Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F8C9C2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 12:37:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A42A120756
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 12:37:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A42A120756
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY7B0-00025b-LN
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 08:37:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kY79g-0001O3-0x
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 08:35:48 -0400
Received: from indium.canonical.com ([91.189.90.7]:58744)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kY79d-0006lE-LX
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 08:35:47 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kY79b-00012x-E4
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 12:35:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 6956B2E804E
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 12:35:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2020 12:23:28 -0000
From: Gustavo Romero <1900241@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided;
 assignee=gromero@br.ibm.com; 
X-Launchpad-Bug-Tags: kvm powerpc xive
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: sathnaga
X-Launchpad-Bug-Reporter: Satheesh Rajendran (sathnaga)
X-Launchpad-Bug-Modifier: Gustavo Romero (gromero)
References: <160293454254.8431.993577940537988142.malonedeb@chaenomeles.canonical.com>
Message-Id: <160397420933.8731.9491736527520602012.launchpad@soybean.canonical.com>
Subject: [Bug 1900241] Re: [regression][powerpc] some vcpus are found offline
 inside guest with different vsmt setting from qemu-cmdline and breaks
 subsequent vcpu hotplug operation (xive)
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="96ff31b88b65a0d0ea73b89333fe7c4a2669d8fb"; Instance="production"
X-Launchpad-Hash: c7dcd3e4acd2e72641997c6aa2213dc4d9a722ab
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 08:35:43
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_HI=-5,
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

** Changed in: qemu
     Assignee: (unassigned) =3D> Gustavo Romero (gromero)

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

