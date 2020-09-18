Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC02C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 08:56:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 003F221D42
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 08:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHBvcTyt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 003F221D42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJCCK-0001wY-29
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 04:56:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37498)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kJBz9-0003mV-PV
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 04:43:15 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:41308)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kJBz6-00081b-CC
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 04:43:15 -0400
Received: by mail-lf1-x142.google.com with SMTP id y17so5254798lfa.8
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 01:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=2orbkTMS6pB4VKPVAI2feshufgHaPFE2KuASKMKjKwQ=;
 b=bHBvcTytWRGiBQQJi6ML3Uerry7H/XkwTvOrdhTf5jXS2RechKLv1ZF17ToD+LjtrJ
 HOBqKOa40l23ag32n6222DgNB7dK2yIPul1+vI1+tBBh15A8THuDKJjL2sJ8V0wVCGAc
 mmhMCrY665RfStVZdew/JB5FTiBFmNegigKTQNeTvTH6ARZnlgl4blSigJYU7CDqEeXe
 nj9Tkolcuut4Zg+pyuScM4lPeoGfHNRKHuD4YkCZUvtlMS7/huTCWtglcAiYmkVTHLOG
 tvh2wOo59QqpOj/akmgRNPg7fS+inkIU34LDx1+wriA4Wpuc7+8+DZ6pYdYl6kZqPnmu
 AzxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=2orbkTMS6pB4VKPVAI2feshufgHaPFE2KuASKMKjKwQ=;
 b=k3c6HySDEi4VR3WVWF+UGrXCuFH1U6/9cHSq+gKp1b+nom2TfbQsSsXU2Vwn9mvsnC
 l8OEoCDggRHBnSej9mF5YXpFL3yHspuOEkCgzJ1TQy65zJd48AL2Ljh5jM9U2hi1fKp4
 KCmYo+BzirJt1ijRWXhNwaQmofhB43UUXKeCj518BJwdgxQMJ+zW+VhcCIrC1ZOVnhFK
 7B8umnoJXKnlVi/HDxtfNEuIr7hW8k5TXcjjqZMRWHuwrMVBMgLCsJQjSbndUW321uxt
 7Ql8/s2zNXycTgUngnT+vfzA0BEb9v3OxD1SswqMj9VGL8CqymH3TIz/H+xaFIDAxOU/
 hJKw==
X-Gm-Message-State: AOAM531suU7X4IzbAZP7X4uAT+ZCLVMPnK/pWxUWJWmFI/cqI/Xb51tt
 NWgCcL1f4F8SDOij+xVJZeHjkhIssfBIvSLB7IE=
X-Google-Smtp-Source: ABdhPJxGNPwBNBhqE+wU8pSQ3A82YybdLEl8hdHZTgJcUPU69g1YaIfeURwzyLKYo1PxfLHB7cNqvazddKzXKIDcbDw=
X-Received: by 2002:a19:a407:: with SMTP id q7mr9814836lfc.377.1600418590169; 
 Fri, 18 Sep 2020 01:43:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200917235720.2685978-1-richard.henderson@linaro.org>
 <20200917235720.2685978-2-richard.henderson@linaro.org>
 <047ad15d-e847-a53d-d0ef-443196085e10@redhat.com>
