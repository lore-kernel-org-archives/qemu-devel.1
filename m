Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6ACBC04AA7
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 13:24:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61D2E208C2
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 13:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Iau5J0OB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61D2E208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57383 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQAwT-0004rU-Gg
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 09:24:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hQAn3-0005f9-L7
	for qemu-devel@nongnu.org; Mon, 13 May 2019 09:14:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hQAn1-0004sd-9K
	for qemu-devel@nongnu.org; Mon, 13 May 2019 09:14:49 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:35795)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hQAn0-0004ri-LM
	for qemu-devel@nongnu.org; Mon, 13 May 2019 09:14:46 -0400
Received: by mail-oi1-x243.google.com with SMTP id a132so9272485oib.2
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 06:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=cMjzGnLVpq/xIUfb1kG6VVA/5QDnB2YJfyhx77XPFnU=;
	b=Iau5J0OB1acoqv4NGhWEilNM+KrrBitlOkhwzn4Nwgp+SMCsWrXbl59AdmD6hApedk
	XbBr1PFtn32j8VZ1CXVpo+rl9hG0qf5wXVjPXASw+b0jfZSy4OrTwgnNNd0c7pCY1EB3
	RHzmfud2Q1/EYadZ1Yb+QsVaOnlV4Gw5Qts9KujraW7P1y5iC5+M4XWqWBUI3jSI5pca
	7HoGJ9d4gp+ve6ahH0mSjw+/KHtBPEzDzSKsZfrerEsxB4RSjSKQ9g82FEwsLwZZDMn3
	pAAFtcaLd/AJgyp7BBsk9OGQcWuql0nlBkvwRW1iYdLCsU4D8ERLqQIuoT2bg/QZOR1E
	9NfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=cMjzGnLVpq/xIUfb1kG6VVA/5QDnB2YJfyhx77XPFnU=;
	b=WAuMsiWgxwfD8lYKMkkEF1Rp8gSLoAdqzRgOwfXeBsWajul5X7yLr9ln3oYCifHKCn
	OLs8g/SgQ5VW8ZdGO3iXYYhsigKrDKRL0CUbdtLKaBbhBGK+T3PLDniwHtGxfo+tUd6X
	cZVvSQWsNScEy9qaD30Gc3ZnyCdfMVms+AZBBTl2dh/YnIvDhThdN/l3aGfwgM9oGxWR
	/ZaYYg5KnM7PmhokT6f+4a5AOr/vhTKGZVqCFHWLs0AGNmp/PIZgfQAjJvGrKtFGrP1s
	VrE9cOADoL373wcrl1GbG5NfTfb9xNOqeojKGRaugkhKKKq4hJ6E2LDQ0XOkItSCZh6v
	od4w==
X-Gm-Message-State: APjAAAW8bvYxbL5ouiAYnb5DndL2rGy6EE7i7p1x1a2CvvCCDVH9d0EA
	5cE3wn/wC1LKmAp+GgxHvulDcTuSQ80gsr6uBk/JIw==
X-Google-Smtp-Source: APXvYqw46T1KaAmGEyN8Sm1bee2greOSqmZxJRyiK+tiovQDTYbgROmixfaz0sUX461S57H48SrDXB8PhjoozHkcaBs=
X-Received: by 2002:aca:5785:: with SMTP id l127mr12444924oib.48.1557753285412;
	Mon, 13 May 2019 06:14:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190510191051.5973-1-alex.bennee@linaro.org>
In-Reply-To: <20190510191051.5973-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 May 2019 14:14:34 +0100
Message-ID: <CAFEAcA8iZuU+xw--1WLH0=+TzeXrgGF7-rauKMSK_vqp98x0dQ@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] [RFC PATCH] target/arm: semihosting docs,
 formatting and return clean-ups
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 10 May 2019 at 20:10, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> This is a clean-up of the semihosting calls after reading ver 2.0 of
> the specification. There are a number of small fixes that seemed too
> insignificant to split into smaller patches:
>
>   - add reference to the ARM semihosting spec
>   - add some additional commentary on return values
>   - fixup block comments as per standard
>   - audit return values, return 0xdeadbeef for corrupted values
>   - fix up leaks from early returns with lock_user_string
>   - return bytes not written/read instead of -1
>   - add LOG_UNIMP for missing functionality
>
> This is very much a Friday patch. It might be worth splitting up if
> coming back for a more concerted clean-up series for semihosting as
> the asynchronous gdb calls probably need more attention.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  target/arm/arm-semi.c | 180 +++++++++++++++++++++++++-----------------
>  1 file changed, 109 insertions(+), 71 deletions(-)
>
> diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
> index 4c326fdc2fb..8deaed2807c 100644
> --- a/target/arm/arm-semi.c
> +++ b/target/arm/arm-semi.c
> @@ -2,6 +2,7 @@
>   *  Arm "Angel" semihosting syscalls
>   *
>   *  Copyright (c) 2005, 2007 CodeSourcery.
> + *  Copyright (c) 2019 Linaro
>   *  Written by Paul Brook.
>   *
>   *  This program is free software; you can redistribute it and/or modify
> @@ -15,13 +16,19 @@
>   *  GNU General Public License for more details.
>   *
>   *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + *  along with this program; if not, see
> + *  <http://www.gnu.org/licenses/>.
> + *
> + *  ARM Semihosting is documented in:
> + *     Semihosting for AArch32 and AArch64 Release 2.0
> + *     https://static.docs.arm.com/100863/0200/semihosting.pdf
>   */
>
>  #include "qemu/osdep.h"
>
>  #include "cpu.h"
>  #include "exec/semihost.h"
> +#include "exec/log.h"
>  #ifdef CONFIG_USER_ONLY
>  #include "qemu.h"
>
> @@ -241,13 +248,18 @@ static target_ulong arm_gdb_syscall(ARMCPU *cpu, gd=
b_syscall_complete_cb cb,
>       put_user_u64(val, args + (n) * 8) :                \
>       put_user_u32(val, args + (n) * 4))
>
> +/*
> + * Do a semihosting call. Returns the "RETURN REGISTER" which is
> + * documented as corrupted for some calls. In this case we use the
> + * venerable 0xdeadbeef.
> + */

