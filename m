Return-Path: <SRS0=rbQy=SV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D31BC282DA
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 15:42:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62B47222D3
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 15:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oberlin-edu.20150623.gappssmtp.com header.i=@oberlin-edu.20150623.gappssmtp.com header.b="RA/J0VnL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62B47222D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=oberlin.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58059 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHVeQ-0001Lq-77
	for qemu-devel@archiver.kernel.org; Fri, 19 Apr 2019 11:42:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hHVdH-0000mR-9m
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 11:40:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hHVdG-0001dY-6O
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 11:40:55 -0400
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143]:50515)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stephen.checkoway@oberlin.edu>)
	id 1hHVdF-0001cp-R9
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 11:40:54 -0400
Received: by mail-it1-x143.google.com with SMTP id q14so1222796itk.0
	for <qemu-devel@nongnu.org>; Fri, 19 Apr 2019 08:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=oberlin-edu.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=7zqS2468sT/HtISYB7AAYD8azC667R2g/p5gFYHkaPE=;
	b=RA/J0VnLQievAa8YV5gFDgDFEDG+GF0UvMGCw8OO/4W3MWuGI548yNG3L3vGmkcFPA
	KrytLgINElecr0gGSKWpRcLJSPc7FifO/2dtgOzodIutrF08lSU7T8SiZrH3zR9+6ZJW
	GA1nr3yeIvp2GhCe8HeREdNN7Odg+9OcymbTVeR/yIs1A57RplG0Wbx96dbRVis/1xez
	PzyVUg7QAxz3e5kAJkBlUfZpti2pJ0je5ffif5d1u9rfzUnNODITxfsyv2C3rwFfeD92
	PJ0CJ+y438y6jFx1uPWt7BYMIGzpw3SXDvfmEsy0P/TBK6H81/yPM/eBeCyUeLhbt/32
	CHMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=7zqS2468sT/HtISYB7AAYD8azC667R2g/p5gFYHkaPE=;
	b=i54pDCO5MGMWs/ru6OjfGTlSoTsXGgahPQ0DZTCj8mk0D71RpnSpeyrGpywL1gcPqP
	PQHJGCrba5erU3563ODcPUZUcbV2Bw2wtDfnziBcYwgIdN9ZtjIIPJoFFdKvoZ/vMO3r
	dYUXMVblxlHdAAaJEdM2zXPExBFa8wPFE2lNizn+SoTv/1oFP1rOtei8TsQ62Gi9D79F
	QDaSbcmMKWg59NHJz7ZzkeRuaKvxT+3TTs1HWg+wl3iq6aLmMgKBS1kwJxHLdjTIlkoU
	NxNuU2VATDkqLoJXSs0o4EZAZ/d/bH+UzNvuX6zFvCxzuhEQmukrV/2dDd37Rs/Fa5FG
	0x7g==
X-Gm-Message-State: APjAAAXwDhhjExzjkbVXmeazFr7VZ7llxs8P2KmKvd1A5Ash/J5yZzbA
	x7DkE8WPRLMoZtwyMEIFB4l8jw==
X-Google-Smtp-Source: APXvYqxfEOYKQz7U56VO37UbsLPATlQlt8gjVfj0UOhpvmZwXNDRzSpWY0yOoVAQfhwy/8lo+oExeg==
X-Received: by 2002:a24:ee83:: with SMTP id b125mr3801829iti.43.1555688452779; 
	Fri, 19 Apr 2019 08:40:52 -0700 (PDT)
Received: from worksec.wireless.oberlin.edu (ip-70-93.wireless.oberlin.edu.
	[132.162.70.93]) by smtp.gmail.com with ESMTPSA id
	t67sm2487587ita.35.2019.04.19.08.40.51
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 19 Apr 2019 08:40:52 -0700 (PDT)
From: Stephen Checkoway <stephen.checkoway@oberlin.edu>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
	qemu-trivial@nongnu.org,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri, 19 Apr 2019 11:40:41 -0400
Message-Id: <20190419154041.77802-1-stephen.checkoway@oberlin.edu>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::143
Subject: [Qemu-devel] [PATCH v3] hw/char/escc: Lower irq when transmit
 buffer is filled
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
Cc: Stephen Checkoway <stephen.checkoway@oberlin.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190419154041.GunyaLGlGAW0TrxSbuNjjYxbymBjMJEQeOdjr0DCvuM@z>

The SCC/ESCC will briefly stop asserting an interrupt when the
transmit FIFO is filled.

This code doesn't model the transmit FIFO/shift register so the
pending transmit interrupt is never deasserted which means that an
edge-triggered interrupt controller will never see the low-to-high
transition it needs to raise another interrupt. The practical
consequence of this is that guest firmware with an interrupt service
routine for the ESCC that does not send all of the data it has
immediately will stop sending data if the following sequence of
events occurs:
1. Disable processor interrupts
2. Write a character to the ESCC
3. Add additional characters to a buffer which is drained by the ISR
4. Enable processor interrupts

In this case, the first character will be sent, the interrupt will
fire and the ISR will output the second character. Since the pending
transmit interrupt remains asserted, no additional interrupts will
ever fire.

This behavior was triggered by firmware for an embedded system with a
Z85C30 which necessitated this patch.

This patch fixes that situation by explicitly lowering the IRQ when a
character is written to the buffer and no other interrupts are currently
pending.

Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---

I added a sentence about the Z85C30 necessitating this to the commit message.

 hw/char/escc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/char/escc.c b/hw/char/escc.c
index 628f5f81f7..c5b05a63f1 100644
--- a/hw/char/escc.c
+++ b/hw/char/escc.c
@@ -509,6 +509,13 @@ static void escc_mem_write(void *opaque, hwaddr addr,
         break;
     case SERIAL_DATA:
         trace_escc_mem_writeb_data(CHN_C(s), val);
+        /*
+         * Lower the irq when data is written to the Tx buffer and no other
+         * interrupts are currently pending. The irq will be raised again once
+         * the Tx buffer becomes empty below.
+         */
+        s->txint = 0;
+        escc_update_irq(s);
         s->tx = val;
         if (s->wregs[W_TXCTRL2] & TXCTRL2_TXEN) { // tx enabled
             if (qemu_chr_fe_backend_connected(&s->chr)) {
-- 
2.20.1 (Apple Git-117)


