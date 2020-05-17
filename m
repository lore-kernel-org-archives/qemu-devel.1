Return-Path: <SRS0=EQsI=67=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F56C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 11:26:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F668206D4
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 11:26:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F668206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaHRN-0007oI-6S
	for qemu-devel@archiver.kernel.org; Sun, 17 May 2020 07:26:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47864)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jaHQQ-00074l-6v
 for qemu-devel@nongnu.org; Sun, 17 May 2020 07:25:46 -0400
Received: from indium.canonical.com ([91.189.90.7]:55242)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jaHQO-0006O9-VI
 for qemu-devel@nongnu.org; Sun, 17 May 2020 07:25:45 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jaHQL-0005Xb-2o
 for <qemu-devel@nongnu.org>; Sun, 17 May 2020 11:25:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 0C91D2E80E7
 for <qemu-devel@nongnu.org>; Sun, 17 May 2020 11:25:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 17 May 2020 11:15:50 -0000
From: Jan Klos <1856335@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: babumoger djdatte h-sieger janklos
X-Launchpad-Bug-Reporter: Damir (djdatte)
X-Launchpad-Bug-Modifier: Jan Klos (janklos)
References: <157625616239.22064.10423897892496347105.malonedeb@gac.canonical.com>
Message-Id: <158971415072.22897.16303582021252899317.malone@gac.canonical.com>
Subject: [Bug 1856335] Re: Cache Layout wrong on many Zen Arch CPUs
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="0385b538081bc4718df6fb844a3afc89729c94ce";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 55409860d84b0d7c797b478f24d77d38f6767432
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 06:50:40
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Reply-To: Bug 1856335 <1856335@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

No, creating artificial NUMA nodes is, simply put, never a good solution
for CPUs that operate as a single NUMA node - which is the case for all
Zen2 CPUs (except maybe EPYCs? not sure about those).

You may workaround the L3 issue that way, but hit many new bugs/problems
by introducing multiple NUMA nodes, _especially_ on Windows VMs, because
that OS has crappy NUMA handling and multitude of bugs related to it -
which was one of the major reasons why even Zen2 Threadrippers are now
single NUMA node (e.g. https://www.servethehome.com/wp-
content/uploads/2019/11/AMD-Ryzen-Threadripper-3960X-Topology.png ).

The host CPU architecture should be replicated as closely as possible on
the VM and for Zen2 CPUs with 4 cores per CCX, _this already works
perfectly_ - there are no problems on
3300X/3700(X)/3800X/3950X/3970X/3990X.

There is, unfortunately, no way to customize/specify the "disabled" CPU
cores in QEMU, and therefore no way to emulate 1 NUMA node + L3 cache
per 2/3 cores - only to passthrough the cache config from host, which is
unfortunately not done correctly for CPUs with disabled cores (but
again, works perfectly for CPUs with all 4 cores enabled per CCX).

lscpu:
Architecture:                    x86_64
CPU op-mode(s):                  32-bit, 64-bit
Byte Order:                      Little Endian
Address sizes:                   43 bits physical, 48 bits virtual
CPU(s):                          24
On-line CPU(s) list:             0-23
Thread(s) per core:              2
Core(s) per socket:              12
Socket(s):                       1
NUMA node(s):                    1
Vendor ID:                       AuthenticAMD
CPU family:                      23
Model:                           113
Model name:                      AMD Ryzen 9 3900X 12-Core Processor
Stepping:                        0
Frequency boost:                 enabled
CPU MHz:                         2972.127
CPU max MHz:                     3800.0000
CPU min MHz:                     2200.0000
BogoMIPS:                        7602.55
Virtualization:                  AMD-V
L1d cache:                       384 KiB
L1i cache:                       384 KiB
L2 cache:                        6 MiB
L3 cache:                        64 MiB
NUMA node0 CPU(s):               0-23
Vulnerability Itlb multihit:     Not affected
Vulnerability L1tf:              Not affected
Vulnerability Mds:               Not affected
Vulnerability Meltdown:          Not affected
Vulnerability Spec store bypass: Mitigation; Speculative Store Bypass disab=
led via prctl and seccomp
Vulnerability Spectre v1:        Mitigation; usercopy/swapgs barriers and _=
_user pointer sanitization
Vulnerability Spectre v2:        Mitigation; Full AMD retpoline, IBPB condi=
tional, STIBP conditional, RSB filling
Vulnerability Tsx async abort:   Not affected
Flags:                           fpu vme de pse tsc msr pae mce cx8 apic se=
p mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxex=
t fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonsto
                                 p_tsc cpuid extd_apicid aperfmperf pni pcl=
mulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c=
 rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a mi
                                 salignsse 3dnowprefetch osvw ibs skinit wd=
t tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb cat_l3 c=
dp_l3 hw_pstate sme ssbd mba sev ibpb stibp vmmcall fsgsbase b
                                 mi1 avx2 smep bmi2 cqm rdt_a rdseed adx sm=
ap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_=
llc cqm_mbm_total cqm_mbm_local clzero irperf xsaveerptr rdpru
                                  wbnoinvd arat npt lbrv svm_lock nrip_save=
 tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avi=
c v_vmsave_vmload vgif umip rdpid overflow_recov succor smca


But the important thing has already been posted here in previous comments -=
 notice the skipped core ids belonging to the disabled cores:

