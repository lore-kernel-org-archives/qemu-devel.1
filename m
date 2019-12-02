Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC07C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 20:20:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3079421823
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 20:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="aBLBunUn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3079421823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibsBC-0003Y7-8e
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 15:20:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44597)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1ibs9c-0002nL-Ry
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 15:18:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1ibs9a-00008l-J7
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 15:18:44 -0500
Received: from mail-eopbgr760043.outbound.protection.outlook.com
 ([40.107.76.43]:31199 helo=NAM02-CY1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1ibs9a-00008R-4M
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 15:18:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JomCnBP1UxSEBLw43fUq1oxOZkWRnccvULmdrD+mkZktSPFELdvQHpBr7Sec5XEVyxgpOJ3SJ8dgrrYd9i5BeaGrG9lgRjAjbUJ091o72C6xpzvo7auBude1Og+U+iOBwaF4O+GhMvl8k6o5jXA4EVNyK9abtLUcan0wTpYFVgDom5m7auIj+YmL09Q2y3wUu5MxALlsUXciEXXfHJrEGIRQbbhx92VH+WgiCd4o+1aRdJUT0/1oNvSGFSIghWEtrXtTkkDbtWjcCF8QSvl+3Si2EeDLBJ9CojSCqJ4fjZnr78hCp2+jX8xljC33poBzZZZ+d7cAQTyrxxe/T7j47g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WTg5hyA3INO/jjh8tb6m7HH4B1WbxrXyFcj4tYhGT7Y=;
 b=cL4cORrhpjhRJOuHwwGSHM4YtpH5MyoLKAPMx26wnUSQJnNOKFK2agDoq+6O+mgozdK3gR/mu0iz01Ie+2L1I+eron014QAXaTpNaH3Q86AFmZmriFAAJrij90POCDOMrtlyAiGtW9H+HpOuK7qWgrTSBIffdkJ0FU0fe5kLv18usZadTUSSPlMxb2YjjRN/Awb80ueS7CiiMPEf+gxZ/Ya0sn+UoUI3BQu55Tqx8NtDBfy9S76Bp0GuLPKeJNqrT6M0Ks4RjIONnnQK8JSCFp7P5LgeYhtmSXuaGuq+7TxeZLVTSwJYKRGox8o4OoeGqLZPhxOclHXksAa0Ns29lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WTg5hyA3INO/jjh8tb6m7HH4B1WbxrXyFcj4tYhGT7Y=;
 b=aBLBunUnd0uwZWaHxA860zln4ZG5tNkrnimP4VoicA9DHchh54w8KUsugvDeZ/d07AwrbBeG/T5AH45zlpceXEbgKfXBGK9aEShmXVcGmYAJbHjjimTPHhiO7eFGUIKIh951Ys16a8xJJ65IIZa4hxFb4EkXBtOGjPdxq1HMkDg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1211.namprd12.prod.outlook.com (10.168.239.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.20; Mon, 2 Dec 2019 20:18:37 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::d0f5:b875:7b5c:46c3]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::d0f5:b875:7b5c:46c3%6]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 20:18:37 +0000
Subject: Re: [Qemu-devel] [RFC 2 PATCH 01/16] numa: Split the numa
 functionality
To: Eduardo Habkost <ehabkost@redhat.com>
References: <156779689013.21957.1631551572950676212.stgit@localhost.localdomain>
 <156779710184.21957.13351592831416903368.stgit@localhost.localdomain>
 <20191010032538.GB21666@habkost.net>
From: Babu Moger <babu.moger@amd.com>
Message-ID: <a1a0328b-4adf-eeaf-bab4-c02e430cd44a@amd.com>
Date: Mon, 2 Dec 2019 14:18:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
In-Reply-To: <20191010032538.GB21666@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR06CA0063.namprd06.prod.outlook.com
 (2603:10b6:5:54::40) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
