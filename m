Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FAC0C433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 11:51:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A09A820704
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 11:51:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A09A820704
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTkkZ-00007f-Qh
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 07:51:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kTkjX-0007k9-22
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 07:50:47 -0400
Received: from indium.canonical.com ([91.189.90.7]:60712)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kTkjT-0005rv-5i
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 07:50:46 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kTkjS-0004nU-4m
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2020 11:50:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 229032E812F
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2020 11:50:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2020 11:39:13 -0000
From: Satheesh Rajendran <1900241@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: kvm powerpc xive
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: sathnaga
X-Launchpad-Bug-Reporter: Satheesh Rajendran (sathnaga)
X-Launchpad-Bug-Modifier: Satheesh Rajendran (sathnaga)
References: <160293454254.8431.993577940537988142.malonedeb@chaenomeles.canonical.com>
Message-Id: <160293475392.24915.12236813268480351259.malone@soybean.canonical.com>
Subject: [Bug 1900241] Re: some vcpus are found offline inside guest with
 different vsmt setting from qemu-cmdline and breaks subsequent vcpu hotplug
 operation (xive)
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="58bb2f3096f16f0e0acc917602669aecb4ffaf54"; Instance="production"
X-Launchpad-Hash: 331b05552d3a02bc2252896e3ea62ebcb07eca30
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/17 07:50:41
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1900241 <1900241@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Did a git bisect and the bad commit is

acbdb9956fe93f4669141f103cb543d3025775db is the first bad commit
commit acbdb9956fe93f4669141f103cb543d3025775db
Author: C=C3=A9dric Le Goater <clg@kaod.org>
Date:   Thu Aug 20 15:45:46 2020 +0200

    spapr/xive: Allocate IPIs independently from the other sources
    =

    The vCPU IPIs are now allocated in kvmppc_xive_cpu_connect() when the
    vCPU connects to the KVM device and not when all the sources are reset
    in kvmppc_xive_source_reset()
    =

    This requires extra care for hotplug vCPUs and VM restore.
    =

    Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
    Message-Id: <20200820134547.2355743-4-clg@kaod.org>
    Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

 hw/intc/spapr_xive_kvm.c | 47 ++++++++++++++++++++++++++++++++++++++++++--=
---
 1 file changed, 42 insertions(+), 5 deletions(-)



# git bisect log
git bisect start
# good: [d0ed6a69d399ae193959225cdeaa9382746c91cc] Update version for v5.1.=
0 release
git bisect good d0ed6a69d399ae193959225cdeaa9382746c91cc
# bad: [7daf8f8d011cdd5d3e86930ed2bde969425c790c] Merge remote-tracking bra=
nch 'remotes/kevin/tags/for-upstream' into staging
git bisect bad 7daf8f8d011cdd5d3e86930ed2bde969425c790c
# skip: [7595a65818ea9b49c36650a8c217a1ef9bd6e62a] hw/riscv: Sort the Kconf=
ig options in alphabetical order
git bisect skip 7595a65818ea9b49c36650a8c217a1ef9bd6e62a
# skip: [3b65b742543bc6c2ad35e3b42401a26b48a87f26] target/hppa: Fix boot wi=
th old Linux installation CDs
git bisect skip 3b65b742543bc6c2ad35e3b42401a26b48a87f26
# bad: [f4ef8c9cc10b3bee829b9775879d4ff9f77c2442] Merge remote-tracking bra=
nch 'remotes/ehabkost/tags/machine-next-pull-request' into staging
git bisect bad f4ef8c9cc10b3bee829b9775879d4ff9f77c2442
# good: [4ee40a6b98c02b72fc5dd262df9d3ac8680d767b] hw/usb: Add U2F device c=
heck to passthru mode
git bisect good 4ee40a6b98c02b72fc5dd262df9d3ac8680d767b
# skip: [fe4b0b5bfa96c38ad1cad0689a86cca9f307e353] tcg: Implement 256-bit d=
up for tcg_gen_gvec_dup_mem
git bisect skip fe4b0b5bfa96c38ad1cad0689a86cca9f307e353
# skip: [287b1defeb44398d02669d97ebdc347d650f274d] target/microblaze: Cache=
 mem_index in DisasContext
