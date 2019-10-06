Return-Path: <SRS0=2u83=X7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A108C4360C
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Oct 2019 03:57:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF5222166E
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Oct 2019 03:57:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF5222166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGxfz-0000Ba-4k
	for qemu-devel@archiver.kernel.org; Sat, 05 Oct 2019 23:57:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39969)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iGvXT-0004U7-62
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 21:40:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iGvXR-0005Yk-Qh
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 21:40:47 -0400
Received: from indium.canonical.com ([91.189.90.7]:38736)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iGvXR-0005YC-LX
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 21:40:45 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iGvXQ-0004r7-AO
 for <qemu-devel@nongnu.org>; Sun, 06 Oct 2019 01:40:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 1E5472E80CC
 for <qemu-devel@nongnu.org>; Sun,  6 Oct 2019 01:40:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 06 Oct 2019 01:31:41 -0000
From: =?utf-8?q?Andr=C3=A9_Chalella?= <andrechalella@gmail.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Confirmed; importance=Undecided;
 assignee=ubuntu@weilnetz.de; 
X-Launchpad-Bug-Tags: installation windows
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: andrechalella justbesage stefanha ubuntu-weilnetz
X-Launchpad-Bug-Reporter: Justin (justbesage)
X-Launchpad-Bug-Modifier: =?utf-8?q?Andr=C3=A9_Chalella_=28andrechalella=29?=
References: <152465178789.21509.8085388028037824608.malonedeb@soybean.canonical.com>
Message-Id: <157032550144.792.9195329187823389927.malone@chaenomeles.canonical.com>
Subject: [Bug 1766841] Re: QEMU 2.12 Running Problem in Windows 7 Installation
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="af2eefe214bd95389a09b7c956720881bab16807";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 4cb37397e1020e5a0b0ca9984246c628a3562eb1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 91.189.90.7
X-Mailman-Approved-At: Sat, 05 Oct 2019 23:57:01 -0400
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
Reply-To: Bug 1766841 <1766841@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I discovered that the following directory is not installed when the
"Desktop icons" component is unchecked during installation:

    qemu\share\icons

Such directory contains two subdirectories: "Adwaita" and "hicolor".
When they're present, the bug does not occur.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1766841

Title:
  QEMU 2.12 Running Problem in Windows 7 Installation

Status in QEMU:
  Confirmed

Bug description:
  QEMU Version: 2.12 (Binary installer qemu-w64-setup-20180424.exe  from St=
efan Weil's website so I am not sure I should report it to Weil by email or=
 by this bug report system.)
  Host System: Windows 7 64bit
  Guest System: 9front 6350 (Codename=E2=80=9CCONTENTS, MAINTAINED, STABLE=
=E2=80=9D, Release 2018/02/02)

  QEMU Command:
  qemu-system-x86_64 -usb -device usb-mouse -hda plan9.qcow2.img -cdrom 9fr=
ont-6350.iso -boot d

  QEMU warning: =

  (qemu-system-x86_64.exe:8844): GdkPixbuf-WARNING **: Cannot open pixbuf l=
oader module file 'D:\qemu\lib\gdk-pixbuf-2.0\2.10.0\loaders.cache': No suc=
h file or directory

  This likely means that your installation is broken.
  Try running the command
    gdk-pixbuf-query-loaders > D:\qemu\lib\gdk-pixbuf-2.0\2.10.0\loaders.ca=
che
  to make things work again for the time being.

  (qemu-system-x86_64.exe:8844): Gtk-WARNING **: Could not find the icon 'w=
indow-minimize-symbolic-ltr'. The 'hicolor' theme was not found either, per=
haps you need to install it.
  You can get a copy from:
          http://icon-theme.freedesktop.org/releases

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1766841/+subscriptions

