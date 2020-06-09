Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313EDC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 07:43:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDE852074B
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 07:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cuT6QXJW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDE852074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiYur-00043i-VB
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 03:43:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40350)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiYkL-0004CO-MT
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 03:32:33 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33142)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiYkK-0007XZ-7d
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 03:32:33 -0400
Received: by mail-wr1-x444.google.com with SMTP id l11so20081208wru.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 00:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=b/OykygRwVllcM0LU21qFqXRkh6UcxIdIvocNlUkuAY=;
 b=cuT6QXJW/6joXiohF2Sw6YX+QAfTtElydWkOJSe1a/S2X8hjxzSdsbNXxAWMxC1KTl
 jWXBHz9u55n/yvvlD0mT+bm9eN2JR71GUXLksjcCoUFCsmWo7TtUEH0DqqyelWPJ+T41
 3bR7zIjYgXYdCDTQgsVkvF5ZuycHSo6gpDADq04MvCGulyD1sEnFFNxgfkDH0JHoIRNC
 A3zmc9LHNvFaoiw3peXeElX527jLFkewOTr5QUdMKEvAfjSLjNshpcpSAoIzHepyKtcF
 BpHoI+xYbJfMszMITcNXX88nhUXdMFJ/PoB/wWAryWhxno3xoyqDSomg/VCLNoPcFm8f
 ce+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=b/OykygRwVllcM0LU21qFqXRkh6UcxIdIvocNlUkuAY=;
 b=QFgpV1QzxxnQzIXDFKIH/JHr9SfoenMBziPEDKbr8FT5TxsQs5jdPYsjbr9k6VxMn8
 gWL02KZFhiW+Ef7ZseSjQMx2D7OypcNsSoCOO7zdyaZ94qGQkqNWiY063G6z4PcrjinZ
 jjypEKUJgBRHs7LE77+IDJY0EyqjL+Xn06sTQdXfC+CGXJh80xeDdWkj5cCZkkBA0cg0
 OcZe7ZY973PIGg4AKXG12gsrz1upW5rdgGuK8pWtvJvV174XqqKDomjCx7IuxWA1qsWI
 I+rJrIKI0EBZus+viB442fKerHRH2D4UcUi2odBm0ylE3zVHBZgSTywgFU2LNdoryMAQ
 5aZg==
X-Gm-Message-State: AOAM531tigauV7EGgXOZ5vu+jVx1dO05K4lE/TUsQoUltjPea/UHiyeI
 Km8ue4omRz+wOUUXkPxB0tYNS7Yu
X-Google-Smtp-Source: ABdhPJz2cRcrqVNjGsSLegGPr13tfJFLf3miJ2jXbQu05nDiTP8R0wqltM1RlLLphxiyPglltSrxmw==
X-Received: by 2002:adf:a350:: with SMTP id d16mr2977293wrb.237.1591687949040; 
 Tue, 09 Jun 2020 00:32:29 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id m3sm2036192wmc.0.2020.06.09.00.32.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 00:32:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/16] hw/misc/grlib_ahb_apb_pnp: Avoid crash when writing to
 AHB PnP registers
Date: Tue,  9 Jun 2020 09:32:09 +0200
Message-Id: <20200609073214.14079-12-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200609073214.14079-1-f4bug@amsat.org>
References: <20200609073214.14079-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Fabien Chouteau <chouteau@adacore.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
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
Reviewed-by: KONRAD Frederic <frederic.konrad@adacore.com>
Message-Id: <20200331105048.27989-3-f4bug@amsat.org>
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
2.21.3


