Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85A1C43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 12:28:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21A9A21D24
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 12:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k/KNwq6q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21A9A21D24
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIWXq-0003zL-2O
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 08:28:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36700)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kIWWa-0002PC-Fn
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 08:27:00 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:42478)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kIWWY-00059h-V6
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 08:27:00 -0400
Received: by mail-wr1-x42c.google.com with SMTP id c18so6687692wrm.9
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 05:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HQrz0i+rDWZq2bY4Msh6O9mfJzIupW4z7nc0usXBlMM=;
 b=k/KNwq6qqJ8eqhK+/NIYt3rCfffaYaZsoBQcUVoyGor6pRyE+vWSbxLLeoPA3djjrO
 DIGXZzI0gFt9Q42v5faJ0crU2W5yBTezOLpE3EvJuWivH8on/y1lzJn0B1UfP99hY6E7
 FVsz7/Rec88/LcVn9FS4MgbU7+nOGFvt/IEmIiLmvZBlGimDnoYLOgZ1TiIvreUYIF9R
 wANHNI1J31JoYUXLhy+1Y12Y7+dvf+T9Tg61P1nBUcbLi8Cn/NRbm0fwVnspLCLzIzPq
 OS9jOYIus2EPaSIn/CI/8pKasxZear2LOk+ztK7RMpINR7oad3GShicOWlsRserWqv4y
 L4lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HQrz0i+rDWZq2bY4Msh6O9mfJzIupW4z7nc0usXBlMM=;
 b=gXs0bt1SdrsMAxlFRs5p4vnsDRHUsiazB0NzhnwD4zw7MHbCEURHTPwVhsTmNRVe2R
 rkOcMAghk/76aX+JiTYeJut7drMPA8C2qTkHa4AqqHA1WwAQfBpdEvR8/SvNt9pPRyW4
 AyOoCAzK1u4BuqDmbctA8Nh2UrOb687z9eVzsJNRaqr/dGenXY+gYr/s6TXT/cwx5LNU
 lzxTOeZNWALxL9jMsd55PJxYkgRt/8JdGcTlw3Q0iWQ3VeePl8J1nfPf9GEu8Piah+UI
 bcRvdZ0nCr+kgfmSqaU7giJycvoOnnm/t94OUeliVoQ2Bkw9aB6lCa2XUwZXds1iLd6b
 2e8g==
X-Gm-Message-State: AOAM531O1f7hpHN/HEH/xI7YNVlKg+r4LfSoSJvrUdGtlbB+0l96CxYE
 ExVxv1T1tXr/mY+IIoStb60pxw==
X-Google-Smtp-Source: ABdhPJwmtk5ykACihv/eRJRJHCyvtE/uKWs8i+JwBbrYs4l1pZuT2kPrWrNEi6QDbYx4dwHR42DD7Q==
X-Received: by 2002:adf:f14f:: with SMTP id y15mr25638980wro.69.1600259217489; 
 Wed, 16 Sep 2020 05:26:57 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d18sm32903071wrm.10.2020.09.16.05.26.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2020 05:26:53 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E3CA31FF91;
 Wed, 16 Sep 2020 13:26:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 5/8] configure: clean-up the target-list-exclude logic
Date: Wed, 16 Sep 2020 13:26:45 +0100
Message-Id: <20200916122648.17468-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200916122648.17468-1-alex.bennee@linaro.org>
References: <20200916122648.17468-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rather than sed and loop just do a grep.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200915134317.11110-6-alex.bennee@linaro.org>

diff --git a/configure b/configure
index f5fe48d6dd7b..58be974065c8 100755
--- a/configure
+++ b/configure
@@ -1739,17 +1739,9 @@ if test -z "$target_list"; then
     fi
 fi
 
-exclude_list=$(echo "$target_list_exclude" | sed -e 's/,/ /g')
 for config in $mak_wilds; do
     target="$(basename "$config" .mak)"
-    exclude="no"
-    for excl in $exclude_list; do
-        if test "$excl" = "$target"; then
-            exclude="yes"
-            break;
-        fi
-    done
-    if test "$exclude" = "no"; then
+    if echo "$target_list_exclude" | grep -vq "$target"; then
         default_target_list="${default_target_list} $target"
     fi
 done
-- 
2.20.1


