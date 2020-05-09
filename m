Return-Path: <SRS0=giGJ=6X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29754C28CBC
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2020 13:15:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E43B721775
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2020 13:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="flf4veSg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E43B721775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXPKU-0000WH-5B
	for qemu-devel@archiver.kernel.org; Sat, 09 May 2020 09:15:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44732)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jXPEh-0004sO-U5; Sat, 09 May 2020 09:09:47 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45340)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jXPEh-0006b1-2e; Sat, 09 May 2020 09:09:47 -0400
Received: by mail-wr1-x444.google.com with SMTP id v12so5107262wrp.12;
 Sat, 09 May 2020 06:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kJ9dbndR3EJ3N94DuL32xKff0HO4BFM4yLLW9t9p4DU=;
 b=flf4veSgSNp7WVQXiv7V7NrX4UAefRYgFkBmINorTlpVmyHhE7veSTufxoQW+l6Dot
 wR4o/pIkezvKsQqfk7pi/vw7fH8RkeyXgbJuREtSTbXGDFEouDylssuXi6SMi8W1jC5F
 5aED8Ld4faiQC7wAF1M2ntUooqoguTRu/E29eqc9poBI//e0zx/vU6BrIVDw5CAtIRJQ
 U1HvgPNfo1scPphSCiVyayMiZg9brfMjvP3CZScx0xnjDbgj7SjIjb3Aon3WxpxEpyNk
 8Tgzh6WxdSkr+gT7kxZVlRfnD7P4SSu4HY+r7qtPXUW500nMnbMXQG11g89ahQXrW1ih
 IqKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=kJ9dbndR3EJ3N94DuL32xKff0HO4BFM4yLLW9t9p4DU=;
 b=hYA51jR8pZ/PL8K7HablazVaKXoEBGkUuhOQXN1e1ALamv/GaU6LkD23pQu7j2msnH
 hNwDNEssAnvv2+OVxEtRcP1eeiQ7zknfcD6yGy5IQxeJYdMKDD6eYwJhMGlK/ux4LWuO
 hqRVDk3m5f1ZN31132vVuvk/KMt1TBbgxx2X97YWeD/TPiGzJgrPG6q1La7HxXCz6rjI
 dUGbMfk8V7NXfrlLxYMrOT52snpZXS1PJGf00KNaP0VAj+XR/BobCXkVy+5QD/4X8iW8
 nO8AU7nmuMC2Oct6Ih2703Vwb07pho3zYwIvwRndTcJ+BQ0dtRw/d6f9vy2vYpjVvANs
 URNg==
X-Gm-Message-State: AGi0PuY2GKowuEDM8U3qY1HqeuqAQKpbKvSzeg3ZMGtmLo0yO+SN0XSs
 fUrcHa0XScTrvg632DgQeH4rE146QGg=
X-Google-Smtp-Source: APiQypLurdSmGrp9B56qX9CNWGd9AI2ip7cdRiw9zhMpmGh5F+d4uyBrY7d4KNVvcCiBokEwwDx36g==
X-Received: by 2002:a05:6000:11cd:: with SMTP id
 i13mr8894961wrx.95.1589029784233; 
 Sat, 09 May 2020 06:09:44 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id m65sm1411410wmm.17.2020.05.09.06.09.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 May 2020 06:09:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/11] exec: Use 'cpu-common.h' instead of system-mode
 specific 'hwaddr.h'
Date: Sat,  9 May 2020 15:09:09 +0200
Message-Id: <20200509130910.26335-11-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200509130910.26335-1-f4bug@amsat.org>
References: <20200509130910.26335-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Chris Wulff <crwulff@gmail.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Marek Vasut <marex@denx.de>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, qemu-ppc@nongnu.org,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, Stafford Horne <shorne@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>, qemu-riscv@nongnu.org,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>, Roman Bolshakov <r.bolshakov@yadro.com>,
 Laurent Vivier <laurent@vivier.eu>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The "exec/hwaddr.h" header is restricted to system-mode emulation.
Instead, use "exec/cpu-common.h", which is meant for all modes.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/disas/disas.h  | 2 +-
 include/hw/core/cpu.h  | 2 +-
 include/sysemu/accel.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/disas/disas.h b/include/disas/disas.h
index 36c33f6f19..531b42e002 100644
--- a/include/disas/disas.h
+++ b/include/disas/disas.h
@@ -1,7 +1,7 @@
 #ifndef QEMU_DISAS_H
 #define QEMU_DISAS_H
 
-#include "exec/hwaddr.h"
+#include "exec/cpu-common.h"
 
 #ifdef NEED_CPU_H
 #include "cpu.h"
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index ed09d056d1..a215ae451d 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -22,7 +22,7 @@
 
 #include "hw/qdev-core.h"
 #include "disas/dis-asm.h"
-#include "exec/hwaddr.h"
+#include "exec/cpu-common.h"
 #include "exec/memattrs.h"
 #include "qapi/qapi-types-run-state.h"
 #include "qemu/bitmap.h"
diff --git a/include/sysemu/accel.h b/include/sysemu/accel.h
index e08b8ab8fa..e223a1d87b 100644
--- a/include/sysemu/accel.h
+++ b/include/sysemu/accel.h
@@ -24,7 +24,7 @@
 #define HW_ACCEL_H
 
 #include "qom/object.h"
-#include "exec/hwaddr.h"
+#include "exec/cpu-common.h"
 
 typedef struct AccelState {
     /*< private >*/
-- 
2.21.3


