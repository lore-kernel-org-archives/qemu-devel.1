Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC5FC3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 20:51:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A85FD208E4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 20:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YHDgLRTR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A85FD208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5cFC-0003Ko-3g
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 16:51:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49834)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i5bvJ-0008CH-SN
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:30:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i5bvB-0006fd-HI
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:30:37 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:54898)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i5bvA-0006di-Bd
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:30:28 -0400
Received: by mail-wm1-x334.google.com with SMTP id k2so190261wmj.4
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 13:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nE8/v9/E1aXsZxbh6/91YvEiHDaWx51s/9G3ceEKxhQ=;
 b=YHDgLRTRCJXCJOyb87/qCAwR5uNDwovJ3Q/EMi8uTj0lF3ba1bQMicVIdSCMKRmFMt
 MJxc6CCmh1SqZNo1yASDXgjYWnpQSsT20hP1eIlztMDQTPOxWzOvEKUFl0xSlRf0ZvdI
 EzVKbymVkvmh9fJzcnrhVPWM/Gz3XoGrLd6APGuTFxsik57V14qQPadyHHepTxLzIkmc
 t2R7v8C/5Z470wViHNv6aS2EZSvDoBkigkmV3lTsXj7W4/4Z70BZhkiX6WnWsSgLMKID
 Df8/ePs5lX61+QfLX6H6n0+rB5HQSIEPgjdFkmIOMUOUi360nBGyAVfQRIzHV+ZW9oGy
 dHXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nE8/v9/E1aXsZxbh6/91YvEiHDaWx51s/9G3ceEKxhQ=;
 b=Pure4+z7vwGnEcNAe1GvMzmZz4kFGqDkZfQdoEwg5hoh/rzowoSf/Ybdcgbp7JqKNh
 TeDoEXYnOHt7NsL9KKhAkwDFzwVYsBsqP3vQPEbw7OFxaIqmz1kuvNB+3zXymX6eJA6v
 YpKjnj6/CmM6RaNNX2vCaW1uYuwt12TxquVp67GsWi64wBwEFaNLRNqU8w16NI0PD/tk
 yW3+4HuSwp/JahsvZBwy4Zj1Q7HmLhGjdy4WjWf0emh/zFikavkBfbs+6XW5uJAh70jI
 Ci9Y9jyk9bVgIeM8pgyuOv7H9XbYydYIsOQaswDnNswJrsJr+fZraZQzKUITpZR17n//
 ZBbg==
X-Gm-Message-State: APjAAAWxTx3XqVrDNXVtzzzryvKk9W9wMV+n7qqyoFiFhHgfn/m5SUSe
 sbjP7F+vwQIxt7UrHxLOjtWMuw==
X-Google-Smtp-Source: APXvYqwXZqJTy5HTLLg698L36aqwF5oQ+VmLgT4Bs3mkwkTgfW9KdT2WygTEwhU1+3SGH8hfd1O7Nw==
X-Received: by 2002:a7b:ce99:: with SMTP id q25mr67180wmj.163.1567629026881;
 Wed, 04 Sep 2019 13:30:26 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q15sm116315wmb.28.2019.09.04.13.30.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 13:30:25 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 303761FFB5;
 Wed,  4 Sep 2019 21:30:16 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 21:30:01 +0100
Message-Id: <20190904203013.9028-31-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904203013.9028-1-alex.bennee@linaro.org>
References: <20190904203013.9028-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::334
Subject: [Qemu-devel] [PATCH v1 30/42] .travis.yml: Enable multiple caching
 features
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Using the 'multiple caching features' means explode the YAML array,
thus it eases the git workflow (it is easier to move patches around).

See https://docs.travis-ci.com/user/caching#enabling-multiple-caching-features

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20170809202712.6951-4-f4bug@amsat.org>
---
 .travis.yml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index 92b00927d4f..612caabc6cf 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -5,7 +5,8 @@ dist: xenial
 language: c
 compiler:
   - gcc
-cache: ccache
+cache:
+  ccache: true
 
 
 addons:
-- 
2.20.1


