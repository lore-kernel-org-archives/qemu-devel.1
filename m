Return-Path: <SRS0=Oxyb=V7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1A8C0650F
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Aug 2019 00:28:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64A8D2087E
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Aug 2019 00:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ueI0R8GH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64A8D2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hthu2-00059O-KN
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 20:28:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51753)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hthte-0004Um-Oq
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 20:27:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hthtd-00076W-1G
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 20:27:42 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:39946)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hthtc-00072q-SM; Fri, 02 Aug 2019 20:27:40 -0400
Received: by mail-pl1-x644.google.com with SMTP id a93so34168746pla.7;
 Fri, 02 Aug 2019 17:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id;
 bh=yAxZ8RM+7BN40lgaBTxH7y4VBapD3Af85d2Gzv1To1A=;
 b=ueI0R8GHXKe7lf/OYpF3cGWWQuElYJ/uA/eZ7Hjj0pAOFq1RSj4c/IKlmT7+PW5F7e
 SpsCKdzVHrS3ogwG9zVKOByv0Jfl5Q1AtVWeTSsVuSbRE1MiRME7IkdXRBhP4Zo+IPGZ
 xI9WOFL3U20PJdKcwrx/4wn3jEBQZH58OV+aIS2L4lS+o4wTjGjgIENnrfuBoJ8S7eFe
 dmwFCtIRAnuOq8EXuHtUdU+2zyZgGR/1bEfqLUg5i+puNTkBUeImC/P3Z5e31S80aRLc
 5HWcJnq8h0gPC26XPGuSfUPyC/USOGkRQ6U9b9uWx0qt+GLPfZI+hG6mzBR/Yr7Bp6wA
 np6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id;
 bh=yAxZ8RM+7BN40lgaBTxH7y4VBapD3Af85d2Gzv1To1A=;
 b=rkuFXjQJcbkI3tg6kL8eYLPCgkR24yjDC0snNEIjvcMd7ikS4usvAjfiA7l2GuRKix
 w2Pl5kpytf8Jr5DJfeXTSUBtSr6CI4HZXIWkUC2vDSkr3C8O0YD3yOV7kupZ4fb/cXOj
 0pX/f8psO4snd/z9s1u0ZXIvr/2WM3XKDoZv4k++YOWsYAwjBVe3NabtMhQAcyHMoITQ
 8u3YnVM2aCUBfeNVFzUGeNJoUsFDQjdxdWiKqzMThm4av/qemmPvzvLWnRrVkAn8x9gv
 fSgdSHEIsnZbOSl/NsByZ53LvqleVReUXL56ka7k2rRrYgnrnrNjue3X9Yri1V/4GKEN
 7ngg==
X-Gm-Message-State: APjAAAWRb9LJT8Ldt6tLkyPArqiiJZLgpi0cW8qU8Ra5IWNTExz5yV3D
 OKNFMb6Dpiz3hnpI0i8UiHA=
X-Google-Smtp-Source: APXvYqw/y/RkEoMZqYxFyDiHraPalbf1S/Mb65HmPFEHyF2japhprA/WfbHFcIEP/ANgslQf5+pVTw==
X-Received: by 2002:a17:902:7283:: with SMTP id
 d3mr43675532pll.93.1564792058189; 
 Fri, 02 Aug 2019 17:27:38 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id 23sm80222524pfn.176.2019.08.02.17.27.37
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Fri, 02 Aug 2019 17:27:37 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Fri,  2 Aug 2019 17:27:32 -0700
Message-Id: <1564792052-6469-1-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [PATCH] riscv: sifive_e: Correct various SoC IP block
 sizes
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some of the SoC IP block sizes are wrong. Correct them according
to the FE310 manual.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
---

 hw/riscv/sifive_e.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 2a499d8..9655847 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -53,13 +53,13 @@ static const struct MemmapEntry {
     hwaddr base;
     hwaddr size;
 } sifive_e_memmap[] = {
-    [SIFIVE_E_DEBUG] =    {        0x0,      0x100 },
+    [SIFIVE_E_DEBUG] =    {        0x0,     0x1000 },
     [SIFIVE_E_MROM] =     {     0x1000,     0x2000 },
     [SIFIVE_E_OTP] =      {    0x20000,     0x2000 },
     [SIFIVE_E_CLINT] =    {  0x2000000,    0x10000 },
     [SIFIVE_E_PLIC] =     {  0xc000000,  0x4000000 },
-    [SIFIVE_E_AON] =      { 0x10000000,     0x8000 },
-    [SIFIVE_E_PRCI] =     { 0x10008000,     0x8000 },
+    [SIFIVE_E_AON] =      { 0x10000000,     0x1000 },
+    [SIFIVE_E_PRCI] =     { 0x10008000,     0x1000 },
     [SIFIVE_E_OTP_CTRL] = { 0x10010000,     0x1000 },
     [SIFIVE_E_GPIO0] =    { 0x10012000,     0x1000 },
     [SIFIVE_E_UART0] =    { 0x10013000,     0x1000 },
-- 
2.7.4


