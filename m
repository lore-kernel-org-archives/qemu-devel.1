Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2912EC1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 00:11:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8A2420757
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 00:11:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8A2420757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEMIs-0002pf-34
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 20:11:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38527)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jEMIH-0002Nx-Nx
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 20:10:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1jEMIG-0007i8-DP
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 20:10:45 -0400
Received: from indium.canonical.com ([91.189.90.7]:41432)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1jEMIF-0007dk-FJ
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 20:10:44 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jEMID-0005Rw-Er
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 00:10:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 683342E8029
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 00:10:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Mar 2020 00:01:05 -0000
From: Heiko Sieger <1811533@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Confirmed; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: dgilbert-h djdatte h-sieger vkuznets zaltysz
X-Launchpad-Bug-Reporter: =?utf-8?q?=C5=BDilvinas_=C5=BDaltiena_=28zaltysz?=
 =?utf-8?q?=29?=
X-Launchpad-Bug-Modifier: Heiko Sieger (h-sieger)
References: <154731859474.20612.3794172498936114295.malonedeb@soybean.canonical.com>
Message-Id: <158448966581.18971.13070337310099613086.malone@chaenomeles.canonical.com>
Subject: [Bug 1811533] Re: Unstable Win10 guest with qemu 3.1 + huge pages +
 hv_stimer
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="3a6db24bbe7280ec09bae73384238390fcc98ad3";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: a3cda4df2185e9c7b507e780d1a196d16b02115e
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
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
Reply-To: Bug 1811533 <1811533@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Also affects me when running Qemu 4.0.0 with -machine pc-q35-3.1. I get
this on the command line:

"qemu-system-x86_64: vhost_region_add_section: Overlapping but not
coherent sections at 11a000".

h/w: AMD Ryzen 3900X, Gigabyte Aorus Pro X570 (latest BIOS), kernel
5.3.0.

With -machine q35 (i.e. pc-q35-4.0) the machine crashes when soundhw is
specified. Here the quick and dirty command line:

qemu-system-x86_64 \
  -enable-kvm \
  -runas user \
  -serial none \
  -parallel none \
  -nodefaults \
  -name $vmname,process=3D$vmname \
  -machine pc-q35-3.1,accel=3Dkvm,mem-merge=3Doff,vmport=3Doff \
-cpu host,kvm=3Doff,+topoext,hv_vendor_id=3D1234567890ab,hv_vapic,hv_time,h=
v_relaxed,hv_spinlocks=3D0x1fff,hv_crash,hv_reset,hv_vpindex,hv_runtime,hv_=
synic,hv_stimer \
  -smp 24,sockets=3D1,cores=3D12,threads=3D2 \
    -global ICH9-LPC.disable_s3=3D1 \
    -global ICH9-LPC.disable_s4=3D1 \
  -m 48G \
-mem-path /dev/hugepages \
-mem-prealloc \
  -rtc base=3Dlocaltime,clock=3Dhost,driftfix=3Dslew  \
-soundhw hda \
-audiodev pa,id=3Dpa1,server=3D/run/user/1000/pulse/native \
  -vga none \
  -nographic \
-usb \
-device usb-host,vendorid=3D0x046d,productid=3D0xc52b \
-device ioh3420,id=3Droot_port1,chassis=3D1,bus=3Dpcie.0,addr=3D03.0 \
-device vfio-pci,host=3D0b:00.0,id=3Dhostdev1,bus=3Droot_port1,addr=3D0x00,=
multifunction=3Don \
-device vfio-pci,host=3D0b:00.1,id=3Dhostdev2,bus=3Droot_port1,addr=3D0x00.=
1 \
  -drive if=3Dpflash,format=3Draw,readonly,file=3D/usr/share/OVMF/OVMF_CODE=
.fd \
  -drive if=3Dpflash,format=3Draw,file=3D/tmp/my_vars.fd \
...

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1811533

Title:
  Unstable Win10 guest with qemu 3.1 + huge pages + hv_stimer

Status in QEMU:
  Confirmed

Bug description:
  Host:
  Gentoo linux x86_64, kernel 4.20.1
  Qemu 3.1.0 =

  CPU: Intel i7 6850K
  Chipset: X99

  Guest:
  Windows 10 Pro 64bit (1809)
  Machine type: pc-q35_3.1
  Hyper-V enlightenments: hv_stimer,hv_reenlightenment,hv_frequencies,hv_va=
pic,hv_reset,hv_synic,hv_runtime,hv_vpindex,hv_time,hv_relaxed,hv_spinlocks=
=3D0x1fff
  Memory: 16GB backed by 2MB huge pages

  Issue:
  Once guest is started, log gets flooded with:

  qemu-system-x86_64: vhost_region_add_section: Overlapping but not
  coherent sections at 103000

  or

  qemu-system-x86_64: vhost_region_add_section:Section rounded to 0
  prior to previous 1f000

  (line endings change)

  and as time goes guest loses network access (virtio-net-pci) and
  general performance diminishes to extent of freezing applications.

  Observations:
  1) problem disappears when hv_stimer is removed
  2) problem disappears when memory backing with huge pages is disabled
  3) problem disappears when machine type is downgraded to pc-q35_3.0

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1811533/+subscriptions

