Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEDE9C76192
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 08:14:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B691A2145D
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 08:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRn8ESDn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B691A2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnIbF-0002eI-Kh
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 04:14:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59947)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hnIYe-0008Kq-OY
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:11:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hnIYd-0003Gw-8v
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:11:32 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:36922)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hnIYd-0003GQ-2W
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:11:31 -0400
Received: by mail-wr1-x434.google.com with SMTP id n9so19863188wrr.4
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 01:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=KaySmgI0vFG3f8nxtwM3Mu8yasXrk6fOBut/kewGAmc=;
 b=nRn8ESDnqePtSElQ3Nb2VF4u2UZDuqSh8zBpMK2Hat/ONmlIcoiXlAdQBuxAdMEZFx
 +3BBE7MNGIiz7XpGX/J8f8d10WTQ9RI1PYHr7rwU46Iiej0SyQPSJSzBDWDeZ+sXA0/Z
 gzCRmyNYm0XDqXFoY+IOdgbLdAo6XbbSmLaTQjyVwqBJ43n25b91z3kxRmL2rr+IurUL
 0PVtc16HDleLWdfLaVBnWxhCA8vB8Wyoh2Zr+mUOrb7dvq6WMQBwpPeTUXdHAxM2nezf
 X+V8nwMhyrQPF2HMuJEKFerJEBnk0Mmgr2Lwd2ZIclQMc7QHIyRXjsMKKKMsxl8eAYa1
 W6lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=KaySmgI0vFG3f8nxtwM3Mu8yasXrk6fOBut/kewGAmc=;
 b=QaolWuP26KyI6WYhLzAMxuYPOHFG42zD8NqW1f2LshbehYikISJssqYVSoAB3Du+Cq
 xcONrK+B0vwW602mntxTPIjGfjzM7vEPwED9PBPvXieDD6a/8ylxfDb+kRS3CtippBG3
 7qZpQ7EfR1OQ3em00DOd/ZTOI3a6vzUrbyxqQKSrLdwAra9wJO/sIu0LPX+WI7OT/4xE
 YS2AMk0ILoAENu9x1NfwNnnA/U1QFg9GAvTzVB6gQsKHTFKbwL/QtpQd21lbX50Vriqv
 5gGz/s72o45u8s/O16Yi6Sl2kKkGKxSn6BZXBX3+SLke4ZR6iAowuaQEHnrYXCUksR/i
 4Psw==
X-Gm-Message-State: APjAAAXcW1s/h0aQ/yNMNw71rYBVtgypv2OTLz7DXlK3DjKp5r4ux7ou
 QlEsITz1sODPFf8wl4pNOWscEKK+pkg=
X-Google-Smtp-Source: APXvYqwLoXgk9zyx0VvuTplgvTkUHIuYxE9wrSEipffh1JiDdXkatkgJAx+ah2RUFJgEVVSFA5U0Qg==
X-Received: by 2002:a5d:498a:: with SMTP id r10mr34548306wrq.28.1563264689819; 
 Tue, 16 Jul 2019 01:11:29 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id c1sm37723879wrh.1.2019.07.16.01.11.28
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Jul 2019 01:11:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 16 Jul 2019 10:11:08 +0200
Message-Id: <1563264677-39718-11-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1563264677-39718-1-git-send-email-pbonzini@redhat.com>
References: <1563264677-39718-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::434
Subject: [Qemu-devel] [PULL 10/19] Fix broken build with WHPX enabled
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
Cc: Stefan Weil <sw@weilnetz.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Weil <sw@weilnetz.de>

Signed-off-by: Stefan Weil <sw@weilnetz.de>
Message-Id: <20190712132611.20411-1-sw@weilnetz.de>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/whpx-all.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
index 31d4732..ed95105 100644
--- a/target/i386/whpx-all.c
+++ b/target/i386/whpx-all.c
@@ -1396,7 +1396,7 @@ static int whpx_accel_init(MachineState *ms)
     }
 
     memset(&prop, 0, sizeof(WHV_PARTITION_PROPERTY));
-    prop.ProcessorCount = smp_cpus;
+    prop.ProcessorCount = ms->smp.cpus;
     hr = whp_dispatch.WHvSetPartitionProperty(
         whpx->partition,
         WHvPartitionPropertyCodeProcessorCount,
@@ -1405,7 +1405,7 @@ static int whpx_accel_init(MachineState *ms)
 
     if (FAILED(hr)) {
         error_report("WHPX: Failed to set partition core count to %d,"
-                     " hr=%08lx", smp_cores, hr);
+                     " hr=%08lx", ms->smp.cores, hr);
         ret = -EINVAL;
         goto error;
     }
-- 
1.8.3.1



