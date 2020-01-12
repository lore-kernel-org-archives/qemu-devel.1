Return-Path: <SRS0=tUBQ=3B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93EA4C32771
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2020 12:55:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62EAC21556
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2020 12:55:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62EAC21556
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iqcli-0001Wa-Tx
	for qemu-devel@archiver.kernel.org; Sun, 12 Jan 2020 07:55:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33171)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ysato@users.sourceforge.jp>) id 1iqcgM-00044L-HN
 for qemu-devel@nongnu.org; Sun, 12 Jan 2020 07:49:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ysato@users.sourceforge.jp>) id 1iqcgI-0001Dc-2R
 for qemu-devel@nongnu.org; Sun, 12 Jan 2020 07:49:29 -0500
Received: from mail02.asahi-net.or.jp ([202.224.55.14]:58864)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <ysato@users.sourceforge.jp>) id 1iqcgH-0001AO-No
 for qemu-devel@nongnu.org; Sun, 12 Jan 2020 07:49:25 -0500
Received: from h61-195-96-97.vps.ablenet.jp (h61-195-96-97.ablenetvps.ne.jp
 [61.195.96.97]) (Authenticated sender: PQ4Y-STU)
 by mail02.asahi-net.or.jp (Postfix) with ESMTPA id E988EBAAB0;
 Sun, 12 Jan 2020 21:49:24 +0900 (JST)
Received: from yo-satoh-debian.localdomain (ZM005235.ppp.dion.ne.jp
 [222.8.5.235])
 by h61-195-96-97.vps.ablenet.jp (Postfix) with ESMTPSA id B089024008E;
 Sun, 12 Jan 2020 21:49:24 +0900 (JST)
From: Yoshinori Sato <ysato@users.sourceforge.jp>
To: qemu-devel@nongnu.org
Subject: [PATCH v28 22/22] qemu-doc.texi: Add RX section.
Date: Sun, 12 Jan 2020 21:49:13 +0900
Message-Id: <20200112124913.94959-23-ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200112124913.94959-1-ysato@users.sourceforge.jp>
References: <20200112124913.94959-1-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 202.224.55.14
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: richard.henderson@linaro.org, philmd@redhat.com,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 qemu-doc.texi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index 39f950471f..81f76074c4 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -1741,6 +1741,7 @@ differences are mentioned in the following sections=
.
 * Microblaze System emulator::
 * SH4 System emulator::
 * Xtensa System emulator::
+* RX System emulator::
 @end menu
=20
 @node PowerPC System emulator
@@ -2514,6 +2515,30 @@ so should only be used with trusted guest OS.
=20
 @c man end
=20
+@node RX System emulator
+@section RX System emulator
+@cindex system emulation (RX)
+
+Use the executable @file{qemu-system-rx} to simulate a Virtual RX target=
.
+This target emulated following devices.
+
+@itemize @minus
+@item
+R5F562N8 MCU
+@item
+On-chip memory (ROM 512KB, RAM 96KB)
+@item
+Interrupt Control Unit (ICUa)
+@item
+8Bit Timer x 1CH (TMR0,1)
+@item
+Compare Match Timer x 2CH (CMT0,1)
+@item
+Serial Communication Interface x 1CH (SCI0)
+@item
+External memory 16MByte
+@end itemize
+
 @node QEMU User space emulator
 @chapter QEMU User space emulator
=20
--=20
2.20.1


