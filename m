Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC08DC433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 06:05:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 855FB20658
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 06:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SVfWc9Lz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 855FB20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyUM6-0008JT-OQ
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 02:05:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43502)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <scw@google.com>) id 1jyULL-0007ru-GV
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 02:04:35 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:37840)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <scw@google.com>) id 1jyULJ-0004OX-JB
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 02:04:35 -0400
Received: by mail-ej1-x641.google.com with SMTP id lx13so5083257ejb.4
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 23:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mlhTFuI/2HM9DI3A8p2KMqGPIZ76+Qd5nYfMCvTr2Oo=;
 b=SVfWc9LzXdIvZ7f9DRm5MCUkgozOUY9ETWV5Kagr084lmzLeKSF85byHa6sSfXiYWP
 EYMtj1ZLTgrXO0o6YpUXBiwwv+jYCON2CGnik5DUiYKDzHHopaF0Dm/0tcI+7r5tGwEW
 Z5bEIG4d26BtZ7EoGc8burmzZL7jCzYRDyGU5R1ol+ZCTnfq61vnI9sTYA9ZMYHJCUYK
 u5gBwzHNmK+3iPVQGkaGmeUDgA7nq1winhEx1HQv7clAnFs6tEMAdm3j8jyXMpJ0AaAJ
 lt5JiL2OTvy6gwvC9taHZpnnS9nUVR1AuENxvgdOMIMKq/UjZUVMXJBnOiN/4IQ10vv/
 zK0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mlhTFuI/2HM9DI3A8p2KMqGPIZ76+Qd5nYfMCvTr2Oo=;
 b=Yf0kWyfYdNxEPVhMA0krmuK/+FyxcDeSUluAcIh59IqJTn25z0oTFnb63jPWuC+xG3
 SO1j2NUisuj6s4B48rgxalvAa/POwzBeWjPEWbmZz3u6eX4aG/kQAT6tFXMYEaiRq7SP
 S1tXMDtRdTAxAiN6Wq6mSky2C+hqnFlFumhytCxgRxwySCL+MGaxOHwDwjr/oJi586Yt
 GK7dsRsivvqx7Lr72C9qjrYb5iEm6+RuDLTfh2EDB0FQnuxCgVuw236LXsLFZSzd+9ql
 rHNscCM5mfkA3ddm/4ylYOXagORBBemVKhdk9dFe7aLXs9S6s+NNbkN23/8eW/KHTC9o
 ekCA==
X-Gm-Message-State: AOAM533upZE5eOaaTXCBUIlPKvR2KBx/qaVMpNRF8ZBasoBjU64qKVEn
 d1FcIZs1LjRNDTz5+i6loJIAgl0AH2ZlsLmu1w8YpQ==
X-Google-Smtp-Source: ABdhPJz3+O12NyhENFLOfsIkc/wQ0jtkIal+eg+got0Ky6xYF7ZsWkLJ9MbVVYKCWFQ68JBYteMZtXW0P1BKkzj6DBI=
X-Received: by 2002:a17:906:f1d5:: with SMTP id
 gx21mr2806159ejb.121.1595484269753; 
 Wed, 22 Jul 2020 23:04:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1595463707.git.scw@google.com>
 <bf706105addcaa3f48391be8f7e5c09c3b1735ae.1595463707.git.scw@google.com>
 <0152137e-638a-dd06-741a-f03830c92ffd@redhat.com>
In-Reply-To: <0152137e-638a-dd06-741a-f03830c92ffd@redhat.com>
From: Shu-Chun Weng <scw@google.com>
Date: Wed, 22 Jul 2020 23:04:18 -0700
Message-ID: <CAF3nBxjpcPW182wJajOkd+kdTcGQOefptDg=R01C7G9DTrQpZA@mail.gmail.com>
Subject: Re: [PATCH 1/2] configure: avx2 and avx512f detection for clang
To: Thomas Huth <thuth@redhat.com>
Cc: rth@twiddle.net, qemu-devel@nongnu.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="0000000000002c5dfc05ab15a16d"
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=scw@google.com; helo=mail-ej1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -185
X-Spam_score: -18.6
X-Spam_bar: ------------------
X-Spam_report: (-18.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000002c5dfc05ab15a16d
Content-Type: multipart/alternative; boundary="0000000000002543c405ab15a153"

--0000000000002543c405ab15a153
Content-Type: text/plain; charset="UTF-8"

Do we have the flexibility to do that for util/bufferiszero.c as well?
Otherwise, we are using different mechanisms to detect (compile test.c with
-mavx2) and actually use (GCC pragma & __attribute__((target(*))))) the
feature in production.

Shu-Chun

On Wed, Jul 22, 2020 at 9:55 PM Thomas Huth <thuth@redhat.com> wrote:

