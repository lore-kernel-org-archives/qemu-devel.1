Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABEDC04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 15:54:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B783A2087F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 15:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AtL0d3H8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B783A2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58519 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNfwO-0005wF-03
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 11:54:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fintelia@gmail.com>) id 1hNfvW-0005cf-Uy
	for qemu-devel@nongnu.org; Mon, 06 May 2019 11:53:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fintelia@gmail.com>) id 1hNfvV-0008Nt-SE
	for qemu-devel@nongnu.org; Mon, 06 May 2019 11:53:14 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:33372)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <fintelia@gmail.com>)
	id 1hNfvV-0008L5-Kb; Mon, 06 May 2019 11:53:13 -0400
Received: by mail-lj1-x241.google.com with SMTP id f23so11559431ljc.0;
	Mon, 06 May 2019 08:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:from:date:message-id:subject:to:cc;
	bh=KHavCqKvy5hytza/0TzF9855TIZSWm0TzjfnbXQH0cw=;
	b=AtL0d3H81swLS4uZt18XiT02PWvQ7TTncUH0e3VYMlljn8XPo/O6MZXoZ+zvHulxMk
	AAaYPmYdHa4LA8WoSteZ2GdpC0KVB4YDNdWrqnZ+PaCUGzveM7C9kdMjqzw741EMuBl8
	DJxyR6YauFruSUmFMee8Ya5WZsM4VXabUnqpi958sezCNm/NARWYZi9aYktrozB3llcd
	YA+1qE8VLfsKnuCSTwcZFJ0fw6OMZD6T2b36BhPgFVw1gUpYh6mMOrdZtnv7vRCZ+35e
	rfUaRXSWKm0YA1huKCtvoKu7UtEp1VzJlAmUy0HqOkTdz4mFGO/7Wy/D5fouv9aL7yII
	s21Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
	bh=KHavCqKvy5hytza/0TzF9855TIZSWm0TzjfnbXQH0cw=;
	b=drBCqpz2Pc4UdTxZyFcJhVLgwdT2LXRwRTL6PZdGNaL/vV9p2HQ9kokKbyIQt5G1hC
	38lXNAhD3BKs8M6yLhY8wR/nzPto8OYd3R5RGZ9pcD7vtsyj9bTUHOJuAqhEprijW/g0
	RfCRXWg5ytvGtV64+fS6D2cUWPw4SSwZbfMjE4PKDE9OTreoSQbg/ABRJsCnwZt+Eud6
	aafCpkUMwIuVTEBas1MoAKpY6QTpR0dbkzxQqKLyJ7syCQ5Mk/X84oUu/BOGiyxfTByV
	Y9U5/uTSAy532R+qJB4IF+tWby0Sk6GQSc7L54oa5JHfyjyR3qtmeE/8OxhBSC1qlsU7
	67Kg==
X-Gm-Message-State: APjAAAWqtNID8hUQkQ+MS+zb5JaAMWPF4XNUUJ/0rjjc5uLTmFKMzmWi
	6Cqfb2W1lDt7yvxwebuZ846VyeHsv9v19KUkIt/c6kEy
X-Google-Smtp-Source: APXvYqxeKzabLDw6/7De7vQ6oF/DFmc0qw+VGkv3cVndTzmTVb40jxAslvoBJyLtY5DuzAGmtLJe9l8X5q1moeBlos0=
X-Received: by 2002:a2e:84ce:: with SMTP id q14mr14315801ljh.80.1557157989829; 
	Mon, 06 May 2019 08:53:09 -0700 (PDT)
MIME-Version: 1.0
From: Jonathan Behrens <fintelia@gmail.com>
Date: Mon, 6 May 2019 11:52:43 -0400
Message-ID: <CANnJOVHd1aFR2tiORJmZ2h3xa+t8djToUEom4WSy=4vBcOjegg@mail.gmail.com>
To: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::241
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: [Qemu-devel] [PATCH for 4.1] target/riscv: More accurate handling
 of `sip` CSR
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
	Palmer Dabbelt <palmer@sifive.com>,
	"open list:RISC-V" <qemu-riscv@nongnu.org>,
	Sagar Karandikar <sagark@eecs.berkeley.edu>,
	Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

According to the spec, "All bits besides SSIP, USIP, and UEIP in the sip
register are read-only." Further, if an interrupt is not delegated to mode
x,
then "the corresponding bits in xip [...] should appear to be hardwired to
zero. This patch implements both of those requirements.

Signed-off-by: Jonathan Behrens <fintelia@gmail.com>
---
 target/riscv/csr.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 1ec1222da1..fff7d834e8 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -246,6 +246,7 @@ static const target_ulong sstatus_v1_9_mask =
SSTATUS_SIE | SSTATUS_SPIE |
 static const target_ulong sstatus_v1_10_mask = SSTATUS_SIE | SSTATUS_SPIE |
     SSTATUS_UIE | SSTATUS_UPIE | SSTATUS_SPP | SSTATUS_FS | SSTATUS_XS |
     SSTATUS_SUM | SSTATUS_MXR | SSTATUS_SD;
+static const target_ulong sip_writable_mask = SIP_SSIP | MIP_USIP |
MIP_UEIP;

 #if defined(TARGET_RISCV32)
 static const char valid_vm_1_09[16] = {
@@ -694,8 +695,10 @@ static int write_sbadaddr(CPURISCVState *env, int
csrno, target_ulong val)
 static int rmw_sip(CPURISCVState *env, int csrno, target_ulong *ret_value,
                    target_ulong new_value, target_ulong write_mask)
 {
-    return rmw_mip(env, CSR_MSTATUS, ret_value, new_value,
-                   write_mask & env->mideleg);
+    int ret = rmw_mip(env, CSR_MSTATUS, ret_value, new_value,
+                      write_mask & env->mideleg & sip_writable_mask);
+    *ret_value &= env->mideleg;
+    return ret;
 }

 /* Supervisor Protection and Translation */
-- 
2.20.1