In-Reply-To: <047ad15d-e847-a53d-d0ef-443196085e10@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Fri, 18 Sep 2020 16:42:58 +0800
Message-ID: <CAE2XoE_Dk-h1hyZSBDuf-TZS1i+p2fMtsk5P9ugHpQPARSvmdA@mail.gmail.com>
Subject: Re: [PATCH v3 01/10] capstone: Convert Makefile bits to meson bits
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000008f21fa05af927ddc"
Received-SPF: pass client-ip=2a00:1450:4864:20::142;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x142.google.com
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 qemu-level <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000008f21fa05af927ddc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2020 at 4:19 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 18/09/20 01:57, Richard Henderson wrote:
> > There are better ways to do this, e.g. meson cmake subproject,
> > but that requires cmake 3.7 and some of our CI environments
> > only provide cmake 3.5.
> >
> > Nor can we add a meson.build file to capstone/, because the git
> > submodule would then always report "untracked files".  Fixing that
> > would require creating our own branch on the qemu git mirror, at
> > which point we could just as easily create a native meson subproject.
> >
> > Instead, build the library via the main meson.build.
> >
> > This improves the current state of affairs in that we will re-link
> > the qemu executables against a changed libcapstone.a, which we wouldn't
> > do before-hand.  In addition, the use of the configuration header file
> > instead of command-line -DEFINES means that we will rebuild the
> > capstone objects with changes to meson.build.
> >
> > Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> > ---
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > v2: Further reduce probing in configure (paolo),
> >     Drop state 'internal' and use 'git' even when it isn't git.
> >     Move CONFIG_CAPSTONE to config_host_data.
> > v3: Add Submodules separator; fix default in meson_options.txt.
> > ---
>
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
>
> Thanks!  That's also a nice blueprint if anyone wants to do the same on
> libfdt.
>
> Paolo
>
>
> >  configure         |  61 +++----------------------
> >  Makefile          |  16 -------
> >  meson.build       | 111 +++++++++++++++++++++++++++++++++++++++++++---
> >  meson_options.txt |   4 ++
> >  4 files changed, 115 insertions(+), 77 deletions(-)
> >
> > diff --git a/configure b/configure
> > index 7564479008..76636c430d 100755
> > --- a/configure
> > +++ b/configure
> > @@ -478,7 +478,7 @@ opengl=3D""
> >  opengl_dmabuf=3D"no"
> >  cpuid_h=3D"no"
> >  avx2_opt=3D""
> > -capstone=3D""
> > +capstone=3D"auto"
> >  lzo=3D""
> >  snappy=3D""
> >  bzip2=3D""
> > @@ -1580,7 +1580,7 @@ for opt do
> >    ;;
> >    --enable-capstone) capstone=3D"yes"
> >    ;;
> > -  --enable-capstone=3Dgit) capstone=3D"git"
> > +  --enable-capstone=3Dgit) capstone=3D"internal"
> >    ;;
> >    --enable-capstone=3Dsystem) capstone=3D"system"
> >    ;;
> > @@ -5128,51 +5128,11 @@ fi
> >  # capstone
> >
> >  case "$capstone" in
> > -  "" | yes)
> > -    if $pkg_config capstone; then
> > -      capstone=3Dsystem
> > -    elif test -e "${source_path}/.git" && test $git_update =3D 'yes' ;
then
> > -      capstone=3Dgit
> > -    elif test -e "${source_path}/capstone/Makefile" ; then
> > -      capstone=3Dinternal
> > -    elif test -z "$capstone" ; then
> > -      capstone=3Dno
> > -    else
> > -      feature_not_found "capstone" "Install capstone devel or git
submodule"
> > -    fi
> > -    ;;
> > -
> > -  system)
> > -    if ! $pkg_config capstone; then
> > -      feature_not_found "capstone" "Install capstone devel"
> > -    fi
> > -    ;;
> > -esac
> > -
> > -case "$capstone" in
> > -  git | internal)
> > -    if test "$capstone" =3D git; then
> > +  auto | yes | internal)
> > +    # Simpler to always update submodule, even if not needed.
> > +    if test -e "${source_path}/.git" && test $git_update =3D 'yes' ; t=
hen
> >        git_submodules=3D"${git_submodules} capstone"
> >      fi
> > -    mkdir -p capstone
> > -    if test "$mingw32" =3D "yes"; then
> > -      LIBCAPSTONE=3Dcapstone.lib
> > -    else
> > -      LIBCAPSTONE=3Dlibcapstone.a
> > -    fi
> > -    capstone_libs=3D"-Lcapstone -lcapstone"
> > -    capstone_cflags=3D"-I${source_path}/capstone/include"
> > -    ;;
> > -
> > -  system)
> > -    capstone_libs=3D"$($pkg_config --libs capstone)"
> > -    capstone_cflags=3D"$($pkg_config --cflags capstone)"
> > -    ;;
> > -
> > -  no)
> > -    ;;
> > -  *)
> > -    error_exit "Unknown state for capstone: $capstone"
> >      ;;
> >  esac
> >
> > @@ -7292,11 +7252,6 @@ fi
> >  if test "$ivshmem" =3D "yes" ; then
> >    echo "CONFIG_IVSHMEM=3Dy" >> $config_host_mak
> >  fi
> > -if test "$capstone" !=3D "no" ; then
> > -  echo "CONFIG_CAPSTONE=3Dy" >> $config_host_mak
> > -  echo "CAPSTONE_CFLAGS=3D$capstone_cflags" >> $config_host_mak
> > -  echo "CAPSTONE_LIBS=3D$capstone_libs" >> $config_host_mak
> > -fi
> >  if test "$debug_mutex" =3D "yes" ; then
> >    echo "CONFIG_DEBUG_MUTEX=3Dy" >> $config_host_mak
> >  fi
> > @@ -7819,9 +7774,6 @@ done # for target in $targets
> >  if [ "$fdt" =3D "git" ]; then
> >    subdirs=3D"$subdirs dtc"
> >  fi
> > -if [ "$capstone" =3D "git" -o "$capstone" =3D "internal" ]; then
> > -  subdirs=3D"$subdirs capstone"
> > -fi
> >  echo "SUBDIRS=3D$subdirs" >> $config_host_mak
> >  if test -n "$LIBCAPSTONE"; then
> >    echo "LIBCAPSTONE=3D$LIBCAPSTONE" >> $config_host_mak
> > @@ -8008,7 +7960,8 @@ NINJA=3D${ninja:-$PWD/ninjatool} $meson setup \
> >          -Db_coverage=3D$(if test "$gcov" =3D yes; then echo true; else
echo false; fi) \
> >       -Dsdl=3D$sdl -Dsdl_image=3D$sdl_image \
> >       -Dvnc=3D$vnc -Dvnc_sasl=3D$vnc_sasl -Dvnc_jpeg=3D$vnc_jpeg
-Dvnc_png=3D$vnc_png \
> > -     -Dgettext=3D$gettext -Dxkbcommon=3D$xkbcommon -Du2f=3D$u2f\
> > +     -Dgettext=3D$gettext -Dxkbcommon=3D$xkbcommon -Du2f=3D$u2f \
> > +     -Dcapstone=3D$capstone \
> >          $cross_arg \
> >          "$PWD" "$source_path"
> >
> > diff --git a/Makefile b/Makefile
> > index 7c60b9dcb8..f3da1760ad 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -156,22 +156,6 @@ dtc/all: .git-submodule-status dtc/libfdt
> >  dtc/%: .git-submodule-status
> >       @mkdir -p $@
> >
> > -# Overriding CFLAGS causes us to lose defines added in the
sub-makefile.
> > -# Not overriding CFLAGS leads to mis-matches between compilation modes=
.
> > -# Therefore we replicate some of the logic in the sub-makefile.
> > -# Remove all the extra -Warning flags that QEMU uses that Capstone
doesn't;
> > -# no need to annoy QEMU developers with such things.
> > -CAP_CFLAGS =3D $(patsubst -W%,,$(CFLAGS) $(QEMU_CFLAGS))
$(CAPSTONE_CFLAGS)
> > -CAP_CFLAGS +=3D -DCAPSTONE_USE_SYS_DYN_MEM
> > -CAP_CFLAGS +=3D -DCAPSTONE_HAS_ARM
> > -CAP_CFLAGS +=3D -DCAPSTONE_HAS_ARM64
> > -CAP_CFLAGS +=3D -DCAPSTONE_HAS_POWERPC
> > -CAP_CFLAGS +=3D -DCAPSTONE_HAS_X86
> > -
> > -.PHONY: capstone/all
> > -capstone/all: .git-submodule-status
> > -     $(call quiet-command,$(MAKE) -C $(SRC_PATH)/capstone
CAPSTONE_SHARED=3Dno BUILDDIR=3D"$(BUILD_DIR)/capstone" CC=3D"$(CC)" AR=3D"=
$(AR)"
LD=3D"$(LD)" RANLIB=3D"$(RANLIB)" CFLAGS=3D"$(CAP_CFLAGS)" $(SUBDIR_MAKEFLA=
GS)
$(BUILD_DIR)/capstone/$(LIBCAPSTONE))
> > -
> >  .PHONY: slirp/all
> >  slirp/all: .git-submodule-status
> >       $(call quiet-command,$(MAKE) -C $(SRC_PATH)/slirp               \
> > diff --git a/meson.build b/meson.build
> > index f4d1ab1096..f23273693d 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -10,6 +10,7 @@ else
> >    keyval =3D import('unstable-keyval')
> >  endif
> >  ss =3D import('sourceset')
> > +fs =3D import('fs')
> >
> >  sh =3D find_program('sh')
> >  cc =3D meson.get_compiler('c')
> > @@ -409,11 +410,6 @@ if 'CONFIG_USB_LIBUSB' in config_host
> >    libusb =3D declare_dependency(compile_args:
config_host['LIBUSB_CFLAGS'].split(),
> >                                link_args:
config_host['LIBUSB_LIBS'].split())
> >  endif
> > -capstone =3D not_found
> > -if 'CONFIG_CAPSTONE' in config_host
> > -  capstone =3D declare_dependency(compile_args:
config_host['CAPSTONE_CFLAGS'].split(),
> > -                                link_args:
config_host['CAPSTONE_LIBS'].split())
> > -endif
> >  libpmem =3D not_found
> >  if 'CONFIG_LIBPMEM' in config_host
> >    libpmem =3D declare_dependency(compile_args:
config_host['LIBPMEM_CFLAGS'].split(),
> > @@ -470,7 +466,6 @@ foreach k, v: config_host
> >      config_host_data.set(k, v =3D=3D 'y' ? 1 : v)
> >    endif
> >  endforeach
> > -genh +=3D configure_file(output: 'config-host.h', configuration:
config_host_data)
> >
> >  minikconf =3D find_program('scripts/minikconf.py')
> >  config_all_devices =3D {}
> > @@ -610,6 +605,108 @@ config_all +=3D {
> >    'CONFIG_ALL': true,
> >  }
> >
> > +# Submodules
> > +
> > +capstone =3D not_found
> > +capstone_opt =3D get_option('capstone')
> > +if capstone_opt =3D=3D 'no'
> > +  capstone_opt =3D false
> > +elif capstone_opt in ['yes', 'auto', 'system']
> > +  have_internal =3D fs.exists('capstone/Makefile')
> > +  capstone =3D dependency('capstone', static: enable_static,
> > +                        required: capstone_opt =3D=3D 'system' or
> > +                                  capstone_opt =3D=3D 'yes' and not
have_internal)
> > +  if capstone.found()
> > +    capstone_opt =3D 'system'
> > +  elif have_internal
> > +    capstone_opt =3D 'internal'
> > +  else
> > +    capstone_opt =3D false
> > +  endif
> > +endif
> > +if capstone_opt =3D=3D 'internal'
> > +  capstone_data =3D configuration_data()
> > +  capstone_data.set('CAPSTONE_USE_SYS_DYN_MEM', '1')
> > +
> > +  capstone_files =3D files(
> > +    'capstone/cs.c',
> > +    'capstone/MCInst.c',
> > +    'capstone/MCInstrDesc.c',
> > +    'capstone/MCRegisterInfo.c',
> > +    'capstone/SStream.c',
> > +    'capstone/utils.c'
> > +  )
> > +
> > +  if 'CONFIG_ARM_DIS' in config_all_disas
> > +    capstone_data.set('CAPSTONE_HAS_ARM', '1')
> > +    capstone_files +=3D files(
> > +      'capstone/arch/ARM/ARMDisassembler.c',
> > +      'capstone/arch/ARM/ARMInstPrinter.c',
> > +      'capstone/arch/ARM/ARMMapping.c',
> > +      'capstone/arch/ARM/ARMModule.c'
> > +    )
> > +  endif
> > +
> > +  # FIXME: This config entry currently depends on a c++ compiler.
> > +  # Which is needed for building libvixl, but not for capstone.
> > +  if 'CONFIG_ARM_A64_DIS' in config_all_disas
> > +    capstone_data.set('CAPSTONE_HAS_ARM64', '1')
> > +    capstone_files +=3D files(
> > +      'capstone/arch/AArch64/AArch64BaseInfo.c',
> > +      'capstone/arch/AArch64/AArch64Disassembler.c',
> > +      'capstone/arch/AArch64/AArch64InstPrinter.c',
> > +      'capstone/arch/AArch64/AArch64Mapping.c',
> > +      'capstone/arch/AArch64/AArch64Module.c'
> > +    )
> > +  endif
> > +
> > +  if 'CONFIG_PPC_DIS' in config_all_disas
> > +    capstone_data.set('CAPSTONE_HAS_POWERPC', '1')
> > +    capstone_files +=3D files(
> > +      'capstone/arch/PowerPC/PPCDisassembler.c',
> > +      'capstone/arch/PowerPC/PPCInstPrinter.c',
> > +      'capstone/arch/PowerPC/PPCMapping.c',
> > +      'capstone/arch/PowerPC/PPCModule.c'
> > +    )
> > +  endif
> > +
> > +  if 'CONFIG_I386_DIS' in config_all_disas
> > +    capstone_data.set('CAPSTONE_HAS_X86', 1)
> > +    capstone_files +=3D files(
> > +      'capstone/arch/X86/X86Disassembler.c',
> > +      'capstone/arch/X86/X86DisassemblerDecoder.c',
> > +      'capstone/arch/X86/X86ATTInstPrinter.c',
> > +      'capstone/arch/X86/X86IntelInstPrinter.c',
> > +      'capstone/arch/X86/X86Mapping.c',
> > +      'capstone/arch/X86/X86Module.c'
> > +    )
> > +  endif
> > +
> > +  configure_file(output: 'capstone-defs.h', configuration:
capstone_data)
> > +
> > +  capstone_cargs =3D [
> > +    # FIXME: There does not seem to be a way to completely replace the
c_args
> > +    # that come from add_project_arguments() -- we can only add to
them.
> > +    # So: disable all warnings with a big hammer.
> > +    '-Wno-error', '-w',
> > +
> > +    # Include all configuration defines via a header file, which will
wind up
> > +    # as a dependency on the object file, and thus changes here will
result
> > +    # in a rebuild.
> > +    '-include', 'capstone-defs.h'
> > +  ]
> > +
> > +  libcapstone =3D static_library('capstone',
> > +                               sources: capstone_files,
> > +                               c_args: capstone_cargs,
> > +                               include_directories: 'capstone/include'=
)
> > +  capstone =3D declare_dependency(link_with: libcapstone,
> > +                                include_directories:
'capstone/include')
> > +endif
> > +config_host_data.set('CONFIG_CAPSTONE', capstone.found())
> > +
> > +genh +=3D configure_file(output: 'config-host.h', configuration:
config_host_data)
> > +
> >  # Generators
> >
> >  hxtool =3D find_program('scripts/hxtool')
> > @@ -1512,7 +1609,7 @@ summary_info +=3D {'vvfat support':
config_host.has_key('CONFIG_VVFAT')}
> >  summary_info +=3D {'qed support':
config_host.has_key('CONFIG_QED')}
> >  summary_info +=3D {'parallels support':
config_host.has_key('CONFIG_PARALLELS')}
> >  summary_info +=3D {'sheepdog support':
 config_host.has_key('CONFIG_SHEEPDOG')}
> > -summary_info +=3D {'capstone':
 config_host.has_key('CONFIG_CAPSTONE')}
> > +summary_info +=3D {'capstone':          capstone_opt}
> >  summary_info +=3D {'libpmem support':
config_host.has_key('CONFIG_LIBPMEM')}
> >  summary_info +=3D {'libdaxctl support':
config_host.has_key('CONFIG_LIBDAXCTL')}
> >  summary_info +=3D {'libudev':
config_host.has_key('CONFIG_LIBUDEV')}
> > diff --git a/meson_options.txt b/meson_options.txt
> > index 543cf70043..e650a937e7 100644
> > --- a/meson_options.txt
> > +++ b/meson_options.txt
> > @@ -22,3 +22,7 @@ option('vnc_sasl', type : 'feature', value : 'auto',
> >         description: 'SASL authentication for VNC server')
> >  option('xkbcommon', type : 'feature', value : 'auto',
> >         description: 'xkbcommon support')
> > +
> > +option('capstone', type: 'combo', value: 'auto',
> > +       choices: ['no', 'yes', 'auto', 'system', 'internal'],
> > +       description: 'Whether and how to find the capstone library')
> >
>
>
I also have a question that how about convert
  --disable-capstone) capstone=3D"no"
  ;;
  --enable-capstone) capstone=3D"yes"
  ;;
