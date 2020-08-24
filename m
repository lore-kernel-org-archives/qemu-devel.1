Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D2BC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 19:51:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE47D20706
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 19:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="LQnC/gdU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE47D20706
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAIVG-0000GN-2G
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 15:51:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49788)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1kAIUQ-0008CO-CP
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 15:50:46 -0400
Received: from mail-co1nam11on2056.outbound.protection.outlook.com
 ([40.107.220.56]:7361 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1kAIUO-00029T-59
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 15:50:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AF57gHwCF/7msiPhsr/ZcFn0yVKTOyntg4iIm2g56aMYmPK28SuOxI2sdeCy5Htao1+USSr9ryo6ZZRU2N5QDPw0nbTmaa9MiskwuNs+sf8MfZwZ2HcMu/gdIOVQ/TVA9+ZPlfFT46dzjPaHYHTv2pTu3ErqzlXd3Xg6QqLhSQTzvIud43M95gbOxEd9p1sS9x/166L3ztBArv5DLeUMjhjEuasnkmC6eaVjSTEGCirnqvE7gtLQRibzpB6eZanDWHrtKGuOAaSUe/xfxi/AUJZUFes/x2TPuV+ix228e1w+CkX0sdhuQC8XYBVM1wry+AIQFSsrG7X5E1yPfEIn+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=okGdH0Mftms+PGoGkjMZO42tZCBfQ9qM7kprtGl9kAo=;
 b=GKbYAOacl+bMbDIlYIDgK4Z1TJ1KJxEVYAUVeunRTmY8EEoKrg/PsRdZe9r30CifbNcIr41zxzhOBQ+4E2LjgqlLiqvUej+3shBpXpxZeFeQAfyymNy/2io3hFlcDOPSO+84xKYdzpbjANa8ynQKUdz+rHoDgZWoApPCY7Eq+bh24LaeyPCWdWA9U74eKSx1aoVjpC5YKCICm1QiavkQO/hlynIZK+iOMU2af4iH+eZcN1VKT9i1EmULSMQ3X+Y3TH/ByT3KKyk51XP+U0OWZxwjUTvzJIi6n85ZOkkdfaaqqOfKgYKXh7a+Tl3jvNNJvZQJoDhBFvSrtY1WXgD2jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=okGdH0Mftms+PGoGkjMZO42tZCBfQ9qM7kprtGl9kAo=;
 b=LQnC/gdUaUcBLk0qpRGfxsIjMxmhSe0cGMQrGAKhclYmkpGFOYNHvb8K6SdLl9kDwx/ZN8PzerXIEjNdPUVtepXkftSuhjl8bxa5tbxJstxf+bxaoNPvy9/XxxzvKm4G1cLKuSGae4R3d2KHN92wqtavPZGP2P8+7dKiyNhU2fg=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN6PR12MB2670.namprd12.prod.outlook.com (2603:10b6:805:6b::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Mon, 24 Aug
 2020 19:20:36 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::ccd9:728:9577:200d]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::ccd9:728:9577:200d%4]) with mapi id 15.20.3305.026; Mon, 24 Aug 2020
 19:20:36 +0000
Subject: Re: [PATCH v5 0/8] Remove EPYC mode apicid decode and use generic
 decode
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <159804762216.39954.15502128500494116468.stgit@naples-babu.amd.com>
 <20200824184112.GB2688@work-vm>
