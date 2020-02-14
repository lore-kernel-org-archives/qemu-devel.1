Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB13EC3B1AF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 17:37:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C074A20873
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 17:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TfUPd8rp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C074A20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2euN-0007eP-09
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 12:37:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52803)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2eth-0007Fo-BN
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 12:37:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2etf-0002YR-Ro
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 12:37:00 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:36114)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2etf-0002WO-Kg
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 12:36:59 -0500
Received: by mail-ot1-x341.google.com with SMTP id j20so9920451otq.3
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 09:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oDLePT0jVxYsCDb3AIqpXBrfkuIFuI6803FAIljnHkc=;
 b=TfUPd8rp69hRVacKqcLx1gBWUOyVmInOqJezA0tOI7fikSxSfCUSNqkjT7TEgAvm3d
 +92C7OeMtQXL1xxXakhbluct4PC0NrX8f7NgVYg8inegCzP3TFjZ1X2U3Esa5KQcdr8+
 JSR2ofit213J1PYbursGvkyhjoVJs5AEHhD0F4enQrJO7lGwkCSsR3vfb1wTjdB2HN/2
 UTywgAxt6MOXSv/nEZJw14M9uRudClPVKlselhXnL11lf12QDfQTUk7kn5rs2bjzK2Te
 3FwDdNvte6dimrmsuhU08uieFsTFRX6Wfy/ly36oRKCqMnHNCe5wQsgNTXdbB+56Ze9I
 XjCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oDLePT0jVxYsCDb3AIqpXBrfkuIFuI6803FAIljnHkc=;
 b=Fm9BwZR+DotQVH4/PbdyGYfp7H/Xlrl3kJo3PCgu5rHGrh8CaN1nac/hDyZBffbx2a
 isNW/ZoJ3V5q/VL7EXsOfFHNy4qJIXuhaSHdH6bJ7HFEo671BznFH+oksSmKz4g6pow+
 nR6eCmRMJMDeS0NHLiNLP0wuUNJp0Pc/H2a39uAky1twUtOwFsFvVkfLyYETztj0MIlp
 HjB/LneJH9RbECZ+/P1n4MMrFKRHRo98mmj+pyURRcSpSfZEhbBMosDD6Ny+PqBdUm2j
 dZ696TN3ufnicN5mwuMdE7NBTGgHnYF0H0z96nccPLs/bEnqfIW43CrqxyeWe8z4cxEk
 ML4Q==
X-Gm-Message-State: APjAAAWktZKfPyPeOyLZxalgH9DrgaID4I7qA+Zp8iMQdhjS1YoWt07S
 9XxIR/DYgeI+V8mZk2bzM5eNRJBr9mNV1Kh4wfRW/Q==
X-Google-Smtp-Source: APXvYqwA/x8SxkkLtBEfW7c8NdMIeoB1CUOM0jf2JNYh9tdmo4/U4dYL9EFmZYdpr5meCsdcToHBucfvVJ/IxhcMMHM=
X-Received: by 2002:a05:6830:13da:: with SMTP id
 e26mr3025591otq.97.1581701818668; 
 Fri, 14 Feb 2020 09:36:58 -0800 (PST)
MIME-Version: 1.0
References: <20200213175647.17628-1-peter.maydell@linaro.org>
 <20200213175647.17628-2-peter.maydell@linaro.org>
 <87v9o91xvv.fsf@dusky.pond.sub.org>
 <CAFEAcA8ZPrkfzzyxe-im609GQAxEqRz_z3Ar2EFdcFqzyN4p1g@mail.gmail.com>
 <87d0ahxsv1.fsf@dusky.pond.sub.org>
 <CAFEAcA9ZQfeKA7Nb4FSmk8G3JmCFQa4VsMYLQmE2-UBj7YVeuA@mail.gmail.com>
 <87a75lqe8e.fsf@dusky.pond.sub.org>
In-Reply-To: <87a75lqe8e.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Feb 2020 17:36:47 +0000
Message-ID: <CAFEAcA-BXypUoUcYkadJm8O6TbdCjGmprqyGW9KcNZiaR__Xtw@mail.gmail.com>
Subject: Re: [PATCH v2 01/30] configure: Allow user to specify sphinx-build
 binary
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 14 Feb 2020 at 17:18, Markus Armbruster <armbru@redhat.com> wrote:
> I decided I prefer this as a separate patch, between PATCH 01 and 02.
>
> Hmm, maybe I should squash the last hunk into PATCH 01.
>
>
> From 10d174a9f811708807fb60a610e88084f282c222 Mon Sep 17 00:00:00 2001
> From: Markus Armbruster <armbru@redhat.com>
> Date: Fri, 14 Feb 2020 07:33:43 +0100
> Subject: [PATCH] configure: Pick sphinx-build-3 when available
>
> The next commit will require a sphinx-build that uses Python 3.  On
> some systems, sphinx-build is fine, on others you need to use
> sphinx-build-3.  To keep things working out of the box on both kinds
> of systems, try sphinx-build-3, then sphinx-build.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  configure | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/configure b/configure
> index 14172909f0..4cbeb06b86 100755
> --- a/configure
> +++ b/configure
> @@ -584,7 +584,6 @@ query_pkg_config() {
>  }
>  pkg_config=query_pkg_config
>  sdl2_config="${SDL2_CONFIG-${cross_prefix}sdl2-config}"
> -sphinx_build=sphinx-build
>
>  # If the user hasn't specified ARFLAGS, default to 'rv', just as make does.
>  ARFLAGS="${ARFLAGS-rv}"
> @@ -903,6 +902,7 @@ fi
>
>  : ${make=${MAKE-make}}
>  : ${install=${INSTALL-install}}
> +
>  # We prefer python 3.x. A bare 'python' is traditionally
>  # python 2.x, but some distros have it as python 3.x, so
>  # we check that too


Stray whitespace change.

> @@ -915,6 +915,17 @@ do
>          break
>      fi
>  done
> +
> +sphinx_build=
> +for binary in sphinx-build-3 sphinx-build
> +do
> +    if has "$binary"
> +    then
> +        sphinx_build=$(command -v "$binary")
> +        break
> +    fi
> +done
> +
>  : ${smbd=${SMBD-/usr/sbin/smbd}}
>
>  # Default objcc to clang if available, otherwise use CC
> @@ -4803,7 +4814,7 @@ has_sphinx_build() {
>      # sphinx-build doesn't exist at all or if it is too old.
>      mkdir -p "$TMPDIR1/sphinx"
>      touch "$TMPDIR1/sphinx/index.rst"
> -    $sphinx_build -c "$source_path/docs" -b html "$TMPDIR1/sphinx" "$TMPDIR1/sphinx/out" >/dev/null 2>&1
> +    "$sphinx_build" -c "$source_path/docs" -b html "$TMPDIR1/sphinx" "$TMPDIR1/sphinx/out" >/dev/null 2>&1
>  }
>
>  # Check if tools are available to build documentation.
> --
> 2.21.1

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

-- PMM

