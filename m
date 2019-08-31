Return-Path: <SRS0=aRDT=W3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD3CC3A59F
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Aug 2019 07:48:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D35CB2343A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Aug 2019 07:48:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D35CB2343A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxfamily.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3y7z-0002ki-7P
	for qemu-devel@archiver.kernel.org; Sat, 31 Aug 2019 03:48:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37378)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <th.huth@gmail.com>) id 1i3y4z-00010b-Kn
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 03:45:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <th.huth@gmail.com>) id 1i3y4x-0005zu-L1
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 03:45:49 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51471)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1i3y4v-0005YG-HE
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 03:45:46 -0400
Received: by mail-wm1-f68.google.com with SMTP id k1so9551423wmi.1
 for <qemu-devel@nongnu.org>; Sat, 31 Aug 2019 00:45:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zL4SPv+ECjSYJDHITbd1llRChd+Y2mQbn5Ro1plp/SU=;
 b=jUX88+6XAbsXstHCec94VP3TqydYMz1BK33a/m2PCQ+UXiiPsB/dIyhyvMnXTE908F
 qcnvdMpJK68pbEX8PmFLc1idOGqGIchbuendy6pTTVr3SELuhKLe7QE+n7BCqubtzduk
 BiHK/Q1BO0p6In85aYkMV/0iO+S5RYNYwJxuk5U1xzobjG/qR7U5sjXJ2vvbRWiV4zFH
 FD3CLm7H7JxjPju9k7wGxNkbJevwmrHzd4t+EhBZUGZOonEcz+qwGf/ks6f/Ft+gWYM5
 BFsrLI1BWu/1WOQYJM/+cTzTpHpOv3VkDjvFjRe3iuPwLwAxZpEa5HsIA4JTVLQZInDm
 yUuQ==
X-Gm-Message-State: APjAAAUhhSAWGM8Mwvj3736Z7zop2uY/Tt1vdt6c9uj+gIyA1Bj77abr
 Gfhx+HILszNsiXUnxl24Yu1Pt0/qF1Y=
X-Google-Smtp-Source: APXvYqzY+H/euiYF7jaaO6fQl/9K0xEHGL+rFjZHhjgTkPGq8W62rrm/u4LxGMSyohrT8QHj8spf0w==
X-Received: by 2002:a1c:1d84:: with SMTP id d126mr8395528wmd.58.1567237535647; 
 Sat, 31 Aug 2019 00:45:35 -0700 (PDT)
Received: from thl530.multi.box (pD9E83624.dip0.t-ipconnect.de.
 [217.232.54.36])
 by smtp.gmail.com with ESMTPSA id w1sm7546650wrm.38.2019.08.31.00.45.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Aug 2019 00:45:35 -0700 (PDT)
From: Thomas Huth <huth@tuxfamily.org>
To: qemu-devel@nongnu.org
Date: Sat, 31 Aug 2019 09:45:19 +0200
Message-Id: <20190831074519.32613-7-huth@tuxfamily.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190831074519.32613-1-huth@tuxfamily.org>
References: <20190831074519.32613-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: [Qemu-devel] [PATCH v5 6/6] m68k: Add an entry for the NeXTcube
 machine to the MAINTAINERS file
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I don't have much clue about the NeXT hardware, but at least I know now
the source files a little bit, so I volunteer to pick up patches and send
PULL requests for them until someone else with more knowledge steps up
to do this job instead.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ef6c01084b..56d6c75f72 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -910,6 +910,13 @@ F: hw/char/mcf_uart.c
 F: hw/net/mcf_fec.c
 F: include/hw/m68k/mcf*.h
 
+NeXTcube
+M: Thomas Huth <huth@tuxfamily.org>
+S: Odd Fixes
+F: hw/m68k/next-*.c
+F: hw/display/next-fb.c
+F: include/hw/m68k/next-cube.h
+
 MicroBlaze Machines
 -------------------
 petalogix_s3adsp1800
-- 
2.21.0


