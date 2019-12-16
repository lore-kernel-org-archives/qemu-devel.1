Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D77C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 17:04:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1759620674
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 17:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eXzuTb+o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1759620674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igtnd-0006fT-K0
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 12:04:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57202)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtFU-0005dJ-WA
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtFT-0008P9-RU
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:32 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:33126)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1igtFT-0008N3-Ko
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:31 -0500
Received: by mail-wr1-x42a.google.com with SMTP id b6so8072692wrq.0
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 08:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=waJxQlBb94XR6Ggskx6BDndQcoTTNWF9QTJRASbqMgE=;
 b=eXzuTb+oK+8nK0W8SymbArv0MfDFWmi6QIPvx2GEZM2xxD3y9WLkIurdxysJRlSQK0
 LHgoU9c6zzeuNECGdZeMVfASM1cfwV9SEn8sQGjU9bo0AgGCJ4wjjGG7e2Vefn2mg2zK
 SMoY1JTK4c7Pd+zO+wE3jyrDhfD+EN3qyiq2LVXSxDsEnWzxWlro9v+pobMUxjeu/V9w
 zjzIk2J3mPvREgh0T1n163t9rXBmnmJ7BBJwUDbumEQ6jqxm1GQSitItOKNmEb+jwm2p
 d0tywCwz7WOQDiT6/DAMI4d06EqoJDa/rSDl61LNe/6vhyhEZARyIbscMAMPpTedxdJ5
 zK5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=waJxQlBb94XR6Ggskx6BDndQcoTTNWF9QTJRASbqMgE=;
 b=CV10P4tMv0juCq8w16MzTQby+o6LXUHQJzWL1aS1xNxhL0XQSh1AmUz3UZ0lkB5f2G
 Hg+bS4fweawEE/AuDrOyD5SXI3XXZxhmXbIovkdRKn5s0mWpa9Qqb2Qsl0pDo/oAlayf
 Iq4nxJNN81n+8AfWA/ntX0+X+5Te+V6QxQgRYc1mH/xt1ndNiAB8yMbCiNLPmi5nr73o
 eujdo2LG+kZDpEyyurVmz/SCN/Sce2msKEbNqmpUm6AMchJaxHOGjeTEcLF7cnIZEoWm
 zLu24+p2tsoeW/1Gko0cF2wmBDXNVXLOuLDSfDMqZcGM4a9wFJ8GxXmChNijJ+S8lrdu
 Dd9A==
X-Gm-Message-State: APjAAAU32LxES6Rkm8wieGOYc36gCw37lgCDiadqmmXyGcyQA2j00uy7
 G/g4WBQ3GWnw1YjyU+ch4a91Xf0e
X-Google-Smtp-Source: APXvYqySpSvp1uMvhqr4ZBvshoQTxMS/9dEuVhei8qe0jylxzT2DllZvYMnwI9QYCuuURbJ5ymI73Q==
X-Received: by 2002:a5d:4044:: with SMTP id w4mr31117984wrp.322.1576513770180; 
 Mon, 16 Dec 2019 08:29:30 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id q68sm19962334wme.14.2019.12.16.08.29.29
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Dec 2019 08:29:29 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 43/62] configure: simplify vhost condition with Kconfig
Date: Mon, 16 Dec 2019 17:28:27 +0100
Message-Id: <1576513726-53700-44-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
References: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42a
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Kconfig.host            | 5 +++++
 Makefile                | 1 +
 hw/virtio/Kconfig       | 3 +++
 hw/virtio/Makefile.objs | 4 ++--
 4 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/Kconfig.host b/Kconfig.host
index bb6e116..55136e0 100644
--- a/Kconfig.host
+++ b/Kconfig.host
@@ -25,6 +25,11 @@ config TPM
 
 config VHOST_USER
     bool
+    select VHOST
+
+config VHOST_KERNEL
+    bool
+    select VHOST
 
 config XEN
     bool
diff --git a/Makefile b/Makefile
index fb1728e..531e955 100644
--- a/Makefile
+++ b/Makefile
@@ -382,6 +382,7 @@ MINIKCONF_ARGS = \
     CONFIG_OPENGL=$(CONFIG_OPENGL) \
     CONFIG_X11=$(CONFIG_X11) \
     CONFIG_VHOST_USER=$(CONFIG_VHOST_USER) \
+    CONFIG_VHOST_KERNEL=$(CONFIG_VHOST_KERNEL) \
     CONFIG_VIRTFS=$(CONFIG_VIRTFS) \
     CONFIG_LINUX=$(CONFIG_LINUX) \
     CONFIG_PVRDMA=$(CONFIG_PVRDMA)
diff --git a/hw/virtio/Kconfig b/hw/virtio/Kconfig
index 3724ff8..f87def2 100644
--- a/hw/virtio/Kconfig
+++ b/hw/virtio/Kconfig
@@ -1,3 +1,6 @@
+config VHOST
+    bool
+
 config VIRTIO
     bool
 
diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
index e2f70fb..de0f5fc 100644
--- a/hw/virtio/Makefile.objs
+++ b/hw/virtio/Makefile.objs
@@ -2,8 +2,8 @@ ifeq ($(CONFIG_VIRTIO),y)
 common-obj-y += virtio-bus.o
 obj-y += virtio.o
 
-obj-$(call lor,$(CONFIG_VHOST_USER),$(CONFIG_VHOST_KERNEL)) += vhost.o vhost-backend.o
-common-obj-$(call lnot,$(call lor,$(CONFIG_VHOST_USER),$(CONFIG_VHOST_KERNEL))) += vhost-stub.o
+obj-$(CONFIG_VHOST) += vhost.o vhost-backend.o
+common-obj-$(call lnot,$(CONFIG_VHOST)) += vhost-stub.o
 obj-$(CONFIG_VHOST_USER) += vhost-user.o
 
 common-obj-$(CONFIG_VIRTIO_RNG) += virtio-rng.o
-- 
1.8.3.1



