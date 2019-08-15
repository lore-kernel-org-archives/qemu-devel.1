Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3637EC31E40
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 07:17:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02895206C2
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 07:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JCGeY32z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02895206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyA0y-0002hU-7C
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 03:17:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55728)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hyA0J-0002En-BJ
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 03:17:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hyA0I-00027D-6k
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 03:16:59 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:40250)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hyA0I-00026x-0W
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 03:16:58 -0400
Received: by mail-ot1-x341.google.com with SMTP id c34so3956310otb.7
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2019 00:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=daTZ9TU2qjkmnqK3TRzIG3Uffu8iH2D/eTrtkBnriOw=;
 b=JCGeY32zsZvGdfaRtHdJGHUoK9kwa7pH/KnQJPgOoR+7aFQfhqwe+wY/tLJlGczy37
 SeD7Go3RZ0HdXvyi7u/T+dLZtOvdG91v6IXIJU0KHU9sGqEJQwYfdN60G/NvRuNOrSyw
 e+z+CsIlgsULyiwnDuxT/QKeMNg8qD5ITdLJ7eGd8yDu+HkdQs30VswAqmLc8lE1AuWl
 0429t6e2DKrjJgs5i2AK+vnSi2UWwKK1iyDJCJcOrxd2StrKb/0ANrqq1ecKSvEZYYfj
 MzaGLF4iXLxIW1BHjYqps5uokct+/RywBV6l+pEQy+dCHbZ9OlF68+ZVBMVJeR8VUJEk
 tD8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=daTZ9TU2qjkmnqK3TRzIG3Uffu8iH2D/eTrtkBnriOw=;
 b=qYteZBdijJ3gUyMSzAiRsH8hQMtUWzNOP8csY0VoJ5I0BH/8r7QpfjHig20EikS97e
 GlXmo+bh+mQyVAtIiBi6Nw02gbMZ12QmJ8Wo5WnJ0eLZu5ZYx7tjgLUy5Yip10EikPjg
 9bHiBdxnTFB4xKwUJZ5oui2UpAqtKnrRQwMapDxs/q57Buhza4UQ1WtdO5yY3Bas887g
 opfWIeZe+sBhKnJqM4kbtLkHdzxNi0L8TkzSq5P3MicvkoypxYShXGiz0Pei279prhYY
 NCckqZ1AB0roRQRHgg33BmfNpcDRg+m6fVJxxz/DYZF4tZRxqeDhkNiwPoU+ghbuMqFZ
 6YMg==
X-Gm-Message-State: APjAAAW4yBbZ2RGh7Rl2E8aoGAAIEQ35IX8zRPpodKOkMTD9hHHyX9H2
 t841NFTW8JOWA6Z5LUEah8z+KU7nkZ2fwhC7Ysk=
X-Google-Smtp-Source: APXvYqyu7oqvY3+qZUnvs1DQjHb+PVk/em7o8QXZjIfNHZftfLqtgYa/iWBxaCl3gVjh0dccAlxt4M/ER7IP4oBKmhI=
X-Received: by 2002:a9d:73d7:: with SMTP id m23mr2549351otk.295.1565853417073; 
 Thu, 15 Aug 2019 00:16:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6830:10d7:0:0:0:0 with HTTP; Thu, 15 Aug 2019 00:16:56
 -0700 (PDT)
Received: by 2002:a05:6830:10d7:0:0:0:0 with HTTP; Thu, 15 Aug 2019 00:16:56
 -0700 (PDT)
In-Reply-To: <20190815020928.9679-4-jan.bobek@gmail.com>
References: <20190815020928.9679-1-jan.bobek@gmail.com>
 <20190815020928.9679-4-jan.bobek@gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 15 Aug 2019 09:16:56 +0200
Message-ID: <CAL1e-=j9GGGCOKXTdGZGSzUz85CKAU7Q3Aw4MAisj4wRJtzpfg@mail.gmail.com>
To: Jan Bobek <jan.bobek@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [RFC PATCH v3 03/46] target/i386: reduce scope of
 variable aflag
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

15.08.2019. 04.10, "Jan Bobek" <jan.bobek@gmail.com> =D1=98=D0=B5 =D0=BD=D0=
=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> The variable aflag is not used in most of disas_insn; make this clear
> by explicitly reducing its scope to the block where it is used.
>
> Suggested-by: Richard Henderson <rth@twiddle.net>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
> ---

Jan, the new block between { and } should be indented.

Yours,
Aleksandar

>  target/i386/translate.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/target/i386/translate.c b/target/i386/translate.c
> index c0866c2797..bda96277e4 100644
> --- a/target/i386/translate.c
> +++ b/target/i386/translate.c
> @@ -4493,11 +4493,14 @@ static target_ulong disas_insn(DisasContext *s,
CPUState *cpu)
>      CPUX86State *env =3D cpu->env_ptr;
>      int b, prefixes;
>      int shift;
> -    TCGMemOp ot, aflag, dflag;
> +    TCGMemOp ot, dflag;
>      int modrm, reg, rm, mod, op, opreg, val;
>      target_ulong next_eip, tval;
>      target_ulong pc_start =3D s->base.pc_next;
>
> +    {
> +    TCGMemOp aflag;
> +
>      s->pc_start =3D s->pc =3D pc_start;
>      s->override =3D -1;
>  #ifdef TARGET_X86_64
> @@ -4657,6 +4660,7 @@ static target_ulong disas_insn(DisasContext *s,
CPUState *cpu)
>      s->prefix =3D prefixes;
>      s->aflag =3D aflag;
>      s->dflag =3D dflag;
> +    }
>
>      /* now check op code */
>   reswitch:
> --
> 2.20.1
>
>
