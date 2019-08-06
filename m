Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB3EC433FF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 11:37:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 878902089E
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 11:37:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 878902089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huxlz-0002Wd-PZ
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 07:36:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54620)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1huxlK-0001cb-Bj
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 07:36:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1huxlG-0000Nx-Ox
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 07:36:18 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40315)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1huxlG-0000ND-Fe
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 07:36:14 -0400
Received: by mail-qk1-f196.google.com with SMTP id s145so62559401qke.7
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2019 04:36:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=J0zQPTbJ0fKX/sYX0Prtz05NlpASNQ7x3ck/f+6OX4o=;
 b=TEvyPrXABC5oahpvnsfSKncSwdr1uApF7dfgPDNXOWyZiAhLu8QYmJbljPf7Km3bD9
 UywmKjou+2T38+M9L9WQNS1qHw9opj6N9TlIMDgpoRtyPfPMWZ8Rw8Az5FZhnWFnIuel
 kpuRUYiekunJz4ByZnXcCFTcDny9ad1XObzHCyTCBhlID7EYUYX0YZkBamoIY8qkz2yl
 HrSQMKokAEPL0cQw6TEOeQ14qK6uZGDMjKQurjUJ/p4yXGUN0KvKSVAft44VFUkS4YGT
 1znlQNZnzCQ/fu4CxVOu20zlzwzGKDP/csOfsMbwIip+xIpWbRdO0yy2BW063kcQXQYa
 xFPg==
X-Gm-Message-State: APjAAAVafNRZ/uHd/NEY1ruAt5Au7zRAxb7yKC1XBdZuwqtbqmUNWs8v
 yEFoHuVnhU7zVJCmVevWqto1TA==
X-Google-Smtp-Source: APXvYqwCDqzTbm1OtXfNuDlHwSkfwTxYr3hhwoAwutXlLfSEqKMLfOE94s8hbvJoL+sxImda/85ibQ==
X-Received: by 2002:a37:4dc6:: with SMTP id a189mr2659799qkb.41.1565091373267; 
 Tue, 06 Aug 2019 04:36:13 -0700 (PDT)
Received: from redhat.com ([147.234.38.1])
 by smtp.gmail.com with ESMTPSA id c45sm44524044qte.70.2019.08.06.04.36.07
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 06 Aug 2019 04:36:12 -0700 (PDT)
Date: Tue, 6 Aug 2019 07:36:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Black <daniel@linux.ibm.com>
Message-ID: <20190806073254-mutt-send-email-mst@kernel.org>
References: <20190806112945.20234-1-daniel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806112945.20234-1-daniel@linux.ibm.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.222.196
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
 Eduardo Habkost <ehabkost@redhat.com>, Liu Jingqi <jingqi.liu@intel.com>,
 Tao Xu <tao3.xu@intel.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Leif Lindholm <leif.lindholm@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 "open list:sPAPR" <qemu-ppc@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 06, 2019 at 09:29:45PM +1000, Daniel Black wrote:
