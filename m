Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85CCC5DF63
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 22:04:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F0642173E
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 22:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEwh94m/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F0642173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSTPT-0007P2-QJ
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 17:04:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58623)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iSTMf-0005pQ-42
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 17:01:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iSTMc-0000UP-KA
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 17:01:21 -0500
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:32957)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iSTMb-0000RU-1Z
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 17:01:17 -0500
Received: by mail-lf1-x142.google.com with SMTP id y9so3192457lfy.0
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2019 14:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=b2mWrlL2otSiwxS3oiF589so9+hzkcrfqSVnDK9V6w8=;
 b=WEwh94m/d+0chz+BvQ0TQ9HBOhDLIX0zuOT8MK3CEW3HMxX8P0ccqIAcdRGPVo5YEi
 p8kuBZ0ZKLzTd3PY8rBucz1oQqBc643Ut6tFYzgTn+xyOy54Xu3m7U+8xpyWiE5+MKsu
 LpHRGQfFJrkoMIdR86ATVoRVR/xJCXuswgAxj5opM1REgwotMBNd5GYfxbLeOMJyRy7i
 hUoHxDbzN+bvN/bHYAUIgBGZAeHl9r8Nfq4qzQQAbKkOLPkJ75ZwPAz1a32zy+kXnVn7
 1OeWc2ymdt0IlluBFkS1T4RODcs4hrrit743RNCPuZRaYjPSlWF453tNFDs1J+C67sqI
 1keQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=b2mWrlL2otSiwxS3oiF589so9+hzkcrfqSVnDK9V6w8=;
 b=Ddct3bdRpwSIQkvcwwHe5sTIK1A10z1d115myvrBvwezmK74uiYY5PDyXK8FYG7wPf
 /+VX7iNXCRz58v8zllLeHzAOH2/tFlDqHMt4YrTGl0baSvoAFoMwFWyQJyI4Sqi+/N20
 6eP9sQ44/7e2/6B/y28Pxfk71QKjTRO0p911H4qGHakmVpAP0qL9L3M7N39etEAfwhyT
 8x7tdXpwDEDLE+3zzL8huQ6/m0hSJDt3jhJuf9zya97cgFfacuoUpXaBTy9yMtYfbBCM
 oB1KTeNVBcyeng0yy369qk81jwqbBNgpv6KfzekJqFX+LStnFCawaBv4yLbCuzaKxRIQ
 IRGg==
X-Gm-Message-State: APjAAAWwDA5A6IEZjZNJkJMRvq8JfZdjUrU6OcMN9lN6y9OYuLcXyl93
 nLuxFnYB5uE2abhTHAXydDkXOwHfr8Ld4NeQa4Y=
X-Google-Smtp-Source: APXvYqwNSeNNdqr2npUnAh5cDie5vJcRJQsI/KWyQ7WHgBpk9SkRoNhSqaSmHKAwpexgyJLZSbxxQTTDleulw5f9n1I=
X-Received: by 2002:ac2:4a8f:: with SMTP id l15mr25679731lfp.5.1573077673702; 
 Wed, 06 Nov 2019 14:01:13 -0800 (PST)
MIME-Version: 1.0
References: <20191106141424.27244-1-edgar.iglesias@gmail.com>
 <20191106141424.27244-2-edgar.iglesias@gmail.com>
In-Reply-To: <20191106141424.27244-2-edgar.iglesias@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 6 Nov 2019 13:55:31 -0800
Message-ID: <CAKmqyKM1K9O++2rRK7Pj3PdQ6YZ53NQ_WxEkZFori=9Q0-_jkg@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] target/microblaze: Plug temp leaks for loads/stores
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::142
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
Cc: figlesia@xilinx.com, Peter Maydell <peter.maydell@linaro.org>,
 Edgar Iglesias <edgar.iglesias@xilinx.com>,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Francisco Iglesias <frasse.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 6, 2019 at 6:14 AM Edgar E. Iglesias
