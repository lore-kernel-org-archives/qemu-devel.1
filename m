Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D28C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 22:46:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2FCE24679
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 22:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FJTzk14B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2FCE24679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwD9V-0003XV-0M
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 17:46:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48690)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iwD2G-00013s-91
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 17:39:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iwD2E-0007tZ-Qs
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 17:39:12 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51785
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iwD2E-0007tF-MW
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 17:39:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580164750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3M2UEvxrZ8i9hm/P0THGbCI0vgrNXwtan7TWYP2J9fo=;
 b=FJTzk14BwwFaBTDcBdCNWOkcr9Ue/18NMSUENljbHZm8QsB5ORmeYjdd+p1UEE6HSDusah
 UWJc5A5PxGmXJyKKvm6N+0wza0yMB5mAcfiUgj072/7TJPO91l8aI7UJaMbih6bYKp8Ddi
 lLtTuudwC2FewmTFPJsWjrAYnYWgCqA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-S3njkpAOPmKe00nLnruJbQ-1; Mon, 27 Jan 2020 17:39:04 -0500
Received: by mail-ed1-f69.google.com with SMTP id n18so8257780edo.17
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2020 14:39:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=I7M/OUt7AisKjpXH2vxRJ5/0IrSdglJwi13jdjevA5k=;
 b=Rj0RmbiXIAjN9nIyhQP0LQsbuPtE+vHlSeXy8BXPEYzHutfqSr6KumHWsYhT/zAoHe
 WacMB4WcHjFTgsTjgBnnwj0647CKJZVMzpV4y8b7advu4Y3VawL82TVNoAP6bcPdGhDZ
 kCU5r/zl0kmn5vmHDUdr+divaP/Pd1YH4QFddW4aWCbBgrNu9rlMlFRFortSFRz8P9tN
 DXFkS1mvuv5w6ADnRFJSJ765AKS5eDK5fI4M3lnePEVN282Te8WzVwd9J3TDMF91DpoW
 slcnwB/6vd16zamcSXi7zo8zEHFxRhg66RvvfIceBk9hjVDJT7CxvNuMSNCxi7GIlsaY
 ye6w==
X-Gm-Message-State: APjAAAW31fLTij/HjrdTy6O2fb9bJyfjMd06gJjy6QGx7P102FhVgQXy
 QXeSFqEtbXbi2EDROurNis+goV39K60SZPFOUeRR9t8KP83CETA+P/3/HhTQZsL0wzwYVIH/Tj4
 WLwQ64GbI34mnbasRaoqRA8stKqLiGxs=
X-Received: by 2002:a17:906:82cb:: with SMTP id
 a11mr733527ejy.206.1580164742934; 
 Mon, 27 Jan 2020 14:39:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqz4Rn43+dLQa5SlcaCYlUEUQFGoX5tCeDcGGDjQTzScJymx8Ka4FQyW9lZK/KWxAJosHjqlCWvlrTeFYsnv5DQ=
X-Received: by 2002:a17:906:82cb:: with SMTP id
 a11mr733514ejy.206.1580164742700; 
 Mon, 27 Jan 2020 14:39:02 -0800 (PST)
MIME-Version: 1.0
References: <20191224134139.GD2710539@redhat.com>
 <30664f6e-81da-a6e6-9b20-037fc91290fb@redhat.com>
 <878slyej29.fsf@dusky.pond.sub.org>
 <a41ae09b-021f-2fda-0b03-7b37c5624ab3@redhat.com>
 <20200123190145.GI657556@redhat.com>
 <2561a069-ce5f-3c30-b04e-db7cd2fcdc85@redhat.com>
 <871rrp474i.fsf@dusky.pond.sub.org> <20200124102743.GB824327@redhat.com>
 <20200124143841.GG4732@dhcp-200-226.str.redhat.com>
 <87sgk3x2im.fsf@dusky.pond.sub.org>
 <20200127115606.GA5669@linux.fritz.box>
 <1c65b678-7bb4-a4cc-5fa6-03d6d27cf381@redhat.com>
In-Reply-To: <1c65b678-7bb4-a4cc-5fa6-03d6d27cf381@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 27 Jan 2020 23:38:49 +0100
Message-ID: <CABgObfZNHP68i4xLEYhBw=cRFgXcKnUKnqEk_7LFseoeKizB=Q@mail.gmail.com>
Subject: Re: Making QEMU easier for management tools and applications
To: John Snow <jsnow@redhat.com>
X-MC-Unique: S3njkpAOPmKe00nLnruJbQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="0000000000002d018f059d26c613"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Cleber Rosa <cleber@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000002d018f059d26c613
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il lun 27 gen 2020, 21:11 John Snow <jsnow@redhat.com> ha scritto:

