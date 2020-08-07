Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E7AC433E1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 17:24:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BB98221E5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 17:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Tlybellg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BB98221E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k466X-0007vg-7z
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 13:24:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49228)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1k465V-0006k3-36
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 13:23:25 -0400
Received: from mail-bn7nam10on2087.outbound.protection.outlook.com
 ([40.107.92.87]:23008 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1k465S-0008BK-NC
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 13:23:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KGSedDMo3mpfPZuTTKvyv+y4pHq4jqHNbiD/UOLhIQbWa2/DkpJEeaCxaJOTTPhsn3Z8G8pAeZcVCTn2l1xJVWkCyWdKFSCHwmu/X6MtY6zRpQjS1L2CarnjjkcsZGUbW4/vjw7m+kYyyEgb8jcrClTjsjA4AhvE342BAIhBukqZICp2yPDcblal32EibloxmyTvJtxPPGZS2pkOoGBoqAW2gFVbDv8jNmUP2ghqKPbzAyc2O+TIKl3FE7iNPyDFDJmFZ7JoSTlgOjndrQK9w5cvJFZKkTP1b1t/9V45o4QhVUVmHOmOPpmg3hS5xvU2K2yuF0DZTmpZRTScxbDJ7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0l+cIMskOiik3i3y8TUvltl6JxpxPdftMav+q1KtROQ=;
 b=PPWv8jZl1d8ao7QEiapEkA/nDnSBXfWG4ITftv2osq3QOpO6RcrJ3LzJu5g2gvQILlmXAPEU6qQlJ/xWMDPV8U1rOKXEFWYmO+jnLvJz6r0COlho78K9ytOR4vENxaPjctsfE2cAMr5IHGxOtR7xFTkSTWEyocPDABvEbE5okT3h7LyzbdtjS9dD9WQfB5Yjs31BE+8WaOFVOzWQxwSoUX7V2W8hBanrWJsY8SF2yhWCd6172B6qpRXhWTBYpOBv5SePlaazSNAKbLGMIpJJGZCL6+yIZtNHU6Xs4iQphj39pRXizygLwnboT/T2v7W811SnZ0c53ZcXnfFJj9l08A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0l+cIMskOiik3i3y8TUvltl6JxpxPdftMav+q1KtROQ=;
 b=TlybellgWD+cOp29l+LTzuWAzEZtUhDfDTougfzFn5QO5u56W5IgGCBA0a4aFVF+t5eDeWd06CuZ1Offrydq2HigA2z0l4gZNRhPJo1k/hCGs9v9QbPchb9c0cCIauUEbdp3+P561fXn5HrGrDVePISmBFagbVW/9UaKnWFRIMY=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2558.namprd12.prod.outlook.com (2603:10b6:802:2b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16; Fri, 7 Aug
 2020 17:23:19 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::691c:c75:7cc2:7f2c]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::691c:c75:7cc2:7f2c%6]) with mapi id 15.20.3239.024; Fri, 7 Aug 2020
 17:23:19 +0000
Subject: Re: [PATCH v3 2/3] hw/i386: Add a new check to configure smp dies for
 EPYC
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <159681772267.9679.1334429994189974662.stgit@naples-babu.amd.com>
 <159681797161.9679.5653247810916709875.stgit@naples-babu.amd.com>
 <20200807165222.GB120942@redhat.com>
