Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D93C32792
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 22:58:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BC4C2133F
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 22:58:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BC4C2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGA3N-00050m-M0
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 18:58:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40653)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iG9zv-0003Uj-R0
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 18:55:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iG9zu-0007hp-I1
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 18:54:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41852)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iG9zu-0007f2-CB
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 18:54:58 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 89D0210DCC95;
 Thu,  3 Oct 2019 22:54:57 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-21.brq.redhat.com [10.40.204.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F2856600C4;
 Thu,  3 Oct 2019 22:54:53 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/7] tests/libqos/fw_cfg: Document io_fw_cfg_init to drop
 io_fw_cfg_uninit
Date: Fri,  4 Oct 2019 00:54:31 +0200
Message-Id: <20191003225437.16651-2-philmd@redhat.com>
In-Reply-To: <20191003225437.16651-1-philmd@redhat.com>
References: <20191003225437.16651-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.64]); Thu, 03 Oct 2019 22:54:57 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Li Qiang <liq3ea@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Document io_fw_cfg_init() return value must be released
with g_free(). Directly calling g_free() we don't really
need io_fw_cfg_uninit(): remove it.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/libqos/fw_cfg.c |  5 -----
 tests/libqos/fw_cfg.h | 11 +++++++++--
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/tests/libqos/fw_cfg.c b/tests/libqos/fw_cfg.c
index 1f46258f96..37c3f2cf4d 100644
--- a/tests/libqos/fw_cfg.c
+++ b/tests/libqos/fw_cfg.c
@@ -157,8 +157,3 @@ QFWCFG *io_fw_cfg_init(QTestState *qts, uint16_t base=
)
=20
     return fw_cfg;
 }
-
-void io_fw_cfg_uninit(QFWCFG *fw_cfg)
-{
-    g_free(fw_cfg);
-}
diff --git a/tests/libqos/fw_cfg.h b/tests/libqos/fw_cfg.h
index 13325cc4ff..15604040bd 100644
--- a/tests/libqos/fw_cfg.h
+++ b/tests/libqos/fw_cfg.h
@@ -36,8 +36,15 @@ size_t qfw_cfg_get_file(QFWCFG *fw_cfg, const char *fi=
lename,
=20
 QFWCFG *mm_fw_cfg_init(QTestState *qts, uint64_t base);
 void mm_fw_cfg_uninit(QFWCFG *fw_cfg);
+/**
+ * io_fw_cfg_init():
+ * @qts: The #QTestState that will be referred to by the QFWCFG object.
+ * @base: The I/O address of the fw_cfg device in the guest.
+ *
+ * Returns a newly allocated QFWCFG object which must be released
+ * with a call to g_free() when no longer required.
+ */
 QFWCFG *io_fw_cfg_init(QTestState *qts, uint16_t base);
-void io_fw_cfg_uninit(QFWCFG *fw_cfg);
=20
 static inline QFWCFG *pc_fw_cfg_init(QTestState *qts)
 {
@@ -46,7 +53,7 @@ static inline QFWCFG *pc_fw_cfg_init(QTestState *qts)
=20
 static inline void pc_fw_cfg_uninit(QFWCFG *fw_cfg)
 {
-    io_fw_cfg_uninit(fw_cfg);
+    g_free(fw_cfg);
 }
=20
 #endif
--=20
2.20.1


