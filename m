Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 581E9C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 18:06:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A21720657
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 18:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aVGYFjf3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A21720657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZeik-0006FY-9I
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 14:06:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jZehy-0005TD-Jb
 for qemu-devel@nongnu.org; Fri, 15 May 2020 14:05:18 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:35934)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jZehw-0002VS-UI
 for qemu-devel@nongnu.org; Fri, 15 May 2020 14:05:17 -0400
Received: by mail-lj1-x241.google.com with SMTP id u15so3218855ljd.3
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 11:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ayGdfgOFftiXTLtBHQBT4WHs8Wd8Y25/NfLF3aAbGZM=;
 b=aVGYFjf3eY7lQsYrcBC7U1epMoWAEy5R/8K8f01ljircfA/1EICkgQwlTdiprPKGDN
 rI2NHgJTNeUDXBBh3UsjgJoKD35JF/mJUUgWXqtd7Vb2KTMqbOGx6X3lHg1tT5cSX2Ob
 DK9EWOFLcVC3am86lbUD8NUQ53XIK/IqAhvUeKHpfuOENgDbg+JlxNuEoSmHa+xFyP3P
 Pxtp/lNx4m3ayfcvrUz4hYEvFrkpCCWdVmWTqsUvRSLs2eAnrsaFdOP9QgydLdqlIbng
 3miaeaEd50M7LIZ7lcjrmt0qJPI14cPJjoBpQLn4ZOy5ealv8D8aR14GajGJcsa7nY0P
 cZiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ayGdfgOFftiXTLtBHQBT4WHs8Wd8Y25/NfLF3aAbGZM=;
 b=rHpKE76UiZ7AWV7KpzN66jibI1zQ5orrRMqIYWafqvxb9eTvaSh45FiT0r4+0NxaFB
 Vu3NMb0uf5bKX+mSa1udS9hnB4VsI88BR0OMMd9XQ/Cb+FGBc2ry5uNMTMFC552RdrmD
 t8vGfm7yyP4GUMLQ6woGU0em2U7E41sLjBuyZDKV6wji25NXd6ZQvO+tUmq/5H7usTQt
 MawQaJ27Jto9tPxF6a/dTwuk/CbFstOYwKpaD4QYPtGyBNegJ0z4MbhtnUMe6kemT+/4
 U3N2MpllwvIVz2nBZl47pGARrV+5KY9gtY/FPPXvBHE77h1kUdwD5GEroSZEMO80Dg8+
 arhA==
X-Gm-Message-State: AOAM531c4jqqmoXDZXEH54kKi7+TtA7UUnVcBi1XDzV9LdTNvLDPueYN
 xAIInvRzDNlKbWkCPi6CAdgyhqqVnnolhaVpBKdEow==
X-Google-Smtp-Source: ABdhPJzrxbuspDNB2uPI+8ezjD2JyJDdiknkoknTRKCioI9giTfHN2vT3bygP+uY6YntA5wkc9nzdI4qvL+5cH8nITw=
X-Received: by 2002:a2e:8884:: with SMTP id k4mr3116043lji.267.1589565914823; 
 Fri, 15 May 2020 11:05:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200512193340.265-1-robert.foley@linaro.org>
 <20200512193340.265-7-robert.foley@linaro.org>
 <875zcxcii5.fsf@linaro.org>
In-Reply-To: <875zcxcii5.fsf@linaro.org>
From: Robert Foley <robert.foley@linaro.org>
Date: Fri, 15 May 2020 14:05:08 -0400
Message-ID: <CAEyhzFtfAg3Sf2X6ChRz4sS=C5bDa+PAMZ7X=wLv1mpAUKtHsw@mail.gmail.com>
Subject: Re: [PATCH v6 6/9] tests/vm: Added a new script for ubuntu.aarch64.
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::241;
 envelope-from=robert.foley@linaro.org; helo=mail-lj1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Puhov <peter.puhov@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alex,

These are all good points.  I will make these changes.

Thanks & Regards,
-Rob

