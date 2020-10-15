Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E877FC433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 20:12:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42C8A20714
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 20:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HL5X5qLC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42C8A20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT9c3-0000XT-VC
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 16:12:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33490)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kT9aW-0007Hs-4L
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 16:11:00 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632]:34888)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kT9aU-0001jg-HD
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 16:10:59 -0400
Received: by mail-pl1-x632.google.com with SMTP id 1so2227108ple.2
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2020 13:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IkJ+z3wbykhjoUQ4XRK2kASFvDBSvBM63031zcipiFE=;
 b=HL5X5qLCI4zBxi4j5zjUtjwj7ccrDQ8XU/iNOgc/55oL51z8wTX17//PqETkt/5OGu
 ptILUxLX1oL4wgyMxlL3/J45uMgQfC//TJvYmH7mfwI3DPm77FXK1EdNgE94V0sL3+rL
 YSKU5v3irM7Ul6lT6uDUh2RSdhrF0GgL7nZzYbhzSjQE/OWsJcVOex+9QkF+P8BxCujP
 tUpCPmC7yUFsKXXPdxqeWgi71D9HX2B1kmOeQShCFOobWD/pQUZXuarngdM9r3awGg9l
 USh+a40G19BzwI2S5Qxh6F7LxXEguRfEOuk/e/7mmKsX4aEgvTqeK/LJpzE3NTTuQrKh
 opqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IkJ+z3wbykhjoUQ4XRK2kASFvDBSvBM63031zcipiFE=;
 b=pa47bHtrI9fXYMxMzdQV+2pJINR70GZUKNMrea5JaJBAOiWrarDbNjsC+KjsbVFxQ1
 2hfAVIq24tqW2N79i//L6AzbKzzQxY4En0KSr+fUIuDq4J5CzJbMezfvzf71bvmvFCO6
 M8TC3NJ2ED2XS936adtTce3xom6/xQklN2D5kiWkecQT4TnOXKobf5SAOqJdtI+T8Yar
 Vy3lOVzp8B/8pPmlyvS2XYvcmjxJvuOpFcFNBXAzBpGELtR6zwQiDGQ8qH5aNHhkf5yt
 iY6K6ISj9yqUGA48V19M/oWk2R4GsCuKCaPJ/3vQgIhA5O8+aAoMXtvTQGjeAeW+qOCM
 A1+w==
X-Gm-Message-State: AOAM532HgzYLs0EaGGB9Op/EaumA2IMT9Sk0KXsTtzlT+Oq3GI+n4ASL
 SWTao8vv80+QN61yhxDDjvCfZxWsgU6MfKvz
X-Google-Smtp-Source: ABdhPJx77u6YsDtHIS1ogzeA9zHMk/y5fBRXGsR8CUC81EOfHGVGzWe7c//uoP5wbzVSz6ILn3YzcA==
X-Received: by 2002:a17:902:6ac1:b029:d3:b4c9:e92f with SMTP id
 i1-20020a1709026ac1b02900d3b4c9e92fmr398905plt.38.1602792655796; 
 Thu, 15 Oct 2020 13:10:55 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id x18sm104734pfj.90.2020.10.15.13.10.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2020 13:10:55 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/4] configure: the docdir option should passed to meson as
 is.
Date: Fri, 16 Oct 2020 04:10:33 +0800
Message-Id: <20201015201035.1964-3-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20201015201035.1964-1-luoyonggang@gmail.com>
References: <20201015201035.1964-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=luoyonggang@gmail.com; helo=mail-pl1-x632.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 configure | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/configure b/configure
index f839c2a557..1ce31f97b4 100755
--- a/configure
+++ b/configure
@@ -971,7 +971,7 @@ for opt do
   ;;
   --with-suffix=*) qemu_suffix="$optarg"
   ;;
-  --docdir=*) qemu_docdir="$optarg"
+  --docdir=*) docdir="$optarg"
   ;;
   --sysconfdir=*) sysconfdir="$optarg"
   ;;
@@ -5770,7 +5770,6 @@ fi
 qemu_confdir="$sysconfdir/$qemu_suffix"
 qemu_moddir="$libdir/$qemu_suffix"
 qemu_datadir="$datadir/$qemu_suffix"
-qemu_docdir="$docdir/$qemu_suffix"
 qemu_localedir="$datadir/locale"
 qemu_icondir="$datadir/icons"
 qemu_desktopdir="$datadir/applications"
-- 
2.28.0.windows.1


