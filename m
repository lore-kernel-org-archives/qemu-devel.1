Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C9A9C433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 20:05:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEB8B2145D
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 20:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yhrot6J9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEB8B2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFNOY-00062m-Lg
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 16:05:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33610)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFNNl-0004dI-Mv
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 16:04:53 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b]:34049)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFNNj-0008ML-Gc
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 16:04:53 -0400
Received: by mail-pj1-x102b.google.com with SMTP id n3so7736163pjq.1
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 13:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LvgBmVo5Tzfa2ETkxK8CQ+jBfbey6Ap12eTwlbT45c8=;
 b=Yhrot6J9BA0q6UtBTu3nxSoezTzeiumdjj3j2DDwg04DIOBXUjKRpSaNBDg0uERJJD
 hmb4MY6VoJa4JpLjfVS/IQD6k//wiTzAfaRluQwHslNZX/BcwbY7+oPfhrpErZuvLDMg
 ALNPMPycyxmGqsKjyT+UkIxtImETzyb69X1903XGOmvZ5Y/rFL5eTmQP/NNMFwoYs2F2
 beI0dp/zhRtOr3aE6F2mev+bhePv8LeQFYNTOiI7z0BqiBdk3WxUfYyhnjP+zZrvhAb6
 1ayahz8mhEnMMEiGwoT/L7zeFMYI/DrKxfYRxGjE+ce/EPw5jX8E4FnARe2FwfFlYsrD
 4jCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LvgBmVo5Tzfa2ETkxK8CQ+jBfbey6Ap12eTwlbT45c8=;
 b=TQ1ntgv4hCFCRT199jnkLsJbeaHjHJh8lvsSEhHe/1VR+CxWvmLoUN4d+MrIkBIHIh
 7R6KWRnUq9BSv5JPe8YDEDGILnZ/dF8gzvCdF1WaPTB+pe8253rUmvKVyxv2gvC7TBOR
 2vVXO6qMKdLG7Caql9Ulvf8P9oPyYxp9CNk8w+UoeRDz2mwppBDmbIApqjWcEsKrXsJ8
 N6YSXzQSoYtHLIXXfjvxBjMN8mCDwXzcxOzy6wlV5W3d2UYHU879q7NWyS8WQQbQyFl8
 uJWTUkS5Pu7vDQ5QtF3NL5jfsHG58vCUbWHpWu5ZCVQVPGfJ6iIo/07Z3xNJ4tW0ItX7
 5y4g==
X-Gm-Message-State: AOAM531Gu2gHZDibY7uOUlx+mP7TQxdq/fzKMuwLk6OsB39XexGlc/la
 owJbJ3Kdff8ppwQ17S0eHuLq+uRz3w4/ifH/
X-Google-Smtp-Source: ABdhPJyCJ9q4OOVCr+AkypuN1egCtchrV01a6LaDQpTI/c7onS0p9Lpo4qyO4MxSAP+mDoQU8zM51g==
X-Received: by 2002:a17:90b:f14:: with SMTP id
 br20mr772350pjb.24.1599509089766; 
 Mon, 07 Sep 2020 13:04:49 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id 204sm8713098pfc.200.2020.09.07.13.04.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2020 13:04:49 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/4] meson: remove empty else and duplicated gio deps
Date: Tue,  8 Sep 2020 04:04:29 +0800
Message-Id: <20200907200432.2418-2-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200907200432.2418-1-luoyonggang@gmail.com>
References: <20200907200432.2418-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj1-x102b.google.com
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=E8=8C=85?= <philmd@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 meson.build | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/meson.build b/meson.build
index 6e909213ee..d6a1949b2f 100644
--- a/meson.build
+++ b/meson.build
@@ -320,7 +320,6 @@ opengl = not_found
 if 'CONFIG_OPENGL' in config_host
   opengl = declare_dependency(compile_args: config_host['OPENGL_CFLAGS'].split(),
                               link_args: config_host['OPENGL_LIBS'].split())
-else
 endif
 gtk = not_found
 if 'CONFIG_GTK' in config_host
@@ -347,11 +346,6 @@ if 'CONFIG_ICONV' in config_host
   iconv = declare_dependency(compile_args: config_host['ICONV_CFLAGS'].split(),
                              link_args: config_host['ICONV_LIBS'].split())
 endif
-gio = not_found
-if 'CONFIG_GIO' in config_host
-  gio = declare_dependency(compile_args: config_host['GIO_CFLAGS'].split(),
-                           link_args: config_host['GIO_LIBS'].split())
-endif
 vnc = not_found
 png = not_found
 jpeg = not_found
-- 
2.28.0.windows.1


