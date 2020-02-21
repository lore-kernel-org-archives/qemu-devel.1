Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572E9C35656
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 15:18:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2211A206EF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 15:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o2TBR5Ni"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2211A206EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5A3z-0007CL-Bm
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 10:17:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32977)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j5A2o-0006FF-3V
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 10:16:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j5A2k-0001he-9r
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 10:16:45 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:44032)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j5A2k-0001hE-3i
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 10:16:42 -0500
Received: by mail-ot1-x342.google.com with SMTP id h9so2254479otj.11
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 07:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=/nmisr1JrQlfkp7UrLG7y7cEfP6qoNvMsqKLbYiGlNA=;
 b=o2TBR5NiuqNEswkNQKPYEdJxkoNNug+xCPB8bUtXOEqfG9NKKOC2Zi6qEEvhwIapCm
 KctaFMEYfhFEntNA2doi5mG0iNdKVRCfM7zgjb6lMHSMDSfyETBh+Ut0NP9iTZ6Bi5Jg
 Djw0EKoOexDLNI/9NTBI7YZyl7UhptLUrfaPVUsJErk0k4jU+C7WDIi+tXXqBr0E+mxc
 R5jk8zxLYRlzFYrk6RgagQJVRUtXNewE32cuoCOwoAB5KfklSepOQdQvlSEuauq0fBvz
 BKPZN+EfsZ4l6UO48mJru1nY3Qb/yDRjq3Bt/BrVN4a19c7yS8DNUszaYxVRmmC9CboL
 j3BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=/nmisr1JrQlfkp7UrLG7y7cEfP6qoNvMsqKLbYiGlNA=;
 b=qdLjeCpsgMKTgCMJ82noUfscThlhmtakBg2lxhJtl6/USUtfDQiXikmSE2AIa0n7bn
 KzP/dHKGGbP2bD5dNGQGOqHiSPm3E2GeXTLUryPB2dsmyHsJyjyVeD5DTDfnjNBub/7S
 xAMST4ENs0b5MXY8RTSOoG2pQSatgkweVa1t4l0HG5a8dilOd/k5gZgBRDFHRCZTBosC
 JUoaJJjRliPEiXSK/T4y5ec5aTQJXBLlPnlSYFz9PXG9BLUnnQcZasuNWAku5W3Di29t
 YzmXKERl4stl8a183eDD4pR77iiDLq/Gx6p0lz30QVbF+2qMBwFhihbI2qWvrsSC0OFp
 FFEw==
X-Gm-Message-State: APjAAAUpYN2d0MFJLED0YbEF1x+dt+0PgZUgeA1YINflgAmD+SmbxhED
 NNhHd9Ecc+TIQv6y6qBsCzy7uV7wF+BPy7zl7EQ2KA==
X-Google-Smtp-Source: APXvYqw+vQNzTXFS33+6iKMEi9sCN7SJkRC4AbCi3EQdxbUITLW76c2d3NMByz2oQFEVxbt8FRiaLnFiYuE/FxJXBGc=
X-Received: by 2002:a05:6830:184:: with SMTP id
 q4mr28859098ota.232.1582298200452; 
 Fri, 21 Feb 2020 07:16:40 -0800 (PST)
MIME-Version: 1.0
References: <20200220142001.20774-1-kchamart@redhat.com>
 <20200220142001.20774-2-kchamart@redhat.com>
In-Reply-To: <20200220142001.20774-2-kchamart@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Feb 2020 15:16:29 +0000
Message-ID: <CAFEAcA9_tDWLxBrsw42uxs7E_QmA5XzsMs6zwmzpckv=B0ksuw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] docs: Convert qemu-cpu-models.texi to rST
To: Kashyap Chamarthy <kchamart@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 20 Feb 2020 at 14:20, Kashyap Chamarthy <kchamart@redhat.com> wrote=
:
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
>   - rST and related infra changes: for building the manual page,
>     Makefile fixes, clean up references to qemu-cpu-models.texi, etc.
>
> [1] https://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D2544e9e4aa
>
> Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
> ---
> v2: Fix rST conversion, man page creation, Makefile changes, et al
>     (thanks, Peter Maydell)
> ---
>  MAINTAINERS                     |   2 +-
>  Makefile                        |  10 +-
>  docs/qemu-cpu-models.texi       | 677 --------------------------------
>  docs/system/conf.py             |   3 +
>  docs/system/index.rst           |   1 +
>  docs/system/qemu-cpu-models.rst | 514 ++++++++++++++++++++++++
>  qemu-doc.texi                   |   5 -
>  7 files changed, 524 insertions(+), 688 deletions(-)
>  delete mode 100644 docs/qemu-cpu-models.texi
>  create mode 100644 docs/system/qemu-cpu-models.rst