<edgar.iglesias@gmail.com> wrote:
>
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> Plug TCG temp leaks for loads/stores.
>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/microblaze/translate.c | 30 ++++++++++++++++++++++++------
>  1 file changed, 24 insertions(+), 6 deletions(-)
>
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> index 761f535357..ba143ede5f 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -967,12 +967,14 @@ static void dec_load(DisasContext *dc)
>                     10 -> 10
>                     11 -> 00 */
>                  TCGv low = tcg_temp_new();
> +                TCGv t3 = tcg_const_tl(3);
>
>                  tcg_gen_andi_tl(low, addr, 3);
> -                tcg_gen_sub_tl(low, tcg_const_tl(3), low);
> +                tcg_gen_sub_tl(low, t3, low);
>                  tcg_gen_andi_tl(addr, addr, ~3);
>                  tcg_gen_or_tl(addr, addr, low);
>                  tcg_temp_free(low);
> +                tcg_temp_free(t3);
>                  break;
>              }
>
> @@ -1006,9 +1008,16 @@ static void dec_load(DisasContext *dc)
>      tcg_gen_qemu_ld_i32(v, addr, mem_index, mop);
>
>      if ((dc->cpu->env.pvr.regs[2] & PVR2_UNALIGNED_EXC_MASK) && size > 1) {
> +        TCGv_i32 t0 = tcg_const_i32(0);
> +        TCGv_i32 treg = tcg_const_i32(dc->rd);
> +        TCGv_i32 tsize = tcg_const_i32(size - 1);
> +
>          tcg_gen_movi_i64(cpu_SR[SR_PC], dc->pc);
> -        gen_helper_memalign(cpu_env, addr, tcg_const_i32(dc->rd),
> -                            tcg_const_i32(0), tcg_const_i32(size - 1));
> +        gen_helper_memalign(cpu_env, addr, treg, t0, tsize);
> +
> +        tcg_temp_free_i32(t0);
> +        tcg_temp_free_i32(treg);
> +        tcg_temp_free_i32(tsize);
>      }
>
>      if (ex) {
> @@ -1100,12 +1109,14 @@ static void dec_store(DisasContext *dc)
>                     10 -> 10
>                     11 -> 00 */
>                  TCGv low = tcg_temp_new();
> +                TCGv t3 = tcg_const_tl(3);
>
>                  tcg_gen_andi_tl(low, addr, 3);
> -                tcg_gen_sub_tl(low, tcg_const_tl(3), low);
> +                tcg_gen_sub_tl(low, t3, low);
>                  tcg_gen_andi_tl(addr, addr, ~3);
>                  tcg_gen_or_tl(addr, addr, low);
>                  tcg_temp_free(low);
> +                tcg_temp_free(t3);
>                  break;
>              }
>
> @@ -1124,6 +1135,10 @@ static void dec_store(DisasContext *dc)
>
>      /* Verify alignment if needed.  */
>      if ((dc->cpu->env.pvr.regs[2] & PVR2_UNALIGNED_EXC_MASK) && size > 1) {
> +        TCGv_i32 t1 = tcg_const_i32(1);
> +        TCGv_i32 treg = tcg_const_i32(dc->rd);
> +        TCGv_i32 tsize = tcg_const_i32(size - 1);
> +
>          tcg_gen_movi_i64(cpu_SR[SR_PC], dc->pc);
>          /* FIXME: if the alignment is wrong, we should restore the value
>           *        in memory. One possible way to achieve this is to probe
> @@ -1131,8 +1146,11 @@ static void dec_store(DisasContext *dc)
>           *        the alignment checks in between the probe and the mem
>           *        access.
>           */
> -        gen_helper_memalign(cpu_env, addr, tcg_const_i32(dc->rd),
> -                            tcg_const_i32(1), tcg_const_i32(size - 1));
> +        gen_helper_memalign(cpu_env, addr, treg, t1, tsize);
> +
> +        tcg_temp_free_i32(t1);
> +        tcg_temp_free_i32(treg);
> +        tcg_temp_free_i32(tsize);
>      }
>
>      if (ex) {
> --
> 2.20.1
>
>

