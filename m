Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C82FAC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 12:29:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 929312074F
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 12:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fMMntSOp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 929312074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k02GS-00089q-Qf
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 08:29:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37124)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k02B2-0007Sz-5i
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 08:24:20 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:40278)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k02B0-0006SA-CC
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 08:24:19 -0400
Received: by mail-wr1-x433.google.com with SMTP id l2so4116183wrc.7
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 05:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=a9EvgEdBVuLI76HbSujJ5mYXWXYqdvnxohcwrpyH65M=;
 b=fMMntSOpw1y0nccc5yEPvcQcvTWTbr8gsbSWvcQ/URszXIzWDzLVx7TRO3DTq3dDoL
 plXy2PZ/2zGkj6c/i/iLjrMZB7dYQxfwrdWgOnVUMS6WK5CtNgsO6YwsNT+8bgnI6bJq
 SG+8OBpTgrg6AH0/Z8Zu9qOGKdoTZx0vnuptQKqgfFGGEArwR5raNDk8+wWGVlq+VdKk
 HAltWb7rvA3Ef9DEzXPiYl4YuUhN3n45KCOIyX3NxmM6Xcexb5/Jc1Br1eGkZ3ZE9Zzy
 krxTdmuQ8iZO8dW1HywiFNIuyy5Tyuzj/v3F9hd5DfOMJzNSQKqt8/dsr43PdZZs+SP3
 05fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=a9EvgEdBVuLI76HbSujJ5mYXWXYqdvnxohcwrpyH65M=;
 b=ft3Yr1u+K/S9GXHrR/ifI+i7EiQKlKz0tGT5TW38Lcj61hXEfxJUUJ/f4pbQXAf05J
 eZo/VoN5GZ79KFIMQCp1Dv+34VD4SjP8E328Xq1je37gqT3gPIpfu/rQcPFEd4RjfzI0
 EyVJksF3DtQTJh2cle8UUyKMY6DUSfpV6+RCmGKMKYWs6aSrvzp5Tp0iU/0QDTSxwGf2
 juYvH/NKlb9YcBNP4uWqyAP4uaeoIPKmhuOAg51F+gK/rwnlmdMGcmKzC6akV7a/3kE2
 37nQ8enT8DpcHIQ0FHNz/BqJnfAykqgdFPmXtuiVEFxxegtXmYPUNIlOLSCnpLd0WQKT
 vgyg==
X-Gm-Message-State: AOAM530pWrl0mD/+h7MAb/wrI3FxP6Uvjs8ECLNCD4FdjCpFDv4MIYd7
 uxtY1wtDp0nptnoUbpcDJMLbwQ==
X-Google-Smtp-Source: ABdhPJyo7r9Otgq/aTHzDqq4RIHRM/mAXRVFdlzr6g9e9E2z8utK+4sEatWv5Gu8g4/31A4fCFI0SA==
X-Received: by 2002:a5d:490c:: with SMTP id x12mr19399070wrq.238.1595852657093; 
 Mon, 27 Jul 2020 05:24:17 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w7sm18622137wmc.32.2020.07.27.05.24.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 05:24:06 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6A49B1FF9A;
 Mon, 27 Jul 2020 13:23:58 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 11/16] tests/docker: add support for DEB_KEYRING
Date: Mon, 27 Jul 2020 13:23:52 +0100
Message-Id: <20200727122357.31263-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200727122357.31263-1-alex.bennee@linaro.org>
References: <20200727122357.31263-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For installing stuff from sid or ports you may need to manually
specify the location of the keyring. You can even import keys into
your personal keyring and point it there, e.g.:

  gpg --keyserver keyring.debian.org --recv-keys 84C573CD4E1AFD6C
  make docker-binfmt-image-debian-sid-hppa DEB_TYPE=sid DEB_ARCH=hppa \
      DEB_URL=http://ftp.ports.debian.org/debian-ports/ \
      EXECUTABLE=./hppa-linux-user/qemu-hppa V=1 \
      DEB_KEYRING=${HOME}/.gnupg/pubring.kbx

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200724064509.331-12-alex.bennee@linaro.org>

diff --git a/tests/docker/dockerfiles/debian-bootstrap.pre b/tests/docker/dockerfiles/debian-bootstrap.pre
index c164778c302..35c85f7db8a 100755
--- a/tests/docker/dockerfiles/debian-bootstrap.pre
+++ b/tests/docker/dockerfiles/debian-bootstrap.pre
@@ -79,6 +79,13 @@ else
     fi
 fi
 
+#
+# Add optional args
+#
+if [ -n "${DEB_KEYRING}" ]; then
+    DEBOOTSTRAP="${DEBOOTSTRAP} --keyring=${DEB_KEYRING}"
+fi
+
 #
 # Finally check to see if any qemu's are installed
 #
-- 
2.20.1


