Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D75C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 18:03:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01BB3215A4
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 18:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="u5MWQjv5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01BB3215A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBMkI-0006TV-7d
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 14:03:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36721)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1jBMix-0005aj-Rt
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 14:01:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1jBMiw-00010P-Cg
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 14:01:55 -0400
Received: from mail-dm6nam12on2053.outbound.protection.outlook.com
 ([40.107.243.53]:3098 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1jBMiw-0000zi-3S
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 14:01:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLh8c3q8dx7VUMzugK3XGdLdXS+l4WEPRcn9G3QBSm/ht6p11FsORtF7SFxrkg3hxrHTBsBv70fHs89pD59iGoTgkQkfoh2fmiKkCY8zl1puXMos+GQflQ9kaX7HPruH2TJe6VS3dtXekxi6CKNszVt4mUXnl2zSQGfL1ir3hIePhVa07xtaDzNcVDWnK0AbXkSd2kJcki5VyyswBSIuHwuFtC0MK+sCZ/iqGaklW23/nnGZ+VLmMWJd65jYaUWYghlhhCBzsuOMk98ESqlB5r4Yd2KsK92UgH/bgodqyHxgVatpMDwtw68TJysToRju97hJM0vLEihS+RlWGU/jDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1kDG03Oi5/aWDXz2bK+JfSGX/9Bl4YPe7K1jJ97d+jQ=;
 b=GCCwod3LQRLRD/4E3hPUjoGvBTGmSWxQbVsoTdrVtVQ5bLfAC9F3pTGzgeWuproJarjJ2ma3R1Izly5Om2DNJR1jC67nSP65RDXz2YIflMJ1FeKFAVZm5PWQiY02ZUUVwWhm3L957GrWvLXIpy6Uc6DH4dSx3bWBLXqnfkbHBtD7V6e5LSRw24Kc7WH8Bb1krnIjtZ2r2FarNXLkrLFsSUb/1rH9GMY4AuPgkM1HdluDqvq/aBvnIksu4vA27XqfeDyf9c0ZzgdKjpaADxXlHD7fJAxszlnHuD80dEkPq12Ds5gTiTa9UgP4dxn9potxjmR6NF8bgwI/BhqyicSgxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1kDG03Oi5/aWDXz2bK+JfSGX/9Bl4YPe7K1jJ97d+jQ=;
 b=u5MWQjv5Nz2kumxznmmZ6nU2sCGHjXTxnMyJfoTy3fQhStGDqWTq2EoWcV049SmEH3wjLfouC1uyHA759525ueoKCP8osOz3i9ZCcsprOekTZgoE7eQWPWZzLk7kDSW2sUNS1EOacjFwoIMAjDdbhuEi00LalY3XyzjL5QeY7J0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2429.namprd12.prod.outlook.com (2603:10b6:802:26::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Mon, 9 Mar
 2020 18:01:49 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93%5]) with mapi id 15.20.2793.013; Mon, 9 Mar 2020
 18:01:49 +0000
Subject: Re: [PATCH v5 04/16] machine: Add SMP Sockets in CpuTopology
To: Igor Mammedov <imammedo@redhat.com>
References: <158326531474.40452.11433722850425537745.stgit@naples-babu.amd.com>
 <158326543822.40452.17598145031344735065.stgit@naples-babu.amd.com>
 <20200309151730.587ec11d@Igors-MacBook-Pro>
