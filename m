Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3734EC47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 13:59:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC8692063A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 13:59:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC8692063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU9ia-0002Mo-Sl
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 09:59:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51656)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jU9ad-0003Js-LY
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 09:50:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jU9ac-0000PX-8r
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 09:50:59 -0400
Received: from indium.canonical.com ([91.189.90.7]:35766)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jU9ab-0000P7-QV
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 09:50:57 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jU9aa-0007FF-J7
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 13:50:56 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 8FBC72E80E7
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 13:50:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Apr 2020 13:44:44 -0000
From: Laurent Vivier <Laurent@vivier.eu>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: dgilbert-h laurent-vivier marcandre-lureau
X-Launchpad-Bug-Reporter: Dr. David Alan Gilbert (dgilbert-h)
X-Launchpad-Bug-Modifier: Laurent Vivier (laurent-vivier)
References: <158533956244.22377.11770713570863953031.malonedeb@wampee.canonical.com>
Message-Id: <158825428490.4878.6816127526331277683.malone@chaenomeles.canonical.com>
Subject: [Bug 1869426] Re: 5.0rc0->4.2 serial migraiton
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="fbdff7602bd10fb883bf7e2ddcc7fd5a16f60398";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 77681020c4e890a42445e612fd1533e5b7f8de38
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 09:35:36
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
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
Reply-To: Bug 1869426 <1869426@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fixed here:
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3Df602d047ac21


** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1869426

Title:
  5.0rc0->4.2 serial migraiton

Status in QEMU:
  Fix Released

Bug description:
  Migrating from 5.0rc0->4.2 with pc-q35-4.2 we get an error:

  Unknown savevm section or instance 'serial' 1

  dumping the migration streams it looks like 5.0 is duplicating the
  serial migration data:

      "serial (26)": {
          "divider": "0x000c",
          "rbr": "0x00",
          "ier": "0x00",
          "iir": "0x01",
          "lcr": "0x00",
          "mcr": "0x00",
          "lsr": "0x60",
          "msr": "0xb0",
          "scr": "0x00",
          "fcr_vmstate": "0x00"
      },
      "serial (27)": {
          "state": {
              "divider": "0x000c",
              "rbr": "0x00",
              "ier": "0x00",
              "iir": "0x01",
              "lcr": "0x00",
              "mcr": "0x00",
              "lsr": "0x60",
              "msr": "0xb0",
              "scr": "0x00",
              "fcr_vmstate": "0x00"
          }
      },

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1869426/+subscriptions

