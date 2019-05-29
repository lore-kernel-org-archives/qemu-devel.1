Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2DFC28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 11:55:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 921B720644
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 11:55:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 921B720644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52419 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVxBB-0002jQ-RB
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 07:55:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hVx9e-0001jr-BL
	for qemu-devel@nongnu.org; Wed, 29 May 2019 07:54:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hVx9d-0004sg-7t
	for qemu-devel@nongnu.org; Wed, 29 May 2019 07:54:02 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51830)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hVx9d-0004sJ-2l
	for qemu-devel@nongnu.org; Wed, 29 May 2019 07:54:01 -0400
Received: by mail-wm1-f68.google.com with SMTP id f10so1482031wmb.1
	for <qemu-devel@nongnu.org>; Wed, 29 May 2019 04:54:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=3Zx0KpH4xIgjdbwZ2C1DZ6N+jS5tVwtrAgTbOBlbFM4=;
	b=OF6TYultMHtJSP9nDEl8xE330ua/xlWpb7x/LCBZsgowSnjITl+EMQf7kamPWKsVsW
	oJSm7z7mxZ1BY184F2Q8YjbfY2/o7/AM7qCj/PFpoltVchaDy4+3dCJ8Sxb+wZ74EmjF
	Dnhd/9ShRZNNL5gxul4E+n8bo5DLmMWs4apLM2jGyfHw8y548HLdyeGdCSjf1sYf09pN
	OMTJO23/MwXJwiqMIuavN0g1SzhhErb+zAiIQW/AEwr7UoaUW7rfRrlAjDCYng8RrjzX
	dh7GdN8xe36Vc06B/fDqQPzOls9KRqal3oZOBv6MTNfsdZfwmnmF3S6UiG+KdCrVZ6ay
	FKBw==
X-Gm-Message-State: APjAAAVIpkqPqwGaIl/93t8c3xzCXaS8DVYH/QIWuA7PWeN3+2Wvvws/
	dNviwpYIvZwhd/OcTJTvwJUDUA==
X-Google-Smtp-Source: APXvYqzBOVA/xItaeyrBIF3EnM5Is8CBVX12mj1Lyw5g++cWCD6Pd3K+gLWVUNR8aTyuFUW76OK2aQ==
X-Received: by 2002:a05:600c:218d:: with SMTP id
	e13mr6674132wme.101.1559130839912; 
	Wed, 29 May 2019 04:53:59 -0700 (PDT)
Received: from [10.32.224.40] (red-hat-inc.vlan560.asr1.mad1.gblx.net.
	[159.63.51.90]) by smtp.gmail.com with ESMTPSA id
	b10sm33697604wrh.59.2019.05.29.04.53.58
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Wed, 29 May 2019 04:53:59 -0700 (PDT)
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20190520124716.30472-1-kraxel@redhat.com>
	<20190520124716.30472-2-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <1b1d3794-874c-91e6-1040-f6dd2a1c1343@redhat.com>
Date: Wed, 29 May 2019 13:53:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190520124716.30472-2-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH v3 01/14] scripts: use git archive in
 archive-source
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>, Ed Maste <emaste@freebsd.org>,
	Kamil Rytarowski <kamil@netbsd.org>,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	Li-Wen Hsu <lwhsu@freebsd.org>, Brad Smith <brad@comstyle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/20/19 2:47 PM, Gerd Hoffmann wrote:
