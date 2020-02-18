Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8847BC34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 19:42:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5086121D56
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 19:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jng6cjJ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5086121D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j48lZ-00009A-G3
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 14:42:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55342)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j48ie-0003oK-NK
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 14:39:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j48id-0004Vg-LJ
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 14:39:44 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d]:41457)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j48id-0004U4-Ex
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 14:39:43 -0500
Received: by mail-pf1-x42d.google.com with SMTP id j9so11147339pfa.8
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 11:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fkf1cCU+0nMjQ3/Y/EWHF6ItnUhhF98WWxF5yKDha6U=;
 b=Jng6cjJ1KQzNj5yLYHF63m6IEbsOSuKsIS91rowT385wkEdGQ1jP8qJloYgS7q3AnH
 cmPVgZYrz6yoxuac+AAK/yYhkzP+cvqiLA3rY3kzXkM/JaTe1c2/0tbczAVkwjm1p7ME
 a2nvC5isR0/65eQ4C8vqNPvEldVkm+dElsftBpqJybuWmKu1cV/mmb9/M/AQl7C9s8O9
 4Hee8IFJSgTHUO+xyMh2IjkhpuJNnjPbXXPjEjXtg0aPFplTYHZgHsSw8eLknW2k8HJF
 0jQ1R3ZM0CHM+2PfdYht4z4mzRYmsf5NraPNyj76Iy8PNbWw/UtLJjEu8UcvP8dCNfYy
 smCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fkf1cCU+0nMjQ3/Y/EWHF6ItnUhhF98WWxF5yKDha6U=;
 b=TBc/bxbs+UfBsLAYUZo27hS4npmYFn/NI/xxF6EkNWbr5Fj1Gwt8fIuO0pFajQRB26
 ise2LtBrxZeTUcO2rO8kaCmsNsSULw8IvMW/+j4vUR8GJFVXqVApfkUMCNXntil2eVTB
 rV6tbMcpU50o/nDyGmeatM1m4/Xf0UewaWOg6f5Tx3ml62fflK/XHzLeQC0+bGCjqta9
 Tyl/MIHRSelO1Sk7z3ePQ6ji8y+2sW0Yiv2JNvjZIYkzgi/fWn0o+Q8lAH+6yA8ItkKl
 xmEunvFS0TXzUBSA/A0WM0fFIZzY7wrnTOjhDlpjeT50XobAmBbN1OzxocY6zIlnDVBl
 h9lA==
X-Gm-Message-State: APjAAAVV/UwJ1VLXg7gUNlJ4QXvnfCsIKwcIac6WlcgkSwjqkxdGQEEZ
 jc7sJFJOFRggykobixeM/OHuM20YsD0=
X-Google-Smtp-Source: APXvYqwDjnpwbc7hCgl/845q9C81U9dqTQ7JsdMtBpufLcZp6XRHIOQu6CywTDLErfB/D/EvJQ/fwg==
X-Received: by 2002:a63:1e5e:: with SMTP id p30mr25945016pgm.112.1582054782116; 
 Tue, 18 Feb 2020 11:39:42 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id y15sm424395pgj.78.2020.02.18.11.39.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2020 11:39:41 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 8/9] hw/hppa/dino: Fix bitmask for the PCIROR register
Date: Tue, 18 Feb 2020 11:39:28 -0800
Message-Id: <20200218193929.11404-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200218193929.11404-1-richard.henderson@linaro.org>
References: <20200218193929.11404-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::42d
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
Cc: peter.maydell@linaro.org, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Only 24 bits of the PCIROR register are documented
(see pp. 37 of datasheet referenced in this file header).

Acked-by: Helge Deller <deller@gmx.de>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200218063355.18577-4-f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/hppa/dino.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/hppa/dino.c b/hw/hppa/dino.c
index 8868e31793..be799aad43 100644
--- a/hw/hppa/dino.c
+++ b/hw/hppa/dino.c
@@ -94,7 +94,7 @@ static const uint32_t reg800_keep_bits[DINO800_REGS] = {
     MAKE_64BIT_MASK(0, 32), /* Undefined */
     MAKE_64BIT_MASK(0, 8),  /* MLTIM */
     MAKE_64BIT_MASK(0, 30), /* BRDG_FEAT */
-    MAKE_64BIT_MASK(0, 25), /* PCIROR */
+    MAKE_64BIT_MASK(0, 24), /* PCIROR */
     MAKE_64BIT_MASK(0, 22), /* PCIWOR */
     MAKE_64BIT_MASK(0, 32), /* Undocumented */
     MAKE_64BIT_MASK(0, 9),  /* TLTIM */
-- 
2.20.1


