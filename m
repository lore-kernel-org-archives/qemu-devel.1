Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05BC0C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 12:21:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C69A12075C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 12:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBbe0NqB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C69A12075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39832 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMXBf-0005Nr-SV
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 08:21:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thatlemon@gmail.com>) id 1hMXAi-0004rp-UJ
	for qemu-devel@nongnu.org; Fri, 03 May 2019 08:20:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thatlemon@gmail.com>) id 1hMXAi-0006BV-2M
	for qemu-devel@nongnu.org; Fri, 03 May 2019 08:20:12 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40825)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <thatlemon@gmail.com>) id 1hMXAh-0006An-SR
	for qemu-devel@nongnu.org; Fri, 03 May 2019 08:20:12 -0400
Received: by mail-wm1-x343.google.com with SMTP id h11so6492804wmb.5
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 05:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:mime-version:content-disposition
	:user-agent; bh=MDxLo/LnSsluuOYbAhZgKtIhQBd/p3pTdicYr0RUXxM=;
	b=JBbe0NqByKmoCnyQEZxNrWnhJUYjoCbeu91Evc3krdsDtEWGsuzx1eRFe1pu5NN2LO
	QRYONro8H25PMjAMP0nOswgk4071HVtggyQfS5ACm9/PJTH99zKR+laIGP8lWVNdnC1Q
	STuLmQ70HEOre/F4dKcqsfz/ZrHX4HIh5EYzIU9yA8Doev00p/mChUDJ/j45QkLkvapi
	sw1qNATa+Xowp6IXlohIsfJ3vsBJAwQxamzGwleipdU9Z3o/vF6E42JaXCzcdW9OQVep
	yL+xA+zS/Md+7etWewDxlPxDELpP5TchMyNDO5XUZsPL5AeXS8ZEDBuvNYnLgGuFoGoS
	kyQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
	:content-disposition:user-agent;
	bh=MDxLo/LnSsluuOYbAhZgKtIhQBd/p3pTdicYr0RUXxM=;
	b=VlkKM49oHsAbfA9ii7RHQqdw380UqjG4cBKd4d9BqkTo/SoPrEAsOBnSDxwuM7GdBV
	6NcVVNwZS1duiYpAYGUDH0gUn12raSd79em6hlns+AoHly5/v+lKFlJUiZiKpiIhglwv
	d+3WTCeepiQJW90FKVjifSP8QuPCQkmcoyNKKEQoIWflSpCGVH80qO9AuMQibw1ksUOE
	KUlf4Or19iLivmUYeQVpQCLDMKFxSYHk36c0AD49LpvW29hBZaBAulrDRRbUwLlMWFes
	DYD8K/J4cycltYSTEmQDDhlCYm9WbDxuchjB0Duw+fwaJRU4Vr2FJRFX61Hex1HTktnx
	t01A==
X-Gm-Message-State: APjAAAUqeFEEAoRbaP8qNI6pAfg7Gi6wgf4QSwkm1WpTN5cMxVaPCZrX
	mQ10WGtR7f4rT+TI9T+kusarNjW1LmY=
X-Google-Smtp-Source: APXvYqzJBHXEm/MxEXuZR1ttw2CjUoNQdzgFGdudVx7Me050Hu147F1i8yI41UFZX7Er2/ln9jy5LQ==
X-Received: by 2002:a1c:f909:: with SMTP id x9mr6239364wmh.18.1556886009950;
	Fri, 03 May 2019 05:20:09 -0700 (PDT)
Received: from debian ([151.60.84.114])
	by smtp.gmail.com with ESMTPSA id v9sm2773594wrg.20.2019.05.03.05.20.08
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Fri, 03 May 2019 05:20:08 -0700 (PDT)
Date: Fri, 3 May 2019 14:20:07 +0200
From: Giuseppe Musacchio <thatlemon@gmail.com>
To: qemu-devel@nongnu.org
Message-ID: <20190503122007.lkjsvztgt4ycovac@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH v2] linux-user: elf: Map empty PT_LOAD segments
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, riku.voipio@iki.fi, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503122007.8XzfYLwHDRc4-N5dQAhCJpQm-C0PDgMaFCtYyziDEtA@z>

Some PT_LOAD segments may be completely zeroed out and their p_filesize
is zero, in that case the loader should just allocate a page that's at
least p_memsz bytes large (plus eventual alignment padding).

Calling zero_bss does this job for us, all we have to do is make sure we
don't try to mmap a zero-length page.

Signed-off-by: Giuseppe Musacchio <thatlemon@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/elfload.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index c1a2602..138735b 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2366,11 +2366,19 @@ static void load_elf_image(const char *image_name, int image_fd,
             vaddr_ps = TARGET_ELF_PAGESTART(vaddr);
             vaddr_len = TARGET_ELF_PAGELENGTH(eppnt->p_filesz + vaddr_po);
 
-            error = target_mmap(vaddr_ps, vaddr_len,
-                                elf_prot, MAP_PRIVATE | MAP_FIXED,
-                                image_fd, eppnt->p_offset - vaddr_po);
-            if (error == -1) {
-                goto exit_perror;
+            /*
+             * Some segments may be completely empty without any backing file
+             * segment, in that case just let zero_bss allocate an empty buffer
+             * for it.
+             */
+            if (eppnt->p_filesz != 0) {
+                error = target_mmap(vaddr_ps, vaddr_len, elf_prot,
+                                    MAP_PRIVATE | MAP_FIXED,
+                                    image_fd, eppnt->p_offset - vaddr_po);
+
+                if (error == -1) {
+                    goto exit_perror;
+                }
             }
 
             vaddr_ef = vaddr + eppnt->p_filesz;
-- 
2.20.1


