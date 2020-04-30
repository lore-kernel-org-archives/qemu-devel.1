Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D5FC8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 10:33:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48C2B20838
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 10:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gae+n53x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48C2B20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU6VQ-0004Kn-Di
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 06:33:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53250)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zltjiangshi@gmail.com>) id 1jU6Oz-0002H3-Ja
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 06:26:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <zltjiangshi@gmail.com>) id 1jU6Oy-0008D4-0W
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 06:26:45 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:46173)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1jU6Ox-0008Cs-H3
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 06:26:43 -0400
Received: by mail-pg1-x542.google.com with SMTP id q124so2539233pgq.13
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 03:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=HgsgnhcknBEThCxoBAkUHZODhxnE0lcuSM5I7iabbM0=;
 b=Gae+n53xxZXyy44d0dnLPs0NdZDUvaWEHxRk0kkHMDd9mDNX4qRbU41mRBr7idH3PO
 FG5qoot9R0ZYIxCY1ctNbrZ56RB3Go0YcN5q5SPfhsCAAWrQpe3AQ9EmZ6qChXY3oFds
 WHuq49ko0RdiUdIEhHRoaNSk5v0vwBb2BcH4gD0g+uJ2e1RYC2PdZ+DINUqChUFVhy+h
 kKrTq8hzJwp4knapJah4w7mvKmYDn69mUSx2/p1hXBslAPtvJhnNrw/boGmj+qp/TylK
 7TYDwgCFc78VykMcUH6NSh8jsboZ6VxVAbAx8+OWpWKyvv/MvrGVgZTsddhmPhHU5I8+
 GsFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=HgsgnhcknBEThCxoBAkUHZODhxnE0lcuSM5I7iabbM0=;
 b=J42EewRJhNhonzp9IWWSY559g9B+2dBoNUDKe8Mzb1+eXk6QNctnwHLYcU8RKVT6Wk
 ftNKk4BbXkUkvTkyxc+FiLjR06i7RXwjkz6vP/CF8GnTkZEw6ZXTqWdVvjcQoj2HxJVW
 1AAYsu9IspXXi0tSVm/5uaDCwYdTsidcuSR+HVcBo652a7oerE+s7ZsIM5ixfIFwQqwP
 Kv/c6hlG9atPrwuRFkCCQH5DUTsWrB8iBf8FyzOtD5kypXDzlWjk3OOQR7oQ6DZxW5R2
 9jsgZQHbf84e78ZIx8MI/FudCI53eGN5z7IecSkLMqGinlOcira+gsaaNg9JJfgSEDiF
 7n8g==
X-Gm-Message-State: AGi0PuaozdhHXfnugk0QNPEDEZvaHRGr+jrRZraPUStgXJ+fgVEbqY6D
 5yqdKd9BxSpJfD04bz0zGeY=
X-Google-Smtp-Source: APiQypJoYh7XUxsqca6zkLK2twHS2GO8Vv9gQ2nk38elVzSJw1GLjW/DZeDJcLFE13aBOEFuIVZwMw==
X-Received: by 2002:aa7:8f26:: with SMTP id y6mr2960506pfr.36.1588242402054;
 Thu, 30 Apr 2020 03:26:42 -0700 (PDT)
Received: from software.domain.org (28.144.92.34.bc.googleusercontent.com.
 [34.92.144.28])
 by smtp.gmail.com with ESMTPSA id a15sm1397872pju.3.2020.04.30.03.26.39
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 30 Apr 2020 03:26:41 -0700 (PDT)
From: Huacai Chen <zltjiangshi@gmail.com>
X-Google-Original-From: Huacai Chen <chenhc@lemote.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: [PATCH for-5.1 V2 7/7] MAINTAINERS: Add myself as Loongson-3
 maintainer
Date: Thu, 30 Apr 2020 18:22:35 +0800
Message-Id: <1588242155-23924-8-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1588242155-23924-1-git-send-email-chenhc@lemote.com>
References: <1588242155-23924-1-git-send-email-chenhc@lemote.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=zltjiangshi@gmail.com; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: Huacai Chen <chenhuacai@gmail.com>, Huacai Chen <chenhc@lemote.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>, qemu-devel@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index aa9a057..66c5a41 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1080,6 +1080,11 @@ F: hw/isa/vt82c686.c
 F: hw/pci-host/bonito.c
 F: include/hw/isa/vt82c686.h
 
+Loongson-3
+M: Huacai Chen <chenhc@lemote.com>
+S: Maintained
+F: hw/mips/mips_loongson3.c
+
 Boston
 M: Paul Burton <pburton@wavecomp.com>
 R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
-- 
2.7.0


