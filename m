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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91461C43457
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 22:08:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0A8020776
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 22:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dnNNy3Eb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0A8020776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTBQH-0001OF-TJ
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 18:08:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55232)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kTBOc-0008Ub-6B
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 18:06:50 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e]:41422)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kTBOa-000724-OO
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 18:06:49 -0400
Received: by mail-pf1-x42e.google.com with SMTP id c20so252688pfr.8
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2020 15:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IkJ+z3wbykhjoUQ4XRK2kASFvDBSvBM63031zcipiFE=;
 b=dnNNy3EbHKqqUeSBz+Pv46A6X+kobSFvbmZUwzimElGvFw32/zfGIxqrrFluAyhWyU
 rj95kkGOPoySYu6c9CIJZ2CJxQi09hAHtRuGxqqw9wLh10ES+78v0BN6HWNQqGDgreSo
 qldvneP41drkIsAxbyjRBa4NFkaY+48PwqwtnO2xFdJCCf2zDjXFbNtHf2BoMTGzSaz4
 TQnS5nEgRr/Kg50ej1UXKMepyXCoSnOay70+QykUQ8pjFfiIL6so7ZgM70PAO/SdDBBz
 i/vPcx2cQmsJQAaavr8azwHvtebfoKAOMJwnn9WgFqVseO2zcteKZQx7sxvPuoZlh2+Y
 gTvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IkJ+z3wbykhjoUQ4XRK2kASFvDBSvBM63031zcipiFE=;
 b=GK8WDcxFqOU844tWw4YQ0kIWoZ98QCGtCwaOkykczyW7i0AOSSBx4Z7S7Z7uPa/ouw
 ljofyZF7yb022//R42zyi+4yW3zEvFLIYyjJRk8Y/jeVqP57Ny1o7jO4jjntbaJRAg9G
 bwwV2BfuOS94M15PxhoE4mmIhWZ4sb7KjYiATtv5tRNcYD1ngOYGaDZ0FlTnbTGbLZNp
 Ff+iyH6QAdLkzy4I93lGJmcGgRcumSut7a/rhGztrpwMtkPpycC9eDqVfE0aoEtu7U7I
 TtfONrwJ7iVEXh61N47+AQ+doOW0UvCFwhwuHBvSfsGRolYC1x8QlrQkkUhL9N5MfBNT
 ZHPw==
X-Gm-Message-State: AOAM5324EWKpwtbC/MPYtmqYnAW5z/aPSnRzto9oZPsMJlvYULiCkQZj
 XqT7tOspdevvHASmZrW7N2LJNpe3GYeFjvur
X-Google-Smtp-Source: ABdhPJyirOgCnZaG0YzxsNUc9LY8UhJL88kk9FCTkVZn58YYGCxj5Ll2h3rswtcsepL7OHXhASSDuQ==
X-Received: by 2002:a62:d456:0:b029:152:aa6a:877a with SMTP id
 u22-20020a62d4560000b0290152aa6a877amr687236pfl.24.1602799607039; 
 Thu, 15 Oct 2020 15:06:47 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id x10sm261468pfc.88.2020.10.15.15.06.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2020 15:06:46 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 2/4] configure: the docdir option should passed to meson as
 is.
Date: Fri, 16 Oct 2020 06:06:24 +0800
Message-Id: <20201015220626.418-3-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20201015220626.418-1-luoyonggang@gmail.com>
References: <20201015220626.418-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x42e.google.com
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


