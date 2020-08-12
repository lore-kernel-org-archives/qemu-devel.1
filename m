Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EABDC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 00:41:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D50D22080C
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 00:41:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D50D22080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5epq-0007pm-Vn
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 20:41:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56318)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k5ep2-0007Np-PS
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 20:40:52 -0400
Received: from indium.canonical.com ([91.189.90.7]:39812)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k5ep0-0007Bl-48
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 20:40:52 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k5eoy-0000KB-5g
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 00:40:48 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id F25572E808D
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 00:40:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2020 00:35:26 -0000
From: TheCatFelix <1884684@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: thecatfelix
X-Launchpad-Bug-Reporter: TheCatFelix (thecatfelix)
X-Launchpad-Bug-Modifier: TheCatFelix (thecatfelix)
References: <159287262873.13509.14889128175029136647.malonedeb@wampee.canonical.com>
Message-Id: <159719252686.22410.14525350364562879837.malone@chaenomeles.canonical.com>
Subject: [Bug 1884684] Re: QEMU 5.0: Guest VM hangs/freeze when unplugging USB
 device
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="6a138c03da9cc3e2e03f6dd3bbb4a615b0be6ec2";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 8b8dd302d208aec5b409e45f5a669d3bd006650f
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 20:40:48
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Bug 1884684 <1884684@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I do get get the same backtrace in gdb every time every time when we
reproduce the hang:

(gdb) thread apply all bt

Thread 9 (Thread 0x7fd1415ff700 (LWP 3202)):
#0  0x00007fd323d154bf in __GI___poll (fds=3D0x7fd1415fe6c0, nfds=3D2, time=
out=3D-1) at ../sysdeps/unix/sysv/linux/poll.c:29
#1  0x00007fd324978bb2 in ?? () from target:/lib/x86_64-linux-gnu/libusb-1.=
0.so.0
#2  0x00007fd323defea7 in start_thread (arg=3D<optimized out>) at pthread_c=
reate.c:477
#3  0x00007fd323d1feaf in clone () at ../sysdeps/unix/sysv/linux/x86_64/clo=
ne.S:95

Thread 8 (Thread 0x7fd1437fe700 (LWP 3171)):
#0  0x00007fd323d16d87 in ioctl () at ../sysdeps/unix/syscall-template.S:120
#1  0x000055a5daef74f7 in kvm_vcpu_ioctl ()
#2  0x000055a5daef7631 in kvm_cpu_exec ()
#3  0x000055a5daedaede in ?? ()
#4  0x000055a5db32194b in ?? ()
#5  0x00007fd323defea7 in start_thread (arg=3D<optimized out>) at pthread_c=
reate.c:477
#6  0x00007fd323d1feaf in clone () at ../sysdeps/unix/sysv/linux/x86_64/clo=
ne.S:95

Thread 7 (Thread 0x7fd143fff700 (LWP 3170)):
#0  0x00007fd323d16d87 in ioctl () at ../sysdeps/unix/syscall-template.S:120
#1  0x000055a5daef74f7 in kvm_vcpu_ioctl ()
#2  0x000055a5daef7631 in kvm_cpu_exec ()
#3  0x000055a5daedaede in ?? ()
#4  0x000055a5db32194b in ?? ()
#5  0x00007fd323defea7 in start_thread (arg=3D<optimized out>) at pthread_c=
reate.c:477
#6  0x00007fd323d1feaf in clone () at ../sysdeps/unix/sysv/linux/x86_64/clo=
ne.S:95