to
    --disable-capstone) capstone=3D"disabled"
  ;;
  --enable-capstone) capstone=3D"enabled"
  ;;

for consistence with meson
--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000008f21fa05af927ddc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Fri, Sep 18, 2020 at 4:19 PM Paolo Bonzini &lt;=
<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>&gt; wrote:<b=
r>&gt;<br>&gt; On 18/09/20 01:57, Richard Henderson wrote:<br>&gt; &gt; The=
re are better ways to do this, e.g. meson cmake subproject,<br>&gt; &gt; bu=
t that requires cmake 3.7 and some of our CI environments<br>&gt; &gt; only=
 provide cmake 3.5.<br>&gt; &gt;<br>&gt; &gt; Nor can we add a meson.build =
file to capstone/, because the git<br>&gt; &gt; submodule would then always=
 report &quot;untracked files&quot;.=C2=A0 Fixing that<br>&gt; &gt; would r=
equire creating our own branch on the qemu git mirror, at<br>&gt; &gt; whic=
h point we could just as easily create a native meson subproject.<br>&gt; &=
gt;<br>&gt; &gt; Instead, build the library via the main meson.build.<br>&g=
t; &gt;<br>&gt; &gt; This improves the current state of affairs in that we =
will re-link<br>&gt; &gt; the qemu executables against a changed libcapston=
e.a, which we wouldn&#39;t<br>&gt; &gt; do before-hand.=C2=A0 In addition, =
the use of the configuration header file<br>&gt; &gt; instead of command-li=
ne -DEFINES means that we will rebuild the<br>&gt; &gt; capstone objects wi=
th changes to meson.build.<br>&gt; &gt;<br>&gt; &gt; Signed-off-by: Richard=
 Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">richard.hend=
