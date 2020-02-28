Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AAD0C3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 19:25:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19C382469F
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 19:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JkSuaUaO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19C382469F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7lGg-0005G3-7u
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 14:25:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40132)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j7lFE-0003WZ-Tf
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 14:24:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j7lFD-0005yV-Eq
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 14:24:20 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35466)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j7lFD-0005xT-91
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 14:24:19 -0500
Received: by mail-wm1-x341.google.com with SMTP id m3so4505605wmi.0
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 11:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=zrL4tjn6sCEWB+G2jq1bIimUHKF4zGrlNdYVKdnU6lE=;
 b=JkSuaUaO07btGRA7uuUM5KTNvtBFR+USNRm7N96Y0B7DnShHCNAKqFB/wXkvGADvfQ
 +34PoBMomyQ8f+8FnpN/xS23XZQB3iCYwbA/Jt3nyJ/hpiHaZ4cWzmnn0hfw84DPGGr5
 j/HimkS5QK34/BDh3JOqLdz6w0SN5J0z54FHYc3j8KSsXtQrKDu0mbBWP4eTh/Z7Qvtg
 7RyusWfFI2qN+wY5Ah+CQz22Zl0to1NLlhFoNDwXydZ0BD8OyuvJYXQSrBdi+Skr0gNI
 FmK2PEe5e8VSf9A1WkjKkvIrnkKG55nC1zPlWW5g2bwJBKVPiUZm7papdnuR/nBUJ7oM
 hsSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=zrL4tjn6sCEWB+G2jq1bIimUHKF4zGrlNdYVKdnU6lE=;
 b=KDVgPiMRfdWKs1rA9ayULreE8qtxhHN0T2W1+bA2PKzJxz3CZExl9lkCV4wk/PhQG9
 GAPUqNoTANwDc7KCEPcAa86Rf6x9fiLcGdHZnpb35yRDZRRarqtQU6hYqIIat9aXwy4E
 aCykb4P5mxFz7Wemi7CxfynhXiSLsx3JcRaeCYABjluwdBos0hWiH/q+IayjpLv7EEvh
 zg8w0IdJPan2UOXWu0KQnbgo+S1jgt8BY0u4H/WyPdv53+Zov86Dc2BNTdFtzri6UDCg
 YHgRPQDCzhN5Rrgw4UZnlyx12teCI/VMg5OSuhUlsK6Ff/RJyst5536tpm/ct4gUn07M
 Ap5g==
X-Gm-Message-State: APjAAAW2GAu5R4c83HtApLG2cYWdD2Yuh6RcccUWAg8IDmP+jicwUvLh
 b5+oWTA4o+y0iJTyFTBa2xUIzA==
X-Google-Smtp-Source: APXvYqzvm1f03QqaPKdb+xKs5mhgKz2VkBH/FE0E8wuIjvQLzra42WBLzkbeRdMs+8H+8aNuGXntPA==
X-Received: by 2002:a7b:c341:: with SMTP id l1mr5773376wmj.146.1582917858284; 
 Fri, 28 Feb 2020 11:24:18 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d17sm3272847wmb.36.2020.02.28.11.24.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 11:24:15 -0800 (PST)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4F87B1FF87;
 Fri, 28 Feb 2020 19:24:15 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 0/4] Clean-up codegen cache size
Date: Fri, 28 Feb 2020 19:24:11 +0000
Message-Id: <20200228192415.19867-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

A few tweaks to the final commit so we are a little less greedy for
translation buffer, especially for the CONFIG_USER case. Otherwise
I've applied the review tags.

Alex Bennée (4):
  accel/tcg: use units.h for defining code gen buffer sizes
  accel/tcg: remove link between guest ram and TCG cache size
  accel/tcg: only USE_STATIC_CODE_GEN_BUFFER on 32 bit hosts
  accel/tcg: increase default code gen buffer size for 64 bit

 accel/tcg/translate-all.c | 61 +++++++++++++++++++++++----------------
 1 file changed, 36 insertions(+), 25 deletions(-)

-- 
2.20.1


