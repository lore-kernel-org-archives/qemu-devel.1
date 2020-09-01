Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B3DC433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 13:20:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 134AF20767
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 13:20:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWDkBEAY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 134AF20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD6DJ-0003XY-88
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 09:20:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42164)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kD6Cd-00031X-ET
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 09:19:59 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233]:38608)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kD6Cb-0005UC-Bw
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 09:19:59 -0400
Received: by mail-lj1-x233.google.com with SMTP id w3so1482294ljo.5
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 06:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=s18B5dwypIm5SaW4dyeU9nUQPwau4889kVjag61Telk=;
 b=gWDkBEAYEUUGqsGzRaWrCEV4I7h6JQhcURE85QTiD2g2PHPTcvklPT87kZWiY9ia6D
 DeAMguz7dDxd/8lwEFIZFFjhQyQqnSCfG2c2dEERJ36xam0iH/Oy90w1TkLnYsLUX9Kn
 Y4mvV9shDVbJaoXxc5wYYc90Gm4K4Q7AK/PL//fvBReGKwp172Q4As3boOTPTIz64Jx1
 YUqPjI9QQS5fa10nZxwfFglQm6NnXf6VM2FomEqwFCRMboIanblfZESs1z4y21lbvkTU
 1fB5BYwy/mDAU/Dh85P2sUoM64wl0w3oob2pcyW6mh6cfw+iy+SKtZvKfqR/cmz9AivJ
 in8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=s18B5dwypIm5SaW4dyeU9nUQPwau4889kVjag61Telk=;
 b=uLn5ortLc3gJ+d+Jjcd54XcML4S06GxYzF7f/n4koOGPN/bI+P5jQsw+CqsbXQvGCH
 RtD9gCC4+CFYHYs6J0JCtKRqmCFTt/xtN1F6v2rem2LFCEAh9iETPbjFhJ+fls0zS4SF
 4VfGLa7BJqjkVcwfEiY4BsF2eUfFwQborOt9P2Gqc/A1bQajQu42f9r9U3JsXtm9mfG+
 7mos6JbwD8yZ84XldO5KS48F3nAecJx4nUHkABzSiV38/a0jo1ewO7uwhf4gnLJd1iOv
 rOEqafy9eCTEdKPF///AIil53j6sUq9WbM1XjkqESAn2A6KSx3NE2hN0n1TXHtaGGnyD
 hQxQ==
X-Gm-Message-State: AOAM533sWkidyg9Yq+6WUv3p3Az1lcJn7feDOEIHEhGDcj4afoD1fHrA
 DqMC5YFIB7oj/a6bw9HKIhAGoqxr3Q4SHBuXKNLt5+XIZY4J5g==
X-Google-Smtp-Source: ABdhPJwRovQn5LfeKj4oiPcB8IjgYmhocxvbVYC58sL2G/kHpdnyGLNfUBN4UpyGqJjjNxs2+7Hq3lsW0TfDd9NkoM0=
X-Received: by 2002:a2e:2a83:: with SMTP id q125mr624168ljq.242.1598966394922; 
 Tue, 01 Sep 2020 06:19:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200901091132.29601-1-pbonzini@redhat.com>
In-Reply-To: <20200901091132.29601-1-pbonzini@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Tue, 1 Sep 2020 21:19:42 +0800
Message-ID: <CAE2XoE_cO83H7ki8NXY=X+U0aWGbmPRBhyakzMk8dqmTOAmcFQ@mail.gmail.com>
Subject: Re: [PULL 00/24] Meson changes for 2020-09-01
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000fa2be905ae405fe7"
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x233.google.com
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
Cc: qemu-level <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000fa2be905ae405fe7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Seems forgot queue my undefsym.py patch

On Tue, Sep 1, 2020 at 5:12 PM Paolo Bonzini <pbonzini@redhat.com> wrote:

