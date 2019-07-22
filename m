Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11493C76191
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 02:37:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC0F421903
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 02:37:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC0F421903
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpOCi-00033b-WD
	for qemu-devel@archiver.kernel.org; Sun, 21 Jul 2019 22:37:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53875)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jingqi.liu@intel.com>) id 1hpOCX-0002fJ-5C
 for qemu-devel@nongnu.org; Sun, 21 Jul 2019 22:37:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jingqi.liu@intel.com>) id 1hpOCV-000238-Jh
 for qemu-devel@nongnu.org; Sun, 21 Jul 2019 22:37:21 -0400
Received: from mga09.intel.com ([134.134.136.24]:7584)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jingqi.liu@intel.com>)
 id 1hpOCV-0001yB-BH
 for qemu-devel@nongnu.org; Sun, 21 Jul 2019 22:37:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 21 Jul 2019 19:37:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,293,1559545200"; d="scan'208";a="176865876"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
 by FMSMGA003.fm.intel.com with ESMTP; 21 Jul 2019 19:37:11 -0700
Received: from fmsmsx153.amr.corp.intel.com (10.18.125.6) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 21 Jul 2019 19:37:11 -0700
Received: from shsmsx152.ccr.corp.intel.com (10.239.6.52) by
 FMSMSX153.amr.corp.intel.com (10.18.125.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 21 Jul 2019 19:37:11 -0700
Received: from shsmsx103.ccr.corp.intel.com ([169.254.4.109]) by
 SHSMSX152.ccr.corp.intel.com ([169.254.6.22]) with mapi id 14.03.0439.000;
 Mon, 22 Jul 2019 10:37:09 +0800
From: "Liu, Jingqi" <jingqi.liu@intel.com>
To: "Xu, Tao3" <tao3.xu@intel.com>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>
Thread-Topic: [PATCH v7 05/11] numa: Extend CLI to provide initiator
 information for numa nodes
Thread-Index: AQHVO+ZeZUCn4f4d8UCzDzSVlQKGxKbV85nA
Date: Mon, 22 Jul 2019 02:37:09 +0000
Message-ID: <09D68D4CF52CAF489B702DEBDD12D3D3529A877D@SHSMSX103.ccr.corp.intel.com>
References: <20190716145121.19578-1-tao3.xu@intel.com>
 <20190716145121.19578-6-tao3.xu@intel.com>
In-Reply-To: <20190716145121.19578-6-tao3.xu@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNjUxYmE3NzYtMzQ4YS00Yjk2LTg3NmQtOGMyNWZhOGU4NWNkIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiN1BpeWJkcXk1QjBrVGZWZTBrZHRyMHNSUFMrSjN0endETUdzbVMxcDhXMUhhdVFtYjUwU1Bsdm5BMks1SUVTbiJ9
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.24
Subject: Re: [Qemu-devel] [PATCH v7 05/11] numa: Extend CLI to provide
 initiator information for numa nodes
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
Cc: "Williams, Dan J" <dan.j.williams@intel.com>, "Du, Fan" <fan.du@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> -----Original Message-----
> From: Xu, Tao3
> Sent: Tuesday, July 16, 2019 10:51 PM
> To: imammedo@redhat.com; eblake@redhat.com; ehabkost@redhat.com
> Cc: Xu, Tao3 <tao3.xu@intel.com>; Liu, Jingqi <jingqi.liu@intel.com>; Wil=
liams, Dan J <dan.j.williams@intel.com>;
> jonathan.cameron@huawei.com; Du, Fan <fan.du@intel.com>; qemu-devel@nongn=
u.org
> Subject: [PATCH v7 05/11] numa: Extend CLI to provide initiator informati=
on for numa nodes
>=20
> In ACPI 6.3 chapter 5.2.27 Heterogeneous Memory Attribute Table (HMAT), T=
he initiator represents processor which access to memory. And
> in 5.2.27.3 Memory Proximity Domain Attributes Structure, the attached in=
itiator is defined as where the memory controller responsible for
> a memory proximity domain. With attached initiator information, the topol=
ogy of heterogeneous memory can be described.
>=20
> Extend CLI of "-numa node" option to indicate the initiator numa node-id.
> In the linux kernel, the codes in drivers/acpi/hmat/hmat.c parse and repo=
rt the platform's HMAT tables.
>=20
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Tao Xu <tao3.xu@intel.com>
Looks good for me.

Reviewed-by: Jingqi Liu <Jingqi.liu@intel.com>

Thanks
Jingqi Liu
> ---
>=20
> No changes in v7.
>=20
> Changes in v6:
>     - Add the version designator (since 4.2) after @initiator (Eric)
> ---
>  hw/core/machine.c     | 24 ++++++++++++++++++++++++
>  hw/core/numa.c        | 13 +++++++++++++
>  include/sysemu/numa.h |  3 +++
>  qapi/machine.json     |  6 +++++-
>  qemu-options.hx       | 27 +++++++++++++++++++++++----
>  5 files changed, 68 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/core/machine.c b/hw/core/machine.c index 4228bcd2a2..063c=
b7923c 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -653,6 +653,7 @@ void machine_set_cpu_numa_node(MachineState *machine,
>                                 const CpuInstanceProperties *props, Error=
 **errp)  {
>      MachineClass *mc =3D MACHINE_GET_CLASS(machine);
> +    NodeInfo *numa_info =3D machine->numa_state->nodes;
>      bool match =3D false;
>      int i;
>=20
> @@ -722,6 +723,16 @@ void machine_set_cpu_numa_node(MachineState *machine=
,
>          match =3D true;
>          slot->props.node_id =3D props->node_id;
>          slot->props.has_node_id =3D props->has_node_id;
> +
> +        if (numa_info[props->node_id].initiator_valid &&
> +            (props->node_id !=3D numa_info[props->node_id].initiator)) {
> +            error_setg(errp, "The initiator of CPU NUMA node %" PRId64
> +                       " should be itself.", props->node_id);
> +            return;
> +        }
> +        numa_info[props->node_id].initiator_valid =3D true;
> +        numa_info[props->node_id].has_cpu =3D true;
> +        numa_info[props->node_id].initiator =3D props->node_id;
>      }
>=20
>      if (!match) {
> @@ -1063,6 +1074,7 @@ static void machine_numa_finish_cpu_init(MachineSta=
te *machine)
>      GString *s =3D g_string_new(NULL);
>      MachineClass *mc =3D MACHINE_GET_CLASS(machine);
>      const CPUArchIdList *possible_cpus =3D mc->possible_cpu_arch_ids(mac=
hine);
> +    NodeInfo *numa_info =3D machine->numa_state->nodes;
>=20
>      assert(machine->numa_state->num_nodes);
>      for (i =3D 0; i < possible_cpus->len; i++) { @@ -1096,6 +1108,18 @@ =
static void machine_numa_finish_cpu_init(MachineState *machine)
>              machine_set_cpu_numa_node(machine, &props, &error_fatal);
>          }
>      }
> +
> +    for (i =3D 0; i < machine->numa_state->num_nodes; i++) {
> +        if (numa_info[i].initiator_valid &&
> +            !numa_info[numa_info[i].initiator].has_cpu) {
> +            error_report("The initiator-id %"PRIu16 " of NUMA node %d"
> +                         " does not exist.", numa_info[i].initiator, i);
> +            error_printf("\n");
> +
> +            exit(1);
> +        }
> +    }
> +
>      if (s->len && !qtest_enabled()) {
>          warn_report("CPU(s) not present in any NUMA nodes: %s",
>                      s->str);
> diff --git a/hw/core/numa.c b/hw/core/numa.c index 8fcbba05d6..cfb6339810=
 100644
> --- a/hw/core/numa.c
> +++ b/hw/core/numa.c
> @@ -128,6 +128,19 @@ static void parse_numa_node(MachineState *ms, NumaNo=
deOptions *node,
>          numa_info[nodenr].node_mem =3D object_property_get_uint(o, "size=
", NULL);
>          numa_info[nodenr].node_memdev =3D MEMORY_BACKEND(o);
>      }
> +
> +    if (node->has_initiator) {
> +        if (numa_info[nodenr].initiator_valid &&
> +            (node->initiator !=3D numa_info[nodenr].initiator)) {
> +            error_setg(errp, "The initiator of NUMA node %" PRIu16 " has=
 been "
> +                       "set to node %" PRIu16, nodenr,
> +                       numa_info[nodenr].initiator);
> +            return;
> +        }
> +
> +        numa_info[nodenr].initiator_valid =3D true;
> +        numa_info[nodenr].initiator =3D node->initiator;
> +    }
>      numa_info[nodenr].present =3D true;
>      max_numa_nodeid =3D MAX(max_numa_nodeid, nodenr + 1);
>      ms->numa_state->num_nodes++;
> diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h index 76da3016=
db..46ad06e000 100644
> --- a/include/sysemu/numa.h
> +++ b/include/sysemu/numa.h
> @@ -10,6 +10,9 @@ struct NodeInfo {
>      uint64_t node_mem;
>      struct HostMemoryBackend *node_memdev;
>      bool present;
> +    bool has_cpu;
> +    bool initiator_valid;
> +    uint16_t initiator;
>      uint8_t distance[MAX_NODES];
>  };
>=20
> diff --git a/qapi/machine.json b/qapi/machine.json index 6db8a7e2ec..05e3=
67d26a 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -414,6 +414,9 @@
>  # @memdev: memory backend object.  If specified for one node,
>  #          it must be specified for all nodes.
>  #
> +# @initiator: the initiator numa nodeid that is closest (as in directly
> +#             attached) to this numa node (since 4.2)
> +#
>  # Since: 2.1
>  ##
>  { 'struct': 'NumaNodeOptions',
> @@ -421,7 +424,8 @@
>     '*nodeid': 'uint16',
>     '*cpus':   ['uint16'],
>     '*mem':    'size',
> -   '*memdev': 'str' }}
> +   '*memdev': 'str',
> +   '*initiator': 'uint16' }}
>=20
>  ##
>  # @NumaDistOptions:
> diff --git a/qemu-options.hx b/qemu-options.hx index 9621e934c0..c4807819=
92 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -161,14 +161,14 @@ If any on the three values is given, the total numb=
er of CPUs @var{n} can be omi  ETEXI
>=20
>  DEF("numa", HAS_ARG, QEMU_OPTION_numa,
> -    "-numa node[,mem=3Dsize][,cpus=3Dfirstcpu[-lastcpu]][,nodeid=3Dnode]=
\n"
> -    "-numa node[,memdev=3Did][,cpus=3Dfirstcpu[-lastcpu]][,nodeid=3Dnode=
]\n"
> +    "-numa node[,mem=3Dsize][,cpus=3Dfirstcpu[-lastcpu]][,nodeid=3Dnode]=
[,initiator=3Dnode]\n"
> +    "-numa node[,memdev=3Did][,cpus=3Dfirstcpu[-lastcpu]][,nodeid=3Dnode=
][,initiator=3Dnode]\n"
>      "-numa dist,src=3Dsource,dst=3Ddestination,val=3Ddistance\n"
>      "-numa cpu,node-id=3Dnode[,socket-id=3Dx][,core-id=3Dy][,thread-id=
=3Dz]\n",
>      QEMU_ARCH_ALL)
>  STEXI
> -@item -numa node[,mem=3D@var{size}][,cpus=3D@var{firstcpu}[-@var{lastcpu=
}]][,nodeid=3D@var{node}]
> -@itemx -numa node[,memdev=3D@var{id}][,cpus=3D@var{firstcpu}[-@var{lastc=
pu}]][,nodeid=3D@var{node}]
> +@item -numa
> +node[,mem=3D@var{size}][,cpus=3D@var{firstcpu}[-@var{lastcpu}]][,nodeid=
=3D@va
> +r{node}][,initiator=3D@var{initiator}]
> +@itemx -numa
> +node[,memdev=3D@var{id}][,cpus=3D@var{firstcpu}[-@var{lastcpu}]][,nodeid=
=3D@v
> +ar{node}][,initiator=3D@var{initiator}]
>  @itemx -numa dist,src=3D@var{source},dst=3D@var{destination},val=3D@var{=
distance}
>  @itemx -numa cpu,node-id=3D@var{node}[,socket-id=3D@var{x}][,core-id=3D@=
var{y}][,thread-id=3D@var{z}]
>  @findex -numa
> @@ -215,6 +215,25 @@ split equally between them.
>  @samp{mem} and @samp{memdev} are mutually exclusive. Furthermore,  if on=
e node uses @samp{memdev}, all of them have to use it.
>=20
> +@samp{initiator} indicate the initiator NUMA @var{initiator} that is
> +closest (as in directly attached) to this NUMA @var{node}.
> +
> +For example, the following option assigns 2 NUMA nodes, node 0 has CPU.
> +node 1 has only memory, and its' initiator is node 0. Note that because
> +node 0 has CPU, by default the initiator of node 0 is itself and must
> +be itself.
> +@example
> +-M pc \
> +-m 2G,slots=3D2,maxmem=3D4G \
> +-object memory-backend-ram,size=3D1G,id=3Dm0 \ -object
> +memory-backend-ram,size=3D1G,id=3Dm1 \ -numa node,nodeid=3D0,memdev=3Dm0=
 \
> +-numa node,nodeid=3D1,memdev=3Dm1,initiator=3D0 \ -smp 2,sockets=3D2,max=
cpus=3D2
> +\ -numa cpu,node-id=3D0,socket-id=3D0 \ -numa cpu,node-id=3D0,socket-id=
=3D1 \
> +@end example
> +
>  @var{source} and @var{destination} are NUMA node IDs.
>  @var{distance} is the NUMA distance from @var{source} to @var{destinatio=
n}.
>  The distance from a node to itself is always 10. If any pair of nodes is
> --
> 2.20.1