> Replace all node_id assumptions with lookups from machinestate->numa_state->nodes[]
> and remove aspects that assume a sequential numbering of nodes. This enables
> non-sequential NUMA node number topoligies to be created.
> 
> Default assignments of CPU->nodeid (get_default_cpu_node_id) now return
> a nodeid from the machinestate->numa_state->nodes[].
> 
> x86 will use the node is as the Proximity Domain (which the
> Linux kernel will map down to sequential node numbers). Both HMAT and
> SLIT ACPI data are entered based on this nodeid. In Linux kernel
> output look at the SRAT/HMAT: and PXM: references in the kernel early boot.
> 
> Small enhancements where made to error messages to be more explicit
> about errors in node specification.
> 
> CC: Tao Xu <tao3.xu@intel.com>
> CC: Liu Jingqi <jingqi.liu@intel.com>
> Signed-off-by: Daniel Black <daniel@linux.ibm.com>
> 
> ---
> Based-on: 20190614155626.27932-1-tao3.xu@intel.com
> ([PATCH RESEND v8 00/11] Build ACPI Heterogeneous Memory Attribute Table
> (HMAT))
> 
> Test script:
> 
> #!/bin/bash
> set -x -v
> 
> QEMUHOME=${HOME}/repos/qemu/
> # optional but make it easy to install/run numactl --hardware
> #ALPINE_NET=""
> ALPINE_NET="ip=dhcp alpine_repo=http://dl-cdn.alpinelinux.org/alpine/edge/main/"
> 
> ALPINE_HOME=${HOME}/repos/alpine/alpine-netboot-3.10.1-
> 
> # x86 / armv7 - no CONFIG_NUMA=y support in kernel
> # Kernel configs: https://git.alpinelinux.org/aports/tree/main/linux-vanilla/
> # s390x - no numa support in QEMU
> for ARCH in x86_64 aarch64 ppc64le
> do
>  if [ ! -d ${ALPINE_HOME}${ARCH} ]
>  then
>    mkdir ${ALPINE_HOME}${ARCH}
>    wget http://dl-cdn.alpinelinux.org/alpine/v3.10/releases/${ARCH}/alpine-netboot-3.10.1-${ARCH}.tar.gz -O - | tar -zxf - -C ${ALPINE_HOME}${ARCH}
>  fi
> done
> 
> if [ ! -x ${ALPINE_HOME}i386 ]
> then
>   ln -s ${ALPINE_HOME}x86 ${ALPINE_HOME}i386
> fi
> 
> if [ ! -x ${ALPINE_HOME}arm ]
> then
>   ln -s ${ALPINE_HOME}armv7 ${ALPINE_HOME}arm
> fi
> 
> if [ ! -x ${ALPINE_HOME}ppc64 ]
> then
>   ln -s ${ALPINE_HOME}ppc64le ${ALPINE_HOME}ppc64
> fi
> 
> # Note "virtual" kernels don't have numa enabled
> run()
> {
>   NUMA=$1
>   ARCH=$2
>   ARGS=$3
>   CONSOLE=$4
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
> 
> # This ends up as odd:
> # ends up with both CPUs are on same node
> # as 0 and 8 % 2 (nodes) are the same
> # in short - don't run legacy with gaps with
> # odd numa node numbers (like 0 and 8).
> run_legacy()
> {
>   run "-smp 2,cores=3,sockets=2,maxcpus=6 \
>        -numa node,mem=1G \
>        -numa node,mem=1G,nodeid=8 \
>        -numa dist,src=0,dst=8,val=21" "$@"
> }
> 
> run_memdev_implicit_core()
> {
>   run "-smp cpus=6,maxcpus=8,cores=4,sockets=2 \
>        -object memory-backend-ram,id=ram0,size=1G \
>        -object memory-backend-ram,id=ram1,size=1G \
>        -numa node,memdev=ram0,nodeid=0 \
>        -numa node,memdev=ram1,nodeid=8 \
>        -numa dist,src=0,dst=8,val=21" "$@"
> }
> 
> run_memdev_explicit_core()
> {
>   run "-smp cpus=6,maxcpus=8,cores=4,sockets=2 \
>        -object memory-backend-ram,id=ram0,size=1G \
>        -object memory-backend-ram,id=ram1,size=1G \
>        -numa node,memdev=ram0,cpus=0-3,nodeid=0 \
>        -numa node,memdev=ram1,cpus=4-7,nodeid=8 \
>        -numa dist,src=0,dst=8,val=21" "$@"
> }
> 
> # hmat isn't added until kernel-5.2-rc1 and requires
> # CONFIG_ACPI_HMAT
> run_hmat_lb()
> {
>   run "-smp 2,sockets=2 \
>        -m 128M,slots=2,maxmem=1G \
>        -kernel ${HOME}/repos/linux/vmlinux \
>        -object memory-backend-ram,size=64M,id=m0 \
>        -object memory-backend-ram,size=64M,id=m1 \
>        -numa node,nodeid=3,memdev=m0 \
>        -numa node,nodeid=4,memdev=m1,initiator=3 \
>        -numa cpu,node-id=3,socket-id=0 \
>        -numa cpu,node-id=3,socket-id=1 \
>        -numa hmat-lb,initiator=3,target=3,hierarchy=memory,data-type=access-latency,base-lat=1000,latency=5 \
>        -numa hmat-lb,initiator=3,target=3,hierarchy=memory,data-type=access-bandwidth,base-bw=20,bandwidth=5 \
>        -numa hmat-lb,initiator=3,target=4,hierarchy=memory,data-type=access-latency,base-lat=1,latency=15 \
>        -numa hmat-lb,initiator=3,target=4,hierarchy=memory,data-type=access-bandwidth,base-bw=20,bandwidth=10 \
>        -numa hmat-cache,node-id=3,size=0x20000,total=1,level=1,assoc=direct,policy=write-back,line=8 \
>        -numa hmat-cache,node-id=4,size=0x20000,total=1,level=1,assoc=direct,policy=write-back,line=8" "$@"
> }
> 
> 
> for arch in x86_64 ppc64 aarch64 s390x; do killall qemu-system-$arch; done
> killall vncviewer
> 
> # i386 Alpine kernels don't have NUMA
> #run_memdev_implicit_core i386 "-machine pc -nographic" console=ttyS0
> # armv7 kernel's don't have NUMA
> #run_legacy arm "-machine virt -cpu cortex-a15 -nographic" console=ttyAMA0
> 
> # GOOD
> run_legacy x86_64 "-machine pc -nographic" console=ttyS0
> run_memdev_implicit_core x86_64 "-machine pc -nographic" console=ttyS0
> run_memdev_explicit_core x86_64 "-machine pc -nographic" console=ttyS0
> 
> run_hmat_lb x86_64 "-machine pc -nographic" console=ttyS0
> 
> # GOOD
> run_legacy aarch64 "-machine virt -cpu cortex-a57 -nographic" console=ttyAMA0
> run_memdev_implicit_core  aarch64 "-machine virt -cpu cortex-a57 -nographic" console=ttyAMA0
> run_memdev_explicit_core  aarch64 "-machine virt -cpu cortex-a57 -nographic" console=ttyAMA0
> 
> # PPC not doing numa distance (not a regression)
> (sleep 1; vncviewer :0) &
> 
> # GOOD
>  run_legacy ppc64 "-machine pseries -cpu POWER9 -display vnc=:0" "numa=debug"
>  run_memdev_implicit_core ppc64 "-machine pseries -cpu POWER9 -display vnc=:0" "numa=debug"
>  run_memdev_explicit_core ppc64 "-machine pseries -cpu POWER9 -display vnc=:0" "numa=debug"
> 
> # ON P8 ppc64le host:
> # run_memdev_implicit_core ppc64 "-machine pseries -cpu host -accel kvm -display vnc=:0" "numa=debug"
> 
> # Couldn't boot Alpine ARM kernel on this machine type:
> # arm sbsa ref - appears to be a BMC so not really a numa target?
> # seems ok looking at the results of sbsa_ref_get_default_cpu_node_id however it display no
> # output when booting
> 
> # run_legacy aarch64 "-machine sbsa-ref -nographic" console=ttyAMA0
> 
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
> 
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index 26ccc1a3e2..512c76e3dd 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -1728,19 +1728,34 @@ void build_srat_memory(AcpiSratMemoryAffinity *numamem, uint64_t base,
>   */
>  void build_slit(GArray *table_data, BIOSLinker *linker, MachineState *ms)
>  {
> -    int slit_start, i, j;
> +    int slit_start, i, j, src, dst, largest;
>      slit_start = table_data->len;
>      int nb_numa_nodes = ms->numa_state->num_nodes;
>  
>      acpi_data_push(table_data, sizeof(AcpiTableHeader));
>  
> -    build_append_int_noprefix(table_data, nb_numa_nodes, 8);
> -    for (i = 0; i < nb_numa_nodes; i++) {
> -        for (j = 0; j < nb_numa_nodes; j++) {
> -            assert(ms->numa_state->nodes[i].distance[j]);
> -            build_append_int_noprefix(table_data,
> -                                      ms->numa_state->nodes[i].distance[j],
> -                                      1);
> +    for (largest = 0, i = 0; i < nb_numa_nodes; i++)
> +        if (largest < ms->numa_state->nodes[i].nodeid) {
> +            largest = ms->numa_state->nodes[i].nodeid;
> +        }

Missing {} in the for loop.

> +
> +    /* number of entries is largest + 1 as nodes start at 0 */
> +    build_append_int_noprefix(table_data, largest + 1, 8);
> +
> +    for (i = 0; i <= largest; i++) {
> +        src = find_numa(i, ms->numa_state);
> +        for (j = 0; j <= largest; j++) {
> +            dst = find_numa(j, ms->numa_state);
> +
> +            if (dst == MAX_NODES || src == MAX_NODES) {
> +                /* 255 is unreachable. Linux expects 10 in self-maps entries */
> +                build_append_int_noprefix(table_data,
> +                                          i == j ? NUMA_DISTANCE_MIN : 255, 1);
> +            } else {
> +                assert(ms->numa_state->nodes[src].distance[dst]);
> +                build_append_int_noprefix(table_data,
> +                    ms->numa_state->nodes[src].distance[dst], 1);
> +            }
>          }
>      }
>  
> diff --git a/hw/acpi/hmat.c b/hw/acpi/hmat.c
> index 01a6552d51..0042be48d2 100644
> --- a/hw/acpi/hmat.c
> +++ b/hw/acpi/hmat.c
> @@ -73,7 +73,8 @@ static void build_hmat_mpda(GArray *table_data, uint16_t flags, int initiator,
>   */
>  static void build_hmat_lb(GArray *table_data, HMAT_LB_Info *hmat_lb,
>                            uint32_t num_initiator, uint32_t num_target,
> -                          uint32_t *initiator_pxm, int type)
> +                          uint32_t *initiator_pxm, int type,
> +                          NumaState *numa_state)
>  {
>      uint32_t s = num_initiator;
>      uint32_t t = num_target;
> @@ -114,12 +115,12 @@ static void build_hmat_lb(GArray *table_data, HMAT_LB_Info *hmat_lb,
>  
>      /* Target Proximity Domain List */
>      for (i = 0; i < t; i++) {
> -        build_append_int_noprefix(table_data, i, 4);
> +        build_append_int_noprefix(table_data, numa_state->nodes[i].nodeid, 4);
>      }
>  
>      /* Latency or Bandwidth Entries */
>      for (i = 0; i < s; i++) {
> -        m = initiator_pxm[i];
> +        m = find_numa(initiator_pxm[i], numa_state);
>          for (n = 0; n < t; n++) {
>              uint16_t entry;
>  
> @@ -199,12 +200,13 @@ static void hmat_build_table_structs(GArray *table_data, NumaState *nstat)
>              flags |= HMAT_PROX_INIT_VALID;
>          }
>  
> -        build_hmat_mpda(table_data, flags, nstat->nodes[i].initiator, i);
> +        build_hmat_mpda(table_data, flags, nstat->nodes[i].initiator,
> +                        nstat->nodes[i].nodeid);
>      }
>  
>      for (i = 0; i < nstat->num_nodes; i++) {
>          if (nstat->nodes[i].has_cpu) {
> -            initiator_pxm[num_initiator++] = i;
> +            initiator_pxm[num_initiator++] = nstat->nodes[i].nodeid;
>          }
>      }
>  
> @@ -220,7 +222,7 @@ static void hmat_build_table_structs(GArray *table_data, NumaState *nstat)
>  
>              if (numa_hmat_lb) {
>                  build_hmat_lb(table_data, numa_hmat_lb, num_initiator,
> -                              nstat->num_nodes, initiator_pxm, type);
> +                              nstat->num_nodes, initiator_pxm, type, nstat);
>              }
>          }
>      }
> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> index 6472aa441e..1d92001930 100644
> --- a/hw/arm/boot.c
> +++ b/hw/arm/boot.c
> @@ -603,7 +603,8 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
>          for (i = 0; i < ms->numa_state->num_nodes; i++) {
>              mem_len = ms->numa_state->nodes[i].node_mem;
>              rc = fdt_add_memory_node(fdt, acells, mem_base,
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
>          for (i = 0; i < nb_numa_nodes; i++) {
>              for (j = 0; j < nb_numa_nodes; j++) {
>                  idx = (i * nb_numa_nodes + j) * 3;
> -                matrix[idx + 0] = cpu_to_be32(i);
> -                matrix[idx + 1] = cpu_to_be32(j);
> +                matrix[idx + 0] = cpu_to_be32(ms->numa_state->nodes[i].nodeid);
> +                matrix[idx + 1] = cpu_to_be32(ms->numa_state->nodes[j].nodeid);
>                  matrix[idx + 2] =
>                      cpu_to_be32(ms->numa_state->nodes[i].distance[j]);
>              }
> @@ -762,7 +762,7 @@ sbsa_ref_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
>  static int64_t
>  sbsa_ref_get_default_cpu_node_id(const MachineState *ms, int idx)
>  {
> -    return idx % ms->numa_state->num_nodes;
> +    return ms->numa_state->nodes[idx % ms->numa_state->num_nodes].nodeid;
>  }
>  
>  static void sbsa_ref_instance_init(Object *obj)
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 89899ec4c1..0384339867 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -537,7 +537,8 @@ build_srat(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>          if (ms->numa_state->nodes[i].node_mem > 0) {
>              numamem = acpi_data_push(table_data, sizeof(*numamem));
>              build_srat_memory(numamem, mem_base,
> -                              ms->numa_state->nodes[i].node_mem, i,
> +                              ms->numa_state->nodes[i].node_mem,
> +                              ms->numa_state->nodes[i].nodeid,
>                                MEM_AFFINITY_ENABLED);
>              mem_base += ms->numa_state->nodes[i].node_mem;
>          }
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 46f39e20bc..1a2db6447f 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -240,8 +240,8 @@ static void create_fdt(VirtMachineState *vms)
>          for (i = 0; i < nb_numa_nodes; i++) {
>              for (j = 0; j < nb_numa_nodes; j++) {
>                  idx = (i * nb_numa_nodes + j) * 3;
> -                matrix[idx + 0] = cpu_to_be32(i);
> -                matrix[idx + 1] = cpu_to_be32(j);
> +                matrix[idx + 0] = cpu_to_be32(ms->numa_state->nodes[i].nodeid);
> +                matrix[idx + 1] = cpu_to_be32(ms->numa_state->nodes[j].nodeid);
>                  matrix[idx + 2] =
>                      cpu_to_be32(ms->numa_state->nodes[i].distance[j]);
>              }
> @@ -1845,7 +1845,7 @@ virt_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
>  
>  static int64_t virt_get_default_cpu_node_id(const MachineState *ms, int idx)
>  {
> -    return idx % ms->numa_state->num_nodes;
> +    return ms->numa_state->nodes[idx % ms->numa_state->num_nodes].nodeid;
>  }
>  
>  static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index b36d9a1ec8..faf6e05d84 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -643,11 +643,19 @@ void machine_set_cpu_numa_node(MachineState *machine,
>      NodeInfo *numa_info = machine->numa_state->nodes;
>      bool match = false;
>      int i;
> +    int node_id = find_numa(props->node_id, machine->numa_state);
>  
>      if (!mc->possible_cpu_arch_ids) {
>          error_setg(errp, "mapping of CPUs to NUMA node is not supported");
>          return;
>      }
> +    if (node_id == MAX_NODES) {
> +        if (props->has_node_id) {
> +            node_id = props->node_id;
> +        } else {
> +            node_id = machine->numa_state->num_nodes;
> +        }
> +    }
>  
>      /* disabling node mapping is not supported, forbid it */
>      assert(props->has_node_id);
> @@ -711,15 +719,15 @@ void machine_set_cpu_numa_node(MachineState *machine,
>          slot->props.node_id = props->node_id;
>          slot->props.has_node_id = props->has_node_id;
>  
> -        if (numa_info[props->node_id].initiator_valid &&
> -            (props->node_id != numa_info[props->node_id].initiator)) {
> +        if (numa_info[node_id].initiator_valid &&
> +            (props->node_id != numa_info[node_id].initiator)) {
>              error_setg(errp, "The initiator of CPU NUMA node %" PRId64
>                         " should be itself.", props->node_id);
>              return;
>          }
> -        numa_info[props->node_id].initiator_valid = true;
> -        numa_info[props->node_id].has_cpu = true;
> -        numa_info[props->node_id].initiator = props->node_id;
> +        numa_info[node_id].initiator_valid = true;
> +        numa_info[node_id].has_cpu = true;
> +        numa_info[node_id].initiator = props->node_id;
>      }
>  
>      if (!match) {
> @@ -1097,14 +1105,28 @@ static void machine_numa_finish_cpu_init(MachineState *machine)
>      }
>  
>      for (i = 0; i < machine->numa_state->num_nodes; i++) {
> -        if (numa_info[i].initiator_valid &&
> -            !numa_info[numa_info[i].initiator].has_cpu) {
> -            error_report("The initiator-id %"PRIu16 " of NUMA node %d"
> -                         " does not exist.", numa_info[i].initiator, i);
> +        int node_id;
> +        if (!numa_info[i].initiator_valid) {
> +            continue;
> +        }
> +        node_id = find_numa(numa_info[i].initiator, machine->numa_state);
> +        if (node_id == MAX_NODES) {
> +            error_report("The NUMA node %" PRIu16 " initiator node (id %" PRIu16
> +                         ") does not exist", numa_info[i].nodeid,
> +                         numa_info[i].initiator);
> +            error_printf("\n");
> +
> +            exit(1);
> +        }
> +        if (!numa_info[node_id].has_cpu) {
> +            error_report("The NUMA node %" PRIu16 " initiator node (id %" PRIu16
> +                         ") has no cpus", numa_info[i].nodeid,
> +                         numa_info[i].initiator);
>              error_printf("\n");
>  
>              exit(1);
>          }
> +
>      }
>  
>      if (s->len && !qtest_enabled()) {
> diff --git a/hw/core/numa.c b/hw/core/numa.c
> index 75db35ac19..50a156f39f 100644
> --- a/hw/core/numa.c
> +++ b/hw/core/numa.c
> @@ -48,9 +48,19 @@ QemuOptsList qemu_numa_opts = {
>  
>  static int have_memdevs;
>  static int have_mem;
> -static int max_numa_nodeid; /* Highest specified NUMA node ID, plus one.
> -                             * For all nodes, nodeid < max_numa_nodeid
> -                             */
> +
> +int find_numa(uint16_t node, NumaState *numa_state)
> +{
> +    NodeInfo *numa_info = numa_state->nodes;
> +    int nb_numa_nodes = numa_state->num_nodes;
> +
> +    for (int i = 0; i < nb_numa_nodes; i++) {
> +        if (numa_info[i].present && numa_info[i].nodeid == node) {
> +            return i;
> +        }
> +    }
> +    return MAX_NODES;
> +}
>  
>  static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
>                              Error **errp)
> @@ -61,20 +71,18 @@ static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
>      MachineClass *mc = MACHINE_GET_CLASS(ms);
>      unsigned int max_cpus = ms->smp.max_cpus;
>      NodeInfo *numa_info = ms->numa_state->nodes;
> +    int nb_numa_nodes = ms->numa_state->num_nodes;
>  
> -    if (node->has_nodeid) {
> -        nodenr = node->nodeid;
> -    } else {
> -        nodenr = ms->numa_state->num_nodes;
> -    }
> +    nodenr = ms->numa_state->num_nodes;
>  
> -    if (nodenr >= MAX_NODES) {
> +    if (nb_numa_nodes >= MAX_NODES) {
>          error_setg(errp, "Max number of NUMA nodes reached: %"
>                     PRIu16 "", nodenr);
>          return;
>      }
>  
> -    if (numa_info[nodenr].present) {
> +    if (node->has_nodeid &&
> +        find_numa(node->nodeid, ms->numa_state) != MAX_NODES) {
>          error_setg(errp, "Duplicate NUMA nodeid: %" PRIu16, nodenr);
>          return;
>      }
> @@ -93,7 +101,7 @@ static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
>              return;
>          }
>          props = mc->cpu_index_to_instance_props(ms, cpus->value);
> -        props.node_id = nodenr;
> +        props.node_id = node->has_nodeid ? node->nodeid : nodenr;
>          props.has_node_id = true;
>          machine_set_cpu_numa_node(ms, &props, &err);
>          if (err) {
> @@ -143,26 +151,26 @@ static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
>          numa_info[nodenr].initiator = node->initiator;
>      }
>      numa_info[nodenr].present = true;
> -    max_numa_nodeid = MAX(max_numa_nodeid, nodenr + 1);
> +    numa_info[nodenr].nodeid = node->has_nodeid ? node->nodeid : nb_numa_nodes;
>      ms->numa_state->num_nodes++;
>  }
>  
>  static
>  void parse_numa_distance(MachineState *ms, NumaDistOptions *dist, Error **errp)
>  {
> -    uint16_t src = dist->src;
> -    uint16_t dst = dist->dst;
> +    int src = find_numa(dist->src, ms->numa_state);
> +    int dst = find_numa(dist->dst, ms->numa_state);
>      uint8_t val = dist->val;
>      NodeInfo *numa_info = ms->numa_state->nodes;
>  
> -    if (src >= MAX_NODES || dst >= MAX_NODES) {
> -        error_setg(errp, "Parameter '%s' expects an integer between 0 and %d",
> -                   src >= MAX_NODES ? "src" : "dst", MAX_NODES - 1);
> +    if (src >= MAX_NODES || !numa_info[src].present) {
> +        error_setg(errp, "Source NUMA node is missing. "
> +                   "Please use '-numa node' option to declare it first.");
>          return;
>      }
>  
> -    if (!numa_info[src].present || !numa_info[dst].present) {
> -        error_setg(errp, "Source/Destination NUMA node is missing. "
> +    if (dst >= MAX_NODES || !numa_info[dst].present) {
> +        error_setg(errp, "Destination NUMA node is missing. "
>                     "Please use '-numa node' option to declare it first.");
>          return;
>      }
> @@ -175,8 +183,8 @@ void parse_numa_distance(MachineState *ms, NumaDistOptions *dist, Error **errp)
>      }
>  
>      if (src == dst && val != NUMA_DISTANCE_MIN) {
> -        error_setg(errp, "Local distance of node %d should be %d.",
> -                   src, NUMA_DISTANCE_MIN);
> +        error_setg(errp, "Local distance of node %" PRIu16 " should be %d.",
> +                   dist->src, NUMA_DISTANCE_MIN);
>          return;
>      }
>  
> @@ -187,9 +195,10 @@ void parse_numa_distance(MachineState *ms, NumaDistOptions *dist, Error **errp)
>  void parse_numa_hmat_lb(MachineState *ms, NumaHmatLBOptions *node,
>                          Error **errp)
>  {
> -    int nb_numa_nodes = ms->numa_state->num_nodes;
>      NodeInfo *numa_info = ms->numa_state->nodes;
>      HMAT_LB_Info *hmat_lb = NULL;
> +    int initiator = find_numa(node->initiator, ms->numa_state);
> +    int target = find_numa(node->target, ms->numa_state);
>  
>      if (node->data_type <= HMATLB_DATA_TYPE_WRITE_LATENCY) {
>          if (!node->has_latency) {
> @@ -225,26 +234,26 @@ void parse_numa_hmat_lb(MachineState *ms, NumaHmatLBOptions *node,
>          }
>      }
>  
> -    if (node->initiator >= nb_numa_nodes) {
> +    if (initiator >= MAX_NODES) {
>          error_setg(errp, "Invalid initiator=%"
> -                   PRIu16 ", it should be less than %d.",
> -                   node->initiator, nb_numa_nodes);
> +                   PRIu16 ", not found.",
> +                   node->initiator);
>          return;
>      }
> -    if (!numa_info[node->initiator].has_cpu) {
> +    if (!numa_info[initiator].has_cpu) {
>          error_setg(errp, "Invalid initiator=%"
>                     PRIu16 ", it isn't an initiator proximity domain.",
>                     node->initiator);
>          return;
>      }
>  
> -    if (node->target >= nb_numa_nodes) {
> +    if (target >= MAX_NODES) {
>          error_setg(errp, "Invalid target=%"
> -                   PRIu16 ", it should be less than %d.",
> -                   node->target, nb_numa_nodes);
> +                   PRIu16 ", not found",
> +                   node->target);
>          return;
>      }
> -    if (!numa_info[node->target].initiator_valid) {
> +    if (!numa_info[target].initiator_valid) {
>          error_setg(errp, "Invalid target=%"
>                     PRIu16 ", it hasn't a valid initiator proximity domain.",
>                     node->target);
> @@ -257,7 +266,7 @@ void parse_numa_hmat_lb(MachineState *ms, NumaHmatLBOptions *node,
>          if (!hmat_lb) {
>              hmat_lb = g_malloc0(sizeof(*hmat_lb));
>              ms->numa_state->hmat_lb[node->hierarchy][node->data_type] = hmat_lb;
> -        } else if (hmat_lb->latency[node->initiator][node->target]) {
> +        } else if (hmat_lb->latency[initiator][target]) {
>              error_setg(errp, "Duplicate configuration of the latency for "
>                         "initiator=%" PRIu16 " and target=%" PRIu16 ".",
>                         node->initiator, node->target);
> @@ -269,7 +278,7 @@ void parse_numa_hmat_lb(MachineState *ms, NumaHmatLBOptions *node,
>              hmat_lb->base_lat = node->base_lat;
>          }
>  
> -        hmat_lb->latency[node->initiator][node->target] = node->latency;
> +        hmat_lb->latency[initiator][target] = node->latency;
>      }
>  
>      if (node->has_bandwidth) {
> @@ -278,7 +287,7 @@ void parse_numa_hmat_lb(MachineState *ms, NumaHmatLBOptions *node,
>          if (!hmat_lb) {
>              hmat_lb = g_malloc0(sizeof(*hmat_lb));
>              ms->numa_state->hmat_lb[node->hierarchy][node->data_type] = hmat_lb;
> -        } else if (hmat_lb->bandwidth[node->initiator][node->target]) {
> +        } else if (hmat_lb->bandwidth[initiator][target]) {
>              error_setg(errp, "Duplicate configuration of the bandwidth for "
>                         "initiator=%" PRIu16 " and target=%" PRIu16 ".",
>                         node->initiator, node->target);
> @@ -295,7 +304,7 @@ void parse_numa_hmat_lb(MachineState *ms, NumaHmatLBOptions *node,
>              }
>          }
>  
> -        hmat_lb->bandwidth[node->initiator][node->target] = node->bandwidth;
> +        hmat_lb->bandwidth[initiator][target] = node->bandwidth;
>      }
>  
>      if (hmat_lb) {
> @@ -307,13 +316,13 @@ void parse_numa_hmat_lb(MachineState *ms, NumaHmatLBOptions *node,
>  void parse_numa_hmat_cache(MachineState *ms, NumaHmatCacheOptions *node,
>                             Error **errp)
>  {
> -    int nb_numa_nodes = ms->numa_state->num_nodes;
>      HMAT_Cache_Info *hmat_cache = NULL;
> +    int node_id = find_numa(node->node_id, ms->numa_state);
>  
> -    if (node->node_id >= nb_numa_nodes) {
> +    if (node_id >= MAX_NODES) {
>          error_setg(errp, "Invalid node-id=%" PRIu32
> -                   ", it should be less than %d.",
> -                   node->node_id, nb_numa_nodes);
> +                   ", not found.",
> +                   node->node_id);
>          return;
>      }
>  
> @@ -330,7 +339,7 @@ void parse_numa_hmat_cache(MachineState *ms, NumaHmatCacheOptions *node,
>                     node->level, node->total);
>          return;
>      }
> -    if (ms->numa_state->hmat_cache[node->node_id][node->level]) {
> +    if (ms->numa_state->hmat_cache[node_id][node->level]) {
>          error_setg(errp, "Duplicate configuration of the side cache for "
>                     "node-id=%" PRIu32 " and level=%" PRIu8 ".",
>                     node->node_id, node->level);
> @@ -338,15 +347,15 @@ void parse_numa_hmat_cache(MachineState *ms, NumaHmatCacheOptions *node,
>      }
>  
>      if ((node->level > 1) &&
> -        ms->numa_state->hmat_cache[node->node_id][node->level - 1] &&
> +        ms->numa_state->hmat_cache[node_id][node->level - 1] &&
>          (node->size >=
> -            ms->numa_state->hmat_cache[node->node_id][node->level - 1]->size)) {
> +            ms->numa_state->hmat_cache[node_id][node->level - 1]->size)) {
>          error_setg(errp, "Invalid size=0x%" PRIx64
>                     ", the size of level=%" PRIu8
>                     " should be less than the size(0x%" PRIx64
>                     ") of level=%" PRIu8 ".",
>                     node->size, node->level,
> -                   ms->numa_state->hmat_cache[node->node_id]
> +                   ms->numa_state->hmat_cache[node_id]
>                                               [node->level - 1]->size,
>                     node->level - 1);
>          return;
> @@ -362,7 +371,7 @@ void parse_numa_hmat_cache(MachineState *ms, NumaHmatCacheOptions *node,
>      hmat_cache->write_policy = node->policy;
>      hmat_cache->line_size = node->line;
>  
> -    ms->numa_state->hmat_cache[node->node_id][node->level] = hmat_cache;
> +    ms->numa_state->hmat_cache[node_id][node->level] = hmat_cache;
>  }
>  
>  void set_numa_options(MachineState *ms, NumaOptions *object, Error **errp)
> @@ -393,7 +402,7 @@ void set_numa_options(MachineState *ms, NumaOptions *object, Error **errp)
>              error_setg(&err, "Missing mandatory node-id property");
>              goto end;
>          }
> -        if (!ms->numa_state->nodes[object->u.cpu.node_id].present) {
> +        if (find_numa(object->u.cpu.node_id, ms->numa_state) == MAX_NODES) {
>              error_setg(&err, "Invalid node-id=%" PRId64 ", NUMA node must be "
>                  "defined with -numa node,nodeid=ID before it's used with "
>                  "-numa cpu,node-id=ID", object->u.cpu.node_id);
> @@ -472,10 +481,11 @@ static void validate_numa_distance(MachineState *ms)
>              if (numa_info[src].distance[dst] == 0 &&
>                  numa_info[dst].distance[src] == 0) {
>                  if (src != dst) {
> -                    error_report("The distance between node %d and %d is "
> -                                 "missing, at least one distance value "
> -                                 "between each nodes should be provided.",
> -                                 src, dst);
> +                    error_report("The distance between node %" PRIu16
> +                                 " and %" PRIu16 " is missing, at least one "
> +                                 "distance value between each nodes should be "
> +                                 "provided.",
> +                                 numa_info[src].nodeid, numa_info[dst].nodeid);
>                      exit(EXIT_FAILURE);
>                  }
>              }
> @@ -493,9 +503,11 @@ static void validate_numa_distance(MachineState *ms)
>          for (src = 0; src < nb_numa_nodes; src++) {
>              for (dst = 0; dst < nb_numa_nodes; dst++) {
>                  if (src != dst && numa_info[src].distance[dst] == 0) {
> -                    error_report("At least one asymmetrical pair of "
> -                            "distances is given, please provide distances "
> -                            "for both directions of all node pairs.");
> +                    error_report("At least one asymmetrical pair (%" PRIu16
> +                            ", %" PRIu16 ") of distances is given, please "
> +                            "provide distances for both directions of all node "
> +                            "pairs.",
> +                            numa_info[src].nodeid, numa_info[dst].nodeid);
>                      exit(EXIT_FAILURE);
>                  }
>              }
> @@ -587,27 +599,11 @@ void numa_complete_configuration(MachineState *ms)
>              parse_numa_node(ms, &node, &error_abort);
>      }
>  
> -    assert(max_numa_nodeid <= MAX_NODES);
> -
> -    /* No support for sparse NUMA node IDs yet: */
> -    for (i = max_numa_nodeid - 1; i >= 0; i--) {
> -        /* Report large node IDs first, to make mistakes easier to spot */
> -        if (!numa_info[i].present) {
> -            error_report("numa: Node ID missing: %d", i);
> -            exit(1);
> -        }
> -    }
> -
> -    /* This must be always true if all nodes are present: */
> -    assert(ms->numa_state->num_nodes == max_numa_nodeid);
> +    assert(ms->numa_state->num_nodes <= MAX_NODES);
>  
>      if (ms->numa_state->num_nodes > 0) {
>          uint64_t numa_total;
>  
> -        if (ms->numa_state->num_nodes > MAX_NODES) {
> -            ms->numa_state->num_nodes = MAX_NODES;
> -        }
> -
>          /* If no memory size is given for any node, assume the default case
>           * and distribute the available memory equally across all nodes
>           */
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 90ad0dff99..f4a906c72e 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2361,6 +2361,7 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
>      numa_start = table_data->len;
>  
>      for (i = 1; i < pcms->numa_nodes + 1; ++i) {
> +        int nodeid = machine->numa_state->nodes[i - 1].nodeid;
>          mem_base = next_base;
>          mem_len = pcms->node_mem[i - 1];
>          next_base = mem_base + mem_len;
> @@ -2371,7 +2372,7 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
>              mem_len -= next_base - HOLE_640K_START;
>              if (mem_len > 0) {
>                  numamem = acpi_data_push(table_data, sizeof *numamem);
> -                build_srat_memory(numamem, mem_base, mem_len, i - 1,
> +                build_srat_memory(numamem, mem_base, mem_len, nodeid,
>                                    MEM_AFFINITY_ENABLED);
>              }
>  
> @@ -2390,7 +2391,7 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
>              mem_len -= next_base - pcms->below_4g_mem_size;
>              if (mem_len > 0) {
>                  numamem = acpi_data_push(table_data, sizeof *numamem);
> -                build_srat_memory(numamem, mem_base, mem_len, i - 1,
> +                build_srat_memory(numamem, mem_base, mem_len, nodeid,
>                                    MEM_AFFINITY_ENABLED);
>              }
>              mem_base = 1ULL << 32;
> @@ -2400,7 +2401,7 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
>  
>          if (mem_len > 0) {
>              numamem = acpi_data_push(table_data, sizeof *numamem);
> -            build_srat_memory(numamem, mem_base, mem_len, i - 1,
> +            build_srat_memory(numamem, mem_base, mem_len, nodeid,
>                                MEM_AFFINITY_ENABLED);
>          }
>      }
> @@ -2421,8 +2422,9 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
>      if (hotplugabble_address_space_size) {
>          numamem = acpi_data_push(table_data, sizeof *numamem);
>          build_srat_memory(numamem, machine->device_memory->base,
> -                          hotplugabble_address_space_size, pcms->numa_nodes - 1,
> -                          MEM_AFFINITY_HOTPLUGGABLE | MEM_AFFINITY_ENABLED);
> +            hotplugabble_address_space_size,
> +            machine->numa_state->nodes[pcms->numa_nodes - 1].nodeid,
> +            MEM_AFFINITY_HOTPLUGGABLE | MEM_AFFINITY_ENABLED);
>      }
>  
>      build_header(linker, table_data,
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index c3f5a70a56..5b8db454b7 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -2850,7 +2850,7 @@ static int64_t pc_get_default_cpu_node_id(const MachineState *ms, int idx)
>     x86_topo_ids_from_apicid(ms->possible_cpus->cpus[idx].arch_id,
>                              pcms->smp_dies, ms->smp.cores,
>                              ms->smp.threads, &topo);
> -   return topo.pkg_id % ms->numa_state->num_nodes;
> +   return ms->numa_state->nodes[topo.pkg_id % ms->numa_state->num_nodes].nodeid;
>  }
>  
>  static const CPUArchIdList *pc_possible_cpu_arch_ids(MachineState *ms)
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index f607ca567b..ef4802698c 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -424,7 +424,8 @@ static int spapr_populate_memory(SpaprMachineState *spapr, void *fdt)
>          if (!mem_start) {
>              /* spapr_machine_init() checks for rma_size <= node0_size
>               * already */
> -            spapr_populate_memory_node(fdt, i, 0, spapr->rma_size);
> +            spapr_populate_memory_node(fdt, nodes[i].nodeid, 0,
> +                                       spapr->rma_size);
>              mem_start += spapr->rma_size;
>              node_size -= spapr->rma_size;
>          }
> @@ -436,7 +437,8 @@ static int spapr_populate_memory(SpaprMachineState *spapr, void *fdt)
>                  sizetmp = 1ULL << ctzl(mem_start);
>              }
>  
> -            spapr_populate_memory_node(fdt, i, mem_start, sizetmp);
> +            spapr_populate_memory_node(fdt, nodes[i].nodeid, mem_start,
> +                                       sizetmp);
>              node_size -= sizetmp;
>              mem_start += sizetmp;
>          }
> @@ -2543,7 +2545,8 @@ static void spapr_validate_node_memory(MachineState *machine, Error **errp)
>              error_setg(errp,
>                         "Node %d memory size 0x%" PRIx64
>                         " is not aligned to %" PRIu64 " MiB",
> -                       i, machine->numa_state->nodes[i].node_mem,
> +                       machine->numa_state->nodes[i].nodeid,
> +                       machine->numa_state->nodes[i].node_mem,
>                         SPAPR_MEMORY_BLOCK_SIZE / MiB);
>              return;
>          }
> @@ -4140,7 +4143,8 @@ spapr_cpu_index_to_props(MachineState *machine, unsigned cpu_index)
>  
>  static int64_t spapr_get_default_cpu_node_id(const MachineState *ms, int idx)
>  {
> -    return idx / ms->smp.cores % ms->numa_state->num_nodes;
> +    return ms->numa_state->nodes[
> +        idx / ms->smp.cores % ms->numa_state->num_nodes].nodeid;
>  }
>  
>  static const CPUArchIdList *spapr_possible_cpu_arch_ids(MachineState *machine)
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
>  
> @@ -39,6 +40,7 @@ struct NumaState {
>  };
>  typedef struct NumaState NumaState;
>  
> +int find_numa(uint16_t node, NumaState *numa_state);
>  void set_numa_options(MachineState *ms, NumaOptions *object, Error **errp);
>  void parse_numa_opts(MachineState *ms);
>  void parse_numa_hmat_lb(MachineState *ms, NumaHmatLBOptions *node,
> -- 
> 2.21.0