On Fri, 15 May 2020 at 11:42, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
>
> Robert Foley <robert.foley@linaro.org> writes:
>
> > ubuntu.aarch64 provides a script to create an Ubuntu 18.04 VM.
> > Another new file is also added aarch64vm.py, which is a module with
> > common methods used by aarch64 VMs, such as how to create the
> > flash images.
> >
> > Signed-off-by: Robert Foley <robert.foley@linaro.org>
> > Reviewed-by: Peter Puhov <peter.puhov@linaro.org>
> > ---
> >  configure                 |  16 ++++++
> >  tests/vm/Makefile.include |   8 +++
> >  tests/vm/aarch64vm.py     | 105 ++++++++++++++++++++++++++++++++++
> >  tests/vm/basevm.py        |   8 +++
> >  tests/vm/ubuntu.aarch64   | 117 ++++++++++++++++++++++++++++++++++++++
> >  5 files changed, 254 insertions(+)
> >  create mode 100644 tests/vm/aarch64vm.py
> >  create mode 100755 tests/vm/ubuntu.aarch64
> >
> > diff --git a/configure b/configure
> > index b3cf32f556..26f8561557 100755
> > --- a/configure
> > +++ b/configure
> > @@ -950,6 +950,20 @@ do
> >      fi
> >  done
> >
> > +# Check for files needed by aarch64 VMs.
> > +# Allow user to override the path for efi also.
> > +qemu_efi_aarch64=3D
> > +for fd in $QEMU_EFI_PATH /usr/share/qemu-efi-aarch64/QEMU_EFI.fd
> > +do
>
> I don't think we should be using an unset QEMU_EFI_PATH here - we only
> really preserve the environment for compiler related things. Everything
> else we pass with an --option so in this case we need to wire in a
> --efi-aarch64.
>
> Also we now have a copy of an EFI bios in the pc-bios blobs directory so
> we could fall back to that. The minor wrinkle is something in the build
> process bunzip2's the pc-bios/edk2-aarch64-code.fd.bz2 into the build
> directory. I guess we can assume it will be there if we fail to find
> another copy with the above.
>
> > +    if has $fd
>
> The "has" test fails to fire for me as that only cares if the thing is
> executable. We can just do a -f test.
>
> > +    then
> > +        if [ -f  $fd ]; then
>
> test -f without the []'s
>
> > +            qemu_efi_aarch64=3D$fd
> > +        fi
> > +        break
>
> break the loop if we find what we are looking for.
>
> > +    fi
> > +done
> > +
> >  # Check for existence of python3 yaml, needed to
> >  # import yaml config files into vm-build.
> >  python_yaml=3D"no"
> > @@ -6588,6 +6602,7 @@ if test "$docs" !=3D "no"; then
> >      echo "sphinx-build      $sphinx_build"
> >  fi
> >  echo "genisoimage       $genisoimage"
> > +echo "qemu_efi_aarch64  $qemu_efi_aarch64"
> >  echo "python_yaml       $python_yaml"
> >  echo "slirp support     $slirp $(echo_version $slirp $slirp_version)"
> >  if test "$slirp" !=3D "no" ; then
> > @@ -7650,6 +7665,7 @@ echo "PYTHON=3D$python" >> $config_host_mak
> >  echo "SPHINX_BUILD=3D$sphinx_build" >> $config_host_mak
> >  echo "SPHINX_WERROR=3D$sphinx_werror" >> $config_host_mak
> >  echo "GENISOIMAGE=3D$genisoimage" >> $config_host_mak
> > +echo "QEMU_EFI_AARCH64=3D$qemu_efi_aarch64" >> $config_host_mak
> >  echo "PYTHON_YAML=3D$python_yaml" >> $config_host_mak
> >  echo "CC=3D$cc" >> $config_host_mak
> >  if $iasl -h > /dev/null 2>&1; then
> > diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
> > index 99c06832ac..d918d13f50 100644
> > --- a/tests/vm/Makefile.include
> > +++ b/tests/vm/Makefile.include
> > @@ -5,6 +5,9 @@
> >  IMAGES :=3D freebsd netbsd openbsd centos fedora
> >  ifneq ($(GENISOIMAGE),)
> >  IMAGES +=3D ubuntu.i386 centos
> > +ifneq ($(QEMU_EFI_AARCH64),)
> > +IMAGES +=3D ubuntu.aarch64
> > +endif
> >  endif
> >
> >  IMAGES_DIR :=3D $(HOME)/.cache/qemu-vm/images
> > @@ -23,6 +26,11 @@ vm-help vm-test:
> >  ifneq ($(GENISOIMAGE),)
> >       @echo "  vm-build-centos                 - Build QEMU in CentOS V=
M, with Docker"
> >       @echo "  vm-build-ubuntu.i386            - Build QEMU in ubuntu i=
386 VM"
> > +ifneq ($(QEMU_EFI_AARCH64),)
> > +     @echo "  vm-build-ubuntu.aarch64         - Build QEMU in ubuntu a=
arch64 VM"
> > +else
> > +     @echo "  (install qemu-efi-aarch64 to build centos/ubuntu aarch64=
 images.)"
