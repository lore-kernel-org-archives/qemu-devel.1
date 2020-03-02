Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C72F8C3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 21:05:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F9A321D56
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 21:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s0bAys15"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F9A321D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8sGE-0005mX-HS
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 16:05:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42987)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j8sFW-0004zx-Qs
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 16:05:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j8sFV-0001Wk-6w
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 16:05:14 -0500
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232]:45406)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1j8sFU-0001Vu-Vx; Mon, 02 Mar 2020 16:05:13 -0500
Received: by mail-oi1-x232.google.com with SMTP id v19so664489oic.12;
 Mon, 02 Mar 2020 13:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uOsTYYmk3JNHpnDxPJSm4+e5Ig7FQrCHgTPHOERUesw=;
 b=s0bAys15cvAz2uCgowmu3kSMkgMb+Hbe7UUPiLZ9SZdae9or8zf3UGjQtC95SqI1x1
 2dAqwkVezPnInaeb9Ols7CRXr4pd0mH3ekhiWGjRE77NOdE3YZx6VugJGm1FWBhOO2TB
 zRK/p4EaXBrmr5Xhgv+XvZJNh8TAhzAZGARdcbp8kfWCKKCKRz+fnoaFwwEdqX1yphFO
 U2+LRK6QB+T8tDO/teH1W+JGlehkcPqdL0hFxw6Nn/TtPtJAXdlgIASmYH93g400107W
 UB1ItLn3eISod/rOZckeKEVhbx+sdyNb+TRFG2CMMpiZ4Y7GHjsYL73thVyeFrijwD2F
 poEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uOsTYYmk3JNHpnDxPJSm4+e5Ig7FQrCHgTPHOERUesw=;
 b=H2c+ffvhT8YuEM0RI6c8uyYieCKPt22dIFRn5CigOABOGBVB3NbibQl/d/z+6gtvuf
 sUzkVgQAX1jvsOdVQwmz0ratqf2+UZrsRvNeWOWjA8+Zb+Yo1gUM497OH1mbF2Md7KLa
 DptzASrP2hTM0L8iofLp7exI2RJwpDPTvXVqjudIHtvZRRMVLBSLazb6I4ZLgd/i7jzo
 gmdLM2TLplsEyN7tBY4jdbuL6KZVsznSH7+JA9oxh4hhYOm+RkUDL3WSsrki0qFIx9xX
 yl31rFvwHn0pEgolKNlFzhPBZN+6ZXLetbuHgHhRVxWVFmRKuo6pQ/HTqATszqtVsZxN
 wsSw==
X-Gm-Message-State: ANhLgQ2vWYBeuv6eoCxveH6PpMSheL/8Y2/h0jaWS6RyTLbv1MtCH2di
 AYszZwfYjLFM59WO6ucpBp7GTeQ5hf5s6U362Nc=
X-Google-Smtp-Source: ADFU+vtbi3tPjuOeO/cMf4B0iVj+kH2U0dt7Bbf80jZLYgqMAjYbTxJ1LgRmfcNg3jsiPPGuMoCHoLwVNUhM2lgKZv0=
X-Received: by 2002:aca:c3c5:: with SMTP id t188mr241853oif.53.1583183111562; 
 Mon, 02 Mar 2020 13:05:11 -0800 (PST)
MIME-Version: 1.0
References: <20200228071914.11746-1-vsementsov@virtuozzo.com>
 <20200228071914.11746-2-vsementsov@virtuozzo.com>
 <CAL1e-=hX=7OJP-Rpc5TtVQkftq_F3wrh-auYt7yjAe+2i3whHQ@mail.gmail.com>
 <75b4d5ad-f95f-dab2-1b53-5e654c29015e@virtuozzo.com>
In-Reply-To: <75b4d5ad-f95f-dab2-1b53-5e654c29015e@virtuozzo.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 2 Mar 2020 22:05:00 +0100
Message-ID: <CAL1e-=gkw9_UJ-0zYx_qUYfRpGmpi-otXf2VnR=5SYDhm=RCGw@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] scripts/simplebench: add simplebench.py
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Content-Type: multipart/alternative; boundary="000000000000faa7bf059fe58a6b"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::232
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "open list:bochs" <qemu-block@nongnu.org>,
 Stefan Hajnoczi <stefanha@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000faa7bf059fe58a6b
Content-Type: text/plain; charset="UTF-8"