From: Babu Moger <babu.moger@amd.com>
Message-ID: <a7c6bb48-3f12-f6e0-fa12-6c2261b4e37e@amd.com>
Date: Fri, 7 Aug 2020 12:23:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200807165222.GB120942@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM5PR22CA0019.namprd22.prod.outlook.com
 (2603:10b6:3:101::29) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.79] (165.204.77.1) by
 DM5PR22CA0019.namprd22.prod.outlook.com (2603:10b6:3:101::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.17 via Frontend Transport; Fri, 7 Aug 2020 17:23:19 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: eee72a38-bf62-4e22-87b8-08d83af6942e
X-MS-TrafficTypeDiagnostic: SN1PR12MB2558:
X-Microsoft-Antispam-PRVS: <SN1PR12MB25588DB7BDDC5E8434DA97D795490@SN1PR12MB2558.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wjAIg8/k7sir1E/7QSFzsBDWesRojnI1kldmMoZwgg8ra22WdSapAP559wMp/vEr/fNTxoDFRsqMHPkJvHXy0uSWYpP5Yr/mvitCXK33GbhbvnHakN999nm963W+nRDLWf7E7ZDM0278oOb4+NkrxiT+9D8V5iAySg5gSS/QfgqCHE8D5xeqvOUkNdo6UWemWXzMHzn6H29wvuVkgkrhxyAWhz9UibtJRuOM6C8vX9Deys3LJVyMckDHUanjDqU8nYbQ/u0A48I9pi6ky0xzzROlpxohDmB7b1hhglJ73M2ed0+mA7Hyy7XkjCj50FwkSgDJpSXyy/m06zwZKIx7xGa3PnHjZBNi/ist4MlypnZTteoXM2qTcst9C6/jeX1M
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(376002)(346002)(366004)(136003)(956004)(2616005)(44832011)(83380400001)(31696002)(6916009)(6486002)(36756003)(66946007)(86362001)(66556008)(66476007)(478600001)(52116002)(16576012)(16526019)(186003)(5660300002)(8936002)(26005)(53546011)(4326008)(2906002)(31686004)(316002)(8676002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: UyB2XaODfYAJ1nXKenlBkf0nog+ErxUABRVeDW6sJXVZdckdDme6Zpo+qkkX772TY+BOqjxhAqjq2TJ1TjZV3M3HhPjlix8ErbbjvR/kZJtW6837d/Utr2C2e7f27EXXne9xNaCwq2tAjGUQntb5qtDiy+sXQRIds/9JmKuitfNJqMqOOMwmEjbyvrtOoZazPGZZ3Rv8TwMlL+Ci6p06qBjaIAvItTv6gdQ8Nxedas+hqGfVv5BnlcsMpEaEZ6nofm9agy7CYjrWTpSxh1SAdroZ4a3uJq/LIbNtlIZKKNFf2HEoLbIvN2NI3qUxoEBMKUIG1ev9IkPHDjA7wwdrI95Emiz4Hrc1ZHdZaUr3Wny54PS3cFCQ8PT8c6sNHV3wkZDyvpED1a3nFKxW40pMZt6BfKUpkYfQAnytcRQ1A4D1ClGlH9FWDSminyJ/IpeO8vkTDmJmVLEFhW4wM3v0dFjkDlyqUAgW0iLjvT0JkWgXM/1KhGjXC7hxNG+IT1Q8ZyuXeGm/j//ILI3PEiqX+W1uhApUaK8TvFMaVkZ8xBJST1zs6P66wIELFRejn1sTE/b6TOIUXThqFHzigr+mfRfav8CKqfcCKrzlFW/NxN2gimKHqRaSJIX004jbGJX3Y8WB/bt3YowJ3+w/J+mlyw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eee72a38-bf62-4e22-87b8-08d83af6942e
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2020 17:23:19.7557 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ArZi8ip3pm3h8A+ZLRrjJhnl9ZfLBMpvPrwI8Hg6K9zES6tA/FfBssfKrP1Vjbor
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2558
Received-SPF: none client-ip=40.107.92.87; envelope-from=Babu.Moger@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 13:23:20
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
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



On 8/7/20 11:52 AM, Daniel P. Berrangé wrote:
> On Fri, Aug 07, 2020 at 11:32:51AM -0500, Babu Moger wrote:
>> Adding a new check to warn the users to configure 'dies' when
>> topology is numa configured. It makes it easy to build the
>> topology for EPYC models.
> 
> This says you're adding a warning....
> 
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>>  hw/i386/x86.c |    7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
>> index 67bee1bcb8..2a6ce56ef1 100644
>> --- a/hw/i386/x86.c
>> +++ b/hw/i386/x86.c
>> @@ -138,6 +138,13 @@ void x86_cpus_init(X86MachineState *x86ms, int default_cpu_version)
>>  
>>      /* Check for apicid encoding */
>>      if (cpu_x86_use_epyc_apic_id_encoding(ms->cpu_type)) {
>> +        if ((ms->numa_state->num_nodes > 0) &&
>> +            ms->numa_state->num_nodes != (ms->smp.sockets * x86ms->smp_dies)) {
>> +            error_setg(&error_fatal, "Numa configuration requires smp 'dies' "
>> +                       "parameter. Configure the cpu topology properly with "
>> +                       "max_cpus = sockets * dies * cores * threads");
> 
> ...but you're actually making this a fatal error, not a warning.
> 
> I'm not sure this is really OK. Wouldn't this mean that existing VMs
> deployed today, risk triggering this fatal error next time they
> are booted, or live migrated.  If it is possible someone is using
> such a config today, I don't think we can break it.

Yes. that is correct. May be we can display warning(not fatal) and assign
the smp_dies = numa_nodes / sockets. But that requires re-arrange of smp
parameters. Not sure if that is ok.

> 
> Regards,
> Daniel
> 

