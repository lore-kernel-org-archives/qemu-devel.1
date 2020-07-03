Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB3AC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 20:22:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9282820782
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 20:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UGOI423t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9282820782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrSC7-0004oV-RT
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 16:21:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrS9Z-0007uq-PF; Fri, 03 Jul 2020 16:19:21 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:55527)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrS9Y-0001Uf-1E; Fri, 03 Jul 2020 16:19:21 -0400
Received: by mail-wm1-x32e.google.com with SMTP id g75so33102567wme.5;
 Fri, 03 Jul 2020 13:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+N8OjUxPp76AevnconS+CgpZ8ikHFXXAtXrie4C228s=;
 b=UGOI423tBZFfzoF1WMjiiRbBCeo84E/Ha5azYLbbFLP4iBxjGlPWHhJxWDwCfuDOIu
 ujGmeIj9BJH1fnGnaRxNcKO+feeuXf1PkTS2N3O5DJGHAPI6Dcuou7aEjoIA96vknQVL
 yDioM+Q/gxdU1ci753S2wtkdUOxr9VWUv2gXSfEdoyUvqVwwOqQuu60UMM4NjuCYCjWC
 n/QI21vHUqeq9IBEx12+soseCu0UPHUnlikBiEEt9xq2IC/nHJbT/LYfBjTDKsX4LE0r
 j2bmnXr69xSqIv+/aQL4Xgr9n/FcxvDE1wn8yv5NTMSZvHTRh9D3TRWqcYbcAAQ/PqVG
 wpsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=+N8OjUxPp76AevnconS+CgpZ8ikHFXXAtXrie4C228s=;
 b=gMGPExrOPWQA1IyIjgfGv9GuQhyFrfArgdAdLnZ2vImCrz9CLE91OSU2NNc3iTw65M
 Zr7jmrsCEDusS3NMd5HEGYLTRbGQYisslowmmT44OIM19MWFsjiVVKDpNTdBMqME9Icf
 BhNmk0F+zFIeVKJmjufyooVjbDthUbuCWaygK6dEjc66hUEtvq03F+SkN7lc6zXEn9zs
 XlxYOzMAb5njbeBBbwlR9laCAjW1NzZwDex988j9Fls60bZaduYHQI7OSXNIGz/HZGWM
 PHYIXTboTEEgeX2AX2kfoOoZX5T4326bEheLaXhix8NMzZ8qvMAy6OF3tGtSq65NW4jD
 isag==
X-Gm-Message-State: AOAM533c3nfzZhYvVKlbhuwRuGRrbS3W3oc2yS+yGBUa2PEOYdF7G8o6
 yBBgMBghongRxEwciGRwV09D7ipaat8=
X-Google-Smtp-Source: ABdhPJx6dPfhCcjMJTzTWcp9FE5q3luzLrsoqrfBlHW/r4BFqnzbeVhxNlU9TjwpqkNt0iOKyvkbkA==
X-Received: by 2002:a05:600c:21ca:: with SMTP id
 x10mr37959408wmj.63.1593807558163; 
 Fri, 03 Jul 2020 13:19:18 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id u65sm14229625wmg.5.2020.07.03.13.19.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 13:19:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 03/18] hw/core/qdev: Add vmstate_qdev_no_state_to_migrate
Date: Fri,  3 Jul 2020 22:18:56 +0200
Message-Id: <20200703201911.26573-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200703201911.26573-1-f4bug@amsat.org>
References: <20200703201911.26573-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x32e.google.com
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
Cc: Laurent Vivier <laurent@vivier.eu>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add vmstate_qdev_no_state_to_migrate, which is simply a
pointer to vmstate_no_state_to_migrate. This way all
qdev devices (including "hw/qdev-core.h") don't have to
include "migration/vmstate.h".

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/qdev-core.h | 2 ++
 hw/core/qdev.c         | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index fe78073c70..2e4ddfd75f 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -139,6 +139,8 @@ typedef struct DeviceClass {
     const char *bus_type;
 } DeviceClass;
 
+extern const VMStateDescription *vmstate_qdev_no_state_to_migrate;
+
 typedef struct NamedGPIOList NamedGPIOList;
 
 struct NamedGPIOList {
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 2131c7f951..0d18bc6d93 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -45,6 +45,9 @@ bool qdev_hotplug = false;
 static bool qdev_hot_added = false;
 bool qdev_hot_removed = false;
 
+const VMStateDescription *vmstate_qdev_no_state_to_migrate =
+        &vmstate_no_state_to_migrate;
+
 const VMStateDescription *qdev_get_vmsd(DeviceState *dev)
 {
     DeviceClass *dc = DEVICE_GET_CLASS(dev);
-- 
2.21.3