> The following changes since commit
> 2f4c51c0f384d7888a04b4815861e6d5fd244d75:
>
>   Merge remote-tracking branch
> 'remotes/kraxel/tags/usb-20200831-pull-request' into staging (2020-08-31
> 19:39:13 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 703230593ffda7699ae81811967b4d2c76a425c1:
>
>   meson: add description to options (2020-09-01 03:10:36 -0400)
>
> ----------------------------------------------------------------
> meson fixes:
> * bump submodule to 0.55.1
> * SDL, pixman and zlib fixes
> * firmwarepath fix
> * fix firmware builds
>
> meson related:
> * move install to Meson
> * move NSIS to Meson
> * do not make meson use cmake
> * add description to options
>
> ----------------------------------------------------------------
> Marc-Andr=C3=A9 Lureau (14):
>       meson: install pc-bios blobs
>       meson: install scripts/qemu-trace-stap
>       meson: install icons
>       meson: install desktop file
>       meson: install $localstatedir/run for qga
>       build-sys: remove install target from Makefile
>       configure: rename confsuffix option
>       configure: always /-seperate directory from qemu_suffix
>       configure: build docdir like other suffixed directories
>       meson: pass qemu_suffix option
>       meson: use meson datadir instead of qemu_datadir
>       meson: pass docdir option
>       meson: use meson mandir instead of qemu_mandir
>       meson: add NSIS building
>
> Paolo Bonzini (8):
>       meson: bump submodule to 0.55.1
>       block: always link with zlib
>       meson: move zlib detection to meson
>       meson: add pixman dependency to UI modules
>       configure: do not include ${prefix} in firmwarepath
>       meson: use pkg-config method to find dependencies
>       build: fix recurse-all target
>       meson: add description to options
>
> Stefan Weil (1):
>       meson: add pixman dependency to chardev/baum module
>
> Volker R=C3=BCmelin (1):
>       meson: fix SDL2_image detection
>
>  Makefile                           | 122
> +------------------------------------
>  block/meson.build                  |   4 +-
>  chardev/meson.build                |   2 +-
>  configure                          |  65 ++++++--------------
>  contrib/vhost-user-gpu/meson.build |   2 +-
>  docs/devel/build-system.rst        |  27 ++++----
>  docs/meson.build                   |   4 +-
>  meson                              |   2 +-
>  meson.build                        |  53 +++++++++++-----
>  meson_options.txt                  |  33 +++++++---
>  pc-bios/descriptors/meson.build    |   2 +-
>  pc-bios/keymaps/meson.build        |   6 +-
>  pc-bios/meson.build                |  65 +++++++++++++++++++-
>  pc-bios/optionrom/Makefile         |  10 +--
>  pc-bios/s390-ccw/Makefile          |   3 +-
>  qga/meson.build                    |   2 +
>  scripts/meson.build                |   3 +
>  scripts/nsis.py                    |  78 ++++++++++++++++++++++++
>  tools/virtiofsd/meson.build        |   2 +-
>  trace/meson.build                  |   2 +-
>  ui/icons/meson.build               |  13 ++++
>  ui/meson.build                     |   9 ++-
>  22 files changed, 281 insertions(+), 228 deletions(-)
>  create mode 100644 scripts/meson.build
>  create mode 100644 scripts/nsis.py
>  create mode 100644 ui/icons/meson.build
> --
> 2.26.2
>
>
>

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000fa2be905ae405fe7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Seems forgot queue my=C2=A0undefsym.py patch</div><br><div=
 class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 1,=
 2020 at 5:12 PM Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com">p=
bonzini@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">The following changes since commit 2f4c51c0f384d7888a04b4=
815861e6d5fd244d75:<br>
<br>
=C2=A0 Merge remote-tracking branch &#39;remotes/kraxel/tags/usb-20200831-p=
ull-request&#39; into staging (2020-08-31 19:39:13 +0100)<br>
<br>
are available in the Git repository at:<br>
<br>
=C2=A0 <a href=3D"https://gitlab.com/bonzini/qemu.git" rel=3D"noreferrer" t=
arget=3D"_blank">https://gitlab.com/bonzini/qemu.git</a> tags/for-upstream<=
br>
<br>
for you to fetch changes up to 703230593ffda7699ae81811967b4d2c76a425c1:<br=
>
<br>
=C2=A0 meson: add description to options (2020-09-01 03:10:36 -0400)<br>
<br>
----------------------------------------------------------------<br>
meson fixes:<br>
* bump submodule to 0.55.1<br>
* SDL, pixman and zlib fixes<br>
* firmwarepath fix<br>
* fix firmware builds<br>
<br>
meson related:<br>
* move install to Meson<br>
* move NSIS to Meson<br>
* do not make meson use cmake<br>
* add description to options<br>
<br>
----------------------------------------------------------------<br>
Marc-Andr=C3=A9 Lureau (14):<br>
=C2=A0 =C2=A0 =C2=A0 meson: install pc-bios blobs<br>
=C2=A0 =C2=A0 =C2=A0 meson: install scripts/qemu-trace-stap<br>
=C2=A0 =C2=A0 =C2=A0 meson: install icons<br>
=C2=A0 =C2=A0 =C2=A0 meson: install desktop file<br>
=C2=A0 =C2=A0 =C2=A0 meson: install $localstatedir/run for qga<br>
=C2=A0 =C2=A0 =C2=A0 build-sys: remove install target from Makefile<br>
=C2=A0 =C2=A0 =C2=A0 configure: rename confsuffix option<br>
=C2=A0 =C2=A0 =C2=A0 configure: always /-seperate directory from qemu_suffi=
x<br>
=C2=A0 =C2=A0 =C2=A0 configure: build docdir like other suffixed directorie=
s<br>
=C2=A0 =C2=A0 =C2=A0 meson: pass qemu_suffix option<br>
=C2=A0 =C2=A0 =C2=A0 meson: use meson datadir instead of qemu_datadir<br>
=C2=A0 =C2=A0 =C2=A0 meson: pass docdir option<br>
=C2=A0 =C2=A0 =C2=A0 meson: use meson mandir instead of qemu_mandir<br>
=C2=A0 =C2=A0 =C2=A0 meson: add NSIS building<br>
<br>
Paolo Bonzini (8):<br>
=C2=A0 =C2=A0 =C2=A0 meson: bump submodule to 0.55.1<br>
=C2=A0 =C2=A0 =C2=A0 block: always link with zlib<br>
=C2=A0 =C2=A0 =C2=A0 meson: move zlib detection to meson<br>
=C2=A0 =C2=A0 =C2=A0 meson: add pixman dependency to UI modules<br>
=C2=A0 =C2=A0 =C2=A0 configure: do not include ${prefix} in firmwarepath<br=
>
=C2=A0 =C2=A0 =C2=A0 meson: use pkg-config method to find dependencies<br>
=C2=A0 =C2=A0 =C2=A0 build: fix recurse-all target<br>
=C2=A0 =C2=A0 =C2=A0 meson: add description to options<br>
<br>
Stefan Weil (1):<br>
=C2=A0 =C2=A0 =C2=A0 meson: add pixman dependency to chardev/baum module<br=
>
<br>
Volker R=C3=BCmelin (1):<br>
=C2=A0 =C2=A0 =C2=A0 meson: fix SDL2_image detection<br>
<br>
=C2=A0Makefile=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 122 +------------------------------=
------<br>
=C2=A0block/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 =C2=A04 +-<br>
=C2=A0chardev/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A02 +-<br>
=C2=A0configure=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 65 ++++++--------------<br>
=C2=A0contrib/vhost-user-gpu/meson.build |=C2=A0 =C2=A02 +-<br>
=C2=A0docs/devel/build-system.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 27 +++=
+----<br>
=C2=A0docs/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A04 +-<br>
=C2=A0meson=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
=C2=A0meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 53 +++++++++++-----<br>
=C2=A0meson_options.txt=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 33 +++++++---<br>
=C2=A0pc-bios/descriptors/meson.build=C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
=C2=A0pc-bios/keymaps/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0=
6 +-<br>
=C2=A0pc-bios/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 65 +++++++++++++++++++-<br>
=C2=A0pc-bios/optionrom/Makefile=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1=
0 +--<br>
=C2=A0pc-bios/s390-ccw/Makefile=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A03 +-<br>
=C2=A0qga/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +<br>
=C2=A0scripts/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A03 +<br>
=C2=A0scripts/nsis.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 78 ++++++++++++++++++++++++<br>
=C2=A0tools/virtiofsd/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0=
2 +-<br>
=C2=A0trace/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
=C2=A0ui/icons/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 13 ++++<br>
=C2=A0ui/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A09 ++-<br>
=C2=A022 files changed, 281 insertions(+), 228 deletions(-)<br>
=C2=A0create mode 100644 scripts/meson.build<br>
=C2=A0create mode 100644 scripts/nsis.py<br>
=C2=A0create mode 100644 ui/icons/meson.build<br>
-- <br>
2.26.2<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div>

--000000000000fa2be905ae405fe7--

