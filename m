Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A692C35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:52:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E94EA21556
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q08y99wB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E94EA21556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Zhc-0006pq-V1
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:52:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52485)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Z08-0003Qn-97
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:07:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Z07-0003SX-9W
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:07:48 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45812)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6Z07-0003QU-1o
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:07:47 -0500
Received: by mail-wr1-x442.google.com with SMTP id g3so14386721wrs.12
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 04:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Pa3Dg+0nydJXBH9NRO9g2c3Rg2CZEZxMnxi2NhPzuTw=;
 b=q08y99wBshmVvJsx0lmLOBl1zEsji22MPSzM/fmSmRjVovDbMjEpeO1dDzQGqeN1kv
 YS/2yoPchufKUQ/co+xK+KIpuurAmifZtaJ5PNaj48sWhtUt1ml3LoXS/Vs69yFnkbBs
 df3CJyEfqMVKj/KL+L997X9wIcyfl4II1Dwf32AO7rWEzksN8E7aCbMR4WIXNQnOsQaK
 jUOanDHCU6flWbvxPug1Qdwd7GgqYTzmtWY/fOWsNlh9Qy0eaUIWJzn0SqOPv6b/IZTH
 Riru1goELMN0xZtdmAmgCB/1IaWXTmkENASbqiA1DoxN8DmNzBYRiJzIoVPtAdy4HyUs
 dBag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Pa3Dg+0nydJXBH9NRO9g2c3Rg2CZEZxMnxi2NhPzuTw=;
 b=KcZNxb7iEBUIBHdIJ9kH1TNr9pnF5a1IMNzNdc6EJO5ilU7pK8z8HB8MoCKVXONKeY
 bbyNTrWGbxsGB6ga1D5JvRdk1QE3a98rLSkExA7LNlxBILehITbtLNZj0mkKB0a92pH9
 /Mo3xjhMvLz1Lbl6Pnj1TEK30HeyiXOGjjXPgv3ZoeyUh/Klrgm+D5l7Lfs4jobZRzYq
 AYbyZmwQBmfjqWXu7M6qgBmDNHpW6jkHyyBWfqRoUzpVyBQn8ivP0kVgK5goA+jxdLwc
 F611PNbjmwQRHBvaSDQ8VM57zveT9OxnSUUk4O5fZdTxB6gGMFP/v16/ImKwmkajvtWv
 5IuQ==
X-Gm-Message-State: APjAAAUpwS5XX268Z8xaq81yDjqzAkTr3yuMcmwUPTk2HwTj8looFt7Y
 RYf497Iun4FKAKvpZ5/U/S20sREV
X-Google-Smtp-Source: APXvYqy/DTH62VkIiU78vrCnwwMz5H/bQwP6zNzQLp1KVB/ZDeWSdJFQgfZbjjn5aFZOG8EYFRGqww==
X-Received: by 2002:a5d:540f:: with SMTP id g15mr70071980wrv.86.1582632461988; 
 Tue, 25 Feb 2020 04:07:41 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id h13sm22709423wrw.54.2020.02.25.04.07.41
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 04:07:41 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 108/136] hw/pci-host: Use memory_region_init_rom() with
 read-only regions
Date: Tue, 25 Feb 2020 13:07:06 +0100
Message-Id: <1582632454-16491-6-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

This commit was produced with the Coccinelle script
scripts/coccinelle/memory-region-housekeeping.cocci.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200224205533.23798-11-philmd@redhat.com>
Supersedes: <20200221173049.18134-1-philmd@redhat.com>
---
 hw/pci-host/prep.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/pci-host/prep.c b/hw/pci-host/prep.c
index 1aff72b..1a02e9a 100644
--- a/hw/pci-host/prep.c
+++ b/hw/pci-host/prep.c
@@ -325,9 +325,8 @@ static void raven_realize(PCIDevice *d, Error **errp)
     d->config[0x0D] = 0x10; // latency_timer
     d->config[0x34] = 0x00; // capabilities_pointer
 
-    memory_region_init_ram_nomigrate(&s->bios, OBJECT(s), "bios", BIOS_SIZE,
-                           &error_fatal);
-    memory_region_set_readonly(&s->bios, true);
+    memory_region_init_rom_nomigrate(&s->bios, OBJECT(s), "bios", BIOS_SIZE,
+                                     &error_fatal);
     memory_region_add_subregion(get_system_memory(), (uint32_t)(-BIOS_SIZE),
                                 &s->bios);
     if (s->bios_name) {
-- 
1.8.3.1



