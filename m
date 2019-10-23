Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3287ACA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 15:56:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E25C720679
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 15:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V2L2VoEo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E25C720679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNIzt-0006Wm-Ea
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 11:56:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40162)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iNIZM-0007Ji-OH
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:29:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iNIZK-0003Nq-Ha
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:29:04 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46308
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iNIZK-0003Ng-Dg
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:29:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571844542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MHTQpGI74b8/oA0QRYy5/0PHL/SRsovJ61XNt3Pw6f8=;
 b=V2L2VoEowXtthz/C05dH7P6BRel/eRae3T0wF1Z4M5qrPsk++UO2JNOdDOczereLCME+K4
 BzDCvlapcIy3CoK6d09g413Rqgu8MCNWEOsIY2ug3XwR/QbVc7jZzpQauHO3K7JrDkQcCK
 C4eE+f+N3qWlfQcJBAg6eWY7Nb5U4YI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-oH1Gnxv6OPeOTzfCvbejKQ-1; Wed, 23 Oct 2019 11:28:58 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 775CB476;
 Wed, 23 Oct 2019 15:28:57 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D6C1D5D6D0;
 Wed, 23 Oct 2019 15:28:55 +0000 (UTC)
Date: Wed, 23 Oct 2019 17:28:54 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Subject: Re: [PATCH v13 06/12] numa: Extend CLI to provide memory latency
 and bandwidth information
Message-ID: <20191023172854.42c495d5@redhat.com>
In-Reply-To: <20191020111125.27659-7-tao3.xu@intel.com>
References: <20191020111125.27659-1-tao3.xu@intel.com>
 <20191020111125.27659-7-tao3.xu@intel.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: oH1Gnxv6OPeOTzfCvbejKQ-1
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
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 jonathan.cameron@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 20 Oct 2019 19:11:19 +0800
Tao Xu <tao3.xu@intel.com> wrote:

> From: Liu Jingqi <jingqi.liu@intel.com>
>=20
> Add -numa hmat-lb option to provide System Locality Latency and
> Bandwidth Information. These memory attributes help to build
> System Locality Latency and Bandwidth Information Structure(s)
> in ACPI Heterogeneous Memory Attribute Table (HMAT).
>=20
> Signed-off-by: Liu Jingqi <jingqi.liu@intel.com>
> Signed-off-by: Tao Xu <tao3.xu@intel.com>
> ---
>=20
> Changes in v13:
>     - Reuse Garray to store the raw bandwidth and bandwidth data
>     - Calculate common base unit using range bitmap (Igor)
> ---
>  hw/core/numa.c        | 127 ++++++++++++++++++++++++++++++++++++++++++
>  include/sysemu/numa.h |  68 ++++++++++++++++++++++
>  qapi/machine.json     |  95 ++++++++++++++++++++++++++++++-
>  qemu-options.hx       |  49 +++++++++++++++-
>  4 files changed, 336 insertions(+), 3 deletions(-)
Below some comments on doc parts of the patch
(since I'm too familiar with the topic y now I can't properly review doc pa=
rts)

perhaps Eric and Markus can suggest a better way to describe new options.

[...]

> diff --git a/qapi/machine.json b/qapi/machine.json
> index f1b07b3486..9ca008810b 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -426,10 +426,12 @@
>  #
>  # @cpu: property based CPU(s) to node mapping (Since: 2.10)
>  #
> +# @hmat-lb: memory latency and bandwidth information (Since: 4.2)
> +#
>  # Since: 2.1
>  ##
>  { 'enum': 'NumaOptionsType',
> -  'data': [ 'node', 'dist', 'cpu' ] }
> +  'data': [ 'node', 'dist', 'cpu', 'hmat-lb' ] }
> =20
>  ##
>  # @NumaOptions:
> @@ -444,7 +446,8 @@
>    'data': {
>      'node': 'NumaNodeOptions',
>      'dist': 'NumaDistOptions',
> -    'cpu': 'NumaCpuOptions' }}
> +    'cpu': 'NumaCpuOptions',
> +    'hmat-lb': 'NumaHmatLBOptions' }}
> =20
>  ##
>  # @NumaNodeOptions:
> @@ -557,6 +560,94 @@
>     'base': 'CpuInstanceProperties',
>     'data' : {} }
> =20
> +##
> +# @HmatLBMemoryHierarchy:
> +#
> +# The memory hierarchy in the System Locality Latency
> +# and Bandwidth Information Structure of HMAT (Heterogeneous
> +# Memory Attribute Table)
> +#
> +# For more information of @HmatLBMemoryHierarchy see
> +# the chapter 5.2.27.4: Table 5-142: Field "Flags" of ACPI 6.3 spec.
> +#
> +# @memory: the structure represents the memory performance
> +#
> +# @first-level: first level memory of memory side cached memory
> +#
> +# @second-level: second level memory of memory side cached memory
> +#
> +# @third-level: third level memory of memory side cached memory
> +#
> +# Since: 4.2
> +##
> +{ 'enum': 'HmatLBMemoryHierarchy',
> +  'data': [ 'memory', 'first-level', 'second-level', 'third-level' ] }
> +
> +##
> +# @HmatLBDataType:
> +#
> +# Data type in the System Locality Latency
> +# and Bandwidth Information Structure of HMAT (Heterogeneous
> +# Memory Attribute Table)
> +#
> +# For more information of @HmatLBDataType see
> +# the chapter 5.2.27.4: Table 5-142:  Field "Data Type" of ACPI 6.3 spec=
.
> +#
> +# @access-latency: access latency (nanoseconds)
> +#
> +# @read-latency: read latency (nanoseconds)
> +#
> +# @write-latency: write latency (nanoseconds)
> +#
> +# @access-bandwidth: access bandwidth (MB/s)
> +#
> +# @read-bandwidth: read bandwidth (MB/s)
> +#
> +# @write-bandwidth: write bandwidth (MB/s)
I think units here are not appropriate, values stored in fields are
minimal base units only and nothing else (i.e. ps and B/s)

