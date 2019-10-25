Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA498CA9EBC
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 19:40:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B391121D81
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 19:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JsvY5Tp4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B391121D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO5Rt-0005dk-Bp
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 15:40:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57705)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iO5Oc-0007y4-CI
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 15:37:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iO5Ob-00034P-0U
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 15:37:13 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:41410)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iO5Oa-00033t-Qz
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 15:37:12 -0400
Received: by mail-wr1-x42f.google.com with SMTP id p4so3619252wrm.8
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 12:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RnAEdxIMsOBRs/5T7Ts8em7DhClh/2QoH7on8QJvikk=;
 b=JsvY5Tp4RhmNIO82lGeg8nZkvo4S0KWCFNILiOtqkkuvY04ZVi1c3IiHs5YKyFh7wT
 ypFBg1KN1Q8UqLibPuTyHF8e9cPlDqnT2LodGrjwvDE7eTei9VbW1nvT8J8Lg/yfAZmR
 Gwj92eE9kkZfW3u0/nSgweGv8yjVlXgf56y2zvICUPaIDzafQKVm6rk+m78/iUWao6rv
 g/xbIrvco8cHCkSWL9zgf/p7OK9Ctsg1uS8cClnXqu1n1y+lLLYXKeueFTjZccsNIFSS
 IH/PP9pQZNxR6Mp7w2r13KAkS2APAq+ZeCY2T24NxsqxrmZ0ea6v0XtQCw/sLxYWY/66
 0euQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RnAEdxIMsOBRs/5T7Ts8em7DhClh/2QoH7on8QJvikk=;
 b=pck7FINXNnYak1HrmAa71UJDdzXigW92XIQLlf/gQDoU45Rie4mjKs3+SLR3rsa3mb
 EaASIKYco2XOG8ODL7gxjh7Xs+j7FAySPovdu6VAlwse+lriUcDhtbm+ECCw2o8FWn0A
 FnBOlcZAR4duxzFPSdd51ZhvbCn2ltU+OQOfEQylEBUV28bttBhI3qH1cS2wBi9jfOtu
 zIp0BVNjXETvIlufWEgKbBoykoeH//xgXkugNYhUzQTecqGa8LzwTjGdleuCRd8y3r2m
 LHJ8PmZIFtm8/Ak0iG/C8y6iIe+/SldmJlF9s45v+WxuZuuw1wDLfT4LASGFTKINQBeS
 Sn9g==
X-Gm-Message-State: APjAAAWRN2ylu2lELNUquD3PHV+bWanPkvrBBlijZn4Ey7yTXqlPfQ1r
 xc4Y71CKWk8UX1EbiG1xiD0lkg==
X-Google-Smtp-Source: APXvYqwiQ3lKFdj0Msw0yxFgeMhYuRW9MrCVb1LYIrgNfzA4c3m1nWv/6IipaPx7gkQBTc+l7iaLHA==
X-Received: by 2002:a5d:6cc3:: with SMTP id c3mr4455140wrc.202.1572032231442; 
 Fri, 25 Oct 2019 12:37:11 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w9sm3557751wrt.85.2019.10.25.12.37.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 12:37:10 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A4D391FF8F;
 Fri, 25 Oct 2019 20:37:09 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v3 02/15] travis.yml: Add libvdeplug-dev to compile-test
 net/vde.c
Date: Fri, 25 Oct 2019 20:36:56 +0100
Message-Id: <20191025193709.28783-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025193709.28783-1-alex.bennee@linaro.org>
References: <20191025193709.28783-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42f
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

This library is needed to compile the VDE network backend.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20191009170701.14756-2-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

diff --git a/.travis.yml b/.travis.yml
index 7d90b87540f..7be2a9949f5 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -46,6 +46,7 @@ addons:
       - libssh-dev
       - liburcu-dev
       - libusb-1.0-0-dev
+      - libvdeplug-dev
       - libvte-2.91-dev
       - sparse
       - uuid-dev
-- 
2.20.1