erson@linaro.org</a>&gt;<br>&gt; &gt; ---<br>&gt; &gt; Cc: Paolo Bonzini &l=
t;<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>&gt;<br>&gt=
; &gt; v2: Further reduce probing in configure (paolo),<br>&gt; &gt; =C2=A0=
 =C2=A0 Drop state &#39;internal&#39; and use &#39;git&#39; even when it is=
n&#39;t git.<br>&gt; &gt; =C2=A0 =C2=A0 Move CONFIG_CAPSTONE to config_host=
_data.<br>&gt; &gt; v3: Add Submodules separator; fix default in meson_opti=
ons.txt.<br>&gt; &gt; ---<br>&gt;<br>&gt; Acked-by: Paolo Bonzini &lt;<a hr=
ef=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>&gt;<br>&gt;<br>&g=
t; Thanks!=C2=A0 That&#39;s also a nice blueprint if anyone wants to do the=
 same on<br>&gt; libfdt.<br>&gt;<br>&gt; Paolo<br>&gt;<br>&gt;<br>&gt; &gt;=
 =C2=A0configure =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A061 +++----------------=
------<br>&gt; &gt; =C2=A0Makefile =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=
=A016 -------<br>&gt; &gt; =C2=A0meson.build =C2=A0 =C2=A0 =C2=A0 | 111 +++=
++++++++++++++++++++++++++++++++++++++++---<br>&gt; &gt; =C2=A0meson_option=
s.txt | =C2=A0 4 ++<br>&gt; &gt; =C2=A04 files changed, 115 insertions(+), =
77 deletions(-)<br>&gt; &gt;<br>&gt; &gt; diff --git a/configure b/configur=
e<br>&gt; &gt; index 7564479008..76636c430d 100755<br>&gt; &gt; --- a/confi=
gure<br>&gt; &gt; +++ b/configure<br>&gt; &gt; @@ -478,7 +478,7 @@ opengl=
=3D&quot;&quot;<br>&gt; &gt; =C2=A0opengl_dmabuf=3D&quot;no&quot;<br>&gt; &=
gt; =C2=A0cpuid_h=3D&quot;no&quot;<br>&gt; &gt; =C2=A0avx2_opt=3D&quot;&quo=
t;<br>&gt; &gt; -capstone=3D&quot;&quot;<br>&gt; &gt; +capstone=3D&quot;aut=
o&quot;<br>&gt; &gt; =C2=A0lzo=3D&quot;&quot;<br>&gt; &gt; =C2=A0snappy=3D&=
quot;&quot;<br>&gt; &gt; =C2=A0bzip2=3D&quot;&quot;<br>&gt; &gt; @@ -1580,7=
 +1580,7 @@ for opt do<br>&gt; &gt; =C2=A0 =C2=A0;;<br>&gt; &gt; =C2=A0 =C2=
