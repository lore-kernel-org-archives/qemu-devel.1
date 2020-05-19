Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D6F0C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 02:55:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C93F2075F
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 02:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a4ZpaKdt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C93F2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jasPK-0006ow-Cu
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 22:55:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jasOL-0005Ay-84
 for qemu-devel@nongnu.org; Mon, 18 May 2020 22:54:05 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:40259)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jasOK-0002P8-F1
 for qemu-devel@nongnu.org; Mon, 18 May 2020 22:54:04 -0400
Received: by mail-pj1-x1041.google.com with SMTP id ci23so711346pjb.5
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 19:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AybC5+AFZZgiZxEHJk4RYMN+nVSUkMOWZVM2DrgRF3s=;
 b=a4ZpaKdtnrsEGdVV9NMwg1AbtI8gOOs15h1CpoxTxPcFMAkYM/ASf10OXVcapBRh39
 28frS27EVYX14eg7dKcYqL5oqiOuFBnEcsaSn0HblL3CzzLbWX8Lf+3/+hO3MPrhhVFJ
 XGVY21SJPw6q0sMHhiHv7wxiTCZWS4CKrVi9PB11g09hprqLx5Ed5YJtcVHWJ35e4TIe
 PwsQDcMsPyz/f7LK8UBOwDotKSVrQT4LCJ2x7EJHfGt69imPPT98oonmft5CaaiDAKLI
 gVMY6yI+3FnzjGRI1ig5ZVsQEbjIYNjJ7TfdpeAsx1UHv/kAlj2yrjMhCwpOtDS4Yivy
 jJ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AybC5+AFZZgiZxEHJk4RYMN+nVSUkMOWZVM2DrgRF3s=;
 b=aR4b489cfUFrulnNodmUWN9hJ49pZ8RUYS5gagZViUR4klk5wpCtGtR8PrwGNjY+xp
 YCFbyLNr81jBOiWqSOn1W2Ctr3tXavYn+gLELEfIyg13MC67CjvHXdPfcjxh4urmWh2r
 NTOjMz5kyLDox4f2EB/mRi9OjxVKK9n8eRYZ9EQraxyy+c1VfJipdtpc7+bXJbPzs1nH
 48SL/pwndToA2uDiE/5MSqh/XFGo1WAFtD6MB2MBbFemotyRSo6EcFntLz9Ckw+HMkCo
 x1qf1gcVKuYn7DrEjRL1TwxzlpBjfAVbd43rLM7ZI8QvQYy87NoBVwrP0TvnY5wkrxln
 XqgQ==
X-Gm-Message-State: AOAM532VGfcPIoWxTbQ23kj/2YD740kB7dZYLZtdMs+6BwGfE2z9K5GX
 8BNwoeG0k5683in7fyzJUcFefTtsOZk=
X-Google-Smtp-Source: ABdhPJwPSLbiaUY8kvYo3aaOP8u+M6bjvMfEq73jTzSAHfqB7oe8+9qL1h7hNlvwRyoJIxA4a51ihQ==
X-Received: by 2002:a17:90a:1464:: with SMTP id
 j91mr2765954pja.87.1589856842794; 
 Mon, 18 May 2020 19:54:02 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id a2sm8772418pgh.57.2020.05.18.19.54.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 19:54:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RISU v2 04/17] Adjust tracefile open for write
Date: Mon, 18 May 2020 19:53:42 -0700
Message-Id: <20200519025355.4420-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200519025355.4420-1-richard.henderson@linaro.org>
References: <20200519025355.4420-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Truncate the new output file.  Rely on umask to remove
group+other file permissions, if desired.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 risu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/risu.c b/risu.c
index 1c66885..f404d8f 100644
--- a/risu.c
+++ b/risu.c
@@ -368,7 +368,7 @@ int main(int argc, char **argv)
             comm_fd = ismaster ? STDOUT_FILENO : STDIN_FILENO;
         } else {
             if (ismaster) {
-                comm_fd = open(trace_fn, O_WRONLY | O_CREAT, S_IRWXU);
+                comm_fd = open(trace_fn, O_WRONLY | O_CREAT | O_TRUNC, 0666);
             } else {
                 comm_fd = open(trace_fn, O_RDONLY);
             }
-- 
2.20.1


