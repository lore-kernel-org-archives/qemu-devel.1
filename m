Return-Path: <SRS0=q9Vo=YU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4128CA9EAF
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2019 19:24:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E1A920717
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2019 19:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B3mfhEcI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E1A920717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOo9a-00083Z-6D
	for qemu-devel@archiver.kernel.org; Sun, 27 Oct 2019 15:24:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40013)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iOo7X-00056r-Rq
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 15:22:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iOo7T-00074g-Ii
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 15:22:34 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:37777)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iOo7S-00074K-5T
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 15:22:30 -0400
Received: by mail-wr1-x42b.google.com with SMTP id e11so7664892wrv.4
 for <qemu-devel@nongnu.org>; Sun, 27 Oct 2019 12:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EDYONk5c0EBAOOyd1cg6ayjAHSM/nf0MYDEf+17uSlk=;
 b=B3mfhEcIaQDUdV8HKFOEj4u8+34fzFBfR6Os77lnNV3ZKgJGTegKyftVkVP3Yrwhs0
 8Eq005Nn/SWgA25u2WVXXqEhLO0A1Ie5a8PuiLhqpdciPD67C+NwM//eBN/t36Ho1Bx5
 AVj0q4wolWKBRyozhLQ7wXV+nyyhiTyzD46CIQaYVQlqkflM3IlcCJJeOSbsQsyq+qNz
 6Py2lCZ1EqanExpyZi0MmabpF83Nb25REbN15j4Egxmnm/2GxB0iZwqi3zMfpIju68wv
 8UN25l2AR/rE6ojmTCVlziVZmzcTLn2sw9d5al28lLzNRowSiYcqq9GvnfgMCjkOP9pg
 FZrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EDYONk5c0EBAOOyd1cg6ayjAHSM/nf0MYDEf+17uSlk=;
 b=Rlf9sWtlpYUsqR15uIIJISUURCz9qc/PIVb63X/sl6W3LSn6Vm4urNmRB7IWEiExhK
 tIgpSLnUudXu/QbhRqTFDLtOoYRya7IOzkqzDh+uGwlBsnIv1WEcEop4yC0hnoSSb3Qz
 hs99YDt7I2d74m739DNRzmD6iBcM23Gdw6XHiomReJ14jNhghQQawNwiLNiolL2e2sf/
 b/dKg0QApJ3P0y8HYg1Yd3KUpFexKdjSs2p44E3hifkWcBuUV2LyMpsbXzPdFcEp6L6p
 vk94Wa3GhiA8Mpu57WzAQRjoERUjMFJ103OmqyWHMhtyB6VDloURWb6HLsywKCy2euMW
 nfgA==
X-Gm-Message-State: APjAAAX3D8E3S0tOQnda6eiTuAu/h0VxqL1uKu5dqXyDKucYa6DJxFty
 2EmD+XWOYLMTXfUC6skHRY/5ow==
X-Google-Smtp-Source: APXvYqxXG3vVHkB0BnoQLe3CWGCdmSJts/SvR4ubqJi9SXPCp7+noopDSPJ2HIkVwYhkv45tKPR7UQ==
X-Received: by 2002:adf:a157:: with SMTP id r23mr11576194wrr.51.1572204146382; 
 Sun, 27 Oct 2019 12:22:26 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q11sm8130724wmq.21.2019.10.27.12.22.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Oct 2019 12:22:24 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A19D61FF8C;
 Sun, 27 Oct 2019 19:22:23 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 1/3] contrib/gitdm: add Emanuele as an individual
Date: Sun, 27 Oct 2019 19:22:21 +0000
Message-Id: <20191027192223.10855-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191027192223.10855-1-alex.bennee@linaro.org>
References: <20191027192223.10855-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
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
Cc: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Again this is guess work based on public websites. Please confirm.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>

diff --git a/contrib/gitdm/group-map-individuals b/contrib/gitdm/group-map-individuals
index 1c847174380..bcb50e325cc 100644
--- a/contrib/gitdm/group-map-individuals
+++ b/contrib/gitdm/group-map-individuals
@@ -14,3 +14,4 @@ noring@nocrew.org
 samuel.thibault@ens-lyon.org
 aurelien@aurel32.net
 balaton@eik.bme.hu
+e.emanuelegiuseppe@gmail.com
-- 
2.20.1