> > +endif
> >  else
> >       @echo "  (install genisoimage to build centos/ubuntu images)"
> >  endif
> > diff --git a/tests/vm/aarch64vm.py b/tests/vm/aarch64vm.py
> > new file mode 100644
> > index 0000000000..3a9807cd43
> > --- /dev/null
> > +++ b/tests/vm/aarch64vm.py
> > @@ -0,0 +1,105 @@
> > +#!/usr/bin/env python3
> > +#
> > +# VM testing aarch64 library
> > +#
> > +# Copyright 2020 Linaro
> > +#
> > +# Authors:
> > +#  Robert Foley <robert.foley@linaro.org>
> > +#
> > +# This code is licensed under the GPL version 2 or later.  See
> > +# the COPYING file in the top-level directory.
> > +#
> > +import os
> > +import sys
> > +import subprocess
> > +import basevm
> > +from qemu.accel import kvm_available
> > +
> > +# This is the config needed for current version of QEMU.
> > +# This works for both kvm and tcg.
> > +CURRENT_CONFIG =3D {
> > +    'cpu'          : "max",
> > +    'machine'      : "virt,gic-version=3Dmax",
> > +}
> > +
> > +# The minimum minor version of QEMU we will support with aarch64 VMs i=
s 3.
> > +# QEMU versions less than 3 have various issues running these VMs.
> > +QEMU_AARCH64_MIN_VERSION =3D 3
> > +
> > +# The DEFAULT_CONFIG will default to a version of
> > +# parameters that works for backwards compatibility.
> > +DEFAULT_CONFIG =3D {'kvm' : {'cpu'          : "host",
> > +                           'machine'      : "virt,gic-version=3Dhost"}=
,
> > +                  'tcg' : {'cpu'          : "cortex-a57",
> > +                           'machine'      : "virt"},
> > +}
> > +
> > +def get_config_defaults(vmcls, default_config):
> > +    """Fetch the configuration defaults for this VM,
> > +       taking into consideration the defaults for
> > +       aarch64 first, followed by the defaults for this VM."""
> > +    config =3D default_config
> > +    config.update(aarch_get_config_defaults(vmcls))
> > +    return config
> > +
> > +def aarch_get_config_defaults(vmcls):
> > +    """Set the defaults for current version of QEMU."""
> > +    config =3D CURRENT_CONFIG
> > +    args, argv =3D basevm.parse_args(vmcls)
> > +    qemu_path =3D basevm.get_qemu_path(vmcls.arch, args.build_path)
> > +    qemu_version =3D basevm.get_qemu_version(qemu_path)
> > +    if qemu_version < QEMU_AARCH64_MIN_VERSION:
> > +        error =3D "\nThis major version of QEMU {} is to old for aarch=
64 VMs.\n"\
> > +                "The major version must be at least {}.\n"\
> > +                "To continue with the current build of QEMU, "\
> > +                "please restart with QEMU_LOCAL=3D1 .\n"
> > +        print(error.format(qemu_version, QEMU_AARCH64_MIN_VERSION))
> > +        exit(1)
> > +    if qemu_version =3D=3D QEMU_AARCH64_MIN_VERSION:
> > +        # We have an older version of QEMU,
> > +        # set the config values for backwards compatibility.
> > +        if kvm_available('aarch64'):
> > +            config.update(DEFAULT_CONFIG['kvm'])
> > +        else:
> > +            config.update(DEFAULT_CONFIG['tcg'])
> > +    return config
> > +
> > +def create_flash_images(flash_dir=3D"./"):
> > +    """Creates the appropriate pflash files
> > +       for an aarch64 VM."""
> > +    flash0_path =3D get_flash_path(flash_dir, "flash0")
> > +    flash1_path =3D get_flash_path(flash_dir, "flash1")
> > +    fd_null =3D open(os.devnull, 'w')
> > +    subprocess.check_call(["dd", "if=3D/dev/zero", "of=3D{}".format(fl=
ash0_path),
> > +                           "bs=3D1M", "count=3D64"],
> > +                           stdout=3Dfd_null, stderr=3Dsubprocess.STDOU=
T)
> > +    # A reliable way to get the QEMU EFI image is via an installed pac=
kage.
> > +    efi_img =3D "/usr/share/qemu-efi-aarch64/QEMU_EFI.fd"
> > +    if not os.path.exists(efi_img):
> > +        sys.stderr.write("*** {} is missing\n".format(efi_img))
> > +        sys.stderr.write("*** please install qemu-efi-aarch64 package\=
n")
> > +        exit(3)
>
> This is hardcoded when we have just probed for it.
>
> <snip>
>
> Otherwise it looks ok to me.
>
> --
> Alex Benn=C3=A9e

