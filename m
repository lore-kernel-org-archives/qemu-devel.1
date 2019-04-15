Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5FC5C282DA
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 16:04:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9145220684
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 16:04:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9145220684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52475 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hG45R-0005ig-9Z
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 12:04:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hG43U-0004SO-Q4
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 12:02:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hG43S-0005Tz-QK
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 12:02:00 -0400
Received: from indium.canonical.com ([91.189.90.7]:60860)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hG43R-0005Nw-8z
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 12:01:58 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hG43P-0005yJ-Eu
	for <qemu-devel@nongnu.org>; Mon, 15 Apr 2019 16:01:55 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 6F2DE2E80CB
	for <qemu-devel@nongnu.org>; Mon, 15 Apr 2019 16:01:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Apr 2019 15:46:49 -0000
From: Marc Hartmayer <1788582@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: lizhengui mhartmay
X-Launchpad-Bug-Reporter: Marc Hartmayer (mhartmay)
X-Launchpad-Bug-Modifier: Marc Hartmayer (mhartmay)
References: <153501548405.31458.2315196104370535583.malonedeb@soybean.canonical.com>
Message-Id:
 <155534321004.20376.8498307131032941296.malone@soybean.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18920";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 4f35176d28e92fdd51f8ffde7e6119264ee46bad
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1788582] Re: Race condition during shutdown
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1788582 <1788582@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190415154649.ezbFJAzobfN_swHzFOAxmy7cHfRt6qCFstMoo52si4o@z>

It was fixed with commit 4cf077b59fc73eec29f8b7 (see patch series
https://lists.gnu.org/archive/html/qemu-block/2018-09/msg00504.html).

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1788582

Title:
  Race condition during shutdown

Status in QEMU:
  New

Bug description:
  I ran into a bug when I started several VMs in parallel using
  libvirt. The VMs are using only a kernel and a initrd (which includes a
  minimal OS). The guest OS itself does a 'poweroff -f' as soon as the
  login prompt shows up. So the expectaction is that the VMs will start,
  the shutdown will be initiated, and the QEMU processes will then
  end. But instead some of the QEMU processes get stuck in ppoll().

  A bisect showed that the first bad commit was
  0f12264e7a41458179ad10276a7c33c72024861a ("block: Allow graph changes in
  bdrv_drain_all_begin/end sections").

  I've already tried the current master (13b7b188501d419a7d63c016e00065bcc6=
93b7d4) =

  since the problem might be related
  to the commit a1405acddeb0af6625dd9c30e8277b08e0885bd3 ("aio: Do
  aio_notify_accept only during blocking aio_poll"). But the bug is still
  there. I=E2=80=99ve reproduced the bug on x86_64 and on s390x.

  The backtrace of a hanging QEMU process:

  (gdb) bt
  #0  0x00007f5d0e251b36 in ppoll () from target:/lib64/libc.so.6
  #1  0x0000560191052014 in qemu_poll_ns (fds=3D0x560193b23d60, nfds=3D5, t=
imeout=3D55774838936000) at /home/user/git/qemu/util/qemu-timer.c:334
  #2  0x00005601910531fa in os_host_main_loop_wait (timeout=3D5577483893600=
0) at /home/user/git/qemu/util/main-loop.c:233
  #3  0x0000560191053119 in main_loop_wait (nonblocking=3D0) at /home/user/=
git/qemu/util/main-loop.c:497
  #4  0x0000560190baf454 in main_loop () at /home/user/git/qemu/vl.c:1866
  #5  0x0000560190baa552 in main (argc=3D71, argv=3D0x7ffde10e41c8, envp=3D=
0x7ffde10e4408) at /home/user/git/qemu/vl.c:4644

  The used domain definition is:

  <domain type=3D'kvm'>
    <name>test</name>
    <memory unit=3D'KiB'>716800</memory>
    <vcpu placement=3D'static'>2</vcpu>
    <iothreads>8</iothreads>
    <os>
      <type arch=3D'x86_64' machine=3D'pc-i440fx-3.0'>hvm</type>
      <kernel>/var/lib/libvirt/images/vmlinuz-4.14.13-200.fc26.x86_64</kern=
el>
      <initrd>/var/lib/libvirt/images/test-image-qemux86_64+modules-4.14.13=
-200.fc26.x86_64.cpio.gz</initrd>
      <cmdline>console=3Dhvc0 STARTUP=3Dshutdown.sh</cmdline>
      <boot dev=3D'hd'/>
    </os>
    <features>
      <acpi/>
    </features>
    <clock offset=3D'utc'/>
    <on_poweroff>destroy</on_poweroff>
    <on_reboot>restart</on_reboot>
    <on_crash>preserve</on_crash>
    <devices>
      <emulator>/usr/local/qemu/master/bin/qemu-system-x86_64</emulator>
      <controller type=3D'usb' index=3D'0' model=3D'piix3-uhci'>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x01' =
function=3D'0x2'/>
      </controller>
      <controller type=3D'pci' index=3D'0' model=3D'pci-root'/>
      <controller type=3D'virtio-serial' index=3D'0'>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x02' =
function=3D'0x0'/>
      </controller>
      <console type=3D'pty'>
        <target type=3D'virtio' port=3D'0'/>
      </console>
      <input type=3D'mouse' bus=3D'ps2'/>
      <input type=3D'keyboard' bus=3D'ps2'/>
      <memballoon model=3D'none'/>
    </devices>
  </domain>

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1788582/+subscriptions

