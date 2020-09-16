Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75764C43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 12:30:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01CFF22225
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 12:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P9tOy0dn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01CFF22225
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIWZl-0006nH-2o
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 08:30:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36696)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kIWWZ-0002N6-MC
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 08:26:59 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:44240)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kIWWX-00059a-Ve
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 08:26:59 -0400
Received: by mail-wr1-x42e.google.com with SMTP id s12so6671138wrw.11
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 05:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ktsao0Yr9LA/9tEst7nosAjV8iuHgs9MeN8ofZc1GKU=;
 b=P9tOy0dn7xDs9MfiQW7s7b3wrLjqT+3Ud5cTYvd30dzRlalOyVzpoiOs/CaIWuhf5x
 xQrEdnGucV1Jc/uvze69pcaum8hjFJyX4r9rxGVGwGRth6Z2vNvN8+aOPtXTwMzEAIqY
 w36JsThHcKIzm/At8OeNxLmhedPckWdyQYWqNixTQA8pPKp6+Z1RI7bNaRB9OBR8XTsH
 544e6Qf+C5/H1klGZtyjVENpUBqk9Qg7CrH0lnym/9sF1BKH48BjhTF45Gxv5xRbJfy6
 2JgB3BZ/S99DjYSV4G2PPIQqHyyk7VP98tKV976bR0mtNxwpGEGMHNv8Gza7A611Kb3I
 pDzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ktsao0Yr9LA/9tEst7nosAjV8iuHgs9MeN8ofZc1GKU=;
 b=U0zM9Wo4oZzJCiy5hJzmOUwSY4lQPMEYwHRm+SfYtIgHci6nSNKYstlUkm8OMYAgGL
 UdhMUmIz47CpFoLwaXifcBZCFt+CuGgvZwk6sxOx7rgHxJuMFaYfpOZxIuQ1W74a99IA
 ksOWibAzVE5oH8AYzIDpdxHeI0ZPQb51adp9r2M17w+FeBPt0XZVCPoV1o6UI/H0t+XZ
 rmvjC+e41B/DB7TyUGxCi82isznDbsILfcDOrLeU2QxFH2HB6NFvuP/cxeVbQtvYNrSF
 g9gekoE273ubadM5PaHieescL8RJbF+Gi77PEvycSnR5DzdofF9U/RJTGfEH98I/IUHc
 JGWg==
X-Gm-Message-State: AOAM530pyzJwXuB5s+Wg2sUrEOUkt7+Ib7AqlfOwfa8fZbzoX6AC/M8P
 MBrnBJnQtXwsSMWWPv9yk8DD0g==
X-Google-Smtp-Source: ABdhPJwaIEKrjJmzFNEEHSIbceUtInRs5BcfPeqc52IiH1kqHCzcZJwXw333gQIHXQAXB7nKkBoTvw==
X-Received: by 2002:adf:b74b:: with SMTP id n11mr868485wre.274.1600259216498; 
 Wed, 16 Sep 2020 05:26:56 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u186sm4534115wmu.34.2020.09.16.05.26.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2020 05:26:53 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CE24C1FF90;
 Wed, 16 Sep 2020 13:26:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 4/8] configure: also skip deprecated targets with
 target-list-exclude
Date: Wed, 16 Sep 2020 13:26:44 +0100
Message-Id: <20200916122648.17468-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200916122648.17468-1-alex.bennee@linaro.org>
References: <20200916122648.17468-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
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

Now the user has to make an even more deliberate decision to
enable a deprecated target rather than getting it as a side effect of
using --target-exclude-list.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200915134317.11110-5-alex.bennee@linaro.org>

diff --git a/configure b/configure
index 51d03a8d340f..f5fe48d6dd7b 100755
--- a/configure
+++ b/configure
@@ -1729,9 +1729,14 @@ if [ "$bsd_user" = "yes" ]; then
     mak_wilds="${mak_wilds} $source_path/default-configs/*-bsd-user.mak"
 fi
 
-if test -z "$target_list_exclude" -a -z "$target_list"; then
-    # if the user doesn't specify anything lets skip deprecating stuff
-    target_list_exclude=$deprecated_targets_list
+# If the user doesn't explicitly specify a deprecated target we will
+# skip it.
+if test -z "$target_list"; then
+    if test -z "$target_list_exclude"; then
+        target_list_exclude="$deprecated_targets_list"
+    else
+        target_list_exclude="$target_list_exclude,$deprecated_targets_list"
+    fi
 fi
 
 exclude_list=$(echo "$target_list_exclude" | sed -e 's/,/ /g')
-- 
2.20.1