> @@ -1056,6 +1055,8 @@ $(call define-manpage-rule,interop,\
>
>  $(call define-manpage-rule,system,qemu-block-drivers.7)
>
> +$(call define-manpage-rule,system,qemu-cpu-models.7)

The new manpage should be added to the existing define-manpage-rule
invocation for the system manual: the last argument is a space
separated list of all the manpages in the manual, like this:

$(call define-manpage-rule,system,qemu-block-drivers.7 qemu-cpu-models.7)

> +
>  $(MANUAL_BUILDDIR)/index.html: $(SRC_PATH)/docs/index.html.in qemu-versi=
on.h
>         @mkdir -p "$(MANUAL_BUILDDIR)"
>         $(call quiet-command, sed "s|@@VERSION@@|${VERSION}|g" $< >$@, \



> -@c man begin AUTHOR
> -Daniel P. Berrange
> -@c man end

> diff --git a/docs/system/conf.py b/docs/system/conf.py
> index 7ca115f5e0..7cc9da9508 100644
> --- a/docs/system/conf.py
> +++ b/docs/system/conf.py
> @@ -18,5 +18,8 @@ html_theme_options['description'] =3D u'System Emulatio=
n User''s Guide'
>  man_pages =3D [
>      ('qemu-block-drivers', 'qemu-block-drivers',
>       u'QEMU block drivers reference',
> +     ['Fabrice Bellard and the QEMU Project developers'], 7),
> +    ('qemu-cpu-models', 'qemu-cpu-models',
> +     u'QEMU CPU Models',
>       ['Fabrice Bellard and the QEMU Project developers'], 7)
>  ]

The old manpage/documentation credits Dan as the author,
so that's what we should specify in the conf.py line,
rather than 'Fabrice and the project devs' (which we
use for qemu-block-drivers.7 because that's what the
old texi version of that file specified as the authors).


> +Preferred CPU models for Intel x86 hosts
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +The following CPU models are preferred for use on Intel hosts.
> +Administrators / applications are recommended to use the CPU model that
> +matches the generation of the host CPUs in use. In a deployment with a
> +mixture of host CPU models between machines, if live migration
> +compatibility is required, use the newest CPU model that is compatible
> +across all desired hosts.
> +
> +* Intel Xeon Processor (Skylake, 2016)
> +
> +  * ``Skylake-Server``
> +  * ``Skylake-Server-IBRS``

This reverses the old ordering of these lists, which consistently
had the QEMU CPU model names as the 'term' and the explanations
as the 'definition' of a definition-list. Now we have the
'explanation' first and the 'terms' second...

> +* AMD EPYC Processor (2017)
> +
> +  * ``EPYC``
> +  * ``EPYC-IBPB``
> +
> +* ``Opteron_G5`` =E2=80=93 AMD Opteron 63xx class CPU (2012)
> +
> +* ``Opteron_G4`` =E2=80=93 AMD Opteron 62xx class CPU (2011)
> +
> +* ``Opteron_G3`` =E2=80=93 AMD Opteron 23xx (Gen 3 Class Opteron, 2009)
> +
> +* ``Opteron_G2`` =E2=80=93 AMD Opteron 22xx (Gen 2 Class Opteron, 2006)
> +
> +* ``Opteron_G1`` =E2=80=93 AMD Opteron 240 (Gen 1 Class Opteron, 2004)

...but here we become inconsistent, switching back to
term first and explanation second. I think the
term-first approach of the original texi makes more sense,
as we're trying to document the behaviour of the various
CPU models QEMU supports.

rST is not a fan of having multiple definition list items
sharing a definition, which is probably why you ended up with
the list approach you did, but we can do:

``Skylake-Server``, ``Skylake-Server-IBRS``
    Intel Xeon Processor (Skylake, 2016)

``Skylake-Client``, ``Skylake-Client-IBRS``
    Intel Core Processor (Skylake, 2015)

Or we can actually document what the difference is between
a "Skylake-Server" and a "Skylake-Server-IBRS", rather than
leaving the user to guess :-), in which case we could write

``Skylake-Server``
    Intel Xeon Processor (Skylake, 2016)
``Skylake-Server-IBRS``
    Like ``Skylake-Server`` but with extra magic

(or whatever the difference is...)

Regardless of how we format this, we should be consistent
in using the same format throughout the document.

thanks
-- PMM

