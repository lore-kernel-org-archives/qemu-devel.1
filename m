Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534DFCA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 12:31:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E039205C9
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 12:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YA1NR5iG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E039205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMWqj-0005vf-6X
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 08:31:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57682)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iMWoB-0004YL-W1
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 08:29:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iMWo9-0005z8-JK
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 08:29:11 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60606)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iMWo9-0005yi-F0
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 08:29:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571660948;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c60GbpeS7SanVejZfMgDrnweFcRUavlBobG/gJuYVt0=;
 b=YA1NR5iG7BYFG+ydInv7LGIggFru06fUQpt4iT3r6akPdaXZBfmFNTobK078amC1gME11A
 VBdKh1lWPDGktW2c/H0yxBcP0Y4f+dVxPXOC+ORNijvfMW3Dw5Bachswr1KfYISsYIo9+3
 KTNLTBzOrYB3j8786Czi6vb5KNHgI7g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-JFkcd2uANBKiSz4se_yJBQ-1; Mon, 21 Oct 2019 08:29:06 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 96CDE107AD31;
 Mon, 21 Oct 2019 12:29:05 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9910460606;
 Mon, 21 Oct 2019 12:29:03 +0000 (UTC)
Date: Mon, 21 Oct 2019 14:29:01 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Subject: Re: [PATCH v13 05/12] numa: Extend CLI to provide initiator
 information for numa nodes
Message-ID: <20191021142901.24b33faa@redhat.com>
In-Reply-To: <20191020111125.27659-6-tao3.xu@intel.com>
References: <20191020111125.27659-1-tao3.xu@intel.com>
 <20191020111125.27659-6-tao3.xu@intel.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: JFkcd2uANBKiSz4se_yJBQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: ehabkost@redhat.com, jingqi.liu@intel.com, fan.du@intel.com,
 qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
 Dan Williams <dan.j.williams@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 20 Oct 2019 19:11:18 +0800
Tao Xu <tao3.xu@intel.com> wrote:

