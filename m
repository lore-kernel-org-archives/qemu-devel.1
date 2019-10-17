Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EED3ECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:25:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42BB720869
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v5xN3Jku"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42BB720869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL5m1-000118-3b
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 09:25:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33877)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5df-00080P-SU
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:16:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5de-0005PC-OX
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:16:23 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:35617)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iL5de-0005NS-Ij
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:16:22 -0400
Received: by mail-wr1-x431.google.com with SMTP id l10so1903837wrb.2
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 06:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eKrMpcgiWZC+DVZc7vkQy9WeCAb7Sz4gQtueyAwrb/8=;
 b=v5xN3JkuIt3wd6wuymwE0JqYIExwsxOuaFlP8UbfenSQRQlq7nm5pKzNCAWfSHg0iP
 P5f6UOXqVGD0f6/3mx5gVKJ8HzKoDQ7xTIj2WInqLRug/7jM9c2mfhcFedT8X72G9nEj
 XhfinKMtEc4aQlfS7J49ZpV6N+c3vg4Qez+p60LTzFp+2up3pUqBePdWzp9AAhHGGirQ
 lpLS8tC+wij/+qbgoi7RlIJ2Ut3zABqgRAfEMCgSaJG37ZVXBQCpXwjJgrUz2+W4WGO9
 wXrxCeyX186iYd5IkreeA/oQ+AuUe+ERqLYf+KZ2bqvdcfdTNPtWWHYJrBQUzeuFQ5wG
 WNzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eKrMpcgiWZC+DVZc7vkQy9WeCAb7Sz4gQtueyAwrb/8=;
 b=SsZ8awDeqWOLC14HfnctaEuMkA+Z6eBc4I8dK8DOnpg/H9zDCYAr3oPlUIw6cZc3Sv
 GBDtlKoS1rFLEcvEvP1Vvlo8lkIgfSGOFwql/1qtFvX5Mxpp9XdNOPJteDGoUgi8bBfx
 rv3qyQ16gHn4Wjfb5aTxXVVbQQv+PdOGlVrWsAJ81vvVO42QqZHiafwKEOnC7iOrJQCi
 2re9MafutsXfdBns1u3tXVyHilPYww0pUWJE+HZtk/TZn134C5ReKVRGTUCCioyabylm
 Os+zayNjZg2QRfZ3UuSa5eV7NuLCuEy85SGqi542Aq5i3jsDfyoQf46VcpKUCz+lLfon
 wU4A==
X-Gm-Message-State: APjAAAWeU+3mQvUX3siPEnk+yXIyI8T8F1skTzqzbQ5zKAayt5wpOCWX
 iZvbKVSfkB0IWpF/pQsVzXJ0fyFx+sc=
X-Google-Smtp-Source: APXvYqxTU+TcFxdnz+Z8i3jLUf1hYb1KSG7sVBB8OFNC9HTKLLWAUE/yXZz3jeWOVkH5Hq+4vUoUkg==
X-Received: by 2002:adf:ef0f:: with SMTP id e15mr3146256wro.312.1571318181446; 
 Thu, 17 Oct 2019 06:16:21 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q14sm2681495wre.27.2019.10.17.06.16.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 06:16:21 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EEDD81FF9C;
 Thu, 17 Oct 2019 14:16:16 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v6 12/54] tcg: add tcg_gen_st_ptr
Date: Thu, 17 Oct 2019 14:15:33 +0100
Message-Id: <20191017131615.19660-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191017131615.19660-1-alex.bennee@linaro.org>
References: <20191017131615.19660-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::431
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
Cc: robert.foley@futurewei.com,
 Richard Henderson <richard.henderson@linaro.org>, peter.puhov@futurewei.com,
 aaron@os.amperecomputing.com, cota@braap.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Will gain a user soon.

Signed-off-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tcg/tcg-op.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
index e9cf172762..7c778f96f3 100644
--- a/tcg/tcg-op.h
+++ b/tcg/tcg-op.h
@@ -1249,6 +1249,11 @@ static inline void tcg_gen_ld_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t o)
     glue(tcg_gen_ld_,PTR)((NAT)r, a, o);
 }
 
+static inline void tcg_gen_st_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t o)
+{
+    glue(tcg_gen_st_, PTR)((NAT)r, a, o);
+}
+
 static inline void tcg_gen_discard_ptr(TCGv_ptr a)
 {
     glue(tcg_gen_discard_,PTR)((NAT)a);
-- 
2.20.1


