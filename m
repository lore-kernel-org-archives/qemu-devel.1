Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE63C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 20:11:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE1F120734
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 20:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U03bWEWI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE1F120734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jikaL-0000lF-69
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 16:11:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59288)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jikZ4-0007RC-K7
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 16:09:42 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:41994)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jikZ3-0005Zd-Rb
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 16:09:42 -0400
Received: by mail-pl1-x643.google.com with SMTP id x11so7667plv.9
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 13:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hi7LUnC/2Vxc6CG4AyW71h/9KhgELUl20yMZDhooBMo=;
 b=U03bWEWIv5lmCxfVjI5TYxG7RiozcKxCQ+evlMNwHzvIXrXt1/I7T6fSDdvPQR7pVP
 hw9kBk29qkHugmcZCb2wefK1ecjO6DaQCyVwoeu/nH+237tldj2WIkjAtT6R7QVSAdzU
 R1bCWRRXbzX9F+7uiweQMhNFjs2dNLwzyurj5xF7FErQdZhqezs1wc+sY8mfoTFf/keG
 9jCu7LrOBjx9mMkcH4P5Qh5GWfwOWzoETs6kIpqrhsk8arLLQZvQw00cPG/u20End6NM
 qJHridjevr2gCVkVh+5g1LOEeJorocZlLR2LdzMDsIUOSkBeY9jQ7iDifyJh6y/+ZAy8
 Qojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hi7LUnC/2Vxc6CG4AyW71h/9KhgELUl20yMZDhooBMo=;
 b=S2QTGC5y5YXNmKjFKj+tQHO6iyn05azFckMbvAFhkQjVmCWCmjJ25CKGXUhCUo9vlR
 F1h9fVPhb7AnTo3rKFlt65NKBLqgqhii4GGHTS9A8oJavQ6pCl6qANxqF8+UOFIKxN2O
 Jyj+m+7u797CJRVSyk0cnUpofd5rGlL/XkRIWJnCxGyHhpfBM/5EOKDgaJLgM5lqk0Zu
 ujDQ3yc9DfmwnzsVPxQDn0zG0zD7iNiVWxIdFkPZgn6ox0+zBuhWqeIelrS1l6HFuht0
 3MT8tn9SyqLFOoxadBdVTTwHJh+3sH/Q617GA0HYKiARbRRwnvzrayCiAtsWD2/5aY6t
 ULwA==
X-Gm-Message-State: AOAM530oq8ikNu477zwlnfBmyaqLe08eb1W0OGYyIpbo9Xfv/r/jWC2I
 4bv8TaHDQZT1yT+/hqypXnXTjVkcWONxMA==
X-Google-Smtp-Source: ABdhPJwypIq3skTHG6eKDpGKZhbgZ+3obRqjtUqU0TqiC9pvYMIKw0xGDMscL+kqSdh6xKIqrJaW4Q==
X-Received: by 2002:a17:902:7247:: with SMTP id c7mr63673pll.103.1591733380337; 
 Tue, 09 Jun 2020 13:09:40 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:1d09:cef2:3b1f:abce])
 by smtp.gmail.com with ESMTPSA id n19sm10523374pfu.194.2020.06.09.13.09.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 13:09:39 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 03/13] thread: add qemu_spin_destroy
Date: Tue,  9 Jun 2020 16:07:28 -0400
Message-Id: <20200609200738.445-4-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200609200738.445-1-robert.foley@linaro.org>
References: <20200609200738.445-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=robert.foley@linaro.org; helo=mail-pl1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.puhov@linaro.org, cota@braap.org, alex.bennee@linaro.org,
 robert.foley@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

It will be used for TSAN annotations.

Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/qemu/thread.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/qemu/thread.h b/include/qemu/thread.h
index d22848138e..e50a073889 100644
--- a/include/qemu/thread.h
+++ b/include/qemu/thread.h
@@ -215,6 +215,9 @@ static inline void qemu_spin_init(QemuSpin *spin)
     __sync_lock_release(&spin->value);
 }
 
+static inline void qemu_spin_destroy(QemuSpin *spin)
+{ }
+
 static inline void qemu_spin_lock(QemuSpin *spin)
 {
     while (unlikely(__sync_lock_test_and_set(&spin->value, true))) {
-- 
2.17.1


