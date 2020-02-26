Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4DDC4BA24
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 22:01:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 865A021D7E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 22:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n7WttgQx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 865A021D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j74k6-0000K2-MP
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 17:01:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48853)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1j74jE-0007rb-II
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 17:00:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1j74jC-0004Fe-TU
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 17:00:28 -0500
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:46713)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1j74jC-0004Ec-Jy; Wed, 26 Feb 2020 17:00:26 -0500
Received: by mail-il1-x142.google.com with SMTP id t17so497272ilm.13;
 Wed, 26 Feb 2020 14:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/Q+xYwkm6ri94nuzgMOTuFQwr8uB85kmkJI+QSjsZs0=;
 b=n7WttgQxsj7u2eJGFQfttOpWRlqg/GeDFKcPFB4QZKLVvewwG6gKFvPOqxJg8ZoUwh
 /8wVwPp3uHExn8TtfhiYxNu1q2U69u2LVLUbOHyk/u0ejr027ij5ksRTZil7qYJs0gyL
 vC+BXlbQUDp1/y86LhfaM62uvzNqzqepFOfQzxY5ET4Q0YvUykxlUgEZCccFQ/yy402W
 OCE6l7WBIbYReMDhryIaQhqi+t923eUu00VCSEl2PYKsB3djUKlHG90cdUyCUQc9mmNc
 BWWcUPkKRwZR3yyw5Z6hIJudZvXZQx+z4kYpE0Z4C5AL0ZZwhGjzbZF/NbZrohqoZa/a
 2ZzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/Q+xYwkm6ri94nuzgMOTuFQwr8uB85kmkJI+QSjsZs0=;
 b=lkhCfpv1wvohmlZRDK7lVr1f2dyIPUXqBaPrS7NAmozyNSnxFkCol7u5N5KWkNebD+
 98be8FG2VxI0dfmhxjGF3rAIqg32Dz5GNF9dWpmALs3o+NzFiUAz6RxwQ+kM92M50Y9C
 2MG/SmHZUYT2zP/o94vuQJzYhQiMiYEmRN1NPtFI0pW0aDCvKARigoGd5bpEIXDeSDyx
 4jksHMC4m1vRHJT62Keg8kNZ5X8me/73QDKBwsLTjeFMWV41b45cRjX+iAXGS+cfRtGj
 SdCCn7MutACVWkde6chJVVRldiSBNJBjhn6nBpq3xeOgVYCoQCiB8pYUK2xyqE52Jmxm
 3fJQ==
X-Gm-Message-State: APjAAAWI8ezUJO093lLSmr87yxmnu58Zzbytln81Wt3Wdjr+YL4w/0ae
 mWDsLKY+fvD6RbT1G30nQCwA65U1ZIN3741DnWU=
X-Google-Smtp-Source: APXvYqxMJy81fwJLh/KuNEJ0vtG40HZvRlw6dUhgPOjBGkjjTdQOKKkN/R8LD0ykvg1DRlQj4wp1ANCgAJVXH5IEkVw=
X-Received: by 2002:a92:af08:: with SMTP id n8mr983895ili.217.1582754425424;
 Wed, 26 Feb 2020 14:00:25 -0800 (PST)
MIME-Version: 1.0
References: <20200226181020.19592-1-alex.bennee@linaro.org>
 <20200226181020.19592-2-alex.bennee@linaro.org>
In-Reply-To: <20200226181020.19592-2-alex.bennee@linaro.org>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Wed, 26 Feb 2020 23:00:13 +0100
Message-ID: <CAPan3Woa8rb7NBOALieuyEiE=p_C_P+basRummBhPoX5On_XWw@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] accel/tcg: use units.h for defining code gen
 buffer sizes
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000004b5113059f81bb1d"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::142
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000004b5113059f81bb1d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2020 at 7:11 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:

> It's easier to read.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
Reviewed-by: Niek Linnenbank <nieklinnenbank@gmail.com>


