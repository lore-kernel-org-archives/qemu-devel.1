Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FAE6C4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 12:11:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE23D2067C
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 12:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F6x9nZOH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE23D2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7I0Q-00049B-6q
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 07:11:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57528)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j7Hzg-0003hN-DJ
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 07:10:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j7Hzd-0001l5-Ih
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 07:10:20 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:46569)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j7Hzd-0001jd-BY
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 07:10:17 -0500
Received: by mail-ot1-x343.google.com with SMTP id g96so2620658otb.13
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 04:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=z+dw6IKG7KfVaE90rJdlxcsfHOOfgBlXU+gkGwJKbpc=;
 b=F6x9nZOHYjp0wIweAFy0/9wTsWl4gfpzdYFP2L0e8/15C+/eiIm9/zxhkSEdnrG1lx
 9SkPn3MBc/1LWVwdEzpoGyozYcQS4tvSQJ8T7nxRqni+DUNjm7v6Ehyii/yRj7bU4Ch9
 WpmDHN2+SOnLJ2KJqL0ZYgSzhdckwx8t+jid1kmn5lAUG/Cx9AiaNinW7EkSmsR3UgZE
 uCfcPL8Ls/Ue2UHIf8S6uZyav1UkTPd4aF1ceKSeW2tbzBbbh+mPjXpyvMy8XyPpZ4i6
 o+n5SR7VsD3G35clz4aO88kj94/UUldE4B3dv5ArnyAII3DZrYlcwM89vF4G1TFXu633
 SDbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=z+dw6IKG7KfVaE90rJdlxcsfHOOfgBlXU+gkGwJKbpc=;
 b=ZThyYcEvfE601a9l3CXYuUF8OXx5mJnmZ3s/yWQfG/pFQJJEHYo8ZNQptBROyjM+Po
 tk46ISH6hJrqKLEbINL/NV3NRT2EuAUQoLDBkDS9eUyjyHvrXaBZBmt/kjhPR2iMEH/A
 rBNNUJbgH71ktLFWk5kvnqeCIs6iQW3SvcKBLcklGWqc93LiRvPu067a+lldr53CVqKG
 Eiv5SkPHYyPw72Qpein4Ro5YgfXi5bnULAt6u8wVtc7Lc06gYgdBgknxCrJwdPugHExD
 1KAKNG513qd61HXXiGLrADHqLNGV1Oft7WhyL04ZOMfsdaLlhLNwaQ6UU9ncsRIIonSn
 vDdQ==
X-Gm-Message-State: APjAAAV3Xzp50byz4j4xaqQPSJvbTxhBynmVTvxvYjkpr53ckTGC4vsy
 0ypZu2DwzgKrgu0etv51yjyPNj7dJjYYM6fkW1130g==
X-Google-Smtp-Source: APXvYqzCBLawxrAS9OB5AqGAjkgc+bR/8ESg9i741OqY+9K6Mp11Tr0/KX5ZDGHVf5iVpkputnI5Tp07iDQOWmpCkFk=
X-Received: by 2002:a9d:68d9:: with SMTP id i25mr3018567oto.135.1582805412763; 
 Thu, 27 Feb 2020 04:10:12 -0800 (PST)
MIME-Version: 1.0
References: <20200226113034.6741-1-pbonzini@redhat.com>
 <20200226113034.6741-15-pbonzini@redhat.com>
In-Reply-To: <20200226113034.6741-15-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Feb 2020 12:10:02 +0000
Message-ID: <CAFEAcA-ps7dmo_7Lgf2kTsy0nvFgU6qopS8HvZMu3DY81VvE_g@mail.gmail.com>
Subject: Re: [PATCH 14/18] docs/system: Convert qemu-cpu-models.texi to rST
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Kashyap Chamarthy <kchamart@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 26 Feb 2020 at 11:30, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> From: Kashyap Chamarthy <kchamart@redhat.com>
>
> This doc was originally written by Daniel P. Berrang=C3=A9
> <berrange@redhat.com>, introduced via commit[1]: 2544e9e4aa (docs: add
> guidance on configuring CPU models for x86, 2018-06-27).
>
> In this patch:
>
>   - 1-1 conversion of Texinfo to rST, besides a couple of minor
>     tweaks that are too trivial to mention.   (Thanks to Stephen
>     Finucane on IRC for the suggestion to use rST "definition lists"
>     instead of bullets in some places.)
>
>     Further modifications will be done via a separate patch.
>
>   - rST and related infra changes: manual page generation, Makefile
>     fixes, clean up references to qemu-cpu-models.texi, update year in
>     the copyright notice, etc.
>
> [1] https://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D2544e9e4aa

> Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
> [Move macros to defs.rst.inc, split in x86 and MIPS parts,
>  make qemu-cpu-models.rst a standalone document. - Paolo]
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  MAINTAINERS                         |   2 +-
>  Makefile                            |   3 +-
>  docs/conf.py                        |   2 +-
>  docs/system/conf.py                 |  10 +-
>  docs/system/cpu-models-mips.rst.inc | 105 ++++++++
>  docs/system/cpu-models-x86.rst.inc  | 365 ++++++++++++++++++++++++++++
>  docs/system/defs.rst.inc            |   2 +
>  docs/system/qemu-block-drivers.rst  |   2 -
>  docs/system/qemu-cpu-models.rst     |  20 ++
>  docs/system/qemu-cpu-models.texi    |  28 ---
>  10 files changed, 504 insertions(+), 35 deletions(-)
>  create mode 100644 docs/system/cpu-models-mips.rst.inc
>  create mode 100644 docs/system/cpu-models-x86.rst.inc
>  create mode 100644 docs/system/defs.rst.inc
>  create mode 100644 docs/system/qemu-cpu-models.rst
>  delete mode 100644 docs/system/qemu-cpu-models.texi

