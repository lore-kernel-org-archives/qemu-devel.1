Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40585C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 10:43:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08F5B207C3
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 10:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n2KP0W3r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08F5B207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jibjO-0006d4-9w
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 06:43:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jibeG-0007nm-Mv
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 06:38:28 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:42512)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jibeF-0004Pq-TM
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 06:38:28 -0400
Received: by mail-wr1-x42f.google.com with SMTP id p5so20691611wrw.9
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 03:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=k3lF9DeNDfRTjUxYMHbrRJM1lI0Q2JxlrXUIAK9HEcQ=;
 b=n2KP0W3r1sfXTeyfE1QD0uZ5i0HjG2xf22421NAtgelSeWmMaSfqXvgwdGmehGcILk
 d+XzzkHJqfGKjDkFggXmR0gWG5BGxBNN7yruzNHg4YStVG+Fp3XkVEw+Tj5gVd+GhcDx
 /42sxHN7k3qMXsHikfpjPRIGVK2Tla3Mw3A8G8GLlYTQbJKHb2hP6DlTwiUyhjVvdHrQ
 LimPZVk3gUKSnEImWudbYdSoDOAqqRs2h118j94WJDT4+KrdmV+sSdooII8g4p2ulf5O
 WCXQoV5IBwL+iRY2M/+W25Q1b3cXSJnRJbH63d1MhCYRdwsbV2Pa/THrpyNyf2g+ANs8
 W0ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=k3lF9DeNDfRTjUxYMHbrRJM1lI0Q2JxlrXUIAK9HEcQ=;
 b=GhA/hVDFWmfP7UPN7Iphgk7losxKN0tnTCbmsB54rV8k4yxXseKi1Za4X5QeHxjjHx
 6OrAcvXP8hHcxWKp8cIydw4zLiWeHG5QzmiAz7b/vrumzjs4F00JzqAgIFdGyACluZV7
 RGtB+IKc7L5CF35cHloch9igcCPt9tuwH9AWIvnaOyOeQC569wLJbv0nVMkPNN2ju4rC
 8oWF5+fv8JMrChi/pMOfZD4QPhwlyWktU8ai+KOQbBDsd6JD6eOXqzwNsX8L56nkq7WL
 WeqH9pDy98vpHa3B1G0buNa3pB3A4Xq77gD3u9anpgntzUhlNgsSIiqZ9jrsR+qZOk2S
 1TLg==
X-Gm-Message-State: AOAM531CfRPSCZZGbVxorrrLP9hcc6kDI9nzurK5uUuFD5sB07uR2j48
 iHHgojG2GvCOOnqVR4FXQaQjyA==
X-Google-Smtp-Source: ABdhPJw+GOGBAuAivyl/zKXfkRTdcEq9CNO3YJM9VGLPf38fT87c7KtyVtrTF3M+Rp2M2Wl6iRlaRQ==
X-Received: by 2002:adf:dd46:: with SMTP id u6mr3476083wrm.44.1591699105982;
 Tue, 09 Jun 2020 03:38:25 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b8sm3145375wrs.36.2020.06.09.03.38.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 03:38:19 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 35B301FF96;
 Tue,  9 Jun 2020 11:38:11 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 08/17] docker: update Ubuntu to 20.04
Date: Tue,  9 Jun 2020 11:38:00 +0100
Message-Id: <20200609103809.23443-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200609103809.23443-1-alex.bennee@linaro.org>
References: <20200609103809.23443-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Paolo Bonzini <pbonzini@redhat.com>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200604231716.11354-1-pbonzini@redhat.com>
Message-Id: <20200605154929.26910-10-alex.bennee@linaro.org>

diff --git a/tests/docker/dockerfiles/ubuntu.docker b/tests/docker/dockerfiles/ubuntu.docker
index eeb3b22bf20..43872417dec 100644
--- a/tests/docker/dockerfiles/ubuntu.docker
+++ b/tests/docker/dockerfiles/ubuntu.docker
@@ -9,7 +9,7 @@
 # system won't pick up that it has changed.
 #
 
-FROM ubuntu:19.04
+FROM ubuntu:20.04
 ENV PACKAGES flex bison \
     ccache \
     clang \
-- 
2.20.1


