Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DACC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 13:47:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 955C6221E2
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 13:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MAhWC5ZE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 955C6221E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAvmM-0006XY-QS
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 09:47:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60628)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kAvlb-0005ym-NO
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 09:47:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25542)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kAvlY-0007uG-TS
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 09:47:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598449622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fRtfT/CxhIkeKUTJw7U8zEzLLiyGGwYrQ3oZvZkrwjE=;
 b=MAhWC5ZEwpehU/8BZIi7lk7WI0pn/3XETh00eugyaCeHe4uzTMRX54lZYPNWC+ImPgDGg3
 mjOsJgs+lH5XbZJUu6fbISiJdffEWnWaYxm1XhvFHll+0wMsUJztJtFr4g7G81n3+GSUVc
 Bu3DZ3aBQ759akJ2auWHGXKq8uabvCw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-2Lyc1FPlNfO8oml6nUwKXw-1; Wed, 26 Aug 2020 09:46:57 -0400
X-MC-Unique: 2Lyc1FPlNfO8oml6nUwKXw-1
Received: by mail-ed1-f71.google.com with SMTP id u11so686575eds.23
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 06:46:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fRtfT/CxhIkeKUTJw7U8zEzLLiyGGwYrQ3oZvZkrwjE=;
 b=iUmcfaTjp0kDBhXP6NfrLT+YuUOLOrIKgHde0lMPjZqnV9fVSLdyX1UOMPP0aTGphC
 xKs1FcMm24vQERb9tCbn4RpthcYcVuFsTaE5aqaHqdKO0RI2K1AOpe4MIkAHr46oMMTo
 XRqHYk0KkExnXMEGGwWrunYfW2zB+Ov+GQXg27ryfKfXUCCAKf/dPzqNCOshCSH0RIzt
 mlP4t7p3wZcZvCavxZDuZ1ytjjVwsC5ryr3BdXkCgZeMaY1AgLV0I+DgALPx3ebfKTR8
 HF5zb2M10gN53AJ/XUy9s2CGwH/cXbKZsO3QTWX7MKeW99KV+04t+PJoH/BC8/z+ka5w
 Bfog==
X-Gm-Message-State: AOAM530qXWdO9bviO34drlFZRiqbEGkopf3aGhUqzR9s/p/2ky9ze71i
 5JImdDTHFQkkQ2auz5IDXouXF29549kuY+q2CbYrf09+1Y118HAFhyDa4rrVQhcZ6lo9qj1v651
 tC4hntWou/AS6SVInUxV7Vg7ldFFj3Ks=
X-Received: by 2002:a50:fb94:: with SMTP id e20mr15296944edq.103.1598449615890; 
 Wed, 26 Aug 2020 06:46:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXsc7fh+MjozBXKnAHE6h+qrNmvZO1XW/kM9qZm7XIRcKUWN9YtLR7yiW2bUnieHd7dAn5zHMdufqVT1JYOE4=
X-Received: by 2002:a50:fb94:: with SMTP id e20mr15296931edq.103.1598449615677; 
 Wed, 26 Aug 2020 06:46:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200826110419.528931-1-marcandre.lureau@redhat.com>
 <CABgObfa1Xa_2EBNHo9=XOYEWFUBqUhKmu6kDfsiE1+hMTwdDvA@mail.gmail.com>
 <CAJ+F1CLqew5KdKGN1zjoBUEtm9q79dWw-9QmhyBu1mYD0qeMWA@mail.gmail.com>
In-Reply-To: <CAJ+F1CLqew5KdKGN1zjoBUEtm9q79dWw-9QmhyBu1mYD0qeMWA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 26 Aug 2020 15:46:43 +0200
Message-ID: <CABgObfZZPixkG55c-eUUEzVKczK+nzxGOyO7HPLnXSRwggekBg@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] meson: mingw installation fixes & nsis conversion
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="00000000000088ccae05adc80d95"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 06:53:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: sw <sw@weilnetz.de>, "Daniel P. Berrange" <berrange@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000088ccae05adc80d95
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

We should document the difference in the 5.2 changelog then (it's okay to
introduce it since the configure option is named differently).

Il mer 26 ago 2020, 13:50 Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.co=
m> ha
scritto:

