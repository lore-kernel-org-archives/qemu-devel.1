Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEFD5C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 08:19:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F5872080A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 08:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cco285He"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F5872080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTKxR-0001oR-Ms
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 04:19:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kTKvT-0008Sm-Fq
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 04:17:23 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433]:39112)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kTKvR-0006H3-Tn
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 04:17:23 -0400
Received: by mail-pf1-x433.google.com with SMTP id n14so1040855pff.6
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 01:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oOrel6pAkV/C7atKug+trSY8cTbdMTMgCmXz/9nhCTc=;
 b=cco285He5hIfsca7QMw7/dNq/z5Z/4C9B87DOSFi1JBNBtWIaeeea0uiQLf/i+t/PQ
 SwDI86tYRpG4CD46sD8f/frfbcwtT2F+Dv/M+QLMxqgW3ZUeQ7psUjyJ8CuGOYrR6EqJ
 QyRxGp/jzRPFHEzeisJqKOsU8iLcJW3qCGuENlX10Gwz7NyCEO8BfOVEibfpN7SN0bJH
 PXlQgoaEkKOHptD4w6FFQhU+eI1hluzKcuO+QfY/W6YtoosHoxZgbwBPsNU1+TdF6+mh
 KQZzmij7XpsG7sYr+wxrklg7ORaookd1ybcRS1mIxsE+frF7P8vnrH6ZYe+jjfXd2P+X
 tWsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oOrel6pAkV/C7atKug+trSY8cTbdMTMgCmXz/9nhCTc=;
 b=gDjS4P3fP8RzQ+nwXtNZPKhkWoXyUpGwSaVyTZNPnrQrHsPI051/jUzapccoVON2t9
 x5Nv/XEveFoC9aWf/zW0HW0pSJEEAZfrfJlZ8q53kjaoHj7e1IgVq2Te7PpVxh4ydDY3
 E7eReQUf3qr9UCPU15j4jvmiNwC2vb5JP93mmB2rBtZ9s0nhDruypDfm2Jaf0BiVhhH5
 CAF2QOA4jpS1NosAJQCs5nlNVUwN3lrp+WZp49ejXICsNH0dkhVII99mQm+dXaJxiI0b
 qVEmbe5oa/A4Ap7bhWbLh/brA+K7kDQ+jbhsxz7cBhHrwJRevFm5tFtp2RfwpC+2n2Tm
 0HPg==
X-Gm-Message-State: AOAM532p+W4iOVTK1XKXyiC6SIiYFaK1HCn4Gdr1fdUO/LuY2BbnMsj8
 1sWBFBJXxdmv2RijjU1Qyy70aveFqLx88yAR
X-Google-Smtp-Source: ABdhPJwfm9Wr/jo7tR9JGgfefM+Y7I4rijgh7UUw2J5skWZVu+GheXq2uGp+6PCtPaWEUQ0d8kzF1Q==
X-Received: by 2002:a65:67d6:: with SMTP id b22mr2182766pgs.358.1602836240212; 
 Fri, 16 Oct 2020 01:17:20 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id d2sm1940343pjx.4.2020.10.16.01.17.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2020 01:17:19 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 2/4] configure: the docdir option should passed to meson as
 is.
Date: Fri, 16 Oct 2020 16:16:56 +0800
Message-Id: <20201016081658.1890-3-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20201016081658.1890-1-luoyonggang@gmail.com>
References: <20201016081658.1890-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x433.google.com
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
index 78062fb091..432ea124e1 100755
--- a/configure
+++ b/configure
@@ -968,7 +968,7 @@ for opt do
   ;;
   --with-suffix=*) qemu_suffix="$optarg"
   ;;
-  --docdir=*) qemu_docdir="$optarg"
+  --docdir=*) docdir="$optarg"
   ;;
   --sysconfdir=*) sysconfdir="$optarg"
   ;;
@@ -5710,7 +5710,6 @@ fi
 qemu_confdir="$sysconfdir/$qemu_suffix"
 qemu_moddir="$libdir/$qemu_suffix"
 qemu_datadir="$datadir/$qemu_suffix"
-qemu_docdir="$docdir/$qemu_suffix"
 qemu_localedir="$datadir/locale"
 qemu_icondir="$datadir/icons"
 qemu_desktopdir="$datadir/applications"
-- 
2.28.0.windows.1