From: Babu Moger <babu.moger@amd.com>
Message-ID: <f602852c-b6af-694e-3e32-47974722e144@amd.com>
Date: Mon, 24 Aug 2020 14:20:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200824184112.GB2688@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR07CA0164.namprd07.prod.outlook.com
 (2603:10b6:3:ee::30) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 DM5PR07CA0164.namprd07.prod.outlook.com (2603:10b6:3:ee::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24 via Frontend Transport; Mon, 24 Aug 2020 19:20:34 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7b13cdfe-c18b-4b57-4f00-08d84862c6fe
X-MS-TrafficTypeDiagnostic: SN6PR12MB2670:
X-Microsoft-Antispam-PRVS: <SN6PR12MB2670CF9484F83C1D844C32AF95560@SN6PR12MB2670.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MUT/XPWd4Bj6oq8NIN4vOd29qYP+91nX5l2n1DYBmFUtHoqIRFaczx5AwkWQMwErBltAFyQY/wd4wPHTrbuYVXFR5nuYpWyutf8nFFnV23tGDeYSWGODzr2rbq/o3cQi2/y3+921abxm1Go5oNTUwKy2wzDPTzx/VHs2pk6ONToSIvkhK08L9FzGZ80XH9+vgWpLSob4wplIs/IXEEkQQb/1NY6mB35iTDcuPv1bNEnwHScAlYCvFLDCYMDZ++t0eF6/rMzMyc4FF0RR0SoVuwounGX11M4szoh3RXftuOy3vDI9ZCOF8jbT97D4X6ciA61LUnkdVyWEf34Ij4RW0Db41kM4bkxIFtBPDlmtQZbO1bWHvqAQwrXQNMyMLvI4vvIYNq5VTNizC13A5TkpSORe5/jj5CkAtooXA5imTHvp1y9r85mhWViDoY1neJAjncsWXTMTkl/HKDRcfV0pKRd6pFFC4miiE9RcYHCD8X4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(376002)(136003)(346002)(396003)(36756003)(4326008)(86362001)(5660300002)(53546011)(52116002)(8676002)(31696002)(956004)(26005)(186003)(6486002)(478600001)(66946007)(66476007)(66556008)(44832011)(45080400002)(2616005)(316002)(31686004)(966005)(2906002)(8936002)(6916009)(16576012)(41533002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 2uOfmief3eIWFSiyp7TuirSAzNQaE/Nfm5iDpWjVMibqP8AeBjf4INlOX6f2GlG5Smv+Gor0kv8frYrK15tu+5dzn7jfofDeKL+DL9a4YuFX7lfoFiwfjEw/I36dEe3CEna/yCbTBPy5Q75fkjvS76uT+DU/yiAxdb0c/Bzc8KY/1HKfl9rxSW2+es5bfvbencH0CRglxwx4klkk7M4WBfYKGbSUVg4ZU7olRIA39tLzpG7gig9sMzDR1vFMYEelGR6WH3xx8jk9Ylh9ime4ZYOQhbyvdSXZpEHQX1B0J6yKisVla527pDu11608Ku8JhHyj99AX99RhiPevnVF3uTRUilL3sjf0HQuWuw06KOGujBzYySB8DjjtHSWaCQ/Lu3Xygeajou7Xj7ksg457AN9OuYKNKszLkykjRYDKv/4quAmpyS6oNtRDTsXc3138dSKC16YmMXvV2PbCuHHGELGYI7ic2qr8ZJ/qtNVSNTUwz0o+cF11VvhwdicJM54PVlo9Gd7RbnJEzkKPMA5A2lwgVYmdpzzP4LryQ7eUdio8/Ct8Wee31wLkrVUdmrKz6yHBOcFd+qqcNMXFt+/KCXdjfyvZjmK0Qv1b334Oj3/0p9/+biRjZ+Ep2BnFWdOJhie45eLbLLcnDkmkeS8UGQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b13cdfe-c18b-4b57-4f00-08d84862c6fe
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2020 19:20:36.0982 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /NpKMmz9Izt/aHRNfBmZkmviU1tYAhSnFpoN3wQiKYrLlY/l19//Pl9TeBCYgFie
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2670
Received-SPF: none client-ip=40.107.220.56; envelope-from=Babu.Moger@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 15:50:41
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001,
 NICE_REPLY_A=-2.25, RCVD_ILLEGAL_IP=1.3, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: ehabkost@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 imammedo@redhat.com, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Dave,

On 8/24/20 1:41 PM, Dr. David Alan Gilbert wrote:
> * Babu Moger (babu.moger@amd.com) wrote:
>> To support some of the complex topology, we introduced EPYC mode apicid decode.
>> But, EPYC mode decode is running into problems. Also it can become quite a
>> maintenance problem in the future. So, it was decided to remove that code and
>> use the generic decode which works for majority of the topology. Most of the
>> SPECed configuration would work just fine. With some non-SPECed user inputs,
>> it will create some sub-optimal configuration.
>> Here is the discussion thread.
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fqemu-devel%2Fc0bcc1a6-1d84-a6e7-e468-d5b437c1b254%40amd.com%2F&amp;data=02%7C01%7Cbabu.moger%40amd.com%7C74d90724af9c4adcc75008d8485d4d16%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637338912853492167&amp;sdata=GTsMKcpeYXAA0CvpLTirPHKdNSdlJE3RuPjCtSyWtGQ%3D&amp;reserved=0
>>
>> This series removes all the EPYC mode specific apicid changes and use the generic
>> apicid decode.
> 
> Hi Babu,
>   This does simplify things a lot!
> One worry, what happens about a live migration of a VM from an old qemu
> that was using the node-id to a qemu with this new scheme?

The node_id which we introduced was only used internally. This wasn't
exposed outside. I don't think live migration will be an issue.

