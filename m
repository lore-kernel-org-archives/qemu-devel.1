Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3DD5C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 08:49:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE6BA206D7
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 08:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c73G7AIf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE6BA206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVWn0-0007JJ-R7
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 04:49:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42652)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVWk2-0003sc-DP; Mon, 04 May 2020 04:46:22 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:33379)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVWk0-00057F-W7; Mon, 04 May 2020 04:46:22 -0400
Received: by mail-wr1-x42a.google.com with SMTP id h9so9569838wrt.0;
 Mon, 04 May 2020 01:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SkzVF0IAQenJ+vuaRxVd2feGaJRdUO/UKBkIdIBtTMo=;
 b=c73G7AIf02xEPxib1pJs4u5FUlo9ab0wnzH783TUYR6omj+qer5h7DRzhPiS7xNIKw
 Im7+DM3Zv9AJkXLvJjETkQuX4LCfj9uZmD2+T5q8w5Jsc3uUGZzxyp8vMmMkC0h/QroI
 6ew83yYKDYqYBh4O5rERY36jLAGiJlsIeXsKq6HgB0U2i2oZVDHPs88cLzaKICLXonv8
 TY5dDIDavYUegz1i/IdWQ4uIXeglAfUUp4L9xu5llC+22n28sbuOdVxE2GI7GcVp6PYh
 +khClOdo55ZtczhuV+McfSyZpVzm68eniJjXMHhJK+ei8bu1NYU3BWhYQgZGPRdNeG+p
 OU/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=SkzVF0IAQenJ+vuaRxVd2feGaJRdUO/UKBkIdIBtTMo=;
 b=bgLMf4ijkKkvYb+OUMH0r01V5pmNh6o8fE9cCBT40udpkP4UbgRJ1akErsLOwoYgYI
 Kj6mHCvMf4AAywai6ucFTQVi1/ZYMBWiKhUCdU9jc/LG/ZEczQDCgFAtG5Xc6rCugsom
 QuMAzi3LfKHmEjOGzx/rWjW6b7gZHhn5sgi5srrfZzh3edQ2VzNO19eLqdK5lELW6Mt2
 dL+7eBjYn63haSKDeBRx9upgbfnj+qLERRaNLsrLF1W3l5WCi7dhzqT10Jvusqms2ix3
 1PxxX/lKyKUgTWQhRGM8/wlXPjtxevKov++pgmPIYUEDvkz17XvV0oOsqpSR7aAwlvSh
 iZDg==
X-Gm-Message-State: AGi0PuayfukbrPDFIyURbdLC+1zye/VHZIHWZnuSZ0cK0Z21ev7r8fEu
 ac3OwuBdRoF+gh4VYMQbOjF/oIJm
X-Google-Smtp-Source: APiQypIw4ubh1VWVYRKjwYkeY5N3hwWTvpxXkD+d8A3wLzF3ve8Zuu4Dmn5P+pjEpzIBY/S572nCfg==
X-Received: by 2002:adf:e7ca:: with SMTP id e10mr18432009wrn.18.1588581978772; 
 Mon, 04 May 2020 01:46:18 -0700 (PDT)
Received: from x1w.redhat.com (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id w6sm10740621wrt.39.2020.05.04.01.46.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 01:46:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/3] qom/object: Move Object typedef to 'qemu/typedefs.h'
Date: Mon,  4 May 2020 10:46:13 +0200
Message-Id: <20200504084615.27642-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200504084615.27642-1-f4bug@amsat.org>
References: <20200504084615.27642-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42a.google.com
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Markus Armbruster <armbru@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We use the Object type all over the place.
Forward declare it in "qemu/typedefs.h".

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/qemu/typedefs.h   | 1 +
 include/qom/object.h      | 2 --
 include/qom/qom-qobject.h | 2 --
 include/sysemu/sysemu.h   | 1 -
 4 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 375770a80f..b03ec9f40a 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -75,6 +75,7 @@ typedef struct NetFilterState NetFilterState;
 typedef struct NICInfo NICInfo;
 typedef struct NodeInfo NodeInfo;
 typedef struct NumaNodeMem NumaNodeMem;
+typedef struct Object Object;
 typedef struct ObjectClass ObjectClass;
 typedef struct PCIBridge PCIBridge;
 typedef struct PCIBus PCIBus;
diff --git a/include/qom/object.h b/include/qom/object.h
index 784c97c0e1..1edc12e64c 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -20,8 +20,6 @@
 struct TypeImpl;
 typedef struct TypeImpl *Type;
 
-typedef struct Object Object;
-
 typedef struct TypeInfo TypeInfo;
 
 typedef struct InterfaceClass InterfaceClass;
diff --git a/include/qom/qom-qobject.h b/include/qom/qom-qobject.h
index 77cd717e3f..82136e6e80 100644
--- a/include/qom/qom-qobject.h
+++ b/include/qom/qom-qobject.h
@@ -13,8 +13,6 @@
 #ifndef QEMU_QOM_QOBJECT_H
 #define QEMU_QOM_QOBJECT_H
 
-#include "qom/object.h"
-
 /*
  * object_property_get_qobject:
  * @obj: the object
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index ef81302e1a..ca4458e451 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -5,7 +5,6 @@
 #include "qemu/timer.h"
 #include "qemu/notify.h"
 #include "qemu/uuid.h"
-#include "qom/object.h"
 
 /* vl.c */
 
-- 
2.21.3


