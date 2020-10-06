Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553FFC41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 08:44:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85B662080A
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 08:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GuV686ar"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85B662080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPiaZ-0008Sq-Cg
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 04:44:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55364)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kPiX4-00066o-43
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 04:41:14 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631]:33710)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kPiX2-00030l-Ad
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 04:41:13 -0400
Received: by mail-ej1-x631.google.com with SMTP id c22so15072832ejx.0
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 01:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=o6FOmTAhVyYGMcAf1PB6hbfQknro5cZ7zds/7nsigrw=;
 b=GuV686arF/8B9HX2NRTFatnmw3p3SUXPhsC8DCGejlP/z159IFhIipMghl4l8V9tc0
 w/UXfgs+mM32JoP5AJwulbEJlgHHADFyQf60yR0ZUrrWcC5ZlIQ1sG4W4NQnbZhp2HhR
 /wGgrEeOdK+puzMlDf2J7Lvd+5SAwVkZk2w92vY1Yiy3EpA/2soTg9cA3Dr99z37XQBr
 l9aC3pq53uvMmQEpTmL7xOnP0cm5dAlKhnhgQ1bwknqZY8NSyWIxmUduPXk+H+Ov7fFH
 W1F9QiamKNMtmMQ+8G2gM+WVOXiULwkljJN5BO7dY3zEuw7F1ERJEdHT+57ALdbQXxDY
 uHQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=o6FOmTAhVyYGMcAf1PB6hbfQknro5cZ7zds/7nsigrw=;
 b=AOw1n7pA8VV8nJi7XGX927A8ndqwRuxy/u8WKuHWj2AoGR6NhMYC8dt7weEx/H+Jvq
 NjkRInF0ZQLyZ+Vm8PEU1bk7BCSXX4hte2zunNdU4EekDDpEmQ4OsqR+/iLMzs+Nn/Er
 H7GAKwfZiLWRwWMaWPOn6O2Qe80kWtXk6fWoyuZBdedLTd2WmPMSKSfktZf+EPrXoOE0
 cAHgOKS04CA85J9A4AKxbeuELA//UP4taJ+Plgvr40YVi5nhW/MR96lCFeAHGO43BLli
 HRQJ7t8vwWr228BC/vuU5HpX+HUpKvky1lDJGXfRX+6V9XiPJGe11uVYfSe6jx4fZSfP
 1EFg==
X-Gm-Message-State: AOAM531rqVVeml0FNYMCaDkgplDZNhyxZ+q3Dod3GEg2u6Gi9doZOeSZ
 m156smRgpLqnXTJf0i/nomBDp4EPqB1njTEj3so=
X-Google-Smtp-Source: ABdhPJwqMh2+nuyaZ4b3meaqE7PmZtYpc1cUjmdLbsBfTGh4OwlnyBjGdvo230R2id3KS40hefbd9j8FrVAhoSMv5j8=
X-Received: by 2002:a17:906:e949:: with SMTP id
 jw9mr3980449ejb.109.1601973670981; 
 Tue, 06 Oct 2020 01:41:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1599470071.git.tgolembi@redhat.com>
 <1bf9ede3b9273613319ff8ff99b40c385439cfa8.1599470071.git.tgolembi@redhat.com>
 <CAJ+F1C+FPkg-fznQdfqnioJ9CD3fi7apW34ad=cQMgzRsphqCQ@mail.gmail.com>
 <20201006083141.m4xmo2pzlte72pzp@auriga.localdomain>
In-Reply-To: <20201006083141.m4xmo2pzlte72pzp@auriga.localdomain>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 6 Oct 2020 12:40:58 +0400
Message-ID: <CAJ+F1CK0hnmYT=fxvuePHyt3je5KYn4KZva-jFoRM4ZTqsNTPQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] qga: add implementation of guest-get-disks for
 Linux
To: =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000099357f05b0fc8fef"
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ej1-x631.google.com
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
Cc: Thomas Huth <thuth@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000099357f05b0fc8fef
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Tue, Oct 6, 2020 at 12:31 PM Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi=
@redhat.com>
wrote:

> On Tue, Sep 29, 2020 at 07:22:00PM +0400, Marc-Andr=C3=A9 Lureau wrote:
>
> > > +        if (getline(&line, &n, fp) =3D=3D -1) {
> > > +            g_debug("  failed to read disk size");
> > >
> >
> > line: getline(3) "This buffer should be freed by the user program even =
if
> > getline() failed."
>
> That is handled by the g_autofree, or am I missing something? `line`
> will get out of scope after every interation (even with continue). Or do
>
>
Ah right, I got confused.

thanks

--=20
Marc-Andr=C3=A9 Lureau

--00000000000099357f05b0fc8fef
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi<br></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Tue, Oct 6, 2020 at 12:31 PM Tom=C3=A1=C5=
=A1 Golembiovsk=C3=BD &lt;<a href=3D"mailto:tgolembi@redhat.com">tgolembi@r=
edhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">On Tue, Sep 29, 2020 at 07:22:00PM +0400, Marc-Andr=C3=A9 Lureau=
 wrote:<br><br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (getline(&amp;line, &amp;n, fp) =
=3D=3D -1) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;=C2=A0 f=
ailed to read disk size&quot;);<br>
&gt; &gt;<br>
&gt; <br>
&gt; line: getline(3) &quot;This buffer should be freed by the user program=
 even if<br>
&gt; getline() failed.&quot;<br>
<br>
That is handled by the g_autofree, or am I missing something? `line`<br>
will get out of scope after every interation (even with continue). Or do<br=
><br></blockquote><div>=C2=A0</div><div>Ah right, I got confused.<br></div>=
<div><br></div>thanks<br clear=3D"all"></div><br>-- <br><div dir=3D"ltr" cl=
ass=3D"gmail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--00000000000099357f05b0fc8fef--