MIME-Version: 1.0
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f7876044-47b8-4628-db77-08d77764d07d
X-MS-TrafficTypeDiagnostic: DM5PR12MB1211:
X-Microsoft-Antispam-PRVS: <DM5PR12MB12115F288BAEDFEE436AD69495430@DM5PR12MB1211.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0239D46DB6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(396003)(366004)(346002)(136003)(199004)(189003)(6512007)(47776003)(52116002)(305945005)(3846002)(6116002)(229853002)(31696002)(446003)(11346002)(44832011)(4326008)(25786009)(14454004)(230700001)(53546011)(6506007)(386003)(26005)(8936002)(478600001)(99286004)(66946007)(5660300002)(31686004)(66556008)(58126008)(66476007)(2616005)(81166006)(81156014)(316002)(14444005)(36756003)(86362001)(6436002)(8676002)(2906002)(6916009)(54906003)(65806001)(6486002)(65956001)(2486003)(23676004)(66066001)(76176011)(7736002)(50466002)(6246003)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1211;
 H:DM5PR12MB2471.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +ozYsXVwEolLXrdGk/O4ZxAeiFej5lt4YulRdyI+5Uctsls5KRin/u1L3rJAIkPIVaocjYEaYHyHigpEFD9ZI/VMBTLNtTtmA8pTBTPJgBoJHeOGsZDk1WHaz8R6oWU7JI1DwQT7Pa5mkS/dXlCF73k86lTxtr2LZdEJHXBTR3N7YX+T2O800i2QFiAaY/p7ChU536qWc6nbkAMF/pj4WLEvwEBFzfddnpIAG8L9FvxrU0DbL8Ycav9Mabw4zDjATUwEvVUxybwuBZKkBmfpQ4Z6FCzQRr3dngxTubGOkdt+x27YweaxDM1aQw7p9uvvKW5LvDbTlrzgd0hlD1Dvy9kLdgfuwUAX2MhxVTJDf4zJ4naeKULuRu/aIo7jHeJAZqrHZuEbBVFlwQNzod7JJ7QzBq+f/sS22rIftypeEAIYOqdwwxJs9ZTx6aXcQd34
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7876044-47b8-4628-db77-08d77764d07d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2019 20:18:37.6327 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0wjG9aeXIvD1BMSy7jkA8I6phyBLw2T9j8SpPvVMaqDj6tp2kIVxnJIY0HezygdD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1211
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.76.43
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


Eduardo,
Sorry taking time to respond to your comments earlier. Started working on
something else so it took a while to come back.

Working on v3 right now and taken care most of your comments on v2. Will
plan to submit v3 sometime this week.

On 10/9/19 10:25 PM, Eduardo Habkost wrote:
> Hi,
> 
> First of all, sorry for taking more than a month to start
> reviewing this.
> 
> On Fri, Sep 06, 2019 at 07:11:43PM +0000, Moger, Babu wrote:
>> To support new epyc mode, we need to know the number of numa nodes
>> in advance to generate apic id correctly. [...]
> 
> This explains that we need to initialize numa_info earlier than
> something...
> 
>>                                     [...] So, split the numa
>> initialization into two. The function parse_numa initializes numa_info
>> and updates nb_numa_nodes. And then parse_numa_node does the numa node
>> initialization.
> 
> ...but I miss what "something" is.
> 
> The sequence of events here will be:
> 
> * parse_numa_opts()
>   * for each -numa option:
>     * parse_numa()
>       * set_numa_options()
>         * parse_numa_info()
>           * here ms->numa_state->num_nodes is incremented [1]
> * parse_numa_node_opts()
>   * for each -numa option:
>     * parse_numa_node()
>       * set_numa_node_options()
>         * here are the operations that are being delayed by this
>           patch [2]
> 
> What exactly makes it necessary for [2] to happen after [1] is
> done for all NUMA nodes?

We dont need these changes anymore. Look at my comments below.

> 
> This needs to be clear in the code, otherwise somebody will try to refactor
> this in the future and merge set_numa_node_options() and parse_numa_info()
> again, not knowing why ordering between [1] and [2] is so important.
> 
> In addition to documenting it better, I suggest saving the CPU
> index list in NodeInfo, instead of calling qemu_opts_foreach()
> twice.  (Probably a good idea to document the new field as
> internal, though.  We don't want machine-specific code to be
> looking at the CPU index list.)
> 
> Also, would it work if the delayed initialization is done at
> numa_complete_configuration() instead of a new
> parse_numa_node_opts() function?  We already have 2 separate
> steps in NUMA initialization (parse_numa_node() and
> numa_complete_configuration()), so it would be nice to avoid
> adding a 3rd one.
> 
> Putting all the suggestions together, the code would look like this:
> 
> 
> static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
>                             Error **errp)
> {
>     /* ... */
>     numa_info[nodenr].cpu_indexes = QAPI_CLONE(node->cpus, uint16List);
>     /* ... */
> }
> 
> void numa_complete_configuration(MachineState *ms)
> {
>     /* ... */
>     for (i = 0; i < ms->numa_state->num_nodes; i++) {
>         /*
>          * numa_node_complete_configuration() needs to be called after all
>          * nodes were already parsed, because <insert reason here>,
>          */
>         numa_node_complete_configuration(numa_info[i]);
>     }
> }
> 
> void numa_node_complete_configuration(MachineState *ms, NodeInfo *node)
> {
>     for (cpu_index = node->cpu_indexes; cpu_index; cpu_index = cpu_index->next) {
>         CpuInstanceProperties props;
>         props = mc->cpu_index_to_instance_props(ms, cpu_index->value);
>         props.node_id = nodenr;
>         props.has_node_id = true;
>         machine_set_cpu_numa_node(ms, &props, &err);
>     }
> }

