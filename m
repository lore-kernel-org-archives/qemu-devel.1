Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F88C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 05:59:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 549E32071A
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 05:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKMdrWXg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 549E32071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdScN-0001iR-Iv
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 01:59:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdSba-0000uc-Vv
 for qemu-devel@nongnu.org; Tue, 26 May 2020 01:58:26 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:35700)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdSba-0006PN-7m
 for qemu-devel@nongnu.org; Tue, 26 May 2020 01:58:26 -0400
Received: by mail-wr1-x441.google.com with SMTP id x14so13770231wrp.2
 for <qemu-devel@nongnu.org>; Mon, 25 May 2020 22:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rxgWqsaxiMy6B4YGC/YTXF3N15jU8g4frTvpAKYBgWQ=;
 b=hKMdrWXgwmtFqyC422/xyzeYJvLkmww6uKsJmrFns5MSVK11NQgbCjxbwOf6NRr+Lf
 JQHQbv0coj8CcSAXk06xosPlqGyjP5cKPNfaSpzTFtQWu19Jsuz55LvpCLPuvK2fPayM
 KzaWPK3NZSwWPQ7Bk5d1VkFUsvjEMwohQ6zRLd042b/vuSh3Fl2upSQOTKdLcR0VFGbw
 I/HNoS2sWUVlgfRTFkFy4grKC8YkirC+EWx/2Sfm5woY/mG5QmN1GEwmCaAlPBKHix9A
 Fd+vebVs5ulfWfCmcnq+/5WDuZ5R7PCA5OLMPSh04HnLVyAbzKf48czEMqKbpKPuFVfh
 su9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=rxgWqsaxiMy6B4YGC/YTXF3N15jU8g4frTvpAKYBgWQ=;
 b=QwJUCsKDwmRTu6HLei7uTTyTmsDbUEyDL0I0a00vMKURZjQ8wQRdob+x82BfaY0hEK
 L3oLi0272SMFOvdg4QbYIlZWLkakeIAc2aQdI8Bac2A5PnGr8O3P/1/uYpHXrwYI8UmA
 l5slvvS+oDoTF877L7UoFSgXl6Q91+ckYkZDh/pWdqoM8Y+9ndCDnFTdr0JiwcPKeMZJ
 xvrIAkwYX/B8oLfalwaomZgBfFhSHDvSQmjvVsflUhgNkCAC94Ps+aoyeJnTi3pxi3s4
 D13TJMZEZb3VoYp8GOKf2lSPmG7zy4gHf/JkLTHn2mm3vYYvdamm7xfk6E/NtgWVxwXG
 odTg==
X-Gm-Message-State: AOAM530HSBJzMAPEn9YZijl5+/9znOUAdxMMb++0swFwLVC6PgwQewaQ
 gUWp43iJgNxRCvsgZkGedgtGzdi+5kM=
X-Google-Smtp-Source: ABdhPJzBX/UihyTemnwXE7hDCVTIvZAoyhHm3GF+NdXxxzAQyBAPLMVFMQJ0Pm67h5pYoGX0VfWoXw==
X-Received: by 2002:a5d:6288:: with SMTP id k8mr3765544wru.94.1590472704674;
 Mon, 25 May 2020 22:58:24 -0700 (PDT)
Received: from localhost.localdomain (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id s8sm19887710wrt.69.2020.05.25.22.58.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2020 22:58:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] tests/qtest/fuzz: Avoid QTest ioport serialization
Date: Tue, 26 May 2020 07:58:19 +0200
Message-Id: <20200526055820.12999-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200526055820.12999-1-f4bug@amsat.org>
References: <20200526055820.12999-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Alexander Bulekov <alxndr@bu.edu>, Bandan Das <bsd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We don't need to serialize over QTest chardev when we can
directly access the globally registered I/O address space.

i440fx-qtest-reboot-fuzz gets 2x performance improvement.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/qtest/fuzz/i440fx_fuzz.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/tests/qtest/fuzz/i440fx_fuzz.c b/tests/qtest/fuzz/i440fx_fuzz.c
index bcd6769b4c..d770caffa7 100644
--- a/tests/qtest/fuzz/i440fx_fuzz.c
+++ b/tests/qtest/fuzz/i440fx_fuzz.c
@@ -20,6 +20,7 @@
 #include "fuzz/qos_fuzz.h"
 #include "fuzz/fork_fuzz.h"
 
+#include "exec/address-spaces.h"
 
 #define I440FX_PCI_HOST_BRIDGE_CFG 0xcf8
 #define I440FX_PCI_HOST_BRIDGE_DATA 0xcfc
@@ -59,22 +60,28 @@ static void ioport_fuzz_qtest(QTestState *s,
                                       I440FX_PCI_HOST_BRIDGE_DATA;
         switch (a.opcode % ACTION_MAX) {
         case WRITEB:
-            qtest_outb(s, addr, (uint8_t)a.value);
+            address_space_write(&address_space_io, addr, MEMTXATTRS_UNSPECIFIED,
+                                &a.value, sizeof(uint8_t));
             break;
         case WRITEW:
-            qtest_outw(s, addr, (uint16_t)a.value);
+            address_space_write(&address_space_io, addr, MEMTXATTRS_UNSPECIFIED,
+                                &a.value, sizeof(uint16_t));
             break;
         case WRITEL:
-            qtest_outl(s, addr, (uint32_t)a.value);
+            address_space_write(&address_space_io, addr, MEMTXATTRS_UNSPECIFIED,
+                                &a.value, sizeof(uint32_t));
             break;
         case READB:
-            qtest_inb(s, addr);
+            address_space_read(&address_space_io, addr, MEMTXATTRS_UNSPECIFIED,
+                               &a.value, sizeof(uint8_t));
             break;
         case READW:
-            qtest_inw(s, addr);
+            address_space_read(&address_space_io, addr, MEMTXATTRS_UNSPECIFIED,
+                               &a.value, sizeof(uint16_t));
             break;
         case READL:
-            qtest_inl(s, addr);
+            address_space_read(&address_space_io, addr, MEMTXATTRS_UNSPECIFIED,
+                               &a.value, sizeof(uint32_t));
             break;
         }
         /* Move to the next operation */
-- 
2.21.3


