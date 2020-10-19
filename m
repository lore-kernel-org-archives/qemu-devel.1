Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78068C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 20:21:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFE86223EA
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 20:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JjyzqLlz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFE86223EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUbf2-0007Fe-S8
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 16:21:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58674)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eafanasova@gmail.com>)
 id 1kUbdx-0006aU-H7
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 16:20:33 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:33054)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eafanasova@gmail.com>)
 id 1kUbdv-0002ep-TI
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 16:20:33 -0400
Received: by mail-lj1-x241.google.com with SMTP id c21so1665388ljj.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 13:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:user-agent:mime-version
 :content-transfer-encoding;
 bh=7urB7f92nHfRlxyFk7GnYTz1GZBdxJ9ZfAfPv48p1XY=;
 b=JjyzqLlzXo6whVwUzg+DYEdOuI0XUsjLUXFt6eDrM0ZnEegLRzobFFHs16LxuoKr7S
 2mGRyZzDP2n7yJdCEmhBFpijPecWyJMQaUIL/o6PcjApDi7ROXNQ+ag7spEOo754QKpf
 wuxY1MzJjk2OGRJA66bXiRjYkblq5/s8C4HGpMQG/GyBHwkhCm3ZjlEt8UukrSeGHnSG
 AKlYe9trRxeX+gWH4pSta8YEqNPgE1HWnvUl6tUdIGCgqXZzRzi1mUYFlrV1NLEN7DUI
 S1GJu33o6vKZAPp8XFGepjcDWLWde2vTaHgUkjSgKh/5w+26B/oGX5begEs2+BYl3YOv
 pQ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:user-agent
 :mime-version:content-transfer-encoding;
 bh=7urB7f92nHfRlxyFk7GnYTz1GZBdxJ9ZfAfPv48p1XY=;
 b=ABjwgyw8cjlhuNl/N1jXzMdCjMlGFbOUcXmiqxbGzOC1YX+/LpTwEtxCE9cFEIoWi3
 FwxVp06FRfz/k1zwYM4dhKU9ybu4QSqjpw0Ds7uqrKfdY1j+4YJJcQvtetOGY2qy3U2n
 uNGlKr7B5oC6b2jF1vWJPvRZTIIfZztAl8Ob2pthYf1pY1I+gKjkduYaWDqSPd+uKnQk
 hMnksc9q1JFnSyE5lrF4zkROSBdmJ7OhX8F7U0iySce/jZ8Tb7W3nvraQciYJC/Gz2fo
 sQrh2sxl5eOZa99+ekuFzJKAp2w5qmXnX687clQWlySbJrNRfLbBn7O6XizovGkIe9xC
 tcwg==
X-Gm-Message-State: AOAM530zMxbQJTlC+NeIL8FJDW5p7hGeRK6/Je3e3tzrtiX7W1VU/ZRo
 cmlmhGXrkyECaJvH+nlOZk/qLXyq4lD5yg==
X-Google-Smtp-Source: ABdhPJzcmWCt9DUCufMUe2kPAH7hx3Ig5bGih4TipveCP9KTntgMrpP657GS6vIgc8WuvMJteXXv4A==
X-Received: by 2002:a2e:88cb:: with SMTP id a11mr725738ljk.304.1603138828678; 
 Mon, 19 Oct 2020 13:20:28 -0700 (PDT)
Received: from [192.168.167.128] (37-145-186-126.broadband.corbina.ru.
 [37.145.186.126])
 by smtp.gmail.com with ESMTPSA id q27sm136133lfd.261.2020.10.19.13.20.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2020 13:20:28 -0700 (PDT)
Message-ID: <cf71a62eb04e61932ff8ffdd02e0b2aab4f495a0.camel@gmail.com>
Subject: [PATCH v2] softmmu/memory: fix memory_region_ioeventfd_equal()
From: Elena Afanasova <eafanasova@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 19 Oct 2020 13:20:13 -0700
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::241;
 envelope-from=eafanasova@gmail.com; helo=mail-lj1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: pbonzini@redhat.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eventfd can be registered with a zero length when fast_mmio is true.
Handle this case properly when dispatching through QEMU.

Signed-off-by: Elena Afanasova <eafanasova@gmail.com>
---
 softmmu/memory.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/softmmu/memory.c b/softmmu/memory.c
index 403ff3abc9..4b5775ae5b 100644
--- a/softmmu/memory.c
+++ b/softmmu/memory.c
@@ -205,8 +205,15 @@ static bool memory_region_ioeventfd_before(MemoryRegionIoeventfd *a,
 static bool memory_region_ioeventfd_equal(MemoryRegionIoeventfd *a,
                                           MemoryRegionIoeventfd *b)
 {
-    return !memory_region_ioeventfd_before(a, b)
-        && !memory_region_ioeventfd_before(b, a);
+    if (int128_eq(a->addr.start, b->addr.start) &&
+        (!int128_nz(a->addr.size) || !int128_nz(b->addr.size) ||
+         (int128_eq(a->addr.size, b->addr.size) &&
+          (a->match_data == b->match_data) &&
+          ((a->match_data && (a->data == b->data)) || !a->match_data) &&
+          (a->e == b->e))))
+        return true;
+
+    return false;
 }
 
 /* Range of memory in the global map.  Addresses are absolute. */
-- 
2.25.1



