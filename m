Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43CE2C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 13:44:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10C912067C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 13:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ORROlPnM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10C912067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCO8n-0004eq-8t
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 09:44:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56441)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1jCO87-0004Ew-7l
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 09:44:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1jCO85-0004vc-4Y
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 09:44:06 -0400
Received: from mail-bn8nam12on2088.outbound.protection.outlook.com
 ([40.107.237.88]:55681 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1jCO84-0004vB-Rj
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 09:44:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V3Q5CLvD6pQQElfIcq7VBekZTRAb0JHL2uprsPbHmdeCaKnoeg0vH5/BTVo90SxxO3MMIr+wyyw5gK6Gl9ArWTBdSPb287AFAcgqpT31NqDSvd5FTOrXyDW+d6q1ujFhTZCGR6HWSE0OIKjfOXODpwZPcOf1wOztY3fvUlOOu7nl4giGQ8tH3OPpOQASimDSmfhYbuaiDOxd49uESZgRRu+evjWskQx6Xs9GY9bH5O9DDaiVHFIkymU7oAX0jQ5dWwcpEbIzhousCdtY3KY2xC1b0Fyd8eKk3Fboie+fiztSegZlJup/AVO0jyMxiIxpEonfFXlDdgR6syETcInLVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0LAYdOpnk91E63fi6n83XBIgQDBDPDiqwuF7eORgEU=;
 b=J8aFvEKBE2k1F9+rSGgICJeiAIGtEzL5Yyd6yV6owAtobL5H5Wvr9M4T+hxUfW0Ynd7qngC8eV25XgAurWdgFyltk0f/NDUB/XnVtjrNBaaAePN7rDFYh1Yt96f3Ct7zI+wS6f324mCWcr/GKAD+4iXOzn8RMncdJ/WVdcczux5VvRvecS3679aXpAo/pfGJmU60mqHfA+KU/OTPetJWo56it9AKWVsxayLmLqRQYuX5MCS1QwtdrDkwJWj+TCVoHqhFPk0+/nmCgh70xPcDEOL8CVXlOaio17RokG9c937RoL64oOxjycBSt6EA5PWtTgw3qZJXx6xJHMEuCQ6fDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0LAYdOpnk91E63fi6n83XBIgQDBDPDiqwuF7eORgEU=;
 b=ORROlPnMrVup3T3Q+3S17SH2zPig4AgtvIjIgfraXek/Twt3gmXqBMzte+zGO3T/viOX43Z9TV/KXlYsLKkwxMSmNEoRYc/ZrbOQauOubIHGMYN5/iLZg5okVPgrT4W0h0I5/KXGMdq4rBJmkv351eFQr49OWQQYBRyg8Ndk2OM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2416.namprd12.prod.outlook.com (2603:10b6:802:2f::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.13; Thu, 12 Mar
 2020 13:44:02 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93%5]) with mapi id 15.20.2793.018; Thu, 12 Mar 2020
 13:44:01 +0000
Subject: Re: [PATCH v7 07/13] hw/386: Add EPYC mode topology decoding functions
To: Igor Mammedov <imammedo@redhat.com>
References: <158396702138.58170.7920458595372792959.stgit@naples-babu.amd.com>
 <158396721426.58170.2930696192478912976.stgit@naples-babu.amd.com>
 <20200312133916.512773bc@redhat.com>
