Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C026AC433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 17:39:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84B962075D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 17:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="GtS/NfUA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84B962075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv2QU-00050w-Rb
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 13:39:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53310)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chihmin.chao@sifive.com>)
 id 1jv2Pa-0004Ry-4l
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 13:38:42 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:37497)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chihmin.chao@sifive.com>)
 id 1jv2PT-0005WQ-7O
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 13:38:41 -0400
Received: by mail-io1-xd41.google.com with SMTP id v6so14398565iob.4
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 10:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HT53HVK98Q87GNg+2/R6deKFNdaS+YtlVv9jtJlBsiQ=;
 b=GtS/NfUAzXkC0jpeP+HZN2NvwULioOIAx7JacWsucIpmvG7ncfb1WMvA1E6FKc1wN3
 dplMYNWEHmNpcK0yyofMzJs8lpnvYKC7Z80R5nVJJ/Xx/M7CSiiBTEOIB8Mrhq7ghdfk
 XgzFHc0jjlEaDoWNg3LBko1elruYsgrmTpy/GB+4Q654i9k2OfaBxvPapmwUWPkTs2xz
 UEiXv9va4fVkq0L/i5sD/RyS7tHLO+c8mGORNNqVbCr/KkNNrH+nQgNSiw37vc10uvy0
 +AbyhMqjKztdoebPAKiloYqiOV22s3x2XiqnL7kHnnxYZuqy1pQ2LGpZhNaEcrBGrdre
 2bTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HT53HVK98Q87GNg+2/R6deKFNdaS+YtlVv9jtJlBsiQ=;
 b=gDTLCRmmAQNVA5JwUThrGk6XnB0e26a0IKkoy98ftqinYXNAo8vBi2jL7BFgb75E0g
 4DGHRuruahVXSyIcHwty3KT7IU27PXo632mASvdrpEMqs13+sg1Z3rIPSgQLMPAd4L9D
 m/IApB1aBR28M40zS1CEhrVQslh2VncIrPaSRqdRtSj8DqQ594Mvgz6QeSOO5yBOUuON
 bKdifziDK4xMO/WL/hbBWcJtjTG8yvmdGoBi7rWLJGG469e8r1dpkQ7z89gXl+pVch8n
 0tm36fYfw2aegjIF0nK5RzMCIVoK7SMMHTb7nVdBZq2YlnvqoNsbnUcgW7Itdgqlh8J1
 sjbw==
X-Gm-Message-State: AOAM532ZYnxXUR3d5npn9DvZ6fXWL3IlMFmpKWluRQNvoSLD9TsdOOgA
 wTRQ+l2aMeud7UTHFYtE5DWAwr6iZoHEhASJ70nKQg==
X-Google-Smtp-Source: ABdhPJyqkrBrRQ2TD/Olt4duB0EUh4urNPHgiFdkCf+SnFu29/csXmRdZ43i+xoBEmh1SxUrnCaZvyll8L468A1ej40=
X-Received: by 2002:a05:6638:1187:: with SMTP id
 f7mr1381103jas.58.1594661913437; 
 Mon, 13 Jul 2020 10:38:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200710104920.13550-1-frank.chang@sifive.com>
 <20200710104920.13550-63-frank.chang@sifive.com> <87h7uflg65.fsf@linaro.org>
In-Reply-To: <87h7uflg65.fsf@linaro.org>
From: Chih-Min Chao <chihmin.chao@sifive.com>
Date: Tue, 14 Jul 2020 01:38:22 +0800
Message-ID: <CAEiOBXXY33gxpBBmu0N8vauqFNXdnbWJiA58nUtHvRBtYFe-EQ@mail.gmail.com>
Subject: Re: [RFC 62/65] fpu: add api to handle alternative sNaN propagation
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000e3425f05aa562888"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d41;
 envelope-from=chihmin.chao@sifive.com; helo=mail-io1-xd41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: frank.chang@sifive.com, Peter Maydell <peter.maydell@linaro.org>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000e3425f05aa562888
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2020 at 8:15 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:

