Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6279C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 03:34:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F8ED20684
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 03:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bebb0N/5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F8ED20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jseN1-0007xF-MT
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 23:34:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39436)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jseMO-0007YJ-OJ
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 23:33:32 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43043)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jseMN-0004fc-2g
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 23:33:32 -0400
Received: by mail-wr1-x443.google.com with SMTP id j4so41165798wrp.10
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2020 20:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CgMS82F6/ZBgUqSCKkrXcEsAwxJsTPJ08qpLjwRHWho=;
 b=bebb0N/5UsIJZK+cQjvAzCo1Dft6CObMF1STGa1gkXSSX2us6C4F1w4AQKV+j4NU9e
 AXDbHddsCsnf7bRpRn3kD57tOYjqHgE/nLmLIuLxodUCF5QIHIdz2tKISEkTmfqUkjYh
 8SnG5ch3dofzAIWLAXg2U1kTtWozM8D9kX3nxIpF/5/MaC4l894JQNdwXX7rnNCrfyC1
 pwWYWLSaSKzTHX7LyhMsrKU9x4BqVZhJdlXL4oEwr5O4kFiaVVKYPXEJmdHJkycSlXHO
 u+VN876ZytNPT3V1x0tJftaIai0Yqzn9DZoa4GyY2FsDq0KIRl8cyTjm0OE/HUgBzbdj
 ZplQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=CgMS82F6/ZBgUqSCKkrXcEsAwxJsTPJ08qpLjwRHWho=;
 b=P0PmnNc6p6gSgpZpQZXNS6SO3Z/zVSk/y3Jqij7aMLn83AhnEipk/VJLkamauVWTLA
 jSSa98BLuXYw5pD/d6wjORByiTsaEhxUAXoB71XsqrVpF/twG2cRPZe5Dn6ADDA0RIKv
 8kl3cJ+DRnZbwVYy6tneyDDP7KBZI3kHdn+IVcHWI2rE2sI1XNCN/2Otynd2AcNdLWPE
 nMBHQtDCiAoZ110HXLWxVlx899xvdmxlFl56uHC+uvjj8pTPnQz3lvpufsAdKeuNgxeh
 0z3pksVxyaD+SexZ85IDMgpWgSxvEwDAlJJIvZxZV94IH5OHN0Wvoui023lIbc2uwtwH
 1X4g==
X-Gm-Message-State: AOAM533z0Drp4hL/BlsXx86jrDEZoRZLrnAeKQMa8rZ6EifXwXmlSLLe
 Oe9RP4LagmSlvqbiTyXzuAuU3ejR
X-Google-Smtp-Source: ABdhPJxiI5pZFJRHoEF4XG2ESxOhdgOIrxJtG9uxNcwDlgj0/j7ictJnsJWBAKhs1uulIc5GBbBqEQ==
X-Received: by 2002:a5d:5270:: with SMTP id l16mr51344261wrc.122.1594092808780; 
 Mon, 06 Jul 2020 20:33:28 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id v18sm27810231wrv.49.2020.07.06.20.33.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2020 20:33:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3] hw/core/qdev: Increase qdev_realize() kindness
Date: Tue,  7 Jul 2020 05:33:26 +0200
Message-Id: <20200707033326.19178-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since commit 510ef98dca5, qdev_realize() aborts if bus-less device
is realized on a bus. While commits 514db7710b..007d1dbf72 took
care of converting all mainstream uses, QEMU forks weren't. These
forks are usually maintained by hobbyist with interest in following
mainstream development, but with limited time, so usually rebase
from time to time. To avoid them to spend time on debugging and
reading git-log history, display a kind hint about what is wrong.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Since v2:
- scratch __func__ (armbru)
- reword to justify this is not an impossible case (armbru)
---
 hw/core/qdev.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 2131c7f951..a16f1270f1 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -392,8 +392,11 @@ bool qdev_realize(DeviceState *dev, BusState *bus, Error **errp)
 
     if (bus) {
         qdev_set_parent_bus(dev, bus);
-    } else {
-        assert(!DEVICE_GET_CLASS(dev)->bus_type);
+    } else if (DEVICE_GET_CLASS(dev)->bus_type) {
+        error_setg(errp, "Unexpected bus '%s' for bus-less device '%s'",
+                   DEVICE_GET_CLASS(dev)->bus_type,
+                   object_get_typename(OBJECT(dev)));
+        return false;
     }
 
     object_property_set_bool(OBJECT(dev), true, "realized", &err);
-- 
2.21.3


