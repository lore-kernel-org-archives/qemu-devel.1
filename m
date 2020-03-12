Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5C8C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:50:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E1F8206F1
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ni3ilxQG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E1F8206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCR2c-0003Hi-UT
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 12:50:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35620)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jCQxO-0008Gj-T8
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:45:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jCQxN-00055z-Ne
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:45:14 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34589)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jCQxN-00054U-GQ
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:45:13 -0400
Received: by mail-wr1-x443.google.com with SMTP id z15so8381010wrl.1
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 09:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=tWA33XZa/cz9PUChiNWS4Z6nrgn0YwL/7Lfi/vyfbzE=;
 b=Ni3ilxQGB1VEPlSVkK4tN3ruWhMW+q1BmovcUd1KvoWFP7++vx8aJ9iuc/qV0Euz3g
 E7USbpbyTmmd+LRMuP8bOwN2H/L7qnjxEDCGQhZrWS2T3AXgpTx0Gw7Bhd00QtvgA2sq
 BbN1oylQYL8/Nxy750eiyUOlvcnD43yanfjhcW8D26BR+X/k88PKeUDgjeTgyQASAgZT
 SbbQjAo1kmzN6SbdTHxMDyscZ151ce/OeWS/pRI3HrucQUTfKuPV9CMuBBcIe0yQbrbh
 elKZlk1bKUcGUKS3ixDIpt/XowIqwvwBE61TgwO0SchDwdA1F1wJZCDxVVb2I09b1hPE
 KCJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tWA33XZa/cz9PUChiNWS4Z6nrgn0YwL/7Lfi/vyfbzE=;
 b=BEMC4cyJYtQGvX83IgUpvg4BQTl9z6oCQ0Hlohkl8GbMTJK9q/nB71vfFg6vJPOVrC
 wxu6jRm698pTeS4QpegRTUoorfCF9nsTaPr1KeRCLYT5tITeGiDzToiPfaUDtUkHBZOx
 nC9QMTzDzWHn05sCAcupBwdG/2bFsSI66RuH0nE6GlIwa78eRHrKzI8Y9jahLdKmVRAk
 /HDab4ESqoRrCMR6ySu1hxyfzWYsYrMxAB6udldtBFcjmZ3i4K/gVCFM8FUplI/dVy9P
 9rrqC7ePzEuLr09+gmox9Cq0lvbtXKt8jiYjiicrfkcONrA1Zvtdegj1ktK8cDj8mMQB
 qTJw==
X-Gm-Message-State: ANhLgQ0Y780/8BAkuPajffpPrLTvulPnqyKadNgC6QYT3Kwbl2it+WDF
 zznZCwMWLNIvZwOHXUF0eAeAJy35aw4W2w==
X-Google-Smtp-Source: ADFU+vuXQDW4lN8Bmy1b4iBQ6rde0MsKRi1SXg7JeW40zhKEF3RIVsoa+R7iTOA+2grud1rIZFvaZg==
X-Received: by 2002:a05:6000:1206:: with SMTP id
 e6mr7822223wrx.339.1584031511140; 
 Thu, 12 Mar 2020 09:45:11 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j15sm36838640wrp.85.2020.03.12.09.45.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 09:45:10 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/36] target/arm: Disable clean_data_tbi for system mode
Date: Thu, 12 Mar 2020 16:44:31 +0000
Message-Id: <20200312164459.25924-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312164459.25924-1-peter.maydell@linaro.org>
References: <20200312164459.25924-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

We must include the tag in the FAR_ELx register when raising
an addressing exception.  Which means that we should not clear
out the tag during translation.

We cannot at present comply with this for user mode, so we
retain the clean_data_tbi function for the moment, though it
no longer does what it says on the tin for system mode.  This
function is to be replaced with MTE, so don't worry about the
slight misnaming.

Buglink: https://bugs.launchpad.net/qemu/+bug/1867072
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200308012946.16303-3-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-a64.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index fefe8af7f52..8fffb52203d 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -228,7 +228,18 @@ static void gen_a64_set_pc(DisasContext *s, TCGv_i64 src)
 static TCGv_i64 clean_data_tbi(DisasContext *s, TCGv_i64 addr)
 {
     TCGv_i64 clean = new_tmp_a64(s);
+    /*
+     * In order to get the correct value in the FAR_ELx register,
+     * we must present the memory subsystem with the "dirty" address
+     * including the TBI.  In system mode we can make this work via
+     * the TLB, dropping the TBI during translation.  But for user-only
+     * mode we don't have that option, and must remove the top byte now.
+     */
+#ifdef CONFIG_USER_ONLY
     gen_top_byte_ignore(s, clean, addr, s->tbid);
+#else
+    tcg_gen_mov_i64(clean, addr);
+#endif
     return clean;
 }
 
-- 
2.20.1