=A0--enable-capstone) capstone=3D&quot;yes&quot;<br>&gt; &gt; =C2=A0 =C2=A0=
;;<br>&gt; &gt; - =C2=A0--enable-capstone=3Dgit) capstone=3D&quot;git&quot;=
<br>&gt; &gt; + =C2=A0--enable-capstone=3Dgit) capstone=3D&quot;internal&qu=
ot;<br>&gt; &gt; =C2=A0 =C2=A0;;<br>&gt; &gt; =C2=A0 =C2=A0--enable-capston=
e=3Dsystem) capstone=3D&quot;system&quot;<br>&gt; &gt; =C2=A0 =C2=A0;;<br>&=
gt; &gt; @@ -5128,51 +5128,11 @@ fi<br>&gt; &gt; =C2=A0# capstone<br>&gt; &=
gt; <br>&gt; &gt; =C2=A0case &quot;$capstone&quot; in<br>&gt; &gt; - =C2=A0=
&quot;&quot; | yes)<br>&gt; &gt; - =C2=A0 =C2=A0if $pkg_config capstone; th=
en<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0capstone=3Dsystem<br>&gt; &gt; - =C2=
=A0 =C2=A0elif test -e &quot;${source_path}/.git&quot; &amp;&amp; test $git=
_update =3D &#39;yes&#39; ; then<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0capston=
e=3Dgit<br>&gt; &gt; - =C2=A0 =C2=A0elif test -e &quot;${source_path}/capst=
one/Makefile&quot; ; then<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0capstone=3Dint=
ernal<br>&gt; &gt; - =C2=A0 =C2=A0elif test -z &quot;$capstone&quot; ; then=
<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0capstone=3Dno<br>&gt; &gt; - =C2=A0 =C2=
=A0else<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0feature_not_found &quot;capstone=
&quot; &quot;Install capstone devel or git submodule&quot;<br>&gt; &gt; - =
=C2=A0 =C2=A0fi<br>&gt; &gt; - =C2=A0 =C2=A0;;<br>&gt; &gt; -<br>&gt; &gt; =
- =C2=A0system)<br>&gt; &gt; - =C2=A0 =C2=A0if ! $pkg_config capstone; then=
<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0feature_not_found &quot;capstone&quot; =
&quot;Install capstone devel&quot;<br>&gt; &gt; - =C2=A0 =C2=A0fi<br>&gt; &=
gt; - =C2=A0 =C2=A0;;<br>&gt; &gt; -esac<br>&gt; &gt; -<br>&gt; &gt; -case =
&quot;$capstone&quot; in<br>&gt; &gt; - =C2=A0git | internal)<br>&gt; &gt; =
- =C2=A0 =C2=A0if test &quot;$capstone&quot; =3D git; then<br>&gt; &gt; + =
=C2=A0auto | yes | internal)<br>&gt; &gt; + =C2=A0 =C2=A0# Simpler to alway=
s update submodule, even if not needed.<br>&gt; &gt; + =C2=A0 =C2=A0if test=
 -e &quot;${source_path}/.git&quot; &amp;&amp; test $git_update =3D &#39;ye=
s&#39; ; then<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0git_submodules=3D&quo=
t;${git_submodules} capstone&quot;<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0fi<br>&=
gt; &gt; - =C2=A0 =C2=A0mkdir -p capstone<br>&gt; &gt; - =C2=A0 =C2=A0if te=
st &quot;$mingw32&quot; =3D &quot;yes&quot;; then<br>&gt; &gt; - =C2=A0 =C2=
=A0 =C2=A0LIBCAPSTONE=3Dcapstone.lib<br>&gt; &gt; - =C2=A0 =C2=A0else<br>&g=
t; &gt; - =C2=A0 =C2=A0 =C2=A0LIBCAPSTONE=3Dlibcapstone.a<br>&gt; &gt; - =
=C2=A0 =C2=A0fi<br>&gt; &gt; - =C2=A0 =C2=A0capstone_libs=3D&quot;-Lcapston=
e -lcapstone&quot;<br>&gt; &gt; - =C2=A0 =C2=A0capstone_cflags=3D&quot;-I${=
source_path}/capstone/include&quot;<br>&gt; &gt; - =C2=A0 =C2=A0;;<br>&gt; =
&gt; -<br>&gt; &gt; - =C2=A0system)<br>&gt; &gt; - =C2=A0 =C2=A0capstone_li=
bs=3D&quot;$($pkg_config --libs capstone)&quot;<br>&gt; &gt; - =C2=A0 =C2=
=A0capstone_cflags=3D&quot;$($pkg_config --cflags capstone)&quot;<br>&gt; &=
gt; - =C2=A0 =C2=A0;;<br>&gt; &gt; -<br>&gt; &gt; - =C2=A0no)<br>&gt; &gt; =
- =C2=A0 =C2=A0;;<br>&gt; &gt; - =C2=A0*)<br>&gt; &gt; - =C2=A0 =C2=A0error=
_exit &quot;Unknown state for capstone: $capstone&quot;<br>&gt; &gt; =C2=A0=
 =C2=A0 =C2=A0;;<br>&gt; &gt; =C2=A0esac<br>&gt; &gt; <br>&gt; &gt; @@ -729=
2,11 +7252,6 @@ fi<br>&gt; &gt; =C2=A0if test &quot;$ivshmem&quot; =3D &quo=
t;yes&quot; ; then<br>&gt; &gt; =C2=A0 =C2=A0echo &quot;CONFIG_IVSHMEM=3Dy&=
quot; &gt;&gt; $config_host_mak<br>&gt; &gt; =C2=A0fi<br>&gt; &gt; -if test=
 &quot;$capstone&quot; !=3D &quot;no&quot; ; then<br>&gt; &gt; - =C2=A0echo=
 &quot;CONFIG_CAPSTONE=3Dy&quot; &gt;&gt; $config_host_mak<br>&gt; &gt; - =
=C2=A0echo &quot;CAPSTONE_CFLAGS=3D$capstone_cflags&quot; &gt;&gt; $config_=
host_mak<br>&gt; &gt; - =C2=A0echo &quot;CAPSTONE_LIBS=3D$capstone_libs&quo=
t; &gt;&gt; $config_host_mak<br>&gt; &gt; -fi<br>&gt; &gt; =C2=A0if test &q=
uot;$debug_mutex&quot; =3D &quot;yes&quot; ; then<br>&gt; &gt; =C2=A0 =C2=
=A0echo &quot;CONFIG_DEBUG_MUTEX=3Dy&quot; &gt;&gt; $config_host_mak<br>&gt=
; &gt; =C2=A0fi<br>&gt; &gt; @@ -7819,9 +7774,6 @@ done # for target in $ta=
rgets<br>&gt; &gt; =C2=A0if [ &quot;$fdt&quot; =3D &quot;git&quot; ]; then<=
br>&gt; &gt; =C2=A0 =C2=A0subdirs=3D&quot;$subdirs dtc&quot;<br>&gt; &gt; =
=C2=A0fi<br>&gt; &gt; -if [ &quot;$capstone&quot; =3D &quot;git&quot; -o &q=
uot;$capstone&quot; =3D &quot;internal&quot; ]; then<br>&gt; &gt; - =C2=A0s=
ubdirs=3D&quot;$subdirs capstone&quot;<br>&gt; &gt; -fi<br>&gt; &gt; =C2=A0=
echo &quot;SUBDIRS=3D$subdirs&quot; &gt;&gt; $config_host_mak<br>&gt; &gt; =
=C2=A0if test -n &quot;$LIBCAPSTONE&quot;; then<br>&gt; &gt; =C2=A0 =C2=A0e=
cho &quot;LIBCAPSTONE=3D$LIBCAPSTONE&quot; &gt;&gt; $config_host_mak<br>&gt=
; &gt; @@ -8008,7 +7960,8 @@ NINJA=3D${ninja:-$PWD/ninjatool} $meson setup =
\<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-Db_coverage=3D$(if test &=
quot;$gcov&quot; =3D yes; then echo true; else echo false; fi) \<br>&gt; &g=
t; =C2=A0 =C2=A0 =C2=A0 -Dsdl=3D$sdl -Dsdl_image=3D$sdl_image \<br>&gt; &gt=
; =C2=A0 =C2=A0 =C2=A0 -Dvnc=3D$vnc -Dvnc_sasl=3D$vnc_sasl -Dvnc_jpeg=3D$vn=
c_jpeg -Dvnc_png=3D$vnc_png \<br>&gt; &gt; - =C2=A0 =C2=A0 -Dgettext=3D$get=
text -Dxkbcommon=3D$xkbcommon -Du2f=3D$u2f\<br>&gt; &gt; + =C2=A0 =C2=A0 -D=
gettext=3D$gettext -Dxkbcommon=3D$xkbcommon -Du2f=3D$u2f \<br>&gt; &gt; + =
=C2=A0 =C2=A0 -Dcapstone=3D$capstone \<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0$cross_arg \<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&q=
uot;$PWD&quot; &quot;$source_path&quot;<br>&gt; &gt; <br>&gt; &gt; diff --g=
it a/Makefile b/Makefile<br>&gt; &gt; index 7c60b9dcb8..f3da1760ad 100644<b=
r>&gt; &gt; --- a/Makefile<br>&gt; &gt; +++ b/Makefile<br>&gt; &gt; @@ -156=
,22 +156,6 @@ dtc/all: .git-submodule-status dtc/libfdt<br>&gt; &gt; =C2=A0=
dtc/%: .git-submodule-status<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 @mkdir -p $@=
<br>&gt; &gt; <br>&gt; &gt; -# Overriding CFLAGS causes us to lose defines =
added in the sub-makefile.<br>&gt; &gt; -# Not overriding CFLAGS leads to m=
is-matches between compilation modes.<br>&gt; &gt; -# Therefore we replicat=
e some of the logic in the sub-makefile.<br>&gt; &gt; -# Remove all the ext=
ra -Warning flags that QEMU uses that Capstone doesn&#39;t;<br>&gt; &gt; -#=
 no need to annoy QEMU developers with such things.<br>&gt; &gt; -CAP_CFLAG=