Thread 6 (Thread 0x7fd150dfd700 (LWP 3169)):
#0  __lll_lock_wait (futex=3Dfutex@entry=3D0x55a5db80a540, private=3D0) at =
lowlevellock.c:52
#1  0x00007fd323df2843 in __GI___pthread_mutex_lock (mutex=3D0x55a5db80a540=
) at ../nptl/pthread_mutex_lock.c:80
#2  0x000055a5db321b43 in qemu_mutex_lock_impl ()
#3  0x000055a5daedac8e in qemu_mutex_lock_iothread_impl ()
#4  0x000055a5dae92ac9 in ?? ()
#5  0x000055a5dae97de7 in flatview_read_continue ()
#6  0x000055a5dae98023 in ?? ()
#7  0x000055a5dae9813b in address_space_read_full ()
#8  0x000055a5daef78cf in kvm_cpu_exec ()
#9  0x000055a5daedaede in ?? ()
#10 0x000055a5db32194b in ?? ()
#11 0x00007fd323defea7 in start_thread (arg=3D<optimized out>) at pthread_c=
reate.c:477
#12 0x00007fd323d1feaf in clone () at ../sysdeps/unix/sysv/linux/x86_64/clo=
ne.S:95

Thread 5 (Thread 0x7fd1515fe700 (LWP 3168)):
#0  __lll_lock_wait (futex=3Dfutex@entry=3D0x55a5db80a540, private=3D0) at =
lowlevellock.c:52
#1  0x00007fd323df2843 in __GI___pthread_mutex_lock (mutex=3D0x55a5db80a540=
) at ../nptl/pthread_mutex_lock.c:80
#2  0x000055a5db321b43 in qemu_mutex_lock_impl ()
#3  0x000055a5daedac8e in qemu_mutex_lock_iothread_impl ()
#4  0x000055a5dae92ac9 in ?? ()
#5  0x000055a5dae97de7 in flatview_read_continue ()
#6  0x000055a5dae98023 in ?? ()
#7  0x000055a5dae9813b in address_space_read_full ()
#8  0x000055a5daef78cf in kvm_cpu_exec ()
#9  0x000055a5daedaede in ?? ()
#10 0x000055a5db32194b in ?? ()
#11 0x00007fd323defea7 in start_thread (arg=3D<optimized out>) at pthread_c=
reate.c:477
#12 0x00007fd323d1feaf in clone () at ../sysdeps/unix/sysv/linux/x86_64/clo=
ne.S:95

Thread 4 (Thread 0x7fd151dff700 (LWP 3167)):
#0  __lll_lock_wait (futex=3Dfutex@entry=3D0x55a5db80a540, private=3D0) at =
lowlevellock.c:52
#1  0x00007fd323df2843 in __GI___pthread_mutex_lock (mutex=3D0x55a5db80a540=
) at ../nptl/pthread_mutex_lock.c:80
--Type <RET> for more, q to quit, c to continue without paging--
#2  0x000055a5db321b43 in qemu_mutex_lock_impl ()
#3  0x000055a5daedac8e in qemu_mutex_lock_iothread_impl ()
#4  0x000055a5dae92ac9 in ?? ()
#5  0x000055a5dae97de7 in flatview_read_continue ()
#6  0x000055a5dae98023 in ?? ()
#7  0x000055a5dae9813b in address_space_read_full ()
#8  0x000055a5daef78cf in kvm_cpu_exec ()
#9  0x000055a5daedaede in ?? ()
#10 0x000055a5db32194b in ?? ()
#11 0x00007fd323defea7 in start_thread (arg=3D<optimized out>) at pthread_c=
reate.c:477
#12 0x00007fd323d1feaf in clone () at ../sysdeps/unix/sysv/linux/x86_64/clo=
ne.S:95

Thread 3 (Thread 0x7fd320d97700 (LWP 3166)):
#0  0x00007fd323d154bf in __GI___poll (fds=3D0x7fd318003180, nfds=3D3, time=
out=3D-1) at ../sysdeps/unix/sysv/linux/poll.c:29
#1  0x00007fd324a097ee in ?? () from target:/lib/x86_64-linux-gnu/libglib-2=
.0.so.0
#2  0x00007fd324a09b53 in g_main_loop_run () from target:/lib/x86_64-linux-=
gnu/libglib-2.0.so.0
#3  0x000055a5db016c71 in ?? ()
#4  0x000055a5db32194b in ?? ()
#5  0x00007fd323defea7 in start_thread (arg=3D<optimized out>) at pthread_c=
reate.c:477
#6  0x00007fd323d1feaf in clone () at ../sysdeps/unix/sysv/linux/x86_64/clo=
ne.S:95

