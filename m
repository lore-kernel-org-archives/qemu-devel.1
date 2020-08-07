Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F98C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 10:37:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 485892075D
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 10:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aKFjzqZr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 485892075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3zl5-0007o3-Fy
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 06:37:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45458)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k3zkR-0007Oi-G2
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 06:37:15 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36450)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k3zkP-0002NT-DN
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 06:37:15 -0400
Received: by mail-wr1-x443.google.com with SMTP id 88so1227388wrh.3
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 03:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=IUxEQfxCXOkmuJ1NLHaHhktf48z6FOG6Yj3xDhLJMm4=;
 b=aKFjzqZr5Jxv3HO183IIBr5HkD3fa8vm6sLXb+3VeIISV0NqE9NNGhXiFJMR6iHSl6
 +Fh8gM/UcDYmEGSfjSej/BzfS9oQ34sGfrjm+USYD5PaDw0ESptR4PdsFf/e06f+w74S
 h3YRVxBFmr0BTkvd6B9+998tt4RFbEY7lgOvUj6F9ZYsgCfgA0h2x41k56/oVRQ5NOUs
 tbrLmCqHNEIc+F8oj7+3zBytzRtJq/0GoNJCyQMZpujcZ+tNBJ0cPUIAbdZl4S1n0ck4
 LtgpJJByDi7+vOiNoOg+K6OpiFmfMf96kGpskGtJb1rWQL3tx23yezBp/k+enUEAa9yS
 u2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=IUxEQfxCXOkmuJ1NLHaHhktf48z6FOG6Yj3xDhLJMm4=;
 b=P668hu6aj5DkzbOqXmz2YkDgU59h6BfU2LfOb5ei9OV57o+2wKAxPPg7MmxnpQiuju
 TzbRgXFo3FqXFmsOEh95K152+lRxamHQVf9Po4vajAe+nxcY6+WsEym9ZLLKKUzQlRmd
 cmKJ9CQtA7UcUVPdMp3rfA4MkEWdnSLssiK346BB1k489Titwh/jjFez3I9kWvSlFpeE
 uUkQ9tZf5B2/Hl1cdA3akCNrh10RftnL9LRGbcMP+ysbd8ZmKCj76XCaoa20JlcOPekq
 AyZMhlJ7buFeC0CP46QcStqvakRIKx0KwWSDEfAdGZEhSVH3cmCqQocK4xkRT8Gr+alS
 xKMw==
X-Gm-Message-State: AOAM5312pO+KolmiAMUS2yzNxUax9sTBBjG9N/XHACtVPFNFLF8+mPsL
 0LuTOo7yL5UFqarOmuM0Xu4JOdUUVBA=
X-Google-Smtp-Source: ABdhPJxDP13p+ldO0jNK46SNEEWy5Zgq5Ypv63wMu4raOaqmPzwCNhfnhKKUlQ9xBrwOMxmoAJC/tQ==
X-Received: by 2002:adf:e8cc:: with SMTP id k12mr11898724wrn.2.1596796630598; 
 Fri, 07 Aug 2020 03:37:10 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b123sm9985584wme.20.2020.08.07.03.37.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2020 03:37:09 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DCCAA1FF7E;
 Fri,  7 Aug 2020 11:37:08 +0100 (BST)
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
 <1596741379-12902-16-git-send-email-pbonzini@redhat.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 015/143] build-sys: add meson submodule
In-reply-to: <1596741379-12902-16-git-send-email-pbonzini@redhat.com>
Date: Fri, 07 Aug 2020 11:37:08 +0100
Message-ID: <87v9hukai3.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Paolo Bonzini <pbonzini@redhat.com> writes:

> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  .gitmodules               |  3 +++
>  configure                 | 44 +++++++++++++++++++++++++++++++++++++++++=
---
>  meson                     |  1 +
>  scripts/archive-source.sh |  3 ++-
>  4 files changed, 47 insertions(+), 4 deletions(-)
>  create mode 160000 meson
>
> diff --git a/.gitmodules b/.gitmodules
> index 9c0501a..ce97939 100644
> --- a/.gitmodules
> +++ b/.gitmodules
> @@ -58,3 +58,6 @@
>  [submodule "roms/qboot"]
>  	path =3D roms/qboot
>  	url =3D https://github.com/bonzini/qboot
> +[submodule "meson"]
> +	path =3D meson
> +	url =3D https://github.com/mesonbuild/meson/
> diff --git a/configure b/configure
> index 13db149..d87d544 100755
> --- a/configure
> +++ b/configure
> @@ -174,6 +174,25 @@ path_of() {
>      return 1
>  }
>=20=20
> +version_ge () {
> +    local_ver1=3D`echo $1 | tr . ' '`
> +    local_ver2=3D`echo $2 | tr . ' '`
> +    while true; do
> +        set x $local_ver1
> +        local_first=3D${2-0}
> +        # shift 2 does nothing if there are less than 2 arguments
> +        shift; shift
> +        local_ver1=3D$*
> +        set x $local_ver2
> +        # the second argument finished, the first must be greater or equ=
al
> +        test $# =3D 1 && return 0
> +        test $local_first -lt $2 && return 1
> +        test $local_first -gt $2 && return 0
> +        shift; shift
> +        local_ver2=3D$*
> +    done
> +}
> +
>  have_backend () {
>      echo "$trace_backends" | grep "$1" >/dev/null
>  }
> @@ -1965,9 +1984,28 @@ then
>      error_exit "Python not found. Use --python=3D/path/to/python"
>  fi
>=20=20
> -if ! has "$meson"
> -then
> -    error_exit "Meson not found. Use --meson=3D/path/to/meson"
> +if test -z "$meson" ; then
> +    if has meson && version_ge "$(meson --version)" 0.55.0; then
> +        meson=3Dmeson
> +    elif test -e "${source_path}/.git" && test $git_update =3D 'yes' ; t=
hen
> +        meson=3Dgit
> +    elif test -e "${source_path}/meson/meson.py" ; then
> +        meson=3Dinternal
> +    fi
> +fi
> +
> +case "$meson" in
> +    git | internal)

Is "internal" meant to be synonymous with "git"? AFAICT we don't
actually do anything with --meson=3Dinternal which is why it failed later.

> +        if test "$meson" =3D git; then
> +            git_submodules=3D"${git_submodules} meson"
> +            (cd "${source_path}" && GIT=3D"$git" "./scripts/git-submodul=
e.sh" update meson)
> +        fi
> +        meson=3D"${source_path}/meson/meson.py"
> +        ;;
> +esac
> +
> +if ! has "$meson" ; then
> +    error_exit "Meson not found. Use --meson=3D/path/to/meson|git|intern=
al"
>  fi
<snip>

--=20
Alex Benn=C3=A9e

