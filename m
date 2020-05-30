Return-Path: <SRS0=1N+K=7M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E34C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2020 16:56:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BCA7204EF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2020 16:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhtK0yQp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BCA7204EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jf4mL-0006or-8p
	for qemu-devel@archiver.kernel.org; Sat, 30 May 2020 12:56:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52136)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jf4lT-0006Br-Fh; Sat, 30 May 2020 12:55:19 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:39420)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jf4lS-0003na-GM; Sat, 30 May 2020 12:55:18 -0400
Received: by mail-wr1-x42d.google.com with SMTP id t18so7265979wru.6;
 Sat, 30 May 2020 09:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=V0Xhe941PXhd+YmAF+P/Etq6ib8J1T6jb9BBpOw9xBM=;
 b=OhtK0yQpMAoG+K4WCpfvRzB5hkeDvnQ195wPeJNM3IbPnDlVHtXpzGnqxXVbuGUMmG
 NVhrZZPnn3idhkw/Z0G4t63FZ77h9aZD9nQ3eD3FRlcae20luHoUqrYeKAzZcLS5xNsi
 WW365n5nGaDWRdY/Xk6yThFZ4gTOplOgfk5oMTmCidw4PQxFOIwArnaaJH46hBm1L3ho
 Pt23WnPNa9y1qpFn5MUB5WhePREoG4RJNbP6jkenQnp1G1WPObO3dR4ZsLoNWD0ab/C7
 k1uAluMG47qEOWzbj1XZK5xNj70zaWL1AOw3tP3LMMnBgjPQqF5gna7C7plcXK7EC0hS
 ox+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=V0Xhe941PXhd+YmAF+P/Etq6ib8J1T6jb9BBpOw9xBM=;
 b=cjDTUPnNzQrQsnMPdenXxzFGqybqgEMdGj48ef+S4Qw8gFDmoNRf0Ab1lLdjKgkXuh
 SQN9bGtcBZGgblm8R7zqF/LVIbOQkgi7CLYVf/pb6Un2sUFaRXj3ERXZsb3emLFxUxo6
 zyzYqxdUrr1PWe5vmq3zuXKnDNMDVNy12jy8SgohXLZ4T8qQNhKKIn2+OtObhGHoRYSB
 7isf4zwuxz2rOWNYem24ccRQojabeNUIFR2e02pcDRPBf3RCdt9xq7/b6g2KSgM04cis
 g/xGRWEeccCgIcZUBPztM0sLD1+MkyOyQbu7q309c4hNwyVL2UtVFez3EDAbptAPZa0c
 vQVg==
X-Gm-Message-State: AOAM532i+PHkWMehsY5iSlrLv9LwA5Ke2PU18tV4bq3etWUvdGrLB1C8
 oMzChP9kvSjQ6LZ+mi6EqsWQhf3b
X-Google-Smtp-Source: ABdhPJyhtn+gO++CuwViX9wv1wp6tIR7KZeGuQVVISb0E1vuv88ZDl50Y9nn+if832BMdP/m/nPWSw==
X-Received: by 2002:adf:fb92:: with SMTP id a18mr8207362wrr.263.1590857714851; 
 Sat, 30 May 2020 09:55:14 -0700 (PDT)
Received: from localhost.localdomain (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id i3sm14540684wrm.83.2020.05.30.09.55.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2020 09:55:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] migration/vmstate: Remove unnecessary MemoryRegion forward
 declaration
Date: Sat, 30 May 2020 18:55:12 +0200
Message-Id: <20200530165512.15225-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42d.google.com
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"migration/vmstate.h" only uses pointer to MemoryRegion, which
is already forward declared in "qemu/typedefs.h".

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
CI: https://travis-ci.org/github/philmd/qemu/builds/692879495
---
 include/migration/vmstate.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 30667631bc..eafa39f560 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -1199,7 +1199,6 @@ static inline int vmstate_register(VMStateIf *obj, int instance_id,
 void vmstate_unregister(VMStateIf *obj, const VMStateDescription *vmsd,
                         void *opaque);
 
-struct MemoryRegion;
 void vmstate_register_ram(struct MemoryRegion *memory, DeviceState *dev);
 void vmstate_unregister_ram(struct MemoryRegion *memory, DeviceState *dev);
 void vmstate_register_ram_global(struct MemoryRegion *memory);
-- 
2.21.3


