Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1704DC04AA7
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 14:13:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE26620862
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 14:13:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE26620862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sios.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57998 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQBi2-0006EW-VZ
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 10:13:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yo-satoh@sios.com>) id 1hQ3Sw-0000dy-KF
	for qemu-devel@nongnu.org; Mon, 13 May 2019 01:25:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yo-satoh@sios.com>) id 1hQ3Su-0006Nz-KU
	for qemu-devel@nongnu.org; Mon, 13 May 2019 01:25:34 -0400
Received: from mail03.asahi-net.or.jp ([202.224.55.15]:56161)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yo-satoh@sios.com>) id 1hQ3Su-0006M4-9a
	for qemu-devel@nongnu.org; Mon, 13 May 2019 01:25:32 -0400
Received: from h61-195-96-97.vps.ablenet.jp (h61-195-96-97.vps.ablenet.jp
	[61.195.96.97]) (Authenticated sender: PQ4Y-STU)
	by mail03.asahi-net.or.jp (Postfix) with ESMTPA id 60A7F42346;
	Mon, 13 May 2019 14:25:31 +0900 (JST)
Received: from ysato.dip.jp (ZM005235.ppp.dion.ne.jp [222.8.5.235])
	by h61-195-96-97.vps.ablenet.jp (Postfix) with ESMTPSA id 1E6C5240086; 
	Mon, 13 May 2019 14:25:31 +0900 (JST)
From: Yoshinori Sato <yo-satoh@sios.com>
To: qemu-devel@nongnu.org
Date: Mon, 13 May 2019 14:25:18 +0900
Message-Id: <20190513052518.6274-13-yo-satoh@sios.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190513052518.6274-1-yo-satoh@sios.com>
References: <20190513052518.6274-1-yo-satoh@sios.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 202.224.55.15
X-Mailman-Approved-At: Mon, 13 May 2019 10:11:53 -0400
Subject: [Qemu-devel] [PATCH v11 12/12] MAINTAINERS: Add RX
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
	Yoshinori Sato <yo-satoh@sios.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yoshinori Sato <ysato@users.sourceforge.jp>

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Signed-off-by: Yoshinori Sato <yo-satoh@sios.com>
---
 MAINTAINERS | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 66ddbda9c9..1599eb6a72 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -272,6 +272,13 @@ F: include/hw/riscv/
 F: linux-user/host/riscv32/
 F: linux-user/host/riscv64/
 
+RENESAS RX
+M: Yoshinori Sato <ysato@users.sourceforge.jp>
+S: Maintained
+F: target/rx/
+F: hw/rx/
+F: include/hw/rx/
+
 S390
 M: Richard Henderson <rth@twiddle.net>
 M: David Hildenbrand <david@redhat.com>
@@ -1106,6 +1113,18 @@ F: pc-bios/canyonlands.dt[sb]
 F: pc-bios/u-boot-sam460ex-20100605.bin
 F: roms/u-boot-sam460ex
 
+RX Machines
+-----------
+RX-QEMU
+M: Yoshinori Sato <ysato@users.sourceforge.jp>
+S: Maintained
+F: hw/rx/rxqemu.c
+F: hw/intc/rx_icu.c
+F: hw/timer/renesas_*.c
+F: hw/char/renesas_sci.c
+F: include/hw/timer/renesas_*.h
+F: include/hw/char/renesas_sci.h
+
 SH4 Machines
 ------------
 R2D
-- 
2.11.0


