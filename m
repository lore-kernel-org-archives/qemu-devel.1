Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45436C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 12:42:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15B9120679
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 12:42:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15B9120679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfjlT-0004oR-Bn
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 08:42:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54098)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jfjkU-0003xY-EN
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 08:41:02 -0400
Received: from indium.canonical.com ([91.189.90.7]:58334)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jfjkT-0004oj-2w
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 08:41:02 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jfjkP-0000kq-Kc
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 12:40:57 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id E21DD2E8131
 for <qemu-devel@nongnu.org>; Mon,  1 Jun 2020 12:40:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2020 12:33:16 -0000
From: sles <1844053@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: jamespharvey20 slesru
X-Launchpad-Bug-Reporter: James Harvey (jamespharvey20)
X-Launchpad-Bug-Modifier: sles (slesru)
References: <156855280668.581.6516749257263798071.malonedeb@wampee.canonical.com>
Message-Id: <159101479636.13151.4189723858312481406.malone@soybean.canonical.com>
Subject: [Bug 1844053] Re: task blocked for more than X seconds - events
 drm_fb_helper_dirty_work
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="275d46a24253e557e4403d52832837e4bfa425b6";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: ce297d88a7f64596d6fdf0a717d3f3849df7ce68
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/01 08:40:59
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
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
Reply-To: Bug 1844053 <1844053@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I have the same problem running ubuntu 20.04 on Centos 7 host with
qlx...

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1844053

Title:
  task blocked for more than X seconds - events drm_fb_helper_dirty_work

Status in QEMU:
  New

Bug description:
  I've had bunches of these errors on 9 different boots, between
  2019-08-21 and now, with Arch host and guest, from linux 5.1.16 to
  5.2.14 on host and guest, with QEMU 4.0.0 and 4.1.0.  spice 0.14.2,
  spice-gtk 0.37, spice-protocol 0.14.0, virt-viewer 8.0.

  I've been fighting with some other issues related to a 5.2 btrfs
  regression, a QEMU qxl regression (see bug 1843151) which I ran into
  when trying to temporarily abandon virtio-vga, and I haven't paid
  enough attention to what impact specifically this virtio_gpu issue has
  on the system In journalctl, I can see I often rebooted minutes after
  they occurred, but sometimes much later.  That must mean whenever I
  saw it happen that I rebooted the VM, or potentially it impacted
  functionality of the system.

  Please let me know if and how I can get more information for you if
  needed.

  I've replicated this on both a system with integrated ASPEED video,
  and on an AMD Vega 64 running amdgpu.

  As an example, I have one boot which reported at 122 seconds, 245,
  368, 491, 614, 737, 860, 983, 1105, 1228, then I rebooted.

  I have another that reported 122/245/368/491/614/737, went away for 10
  minutes, then started reporting again 122/245/368/491, and went away.
  Then, I rebooted about 20 hours later.

  Host system has no graphical impact when this happens, and logs
  nothing in its journalctl.

  Guest is tty mode only, with kernel argument "video=3D1280x1024".  No x
  server.

  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

  INFO: task kworker/0:1:15 blocked for more than 122 seconds.
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Not tainted 5.2.14-1 #1
  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
  kworker/0:1     D    0    15      2 0x800004000
  Workqueue: events drm_fb_helper_dirty_work [drm_kms_helper]
  Call Trace:
  =C2=A0? __schedule+0x27f/0x6d0
  =C2=A0schedule+0x3d/0xc0
  =C2=A0virtio_gpu_queue_fenced_ctrl_buffer+0xa1/0x130 [virtio_gpu]
  =C2=A0? wait_woken+0x80/0x80
  =C2=A0virtio_gpu_surface_dirty+0x2a5/0x300 [virtio_gpu]
  =C2=A0drm_fb_helper_dirty_work+0x156/0x160 [drm_kms_helper]
  =C2=A0process_one_work+0x19a/0x3b0
  =C2=A0worker_tread+0x50/0x3a0
  =C2=A0kthread+0xfd/0x130
  =C2=A0? process_one_work+0x3b0/0x3b0
  =C2=A0? kthread_park+0x80/0x80
  =C2=A0ret_from_fork+0x35/0x40

  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

  /usr/bin/qemu-system-x86_64 \
  =C2=A0=C2=A0=C2=A0-name vm,process=3Dqemu:vm \
  =C2=A0=C2=A0=C2=A0-no-user-config \
  =C2=A0=C2=A0=C2=A0-nodefaults \
  =C2=A0=C2=A0=C2=A0-nographic \
  =C2=A0=C2=A0=C2=A0-uuid <uuid> \
  =C2=A0=C2=A0=C2=A0-pidfile <pidfile> \
  =C2=A0=C2=A0=C2=A0-machine q35,accel=3Dkvm,vmport=3Doff,dump-guest-core=
=3Doff \
  =C2=A0=C2=A0=C2=A0-cpu SandyBridge-IBRS \
  =C2=A0=C2=A0=C2=A0-smp cpus=3D4,cores=3D2,threads=3D1,sockets=3D2 \
  =C2=A0=C2=A0=C2=A0-m 4G \
  =C2=A0=C2=A0=C2=A0-drive if=3Dpflash,format=3Draw,readonly,file=3D/usr/sh=
are/ovmf/x64/OVMF_CODE.fd \
  =C2=A0=C2=A0=C2=A0-drive if=3Dpflash,format=3Draw,file=3D/var/qemu/efivar=
s/vm.fd \
  =C2=A0=C2=A0=C2=A0-monitor telnet:localhost:8000,server,nowait,nodelay \
  =C2=A0=C2=A0=C2=A0-spice unix,addr=3D/tmp/spice.vm.sock,disable-ticketing=
 \
  =C2=A0=C2=A0=C2=A0-device ioh3420,id=3Dpcie.1,bus=3Dpcie.0,slot=3D0 \
  =C2=A0=C2=A0=C2=A0-device virtio-vga,bus=3Dpcie.1,addr=3D0 \
  =C2=A0=C2=A0=C2=A0-usbdevice tablet \
  =C2=A0=C2=A0=C2=A0-netdev bridge,id=3Dnetwork0,br=3Dbr0 \
  =C2=A0=C2=A0=C2=A0-device virtio-net-pci,netdev=3Dnetwork0,mac=3DF4:F6:34=
:F6:34:2d,bus=3Dpcie.0,addr=3D3 \
  =C2=A0=C2=A0=C2=A0-device virtio-scsi-pci,id=3Dscsi1 \
  =C2=A0=C2=A0=C2=A0-drive driver=3Draw,node-name=3Dhd0,file=3D/dev/lvm/vm,=
if=3Dnone,discard=3Dunmap,cache=3Dnone,aio=3Dthreads

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1844053/+subscriptions

