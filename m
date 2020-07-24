Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E885DC433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 06:52:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B57AE20714
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 06:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p04GFu32"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B57AE20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyrZ2-0006j8-Vt
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 02:52:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38106)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jyrSY-0004OF-1z
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 02:45:34 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33763)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jyrSV-0000MC-Qj
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 02:45:33 -0400
Received: by mail-wr1-x443.google.com with SMTP id f18so7275904wrs.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 23:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nuRgaJpHsfYCPj7hspcbTe7Etj9//S0efTA7UU/SI/Q=;
 b=p04GFu32I64rK7bhN+j46Dltf+esqa05/VBG/SAhybu5c9wj1Nj9sJ9WjVCo6sVCJ/
 wqX2XhoNKE9SlyzFAXZXEWoRKFr/eCsRngutWUHor75Ai/5c1AoxTAFBGf5VSJNk0FVx
 HAnATcg+cqo9U87XbXF+LSRVSMxd6LB7A64CioJAk3C9/ash5KGW1joeO90Smyha1xDd
 CAR5XQ9ADKN5hp7A+J711WTEvKT2dRlYTyIgBByxpGHuiKymORjw8migylKUiUcW68eR
 +ASQ1GZCBeV495FNZoXQJjm2A4kW/PUTUitjiCo/CRj3/xlZPGsKqdr8xnZ7j/c7AKOz
 CLrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nuRgaJpHsfYCPj7hspcbTe7Etj9//S0efTA7UU/SI/Q=;
 b=GlbCQR2dbgwQKO07R+6MF2t1waFplawc8Kb0dBO9d1bKXdWGlAkz9JCLrQRsHorL7h
 xrjfLo4qHmbR681J8lwTKKO8IIslw1mi9r6pmRUwSm/a93BbniB4LbX5qZadc/2PRGww
 fmuL5DymbJJ0yUapJ9V5JGUS9HRnLgGXrxfoJC/f4LSIdWg2U/otQ2Bkc1hJ33aoG9d7
 ltMhAa+JLJDcG1bzbeDfbpCHte19RY2c/GpU+Ff+96vnY69GBQOUMzgB43iqOEB87ADz
 yDJHfuFPPa+O8sU3HH+M3M4yp8gA3PNi/a7HNCretoe4azRHlyiwvS8vJzaZy/ptqpNe
 0nDg==
X-Gm-Message-State: AOAM530inadzdvoqYZ5jFizu1tnJcrDkzMHU/Xocylg6notAtVxhamYp
 KIYZeUMM9hFMBSkpi4DvwuWaIA==
X-Google-Smtp-Source: ABdhPJwoiGaR7Qj77Fsj6kpBC4DXEdQaMkvKybN0rcy90kU06aTQIAcKp4JtrzWEjbeNeHnN1wjwnw==
X-Received: by 2002:a5d:4e81:: with SMTP id e1mr6841055wru.22.1595573129592;
 Thu, 23 Jul 2020 23:45:29 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j145sm6561848wmj.7.2020.07.23.23.45.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2020 23:45:21 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 376271FF9A;
 Fri, 24 Jul 2020 07:45:10 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 11/16] tests/docker: add support for DEB_KEYRING
Date: Fri, 24 Jul 2020 07:45:04 +0100
Message-Id: <20200724064509.331-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200724064509.331-1-alex.bennee@linaro.org>
References: <20200724064509.331-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 aurelien@aurel32.net
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
Message-Id: <20200722062902.24509-12-alex.bennee@linaro.org>
---
 tests/docker/dockerfiles/debian-bootstrap.pre | 7 +++++++
 1 file changed, 7 insertions(+)

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


