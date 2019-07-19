Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D2F3C76188
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 11:51:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5590820873
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 11:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eSQ/bHC9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5590820873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoRQ8-0005Xy-Lp
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 07:51:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42535)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hoRPy-000596-99
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 07:51:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hoRPw-0004oC-TG
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 07:51:18 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:33498)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hoRPw-0004nT-MU
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 07:51:16 -0400
Received: by mail-ot1-x342.google.com with SMTP id q20so32420383otl.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 04:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ocePWXzpqi1ePmrNMFK2mRms0KOvF3Gemy2vz7mDRc0=;
 b=eSQ/bHC9Yrz3P5dRBYx9O56J6ixYlgUR43eOwBIVR7O4GaicywFRlK6y+QBeokLZMq
 h4c1m6PS4V7sJxnYhaDseCfou+shLaMj2VL39GVgYFe5JisH2XS8vOkVq0FTa+D1dFQg
 NOH0u/up0c87zfV3o3K/unYJ6osSWZpBXhb6Jw0kBMoOdubQ0j8ycD0ojl9xdwZ9wJI7
 Dz6S8LwxqF0wwhc/vJ06mf32Qlqz2ijCNoe98bQpyYg+5dhvQFWs0aHW7pRzlJB7fBsU
 0+9LcXftW6qy3uTfk2eVmzQBAkLJYxKaUGqY3fYoUAN3P5ktCdE2fgSl0J/7zt4YkKY6
 fYzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ocePWXzpqi1ePmrNMFK2mRms0KOvF3Gemy2vz7mDRc0=;
 b=U9sHls3A65+s7fahSw2zcbZVci9saFWd60k0pSG0WjbTCB4oPkeovsETAuJqCYgRN1
 bZy387vq9nD9qFs7R9seX/jB5JEuUgz6LKoCZk/WZxeNI3i5uzUQjIxWgUulIM3wj/MX
 eq2/lC7O5qJjQ6aApTNVNvZqTHsf2ZwEXuB7R9d2Udb2164HFx8ADswKCH2/iXo37oFH
 0LLLsKWAldJpWGzfPJ1goFtO0wJzZ+etmONgom7+vunit+kY2WXOdPBxkgOYTMyc3NDl
 H561f18PhI8kzwd+d8pCMh3SBJ8LYcJIuBTHrwiey18VnJAqeVR3rLIz/LLh6el9MwWr
 u3jg==
X-Gm-Message-State: APjAAAWf4PH1aDzagTkx8ywg1w+G+3TxqO6p2acvqOEZtd1kGzBLuMeU
 Lij3RXK3Wn4jMInr1UV7TlejPlimciSLoF+4/Uppeg==
X-Google-Smtp-Source: APXvYqyoiRoeDnVAzJs911aDd1SiH/W8ZvHJ73NnO2XrRB5rZR2oWmgSxtF+UfQDzMDjpWGVYiPu/GzpkffuwJ41mNk=
X-Received: by 2002:a05:6830:1653:: with SMTP id
 h19mr31678018otr.232.1563537075661; 
 Fri, 19 Jul 2019 04:51:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190719112315.14432-1-philmd@redhat.com>
 <1f5ee7a6-d78c-8d60-40ef-68032d7ef923@redhat.com>
In-Reply-To: <1f5ee7a6-d78c-8d60-40ef-68032d7ef923@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jul 2019 12:51:04 +0100
Message-ID: <CAFEAcA_hvqgH6cjJLARN7jfq+iJLoGPsx_RqVedc+SEtrRDu2w@mail.gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [RFC PATCH-for-4.1] target/i386: Correct misplaced
 break statement in gen_shiftd_rm_T1()
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
Cc: Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 19 Jul 2019 at 12:45, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 19/07/19 13:23, Philippe Mathieu-Daud=C3=A9 wrote:
> > Reported by GCC9 when building with CFLAG -Wimplicit-fallthrough=3D2:
> >
> >     CC      target/i386/translate.o
> >   target/i386/translate.c: In function =E2=80=98gen_shiftd_rm_T1=E2=80=
=99:
> >   target/i386/translate.c:1785:12: error: this statement may fall throu=
gh [-Werror=3Dimplicit-fallthrough=3D]
> >    1785 |         if (is_right) {
> >         |            ^
> >   target/i386/translate.c:1810:5: note: here
> >    1810 |     default:
> >         |     ^~~~~~~
> >   cc1: all warnings being treated as errors
> >
> > Fixes: f437d0a3c24
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > ---
> >  target/i386/translate.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/target/i386/translate.c b/target/i386/translate.c
> > index 03150a86e2..4b2b5937ca 100644
> > --- a/target/i386/translate.c
> > +++ b/target/i386/translate.c
> > @@ -1805,8 +1805,8 @@ static void gen_shiftd_rm_T1(DisasContext *s, TCG=
MemOp ot, int op1,
> >              tcg_gen_shri_i64(s->tmp0, s->tmp0, 32);
> >              tcg_gen_shri_i64(s->T0, s->T0, 32);
> >          }
> > -        break;
> >  #endif
> > +        break;
> >      default:
> >          tcg_gen_subi_tl(s->tmp0, count, 1);
> >          if (is_right) {
> >
>
> I haven't looked closely at the code but I would guess that the
> fallthrough is intended, because the default label has an "ot =3D=3D MO_1=
6"
> condition.

Yeah, this code is really weird -- if TARGET_X86_64 then
MO_16 falls through into MO_32, but if only i386 then
MO_16 falls through into the default case ?!?

thanks
-- PMM

