Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 986ACC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 13:29:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61C3E21835
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 13:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="viKVwkdO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61C3E21835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itX7G-0003TH-9K
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 08:29:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33138)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1itX5D-00026D-6B
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 08:27:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1itX5C-0008Ty-0e
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 08:27:11 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:36637)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1itX5B-0008TJ-PT
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 08:27:09 -0500
Received: by mail-wm1-x341.google.com with SMTP id p17so14733403wma.1
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 05:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=0ZjGdMWOXKWSNvxjzI89CvJnoPIJwoJ9oFTthJFliaA=;
 b=viKVwkdOQ9Bfjl2ejw8w1fhpB+0d0owK7OGy1m77Ab3o0QCl/WDxde3CqyqXoF0MjS
 gUYU+MMvu3E4VHJCN4XU/aKKhX68tHWBHvKXWXWJoEAMMcW8zRlGbvWPua2s+wv4e1dU
 TwFUi4y6ayaGPVq+8BFfP5QQPaXBtt5ASv6crlz5K580lRne5lQ2HOiQ5GC/jxIrYw6a
 r2asrnb78X+q9CDbz724Um1BwdwIkKE2C3CY3IQFtsw6KnFT5aL9N/HjmutIq8HBDTn/
 om/kM5O77C+Sdlf0wi/S+I8R2RnDJV4z3+qwE31zBzVVCj4TepLQDTEQDHvv7/fMPr/U
 uVKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=0ZjGdMWOXKWSNvxjzI89CvJnoPIJwoJ9oFTthJFliaA=;
 b=QjhbIi46CfjRG2rjqL63JtZT1KTvXdSEdDRye618zQIwbLdST+Y4qHZm85NXv1FNFy
 18N300spmUeo6IHwhhNGxiy+028tSfRDsbY/cu7iR8JXm5bp9TQEusy1xxjCU5+A1jjI
 aLUOOjyeV34rGZCAh/TkE9MlzCajr01LqpJ24kAkcj49O4w+gUGuGRYx0K/ZRSyFLqPl
 fp//8JY0AIy1fP4XtoLKu6EmvUvefFI+74Xm0j1DuTf3B8v3XVWrRKjvQT4y+alsQJg3
 fD41b1JR0sxffz+Q6wdwCNwVi622bZc0DzIIZ+6D0EJBFNc/BFgHHmEZEow9MR8LkK/5
 6+pw==
X-Gm-Message-State: APjAAAXn4q03AKs7dMOsvVlmgQasWuL5kaGjzX2kD5giGtmKeOVfbrUJ
 CVxYV1OPib+E0PRiohyNj5J4Qw==
X-Google-Smtp-Source: APXvYqyAFdT7ohtsYOlc/D4XKx8XCwluYoH0Le/ktVtoTcRV0BGdXZ/wK9aJQPD4rRs1ri9dR5r+2Q==
X-Received: by 2002:a1c:f001:: with SMTP id a1mr18218424wmb.76.1579526828180; 
 Mon, 20 Jan 2020 05:27:08 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z187sm1608104wme.16.2020.01.20.05.27.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2020 05:27:06 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3E39C1FF87;
 Mon, 20 Jan 2020 13:27:06 +0000 (GMT)
References: <20200116194341.402-1-richard.henderson@linaro.org>
 <20200116194341.402-6-richard.henderson@linaro.org>
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 5/5] linux-user: Flush out implementation of
 gettimeofday
In-reply-to: <20200116194341.402-6-richard.henderson@linaro.org>
Date: Mon, 20 Jan 2020 13:27:06 +0000
Message-ID: <87sgka2r85.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: qemu-devel@nongnu.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> The first argument, timeval, is allowed to be NULL.
>
> The second argument, timezone, was missing.  While its use is
> deprecated, it is still present in the syscall.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  linux-user/syscall.c | 27 +++++++++++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
>
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index eb867a5296..628b4de9a1 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -1219,6 +1219,23 @@ static inline abi_long host_to_target_timespec64(a=
bi_ulong target_addr,
>      return 0;
>  }
>=20=20
> +static inline abi_long copy_to_user_timezone(abi_ulong target_tz_addr,
> +                                             struct timezone *tz)
> +{
> +    struct target_timezone *target_tz;
> +
> +    if (!lock_user_struct(VERIFY_WRITE, target_tz, target_tz_addr, 1)) {
> +        return -TARGET_EFAULT;
> +    }
> +
> +    __put_user(tz->tz_minuteswest, &target_tz->tz_minuteswest);
> +    __put_user(tz->tz_dsttime, &target_tz->tz_dsttime);
> +
> +    unlock_user_struct(target_tz, target_tz_addr, 1);
> +
> +    return 0;
> +}
> +
>  static inline abi_long copy_from_user_timezone(struct timezone *tz,
>                                                 abi_ulong target_tz_addr)
>  {
> @@ -8567,10 +8584,16 @@ static abi_long do_syscall1(void *cpu_env, int nu=
m, abi_long arg1,
>      case TARGET_NR_gettimeofday:
>          {
>              struct timeval tv;
> -            ret =3D get_errno(gettimeofday(&tv, NULL));
> +            struct timezone tz;
> +
> +            ret =3D get_errno(gettimeofday(&tv, &tz));
>              if (!is_error(ret)) {
> -                if (copy_to_user_timeval(arg1, &tv))
> +                if (arg1 && copy_to_user_timeval(arg1, &tv)) {
>                      return -TARGET_EFAULT;
> +                }
> +                if (arg2 && copy_to_user_timezone(arg2, &tz)) {
> +                    return -TARGET_EFAULT;
> +                }
>              }
>          }
>          return ret;


--=20
Alex Benn=C3=A9e