> ---
>  accel/tcg/translate-all.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index a08ab11f657..238b0e575bf 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -18,6 +18,7 @@
>   */
>
>  #include "qemu/osdep.h"
> +#include "qemu/units.h"
>  #include "qemu-common.h"
>
>  #define NO_CPU_IO_DEFS
> @@ -901,33 +902,33 @@ static void page_lock_pair(PageDesc **ret_p1,
> tb_page_addr_t phys1,
>
>  /* Minimum size of the code gen buffer.  This number is randomly chosen,
>     but not so small that we can't have a fair number of TB's live.  */
> -#define MIN_CODE_GEN_BUFFER_SIZE     (1024u * 1024)
> +#define MIN_CODE_GEN_BUFFER_SIZE     (1 * MiB)
>
>  /* Maximum size of the code gen buffer we'd like to use.  Unless otherwi=
se
>     indicated, this is constrained by the range of direct branches on the
>     host cpu, as used by the TCG implementation of goto_tb.  */
>  #if defined(__x86_64__)
> -# define MAX_CODE_GEN_BUFFER_SIZE  (2ul * 1024 * 1024 * 1024)
> +# define MAX_CODE_GEN_BUFFER_SIZE  (2 * GiB)
>  #elif defined(__sparc__)
> -# define MAX_CODE_GEN_BUFFER_SIZE  (2ul * 1024 * 1024 * 1024)
> +# define MAX_CODE_GEN_BUFFER_SIZE  (2 * GiB)
>  #elif defined(__powerpc64__)
> -# define MAX_CODE_GEN_BUFFER_SIZE  (2ul * 1024 * 1024 * 1024)
> +# define MAX_CODE_GEN_BUFFER_SIZE  (2 * GiB)
>  #elif defined(__powerpc__)
> -# define MAX_CODE_GEN_BUFFER_SIZE  (32u * 1024 * 1024)
> +# define MAX_CODE_GEN_BUFFER_SIZE  (32 * MiB)
>  #elif defined(__aarch64__)
> -# define MAX_CODE_GEN_BUFFER_SIZE  (2ul * 1024 * 1024 * 1024)
> +# define MAX_CODE_GEN_BUFFER_SIZE  (2 * GiB)
>  #elif defined(__s390x__)
>    /* We have a +- 4GB range on the branches; leave some slop.  */
> -# define MAX_CODE_GEN_BUFFER_SIZE  (3ul * 1024 * 1024 * 1024)
> +# define MAX_CODE_GEN_BUFFER_SIZE  (3 * GiB)
>  #elif defined(__mips__)
>    /* We have a 256MB branch region, but leave room to make sure the
>       main executable is also within that region.  */
> -# define MAX_CODE_GEN_BUFFER_SIZE  (128ul * 1024 * 1024)
> +# define MAX_CODE_GEN_BUFFER_SIZE  (128 * MiB)
>  #else
>  # define MAX_CODE_GEN_BUFFER_SIZE  ((size_t)-1)
>  #endif
>
> -#define DEFAULT_CODE_GEN_BUFFER_SIZE_1 (32u * 1024 * 1024)
> +#define DEFAULT_CODE_GEN_BUFFER_SIZE_1 (32 * MiB)
>
>  #define DEFAULT_CODE_GEN_BUFFER_SIZE \
>    (DEFAULT_CODE_GEN_BUFFER_SIZE_1 < MAX_CODE_GEN_BUFFER_SIZE \
> --
> 2.20.1
>
>
>

--=20
Niek Linnenbank

--0000000000004b5113059f81bb1d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Feb 26, 2020 at 7:11 PM Alex =
Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org">alex.bennee@linar=
o.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">It&#39;s easier to read.<br>
<br>
Signed-off-by: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.or=
g" target=3D"_blank">alex.bennee@linaro.org</a>&gt;<br></blockquote><div>Re=
viewed-by: Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@gmail.com">=
nieklinnenbank@gmail.com</a>&gt;<br></div><div>=C2=A0</div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">
---<br>
=C2=A0accel/tcg/translate-all.c | 19 ++++++++++---------<br>
=C2=A01 file changed, 10 insertions(+), 9 deletions(-)<br>
<br>
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c<br>
index a08ab11f657..238b0e575bf 100644<br>
--- a/accel/tcg/translate-all.c<br>
+++ b/accel/tcg/translate-all.c<br>
@@ -18,6 +18,7 @@<br>
=C2=A0 */<br>
<br>
=C2=A0#include &quot;qemu/osdep.h&quot;<br>
+#include &quot;qemu/units.h&quot;<br>
=C2=A0#include &quot;qemu-common.h&quot;<br>
<br>
=C2=A0#define NO_CPU_IO_DEFS<br>
@@ -901,33 +902,33 @@ static void page_lock_pair(PageDesc **ret_p1, tb_page=
_addr_t phys1,<br>
<br>
=C2=A0/* Minimum size of the code gen buffer.=C2=A0 This number is randomly=
 chosen,<br>
=C2=A0 =C2=A0 but not so small that we can&#39;t have a fair number of TB&#=
39;s live.=C2=A0 */<br>
-#define MIN_CODE_GEN_BUFFER_SIZE=C2=A0 =C2=A0 =C2=A0(1024u * 1024)<br>
+#define MIN_CODE_GEN_BUFFER_SIZE=C2=A0 =C2=A0 =C2=A0(1 * MiB)<br>
<br>
=C2=A0/* Maximum size of the code gen buffer we&#39;d like to use.=C2=A0 Un=
less otherwise<br>
=C2=A0 =C2=A0 indicated, this is constrained by the range of direct branche=
s on the<br>
=C2=A0 =C2=A0 host cpu, as used by the TCG implementation of goto_tb.=C2=A0=
 */<br>
=C2=A0#if defined(__x86_64__)<br>
-# define MAX_CODE_GEN_BUFFER_SIZE=C2=A0 (2ul * 1024 * 1024 * 1024)<br>
+# define MAX_CODE_GEN_BUFFER_SIZE=C2=A0 (2 * GiB)<br>
=C2=A0#elif defined(__sparc__)<br>
-# define MAX_CODE_GEN_BUFFER_SIZE=C2=A0 (2ul * 1024 * 1024 * 1024)<br>
+# define MAX_CODE_GEN_BUFFER_SIZE=C2=A0 (2 * GiB)<br>
=C2=A0#elif defined(__powerpc64__)<br>
-# define MAX_CODE_GEN_BUFFER_SIZE=C2=A0 (2ul * 1024 * 1024 * 1024)<br>
+# define MAX_CODE_GEN_BUFFER_SIZE=C2=A0 (2 * GiB)<br>
=C2=A0#elif defined(__powerpc__)<br>
-# define MAX_CODE_GEN_BUFFER_SIZE=C2=A0 (32u * 1024 * 1024)<br>
+# define MAX_CODE_GEN_BUFFER_SIZE=C2=A0 (32 * MiB)<br>
=C2=A0#elif defined(__aarch64__)<br>
-# define MAX_CODE_GEN_BUFFER_SIZE=C2=A0 (2ul * 1024 * 1024 * 1024)<br>
+# define MAX_CODE_GEN_BUFFER_SIZE=C2=A0 (2 * GiB)<br>
=C2=A0#elif defined(__s390x__)<br>
=C2=A0 =C2=A0/* We have a +- 4GB range on the branches; leave some slop.=C2=
=A0 */<br>
-# define MAX_CODE_GEN_BUFFER_SIZE=C2=A0 (3ul * 1024 * 1024 * 1024)<br>
+# define MAX_CODE_GEN_BUFFER_SIZE=C2=A0 (3 * GiB)<br>
=C2=A0#elif defined(__mips__)<br>
=C2=A0 =C2=A0/* We have a 256MB branch region, but leave room to make sure =
the<br>
=C2=A0 =C2=A0 =C2=A0 main executable is also within that region.=C2=A0 */<b=
r>
-# define MAX_CODE_GEN_BUFFER_SIZE=C2=A0 (128ul * 1024 * 1024)<br>
+# define MAX_CODE_GEN_BUFFER_SIZE=C2=A0 (128 * MiB)<br>
=C2=A0#else<br>
=C2=A0# define MAX_CODE_GEN_BUFFER_SIZE=C2=A0 ((size_t)-1)<br>
=C2=A0#endif<br>
<br>
-#define DEFAULT_CODE_GEN_BUFFER_SIZE_1 (32u * 1024 * 1024)<br>
+#define DEFAULT_CODE_GEN_BUFFER_SIZE_1 (32 * MiB)<br>
<br>
=C2=A0#define DEFAULT_CODE_GEN_BUFFER_SIZE \<br>
=C2=A0 =C2=A0(DEFAULT_CODE_GEN_BUFFER_SIZE_1 &lt; MAX_CODE_GEN_BUFFER_SIZE =
\<br>
-- <br>
2.20.1<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--0000000000004b5113059f81bb1d--

