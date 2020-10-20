Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5807C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:45:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9DBE206CA
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CM5bax9P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9DBE206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUulj-0001eT-S6
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 12:45:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49330)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kUudz-0007qN-GL
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 12:37:51 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:42283)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kUudv-0000yW-Eb
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 12:37:49 -0400
Received: by mail-wr1-x42b.google.com with SMTP id j7so2951882wrt.9
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 09:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ug2244h7gF1bgNo40QYky11fMBkQqW8reR6QCk5vxV0=;
 b=CM5bax9P6btdbc0tSV77+acjSdBLr782cvsQX/dbzD/UC3DdsBs5nYjz/9E/J24LZU
 n+RURlQeehPcA3UzOjhr1QpKoTfIZhaq5fFlDeerN9oKTUoo/CZjjbjFEyOFK8Ef33fu
 rxgPOc02gAPQGx7aitZ8ttsJutrGicxpLo3Ejj/7uld6QV7W88SgxUdFk5Zy+Hcs57WK
 N4if4q5C3RPrNISPodU00qywmReVWLh3uiLyVFqnPt99v6g7CbNFJYW0RPdols3O2dDD
 hXJ2ao8O4L2heKyVfIDkQzc27VvhgM7kNi1Db7yhxKq980Wa2QJcb3Bomm1X3Y4A7uBP
 o6bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ug2244h7gF1bgNo40QYky11fMBkQqW8reR6QCk5vxV0=;
 b=T1Tr7EdFkNyD5Ubl/TTMgJ/9ia9IcSwqlrvVjDpcStNh23z2swxUumIGDiAL3M/VXB
 B204dfvmObC99TJqXVroY5Oav2g5Z21Jfo3liMi4MKUED2ofc5qzt795+RXg/ZrgUopq
 pgoq30SKhUN/6wqofhqQXqkT3EasDofT08HSydpNhfbVM9Gj8extwuMeRe8Y2X4y1HBZ
 qZJWDN913BLpETt7Jm9a+gNyZzp2544AKMhU8cuASXUUfrbdJtTQUflYipmAQflKXuFR
 Fn81og/2lPeuEaH3CYgJGyDnqLESFZah3vZyoKglRfAPs/OuMHUrJd/6mhd2ZuVC3zZT
 1q/A==
X-Gm-Message-State: AOAM531mR3PP6tpOV0nzPo+M59SbRCGdZG2SfUGzlBJkQY0j7hzGh1tc
 ODKCfMqTjzYXuVW7LiAyKCROrg==
X-Google-Smtp-Source: ABdhPJz+WvHPHGVXOawnQ7+h9CHPslxYhp+674jKrbXBScL6nyPVyurGLjFeQlxlix65YbYnFfJpDA==
X-Received: by 2002:a5d:4c4b:: with SMTP id n11mr4361381wrt.171.1603211866078; 
 Tue, 20 Oct 2020 09:37:46 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v6sm3933801wrp.69.2020.10.20.09.37.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 09:37:42 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 731DD1FF8F;
 Tue, 20 Oct 2020 17:37:39 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH  3/8] softfloat: Tidy a * b + inf return
Date: Tue, 20 Oct 2020 17:37:33 +0100
Message-Id: <20201020163738.27700-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201020163738.27700-1-alex.bennee@linaro.org>
References: <20201020163738.27700-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, cota@braap.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

No reason to set values in 'a', when we already
have float_class_inf in 'c', and can flip that sign.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200925152047.709901-4-richard.henderson@linaro.org>
---
 fpu/softfloat.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 67cfa0fd82..9db55d2b11 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1380,9 +1380,8 @@ static FloatParts muladd_floats(FloatParts a, FloatParts b, FloatParts c,
             s->float_exception_flags |= float_flag_invalid;
             return parts_default_nan(s);
         } else {
-            a.cls = float_class_inf;
-            a.sign = c.sign ^ sign_flip;
-            return a;
+            c.sign ^= sign_flip;
+            return c;
         }
     }
 
-- 
2.20.1


