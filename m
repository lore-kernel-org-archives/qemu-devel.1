Return-Path: <SRS0=Dm/C=EH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7C1C2D0A3
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 13:35:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1D1D2223F
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 13:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B7xB4TzL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1D1D2223F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZDW8-00021p-PO
	for qemu-devel@archiver.kernel.org; Sun, 01 Nov 2020 08:35:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35732)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZDTk-0001Dw-DD
 for qemu-devel@nongnu.org; Sun, 01 Nov 2020 08:33:04 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36909)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZDTi-0001a6-Ks
 for qemu-devel@nongnu.org; Sun, 01 Nov 2020 08:33:03 -0500
Received: by mail-wr1-x443.google.com with SMTP id w1so11509699wrm.4
 for <qemu-devel@nongnu.org>; Sun, 01 Nov 2020 05:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=e5F37KHKrsAJyEq6bg6gcyfjKzhVjIjvXr9kk8KAAlM=;
 b=B7xB4TzLdAv9C78E97WURZNvaTfeqKIIP7ENQ1vkcmJDha0uTmxOcof0J8udYYq8oL
 yRRgOCIx2ut2plK6exAPpOKK65C5WXYsEEkVsEgxMZ3rRK3B9UQ41dc7OK1/58+2GWuQ
 KVryIOLVE6VGFhFT4CVlu+cn+wALiUxuKamIKRreperSlAYAO4qc4Y4YgI0Z+4VmfzMK
 bkd3oklTfgjsgNAJzDSCeZNI4Bb5SQVeR9dvBVQBDNJ44Ik389JyP4PQHT02BIjhTam7
 YJU9o2XXEfOKEyzPJHqIMzN9k9PikJlnqiO6apCRjYG5j2ikvF3b5ZBQ0In6ziuh8Ufk
 dtVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=e5F37KHKrsAJyEq6bg6gcyfjKzhVjIjvXr9kk8KAAlM=;
 b=CoygAHZuYus8PqZw/lg/dc2ziQiDzOycdn+ea3LUfVlYWowR6Kb6bx7bc/f5X3nsgh
 d3bRl5+FEpvDgTj52kaOLsqYpKoX4CLq8ndWVw/FJWuvvlbf66SC+iq85bIwtEjehX3R
 m+Q51/Hu1Wc63cKyTc187erl+TXXwx500XNbrNxv947jLNL2WjBE1rlE6fJ3ObP+Ixvu
 vh+Rpr6t4hfPzcDjAgSH3k1v8yedMEuof1P8J4QAe7szgf/E1sfIgjsgOcLI4DYZlLBg
 e86Dwoe8QSspB42IRiKwKLYpomtxq62pVc8uVJU0cIVT4+fLUiPhxLZTAGXxwsPWH8Ne
 bLAg==
X-Gm-Message-State: AOAM530EjTy4nt42pLzCJsn/i35/tjsQ1zAzS4yxkJ0oT0w/NiUFv92K
 RqfcQEOE/SZCtK6He3NQhyr8q4PQtf21AQ==
X-Google-Smtp-Source: ABdhPJxjXNFIH1bl0ejx4jGLsgxVIiby4M+y68qYrJ48Kv6SB5KtWmPetujDtJ8IeFt1+hpxW2NIhw==
X-Received: by 2002:adf:d4ce:: with SMTP id w14mr14770107wrk.142.1604237580871; 
 Sun, 01 Nov 2020 05:33:00 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id u3sm21919673wme.0.2020.11.01.05.32.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2020 05:33:00 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/input/ps2.c: Remove remnants of printf debug
Date: Sun,  1 Nov 2020 13:32:58 +0000
Message-Id: <20201101133258.4240-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-trivial@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In commit 5edab03d4040 we added tracepoints to the ps2 keyboard
and mouse emulation. However we didn't remove all the debug-by-printf
support. In fact there is only one printf() remaining, and it is
redundant with the trace_ps2_write_mouse() event next to it.
Remove the printf() and the now-unused DEBUG* macros.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/input/ps2.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/hw/input/ps2.c b/hw/input/ps2.c
index f8746d2f52c..72cdb80ae1c 100644
--- a/hw/input/ps2.c
+++ b/hw/input/ps2.c
@@ -33,12 +33,6 @@
 
 #include "trace.h"
 
-/* debug PC keyboard */
-//#define DEBUG_KBD
-
-/* debug PC keyboard : only mouse */
-//#define DEBUG_MOUSE
-
 /* Keyboard Commands */
 #define KBD_CMD_SET_LEDS	0xED	/* Set keyboard leds */
 #define KBD_CMD_ECHO     	0xEE
@@ -790,9 +784,6 @@ void ps2_write_mouse(void *opaque, int val)
     PS2MouseState *s = (PS2MouseState *)opaque;
 
     trace_ps2_write_mouse(opaque, val);
-#ifdef DEBUG_MOUSE
-    printf("kbd: write mouse 0x%02x\n", val);
-#endif
     switch(s->common.write_cmd) {
     default:
     case -1:
-- 
2.20.1


