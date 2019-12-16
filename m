Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21BE3C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 17:42:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9A54206D7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 17:42:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9A54206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iguNf-0006p2-MA
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 12:42:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60956)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iguMT-0005Sd-9i
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 12:40:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iguMR-0007yf-TG
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 12:40:49 -0500
Received: from indium.canonical.com ([91.189.90.7]:58570)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iguMR-0007v9-MP
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 12:40:47 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iguMQ-0002ty-3a
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 17:40:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 13E0A2E80C3
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 17:40:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Dec 2019 17:32:59 -0000
From: Laurent Vivier <Laurent@vivier.eu>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: i2c m68k rtc
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: dcb314 laurent-vivier philmd
X-Launchpad-Bug-Reporter: dcb (dcb314)
X-Launchpad-Bug-Modifier: Laurent Vivier (laurent-vivier)
References: <157649490094.7480.17075229014510714852.malonedeb@soybean.canonical.com>
Message-Id: <157651757955.14847.8048508132237247696.malone@wampee.canonical.com>
Subject: [Bug 1856549] Re: qemu-4.2.0/hw/misc/mac_via.c: 2 * bad test ?
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="bceb5ef013b87ef7aafe0755545ceb689ca7ac60";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: a8a7757917469be5290350ff8ee2eae15f0b7ba6
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
Reply-To: Bug 1856549 <1856549@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I think VIA RTC access method has been implemented earlier (Classic Mac,
1984-1989) than the I2C specification, so I'm not sure we can/should
port this to an I2C bus.

Specs are (from Apple Macintosh Family Hardware Reference Chapter 2,
Classi Macitosh Processor and Control)

z0000001  Seconds register 0 (lowest-order byte)
z0000101  Seconds register 1
z0001001  Seconds register 2
z0001101  Seconds register 3 (highest-order byte)
00110001  Test register (write-only)
00110101  Write-Protect Register (write-only)
z010aa01  RAM address 100aa ($10-$13) (first 20 bytes only)
z1aaaa01  RAM address 0aaaa ($00-$0F) (first 20 bytes only)
z0111aaa  Extended memory designator and sector number
          (Macintohs 512K enhanced and Macintosh plus only)

For a read request, z=3D1, for a write z=3D0
The letter a indicates bits whose value depend on what parameter RAM byte y=
ou want to address

So I think the mask/values should be:

diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
index f3f130ad96cc..7402cf3f1ee8 100644
--- a/hw/misc/mac_via.c
+++ b/hw/misc/mac_via.c
@@ -414,7 +414,7 @@ static void via1_rtc_update(MacVIAState *m)
                     int addr =3D (m->data_out >> 2) & 0x03;
                     m->data_in =3D v1s->PRAM[addr];
                     m->data_in_cnt =3D 8;
-                } else if ((m->data_out & 0xf3) =3D=3D 0xa1) {
+                } else if ((m->data_out & 0xc3) =3D=3D 0xc1) {
                     /* PRAM address 0x00 -> 0x0f */
                     int addr =3D (m->data_out >> 2) & 0x0f;
                     m->data_in =3D v1s->PRAM[addr];
@@ -460,11 +460,11 @@ static void via1_rtc_update(MacVIAState *m)
                 } else if (m->cmd =3D=3D 0x35) {
                     /* Write Protect register */
                     m->wprotect =3D m->data_out & 1;
-                } else if ((m->cmd & 0xf3) =3D=3D 0xa1) {
+                } else if ((m->cmd & 0xf3) =3D=3D 0x21) {
                     /* PRAM address 0x10 -> 0x13 */
                     int addr =3D (m->cmd >> 2) & 0x03;
                     v1s->PRAM[addr] =3D m->data_out;
-                } else if ((m->cmd & 0xf3) =3D=3D 0xa1) {
+                } else if ((m->cmd & 0xc3) =3D=3D 0x41) {
                     /* PRAM address 0x00 -> 0x0f */
                     int addr =3D (m->cmd >> 2) & 0x0f;
                     v1s->PRAM[addr] =3D m->data_out;

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1856549

Title:
  qemu-4.2.0/hw/misc/mac_via.c: 2 * bad test ?

Status in QEMU:
  New

Bug description:
  1.

  qemu-4.2.0/hw/misc/mac_via.c:417:27: style: Expression is always false
  because 'else if' condition matches previous condition at line 412.
  [multiCondition]

                  } else if ((m->data_out & 0xf3) =3D=3D 0xa1) {
  ...
                  } else if ((m->data_out & 0xf3) =3D=3D 0xa1) {

  2.

  qemu-4.2.0/hw/misc/mac_via.c:467:27: style: Expression is always false
  because 'else if' condition matches previous condition at line 463.
  [multiCondition]

  Duplicate.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1856549/+subscriptions

