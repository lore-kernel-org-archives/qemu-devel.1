Return-Path: <SRS0=QAbx=Z6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A1DC43603
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Dec 2019 19:15:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1938320663
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Dec 2019 19:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbyaxLyI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1938320663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ie21Z-0000AW-UF
	for qemu-devel@archiver.kernel.org; Sun, 08 Dec 2019 14:15:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37649)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1ie1Tz-0002Mq-Di
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 13:40:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1ie1Tx-0003MY-3Q
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 13:40:39 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:52150)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1ie1Tw-0003D8-Pn
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 13:40:36 -0500
Received: by mail-wm1-x341.google.com with SMTP id g206so13076443wme.1
 for <qemu-devel@nongnu.org>; Sun, 08 Dec 2019 10:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=yqxuuUCu5t5jBp61Y7bULRSxBU4NfTQD0Ek2l8SxBT4=;
 b=lbyaxLyIs7cBkHK7JOv7QFwToewnFyoG7g16qvFTwrhAjQDkhqROF/cMTg4voO3SMN
 7XXO43NkyL2efLNyEEf5t5z53ok2vUCV+eYfoBmhxBMpRmS/oXuszkjmTAKzoPvyMWXm
 CUtIV/J4dg4hxQqA6q73JCDqGKc62yVfulcBVBg15vTAAEnLPstQ/0dQZtNF1gqHx/CF
 A3VHbFlYaJ1J6u5RQlLJge1hYIwbQujSz/tQlPuhTCPfQ87HiOi7IJ54q1tv1QwC5yPq
 59AgaVEgWaSlZ/3Zcg+n/luVU3djwaeNG1mt5OE93Bvze/ao/6bjAjzyu/XIqAHmm9wh
 nhRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=yqxuuUCu5t5jBp61Y7bULRSxBU4NfTQD0Ek2l8SxBT4=;
 b=OIt9CCNNQUXVgRZ5EmDKL6G98uwpbteFAe1zkwJ+1SJSfl3L/Vm+TgQzxA6Mq8BFkA
 7Q9X6Kjn5YVl56pyt9XIe+YqwuDsdFVVDzDrEkiCSTBq6Rph88LMc3l+OZkUivWF5nB2
 xnp3I+vuwgtejEHd5oQ6HRSxzzNWG4GBP6OzW/VgXUuONsw75900lMtUexngEX4zgf0O
 v7RiLo3CxHVSrM20LZ9KV2tvHlNi2L10ah67fumE3HBuhYymQwnJEAFCwE+YOJkpp/Fa
 wqbLmD2uON0rPNPO/0jvHdWIeoLBLG9lRv61+e0h0sMqJ0wTLRAwF08F0m2xOWiSTaBA
 0sqw==
X-Gm-Message-State: APjAAAWI06O7apELThEy43g+z180U5tvwu6vCpIH9bX5fpi6EjVUd248
 EPhCuI3opO9xJvtAYaOIKGeFpxoIfyvZZKKc
X-Google-Smtp-Source: APXvYqzH6G6itXsFaEvjS8DS+kVN2+yGW9hDq4KjZD+YtB/VrZyHA+DoRS9QEgMEBT3huT1J44H78w==
X-Received: by 2002:a1c:4b03:: with SMTP id y3mr21890346wma.91.1575830422073; 
 Sun, 08 Dec 2019 10:40:22 -0800 (PST)
Received: from 8c859074c0ff.ant.amazon.com.com
 (bzq-79-180-52-3.red.bezeqint.net. [79.180.52.3])
 by smtp.gmail.com with ESMTPSA id h17sm25289717wrs.18.2019.12.08.10.40.20
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 08 Dec 2019 10:40:21 -0800 (PST)
From: Michael Rolnik <mrolnik@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v38 16/22] target/avr: Add section about AVR into QEMU
 documentation
Date: Sun,  8 Dec 2019 20:39:16 +0200
Message-Id: <20191208183922.13757-17-mrolnik@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20191208183922.13757-1-mrolnik@gmail.com>
References: <20191208183922.13757-1-mrolnik@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: thuth@redhat.com, Michael Rolnik <mrolnik@gmail.com>,
 me@xcancerberox.com.ar, richard.henderson@linaro.org, dovgaluk@ispras.ru,
 imammedo@redhat.com, philmd@redhat.com, aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
---
 qemu-doc.texi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index 3ddf5c0a68..cea1008800 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -1757,6 +1757,7 @@ differences are mentioned in the following sections.
 * Microblaze System emulator::
 * SH4 System emulator::
 * Xtensa System emulator::
+* AVR System emulator::
 @end menu
 
 @node PowerPC System emulator
@@ -2532,6 +2533,15 @@ so should only be used with trusted guest OS.
 
 @c man end
 
+@node AVR System emulator
+@section AVR System emulator
+@cindex system emulation (AVR)
+
+Use the executable @file{qemu-system-avr} to emulates a AVR 8 bit based machine having one for the following cores: avr1, avr2, avr25, avr3, avr31, avr35, avr4, avr5, avr51, avr6, avrtiny, xmega2, xmega3, xmega4, xmega5, xmega6 and xmega7.
+
+As for now it does not support any real MCUs. However, it does support a "sample" board for educational and testing purposes. This "sample" board hosts USART & 16 bit timer devices.
+
+
 @node QEMU User space emulator
 @chapter QEMU User space emulator
 
-- 
2.17.2 (Apple Git-113)


