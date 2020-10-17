Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26456C433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:10:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9092B2072C
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UokLcAdf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9092B2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTmuF-0001df-Lv
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 10:09:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36400)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmnY-0001VK-Fk
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:03:08 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:44920)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmnW-0003gd-Qz
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:03:04 -0400
Received: by mail-wr1-x42c.google.com with SMTP id t9so6549393wrq.11
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2020 07:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=N+6P5UyNzQt64543jNV3+JqEP1ruUMZwDb9XjKLtnVQ=;
 b=UokLcAdfIvbxLFzHsZ+I+CiGEmjwM5PeSp77ZmCFFk3RV6ATrDiOffn65e2v7lhduq
 7jMmhJEcYCjBJJG2CoPiX6dcTlXZ2kuo2teiO/ZxttnL60Wa04bFnw3HiqcLGaqK7vzQ
 LdYyr3hVim3AQvLtvbU19ewYtKwT9ynX1D1W2chfWAgvUqjvfXJ/MmFJr7xeqWBm2EwK
 BDDl9wYhbeouIv4p5X/3maRTAPAqp5ZqpXKIRMiE5ueaiRAYVAS/oltTiFFb+2k5w/GG
 m/3LUit1+mgriud4JH5Blu+KAVP4YuQCeCiwq+b3HoTSLrx0ygcpXQH6QgFAe29oAOly
 lrpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=N+6P5UyNzQt64543jNV3+JqEP1ruUMZwDb9XjKLtnVQ=;
 b=AF5XU5qALfbSKp5eveyHZRFISjRmcKV1tunLLnmmb+TsRFiAwp5e339Trygg8JjjEE
 bEY3qxbSXYMKvqpTvc63OFM/63xOLUzJw4/aj87j/ndCL7RoWYxqp5dFUNr703vQkhf5
 CJc0ltgdaAgHiIR9T1+N1NkCbPZNkKkdujVOfZKhGDvpyTEaEe1QJbvhYve0yGcS7ci4
 LjeUvKJCc3Jl+/+aye+c8+yeMUJt4Vy7Tpq5mvClWPE/Diewg0IfwefPOY96dp9WACnB
 rNVUofTnGeoQVWdcD/A1NBHrwkz0eV2k7EdZZiMdWkpQE4q1uKp3BQTS2VAAZX6KVNyO
 SusA==
X-Gm-Message-State: AOAM533ME25qAioebKaHIYkTNYWj3VYPuFfCTOfo42rsp4nu5t1zckte
 cytmovse5biRPXMNhU8P1fSJKFucNB0=
X-Google-Smtp-Source: ABdhPJyqrT+skP3Rc8vENV40BvEMM08JKTFVY/XKZPXcFmyh4Ppc3MLpElduEL+7q18vql3cCLBBDw==
X-Received: by 2002:adf:e50b:: with SMTP id j11mr10486045wrm.263.1602943379830; 
 Sat, 17 Oct 2020 07:02:59 -0700 (PDT)
Received: from localhost.localdomain
 (117.red-83-52-172.dynamicip.rima-tde.net. [83.52.172.117])
 by smtp.gmail.com with ESMTPSA id x18sm9349551wrg.4.2020.10.17.07.02.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2020 07:02:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/44] hw/core/clock: Add the clock_new helper function
Date: Sat, 17 Oct 2020 16:02:02 +0200
Message-Id: <20201017140243.1078718-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201017140243.1078718-1-f4bug@amsat.org>
References: <20201017140243.1078718-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Luc Michel <luc@lmichel.fr>, Paul Burton <paulburton@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Luc Michel <luc@lmichel.fr>

This function creates a clock and parents it to another object with a
given name. It calls clock_setup_canonical_path before returning the
new clock.

This function is useful to create clocks in devices when one doesn't
want to expose it at the qdev level (as an input or an output).

Suggested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Luc Michel <luc@lmichel.fr>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20201010135759.437903-4-luc@lmichel.fr>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/clock.h | 13 +++++++++++++
 hw/core/clock.c    | 15 +++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/include/hw/clock.h b/include/hw/clock.h
index d357594df99..cbc5e6ced1e 100644
--- a/include/hw/clock.h
+++ b/include/hw/clock.h
@@ -90,6 +90,19 @@ extern const VMStateDescription vmstate_clock;
  */
 void clock_setup_canonical_path(Clock *clk);
 
+/**
+ * clock_new:
+ * @parent: the clock parent
+ * @name: the clock object name
+ *
+ * Helper function to create a new clock and parent it to @parent. There is no
+ * need to call clock_setup_canonical_path on the returned clock as it is done
+ * by this function.
+ *
+ * @return the newly created clock
+ */
+Clock *clock_new(Object *parent, const char *name);
+
 /**
  * clock_set_callback:
  * @clk: the clock to register the callback into
diff --git a/hw/core/clock.c b/hw/core/clock.c
index 7066282f7b9..f866717a835 100644
--- a/hw/core/clock.c
+++ b/hw/core/clock.c
@@ -23,6 +23,21 @@ void clock_setup_canonical_path(Clock *clk)
     clk->canonical_path = object_get_canonical_path(OBJECT(clk));
 }
 
+Clock *clock_new(Object *parent, const char *name)
+{
+    Object *obj;
+    Clock *clk;
+
+    obj = object_new(TYPE_CLOCK);
+    object_property_add_child(parent, name, obj);
+    object_unref(obj);
+
+    clk = CLOCK(obj);
+    clock_setup_canonical_path(clk);
+
+    return clk;
+}
+
 void clock_set_callback(Clock *clk, ClockCallback *cb, void *opaque)
 {
     clk->callback = cb;
-- 
2.26.2


