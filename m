Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B73C7C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 17:20:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83CAC206D3
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 17:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FP5AQxxP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83CAC206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igu2h-00023b-VY
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 12:20:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57431)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtFh-0005vu-8c
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtFf-0000Tb-ET
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:44 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41589)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1igtFf-0000RQ-74
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:43 -0500
Received: by mail-wr1-x442.google.com with SMTP id c9so8039739wrw.8
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 08:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3xRW0dWjMhO1EPoHD9jweteGOAO0mpniEjjgSK1VhoQ=;
 b=FP5AQxxPnltuwrDP8B80N0eYvqBSpLEyAYrlDRCwYaPUosIIT5fLPCxrgSq+dhNfC9
 j6H3LkE3QgUoW+DDsa5f9y+3GqdgeSW8WgqwTygRRzOfZMEjUe7LATngT8frhKFnFDG9
 6vBFUpxyCIddsX6KkU+d/RjeiEB1Dr1c+w4ekUvwLKUa/zT643b0QH23ol8qpN5Vijr6
 NzCjxzSIF49kapOrsyKCfW04RtuumDWoK7jmDmJPTsUUxTNvvoR3iyByHHxAIRsNQsu6
 c06z1DhvaVdH7bA0PNzl1cPLW1QbV4/xO74jGXld24ooSCobCNL+aCBfAaf067mlVhOb
 LYCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=3xRW0dWjMhO1EPoHD9jweteGOAO0mpniEjjgSK1VhoQ=;
 b=Czph/twI8IBbY6W4Ob5G/shu3DbCqnDFsEmHui2BlU8+0tjTNf0tJG5Y4W+ltI6A4B
 DWbpVpmVtSX3vu+09OfXaoErc25qglA5GWfrSvXZZ193+KqnZ6d46DNSSsqQFR7cswUc
 QqcFy/FzE9mOKXw1oKsX/Bw47tdM7yxnLaobkxPkzaEPDMcNe8HpJQeAN2vpetaeXJos
 eEJTljV1TMzeiUCY7E4T/kM+0gBUHxTa59aqfAtMzWXT6P+xUfNgCa5cNNJhWyg5CH4K
 /9SLLi2sYfiIeFtnnpoiWgx+dQ7inrTv/weUujIerY2sBYUEB5e4l7VlSroVKRsFy74r
 0OxA==
X-Gm-Message-State: APjAAAWxR2gPLjNWDkDEH+vzLXBamKp0G8ZoNk4rJCSY9RBcTh2CvJAY
 dlv2CdwHhJn8wVYHNkOAu4CdIO3g
X-Google-Smtp-Source: APXvYqx6+Wv6DRVFBzPSv8AHlb6daZ3L0tikByx+RLWxRhWxr395WKrY4OBLKF+q6xK6+Bx1MsIusg==
X-Received: by 2002:a5d:68c5:: with SMTP id p5mr31916905wrw.193.1576513782101; 
 Mon, 16 Dec 2019 08:29:42 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id q68sm19962334wme.14.2019.12.16.08.29.41
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Dec 2019 08:29:41 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 54/62] hw/i386: Simplify ioapic_init_gsi()
Date: Mon, 16 Dec 2019 17:28:38 +0100
Message-Id: <1576513726-53700-55-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
References: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
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

All callers of ioapic_init_gsi() provide a parent. We want new
uses to follow the same good practice and provide the parent
name, so do not make this optional: assert the parent name is
provided, and simplify the code.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/x86.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index d18a3ef..d8bb5c2 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -307,15 +307,14 @@ void ioapic_init_gsi(GSIState *gsi_state, const char *parent_name)
     SysBusDevice *d;
     unsigned int i;
 
+    assert(parent_name);
     if (kvm_ioapic_in_kernel()) {
         dev = qdev_create(NULL, TYPE_KVM_IOAPIC);
     } else {
         dev = qdev_create(NULL, TYPE_IOAPIC);
     }
-    if (parent_name) {
-        object_property_add_child(object_resolve_path(parent_name, NULL),
-                                  "ioapic", OBJECT(dev), NULL);
-    }
+    object_property_add_child(object_resolve_path(parent_name, NULL),
+                              "ioapic", OBJECT(dev), NULL);
     qdev_init_nofail(dev);
     d = SYS_BUS_DEVICE(dev);
     sysbus_mmio_map(d, 0, IO_APIC_DEFAULT_ADDRESS);
-- 
1.8.3.1



