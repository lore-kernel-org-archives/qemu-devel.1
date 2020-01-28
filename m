Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 934B6C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 21:49:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A1342087F
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 21:49:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mTE/Fio1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A1342087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwYjG-0003E5-GS
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 16:49:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56891)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1iwYic-0002oi-0D
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 16:48:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1iwYia-0000DY-Hm
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 16:48:21 -0500
Received: from mail-bn8nam11on2077.outbound.protection.outlook.com
 ([40.107.236.77]:6111 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1iwYia-0000Bj-3D
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 16:48:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LBPhfD6xh9m6nO3QS6SfkqIa2RMi9CzRIaerizsmXlhEIYYjHBDJNwU+nwEhHRtyrD3cnX0V+8XWiIj5rradBIQmVloUK1X265ScikQ9uI6aHvWZNB4F48lQghMurqu5DSnbMDJeCmfupeG3ZVqrlvfVgoloYiCkIKwygfrn3w6ar8XGijgliYyPOrH6YyxslViK9HrTqC8z6XQlsVZsgM/YZOT1vcCD9Ihh6DXCeUe1H11tr6jLCbbO9YhAU2PXJ95xyNfrKM+YkH9mFXEdbYr9N5Q0AM8/y1kdNnRs4hPxkZLobkBLfhlQkGTW6CQ2+cK2pwtxv6TGzfSsRAlm6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJQNub+VjFYsG/wsYJx1FoPD9qi2k8B8BsT4xrxDwUg=;
 b=NvaN0j32RmUShjL+fWQ/xZ/lMJYYTaKdFTbTJkzlkT/u+rYOy3IrY5ASALVZa+mTUJZyr4hh0MIyIsBF0V0DSwi4VvYhcRiz4xceEbSfWQYUVzwlIDqk5WXZrm4XIx5G8RV/ujoQEhfd/xR1ULdMAnIJadrpNfOEWH9mAUfvf5619s9MxA3QhTKnOBGieLAs9mEAnogDdBJRPgtLCvQWMNSOTieZpikylISJHXvVL1Sh96Dx+99DLygYFTyp2pp5HtxU951cW3hwU1WO5UAAKWnUJknG4Fo2YLT/TbqoYymfcEWaWv0mVecqWssG1eBuYfF/Z0Zl1myaWUGi1f9nvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJQNub+VjFYsG/wsYJx1FoPD9qi2k8B8BsT4xrxDwUg=;
 b=mTE/Fio1DiUT7VbEaXHTG4FLrz/iDVEiYncfJMqy6cSsFcaabKj8aiHho1V6AwT2FWVsImKKtmtS2tU9/xpnYKh1hu7GA0Nm6Dgw6cT/7yiGgmOq1Q/1Bpg7uM1tGYdnFwnUbt/QQ++CDbn86INRBkqXG6IwiAqbl9I2jiYc/JQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from CY4PR12MB1574.namprd12.prod.outlook.com (10.172.71.23) by
 CY4PR12MB1655.namprd12.prod.outlook.com (10.172.72.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.22; Tue, 28 Jan 2020 21:48:17 +0000
Received: from CY4PR12MB1574.namprd12.prod.outlook.com
 ([fe80::610a:6908:1e18:49fd]) by CY4PR12MB1574.namprd12.prod.outlook.com
 ([fe80::610a:6908:1e18:49fd%7]) with mapi id 15.20.2665.026; Tue, 28 Jan 2020
 21:48:17 +0000
Subject: Re: [PATCH v3 16/18] hw/i386: Introduce EPYC mode function handlers
To: Eduardo Habkost <ehabkost@redhat.com>
References: <157541968844.46157.17994918142533791313.stgit@naples-babu.amd.com>
 <157541992659.46157.18191224973398213624.stgit@naples-babu.amd.com>
 <20200128200438.GJ18770@habkost.net>
From: Babu Moger <babu.moger@amd.com>
Message-ID: <90118d85-941f-52f1-1976-0831ed3378c4@amd.com>
Date: Tue, 28 Jan 2020 15:48:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <20200128200438.GJ18770@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0801CA0001.namprd08.prod.outlook.com
 (2603:10b6:803:29::11) To CY4PR12MB1574.namprd12.prod.outlook.com
 (2603:10b6:910:e::23)
MIME-Version: 1.0
Received: from [10.236.30.87] (165.204.77.1) by
 SN4PR0801CA0001.namprd08.prod.outlook.com (2603:10b6:803:29::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.20 via Frontend
 Transport; Tue, 28 Jan 2020 21:48:16 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a7313106-713a-4c23-fe67-08d7a43bc894
X-MS-TrafficTypeDiagnostic: CY4PR12MB1655:
X-Microsoft-Antispam-PRVS: <CY4PR12MB165594AC71734ACC9938257F950A0@CY4PR12MB1655.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 029651C7A1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(376002)(396003)(346002)(39860400002)(366004)(189003)(199004)(16576012)(4326008)(478600001)(6916009)(5660300002)(44832011)(86362001)(31696002)(31686004)(186003)(16526019)(36756003)(2906002)(66946007)(2616005)(956004)(8936002)(81156014)(26005)(8676002)(6486002)(52116002)(66556008)(66476007)(316002)(53546011)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1655;
 H:CY4PR12MB1574.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9K+PUB6JAbSNOd030Ag2LdrDMpMAJkEL3+5ZU59wGa5n2m/kL+xlnmM/XeNz0y7GcEAGYG/UyVkr/NV7N9y2T1ArHgOvS3otbArpas7Extu80ODk4KV7IepdSzIc8BItYtKlp55PiWyMKeXXfTGnXuYd+Pvd76BtquDABz4UaImLvcIjA6HqP2iWycNx5C95YyVtNLwnfDCOlOMPKnsT+0USDguV35OTHzIh1ijkM+AxZMV0H75D/CTRCMr8+ZQKpe7DV7UNKLGP5ScQ1fltbYC7B24cH101wQ5c4NYv1tVVj0RAww02T6/Ma/4S8PpJiTpa9SNjpKXd+RST6UZqggmT9u2czt3lZTi4FUb0Cu4wEoJQtXIt6LycSx7pPzuV9V0ddlzda9Kypn+PzzcrUVRbTXJ3v1c8DzeJwHzQlKKR2oFGd5nhRZ14idNVjlBy
X-MS-Exchange-AntiSpam-MessageData: FKh63DqJu+duju1O4NQ7TW3XQ/dmzujWdu6VKE0ZFfJ7lCQ6ulscXrvsWl1IJ7t93F6ZbXgqY1l4fd6rj4oPGca9RiZyWGJ5Jbpu2zOz0RZ3E1QGDRVE/CLzjdQ+dV8FL8LpVKATwK6oqyBM4LNTxw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7313106-713a-4c23-fe67-08d7a43bc894
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2020 21:48:17.4586 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oyDV45JLnTuhiKf0+kahZ3yqauMBKKwAzFodOLd7VcMAJbKEZFmm2upYbEVQ2Tgm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1655
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.236.77
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
Cc: mst@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org,
 imammedo@redhat.com, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 1/28/20 2:04 PM, Eduardo Habkost wrote:
> Hi,
> 
> Sorry for taking so long.  I was away from the office for a
> month, and now I'm finally back.

no worries.

> 
> On Tue, Dec 03, 2019 at 06:38:46PM -0600, Babu Moger wrote:
>> Introduce following handlers for new epyc mode.
>> x86_apicid_from_cpu_idx_epyc: Generate apicid from cpu index.
>> x86_topo_ids_from_apicid_epyc: Generate topo ids from apic id.
>> x86_apicid_from_topo_ids_epyc: Generate apicid from topo ids.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>>  hw/i386/pc.c               |   12 ++++++++++++
>>  include/hw/i386/topology.h |    4 ++--
>>  2 files changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index e6c8a458e7..64e3658873 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -2819,6 +2819,17 @@ static bool pc_hotplug_allowed(MachineState *ms, DeviceState *dev, Error **errp)
>>      return true;
>>  }
>>  
>> +static void pc_init_apicid_fn(MachineState *ms)
>> +{
>> +    PCMachineState *pcms = PC_MACHINE(ms);
>> +
>> +    if (!strncmp(ms->cpu_type, "EPYC", 4)) {
> 
> Please never use string comparison to introduce device-specific
> behavior.  I had already pointed this out at

Yes. you did mention before. I was not sure how to achieve  without
comparing the model string

> 
> If you need a CPU model to provide special behavior,
> you have two options:
> 
> * Add a method pointer to X86CPUClass and/or X86CPUDefinition
> * Add a QOM property to enable/disable special behavior, and
>   include the property in the CPU model definition.
> 
> The second option might be preferable long term, but might
> require more work because the property would become visible in
> query-cpu-model-expansion and in the command line.  The first
> option may be acceptable to avoid extra user-visible complexity
> in the first version.

Yes. We need to have a special behavior for specific model.
I will look at both these above approaches closely. Challenge is this
needs to be done much early in the initialization(before parse_numa_opts
or machine_run_board_init). Will research more on this.

> 
> 
> 
>> +        pcms->apicid_from_cpu_idx = x86_apicid_from_cpu_idx_epyc;
>> +        pcms->topo_ids_from_apicid = x86_topo_ids_from_apicid_epyc;
>> +        pcms->apicid_from_topo_ids = x86_apicid_from_topo_ids_epyc;
> 
> Why do you need to override the function pointers in
> PCMachineState instead of just looking up the relevant info at
> X86CPUClass?
> 
> If both machine-types and CPU models are supposed to override the
> APIC ID calculation functions, the interaction between
> machine-type and CPU model needs to be better documented
> (preferably with simple test cases) to ensure we won't break
> compatibility later.
> 
>> +    }
>> +}
>> +
>>  static void pc_machine_class_init(ObjectClass *oc, void *data)
>>  {
>>      MachineClass *mc = MACHINE_CLASS(oc);
>> @@ -2847,6 +2858,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
>>      mc->cpu_index_to_instance_props = pc_cpu_index_to_props;
>>      mc->get_default_cpu_node_id = pc_get_default_cpu_node_id;
>>      mc->possible_cpu_arch_ids = pc_possible_cpu_arch_ids;
>> +    mc->init_apicid_fn = pc_init_apicid_fn;
>>      mc->auto_enable_numa_with_memhp = true;
>>      mc->has_hotpluggable_cpus = true;
>>      mc->default_boot_order = "cad";
>> diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
>> index b2b9e93a06..f028d2332a 100644
>> --- a/include/hw/i386/topology.h
>> +++ b/include/hw/i386/topology.h
>> @@ -140,7 +140,7 @@ static inline unsigned apicid_pkg_offset_epyc(X86CPUTopoInfo *topo_info)
>>   *
>>   * The caller must make sure core_id < nr_cores and smt_id < nr_threads.
>>   */
>> -static inline apic_id_t apicid_from_topo_ids_epyc(X86CPUTopoInfo *topo_info,
>> +static inline apic_id_t x86_apicid_from_topo_ids_epyc(X86CPUTopoInfo *topo_info,
>>                                                    const X86CPUTopoIDs *topo_ids)
>>  {
>>      return (topo_ids->pkg_id  << apicid_pkg_offset_epyc(topo_info)) |
>> @@ -200,7 +200,7 @@ static inline apic_id_t x86_apicid_from_cpu_idx_epyc(X86CPUTopoInfo *topo_info,
>>  {
>>      X86CPUTopoIDs topo_ids;
>>      x86_topo_ids_from_idx_epyc(topo_info, cpu_index, &topo_ids);
>> -    return apicid_from_topo_ids_epyc(topo_info, &topo_ids);
>> +    return x86_apicid_from_topo_ids_epyc(topo_info, &topo_ids);
>>  }
>>  /* Make APIC ID for the CPU based on Pkg_ID, Core_ID, SMT_ID
>>   *
>>
>>
> 

