Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4877EC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 20:07:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22407206B6
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 20:07:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22407206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsXOc-0003Ga-Ac
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 16:07:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45686)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jsXNe-0001c3-OV
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 16:06:22 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:53427)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jsXNc-0004sq-Dy
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 16:06:22 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MsI4Q-1kkvVm0EIs-00thKT; Mon, 06 Jul 2020 22:06:04 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 1/3] target/m68k: fix physical address translation in
 m68k_cpu_get_phys_page_debug()
Date: Mon,  6 Jul 2020 22:05:57 +0200
Message-Id: <20200706200559.160209-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200706200559.160209-1-laurent@vivier.eu>
References: <20200706200559.160209-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:cKeJsdyi0MwlEnEzFBeJKdeh6bhOx7DNo8NUVe7tPVWhxaXPVAA
 ZOpevYKNDAItU8uOSKc1+bJFv9Le75ay0Y8auuSja9+HWjBxEbNdGpEgFXRUO7Rcg7n4LNa
 5PswsWwcxFFYT00hf0cfPgJhmkQmW4HbnxQNKt6glGvkGxmZpiCIcMuC8XJbbaJXYBCuuVu
 IPajnI6sTjsjEwlEU6PGQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cNZt1kfyLoo=:JFZLyMm/iFn47s+QxZKSHw
 BgFmGNZHgXUqQg4WEJ0T/ZE6ydeWlo+cAC4/vQcWGw6Cf5gu5ghTxoD2TJVjWyL53DrP/ikmJ
 0K0obObZE5uF2idT58f3bM1Q59WvWYcU3a2iB7UvChBWIEc5T/j6v70YVDRQ+5EEKN5tCsxmC
 vGmZARYugVhDSrqdBWEF+CS4VHrNL5FehFhe9XEZQMLCPR6yyDzv5oQFAPNDn9xZqwdr9Dal4
 7g3ABCGb1zXrzk7vF3kz3ipIkaC0Y0Fkc6U8gIzel9UVptwOXZttqrdtfTZAgudDniQmsC7iG
 Y+HmbB49XUV482y1DlUtgEuLXyKcc6YspMDQhAEVEq9ffQEme5AhctXt5Dv/aufygjSLuB3dP
 OZoT81Pz+64ciyFf7GAdfyEPg+FQqaNfrOK7l2Bo8GKvn+1fVqZ8ttYr9KZKVcmCh8ZRXWAXB
 wm5kcD32uMHDDP40D4YSDrQPAkwajd3VR6tJ23X0jpY2+jXWkMjuAer4Br2r/oGgHMzV1dkX4
 lg+zuQxfkPLbiMKVhGwmE6O2Np1nekvRunnjOdc9ju9bk0tSONkDH3SksatX8Q20ZQxZaiWHP
 99/LItbrtHKiwy8U0pXhzzzrsnxLpmrD/EcvsMObW9P669pOacrQq+7dwd9iYZPSIOhMDRnWb
 t6joT6kB0Gqv05IrkgH0EjsXMPKZzIWcV4/eLMGMh3M8blkpm5AhmdKk6fak2Bit674NEXOeb
 5ykwHYE/YVTuWPRr7WW8hMmnW1Wo4Siz0Rwmt8zh5+Xo2Pa5Ag0A8HjOM3+pI1QWUcJKO42Oe
 JsOYio7jn+IyRMMtGqZCkLSyAnhMREkMZlIqgKxkGfMpKuzZNL8acBo9MtMB3FvP+Ao/c34
Received-SPF: none client-ip=212.227.126.133; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 15:30:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

The result of the get_physical_address() function should be combined with the
offset of the original page access before being returned. Otherwise the
m68k_cpu_get_phys_page_debug() function can round to the wrong page causing
incorrect lookups in gdbstub and various "Disassembler disagrees with
translator over instruction decoding" warnings to appear at translation time.

Fixes: 88b2fef6c3 ("target/m68k: add MC68040 MMU")
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200701201531.13828-2-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/helper.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 79b0b10ea9bc..631eab777494 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -820,10 +820,14 @@ hwaddr m68k_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
     if (env->sr & SR_S) {
         access_type |= ACCESS_SUPER;
     }
+
     if (get_physical_address(env, &phys_addr, &prot,
                              addr, access_type, &page_size) != 0) {
         return -1;
     }
+
+    addr &= TARGET_PAGE_MASK;
+    phys_addr += addr & (page_size - 1);
     return phys_addr;
 }
 
-- 
2.26.2


