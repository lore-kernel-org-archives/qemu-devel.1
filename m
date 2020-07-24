Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A84EC433E4
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 06:52:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21F1820714
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 06:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EGWIkPTG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21F1820714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyrZ9-00072r-CL
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 02:52:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38104)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jyrSY-0004O7-27
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 02:45:34 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36127)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jyrSU-0000Lw-0A
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 02:45:32 -0400
Received: by mail-wr1-x441.google.com with SMTP id 88so7257477wrh.3
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 23:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5qWBsUBL0rRACFD5SJtMCfUkk7hZwZaQ4gS8O1OugSM=;
 b=EGWIkPTGJ/MjDG3ScsYu2NgagVco3kUB2JQLHhPF2ea9xlC8rqrIfbIUK7sdjNK48I
 dnCFJH+YFSiphz3d35Hz4d4js9zFuBSml+tXcUeM7r1+mm9N6BsERceeNCUOkK3+abgP
 EMvb3P9JLvXB1Iqvl8dsDd6ILIP9xtYGNKRPN++J+DVblfvtWVkWazG8FW8m4TdulKQl
 7pXeBKH8yzPPfa9nauOZ6/P6PyOyMCwG4VvkUEejNZtEP+BWYilQWeiv9Cnm4waD+wOu
 t4d9Z2p9bw0FM3woDM7UAw58sUhsKhG7k/nt11SRHXQ9CER8mNqisND+GgT5q09LGQL6
 5UDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5qWBsUBL0rRACFD5SJtMCfUkk7hZwZaQ4gS8O1OugSM=;
 b=CSKPBkrY20RTxFhZTQoNWOUsJYm4wKdY87bX9pdnpi45ioJLvA+XkjGD4iM0hNRYXn
 pMfjLe99Di0Mye+aDgjXpcZjombJmwH5plkb12uO6rHilPjCMRjQO80p/pHLed9P9Z4L
 qjzi34hBFZvsipxhiG7dhIg0cwjxZ/IDmehggwM+zf7vzBjXJIgthOL/G6SZ1w7+pNVn
 pjia65p4eB32m8FeLi+mGxNP7pt1kF6pK9NrTkOQZE+VfaI64Y20F6wIPWymUpbbYx1t
 k4rEYKy2jOybO4cdmw9ynmR4bsguDvloshIuPeNIMAD/ZtNLSQ+j26o/OgQgATZucvzY
 8XCw==
X-Gm-Message-State: AOAM531ix07NFRaFzxp7n2IHcV61aGiR26r7ekiC2NctXqU7U29VLdxi
 Tbx7VfZ7dRLvsY9v2z2Ukdg/mw==
X-Google-Smtp-Source: ABdhPJxRVE469D1J/pdypPeWMhmHeZx1wcdFX6pVE6bhT+GIOtxooQ09wcdCrkE9q6h5ZLqeTIc/kw==
X-Received: by 2002:a5d:538a:: with SMTP id d10mr2941718wrv.280.1595573127747; 
 Thu, 23 Jul 2020 23:45:27 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 62sm171572wrq.31.2020.07.23.23.45.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2020 23:45:23 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 613261FF9C;
 Fri, 24 Jul 2020 07:45:10 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 13/16] linux-user,
 ppc: fix clock_nanosleep() for linux-user-ppc
Date: Fri, 24 Jul 2020 07:45:06 +0100
Message-Id: <20200724064509.331-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200724064509.331-1-alex.bennee@linaro.org>
References: <20200724064509.331-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
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
 Laurent Vivier <laurent@vivier.eu>, cota@braap.org, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Laurent Vivier <laurent@vivier.eu>

Our safe_clock_nanosleep() returns -1 and updates errno.

We don't need to update the CRF bit in syscall.c because it will
be updated in ppc/cpu_loop.c as the return value is negative.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200722174612.2917566-3-laurent@vivier.eu>
---
 linux-user/syscall.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 43a6e283961..f5c4f6b95db 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -11840,13 +11840,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             host_to_target_timespec(arg4, &ts);
         }
 
-#if defined(TARGET_PPC)
-        /* clock_nanosleep is odd in that it returns positive errno values.
-         * On PPC, CR0 bit 3 should be set in such a situation. */
-        if (ret && ret != -TARGET_ERESTARTSYS) {
-            ((CPUPPCState *)cpu_env)->crf[0] |= 1;
-        }
-#endif
         return ret;
     }
 #endif
-- 
2.20.1


