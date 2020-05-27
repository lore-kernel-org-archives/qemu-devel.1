Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF888C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 12:07:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B92E720657
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 12:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rGAaKGrA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B92E720657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdupz-00051T-UV
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 08:07:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jduos-0004C6-Ij; Wed, 27 May 2020 08:06:02 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:40790)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jduor-0007Bs-85; Wed, 27 May 2020 08:06:02 -0400
Received: by mail-wm1-x341.google.com with SMTP id r15so2759520wmh.5;
 Wed, 27 May 2020 05:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=okXHX6ENcIfDa/2JAcLHym2+LmzF+mNzbsWji9EmUfA=;
 b=rGAaKGrAUMiqpKNbj2uQ8yErDP1LgwsMtqmBatsxaZN6kDg78qqN8FszWzC2uqqTG7
 vvGky2AV83TCl/L7xsQNBI8RX0r1OAnUoj7UAhkgM1lpyCk3XMwdeY3+ehb/868roPZT
 BdJx6ndjrn/Xn8LLuNjPtHRCEGvbuxsnvSgdPK+mi51yXB7+7mq2eDk1PqIJ13kTU2T9
 Irj6tUjakkSwPgKbP6UHVvf5/mMwQhblofC016DFklawoZODtMK9I2qNgY8+I9nXv6ER
 Ra1QKjHfr+mI8VmKki2UWxCl59gbctyrt3duW6I/m9LkmhuYYp24SI9pjsYq/N7oLRQH
 C8qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=okXHX6ENcIfDa/2JAcLHym2+LmzF+mNzbsWji9EmUfA=;
 b=FXpaqNeNa2CB/1HrvcUIIvpymxGkAfVmE8dEDbJOYneBgh5+8oq4uBWKmghqVBNDSP
 ayHAqo6fFWuCzAgRfS+lxHSFslrKO+HQs7M4GlXDKLWafLBbermgcuKIpc2YFWk+iKEi
 N1fvGbC0pq4JZT8veb3Awjkq71VBxxItAuu9aw8OLjNKAtGoiqgwmXssKUQh0gS5ARbj
 mr0ZzvfMjWDKuzfQlfQMcS38o+QYvq3e7yXFFvO7JFRP+A+Dhs0Qq2M7NLSySNnJLpai
 +z6akI3Sx6df9KJp4vwjvbm5g07pnuDXUS1ALlRGMIBnyFzmEa7amUliaLn1n55yAyCC
 RmGw==
X-Gm-Message-State: AOAM531NEEvcBtbkCkEbzs9Te9z82iCcfmjp2WS6COvV+Ih/1WL2Ws1Q
 aJwxfujHHfS3Bd0jILnfk02xevvF2kCg54d9OHs=
X-Google-Smtp-Source: ABdhPJwMhwcbPcNgjY4sEkmFkSyN4n3h085z6p0C5Q0IxQ3e505Q6xod9fI5fxBulM/5Y7X6jjSEYPYqjRzpAU2NWJU=
X-Received: by 2002:a1c:2e16:: with SMTP id u22mr4295840wmu.168.1590581158700; 
 Wed, 27 May 2020 05:05:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200527100546.29297-1-alex.bennee@linaro.org>
 <20200527100546.29297-3-alex.bennee@linaro.org>
In-Reply-To: <20200527100546.29297-3-alex.bennee@linaro.org>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Wed, 27 May 2020 14:05:38 +0200
Message-ID: <CAHiYmc7EJVxKXZ4G96cL-Bm3tT8UR_dgr7y3oisUMnuJ0u3zaw@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] linux-user: deal with address wrap for
 ARM_COMMPAGE on 32 bit
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bug 1880225 <1880225@bugs.launchpad.net>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>,
 qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D1=81=D1=80=D0=B5, 27. =D0=BC=D0=B0=D1=98 2020. =D1=83 12:07 Alex Benn=C3=
=A9e <alex.bennee@linaro.org> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=
=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> We rely on the pointer to wrap when accessing the high address of the
> COMMPAGE so it lands somewhere reasonable. However on 32 bit hosts we
> cannot afford just to map the entire 4gb address range. The old mmap
> trial and error code handled this by just checking we could map both
> the guest_base and the computed COMMPAGE address.
>
> We can't just manipulate loadaddr to get what we want so we introduce
> an offset which pgb_find_hole can apply when looking for a gap for
> guest_base that ensures there is space left to map the COMMPAGE
> afterwards.
>
> This is arguably a little inefficient for the one 32 bit
> value (kuser_helper_version) we need to keep there given all the
> actual code entries are picked up during the translation phase.
>
> Fixes: ee94743034b
> Bug: https://bugs.launchpad.net/qemu/+bug/1880225

