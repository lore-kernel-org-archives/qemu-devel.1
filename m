Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F1B2C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 19:26:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2031F205F4
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 19:26:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2031F205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixFSH-0003nt-5N
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 14:26:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40881)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1ixFRc-0003P6-Qk
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 14:25:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1ixFRb-0007t5-OU
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 14:25:40 -0500
Received: from indium.canonical.com ([91.189.90.7]:41530)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1ixFRb-0007ol-JF
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 14:25:39 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1ixFRY-0000Wn-U9
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 19:25:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id E32502E80C0
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 19:25:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jan 2020 19:16:11 -0000
From: John Snow <1856724@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Committed; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: belliash deorder docmax3 ec911 jnsnow
X-Launchpad-Bug-Reporter: Rafal Kupiec (belliash)
X-Launchpad-Bug-Modifier: John Snow (jnsnow)
References: <157659673737.27526.16943710669363851261.malonedeb@chaenomeles.canonical.com>
Message-Id: <158041177108.19441.1791008547843794715.malone@gac.canonical.com>
Subject: [Bug 1856724] Re: SB.PCI0.SMB0 device drivers unavailable
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="0a62c17273454a1313f81a74a2198ec30b44c7b6";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 63ab42d49f76f2c3008972cb792a4f4ff7876b9b
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
Reply-To: Bug 1856724 <1856724@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, although this isn't my area of expertise, the bug caught my eye.
Peter Maydell points out that there is a commit that addresses this
issue:
https://github.com/qemu/qemu/commit/aefcaf9d1b3ebb30981627bd08f595211a648a62

It just never made its way back here to launchpad.

** Changed in: qemu
       Status: New =3D> Fix Committed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1856724

Title:
  SB.PCI0.SMB0 device drivers unavailable

Status in QEMU:
  Fix Committed

Bug description:
  QEMU 4.2 introduces new device with this code:

  static void build_smb0(Aml *table, I2CBus *smbus, int devnr, int func)
  {
      Aml *scope =3D aml_scope("_SB.PCI0");
      Aml *dev =3D aml_device("SMB0");

      aml_append(dev, aml_name_decl("_HID", aml_eisaid("APP0005")));
      aml_append(dev, aml_name_decl("_ADR", aml_int(devnr << 16 | func)));
      build_acpi_ipmi_devices(dev, BUS(smbus), "\\_SB.PCI0.SMB0");
      aml_append(scope, dev);
      aml_append(table, scope);
  }

  It is detected by Windows 10 as 'Unknown Device' and there is no driver a=
vailable.
  Please provide a working Windows driver or give ability to disable this d=
evice.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1856724/+subscriptions