From: Babu Moger <babu.moger@amd.com>
Message-ID: <0109d6c8-b191-4a39-b676-721b531f8399@amd.com>
Date: Mon, 9 Mar 2020 13:01:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200309151730.587ec11d@Igors-MacBook-Pro>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:3:d4::23) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.87] (165.204.77.1) by
 DM5PR05CA0013.namprd05.prod.outlook.com (2603:10b6:3:d4::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.6 via Frontend Transport; Mon, 9 Mar 2020 18:01:48 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9dc7c470-ddc3-44df-ab25-08d7c453f06d
X-MS-TrafficTypeDiagnostic: SN1PR12MB2429:
X-Microsoft-Antispam-PRVS: <SN1PR12MB242911F36D7208012838B8A495FE0@SN1PR12MB2429.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 0337AFFE9A
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(366004)(39860400002)(136003)(396003)(189003)(199004)(5660300002)(31686004)(6486002)(186003)(8676002)(316002)(16576012)(16526019)(2616005)(66476007)(66556008)(26005)(478600001)(8936002)(66946007)(44832011)(31696002)(2906002)(956004)(86362001)(81166006)(4326008)(53546011)(81156014)(6916009)(36756003)(52116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2429;
 H:SN1PR12MB2560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r1yIQ2/NpFENcMQJp1kwwhUquvkpnE5qRH0Ms+T+/5HsJN6L0SiGpMLt5SZ7BzCk1GfrnpCxzII7FKgR915rfXY1lvqjly8LtOt/nitx5KLl1wT40Zra7WQxeg3xNMVV7U+qcCBJQWiHmEHavSSO0LtMliOqspAWgvIzr7q5DDpEzueI2lDT9GupXbQlcdhKRAOsRYpAHBh8r5wK6O0aZf7OqWUwI3HWNkDP6oCnKFNdAlNpuQ5bOjYVko5IopRqDsq8xxGeM/YMa0jWbpfv3vg0fNkDSIDiG0hEpYX2yWQDGmmTfvxWCgbTRWUQVapB5VWB30/GNPF27/K508M+z3MUXfJJW0l1POHuEa0o9ryNw8LHvq0GBq3PUpZy4RL9BK0SXJGRqfPZZT4JdZ9nvNcoFwDr9Eb4Z2f6qeunndCjwO7e/4vWj/1EBCjpTmee
X-MS-Exchange-AntiSpam-MessageData: dVbgJ61jGTTKagnH7mqvFRf5U1L2tZEQMhqNd/SGc6mT8Dnc/o2SzJPmxngZniMFveJTOHMk6VHnEW7piP2wD5tlv1mptLQkuNiFy/uAu6z15Mh3TzvIDEiVIRD7JymrX3ZWNmOAPWj4w79ZRZF9Bw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dc7c470-ddc3-44df-ab25-08d7c453f06d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2020 18:01:49.3611 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YRO+f4J40iq/abe9EHerTpeE2H4gDqYPXffmB/Z5F3fc4GtxnBvmUrUvwoW1X21Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2429
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.243.53
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



On 3/9/20 9:17 AM, Igor Mammedov wrote:
> On Tue, 03 Mar 2020 13:57:18 -0600
> Babu Moger <babu.moger@amd.com> wrote:
> 
>> Store the  smp sockets in CpuTopology. The socket information required to
>> build the apic id in EPYC mode. Right now socket information is not passed
>> to down when decoding the apic id. Add the socket information here.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
>> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
>> ---
>>  hw/core/machine.c   |    1 +
>>  hw/i386/pc.c        |    1 +
>>  include/hw/boards.h |    2 ++
>>  vl.c                |    1 +
> 
> this has been moved to softmmu, so patch needs to rebased against current master

Sure. Will do.

> 
>>  4 files changed, 5 insertions(+)
>>
>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>> index d8e30e4895..2582ce94f6 100644
>> --- a/hw/core/machine.c
>> +++ b/hw/core/machine.c
>> @@ -728,6 +728,7 @@ static void smp_parse(MachineState *ms, QemuOpts *opts)
>>          ms->smp.cpus = cpus;
>>          ms->smp.cores = cores;
>>          ms->smp.threads = threads;
>> +        ms->smp.sockets = sockets;
>>      }
>>  
>>      if (ms->smp.cpus > 1) {
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index ef23ae2af5..68bf08f285 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -780,6 +780,7 @@ void pc_smp_parse(MachineState *ms, QemuOpts *opts)
>>          ms->smp.cpus = cpus;
>>          ms->smp.cores = cores;
>>          ms->smp.threads = threads;
>> +        ms->smp.sockets = sockets;
>>          x86ms->smp_dies = dies;
>>      }
>>  
>> diff --git a/include/hw/boards.h b/include/hw/boards.h
>> index fb1b43d5b9..320dd14e02 100644
>> --- a/include/hw/boards.h
>> +++ b/include/hw/boards.h
>> @@ -252,12 +252,14 @@ typedef struct DeviceMemoryState {
>>   * @cpus: the number of present logical processors on the machine
>>   * @cores: the number of cores in one package
>>   * @threads: the number of threads in one core
>> + * @sockets: the number of sockets on the machine
>>   * @max_cpus: the maximum number of logical processors on the machine
>>   */
>>  typedef struct CpuTopology {
>>      unsigned int cpus;
>>      unsigned int cores;
>>      unsigned int threads;
>> +    unsigned int sockets;
>>      unsigned int max_cpus;
>>  } CpuTopology;
>>  
>> diff --git a/vl.c b/vl.c
>> index 7dcb0879c4..f77b1285c6 100644
>> --- a/vl.c
>> +++ b/vl.c
>> @@ -3949,6 +3949,7 @@ int main(int argc, char **argv, char **envp)
>>      current_machine->smp.max_cpus = machine_class->default_cpus;
>>      current_machine->smp.cores = 1;
>>      current_machine->smp.threads = 1;
>> +    current_machine->smp.sockets = 1;
>>  
>>      machine_class->smp_parse(current_machine,
>>          qemu_opts_find(qemu_find_opts("smp-opts"), NULL));
>>
> 

