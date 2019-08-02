Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8701AC32750
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 18:19:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60E7A2171F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 18:19:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60E7A2171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htc9H-0003Hq-JJ
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 14:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57731)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1htbrx-0005RF-UE
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 14:01:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1htbrw-0004xg-3v
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 14:01:33 -0400
Received: from indium.canonical.com ([91.189.90.7]:55904)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1htbrs-0004N5-7h
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 14:01:28 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1htbra-0001lN-JS
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2019 18:01:10 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 622782E80C9
 for <qemu-devel@nongnu.org>; Fri,  2 Aug 2019 18:01:10 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Aug 2019 17:52:29 -0000
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: icount nodefaults
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: bobby-prani hansni pmaydell
X-Launchpad-Bug-Reporter: Hansni Bu (hansni)
X-Launchpad-Bug-Modifier: Peter Maydell (pmaydell)
References: <20161229080217.16446.50840.malonedeb@wampee.canonical.com>
Message-Id: <156476834965.27696.15955601513466049353.malone@chaenomeles.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19014";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 7f85e206f5d546f663674a6eb00bb0d023749a8d
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1653063] Re: qemu-system-arm hangs with -icount
 and -nodefaults
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
Reply-To: Bug 1653063 <1653063@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I think we fixed this bug in commit 013aabdc665e4256b38d which would
have been in the 3.1.0 release (this is why we closed #1774677, which is
the same issue).


** Changed in: qemu
       Status: Confirmed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1653063

Title:
  qemu-system-arm hangs with -icount and -nodefaults

Status in QEMU:
  Fix Released

Bug description:
  I tested with release 2.8.0 and the latest git repo, (commit:
  dbe2b65566e76d3c3a0c3358285c0336ac61e757).

  My configure options when building QEMU:
  '../configure' '--prefix=3D$HOME/local/qemu.git' '--target-list=3Daarch64=
-softmmu,arm-softmmu' '--cpu=3Dx86_64' '--cc=3Dgcc' '--disable-user' '--dis=
able-sdl' '--disable-stack-protector' '--disable-attr' '--disable-pie' '--d=
isable-linux-aio' '--disable-tpm' '--without-system-pixman' '--disable-docs=
' '--disable-guest-agent' '--disable-guest-agent-msi' '--disable-modules' '=
--disable-sparse' '--disable-gnutls' '--disable-nettle' '--disable-gcrypt' =
'--disable-gtk' '--disable-vte' '--disable-curses' '--disable-vnc' '--disab=
le-cocoa' '--disable-virtfs' '--disable-xen' '--disable-brlapi' '--disable-=
curl' '--disable-bluez' '--disable-rdma' '--disable-uuid' '--disable-vde' '=
--disable-netmap' '--disable-cap-ng' '--disable-attr' '--disable-vhost-net'=
 '--disable-spice' '--disable-rbd' '--disable-libiscsi' '--disable-libnfs' =
'--disable-smartcard' '--disable-libusb' '--disable-usb-redir' '--disable-l=
zo' '--disable-snappy' '--disable-bzip2' '--disable-seccomp' '--disable-glu=
sterfs' '--disable-archipelago' '--disable-libssh2' '--disable-vhdx' '--dis=
able-numa' '--disable-werror' '--disable-blobs' '--disable-vhost-scsi' '--e=
nable-debug' '--disable-strip' '--enable-debug-tcg' '--enable-debug-info' '=
--extra-cflags=3D-fPIC'

  My host OS is Redhat RHEL-6.5. uname command gives:
  Linux rslpc1 2.6.32-431.el6.x86_64 #1 SMP Sun Nov 10 22:19:54 EST 2013 x8=
6_64 x86_64 x86_64 GNU/Linux

  The test image is downloaded from http://wiki.qemu.org/download/arm-
  test-0.2.tar.gz

  The command to re-produce the problem:
  qemu-system-arm -M integratorcp -kernel arm-test/zImage.integrator -initr=
d arm-test/arm_root.img -nographic -icount 1 -nodefaults -chardev stdio,mux=
=3Don,id=3Dchar0 -serial chardev:char0 --append "console=3DttyAMA0"

  After console prints the message below:
  "Uncompressing Linux.....................................................=
..................... done, booting the kernel."
  there's no further action noticed.

  If "-icount" is not set, namely run as:
  qemu-system-arm -M integratorcp -kernel arm-test/zImage.integrator -initr=
d arm-test/arm_root.img -nographic -nodefaults -chardev stdio,mux=3Don,id=
=3Dchar0 -serial chardev:char0 --append "console=3DttyAMA0"

  or if "-nodefaults" is not set, namely run as:
  qemu-system-arm -M integratorcp -kernel arm-test/zImage.integrator -initr=
d arm-test/arm_root.img -nographic -icount 1 --append "console=3DttyAMA0"

  The Linux boot procedure can finish successfully.

  Thanks.
  Hansni

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1653063/+subscriptions

