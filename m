Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9637EC432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 20:24:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 525DC2071E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 20:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XLLV8Wsz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 525DC2071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibsEu-0005Gp-3m
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 15:24:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44956)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1ibsDu-0004YS-Kd
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 15:23:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1ibsDt-0001FX-HG
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 15:23:10 -0500
Received: from mail-eopbgr800072.outbound.protection.outlook.com
 ([40.107.80.72]:25600 helo=NAM03-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1ibsDt-0001ES-4U
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 15:23:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j2dIxJ5pxinkoi8NmbpCLfc80jk/cmifnxGIID20exK5SRjkLXN+drWficUlatx6O8f5bjW7pAqBhs2ie7X7bdm0/FcnBEagy8LQyGp7NP1YHbnvo5j9xWbfy5kjAvl84HwmjTy2s8/n+HC68vADPsSTDKa6vwMyqEczgffz8HoCBVhVP1R0sDJW69TEak7N8z9MU/JzIQF1iI2qSvK09a/blLvNXIxVJnfrNUafwLN43fuyDHllO4hC/2of74kX4Q0yj0D/TjXcz+7r1jkskuhYnTenwDajnZwPSEfqL6ZcxYrT1i02KlBD9K5CKnR5DDUps7zPwFSzVvF+/AmVjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yc3vVi/4vonUYGgIIaULfcGMzN0jwRaBiGSvk78dIcg=;
 b=cUQ2M3VqpwlLlOPaWOEH7j+KrNO4MI9iAGb553/9iLZa8wNZIkzbluVgF4bGDvZqkdx3EZocOqFnNOsMpsejgy6wouyp7CmWZQBWzG07XzqpDwkI7rmC+w7nMCefm1whpoqFUqoMBbkbzORzeGKjxIYLXe60RpLa8SHhx2EKOVHhlHFSZ8jUFEUZOwnrtkZoezT7aJvuENIe6iXMZ5uBd2EaRsuoeQ5aRjN/OA33qzu541yCrgYJao0n/IJXzDcDKmHoikJKb69drjVs33q60H3ZGd1BpBjEAYRMal8WI6YINWZ/2id9agVh9YH5bcTkoAtcya+WoLgIG5MJUQbBiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yc3vVi/4vonUYGgIIaULfcGMzN0jwRaBiGSvk78dIcg=;
 b=XLLV8WszoI6a9DuWFr9LcD3E6OJlMz/YOgQBDPbG4byOCmxiQ3ALFtrxPP0CM7VIP/O2EZwxGwsSEN1MoirefX0PCmJHjP8stRfPVl0x1qMVpSI/MkSwT8KjsvhI0WToHlCqPxiiizM6+rw7s7ieeSCxpNXkLINJSYIskR3NtGQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1353.namprd12.prod.outlook.com (10.168.238.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Mon, 2 Dec 2019 20:23:06 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::d0f5:b875:7b5c:46c3]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::d0f5:b875:7b5c:46c3%6]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 20:23:06 +0000
Subject: Re: [Qemu-devel] [RFC 2 PATCH 03/16] hw/i386: Introduce
 X86CPUTopoInfo to contain topology info
To: Eduardo Habkost <ehabkost@redhat.com>
References: <156779689013.21957.1631551572950676212.stgit@localhost.localdomain>
 <156779711572.21957.10722611828264773686.stgit@localhost.localdomain>
 <20191011022932.GA29387@habkost.net>
From: Babu Moger <babu.moger@amd.com>
Message-ID: <f680f815-f2ef-fd59-e2ec-f65393e8ea6d@amd.com>
Date: Mon, 2 Dec 2019 14:23:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
In-Reply-To: <20191011022932.GA29387@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR02CA0005.namprd02.prod.outlook.com
 (2603:10b6:805:a2::18) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