> >> +
> >> +
> >> +def ascii_one(result):
> >> +    """Return ASCII representation of bench_one() returned dict."""
> >> +    if 'average' in result:
> >> +        s = '{:.2f} +- {:.2f}'.format(result['average'],
result['delta'])
> >> +        if 'n-failed' in result:
> >> +            s += '\n({} failed)'.format(result['n-failed'])
> >> +        return s
> >> +    else:
> >> +        return 'FAILED'
> >
> > I think it would be visually clearer if "+-" was printed without any
> > space between it and the following number, using something
> > like this:
> >
> > s = ' {:.2f} +-{:.2f}'.format(result['average'], result['delta'])
> >
> > The resulting table would look like:
> >
> > ----------  -------------  -------------  -------------
> >              backup-1       backup-2       mirror
> > ssd -> ssd   0.43 +-0.00    4.48 +-0.06    4.38 +-0.02
> > ssd -> hdd   10.60 +-0.08   10.69 +-0.18   10.57 +-0.05
> > ssd -> nbd   33.81 +-0.37   10.67 +-0.17   10.07 +-0.07
> > ----------  -------------  -------------  -------------
> >
> > But, this is just cosmetics.
> >
> > With or without the suggestion above:
> >
> > Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> Thanks for reviewing!
>
> Agree with this change, but I don't think it worth to resend the series
for this one space)
> Hope it may be applied with pull request..
>

I am an occasional Python programmer, and I felt comfortable
reviewing your series, but I am not a maintainer of this directory,
and I believe Eduardo or Cleber or other more active Python
contributors would be better choice for selecting this series in
their pull request.

So, I can't send this series to Peter - Cleber, Eduardo, please
see to it.

Yours,
Aleksandar

> >
> >> +
> >> +
> >> +def bench(test_func, test_envs, test_cases, *args, **vargs):
> >> +    """Fill benchmark table
> >> +
> >> +    test_func -- benchmarking function, see bench_one for description
> >> +    test_envs -- list of test environments, see bench_one
> >> +    test_cases -- list of test cases, see bench_one
> >> +    args, vargs -- additional arguments for bench_one
> >> +
> >> +    Returns dict with the following fields:
> >> +        'envs':  test_envs
> >> +        'cases': test_cases
> >> +        'tab':   filled 2D array, where cell [i][j] is bench_one
result for
> >> +                 test_cases[i] for test_envs[j] (i.e., rows are test
cases and
> >> +                 columns are test environments)
> >> +    """
> >> +    tab = {}
> >> +    results = {
> >> +        'envs': test_envs,
> >> +        'cases': test_cases,
> >> +        'tab': tab
> >> +    }
> >> +    n = 1
> >> +    n_tests = len(test_envs) * len(test_cases)
> >> +    for env in test_envs:
> >> +        for case in test_cases:
> >> +            print('Testing {}/{}: {} :: {}'.format(n, n_tests,
> >> +                                                   env['id'],
case['id']))
> >> +            if case['id'] not in tab:
> >> +                tab[case['id']] = {}
> >> +            tab[case['id']][env['id']] = bench_one(test_func, env,
case,
> >> +                                                   *args, **vargs)
> >> +            n += 1
> >> +
> >> +    print('Done')
> >> +    return results
> >> +
> >> +
> >> +def ascii(results):
> >> +    """Return ASCII representation of bench() returned dict."""
> >> +    from tabulate import tabulate
> >> +
> >> +    tab = [[""] + [c['id'] for c in results['envs']]]
> >> +    for case in results['cases']:
> >> +        row = [case['id']]
> >> +        for env in results['envs']:
> >> +
 row.append(ascii_one(results['tab'][case['id']][env['id']]))
> >> +        tab.append(row)
> >> +
> >> +    return tabulate(tab)
> >> --
> >> 2.21.0
> >>
> >>
>
>
> --
> Best regards,
> Vladimir

