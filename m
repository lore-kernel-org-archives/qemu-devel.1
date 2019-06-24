Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41BCCC43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 20:22:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 077F020663
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 20:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gX3ziSrR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 077F020663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54504 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfVTo-000342-58
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 16:22:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60278)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hfVPZ-0000HK-2W
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 16:17:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hfVPX-0003jP-L3
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 16:17:57 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:34429)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hfVPX-0003iA-CY; Mon, 24 Jun 2019 16:17:55 -0400
Received: by mail-lf1-x144.google.com with SMTP id y198so10999752lfa.1;
 Mon, 24 Jun 2019 13:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XUFx98gVxu3TzC5WkbuJv0pECEtV/CNQvI1Rq/Jezdc=;
 b=gX3ziSrRp5ke5UFh61reURcJT3M0RjEx37YNQSoBr6HKIfGl74UAPvlq2va8+KKNKi
 P4+p7hfXIQkNDwwfZWl3YyWd2X17OlDObPQprlgJsQeLuuByl6wwQdXRmFTzyRATCG/5
 cdIuyzF5DFYvnMXWmr+iE89egFqXyp3sz2AMe1fqfOrhpd4yU5mod2oQYS5z+qpyoQ1I
 x515BnVixC5x9RTTSd+c0QRAu4uGalc+baJECNJrvhhf7FUTBGqBkOfWM7tGOwv6FHIj
 pGZUK7SGOFfzjs0mSh7xCaRny4YAOdEImT50bhPVN2wxQc3E01+9mlNMuEgjR3rLWmWl
 kkDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XUFx98gVxu3TzC5WkbuJv0pECEtV/CNQvI1Rq/Jezdc=;
 b=PS3m8ugq9xkE/W8Myeek55Rxdd3xIZ8c2Nk9O5Z6pW7ZyUqpTQfcLFbCuoMIvTx4lB
 2axDgiMeTMEmpWDob4JSgFVj9ShzaLma/Kk6ZGIp1KLczIr9UkJbAeuT2WAxrWLJDOLA
 u1Ck21Rz0+/ArCmO8UWaZfBUDbx1U1C7s4EWANoirz4pgi3i9SvHi+ozUJWmoZQwPjo2
 XJf/3Z5G9rtr5/tv+dLA4ODdNQoDk+e8nI6NonrnciyNNHXnb15kGeDWHG2V7Q3UqzFr
 dW14z6ykU9znt29SwC0A4ber202ZIwMwVsEoP7c2Dsu2CZlytp/qFaWVBvVFnQ2hmzGO
 Hf3w==
X-Gm-Message-State: APjAAAVDlbRgUPeT7zxYEuOW6zqQbSGUlsw8KPN19QNRJohw+/GsAYD5
 F5rvBq4J2X8mL45XauoPvLkEGumxzlC7YuqVj9rwvjvs
X-Google-Smtp-Source: APXvYqwwz6gmQ0tQOmK9qAf7s8eZdJkM7Wajxfkz2QSQhqR9+K0hI4ywwniyQSWavWmup/tml88HS6+0HIQ78BnZuKY=
X-Received: by 2002:a19:bec1:: with SMTP id o184mr46207579lff.86.1561407473978; 
 Mon, 24 Jun 2019 13:17:53 -0700 (PDT)
MIME-Version: 1.0
References: <b9cb270c4356301ca15d6fec3f651da64beb57d3.1560821342.git.alistair.francis@wdc.com>
 <mhng-e848dd5f-d245-421a-aafc-857a10800e30@palmer-si-x1e>
