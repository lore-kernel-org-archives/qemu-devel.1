Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72DDDC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:01:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D30D214AF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FbyF1sEV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D30D214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuevZ-0007b3-SE
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 11:01:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51224)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucrC-0004k9-OG
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucrB-000347-E6
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:14 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:54618)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iucrB-00032w-7f
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:13 -0500
Received: by mail-wm1-x32b.google.com with SMTP id b19so2627867wmj.4
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 05:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=K91PaAbwuPHcYYRyoA3KVsErzg14dVUsL6XXT+HRvuA=;
 b=FbyF1sEVLC/4Jb2cKaDiC9rNGz7TYDNibxxvXV2OyP6ffn5glrbEIlruc2bF13/Jh+
 Qx0m8yBxwiyHvWU78MrfA/TAg9W4f6VYam6/GUQpQ5MdDei6I/GXMERmqOdJ1scGBPjc
 gomk0utgjzrKw8eQ+iYSWg2hdwXN6Uu8Qd11VfB475i8+3MOG8NOs5m3xPZPKQk/84kT
 GqALK+oOjoxZv6O5gez5Z3VWU/Sb+c6/bwcTiLklQVlkTnyeK65SkFAB2X9F9Sb6ArLJ
 psL7Xmsso1FXhX2DRxZGXjURAX1rTxw9p3spDsg4BS6oYuPIqZcRr/ofJn2R1h/w8J3q
 hfvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=K91PaAbwuPHcYYRyoA3KVsErzg14dVUsL6XXT+HRvuA=;
 b=Egel3EtETm91j6ABUdvIMHPBuQ/rst/s15CAn0HdndRNF4JLylNc/xZiLFqd7Z0/sf
 6HQt/ohs9yJ4/vz6P4fgNBmcti9efRC2Kup72FlxYDQ5Qt+TQlaLAClzwwXazE1lYnZA
 dbpVIoCXbsyywlK/4JREclEtT1l0r9MK1dcv4D+TdopnoghI6KpasXCFIXr+PcysNrFy
 CCB7gltqAfQo6RGgXZJxiWvs1sSLH1OxuypKlCu+h5ySHcjlaNja01XagzwR/maWGScL
 9v5q9JbYHn+op5LHgHJlKnuvHnZgv3lDDbQNpqJVq9hR+0voQMlPmvLv610Y031SHDa5
 MJPw==
X-Gm-Message-State: APjAAAWq14k11Ov6qruZ/62/VYJDG5FD46yMyk3WhAAveQVUI9zNkxdg
 yXBFQGRXwLGlOc90kMBl7X9y7yrN
X-Google-Smtp-Source: APXvYqzqIxANCFi5cnyN/Z3yzXiMcHkwMSszZFimHzZiy6T7jDsiBf0NhaM07IFHzzx8p5rbxS/coA==
X-Received: by 2002:a1c:9602:: with SMTP id y2mr4282216wmd.23.1579787352092;
 Thu, 23 Jan 2020 05:49:12 -0800 (PST)
Received: from 640k.localdomain.com ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id s15sm3073171wrp.4.2020.01.23.05.49.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 23 Jan 2020 05:49:11 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/59] hw/display/tcx: Add missing fall through comments
Date: Thu, 23 Jan 2020 14:48:10 +0100
Message-Id: <1579787342-27146-8-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
References: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
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

When building with GCC9 using CFLAG -Wimplicit-fallthrough=2 we get:

  hw/display/tcx.c: In function ‘tcx_dac_writel’:
  hw/display/tcx.c:453:26: error: this statement may fall through [-Werror=implicit-fallthrough=]
    453 |             s->dac_index = (s->dac_index + 1) & 0xff; /* Index autoincrement */
        |             ~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
  hw/display/tcx.c:454:9: note: here
    454 |         default:
        |         ^~~~~~~
  hw/display/tcx.c: In function ‘tcx_dac_readl’:
  hw/display/tcx.c:412:22: error: this statement may fall through [-Werror=implicit-fallthrough=]
    412 |         s->dac_index = (s->dac_index + 1) & 0xff; /* Index autoincrement */
        |         ~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
  hw/display/tcx.c:413:5: note: here
    413 |     default:
        |     ^~~~~~~
  cc1: all warnings being treated as errors

Give a hint to GCC by adding the missing fall through comments.

Fixes: 55d7bfe22
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-Id: <20191218192526.13845-3-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/display/tcx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/display/tcx.c b/hw/display/tcx.c
index 14e829d..abbeb30 100644
--- a/hw/display/tcx.c
+++ b/hw/display/tcx.c
@@ -410,6 +410,7 @@ static uint64_t tcx_dac_readl(void *opaque, hwaddr addr,
     case 2:
         val = s->b[s->dac_index] << 24;
         s->dac_index = (s->dac_index + 1) & 0xff; /* Index autoincrement */
+        /* fall through */
     default:
         s->dac_state = 0;
         break;
@@ -451,6 +452,7 @@ static void tcx_dac_writel(void *opaque, hwaddr addr, uint64_t val,
             s->b[index] = val >> 24;
             update_palette_entries(s, index, index + 1);
             s->dac_index = (s->dac_index + 1) & 0xff; /* Index autoincrement */
+            /* fall through */
         default:
             s->dac_state = 0;
             break;
-- 
1.8.3.1