>
> frank.chang@sifive.com writes:
>
> > From: Chih-Min Chao <chihmin.chao@sifive.com>
> >
> > Signed-off-by: Chih-Min Chao <chihmin.chao@sifive.com>
> > Signed-off-by: Frank Chang <frank.chang@sifive.com>
> > ---
> >  fpu/softfloat.c         | 68 +++++++++++++++++++++++++----------------
> >  include/fpu/softfloat.h |  6 ++++
> >  2 files changed, 48 insertions(+), 26 deletions(-)
> >
> > diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> > index fa1c99c03e..028b857167 100644
> > --- a/fpu/softfloat.c
> > +++ b/fpu/softfloat.c
> > @@ -2777,23 +2777,32 @@ float64 uint16_to_float64(uint16_t a,
> float_status *status)
> >   * and minNumMag() from the IEEE-754 2008.
> >   */
> >  static FloatParts minmax_floats(FloatParts a, FloatParts b, bool ismin=
,
> > -                                bool ieee, bool ismag, float_status *s=
)
> > +                                bool ieee, bool ismag, bool issnan_pro=
p,
> > +                                float_status *s)
> >  {
> >      if (unlikely(is_nan(a.cls) || is_nan(b.cls))) {
> >          if (ieee) {
> >              /* Takes two floating-point values `a' and `b', one of
> >               * which is a NaN, and returns the appropriate NaN
> >               * result. If either `a' or `b' is a signaling NaN,
> > -             * the invalid exception is raised.
> > +             * the invalid exception is raised but the NaN
> > +             * propagation is 'shall'.
> >               */
> >              if (is_snan(a.cls) || is_snan(b.cls)) {
> > -                return pick_nan(a, b, s);
> > -            } else if (is_nan(a.cls) && !is_nan(b.cls)) {
> > +                if (issnan_prop) {
> > +                    pick_nan(a, b, s);
>
> This looks funky to me because you don't actually pick a nan - are you
> just using this for side effects?
>
> I'm also confused by the fact the new helpers have the prototype noprop
> which implies no propagation yes the bool flag is true and named
> issnan_prop which implies it should propagate.
>
> I think we need a clearer problem statement in the commit of what you
> are trying to achieve here. I suspect it might be worth splitting the
> flag setting from pick_nan to it's own mini helper if that is all we
> want to do in this case.
>
> > +                } else {
> > +                    return pick_nan(a, b, s);
> > +                }
> > +            }
> > +
> > +            if (is_nan(a.cls) && !is_nan(b.cls)) {
> >                  return b;
> >              } else if (is_nan(b.cls) && !is_nan(a.cls)) {
> >                  return a;
> >              }
> >          }
> > +
>
> nit: stray space
>
> >          return pick_nan(a, b, s);
> >      } else {
> >          int a_exp, b_exp;
> > @@ -2847,37 +2856,44 @@ static FloatParts minmax_floats(FloatParts a,
> FloatParts b, bool ismin,
> >      }
> >  }
> >
> > -#define MINMAX(sz, name, ismin, isiee, ismag)
>  \
> > +#define MINMAX(sz, name, ismin, isiee, ismag, issnan_prop)
> \
> >  float ## sz float ## sz ## _ ## name(float ## sz a, float ## sz b,
> \
> >                                       float_status *s)
>  \
> >  {
>  \
> >      FloatParts pa =3D float ## sz ## _unpack_canonical(a, s);
>  \
> >      FloatParts pb =3D float ## sz ## _unpack_canonical(b, s);
>  \
> > -    FloatParts pr =3D minmax_floats(pa, pb, ismin, isiee, ismag, s);
> \
> > +    FloatParts pr =3D minmax_floats(pa, pb, ismin, isiee, ismag,
> \
> > +                                  issnan_prop, s);
> \
> >
> \
> >      return float ## sz ## _round_pack_canonical(pr, s);
>  \
> >  }
> >
> > -MINMAX(16, min, true, false, false)
> > -MINMAX(16, minnum, true, true, false)
> > -MINMAX(16, minnummag, true, true, true)
> > -MINMAX(16, max, false, false, false)
> > -MINMAX(16, maxnum, false, true, false)
> > -MINMAX(16, maxnummag, false, true, true)
> > -
> > -MINMAX(32, min, true, false, false)
> > -MINMAX(32, minnum, true, true, false)
> > -MINMAX(32, minnummag, true, true, true)
> > -MINMAX(32, max, false, false, false)
> > -MINMAX(32, maxnum, false, true, false)
> > -MINMAX(32, maxnummag, false, true, true)
> > -
> > -MINMAX(64, min, true, false, false)
> > -MINMAX(64, minnum, true, true, false)
> > -MINMAX(64, minnummag, true, true, true)
> > -MINMAX(64, max, false, false, false)
> > -MINMAX(64, maxnum, false, true, false)
> > -MINMAX(64, maxnummag, false, true, true)
> > +MINMAX(16, min, true, false, false, false)
> > +MINMAX(16, minnum, true, true, false, false)
> > +MINMAX(16, minnum_noprop, true, true, false, true)
> > +MINMAX(16, minnummag, true, true, true, false)
> > +MINMAX(16, max, false, false, false, false)
> > +MINMAX(16, maxnum, false, true, false, false)
> > +MINMAX(16, maxnum_noprop, false, true, false, true)
> > +MINMAX(16, maxnummag, false, true, true, false)
> > +
> > +MINMAX(32, min, true, false, false, false)
> > +MINMAX(32, minnum, true, true, false, false)
> > +MINMAX(32, minnum_noprop, true, true, false, true)
> > +MINMAX(32, minnummag, true, true, true, false)
> > +MINMAX(32, max, false, false, false, false)
> > +MINMAX(32, maxnum, false, true, false, false)
> > +MINMAX(32, maxnum_noprop, false, true, false, true)
> > +MINMAX(32, maxnummag, false, true, true, false)
> > +
> > +MINMAX(64, min, true, false, false, false)
> > +MINMAX(64, minnum, true, true, false, false)
> > +MINMAX(64, minnum_noprop, true, true, false, true)
> > +MINMAX(64, minnummag, true, true, true, false)
> > +MINMAX(64, max, false, false, false, false)
> > +MINMAX(64, maxnum, false, true, false, false)
> > +MINMAX(64, maxnum_noprop, false, true, false, true)
> > +MINMAX(64, maxnummag, false, true, true, false)
> >
> >  #undef MINMAX
> >
> > diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
> > index b0ae8f6295..075c680456 100644
> > --- a/include/fpu/softfloat.h
> > +++ b/include/fpu/softfloat.h
> > @@ -239,6 +239,8 @@ float16 float16_minnum(float16, float16,
> float_status *status);
> >  float16 float16_maxnum(float16, float16, float_status *status);
> >  float16 float16_minnummag(float16, float16, float_status *status);
> >  float16 float16_maxnummag(float16, float16, float_status *status);
> > +float16 float16_minnum_noprop(float16, float16, float_status *status);
> > +float16 float16_maxnum_noprop(float16, float16, float_status *status);
> >  float16 float16_sqrt(float16, float_status *status);
> >  FloatRelation float16_compare(float16, float16, float_status *status);
> >  FloatRelation float16_compare_quiet(float16, float16, float_status
> *status);
> > @@ -359,6 +361,8 @@ float32 float32_minnum(float32, float32,
> float_status *status);
> >  float32 float32_maxnum(float32, float32, float_status *status);
> >  float32 float32_minnummag(float32, float32, float_status *status);
> >  float32 float32_maxnummag(float32, float32, float_status *status);
> > +float32 float32_minnum_noprop(float32, float32, float_status *status);
> > +float32 float32_maxnum_noprop(float32, float32, float_status *status);
> >  bool float32_is_quiet_nan(float32, float_status *status);
> >  bool float32_is_signaling_nan(float32, float_status *status);
> >  float32 float32_silence_nan(float32, float_status *status);
> > @@ -548,6 +552,8 @@ float64 float64_minnum(float64, float64,
> float_status *status);
> >  float64 float64_maxnum(float64, float64, float_status *status);
> >  float64 float64_minnummag(float64, float64, float_status *status);
> >  float64 float64_maxnummag(float64, float64, float_status *status);
> > +float64 float64_minnum_noprop(float64, float64, float_status *status);
> > +float64 float64_maxnum_noprop(float64, float64, float_status *status);
> >  bool float64_is_quiet_nan(float64 a, float_status *status);
> >  bool float64_is_signaling_nan(float64, float_status *status);
> >  float64 float64_silence_nan(float64, float_status *status);
>
>
> --
> Alex Benn=C3=A9e
>

