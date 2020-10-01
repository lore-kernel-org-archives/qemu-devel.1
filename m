Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D26FC4741F
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:53:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4071221EF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxe4bb5Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4071221EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO2lf-0002mW-Pl
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 13:53:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33370)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kO2Rs-0004gZ-St; Thu, 01 Oct 2020 13:32:56 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033]:52432)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kO2Rp-0005DQ-Tu; Thu, 01 Oct 2020 13:32:56 -0400
Received: by mail-pj1-x1033.google.com with SMTP id gm14so2370180pjb.2;
 Thu, 01 Oct 2020 10:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=J7MK5+58+DPxK9PNp9tYy0RkeJRycPQrGBrc0kvVojg=;
 b=fxe4bb5YjHFKKJ7x/InHZ1iK/oy3hh3OFWkC1xAqETQan91alPoue0mx8EWFnLOQLZ
 YTxSGGF9w7SYSMqjWEIuf/Ih6BpN8TTp3sWsR/j5AEZZY1zBBFi/ghGr5dM8v8ehLFuz
 RLBL2DN8hr6JOldrTy4I97nGfX+uJdue1DD9+HIuV/3FW6z0nllRFxtM570FmqKnl/lK
 AzSayWOMY5uhLKdSak7j0x+A80g57x2CDP4BgAJRgbj30QTGM/hZhWPJFEu7gWt1Z8jG
 +/421+ynJshUuto1NGiOsWmnKrYfBBqJTNYcEqCxYCqg3jDG0XxnLhUwjjbfJvrq7NmU
 op9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=J7MK5+58+DPxK9PNp9tYy0RkeJRycPQrGBrc0kvVojg=;
 b=lGqlabiQTw+JNwL2MtbkBlFhUskJ+N2X/y/OXEDYBoESE0QuYyvN8ZJaMmyBXNbMya
 EiuuqBOanNgmAlJhNwrSk1U+YxSOpk3opBHt7x4a6EyortYvZFvj/qA4Z5ldn51tDytB
 phPaSDIE4a8CVMczuyKRN7QtHR4pYG+7SQMSV05AFqdEoXvZYvaGii/XcnrCPptfQBdE
 BIfF8D5mNSF5GAoP1eFYeR2Ybpg9spUTtb1qp/eJV1evFB7NPZmdlRwU/z+K5H+OSpDQ
 F3wwjFfEI+TmQa5Q2MK7WfUjny6VqY0Uo2EcuBiEmpmGwyBA84SkZsvT/erfrhAdHJzC
 ninQ==
X-Gm-Message-State: AOAM533CIBJbp3CE2racZkBTjlYgUdHoj69cdceIjAckED3+aGop+b7g
 5LZMHCrWgQnQ+wzk5Ztft4kKe2YAliBK+w==
X-Google-Smtp-Source: ABdhPJz7C3BcCjBGoZv4rE2wg2LXDyfb4LRJ3nuhXWpuUiv7f0w8buV1Hp6UsU7OqQ6cH6QOmo5a3g==
X-Received: by 2002:a17:90a:8c83:: with SMTP id
 b3mr1002224pjo.206.1601573571423; 
 Thu, 01 Oct 2020 10:32:51 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id b20sm7253767pfb.198.2020.10.01.10.32.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 10:32:50 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 1/4] configure: fixes indent of $meson setup
Date: Fri,  2 Oct 2020 01:32:27 +0800
Message-Id: <20201001173230.829-2-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20201001173230.829-1-luoyonggang@gmail.com>
References: <20201001173230.829-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj1-x1033.google.com
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Yonggang Luo <luoyonggang@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

convert these line from tab to space

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 configure | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/configure b/configure
index ca9b458ea0..8f7bdbfdd3 100755
--- a/configure
+++ b/configure
@@ -7843,10 +7843,10 @@ NINJA=${ninja:-$PWD/ninjatool} $meson setup \
         -Dstrip=$(if test "$strip_opt" = yes; then echo true; else echo false; fi) \
         -Db_pie=$(if test "$pie" = yes; then echo true; else echo false; fi) \
         -Db_coverage=$(if test "$gcov" = yes; then echo true; else echo false; fi) \
-	-Dmalloc=$malloc -Dmalloc_trim=$malloc_trim \
-	-Dcocoa=$cocoa -Dmpath=$mpath -Dsdl=$sdl -Dsdl_image=$sdl_image \
-	-Dvnc=$vnc -Dvnc_sasl=$vnc_sasl -Dvnc_jpeg=$vnc_jpeg -Dvnc_png=$vnc_png \
-	-Dgettext=$gettext -Dxkbcommon=$xkbcommon -Du2f=$u2f\
+        -Dmalloc=$malloc -Dmalloc_trim=$malloc_trim \
+        -Dcocoa=$cocoa -Dmpath=$mpath -Dsdl=$sdl -Dsdl_image=$sdl_image \
+        -Dvnc=$vnc -Dvnc_sasl=$vnc_sasl -Dvnc_jpeg=$vnc_jpeg -Dvnc_png=$vnc_png \
+        -Dgettext=$gettext -Dxkbcommon=$xkbcommon -Du2f=$u2f \
         $cross_arg \
         "$PWD" "$source_path"
 
-- 
2.28.0.windows.1