From: Babu Moger <babu.moger@amd.com>
Message-ID: <aa29454a-e7c0-7b6b-c984-f5fbdc3a2378@amd.com>
Date: Thu, 12 Mar 2020 08:44:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200312133916.512773bc@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0801CA0022.namprd08.prod.outlook.com
 (2603:10b6:803:29::32) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.87] (165.204.77.1) by
 SN4PR0801CA0022.namprd08.prod.outlook.com (2603:10b6:803:29::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16 via Frontend
 Transport; Thu, 12 Mar 2020 13:44:01 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5ac58712-0695-4604-c26c-08d7c68b6c39
X-MS-TrafficTypeDiagnostic: SN1PR12MB2416:
X-Microsoft-Antispam-PRVS: <SN1PR12MB24163EA547447B5A14F206EA95FD0@SN1PR12MB2416.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 0340850FCD
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(396003)(39860400002)(366004)(376002)(136003)(199004)(316002)(16526019)(16576012)(86362001)(26005)(186003)(6916009)(66946007)(6486002)(31696002)(8676002)(66556008)(2906002)(4326008)(966005)(45080400002)(66476007)(36756003)(8936002)(52116002)(81166006)(31686004)(5660300002)(2616005)(53546011)(81156014)(956004)(44832011)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2416;
 H:SN1PR12MB2560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NdKH9XyU3RuhZmdPmLguW+VLbyNWdcUJ+u1mgFi9eJ6th9AuItKlJz8b1MdDOwroA3Ke2wupRPrxWfpyZp9sW1GY3ygKkVrQPS/4u7J4nFoVAIMPIUR7vnP4YorH8K3Iu2LAvo4NNwRNqN2AwBmQJ2uBdi6TFdpYovMx1vxZnLckNq3OB4+ebV6U8uvK4baJW/Q5+4nKFITv9yiSUPYphppaFia5qeCk7ZLDMfsqWCEBlGZs4uiWpWJJBxdfv+6EJh1j+xpAK01Afd0hjw6sOXUFom4eHjrJ/Dv0I7ckdgYQZjFxskYo0Z3Ese0FDnW5oEgIoEkvZAEdixaVBrQErg1fYeNRuh1JA1nU6xAPwAsFaxe711+/1HiS4LHSjY1eTu2Hq5i1CkS04kniFPIQ0jJaIT9tvCh2F3VVYiQTixboJKuh3tpNcGPiuZCniwM6EiZJ8DMyyT2dAFPEyMQorwBfHUwcG4kMgYe8MGOb/GAeNWhCVfPcLkxCKMIvoiVWshFi7QIq2UlcOMIogaalNA==
X-MS-Exchange-AntiSpam-MessageData: CT0JCmjl3KLwQhS+H/HfoUng2+PkV3C/rvWb7RuL/zlqYE/k73Cuc1BFCqDC3BfGj6UfC8PJN7wKn0YZB1KU4s0uMlQrZSh0Om1MIN/MtowioS1bX0FPqg6tOWSkQ0OkjC7cgbNEOSVhWES1yDSY2Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ac58712-0695-4604-c26c-08d7c68b6c39
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2020 13:44:01.7411 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S2Oijg7AxSjQ/65QWst5zO/TL3qVy3uFVWEXukoMoYxRKeSLUeCVETFIQ5ZHgt66
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2416
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.237.88
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
 pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 3/12/20 7:39 AM, Igor Mammedov wrote:
> On Wed, 11 Mar 2020 17:53:34 -0500
> Babu Moger <babu.moger@amd.com> wrote:
> 
>> These functions add support for building EPYC mode topology given the smp
>> details like numa nodes, cores, threads and sockets.
>>
>> The new apic id decoding is mostly similar to current apic id decoding
>> except that it adds a new field node_id when numa configured. Removes all
>> the hardcoded values. Subsequent patches will use these functions to build
>> the topology.
>>
>> Following functions are added.
> [...]
>> x86_topo_ids_from_idx_epyc
> you forgot to remove unused anymore function.
> No need to respin whole series for it though, you can post as reply to
> this patch v8 or do it as a patch on top.

Igor, The function x86_topo_ids_from_idx_epyc(or x86_topo_ids_from_idx) is
still there. We are using it internally now. It is used by
x86_apicid_from_cpu_idx_epyc(or x86_apicid_from_cpu_idx). We removed it as
callback function. So, we are good here. Thanks

> 
> 
> 
> 
> [...]
>>
>> The topology details are available in Processor Programming Reference (PPR)
>> for AMD Family 17h Model 01h, Revision B1 Processors. The revision guides are
>> available from the bugzilla Link below.
>> Link: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D206537&amp;data=02%7C01%7Cbabu.moger%40amd.com%7C3d1032fb1cc94a5a197308d7c68268c5%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637196135715465573&amp;sdata=13zSN7AqPGKHFG%2FePmkWTVbwM0qzktrnolEidnNzyhs%3D&amp;reserved=0
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> Acked-by: Igor Mammedov <imammedo@redhat.com>
>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> [...]
>> +static inline void x86_topo_ids_from_idx_epyc(X86CPUTopoInfo *topo_info,
>> +                                              unsigned cpu_index,
>> +                                              X86CPUTopoIDs *topo_ids)
>> +{
>> +    unsigned nr_nodes = MAX(topo_info->nodes_per_pkg, 1);
>> +    unsigned nr_dies = topo_info->dies_per_pkg;
>> +    unsigned nr_cores = topo_info->cores_per_die;
>> +    unsigned nr_threads = topo_info->threads_per_core;
>> +    unsigned cores_per_node = DIV_ROUND_UP((nr_dies * nr_cores * nr_threads),
>> +                                            nr_nodes);
>> +
>> +    topo_ids->pkg_id = cpu_index / (nr_dies * nr_cores * nr_threads);
>> +    topo_ids->node_id = (cpu_index / cores_per_node) % nr_nodes;
>> +    topo_ids->die_id = cpu_index / (nr_cores * nr_threads) % nr_dies;
>> +    topo_ids->core_id = cpu_index / nr_threads % nr_cores;
>> +    topo_ids->smt_id = cpu_index % nr_threads;
>> +}
>> +
>> +/*
> [...]
> 