Hi  Alex,

1.
This patch comes from the change of sNaN propagation implementation of
riscv floating spec.
Take following as example,
    fmin.s  ft0, ft1, ft2.

For spec 2.2,  the sNaN handling for fmin and fmax is
             if ft1 is sNaN or ft2 is sNaN
                  a. set the invalid flag
                  b. ft0 is  canonical NaN

            ref:
https://github.com/riscv/riscv-isa-manual/releases/tag/riscv-user-2.2
                section 8.3
                "For FMIN and FMAX, if at least one input is a signaling
NaN, or if both inputs are quiet NaNs,
                 the result is the canonical NaN. If one operand is a quiet
NaN and the other is not a NaN, the
                 result is the non-NaN operand.

For spec 20191213, the behavior is changed to
             if ft1 or ft2 is sNaN and the other is non-NaN
                   a. set the invalid flag
                   b. ft0 is set to non-NaN source
             ref:
https://github.com/riscv/riscv-isa-manual/releases/tag/Ratified-IMAFDQC
             section 11.6
             "If both inputs are NaNs, the result is
              the canonical NaN. If only one operand is a NaN, the result
is the non-NaN operand. Signaling
              NaN inputs set the invalid operation exception flag, even
when the result is not NaN."

2.
As you guess, the patch takes the side effect of pick_nan.  The pick_nan
does two works
   a. set invalid flag if input is sNaN
   b. return correct NaN number by configuration

   for one possible case, one operand is sNaN and the other is non-NaN, the
