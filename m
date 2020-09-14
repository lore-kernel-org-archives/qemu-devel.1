Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6266DC43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 16:50:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBC4D20829
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 16:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="If6UFPyQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBC4D20829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHrgB-0003vy-Sx
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 12:50:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37854)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kHq4l-0000gH-T4
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 11:07:27 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34224)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kHq4k-0000Dq-Ah
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 11:07:27 -0400
Received: by mail-wr1-x444.google.com with SMTP id t10so64537wrv.1
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 08:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bTZguQqXGVOp7T1z++Tht2natyY+bnRw2yDCKI4+jDM=;
 b=If6UFPyQ2dleong+6iM3rtNm5B4HfItVs85fCwNkJCqD9g+oy+5ONJBg+5R6LAWVTc
 4PU90lBBEXmd0UIVHIwTYFMlrFgy2JGOIaMqJlTE/J6bezhGDREfeG0aXQm8S5E+6eni
 L7hAo40H6UnvOKpvZrtLCIIRd73UZVccCApMtmdeSdxo3LoQltYLBz24B9KQVJynD5da
 7ds2zWrHDtSiUlaZXXrM1OgKTpEP/XAnrb+bw/c2+xYznHdilS2vaoAiMKZhGHZQFU+L
 WG9e7PMbcBs858Fn2seCUUcsc/p6lpycXn92/OZ6581XCNcRIMqP61dmIgYa3a89klFI
 eDHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bTZguQqXGVOp7T1z++Tht2natyY+bnRw2yDCKI4+jDM=;
 b=W4Qu1atYBTZM6Nje/FZPqXpBvHFrtT/jQYJ6Yvviko8vrBvf8YVlomeEr+IGxiYyl6
 yVJ33cRvc1IH18AGRbPw9ljWmrLAaGvCO+30tVziZUjwFlzUz6260OrJeSD8r8u8Mbr2
 4d89JBp2e4+RpToIiac4UiXXe2NGepi6lXXkhJMg7KPo/an/c4aZyXxD4VVYNcF1G4Ot
 cP2WKx+/SEaiwZ3N5XEATkBKLdxEdAr7nav09JAwOadDPEBfgs4Ww8WW4Av/YKTr4Ceb
 Oii6QdoAEVfZIAzFfycnT1mriUrjvY+tdjCuII63m6rvIbHM+AEYw3GTLl4IffB+N5ZZ
 zrWg==
X-Gm-Message-State: AOAM5337faz5ejlSZ0C0dvcCtYrV0FasrOZKTUFQmC86q2eiwjnKJXwk
 c8sKsQr/pBEN89xM8T3TZyKdHQ==
X-Google-Smtp-Source: ABdhPJwEUHP0T2Q137kU0py2W/6JY+jrLWz8iLQ0r1X67Gij4sw2IkogHAC+obq+2oQpk+YRTsanwQ==
X-Received: by 2002:adf:8b1d:: with SMTP id n29mr15803456wra.383.1600096044893; 
 Mon, 14 Sep 2020 08:07:24 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 185sm21137941wma.18.2020.09.14.08.07.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 08:07:21 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 400781FF90;
 Mon, 14 Sep 2020 16:07:17 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 4/6] configure: include tilegx-linux-user in the
 auto-exclude logic
Date: Mon, 14 Sep 2020 16:07:14 +0100
Message-Id: <20200914150716.10501-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200914150716.10501-1-alex.bennee@linaro.org>
References: <20200914150716.10501-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The target is already marked as deprecated in the documentation.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 configure | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index 50052378e417..d998723cccc3 100755
--- a/configure
+++ b/configure
@@ -1725,7 +1725,7 @@ fi
 # If the user doesn't explicitly specify a deprecated target we will
 # skip it.
 if test -z "$target_list"; then
-    deprecated_targets_list=ppc64abi32-linux-user
+    deprecated_targets_list=ppc64abi32-linux-user,tilegx-linux-user
     if test -z "$target_list_exclude"; then
         target_list_exclude="$deprecated_targets_list"
     else
@@ -7719,6 +7719,7 @@ case "$target_name" in
     gdb_xml_files="s390x-core64.xml s390-acr.xml s390-fpr.xml s390-vx.xml s390-cr.xml s390-virt.xml s390-gs.xml"
   ;;
   tilegx)
+    add_to deprecated_features tilegx
   ;;
   tricore)
   ;;
-- 
2.20.1


