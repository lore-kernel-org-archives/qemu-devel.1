Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94624C31E40
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 10:20:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F991208C2
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 10:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dkxj2vb1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F991208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyCrq-0006Of-EH
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 06:20:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51721)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hyCrB-0005yR-N5
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 06:19:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hyCrA-00074J-CX
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 06:19:45 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:41942)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hyCrA-00073t-7M
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 06:19:44 -0400
Received: by mail-ot1-x343.google.com with SMTP id o101so4748931ota.8
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2019 03:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=QzNwB1JxMsn2wY1nrpJOh4bCWgQ0C/AE+uxEdCortew=;
 b=Dkxj2vb12vrsEz1864Mi1VrxY51dBD8Ay8xNTp22UW1+3aEPeg4p1KsOTcPY7w2IxV
 4DV1ZjZMnRFPA+/QLcycv27LyKmadLwZnz18mEfYPiBpuMlzNc9QjTf+4fNKid6BmEif
 WhM2XaB18XJN6Kl7OgMFzK8iAe0BqNWV6Ype8YaecJ7P2tBrp/OwgTgJtdEpayT0pwXq
 8ooKrJdONELJN0Z+UjmYk2CAfQkI0oBXCjt5eCETq1iErWMhNxHDZ5//emuw0wlL67rv
 qu9d0NIdxLj7g56Fl31uhx9X4nOTsNkbmlo681THQGf/2hwlE+CLIKI8XfzFi3PhN3NZ
 dagw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=QzNwB1JxMsn2wY1nrpJOh4bCWgQ0C/AE+uxEdCortew=;
 b=MggNVZMPZZwdBJ7qn+G/ekwAaQO9MCtpHObaozxSSqQk/urU+LnlUGcUPg2e0wfPPJ
 cb6/W+nsXWl8PU9LkFpVmGaBY3tQWMGF5n+UjEeMzobs4FoVm2PluTXKIl5ErmwLR0cs
 +KPjG9iV6BMQPvndRm3AcheLeZ8d3Ej2zii3mKpBYKUTTF2EQh0emHmaxaWBnbUlkptt
 EU5EavF5xEDd0vKw9poq8OxVhF46XAKnO+rZw+bo5AsQaq2tScTIzW2YAR1jfHbgsic1
 fyKge5IkiGSZuThj70lEyfiuZ+edtke3YNDHUq8+ulXzNtlC4qoxIIgT6sRnRhRgx6ec
 EYdQ==
X-Gm-Message-State: APjAAAUd7uzUrVL6t+sgnVzLIfeL5eYLE3eXdAI3V0Apccscc/W8w0Y3
 vtQ7bFK39VaRd0JiSPn/slHqe78dh2oIHHedJqQ=
X-Google-Smtp-Source: APXvYqwhzAsYXFXcjA96l20UddQDgPP1/nar38D+REmrfsS+hkG0XMEyANlMz1dTmDGrIAvy90Oj2bmzd9Qrjbxge0g=
X-Received: by 2002:a9d:73d7:: with SMTP id m23mr3030951otk.295.1565864383291; 
 Thu, 15 Aug 2019 03:19:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6830:10d7:0:0:0:0 with HTTP; Thu, 15 Aug 2019 03:19:42
 -0700 (PDT)
Received: by 2002:a05:6830:10d7:0:0:0:0 with HTTP; Thu, 15 Aug 2019 03:19:42
 -0700 (PDT)
In-Reply-To: <8a3988c7-5cca-d6b9-2be9-84cfe4b59f9f@linaro.org>
References: <20190815020928.9679-1-jan.bobek@gmail.com>
 <20190815020928.9679-3-jan.bobek@gmail.com>
 <CAL1e-=j9eDuFSspcUx3oac3UFvY7-N4rYOwVvQ2eSvc9DnbC=A@mail.gmail.com>
 <8a3988c7-5cca-d6b9-2be9-84cfe4b59f9f@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 15 Aug 2019 12:19:42 +0200
Message-ID: <CAL1e-=i7iW50-0uDywH_-eP0KDWaFGMo5qc3v3PX0SA8Fg+W9w@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [RFC PATCH v3 02/46] target/i386: Push rex_w into
 DisasContext
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
 Jan Bobek <jan.bobek@gmail.com>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

15.08.2019. 11.55, "Richard Henderson" <richard.henderson@linaro.org> =D1=
=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> On 8/15/19 8:30 AM, Aleksandar Markovic wrote:
> >
> > 15.08.2019. 04.13, "Jan Bobek" <jan.bobek@gmail.com
> > <mailto:jan.bobek@gmail.com>> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=
=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> >>
> >> From: Richard Henderson <rth@twiddle.net <mailto:rth@twiddle.net>>
> >>
> >> Treat this the same as we already do for other rex bits.
> >>
> >> Signed-off-by: Richard Henderson <rth@twiddle.net <mailto:
rth@twiddle.net>>
> >> ---
> >>  target/i386/translate.c | 19 +++++++++++--------
> >>  1 file changed, 11 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/target/i386/translate.c b/target/i386/translate.c
> >> index d74dbfd585..c0866c2797 100644
> >> --- a/target/i386/translate.c
> >> +++ b/target/i386/translate.c
> >> @@ -44,11 +44,13 @@
> >>  #define REX_X(s) ((s)->rex_x)
> >>  #define REX_B(s) ((s)->rex_b)
> >>  #define REX_R(s) ((s)->rex_r)
> >> +#define REX_W(s) ((s)->rex_w)
> >>  #else
> >>  #define CODE64(s) 0
> >>  #define REX_X(s) 0
> >>  #define REX_B(s) 0
> >>  #define REX_R(s) 0
> >> +#define REX_W(s) -1
> >
> > The commit message says "treat rex_w the same as other rex bits". Why
is then
> > REX_W() treated differently here?
>
> "Treated the same" in terms of being referenced by a macro instead of a
local
> variable.  As for the -1, if you look at the rest of the patch you can
clearly
> see it preserves existing behaviour.
>

That is exactly what I dislike about your commit messages: they often
introduce ambiguity, without any real need, and with really bad
consequences to the reader. Is adding "in terms of being referenced by a
macro instead of a local
variable" to the commit message that hard?

When writing commit messages, you need to try to put yourself in the shoes
of the reader.

Aleksandar

> >> @@ -4503,6 +4504,7 @@ static target_ulong disas_insn(DisasContext *s,
> > CPUState *cpu)
> >>      s->rex_x =3D 0;
> >>      s->rex_b =3D 0;
> >>      s->rex_r =3D 0;
> >> +    s->rex_w =3D -1;
> >>      s->x86_64_hregs =3D false;
> >>  #endif
> >>      s->rip_offset =3D 0; /* for relative ip address */
> >> @@ -4514,7 +4516,6 @@ static target_ulong disas_insn(DisasContext *s,
> > CPUState *cpu)
> >>      }
> >>
> >>      prefixes =3D 0;
> >> -    rex_w =3D -1;
>
>
> r~
