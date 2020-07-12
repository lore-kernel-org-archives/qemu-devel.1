Return-Path: <SRS0=QItv=AX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41EFC433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2020 12:26:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B263720674
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2020 12:26:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B263720674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jub3l-00015s-RR
	for qemu-devel@archiver.kernel.org; Sun, 12 Jul 2020 08:26:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jub3F-0000fd-Uc
 for qemu-devel@nongnu.org; Sun, 12 Jul 2020 08:25:49 -0400
Received: from indium.canonical.com ([91.189.90.7]:33098)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jub3C-0003UN-Rn
 for qemu-devel@nongnu.org; Sun, 12 Jul 2020 08:25:49 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jub39-00079s-SA
 for <qemu-devel@nongnu.org>; Sun, 12 Jul 2020 12:25:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id B6A662E80E7
 for <qemu-devel@nongnu.org>; Sun, 12 Jul 2020 12:25:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 12 Jul 2020 12:17:52 -0000
From: Michael Tokarev <1886318@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: mark-cave-ayland mjt+launchpad-tls sej7278
X-Launchpad-Bug-Reporter: Simon John (sej7278)
X-Launchpad-Bug-Modifier: Michael Tokarev (mjt+launchpad-tls)
References: <159394898604.17667.6684490731246411850.malonedeb@soybean.canonical.com>
Message-Id: <159455627295.7359.406798975618275772.malone@wampee.canonical.com>
Subject: [Bug 1886318] Re: Qemu after v5.0.0 breaks macos guests
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="4809fcb62f445aaa3ae919f7f6c3cc7d156ea57a";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 4fa6ec5b6f182e958453b6e2007c7b23b26cf6ca
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/12 04:40:51
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
Reply-To: Bug 1886318 <1886318@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I think we should add debugging patch by Mark to qemu too, =E2=80=94 I susp=
ect
there will be more cases like this, since this check were turned off for
a few years.  Maybe not as printf's but as logging, I dunno, but the
info it collects is really a must-have.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1886318

Title:
  Qemu after v5.0.0 breaks macos guests

Status in QEMU:
  New

Bug description:
  The Debian Sid 5.0-6 qemu-kvm package can no longer get further than
  the Clover bootloader whereas 5.0-6 and earlier worked fine.

  So I built qemu master from github and it has the same problem,
  whereas git tag v5.0.0 (or 4.2.1) does not, so something between
  v5.0.0 release and the last few days has caused the problem.

  Here's my qemu script, pretty standard macOS-Simple-KVM setup on a
  Xeon host:

  qemu-system-x86_64 \
      -enable-kvm \
      -m 4G \
      -machine q35,accel=3Dkvm \
      -smp 4,sockets=3D1,cores=3D2,threads=3D2 \
      -cpu =

  Penryn,vendor=3DGenuineIntel,kvm=3Don,+sse3,+sse4.2,+aes,+xsave,+avx,+xsa=
veopt,+xsavec,+xgetbv1,+avx2,+bmi2,+smep,+bmi1,+fma,+movbe,+invtsc =

  \
      -device =

  isa-applesmc,osk=3D"ourhardworkbythesewordsguardedpleasedontsteal(c)Apple=
ComputerInc" =

  \
      -smbios type=3D2 \
      -drive if=3Dpflash,format=3Draw,readonly,file=3D"/tmp/OVMF_CODE.fd" \
      -drive if=3Dpflash,format=3Draw,file=3D"/tmp/macos_catalina_VARS.fd" \
      -vga qxl \
      -device ich9-ahci,id=3Dsata \
      -drive id=3DESP,if=3Dnone,format=3Draw,file=3D/tmp/ESP.img \
      -device ide-hd,bus=3Dsata.2,drive=3DESP \
      -drive id=3DInstallMedia,format=3Draw,if=3Dnone,file=3D/tmp/BaseSyste=
m.img \
      -device ide-hd,bus=3Dsata.3,drive=3DInstallMedia \
      -drive id=3DSystemDisk,if=3Dnone,format=3Draw,file=3D/tmp/macos_catal=
ina.img \
      -device ide-hd,bus=3Dsata.4,drive=3DSystemDisk \
      -usb -device usb-kbd -device usb-mouse

  Perhaps something has changed in Penryn support recently, as that's
  required for macos?

  See also https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D964247

  Also on a related note, kernel 5.6/5.7 (on Debian) hard crashes the
  host when I try GPU passthrough on macos, whereas Ubuntu20/Win10 work
  fine - as does 5.5 kernel.

  See also https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D961676

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1886318/+subscriptions