> +#
> +# Since: 4.2
> +##
> +{ 'enum': 'HmatLBDataType',
> +  'data': [ 'access-latency', 'read-latency', 'write-latency',
> +            'access-bandwidth', 'read-bandwidth', 'write-bandwidth' ] }
> +
> +##
> +# @NumaHmatLBOptions:
> +#
> +# Set the system locality latency and bandwidth information
> +# between Initiator and Target proximity Domains.
> +#
> +# For more information of @NumaHmatLBOptions see
> +# the chapter 5.2.27.4: Table 5-142 of ACPI 6.3 spec.
> +#
> +# @initiator: the Initiator Proximity Domain.
> +#
> +# @target: the Target Proximity Domain.
> +#
> +# @hierarchy: the Memory Hierarchy. Indicates the performance
> +#             of memory or side cache.
> +#
> +# @data-type: presents the type of data, access/read/write
> +#             latency or hit latency.

> +# @latency: the value of latency from @initiator to @target proximity do=
main,
> +#           the latency units are "ps(picosecond)", "ns(nanosecond)" or
> +#           "us(microsecond)".
> +#
> +# @bandwidth: the value of bandwidth between @initiator and @target prox=
imity
> +#             domain, the bandwidth units are "MB(/s)","GB(/s)" or "TB(/=
s)".
ditto

> +# Since: 4.2
> +##
> +{ 'struct': 'NumaHmatLBOptions',
> +    'data': {
> +    'initiator': 'uint16',
> +    'target': 'uint16',
> +    'hierarchy': 'HmatLBMemoryHierarchy',
> +    'data-type': 'HmatLBDataType',
> +    '*latency': 'time',
> +    '*bandwidth': 'size' }}
> +
>  ##
>  # @HostMemPolicy:
>  #
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 1f96399521..de97939f9a 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -168,16 +168,19 @@ DEF("numa", HAS_ARG, QEMU_OPTION_numa,
>      "-numa node[,mem=3Dsize][,cpus=3Dfirstcpu[-lastcpu]][,nodeid=3Dnode]=
[,initiator=3Dnode]\n"
>      "-numa node[,memdev=3Did][,cpus=3Dfirstcpu[-lastcpu]][,nodeid=3Dnode=
][,initiator=3Dnode]\n"
>      "-numa dist,src=3Dsource,dst=3Ddestination,val=3Ddistance\n"
> -    "-numa cpu,node-id=3Dnode[,socket-id=3Dx][,core-id=3Dy][,thread-id=
=3Dz]\n",
> +    "-numa cpu,node-id=3Dnode[,socket-id=3Dx][,core-id=3Dy][,thread-id=
=3Dz]\n"
> +    "-numa hmat-lb,initiator=3Dnode,target=3Dnode,hierarchy=3Dmemory|fir=
st-level|second-level|third-level,data-type=3Daccess-latency|read-latency|w=
rite-latency[,latency=3Dlat][,bandwidth=3Dbw]\n",
>      QEMU_ARCH_ALL)
>  STEXI
>  @item -numa node[,mem=3D@var{size}][,cpus=3D@var{firstcpu}[-@var{lastcpu=
}]][,nodeid=3D@var{node}][,initiator=3D@var{initiator}]
>  @itemx -numa node[,memdev=3D@var{id}][,cpus=3D@var{firstcpu}[-@var{lastc=
pu}]][,nodeid=3D@var{node}][,initiator=3D@var{initiator}]
>  @itemx -numa dist,src=3D@var{source},dst=3D@var{destination},val=3D@var{=
distance}
>  @itemx -numa cpu,node-id=3D@var{node}[,socket-id=3D@var{x}][,core-id=3D@=
var{y}][,thread-id=3D@var{z}]
> +@itemx -numa hmat-lb,initiator=3D@var{node},target=3D@var{node},hierarch=
y=3D@var{str},data-type=3D@var{str}[,latency=3D@var{lat}][,bandwidth=3D@var=
{bw}]
                                                                           =
   ^^^                 ^^^
