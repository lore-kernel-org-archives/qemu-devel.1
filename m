Return-Path: <SRS0=xv8e=AB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E662CC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 15:40:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE199221F7
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 15:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n67Bf4dc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE199221F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmfbZ-0004Nk-UX
	for qemu-devel@archiver.kernel.org; Sat, 20 Jun 2020 11:40:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36354)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jmfZt-0002hX-6W
 for qemu-devel@nongnu.org; Sat, 20 Jun 2020 11:38:45 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45907)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jmfZq-0005zC-Dv
 for qemu-devel@nongnu.org; Sat, 20 Jun 2020 11:38:44 -0400
Received: by mail-wr1-x442.google.com with SMTP id c3so12376262wru.12
 for <qemu-devel@nongnu.org>; Sat, 20 Jun 2020 08:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Zn+iIpXpdwJ6WSGdxt8VQvwtltggvLu0E5NwS3wf3MA=;
 b=n67Bf4dcqmcLn/GpWf120kXsYvpI2i+cGDuwnL8a169PZ6kctm8Z8mzECMkrWuBGgr
 LqC+/S5BBz6sNcNA/ZIVfm9bUDHkwJ/HlZzIwvlKuZdyG1qKcr/Mo3fLSLHC4bbgM9CO
 i4mQIxbZS6gITeai5FDsTP03J8U6rjRUzfFweePBahG7RFOUbOQ7XbdfG1L9YKOcPgOu
 Q++U0MzZI5QdW9c5C7JEeiJR41xcPAEv9nFGK9i4PKnsNteGY1DQcihP2PR62KeyJKQR
 ts1HS3JbSZbFf0LvJegUxVlX3Fr7kMvayQb7f+QnKle1eBFkLDDE/Q1/uZcXhNfTbGaE
 NuWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=Zn+iIpXpdwJ6WSGdxt8VQvwtltggvLu0E5NwS3wf3MA=;
 b=hnzMMCmEALDMscWQ4vCVRwedFPQisRxhUDCn1hjwdXWds/yexr5s6AwVZl5lFYmnRi
 LmXjDcqQUbd/BkQcKtWifSpbr78DIRXe6Y47YMbFyxdxqe6tvWLlQ0BpQwFUTaBGlZwb
 qKiuMRewtmKkt0wimGQwfEN5ercx4VTdbc3BUIzveV4WRNriv9Fm3Xvzomnws0Tm/odw
 LmdYOy6jLVqVmdE5s5NX7JbQo0lAqskwoI0uj7T1OP4XyIGSmoUpbFjc/QcVNbKQmAvf
 M9rOaoFhujhrBWuMpv7jBhOdsTJwXA6f9mEOyvPlNUA9y2k1fo3AumeBKk7/Em7yM69J
 Ec3A==
X-Gm-Message-State: AOAM5315CD3dw9WerTSoeY148NOLfHKyYv8BLY0jpBkNpykhN9v6KBHh
 oY7qt1nkttL8PGPMsgpky7dlTvES
X-Google-Smtp-Source: ABdhPJx+Db8SMjtAoN1YB0tpHu0cx+WWKYihCV99RQ6t1v/H20yA/4TIC2KAHF1sMT1hAWKUA4R4dw==
X-Received: by 2002:adf:e604:: with SMTP id p4mr9444250wrm.212.1592667519412; 
 Sat, 20 Jun 2020 08:38:39 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id l17sm8659514wmh.14.2020.06.20.08.38.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jun 2020 08:38:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Subject: [PATCH] hw/core/qdev: Increase qdev_realize() kindness
Date: Sat, 20 Jun 2020 17:38:37 +0200
Message-Id: <20200620153837.14222-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since commit 510ef98dca5, qdev_realize() aborts if bus-less
device is realized on a bus. Be kind with the developer by
displaying a hint about what is wrong.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/core/qdev.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 2131c7f951..dd3c90d37a 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -392,8 +392,11 @@ bool qdev_realize(DeviceState *dev, BusState *bus, Error **errp)
 
     if (bus) {
         qdev_set_parent_bus(dev, bus);
-    } else {
-        assert(!DEVICE_GET_CLASS(dev)->bus_type);
+    } else if (DEVICE_GET_CLASS(dev)->bus_type) {
+        error_report("%s: Unexpected bus '%s' for device '%s'",
+                     __func__, DEVICE_GET_CLASS(dev)->bus_type,
+                     object_get_typename(OBJECT(dev)));
+        abort();
     }
 
     object_property_set_bool(OBJECT(dev), true, "realized", &err);
-- 
2.21.3


