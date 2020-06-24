Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C78C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 14:15:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4BA520781
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 14:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qoVgHKhl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4BA520781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo6BM-0000Qk-23
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 10:15:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59322)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jo61X-0005EL-0J
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 10:05:11 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40721)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jo61V-0003XK-8A
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 10:05:10 -0400
Received: by mail-wr1-x443.google.com with SMTP id h5so2416053wrc.7
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 07:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XJD1GL90UWNycRg4BT4TsZXTpQO4+SzPpVo+RlIQlho=;
 b=qoVgHKhlnZMVtwgby0vh1A08Lu4m3eq7kDoxQxMuTRN05QuT8ASII+v2D83VXiJ2KH
 uItqonBdKB++2jl2DsS8U2/G1eO8HV9YKbimwSBr0H4uCuDuCg021y2GKHJ+opXRS4mK
 XXWox5tELn4s4QMvE+VpH2+J0vmuDJH/06s4+gnbvwkafQ5wCZp+9XPNLqylzc5sQWLN
 d9X7sV3Ax/DamLuedPt70f9NxiMRbXDl0kncC4rh+jnn0UPBBQUnWPWtkvwirL4lhaMS
 k0NDc9NzACSh1HVo+RwtltZAWF5DGKf/65xabbQnSOiNYEAOB7Xv8VIRZG53JK2G3kuB
 1avQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XJD1GL90UWNycRg4BT4TsZXTpQO4+SzPpVo+RlIQlho=;
 b=af8FCoZ/bRaIPtOIriogm/7AGIu07TzpT9U768kW7E6FrWw98MigQcfswLJmx11j4h
 yf/aRBl93Z9Mv52qyfdphbNhMi48G5eIfGLtQLsQ+S7BWlmc/2OViGvgXnEYe+Q8dwSE
 dEtf8tT361FnM/cGpZezdLsqRUzt/DnIbQ6JMeip8Nfn0/yKVJazCjIi/Ny7c0NU5ssD
 +zhnFerLy09OxFfgd+GwXbxTtsVuVA9t9ieuL3at65JNTBPRdtA32+himTbN6uquSokn
 XsLWhuX68iFSTn8L/9jx1tNZCpMSaRE7vddcHhdOnOVhMJUHiVWld1/gcnsdN2sm9I90
 +tAw==
X-Gm-Message-State: AOAM532ZdhFAGm9fvoZH73aPOsB6tg25ffGJ7Olw8NEdRsY5u99N+2Nt
 zilzGii2wMSllkq+G+eug9/WlQ==
X-Google-Smtp-Source: ABdhPJzJMOBcqSmaD0RE5oXCciOuPB2Ho63lxIX27IS9k6JifKDS83LIFQe9hSzaAdG8mS/t36Cq/w==
X-Received: by 2002:adf:e38d:: with SMTP id e13mr10562160wrm.304.1593007507864; 
 Wed, 24 Jun 2020 07:05:07 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id i15sm27161336wre.93.2020.06.24.07.04.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2020 07:05:02 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EE1891FF9F;
 Wed, 24 Jun 2020 15:04:47 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 16/25] .gitignore: un-ignore .gitlab-ci.d
Date: Wed, 24 Jun 2020 15:04:37 +0100
Message-Id: <20200624140446.15380-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200624140446.15380-1-alex.bennee@linaro.org>
References: <20200624140446.15380-1-alex.bennee@linaro.org>
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
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The sooner we deprecate in-tree builds the sooner this mess of regexes
can be thrown away.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - just use explicit !/.gitlab-ci.d
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 90acb4347d4..2992d15931a 100644
--- a/.gitignore
+++ b/.gitignore
@@ -93,6 +93,7 @@
 *.tp
 *.vr
 *.d
+!/.gitlab-ci.d
 !/scripts/qemu-guest-agent/fsfreeze-hook.d
 *.o
 .sdk
-- 
2.20.1


