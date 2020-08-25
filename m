Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A784BC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 00:18:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AE5F2074D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 00:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8847GtM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AE5F2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAMfD-0004sp-Ir
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 20:18:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45024)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAMeH-0003aw-Md
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 20:17:13 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534]:35224)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAMeG-00065n-7N
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 20:17:13 -0400
Received: by mail-pg1-x534.google.com with SMTP id o5so5539601pgb.2
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 17:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=htMtb1NzKhLangZNeh4fyVQE1LaLJL7zHAVE3XWM2KA=;
 b=D8847GtMgaGkJD0bpAax57GNxsTBGG0q0G/coG68LVoImaEszHDnlQmjR4+nq+9HVb
 q4EG/Rm3HB3+hWTETAcJlLbn6OT5TnI/IgaBBfZvq589SR3JFY/PmYf/X9o9P7NR77z9
 0Dequ1P//wicZpq57CQ9IM+xVEbZNPMVJfDuDoMf3EVqv1/vICc6aASusgvprwDwaEgI
 EozK5zrKcVEodn58qBbAmcveO5B6zO49mW9NOdZSpnnxWHsxhmgSmIxdAIUMCzjzYXjf
 GvhYLHXnyeORECPDidcaUM9NO3HbszQDIigL2cltUiLzQMiI+1EZPWxEQvTmhKUpLzw5
 Un9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=htMtb1NzKhLangZNeh4fyVQE1LaLJL7zHAVE3XWM2KA=;
 b=KQdXIOEHwIQZj0POa6dDAgOomvW+gU/qZg9oRgc6Zb7pf0BuqB7cVjgKOk+e9eX71a
 g6s48H5YQ6yhFOTsONbivjUG5/lMJg0SZhYE3FkWDE+vE9+FKdonrasqd7GOm/M/PSjh
 kEqLK9/sbRr+ljuPW9YPQxnVejjh5Ut6esKIb9ejqKqyPzPVta8nl79/IpTlyS7JSI/b
 gmk1szpXkDFWdhx5ObsBXiC1C5aNwJkJ+Qezwyx3mGsqqWB1y/s3wiaDjpsyVlD4iolw
 8X4sd+qBAkdtMgNOmLMy5uC38Nhpo0ktsc+ocdhJCAhzRqvgtkupyc3qFg5p4OBxtjiT
 5R2A==
X-Gm-Message-State: AOAM533bJyLt75tNk5Vss+HWOoFGhSD6/jJNB3QXlln9YWnfy4uWNyk1
 4ZeH5HjUB9fC7eY5Hl/CTG0PcI6Szk+XwSbE
X-Google-Smtp-Source: ABdhPJy+tqW9kmKMCNem8Rxc3/F95NlYWzfcXjcPZ5b7mbQBoH9RDJaTx5kjsEOWvWgWs52Wo6OLIw==
X-Received: by 2002:a63:fd11:: with SMTP id d17mr4852463pgh.272.1598314630313; 
 Mon, 24 Aug 2020 17:17:10 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id 2sm643969pjg.32.2020.08.24.17.17.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2020 17:17:09 -0700 (PDT)
From: luoyonggang@gmail.com
To: qemu-devel@nongnu.org
Subject: [PATCH] meson: Mingw64 gcc doesn't recognize system include_type for
 sdl2
Date: Tue, 25 Aug 2020 08:16:49 +0800
Message-Id: <20200825001649.1811-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.27.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x534.google.com
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
Cc: pbonzini@redhat.com, Yonggang Luo <luoyonggang@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yonggang Luo <luoyonggang@gmail.com>

---
 meson.build | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index df5bf728b5..a3585881e1 100644
--- a/meson.build
+++ b/meson.build
@@ -224,8 +224,7 @@ if 'CONFIG_BRLAPI' in config_host
   brlapi = declare_dependency(link_args: config_host['BRLAPI_LIBS'].split())
 endif
 
-sdl = dependency('sdl2', required: get_option('sdl'), static: enable_static,
-                 include_type: 'system')
+sdl = dependency('sdl2', required: get_option('sdl'), static: enable_static)
 sdl_image = not_found
 if sdl.found()
   # work around 2.0.8 bug
-- 
2.27.0.windows.1