>
> > ./qemu-core <<EOF
> {
>     "machine": "Q35",
>     "memory": "2GiB",
>     "accel": "kvm"
> }
> EOF
>

And now you have to keep all the syntactic sugar that is in vl.c. I don't
think a redesign of -readconfig should accept anything less verbose than

- machine:
    type: q35
    ram:
       type: memory-backend-hostmem
       size: 2G
- accel:
  - type: kvm

And this is not even taking into account disks.

I like the idea of refactoring all the syntactic sugar into a pre-pass on
command line options. This is not an entirely new idea, see
https://www.mail-archive.com/qemu-devel@nongnu.org/msg35024.html.

I am afraid that this thread is derailing a bit, with lots of pipe dreams
and no actionable items. How do we get it back in track?

Paolo


> No file required, cooperates with readline, avoids crunchy,
> hard-to-maintain CLI syntax. Directly and easily translatable to a
> stored-file configuration. All configuration and documentation is
> centralized via QAPI.
>
> A little worse to type manually, yes. Maybe not bad /enough/ for me to
> want to rescue the CLI which prevents full QAPI-fication and a working
> configuration file.
>
> Arguably, a well documented configuration schema will be much easier to
> browse, discover, and use than a labyrinthine CLI with many stub
> definitions whose options are not exposed in the documentation.
>
> (The argument here is: It's a little harder and a little longer to type,
> but the benefits from the schema organization may improve productivity
> of using QEMU directly instead of harming it.)
>
> --js
>
>

--0000000000002d018f059d26c613
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il lun 27 gen 2020, 21:11 John Snow &lt;<a href=3D"mai=
lto:jsnow@redhat.com">jsnow@redhat.com</a>&gt; ha scritto:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex"><br>
&gt; ./qemu-core &lt;&lt;EOF<br>
{<br>
=C2=A0 =C2=A0 &quot;machine&quot;: &quot;Q35&quot;,<br>
=C2=A0 =C2=A0 &quot;memory&quot;: &quot;2GiB&quot;,<br>
=C2=A0 =C2=A0 &quot;accel&quot;: &quot;kvm&quot;<br>
}<br>
EOF<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"aut=
o">And now you have to keep all the syntactic sugar that is in vl.c. I don&=
#39;t think a redesign of -readconfig should accept anything less verbose t=
han</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div dir=3D"auto">- =
machine:</div><div dir=3D"auto">=C2=A0 =C2=A0 type: q35</div><div dir=3D"au=
to">=C2=A0 =C2=A0 ram:</div><div dir=3D"auto">=C2=A0 =C2=A0 =C2=A0 =C2=A0ty=
pe: memory-backend-hostmem</div><div dir=3D"auto">=C2=A0 =C2=A0 =C2=A0 =C2=
=A0size: 2G</div><div dir=3D"auto">- accel:</div><div dir=3D"auto">=C2=A0 -=
 type: kvm</div><div dir=3D"auto"><br></div><div dir=3D"auto">And this is n=
ot even taking into account disks.</div><div dir=3D"auto"><br></div><div di=
r=3D"auto">I like the idea of refactoring all the syntactic sugar into a pr=
e-pass on command line options. This is not an entirely new idea, see=C2=A0=
<a href=3D"https://www.mail-archive.com/qemu-devel@nongnu.org/msg35024.html=
">https://www.mail-archive.com/qemu-devel@nongnu.org/msg35024.html</a>.</di=
v></div><div dir=3D"auto"><br></div><div dir=3D"auto">I am afraid that this=
 thread is derailing a bit, with lots of pipe dreams and no actionable item=
s. How do we get it back in track?</div><div dir=3D"auto"><br></div><div di=
r=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div cl=
ass=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
No file required, cooperates with readline, avoids crunchy,<br>
hard-to-maintain CLI syntax. Directly and easily translatable to a<br>
stored-file configuration. All configuration and documentation is<br>
centralized via QAPI.<br>
<br>
A little worse to type manually, yes. Maybe not bad /enough/ for me to<br>
want to rescue the CLI which prevents full QAPI-fication and a working<br>
configuration file.<br>
<br>
Arguably, a well documented configuration schema will be much easier to<br>
browse, discover, and use than a labyrinthine CLI with many stub<br>
definitions whose options are not exposed in the documentation.<br>
<br>
(The argument here is: It&#39;s a little harder and a little longer to type=
,<br>
but the benefits from the schema organization may improve productivity<br>
of using QEMU directly instead of harming it.)<br>
<br>
--js<br>
<br>
</blockquote></div></div></div>

--0000000000002d018f059d26c613--