I think what you mean here is something like "the specification always
says that the "return register" either returns a specific value or
is corrupted, so we don't need to report to our caller whether we
are returning a value or trying to leave the register unchanged.
We use 0xdeadbeef as the return value when there isn't a defined
return value for the call."

>  target_ulong do_arm_semihosting(CPUARMState *env)
>  {
>      ARMCPU *cpu =3D arm_env_get_cpu(env);
>      CPUState *cs =3D CPU(cpu);
>      target_ulong args;
>      target_ulong arg0, arg1, arg2, arg3;
> -    char * s;
> +    char *s;
>      int nr;
>      uint32_t ret;
>      uint32_t len;
> @@ -273,9 +285,9 @@ target_ulong do_arm_semihosting(CPUARMState *env)
>          GET_ARG(2);
>          s =3D lock_user_string(arg0);
>          if (!s) {
> -            /* FIXME - should this error code be -TARGET_EFAULT ? */

We definitely don't want to return -TARGET_EFAULT, but we could
in theory call set_swi_errno(ts, EFAULT). The spec says that
it's up to the implementation, effectively, so I think I agree
we don't need to bother. Any caller which has messed things up
sufficiently to be passing us bogus memory is unlikely to be
in a state to successfully call SYS_ERRNO anyway.

>              return (uint32_t)-1;
>          }
> +        /* check for invalid open mode */
>          if (arg1 >=3D 12) {
>              unlock_user(s, arg0, 0);
>              return (uint32_t)-1;
> @@ -287,7 +299,7 @@ target_ulong do_arm_semihosting(CPUARMState *env)
>          }
>          if (use_gdb_syscalls()) {
>              ret =3D arm_gdb_syscall(cpu, arm_semi_cb, "open,%s,%x,1a4", =
arg0,
> -                                  (int)arg2+1, gdb_open_modeflags[arg1])=
;
> +                                  (int) arg2 + 1, gdb_open_modeflags[arg=
1]);

The space after the cast looks a bit odd here.

>          } else {
>              ret =3D set_swi_errno(ts, open(s, open_modeflags[arg1], 0644=
));
>          }
> @@ -301,48 +313,51 @@ target_ulong do_arm_semihosting(CPUARMState *env)
>              return set_swi_errno(ts, close(arg0));
>          }
>      case TARGET_SYS_WRITEC:
> -        {
> -          char c;
> -
> -          if (get_user_u8(c, args))
> -              /* FIXME - should this error code be -TARGET_EFAULT ? */
> -              return (uint32_t)-1;
> -          /* Write to debug console.  stderr is near enough.  */
> -          if (use_gdb_syscalls()) {
> +    {
> +        char c;
> +        if (!get_user_u8(c, args)) {
> +            /* Write to debug console.  stderr is near enough.  */
> +            if (use_gdb_syscalls()) {
>                  return arm_gdb_syscall(cpu, arm_semi_cb, "write,2,%x,1",=
 args);
> -          } else {
> +            } else {
>  #ifdef CONFIG_SOFTMMU
> -              Chardev *chardev =3D semihosting_get_chardev();
> -              if (chardev) {
> -                  return qemu_chr_write_all(chardev, (uint8_t *) &c, 1);
> -              } else
> +                Chardev *chardev =3D semihosting_get_chardev();
> +                if (chardev) {
> +                    return qemu_chr_write_all(chardev, (uint8_t *) &c, 1=
);
> +                }
>  #endif

Looks like this patch is dependent on some other patchset?


> @@ -447,20 +474,23 @@ target_ulong do_arm_semihosting(CPUARMState *env)
>          GET_ARG(3);
>          if (use_gdb_syscalls()) {
>              return arm_gdb_syscall(cpu, arm_semi_cb, "rename,%s,%s",
> -                                   arg0, (int)arg1+1, arg2, (int)arg3+1)=
;
> +                                   arg0, (int)arg1 + 1, arg2, (int)arg3 =
+ 1);
>          } else {
>              char *s2;
>              s =3D lock_user_string(arg0);
>              s2 =3D lock_user_string(arg2);
> -            if (!s || !s2)
> -                /* FIXME - should this error code be -TARGET_EFAULT ? */
> -                ret =3D (uint32_t)-1;
> -            else
> +            if (s && s2) {
>                  ret =3D set_swi_errno(ts, rename(s, s2));
> -            if (s2)
> +            } else {
> +                ret =3D -EIO;

I would stick with -1 personally. The spec says "host-specific error
code", but since there's not a lot the guest can do with the result
anyway we can just use -1 in our implementation. Also, EIO is an
odd choice for "you passed us non-readable memory", which is more
usually EFAULT.

More generally, can you keep changes in behaviour in a separate patch
from code reformatting, please ?

> @@ -472,7 +502,7 @@ target_ulong do_arm_semihosting(CPUARMState *env)
>          GET_ARG(1);
>          if (use_gdb_syscalls()) {
>              return arm_gdb_syscall(cpu, arm_semi_cb, "system,%s",
> -                                   arg0, (int)arg1+1);
> +                                   arg0, (int)arg1 + 1);

...here you don't have the space after the cast. I prefer this way.

thanks
-- PMM

