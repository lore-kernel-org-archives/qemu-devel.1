Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E60C10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 05:41:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEC5E2075B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 05:41:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEC5E2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45093 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFuNJ-0005t6-LA
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 01:41:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ysato@users.sourceforge.jp>) id 1hFuHT-0001LL-RB
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 01:35:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ysato@users.sourceforge.jp>) id 1hFuHS-0003WW-HR
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 01:35:47 -0400
Received: from mail03.asahi-net.or.jp ([202.224.55.15]:37755)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ysato@users.sourceforge.jp>) id 1hFuHS-0003Vc-5O
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 01:35:46 -0400
Received: from h61-195-96-97.vps.ablenet.jp (h61-195-96-97.vps.ablenet.jp
	[61.195.96.97]) (Authenticated sender: PQ4Y-STU)
	by mail03.asahi-net.or.jp (Postfix) with ESMTPA id 7E49B3ED1B;
	Mon, 15 Apr 2019 14:35:45 +0900 (JST)
Received: from ysato.dip.jp (ZM005235.ppp.dion.ne.jp [222.8.5.235])
	by h61-195-96-97.vps.ablenet.jp (Postfix) with ESMTPSA id 3FDD9240084; 
	Mon, 15 Apr 2019 14:35:45 +0900 (JST)
From: Yoshinori Sato <ysato@users.sourceforge.jp>
To: qemu-devel@nongnu.org
Date: Mon, 15 Apr 2019 14:35:29 +0900
Message-Id: <20190415053531.77264-12-ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190415053531.77264-1-ysato@users.sourceforge.jp>
References: <20190415053531.77264-1-ysato@users.sourceforge.jp>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 202.224.55.15
Subject: [Qemu-devel] [PATCH RFC v7 11/12] MAINTAINERS: Add RX
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
	Yoshinori Sato <ysato@users.sourceforge.jp>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190415053529.fOoBLMZE8U3ZY4Cb1zwDgJBB_1QjIsamqRdSQdlx6PI@z>

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 MAINTAINERS | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 56139ac8ab..99d3428f04 100644
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
@@ -1099,6 +1106,18 @@ F: pc-bios/canyonlands.dt[sb]
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


