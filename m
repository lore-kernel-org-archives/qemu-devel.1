Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E32C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 15:42:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2C2E2465E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 15:42:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2C2E2465E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihEzk-0004mT-Vk
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 10:42:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55052)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1ihExs-0003Sc-JW
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 10:40:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1ihExr-0000zw-Cq
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 10:40:48 -0500
Received: from indium.canonical.com ([91.189.90.7]:50530)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1ihExr-0000yY-6x
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 10:40:47 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1ihExp-0004lK-QO
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 15:40:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id C00682E805B
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 15:40:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Dec 2019 15:32:17 -0000
From: Rafal Kupiec <1856724@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: belliash
X-Launchpad-Bug-Reporter: Rafal Kupiec (belliash)
X-Launchpad-Bug-Modifier: Rafal Kupiec (belliash)
Message-Id: <157659673737.27526.16943710669363851261.malonedeb@chaenomeles.canonical.com>
Subject: [Bug 1856724] [NEW] SB.PCI0.SMB0 device drivers unavailable
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="bceb5ef013b87ef7aafe0755545ceb689ca7ac60";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: a73b2e1600ce5a7eeadcc12b0bab660386ec062c
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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

Public bug reported:

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

It is detected by Windows 10 as 'Unknown Device' and there is no driver ava=
ilable.
Please provide a working Windows driver or give ability to disable this dev=
ice.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1856724

Title:
  SB.PCI0.SMB0 device drivers unavailable

Status in QEMU:
  New

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

