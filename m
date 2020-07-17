Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3FC9C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 10:54:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DDC6206BE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 10:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TIsgKk+7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DDC6206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwO0a-0000KW-Mu
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 06:54:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44016)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jwNy6-0004ct-OZ
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 06:51:54 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35700)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jwNy3-0003sB-BS
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 06:51:54 -0400
Received: by mail-wr1-x442.google.com with SMTP id z2so10539549wrp.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2020 03:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KVJaVP/ZQ17vhjW05uiIXG4G85am9cMHX0FIzvUa6Gc=;
 b=TIsgKk+7hM/o3q1rcPINasp0D3y3YY7fmPqK+eUpDIjnY8yEsLNi6ZHjTVaScsxRab
 gSBtqT5xLA/2ClouJBexXk9NnHrmYBFCaxX6uCmkuCtSrNN9KFn7OY8X18/GnL6DxviQ
 mGXYxL1+URFB45O5Uwy/IBK0LGoGjGWcfZzu7P7Dl1Y0f2M+qyZvSwnj4mRsYi5ntk2U
 sUdOq4m8oAbYtvuYB3T6vDvh5KVR4PR6LtWYHA1RKmevmlx3h4KP7eFMfKUKReRUh/OX
 brnfUUVD6k/IJKidftnVoc93zDoxWB2alwQInixtDBJthDlz4xUW7LgpGrtk3AmBgyXM
 azew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KVJaVP/ZQ17vhjW05uiIXG4G85am9cMHX0FIzvUa6Gc=;
 b=TORdoFQVLJRPc++k6hbrs7pEon/XbQ7VS50hfGkMnos8qjv5YlUozFVMBLeXlZw8Qf
 pjfwnaXxAp0hJsXyRdQcTunux1swUuV7hmc5H1RDNQHQu8awAH3VYZlnxGpwiDkfasj7
 j2djw0nU6/fH41f0gqvqzLH602j57exTKXaq+vyOd5h5YEBg1HqcxSyI4VPjMtFwtHEK
 YIZByfS8OR99KptUs3OMyF7DbV/+qPzpNHUg2LZs5MavAWaFpBLQq1D5sWt1AxbJ7COT
 +Xoedyj2mZgiGkyjhFDrptBEOLujvmo6hJYmeaVrGbY9hnCvYj9F8Fk+fOVjzSs0vBDW
 YMpg==
X-Gm-Message-State: AOAM53268o031PSWuYv/WeUAdqIeVqJMubP4av8BCoXhZSjO6JMHRhq2
 zYaFw58DlH73LwAYmgI/UTKWgA==
X-Google-Smtp-Source: ABdhPJwzBflR/rTnGfoL9M2+KTqfN9wYlFd/SsM6RgDTvjAqKdYh+NRhzl3o22Fnmdp2M+TT9ZyJPw==
X-Received: by 2002:adf:f504:: with SMTP id q4mr9479420wro.163.1594983107713; 
 Fri, 17 Jul 2020 03:51:47 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z16sm13486743wrr.35.2020.07.17.03.51.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2020 03:51:43 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 121B31FF91;
 Fri, 17 Jul 2020 11:51:40 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 5/5] accel/tcg: better handle memory constrained systems
Date: Fri, 17 Jul 2020 11:51:39 +0100
Message-Id: <20200717105139.25293-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200717105139.25293-1-alex.bennee@linaro.org>
References: <20200717105139.25293-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
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
Cc: fam@euphon.net, berrange@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>, cota@braap.org,
 Paolo Bonzini <pbonzini@redhat.com>, aurelien@aurel32.net,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It turns out there are some 64 bit systems that have relatively low
amounts of physical memory available to them (typically CI system).
Even with swapping available a 1GB translation buffer that fills up
can put the machine under increased memory pressure. Detect these low
memory situations and reduce tb_size appropriately.

Fixes: 600e17b261
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Christian Ehrhardt <christian.ehrhardt@canonical.com>
---
 accel/tcg/translate-all.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 2afa46bd2b1..2ff0ba6d19b 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -976,7 +976,12 @@ static inline size_t size_code_gen_buffer(size_t tb_size)
 {
     /* Size the buffer.  */
     if (tb_size == 0) {
-        tb_size = DEFAULT_CODE_GEN_BUFFER_SIZE;
+        size_t phys_mem = qemu_get_host_physmem();
+        if (phys_mem > 0 && phys_mem < (2 * DEFAULT_CODE_GEN_BUFFER_SIZE)) {
+            tb_size = phys_mem / 4;
+        } else {
+            tb_size = DEFAULT_CODE_GEN_BUFFER_SIZE;
+        }
     }
     if (tb_size < MIN_CODE_GEN_BUFFER_SIZE) {
         tb_size = MIN_CODE_GEN_BUFFER_SIZE;
-- 
2.20.1


