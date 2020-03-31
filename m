Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0812C2D0EF
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 10:52:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E4BD208E0
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 10:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gyepPOW6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E4BD208E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJEVl-00049J-N8
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 06:52:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52953)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jJEU1-0002OA-U2
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 06:51:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jJEU0-0006I1-Or
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 06:51:01 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40476)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jJEU0-0006HD-Ih
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 06:51:00 -0400
Received: by mail-wm1-x343.google.com with SMTP id a81so2023465wmf.5
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 03:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NTEVMDbO4wtPzpWjDeuq384PlojGr8aCfjPexjiQfbw=;
 b=gyepPOW6Hg+OHkFgwwNud5yofv8/3l8kv1+v59ajcufK2uFMCXl8ENXu3Y46SVaxGG
 v/Oun7ncY4HuqVNFPN6lj7hZSLiz8i+DUPridgNa7vb+JD5XN3x3MdDzu74ZisAO0kcF
 27a8nD8xBgXY3Id3d7Bvy8BmRwMHULU4AgX4u7mWs4JbQCK2SjUihPEOM0CupEM9VVF0
 Tc6GHkEyV0Km0F318LybAt/ACE+kmIzP7VSCFhdtqltn0qnsvLbAuOx7x0Lc7yeglTUu
 8Kr4cecnNAiWQiRgf6CXXNNPHpWjlvxynjG6icsQoJ4F3qeyeyTS2PbJDWRuiZsXaima
 S99A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=NTEVMDbO4wtPzpWjDeuq384PlojGr8aCfjPexjiQfbw=;
 b=I2lXzP4lWfx/b7PxL6uj4SusDhj4rrB8rHrcQdxLWOI8lzVMZ8gnlJxxZv+86KUFnQ
 CQCa0WPdiq267hOMuaHXedgEoa9Li5e7fCnr2r5HmO7a2rLBAILHxgWND0Jd5ux/KWld
 vmGHHv7JnRUe1enitegYC6OldSYPN7rP/UUk8mYH9cosbvaNQOdGRogspgCvNhWPwnjR
 oP9q05/uXgoq3gawqH6XPa8tDr0awb2STICUAaLl15CrPsJytvG0JvyqVi1RZwxTY3AE
 N1p4rdjdmaIimsAR1E3P+vz7DOIOMdLIl5rLs3No9xmqaBVzZVobgUOsz2rBypiAC/xF
 PSWw==
X-Gm-Message-State: ANhLgQ3y8dze577852UIOUpK8w0MJS9wCnk8uLvhKyYHwCJWmjOkslee
 1eWMz8hKmitn2O2axfWsr/qFDCaiNbc=
X-Google-Smtp-Source: ADFU+vvNTqEIj0dE/ch21tINs+V7stnqZ8Q4J/YxzejW1IUiTyBHm1hi5RwHBDC5n27BUAhENpb3ug==
X-Received: by 2002:a1c:4c1a:: with SMTP id z26mr2785273wmf.94.1585651859326; 
 Tue, 31 Mar 2020 03:50:59 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id w3sm26042830wrn.31.2020.03.31.03.50.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2020 03:50:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0 2/7] hw/misc/grlib_ahb_apb_pnp: Avoid crash when
 writing to AHB PnP registers
Date: Tue, 31 Mar 2020 12:50:43 +0200
Message-Id: <20200331105048.27989-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200331105048.27989-1-f4bug@amsat.org>
References: <20200331105048.27989-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, Jiri Gaisler <jiri@gaisler.se>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Similarly to commit 158b659451 with the APB PnP registers, guests
can crash QEMU when writting to the AHB PnP registers:

  $ echo 'writeb 0xfffff042 69' | qemu-system-sparc -M leon3_generic -S -bios /etc/magic -qtest stdio
  [I 1571938309.932255] OPENED
  [R +0.063474] writeb 0xfffff042 69
  Segmentation fault (core dumped)

  (gdb) bt
  #0  0x0000000000000000 in  ()
  #1  0x0000562999110df4 in memory_region_write_with_attrs_accessor
      (mr=mr@entry=0x56299aa28ea0, addr=66, value=value@entry=0x7fff6abe13b8, size=size@entry=1, shift=<optimized out>, mask=mask@entry=255, attrs=...) at memory.c:503
  #2  0x000056299911095e in access_with_adjusted_size
      (addr=addr@entry=66, value=value@entry=0x7fff6abe13b8, size=size@entry=1, access_size_min=<optimized out>, access_size_max=<optimized out>, access_fn=access_fn@entry=
      0x562999110d70 <memory_region_write_with_attrs_accessor>, mr=0x56299aa28ea0, attrs=...) at memory.c:539
  #3  0x0000562999114fba in memory_region_dispatch_write (mr=mr@entry=0x56299aa28ea0, addr=66, data=<optimized out>, op=<optimized out>, attrs=attrs@entry=...) at memory.c:1482
  #4  0x00005629990c0860 in flatview_write_continue
      (fv=fv@entry=0x56299aa7d8a0, addr=addr@entry=4294963266, attrs=..., ptr=ptr@entry=0x7fff6abe1540, len=len@entry=1, addr1=<optimized out>, l=<optimized out>, mr=0x56299aa28ea0)
      at include/qemu/host-utils.h:164
  #5  0x00005629990c0a76 in flatview_write (fv=0x56299aa7d8a0, addr=4294963266, attrs=..., buf=0x7fff6abe1540, len=1) at exec.c:3165
  #6  0x00005629990c4c1b in address_space_write (as=<optimized out>, addr=<optimized out>, attrs=..., attrs@entry=..., buf=buf@entry=0x7fff6abe1540, len=len@entry=1) at exec.c:3256
  #7  0x000056299910f807 in qtest_process_command (chr=chr@entry=0x5629995ee920 <qtest_chr>, words=words@entry=0x56299acfcfa0) at qtest.c:437

Instead of crashing, log the access as unimplemented.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/misc/grlib_ahb_apb_pnp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/misc/grlib_ahb_apb_pnp.c b/hw/misc/grlib_ahb_apb_pnp.c
index e230e25363..72a8764776 100644
--- a/hw/misc/grlib_ahb_apb_pnp.c
+++ b/hw/misc/grlib_ahb_apb_pnp.c
@@ -136,8 +136,15 @@ static uint64_t grlib_ahb_pnp_read(void *opaque, hwaddr offset, unsigned size)
     return ahb_pnp->regs[offset >> 2];
 }
 
+static void grlib_ahb_pnp_write(void *opaque, hwaddr addr,
+                                uint64_t val, unsigned size)
+{
+    qemu_log_mask(LOG_UNIMP, "%s not implemented\n", __func__);
+}
+
 static const MemoryRegionOps grlib_ahb_pnp_ops = {
     .read       = grlib_ahb_pnp_read,
+    .write      = grlib_ahb_pnp_write,
     .endianness = DEVICE_BIG_ENDIAN,
 };
 
-- 
2.21.1


