Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E5BC433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 06:31:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 781132171F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 06:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Cp5Pw6cg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 781132171F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvbxM-0003IS-PX
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 02:31:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44012)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hvbwX-0002ik-En
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 02:30:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hvbwT-00016w-KA
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 02:30:33 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:53879 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hvbwK-00011X-MK; Thu, 08 Aug 2019 02:30:22 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 463z515Gfhz9sNx; Thu,  8 Aug 2019 16:30:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1565245813;
 bh=5S1Z/dGxqEMng6N3GKpZfNMCIizpfPpUYZtrKhOBbvc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Cp5Pw6cgVbnJ+b6MP8BaAlg6i6WRaOANsWujLJVx0LGYcYCLQh4HPlcG6BEECLIHX
 jgo+4+ICcDKFnqIFCUs2QA75wZgD8BqW9+B2Me7Fd7ocXEw9/XtjnyZDYyR9KILzLY
 ENPDhU0V0+s8b7RjLOu9GmTfUQQ/XQ4xVy3eH3Jg=
Date: Wed, 7 Aug 2019 20:03:34 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Daniel Black <daniel@linux.ibm.com>
Message-ID: <20190807100334.GA5465@umbus.fritz.box>
References: <20190806112945.20234-1-daniel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
In-Reply-To: <20190806112945.20234-1-daniel@linux.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH v2] numa: numa nodeid need not be sequential
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Radoslaw Biernacki <radoslaw.biernacki@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Liu Jingqi <jingqi.liu@intel.com>, Tao Xu <tao3.xu@intel.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Leif Lindholm <leif.lindholm@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 "open list:sPAPR" <qemu-ppc@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 06, 2019 at 09:29:45PM +1000, Daniel Black wrote:
> Replace all node_id assumptions with lookups from machinestate->numa_stat=
e->nodes[]
> and remove aspects that assume a sequential numbering of nodes. This enab=
les
> non-sequential NUMA node number topoligies to be created.
>=20
> Default assignments of CPU->nodeid (get_default_cpu_node_id) now return
> a nodeid from the machinestate->numa_state->nodes[].
>=20
> x86 will use the node is as the Proximity Domain (which the
> Linux kernel will map down to sequential node numbers). Both HMAT and
> SLIT ACPI data are entered based on this nodeid. In Linux kernel
> output look at the SRAT/HMAT: and PXM: references in the kernel early boo=
t.
>=20
> Small enhancements where made to error messages to be more explicit
> about errors in node specification.
>=20
> CC: Tao Xu <tao3.xu@intel.com>
> CC: Liu Jingqi <jingqi.liu@intel.com>
> Signed-off-by: Daniel Black <daniel@linux.ibm.com>

I have no real opinion on whether this is a good idea overall.  But,
if we go for it then the ppc parts are

Acked-by: David Gibson <david@gibson.dropbear.id.au>

