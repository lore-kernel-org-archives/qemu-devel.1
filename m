Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F8BC432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 20:45:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F517205ED
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 20:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="J6/f7ZGQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F517205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibsZf-0007Nr-6b
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 15:45:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46789)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1ibsYZ-0006tw-68
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 15:44:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1ibsYX-0007Gs-SB
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 15:44:31 -0500
Received: from mail-eopbgr720079.outbound.protection.outlook.com
 ([40.107.72.79]:35136 helo=NAM05-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1ibsYX-0007EV-Jy
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 15:44:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DACxwtn53kGJIguCRU1XnE0ixJ32Os5xs8/zQ1Is88yyGm2G0jrD4W56aTSDY+C353T0QPgkSBg2QPyYwnuXHa2oXg8QN5Y1iHg81G/RgKTgPgp5QLmBvHigIWNExKGoYaHNQfnHqgY28UC2gOHHjJqAka8vF9jGf46LL5g2ea2tSJuifvoKKz2XPOWyFNKOW2SU3VxHKF1q6Glz5sDHpWgG77btXlkMxnEiExacTDJv0DE7/kYWzvsq28jDrmnBhBylYIxqqm0HcFTPL6LXgHuV+Bu1MOZAUXhffwoarWbLNZ+C+xbhfw9mGmKe3NAgOQJm5+qrG7vJoV4ffREbdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8SV3LmhdCdNSnVO/VMeQcygohDbf58aUAR9BXJQkM4=;
 b=I3g8HOIpv0y5pqYPsCJOJay7uUtdf+Bqel4ogAb7oq0aW4AD/OTeywiMyItBQW1flKnJCBeJDoaFX+vjA5904hDOA0dCgejjqHGs/9jPdeKLhWT3LHKQ5oJjTSqIlP0STH8zVJiGhzG4J1v01fRpn3wLssxrFTpBXZumiHTwFvmc2WX93wD1kU1pD4sXobZury9yhdFrJYSTe4lBDkAWBnm+sedZnwFJnTJsl9r9P5uu6tid1EveTydnNLXvlUOktmzde87/5rMFqV/bmOkvRHbLKY/Yk3IsBGc9GPy5BQV6kKFbE0rjTJsZMd0cYEhqjXwAl9fJRI3EDGveU83kDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8SV3LmhdCdNSnVO/VMeQcygohDbf58aUAR9BXJQkM4=;
 b=J6/f7ZGQ/41N+dQLfoUA+hd8Dc1z7gbauaeJ8D9NQGrbJY4irkX8wnId87Y/nHpNO5z7GwxZ268Bo7Ubf03nhXo1muJ5w/yMVoJNYGfIhUW+RQYfNtENi6fuYsc0XZJ544OkiP4R3tl2SgHyZI6TKNHP1D19VRrxr4ORBv1mhZo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1274.namprd12.prod.outlook.com (10.168.239.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.20; Mon, 2 Dec 2019 20:44:26 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::d0f5:b875:7b5c:46c3]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::d0f5:b875:7b5c:46c3%6]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 20:44:26 +0000
Subject: Re: [Qemu-devel] [RFC 2 PATCH 16/16] hw/core: Fix up the
 machine_set_cpu_numa_node for epyc
To: Eduardo Habkost <ehabkost@redhat.com>
References: <156779689013.21957.1631551572950676212.stgit@localhost.localdomain>
 <156779720803.21957.8389712174989601936.stgit@localhost.localdomain>
 <20191011041057.GJ29387@habkost.net>
From: Babu Moger <babu.moger@amd.com>
Message-ID: <255ae191-c477-de25-3e46-205d0797a67e@amd.com>
Date: Mon, 2 Dec 2019 14:44:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
In-Reply-To: <20191011041057.GJ29387@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR08CA0004.namprd08.prod.outlook.com
 (2603:10b6:805:66::17) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
MIME-Version: 1.0
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 46113804-0ab7-48a6-2091-08d777686bba
X-MS-TrafficTypeDiagnostic: DM5PR12MB1274:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1274BD91D72BE8A8C7832FF495430@DM5PR12MB1274.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0239D46DB6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(376002)(39860400002)(346002)(366004)(136003)(189003)(199004)(50466002)(2906002)(99286004)(6512007)(6436002)(6486002)(478600001)(5660300002)(14454004)(8676002)(66066001)(81166006)(186003)(66946007)(26005)(2616005)(11346002)(446003)(44832011)(31686004)(229853002)(4326008)(6246003)(81156014)(53546011)(6506007)(386003)(2486003)(23676004)(76176011)(52116002)(305945005)(7736002)(65806001)(65956001)(25786009)(36756003)(6916009)(66556008)(66476007)(8936002)(58126008)(316002)(6116002)(3846002)(14444005)(54906003)(230700001)(31696002)(47776003)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1274;
 H:DM5PR12MB2471.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tzAELxw4dT8oKEfK3JCQ5ZJ4DcJN37Uw6B2YT1ojAzNdpvqf6HHdAvFBai7hBjkBkKCd0FeQb3jd5GAGBRZkqmvAs7olj/1Qq25WpPvV+Gt0yJFcM7kcjR4z/+eL+mMJttmPlMdlh/dtXlll6UgCzStpnyq4xi5bc/rhzuCQcpxl9MejTsPai5ESX87aJGpTxVnRcl7vh0LlkueaNA5j0WSUZ4CqcGtwixr36FgX1qEmQLoyr5COrVG/09lIJCPo9QWV/c9FFZ/ORndcfBtS/XLwAepCg+fQG12QpiwELRbN9YNwgs030i7ixuVUik6GwSnhmLS95DlAXIgiu5hIRH6VFcDezFjOep58u/QnF9s/goUKoZERKuuosgfkJBk55D7C5zajFIh3ECxpQHdsMANta4gvPrt3YfdsSZe0JZV85nd+0A4xQvwACyzMQMbF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46113804-0ab7-48a6-2091-08d777686bba
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2019 20:44:26.5717 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FzYNBF/hM0nhcSJwyf5l7C8fQdH8D1g/9W2fEUpbm5u+d3iwg5pgTGVNWM5ZUSsy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1274
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.72.79
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