git bisect skip 287b1defeb44398d02669d97ebdc347d650f274d
# skip: [7a1fb2ef40df508e90eb756a80d67e6435246cae] block/nvme: Extract nvme=
_poll_queue()
git bisect skip 7a1fb2ef40df508e90eb756a80d67e6435246cae
# good: [536e340f464d7c2ef55cca47c7535d9409bf03c7] target/microblaze: Conve=
rt msrclr, msrset to decodetree
git bisect good 536e340f464d7c2ef55cca47c7535d9409bf03c7
# good: [227de21ed0759e275a469394af72c999d0134bb5] Merge remote-tracking br=
anch 'remotes/rth/tags/pull-tcg-20200903' into staging
git bisect good 227de21ed0759e275a469394af72c999d0134bb5
# bad: [b95ba83fc56ebfc4b6869f21db0c757c0c191104] Merge remote-tracking bra=
nch 'remotes/dgibson/tags/ppc-for-5.2-20200908' into staging
git bisect bad b95ba83fc56ebfc4b6869f21db0c757c0c191104
# good: [789035f1239054331b335801a06bdbef026f02e1] oss-fuzz: fix rpath
git bisect good 789035f1239054331b335801a06bdbef026f02e1
# good: [00942071a0eabeb3ebc3bd594296859587f8f3c8] Merge remote-tracking br=
anch 'remotes/rth/tags/pull-mb-20200907-2' into staging
git bisect good 00942071a0eabeb3ebc3bd594296859587f8f3c8
# bad: [554c2169e9251ca2829ab968bd9ba5641a5abe1d] ppc/spapr: Use start-powe=
red-off CPUState property
git bisect bad 554c2169e9251ca2829ab968bd9ba5641a5abe1d
# good: [235d3b116213828f4206e2e4b199a32bffc96f35] spapr/xive: Modify kvm_c=
pu_is_enabled() interface
git bisect good 235d3b116213828f4206e2e4b199a32bffc96f35
# bad: [90d282d0858cf5a38f3e8a7e201aeab2a0ccbe88] ppc/spapr_nvdimm: use g_a=
utofree in spapr_nvdimm_validate_opts()
git bisect bad 90d282d0858cf5a38f3e8a7e201aeab2a0ccbe88
# bad: [acbdb9956fe93f4669141f103cb543d3025775db] spapr/xive: Allocate IPIs=
 independently from the other sources
git bisect bad acbdb9956fe93f4669141f103cb543d3025775db
# good: [fa94447a2cd6643609d5822d5b5f739dc8ad8a8c] spapr/xive: Use kvmppc_x=
ive_source_reset() in post_load
git bisect good fa94447a2cd6643609d5822d5b5f739dc8ad8a8c
# first bad commit: [acbdb9956fe93f4669141f103cb543d3025775db] spapr/xive: =
Allocate IPIs independently from the other sources


Regards,
-Satheesh

** Summary changed:

- some vcpus are found offline inside guest with different vsmt setting fro=
m qemu-cmdline and breaks subsequent vcpu hotplug operation (xive)
+ [regression][powerpc] some vcpus are found offline inside guest with diff=
erent vsmt setting from qemu-cmdline and breaks subsequent vcpu hotplug ope=
ration (xive)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1900241

Title:
  [regression][powerpc] some vcpus are found offline inside guest with
  different vsmt setting from qemu-cmdline and breaks subsequent vcpu
  hotplug operation (xive)

Status in QEMU:
  New

Bug description:
  Env:
  Host: Power9 HW ppc64le

  # lscpu
  Architecture:                    ppc64le
  Byte Order:                      Little Endian
  CPU(s):                          128
  On-line CPU(s) list:             24-31,40-159
  Thread(s) per core:              4
  Core(s) per socket:              16
  Socket(s):                       2
  NUMA node(s):                    2
  Model:                           2.3 (pvr 004e 1203)
  Model name:                      POWER9, altivec supported
  Frequency boost:                 enabled
  CPU max MHz:                     3800.0000
  CPU min MHz:                     2300.0000
  L1d cache:                       1 MiB
  L1i cache:                       1 MiB
  L2 cache:                        8 MiB
  L3 cache:                        160 MiB
  NUMA node0 CPU(s):               24-31,40-79
  NUMA node8 CPU(s):               80-159
  Vulnerability Itlb multihit:     Not affected
  Vulnerability L1tf:              Mitigation; RFI Flush, L1D private per t=
hread
  Vulnerability Mds:               Not affected
  Vulnerability Meltdown:          Mitigation; RFI Flush, L1D private per t=
