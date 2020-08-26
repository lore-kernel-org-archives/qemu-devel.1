Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 184E1C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 11:51:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4A7620707
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 11:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blF4Hdkb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4A7620707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAtxs-000149-4d
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 07:51:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58512)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kAtwj-0008Ks-C8
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 07:50:29 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:35395)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kAtwh-0000hN-Ha
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 07:50:29 -0400
Received: by mail-ej1-x642.google.com with SMTP id a26so2437545ejc.2
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 04:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=06Bzp5UfP9dL8ui686QQpD6Rqmt6+eKufYjI9m9cNHM=;
 b=blF4Hdkbs1ziW883YwjQNxy7KJ7cpk0UIqVTF9ssDzTOnTJubfrDFPOikBFcr0sRVb
 /1e7JoLZDUbOlcXQpj/WAuNK+Y9A5vWc6dMG9VAD3/dnrlYxDh0GJOudMiVg/uoZ7Fit
 KcXtcGDk5qTLoIlPUr5xUV84MjezoDDwfpC1GFbcpf1vQcVM2Chld5Nqtnd118JvQBXl
 X2boR1tXI99Fc3zH710AOWY8zUdyGB5NF76bAdk8FLV9iOxBgZCc6ekme8ZqW/JMcZsI
 KFKxEUAgo88bzHDdCULrutBrlqBAjkEWh2IfRAI+OIP72VnqlQaT57ThiaLvLwwCoXbh
 A/Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=06Bzp5UfP9dL8ui686QQpD6Rqmt6+eKufYjI9m9cNHM=;
 b=fBn5UJXEHACgn+nTrrroh9kFmQdjf8jtTKJSZY1hLK0CQbMVtfN+EUmvUslxFUwIxc
 uzahbKdRKyxswl7OfiiX+K0yuS7Qlz2hl1eE1ydC2ocg15nfMBqT/lhXVZmkYC53QJw8
 fqN+q2E1ME5nDbM7C6VXRUWxbyKjdM7q+9/8oxBihguPIcdBCQ8/yu1TaY4lgNaFRfmz
 QVDcA4ZhWr25q8xMrUCh3yVdpE5W8WwZWiIaL1z979Ftuub5aitQHb+vtAySx2uXnMCR
 l4v4pEcFjaf6uAM3FmWzBS2purxaFpDh14mfjcgTKWwymSxBNJs4wFDxv4Kibo3qbt1V
 pUwg==
X-Gm-Message-State: AOAM530a6TJvOGPl2p7kKEbjWlELwtMefhDANRyQrn7O5FbORRYWUtcy
 +BM8n3UX9nsYA09i0Pp0pGi5K4A659M0TccBDHo=
X-Google-Smtp-Source: ABdhPJxbSw3Jr9k39qzw04qV2/WRQ9/UWo/MTKreevw2jSao+G+FqQ9bapEh5D1Yj9PQ1LHSFxkNDnohpx7ZDirShuM=
X-Received: by 2002:a17:906:3945:: with SMTP id
 g5mr10437343eje.109.1598442625486; 
 Wed, 26 Aug 2020 04:50:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200826110419.528931-1-marcandre.lureau@redhat.com>
 <CABgObfa1Xa_2EBNHo9=XOYEWFUBqUhKmu6kDfsiE1+hMTwdDvA@mail.gmail.com>
In-Reply-To: <CABgObfa1Xa_2EBNHo9=XOYEWFUBqUhKmu6kDfsiE1+hMTwdDvA@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 26 Aug 2020 15:50:13 +0400
Message-ID: <CAJ+F1CLqew5KdKGN1zjoBUEtm9q79dWw-9QmhyBu1mYD0qeMWA@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] meson: mingw installation fixes & nsis conversion
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000e2d2d205adc66cc7"
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ej1-x642.google.com
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
Cc: sw <sw@weilnetz.de>, "Daniel P. Berrange" <berrange@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000e2d2d205adc66cc7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Wed, Aug 26, 2020 at 3:38 PM Paolo Bonzini <pbonzini@redhat.com> wrote:

> Since behavioral changes should be reviewed separately let's just include
> v2 first.
>
>
 I am more confident that this version doesn't introduce regressions
though.. The use of + qemu_confsuffix was problematic, and I noticed some
weird behaviour that I couldn't clearly identify (when updating meson &
running make only - iow, fresh configure && make should be ok, but for the
rest it's not as "clean" as this version..).

Paolo
>
> Il mer 26 ago 2020, 13:04 <marcandre.lureau@redhat.com> ha scritto:
>
>> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>
>> Hi,
>>
>> The following patches fix installation path when cross-compiling Windows
>> version, and move the NSIS build rule to meson.
>>
>> v3:
>>  - change qemu suffix handling, make /-separator implicit
>>  - use qemu suffix to build qemu_docdir, as --help says
>>  - use / to construct qemu directory variables in meson
>>  - add a few signed-off from Daniel
>>
>> v2:
>>  - replaced the shell script by a python version
>>  - add copyright/license for the new python script
>>
>> Marc-Andr=C3=A9 Lureau (8):
>>   configure: rename confsuffix option
>>   configure: always /-seperate directory from qemu_suffix
>>   configure: build docdir like other suffixed directories
>>   meson: pass qemu_suffix option
>>   meson: use meson datadir instead of qemu_datadir
>>   meson: pass docdir option
>>   meson: use meson mandir instead of qemu_mandir
>>   meson: add NSIS building
>>
>>  Makefile                           | 56 ---------------------
>>  configure                          | 27 ++++++-----
>>  contrib/vhost-user-gpu/meson.build |  2 +-
>>  docs/meson.build                   |  4 +-
>>  meson.build                        | 34 +++++++++++--
>>  meson_options.txt                  |  4 ++
>>  pc-bios/descriptors/meson.build    |  2 +-
>>  pc-bios/keymaps/meson.build        |  6 +--
>>  pc-bios/meson.build                |  2 +-
>>  scripts/nsis.py                    | 78 ++++++++++++++++++++++++++++++
>>  tools/virtiofsd/meson.build        |  2 +-
>>  trace/meson.build                  |  2 +-
>>  12 files changed, 138 insertions(+), 81 deletions(-)
>>  create mode 100644 scripts/nsis.py
>>
>> --
>> 2.26.2
>>
>>
>>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000e2d2d205adc66cc7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi<br></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Wed, Aug 26, 2020 at 3:38 PM Paolo Bonzini=
 &lt;<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>&gt; wro=
te:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"=
auto">Since behavioral changes should be reviewed separately let&#39;s just=
 include v2 first.<div dir=3D"auto"><br></div></div></blockquote><div><br><=
/div><div>=C2=A0I am more confident that this version doesn&#39;t introduce=
 regressions though.. The use of + qemu_confsuffix was problematic, and I n=
oticed some weird behaviour that I couldn&#39;t clearly identify (when upda=
ting meson &amp; running make only - iow, fresh configure &amp;&amp; make s=
hould be ok, but for the rest it&#39;s not as &quot;clean&quot; as this ver=
sion..).<br></div><div><br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex"><div dir=3D"auto"><div dir=3D"auto"></div><div dir=3D"auto">Paolo</=
div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_at=
tr">Il mer 26 ago 2020, 13:04  &lt;<a href=3D"mailto:marcandre.lureau@redha=
t.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt; ha scritto:<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex">From: Marc-Andr=C3=
=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.com" rel=3D"norefe=
rrer" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
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
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--000000000000e2d2d205adc66cc7--

