Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B67C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 16:31:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E6F6206DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 16:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTtYiqjP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E6F6206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34366 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEG7p-0005VA-KV
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 12:31:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fintelia@gmail.com>) id 1hEG6b-0004md-2S
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 12:29:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fintelia@gmail.com>) id 1hEG6a-0006O5-3F
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 12:29:44 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:41981)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <fintelia@gmail.com>)
	id 1hEG6Y-0006Hp-FI; Wed, 10 Apr 2019 12:29:42 -0400
Received: by mail-lj1-x242.google.com with SMTP id k8so2708563lja.8;
	Wed, 10 Apr 2019 09:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:from:date:message-id:subject:to:cc;
	bh=l8vm+xUorX7C+t0Kbe+tK1Hn6sNLPaRk09jJpVsMse4=;
	b=UTtYiqjPnvsEmeby95wWAcAFG84CxUw0OrpGczpjKKP1/TrPW/Pa5S9EXBVKYRtk10
	ngyoNrA2IFq66uWFMQhdlKWIsMcGXSQuPN/qhHAnsxwiYBhML4EV9kjAGgXxv1V5uN4q
	GEO//IQSfWaqiXjWHyR0c/adJlhRP/ckAGXsl68zpvd+W3e11UDh+nK3zZJUELycuze8
	qDC5lNoNxW16bDNDrHPbUTQJk3SwMwK3NQcoZQMhaD+2qM00XgC+XWSD6mA9blpzeTwh
	rV1va5Q9hrufgZMLPs/j6UO78qVzTYu2I13odfwz3fNA/puO8ahnsvEAfjWjlti28i9o
	eHKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
	bh=l8vm+xUorX7C+t0Kbe+tK1Hn6sNLPaRk09jJpVsMse4=;
	b=Klv3t7aVPdegGL2eXnR0ixy+NPxcIzY4I2JqTtioNumNgMuvDKmZupAEsLvcI/1gI7
	aGAO9VR6Cui6sVphEBWovwm7W4gh8s0oX891ToVeq7a1YJgnJ4wR4UQyz6Zl8O9Te8si
	bjwGBDingm1aXEJp72izKKb0EuMfKgG+8Q/SDROTyVwcJJ8tpP3vL3zcEb2LpfKakB2a
	2JZcXfBHPsxtpOsVjUsasKJR/mf3aixTh52aWFPkN//+oP0o/iN1QUEMfNfKYdbh4IDS
	KvwtVjyCA4guNjdu/EqSUPNMqePfDAeJqBRGT8Z7ONAta4GZDzVxWQgN3yOOxfusiaTC
	i3jA==
X-Gm-Message-State: APjAAAWzfDucK5FyQ9SMkDAtME0C/BHJvL8mGLfUnQ7LFeng0DeFtyF4
	ZPlAlbenk1xJ5utCnkyJ/+bDdn9qyfpA3zhB+3Cx9EhqiEM=
X-Google-Smtp-Source: APXvYqwXR1pTuBq476qmtTm0pNk7pG83xRayj5xaC6B4O3hnPVZUhNlbh0Ov0vCba4iAMUI5TqzgEwoBJuVNlMZbe4M=
X-Received: by 2002:a2e:9ac3:: with SMTP id p3mr23824919ljj.109.1554913778003; 
	Wed, 10 Apr 2019 09:29:38 -0700 (PDT)
MIME-Version: 1.0
From: Jonathan Behrens <fintelia@gmail.com>
Date: Wed, 10 Apr 2019 12:29:11 -0400
Message-ID:
 <CANnJOVHbCGcgnHT3qVbHGFh_Ba0=FqABSoM2SG9ddf-fawwaYg@mail.gmail.com>
To: qemu-devel@nongnu.org
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::242
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: [Qemu-devel] [PATCH] target/riscv: Remove unused include of
 riscv_htif.h for virt board
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
	Palmer Dabbelt <palmer@sifive.com>,
	Alistair Francis <Alistair.Francis@wdc.com>, qemu-riscv@nongnu.org,
	Sagar Karandikar <sagark@eecs.berkeley.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190410162911.6ouOrXsxsrB6NTL8bXkxrYjlx_gV2FmpZbu9hHwHsz8@z>

Unless I'm missing something, the virt board doesn't support HTIF and
should not be including this header.

Jonathan

Signed-off-by: Jonathan Behrens <fintelia@gmail.com>
---
 hw/riscv/virt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index fc4c6b306e..3526463034 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -29,7 +29,6 @@
 #include "hw/sysbus.h"
 #include "hw/char/serial.h"
 #include "target/riscv/cpu.h"
-#include "hw/riscv/riscv_htif.h"
 #include "hw/riscv/riscv_hart.h"
 #include "hw/riscv/sifive_plic.h"
 #include "hw/riscv/sifive_clint.h"
-- 
2.20.1
