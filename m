Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A7CC28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 12:08:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D7FB206DD
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 12:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WEfHiC7/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D7FB206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWIqe-0002pc-Gh
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 08:08:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56480)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jWIo3-0006Aj-81
 for qemu-devel@nongnu.org; Wed, 06 May 2020 08:05:43 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:52242)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jWIo1-0000V7-PP
 for qemu-devel@nongnu.org; Wed, 06 May 2020 08:05:42 -0400
Received: by mail-wm1-x329.google.com with SMTP id 188so2308782wmc.2
 for <qemu-devel@nongnu.org>; Wed, 06 May 2020 05:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fvkeabdgvJPxQm3LnzLPHngBriCPb145ytneLsdCQhg=;
 b=WEfHiC7/0bgofvJWpro3tI5zatnFNxJgMsYS1+1bZezQClNEviR3/72gqJLnSfFnsY
 sIAMcmmsqXOxMfCfZxJUImf9kCo9aX3daaXyu1Qx2NOM7Rwq60QqbWba0LIFHcDK7pIn
 vm49ochaTa8nKhR+fTImPrrdo7vDsuMa/ZeLCUDinei0SSPz+mXV8anGufW6KMpMFYj3
 aJnPzkpJtZ/ADZXZYtK5xlT+wH/skQMJAaP4AkKPJ+O1SWK98tYCZy4q/lpA91xYzYxk
 pHyp90gdHWcTyB/UsIVTzNGyTnR8GxLeqDlrO8AHG45Qn1Q/Oo3RWKOmrfLEsMrHLjgT
 yn3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fvkeabdgvJPxQm3LnzLPHngBriCPb145ytneLsdCQhg=;
 b=p5BgDzF4Ua/zASHHSAKwHk3phxxBdejqAvfDigW3FDX3jeH16hHSvAohuU7CBAPK8x
 2kf6sBXSF7xN3Vp38fdJJvLIbtlX0Bjbijb+kddEec7do4LqnT1wdfNMjtSblVfVijIp
 0gk7uzscWg6/pnErcR8BkaBpnPoj0kmiC2klRpxaDOsPe0/95PjXYNQRD+7GhaTRM7UR
 SMx1Broqyv8wwQeaMZY26YWFWipswoxGHTCt+omXynIgu8uUOe8+y8sfxIDTTHbdVnHc
 rbvVEuhM/0TlaN+6H/5khDHsEtlJDMLNOyyNfQXlIprO9G98QWqKQ9Mrydi0GmP641Ko
 3K+Q==
X-Gm-Message-State: AGi0PubEWvvmgCrze3MVoqqN0ByBlXejP8+13oWeO28P2Y2Wvaz92Zfi
 EGIDqf5rlyVW/BtUCsDCA2SR4MvVpZs=
X-Google-Smtp-Source: APiQypKOeV+BiMWjXbTXSmgP8cUQrEoGgr8Pu9JX9+A37KVQBlss08cUeYl6U7t3GVmRNGfCaRvbig==
X-Received: by 2002:a1c:7415:: with SMTP id p21mr3989036wmc.93.1588766740358; 
 Wed, 06 May 2020 05:05:40 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g69sm2971076wmg.17.2020.05.06.05.05.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2020 05:05:37 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 380251FF92;
 Wed,  6 May 2020 13:05:30 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 06/14] configure: favour gdb-multiarch if we have it
Date: Wed,  6 May 2020 13:05:21 +0100
Message-Id: <20200506120529.18974-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200506120529.18974-1-alex.bennee@linaro.org>
References: <20200506120529.18974-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As gdb will generally be talking to "foreign" guests lets use that if
we can. Otherwise the chances of gdb barfing are considerably higher.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200430190122.4592-2-alex.bennee@linaro.org>

diff --git a/configure b/configure
index 23b5e93752b..c58787100f1 100755
--- a/configure
+++ b/configure
@@ -303,7 +303,7 @@ libs_qga=""
 debug_info="yes"
 stack_protector=""
 use_containers="yes"
-gdb_bin=$(command -v "gdb")
+gdb_bin=$(command -v "gdb-multiarch" || command -v "gdb")
 
 if test -e "$source_path/.git"
 then
-- 
2.20.1


