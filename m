Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C376CC433E3
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 11:37:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92D772087D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 11:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhK7UdRi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92D772087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAtji-0007g9-Pr
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 07:37:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53358)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAth0-00037M-Aa
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 07:34:14 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029]:40722)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAtgy-0006iT-PH
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 07:34:14 -0400
Received: by mail-pj1-x1029.google.com with SMTP id kx11so733520pjb.5
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 04:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kZmgaDEBNjpxaFbsHI9krVOWSzauPOV79k08lIpZd10=;
 b=NhK7UdRiHc7jqeAi377NWdg8cg3gN+zYrVkghPy5vo8mBf2fFMJrZPgUMGmocXdTIM
 y7fiD9qkG/G5TDutJqt6ZHd2hxZOU0WcNnPGYOsVzwIgvvugFOHQo/wXbyqexJMJB9Vp
 dwxB2P15fT+0K+DkL70aBxxFtlfRDgC09AXSksGv9i3C7sVsnONo79JIeqA25hZtpsqF
 9B2tRER8HfpcK9vvMTqXBLZjZrXcBDuNRfGQrAgTaFFEQIvpjSTG3cD/bFGRcl9ABWcB
 oaEbmFbKCt1D+Bj8GH1gFvcVIOSYAhD6E8oBUAa4UhGzde0p9mChO7HjzJnlJRFUINgN
 BKtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kZmgaDEBNjpxaFbsHI9krVOWSzauPOV79k08lIpZd10=;
 b=kMeDEemqtM/ERySNALOyS3jsw4bSBsagF6z4+t/oMzrkces551l3fcwmCmt3AIbrdL
 zKuy1YRH5tO4nelIMDIUizgnPRSVLE7WnLcLBbgt+Lp3mBkt744WbbSdzOCFa6ZE4WR1
 6QxKaf0ig4pYStiQcgDTouf2rB36Evfp00YXjsQSFfO2QoIZMtBNU1JC5Sd4dx0mPtQU
 59mam2s/oRfY+EpUB7HAe7ofwNxXo9h/dKSWJUUmejNXmk0zgAjey7n2ZUiOtTT3qa6q
 MkkH0gSpxDmDD7lFQBHtsCx3j+BMq2I/YattqFFgliWKqVh1A6e4pp0Li301BVmEZjPh
 xi5A==
X-Gm-Message-State: AOAM5315KkuYPPASqXauNsKXc8Rdy3aytGviHBIeb7MrQimlL2QA9IzV
 pa+hKAAhqMfHjedK/P5p9YnDxaqxWhlcY5sZ
X-Google-Smtp-Source: ABdhPJwVy7pWROAr6IRAs2qh2C0ECcv+4fohV2y6Lh9VN34IxxRhc08nKcUZhn5AlHkFNnRmTtJiwA==
X-Received: by 2002:a17:902:82c7:: with SMTP id
 u7mr11841462plz.310.1598441651055; 
 Wed, 26 Aug 2020 04:34:11 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id p20sm1915914pjz.49.2020.08.26.04.34.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2020 04:34:10 -0700 (PDT)
From: luoyonggang@gmail.com
To: qemu-devel@nongnu.org
Subject: [PATCH v4 5/5] meson: Fixes ninjatool can not be recognized as script
 under Window/MSYS2
Date: Wed, 26 Aug 2020 19:33:26 +0800
Message-Id: <20200826113326.491-5-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.27.0.windows.1
In-Reply-To: <20200826113326.491-1-luoyonggang@gmail.com>
References: <20200826113326.491-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj1-x1029.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yonggang Luo <luoyonggang@gmail.com>

use ninja instead ${build_path}/ninjatool

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index 3b9e79923d..2ad0c58492 100755
--- a/configure
+++ b/configure
@@ -8222,7 +8222,7 @@ fi
 mv $cross config-meson.cross
 
 rm -rf meson-private meson-info meson-logs
-NINJA="${build_path}/ninjatool" $meson setup \
+NINJA="ninja" $meson setup \
         --prefix "${pre_prefix}$prefix" \
         --libdir "${pre_prefix}$libdir" \
         --libexecdir "${pre_prefix}$libexecdir" \
-- 
2.27.0.windows.1