In-Reply-To: <mhng-e848dd5f-d245-421a-aafc-857a10800e30@palmer-si-x1e>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 24 Jun 2019 13:14:59 -0700
Message-ID: <CAKmqyKOa_G+aHmrpsF3UW2e0h=a3bWou8A2dLEbpGFp3+nxj1Q@mail.gmail.com>
To: Palmer Dabbelt <palmer@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::144
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 24, 2019 at 2:31 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Mon, 17 Jun 2019 18:31:08 PDT (-0700), Alistair Francis wrote:
> > Add a comment for the new mcountinhibit which conflicts with the
> > CSR_MUCOUNTEREN from version 1.09.1. This can be updated when we remove
> > 1.09.1.
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >  target/riscv/cpu_bits.h | 1 +
> >  target/riscv/csr.c      | 6 ++++--
> >  2 files changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> > index 47450a3cdb..11f971ad5d 100644
> > --- a/target/riscv/cpu_bits.h
> > +++ b/target/riscv/cpu_bits.h
> > @@ -136,6 +136,7 @@
> >  #define CSR_MCOUNTEREN      0x306
> >
> >  /* Legacy Counter Setup (priv v1.9.1) */
> > +/* Update to #define CSR_MCOUNTINHIBIT 0x320 for 1.11.0 */
> >  #define CSR_MUCOUNTEREN     0x320
> >  #define CSR_MSCOUNTEREN     0x321
> >  #define CSR_MHCOUNTEREN     0x322
> > diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> > index c67d29e206..437387fd28 100644
> > --- a/target/riscv/csr.c
> > +++ b/target/riscv/csr.c
> > @@ -461,18 +461,20 @@ static int write_mcounteren(CPURISCVState *env, int csrno, target_ulong val)
> >      return 0;
> >  }
> >
> > +/* This regiser is replaced with CSR_MCOUNTINHIBIT in 1.11.0 */
> >  static int read_mscounteren(CPURISCVState *env, int csrno, target_ulong *val)
> >  {
> > -    if (env->priv_ver > PRIV_VERSION_1_09_1) {
> > +    if (env->priv_ver > PRIV_VERSION_1_09_1 && env->priv_ver < PRIV_VERSION_1_11_0) {
> >          return -1;
> >      }
> >      *val = env->mcounteren;
> >      return 0;
> >  }
> >
> > +/* This regiser is replaced with CSR_MCOUNTINHIBIT in 1.11.0 */
> >  static int write_mscounteren(CPURISCVState *env, int csrno, target_ulong val)
> >  {
> > -    if (env->priv_ver > PRIV_VERSION_1_09_1) {
> > +    if (env->priv_ver > PRIV_VERSION_1_09_1 && env->priv_ver < PRIV_VERSION_1_11_0) {
> >          return -1;
> >      }
> >      env->mcounteren = val;
>
> I don't think this one is right: this should be unsupported on 1.11, as the
> semantics of this bit are slightly different.  It shouldn't be that hard to
> just emulate it fully for both 1.09.1 and 1.11: for 1.09 this disables access
> to the counters (which still tick), while for 1.11 it disables ticking the
> counters (which can still be accessed).  Since we don't do anything with the
> counters in QEMU, I think this should do it
>
> LMK if you're OK with me replacing the patch with this
>
> commit e9169ccd5ca97a036de41dad23f37f6724712b90
> Author: Alistair Francis <alistair.francis@wdc.com>
> Date:   Mon Jun 17 18:31:08 2019 -0700
>
>     target/riscv: Add the mcountinhibit CSR
>
>     1.11 defines mcountinhibit, which has the same numeric CSR value as
>     mucounteren from 1.09.1 but has different semantics.  This patch enables
>     the CSR for 1.11-based targets, which is trivial to implement because
>     the counters in QEMU never tick (legal according to the spec).
>
>     Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>     [Palmer: Fix counter access semantics, change commit message to indicate
>     the behavior is fully emulated.]
>     Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
>     Signed-off-by: Palmer Dabbelt <palmer@sifive.com>

Yep, looks good.

Alistair

>
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index 47450a3cdb75..11f971ad5df0 100644
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
> index c67d29e20618..2622b2e05474 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -56,6 +56,14 @@ static int fs(CPURISCVState *env, int csrno)
>  static int ctr(CPURISCVState *env, int csrno)
>  {
>  #if !defined(CONFIG_USER_ONLY)
> +    /*
> +     * The counters are always enabled on newer priv specs, as the CSR has
> +     * changed from controlling that the counters can be read to controlling
> +     * that the counters increment.
> +     */
> +    if (env->priv_ver > PRIV_VERSION_1_09_1)
> +        return 0;
> +
>      uint32_t ctr_en = ~0u;
>
>      if (env->priv < PRV_M) {
> @@ -461,18 +469,20 @@ static int write_mcounteren(CPURISCVState *env, int csrno, target_ulong val)
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

