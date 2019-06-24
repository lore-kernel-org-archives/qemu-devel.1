Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 037A6C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 09:34:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAA0C2089F
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 09:34:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAA0C2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49200 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfLMS-0006l5-OT
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 05:34:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57096)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hfLKP-0005i1-TC
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 05:32:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hfLKN-0000WN-GP
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 05:31:57 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38513)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hfLKJ-0000D7-Fh
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 05:31:53 -0400
Received: by mail-pl1-f194.google.com with SMTP id g4so6536534plb.5
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2019 02:31:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=W0G8UeOjcso8Plch7kD+AA0OuDIm7xzN3rImXUDGpfY=;
 b=DM7YdZ3H8EFviBbhynBDqTb1prIG1djrC0/npySd2Yk8T5+Ya5iX0ylDeE8RMv1lTn
 LnaI6eNUKlcZA+Aa7IqBxszpgmNh/HAjp7vnriCYAcjoxC3G0onPFf6iOIPthrM8Lih1
 U2SKBIPNyXJb4o0CgcT72ux2uBe6Aev+H6sFUyGEN5QgX6/FZ0jDr2tB1ljU71pR9thQ
 SRHoRgXCbIqbvkmnzPfyF26Nx3BZI15QkCQRdj+ue4ICpXBgqmNf1FkJcDXxCcab0TN6
 wOpZDtNMhMqSRuCw1xXdOVOwZrddC/FHL4A0HTZzF34+BfXXFQCF8CP0vPFeZ3epgIwh
 O4zw==
X-Gm-Message-State: APjAAAVKMgqbxz4m/7HfUG5RN4PnOpAyeQf1zGX2hMfdXnRDjZCKOrFl
 VB0ywLNamF8A6lFWKmHf3bviyrh7OcBeJw==
X-Google-Smtp-Source: APXvYqwduhZ6O3VThmozQrPRTHtToGNcnAC6dO1xditU7i/RAqJcTkgqjWNVUGcjohCnqH6oVz1m2g==
X-Received: by 2002:a17:902:e40f:: with SMTP id
 ci15mr68842797plb.103.1561368702386; 
 Mon, 24 Jun 2019 02:31:42 -0700 (PDT)
