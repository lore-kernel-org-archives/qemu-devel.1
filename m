Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ECA2C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 12:42:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A5D720705
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 12:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOBTvHzz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A5D720705
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipAfh-0000j0-Mt
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 07:42:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60359)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipAWP-0003o9-Ee
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipAWO-0004LA-70
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:13 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:38060)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ipAWO-0004Km-1G
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:12 -0500
Received: by mail-wm1-x32b.google.com with SMTP id u2so2317041wmc.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 04:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=h3yQhB8alBlldX2ihkI73aVBbhIVO77Uu7vlmxTBOs0=;
 b=NOBTvHzzU+TzTlbk68TFb9Om3wppsaalL9VEV7HAcRNWeHkKC5NUE9LRBcqFsiadNg
 UR3KazNrjKsaWtFtjVoHQc8bAQmvx4t3cXJyC7eG9/nmbRPqpkK0oiJUUPyMsliYxKKD
 VQ9HLGoRxWwFVbgjTlrXr3aypxAX3pxsllDxG9hq8NhjvIBwXSBz8N8ge1k17yb4mqT8
 sRyUBUM2octJwJEMw6osCOpt+CrkdommTzNYSNsEPYlsY4wLiSDhy/fvJAanF2ZjX1kh
 TbfH4yyMA8JdAoUGsY5eLQg+uaxF/be38Gf0RZm0vyT0SHGQHc6YQUcW+cgQTmX903mS
 s7aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=h3yQhB8alBlldX2ihkI73aVBbhIVO77Uu7vlmxTBOs0=;
 b=H9AnSVEu605s5Si9xtKf4LAST1/nGogYOQc2BRmX76Lltl5bIKcDWY4JEvwmt76lA1
 a7KtXI1U3v3aQYC6T6atf8Yf7m3dWhZKOpK20zUfTksy6Xye03YZxaAfVC70zdZJIRIl
 9x1XxITnsthLTWyXCMcnuZeyhWadiNxdPUNB+DV3L/liUzcYmmtKjhScZinCXR7Y21n+
 yxxoF11LllDsm+4VklrcLD0yfuMwEtuyy93qQDFv0GfveIEqySd3vABGxPhG0e9lHUIG
 VbDNcYU+Y+dS6i73aO5ieplalNvhwN6EYxN3su349RT8lEoyQZuIZN8/tmmRIJp6xBnm
 uOrw==
X-Gm-Message-State: APjAAAWRdkNq5wXJyG3tzoX8BmRl5ox+un9SbaVb7a4gAJvv2PbLKu78
 Y0GQXMGhOWnOe0yzLUp/TRqB/Zp0
X-Google-Smtp-Source: APXvYqxyy1jPVw8ZgoBDyqgHBdbp+fvqft/r0Rb+kZcW7GfkvCmpxj7f2GXrQledOffbY3xd+mcgPg==
X-Received: by 2002:a05:600c:230d:: with SMTP id
 13mr3588051wmo.12.1578486790901; 
 Wed, 08 Jan 2020 04:33:10 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id o4sm4037750wrw.97.2020.01.08.04.33.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 08 Jan 2020 04:33:10 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 14/38] hw/ppc/Kconfig: Let the Xilinx Virtex5 ML507 use the
 PPC-440 devices
Date: Wed,  8 Jan 2020 13:32:31 +0100
Message-Id: <1578486775-52247-15-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1578486775-52247-1-git-send-email-pbonzini@redhat.com>
References: <1578486775-52247-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32b
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

When configured with --without-default-devices, the build fails:

    LINK    ppc-softmmu/qemu-system-ppc
  /usr/bin/ld: hw/ppc/virtex_ml507.o: in function `ppc440_init_xilinx':
  hw/ppc/virtex_ml507.c:112: undefined reference to `ppcuic_init'
  collect2: error: ld returned 1 exit status
  make[1]: *** [Makefile:206: qemu-system-ppc] Error 1
  make: *** [Makefile:483: ppc-softmmu/all] Error 2

Fix by selecting the PPC4XX config.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20191231183216.6781-9-philmd@redhat.com>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/ppc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
index 004b7d5..d8482a5 100644
--- a/hw/ppc/Kconfig
+++ b/hw/ppc/Kconfig
@@ -110,6 +110,7 @@ config E500
 
 config VIRTEX
     bool
+    select PPC4XX
     select PFLASH_CFI01
     select SERIAL
     select XILINX
-- 
1.8.3.1