> On 23/07/2020 02.27, Shu-Chun Weng wrote:
> > Since clang does not support "#pragma GCC", the instruction sets are
> > always disabled. In this change, we
> >
> >  1. wrap "#pragma GCC" inside "#ifndef __clang__",
> >  2. only retain them around "#include <{e,i,s}mmintrin.h>" to work
> >     around gcc bug,
> >  3. and annotate each function with `__attribute__((target(*)))` which
> >     is recognized by both gcc and clang.
> >
> > Signed-off-by: Shu-Chun Weng <scw@google.com>
> > ---
> >  configure           | 16 ++++++++++++++--
> >  util/bufferiszero.c | 33 +++++++++++++++++++++++----------
> >  2 files changed, 37 insertions(+), 12 deletions(-)
> >
> > diff --git a/configure b/configure
> > index 4bd80ed507..d9ce3aa5db 100755
> > --- a/configure
> > +++ b/configure
> > @@ -5808,10 +5808,16 @@ fi
> >
> >  if test "$cpuid_h" = "yes" && test "$avx2_opt" != "no"; then
> >    cat > $TMPC << EOF
> > +#include <cpuid.h>
> > +#ifndef __clang__
> >  #pragma GCC push_options
> >  #pragma GCC target("avx2")
> > -#include <cpuid.h>
> > +#endif
> >  #include <immintrin.h>
> > +#ifndef __clang__
> > +#pragma GCC pop_options
> > +#endif
> > +__attribute__((target("avx2")))
> >  static int bar(void *a) {
> >      __m256i x = *(__m256i *)a;
> >      return _mm256_testz_si256(x, x);
>
> I wonder whether it would make more sense to pass "-mavx2" to the
> compile_object call afterwards and simply remove the #pragmas here?
> Did you try that already?
>
>  Thomas
>
>

--0000000000002543c405ab15a153
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Do we have the flexibility to do that for=
 util/bufferiszero.c as well? Otherwise, we are using different mechanisms =
to detect (compile test.c with -mavx2) and actually use (GCC pragma &amp; _=
_attribute__((target(*))))) the feature in production.</div><div dir=3D"ltr=
"><br></div><div>Shu-Chun</div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Wed, Jul 22, 2020 at 9:55 PM Thomas Huth &lt;<a=
 href=3D"mailto:thuth@redhat.com">thuth@redhat.com</a>&gt; wrote:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">On 23/07/2020 02.27, Shu-=
Chun Weng wrote:<br>
&gt; Since clang does not support &quot;#pragma GCC&quot;, the instruction =
sets are<br>
&gt; always disabled. In this change, we<br>
&gt; <br>
&gt;=C2=A0 1. wrap &quot;#pragma GCC&quot; inside &quot;#ifndef __clang__&q=
uot;,<br>
&gt;=C2=A0 2. only retain them around &quot;#include &lt;{e,i,s}mmintrin.h&=
gt;&quot; to work<br>
&gt;=C2=A0 =C2=A0 =C2=A0around gcc bug,<br>
&gt;=C2=A0 3. and annotate each function with `__attribute__((target(*)))` =
which<br>
&gt;=C2=A0 =C2=A0 =C2=A0is recognized by both gcc and clang.<br>
&gt; <br>
&gt; Signed-off-by: Shu-Chun Weng &lt;<a href=3D"mailto:scw@google.com" tar=
get=3D"_blank" class=3D"cremed">scw@google.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 configure=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 16 +++++++++=
+++++--<br>
&gt;=C2=A0 util/bufferiszero.c | 33 +++++++++++++++++++++++----------<br>
&gt;=C2=A0 2 files changed, 37 insertions(+), 12 deletions(-)<br>
&gt; <br>
&gt; diff --git a/configure b/configure<br>
&gt; index 4bd80ed507..d9ce3aa5db 100755<br>
&gt; --- a/configure<br>
&gt; +++ b/configure<br>
&gt; @@ -5808,10 +5808,16 @@ fi<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 if test &quot;$cpuid_h&quot; =3D &quot;yes&quot; &amp;&amp; test=
 &quot;$avx2_opt&quot; !=3D &quot;no&quot;; then<br>
&gt;=C2=A0 =C2=A0 cat &gt; $TMPC &lt;&lt; EOF<br>
&gt; +#include &lt;cpuid.h&gt;<br>
&gt; +#ifndef __clang__<br>
&gt;=C2=A0 #pragma GCC push_options<br>
&gt;=C2=A0 #pragma GCC target(&quot;avx2&quot;)<br>
&gt; -#include &lt;cpuid.h&gt;<br>
&gt; +#endif<br>
&gt;=C2=A0 #include &lt;immintrin.h&gt;<br>
&gt; +#ifndef __clang__<br>
&gt; +#pragma GCC pop_options<br>
&gt; +#endif<br>
&gt; +__attribute__((target(&quot;avx2&quot;)))<br>
&gt;=C2=A0 static int bar(void *a) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 __m256i x =3D *(__m256i *)a;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return _mm256_testz_si256(x, x);<br>
<br>
I wonder whether it would make more sense to pass &quot;-mavx2&quot; to the=
<br>
compile_object call afterwards and simply remove the #pragmas here?<br>
Did you try that already?<br>
<br>
=C2=A0Thomas<br>
<br>
</blockquote></div></div>

--0000000000002543c405ab15a153--