patch does
            a. pick_nan to  set invalid_flag but doesn't use the return
value)
            b. return non-NaN
  for the other case, both operands are sNaN, the patch does
           a. pick_nan to set_invalid_flag
           b  pick_nan to return NaN value
Is it better to separate the "set invalid flag" part from pick_nan to make
it concrete ?

3.
The parameter naming is misleading and will be fix in next separated
softfloat patch.

Thanks
Chih-Min Chao

--000000000000e3425f05aa562888
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><div><div><div><div dir=3D"ltr" data=
-smartmail=3D"gmail_signature"><div dir=3D"ltr"><span style=3D"color:rgb(13=
6,136,136)"></span><div style=3D"color:rgb(136,136,136)"><br></div></div></=
div></div></div></div></div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Fri, Jul 10, 2020 at 8:15 PM Alex Benn=C3=
=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org" target=3D"_blank">alex.b=
ennee@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex"><br>
<a href=3D"mailto:frank.chang@sifive.com" target=3D"_blank">frank.chang@sif=
ive.com</a> writes:<br>
<br>
&gt; From: Chih-Min Chao &lt;<a href=3D"mailto:chihmin.chao@sifive.com" tar=
get=3D"_blank">chihmin.chao@sifive.com</a>&gt;<br>
&gt;<br>
&gt; Signed-off-by: Chih-Min Chao &lt;<a href=3D"mailto:chihmin.chao@sifive=
.com" target=3D"_blank">chihmin.chao@sifive.com</a>&gt;<br>
&gt; Signed-off-by: Frank Chang &lt;<a href=3D"mailto:frank.chang@sifive.co=
m" target=3D"_blank">frank.chang@sifive.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 fpu/softfloat.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 68 ++++++++++=
+++++++++++++++----------------<br>
&gt;=C2=A0 include/fpu/softfloat.h |=C2=A0 6 ++++<br>
&gt;=C2=A0 2 files changed, 48 insertions(+), 26 deletions(-)<br>
&gt;<br>
&gt; diff --git a/fpu/softfloat.c b/fpu/softfloat.c<br>
&gt; index fa1c99c03e..028b857167 100644<br>
&gt; --- a/fpu/softfloat.c<br>
&gt; +++ b/fpu/softfloat.c<br>
&gt; @@ -2777,23 +2777,32 @@ float64 uint16_to_float64(uint16_t a, float_st=
atus *status)<br>
&gt;=C2=A0 =C2=A0* and minNumMag() from the IEEE-754 2008.<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 static FloatParts minmax_floats(FloatParts a, FloatParts b, bool=
 ismin,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bool ieee, bool ismag, float_sta=
tus *s)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bool ieee, bool ismag, bool issn=
an_prop,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 float_status *s)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (unlikely(is_nan(a.cls) || is_nan(b.cls))) {<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ieee) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Takes two floating-=
point values `a&#39; and `b&#39;, one of<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* which is a NaN=
, and returns the appropriate NaN<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* result. If eit=
her `a&#39; or `b&#39; is a signaling NaN,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* the invalid excepti=
on is raised.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* the invalid excepti=
on is raised but the NaN<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* propagation is &#39=
;shall&#39;.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (is_snan(a.cls) || =
is_snan(b.cls)) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return pick_n=
an(a, b, s);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (is_nan(a.cls) &a=
mp;&amp; !is_nan(b.cls)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (issnan_pr=
op) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 pick_nan(a, b, s);<br>
<br>
This looks funky to me because you don&#39;t actually pick a nan - are you<=
br>
just using this for side effects?<br>
<br>
I&#39;m also confused by the fact the new helpers have the prototype noprop=
<br>
which implies no propagation yes the bool flag is true and named<br>
issnan_prop which implies it should propagate.<br>
<br>
I think we need a clearer problem statement in the commit of what you<br>
are trying to achieve here. I suspect it might be worth splitting the<br>
flag setting from pick_nan to it&#39;s own mini helper if that is all we<br=
>
want to do in this case.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 return pick_nan(a, b, s);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (is_nan(a.cls) &amp;&amp=
; !is_nan(b.cls)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return b=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (is_nan(b.cl=
s) &amp;&amp; !is_nan(a.cls)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return a=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
<br>
nit: stray space<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return pick_nan(a, b, s);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int a_exp, b_exp;<br>
&gt; @@ -2847,37 +2856,44 @@ static FloatParts minmax_floats(FloatParts a, =
FloatParts b, bool ismin,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; -#define MINMAX(sz, name, ismin, isiee, ismag)=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<=
br>
&gt; +#define MINMAX(sz, name, ismin, isiee, ismag, issnan_prop)=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt;=C2=A0 float ## sz float ## sz ## _ ## name(float ## sz a, float ## sz =
b,=C2=A0 =C2=A0 =C2=A0 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0float_=
status *s)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0\<br>
&gt;=C2=A0 {=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt;=C2=A0 =C2=A0 =C2=A0 FloatParts pa =3D float ## sz ## _unpack_canonical=
(a, s);=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt;=C2=A0 =C2=A0 =C2=A0 FloatParts pb =3D float ## sz ## _unpack_canonical=
(b, s);=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; -=C2=A0 =C2=A0 FloatParts pr =3D minmax_floats(pa, pb, ismin, isiee, i=
smag, s);=C2=A0 =C2=A0 =C2=A0 \<br>
&gt; +=C2=A0 =C2=A0 FloatParts pr =3D minmax_floats(pa, pb, ismin, isiee, i=
smag,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 issnan_prop, s);=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return float ## sz ## _round_pack_canonical(pr, s)=
;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; -MINMAX(16, min, true, false, false)<br>
&gt; -MINMAX(16, minnum, true, true, false)<br>
&gt; -MINMAX(16, minnummag, true, true, true)<br>
&gt; -MINMAX(16, max, false, false, false)<br>
&gt; -MINMAX(16, maxnum, false, true, false)<br>
&gt; -MINMAX(16, maxnummag, false, true, true)<br>
&gt; -<br>
&gt; -MINMAX(32, min, true, false, false)<br>
&gt; -MINMAX(32, minnum, true, true, false)<br>
&gt; -MINMAX(32, minnummag, true, true, true)<br>
&gt; -MINMAX(32, max, false, false, false)<br>
&gt; -MINMAX(32, maxnum, false, true, false)<br>
&gt; -MINMAX(32, maxnummag, false, true, true)<br>
&gt; -<br>
&gt; -MINMAX(64, min, true, false, false)<br>
&gt; -MINMAX(64, minnum, true, true, false)<br>
&gt; -MINMAX(64, minnummag, true, true, true)<br>
&gt; -MINMAX(64, max, false, false, false)<br>
&gt; -MINMAX(64, maxnum, false, true, false)<br>
&gt; -MINMAX(64, maxnummag, false, true, true)<br>
&gt; +MINMAX(16, min, true, false, false, false)<br>
&gt; +MINMAX(16, minnum, true, true, false, false)<br>
&gt; +MINMAX(16, minnum_noprop, true, true, false, true)<br>
&gt; +MINMAX(16, minnummag, true, true, true, false)<br>
&gt; +MINMAX(16, max, false, false, false, false)<br>
&gt; +MINMAX(16, maxnum, false, true, false, false)<br>
&gt; +MINMAX(16, maxnum_noprop, false, true, false, true)<br>
&gt; +MINMAX(16, maxnummag, false, true, true, false)<br>
&gt; +<br>
&gt; +MINMAX(32, min, true, false, false, false)<br>
&gt; +MINMAX(32, minnum, true, true, false, false)<br>
&gt; +MINMAX(32, minnum_noprop, true, true, false, true)<br>
&gt; +MINMAX(32, minnummag, true, true, true, false)<br>
&gt; +MINMAX(32, max, false, false, false, false)<br>
&gt; +MINMAX(32, maxnum, false, true, false, false)<br>
&gt; +MINMAX(32, maxnum_noprop, false, true, false, true)<br>
&gt; +MINMAX(32, maxnummag, false, true, true, false)<br>
&gt; +<br>
&gt; +MINMAX(64, min, true, false, false, false)<br>
&gt; +MINMAX(64, minnum, true, true, false, false)<br>
&gt; +MINMAX(64, minnum_noprop, true, true, false, true)<br>
&gt; +MINMAX(64, minnummag, true, true, true, false)<br>
&gt; +MINMAX(64, max, false, false, false, false)<br>
&gt; +MINMAX(64, maxnum, false, true, false, false)<br>
&gt; +MINMAX(64, maxnum_noprop, false, true, false, true)<br>
&gt; +MINMAX(64, maxnummag, false, true, true, false)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #undef MINMAX<br>
&gt;=C2=A0 <br>
&gt; diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h<br>
&gt; index b0ae8f6295..075c680456 100644<br>
&gt; --- a/include/fpu/softfloat.h<br>
&gt; +++ b/include/fpu/softfloat.h<br>
&gt; @@ -239,6 +239,8 @@ float16 float16_minnum(float16, float16, float_sta=
tus *status);<br>
&gt;=C2=A0 float16 float16_maxnum(float16, float16, float_status *status);<=
br>
&gt;=C2=A0 float16 float16_minnummag(float16, float16, float_status *status=
);<br>
&gt;=C2=A0 float16 float16_maxnummag(float16, float16, float_status *status=
);<br>
&gt; +float16 float16_minnum_noprop(float16, float16, float_status *status)=
;<br>
&gt; +float16 float16_maxnum_noprop(float16, float16, float_status *status)=
;<br>
&gt;=C2=A0 float16 float16_sqrt(float16, float_status *status);<br>
&gt;=C2=A0 FloatRelation float16_compare(float16, float16, float_status *st=
atus);<br>
&gt;=C2=A0 FloatRelation float16_compare_quiet(float16, float16, float_stat=
us *status);<br>
&gt; @@ -359,6 +361,8 @@ float32 float32_minnum(float32, float32, float_sta=
tus *status);<br>
&gt;=C2=A0 float32 float32_maxnum(float32, float32, float_status *status);<=
br>
&gt;=C2=A0 float32 float32_minnummag(float32, float32, float_status *status=
);<br>
&gt;=C2=A0 float32 float32_maxnummag(float32, float32, float_status *status=
);<br>
&gt; +float32 float32_minnum_noprop(float32, float32, float_status *status)=
;<br>
&gt; +float32 float32_maxnum_noprop(float32, float32, float_status *status)=
;<br>
&gt;=C2=A0 bool float32_is_quiet_nan(float32, float_status *status);<br>
&gt;=C2=A0 bool float32_is_signaling_nan(float32, float_status *status);<br=
>
&gt;=C2=A0 float32 float32_silence_nan(float32, float_status *status);<br>
&gt; @@ -548,6 +552,8 @@ float64 float64_minnum(float64, float64, float_sta=
tus *status);<br>
&gt;=C2=A0 float64 float64_maxnum(float64, float64, float_status *status);<=
br>
&gt;=C2=A0 float64 float64_minnummag(float64, float64, float_status *status=
);<br>
&gt;=C2=A0 float64 float64_maxnummag(float64, float64, float_status *status=
);<br>
&gt; +float64 float64_minnum_noprop(float64, float64, float_status *status)=
;<br>
&gt; +float64 float64_maxnum_noprop(float64, float64, float_status *status)=
;<br>
&gt;=C2=A0 bool float64_is_quiet_nan(float64 a, float_status *status);<br>
&gt;=C2=A0 bool float64_is_signaling_nan(float64, float_status *status);<br=
>
&gt;=C2=A0 float64 float64_silence_nan(float64, float_status *status);<br>
<br>
<br>
-- <br>
Alex Benn=C3=A9e<br></blockquote><div><br></div>Hi=C2=A0 Alex,<div><br></di=
v><div>1.</div><div>This patch comes from the change of sNaN propagation im=
plementation of riscv=C2=A0floating spec.<br>Take following as example,<br>=
=C2=A0 =C2=A0 fmin.s=C2=A0 ft0, ft1, ft2.<br><br>For spec 2.2,=C2=A0 the sN=
aN handling for fmin and fmax is<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if ft1 is sNaN or ft2 is sNaN<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 a. set the invalid flag<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 b. ft0 is=C2=A0 canonical =
NaN<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ref:=C2=A0<a href=3D"h=
ttps://github.com/riscv/riscv-isa-manual/releases/tag/riscv-user-2.2">https=
://github.com/riscv/riscv-isa-manual/releases/tag/riscv-user-2.2</a><br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 section 8.3<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;For FMIN and FMAX, i=
f at least one input is a signaling NaN, or if both inputs are quiet NaNs,<=
br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0the result=
 is the canonical NaN. If one operand is a quiet NaN and the other is not a=
 NaN, the<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
result is the non-NaN operand.<br><br>For spec=C2=A020191213, the behavior =
is changed to=C2=A0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if f=
t1 or ft2 is sNaN and the other is non-NaN<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0a. set the invalid flag<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0b. ft0 is set=
 to non-NaN source=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0=C2=A0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ref:=C2=A0<=
a href=3D"https://github.com/riscv/riscv-isa-manual/releases/tag/Ratified-I=
MAFDQC" target=3D"_blank">https://github.com/riscv/riscv-isa-manual/release=
s/tag/Ratified-IMAFDQC</a><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0section 11.6<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;If=
 both inputs are NaNs, the result is</div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 the canonical NaN. If only one operand is a NaN, the resu=
lt is the non-NaN operand. Signaling<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 NaN inputs set the invalid operation exception flag, even whe=
n the result is not NaN.&quot;<div><br><div>2.</div><div>As you guess, the =
patch takes the side effect of pick_nan.=C2=A0 The pick_nan does two works<=
br>=C2=A0 =C2=A0a. set invalid flag if input is sNaN</div><div>=C2=A0 =C2=
=A0b. return correct NaN number by configuration</div><div><br></div><div>=
=C2=A0 =C2=A0for one possible case, one operand is sNaN and the other is no=
n-NaN, the patch does</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 a=
. pick_nan to=C2=A0 set invalid_flag but doesn&#39;t use the return value)<=
br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 b. return non-NaN=C2=A0</div><=
div>=C2=A0 for the=C2=A0other case, both operands are sNaN, the patch does<=
br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0a. pick_nan to set_invalid_flag=
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0b=C2=A0 pick_nan to return NaN=
 value</div><div>Is it better to separate the &quot;set invalid flag&quot; =
part from pick_nan to make it concrete ?</div><div><br></div><div>3.</div><=
div>The parameter naming is misleading and will be fix in next separated so=
ftfloat patch.=C2=A0<br></div><div><br>Thanks=C2=A0 =C2=A0 =C2=A0=C2=A0<br>=
</div></div><div><span style=3D"color:rgb(136,136,136)">Chih-Min Chao</span=
>=C2=A0</div></div>
</div>

--000000000000e3425f05aa562888--

