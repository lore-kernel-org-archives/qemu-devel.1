Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49129C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 03:28:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11272206A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 03:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D9BdHJWi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11272206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k63ui-0000wR-At
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 23:28:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58480)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k63sA-0004kH-Cb
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 23:25:46 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c]:36871)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k63s8-0008UW-Om
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 23:25:46 -0400
Received: by mail-pj1-x102c.google.com with SMTP id mw10so2104922pjb.2
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 20:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=x/8I1E6U1kT8gsX6JaE/+oNAkXGuibBh0+8jWx18CRY=;
 b=D9BdHJWixCVHf/isjihr1og6IfZHmeqhejt0K5X+Mh3g6hREn6UhOqzv1kq0ZuNcqr
 Nr54XRx67l2GmQZIGU3V4iyh7OdTBUs4eL0zqj8CBAvEAho+6am8hghc15tblRvyJKij
 kRYSDKgvY2nKHqOeQGvJMcEFc7i4shNN/VxqZWsmGJvl9UxAy8BiJa7K+JQV8xvep7EY
 bP485WE8Y3B9gnBsrHjXT9uDtQLB+qP/oJP9TRRogc9X/ct1nL97d5ipwH6lP79C/KIq
 pbkKW0pi/ca6BIsPpT6zdkcvZvnSONERFdw/ST7z9YM0LVXR/7CM72fzfk4tW4vxwRQX
 mwnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=x/8I1E6U1kT8gsX6JaE/+oNAkXGuibBh0+8jWx18CRY=;
 b=R9HsjLOk14PXf3HHOi2PF6j5Kk+NgzSwzn5eGhpko4No0KpaZ4cOfcv66AevELaE5W
 RmzPwxO1pHgSvUN7xv7RU2IB66O7N53cpcOwyc/NsZ5A0ZH84GyNBxGmPRyK78Wm+9Dl
 13pumNOb2lA01DXBjJ/AtOBbmk+YPX9tnviiZydw/FSJ6YpDLe609KR+dxMZEeQREqmG
 b/tcTCCTD88cUgjpPu3GRLhNI+tyEkKpKxAVWzXoJPGpN2ImQbPHch4Qdh0Bnd/DQrkE
 DPS7C/EuHq0yfW7uTUwfvnLerxB93WoD9XA/s55BQU+BToJ71yTVv9rbGCrbBL4yPxzU
 gUZA==
X-Gm-Message-State: AOAM531sJNJ/gws8wr0zFIHjVsOl1htNoaqbWvRP30id9iCzjJJZhcbS
 IsWRF9JKABajBDOj/xPrEumZPv6UB80=
X-Google-Smtp-Source: ABdhPJy2XAADVcCnopGFkbaf6oHY6RDVMfD6hcM7CjnKYImAswC917lVlL1jrQkTv9c5s28UMnOwpg==
X-Received: by 2002:a17:902:40a:: with SMTP id
 10mr2211995ple.180.1597289142930; 
 Wed, 12 Aug 2020 20:25:42 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id m19sm3633164pgd.21.2020.08.12.20.25.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2020 20:25:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/17] crypto: Move QCryptoCipherDriver typedef to
 qemu/typedefs.h
Date: Wed, 12 Aug 2020 20:25:22 -0700
Message-Id: <20200813032537.2888593-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200813032537.2888593-1-richard.henderson@linaro.org>
References: <20200813032537.2888593-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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
Cc: berrange@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This will allow the pointer to be used in crypto/cipher.h,
and not just in code using cipherpriv.h.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 crypto/cipherpriv.h     | 2 --
 include/qemu/typedefs.h | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/crypto/cipherpriv.h b/crypto/cipherpriv.h
index 0823239f41..9228c9fc3a 100644
--- a/crypto/cipherpriv.h
+++ b/crypto/cipherpriv.h
@@ -17,8 +17,6 @@
 
 #include "qapi/qapi-types-crypto.h"
 
-typedef struct QCryptoCipherDriver QCryptoCipherDriver;
-
 struct QCryptoCipherDriver {
     int (*cipher_encrypt)(QCryptoCipher *cipher,
                           const void *in,
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 45b9c57717..d4ca469b6b 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -96,6 +96,7 @@ typedef struct Property Property;
 typedef struct PropertyInfo PropertyInfo;
 typedef struct QBool QBool;
 typedef struct QCryptoCipher QCryptoCipher;
+typedef struct QCryptoCipherDriver QCryptoCipherDriver;
 typedef struct QDict QDict;
 typedef struct QEMUBH QEMUBH;
 typedef struct QemuConsole QemuConsole;
-- 
2.25.1