--000000000000faa7bf059fe58a6b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br><br>&gt; &gt;&gt; +<br>&gt; &gt;&gt; +<br>&gt; &gt=
;&gt; +def ascii_one(result):<br>&gt; &gt;&gt; + =C2=A0 =C2=A0&quot;&quot;&=
quot;Return ASCII representation of bench_one() returned dict.&quot;&quot;&=
quot;<br>&gt; &gt;&gt; + =C2=A0 =C2=A0if &#39;average&#39; in result:<br>&g=
t; &gt;&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0s =3D &#39;{:.2f} +- {:.2f}&#39;.f=
ormat(result[&#39;average&#39;], result[&#39;delta&#39;])<br>&gt; &gt;&gt; =
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if &#39;n-failed&#39; in result:<br>&gt; &gt;&=
gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s +=3D &#39;\n({} failed)&#3=
9;.format(result[&#39;n-failed&#39;])<br>&gt; &gt;&gt; + =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return s<br>&gt; &gt;&gt; + =C2=A0 =C2=A0else:<br>&gt; &gt;&gt; +=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0return &#39;FAILED&#39;<br>&gt; &gt;<br>&gt; &g=
t; I think it would be visually clearer if &quot;+-&quot; was printed witho=
ut any<br>&gt; &gt; space between it and the following number, using someth=
ing<br>&gt; &gt; like this:<br>&gt; &gt;<br>&gt; &gt; s =3D &#39; {:.2f} +-=
{:.2f}&#39;.format(result[&#39;average&#39;], result[&#39;delta&#39;])<br>&=
gt; &gt;<br>&gt; &gt; The resulting table would look like:<br>&gt; &gt;<br>=
&gt; &gt; ---------- =C2=A0------------- =C2=A0------------- =C2=A0--------=
-----<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0backup-1=
 =C2=A0 =C2=A0 =C2=A0 backup-2 =C2=A0 =C2=A0 =C2=A0 mirror<br>&gt; &gt; ssd=
 -&gt; ssd =C2=A0 0.43 +-0.00 =C2=A0 =C2=A04.48 +-0.06 =C2=A0 =C2=A04.38 +-=
0.02<br>&gt; &gt; ssd -&gt; hdd =C2=A0 10.60 +-0.08 =C2=A0 10.69 +-0.18 =C2=
=A0 10.57 +-0.05<br>&gt; &gt; ssd -&gt; nbd =C2=A0 33.81 +-0.37 =C2=A0 10.6=
7 +-0.17 =C2=A0 10.07 +-0.07<br>&gt; &gt; ---------- =C2=A0------------- =
=C2=A0------------- =C2=A0-------------<br>&gt; &gt;<br>&gt; &gt; But, this=
 is just cosmetics.<br>&gt; &gt;<br>&gt; &gt; With or without the suggestio=
n above:<br>&gt; &gt;<br>&gt; &gt; Reviewed-by: Aleksandar Markovic &lt;<a =
href=3D"mailto:amarkovic@wavecomp.com">amarkovic@wavecomp.com</a>&gt;<br>&g=
t;<br>&gt; Thanks for reviewing!<br>&gt;<br>&gt; Agree with this change, bu=
t I don&#39;t think it worth to resend the series for this one space)<br>&g=
t; Hope it may be applied with pull request..<br><div>&gt;</div><div><br></=
div><div>I am an occasional Python programmer, and I felt comfortable</div>=
<div>reviewing your series, but I am not a maintainer of this directory,</d=
iv><div>and I believe Eduardo or Cleber or other more active Python</div><d=
iv>contributors would be better choice for selecting this series in</div><d=
iv>their pull request.</div><div><br></div><div>So, I can&#39;t send this s=
eries to Peter - Cleber, Eduardo, please</div><div>see to it.</div><div><br=
></div><div>Yours,</div><div>Aleksandar<br></div><div><br></div>&gt; &gt;<b=
r>&gt; &gt;&gt; +<br>&gt; &gt;&gt; +<br>&gt; &gt;&gt; +def bench(test_func,=
 test_envs, test_cases, *args, **vargs):<br>&gt; &gt;&gt; + =C2=A0 =C2=A0&q=
uot;&quot;&quot;Fill benchmark table<br>&gt; &gt;&gt; +<br>&gt; &gt;&gt; + =
=C2=A0 =C2=A0test_func -- benchmarking function, see bench_one for descript=
ion<br>&gt; &gt;&gt; + =C2=A0 =C2=A0test_envs -- list of test environments,=
 see bench_one<br>&gt; &gt;&gt; + =C2=A0 =C2=A0test_cases -- list of test c=
ases, see bench_one<br>&gt; &gt;&gt; + =C2=A0 =C2=A0args, vargs -- addition=
al arguments for bench_one<br>&gt; &gt;&gt; +<br>&gt; &gt;&gt; + =C2=A0 =C2=
=A0Returns dict with the following fields:<br>&gt; &gt;&gt; + =C2=A0 =C2=A0=
 =C2=A0 =C2=A0&#39;envs&#39;: =C2=A0test_envs<br>&gt; &gt;&gt; + =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&#39;cases&#39;: test_cases<br>&gt; &gt;&gt; + =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&#39;tab&#39;: =C2=A0 filled 2D array, where cell [i][j] i=
s bench_one result for<br>&gt; &gt;&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 test_cases[i] for test_envs[j] (i.e., rows are tes=
t cases and<br>&gt; &gt;&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 columns are test environments)<br>&gt; &gt;&gt; + =C2=A0 =C2=
=A0&quot;&quot;&quot;<br>&gt; &gt;&gt; + =C2=A0 =C2=A0tab =3D {}<br>&gt; &g=
t;&gt; + =C2=A0 =C2=A0results =3D {<br>&gt; &gt;&gt; + =C2=A0 =C2=A0 =C2=A0=
 =C2=A0&#39;envs&#39;: test_envs,<br>&gt; &gt;&gt; + =C2=A0 =C2=A0 =C2=A0 =
=C2=A0&#39;cases&#39;: test_cases,<br>&gt; &gt;&gt; + =C2=A0 =C2=A0 =C2=A0 =
=C2=A0&#39;tab&#39;: tab<br>&gt; &gt;&gt; + =C2=A0 =C2=A0}<br>&gt; &gt;&gt;=
 + =C2=A0 =C2=A0n =3D 1<br>&gt; &gt;&gt; + =C2=A0 =C2=A0n_tests =3D len(tes=
t_envs) * len(test_cases)<br>&gt; &gt;&gt; + =C2=A0 =C2=A0for env in test_e=
nvs:<br>&gt; &gt;&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0for case in test_cases:<=
br>&gt; &gt;&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print(&#39;Test=
ing {}/{}: {} :: {}&#39;.format(n, n_tests,<br>&gt; &gt;&gt; + =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 env[&#39;id&#39;], case[&#39;id&#39;]))<br>&gt; &gt;&gt; =
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if case[&#39;id&#39;] not in tab=
:<br>&gt; &gt;&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0tab[case[&#39;id&#39;]] =3D {}<br>&gt; &gt;&gt; + =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0tab[case[&#39;id&#39;]][env[&#39;id&#39;]] =3D bench_on=
e(test_func, env, case,<br>&gt; &gt;&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *args=
, **vargs)<br>&gt; &gt;&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0n +=
=3D 1<br>&gt; &gt;&gt; +<br>&gt; &gt;&gt; + =C2=A0 =C2=A0print(&#39;Done&#3=
9;)<br>&gt; &gt;&gt; + =C2=A0 =C2=A0return results<br>&gt; &gt;&gt; +<br>&g=
t; &gt;&gt; +<br>&gt; &gt;&gt; +def ascii(results):<br>&gt; &gt;&gt; + =C2=
=A0 =C2=A0&quot;&quot;&quot;Return ASCII representation of bench() returned=
 dict.&quot;&quot;&quot;<br>&gt; &gt;&gt; + =C2=A0 =C2=A0from tabulate impo=
rt tabulate<br>&gt; &gt;&gt; +<br>&gt; &gt;&gt; + =C2=A0 =C2=A0tab =3D [[&q=
uot;&quot;] + [c[&#39;id&#39;] for c in results[&#39;envs&#39;]]]<br>&gt; &=
gt;&gt; + =C2=A0 =C2=A0for case in results[&#39;cases&#39;]:<br>&gt; &gt;&g=
t; + =C2=A0 =C2=A0 =C2=A0 =C2=A0row =3D [case[&#39;id&#39;]]<br>&gt; &gt;&g=
t; + =C2=A0 =C2=A0 =C2=A0 =C2=A0for env in results[&#39;envs&#39;]:<br>&gt;=
 &gt;&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0row.append(ascii_one(r=
esults[&#39;tab&#39;][case[&#39;id&#39;]][env[&#39;id&#39;]]))<br>&gt; &gt;=
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0tab.append(row)<br>&gt; &gt;&gt; +<br>&gt=
; &gt;&gt; + =C2=A0 =C2=A0return tabulate(tab)<br>&gt; &gt;&gt; --<br>&gt; =
&gt;&gt; 2.21.0<br>&gt; &gt;&gt;<br>&gt; &gt;&gt;<br>&gt;<br>&gt;<br>&gt; -=
-<br>&gt; Best regards,<br>&gt; Vladimir</div>

--000000000000faa7bf059fe58a6b--

