Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F4FC49ED9
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 04:38:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 263C62084F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 04:38:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 263C62084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8GsC-0007az-C8
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 00:38:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46666)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1i8Gpf-0005pu-8N
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 00:35:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1i8Gpd-0000KY-AB
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 00:35:47 -0400
Received: from indium.canonical.com ([91.189.90.7]:36722)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1i8Gpb-0000Jc-Tp
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 00:35:44 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1i8GpZ-0004D5-As
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 04:35:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 3F99D2E8E53
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 04:35:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Sep 2019 04:17:46 -0000
From: James Harvey <jamespharvey20@gmail.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: dgilbert-h jamespharvey20
X-Launchpad-Bug-Reporter: James Harvey (jamespharvey20)
X-Launchpad-Bug-Modifier: James Harvey (jamespharvey20)
References: <156790812963.29382.11232177290822294099.malonedeb@chaenomeles.canonical.com>
Message-Id: <156826186626.28889.6438334463994431587.malone@chaenomeles.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19044";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 9cbf5b8fd96b059e9d915caed60cce62d30b2062
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1843151] Re: Regression: QEMU 4.1.0 qxl and KMS
 resoluiton only 4x10
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
Reply-To: Bug 1843151 <1843151@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Finding a minimal case did shed some light on this.

Using QEMU's native graphics window, this works fine:

$ /usr/bin/qemu-system-x86_64 \
   -m 1G \
   -blockdev raw,node-name=3Dinstall_iso,read-only=3Don,file.driver=3Dfile,=
file.filename=3D/mnt/losable/ISOs/archlinux-2019.09.01-x86_64.iso \
   -device ide-cd,drive=3Dinstall_iso,bus=3Dide.0,bootindex=3D0

But, introducing spice reproduces the problem:

$ /usr/bin/qemu-system-x86_64 \
   -m 1G \
   -blockdev raw,node-name=3Dinstall_iso,read-only=3Don,file.driver=3Dfile,=
file.filename=3D/mnt/losable/ISOs/archlinux-2019.09.01-x86_64.iso \
   -spice unix,addr=3D/tmp/spice.qxl.sock,disable-ticketing \
   -device ide-cd,drive=3Dinstall_iso,bus=3Dide.0,bootindex=3D0 \
   -vga qxl

$ remote-viewer "spice+unix:///tmp/spice.qxl.sock"

I've been running remote-viewer (from virt-viewer package) since around
March 13, version 8.0 since then.  It's only when upgrading QEMU from
4.0.0 to 4.1.0 that introduces the problem.

Running remote-viewer this way also shows that it outputs these, right
when KMS changes resolution:

(remote-viewer:15090): GLib-GObject-WARNING **: 23:56:03.914: value "64"
of type 'gint' is invalid or out of range for property 'desktop-width'
of type 'gint'

(remote-viewer:15090): GLib-GObject-WARNING **: 23:56:03.915: value "64"
of type 'gint' is invalid or out of range for property 'desktop-height'
of type 'gint'

When downgrading to QEMU 4.0.0, remote-viewer STILL outputs these lines
regarding desktop-width and height, when KMS changes resolution.

In case it helps, below are spice-debug logs from remote-viewer.  I've
included the whole log, but also added a bunch of spacing and a header
showing the second worth of output correlating with the KMS resolution
change.

QEMU 4.0.0 without the bug: http://ix.io/1USn

QEMU 4.1.0 with the bug: http://ix.io/1USo

So, it's always possible the fix might need to be in remote-viewer, but
at minimum, the case it would need to handle properly wasn't being given
to it until QEMU 4.1.0.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1843151

Title:
  Regression: QEMU 4.1.0 qxl and KMS resoluiton only 4x10

Status in QEMU:
  New

Bug description:
  Host is Arch Linux.  linux 5.2.13, qemu 4.1.0.  virt-viewer 8.0.

  Guest is Arch Linux Sept 2019 ISO.  linux 5.2.11.

  Have replicated this both on a system using amdgpu and one using
  integrated ASPEED graphics.

  Downgrading from 4.1.0 to 4.0.0 works as usual, see:
  https://www.youtube.com/watch?v=3DNyMdcYwOCvY

  Going back to 4.1.0 reproduces, see:
  https://www.youtube.com/watch?v=3DH3nGG2Mk6i0

  4.1.0 displays fine until KMS kicks in.

  Using 4.1.0 with virtio-vga doesn't cause this.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1843151/+subscriptions

