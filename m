Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50503C0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 09:53:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2103B21881
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 09:53:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2103B21881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hibwj-00085g-3V
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 05:53:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41864)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hibup-0007E9-Ho
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 05:51:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hibun-0006cA-Kg
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 05:51:03 -0400
Received: from indium.canonical.com ([91.189.90.7]:51278)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hibul-0006Wu-PP
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 05:50:59 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hibuk-0000YF-FI
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2019 09:50:58 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 6997E2E8078
 for <qemu-devel@nongnu.org>; Wed,  3 Jul 2019 09:50:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jul 2019 09:36:28 -0000
From: DDoSolitary <DDoSolitary@gmail.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Committed; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: ppc
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: ddosolitary laurent-vivier
X-Launchpad-Bug-Reporter: DDoSolitary (ddosolitary)
X-Launchpad-Bug-Modifier: DDoSolitary (ddosolitary)
References: <156171334969.18290.6262209650807716029.malonedeb@gac.canonical.com>
Message-Id: <156214658912.16853.12895930110720821938.malone@wampee.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18991";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 3dc1c41c448c5ea0bbd2b89c9a554a79a6ab268f
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1834613] Re: Crypto related operations failing on
 Alpine Linux on QEMU 4.0
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
Reply-To: Bug 1834613 <1834613@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

@laurent-vivier I just tested the binary built from git master and the
error went away. Thanks.

** Changed in: qemu
       Status: New =3D> Fix Committed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1834613

Title:
  Crypto related operations failing on Alpine Linux on QEMU 4.0

Status in QEMU:
  Fix Committed

Bug description:
  I'm unable to boot the netboot image of Alpine Linux using QEMU 4.0.

  Steps to reproduce:

  curl -O http://dl-cdn.alpinelinux.org/alpine/v3.10/releases/ppc64le/netbo=
ot/vmlinuz-vanilla
  curl -O http://dl-cdn.alpinelinux.org/alpine/v3.10/releases/ppc64le/netbo=
ot/initramfs-vanilla
  qemu-system-ppc64 -kernel vmlinuz-vanilla -initrd initramfs-vanilla -nogr=
aphic -append "console=3Dhvc0 ip=3Ddhcp alpine_repo=3Dhttp://dl-cdn.alpinel=
inux.org/alpine/v3.10/main"

  The init script will automatically download and install an in-memory
  Alpine Linux environment. However, with QEMU 4.0, the installation
  process will fail with "BAD signature" errors:

  (1/20) Installing musl (1.1.22-r2)
  ERROR: musl-1.1.22-r2: BAD signature
  (2/20) Installing busybox (1.30.1-r2)
  ERROR: busybox-1.30.1-r2: BAD signature
  (3/20) Installing alpine-baselayout (3.1.2-r0)
  Executing alpine-baselayout-3.1.2-r0.pre-install
  ERROR: alpine-baselayout-3.1.2-r0.pre-install: script exited with error 1=
27
  ERROR: alpine-baselayout-3.1.2-r0: BAD signature
  (4/20) Installing openrc (0.41.2-r1)
  ERROR: openrc-0.41.2-r1: BAD signature
  (5/20) Installing alpine-conf (3.8.3-r0)
  ERROR: alpine-conf-3.8.3-r0: BAD signature
  (6/20) Installing libcrypto1.1 (1.1.1c-r0)
  ERROR: libcrypto1.1-1.1.1c-r0: BAD signature
  (7/20) Installing libssl1.1 (1.1.1c-r0)
  ERROR: libssl1.1-1.1.1c-r0: BAD signature
  (8/20) Installing ca-certificates-cacert (20190108-r0)
  ERROR: ca-certificates-cacert-20190108-r0: BAD signature
  (9/20) Installing libtls-standalone (2.9.1-r0)
  ERROR: libtls-standalone-2.9.1-r0: BAD signature
  (10/20) Installing ssl_client (1.30.1-r2)
  ERROR: ssl_client-1.30.1-r2: BAD signature
  (11/20) Installing zlib (1.2.11-r1)
  ERROR: zlib-1.2.11-r1: BAD signature
  (12/20) Installing apk-tools (2.10.4-r1)
  ERROR: apk-tools-2.10.4-r1: BAD signature
  (13/20) Installing busybox-suid (1.30.1-r2)
  ERROR: busybox-suid-1.30.1-r2: BAD signature
  (14/20) Installing busybox-initscripts (3.1-r7)
  ERROR: busybox-initscripts-3.1-r7: BAD signature
  (15/20) Installing scanelf (1.2.3-r0)
  ERROR: scanelf-1.2.3-r0: BAD signature
  (16/20) Installing musl-utils (1.1.22-r2)
  ERROR: musl-utils-1.1.22-r2: BAD signature
  (17/20) Installing libc-utils (0.7.1-r0)
  ERROR: libc-utils-0.7.1-r0: BAD signature
  (18/20) Installing alpine-keys (2.1-r2)
  ERROR: alpine-keys-2.1-r2: BAD signature
  (19/20) Installing alpine-base (3.10.0-r0)
  ERROR: alpine-base-3.10.0-r0: BAD signature
  (20/20) Installing openssl (1.1.1c-r0)
  ERROR: openssl-1.1.1c-r0: BAD signature
  20 errors; 0 MiB in 0 packages
  ok.
  grep: /sysroot/etc/inittab: No such file or directory
  /sbin/init not found in new root. Launching emergency recovery shell
  Type exit to continue boot.
  sh: can't access tty; job control turned off
  / #

  If I boot up a disk image created by a previous version of QEMU,
  crypto related operations like verifying a RSA signature using the
  "openssl" command will also fail.

  I didn't see these errors on previous QEMU versions or other
  architectures on QEMU 4.0

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1834613/+subscriptions

