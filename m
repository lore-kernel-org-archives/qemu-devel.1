Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8E8C2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 17:54:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B701A20714
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 17:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D+H2vv2/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B701A20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEGPn-0005e4-Nh
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 13:54:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56915)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jEGMs-0000Im-1x
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:51:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jEGMn-000281-Q7
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:51:04 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:37968)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jEGMn-00023R-JX
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:51:01 -0400
Received: by mail-wm1-x32d.google.com with SMTP id t13so244527wmi.3
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 10:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ct6UnNO0v3t7GlF0HPoxhyjiCS97DL0SR0Dn0QoY3ek=;
 b=D+H2vv2/ZJHaFBk4sfreBJmvQVNbPMwYBsV1/MBbHbDWTR4QlU4DzOZtpjtJCmZRt9
 GGbbg/ia7Em/WgtmW9IIreh3RoWin5cesql74IOyQ2zmMWk6rn+RDS17EKbZG6Lft8CJ
 IN9wJpz3TrOxs7t2MRI8lpAm90o3f6K7PQfq7CdPBvab87BAp09nRmc+nvGdPXo/TGBI
 qwsduMUbtlcv4I+J7C25NfyuLMjpslo48nlRwJWVu5k/zCgzdPXrwsj/6VwkR6dU+Qes
 MgYd611UoG10XSlml6Qef7Gj1bwcVFy2VCXZ9shxyyYlX3g6VnMBumcmnpOf++iERfgd
 rTnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ct6UnNO0v3t7GlF0HPoxhyjiCS97DL0SR0Dn0QoY3ek=;
 b=XeySG/31U/Z88fM6OQ7GJjTmKu8x0XTptbbnmD6iARbx2MQSJt98RxnyRcF6D3u7bO
 Z/3On4H50ju2KdWOdWKidfYtmV5SBpsg4/x2/aX2CZEjbOw3B3VL6JCluiSitanaMig4
 KPWTYJFg2tP6TKrfcsFJDWgXmbZ9KFGqS1DpUDtRoxnTJ9xCmCEjxZSP5aHj7GwfcL3l
 g4z02KuI5fFj/2eXQ74LwmSqsd1aTBhGAl5wWP9suS3Q2QKjj0uDqe48gG+LrrUxQP7C
 fhLYawaMiHkaSAsP3fIiI8W30aDEkNNcOMA5+CTT2a6edK87LPOji+QwshIekp9yh7Z2
 XhqQ==
X-Gm-Message-State: ANhLgQ1jZU/lfb044iJHNW/aoFVKSCuxNEj8LEREANynlLxyaeV1MDle
 1RX7Pv+nDjpKOyjOZyKoRO4nXQ==
X-Google-Smtp-Source: ADFU+vuch3Ao6ABNa+ZQ3QfON5r9r12PtWaurqNjci4gA+t1+WRN9nPrr2SbIyBcNR845r/VmBY03g==
X-Received: by 2002:a7b:c770:: with SMTP id x16mr144638wmk.159.1584467460485; 
 Tue, 17 Mar 2020 10:51:00 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n9sm207661wmi.23.2020.03.17.10.50.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2020 10:50:54 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 840841FF8F;
 Tue, 17 Mar 2020 17:50:53 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 03/28] tests/docker: Remove obsolete VirGL --with-glx configure
 option
Date: Tue, 17 Mar 2020 17:50:28 +0000
Message-Id: <20200317175053.5278-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200317175053.5278-1-alex.bennee@linaro.org>
References: <20200317175053.5278-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32d
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

The GLX configure option has been removed in 71c75f201d [*].
We missed that when updating to v0.7.0 in commit fab3220f97.

This silents:

  configure: creating ./config.status
  config.status: creating virglrenderer.pc
  ...
  configure: WARNING: unrecognized options: --with-glx

[*] https://gitlab.freedesktop.org/virgl/virglrenderer/commit/71c75f201d

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200212202709.12665-3-philmd@redhat.com>
Message-Id: <20200316172155.971-4-alex.bennee@linaro.org>

diff --git a/tests/docker/dockerfiles/debian-amd64.docker b/tests/docker/dockerfiles/debian-amd64.docker
index b67fad54cb7..a1d40a56fa1 100644
--- a/tests/docker/dockerfiles/debian-amd64.docker
+++ b/tests/docker/dockerfiles/debian-amd64.docker
@@ -29,7 +29,7 @@ RUN apt update && \
         libgbm-dev
 RUN git clone https://gitlab.freedesktop.org/virgl/virglrenderer.git /usr/src/virglrenderer && \
     cd /usr/src/virglrenderer && git checkout virglrenderer-0.7.0
-RUN cd /usr/src/virglrenderer && ./autogen.sh && ./configure --with-glx --disable-tests && make install
+RUN cd /usr/src/virglrenderer && ./autogen.sh && ./configure --disable-tests && make install
 
 # netmap
 RUN apt update && \
-- 
2.20.1