>=20
> ---
> Based-on: 20190614155626.27932-1-tao3.xu@intel.com
> ([PATCH RESEND v8 00/11] Build ACPI Heterogeneous Memory Attribute Table
> (HMAT))
>=20
> Test script:
>=20
> #!/bin/bash
> set -x -v
>=20
> QEMUHOME=3D${HOME}/repos/qemu/
> # optional but make it easy to install/run numactl --hardware
> #ALPINE_NET=3D""
> ALPINE_NET=3D"ip=3Ddhcp alpine_repo=3Dhttp://dl-cdn.alpinelinux.org/alpin=
e/edge/main/"
>=20
> ALPINE_HOME=3D${HOME}/repos/alpine/alpine-netboot-3.10.1-
>=20
> # x86 / armv7 - no CONFIG_NUMA=3Dy support in kernel
> # Kernel configs: https://git.alpinelinux.org/aports/tree/main/linux-vani=
lla/
> # s390x - no numa support in QEMU
> for ARCH in x86_64 aarch64 ppc64le
> do
>  if [ ! -d ${ALPINE_HOME}${ARCH} ]
>  then
>    mkdir ${ALPINE_HOME}${ARCH}
>    wget http://dl-cdn.alpinelinux.org/alpine/v3.10/releases/${ARCH}/alpin=
e-netboot-3.10.1-${ARCH}.tar.gz -O - | tar -zxf - -C ${ALPINE_HOME}${ARCH}
>  fi
> done
>=20
> if [ ! -x ${ALPINE_HOME}i386 ]
> then
>   ln -s ${ALPINE_HOME}x86 ${ALPINE_HOME}i386
> fi
>=20
> if [ ! -x ${ALPINE_HOME}arm ]
> then
>   ln -s ${ALPINE_HOME}armv7 ${ALPINE_HOME}arm
> fi
>=20
> if [ ! -x ${ALPINE_HOME}ppc64 ]
> then
>   ln -s ${ALPINE_HOME}ppc64le ${ALPINE_HOME}ppc64
> fi
>=20
> # Note "virtual" kernels don't have numa enabled
> run()
> {
>   NUMA=3D$1
>   ARCH=3D$2
>   ARGS=3D$3
>   CONSOLE=3D$4
>   #echo \
>   ${QEMUHOME}/${ARCH}-softmmu/qemu-system-${ARCH} \
>     ${ARGS} \
>     -kernel ${ALPINE_HOME}${ARCH}/boot/vmlinuz-vanilla  \
>     -initrd ${ALPINE_HOME}${ARCH}/boot/initramfs-vanilla \
>     -append "${CONSOLE} ${ALPINE_NET}" \
>     -m 2G \
>     ${NUMA}
>   echo
> }
>=20
> # This ends up as odd:
> # ends up with both CPUs are on same node
> # as 0 and 8 % 2 (nodes) are the same
> # in short - don't run legacy with gaps with
> # odd numa node numbers (like 0 and 8).
> run_legacy()
> {
>   run "-smp 2,cores=3D3,sockets=3D2,maxcpus=3D6 \
>        -numa node,mem=3D1G \
>        -numa node,mem=3D1G,nodeid=3D8 \
>        -numa dist,src=3D0,dst=3D8,val=3D21" "$@"
> }
>=20
> run_memdev_implicit_core()
> {
>   run "-smp cpus=3D6,maxcpus=3D8,cores=3D4,sockets=3D2 \
>        -object memory-backend-ram,id=3Dram0,size=3D1G \
>        -object memory-backend-ram,id=3Dram1,size=3D1G \
>        -numa node,memdev=3Dram0,nodeid=3D0 \
>        -numa node,memdev=3Dram1,nodeid=3D8 \
>        -numa dist,src=3D0,dst=3D8,val=3D21" "$@"
> }
>=20
> run_memdev_explicit_core()
> {
>   run "-smp cpus=3D6,maxcpus=3D8,cores=3D4,sockets=3D2 \
>        -object memory-backend-ram,id=3Dram0,size=3D1G \
>        -object memory-backend-ram,id=3Dram1,size=3D1G \
>        -numa node,memdev=3Dram0,cpus=3D0-3,nodeid=3D0 \
>        -numa node,memdev=3Dram1,cpus=3D4-7,nodeid=3D8 \
>        -numa dist,src=3D0,dst=3D8,val=3D21" "$@"
> }
>=20
> # hmat isn't added until kernel-5.2-rc1 and requires
> # CONFIG_ACPI_HMAT
> run_hmat_lb()
> {
>   run "-smp 2,sockets=3D2 \
>        -m 128M,slots=3D2,maxmem=3D1G \
>        -kernel ${HOME}/repos/linux/vmlinux \
>        -object memory-backend-ram,size=3D64M,id=3Dm0 \
>        -object memory-backend-ram,size=3D64M,id=3Dm1 \
>        -numa node,nodeid=3D3,memdev=3Dm0 \
>        -numa node,nodeid=3D4,memdev=3Dm1,initiator=3D3 \
>        -numa cpu,node-id=3D3,socket-id=3D0 \
>        -numa cpu,node-id=3D3,socket-id=3D1 \
>        -numa hmat-lb,initiator=3D3,target=3D3,hierarchy=3Dmemory,data-typ=
e=3Daccess-latency,base-lat=3D1000,latency=3D5 \
>        -numa hmat-lb,initiator=3D3,target=3D3,hierarchy=3Dmemory,data-typ=
e=3Daccess-bandwidth,base-bw=3D20,bandwidth=3D5 \
>        -numa hmat-lb,initiator=3D3,target=3D4,hierarchy=3Dmemory,data-typ=
e=3Daccess-latency,base-lat=3D1,latency=3D15 \
>        -numa hmat-lb,initiator=3D3,target=3D4,hierarchy=3Dmemory,data-typ=
e=3Daccess-bandwidth,base-bw=3D20,bandwidth=3D10 \
>        -numa hmat-cache,node-id=3D3,size=3D0x20000,total=3D1,level=3D1,as=
soc=3Ddirect,policy=3Dwrite-back,line=3D8 \
>        -numa hmat-cache,node-id=3D4,size=3D0x20000,total=3D1,level=3D1,as=
soc=3Ddirect,policy=3Dwrite-back,line=3D8" "$@"
> }
>=20
>=20
> for arch in x86_64 ppc64 aarch64 s390x; do killall qemu-system-$arch; done
> killall vncviewer
>=20
> # i386 Alpine kernels don't have NUMA
> #run_memdev_implicit_core i386 "-machine pc -nographic" console=3DttyS0
> # armv7 kernel's don't have NUMA
> #run_legacy arm "-machine virt -cpu cortex-a15 -nographic" console=3DttyA=
MA0
>=20
> # GOOD
> run_legacy x86_64 "-machine pc -nographic" console=3DttyS0
> run_memdev_implicit_core x86_64 "-machine pc -nographic" console=3DttyS0
> run_memdev_explicit_core x86_64 "-machine pc -nographic" console=3DttyS0
>=20
> run_hmat_lb x86_64 "-machine pc -nographic" console=3DttyS0
>=20
> # GOOD
> run_legacy aarch64 "-machine virt -cpu cortex-a57 -nographic" console=3Dt=
tyAMA0
> run_memdev_implicit_core  aarch64 "-machine virt -cpu cortex-a57 -nograph=
ic" console=3DttyAMA0
> run_memdev_explicit_core  aarch64 "-machine virt -cpu cortex-a57 -nograph=
ic" console=3DttyAMA0
>=20
> # PPC not doing numa distance (not a regression)
> (sleep 1; vncviewer :0) &
>=20
> # GOOD
>  run_legacy ppc64 "-machine pseries -cpu POWER9 -display vnc=3D:0" "numa=
=3Ddebug"
>  run_memdev_implicit_core ppc64 "-machine pseries -cpu POWER9 -display vn=
c=3D:0" "numa=3Ddebug"
>  run_memdev_explicit_core ppc64 "-machine pseries -cpu POWER9 -display vn=
c=3D:0" "numa=3Ddebug"
>=20
> # ON P8 ppc64le host:
> # run_memdev_implicit_core ppc64 "-machine pseries -cpu host -accel kvm -=
display vnc=3D:0" "numa=3Ddebug"
>=20
> # Couldn't boot Alpine ARM kernel on this machine type:
> # arm sbsa ref - appears to be a BMC so not really a numa target?
> # seems ok looking at the results of sbsa_ref_get_default_cpu_node_id how=
ever it display no
> # output when booting
>=20
> # run_legacy aarch64 "-machine sbsa-ref -nographic" console=3DttyAMA0
>=20
> # Then run:
> # sh -c 'apk add numactl-tools && numactl --hardware'
> #
> # alternately examine results in:
> # ls -la /sys/devices/system/node/node*/cpu*
> # more /sys/devices/system/node/node*/distance
> #
> # x86 node numbers are renumbered by kernel. To view
> # acpi mappings:
> # dmesg | egrep -A 2 '(HMAT|SRAT|PXM):'
> ---
>  hw/acpi/aml-build.c      |  31 ++++++---
>  hw/acpi/hmat.c           |  14 +++--
>  hw/arm/boot.c            |   3 +-
>  hw/arm/sbsa-ref.c        |   6 +-
>  hw/arm/virt-acpi-build.c |   3 +-
>  hw/arm/virt.c            |   6 +-
>  hw/core/machine.c        |  40 +++++++++---
>  hw/core/numa.c           | 132 +++++++++++++++++++--------------------
>  hw/i386/acpi-build.c     |  12 ++--
>  hw/i386/pc.c             |   2 +-
>  hw/ppc/spapr.c           |  12 ++--
>  include/sysemu/numa.h    |   2 +
>  12 files changed, 154 insertions(+), 109 deletions(-)
>=20
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index 26ccc1a3e2..512c76e3dd 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -1728,19 +1728,34 @@ void build_srat_memory(AcpiSratMemoryAffinity *nu=
mamem, uint64_t base,
>   */
>  void build_slit(GArray *table_data, BIOSLinker *linker, MachineState *ms)
>  {
> -    int slit_start, i, j;
> +    int slit_start, i, j, src, dst, largest;
>      slit_start =3D table_data->len;
>      int nb_numa_nodes =3D ms->numa_state->num_nodes;
> =20
>      acpi_data_push(table_data, sizeof(AcpiTableHeader));
> =20
> -    build_append_int_noprefix(table_data, nb_numa_nodes, 8);
> -    for (i =3D 0; i < nb_numa_nodes; i++) {
> -        for (j =3D 0; j < nb_numa_nodes; j++) {
> -            assert(ms->numa_state->nodes[i].distance[j]);
> -            build_append_int_noprefix(table_data,
> -                                      ms->numa_state->nodes[i].distance[=
j],
> -                                      1);
> +    for (largest =3D 0, i =3D 0; i < nb_numa_nodes; i++)
> +        if (largest < ms->numa_state->nodes[i].nodeid) {
> +            largest =3D ms->numa_state->nodes[i].nodeid;
> +        }
> +
> +    /* number of entries is largest + 1 as nodes start at 0 */
> +    build_append_int_noprefix(table_data, largest + 1, 8);
> +
> +    for (i =3D 0; i <=3D largest; i++) {
> +        src =3D find_numa(i, ms->numa_state);
> +        for (j =3D 0; j <=3D largest; j++) {
> +            dst =3D find_numa(j, ms->numa_state);
> +
> +            if (dst =3D=3D MAX_NODES || src =3D=3D MAX_NODES) {
> +                /* 255 is unreachable. Linux expects 10 in self-maps ent=
ries */
> +                build_append_int_noprefix(table_data,
> +                                          i =3D=3D j ? NUMA_DISTANCE_MIN=
 : 255, 1);
> +            } else {
> +                assert(ms->numa_state->nodes[src].distance[dst]);
> +                build_append_int_noprefix(table_data,
> +                    ms->numa_state->nodes[src].distance[dst], 1);
> +            }
>          }
>      }
> =20
> diff --git a/hw/acpi/hmat.c b/hw/acpi/hmat.c
> index 01a6552d51..0042be48d2 100644
> --- a/hw/acpi/hmat.c
> +++ b/hw/acpi/hmat.c
> @@ -73,7 +73,8 @@ static void build_hmat_mpda(GArray *table_data, uint16_=
t flags, int initiator,
>   */
>  static void build_hmat_lb(GArray *table_data, HMAT_LB_Info *hmat_lb,
>                            uint32_t num_initiator, uint32_t num_target,
> -                          uint32_t *initiator_pxm, int type)
> +                          uint32_t *initiator_pxm, int type,
> +                          NumaState *numa_state)
>  {
>      uint32_t s =3D num_initiator;
>      uint32_t t =3D num_target;
> @@ -114,12 +115,12 @@ static void build_hmat_lb(GArray *table_data, HMAT_=
LB_Info *hmat_lb,
> =20
>      /* Target Proximity Domain List */
>      for (i =3D 0; i < t; i++) {
> -        build_append_int_noprefix(table_data, i, 4);
> +        build_append_int_noprefix(table_data, numa_state->nodes[i].nodei=
d, 4);
>      }
> =20
>      /* Latency or Bandwidth Entries */
>      for (i =3D 0; i < s; i++) {
> -        m =3D initiator_pxm[i];
> +        m =3D find_numa(initiator_pxm[i], numa_state);
>          for (n =3D 0; n < t; n++) {
>              uint16_t entry;
> =20
> @@ -199,12 +200,13 @@ static void hmat_build_table_structs(GArray *table_=
data, NumaState *nstat)
>              flags |=3D HMAT_PROX_INIT_VALID;
>          }
> =20
> -        build_hmat_mpda(table_data, flags, nstat->nodes[i].initiator, i);
> +        build_hmat_mpda(table_data, flags, nstat->nodes[i].initiator,
> +                        nstat->nodes[i].nodeid);
>      }
> =20
>      for (i =3D 0; i < nstat->num_nodes; i++) {
>          if (nstat->nodes[i].has_cpu) {
> -            initiator_pxm[num_initiator++] =3D i;
> +            initiator_pxm[num_initiator++] =3D nstat->nodes[i].nodeid;
>          }
>      }
> =20
> @@ -220,7 +222,7 @@ static void hmat_build_table_structs(GArray *table_da=
ta, NumaState *nstat)
> =20
>              if (numa_hmat_lb) {
>                  build_hmat_lb(table_data, numa_hmat_lb, num_initiator,
> -                              nstat->num_nodes, initiator_pxm, type);
> +                              nstat->num_nodes, initiator_pxm, type, nst=
at);
>              }
>          }
>      }
> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> index 6472aa441e..1d92001930 100644
> --- a/hw/arm/boot.c
> +++ b/hw/arm/boot.c
> @@ -603,7 +603,8 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_i=
nfo *binfo,
>          for (i =3D 0; i < ms->numa_state->num_nodes; i++) {
>              mem_len =3D ms->numa_state->nodes[i].node_mem;
>              rc =3D fdt_add_memory_node(fdt, acells, mem_base,
> -                                     scells, mem_len, i);
> +                                     scells, mem_len,
> +                                     ms->numa_state->nodes[i].nodeid);
>              if (rc < 0) {
>                  fprintf(stderr, "couldn't add /memory@%"PRIx64" node\n",
>                          mem_base);
> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> index 3a243e6a53..f2c3a6fefa 100644
> --- a/hw/arm/sbsa-ref.c
> +++ b/hw/arm/sbsa-ref.c
> @@ -166,8 +166,8 @@ static void create_fdt(SBSAMachineState *sms)
>          for (i =3D 0; i < nb_numa_nodes; i++) {
>              for (j =3D 0; j < nb_numa_nodes; j++) {
>                  idx =3D (i * nb_numa_nodes + j) * 3;
> -                matrix[idx + 0] =3D cpu_to_be32(i);
> -                matrix[idx + 1] =3D cpu_to_be32(j);
> +                matrix[idx + 0] =3D cpu_to_be32(ms->numa_state->nodes[i]=
=2Enodeid);
> +                matrix[idx + 1] =3D cpu_to_be32(ms->numa_state->nodes[j]=
=2Enodeid);
>                  matrix[idx + 2] =3D
>                      cpu_to_be32(ms->numa_state->nodes[i].distance[j]);
>              }
> @@ -762,7 +762,7 @@ sbsa_ref_cpu_index_to_props(MachineState *ms, unsigne=
d cpu_index)
>  static int64_t
>  sbsa_ref_get_default_cpu_node_id(const MachineState *ms, int idx)
>  {
> -    return idx % ms->numa_state->num_nodes;
> +    return ms->numa_state->nodes[idx % ms->numa_state->num_nodes].nodeid;
>  }
> =20
>  static void sbsa_ref_instance_init(Object *obj)
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 89899ec4c1..0384339867 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -537,7 +537,8 @@ build_srat(GArray *table_data, BIOSLinker *linker, Vi=
rtMachineState *vms)
>          if (ms->numa_state->nodes[i].node_mem > 0) {
>              numamem =3D acpi_data_push(table_data, sizeof(*numamem));
>              build_srat_memory(numamem, mem_base,
> -                              ms->numa_state->nodes[i].node_mem, i,
> +                              ms->numa_state->nodes[i].node_mem,
> +                              ms->numa_state->nodes[i].nodeid,
>                                MEM_AFFINITY_ENABLED);
>              mem_base +=3D ms->numa_state->nodes[i].node_mem;
>          }
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 46f39e20bc..1a2db6447f 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -240,8 +240,8 @@ static void create_fdt(VirtMachineState *vms)
>          for (i =3D 0; i < nb_numa_nodes; i++) {
>              for (j =3D 0; j < nb_numa_nodes; j++) {
>                  idx =3D (i * nb_numa_nodes + j) * 3;
> -                matrix[idx + 0] =3D cpu_to_be32(i);
> -                matrix[idx + 1] =3D cpu_to_be32(j);
> +                matrix[idx + 0] =3D cpu_to_be32(ms->numa_state->nodes[i]=
=2Enodeid);
> +                matrix[idx + 1] =3D cpu_to_be32(ms->numa_state->nodes[j]=
=2Enodeid);
>                  matrix[idx + 2] =3D
>                      cpu_to_be32(ms->numa_state->nodes[i].distance[j]);
>              }
> @@ -1845,7 +1845,7 @@ virt_cpu_index_to_props(MachineState *ms, unsigned =
cpu_index)
> =20
>  static int64_t virt_get_default_cpu_node_id(const MachineState *ms, int =
idx)
>  {
> -    return idx % ms->numa_state->num_nodes;
> +    return ms->numa_state->nodes[idx % ms->numa_state->num_nodes].nodeid;
>  }
> =20
>  static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index b36d9a1ec8..faf6e05d84 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -643,11 +643,19 @@ void machine_set_cpu_numa_node(MachineState *machin=
e,
>      NodeInfo *numa_info =3D machine->numa_state->nodes;
>      bool match =3D false;
>      int i;
> +    int node_id =3D find_numa(props->node_id, machine->numa_state);
> =20
>      if (!mc->possible_cpu_arch_ids) {
>          error_setg(errp, "mapping of CPUs to NUMA node is not supported"=
);
>          return;
>      }
> +    if (node_id =3D=3D MAX_NODES) {
> +        if (props->has_node_id) {
> +            node_id =3D props->node_id;
> +        } else {
> +            node_id =3D machine->numa_state->num_nodes;
> +        }
> +    }
> =20
>      /* disabling node mapping is not supported, forbid it */
>      assert(props->has_node_id);
> @@ -711,15 +719,15 @@ void machine_set_cpu_numa_node(MachineState *machin=
e,
>          slot->props.node_id =3D props->node_id;
>          slot->props.has_node_id =3D props->has_node_id;
> =20
> -        if (numa_info[props->node_id].initiator_valid &&
> -            (props->node_id !=3D numa_info[props->node_id].initiator)) {
> +        if (numa_info[node_id].initiator_valid &&
> +            (props->node_id !=3D numa_info[node_id].initiator)) {
>              error_setg(errp, "The initiator of CPU NUMA node %" PRId64
>                         " should be itself.", props->node_id);
>              return;
>          }
> -        numa_info[props->node_id].initiator_valid =3D true;
> -        numa_info[props->node_id].has_cpu =3D true;
> -        numa_info[props->node_id].initiator =3D props->node_id;
> +        numa_info[node_id].initiator_valid =3D true;
> +        numa_info[node_id].has_cpu =3D true;
> +        numa_info[node_id].initiator =3D props->node_id;
>      }
> =20
>      if (!match) {
> @@ -1097,14 +1105,28 @@ static void machine_numa_finish_cpu_init(MachineS=
tate *machine)
>      }
> =20
>      for (i =3D 0; i < machine->numa_state->num_nodes; i++) {
> -        if (numa_info[i].initiator_valid &&
> -            !numa_info[numa_info[i].initiator].has_cpu) {
> -            error_report("The initiator-id %"PRIu16 " of NUMA node %d"
> -                         " does not exist.", numa_info[i].initiator, i);
> +        int node_id;
> +        if (!numa_info[i].initiator_valid) {
> +            continue;
> +        }
> +        node_id =3D find_numa(numa_info[i].initiator, machine->numa_stat=
e);
> +        if (node_id =3D=3D MAX_NODES) {
> +            error_report("The NUMA node %" PRIu16 " initiator node (id %=
" PRIu16
> +                         ") does not exist", numa_info[i].nodeid,
> +                         numa_info[i].initiator);
> +            error_printf("\n");
> +
> +            exit(1);
> +        }
> +        if (!numa_info[node_id].has_cpu) {
> +            error_report("The NUMA node %" PRIu16 " initiator node (id %=
" PRIu16
> +                         ") has no cpus", numa_info[i].nodeid,
> +                         numa_info[i].initiator);
>              error_printf("\n");
> =20
>              exit(1);
>          }
> +
>      }
> =20
>      if (s->len && !qtest_enabled()) {
> diff --git a/hw/core/numa.c b/hw/core/numa.c
> index 75db35ac19..50a156f39f 100644
> --- a/hw/core/numa.c
> +++ b/hw/core/numa.c
> @@ -48,9 +48,19 @@ QemuOptsList qemu_numa_opts =3D {
> =20
>  static int have_memdevs;
>  static int have_mem;
> -static int max_numa_nodeid; /* Highest specified NUMA node ID, plus one.
> -                             * For all nodes, nodeid < max_numa_nodeid
> -                             */
> +
> +int find_numa(uint16_t node, NumaState *numa_state)
> +{
> +    NodeInfo *numa_info =3D numa_state->nodes;
> +    int nb_numa_nodes =3D numa_state->num_nodes;
> +
> +    for (int i =3D 0; i < nb_numa_nodes; i++) {
> +        if (numa_info[i].present && numa_info[i].nodeid =3D=3D node) {
> +            return i;
> +        }
> +    }
> +    return MAX_NODES;
> +}
> =20
>  static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
>                              Error **errp)
> @@ -61,20 +71,18 @@ static void parse_numa_node(MachineState *ms, NumaNod=
eOptions *node,
>      MachineClass *mc =3D MACHINE_GET_CLASS(ms);
>      unsigned int max_cpus =3D ms->smp.max_cpus;
>      NodeInfo *numa_info =3D ms->numa_state->nodes;
> +    int nb_numa_nodes =3D ms->numa_state->num_nodes;
> =20
> -    if (node->has_nodeid) {
> -        nodenr =3D node->nodeid;
> -    } else {
> -        nodenr =3D ms->numa_state->num_nodes;
> -    }
> +    nodenr =3D ms->numa_state->num_nodes;
> =20
> -    if (nodenr >=3D MAX_NODES) {
> +    if (nb_numa_nodes >=3D MAX_NODES) {
>          error_setg(errp, "Max number of NUMA nodes reached: %"
>                     PRIu16 "", nodenr);
>          return;
>      }
> =20
> -    if (numa_info[nodenr].present) {
> +    if (node->has_nodeid &&
> +        find_numa(node->nodeid, ms->numa_state) !=3D MAX_NODES) {
>          error_setg(errp, "Duplicate NUMA nodeid: %" PRIu16, nodenr);
>          return;
>      }
> @@ -93,7 +101,7 @@ static void parse_numa_node(MachineState *ms, NumaNode=
Options *node,
>              return;
>          }
>          props =3D mc->cpu_index_to_instance_props(ms, cpus->value);
> -        props.node_id =3D nodenr;
> +        props.node_id =3D node->has_nodeid ? node->nodeid : nodenr;
>          props.has_node_id =3D true;
>          machine_set_cpu_numa_node(ms, &props, &err);
>          if (err) {
> @@ -143,26 +151,26 @@ static void parse_numa_node(MachineState *ms, NumaN=
odeOptions *node,
>          numa_info[nodenr].initiator =3D node->initiator;
>      }
>      numa_info[nodenr].present =3D true;
> -    max_numa_nodeid =3D MAX(max_numa_nodeid, nodenr + 1);
> +    numa_info[nodenr].nodeid =3D node->has_nodeid ? node->nodeid : nb_nu=
ma_nodes;
>      ms->numa_state->num_nodes++;
>  }
> =20
>  static
>  void parse_numa_distance(MachineState *ms, NumaDistOptions *dist, Error =
**errp)
>  {
> -    uint16_t src =3D dist->src;
> -    uint16_t dst =3D dist->dst;
> +    int src =3D find_numa(dist->src, ms->numa_state);
> +    int dst =3D find_numa(dist->dst, ms->numa_state);
>      uint8_t val =3D dist->val;
>      NodeInfo *numa_info =3D ms->numa_state->nodes;
> =20
> -    if (src >=3D MAX_NODES || dst >=3D MAX_NODES) {
> -        error_setg(errp, "Parameter '%s' expects an integer between 0 an=
d %d",
> -                   src >=3D MAX_NODES ? "src" : "dst", MAX_NODES - 1);
> +    if (src >=3D MAX_NODES || !numa_info[src].present) {
> +        error_setg(errp, "Source NUMA node is missing. "
> +                   "Please use '-numa node' option to declare it first."=
);
>          return;
>      }
> =20
> -    if (!numa_info[src].present || !numa_info[dst].present) {
> -        error_setg(errp, "Source/Destination NUMA node is missing. "
> +    if (dst >=3D MAX_NODES || !numa_info[dst].present) {
> +        error_setg(errp, "Destination NUMA node is missing. "
>                     "Please use '-numa node' option to declare it first."=
);
>          return;
>      }
> @@ -175,8 +183,8 @@ void parse_numa_distance(MachineState *ms, NumaDistOp=
tions *dist, Error **errp)
>      }
> =20
>      if (src =3D=3D dst && val !=3D NUMA_DISTANCE_MIN) {
> -        error_setg(errp, "Local distance of node %d should be %d.",
> -                   src, NUMA_DISTANCE_MIN);
> +        error_setg(errp, "Local distance of node %" PRIu16 " should be %=
d.",
> +                   dist->src, NUMA_DISTANCE_MIN);
>          return;
>      }
> =20
> @@ -187,9 +195,10 @@ void parse_numa_distance(MachineState *ms, NumaDistO=
ptions *dist, Error **errp)
>  void parse_numa_hmat_lb(MachineState *ms, NumaHmatLBOptions *node,
>                          Error **errp)
>  {
> -    int nb_numa_nodes =3D ms->numa_state->num_nodes;
>      NodeInfo *numa_info =3D ms->numa_state->nodes;
>      HMAT_LB_Info *hmat_lb =3D NULL;
> +    int initiator =3D find_numa(node->initiator, ms->numa_state);
> +    int target =3D find_numa(node->target, ms->numa_state);
> =20
>      if (node->data_type <=3D HMATLB_DATA_TYPE_WRITE_LATENCY) {
>          if (!node->has_latency) {
> @@ -225,26 +234,26 @@ void parse_numa_hmat_lb(MachineState *ms, NumaHmatL=
BOptions *node,
>          }
>      }
> =20
> -    if (node->initiator >=3D nb_numa_nodes) {
> +    if (initiator >=3D MAX_NODES) {
>          error_setg(errp, "Invalid initiator=3D%"
> -                   PRIu16 ", it should be less than %d.",
> -                   node->initiator, nb_numa_nodes);
> +                   PRIu16 ", not found.",
> +                   node->initiator);
>          return;
>      }
> -    if (!numa_info[node->initiator].has_cpu) {
> +    if (!numa_info[initiator].has_cpu) {
>          error_setg(errp, "Invalid initiator=3D%"
>                     PRIu16 ", it isn't an initiator proximity domain.",
>                     node->initiator);
>          return;
>      }
> =20
> -    if (node->target >=3D nb_numa_nodes) {
> +    if (target >=3D MAX_NODES) {
>          error_setg(errp, "Invalid target=3D%"
> -                   PRIu16 ", it should be less than %d.",
> -                   node->target, nb_numa_nodes);
> +                   PRIu16 ", not found",
> +                   node->target);
>          return;
>      }
> -    if (!numa_info[node->target].initiator_valid) {
> +    if (!numa_info[target].initiator_valid) {
>          error_setg(errp, "Invalid target=3D%"
>                     PRIu16 ", it hasn't a valid initiator proximity domai=
n.",
>                     node->target);
> @@ -257,7 +266,7 @@ void parse_numa_hmat_lb(MachineState *ms, NumaHmatLBO=
ptions *node,
>          if (!hmat_lb) {
>              hmat_lb =3D g_malloc0(sizeof(*hmat_lb));
>              ms->numa_state->hmat_lb[node->hierarchy][node->data_type] =
=3D hmat_lb;
> -        } else if (hmat_lb->latency[node->initiator][node->target]) {
> +        } else if (hmat_lb->latency[initiator][target]) {
>              error_setg(errp, "Duplicate configuration of the latency for=
 "
>                         "initiator=3D%" PRIu16 " and target=3D%" PRIu16 "=
=2E",
>                         node->initiator, node->target);
> @@ -269,7 +278,7 @@ void parse_numa_hmat_lb(MachineState *ms, NumaHmatLBO=
ptions *node,
>              hmat_lb->base_lat =3D node->base_lat;
>          }
> =20
> -        hmat_lb->latency[node->initiator][node->target] =3D node->latenc=
y;
> +        hmat_lb->latency[initiator][target] =3D node->latency;
>      }
> =20
>      if (node->has_bandwidth) {
> @@ -278,7 +287,7 @@ void parse_numa_hmat_lb(MachineState *ms, NumaHmatLBO=
ptions *node,
>          if (!hmat_lb) {
>              hmat_lb =3D g_malloc0(sizeof(*hmat_lb));
>              ms->numa_state->hmat_lb[node->hierarchy][node->data_type] =
=3D hmat_lb;
> -        } else if (hmat_lb->bandwidth[node->initiator][node->target]) {
> +        } else if (hmat_lb->bandwidth[initiator][target]) {
>              error_setg(errp, "Duplicate configuration of the bandwidth f=
or "
>                         "initiator=3D%" PRIu16 " and target=3D%" PRIu16 "=
=2E",
>                         node->initiator, node->target);
> @@ -295,7 +304,7 @@ void parse_numa_hmat_lb(MachineState *ms, NumaHmatLBO=
ptions *node,
>              }
>          }
> =20
> -        hmat_lb->bandwidth[node->initiator][node->target] =3D node->band=
width;
> +        hmat_lb->bandwidth[initiator][target] =3D node->bandwidth;
>      }
> =20
>      if (hmat_lb) {
> @@ -307,13 +316,13 @@ void parse_numa_hmat_lb(MachineState *ms, NumaHmatL=
BOptions *node,
>  void parse_numa_hmat_cache(MachineState *ms, NumaHmatCacheOptions *node,
>                             Error **errp)
>  {
> -    int nb_numa_nodes =3D ms->numa_state->num_nodes;
>      HMAT_Cache_Info *hmat_cache =3D NULL;
> +    int node_id =3D find_numa(node->node_id, ms->numa_state);
> =20
> -    if (node->node_id >=3D nb_numa_nodes) {
> +    if (node_id >=3D MAX_NODES) {
>          error_setg(errp, "Invalid node-id=3D%" PRIu32
> -                   ", it should be less than %d.",
> -                   node->node_id, nb_numa_nodes);
> +                   ", not found.",
> +                   node->node_id);
>          return;
>      }
> =20
> @@ -330,7 +339,7 @@ void parse_numa_hmat_cache(MachineState *ms, NumaHmat=
CacheOptions *node,
>                     node->level, node->total);
>          return;
>      }
> -    if (ms->numa_state->hmat_cache[node->node_id][node->level]) {
> +    if (ms->numa_state->hmat_cache[node_id][node->level]) {
>          error_setg(errp, "Duplicate configuration of the side cache for "
>                     "node-id=3D%" PRIu32 " and level=3D%" PRIu8 ".",
>                     node->node_id, node->level);
> @@ -338,15 +347,15 @@ void parse_numa_hmat_cache(MachineState *ms, NumaHm=
atCacheOptions *node,
>      }
> =20
>      if ((node->level > 1) &&
> -        ms->numa_state->hmat_cache[node->node_id][node->level - 1] &&
> +        ms->numa_state->hmat_cache[node_id][node->level - 1] &&
>          (node->size >=3D
> -            ms->numa_state->hmat_cache[node->node_id][node->level - 1]->=
size)) {
> +            ms->numa_state->hmat_cache[node_id][node->level - 1]->size))=
 {
>          error_setg(errp, "Invalid size=3D0x%" PRIx64
>                     ", the size of level=3D%" PRIu8
>                     " should be less than the size(0x%" PRIx64
>                     ") of level=3D%" PRIu8 ".",
>                     node->size, node->level,
> -                   ms->numa_state->hmat_cache[node->node_id]
> +                   ms->numa_state->hmat_cache[node_id]
>                                               [node->level - 1]->size,
>                     node->level - 1);
>          return;
> @@ -362,7 +371,7 @@ void parse_numa_hmat_cache(MachineState *ms, NumaHmat=
CacheOptions *node,
>      hmat_cache->write_policy =3D node->policy;
>      hmat_cache->line_size =3D node->line;
> =20
> -    ms->numa_state->hmat_cache[node->node_id][node->level] =3D hmat_cach=
e;
> +    ms->numa_state->hmat_cache[node_id][node->level] =3D hmat_cache;
>  }
> =20
>  void set_numa_options(MachineState *ms, NumaOptions *object, Error **err=
p)
> @@ -393,7 +402,7 @@ void set_numa_options(MachineState *ms, NumaOptions *=
object, Error **errp)
>              error_setg(&err, "Missing mandatory node-id property");
>              goto end;
>          }
> -        if (!ms->numa_state->nodes[object->u.cpu.node_id].present) {
> +        if (find_numa(object->u.cpu.node_id, ms->numa_state) =3D=3D MAX_=
NODES) {
>              error_setg(&err, "Invalid node-id=3D%" PRId64 ", NUMA node m=
ust be "
>                  "defined with -numa node,nodeid=3DID before it's used wi=
th "
>                  "-numa cpu,node-id=3DID", object->u.cpu.node_id);
> @@ -472,10 +481,11 @@ static void validate_numa_distance(MachineState *ms)
>              if (numa_info[src].distance[dst] =3D=3D 0 &&
>                  numa_info[dst].distance[src] =3D=3D 0) {
>                  if (src !=3D dst) {
> -                    error_report("The distance between node %d and %d is=
 "
> -                                 "missing, at least one distance value "
> -                                 "between each nodes should be provided.=
",
> -                                 src, dst);
> +                    error_report("The distance between node %" PRIu16
> +                                 " and %" PRIu16 " is missing, at least =
one "
> +                                 "distance value between each nodes shou=
ld be "
> +                                 "provided.",
> +                                 numa_info[src].nodeid, numa_info[dst].n=
odeid);
>                      exit(EXIT_FAILURE);
>                  }
>              }
> @@ -493,9 +503,11 @@ static void validate_numa_distance(MachineState *ms)
>          for (src =3D 0; src < nb_numa_nodes; src++) {
>              for (dst =3D 0; dst < nb_numa_nodes; dst++) {
>                  if (src !=3D dst && numa_info[src].distance[dst] =3D=3D =
0) {
> -                    error_report("At least one asymmetrical pair of "
> -                            "distances is given, please provide distance=
s "
> -                            "for both directions of all node pairs.");
> +                    error_report("At least one asymmetrical pair (%" PRI=
u16
> +                            ", %" PRIu16 ") of distances is given, pleas=
e "
> +                            "provide distances for both directions of al=
l node "
> +                            "pairs.",
> +                            numa_info[src].nodeid, numa_info[dst].nodeid=
);
>                      exit(EXIT_FAILURE);
>                  }
>              }
> @@ -587,27 +599,11 @@ void numa_complete_configuration(MachineState *ms)
>              parse_numa_node(ms, &node, &error_abort);
>      }
> =20
> -    assert(max_numa_nodeid <=3D MAX_NODES);
> -
> -    /* No support for sparse NUMA node IDs yet: */
> -    for (i =3D max_numa_nodeid - 1; i >=3D 0; i--) {
> -        /* Report large node IDs first, to make mistakes easier to spot =
*/
> -        if (!numa_info[i].present) {
> -            error_report("numa: Node ID missing: %d", i);
> -            exit(1);
> -        }
> -    }
> -
> -    /* This must be always true if all nodes are present: */
> -    assert(ms->numa_state->num_nodes =3D=3D max_numa_nodeid);
> +    assert(ms->numa_state->num_nodes <=3D MAX_NODES);
> =20
>      if (ms->numa_state->num_nodes > 0) {
>          uint64_t numa_total;
> =20
> -        if (ms->numa_state->num_nodes > MAX_NODES) {
> -            ms->numa_state->num_nodes =3D MAX_NODES;
> -        }
> -
>          /* If no memory size is given for any node, assume the default c=
ase
>           * and distribute the available memory equally across all nodes
>           */
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 90ad0dff99..f4a906c72e 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2361,6 +2361,7 @@ build_srat(GArray *table_data, BIOSLinker *linker, =
MachineState *machine)
>      numa_start =3D table_data->len;
> =20
>      for (i =3D 1; i < pcms->numa_nodes + 1; ++i) {
> +        int nodeid =3D machine->numa_state->nodes[i - 1].nodeid;
>          mem_base =3D next_base;
>          mem_len =3D pcms->node_mem[i - 1];
>          next_base =3D mem_base + mem_len;
> @@ -2371,7 +2372,7 @@ build_srat(GArray *table_data, BIOSLinker *linker, =
MachineState *machine)
>              mem_len -=3D next_base - HOLE_640K_START;
>              if (mem_len > 0) {
>                  numamem =3D acpi_data_push(table_data, sizeof *numamem);
> -                build_srat_memory(numamem, mem_base, mem_len, i - 1,
> +                build_srat_memory(numamem, mem_base, mem_len, nodeid,
>                                    MEM_AFFINITY_ENABLED);
>              }
> =20
> @@ -2390,7 +2391,7 @@ build_srat(GArray *table_data, BIOSLinker *linker, =
MachineState *machine)
>              mem_len -=3D next_base - pcms->below_4g_mem_size;
>              if (mem_len > 0) {
>                  numamem =3D acpi_data_push(table_data, sizeof *numamem);
> -                build_srat_memory(numamem, mem_base, mem_len, i - 1,
> +                build_srat_memory(numamem, mem_base, mem_len, nodeid,
>                                    MEM_AFFINITY_ENABLED);
>              }
>              mem_base =3D 1ULL << 32;
> @@ -2400,7 +2401,7 @@ build_srat(GArray *table_data, BIOSLinker *linker, =
MachineState *machine)
> =20
>          if (mem_len > 0) {
>              numamem =3D acpi_data_push(table_data, sizeof *numamem);
> -            build_srat_memory(numamem, mem_base, mem_len, i - 1,
> +            build_srat_memory(numamem, mem_base, mem_len, nodeid,
>                                MEM_AFFINITY_ENABLED);
>          }
>      }
> @@ -2421,8 +2422,9 @@ build_srat(GArray *table_data, BIOSLinker *linker, =
MachineState *machine)
>      if (hotplugabble_address_space_size) {
>          numamem =3D acpi_data_push(table_data, sizeof *numamem);
>          build_srat_memory(numamem, machine->device_memory->base,
> -                          hotplugabble_address_space_size, pcms->numa_no=
des - 1,
> -                          MEM_AFFINITY_HOTPLUGGABLE | MEM_AFFINITY_ENABL=
ED);
> +            hotplugabble_address_space_size,
> +            machine->numa_state->nodes[pcms->numa_nodes - 1].nodeid,
> +            MEM_AFFINITY_HOTPLUGGABLE | MEM_AFFINITY_ENABLED);
>      }
> =20
>      build_header(linker, table_data,
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index c3f5a70a56..5b8db454b7 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -2850,7 +2850,7 @@ static int64_t pc_get_default_cpu_node_id(const Mac=
hineState *ms, int idx)
>     x86_topo_ids_from_apicid(ms->possible_cpus->cpus[idx].arch_id,
>                              pcms->smp_dies, ms->smp.cores,
>                              ms->smp.threads, &topo);
> -   return topo.pkg_id % ms->numa_state->num_nodes;
> +   return ms->numa_state->nodes[topo.pkg_id % ms->numa_state->num_nodes]=
=2Enodeid;
>  }
> =20
>  static const CPUArchIdList *pc_possible_cpu_arch_ids(MachineState *ms)
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index f607ca567b..ef4802698c 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -424,7 +424,8 @@ static int spapr_populate_memory(SpaprMachineState *s=
papr, void *fdt)
>          if (!mem_start) {
>              /* spapr_machine_init() checks for rma_size <=3D node0_size
>               * already */
> -            spapr_populate_memory_node(fdt, i, 0, spapr->rma_size);
> +            spapr_populate_memory_node(fdt, nodes[i].nodeid, 0,
> +                                       spapr->rma_size);
>              mem_start +=3D spapr->rma_size;
>              node_size -=3D spapr->rma_size;
>          }
> @@ -436,7 +437,8 @@ static int spapr_populate_memory(SpaprMachineState *s=
papr, void *fdt)
>                  sizetmp =3D 1ULL << ctzl(mem_start);
>              }
> =20
> -            spapr_populate_memory_node(fdt, i, mem_start, sizetmp);
> +            spapr_populate_memory_node(fdt, nodes[i].nodeid, mem_start,
> +                                       sizetmp);
>              node_size -=3D sizetmp;
>              mem_start +=3D sizetmp;
>          }
> @@ -2543,7 +2545,8 @@ static void spapr_validate_node_memory(MachineState=
 *machine, Error **errp)
>              error_setg(errp,
>                         "Node %d memory size 0x%" PRIx64
>                         " is not aligned to %" PRIu64 " MiB",
> -                       i, machine->numa_state->nodes[i].node_mem,
> +                       machine->numa_state->nodes[i].nodeid,
> +                       machine->numa_state->nodes[i].node_mem,
>                         SPAPR_MEMORY_BLOCK_SIZE / MiB);
>              return;
>          }
> @@ -4140,7 +4143,8 @@ spapr_cpu_index_to_props(MachineState *machine, uns=
igned cpu_index)
> =20
>  static int64_t spapr_get_default_cpu_node_id(const MachineState *ms, int=
 idx)
>  {
> -    return idx / ms->smp.cores % ms->numa_state->num_nodes;
> +    return ms->numa_state->nodes[
> +        idx / ms->smp.cores % ms->numa_state->num_nodes].nodeid;
>  }
> =20
>  static const CPUArchIdList *spapr_possible_cpu_arch_ids(MachineState *ma=
chine)
> diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
> index 9009bbdee3..7474f2c5b6 100644
> --- a/include/sysemu/numa.h
> +++ b/include/sysemu/numa.h
> @@ -13,6 +13,7 @@ struct NodeInfo {
>      bool has_cpu;
>      bool initiator_valid;
>      uint16_t initiator;
> +    uint16_t nodeid;
>      uint8_t distance[MAX_NODES];
>  };
> =20
> @@ -39,6 +40,7 @@ struct NumaState {
>  };
>  typedef struct NumaState NumaState;
> =20
> +int find_numa(uint16_t node, NumaState *numa_state);
>  void set_numa_options(MachineState *ms, NumaOptions *object, Error **err=
p);
>  void parse_numa_opts(MachineState *ms);
>  void parse_numa_hmat_lb(MachineState *ms, NumaHmatLBOptions *node,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1KofMACgkQbDjKyiDZ
s5LDng/9EQTXuJElIo8nzWc1IhE8U8LJOijkW0VJAh1xq/UpWz1M45K43qdsDPz/
+btfL7cE1MAkR/Uh9lWRX8W99+m+JnLPBZucAmdZ7OmI9/pnThvAt1LMXGD7GjZs
ImOoZ9pHCHu18m372cbhXDMwjDp+/yFkqfwkKHaWJL6k1HKs6Fb38xagun7dFJA7
P5myUG44NFQZT0cd6hEFU/ruSZ2z2/ICTjBzynpxGArLT+tVwifHQCo0bAe5Sv6h
kQ4/mxDZe6u4RXfEzOjrntD+BN+9/LTHY8H91wHwJ5r5mOfP2ncrOHEOht8sVqZP
IsHcvopQzvTxe9po8MZ6heslM0EWfVmYrpizdMLKXfYMzQVQBjLcwIxDoUW+Glqp
BF9PtiBFfgFZ+Mg1Nx/oqus/OpEL303NJjnUhbOxh1OI+jiK8wZxx4PzT/1qa3PC
qwSzt0NPbLhoAm4uv8vUbaUwrcbjV11Skj0Euv8yj+YTFoCPUxETMwaEV++mHN26
VTyeROGAoFmDKWvIyShijP5XluR8qwoHXa/WzZ47fSlxs0Z5bmzvQJlD4rO4+KcC
WGL7CsLnXTEoxmo5QbRCGStQ0jn7nZrxkq9+gxwx/KbqBmpKtvB+bC1jFaVpQAnR
PbqaELxKO+GneL7sGxb5+1s3wd6qCZV7jj5KWIBG/O6B751OPtk=
=C039
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--

