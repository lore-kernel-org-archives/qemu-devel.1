Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83CA7C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:10:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54169206A5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:10:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54169206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVZvA-0002Xu-Gu
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 08:10:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52062)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVZjt-000393-37; Mon, 04 May 2020 07:58:25 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:38807)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVZjp-00027i-02; Mon, 04 May 2020 07:58:24 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mn1mb-1ipg1502hr-00kARR; Mon, 04 May 2020 13:58:12 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 08/20] elf_ops: Don't try to g_mapped_file_unref(NULL)
Date: Mon,  4 May 2020 13:57:46 +0200
Message-Id: <20200504115758.283914-9-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504115758.283914-1-laurent@vivier.eu>
References: <20200504115758.283914-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:BQ5r9yph8+G/Az6IX8fW6EIIjsM+kUd3mF51aPquBfwZdBe78HQ
 eJny12BmQEzKP8RuUE9iCi84G9lQkzH84XG1tI0BSjC4quvIP1FWMvd5pHl8s1dMCMQcmMq
 HQ/ZxSNvlyXyh1WBdViEbgdbjsSe4iTbQPZQC/nZ0qrsH/WQ5FI3bVxbct72uEReOO+FK2o
 8PG5uPIteltoGpTuG3VQQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XJXUFm27smw=:7Iahaa0JmqSlE5YatvC0bp
 6dutlD/QcvXKvsQesDZwrOqnOx2bgnQgs2kE2tjaUEt4pqrUr4hhvfv39aviY2DJIIe9CAJ4W
 4dLdNRocSko0IUkiOFLyNLZ+f7EmktNNPRAoAlaoMIQ4vXqRWpuY2bgyW7C0qIkffQvK8r4HF
 Sz5f1OP1QfMbrnoiLprwcRt1bnbr4E+uTJMYxTKDkRMn0FFgLIaN5PQzMmYxfoLmZuvxEoX+L
 vEhOHJiJMZOZ/rbzEMZN++Nz03/jO8Xvhre069TkTwfOCAPI3+YKpKiAitq0ict5J3+jYHqJE
 YoH1O78NYE6fBnw98wvxqpDgmEJ2tRrqrMZCYeCueOw5CZu82fhPBZctFOb16ajAGfwqsHqq/
 RXF5HOF9c8OuZuTbzeYZeZTBSsFPdzQFHe2roUdntS30VfNcRxEVfKBCFlH1/pAhtUNtRnR9/
 JqSSzlEHhYYS3A/mKOXqibmtBvjWdvs72zdgVDClXvDizo5nCnZ3x8b37wTWUSGnfyyHXZKkt
 02mF77bMEosg/WCYQfxqB2P+VF3dSktHaWPNvo1qxqTICMevNLvo0wiuwS9yZhB7hDeDh1apY
 Q9HY/6dKQZyAGC0kNRm4Qfh/H57BxpKXm97/0gPFLqhf0/ODnTxQiEv4uibzfd4WcZaszuPV4
 AAFFoWLzyHdQlLrC6oheP5UU7AwyBWQYZHkhQOS3ZLnoHkV59Rf1/f3IFn6c1Cew+9sOuZOch
 kLc9mRWuqphz92qXxtNVPe7uFKs4K16kkCjR+pOQojIVp1RqaZlAirT3gBMEJ9bXvijOxagSP
 lBRiOWlL2GF4INTR0VwQJjJAA0JU0c+GxMxvJS/N+pLw4C45JMpac3WpyjunCJTPIuvCMUF
Received-SPF: none client-ip=212.227.17.13; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 07:58:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 Randy Yates <yates@ieee.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Maydell <peter.maydell@linaro.org>

Calling g_mapped_file_unref() on a NULL pointer is not valid, and
glib will assert if you try it.

$ qemu-system-arm -M virt -display none -device loader,file=/tmp/bad.elf
qemu-system-arm: -device loader,file=/tmp/bad.elf: GLib: g_mapped_file_unref: assertion 'file != NULL' failed

(One way to produce an ELF file that fails like this is to copy just
the first 16 bytes of a valid ELF file; this is sufficient to fool
the code in load_elf_ram_sym() into thinking it's an ELF file and
calling load_elf32() or load_elf64().)

The failure-exit path in load_elf can be reached from various points
in execution, and for some of those we haven't yet called
g_mapped_file_new_from_fd().  Add a condition to the unref call so we
only call it if we successfully created the GMappedFile to start with.

This will fix the assertion; for the specific case of the generic
loader it will then fall back from "guess this is an ELF file" to
"maybe it's a uImage or a hex file" and eventually to "just load as
a raw data file".

Reported-by: Randy Yates <yates@ieee.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20200423202011.32686-1-peter.maydell@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 include/hw/elf_ops.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h
index e0bb47bb678d..398a4a2c85bb 100644
--- a/include/hw/elf_ops.h
+++ b/include/hw/elf_ops.h
@@ -606,7 +606,9 @@ static int glue(load_elf, SZ)(const char *name, int fd,
         *highaddr = (uint64_t)(elf_sword)high;
     ret = total_size;
  fail:
-    g_mapped_file_unref(mapped_file);
+    if (mapped_file) {
+        g_mapped_file_unref(mapped_file);
+    }
     g_free(phdr);
     return ret;
 }
-- 
2.26.2