hread
  Vulnerability Spec store bypass: Mitigation; Kernel entry/exit barrier (e=
ieio)
  Vulnerability Spectre v1:        Mitigation; __user pointer sanitization,=
 ori31 speculation barrier enabled
  Vulnerability Spectre v2:        Mitigation; Software count cache flush (=
hardware accelerated), Software link stack flush
  Vulnerability Srbds:             Not affected
  Vulnerability Tsx async abort:   Not affected


  Host Kernel: 5.9.0-0.rc8.28.fc34.ppc64le (Fedora rawhide)
  Guest Kernel: Fedora33(5.8.6-301.fc33.ppc64le)

  Qemu: e12ce85b2c79d83a340953291912875c30b3af06 (qemu/master)

  =

  Steps to reproduce:

  Boot below kvm guest: (-M pseries,vsmt=3D2 -smp 8,cores=3D8,threads=3D1)

   /home/sath/qemu/build/qemu-system-ppc64 -name vm1 -M pseries,vsmt=3D2
  -accel kvm -m 4096  -smp 8,cores=3D8,threads=3D1 -nographic -nodefaults
  -serial mon:stdio -vga none -nographic -device virtio-scsi-pci -drive
  file=3D/home/sath/tests/data/avocado-vt/images/fdevel-
  ppc64le.qcow2,if=3Dnone,id=3Dhd0,format=3Dqcow2,cache=3Dnone -device scsi-
  hd,drive=3Dhd0

  =

  lscpu inside guest:
  Actual:
  [root@atest-guest ~]# lscpu
  Architecture:                    ppc64le
  Byte Order:                      Little Endian
  CPU(s):                          8
  On-line CPU(s) list:             0,2,4,6
  Off-line CPU(s) list:            1,3,5,7 --------------------------NOK
  Thread(s) per core:              1
  Core(s) per socket:              4
  Socket(s):                       1
  NUMA node(s):                    1
  Model:                           2.3 (pvr 004e 1203)
  Model name:                      POWER9 (architected), altivec supported
  Hypervisor vendor:               KVM
  Virtualization type:             para
  L1d cache:                       128 KiB
  L1i cache:                       128 KiB
  NUMA node0 CPU(s):               0,2,4,6
  Vulnerability Itlb multihit:     Not affected
  Vulnerability L1tf:              Mitigation; RFI Flush, L1D private per t=
hread
  Vulnerability Mds:               Not affected
  Vulnerability Meltdown:          Mitigation; RFI Flush, L1D private per t=
hread
  Vulnerability Spec store bypass: Mitigation; Kernel entry/exit barrier (e=
ieio)
  Vulnerability Spectre v1:        Mitigation; __user pointer sanitization,=
 ori31 =

                                   speculation barrier enabled
  Vulnerability Spectre v2:        Mitigation; Software count cache flush (=
hardwar
                                   e accelerated), Software link stack flush
  Vulnerability Srbds:             Not affected
  Vulnerability Tsx async abort:   Not affected

  =

  Expected:

  [root@atest-guest ~]# lscpu
  Architecture:                    ppc64le
  Byte Order:                      Little Endian
  CPU(s):                          8
  On-line CPU(s) list:             0-7
  Thread(s) per core:              1
  Core(s) per socket:              8
  Socket(s):                       1
  NUMA node(s):                    1
  Model:                           2.3 (pvr 004e 1203)
  Model name:                      POWER9 (architected), altivec supported
  Hypervisor vendor:               KVM
  Virtualization type:             para
  L1d cache:                       256 KiB
  L1i cache:                       256 KiB
  NUMA node0 CPU(s):               0-7
  Vulnerability Itlb multihit:     Not affected
  Vulnerability L1tf:              Mitigation; RFI Flush, L1D private per t=
hread
  Vulnerability Mds:               Not affected
  Vulnerability Meltdown:          Mitigation; RFI Flush, L1D private per t=
hread
  Vulnerability Spec store bypass: Mitigation; Kernel entry/exit barrier (e=
ieio)
  Vulnerability Spectre v1:        Mitigation; __user pointer sanitization,=
 ori31 =

                                   speculation barrier enabled
  Vulnerability Spectre v2:        Mitigation; Software count cache flush (=
hardwar
                                   e accelerated), Software link stack flush
  Vulnerability Srbds:             Not affected
  Vulnerability Tsx async abort:   Not affected


  There by further vcpuhotplug operation fails...

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1900241/+subscriptions

