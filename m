Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A31C9C433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 01:58:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EFAB2075A
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 01:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDB+MVtI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EFAB2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kF6QN-0002U6-22
	for qemu-devel@archiver.kernel.org; Sun, 06 Sep 2020 21:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59814)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kF6Nm-00067B-Et; Sun, 06 Sep 2020 21:55:46 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38514)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kF6Nk-0007LP-T8; Sun, 06 Sep 2020 21:55:46 -0400
Received: by mail-wr1-x444.google.com with SMTP id g4so14089697wrs.5;
 Sun, 06 Sep 2020 18:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QQ3fywF3U7FMDEHRpvf9acNc1XCO6x1yzECnPG9z1Co=;
 b=DDB+MVtIis5U0yp6R2ic47YLBD+3fjbpRQJLkJwFHJCYLMc3mWWdHKmnSPX0tpaoTa
 ayue6ZuYolMfJGt029y+Dpw8ip9e7hXKiINP81BqeqJzfPkddYkCBAzpbujxisoMzviE
 /ku2RGwCllL8c2rMoH3ZDDvK2T2eqQeZmj0JCm1ObkFMKP5t1sWpBshEeA8XvQpIMLiu
 giwX+nhMn8mL3Uvkb7mW04sPOLTOA8ipXvXvGonmD+h4OyIUxVRemXT+Y7Pz54wadjZE
 zNpTQ8NGlJnDBy7NdIYfBI4r+M2fuWmSF4BcDVgbxdmjFxgpFFoJ7pfSk2yLP8JWV38K
 Mahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=QQ3fywF3U7FMDEHRpvf9acNc1XCO6x1yzECnPG9z1Co=;
 b=CVEW+q04bJBlChv+MXhkYvvj+0c4as7LtofGxS7jIPaDId+G+kcqgxJ6/W8P7kuRPW
 JOqMWkA2j3pgEc5n1A2pE2q4TdLXsqy3OYCMWxel8i8Qs5Oj0FQPv8BNXjrXbj2qi9Zb
 DNz6ZokbhDKFfOQzAD3t9+9FxnL4ygcx59ZMtQQphyqS8Tda/by7bCeCFeJJ0aP4GkKp
 5kb/w6p4+7a/fXa14OmWirELLVAjyL6vbo6jKdVBopWlMskceYweI0fxjO89PW1M+MJQ
 sj2EWl2TPI55xv0DgrbGNy1BRitkHFZkvExOPXxQiixnaA6F8b51cs3gLlt27nWBWRti
 zbfg==
X-Gm-Message-State: AOAM530ehSSiBKQcn3VYcCswcnaAeSSRRLYXd1lDTkbX4NuT/lkKGoih
 zZE+qcssNfoXh+lT1taqWKZ1EvIBbAk=
X-Google-Smtp-Source: ABdhPJyi0x0cVVoQ+7SHtYPb1M1wl81oPCisPgg8JJWhaYjB9CXUFHhVU22DLzEkwhPYgYnZ1ZdRXA==
X-Received: by 2002:a5d:4e8c:: with SMTP id e12mr6280124wru.180.1599443742996; 
 Sun, 06 Sep 2020 18:55:42 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id b84sm29377773wmd.0.2020.09.06.18.55.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2020 18:55:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/7] hw/char/serial: Rename I/O read/write trace events
Date: Mon,  7 Sep 2020 03:55:32 +0200
Message-Id: <20200907015535.827885-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200907015535.827885-1-f4bug@amsat.org>
References: <20200907015535.827885-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The serial_mm_read/write() handlers from the TYPE_SERIAL_MM device
call the serial_ioport_read/write() handlers with shifted offset.

When looking at the trace events from this MMIO device, it is
confusing to read the accesses as I/O. Simplify using generic
trace event names which make sense the various uses.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/char/serial.c     | 4 ++--
 hw/char/trace-events | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index 1e70294f28a..ade4adfd526 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -333,7 +333,7 @@ static void serial_ioport_write(void *opaque, hwaddr addr, uint64_t val,
     SerialState *s = opaque;
 
     assert(size == 1 && addr < 8);
-    trace_serial_ioport_write(addr, val);
+    trace_serial_write(addr, val);
     switch(addr) {
     default:
     case 0:
@@ -550,7 +550,7 @@ static uint64_t serial_ioport_read(void *opaque, hwaddr addr, unsigned size)
         ret = s->scr;
         break;
     }
-    trace_serial_ioport_read(addr, ret);
+    trace_serial_read(addr, ret);
     return ret;
 }
 
diff --git a/hw/char/trace-events b/hw/char/trace-events
index 85e39d9d62b..cd36b63f39d 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -5,8 +5,8 @@ parallel_ioport_read(const char *desc, uint16_t addr, uint8_t value) "read [%s]
 parallel_ioport_write(const char *desc, uint16_t addr, uint8_t value) "write [%s] addr 0x%02x val 0x%02x"
 
 # serial.c
-serial_ioport_read(uint16_t addr, uint8_t value) "read addr 0x%02x val 0x%02x"
-serial_ioport_write(uint16_t addr, uint8_t value) "write addr 0x%02x val 0x%02x"
+serial_read(uint16_t addr, uint8_t value) "read addr 0x%02x val 0x%02x"
+serial_write(uint16_t addr, uint8_t value) "write addr 0x%02x val 0x%02x"
 serial_update_parameters(uint64_t baudrate, char parity, int data_bits, int stop_bits) "baudrate=%"PRIu64" parity='%c' data=%d stop=%d"
 
 # virtio-serial-bus.c
-- 
2.26.2