S =3D $(patsubst -W%,,$(CFLAGS) $(QEMU_CFLAGS)) $(CAPSTONE_CFLAGS)<br>&gt; =
&gt; -CAP_CFLAGS +=3D -DCAPSTONE_USE_SYS_DYN_MEM<br>&gt; &gt; -CAP_CFLAGS +=
=3D -DCAPSTONE_HAS_ARM<br>&gt; &gt; -CAP_CFLAGS +=3D -DCAPSTONE_HAS_ARM64<b=
r>&gt; &gt; -CAP_CFLAGS +=3D -DCAPSTONE_HAS_POWERPC<br>&gt; &gt; -CAP_CFLAG=
S +=3D -DCAPSTONE_HAS_X86<br>&gt; &gt; -<br>&gt; &gt; -.PHONY: capstone/all=
<br>&gt; &gt; -capstone/all: .git-submodule-status<br>&gt; &gt; - =C2=A0 =
=C2=A0 $(call quiet-command,$(MAKE) -C $(SRC_PATH)/capstone CAPSTONE_SHARED=
=3Dno BUILDDIR=3D&quot;$(BUILD_DIR)/capstone&quot; CC=3D&quot;$(CC)&quot; A=
R=3D&quot;$(AR)&quot; LD=3D&quot;$(LD)&quot; RANLIB=3D&quot;$(RANLIB)&quot;=
 CFLAGS=3D&quot;$(CAP_CFLAGS)&quot; $(SUBDIR_MAKEFLAGS) $(BUILD_DIR)/capsto=
ne/$(LIBCAPSTONE))<br>&gt; &gt; -<br>&gt; &gt; =C2=A0.PHONY: slirp/all<br>&=
gt; &gt; =C2=A0slirp/all: .git-submodule-status<br>&gt; &gt; =C2=A0 =C2=A0 =
=C2=A0 $(call quiet-command,$(MAKE) -C $(SRC_PATH)/slirp =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>&gt; &gt; diff --git a/meson.build b/m=
eson.build<br>&gt; &gt; index f4d1ab1096..f23273693d 100644<br>&gt; &gt; --=
- a/meson.build<br>&gt; &gt; +++ b/meson.build<br>&gt; &gt; @@ -10,6 +10,7 =
@@ else<br>&gt; &gt; =C2=A0 =C2=A0keyval =3D import(&#39;unstable-keyval&#3=
9;)<br>&gt; &gt; =C2=A0endif<br>&gt; &gt; =C2=A0ss =3D import(&#39;sourcese=
t&#39;)<br>&gt; &gt; +fs =3D import(&#39;fs&#39;)<br>&gt; &gt; <br>&gt; &gt=
; =C2=A0sh =3D find_program(&#39;sh&#39;)<br>&gt; &gt; =C2=A0cc =3D meson.g=
et_compiler(&#39;c&#39;)<br>&gt; &gt; @@ -409,11 +410,6 @@ if &#39;CONFIG_U=
SB_LIBUSB&#39; in config_host<br>&gt; &gt; =C2=A0 =C2=A0libusb =3D declare_=
dependency(compile_args: config_host[&#39;LIBUSB_CFLAGS&#39;].split(),<br>&=
gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0link_args: config_host[&#39;LI=
BUSB_LIBS&#39;].split())<br>&gt; &gt; =C2=A0endif<br>&gt; &gt; -capstone =
=3D not_found<br>&gt; &gt; -if &#39;CONFIG_CAPSTONE&#39; in config_host<br>=
&gt; &gt; - =C2=A0capstone =3D declare_dependency(compile_args: config_host=
[&#39;CAPSTONE_CFLAGS&#39;].split(),<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0link_args: config_host[&#39;CAPSTONE_LIBS&#39;].split())<b=
r>&gt; &gt; -endif<br>&gt; &gt; =C2=A0libpmem =3D not_found<br>&gt; &gt; =
=C2=A0if &#39;CONFIG_LIBPMEM&#39; in config_host<br>&gt; &gt; =C2=A0 =C2=A0=
libpmem =3D declare_dependency(compile_args: config_host[&#39;LIBPMEM_CFLAG=
S&#39;].split(),<br>&gt; &gt; @@ -470,7 +466,6 @@ foreach k, v: config_host=
<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0config_host_data.set(k, v =3D=3D &#39;y&#=
39; ? 1 : v)<br>&gt; &gt; =C2=A0 =C2=A0endif<br>&gt; &gt; =C2=A0endforeach<=
br>&gt; &gt; -genh +=3D configure_file(output: &#39;config-host.h&#39;, con=
figuration: config_host_data)<br>&gt; &gt; <br>&gt; &gt; =C2=A0minikconf =
=3D find_program(&#39;scripts/minikconf.py&#39;)<br>&gt; &gt; =C2=A0config_=
all_devices =3D {}<br>&gt; &gt; @@ -610,6 +605,108 @@ config_all +=3D {<br>=
&gt; &gt; =C2=A0 =C2=A0&#39;CONFIG_ALL&#39;: true,<br>&gt; &gt; =C2=A0}<br>=
&gt; &gt; <br>&gt; &gt; +# Submodules<br>&gt; &gt; +<br>&gt; &gt; +capstone=
 =3D not_found<br>&gt; &gt; +capstone_opt =3D get_option(&#39;capstone&#39;=
)<br>&gt; &gt; +if capstone_opt =3D=3D &#39;no&#39;<br>&gt; &gt; + =C2=A0ca=
pstone_opt =3D false<br>&gt; &gt; +elif capstone_opt in [&#39;yes&#39;, &#3=
9;auto&#39;, &#39;system&#39;]<br>&gt; &gt; + =C2=A0have_internal =3D fs.ex=
ists(&#39;capstone/Makefile&#39;)<br>&gt; &gt; + =C2=A0capstone =3D depende=
ncy(&#39;capstone&#39;, static: enable_static,<br>&gt; &gt; + =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0requi=
red: capstone_opt =3D=3D &#39;system&#39; or<br>&gt; &gt; + =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0capstone_opt =3D=3D &#39;yes&#39; and not ha=
ve_internal)<br>&gt; &gt; + =C2=A0if capstone.found()<br>&gt; &gt; + =C2=A0=
 =C2=A0capstone_opt =3D &#39;system&#39;<br>&gt; &gt; + =C2=A0elif have_int=
ernal<br>&gt; &gt; + =C2=A0 =C2=A0capstone_opt =3D &#39;internal&#39;<br>&g=
t; &gt; + =C2=A0else<br>&gt; &gt; + =C2=A0 =C2=A0capstone_opt =3D false<br>=
&gt; &gt; + =C2=A0endif<br>&gt; &gt; +endif<br>&gt; &gt; +if capstone_opt =
=3D=3D &#39;internal&#39;<br>&gt; &gt; + =C2=A0capstone_data =3D configurat=
ion_data()<br>&gt; &gt; + =C2=A0capstone_data.set(&#39;CAPSTONE_USE_SYS_DYN=
_MEM&#39;, &#39;1&#39;)<br>&gt; &gt; +<br>&gt; &gt; + =C2=A0capstone_files =
=3D files(<br>&gt; &gt; + =C2=A0 =C2=A0&#39;capstone/cs.c&#39;,<br>&gt; &gt=
; + =C2=A0 =C2=A0&#39;capstone/MCInst.c&#39;,<br>&gt; &gt; + =C2=A0 =C2=A0&=
#39;capstone/MCInstrDesc.c&#39;,<br>&gt; &gt; + =C2=A0 =C2=A0&#39;capstone/=
MCRegisterInfo.c&#39;,<br>&gt; &gt; + =C2=A0 =C2=A0&#39;capstone/SStream.c&=
#39;,<br>&gt; &gt; + =C2=A0 =C2=A0&#39;capstone/utils.c&#39;<br>&gt; &gt; +=
 =C2=A0)<br>&gt; &gt; +<br>&gt; &gt; + =C2=A0if &#39;CONFIG_ARM_DIS&#39; in=
 config_all_disas<br>&gt; &gt; + =C2=A0 =C2=A0capstone_data.set(&#39;CAPSTO=
NE_HAS_ARM&#39;, &#39;1&#39;)<br>&gt; &gt; + =C2=A0 =C2=A0capstone_files +=
=3D files(<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0&#39;capstone/arch/ARM/ARMDis=
assembler.c&#39;,<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0&#39;capstone/arch/ARM=
/ARMInstPrinter.c&#39;,<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0&#39;capstone/ar=
ch/ARM/ARMMapping.c&#39;,<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0&#39;capstone/=
arch/ARM/ARMModule.c&#39;<br>&gt; &gt; + =C2=A0 =C2=A0)<br>&gt; &gt; + =C2=
=A0endif<br>&gt; &gt; +<br>&gt; &gt; + =C2=A0# FIXME: This config entry cur=
rently depends on a c++ compiler.<br>&gt; &gt; + =C2=A0# Which is needed fo=
r building libvixl, but not for capstone.<br>&gt; &gt; + =C2=A0if &#39;CONF=
IG_ARM_A64_DIS&#39; in config_all_disas<br>&gt; &gt; + =C2=A0 =C2=A0capston=
e_data.set(&#39;CAPSTONE_HAS_ARM64&#39;, &#39;1&#39;)<br>&gt; &gt; + =C2=A0=
 =C2=A0capstone_files +=3D files(<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0&#39;c=
apstone/arch/AArch64/AArch64BaseInfo.c&#39;,<br>&gt; &gt; + =C2=A0 =C2=A0 =
=C2=A0&#39;capstone/arch/AArch64/AArch64Disassembler.c&#39;,<br>&gt; &gt; +=
 =C2=A0 =C2=A0 =C2=A0&#39;capstone/arch/AArch64/AArch64InstPrinter.c&#39;,<=
br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0&#39;capstone/arch/AArch64/AArch64Mappin=
g.c&#39;,<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0&#39;capstone/arch/AArch64/AAr=
ch64Module.c&#39;<br>&gt; &gt; + =C2=A0 =C2=A0)<br>&gt; &gt; + =C2=A0endif<=
br>&gt; &gt; +<br>&gt; &gt; + =C2=A0if &#39;CONFIG_PPC_DIS&#39; in config_a=
ll_disas<br>&gt; &gt; + =C2=A0 =C2=A0capstone_data.set(&#39;CAPSTONE_HAS_PO=
WERPC&#39;, &#39;1&#39;)<br>&gt; &gt; + =C2=A0 =C2=A0capstone_files +=3D fi=
les(<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0&#39;capstone/arch/PowerPC/PPCDisas=
sembler.c&#39;,<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0&#39;capstone/arch/Power=
PC/PPCInstPrinter.c&#39;,<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0&#39;capstone/=
arch/PowerPC/PPCMapping.c&#39;,<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0&#39;cap=
stone/arch/PowerPC/PPCModule.c&#39;<br>&gt; &gt; + =C2=A0 =C2=A0)<br>&gt; &=
gt; + =C2=A0endif<br>&gt; &gt; +<br>&gt; &gt; + =C2=A0if &#39;CONFIG_I386_D=
IS&#39; in config_all_disas<br>&gt; &gt; + =C2=A0 =C2=A0capstone_data.set(&=
#39;CAPSTONE_HAS_X86&#39;, 1)<br>&gt; &gt; + =C2=A0 =C2=A0capstone_files +=
=3D files(<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0&#39;capstone/arch/X86/X86Dis=
assembler.c&#39;,<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0&#39;capstone/arch/X86=
/X86DisassemblerDecoder.c&#39;,<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0&#39;cap=
stone/arch/X86/X86ATTInstPrinter.c&#39;,<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=
=A0&#39;capstone/arch/X86/X86IntelInstPrinter.c&#39;,<br>&gt; &gt; + =C2=A0=
 =C2=A0 =C2=A0&#39;capstone/arch/X86/X86Mapping.c&#39;,<br>&gt; &gt; + =C2=
=A0 =C2=A0 =C2=A0&#39;capstone/arch/X86/X86Module.c&#39;<br>&gt; &gt; + =C2=
=A0 =C2=A0)<br>&gt; &gt; + =C2=A0endif<br>&gt; &gt; +<br>&gt; &gt; + =C2=A0=
configure_file(output: &#39;capstone-defs.h&#39;, configuration: capstone_d=
ata)<br>&gt; &gt; +<br>&gt; &gt; + =C2=A0capstone_cargs =3D [<br>&gt; &gt; =
+ =C2=A0 =C2=A0# FIXME: There does not seem to be a way to completely repla=
ce the c_args<br>&gt; &gt; + =C2=A0 =C2=A0# that come from add_project_argu=
ments() -- we can only add to them.<br>&gt; &gt; + =C2=A0 =C2=A0# So: disab=
le all warnings with a big hammer.<br>&gt; &gt; + =C2=A0 =C2=A0&#39;-Wno-er=
ror&#39;, &#39;-w&#39;,<br>&gt; &gt; +<br>&gt; &gt; + =C2=A0 =C2=A0# Includ=
e all configuration defines via a header file, which will wind up<br>&gt; &=
gt; + =C2=A0 =C2=A0# as a dependency on the object file, and thus changes h=
ere will result<br>&gt; &gt; + =C2=A0 =C2=A0# in a rebuild.<br>&gt; &gt; + =
=C2=A0 =C2=A0&#39;-include&#39;, &#39;capstone-defs.h&#39;<br>&gt; &gt; + =
=C2=A0]<br>&gt; &gt; +<br>&gt; &gt; + =C2=A0libcapstone =3D static_library(=
&#39;capstone&#39;,<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sources:=
 capstone_files,<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 c_args: caps=
tone_cargs,<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 include_directorie=
s: &#39;capstone/include&#39;)<br>&gt; &gt; + =C2=A0capstone =3D declare_de=
pendency(link_with: libcapstone,<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0include_directories: &#39;capstone/include&#39;)<br>&gt; &gt; +en=
dif<br>&gt; &gt; +config_host_data.set(&#39;CONFIG_CAPSTONE&#39;, capstone.=
found())<br>&gt; &gt; +<br>&gt; &gt; +genh +=3D configure_file(output: &#39=
;config-host.h&#39;, configuration: config_host_data)<br>&gt; &gt; +<br>&gt=
; &gt; =C2=A0# Generators<br>&gt; &gt; <br>&gt; &gt; =C2=A0hxtool =3D find_=
program(&#39;scripts/hxtool&#39;)<br>&gt; &gt; @@ -1512,7 +1609,7 @@ summar=
y_info +=3D {&#39;vvfat support&#39;: =C2=A0 =C2=A0 config_host.has_key(&#3=
9;CONFIG_VVFAT&#39;)}<br>&gt; &gt; =C2=A0summary_info +=3D {&#39;qed suppor=
t&#39;: =C2=A0 =C2=A0 =C2=A0 config_host.has_key(&#39;CONFIG_QED&#39;)}<br>=
&gt; &gt; =C2=A0summary_info +=3D {&#39;parallels support&#39;: config_host=
.has_key(&#39;CONFIG_PARALLELS&#39;)}<br>&gt; &gt; =C2=A0summary_info +=3D =
{&#39;sheepdog support&#39;: =C2=A0config_host.has_key(&#39;CONFIG_SHEEPDOG=
&#39;)}<br>&gt; &gt; -summary_info +=3D {&#39;capstone&#39;: =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0config_host.has_key(&#39;CONFIG_CAPSTONE&#39;)}<br>&gt;=
 &gt; +summary_info +=3D {&#39;capstone&#39;: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0capstone_opt}<br>&gt; &gt; =C2=A0summary_info +=3D {&#39;libpmem supp=
ort&#39;: =C2=A0 config_host.has_key(&#39;CONFIG_LIBPMEM&#39;)}<br>&gt; &gt=
; =C2=A0summary_info +=3D {&#39;libdaxctl support&#39;: config_host.has_key=
(&#39;CONFIG_LIBDAXCTL&#39;)}<br>&gt; &gt; =C2=A0summary_info +=3D {&#39;li=
budev&#39;: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 config_host.has_key(&#39;CON=
FIG_LIBUDEV&#39;)}<br>&gt; &gt; diff --git a/meson_options.txt b/meson_opti=
ons.txt<br>&gt; &gt; index 543cf70043..e650a937e7 100644<br>&gt; &gt; --- a=
/meson_options.txt<br>&gt; &gt; +++ b/meson_options.txt<br>&gt; &gt; @@ -22=
,3 +22,7 @@ option(&#39;vnc_sasl&#39;, type : &#39;feature&#39;, value : &#=
39;auto&#39;,<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 description: &#39;SA=
SL authentication for VNC server&#39;)<br>&gt; &gt; =C2=A0option(&#39;xkbco=
mmon&#39;, type : &#39;feature&#39;, value : &#39;auto&#39;,<br>&gt; &gt; =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 description: &#39;xkbcommon support&#39;)<br>&g=
t; &gt; +<br>&gt; &gt; +option(&#39;capstone&#39;, type: &#39;combo&#39;, v=
alue: &#39;auto&#39;,<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 choices: [&#39;no=
&#39;, &#39;yes&#39;, &#39;auto&#39;, &#39;system&#39;, &#39;internal&#39;]=
,<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 description: &#39;Whether and how to =
find the capstone library&#39;)<br>&gt; &gt;<br>&gt;<br>&gt;<div>I also hav=
e a question that how about convert</div><div>=C2=A0 --disable-capstone) ca=
pstone=3D&quot;no&quot;<br>=C2=A0 ;;<br>=C2=A0 --enable-capstone) capstone=
=3D&quot;yes&quot;<br>=C2=A0 ;;</div><div>to=C2=A0</div><div>=C2=A0 =C2=A0 =
--disable-capstone) capstone=3D&quot;disabled&quot;<br>=C2=A0 ;;<br>=C2=A0 =
--enable-capstone) capstone=3D&quot;enabled&quot;<br>=C2=A0 ;;</div><div><b=
r></div><div>for consistence with meson<br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br=
>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo</div></div>

--0000000000008f21fa05af927ddc--

