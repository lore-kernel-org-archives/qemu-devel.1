Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66811C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 15:03:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34DA02088E
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 15:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qmKRnkdV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34DA02088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrNDp-00041H-DB
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 11:03:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42582)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrN6z-0003dE-8r
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 10:56:21 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37939)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrN6x-0006iO-GY
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 10:56:20 -0400
Received: by mail-wr1-x443.google.com with SMTP id z13so33013171wrw.5
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 07:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UzGMzmXLzESuVhYFo6WrRdQJb8qigTb6CLPMTcgkfaA=;
 b=qmKRnkdVmlWnuU6c8WWAPJvhD014ix7ust4uOPrgIpO4zqB/zfN1oCwdBt44MI+CwK
 bRr+vnDEri/khiWgqk/ornC409xPdmPFyL44hwisBjNLRWhJ56Hb7BlltcTR91cj9Qwb
 dwpS6N1A9dfnfIMa+j3OBbBlCJnDf8tmQf+2HOvcjeZ1mbslcIGtkeCLSodW+f3SHoZD
 DIFa3Ylz8beHIdvv2OcKFNZr4/mSY+7vYMRyJoyA9xpQbUulTN4I6jZtWlXhbxDMsNql
 iyLK25h9iobomMCJ5ERFIHE0OhWuc8Y0ggNNtIxiWxtCY9EoGfHGMIeRkdGtA+XpEaTa
 Q7+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UzGMzmXLzESuVhYFo6WrRdQJb8qigTb6CLPMTcgkfaA=;
 b=Bk3WIsLARFI9h5X5s9wDIYT8aVSL/aC4ube/7Rzo1wUWOSQxU/TlHpwVmxV2JQmdYz
 Bk3MRNAdnICtPdIrddtIs+fgE5ClmkIGOWy7MpJq5gwor5vMNlOUuOj1OtKa7mMQz/8V
 AE0cFd0/VymEs4rjy/skIYk0GgECJGGMPW/7W2Z/cHKdjB03zgiB/0mWv/gOpDRimZU6
 IyEUEYaadWIrzhoK9kEqVqhVZ8ZqLnu+vMVo+fbD+CcTsZc4e9zqKXRNI4XHodp5SCWS
 eNybW82WnO2Bnrj9tfaWbGF6rhu0kGwGaSxs7MxjvdH0D2qR3tM9Nn0HhgNDp+5LeiXx
 qJrg==
X-Gm-Message-State: AOAM530US/gC0mZ5ad15f04dn8fAcYvKtzGPVzXYudLC9fLoJs3ad8Lw
 YTrZafI3bX2ay/2uvWk/uv1rj5uZPB4tUw==
X-Google-Smtp-Source: ABdhPJxeRGkcYjp/QSq/m+Bns2NV/3x/kPBOMrgWjmGkIiXFqNQjz80kHU3gIpSCOL6H/xvQTFSQXw==
X-Received: by 2002:adf:f984:: with SMTP id f4mr36843138wrr.221.1593788177757; 
 Fri, 03 Jul 2020 07:56:17 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s10sm14078347wme.31.2020.07.03.07.56.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 07:56:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/9] build: Enable BSD symbols for Haiku
Date: Fri,  3 Jul 2020 15:56:06 +0100
Message-Id: <20200703145614.16684-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200703145614.16684-1-peter.maydell@linaro.org>
References: <20200703145614.16684-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x443.google.com
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
Cc: David Carlier <devnexen@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David CARLIER <devnexen@gmail.com>

Tell Haiku to provide various BSD functions by setting BSD_SOURCE
and linking libbsd.

Signed-off-by: David Carlier <devnexen@gmail.com>
[PMM: expanded commit message]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 configure | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index 8a65240d4a8..c9c135b70bc 100755
--- a/configure
+++ b/configure
@@ -903,8 +903,8 @@ SunOS)
 ;;
 Haiku)
   haiku="yes"
-  QEMU_CFLAGS="-DB_USE_POSITIVE_POSIX_ERRORS $QEMU_CFLAGS"
-  LIBS="-lposix_error_mapper -lnetwork $LIBS"
+  QEMU_CFLAGS="-DB_USE_POSITIVE_POSIX_ERRORS -DBSD_SOURCE $QEMU_CFLAGS"
+  LIBS="-lposix_error_mapper -lnetwork -lbsd $LIBS"
 ;;
 Linux)
   audio_drv_list="try-pa oss"
-- 
2.20.1