> Use git archive to create tarballs of qemu and submodules instead of
> cloning the repository and the submodules.  This is a order of magnitude
> faster because it doesn't fetch the submodules from the internet each
> time the script runs.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Tested-by: Thomas Huth <thuth@redhat.com>
> ---
>  scripts/archive-source.sh | 72 +++++++++++++++++----------------------
>  1 file changed, 31 insertions(+), 41 deletions(-)
> 
> diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
> index 8b8994826000..93a48d2063f9 100755
> --- a/scripts/archive-source.sh
> +++ b/scripts/archive-source.sh
> @@ -19,16 +19,25 @@ if test $# -lt 1; then
>  fi
>  
>  tar_file=$(realpath "$1")
> -list_file="${tar_file}.list"
> -vroot_dir="${tar_file}.vroot"
> +sub_tdir=$(mktemp -d "${tar_file%.tar}.sub.XXXXXXXX")
> +sub_file="${sub_tdir}/submodule.tar"
>  
>  # We want a predictable list of submodules for builds, that is
>  # independent of what the developer currently has initialized
>  # in their checkout, because the build environment is completely
>  # different to the host OS.
>  submodules="dtc slirp ui/keycodemapdb tests/fp/berkeley-softfloat-3 tests/fp/berkeley-testfloat-3"
> +sub_deinit=""
>  
> -trap "status=$?; rm -rf \"$list_file\" \"$vroot_dir\"; exit \$status" 0 1 2 3 15
> +function cleanup() {
> +    local status=$?
> +    rm -rf "$sub_tdir"
> +    if test "$sub_deinit" != ""; then
> +	git submodule deinit $sub_deinit
> +    fi
> +    exit $status
> +}
> +trap "cleanup" 0 1 2 3 15
>  
>  if git diff-index --quiet HEAD -- &>/dev/null
>  then
> @@ -36,45 +45,26 @@ then
>  else
>      HEAD=$(git stash create)
>  fi
> -git clone --shared . "$vroot_dir"
> -test $? -ne 0 && error "failed to clone into '$vroot_dir'"
> -for sm in $submodules; do
> -    if test -d "$sm/.git"
> -    then
> -       git clone --shared "$sm" "$vroot_dir/$sm"
> -       test $? -ne 0 && error "failed to clone submodule $sm"
> -    fi
> -done
> -
> -cd "$vroot_dir"
> -test $? -ne 0 && error "failed to change into '$vroot_dir'"
> -
> -git checkout $HEAD
> -test $? -ne 0 && error "failed to checkout $HEAD revision"
>  
> +git archive --format tar $HEAD > "$tar_file"
> +test $? -ne 0 && error "failed to archive qemu"
>  for sm in $submodules; do
> -    git submodule update --init $sm
> -    test $? -ne 0 && error "failed to init submodule $sm"
> +    status="$(git submodule status "$sm")"
> +    smhash="${status#[ +-]}"
> +    smhash="${smhash%% *}"
> +    case "$status" in
> +	-*)
> +	    sub_deinit="$sub_deinit $sm"
> +	    git submodule update --init "$sm"
> +	    test $? -ne 0 && error "failed to update submodule $sm"
> +	    ;;
> +	+*)
> +	    echo "WARNING: submodule $sm is out of sync"
> +	    ;;
> +    esac
> +    (cd $sm; git archive --format tar --prefix "$sm/" $smhash) > "$sub_file"
> +    test $? -ne 0 && error "failed to archive submodule $sm ($smhash)"
> +    tar --concatenate --file "$tar_file" "$sub_file"
> +    test $? -ne 0 && error "failed append submodule $sm to $tar_file"
>  done
> -
> -if test -n "$submodules"; then
> -    {
> -        git ls-files || error "git ls-files failed"
> -        for sm in $submodules; do
> -            (cd $sm; git ls-files) | sed "s:^:$sm/:"
> -            if test "${PIPESTATUS[*]}" != "0 0"; then
> -                error "git ls-files in submodule $sm failed"
> -            fi
> -        done
> -    } | grep -x -v $(for sm in $submodules; do echo "-e $sm"; done) > "$list_file"
> -else
> -    git ls-files > "$list_file"
> -fi
> -
> -if test $? -ne 0; then
> -    error "failed to generate list file"
> -fi
> -
> -tar -cf "$tar_file" -T "$list_file" || error "failed to create tar file"
> -
>  exit 0
> 

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