> In ACPI 6.3 chapter 5.2.27 Heterogeneous Memory Attribute Table (HMAT),
> The initiator represents processor which access to memory. And in 5.2.27.=
3
> Memory Proximity Domain Attributes Structure, the attached initiator is
> defined as where the memory controller responsible for a memory proximity
> domain. With attached initiator information, the topology of heterogeneou=
s
> memory can be described.
>=20
> Extend CLI of "-numa node" option to indicate the initiator numa node-id.
> In the linux kernel, the codes in drivers/acpi/hmat/hmat.c parse and repo=
rt
> the platform's HMAT tables.
>=20
> Reviewed-by: Jingqi Liu <jingqi.liu@intel.com>
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Tao Xu <tao3.xu@intel.com>
> ---
>=20
> Changes in v13:
>     - Modify some text description
>     - Drop "initiator_valid" field in struct NodeInfo (Igor)
>=20
> Changes in v12:
>     - Fix the bug that a memory-only node without initiator setting
>       doesn't report error. (reported by Danmei Wei)
> ---
>  hw/core/machine.c     | 70 +++++++++++++++++++++++++++++++++++++++++++
>  hw/core/numa.c        | 23 ++++++++++++++
>  include/sysemu/numa.h |  5 ++++
>  qapi/machine.json     | 10 ++++++-
>  qemu-options.hx       | 35 ++++++++++++++++++----
>  5 files changed, 137 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 1689ad3bf8..32a451bd84 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -518,6 +518,20 @@ static void machine_set_nvdimm(Object *obj, bool val=
ue, Error **errp)
>      ms->nvdimms_state->is_enabled =3D value;
>  }
> =20
> +static bool machine_get_hmat(Object *obj, Error **errp)
> +{
> +    MachineState *ms =3D MACHINE(obj);
> +
> +    return ms->numa_state->hmat_enabled;
> +}
> +
> +static void machine_set_hmat(Object *obj, bool value, Error **errp)
> +{
> +    MachineState *ms =3D MACHINE(obj);
> +
> +    ms->numa_state->hmat_enabled =3D value;
> +}
> +
>  static char *machine_get_nvdimm_persistence(Object *obj, Error **errp)
>  {
>      MachineState *ms =3D MACHINE(obj);
> @@ -645,6 +659,7 @@ void machine_set_cpu_numa_node(MachineState *machine,
>                                 const CpuInstanceProperties *props, Error=
 **errp)
>  {
>      MachineClass *mc =3D MACHINE_GET_CLASS(machine);
> +    NodeInfo *numa_info =3D machine->numa_state->nodes;
>      bool match =3D false;
>      int i;
> =20
> @@ -714,6 +729,17 @@ void machine_set_cpu_numa_node(MachineState *machine=
,
>          match =3D true;
>          slot->props.node_id =3D props->node_id;
>          slot->props.has_node_id =3D props->has_node_id;
> +
> +        if (machine->numa_state->hmat_enabled) {
> +            if ((numa_info[props->node_id].initiator < MAX_NODES) &&
> +                (props->node_id !=3D numa_info[props->node_id].initiator=
)) {
> +                error_setg(errp, "The initiator of CPU NUMA node %" PRId=
64
> +                        " should be itself.", props->node_id);
> +                return;
> +            }
> +            numa_info[props->node_id].has_cpu =3D true;
> +            numa_info[props->node_id].initiator =3D props->node_id;
> +        }
>      }
> =20
>      if (!match) {
> @@ -960,6 +986,13 @@ static void machine_initfn(Object *obj)
> =20
>      if (mc->numa_mem_supported) {
>          ms->numa_state =3D g_new0(NumaState, 1);
> +        object_property_add_bool(obj, "hmat",
> +                                 machine_get_hmat, machine_set_hmat,
> +                                 &error_abort);
> +        object_property_set_description(obj, "hmat",
> +                                        "Set on/off to enable/disable "
> +                                        "ACPI Heterogeneous Memory Attri=
bute "
> +                                        "Table (HMAT)", NULL);
>      }
> =20
>      /* Register notifier when init is done for sysbus sanity checks */
> @@ -1048,6 +1081,38 @@ static char *cpu_slot_to_string(const CPUArchId *c=
pu)
>      return g_string_free(s, false);
>  }
> =20
> +static void numa_validate_initiator(NumaState *numa_state)
> +{
> +    int i;
> +    NodeInfo *numa_info =3D numa_state->nodes;
> +
> +    for (i =3D 0; i < numa_state->num_nodes; i++) {
> +        if (numa_info[i].initiator =3D=3D MAX_NODES) {
> +            error_report("The initiator of NUMA node %d is missing, use =
"
> +                         "'-numa node,initiator' option to declare it.",=
 i);
> +            goto err;
> +        }
> +
> +        if (!numa_info[numa_info[i].initiator].present) {
> +            error_report("NUMA node %" PRIu16 " is missing, use "
> +                         "'-numa node' option to declare it first.",
> +                         numa_info[i].initiator);
> +            goto err;
> +        }
> +
> +        if (!numa_info[numa_info[i].initiator].has_cpu) {
> +            error_report("The initiator of NUMA node %d is invalid.", i)=
;
> +            goto err;
> +        }
> +    }
> +
> +    return;
> +
> +err:
> +    error_printf("\n");
error_report() does ^^^, drop it

with this fixed,

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> +    exit(1);
> +}
> +
>  static void machine_numa_finish_cpu_init(MachineState *machine)
>  {
>      int i;
> @@ -1088,6 +1153,11 @@ static void machine_numa_finish_cpu_init(MachineSt=
ate *machine)
>              machine_set_cpu_numa_node(machine, &props, &error_fatal);
>          }
>      }
> +
> +    if (machine->numa_state->hmat_enabled) {
> +        numa_validate_initiator(machine->numa_state);
> +    }
> +
>      if (s->len && !qtest_enabled()) {
>          warn_report("CPU(s) not present in any NUMA nodes: %s",
>                      s->str);
> diff --git a/hw/core/numa.c b/hw/core/numa.c
> index 038c96d4ab..eba66ab768 100644
> --- a/hw/core/numa.c
> +++ b/hw/core/numa.c
> @@ -133,6 +133,29 @@ static void parse_numa_node(MachineState *ms, NumaNo=
deOptions *node,
>          numa_info[nodenr].node_mem =3D object_property_get_uint(o, "size=
", NULL);
>          numa_info[nodenr].node_memdev =3D MEMORY_BACKEND(o);
>      }
> +
> +    /*
> +     * If not set the initiator, set it to MAX_NODES. And if
> +     * HMAT is enabled and this node has no cpus, QEMU will raise error.
> +     */
> +    numa_info[nodenr].initiator =3D MAX_NODES;
> +    if (node->has_initiator) {
> +        if (!ms->numa_state->hmat_enabled) {
> +            error_setg(errp, "ACPI Heterogeneous Memory Attribute Table =
"
> +                       "(HMAT) is disabled, enable it with -machine hmat=
=3Don "
> +                       "before using any of hmat specific options.");
> +            return;
> +        }
> +
> +        if (node->initiator >=3D MAX_NODES) {
> +            error_report("The initiator id %" PRIu16 " expects an intege=
r "
> +                         "between 0 and %d", node->initiator,
> +                         MAX_NODES - 1);
> +            return;
> +        }
> +
> +        numa_info[nodenr].initiator =3D node->initiator;
> +    }
>      numa_info[nodenr].present =3D true;
>      max_numa_nodeid =3D MAX(max_numa_nodeid, nodenr + 1);
>      ms->numa_state->num_nodes++;
> diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
> index ae9c41d02b..788cbec7a2 100644
> --- a/include/sysemu/numa.h
> +++ b/include/sysemu/numa.h
> @@ -18,6 +18,8 @@ struct NodeInfo {
>      uint64_t node_mem;
>      struct HostMemoryBackend *node_memdev;
>      bool present;
> +    bool has_cpu;
> +    uint16_t initiator;
>      uint8_t distance[MAX_NODES];
>  };
> =20
> @@ -33,6 +35,9 @@ struct NumaState {
>      /* Allow setting NUMA distance for different NUMA nodes */
>      bool have_numa_distance;
> =20
> +    /* Detect if HMAT support is enabled. */
> +    bool hmat_enabled;
> +
>      /* NUMA nodes information */
>      NodeInfo nodes[MAX_NODES];
>  };
> diff --git a/qapi/machine.json b/qapi/machine.json
> index ca26779f1a..f1b07b3486 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -463,6 +463,13 @@
>  # @memdev: memory backend object.  If specified for one node,
>  #          it must be specified for all nodes.
>  #
> +# @initiator: defined in ACPI 6.3 Chapter 5.2.27.3 Table 5-145,
> +#             points to the nodeid which has the memory controller
> +#             responsible for this NUMA node. This field provides
> +#             additional information as to the initiator node that
> +#             is closest (as in directly attached) to this node, and
> +#             therefore has the best performance (since 4.2)
> +#
>  # Since: 2.1
>  ##
>  { 'struct': 'NumaNodeOptions',
> @@ -470,7 +477,8 @@
>     '*nodeid': 'uint16',
>     '*cpus':   ['uint16'],
>     '*mem':    'size',
> -   '*memdev': 'str' }}
> +   '*memdev': 'str',
> +   '*initiator': 'uint16' }}
> =20
>  ##
>  # @NumaDistOptions:
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 996b6fba74..1f96399521 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -43,7 +43,8 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
>      "                suppress-vmdesc=3Don|off disables self-describing m=
igration (default=3Doff)\n"
>      "                nvdimm=3Don|off controls NVDIMM support (default=3D=
off)\n"
>      "                enforce-config-section=3Don|off enforce configurati=
on section migration (default=3Doff)\n"
> -    "                memory-encryption=3D@var{} memory encryption object=
 to use (default=3Dnone)\n",
