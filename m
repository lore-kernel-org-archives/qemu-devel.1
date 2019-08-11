Return-Path: <SRS0=60Ee=WH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 499E3C433FF
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2019 08:19:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 129DB208C2
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2019 08:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cr+R29jV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 129DB208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwj4f-0007vW-E8
	for qemu-devel@archiver.kernel.org; Sun, 11 Aug 2019 04:19:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60612)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hwitA-0006y0-4P
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 04:07:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hwit9-0004BA-6Z
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 04:07:40 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:40976)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hwit9-0004Ap-1B; Sun, 11 Aug 2019 04:07:39 -0400
Received: by mail-pf1-x441.google.com with SMTP id 196so1074927pfz.8;
 Sun, 11 Aug 2019 01:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=L4ovBGkTvtMuTbVfCjKixwvCZJSnpSENY/BYixzbcEo=;
 b=cr+R29jVF8MMKY8tgluHlll0GboZbmM8OXU2xmhD9QGP3JDBn+OfiIB7gQpBzBo7+6
 sd3wp6TyeJVD/XTmQ7IQr9GoE9WbQLaT312vBMg8dW2dO3AinAiJNwFnoGRn2tz5Tplj
 F0whF5fsM81XI9qk0KFaEK4HwbNRzbRqwfAQgVd3MFqvU+xMCNCmHMJHFoQuiQWlcLsK
 1DnhzSPGJMqWrttIsJvNdO4c/aEwX5J0QbPpeRfJe7xBT8W8wM+ftckYKiJYKv77n1jc
 KjPaosausdglbaZyiX0xF0oNRumrs45w4ma1+FAWOmYNwYRRl4MpvhmW0yNxgvcSBvRY
 JJuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=L4ovBGkTvtMuTbVfCjKixwvCZJSnpSENY/BYixzbcEo=;
 b=BzC2dkQXgGQagcPosLknB8UK+fR+rWPxb9Y6AaxeNEw0IIpv1P80kV51u0UrjuHseS
 r6wW12M5uO5XVi9FwDoCsfVTpm94C5TsCVOTPzBw+LtrLcRfv+dVWqbhJCSJSCfOGzcG
 UXMZEVOWPY95hg+Dkaa/+wFXJgMFom9VLtkhdirYFgLoaIXEBD80vBhaD6H2WP85Zjff
 yu4TfQ6yyCe1F01T7NwchqUboBNdz0w04eV68AT/mVXAKcFTQRP1xlUOEHDnZLzhfwVV
 iSWUBbcus/HSbKo+neG7Eaq1tYQciYVAWAwBdrt31eYhtfh9IfzTO5p6XurYsk8X7CIV
 DUpw==
X-Gm-Message-State: APjAAAW0egLMaveyVFFhwuMBe0frcGtPxiEkzpvm7b4/2FY/McYiOLbF
 BQUvKNbChXqgrGe0DZVN6I8=
X-Google-Smtp-Source: APXvYqyQbh+GkH0TvuO9MxIJ4p6VR51bN8+4FD5Va2Oks2VqdFP1UIdCjq7IWwSUuJ0awpkTdYGwqQ==
X-Received: by 2002:a17:90a:2767:: with SMTP id
 o94mr17476301pje.25.1565510858304; 
 Sun, 11 Aug 2019 01:07:38 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id v8sm87339107pgs.82.2019.08.11.01.07.37
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Sun, 11 Aug 2019 01:07:37 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Sun, 11 Aug 2019 01:07:01 -0700
Message-Id: <1565510821-3927-29-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1565510821-3927-1-git-send-email-bmeng.cn@gmail.com>
References: <1565510821-3927-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH v3 28/28] riscv: sifive_u: Update model and
 compatible strings in device tree
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This updates model and compatible strings to use the same strings
as used in the Linux kernel device tree (hifive-unleashed-a00.dts).

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

---

Changes in v3: None
Changes in v2: None

 hw/riscv/sifive_u.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 8801ee2..98fefbeb 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -96,8 +96,9 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
         exit(1);
     }
 
-    qemu_fdt_setprop_string(fdt, "/", "model", "ucbbar,spike-bare,qemu");
-    qemu_fdt_setprop_string(fdt, "/", "compatible", "ucbbar,spike-bare-dev");
+    qemu_fdt_setprop_string(fdt, "/", "model", "SiFive HiFive Unleashed A00");
+    qemu_fdt_setprop_string(fdt, "/", "compatible",
+                            "sifive,hifive-unleashed-a00");
     qemu_fdt_setprop_cell(fdt, "/", "#size-cells", 0x2);
     qemu_fdt_setprop_cell(fdt, "/", "#address-cells", 0x2);
 
-- 
2.7.4


