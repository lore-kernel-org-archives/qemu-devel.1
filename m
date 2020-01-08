Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E77C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 16:28:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A31012072A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 16:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1NQgHVYh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A31012072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipEBq-0007FK-OZ
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 11:28:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50858)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1ipEBA-0006jn-I7
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 11:27:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1ipEB9-0005U1-AL
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 11:27:32 -0500
Received: from mail-bn8nam12on2048.outbound.protection.outlook.com
 ([40.107.237.48]:6131 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1ipEB9-0005Sn-1c
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 11:27:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dBm3JSzSw3VOu6nktep7SLH3a0ep5zB1cuHu1X4wl36No/TkI8kfvFWLoyQV0RsaEVU3jJguc6LBbOR2KoSROWYqXk82mKHcQphy8UBqMYhrOk07WAU/1Yfn3evl5pMQDK9gYA2K8YB6Vj2uXQyrFpyylX8Wpp+XWXqe2M0xOZnWX+WSLsSrsBLdzF8tH++Um/owv2D5mEVyTMtvhjsMW5iEqPiSeEslJhu/ytAV0Q42+m6TkGVZPOn6sjVvH67mxIBbTu/6gokpZhSJwOz+9MA0dAITTjPd2h5YOYC7yJJP/mpmml9ac7VN35dOF7QPrlQDQ6JSNaYS6YHogcLjWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LUo7k+EQsyYAGtqVy4K/5RMDt8/gc7C+n1mvGANd360=;
 b=CwGpMq7V9idUbSIx+TCDSefjXV47zIvgOT5OjGHCmH36DOqC/ioJUSoLOk+ZhnD9NZKxHLHPmlRJRRIko6l/DLqzIvnxIuLG7Iby1OIjzfp4YCe1vGUYUHox64VIjcJLJwFzITpbb1PaCqgVTw5xffLCDCVyMBOkGFdbrIyh4RfquwuMTNuEI2CcN/yrReMNNHL+ymzKes69KJWpmFFfU/ROtpxZPgxp6hFPmLpFTPRj9IMd9Qj73kiFkxPcbavD1IxLu3LY4/78IXAmVZ0a/BL2kcv8cO5EUxemr1wz5JxUGuL/1SlM67iAPCN1ZfCLj4nyc+ENWeYx46Xv3edNMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LUo7k+EQsyYAGtqVy4K/5RMDt8/gc7C+n1mvGANd360=;
 b=1NQgHVYhU8jEYDwfQnEpb0Fccjynjvw4GkbMTMRJTDELIgJay1034fVGJ+EYtHB4Y65hG6smQiDHAavbLdtgUkJlX4i/KOJr7awoo38CdeRe/rpQkJ6U9zF9hK1xdsvnX+GP7ZOAn9r51Gc6ooFqLTDo0F5jJpEzeV3zPK3CMCA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from CY4PR12MB1574.namprd12.prod.outlook.com (10.172.71.23) by
 CY4PR12MB1782.namprd12.prod.outlook.com (10.175.63.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Wed, 8 Jan 2020 16:27:28 +0000
Received: from CY4PR12MB1574.namprd12.prod.outlook.com
 ([fe80::610a:6908:1e18:49fd]) by CY4PR12MB1574.namprd12.prod.outlook.com
 ([fe80::610a:6908:1e18:49fd%7]) with mapi id 15.20.2602.017; Wed, 8 Jan 2020
 16:27:28 +0000
Subject: Re: [PATCH v2 0/2] Add support for 2nd generation AMD EPYC processors
To: Liang Yan <LYan@suse.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>
References: <157314957337.23828.3860599077487615762.stgit@naples-babu.amd.com>
 <0a6fe793-d5b1-bb9e-b9b3-fb8fefb26cb6@suse.com>
From: Babu Moger <babu.moger@amd.com>
Message-ID: <abd39b75-0a12-5198-5815-dd51a3d5c901@amd.com>
Date: Wed, 8 Jan 2020 10:27:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
In-Reply-To: <0a6fe793-d5b1-bb9e-b9b3-fb8fefb26cb6@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR21CA0022.namprd21.prod.outlook.com
 (2603:10b6:5:174::32) To CY4PR12MB1574.namprd12.prod.outlook.com
 (2603:10b6:910:e::23)
MIME-Version: 1.0
Received: from [10.236.30.87] (165.204.77.1) by
 DM6PR21CA0022.namprd21.prod.outlook.com (2603:10b6:5:174::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.4 via Frontend Transport; Wed, 8 Jan 2020 16:27:25 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e7b26d3e-64d3-4b71-6aa5-08d79457a6c6
X-MS-TrafficTypeDiagnostic: CY4PR12MB1782:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1782BB3D5886395A7D19272A953E0@CY4PR12MB1782.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 02760F0D1C
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(346002)(136003)(39860400002)(396003)(189003)(199004)(8936002)(478600001)(31696002)(4326008)(966005)(316002)(86362001)(31686004)(5660300002)(16576012)(53546011)(2906002)(45080400002)(36756003)(110136005)(66476007)(26005)(186003)(66556008)(8676002)(6486002)(44832011)(956004)(2616005)(16526019)(66946007)(81156014)(52116002)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1782;
 H:CY4PR12MB1574.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 01XvdVCMJ1rs8BSn6K30NdmrqyBRZUrp+Vw0lly9OukzjRb3iQc7j/w6Ds0TCTxGT8CuanJL9psRGIfqX6DFiA4AxWlF9T8VKAp3RDSG2i4Oi3IOCdoJpEmpjSRFYFzEBSho2TBd4UZbeQ6DxHlzcYaQFzwnTwJ2Mot/tWVkWLq8d8i4WaS5SMwzU30pZAcvecJyXacIo4NPaBGdA9XMtx5HXglhGIQ9bP+lR8yJzEH4XYvdwEmkG5H16zDfcQHo/aUGmaGoZ6Vo9wfnfkW2jOnZaHGu5ASGfPYCC82oEyuvt6L/dDrXLa7ET8eHfKDea93m6/ZtblGS1vQJv9sjZhvX4hExxYuB8jgOt+LmejdphKPQu5deVmubh6Jzn+FAAJGbeJ8clbj6j1D4HPtrRygeBVmqpaa2PnrQaKV7mpxt9C1m3Tp/UasS/P1RrEIn2SS97ysqfu9cjn2T9UoyYFb6nkyEZdpwz7yryiReU3dFih/3+dR5UEpRsh/IJ5atmUkExbgi8qrm+BEH4hrdsA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7b26d3e-64d3-4b71-6aa5-08d79457a6c6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2020 16:27:28.2788 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v5GiNEH2U8b01CV1/QVoVOvSzu3MbUYJRTwxTcbRKxuwLRd34IOtU0rgbRxxdyyU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1782
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.237.48
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 1/7/20 12:47 PM, Liang Yan wrote:
> Kindly Ping.
> Just wondering if there are any plans for it.

Yes. Waiting for the feedback or acceptance. Probably delay is due to
December holidays. Hopefully all are back now.

> 
> Best,
> Liang
> 
> 
> On 11/7/19 1:00 PM, Moger, Babu wrote:
>> The following series adds the support for 2nd generation AMD EPYC Processors
>> on qemu guests. The model display name for 2nd generation will be EPYC-Rome.
>>
>> Also fixes few missed cpu feature bits in 1st generation EPYC models.
>>
>> The Reference documents are available at
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fdeveloper.amd.com%2Fwp-content%2Fresources%2F55803_0.54-PUB.pdf&amp;data=02%7C01%7CBabu.Moger%40amd.com%7C139e73eeb64b47cd381e08d793a3db70%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637140204317280432&amp;sdata=Mmdaa9miW4aiuDcCAaMfI8zOOYSC7oTFmZurr7tIc%2BE%3D&amp;reserved=0
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.amd.com%2Fsystem%2Ffiles%2FTechDocs%2F24594.pdf&amp;data=02%7C01%7CBabu.Moger%40amd.com%7C139e73eeb64b47cd381e08d793a3db70%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637140204317280432&amp;sdata=52%2BseLs2VpNsBMblsC4BI7S0Kz5D%2FoOoqUMNd48NHK0%3D&amp;reserved=0
>>
>> ---
>> v2: Used the versioned CPU models instead of machine-type-based CPU
>>     compatibility (commented by Eduardo).
>>
>> Babu Moger (2):
>>       i386: Add missing cpu feature bits in EPYC model
>>       i386: Add 2nd Generation AMD EPYC processors
>>
>>
>>  target/i386/cpu.c |  119 +++++++++++++++++++++++++++++++++++++++++++++++++++--
>>  target/i386/cpu.h |    2 +
>>  2 files changed, 116 insertions(+), 5 deletions(-)
>>
>> --
>>

