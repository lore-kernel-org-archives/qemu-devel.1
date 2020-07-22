Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D61A6C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 06:30:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A27CD20656
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 06:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tq9lWMp3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A27CD20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jy8Gn-00009z-Tk
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 02:30:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jy8Fa-00070x-5j
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 02:29:10 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:33384)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jy8FX-0006tz-Vt
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 02:29:09 -0400
Received: by mail-wm1-x342.google.com with SMTP id a6so3659778wmm.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 23:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jZAPRKLaovu2pplc7biXvq3YREw5GO4K82nPJPMV9Fw=;
 b=Tq9lWMp3cYooqI2/vWfSJFNiu6URnYRr9Ss5FJFsaUsC4y0JV1G2u6DajY9BkCMh4K
 Z3AtKpZZNgEFkaeD9YURksApXThLTTcCoU7u0n9sNTciCXl22iC2W2W+9ZVJfJekgyvH
 iB+00osNWqZOP3GXhcDlC7CI9FywdEdic/eeXK03nktqxeT/LEp/eVHDU+4itnFEBI2+
 UQo+P07p2RBxjUB71syDuGuIKribeWWkU8+MpnwKYPgoOVdOkh2yQtw35a7sj87hjPOg
 o/L5zIixS1oOOyGm38V87ba10PybTFSZ+IlmOYZLNUHMj10x+cO9/8FozDLB8rUsGuFj
 m+XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jZAPRKLaovu2pplc7biXvq3YREw5GO4K82nPJPMV9Fw=;
 b=lc6wI+5xb9n+fum+nJ8vHHUp8jVaR1gqHm56+Omysqz5TywGBv81KvdE4ppsr5BXSj
 ZCo0I8lwxZlZf4SnfaZxjCbnJ4Seh2btGjyAJ2XJ4n9jKiK/eyosjxeuIiIcBFMs34Xf
 Oh89EzEdGw1z8Lh06xIcDeXMXUsRwsN04wZVj517ly8bPQ2PUCK69y+q7tyE9eMlGdHc
 M9ztDyijSqgeg56jj1vDFedvyU2gI1E24Iukcjl3b7Gr+X8LlMETSQKsSqga6Mbzl+kr
 ZaZsK2G2/otEoxL82G6C0p6VkgAPh9cNoufTyBANT8ALvi0+CsWKcldDBzVG7GAe1jGn
 FyAQ==
X-Gm-Message-State: AOAM530QLYewS8IOtG9S8kR7OS5jClV2UUD7LqEYIejcIxH3Ol9fpbPe
 H9awP7/Otl4fm0Qbni+jq7VWvg==
X-Google-Smtp-Source: ABdhPJxILxuVh7BWCJSpIQISn2FMFVvkp+Aw/GlaLt/H6up8gG4b2sMSjjkDo4s5Fli2snFSeQEUww==
X-Received: by 2002:a05:600c:2209:: with SMTP id
 z9mr359097wml.70.1595399346594; 
 Tue, 21 Jul 2020 23:29:06 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l14sm41215142wrn.18.2020.07.21.23.29.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2020 23:29:03 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 14D0C1FF87;
 Wed, 22 Jul 2020 07:29:03 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 01/12] shippable: add one more qemu to registry url
Date: Wed, 22 Jul 2020 07:28:51 +0100
Message-Id: <20200722062902.24509-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200722062902.24509-1-alex.bennee@linaro.org>
References: <20200722062902.24509-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x342.google.com
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

The registry url is <project>/<repo>/qemu/<image>

Perhaps we should rationalise that some day but for now.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200717105139.25293-2-alex.bennee@linaro.org>
---
 .shippable.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.shippable.yml b/.shippable.yml
index f6b742432e5..89d8be4291b 100644
--- a/.shippable.yml
+++ b/.shippable.yml
@@ -27,7 +27,7 @@ env:
       TARGET_LIST=ppc64-softmmu,ppc64-linux-user,ppc64abi32-linux-user
 build:
   pre_ci_boot:
-    image_name: registry.gitlab.com/qemu-project/qemu/${IMAGE}
+    image_name: registry.gitlab.com/qemu-project/qemu/qemu/${IMAGE}
     image_tag: latest
     pull: true
     options: "-e HOME=/root"
-- 
2.20.1