For the scenario in this bug report, for today's master, before and after
applying this patch:

BEFORE:

$ ~/Build/qemu-master/build-gcc/arm-linux-user/qemu-arm ./toupper_string-ar=
m
qemu-arm: /home/rtrk/Build/qemu-master/linux-user/elfload.c:2294:
probe_guest_base: Assertion `have_guest_base' failed.
Aborted

AFTER:

$ ~/Build/qemu-master/build-gcc/arm-linux-user/qemu-arm ./toupper_string-ar=
m
CONTROL RESULT: (toupper_string)
 nwlrbbmqbhcdarz owkkyhiddqscdxr jmowfrxsjybldbe fsarcbynecdyggx xpklorelln=
mpapq
 NWLRBBMQBHCDARZ OWKKYHIDDQSCDXR JMOWFRXSJYBLDBE FSARCBYNECDYGGX XPKLORELLN=
MPAPQ

So, it works in my test bed.

Tested-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>

> Cc: Bug 1880225 <1880225@bugs.launchpad.net>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> ---
>  linux-user/elfload.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index d6027867a1a..31defce95b5 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -2145,7 +2145,7 @@ static uintptr_t pgd_find_hole_fallback(uintptr_t g=
uest_size, uintptr_t brk, lon
>
>  /* Return value for guest_base, or -1 if no hole found. */
>  static uintptr_t pgb_find_hole(uintptr_t guest_loaddr, uintptr_t guest_s=
ize,
> -                               long align)
> +                               long align, uintptr_t offset)
>  {
>      GSList *maps, *iter;
>      uintptr_t this_start, this_end, next_start, brk;
> @@ -2171,7 +2171,7 @@ static uintptr_t pgb_find_hole(uintptr_t guest_load=
dr, uintptr_t guest_size,
>
>          this_end =3D ((MapInfo *)iter->data)->start;
>          next_start =3D ((MapInfo *)iter->data)->end;
> -        align_start =3D ROUND_UP(this_start, align);
> +        align_start =3D ROUND_UP(this_start + offset, align);
>
>          /* Skip holes that are too small. */
>          if (align_start >=3D this_end) {
> @@ -2221,6 +2221,7 @@ static void pgb_static(const char *image_name, abi_=
ulong orig_loaddr,
>  {
>      uintptr_t loaddr =3D orig_loaddr;
>      uintptr_t hiaddr =3D orig_hiaddr;
> +    uintptr_t offset =3D 0;
>      uintptr_t addr;
>
>      if (hiaddr !=3D orig_hiaddr) {
> @@ -2234,18 +2235,19 @@ static void pgb_static(const char *image_name, ab=
i_ulong orig_loaddr,
>      if (ARM_COMMPAGE) {
>          /*
>           * Extend the allocation to include the commpage.
> -         * For a 64-bit host, this is just 4GiB; for a 32-bit host,
> -         * the address arithmetic will wrap around, but the difference
> -         * will produce the correct allocation size.
> +         * For a 64-bit host, this is just 4GiB; for a 32-bit host we
> +         * need to ensure there is space bellow the guest_base so we
> +         * can map the commpage in the place needed when the address
> +         * arithmetic wraps around.
>           */
>          if (sizeof(uintptr_t) =3D=3D 8 || loaddr >=3D 0x80000000u) {
>              hiaddr =3D (uintptr_t)4 << 30;
>          } else {
> -            loaddr =3D ARM_COMMPAGE & -align;
> +            offset =3D (128 * KiB);
>          }
>      }
>
> -    addr =3D pgb_find_hole(loaddr, hiaddr - loaddr, align);
> +    addr =3D pgb_find_hole(loaddr, hiaddr - loaddr, align, offset);
>      if (addr =3D=3D -1) {
>          /*
>           * If ARM_COMMPAGE, there *might* be a non-consecutive allocatio=
n
> @@ -2280,7 +2282,7 @@ static void pgb_dynamic(const char *image_name, lon=
g align)
>           * just above that, and maximises the positive guest addresses.
>           */
>          commpage =3D ARM_COMMPAGE & -align;
> -        addr =3D pgb_find_hole(commpage, -commpage, align);
> +        addr =3D pgb_find_hole(commpage, -commpage, align, 0);
>          assert(addr !=3D -1);
>          guest_base =3D addr;
>      }
> --
> 2.20.1
>
>

