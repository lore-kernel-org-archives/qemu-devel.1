Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE54C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 15:31:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 770902072E
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 15:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5Yw85Yv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 770902072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIwNk-0002vY-Kh
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 11:31:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38779)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jIwMn-000210-QY
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 11:30:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jIwMm-0002Jx-PJ
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 11:30:21 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44204)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jIwMm-0002H0-Gu
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 11:30:20 -0400
Received: by mail-wr1-x444.google.com with SMTP id m17so22147924wrw.11
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 08:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wlkjtKPyWMqQrbfa2vdwgZkigUemJrYf+pOUdA57Mms=;
 b=F5Yw85YvezFOBGlXOPcLstYiVSY0ywC0+clKJiI1IDmd4azg5CiivOizL9BW2NgcsO
 YjUAFt7jIEBrs7fYZJNPXsN8QCh5eqz80LObfLY0giNVYcXF9lMykdQMzZD2DtSrsZZW
 Th+uJmhYSGvWn6njBhG5m8TGVVj6S7cu+YhxtnV7BMGLWwJYpt3l2/QWF11elhGa/Cwr
 OGF+owRrk8wFgkmFwyCKLH6V/pVzdys6cAj7sE9OxXqHDDuj4wWGkx9IodBCHyuBT9G0
 rQXiAqHD2/vKPOotxKvhnCOkQ6EGfb1g4b5UM/VyM+shr44QmASaIlCxQ8KWHJjkkwXq
 uxRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=wlkjtKPyWMqQrbfa2vdwgZkigUemJrYf+pOUdA57Mms=;
 b=dnwy+htycOPyCj4AlxO9VqtRnh4BPHRdlgAIWOGviDaMovMN0JmNo3d3bzhrBDDQZT
 +jRXCsnT+Yr4brKirrLl/T6mfbOQjWOFmBNl2j6p1kpSCfRhP6WtKWUNm461IiQXqcOH
 Y5d8cAoUeA6jIspHSFH0+Fec1fEIW3gg1uGbYvR4LYzQfQ2RIw27OM+Y57c+cjISAwaG
 yZpTQZN7dFPiDmYFnXsySTVtpaz3fWnMniwFw5Vcl8aDEKrDmZPzpTLx8MzWRwxG5tNQ
 0oihfZDvXwtRA7179kNW5ltMKn47Bb8hxY5dvI9N1EPwMszzp5xcHfPUz1wL2e64Jauv
 XWow==
X-Gm-Message-State: ANhLgQ3C7Pi9A7XnoEezZupDP2TxUJJ1sbmUAmiX1yng877SDm2I126k
 AbvVi/K7+3A9hvcrO7z9nncFCIoZHiM=
X-Google-Smtp-Source: ADFU+vs2RIlyYEqRrY9H6DN7hzGjv+xvOUolEim08yy8K+ZRfnNLLuUV94mQ7+5tMS0PTy+yCJ5pcw==
X-Received: by 2002:a05:6000:1251:: with SMTP id
 j17mr15592161wrx.228.1585582218768; 
 Mon, 30 Mar 2020 08:30:18 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id l185sm12185971wml.44.2020.03.30.08.30.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2020 08:30:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0] gdbstub: Use correct address space with
 Qqemu.PhyMemMode packet
Date: Mon, 30 Mar 2020 17:30:16 +0200
Message-Id: <20200330153016.2959-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jon Doron <arilou@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since commit 3f940dc98, we added support for vAttach packet
to select a particular thread/cpu/core. However when using
the GDB physical memory mode, it is not clear which CPU
address space is used.
Since the CPU address space is stored in CPUState::as, use
address_space_rw() instead of cpu_physical_memory_rw().

Fixes: ab4752ec8d9
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 gdbstub.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 013fb1ac0f..3baaef50e3 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -69,11 +69,8 @@ static inline int target_memory_rw_debug(CPUState *cpu, target_ulong addr,
 
 #ifndef CONFIG_USER_ONLY
     if (phy_memory_mode) {
-        if (is_write) {
-            cpu_physical_memory_write(addr, buf, len);
-        } else {
-            cpu_physical_memory_read(addr, buf, len);
-        }
+        address_space_rw(cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
+                         buf, len, is_write);
         return 0;
     }
 #endif
-- 
2.21.1


