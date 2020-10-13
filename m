Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA3EAC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 12:00:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BBE42080A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 12:00:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BBE42080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSIyh-0002ta-Rv
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 08:00:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kSIpo-0007LP-9m; Tue, 13 Oct 2020 07:51:16 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:51517)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kSIpm-0004zI-DI; Tue, 13 Oct 2020 07:51:15 -0400
Received: from localhost.localdomain ([82.252.141.186]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N2VGj-1kKqov0bQF-013x3w; Tue, 13 Oct 2020 13:51:06 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 10/14] hw/char/serial: remove duplicate .class_init in
 serial_mm_info
Date: Tue, 13 Oct 2020 13:50:48 +0200
Message-Id: <20201013115052.133355-11-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201013115052.133355-1-laurent@vivier.eu>
References: <20201013115052.133355-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:5FL95lIOaUdUVeJ/UgbW/JQPtJW7Sj/OTa7qlfwgysXFgcpgzCV
 sUz+6gRgtb/im66JZbG0taCz+gd5JO8f/757mjPztHwiAQwDyQclNAW/b6AQW78LrJZrPVA
 6DawVse6I9NkmeU1gOEwpY91MZA0Zi5FGHaiGH5uuq2cQPSHb5C6Sp3DI/YGvbPSKqlxdKR
 FR1aCAsyu+uFiEbh2wm5Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hsi4yUhukoY=:0LOZoTJFFY7u/O1vfHZzhM
 rvlai5KTDbmHhkIGxzdeoEx4SjYFU+/0+nPmjRWPh1t/QstLq4amwa1yeqzk9t0H6+EjgBW1s
 IrWF2Ek7GUqDmPJ+EAcVm2k+KNVqOlOLU1RpxQY5krQmsKAyvoPQ8UTYmf/CDSpAjIeeeOEdo
 35OwCdcwgGrFGfCH2z1PoUUL5WILKhnkLlv+JOuyR8ngedhRDkc7FfX0z8c2MiLAvM72ByRux
 GNPFs6S3Bx5iRE9aLV2viNtpGwSg4IF7O6Ln5TOrMukGWpF3fsYxLzhlDd6/bmS+LK0gtXcFQ
 Xyb4A4nROwrpIDsoEQzPIuFl0RnPQX5crwQc5z9X8SuZMroj2SAn4nc9NTNMmwM1mn22pJEHH
 GOkNvFf554/Vt/SppPD0Dpqxy8N9/JcH7s17kLCfBYPBUoBbsjTXaxk7FVbNT
Received-SPF: none client-ip=212.227.17.24; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 07:51:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Li Qiang <liq3ea@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Alistair Francis <alistair.francis@wdc.com>, marcandre.lureau@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Laurent Vivier <lvivier@redhat.com>

.class_init is already set to serial_mm_class_init.

Remove the duplicate entry.

Fixes: 17fd1a6490b1 ("serial-mm: add "regshift" property")
Cc: marcandre.lureau@redhat.com
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20201009113843.60995-1-lvivier@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/char/serial.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index 4386adabd466..97f71879ff2a 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -1120,7 +1120,6 @@ static const TypeInfo serial_mm_info = {
     .class_init = serial_mm_class_init,
     .instance_init = serial_mm_instance_init,
     .instance_size = sizeof(SerialMM),
-    .class_init = serial_mm_class_init,
 };
 
 static void serial_register_types(void)
-- 
2.26.2


