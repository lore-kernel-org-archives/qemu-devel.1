Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76069C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 04:27:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CC8420734
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 04:27:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CC8420734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k4zOp-000507-F8
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 00:27:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50614)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k4zOE-0004Y2-6R
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 00:26:26 -0400
Received: from indium.canonical.com ([91.189.90.7]:42022)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k4zOB-0005jN-B0
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 00:26:25 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k4zO6-0004E5-Cn
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 04:26:18 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 608452E820F
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 04:26:09 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2020 04:17:29 -0000
From: Launchpad Bug Tracker <1674117@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Expired; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: pulse-audio
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: hansp-schulz janitor th-huth
X-Launchpad-Bug-Reporter: 3vIL_VIrUs (hansp-schulz)
X-Launchpad-Bug-Modifier: Launchpad Janitor (janitor)
References: <20170319163002.19988.72829.malonedeb@soybean.canonical.com>
Message-Id: <159703305003.12388.8037761849332196076.malone@loganberry.canonical.com>
Subject: [Bug 1674117] Re: Qemu VM start kills Pulseaudio
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="6a138c03da9cc3e2e03f6dd3bbb4a615b0be6ec2";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: e3ebb810b3d8fb1c3dbb23e7375ec5db571c36c6
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 00:26:20
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Bug 1674117 <1674117@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1674117

Title:
  Qemu VM start kills Pulseaudio

Status in QEMU:
  Expired

Bug description:
  When I start a VM (start command below) in Qemu version >2.5, it kills Pu=
lseaudio (paired with a huge lagspike) in ~4/5 cases. Using version 2.5 bui=
ld from GIT, it works fine. This also happens when building from the curren=
t GIT master (ebedf0f).
  Host:
    Freshly installed Antergos Arch Linux 4.10.3-1-ARCH
    Intel I7-5930K
    ASUS X99 Deluxe II latest UEFI
    GTX 770

  Guest:
    Windows 10 x64
    AMD RX480 via VFIO

  This also happened on my last install (Ubuntu GNOME 16.10).

  Start command:
    QEMU_AUDIO_DRV=3Dpa \
    QEMU_PA_SAMPLES=3D4096 \
    qemu-system-x86_64 \
      -serial none \
      -parallel none \
      -nodefconfig \
      -nodefaults \
      -name win10 \
      -enable-kvm \
      -cpu host,check,kvm=3Doff \
      -smp 12,sockets=3D1,cores=3D6,threads=3D2 \
      -m 16G \
      -mem-prealloc \
      -device nec-usb-xhci,id=3Dxhci \
      -device usb-host,vendorid=3D0x05ac,productid=3D0x0205,bus=3Dxhci.0 \
      -net nic,vlan=3D0,model=3Dvirtio \
      -net bridge,vlan=3D0,br=3Dbridge0 \
      -object iothread,id=3Diothread0 \
      -device virtio-blk-pci,iothread=3Diothread0,drive=3Ddrive0 \
      -drive file=3D"$DISK",format=3Draw,if=3Dnone,cache=3Dnone,aio=3Dnativ=
e,id=3Ddrive0 \
      -boot order=3Dc,menu=3Don \
      -rtc base=3Dutc \
      -nographic \
      -k de \
      -monitor stdio \
      -soundhw hda \
      -device vfio-pci,host=3D02:00.0,addr=3D09.0,multifunction=3Don,x-vga=
=3Don \
      -device vfio-pci,host=3D02:00.1,addr=3D09.1 \
      -device vfio-pci,host=3D04:00.0,addr=3D07.0,multifunction=3Don,id=3Du=
sbcontroller

  When it kills Pulseaudio, I see these errors in the Qemu console:
    pulseaudio: set_sink_input_volume() failed
    pulseaudio: Reason: Bad state
    pulseaudio: set_sink_input_mute() failed
    pulseaudio: Reason: Bad state
    pulseaudio: set_source_output_volume() failed
    ... many more of these ...

  The journal shows that PulseAudio is killed:
    M=C3=A4r 19 13:12:42 hp-desktop systemd[530]: pulseaudio.service: Main =
process exited, code=3Dkilled, status=3D9/KILL
    M=C3=A4r 19 13:12:42 hp-desktop systemd[530]: pulseaudio.service: Unit =
entered failed state.
    M=C3=A4r 19 13:12:42 hp-desktop systemd[530]: pulseaudio.service: Faile=
d with result 'signal'.
    M=C3=A4r 19 13:12:42 hp-desktop systemd[530]: pulseaudio.service: Servi=
ce hold-off time over, scheduling restart.
    M=C3=A4r 19 13:12:42 hp-desktop systemd[530]: Stopped Sound Service.
    M=C3=A4r 19 13:12:42 hp-desktop systemd[530]: Starting Sound Service...

  I've also captured a PulseAudio debug log when this happens, but it
  does not contain anything interesting (no warnings or errors), which
  makes sense in case of SIGKILL.

  In DMESG I get some errors too, but they seem to be just symptoms (but Im=
 just guessing...); 00:14.0 is the USB controller my DAC is connected to:
    [ 4372.389051] usb 3-9.4: current rate 4500480 is different from the ru=
ntime rate 44100
    [ 4372.509163] usb 3-9.4: current rate 4500480 is different from the ru=
ntime rate 44100
    [ 4372.559104] usb 3-9.4: current rate 4500480 is different from the ru=
ntime rate 44100
    [ 4373.652557] xhci_hcd 0000:00:14.0: ERROR unknown event type 37
    [ 4373.712382] xhci_hcd 0000:00:14.0: ERROR Transfer event TRB DMA ptr =
not part of current TD ep_index 1 comp_code 36
    [ 4373.715714] xhci_hcd 0000:00:14.0: Looking for event-dma 0000000745d=
a7f00 trb-start 0000000745da7f10 trb-end 0000000745da7f10 seg-start 0000000=
745da7000 seg-end 0000000745da7ff0
    [ 4373.719055] xhci_hcd 0000:00:14.0: ERROR Transfer event TRB DMA ptr =
not part of current TD ep_index 1 comp_code 1
    [ 4373.722381] xhci_hcd 0000:00:14.0: Looking for event-dma 0000000745d=
a7f00 trb-start 0000000745da7f10 trb-end 0000000745da7f10 seg-start 0000000=
745da7000 seg-end 0000000745da7ff0
    [ 4373.725753] xhci_hcd 0000:00:14.0: ERROR Transfer event TRB DMA ptr =
not part of current TD ep_index 4 comp_code 13
    [ 4373.725759] xhci_hcd 0000:00:14.0: Looking for event-dma 000000073c5=
a51a0 trb-start 000000073c5a51b0 trb-end 000000073c5a51b0 seg-start 0000000=
73c5a5000 seg-end 000000073c5a5ff0

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1674117/+subscriptions