On 10/10/19 11:10 PM, Eduardo Habkost wrote:
> On Fri, Sep 06, 2019 at 07:13:29PM +0000, Moger, Babu wrote:
>> Current topology id match will not work for epyc mode when setting
>> the node id. In epyc mode, ids like smt_id, thread_id, core_id,
>> ccx_id, socket_id can be same for more than one CPUs with across
>> two numa nodes.
>>
>> For example, we can have two CPUs with following ids on two different node.
>> 1. smt_id=0, thread_id=0, core_id=0, ccx_id=0, socket_id=0, node_id=0
>> 2. smt_id=0, thread_id=0, core_id=0, ccx_id=0, socket_id=0, node_id=1
> 
> I don't understand how that could happen.  If all IDs are the
> same, how is it possible that those two cases should match two
> different CPUs?
> 
> cpu_index_to_instance_props() must always return an unique
> identifier for a single CPU.

Simplified apic id decoding in v3 version. We don't need these changes
anymore.

> 
>>
>> The function machine_set_cpu_numa_node will fail to find a match to assign
>> the node. Added new function machine_set_cpu_numa_node_epyc to set the node_id
>> directly in epyc mode.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>>  hw/core/machine.c   |   24 ++++++++++++++++++++++++
>>  hw/core/numa.c      |    6 +++++-
>>  include/hw/boards.h |    4 ++++
>>  3 files changed, 33 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>> index 9a8586cf30..6bceefc6f3 100644
>> --- a/hw/core/machine.c
>> +++ b/hw/core/machine.c
>> @@ -741,6 +741,30 @@ void machine_set_cpu_numa_node(MachineState *machine,
>>      }
>>  }
>>  
>> +void machine_set_cpu_numa_node_epyc(MachineState *machine,
>> +                                    const CpuInstanceProperties *props,
>> +                                    unsigned index,
>> +                                    Error **errp)
>> +{
>> +    MachineClass *mc = MACHINE_GET_CLASS(machine);
>> +    CPUArchId *slot;
>> +
>> +    if (!mc->possible_cpu_arch_ids) {
>> +        error_setg(errp, "mapping of CPUs to NUMA node is not supported");
>> +        return;
>> +    }
>> +
>> +    /* disabling node mapping is not supported, forbid it */
>> +    assert(props->has_node_id);
>> +
>> +    /* force board to initialize possible_cpus if it hasn't been done yet */
>> +    mc->possible_cpu_arch_ids(machine);
>> +
>> +    slot = &machine->possible_cpus->cpus[index];
>> +    slot->props.node_id = props->node_id;
>> +    slot->props.has_node_id = props->has_node_id;
>> +}
>> +
>>  static void smp_parse(MachineState *ms, QemuOpts *opts)
>>  {
>>      if (opts) {
>> diff --git a/hw/core/numa.c b/hw/core/numa.c
>> index 27fa6b5e1d..a9e835aea6 100644
>> --- a/hw/core/numa.c
>> +++ b/hw/core/numa.c
>> @@ -247,7 +247,11 @@ void set_numa_node_options(MachineState *ms, NumaOptions *object, Error **errp)
>>           props = mc->cpu_index_to_instance_props(ms, cpus->value);
>>           props.node_id = nodenr;
>>           props.has_node_id = true;
>> -         machine_set_cpu_numa_node(ms, &props, &err);
>> +         if (ms->epyc) {
>> +             machine_set_cpu_numa_node_epyc(ms, &props, cpus->value, &err);
>> +         } else {
>> +             machine_set_cpu_numa_node(ms, &props, &err);
>> +         }
>>           if (err) {
>>              error_propagate(errp, err);
>>              return;
>> diff --git a/include/hw/boards.h b/include/hw/boards.h
>> index 0001d42e50..ec1b1c5a85 100644
>> --- a/include/hw/boards.h
>> +++ b/include/hw/boards.h
>> @@ -74,6 +74,10 @@ HotpluggableCPUList *machine_query_hotpluggable_cpus(MachineState *machine);
>>  void machine_set_cpu_numa_node(MachineState *machine,
>>                                 const CpuInstanceProperties *props,
>>                                 Error **errp);
>> +void machine_set_cpu_numa_node_epyc(MachineState *machine,
>> +                                    const CpuInstanceProperties *props,
>> +                                    unsigned index,
>> +                                    Error **errp);
>>  
>>  void machine_class_allow_dynamic_sysbus_dev(MachineClass *mc, const char *type);
>>  
>>
> 

