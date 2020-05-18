Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D2EEC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 15:57:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC15620758
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 15:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOBfw97b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC15620758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jai9J-0003eF-Ka
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 11:57:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52616)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jai4r-00037m-Ho; Mon, 18 May 2020 11:53:17 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37537)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jai4q-00005l-O8; Mon, 18 May 2020 11:53:17 -0400
Received: by mail-wm1-x342.google.com with SMTP id z72so32918wmc.2;
 Mon, 18 May 2020 08:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YgUO7urc8a2H2l0AjA6/YcXX+FHCC3nhZ10cz3IJGT0=;
 b=IOBfw97bri/HK4rNN8hBH3fS/bLjGzm8A0H/8IkZ8BNpXTH5MWOLMb3YVIeMZKbemA
 3ANvreACUxm3uKFDJZEe4MA+7GDtRxgdRAvLMjOBMc7JlM5setDqR+rAAjGrhOViOGZF
 2Wqfu4cYar/pwmzsrnDNSa2HYymGPUjbGygmgHP6rSFAaV7KZ4Aj7Zf8fLfG4mjSdzoj
 O0xMbKFIM8aKXXnAyWz+2OWRz7ivmrJrmm2ilOqTEom06SGkiN9a0F3K1QeVvnWoTdEt
 L9ra6YC/35hRflgOsBpof5I6H7BbRnEo+uNLoC00Y9tDyfK0lemm9ge5tj8eq1k8Vg70
 hyyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=YgUO7urc8a2H2l0AjA6/YcXX+FHCC3nhZ10cz3IJGT0=;
 b=UzYfulLDKakKYiCKJDekG3GwUxyRJTRwUIsxadnAnl5wETx+j2LbnJ31pdSS8YCog4
 AkVSOst2BQYsLGKHk8O1Dc2IDHPedYGsveoABrnOEzqthETAqWTKSxtuenoW4HZD1K0/
 GXuCII8KiWI4axtw2zhJgp0DGgGew/0+Z/iQeJyuZV1OcYZoo8Od3iSHAPXLFHVCPIRD
 RugRDY3lcze75ZAp7+DdwY0pcfJjJKyoK0f5XQ2dnBXBoG4sy3ulOq6ShhvRMqPnuV0G
 Iu2Ii804OZRQ8GeioKY/Hn9wCm1AmVLTtGZeSGOVw1KPx/ustNkZhQiU+6LYXqWnV8bj
 cCNQ==
X-Gm-Message-State: AOAM53088fCRomxqjHHrq2pL0OxUDNzIAp7xZBCbbFGtQewC1nU2QYiH
 MhH+Vo52aB6ncJ4Se3QqjUqLF8YDSYA=
X-Google-Smtp-Source: ABdhPJyG3gmRwNj2wCtQakz1KaSpc4CoE3n4quosHaeNbq9NCRoNUZ4NxGqjRfI4JksaALSu8mA24w==
X-Received: by 2002:a1c:4cb:: with SMTP id 194mr42967wme.124.1589817194856;
 Mon, 18 May 2020 08:53:14 -0700 (PDT)
Received: from x1w.redhat.com (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id 7sm17647462wra.50.2020.05.18.08.53.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 08:53:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/7] hw/elf_ops: Do not ignore write failures when loading
 ELF
Date: Mon, 18 May 2020 17:53:05 +0200
Message-Id: <20200518155308.15851-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200518155308.15851-1-f4bug@amsat.org>
References: <20200518155308.15851-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Do not ignore the MemTxResult error type returned by
address_space_write().

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/elf_ops.h | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h
index 398a4a2c85..6fdff3dced 100644
--- a/include/hw/elf_ops.h
+++ b/include/hw/elf_ops.h
@@ -553,9 +553,14 @@ static int glue(load_elf, SZ)(const char *name, int fd,
                     rom_add_elf_program(label, mapped_file, data, file_size,
                                         mem_size, addr, as);
                 } else {
-                    address_space_write(as ? as : &address_space_memory,
-                                        addr, MEMTXATTRS_UNSPECIFIED,
-                                        data, file_size);
+                    MemTxResult res;
+
+                    res = address_space_write(as ? as : &address_space_memory,
+                                              addr, MEMTXATTRS_UNSPECIFIED,
+                                              data, file_size);
+                    if (res != MEMTX_OK) {
+                        goto fail;
+                    }
                 }
             }
 
-- 
2.21.3


