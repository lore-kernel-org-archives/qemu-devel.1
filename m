Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F29C433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 17:15:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 611BE206B5
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 17:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vNR9b+mK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 611BE206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8oAA-0000RV-GG
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 13:15:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40138)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k8o9G-00084q-EE
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 13:14:46 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:35855)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k8o9E-0008Mc-FH
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 13:14:46 -0400
Received: by mail-ej1-x644.google.com with SMTP id kq25so3421339ejb.3
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2020 10:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=lnsSYPpXo7juauup6RBY2/9/nUmeITesGQ9vUoRs7Uc=;
 b=vNR9b+mKMAm5eedrdI22EjPVEir/+p3PbEgQuIjAYXlyjnsvjGFqolHi+Yrg5xj5c4
 cZGmzx1SWjKa3HAKduzBCEVJd58Tb/2W06gpg2O606VDn5Nkl7rnkJifeNC88ruwoKxg
 bFeVzEgsuQM5iMMlFF+So/xefj9d2blc9bTRsJBv9uAAWra4FOroaf44VOItFJof1Qqr
 Uew8gSTtyICh0y6F6riELaai4kJc6Dqbx2PNOmbKywJodv9Rp8DLwGcysEriTsJPiDIk
 tX7elsSeSy2YZDSj+YaRd0oMoE+8gD+oOCEZkZ2i3Zxd/ql2SmkDX9fWU/SzARVOdtlw
 XzxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=lnsSYPpXo7juauup6RBY2/9/nUmeITesGQ9vUoRs7Uc=;
 b=RLFEhLVQ4fDqyGupmDNUrZ5X4HTwlkWn6Ilx5gZ7i0JqDDz7VibjCDD1OEyIXAVc1W
 tzpo5frmTlyWO474gvcz6Wythh0NhYO8iyxKgHwIRsbcAPBTjH2a+4TTOFTYhWoXE549
 c+/DTmaQnlEFNQFFLxdjCTPI+y9wSAAUFMkBDPBwuFrhuHncNAKkuZ1IlmPZS2IBfJiy
 tfx9qYzdz0AjTVB8VEaKB1Nvji6DoPJfhZ+5+BRyf7+sAaUf6sh12/G5OTlKkez8Zmok
 aTAmWejYz93s2xw567/eU2qkENCU2DxVeZa9C6XHp5KFPOLGBxx2kYDe7LpR9JBy6NlH
 EwYQ==
X-Gm-Message-State: AOAM5313xkKt62yPiSLqkOOqpBlkdYwRmDr1a2rCZi6IX0AKXkzaRFaC
 beCd4LxgA9r0d2ufnW7KyQQgvhdlt/aVkvYEimn25w==
X-Google-Smtp-Source: ABdhPJzNzeVz0ILpkNS+l73QL77bd0vzBsjh1f+lEkfmAxyGbGevW7tOde/YEtABvhdZmaPMOvWrWhB4RpPIIqXBK74=
X-Received: by 2002:a17:906:b814:: with SMTP id
 dv20mr3645995ejb.4.1597943682866; 
 Thu, 20 Aug 2020 10:14:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200820165543.215372-1-berrange@redhat.com>
In-Reply-To: <20200820165543.215372-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Aug 2020 18:14:31 +0100
Message-ID: <CAFEAcA9z6ac2VuogGkQxKtFko=AYFtFd460iRoX9ZnvNB3o-iA@mail.gmail.com>
Subject: Re: [PATCH] configure: add support for psuedo-"in source tree" builds
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 20 Aug 2020 at 17:56, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> Meson requires the build dir to be separate from the source tree. Many
> people are used to just running "./configure && make" though and the
> meson conversion breaks that.
>
> This introduces some backcompat support to make it appear as if an
> "in source tree" build is being done, but with the the results in the
> "build/" directory. This allows "./configure && make" to work as it
> did historically, albeit with the output binaries staying under build/.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>
> This is a simple integration of Eric's proposal from
>
>   https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg07290.html
>
> with a bit of configure magic. It is enough to enable
>
>    ./configure
>    make
>    make check
>
> I've not tested it beyond that. Note it blows away the "build/"
> dir each time ./configure is run so it is pristine each time.
>
> We could optionally symlink binaries from build/ into $PWD
> if poeople think that is important, eg by changing GNUmakefile
> to have:
>
> recurse: all
>         for bin in `find build -maxdepth 1 -type f -executable | grep -v =
-E '(ninjatool|config.status)'`; \
>         do \
>           ln -f -s $$bin . ; \
>         done
>
> and some cleanup logic to purge the symlinks for "make clean"
>
> This goes on top of Paolo's most recent meson port v175 posting,
> or whatever number it is upto now :-)
>
>  .gitignore |  2 ++
>  configure  | 40 ++++++++++++++++++++++++++++++++--------
>  2 files changed, 34 insertions(+), 8 deletions(-)
>
> diff --git a/.gitignore b/.gitignore
> index 92311284ef..4ccb9ed975 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -1,3 +1,5 @@
> +/GNUmakefile
> +/build/
>  /.doctrees
>  /config-devices.*
>  /config-all-devices.*
> diff --git a/configure b/configure
> index cc5f58f31a..a5c88ad1ac 100755
> --- a/configure
> +++ b/configure
> @@ -11,6 +11,38 @@ unset CLICOLOR_FORCE GREP_OPTIONS
>  # Don't allow CCACHE, if present, to use cached results of compile tests=
!
>  export CCACHE_RECACHE=3Dyes
>
> +source_path=3D$(cd "$(dirname -- "$0")"; pwd)
> +
> +if printf %s\\n "$source_path" "$PWD" | grep -q "[[:space:]:]";
> +then
> +  error_exit "main directory cannot contain spaces nor colons"
> +fi
> +
> +if test "$PWD" =3D=3D "$source_path"
> +then
> +    echo "Using './build' as the directory for build output"
> +    rm -rf build
> +    mkdir -p build
> +    cat > GNUmakefile <<EOF
> +

Since this created file ends up in the source directory it would
be useful to have it start with a brief comment saying
(a) that it's autogenerated by configure (b) what it's for.

thanks
-- PMM

