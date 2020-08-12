Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33860C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 13:08:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3AC320639
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 13:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a6XaPZdo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3AC320639
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5qUz-00023Y-81
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 09:08:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41514)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k5qUQ-0001eJ-6A
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 09:08:22 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:38594)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k5qUO-0000Rr-A7
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 09:08:21 -0400
Received: by mail-lf1-x144.google.com with SMTP id 140so1113732lfi.5
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 06:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3iXgRenxH1jC0Ju5u7Vyprzx2RcEuRJoswA2JzgMvt0=;
 b=a6XaPZdoKha6tPivVVzri4pULevwMMzv8lrCCcYyAZMl2iAk2NgpzhB9Fb8IFynuYT
 ANfGECnG4/SMNNG5X8ijn6ADgXnVhZS/BJM+FabYTJSbxlo+3fRtjG/NjXOf8VtvmQhA
 uwx14+zvLktGyRY/ZNLdl0lmIW7CFQ65aWDqLKTncWz7rjP6ZO8B82Uw63u3XRynggMP
 RpDtrJoRjkSduidkUJu7IW1TFx97QlIBj8mgED8utJzK22GmDGX7AIlNe4Y2eA7+5XFZ
 dqgYkly6Ka1Q/aEA92HFMf0d5g0yeX8Lxm8Uw/G8n6jZTQGMFa3UYHo/pTb6KwA9YXoT
 CLFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3iXgRenxH1jC0Ju5u7Vyprzx2RcEuRJoswA2JzgMvt0=;
 b=j6W0XyRz4bccOVvFGRh65gu0aGSGrK1w1Y5d9plpSJkTLlL5TWC+QMlKhJqUIFrg0r
 1a9Ugc7w86dV46rYUSq+03rXv+llF+dXJ6iypD2zNp311hXt0Ryq/aikvaJ7wGYr4hZq
 p6NVDLozaqXas/KT8WYdO2F+8Fqd0OsiVGGd/6Vv9GNMOi7/G000GAShgfXRUQCDvUah
 //sjS+U6TOi56ArHAHI+c/SCd6HZbduvEd+lbPlvm5CYTQ9nzj9/Xm55TQ8wYkvFhxwq
 TLzcvcJECZMjdYox/QaiT1QpS1WSTB/4HHO8S99H862lx00Nnth8qq+rA2UUDn0Wn35U
 dApA==
X-Gm-Message-State: AOAM532+AFe7vt3Fp+6dzJdZzYVXFMHaYoeOq+7kl+WSscWHo4tk1oIF
 eOsvkUlf01TQqcUl5N164yCXVe2zgBq5nihdnPfxIw==
X-Google-Smtp-Source: ABdhPJz+e1xdWn14KgdmKGIhWGyNB014we9njYZuFux9OAoYpTghrBNxlxoTpeUQmxkGBtkmon2123fDWdE4BLZT810=
X-Received: by 2002:a05:6512:3156:: with SMTP id
 s22mr5718003lfi.140.1597237697787; 
 Wed, 12 Aug 2020 06:08:17 -0700 (PDT)
MIME-Version: 1.0
References: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
 <1597079345-42801-8-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1597079345-42801-8-git-send-email-pbonzini@redhat.com>
From: Robert Foley <robert.foley@linaro.org>
Date: Wed, 12 Aug 2020 09:08:41 -0400
Message-ID: <CAEyhzFu1JfGZiT-W7JBsFVXyo-qN+R7ASTdfHGfcaafj_R4iMw@mail.gmail.com>
Subject: Re: [PATCH 007/147] tests/vm: do not pollute configure with
 --efi-aarch64
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::144;
 envelope-from=robert.foley@linaro.org; helo=mail-lf1-x144.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Robert Foley <robert.foley@linaro.org>

On Mon, 10 Aug 2020 at 13:12, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Just make EFI_AARCH64 a variable in the makefile that defaults to the efi
> firmware included with QEMU.  It can be redefined on the "make" command
> line.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  configure                 | 19 -------------------
>  tests/vm/Makefile.include |  2 ++
>  2 files changed, 2 insertions(+), 19 deletions(-)
>
> diff --git a/configure b/configure
> index 2acc4d1..1c17a0f 100755
> --- a/configure
> +++ b/configure
> @@ -418,7 +418,6 @@ prefix="/usr/local"
>  mandir="\${prefix}/share/man"
>  datadir="\${prefix}/share"
>  firmwarepath="\${prefix}/share/qemu-firmware"
> -efi_aarch64=""
>  qemu_docdir="\${prefix}/share/doc/qemu"
>  bindir="\${prefix}/bin"
>  libdir="\${prefix}/lib"
> @@ -1109,8 +1108,6 @@ for opt do
>    ;;
>    --firmwarepath=*) firmwarepath="$optarg"
>    ;;
> -  --efi-aarch64=*) efi_aarch64="$optarg"
> -  ;;
>    --host=*|--build=*|\
>    --disable-dependency-tracking|\
>    --sbindir=*|--sharedstatedir=*|\
> @@ -3650,20 +3647,6 @@ EOF
>    fi
>  fi
>
> -############################################
> -# efi-aarch64 probe
> -# Check for efi files needed by aarch64 VMs.
> -# By default we will use the efi included with QEMU.
> -# Allow user to override the path for efi also.
> -if ! test -f "$efi_aarch64"; then
> -  if test -f $source_path/pc-bios/edk2-aarch64-code.fd.bz2; then
> -    # valid after build
> -    efi_aarch64=$PWD/pc-bios/edk2-aarch64-code.fd
> -  else
> -    efi_aarch64=""
> -  fi
> -fi
> -
>  ##########################################
>  # libcap-ng library probe
>  if test "$cap_ng" != "no" ; then
> @@ -6861,7 +6844,6 @@ if test "$docs" != "no"; then
>      echo "sphinx-build      $sphinx_build"
>  fi
>  echo "genisoimage       $genisoimage"
> -echo "efi_aarch64       $efi_aarch64"
>  echo "python_yaml       $python_yaml"
>  echo "slirp support     $slirp $(echo_version $slirp $slirp_version)"
>  if test "$slirp" != "no" ; then
> @@ -7963,7 +7945,6 @@ echo "PYTHON=$python" >> $config_host_mak
>  echo "SPHINX_BUILD=$sphinx_build" >> $config_host_mak
>  echo "SPHINX_WERROR=$sphinx_werror" >> $config_host_mak
>  echo "GENISOIMAGE=$genisoimage" >> $config_host_mak
> -echo "EFI_AARCH64=$efi_aarch64" >> $config_host_mak
>  echo "PYTHON_YAML=$python_yaml" >> $config_host_mak
>  echo "CC=$cc" >> $config_host_mak
>  if $iasl -h > /dev/null 2>&1; then
> diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
> index f21948c..a599d19 100644
> --- a/tests/vm/Makefile.include
> +++ b/tests/vm/Makefile.include
> @@ -2,6 +2,8 @@
>
>  .PHONY: vm-build-all vm-clean-all
>
> +EFI_AARCH64 = $(wildcard $(BUILD_DIR)/pc-bios/edk2-aarch64-code.fd)
> +
>  IMAGES := freebsd netbsd openbsd centos fedora
>  ifneq ($(GENISOIMAGE),)
>  IMAGES += ubuntu.i386 centos
> --
> 1.8.3.1
>
>
>