> Hi
>
> On Wed, Aug 26, 2020 at 3:38 PM Paolo Bonzini <pbonzini@redhat.com> wrote=
:
>
>> Since behavioral changes should be reviewed separately let's just includ=
e
>> v2 first.
>>
>>
>  I am more confident that this version doesn't introduce regressions
> though.. The use of + qemu_confsuffix was problematic, and I noticed some
> weird behaviour that I couldn't clearly identify (when updating meson &
> running make only - iow, fresh configure && make should be ok, but for th=
e
> rest it's not as "clean" as this version..).
>
> Paolo
>>
>> Il mer 26 ago 2020, 13:04 <marcandre.lureau@redhat.com> ha scritto:
>>
>>> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>>
>>> Hi,
>>>
>>> The following patches fix installation path when cross-compiling Window=
s
>>> version, and move the NSIS build rule to meson.
>>>
>>> v3:
>>>  - change qemu suffix handling, make /-separator implicit
>>>  - use qemu suffix to build qemu_docdir, as --help says
>>>  - use / to construct qemu directory variables in meson
>>>  - add a few signed-off from Daniel
>>>
>>> v2:
>>>  - replaced the shell script by a python version
>>>  - add copyright/license for the new python script
>>>
>>> Marc-Andr=C3=A9 Lureau (8):
>>>   configure: rename confsuffix option
>>>   configure: always /-seperate directory from qemu_suffix
>>>   configure: build docdir like other suffixed directories
>>>   meson: pass qemu_suffix option
>>>   meson: use meson datadir instead of qemu_datadir
>>>   meson: pass docdir option
>>>   meson: use meson mandir instead of qemu_mandir
>>>   meson: add NSIS building
>>>
>>>  Makefile                           | 56 ---------------------
>>>  configure                          | 27 ++++++-----
>>>  contrib/vhost-user-gpu/meson.build |  2 +-
>>>  docs/meson.build                   |  4 +-
>>>  meson.build                        | 34 +++++++++++--
>>>  meson_options.txt                  |  4 ++
>>>  pc-bios/descriptors/meson.build    |  2 +-
>>>  pc-bios/keymaps/meson.build        |  6 +--
>>>  pc-bios/meson.build                |  2 +-
>>>  scripts/nsis.py                    | 78 ++++++++++++++++++++++++++++++
>>>  tools/virtiofsd/meson.build        |  2 +-
>>>  trace/meson.build                  |  2 +-
>>>  12 files changed, 138 insertions(+), 81 deletions(-)
>>>  create mode 100644 scripts/nsis.py
>>>
>>> --
>>> 2.26.2
>>>
>>>
>>>
>
> --
> Marc-Andr=C3=A9 Lureau
>

--00000000000088ccae05adc80d95
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">We should document the difference in the 5.2 changelog th=
en (it&#39;s okay to introduce it since the configure option is named diffe=
rently).</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmai=
l_attr">Il mer 26 ago 2020, 13:50 Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mai=
lto:marcandre.lureau@gmail.com">marcandre.lureau@gmail.com</a>&gt; ha scrit=
to:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div>Hi<br></d=
iv><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On =
Wed, Aug 26, 2020 at 3:38 PM Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@r=
edhat.com" target=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=
=3D"auto">Since behavioral changes should be reviewed separately let&#39;s =
just include v2 first.<div dir=3D"auto"><br></div></div></blockquote><div><=
br></div><div>=C2=A0I am more confident that this version doesn&#39;t intro=
duce regressions though.. The use of + qemu_confsuffix was problematic, and=
 I noticed some weird behaviour that I couldn&#39;t clearly identify (when =
updating meson &amp; running make only - iow, fresh configure &amp;&amp; ma=
ke should be ok, but for the rest it&#39;s not as &quot;clean&quot; as this=
 version..).<br></div><div><br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex"><div dir=3D"auto"><div dir=3D"auto"></div><div dir=3D"auto">Pao=
lo</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmai=
l_attr">Il mer 26 ago 2020, 13:04  &lt;<a href=3D"mailto:marcandre.lureau@r=
edhat.com" target=3D"_blank" rel=3D"noreferrer">marcandre.lureau@redhat.com=
</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">From: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@re=
dhat.com" rel=3D"noreferrer noreferrer" target=3D"_blank">marcandre.lureau@=
redhat.com</a>&gt;<br>
<br>
Hi,<br>
<br>
The following patches fix installation path when cross-compiling Windows<br=
>
version, and move the NSIS build rule to meson.<br>
<br>
v3:<br>
=C2=A0- change qemu suffix handling, make /-separator implicit<br>
=C2=A0- use qemu suffix to build qemu_docdir, as --help says<br>
=C2=A0- use / to construct qemu directory variables in meson<br>
=C2=A0- add a few signed-off from Daniel<br>
<br>
v2:<br>
=C2=A0- replaced the shell script by a python version<br>
=C2=A0- add copyright/license for the new python script<br>
<br>
Marc-Andr=C3=A9 Lureau (8):<br>
=C2=A0 configure: rename confsuffix option<br>
=C2=A0 configure: always /-seperate directory from qemu_suffix<br>
=C2=A0 configure: build docdir like other suffixed directories<br>
=C2=A0 meson: pass qemu_suffix option<br>
=C2=A0 meson: use meson datadir instead of qemu_datadir<br>
=C2=A0 meson: pass docdir option<br>
=C2=A0 meson: use meson mandir instead of qemu_mandir<br>
=C2=A0 meson: add NSIS building<br>
<br>
=C2=A0Makefile=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 56 ---------------------<br>
=C2=A0configure=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 27 ++++++-----<br>
=C2=A0contrib/vhost-user-gpu/meson.build |=C2=A0 2 +-<br>
=C2=A0docs/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 4 +-<br>
=C2=A0meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 34 +++++++++++--<br>
=C2=A0meson_options.txt=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 4 ++<br>
=C2=A0pc-bios/descriptors/meson.build=C2=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A0pc-bios/keymaps/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 6 +--<=
br>
=C2=A0pc-bios/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 2 +-<br>
=C2=A0scripts/nsis.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | 78 ++++++++++++++++++++++++++++++<br>
=C2=A0tools/virtiofsd/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-<b=
r>
=C2=A0trace/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A012 files changed, 138 insertions(+), 81 deletions(-)<br>
=C2=A0create mode 100644 scripts/nsis.py<br>
<br>
-- <br>
2.26.2<br>
<br>
<br>
</blockquote></div>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr">Marc-Andr=
=C3=A9 Lureau<br></div></div>
</blockquote></div>

--00000000000088ccae05adc80d95--


