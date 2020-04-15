Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E60C2BB85
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 17:56:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72179208E0
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 17:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ihmmb6nu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72179208E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOmHB-0004oe-J6
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 13:56:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47717)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jOmGT-0004Oa-6Q
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 13:55:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jOmGR-000133-Na
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 13:55:56 -0400
Received: from mail-yw1-xc41.google.com ([2607:f8b0:4864:20::c41]:34176
 helo=mail-oo1-xc41.google.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jOmGR-00012t-I2
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 13:55:55 -0400
Received: by mail-oo1-xc41.google.com with SMTP id q204so66896ooq.1
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 10:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4ZBsCiO5v7mZrs1S97d2XZy2Dto81Hfb2sdUVyI6aSE=;
 b=Ihmmb6nul/Jf+RuwktSNzyktNHRw2Pe3hlqijiomvZpMRq5HF2P+RQLBp1M5b02lOB
 HkbBu5PjrDCgolwBsjWJgmbD4rMsyD8ZoJ8u+eHO4kcHKizMjS4rB77XrIgG9DUG3dHE
 RmI6Ub3iI20iOlxtze6cFiGWUWJCnAobJtstCdI1yS9QDR1ZOkOFG0Vspm5gxvxg5l8J
 llYrLyp7S8QB6/gJmyvFIibEIY5srfX/cY7LraSa5sVC48pgEcqQXdz1A/ipHZgRTxQL
 SZMPJaLvTGk6VcldPgaivteL8hvFWDzgthtycDVfPat98PRD9FLNGGPCnWA/vHmb/a75
 8lLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4ZBsCiO5v7mZrs1S97d2XZy2Dto81Hfb2sdUVyI6aSE=;
 b=RGqnh5msTWp0PPck/RbYAVXcnEyjFarcCw2PugZdNzjI6Sf6YTY6q7QHRSlOVSQynE
 d+Y9r9sILTMacz4AXvf80v7EjY3vpdIhdBNr7epsotP2e2Jt/V2NlZu4wzinbzmL6xO6
 VZ0HBtbTA3hIxnEuJbcXpBN2ZnrN3+d8sRIN1MS0o4ZM90vRfSkQppxHoK1cNvKtbtHU
 8s6Bq8ZPmK3HvRR/AKHPqc2+25v1xk9I/hsDWGryO4TIO9KNUedklBjX/Zv2fEFPc5CO
 jrpQmgXe5Zxe0NirdBdk7jOPAMuF5odfDi1srrleQe/HF1Lzwrdnt9sC46OiPRN+Fr+e
 EY5w==
X-Gm-Message-State: AGi0PuZ5Nlljy3ZZWrwAhsAul7MRnyXi1wj8YZ6YRFP1HuuhoPM83iWx
 FbEEUwrCg3BEFzQ1cWVNB7+HeQWPpFeyWdUW/JjVQkl6JfE=
X-Google-Smtp-Source: APiQypIas+45g0h9D8aWtKZw104bpxvAqW9yYBD38cGjXMGKM0sxM0+TjqUTejwYPAP596WSyccXCTcXcw708kBeQm4=
X-Received: by 2002:a4a:890b:: with SMTP id f11mr23516231ooi.85.1586973354374; 
 Wed, 15 Apr 2020 10:55:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200415173329.4920-1-jsnow@redhat.com>
In-Reply-To: <20200415173329.4920-1-jsnow@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 15 Apr 2020 18:55:43 +0100
Message-ID: <CAFEAcA-ipjVsGuzTWhEq59SvSSSiO+ufcqdcx9JYDOZMLLfPfA@mail.gmail.com>
Subject: Re: [PATCH RFC] configure: prefer sphinx-build to sphinx-build-3
To: John Snow <jsnow@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c41
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
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 15 Apr 2020 at 18:33, John Snow <jsnow@redhat.com> wrote:
>
> sphinx-build is the name of the script entry point from the sphinx
> package itself. sphinx-build-3 is a pacakging convention by Linux
> distributions. Prefer, where possible, the canonical package name.

This was Markus's code originally; cc'ing him.

(Incidentally I think when we say "Linux distributions" we
really mean "Red Hat"; Debian/Ubuntu don't use the "sphinx-build-3" name.)

thanks
-- PMM
(rest of email untrimmed for context)

> In the event that this resolves to a python2 version, test the
> suitability of the binary early in the configuration process, and
> continue looking for sphinx-build-3 if necessary.
>
> This prioritizes a virtual environment version of sphinx above any
> distribution versions, if attempting to build of a virtual python
> environment.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  configure | 50 ++++++++++++++++++++++++++++++++------------------
>  1 file changed, 32 insertions(+), 18 deletions(-)
>
> diff --git a/configure b/configure
> index 233c671aaa..82143e8a41 100755
> --- a/configure
> +++ b/configure
> @@ -928,13 +928,34 @@ do
>      fi
>  done
>
> +# Check we have a new enough version of sphinx-build
> +test_sphinx_build() {
> +    sphinx=$1
> +    # This is a bit awkward but works: create a trivial document and
> +    # try to run it with our configuration file (which enforces a
> +    # version requirement). This will fail if either
> +    # sphinx-build doesn't exist at all or if it is too old.
> +    mkdir -p "$TMPDIR1/sphinx"
> +    touch "$TMPDIR1/sphinx/index.rst"
> +    "$sphinx" -c "$source_path/docs" -b html "$TMPDIR1/sphinx" "$TMPDIR1/sphinx/out" >/dev/null 2>&1
> +}
> +
> +# We require the python3 version of sphinx, but sphinx-build-3 is a
> +# distro package. prefer 'sphinx-build' to find the venv version, if
> +# any, but ensure it is a suitable version.
>  sphinx_build=
> -for binary in sphinx-build-3 sphinx-build
> +sphinx_ok=
> +for binary in sphinx-build sphinx-build-3
>  do
>      if has "$binary"
>      then
> -        sphinx_build=$(command -v "$binary")
> -        break
> +        sphinx_candidate=$(command -v "$binary")
> +        if test_sphinx_build "$sphinx_candidate"
> +        then
> +            sphinx_build=$sphinx_candidate
> +            sphinx_ok=yes
> +            break
> +        fi
>      fi
>  done
>
> @@ -4928,24 +4949,17 @@ if check_include sys/kcov.h ; then
>      kcov=yes
>  fi
>
> -# Check we have a new enough version of sphinx-build
> -has_sphinx_build() {
> -    # This is a bit awkward but works: create a trivial document and
> -    # try to run it with our configuration file (which enforces a
> -    # version requirement). This will fail if either
> -    # sphinx-build doesn't exist at all or if it is too old.
> -    mkdir -p "$TMPDIR1/sphinx"
> -    touch "$TMPDIR1/sphinx/index.rst"
> -    "$sphinx_build" -c "$source_path/docs" -b html "$TMPDIR1/sphinx" "$TMPDIR1/sphinx/out" >/dev/null 2>&1
> -}
> -
>  # Check if tools are available to build documentation.
>  if test "$docs" != "no" ; then
> -  if has_sphinx_build; then
> -    sphinx_ok=yes
> -  else
> -    sphinx_ok=no
> +
> +  if [ "$sphinx_ok" != "yes" ]; then
> +    if test_sphinx_build "$sphinx_build"; then
> +      sphinx_ok=yes
> +    else
> +      sphinx_ok=no
> +    fi
>    fi
> +
>    if has makeinfo && has pod2man && test "$sphinx_ok" = "yes"; then
>      docs=yes
>    else
> --

