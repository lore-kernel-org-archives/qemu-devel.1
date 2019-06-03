Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA1EC04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 17:17:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6629720673
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 17:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXYOJaeD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6629720673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38334 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXqaJ-0003XV-H3
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 13:17:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hXqUE-00078s-RI
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:11:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hXqU8-00043c-BK
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:11:03 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39814)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1hXqU5-0003sy-9n
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:10:59 -0400
Received: by mail-wr1-x443.google.com with SMTP id x4so12920924wrt.6
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 10:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=i8cdpTQpJJWnX9/W8Ct8bcoN/ZoC8uS3+XE2cylOq34=;
	b=aXYOJaeDS/kqo3T/r/8s0CEmQXyST/ysfepjBYfJD8DDwWg8fdZoOQwRQfeIeLulJR
	oXJ2QlFaIKuFi/os+o75zTEHmKaFRX7mTOJXsTutbVtPFwIpH0cajFqTXzxK8siFlCYO
	me3ZH3uZoxhT/mn1fu088Y2pnFie6ky3N4Vnfeg49aJ0Ir/FhabvUov94zeesEXOOLG3
	90Mp74ciBtH/H4RMPSBEvVr0FSRjIAT5fYkKs1ZNMYPnDNZDB5fZEFGYY0mAM447ueph
	LS9ljnYY0YiQHs74igG+Tt/OP+DOPW4n7zWHVqZbrfH22QR9cyagzIzEkCYo3VdNCbft
	38Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
	:in-reply-to:references;
	bh=i8cdpTQpJJWnX9/W8Ct8bcoN/ZoC8uS3+XE2cylOq34=;
	b=S50pDz6ZJA907u4AJz8twG7EHsjycYRB7IhXKFfwPY2rR4/bL1TrFMzoKakkGkDf/I
	RN0KFgwK7Q14uFZqSJGxuSGIYgE41y6tf/1zqaBSG2tM9Y1nNyNqVJdOXXQ1plUNKdns
	tcTWFO8LCRa7T0eEzaxp/TkVUwL1ojIazDc8Ak0TK/1SJcEOrirCnpwjjurt7Qf9CMXi
	cCyN/V+og9mWOP05PpvvtATXYQwnw2+aLIFyBxjZ6W+LxweEsUc4fb2XaHBLv0Opz2nc
	MGyFy9lju113k+k4xoSvilq0EFzMgbgD7xI8yd5sWBvSklmHhF+u3D6y2G//VQ6ufhT9
	Jadw==
X-Gm-Message-State: APjAAAUC57w/wvL/QeuSGjphyWd+kBfNoTChagRcEEcZ3N09fvW3U8AO
	qcdfnDPGWPgUebkudN5ZWt6SIkFp
X-Google-Smtp-Source: APXvYqwd2RnC5QqL+gMa37Y6W0/XKcflPJTH2ABE/44nLizBwo3I5oyeRzCKCWNUyHLYln94YAZuHA==
X-Received: by 2002:adf:f951:: with SMTP id q17mr16842462wrr.173.1559581853400;
	Mon, 03 Jun 2019 10:10:53 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	r131sm3325045wmf.4.2019.06.03.10.10.52
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 03 Jun 2019 10:10:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  3 Jun 2019 19:10:26 +0200
Message-Id: <1559581843-3968-8-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1559581843-3968-1-git-send-email-pbonzini@redhat.com>
References: <1559581843-3968-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PULL 07/24] edu: mmio: allow 64-bit access in read
 dispatch
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
Cc: Li Qiang <liq3ea@163.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Li Qiang <liq3ea@163.com>

The edu spec says when address >= 0x80, the MMIO area can
be accessed by 64-bit.

Signed-off-by: Li Qiang <liq3ea@163.com>
Reviewed-by: Philippe Mathieu-Daude <philmd@redhat.com>
Message-Id: <20190510164349.81507-3-liq3ea@163.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/misc/edu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/misc/edu.c b/hw/misc/edu.c
index 65fc32b..33de051 100644
--- a/hw/misc/edu.c
+++ b/hw/misc/edu.c
@@ -185,7 +185,11 @@ static uint64_t edu_mmio_read(void *opaque, hwaddr addr, unsigned size)
     EduState *edu = opaque;
     uint64_t val = ~0ULL;
 
-    if (size != 4) {
+    if (addr < 0x80 && size != 4) {
+        return val;
+    }
+
+    if (addr >= 0x80 && size != 4 && size != 8) {
         return val;
     }
 
-- 
1.8.3.1