MIME-Version: 1.0
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: eb159b86-c823-4c4a-72fb-08d7776570e9
X-MS-TrafficTypeDiagnostic: DM5PR12MB1353:
X-Microsoft-Antispam-PRVS: <DM5PR12MB13533DDF8B50AA5E479661EC95430@DM5PR12MB1353.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0239D46DB6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(199004)(189003)(3846002)(305945005)(44832011)(65956001)(2906002)(66066001)(65806001)(54906003)(6512007)(4326008)(14454004)(6246003)(229853002)(58126008)(6436002)(5660300002)(76176011)(23676004)(6486002)(47776003)(50466002)(36756003)(2486003)(11346002)(386003)(6506007)(53546011)(446003)(52116002)(2616005)(186003)(26005)(6916009)(81156014)(8936002)(7736002)(8676002)(86362001)(81166006)(25786009)(31686004)(31696002)(6116002)(66946007)(230700001)(66556008)(66476007)(99286004)(498600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1353;
 H:DM5PR12MB2471.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6BUtzKgVL57reNX3x1AS56IuN18M/ram70K0TlJar/bdbCyjmPmPAoh8zOX3x2gxYNbLA/CWKihLq+XXnV3j9wpaaLVtit3/y8RNxcxLSoxh/XURDHa3B8loMPSHI6rnTQC1R5iM/fDaVm0+Zh9UxIoEVEne8zS4MR2Ka4WCwKKt8emPatazXMCzZeO0lSUSanyWj0DxeI5bQ2nB/Rqx6XtjO5V8C+eyyDJ2lt+NnhXMtK4gu9BO3ZtbNMjDYvmb9Ja+klV7KfqhDnj03PZsTvjADt+yJeh7P3UzGcYAB7wGvAePc4GMqWarOX6HAvBM+15c7Yua3ovy6SC6RTpi9MpzoyPW0+L7yKokXx858maL4h1Y1e2vCFwZxEm0ecsLbERT3oAy4gAF0EAjXokRzAVnVWth8w3NaSWASl+hvJhTIBor2w5y0Ovaff2s3beN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb159b86-c823-4c4a-72fb-08d7776570e9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2019 20:23:06.7473 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eTii2QEgbNOTBL4SjAuv8cTNGHIpc5N9fwRTtfX8+0X15FIHZuJ3+JkBQRm/2YFA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1353
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.80.72
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
Cc: "mst@redhat.com" <mst@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 10/10/19 9:29 PM, Eduardo Habkost wrote:
> On Fri, Sep 06, 2019 at 07:11:57PM +0000, Moger, Babu wrote:
>> This is an effort to re-arrange few data structure for better
>> readability. Add X86CPUTopoInfo which will have all the topology
>> informations required to build the cpu topology. There is no
>> functional changes.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>>  hw/i386/pc.c               |   40 +++++++++++++++++++++++++++-------------
>>  include/hw/i386/topology.h |   40 ++++++++++++++++++++++++++--------------
>>  2 files changed, 53 insertions(+), 27 deletions(-)
>>
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index ada445f8f3..95aab8e5e7 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -930,11 +930,15 @@ static uint32_t x86_cpu_apic_id_from_index(PCMachineState *pcms,
>>  {
>>      MachineState *ms = MACHINE(pcms);
>>      PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
>> +    X86CPUTopoInfo topo_info;
>>      uint32_t correct_id;
>>      static bool warned;
>>  
>> -    correct_id = x86_apicid_from_cpu_idx(pcms->smp_dies, ms->smp.cores,
>> -                                         ms->smp.threads, cpu_index);
>> +    topo_info.nr_dies = pcms->smp_dies;
>> +    topo_info.nr_cores = ms->smp.cores;
>> +    topo_info.nr_threads = ms->smp.threads;
>> +
>> +    correct_id = x86_apicid_from_cpu_idx(&topo_info, cpu_index);
> 
> If you are using the struct in function calls, please make sure
> all fields are filled correctly, so we won't introduce bugs
> accidentally if we start using the new fields inside the topology
> functions.
> 
> Alternatively, you can leave the struct without the numa_nodes
> and nr_sockets fields by now (because they are unused), and add
> the fields in another patch.

Yes. Separated the patches and added the new fields separately.

> 
> Except for this, the patch looks good.  However, I don't
> understand yet the use case for the `numa_nodes` field yet.  I
> will probably comment on the `numa_nodes` field once I see the
> patches that use the new field.
> 

