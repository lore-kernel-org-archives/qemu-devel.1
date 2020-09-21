Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E20AC4363C
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 19:19:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76C71216C4
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 19:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oCQJssgX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76C71216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKRL1-0008Qe-9Q
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 15:18:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40866)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kKRJW-0007Sh-T4
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 15:17:26 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46652)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kKRJT-00048v-7g
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 15:17:26 -0400
Received: by mail-wr1-x441.google.com with SMTP id o5so13959211wrn.13
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 12:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=sbt0h/Z1IH91C3rLTmmfGTC+Q5Z0mUT3R8gUlNUxIYo=;
 b=oCQJssgXvMb5FUtQQSg4STHSdAcbt9g9ToORENhXbNyvS/D2N5T9Xd6IWLsn5Jtm8Z
 onvKx2Q1SYcR9jOHmETw/Sx1KtQK/QGPErN8AFiTEkrm52xgUHdNOWRbOQU4VUS1U9Ym
 rnZ4SQXzc5omG0VOf1PMb2wTVhcRTW0siz+Yyn89t4Tu3h4Q6RaETsmXaiahoKaE592e
 AX5qMEMSKR84KQram0JXa7BGucYqhFQiqYZsua/8G/WZj0FzjrXBFBPqdHRiA+/cYNj9
 bNiYwAN93wP6CxCYBhjaUNDFZGIN/fajJ3yI4W5JN5swtg4l/+GD8eikbjOyMfJ4ZyAO
 FpiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=sbt0h/Z1IH91C3rLTmmfGTC+Q5Z0mUT3R8gUlNUxIYo=;
 b=F22JC3kkwgCzVSKAM2l/H7qByalhvCoJk1DHSGoMeLz5LxA+wEuNbxAG1AvjnHhQGt
 FaFcjVwn/6Xt0gPKjM95j+zbeHQjjxzo2rX8vLTiFY28bmXLK4Th822jTbt3J/75NkTH
 sXUX9kvQAliDb5jdBpjnXfi3orNM7Ykc5i22cTU62o9eBvnBobaMighUeOXuRsdbz8Pc
 0Mdz+reFzZR92mK825WKVVueaI5kVs4cDQ7TBbZpUXGDxf/CMkyssAh5wtqFQQ61aKd3
 jICkaCJNfLkhluXU+oxV09hIQFcQLWcbos+WPm3ZiR2c+BwRxRC17acKR59pdKjEDmoI
 73ag==
X-Gm-Message-State: AOAM530se6CmiMRqUO+1dgKbNhKxM654eowqs3LVUo3yhh8jUnbBFGo9
 9dNu1cKf71YxG3ef71xqHz+a4A==
X-Google-Smtp-Source: ABdhPJwbbSi94LB9Zji2kTK47OVVZxhHcg3MHJsCGpAbipwihwE3c8mUwsgh9D+eReZQ9JCFxWaLdw==
X-Received: by 2002:a05:6000:1c4:: with SMTP id
 t4mr1333684wrx.350.1600715841277; 
 Mon, 21 Sep 2020 12:17:21 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z9sm781742wmg.46.2020.09.21.12.17.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2020 12:17:19 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 539FF1FF7E;
 Mon, 21 Sep 2020 20:17:19 +0100 (BST)
References: <20200921174118.39352-1-richard.henderson@linaro.org>
 <20200921174118.39352-2-richard.henderson@linaro.org>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v4 01/11] capstone: Convert Makefile bits to meson bits
