Return-Path: <SRS0=PST1=DE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0272C4346E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 08:23:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 925AB23976
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 08:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HAMYUeGL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 925AB23976
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMRyG-0007X2-O6
	for qemu-devel@archiver.kernel.org; Sun, 27 Sep 2020 04:23:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43044)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kMRtx-0004Lx-TF
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 04:19:21 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:54649)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kMRtw-0005Km-DB
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 04:19:21 -0400
Received: by mail-pj1-x1041.google.com with SMTP id mm21so1838742pjb.4
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2020 01:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EmMCKff5D2NhzruLHhJVDlZo6kyMN39ZVhWfzFJSsKo=;
 b=HAMYUeGLXphkugZt7lO8ynj0G4jBlZf0f5un9qMKGUC7twe3V6tunlIlQkvPDxfqKl
 TtMepNNHLy0nOhA8AZRtJiDVvmhv7VJ3CkY1FEb/SN+XnPj8CilQ8ZZ5RzqpWtDnWma/
 dXQIEFnSQ2bDHm575ZWHGMVfxzNamtBb67MivazhWGAS3QwYltUWDsX0P5+pSfgsKcyp
 l6iIedDs/VLxLr7N2iir6aO9B7rIvlLxBMOWErm64iWyD5yqy25GyaaGm6vz2fUkEor+
 ZuoAq0xenjQpaRSrX7uuDop5b84CFqy1eyqZK9uErbd3afNh4TE5PMWzO8nO7craeOhR
 PWSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EmMCKff5D2NhzruLHhJVDlZo6kyMN39ZVhWfzFJSsKo=;
 b=cmSzyWEP3Dn7UBqjPwkGcfRxh0QNJEKKuIeZuREkXQxMYWPyws/9RWueoSGDXcVN5P
 nWkGEEoVtiCXka1lYt8QrpK0fbzVI+J96gTSIKWjqaMgb3PnIeFhGEtjL+/qOtgHCi24
 MpkabdV/r5caB7Es1C9eOFsTWPEQfEw7BWYJgeeN2ECo+IPIjhiJGZ90NeksQ+aGhO8L
 KYbkw+I7FqlBfo1bneGCXoekKHASrwlz5oG9TNAuuENuPJRjlJALUnL6IrHnh6olAlsc
 f/JbD8r8huVfD7u0ymCfEvrUrAQ8J28LKIkLR/hZEpRVxYxLvQNRDCsLv0apOLPEsOZH
 hT0w==
X-Gm-Message-State: AOAM531WGUrX4ihKD+sL3MckOp7lfPkqQGH1Cd1jbVBOq5Iv80RM78Wy
 YI2WWrrRDTAW2nTt/SuKQ82U2KGQbJnFJZQU
X-Google-Smtp-Source: ABdhPJxZDb/IgJQwXB5LmEV5MTSoU0tPHXrAkW/z40YCbu6T0cdaHmEZDhTwwCemEq3WLZjwRTG6AQ==
X-Received: by 2002:a17:902:fe83:b029:d2:2359:e64b with SMTP id
 x3-20020a170902fe83b02900d22359e64bmr6749893plm.7.1601194758589; 
 Sun, 27 Sep 2020 01:19:18 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id z22sm3317693pjq.2.2020.09.27.01.19.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2020 01:19:17 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/4] plugins: Fixes a issue when dlsym failed,
 the handle not closed
Date: Sun, 27 Sep 2020 16:18:58 +0800
Message-Id: <20200927081901.771-2-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200927081901.771-1-luoyonggang@gmail.com>
References: <20200927081901.771-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj1-x1041.google.com
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
Cc: =?UTF-8?q?Alex=20Benn=E8=8C=85e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 plugins/loader.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/plugins/loader.c b/plugins/loader.c
index 685d334e1a..8ac5dbc20f 100644
--- a/plugins/loader.c
+++ b/plugins/loader.c
@@ -235,6 +235,7 @@ static int plugin_load(struct qemu_plugin_desc *desc, const qemu_info_t *info)
     return rc;
 
  err_symbol:
+    g_module_close(ctx->handle);
  err_dlopen:
     qemu_vfree(ctx);
     return 1;
-- 
2.28.0.windows.1