Received: from localhost (220-132-236-182.HINET-IP.hinet.net.
 [220.132.236.182])
 by smtp.gmail.com with ESMTPSA id e188sm789323pfh.99.2019.06.24.02.31.41
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 24 Jun 2019 02:31:41 -0700 (PDT)
Date: Mon, 24 Jun 2019 02:31:41 -0700 (PDT)
X-Google-Original-Date: Mon, 24 Jun 2019 01:23:27 PDT (-0700)
In-Reply-To: <b9cb270c4356301ca15d6fec3f651da64beb57d3.1560821342.git.alistair.francis@wdc.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: Alistair Francis <Alistair.Francis@wdc.com>
Message-ID: <mhng-e848dd5f-d245-421a-aafc-857a10800e30@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.214.194
Subject: Re: [Qemu-devel] [PATCH v1 3/9] target/riscv: Comment in the
 mcountinhibit CSR
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 17 Jun 2019 18:31:08 PDT (-0700), Alistair Francis wrote:
> Add a comment for the new mcountinhibit which conflicts with the
> CSR_MUCOUNTEREN from version 1.09.1. This can be updated when we remove
> 1.09.1.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/cpu_bits.h | 1 +
>  target/riscv/csr.c      | 6 ++++--
>  2 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index 47450a3cdb..11f971ad5d 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -136,6 +136,7 @@
>  #define CSR_MCOUNTEREN      0x306
>
>  /* Legacy Counter Setup (priv v1.9.1) */
> +/* Update to #define CSR_MCOUNTINHIBIT 0x320 for 1.11.0 */
>  #define CSR_MUCOUNTEREN     0x320
>  #define CSR_MSCOUNTEREN     0x321
>  #define CSR_MHCOUNTEREN     0x322
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index c67d29e206..437387fd28 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -461,18 +461,20 @@ static int write_mcounteren(CPURISCVState *env, int csrno, target_ulong val)
>      return 0;
>  }
>
> +/* This regiser is replaced with CSR_MCOUNTINHIBIT in 1.11.0 */
>  static int read_mscounteren(CPURISCVState *env, int csrno, target_ulong *val)
>  {
> -    if (env->priv_ver > PRIV_VERSION_1_09_1) {
> +    if (env->priv_ver > PRIV_VERSION_1_09_1 && env->priv_ver < PRIV_VERSION_1_11_0) {
>          return -1;
>      }
>      *val = env->mcounteren;
>      return 0;
>  }
>
> +/* This regiser is replaced with CSR_MCOUNTINHIBIT in 1.11.0 */
>  static int write_mscounteren(CPURISCVState *env, int csrno, target_ulong val)
>  {
> -    if (env->priv_ver > PRIV_VERSION_1_09_1) {
> +    if (env->priv_ver > PRIV_VERSION_1_09_1 && env->priv_ver < PRIV_VERSION_1_11_0) {
>          return -1;
>      }
>      env->mcounteren = val;

I don't think this one is right: this should be unsupported on 1.11, as the
semantics of this bit are slightly different.  It shouldn't be that hard to
just emulate it fully for both 1.09.1 and 1.11: for 1.09 this disables access
to the counters (which still tick), while for 1.11 it disables ticking the
counters (which can still be accessed).  Since we don't do anything with the
counters in QEMU, I think this should do it

LMK if you're OK with me replacing the patch with this

commit e9169ccd5ca97a036de41dad23f37f6724712b90
Author: Alistair Francis <alistair.francis@wdc.com>
Date:   Mon Jun 17 18:31:08 2019 -0700

    target/riscv: Add the mcountinhibit CSR

    1.11 defines mcountinhibit, which has the same numeric CSR value as
    mucounteren from 1.09.1 but has different semantics.  This patch enables
    the CSR for 1.11-based targets, which is trivial to implement because
    the counters in QEMU never tick (legal according to the spec).

    Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
    [Palmer: Fix counter access semantics, change commit message to indicate
    the behavior is fully emulated.]
    Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
    Signed-off-by: Palmer Dabbelt <palmer@sifive.com>

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 47450a3cdb75..11f971ad5df0 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -136,6 +136,7 @@
 #define CSR_MCOUNTEREN      0x306

 /* Legacy Counter Setup (priv v1.9.1) */
+/* Update to #define CSR_MCOUNTINHIBIT 0x320 for 1.11.0 */
 #define CSR_MUCOUNTEREN     0x320
 #define CSR_MSCOUNTEREN     0x321
 #define CSR_MHCOUNTEREN     0x322
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index c67d29e20618..2622b2e05474 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -56,6 +56,14 @@ static int fs(CPURISCVState *env, int csrno)
 static int ctr(CPURISCVState *env, int csrno)
 {
 #if !defined(CONFIG_USER_ONLY)
+    /*
+     * The counters are always enabled on newer priv specs, as the CSR has
+     * changed from controlling that the counters can be read to controlling
+     * that the counters increment.
+     */
+    if (env->priv_ver > PRIV_VERSION_1_09_1)
+        return 0;
+
     uint32_t ctr_en = ~0u;

     if (env->priv < PRV_M) {
@@ -461,18 +469,20 @@ static int write_mcounteren(CPURISCVState *env, int csrno, target_ulong val)
     return 0;
 }

+/* This regiser is replaced with CSR_MCOUNTINHIBIT in 1.11.0 */
 static int read_mscounteren(CPURISCVState *env, int csrno, target_ulong *val)
 {
-    if (env->priv_ver > PRIV_VERSION_1_09_1) {
+    if (env->priv_ver > PRIV_VERSION_1_09_1 && env->priv_ver < PRIV_VERSION_1_11_0) {
         return -1;
     }
     *val = env->mcounteren;
     return 0;
 }

+/* This regiser is replaced with CSR_MCOUNTINHIBIT in 1.11.0 */
 static int write_mscounteren(CPURISCVState *env, int csrno, target_ulong val)
 {
-    if (env->priv_ver > PRIV_VERSION_1_09_1) {
+    if (env->priv_ver > PRIV_VERSION_1_09_1 && env->priv_ver < PRIV_VERSION_1_11_0) {
         return -1;
     }
     env->mcounteren = val;

