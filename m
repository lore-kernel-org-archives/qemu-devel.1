Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525CCC33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 10:57:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CF89207FF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 10:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zmPubKxX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CF89207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irJt6-0006H4-B9
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 05:57:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46757)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1irJs8-0005Rb-Ce
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 05:56:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1irJs7-0004rO-9U
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 05:56:32 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36029)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1irJs7-0004r7-3j
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 05:56:31 -0500
Received: by mail-wr1-x441.google.com with SMTP id z3so11695517wru.3
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 02:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=hS13Wu7+mzZ+GlHf5cUGX6yM4S3F3bHkWQI9wBoGud0=;
 b=zmPubKxXk0bj27Pp3gBGiXQlRDfgk0jaU8BlnwcNKsbC0EzLpHAJx6a3Oo7NCRtR8/
 1Jt7v80/OSzcQH8vW8S/9UFcm7A/k+5qV4bFmiPzz9tXl7ga8m4RkM0BBruyLvqZBP2X
 T4fpHygfJKvlIFVkfPytLykI7bDZpgPu1PXZRTkRaHSo93BcDxz9E4i4YfjC/91ybOiP
 D9sQ1NoGZ+P66CuXAw7LXvvlAOuUa2SrIIyTRZ/9zE4DOcQLLlTBRfYhsVVe39Z/I8HD
 B3YBFQl/+nUrAjwpmbWXGClvax4G8sNcLz3oMb/VQq3rNQPd8jMYIivKa+LXyXR6D1D3
 XWWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=hS13Wu7+mzZ+GlHf5cUGX6yM4S3F3bHkWQI9wBoGud0=;
 b=SROgENrhuu3W7Ox7xf9wtTnhonQF93GY8nlpmLczwzBPZwDHHOyHJ2KUyM5AvAfDbx
 zvyOdC8MTSdog858slhrVIMXHcWm9ZMz76YZ9WgfOdtuXf3BXe1xtshzQPaoKkJgWE2M
 1a7JJGwddbAN5ASsoAYezfVJh5Ltrv5Ye5Pfrn+ypozx5rsnq+V9wnRe/RUpiPaBizZS
 27g2ArXwF5jxzLK8ulELCLjGmIrcnUcVzOX5rJnOqWO/riT3aBhwKBQtBqC93P/sZz/W
 +QQxCx90R9pf/mLIld41vj+NU6V415zUMPodSf49ewz3URLHkq4PCtW66P1ET5jWqYiz
 By2g==
X-Gm-Message-State: APjAAAVm6d3fwTKfvJAQyB/+ZGM+9+LqZJa488rQUhfiEEtBvfKJGJdX
 7zQpW1H3WyI9JkGnK/dfMAFB6w==
X-Google-Smtp-Source: APXvYqxy9YbwF4BjfdKM6DFzyeWGQUkpcEFtHxy1Ip0BvaSWQqEJcrFY/rmFtCbnoOZ1rtjIbKQJWA==
X-Received: by 2002:a5d:6406:: with SMTP id z6mr22908423wru.294.1578999389998; 
 Tue, 14 Jan 2020 02:56:29 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a1sm17949889wmj.40.2020.01.14.02.56.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2020 02:56:28 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 68EA51FF87;
 Tue, 14 Jan 2020 10:56:28 +0000 (GMT)
References: <20200114030138.260347-1-jkz@google.com>
 <20200114030138.260347-4-jkz@google.com>
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Josh Kunz <jkz@google.com>
Subject: Re: [PATCH 3/4] linux-user: remove gemu_log from the linux-user tree
In-reply-to: <20200114030138.260347-4-jkz@google.com>
Date: Tue, 14 Jan 2020 10:56:28 +0000
Message-ID: <87k15umhlv.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: armbru@redhat.com, riku.voipio@iki.fi, qemu-devel@nongnu.org,
 laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Josh Kunz <jkz@google.com> writes:

> Now that all uses have been migrated to `qemu_log' it is no longer
> needed.
>
> Signed-off-by: Josh Kunz <jkz@google.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  linux-user/main.c | 9 ---------
>  linux-user/qemu.h | 1 -
>  2 files changed, 10 deletions(-)
>
> diff --git a/linux-user/main.c b/linux-user/main.c
> index 0bf40c4d27..945b6adf3a 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -108,15 +108,6 @@ const char *qemu_uname_release;
>     by remapping the process stack directly at the right place */
>  unsigned long guest_stack_size =3D 8 * 1024 * 1024UL;
>=20=20
> -void gemu_log(const char *fmt, ...)
> -{
> -    va_list ap;
> -
> -    va_start(ap, fmt);
> -    vfprintf(stderr, fmt, ap);
> -    va_end(ap);
> -}
> -
>  #if defined(TARGET_I386)
>  int cpu_get_pic_interrupt(CPUX86State *env)
>  {
> diff --git a/linux-user/qemu.h b/linux-user/qemu.h
> index 02c6890c8a..329b409e65 100644
> --- a/linux-user/qemu.h
> +++ b/linux-user/qemu.h
> @@ -210,7 +210,6 @@ abi_long do_syscall(void *cpu_env, int num, abi_long =
arg1,
>                      abi_long arg2, abi_long arg3, abi_long arg4,
>                      abi_long arg5, abi_long arg6, abi_long arg7,
>                      abi_long arg8);
> -void gemu_log(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
>  extern __thread CPUState *thread_cpu;
>  void cpu_loop(CPUArchState *env);
>  const char *target_strerror(int err);


--=20
Alex Benn=C3=A9e

