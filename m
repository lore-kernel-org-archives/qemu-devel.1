Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A60C43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 08:20:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5010B21D40
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 08:20:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dzyXZpcH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5010B21D40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGeHr-0005FT-C5
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 04:20:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57916)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kGeHE-0004Ng-07
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 04:19:24 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529]:42633)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kGeHC-0007sm-9S
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 04:19:23 -0400
Received: by mail-ed1-x529.google.com with SMTP id l63so9062461edl.9
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 01:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jgo7pl7a3u3ghk5Kabvk/rKmHGsrfEWq3QWdY2nVIOQ=;
 b=dzyXZpcHH/JVOjun+ZJvQygLlbn4yr02ktCOyBItwyQTJhLh8FjImraMHTQukZPbRV
 DRit7xT15SeOY0ue2pGDR7cmWrSiwOMyJqhOxBbCSho10aAlkyo7b24wowEB+GZvP0VO
 5Xr0T0YCDDkaL7PfLerJDrYhthF/MddG6QQgWspL+SN3fSpHJsnstgoXa4pxlG0Wlt+i
 RHgrKPw4Je82rJ5rQbp7M5mMBuRr3nFHrEoxYe55mz9qD0KOYZVRzG5ay5q2dA+beuOS
 jT7M4YD97lmMsuv49to2j8hev3scCBRUB/jinG0PZNHP0Mx+Q1iuhx+Lse+VXZttTF7a
 C2qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jgo7pl7a3u3ghk5Kabvk/rKmHGsrfEWq3QWdY2nVIOQ=;
 b=IRcreJN40FyIWEjCQNU+BXcOsxbdC1OVjms68XLXZf6FlE2iERFfhyScmqOrp+Rr8j
 mYKJUlyi3FzIaxEYVWNLhFFts7J0KU/ttl7/s23PPT87kVi8+4+okSQRxWuEX6lYFm0J
 zTGx7QA14lhMTuUkVW0n2oJBU1FFjlvekyVmrZ9BB21vvSN54rd26f/iONu/MXdjno/a
 hwgkIUUfhQpU8aqnvHGoSw1/IOF/zpLhXOrAB478Otb47WKTMaWwtzoN5tpmmhInX5US
 Jbn6wszYvcY35M/ueJSrDmnrJ3gwz7jYc27qixqsiOK1Rt854TwbX0JL74kJV2iE5edE
 AT9Q==
X-Gm-Message-State: AOAM533DCss4V4yYQQyGoI883jaGZdu3M6UZXEE6Ttz/aE0qB4EKyHF6
 WTPN9nvc3eZvK+jTjdSDgfEMCIapU0BT/GfrjTo=
X-Google-Smtp-Source: ABdhPJwY8LszcTIO7a0xpMHeDAWvY22w5TSE1rx4U5JA/o9BkQSbHJmXQgUCF4WqgEX+qpaO6Ftb0Zm6cBCVdqtV/JI=
X-Received: by 2002:a50:bb65:: with SMTP id y92mr802434ede.53.1599812360534;
 Fri, 11 Sep 2020 01:19:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200910194903.4104696-1-ehabkost@redhat.com>
 <CAJ+F1CLLKesMvZo4DJcC=f387d_fN8g--qX8YEQGu8Thf1qotA@mail.gmail.com>
 <20200911081018.GA1203593@redhat.com>
In-Reply-To: <20200911081018.GA1203593@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 11 Sep 2020 12:19:08 +0400
Message-ID: <CAJ+F1C+T9mgwWSsxzhBZyUiYNwhd+ATie3i=8Bari5VQUAfxoQ@mail.gmail.com>
Subject: Re: [PATCH 00/18] chardev: QOM cleanups
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000075047b05af055781"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ed1-x529.google.com
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000075047b05af055781
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Fri, Sep 11, 2020 at 12:10 PM Daniel P. Berrang=C3=A9 <berrange@redhat.c=
om>
wrote:

> On Fri, Sep 11, 2020 at 12:07:27PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Thu, Sep 10, 2020 at 11:50 PM Eduardo Habkost <ehabkost@redhat.com>
> > wrote:
> >
> > > Some chardev QOM cleanup patches had to be dropped from my queue
> > > due to build erros introduced by code movements across ifdef
> > > boundaries at char-parallel.c.  This series redo the changes from
> > > those patches, but the macro renames are now a little different:
> > >
> > > In this version I have decided to rename the type checking macros
> > > from *_CHARDEV to CHARDEV_* instead of renaming tye
> > > TYPE_CHARDEV_* constants to TYPE_*_CHARDEV, to make the
> > > identifiers actually match the QOM type name strings
> > > ("chardev-*").
> > >
> >
> > Sounds reasonable to me, but it loses the matching with the
> > structure/object type name though.
> >
> > - MuxChardev *d =3D MUX_CHARDEV(s);
> > + MuxChardev *d =3D CHARDEV_MUX(s);
> >
> > I have a preference for the first. Unless we rename all the chardev typ=
es
> > too...
>
> I tend to think the structs should be renamed too - I've always considerd
> them to be backwards.
>
> > Imho, the QOM type name is mostly an internal detail, the C type name i=
s
> > dominant in the code.
>
> Err it is the reverse. The QOM type name is exposed public API via QOM
> commands, while the C struct names are a internal private detail.
>
>
Yes, but without the chardev- prefix (unless you try object-add which I
don't think will work with chardev)


--=20
Marc-Andr=C3=A9 Lureau

--00000000000075047b05af055781
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Sep 11, 2020 at 12:10 PM Da=
niel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berrange@r=
edhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">On Fri, Sep 11, 2020 at 12:07:27PM +0400, Marc-Andr=C3=A9 Lureau=
 wrote:<br>
&gt; Hi<br>
&gt; <br>
&gt; On Thu, Sep 10, 2020 at 11:50 PM Eduardo Habkost &lt;<a href=3D"mailto=
:ehabkost@redhat.com" target=3D"_blank">ehabkost@redhat.com</a>&gt;<br>
&gt; wrote:<br>
&gt; <br>
&gt; &gt; Some chardev QOM cleanup patches had to be dropped from my queue<=
br>
&gt; &gt; due to build erros introduced by code movements across ifdef<br>
&gt; &gt; boundaries at char-parallel.c.=C2=A0 This series redo the changes=
 from<br>
&gt; &gt; those patches, but the macro renames are now a little different:<=
br>
&gt; &gt;<br>
&gt; &gt; In this version I have decided to rename the type checking macros=
<br>
&gt; &gt; from *_CHARDEV to CHARDEV_* instead of renaming tye<br>
&gt; &gt; TYPE_CHARDEV_* constants to TYPE_*_CHARDEV, to make the<br>
&gt; &gt; identifiers actually match the QOM type name strings<br>
&gt; &gt; (&quot;chardev-*&quot;).<br>
&gt; &gt;<br>
&gt; <br>
&gt; Sounds reasonable to me, but it loses the matching with the<br>
&gt; structure/object type name though.<br>
&gt; <br>
&gt; - MuxChardev *d =3D MUX_CHARDEV(s);<br>
&gt; + MuxChardev *d =3D CHARDEV_MUX(s);<br>
&gt; <br>
&gt; I have a preference for the first. Unless we rename all the chardev ty=
pes<br>
&gt; too...<br>
<br>
I tend to think the structs should be renamed too - I&#39;ve always conside=
rd<br>
them to be backwards.<br>
<br>
&gt; Imho, the QOM type name is mostly an internal detail, the C type name =
is<br>
&gt; dominant in the code.<br>
<br>
Err it is the reverse. The QOM type name is exposed public API via QOM<br>
commands, while the C struct names are a internal private detail.<br>
<br></blockquote><div><br></div><div>Yes, but without the chardev- prefix (=
unless you try object-add which I don&#39;t think will work with chardev) <=
br></div></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"gmail=
_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--00000000000075047b05af055781--