virsh capabilities | grep "cpu id":
<cpu id=3D'0' socket_id=3D'0' core_id=3D'0' siblings=3D'0,12'/>
<cpu id=3D'1' socket_id=3D'0' core_id=3D'1' siblings=3D'1,13'/>
<cpu id=3D'2' socket_id=3D'0' core_id=3D'2' siblings=3D'2,14'/>
<cpu id=3D'3' socket_id=3D'0' core_id=3D'4' siblings=3D'3,15'/>
<cpu id=3D'4' socket_id=3D'0' core_id=3D'5' siblings=3D'4,16'/>
<cpu id=3D'5' socket_id=3D'0' core_id=3D'6' siblings=3D'5,17'/>
<cpu id=3D'6' socket_id=3D'0' core_id=3D'8' siblings=3D'6,18'/>
<cpu id=3D'7' socket_id=3D'0' core_id=3D'9' siblings=3D'7,19'/>
<cpu id=3D'8' socket_id=3D'0' core_id=3D'10' siblings=3D'8,20'/>
<cpu id=3D'9' socket_id=3D'0' core_id=3D'12' siblings=3D'9,21'/>
<cpu id=3D'10' socket_id=3D'0' core_id=3D'13' siblings=3D'10,22'/>
<cpu id=3D'11' socket_id=3D'0' core_id=3D'14' siblings=3D'11,23'/>
<cpu id=3D'12' socket_id=3D'0' core_id=3D'0' siblings=3D'0,12'/>
<cpu id=3D'13' socket_id=3D'0' core_id=3D'1' siblings=3D'1,13'/>
<cpu id=3D'14' socket_id=3D'0' core_id=3D'2' siblings=3D'2,14'/>
<cpu id=3D'15' socket_id=3D'0' core_id=3D'4' siblings=3D'3,15'/>
<cpu id=3D'16' socket_id=3D'0' core_id=3D'5' siblings=3D'4,16'/>
<cpu id=3D'17' socket_id=3D'0' core_id=3D'6' siblings=3D'5,17'/>
<cpu id=3D'18' socket_id=3D'0' core_id=3D'8' siblings=3D'6,18'/>
<cpu id=3D'19' socket_id=3D'0' core_id=3D'9' siblings=3D'7,19'/>
<cpu id=3D'20' socket_id=3D'0' core_id=3D'10' siblings=3D'8,20'/>
<cpu id=3D'21' socket_id=3D'0' core_id=3D'12' siblings=3D'9,21'/>
<cpu id=3D'22' socket_id=3D'0' core_id=3D'13' siblings=3D'10,22'/>
<cpu id=3D'23' socket_id=3D'0' core_id=3D'14' siblings=3D'11,23'/>

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1856335

Title:
  Cache Layout wrong on many Zen Arch CPUs

Status in QEMU:
  New

Bug description:
  AMD CPUs have L3 cache per 2, 3 or 4 cores. Currently, TOPOEXT seems
  to always map Cache ass if it was an 4-Core per CCX CPU, which is
  incorrect, and costs upwards 30% performance (more realistically 10%)
  in L3 Cache Layout aware applications.

  Example on a 4-CCX CPU (1950X /w 8 Cores and no SMT):

  =C2=A0=C2=A0<cpu mode=3D'custom' match=3D'exact' check=3D'full'>
  =C2=A0=C2=A0=C2=A0=C2=A0<model fallback=3D'forbid'>EPYC-IBPB</model>
  =C2=A0=C2=A0=C2=A0=C2=A0<vendor>AMD</vendor>
  =C2=A0=C2=A0=C2=A0=C2=A0<topology sockets=3D'1' cores=3D'8' threads=3D'1'=
/>

  In windows, coreinfo reports correctly:

  ****----  Unified Cache 1, Level 3,    8 MB, Assoc  16, LineSize  64
  ----****  Unified Cache 6, Level 3,    8 MB, Assoc  16, LineSize  64

  On a 3-CCX CPU (3960X /w 6 cores and no SMT):

  =C2=A0<cpu mode=3D'custom' match=3D'exact' check=3D'full'>
  =C2=A0=C2=A0=C2=A0=C2=A0<model fallback=3D'forbid'>EPYC-IBPB</model>
  =C2=A0=C2=A0=C2=A0=C2=A0<vendor>AMD</vendor>
  =C2=A0=C2=A0=C2=A0=C2=A0<topology sockets=3D'1' cores=3D'6' threads=3D'1'=
/>

  in windows, coreinfo reports incorrectly:

  ****--  Unified Cache  1, Level 3,    8 MB, Assoc  16, LineSize  64
  ----**  Unified Cache  6, Level 3,    8 MB, Assoc  16, LineSize  64

  Validated against 3.0, 3.1, 4.1 and 4.2 versions of qemu-kvm.

  With newer Qemu there is a fix (that does behave correctly) in using the =
dies parameter:
  =C2=A0<qemu:arg value=3D'cores=3D3,threads=3D1,dies=3D2,sockets=3D1'/>

  The problem is that the dies are exposed differently than how AMD does
  it natively, they are exposed to Windows as sockets, which means, that
  if you are nto a business user, you can't ever have a machine with
  more than two CCX (6 cores) as consumer versions of Windows only
  supports two sockets. (Should this be reported as a separate bug?)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1856335/+subscriptions

