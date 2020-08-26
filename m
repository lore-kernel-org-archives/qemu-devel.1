Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E758C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 11:38:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EECA92083B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 11:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SGSEoSty"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EECA92083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAtlE-0001or-AN
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 07:38:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54114)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kAtkM-0000k2-Kf
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 07:37:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52108
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kAtkK-000796-PN
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 07:37:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598441859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C7/snZh4ahmdZ3YwhtJy1h9hF34X/rl5C2+fHUXg7AU=;
 b=SGSEoStygCY8tX3CHXytf77Qjyj6amfY+2jPBawsQco9SYvs75Apa95boKvCUmubfO3Nb9
 VVxuqUWP4sTMmj3RVSgOdZdRA78hT7lp10kAoTrO2R3YcPIZGXZWbcBBijZHnYSk2xDiPp
 S/KIFBD9SNPnKDoLZm+L3tyrYn3kfzw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-568-Ygg2SC8qOe-eAlAOIs6R5w-1; Wed, 26 Aug 2020 07:37:34 -0400
X-MC-Unique: Ygg2SC8qOe-eAlAOIs6R5w-1
Received: by mail-ed1-f72.google.com with SMTP id w26so579280edq.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 04:37:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=C7/snZh4ahmdZ3YwhtJy1h9hF34X/rl5C2+fHUXg7AU=;
 b=CNsF3irKefwvEvtNWgHoEddvp6DXLDQNKIOFq0O1wHizuao/unn4tjK/1d0V7ZWVM4
 dLMEhfMSAWA4WdBUZ35y1NSD7xH3yA6kApqunnFZcAaDyId2YfWLzZSaOIYCMOSz1DJV
 BWDH/XLueaXn/+D/MHbtxu29pm2MyDcR0kXT5MMqDWASy+0zOwXugMlaHwSC2pBupmeo
 R4LZ7cReU4kPaqhBBkP5MOg2rh6q2G0UJWQszUfcy3OxKc9wyGtXoMc8aK4N9L6brQuU
 gt/GyqIyGhZ3PByswiVdVQ6N1GUBxBM4uG6/oBCwRZSNOfA+GHZj7HDphNljcwmwoQL2
 EvlA==
X-Gm-Message-State: AOAM530K58rl/pU8yPoDub5P2eUm4+6X+ocGl0tUmZBrQDexxEd1j7mR
 xH9sMGY+sXZR7CXcpHJvU28L2SnMmS6qDHgcmzwM9KkrP1ciAcK0ma7IIswoz8mTir8wK91V2Nj
 zSJTXbzHc7pT3F1EW/pzf2Tr6+dVQ3GM=
X-Received: by 2002:a17:906:130a:: with SMTP id
 w10mr555557ejb.106.1598441853730; 
 Wed, 26 Aug 2020 04:37:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyYeTCf+IPfD0BVkSN3GsPoxMw5JBUm0iMjLhyxlQ8QoPPfSmPReojmXEmOHql8+CWH0xtuXnJd4JuTj1Kqsig=
X-Received: by 2002:a17:906:130a:: with SMTP id
 w10mr555540ejb.106.1598441853551; 
 Wed, 26 Aug 2020 04:37:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200826110419.528931-1-marcandre.lureau@redhat.com>
In-Reply-To: <20200826110419.528931-1-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 26 Aug 2020 13:37:21 +0200
Message-ID: <CABgObfa1Xa_2EBNHo9=XOYEWFUBqUhKmu6kDfsiE1+hMTwdDvA@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] meson: mingw installation fixes & nsis conversion
To: Marc-Andre Lureau <marcandre.lureau@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000e01da705adc63e6e"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 01:10:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: sw <sw@weilnetz.de>, berrange@redhat.com,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000e01da705adc63e6e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Since behavioral changes should be reviewed separately let's just include
v2 first.

Paolo

Il mer 26 ago 2020, 13:04 <marcandre.lureau@redhat.com> ha scritto:

> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Hi,
>
> The following patches fix installation path when cross-compiling Windows
> version, and move the NSIS build rule to meson.
>
> v3:
>  - change qemu suffix handling, make /-separator implicit
>  - use qemu suffix to build qemu_docdir, as --help says
>  - use / to construct qemu directory variables in meson
>  - add a few signed-off from Daniel
>
> v2:
>  - replaced the shell script by a python version
>  - add copyright/license for the new python script
>
> Marc-Andr=C3=A9 Lureau (8):
>   configure: rename confsuffix option
>   configure: always /-seperate directory from qemu_suffix
>   configure: build docdir like other suffixed directories
>   meson: pass qemu_suffix option
>   meson: use meson datadir instead of qemu_datadir
>   meson: pass docdir option
>   meson: use meson mandir instead of qemu_mandir
>   meson: add NSIS building
>
>  Makefile                           | 56 ---------------------
>  configure                          | 27 ++++++-----
>  contrib/vhost-user-gpu/meson.build |  2 +-
>  docs/meson.build                   |  4 +-
>  meson.build                        | 34 +++++++++++--
>  meson_options.txt                  |  4 ++
>  pc-bios/descriptors/meson.build    |  2 +-
>  pc-bios/keymaps/meson.build        |  6 +--
>  pc-bios/meson.build                |  2 +-
>  scripts/nsis.py                    | 78 ++++++++++++++++++++++++++++++
>  tools/virtiofsd/meson.build        |  2 +-
>  trace/meson.build                  |  2 +-
>  12 files changed, 138 insertions(+), 81 deletions(-)
>  create mode 100644 scripts/nsis.py
>
> --
> 2.26.2
>
>
>

--000000000000e01da705adc63e6e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Since behavioral changes should be reviewed separately le=
t&#39;s just include v2 first.<div dir=3D"auto"><br></div><div dir=3D"auto"=
>Paolo</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"=
gmail_attr">Il mer 26 ago 2020, 13:04  &lt;<a href=3D"mailto:marcandre.lure=
au@redhat.com">marcandre.lureau@redhat.com</a>&gt; ha scritto:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #=
ccc solid;padding-left:1ex">From: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mai=
lto:marcandre.lureau@redhat.com" target=3D"_blank" rel=3D"noreferrer">marca=
ndre.lureau@redhat.com</a>&gt;<br>
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

--000000000000e01da705adc63e6e--