Why don't we also delete cpu-models-x86.texi and
cpu-models-mips.texi ?

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0d3ee8bdc6..01d1ee4b50 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -320,7 +320,7 @@ F: tests/tcg/i386/
>  F: tests/tcg/x86_64/
>  F: hw/i386/
>  F: disas/i386.c
> -F: docs/system/cpu-models-x86.texi
> +F: docs/system/cpu-models-x86.rst

This isn't the filename the patch actually uses.

There should be a corresponding new F: line for the mips version too.

>  T: git https://github.com/ehabkost/qemu.git x86-next
>
>  Xtensa TCG CPUs
> diff --git a/Makefile b/Makefile
> index 6b5193b838..a79f751d5d 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1080,7 +1080,7 @@ $(call define-manpage-rule,interop,\
>         virtiofsd.1 virtfs-proxy-helper.1,\
>         $(SRC_PATH)/qemu-img-cmds.hx)
>
> -$(call define-manpage-rule,system,qemu-block-drivers.7)
> +$(call define-manpage-rule,system,qemu-block-drivers.7 qemu-cpu-models.7=
)
>
>  $(MANUAL_BUILDDIR)/index.html: $(SRC_PATH)/docs/index.html.in qemu-versi=
on.h
>         @mkdir -p "$(MANUAL_BUILDDIR)"
> @@ -1104,7 +1104,6 @@ docs/interop/qemu-ga-qapi.texi: qga/qapi-generated/=
qga-qapi-doc.texi
>
>  qemu.1: qemu-doc.texi qemu-options.texi qemu-monitor.texi qemu-monitor-i=
nfo.texi
>  qemu.1: docs/system/qemu-option-trace.texi
> -docs/system/qemu-cpu-models.7: docs/system/qemu-cpu-models.texi docs/sys=
tem/cpu-models-x86.texi docs/system/cpu-models-mips.texi
>
>  html: qemu-doc.html docs/interop/qemu-qmp-ref.html docs/interop/qemu-ga-=
ref.html sphinxdocs
>  info: qemu-doc.info docs/interop/qemu-qmp-ref.info docs/interop/qemu-ga-=
ref.info

The install line for qemu-cpu-models.7 also needs updating to
include $(MANUAL_BUILDDIR).

The distclean line that removes qemu-cpu-models.7 can be removed.

> diff --git a/docs/conf.py b/docs/conf.py
> index 7588bf192e..1650fc8698 100644
> --- a/docs/conf.py
> +++ b/docs/conf.py
> @@ -80,7 +80,7 @@ master_doc =3D 'index'
>
>  # General information about the project.
>  project =3D u'QEMU'
> -copyright =3D u'2019, The QEMU Project Developers'
> +copyright =3D u'2020, The QEMU Project Developers'
>  author =3D u'The QEMU Project Developers'
>
>  # The version info for the project you're documenting, acts as replaceme=
nt for

We should indeed fix the copyright date, but not in the middle
of this texi->rst series, and we should update the QEMU_COPYRIGHT
macro in qemu-common.h at the same time.

> diff --git a/docs/system/conf.py b/docs/system/conf.py
> index 7ca115f5e0..8d41f4da43 100644
> --- a/docs/system/conf.py
> +++ b/docs/system/conf.py
> @@ -13,10 +13,18 @@ exec(compile(open(parent_config, "rb").read(), parent=
_config, 'exec'))
>  # This slightly misuses the 'description', but is the best way to get
>  # the manual title to appear in the sidebar.
>  html_theme_options['description'] =3D u'System Emulation User''s Guide'
> +
> +rst_prolog =3D '''
> +.. include:: defs.rst.inc
> +'''
> +

Maybe we should do this in docs/conf.py where we update
rst_epilog with the CONFDIR replacement ?

Doing the "put these replacements into a generic defs.rst.inc"
would also be clearer in its own patch, I think.

>  # One entry per manual page. List of tuples
>  # (source start file, name, description, authors, manual section).
>  man_pages =3D [
>      ('qemu-block-drivers', 'qemu-block-drivers',
>       u'QEMU block drivers reference',
> -     ['Fabrice Bellard and the QEMU Project developers'], 7)
> +     ['Fabrice Bellard and the QEMU Project Developers'], 7),

If we want to capitalize the 'D' in Developers, we should
make that fix in its own commit, and we should update
the QEMU_COPYRIGHT macro too, for consistency.

> +    ('qemu-cpu-models', 'qemu-cpu-models',
> +     u'QEMU CPU Models',
> +     ['The QEMU Project Developers'], 7)
>  ]

I would mention explicitly in the commit message that Dan agreed
to the updating of the manpage's Author information to
the more generic string.

thanks
-- PMM