Using the same 'str' for 2 different enums is confusing.
Suggest for 1st use 'level' and for the second just 'type'

>  @findex -numa
>  Define a NUMA node and assign RAM and VCPUs to it.
>  Set the NUMA distance from a source node to a destination node.
> +Set the ACPI Heterogeneous Memory Attributes for the given nodes.
> =20
>  Legacy VCPU assignment uses @samp{cpus} option where
>  @var{firstcpu} and @var{lastcpu} are CPU indexes. Each
> @@ -256,6 +259,50 @@ specified resources, it just assigns existing resour=
ces to NUMA
>  nodes. This means that one still has to use the @option{-m},
>  @option{-smp} options to allocate RAM and VCPUs respectively.
> =20
> +Use @samp{hmat-lb} to set System Locality Latency and Bandwidth Informat=
ion
> +between initiator and target NUMA nodes in ACPI Heterogeneous Attribute =
Memory Table (HMAT).
> +Initiator NUMA node can create memory requests, usually including one or=
 more processors.
s/including/it has/

> +Target NUMA node contains addressable memory.
> +
> +In @samp{hmat-lb} option, @var{node} are NUMA node IDs. @var{str} of 'hi=
erarchy'
> +is the memory hierarchy of the target NUMA node: if @var{str} is 'memory=
', the structure
> +represents the memory performance; if @var{str} is 'first-level|second-l=
evel|third-level',
> +this structure represents aggregated performance of memory side caches f=
or each domain.
> +@var{str} of 'data-type' is type of data represented by this structure i=
nstance:
> +if 'hierarchy' is 'memory', 'data-type' is 'access|read|write' latency(n=
anoseconds)
is nanoseconds is right here? Looking at previous patches default value of =
suffix-less
should be picoseconds. I'd just drop '(nanoseconds)'. User will use appropr=
iate suffix.

> +or 'access|read|write' bandwidth(MB/s) of the target memory; if 'hierarc=
hy' is
ditto (MB/s), probably should be Bytes/s for default suffix-less value
(well, I'm not sure how to express it better)

> +'first-level|second-level|third-level', 'data-type' is 'access|read|writ=
e' hit latency
> +or 'access|read|write' hit bandwidth of the target memory side cache.
> +
> +@var{lat} of 'latency' is latency value, the possible value and units ar=
e
> +NUM[ps|ns|us] (picosecond|nanosecond|microsecond), the recommended unit =
is 'ns'. @var{bw}
> +is bandwidth value, the possible value and units are NUM[M|G|T], mean th=
at

> +the bandwidth value are NUM MB/s, GB/s or TB/s. Note that max NUM is 655=
34,
> +if NUM is 0, means the corresponding latency or bandwidth information is=
 not provided.
> +And if input numbers without any unit, the latency unit will be 'ps' and=
 the bandwidth
> +will be MB/s.
 1st: above is applicable to both bw and lat values and should be documente=
d as such
 2nd: 'max NUM is 65534' when different suffixes is fleeting target,
      spec says that entry with 0xFFFF is unreachable, so how about documen=
ting
      unreachable value as 0xFFFFFFFFFFFFFFFF (then CLI parsing code will
      exclude it from range detection and acpi table building code translat=
e it
      to internal 0xFFFF it could fit into the tables)

> +For example, the following option assigns NUMA node 0 and 1. Node 0 has =
2 cpus and
> +a ram, node 1 has only a ram. The processors in node 0 access memory in =
node
> +0 with access-latency 5 nanoseconds, access-bandwidth is 200 MB/s;
> +The processors in NUMA node 0 access memory in NUMA node 1 with access-l=
atency 10
> +nanoseconds, access-bandwidth is 100 MB/s.
> +@example
> +-machine hmat=3Don \
> +-m 2G \
> +-object memory-backend-ram,size=3D1G,id=3Dm0 \
> +-object memory-backend-ram,size=3D1G,id=3Dm1 \
> +-smp 2 \
> +-numa node,nodeid=3D0,memdev=3Dm0 \
> +-numa node,nodeid=3D1,memdev=3Dm1,initiator=3D0 \
> +-numa cpu,node-id=3D0,socket-id=3D0 \
> +-numa cpu,node-id=3D0,socket-id=3D1 \
> +-numa hmat-lb,initiator=3D0,target=3D0,hierarchy=3Dmemory,data-type=3Dac=
cess-latency,latency=3D5ns \
> +-numa hmat-lb,initiator=3D0,target=3D0,hierarchy=3Dmemory,data-type=3Dac=
cess-bandwidth,bandwidth=3D200M \
> +-numa hmat-lb,initiator=3D0,target=3D1,hierarchy=3Dmemory,data-type=3Dac=
cess-latency,latency=3D10ns \
> +-numa hmat-lb,initiator=3D0,target=3D1,hierarchy=3Dmemory,data-type=3Dac=
cess-bandwidth,bandwidth=3D100M
> +@end example
> +
>  ETEXI
> =20
>  DEF("add-fd", HAS_ARG, QEMU_OPTION_add_fd,


