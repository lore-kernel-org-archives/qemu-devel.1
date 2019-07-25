Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFA0C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 10:18:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CF362173E
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 10:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HoXiGuZa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CF362173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqapr-0005qW-EG
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 06:18:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52623)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hqapf-0005Rp-VN
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 06:18:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hqapf-0005wE-0D
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 06:18:43 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51629)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hqapd-0005v3-P1
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 06:18:42 -0400
Received: by mail-wm1-x343.google.com with SMTP id 207so44455572wma.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 03:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SZ4D3+HH3eDhknXhzXHTgbACfR8HEgUukfvXq/VTaVI=;
 b=HoXiGuZaaTqKEjfLTvfkzvEjriP2xdiSSCBKOOqmNg/gIZrU7WMgaglWeInEp5DENL
 6BDkWPIFbJsKT+aRsnq1k/brF17h1W/PxP+VkalGNd6F80lOYhz92PgVHTASk5TxWPuS
 1WnXZ7ZKvjb0sm2ZJi+wCUJ/jfmdb9eyyrgw674gH94JfvW/CQlPH2NR+uxwwchiNmBO
 VgMafPzpzq+j0/tjQ+SmD18GQH34rkpTWir19r60ryrokzK40xhov0VgPsTcGX2HvCdJ
 jc6F8xw4QrfCPDkplbRo5YpboGw46Se/PCTMx3s9JFD+FR+1jZXJ6vljiHCZalJq4H3X
 UcYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=SZ4D3+HH3eDhknXhzXHTgbACfR8HEgUukfvXq/VTaVI=;
 b=ZWfGONzcQHmIehx0t+vc+5b01TAB8OfEqUNydcQ5FJrtxFklhX00TXCEk9b4jcFenM
 PRZVENS7Rn/e4YfFKO91J4xkHrHSGiVR6PiQN40YXTkvT92pHer96lC1gofcKkft/h5f
 LS2boOacdC91Mp5raruDBcrgbq5D56BatKzeNvbp+dW7CABnPxZDG4owuxOBLcRLK0TX
 fP1druxMKQ2O+rnVsiO1fbtJO2uI/E41h+dnCJZT/oBrJMjVvgoeWy9nPWLy07sew5vs
 fnTBnbivrW69VUq3y607YMFV7Vgc6xzdK3a3RfHcF289aYylNTEzG6tL0aO7r/bH7g4+
 Domg==
X-Gm-Message-State: APjAAAWkDVcY3ZK1ConCDfneQwuIDZ2/DSHWSt9IRQz3wT26z4d+DoN8
 mJHSnMKOFXTPUxB+fZSpcv8cL7hgg1Q=
X-Google-Smtp-Source: APXvYqwNvuoD8WaD77UU8mibxyNAndTbESDtY4BUMCuzQIghDfkiLn+AdtLeo7/n7SRxkSCaAyIJZg==
X-Received: by 2002:a1c:8017:: with SMTP id b23mr79113894wmd.117.1564049918716; 
 Thu, 25 Jul 2019 03:18:38 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:cc23:f353:392:d2ee])
 by smtp.gmail.com with ESMTPSA id
 b2sm64222855wrp.72.2019.07.25.03.18.37
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 25 Jul 2019 03:18:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 25 Jul 2019 12:18:36 +0200
Message-Id: <20190725101836.1273-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH] 9p: simplify source file selection
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 groug@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Express the complex conditions in Kconfig rather than Makefiles, since Kconfig
is better suited at expressing dependencies and detecting contradictions.

Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Kconfig.host        | 1 +
 fsdev/Makefile.objs | 2 +-
 hw/9pfs/Kconfig     | 5 +++++
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/Kconfig.host b/Kconfig.host
index aec95365ff..bb6e116e2a 100644
--- a/Kconfig.host
+++ b/Kconfig.host
@@ -28,6 +28,7 @@ config VHOST_USER
 
 config XEN
     bool
+    select FSDEV_9P if VIRTFS
 
 config VIRTFS
     bool
diff --git a/fsdev/Makefile.objs b/fsdev/Makefile.objs
index 24bbb3e75c..42cd70c367 100644
--- a/fsdev/Makefile.objs
+++ b/fsdev/Makefile.objs
@@ -1,6 +1,6 @@
 # Lots of the fsdev/9pcode is pulled in by vl.c via qemu_fsdev_add.
 # only pull in the actual 9p backend if we also enabled virtio or xen.
-ifeq ($(call land,$(CONFIG_VIRTFS),$(call lor,$(CONFIG_VIRTIO_9P),$(CONFIG_XEN))),y)
+ifeq ($(CONFIG_FSDEV_9P),y)
 common-obj-y = qemu-fsdev.o 9p-marshal.o 9p-iov-marshal.o
 else
 common-obj-y = qemu-fsdev-dummy.o
diff --git a/hw/9pfs/Kconfig b/hw/9pfs/Kconfig
index 8c5032c575..3ae5749661 100644
--- a/hw/9pfs/Kconfig
+++ b/hw/9pfs/Kconfig
@@ -1,4 +1,9 @@
+config FSDEV_9P
+    bool
+    depends on VIRTFS
+
 config VIRTIO_9P
     bool
     default y
     depends on VIRTFS && VIRTIO
+    select FSDEV_9P
-- 
2.21.0