--0000000000002c5dfc05ab15a16d
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPAAYJKoZIhvcNAQcCoIIO8TCCDu0CAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggxjMIIEkjCCA3qgAwIBAgINAewckktV4F6Q7sAtGDANBgkqhkiG9w0BAQsFADBMMSAwHgYDVQQL
ExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UEAxMK
R2xvYmFsU2lnbjAeFw0xODA2MjAwMDAwMDBaFw0yODA2MjAwMDAwMDBaMEsxCzAJBgNVBAYTAkJF
MRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSEwHwYDVQQDExhHbG9iYWxTaWduIFNNSU1FIENB
IDIwMTgwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCUeobu8FdB5oJg6Fz6SFf8YsPI
dNcq4rBSiSDAwqMNYbeTpRrINMBdWuPqVWaBX7WHYMsKQwCOvAF1b7rkD+ROo+CCTJo76EAY25Pp
jt7TYP/PxoLesLQ+Ld088+BeyZg9pQaf0VK4tn23fOCWbFWoM8hdnF86Mqn6xB6nLsxJcz4CUGJG
qAhC3iedFiCfZfsIp2RNyiUhzPAqalkrtD0bZQvCgi5aSNJseNyCysS1yA58OuxEyn2e9itZJE+O
sUeD8VFgz+nAYI5r/dmFEXu5d9npLvTTrSJjrEmw2/ynKn6r6ONueZnCfo6uLmP1SSglhI/SN7dy
L1rKUCU7R1MjAgMBAAGjggFyMIIBbjAOBgNVHQ8BAf8EBAMCAYYwJwYDVR0lBCAwHgYIKwYBBQUH
AwIGCCsGAQUFBwMEBggrBgEFBQcDCTASBgNVHRMBAf8ECDAGAQH/AgEAMB0GA1UdDgQWBBRMtwWJ
1lPNI0Ci6A94GuRtXEzs0jAfBgNVHSMEGDAWgBSP8Et/qC5FJK5NUPpjmove4t0bvDA+BggrBgEF
BQcBAQQyMDAwLgYIKwYBBQUHMAGGImh0dHA6Ly9vY3NwMi5nbG9iYWxzaWduLmNvbS9yb290cjMw
NgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIzLmNybDBn
BgNVHSAEYDBeMAsGCSsGAQQBoDIBKDAMBgorBgEEAaAyASgKMEEGCSsGAQQBoDIBXzA0MDIGCCsG
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
aHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wUQYIKwYBBQUHAQEERTBDMEEG
CCsGAQUFBzAChjVodHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc3NtaW1lY2Ey
MDE4LmNydDAfBgNVHSMEGDAWgBRMtwWJ1lPNI0Ci6A94GuRtXEzs0jA/BgNVHR8EODA2MDSgMqAw
hi5odHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2NhL2dzc21pbWVjYTIwMTguY3JsMA0GCSqGSIb3
DQEBCwUAA4IBAQB0zgx4rAhCKzIVBMrEn4R/8FrisDQWZwJvA4VLbgtBPI1kP/Ys+cw3oYecxHED
MAHXOYclqmcaKudfjsLKZ/jrpdjZMAHDazo86g4BREWWiAxAtnMPhKrL4Ciqs0Yx/fj4VJlJRgES
1wscHQQNh2BgbqP15O5D2CtZVsLIuc9pSY3DZNYUrMQy55hszPnhgeghImVgNLtzUkF8oLKlnrWs
blvMc7fi7e42/rSnhbE6WUWGHvXcQ3+qIptP079GF+p1ZnEVmXIrQeoP1Rh0wS2ThPBorHqMY8OB
+c1AbPa2A/qY7QkFA6Oq7I8gUPNRO1NyuEElN4LJy+SCH0kWzLawMYICYTCCAl0CAQEwXzBLMQsw
CQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEhMB8GA1UEAxMYR2xvYmFsU2ln
biBTTUlNRSBDQSAyMDE4AhAB2NRaeBKJjaSQ9CGctwQsMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqG
SIb3DQEJBDEiBCBAU3aUnvf1zBbdJ5xmDM0JPHRAwDylaBiC/EPSSqq5kDAYBgkqhkiG9w0BCQMx
CwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMDA3MjMwNjA0MzBaMGkGCSqGSIb3DQEJDzFc
MFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJ
KoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEATeEK
vgRTWmnrm/Sd5mIu8S6+f76BV6XSSugZnaHsFvBr5Q+YZJDUuP/+UQql2n12nmmB/Re+7mA4wo+5
twjzDVp2sHHOAppFo4UqRVBXgsTwqZ9pLiewvJREApBO1kDMbBvxqYt8clY0OBxwZ2l/CF2ot0Na
jNm+FUZIxu851TSqxDsXoIc8Gfb+WIEiLY0uVGNKi2CeICfwcSzbBbnt016CukEHylnDvSfsbk0O
ee9ybuJV53v/pMJyaBcD+9kAkj2TsnDr7RLTBPk/FsLhfygAZlW2nVqTivJ1p/d68m4fGwthTlNr
m8TcyZh9blAlkVveYhovXL0vxtYidWGsKg==
--0000000000002c5dfc05ab15a16d--

