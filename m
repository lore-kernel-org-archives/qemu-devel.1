Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 754BDECE58C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 15:22:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B1652053B
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 15:22:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B1652053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHUqF-0004Yf-A7
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 11:22:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47397)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iHUnk-0002rF-AN
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 11:19:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iHUni-0008I7-BY
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 11:19:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34612)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iHUni-0008FV-49
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 11:19:54 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4E7BE30ADBBF;
 Mon,  7 Oct 2019 15:19:52 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.206.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 10F2719D70;
 Mon,  7 Oct 2019 15:19:25 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/7] tests/libqos/fw_cfg: Document mm_fw_cfg_init to drop
 mm_fw_cfg_uninit
Date: Mon,  7 Oct 2019 17:19:00 +0200
Message-Id: <20191007151905.32766-3-philmd@redhat.com>
In-Reply-To: <20191007151905.32766-1-philmd@redhat.com>
References: <20191007151905.32766-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Mon, 07 Oct 2019 15:19:52 +0000 (UTC)
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
 Laszlo Ersek <lersek@redhat.com>, Li Qiang <liq3ea@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Document mm_fw_cfg_init() return value must be released
with g_free(). mm_fw_cfg_uninit() was never used, remove it.

This partly reverts commit 0729d833d6d6:
"tests/libqos: Add mm_fw_cfg_uninit()"

Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/libqos/fw_cfg.c |  5 -----
 tests/libqos/fw_cfg.h | 10 +++++++++-
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/tests/libqos/fw_cfg.c b/tests/libqos/fw_cfg.c
index 37c3f2cf4d..ddeec821db 100644
--- a/tests/libqos/fw_cfg.c
+++ b/tests/libqos/fw_cfg.c
@@ -126,11 +126,6 @@ QFWCFG *mm_fw_cfg_init(QTestState *qts, uint64_t bas=
e)
     return fw_cfg;
 }
=20
-void mm_fw_cfg_uninit(QFWCFG *fw_cfg)
-{
-    g_free(fw_cfg);
-}
-
 static void io_fw_cfg_select(QFWCFG *fw_cfg, uint16_t key)
 {
     qtest_outw(fw_cfg->qts, fw_cfg->base, key);
diff --git a/tests/libqos/fw_cfg.h b/tests/libqos/fw_cfg.h
index 15604040bd..3247fd4000 100644
--- a/tests/libqos/fw_cfg.h
+++ b/tests/libqos/fw_cfg.h
@@ -34,8 +34,16 @@ uint64_t qfw_cfg_get_u64(QFWCFG *fw_cfg, uint16_t key)=
;
 size_t qfw_cfg_get_file(QFWCFG *fw_cfg, const char *filename,
                         void *data, size_t buflen);
=20
+/**
+ * mm_fw_cfg_init():
+ * @qts: The #QTestState that will be referred to by the QFWCFG object.
+ * @base: The MMIO base address of the fw_cfg device in the guest.
+ *
+ * Returns a newly allocated QFWCFG object which must be released
+ * with a call to g_free() when no longer required.
+ */
 QFWCFG *mm_fw_cfg_init(QTestState *qts, uint64_t base);
-void mm_fw_cfg_uninit(QFWCFG *fw_cfg);
+
 /**
  * io_fw_cfg_init():
  * @qts: The #QTestState that will be referred to by the QFWCFG object.
--=20
2.21.0