Yes. I this works fine. Also makes the code simple. Only requirement was
to know the number of numa nodes in advance. Thanks

> 
> 
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>>  hw/core/numa.c        |  106 +++++++++++++++++++++++++++++++++++--------------
>>  include/sysemu/numa.h |    2 +
>>  vl.c                  |    2 +
>>  3 files changed, 80 insertions(+), 30 deletions(-)
>>
>> diff --git a/hw/core/numa.c b/hw/core/numa.c
>> index a11431483c..27fa6b5e1d 100644
>> --- a/hw/core/numa.c
>> +++ b/hw/core/numa.c
>> @@ -55,14 +55,10 @@ bool have_numa_distance;
>>  NodeInfo numa_info[MAX_NODES];
>>  
>>  
>> -static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
>> +static void parse_numa_info(MachineState *ms, NumaNodeOptions *node,
>>                              Error **errp)
>>  {
>> -    Error *err = NULL;
>>      uint16_t nodenr;
>> -    uint16List *cpus = NULL;
>> -    MachineClass *mc = MACHINE_GET_CLASS(ms);
>> -    unsigned int max_cpus = ms->smp.max_cpus;
>>  
>>      if (node->has_nodeid) {
>>          nodenr = node->nodeid;
>> @@ -81,29 +77,6 @@ static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
>>          return;
>>      }
>>  
>> -    if (!mc->cpu_index_to_instance_props || !mc->get_default_cpu_node_id) {
>> -        error_setg(errp, "NUMA is not supported by this machine-type");
>> -        return;
>> -    }
>> -    for (cpus = node->cpus; cpus; cpus = cpus->next) {
>> -        CpuInstanceProperties props;
>> -        if (cpus->value >= max_cpus) {
>> -            error_setg(errp,
>> -                       "CPU index (%" PRIu16 ")"
>> -                       " should be smaller than maxcpus (%d)",
>> -                       cpus->value, max_cpus);
>> -            return;
>> -        }
>> -        props = mc->cpu_index_to_instance_props(ms, cpus->value);
>> -        props.node_id = nodenr;
>> -        props.has_node_id = true;
>> -        machine_set_cpu_numa_node(ms, &props, &err);
>> -        if (err) {
>> -            error_propagate(errp, err);
>> -            return;
>> -        }
>> -    }
>> -
>>      have_memdevs = have_memdevs ? : node->has_memdev;
>>      have_mem = have_mem ? : node->has_mem;
>>      if ((node->has_mem && have_memdevs) || (node->has_memdev && have_mem)) {
>> @@ -177,7 +150,7 @@ void set_numa_options(MachineState *ms, NumaOptions *object, Error **errp)
>>  
>>      switch (object->type) {
>>      case NUMA_OPTIONS_TYPE_NODE:
>> -        parse_numa_node(ms, &object->u.node, &err);
>> +        parse_numa_info(ms, &object->u.node, &err);
>>          if (err) {
>>              goto end;
>>          }
>> @@ -242,6 +215,73 @@ end:
>>      return 0;
>>  }
>>  
>> +void set_numa_node_options(MachineState *ms, NumaOptions *object, Error **errp)
>> +{
>> +    MachineClass *mc = MACHINE_GET_CLASS(ms);
>> +    NumaNodeOptions *node = &object->u.node;
>> +    unsigned int max_cpus = ms->smp.max_cpus;
>> +    uint16List *cpus = NULL;
>> +    Error *err = NULL;
>> +    uint16_t nodenr;
>> +
>> +    if (node->has_nodeid) {
>> +        nodenr = node->nodeid;
>> +    } else {
>> +        error_setg(errp, "NUMA node information is not available");
>> +    }
>> +
>> +    if (!mc->cpu_index_to_instance_props || !mc->get_default_cpu_node_id) {
>> +        error_setg(errp, "NUMA is not supported by this machine-type");
>> +        return;
>> +    }
>> +
>> +    for (cpus = node->cpus; cpus; cpus = cpus->next) {
>> +        CpuInstanceProperties props;
>> +        if (cpus->value >= max_cpus) {
>> +            error_setg(errp,
>> +                       "CPU index (%" PRIu16 ")"
>> +                       " should be smaller than maxcpus (%d)",
>> +                       cpus->value, max_cpus);
>> +            return;
>> +         }
>> +         props = mc->cpu_index_to_instance_props(ms, cpus->value);
>> +         props.node_id = nodenr;
>> +         props.has_node_id = true;
>> +         machine_set_cpu_numa_node(ms, &props, &err);
>> +         if (err) {
>> +            error_propagate(errp, err);
>> +            return;
>> +         }
>> +    }
>> +}
>> +
>> +static int parse_numa_node(void *opaque, QemuOpts *opts, Error **errp)
>> +{
>> +    NumaOptions *object = NULL;
>> +    MachineState *ms = MACHINE(opaque);
>> +    Error *err = NULL;
>> +    Visitor *v = opts_visitor_new(opts);
>> +
>> +    visit_type_NumaOptions(v, NULL, &object, &err);
>> +    visit_free(v);
>> +    if (err) {
>> +        goto end;
>> +    }
>> +
>> +    if (object->type == NUMA_OPTIONS_TYPE_NODE) {
>> +        set_numa_node_options(ms, object, &err);
>> +    }
>> +
>> +end:
>> +    qapi_free_NumaOptions(object);
>> +    if (err) {
>> +        error_propagate(errp, err);
>> +        return -1;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>>  /* If all node pair distances are symmetric, then only distances
>>   * in one direction are enough. If there is even one asymmetric
>>   * pair, though, then all distances must be provided. The
>> @@ -368,7 +408,7 @@ void numa_complete_configuration(MachineState *ms)
>>      if (ms->ram_slots > 0 && nb_numa_nodes == 0 &&
>>          mc->auto_enable_numa_with_memhp) {
>>              NumaNodeOptions node = { };
>> -            parse_numa_node(ms, &node, &error_abort);
>> +            parse_numa_info(ms, &node, &error_abort);
>>      }
>>  
>>      assert(max_numa_nodeid <= MAX_NODES);
>> @@ -448,6 +488,12 @@ void parse_numa_opts(MachineState *ms)
>>      qemu_opts_foreach(qemu_find_opts("numa"), parse_numa, ms, &error_fatal);
>>  }
>>  
>> +void parse_numa_node_opts(MachineState *ms)
>> +{
>> +    qemu_opts_foreach(qemu_find_opts("numa"), parse_numa_node,
>> +                      ms, &error_fatal);
>> +}
>> +
>>  void numa_cpu_pre_plug(const CPUArchId *slot, DeviceState *dev, Error **errp)
>>  {
>>      int node_id = object_property_get_int(OBJECT(dev), "node-id", &error_abort);
>> diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
>> index 01a263eba2..ca109adaa6 100644
>> --- a/include/sysemu/numa.h
>> +++ b/include/sysemu/numa.h
>> @@ -24,7 +24,9 @@ struct NumaNodeMem {
>>  extern NodeInfo numa_info[MAX_NODES];
>>  
>>  void set_numa_options(MachineState *ms, NumaOptions *object, Error **errp);
>> +void set_numa_node_options(MachineState *ms, NumaOptions *object, Error **errp);
>>  void parse_numa_opts(MachineState *ms);
>> +void parse_numa_node_opts(MachineState *ms);
>>  void numa_complete_configuration(MachineState *ms);
>>  void query_numa_node_mem(NumaNodeMem node_mem[]);
>>  extern QemuOptsList qemu_numa_opts;
>> diff --git a/vl.c b/vl.c
>> index b426b32134..711d2ae5da 100644
>> --- a/vl.c
>> +++ b/vl.c
>> @@ -4339,6 +4339,8 @@ int main(int argc, char **argv, char **envp)
>>      }
>>      parse_numa_opts(current_machine);
>>  
>> +    parse_numa_node_opts(current_machine);
>> +
>>      /* do monitor/qmp handling at preconfig state if requested */
>>      main_loop();
>>  
>>
> 