Thread 2 (Thread 0x7fd3224de700 (LWP 3156)):
#0  syscall () at ../sysdeps/unix/sysv/linux/x86_64/syscall.S:38
#1  0x000055a5db3226fa in qemu_event_wait ()
#2  0x000055a5db33466a in ?? ()
#3  0x000055a5db32194b in ?? ()
#4  0x00007fd323defea7 in start_thread (arg=3D<optimized out>) at pthread_c=
reate.c:477
#5  0x00007fd323d1feaf in clone () at ../sysdeps/unix/sysv/linux/x86_64/clo=
ne.S:95

Thread 1 (Thread 0x7fd3224dff40 (LWP 3148)):
#0  0x00007fd323d154bf in __GI___poll (fds=3D0x55a5dca30150, nfds=3D3, time=
out=3D3) at ../sysdeps/unix/sysv/linux/poll.c:29
#1  0x00007fd324971f4d in ?? () from target:/lib/x86_64-linux-gnu/libusb-1.=
0.so.0
#2  0x00007fd32497316c in libusb_handle_events_timeout_completed () from ta=
rget:/lib/x86_64-linux-gnu/libusb-1.0.so.0
#3  0x000055a5db18edc7 in ?? ()
#4  0x000055a5db18efab in ?? ()
#5  0x000055a5db31abf7 in aio_bh_poll ()
#6  0x000055a5db31e3fe in aio_dispatch ()
#7  0x000055a5db31aace in ?? ()
#8  0x00007fd324a095fd in g_main_context_dispatch () from target:/lib/x86_6=
4-linux-gnu/libglib-2.0.so.0
#9  0x000055a5db31d638 in main_loop_wait ()
#10 0x000055a5dafad309 in qemu_main_loop ()
#11 0x000055a5dae9125e in main ()
(gdb)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1884684

Title:
  QEMU 5.0: Guest VM hangs/freeze when unplugging USB device

Status in QEMU:
  New

Bug description:
  Setup:

  Host: Debian/SID, Kernel 5.6, QEMU 5.0
  Guest: Windows 10 VM with PCI and USB device passthrough.

  Problem: Guest VM suddenly hangs when pulling USB device out from the
  Host.

  Observations:
   - Issue appears to be related to QEMU 5.0
     - It started after an upgrade to QEMU 5.0.
     - Downgrading only QEMU on multiple systems fixes the issue.

   - Issue is very reproducible.
     - Most of the time within a few attempts of pulling/reconnecting the d=
evice.
     - Issue happens with multiple devices (I did try standard HID devices,=
 a webcam and an x-ray sensor).

   - Guest just hangs.
     - Display output remains on last frame shown.
     - Ping to Guest immediately stops working.
     - Logs in the Guest stop logging immediately.

   - Host is fine and thinks the Guest is fine. =

     - Guest continues to show as running in "virsh list".
     - No suspicious entries in the QEMU logs.
     - No suspicious entries in Host syslogs/messages.
     - Host can can kill guest "virsh destroy" and respawn fine.

   - Issue seems widespread.
     - Multiple similar reports from ProxMox users after upgrade to ProxMox=
 6.2 for both Windows and Linux guests (First version that uses QEMU 5.0)

  https://forum.proxmox.com/threads/vm-freezes-when-disconnecting-usb-keybo=
ard-and-mouse.70287/
  https://forum.proxmox.com/threads/usb-drive-crashes-vm.70214/
  https://forum.proxmox.com/threads/latest-proxmox-usb-disconnects-freeze-k=
vm.70398/
  https://forum.proxmox.com/threads/vm-with-gpu-passthrough-freezes-when-tu=
rning-off-monitor-after-proxmox-6-2-upgrade.69821/
  https://forum.proxmox.com/threads/vm-with-gpu-passthrough-freezes-when-tu=
rning-off-monitor-after-proxmox-6-2-upgrade.69824/

  I'd be more than happy any debugs that might be helpful.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1884684/+subscriptions

