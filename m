Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10580C00A89
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 12:45:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61EE420756
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 12:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqFkB0X2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61EE420756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaedX-0004Q9-7v
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 07:45:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45524)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kaeS6-0007K3-Bn; Thu, 05 Nov 2020 07:33:18 -0500
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:40486)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kaeS1-0005uI-Np; Thu, 05 Nov 2020 07:33:18 -0500
Received: by mail-lf1-x142.google.com with SMTP id e27so2039874lfn.7;
 Thu, 05 Nov 2020 04:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=MZSnS5vlxF5HvO6E9wZPRhJNQ+5D6tAp8z2brb2h4Yg=;
 b=lqFkB0X2eaD8jujC/4i9LsM4zAFthnvnrLrsVl0m4sqON4EZFcefB0g7scyMmKCluR
 DHuGi41nfNmc8YolBJ7mbts50wvEI0P2GMRDU3CJasU69xJJnP1InKmFy5/XSv5MCfLZ
 3bL6oC3+ojIDeI0S63KzT61hvp3LGOBYXH53V1ik2nh1+hshGK5wbgPBZS4z6ho8AabM
 uXUk8QMW0FN8zmlyAGVY00ztDuM1bvCoAxJINMK7HCut873QgfnJvrgYY47kroQ4HdW3
 0+nNMv90eYhOdohFcxywSzQrqOEkU+xctQFKYP7UF87aUxpDAb8K3E0482VPith2npMN
 8HwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=MZSnS5vlxF5HvO6E9wZPRhJNQ+5D6tAp8z2brb2h4Yg=;
 b=qm44nKcFynnWHlJgvz0tEzx112fA5oDl67GL8748rWSlGPszuRAJ15U5h7PWrndDum
 ojDvMtz6sSTLzrTR68fNKhLaRMREmv7y++U42gCqVmtey9tmlqx0YFxP5ByZM1bv67et
 hhiT5TuLs5J16dGA6OqlUUmA9R5lrRJ0MwWS/UOPkUJ1+u7WsabZ0agxR7ee0Fh1kNID
 QtB55cWTWOJvrEEBES9CqXZRqC6OtIxo5eJMMQcAWab1byNDWS1FjjVhaaVueKUq48Zt
 4HvzDkGD11ucliCUW1LuTw/6gEfDSny250Ilvccr/QnwP1vm18iSKlZuB9lyQtHHVJhU
 K1Mg==
X-Gm-Message-State: AOAM530j60KFALexI6tsczwVDcyf6uCYIWsDmQrq/00Od+EFnPgdB9e9
 41ozovvrlmVxNo2l9YCG69LS3jhzq39zfyyET/g=
X-Google-Smtp-Source: ABdhPJwnHna168H02RyggCsw2WAF2Fye32sa3Y46YKtZxdvig68wj6CZ0rmIlIGRKWpMYCSZqpO2yv6TDYlbJLhVGv0=
X-Received: by 2002:a19:e88:: with SMTP id 130mr840022lfo.599.1604579590103;
 Thu, 05 Nov 2020 04:33:10 -0800 (PST)
MIME-Version: 1.0
References: <20201013001545.1958-1-luoyonggang@gmail.com>
 <20201013001545.1958-3-luoyonggang@gmail.com>
 <2e501256-001e-a9c4-305c-f178d1b53137@redhat.com>
In-Reply-To: <2e501256-001e-a9c4-305c-f178d1b53137@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Thu, 5 Nov 2020 20:32:59 +0800
Message-ID: <CAE2XoE9datOEr3T391pPmQbD_8bKZgAL_hVoEonojVn-e0Z8PQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] block: enable libnfs on msys2/mingw in cirrus.yml
To: Max Reitz <mreitz@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000007b68e905b35b4cf9"
Received-SPF: pass client-ip=2a00:1450:4864:20::142;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x142.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: luoyonggang@gmail.com
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Kevin Wolf <kwolf@redhat.com>,
 Peter Lieven <pl@kamp.de>, qemu-level <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000007b68e905b35b4cf9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2020 at 7:43 PM Max Reitz <mreitz@redhat.com> wrote:
>
> On 13.10.20 02:15, Yonggang Luo wrote:
> > At the begging libnfs are not enabled because of compiling error,
> > now it's fixed so enable it
> >
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > ---
> >   .cirrus.yml | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/.cirrus.yml b/.cirrus.yml
> > index f42ccb956a..2c6bf45e6d 100644
> > --- a/.cirrus.yml
> > +++ b/.cirrus.yml
> > @@ -109,6 +109,7 @@ windows_msys2_task:
> >             mingw-w64-x86_64-cyrus-sasl \
> >             mingw-w64-x86_64-curl \
> >             mingw-w64-x86_64-gnutls \
> > +          mingw-w64-x86_64-libnfs \
> >             "
> >           bitsadmin /transfer msys_download /dynamic /download
/priority FOREGROUND `
> >
https://repo.msys2.org/mingw/x86_64/mingw-w64-x86_64-python-sphinx-2.3.1-1-=
any.pkg.tar.xz
`
>
> I=E2=80=99d love to test this, unfortunately git.qemu.org has some issues=
 now
> and so I can=E2=80=99t run Cirrus tests. :/
>
> I suppose I=E2=80=99ll retry when git.qemu.org works again.
>
> Max
>
Maybe we arealdy switched to gitlab?

--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000007b68e905b35b4cf9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Thu, Nov 5, 2020 at 7:43 PM Max Reitz &lt;<a hr=
ef=3D"mailto:mreitz@redhat.com">mreitz@redhat.com</a>&gt; wrote:<br>&gt;<br=
>&gt; On 13.10.20 02:15, Yonggang Luo wrote:<br>&gt; &gt; At the begging li=
bnfs are not enabled because of compiling error,<br>&gt; &gt; now it&#39;s =
fixed so enable it<br>&gt; &gt;<br>&gt; &gt; Signed-off-by: Yonggang Luo &l=
t;<a href=3D"mailto:luoyonggang@gmail.com">luoyonggang@gmail.com</a>&gt;<br=
>&gt; &gt; ---<br>&gt; &gt; =C2=A0 .cirrus.yml | 1 +<br>&gt; &gt; =C2=A0 1 =
file changed, 1 insertion(+)<br>&gt; &gt;<br>&gt; &gt; diff --git a/.cirrus=
.yml b/.cirrus.yml<br>&gt; &gt; index f42ccb956a..2c6bf45e6d 100644<br>&gt;=
 &gt; --- a/.cirrus.yml<br>&gt; &gt; +++ b/.cirrus.yml<br>&gt; &gt; @@ -109=
,6 +109,7 @@ windows_msys2_task:<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 mingw-w64-x86_64-cyrus-sasl \<br>&gt; &gt; =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 mingw-w64-x86_64-curl \<br>&gt; &gt; =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mingw-w64-x86_64-gnutls \<br>&gt; &gt; + =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mingw-w64-x86_64-libnfs \<br>&gt; &gt; =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;<br>&gt; &gt; =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 bitsadmin /transfer msys_download /dynamic /download /=
priority FOREGROUND `<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 <a href=3D"https://repo.msys2.org/mingw/x86_64/mingw-w64-x86_64-python-=
sphinx-2.3.1-1-any.pkg.tar.xz">https://repo.msys2.org/mingw/x86_64/mingw-w6=
4-x86_64-python-sphinx-2.3.1-1-any.pkg.tar.xz</a> `<br>&gt;<br>&gt; I=E2=80=
=99d love to test this, unfortunately <a href=3D"http://git.qemu.org">git.q=
emu.org</a> has some issues now<br>&gt; and so I can=E2=80=99t run Cirrus t=
ests. :/<br>&gt;<br>&gt; I suppose I=E2=80=99ll retry when <a href=3D"http:=
//git.qemu.org">git.qemu.org</a> works again.<br>&gt;<br>&gt; Max<br>&gt;<b=
r>Maybe we arealdy switched to gitlab?<br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A=
<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo</div>

--0000000000007b68e905b35b4cf9--