In-reply-to: <20200921174118.39352-2-richard.henderson@linaro.org>
Date: Mon, 21 Sep 2020 20:17:19 +0100
Message-ID: <87lfh3ndmo.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> There are better ways to do this, e.g. meson cmake subproject,
> but that requires cmake 3.7 and some of our CI environments
> only provide cmake 3.5.
>
> Nor can we add a meson.build file to capstone/, because the git
> submodule would then always report "untracked files".  Fixing that
> would require creating our own branch on the qemu git mirror, at
> which point we could just as easily create a native meson subproject.
>
> Instead, build the library via the main meson.build.
>
> This improves the current state of affairs in that we will re-link
> the qemu executables against a changed libcapstone.a, which we wouldn't
> do before-hand.  In addition, the use of the configuration header file
> instead of command-line -DEFINES means that we will rebuild the
> capstone objects with changes to meson.build.
>
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  configure         |  64 +++-----------------------
>  Makefile          |  16 -------
>  meson.build       | 111 +++++++++++++++++++++++++++++++++++++++++++---
>  meson_options.txt |   4 ++
>  4 files changed, 115 insertions(+), 80 deletions(-)
>
> diff --git a/configure b/configure
> index 7564479008..03915267e2 100755
> --- a/configure
> +++ b/configure
> @@ -478,7 +478,7 @@ opengl=3D""
>  opengl_dmabuf=3D"no"
>  cpuid_h=3D"no"
>  avx2_opt=3D""
> -capstone=3D""
> +capstone=3D"auto"
>  lzo=3D""
>  snappy=3D""
>  bzip2=3D""
> @@ -1580,7 +1580,7 @@ for opt do
>    ;;
>    --enable-capstone) capstone=3D"yes"
>    ;;
> -  --enable-capstone=3Dgit) capstone=3D"git"
> +  --enable-capstone=3Dgit) capstone=3D"internal"
>    ;;
>    --enable-capstone=3Dsystem) capstone=3D"system"
>    ;;
> @@ -5128,51 +5128,11 @@ fi
>  # capstone
>=20=20
>  case "$capstone" in
> -  "" | yes)
> -    if $pkg_config capstone; then
> -      capstone=3Dsystem
> -    elif test -e "${source_path}/.git" && test $git_update =3D 'yes' ; t=
hen
> -      capstone=3Dgit
> -    elif test -e "${source_path}/capstone/Makefile" ; then
> -      capstone=3Dinternal
> -    elif test -z "$capstone" ; then
> -      capstone=3Dno
> -    else
> -      feature_not_found "capstone" "Install capstone devel or git submod=
ule"
> -    fi
> -    ;;
> -
> -  system)
> -    if ! $pkg_config capstone; then
> -      feature_not_found "capstone" "Install capstone devel"
> -    fi
> -    ;;
> -esac
> -
> -case "$capstone" in
> -  git | internal)
> -    if test "$capstone" =3D git; then
> +  auto | yes | internal)
> +    # Simpler to always update submodule, even if not needed.
> +    if test -e "${source_path}/.git" && test $git_update =3D 'yes' ; then
>        git_submodules=3D"${git_submodules} capstone"
>      fi
> -    mkdir -p capstone
> -    if test "$mingw32" =3D "yes"; then
> -      LIBCAPSTONE=3Dcapstone.lib
> -    else
> -      LIBCAPSTONE=3Dlibcapstone.a
> -    fi
> -    capstone_libs=3D"-Lcapstone -lcapstone"
> -    capstone_cflags=3D"-I${source_path}/capstone/include"
> -    ;;
> -
> -  system)
> -    capstone_libs=3D"$($pkg_config --libs capstone)"
> -    capstone_cflags=3D"$($pkg_config --cflags capstone)"
> -    ;;
> -
> -  no)
> -    ;;
> -  *)
> -    error_exit "Unknown state for capstone: $capstone"
>      ;;
>  esac
>=20=20
> @@ -7292,11 +7252,6 @@ fi
>  if test "$ivshmem" =3D "yes" ; then
>    echo "CONFIG_IVSHMEM=3Dy" >> $config_host_mak
>  fi
> -if test "$capstone" !=3D "no" ; then
> -  echo "CONFIG_CAPSTONE=3Dy" >> $config_host_mak
> -  echo "CAPSTONE_CFLAGS=3D$capstone_cflags" >> $config_host_mak
> -  echo "CAPSTONE_LIBS=3D$capstone_libs" >> $config_host_mak
> -fi
>  if test "$debug_mutex" =3D "yes" ; then
>    echo "CONFIG_DEBUG_MUTEX=3Dy" >> $config_host_mak
>  fi
> @@ -7819,13 +7774,7 @@ done # for target in $targets
>  if [ "$fdt" =3D "git" ]; then
>    subdirs=3D"$subdirs dtc"
>  fi
> -if [ "$capstone" =3D "git" -o "$capstone" =3D "internal" ]; then
> -  subdirs=3D"$subdirs capstone"
> -fi
>  echo "SUBDIRS=3D$subdirs" >> $config_host_mak
> -if test -n "$LIBCAPSTONE"; then
> -  echo "LIBCAPSTONE=3D$LIBCAPSTONE" >> $config_host_mak
> -fi
>=20=20
>  if test "$numa" =3D "yes"; then
>    echo "CONFIG_NUMA=3Dy" >> $config_host_mak
> @@ -8008,7 +7957,8 @@ NINJA=3D${ninja:-$PWD/ninjatool} $meson setup \
>          -Db_coverage=3D$(if test "$gcov" =3D yes; then echo true; else e=
cho false; fi) \
>  	-Dsdl=3D$sdl -Dsdl_image=3D$sdl_image \
>  	-Dvnc=3D$vnc -Dvnc_sasl=3D$vnc_sasl -Dvnc_jpeg=3D$vnc_jpeg -Dvnc_png=3D=
$vnc_png \
> -	-Dgettext=3D$gettext -Dxkbcommon=3D$xkbcommon -Du2f=3D$u2f\
> +	-Dgettext=3D$gettext -Dxkbcommon=3D$xkbcommon -Du2f=3D$u2f \
> +	-Dcapstone=3D$capstone \
>          $cross_arg \
>          "$PWD" "$source_path"
>=20=20
> diff --git a/Makefile b/Makefile
> index 7c60b9dcb8..f3da1760ad 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -156,22 +156,6 @@ dtc/all: .git-submodule-status dtc/libfdt
>  dtc/%: .git-submodule-status
>  	@mkdir -p $@
>=20=20
> -# Overriding CFLAGS causes us to lose defines added in the sub-makefile.
> -# Not overriding CFLAGS leads to mis-matches between compilation modes.
> -# Therefore we replicate some of the logic in the sub-makefile.
> -# Remove all the extra -Warning flags that QEMU uses that Capstone doesn=
't;
> -# no need to annoy QEMU developers with such things.
> -CAP_CFLAGS =3D $(patsubst -W%,,$(CFLAGS) $(QEMU_CFLAGS)) $(CAPSTONE_CFLA=
GS)
> -CAP_CFLAGS +=3D -DCAPSTONE_USE_SYS_DYN_MEM
> -CAP_CFLAGS +=3D -DCAPSTONE_HAS_ARM
> -CAP_CFLAGS +=3D -DCAPSTONE_HAS_ARM64
> -CAP_CFLAGS +=3D -DCAPSTONE_HAS_POWERPC
> -CAP_CFLAGS +=3D -DCAPSTONE_HAS_X86
> -
> -.PHONY: capstone/all
> -capstone/all: .git-submodule-status
> -	$(call quiet-command,$(MAKE) -C $(SRC_PATH)/capstone CAPSTONE_SHARED=3D=
no BUILDDIR=3D"$(BUILD_DIR)/capstone" CC=3D"$(CC)" AR=3D"$(AR)" LD=3D"$(LD)=
" RANLIB=3D"$(RANLIB)" CFLAGS=3D"$(CAP_CFLAGS)" $(SUBDIR_MAKEFLAGS) $(BUILD=
_DIR)/capstone/$(LIBCAPSTONE))
> -
>  .PHONY: slirp/all
>  slirp/all: .git-submodule-status
>  	$(call quiet-command,$(MAKE) -C $(SRC_PATH)/slirp		\
> diff --git a/meson.build b/meson.build
> index f4d1ab1096..f23273693d 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -10,6 +10,7 @@ else
>    keyval =3D import('unstable-keyval')
>  endif
>  ss =3D import('sourceset')
> +fs =3D import('fs')
>=20=20
>  sh =3D find_program('sh')
>  cc =3D meson.get_compiler('c')
> @@ -409,11 +410,6 @@ if 'CONFIG_USB_LIBUSB' in config_host
>    libusb =3D declare_dependency(compile_args: config_host['LIBUSB_CFLAGS=
'].split(),
>                                link_args: config_host['LIBUSB_LIBS'].spli=
t())
>  endif
> -capstone =3D not_found
> -if 'CONFIG_CAPSTONE' in config_host
> -  capstone =3D declare_dependency(compile_args: config_host['CAPSTONE_CF=
LAGS'].split(),
> -                                link_args: config_host['CAPSTONE_LIBS'].=
split())
> -endif
>  libpmem =3D not_found
>  if 'CONFIG_LIBPMEM' in config_host
>    libpmem =3D declare_dependency(compile_args: config_host['LIBPMEM_CFLA=
GS'].split(),
> @@ -470,7 +466,6 @@ foreach k, v: config_host
>      config_host_data.set(k, v =3D=3D 'y' ? 1 : v)
>    endif
>  endforeach
> -genh +=3D configure_file(output: 'config-host.h', configuration: config_=
host_data)
>=20=20
>  minikconf =3D find_program('scripts/minikconf.py')
>  config_all_devices =3D {}
> @@ -610,6 +605,108 @@ config_all +=3D {
>    'CONFIG_ALL': true,
>  }
>=20=20
> +# Submodules
> +
> +capstone =3D not_found
> +capstone_opt =3D get_option('capstone')
> +if capstone_opt =3D=3D 'no'
> +  capstone_opt =3D false
> +elif capstone_opt in ['yes', 'auto', 'system']
> +  have_internal =3D fs.exists('capstone/Makefile')
> +  capstone =3D dependency('capstone', static: enable_static,
> +                        required: capstone_opt =3D=3D 'system' or
> +                                  capstone_opt =3D=3D 'yes' and not have=
_internal)
> +  if capstone.found()
> +    capstone_opt =3D 'system'
> +  elif have_internal
> +    capstone_opt =3D 'internal'
> +  else
> +    capstone_opt =3D false
> +  endif
> +endif
> +if capstone_opt =3D=3D 'internal'
> +  capstone_data =3D configuration_data()
> +  capstone_data.set('CAPSTONE_USE_SYS_DYN_MEM', '1')
> +
> +  capstone_files =3D files(
> +    'capstone/cs.c',
> +    'capstone/MCInst.c',
> +    'capstone/MCInstrDesc.c',
> +    'capstone/MCRegisterInfo.c',
> +    'capstone/SStream.c',
> +    'capstone/utils.c'
> +  )
> +
> +  if 'CONFIG_ARM_DIS' in config_all_disas
> +    capstone_data.set('CAPSTONE_HAS_ARM', '1')
> +    capstone_files +=3D files(
> +      'capstone/arch/ARM/ARMDisassembler.c',
> +      'capstone/arch/ARM/ARMInstPrinter.c',
> +      'capstone/arch/ARM/ARMMapping.c',
> +      'capstone/arch/ARM/ARMModule.c'
> +    )
> +  endif
> +
> +  # FIXME: This config entry currently depends on a c++ compiler.
> +  # Which is needed for building libvixl, but not for capstone.
> +  if 'CONFIG_ARM_A64_DIS' in config_all_disas
> +    capstone_data.set('CAPSTONE_HAS_ARM64', '1')
> +    capstone_files +=3D files(
> +      'capstone/arch/AArch64/AArch64BaseInfo.c',
> +      'capstone/arch/AArch64/AArch64Disassembler.c',
> +      'capstone/arch/AArch64/AArch64InstPrinter.c',
> +      'capstone/arch/AArch64/AArch64Mapping.c',
> +      'capstone/arch/AArch64/AArch64Module.c'
> +    )
> +  endif
> +
> +  if 'CONFIG_PPC_DIS' in config_all_disas
> +    capstone_data.set('CAPSTONE_HAS_POWERPC', '1')
> +    capstone_files +=3D files(
> +      'capstone/arch/PowerPC/PPCDisassembler.c',
> +      'capstone/arch/PowerPC/PPCInstPrinter.c',
> +      'capstone/arch/PowerPC/PPCMapping.c',
> +      'capstone/arch/PowerPC/PPCModule.c'
> +    )
> +  endif
> +
> +  if 'CONFIG_I386_DIS' in config_all_disas
> +    capstone_data.set('CAPSTONE_HAS_X86', 1)
> +    capstone_files +=3D files(
> +      'capstone/arch/X86/X86Disassembler.c',
> +      'capstone/arch/X86/X86DisassemblerDecoder.c',
> +      'capstone/arch/X86/X86ATTInstPrinter.c',
> +      'capstone/arch/X86/X86IntelInstPrinter.c',
> +      'capstone/arch/X86/X86Mapping.c',
> +      'capstone/arch/X86/X86Module.c'
> +    )
> +  endif
> +
> +  configure_file(output: 'capstone-defs.h', configuration: capstone_data)
> +
> +  capstone_cargs =3D [
> +    # FIXME: There does not seem to be a way to completely replace the c=
_args
> +    # that come from add_project_arguments() -- we can only add to them.
> +    # So: disable all warnings with a big hammer.
> +    '-Wno-error', '-w',
> +
> +    # Include all configuration defines via a header file, which will wi=
nd up
> +    # as a dependency on the object file, and thus changes here will res=
ult
> +    # in a rebuild.
> +    '-include', 'capstone-defs.h'
> +  ]
> +
> +  libcapstone =3D static_library('capstone',
> +                               sources: capstone_files,
> +                               c_args: capstone_cargs,
> +                               include_directories: 'capstone/include')
> +  capstone =3D declare_dependency(link_with: libcapstone,
> +                                include_directories: 'capstone/include')
> +endif
> +config_host_data.set('CONFIG_CAPSTONE', capstone.found())
> +
> +genh +=3D configure_file(output: 'config-host.h', configuration: config_=
host_data)
> +
>  # Generators
>=20=20
>  hxtool =3D find_program('scripts/hxtool')
> @@ -1512,7 +1609,7 @@ summary_info +=3D {'vvfat support':     config_host=
.has_key('CONFIG_VVFAT')}
>  summary_info +=3D {'qed support':       config_host.has_key('CONFIG_QED'=
)}
>  summary_info +=3D {'parallels support': config_host.has_key('CONFIG_PARA=
LLELS')}
>  summary_info +=3D {'sheepdog support':  config_host.has_key('CONFIG_SHEE=
PDOG')}
> -summary_info +=3D {'capstone':          config_host.has_key('CONFIG_CAPS=
TONE')}
> +summary_info +=3D {'capstone':          capstone_opt}
>  summary_info +=3D {'libpmem support':   config_host.has_key('CONFIG_LIBP=
MEM')}
>  summary_info +=3D {'libdaxctl support': config_host.has_key('CONFIG_LIBD=
AXCTL')}
>  summary_info +=3D {'libudev':           config_host.has_key('CONFIG_LIBU=
DEV')}
> diff --git a/meson_options.txt b/meson_options.txt
> index 543cf70043..e650a937e7 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -22,3 +22,7 @@ option('vnc_sasl', type : 'feature', value : 'auto',
>         description: 'SASL authentication for VNC server')
>  option('xkbcommon', type : 'feature', value : 'auto',
>         description: 'xkbcommon support')
> +
> +option('capstone', type: 'combo', value: 'auto',
> +       choices: ['no', 'yes', 'auto', 'system', 'internal'],
> +       description: 'Whether and how to find the capstone library')


--=20
Alex Benn=C3=A9e