> +    "                memory-encryption=3D@var{} memory encryption object=
 to use (default=3Dnone)\n"
> +    "                hmat=3Don|off controls ACPI HMAT support (default=
=3Doff)\n",
>      QEMU_ARCH_ALL)
>  STEXI
>  @item -machine [type=3D]@var{name}[,prop=3D@var{value}[,...]]
> @@ -103,6 +104,9 @@ NOTE: this parameter is deprecated. Please use @optio=
n{-global}
>  @option{migration.send-configuration}=3D@var{on|off} instead.
>  @item memory-encryption=3D@var{}
>  Memory encryption object to use. The default is none.
> +@item hmat=3Don|off
> +Enables or disables ACPI Heterogeneous Memory Attribute Table (HMAT) sup=
port.
> +The default is off.
>  @end table
>  ETEXI
> =20
> @@ -161,14 +165,14 @@ If any on the three values is given, the total numb=
er of CPUs @var{n} can be omi
>  ETEXI
> =20
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
> +@item -numa node[,mem=3D@var{size}][,cpus=3D@var{firstcpu}[-@var{lastcpu=
}]][,nodeid=3D@var{node}][,initiator=3D@var{initiator}]
> +@itemx -numa node[,memdev=3D@var{id}][,cpus=3D@var{firstcpu}[-@var{lastc=
pu}]][,nodeid=3D@var{node}][,initiator=3D@var{initiator}]
>  @itemx -numa dist,src=3D@var{source},dst=3D@var{destination},val=3D@var{=
distance}
>  @itemx -numa cpu,node-id=3D@var{node}[,socket-id=3D@var{x}][,core-id=3D@=
var{y}][,thread-id=3D@var{z}]
>  @findex -numa
> @@ -215,6 +219,27 @@ split equally between them.
>  @samp{mem} and @samp{memdev} are mutually exclusive. Furthermore,
>  if one node uses @samp{memdev}, all of them have to use it.
> =20
> +@samp{initiator} is an additional option that points to an @var{initiato=
r}
> +NUMA node that has best performance (the lowest latency or largest bandw=
idth)
> +to this NUMA @var{node}. Note that this option can be set only when
> +the machine property 'hmat' is set to 'on'.
> +
> +Following example creates a machine with 2 NUMA nodes, node 0 has CPU.
> +node 1 has only memory, and its initiator is node 0. Note that because
> +node 0 has CPU, by default the initiator of node 0 is itself and must be
> +itself.
> +@example
> +-machine hmat=3Don \
> +-m 2G,slots=3D2,maxmem=3D4G \
> +-object memory-backend-ram,size=3D1G,id=3Dm0 \
> +-object memory-backend-ram,size=3D1G,id=3Dm1 \
> +-numa node,nodeid=3D0,memdev=3Dm0 \
> +-numa node,nodeid=3D1,memdev=3Dm1,initiator=3D0 \
> +-smp 2,sockets=3D2,maxcpus=3D2  \
> +-numa cpu,node-id=3D0,socket-id=3D0 \
> +-numa cpu,node-id=3D0,socket-id=3D1
> +@end example
> +
>  @var{source} and @var{destination} are NUMA node IDs.
>  @var{distance} is the NUMA distance from @var{source} to @var{destinatio=
n}.
>  The distance from a node to itself is always 10. If any pair of nodes is


