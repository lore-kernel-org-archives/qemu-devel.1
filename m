Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E2FC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 15:42:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B928320758
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 15:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aEJedTaO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B928320758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZcU8-00008k-Qn
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 11:42:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55116)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jZcTX-0007x1-Cr
 for qemu-devel@nongnu.org; Fri, 15 May 2020 11:42:15 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51573)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jZcTV-0002Zx-Vx
 for qemu-devel@nongnu.org; Fri, 15 May 2020 11:42:14 -0400
Received: by mail-wm1-x343.google.com with SMTP id f134so2788516wmf.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 08:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=TOsGu1n88otRBjtf03J3YURYDRLP57XepJqatqOvL4Y=;
 b=aEJedTaOKSE5uVoPg0Pjyj+SM4q7eOEblMq4FFRJIHqlB7fHtna16slyzY33EBcAkL
 ju1N6q8mNfYYSyo65GAJJIcNRzV931BM/DgGMCMOz4y6VTi+nTPvjZ2wdS8MlQwJioo+
 14QY0boF+kOQNz0J9gHQ5hsj//IZWj+phJgpxgLy1aoqrRjqkZARDA3S0U8B6lvkRM5w
 eggqnzMwxWtipe+ZV9H9FvCw9kFQMwRz1EGMuj0lILPc1rl6hvwpoDfUsE93STwPqtnA
 olNJqc+ixsF79UByRAN49wMS+19UbrYqzzVRxMIyMv3c+SslF2JkvRnP2JCJtPW82ftQ
 6UzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=TOsGu1n88otRBjtf03J3YURYDRLP57XepJqatqOvL4Y=;
 b=PAiFlkpkFOU+edZSSuhcSDRflHtZquLUfYW+Ww6KzAwShBHr0Qu1Zl1PoAHLLy+HkV
 xEdkPDBYvT8v2RSTiirtfEBoiiZG2zj+hLPylzMtP1R7aU8wXzO9NARQguNa0Uc/cZbw
 eb4iYYTzx5d0HwJiUGMUnnvUtfwbTY1KPa8LeTDywqwQe86lEuFNEnY6gTwyOLY5TTXL
 SY6CLJmpXt3uObYUCw8oQVaYFSJk/Ru7xOv36zGzVjfLZ1Ik3B2KlcDGO4Sd9VbVTpsL
 ldZ/i/A1jVtfptYw4d9Ehbd8fQM4bx+KB+493VxjDIjV6e5WOvUSaV+doSECrkyYCh+N
 6pZg==
X-Gm-Message-State: AOAM530uRAdusxu061gyphdb6njmxRM2Pbr1Y3D+HG8ZsQWC+6SYAkjp
 XKSDgSqiJJuxPDSEx0qOnGfv9w==
X-Google-Smtp-Source: ABdhPJzcGwOPlF6tYMW6pDxwvfIwenfivx2+MSk7T3SjDfgbftS3bRG9e6b+5vWRno7TTctrWT6GEw==
X-Received: by 2002:a1c:6245:: with SMTP id w66mr4785523wmb.33.1589557332123; 
 Fri, 15 May 2020 08:42:12 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id m6sm3964428wrq.5.2020.05.15.08.42.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2020 08:42:10 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1C63A1FF7E;
 Fri, 15 May 2020 16:42:10 +0100 (BST)
References: <20200512193340.265-1-robert.foley@linaro.org>
 <20200512193340.265-7-robert.foley@linaro.org>
User-agent: mu4e 1.4.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH v6 6/9] tests/vm: Added a new script for ubuntu.aarch64.
In-reply-to: <20200512193340.265-7-robert.foley@linaro.org>
Date: Fri, 15 May 2020 16:42:10 +0100
Message-ID: <875zcxcii5.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
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
Cc: peter.puhov@linaro.org, philmd@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Robert Foley <robert.foley@linaro.org> writes:

> ubuntu.aarch64 provides a script to create an Ubuntu 18.04 VM.
> Another new file is also added aarch64vm.py, which is a module with
> common methods used by aarch64 VMs, such as how to create the
> flash images.
>
> Signed-off-by: Robert Foley <robert.foley@linaro.org>
> Reviewed-by: Peter Puhov <peter.puhov@linaro.org>
> ---
>  configure                 |  16 ++++++
>  tests/vm/Makefile.include |   8 +++
>  tests/vm/aarch64vm.py     | 105 ++++++++++++++++++++++++++++++++++
>  tests/vm/basevm.py        |   8 +++
>  tests/vm/ubuntu.aarch64   | 117 ++++++++++++++++++++++++++++++++++++++
>  5 files changed, 254 insertions(+)
>  create mode 100644 tests/vm/aarch64vm.py
>  create mode 100755 tests/vm/ubuntu.aarch64
>
> diff --git a/configure b/configure
> index b3cf32f556..26f8561557 100755
> --- a/configure
> +++ b/configure
> @@ -950,6 +950,20 @@ do
>      fi
>  done
>=20=20
> +# Check for files needed by aarch64 VMs.
> +# Allow user to override the path for efi also.
> +qemu_efi_aarch64=3D
> +for fd in $QEMU_EFI_PATH /usr/share/qemu-efi-aarch64/QEMU_EFI.fd
> +do

I don't think we should be using an unset QEMU_EFI_PATH here - we only
really preserve the environment for compiler related things. Everything
else we pass with an --option so in this case we need to wire in a
--efi-aarch64.

Also we now have a copy of an EFI bios in the pc-bios blobs directory so
we could fall back to that. The minor wrinkle is something in the build
process bunzip2's the pc-bios/edk2-aarch64-code.fd.bz2 into the build
directory. I guess we can assume it will be there if we fail to find
another copy with the above.

> +    if has $fd

The "has" test fails to fire for me as that only cares if the thing is
executable. We can just do a -f test.

> +    then
> +        if [ -f  $fd ]; then

test -f without the []'s

> +            qemu_efi_aarch64=3D$fd
> +        fi
> +        break

break the loop if we find what we are looking for.

> +    fi
> +done
> +
>  # Check for existence of python3 yaml, needed to
>  # import yaml config files into vm-build.
>  python_yaml=3D"no"
> @@ -6588,6 +6602,7 @@ if test "$docs" !=3D "no"; then
>      echo "sphinx-build      $sphinx_build"
>  fi
>  echo "genisoimage       $genisoimage"
> +echo "qemu_efi_aarch64  $qemu_efi_aarch64"
>  echo "python_yaml       $python_yaml"
>  echo "slirp support     $slirp $(echo_version $slirp $slirp_version)"
>  if test "$slirp" !=3D "no" ; then
> @@ -7650,6 +7665,7 @@ echo "PYTHON=3D$python" >> $config_host_mak
>  echo "SPHINX_BUILD=3D$sphinx_build" >> $config_host_mak
>  echo "SPHINX_WERROR=3D$sphinx_werror" >> $config_host_mak
>  echo "GENISOIMAGE=3D$genisoimage" >> $config_host_mak
> +echo "QEMU_EFI_AARCH64=3D$qemu_efi_aarch64" >> $config_host_mak
>  echo "PYTHON_YAML=3D$python_yaml" >> $config_host_mak
>  echo "CC=3D$cc" >> $config_host_mak
>  if $iasl -h > /dev/null 2>&1; then
> diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
> index 99c06832ac..d918d13f50 100644
> --- a/tests/vm/Makefile.include
> +++ b/tests/vm/Makefile.include
> @@ -5,6 +5,9 @@
>  IMAGES :=3D freebsd netbsd openbsd centos fedora
>  ifneq ($(GENISOIMAGE),)
>  IMAGES +=3D ubuntu.i386 centos
> +ifneq ($(QEMU_EFI_AARCH64),)
> +IMAGES +=3D ubuntu.aarch64
> +endif
>  endif
>=20=20
>  IMAGES_DIR :=3D $(HOME)/.cache/qemu-vm/images
> @@ -23,6 +26,11 @@ vm-help vm-test:
>  ifneq ($(GENISOIMAGE),)
>  	@echo "  vm-build-centos                 - Build QEMU in CentOS VM, wit=
h Docker"
>  	@echo "  vm-build-ubuntu.i386            - Build QEMU in ubuntu i386 VM"
> +ifneq ($(QEMU_EFI_AARCH64),)
> +	@echo "  vm-build-ubuntu.aarch64         - Build QEMU in ubuntu aarch64=
 VM"
> +else
> +	@echo "  (install qemu-efi-aarch64 to build centos/ubuntu aarch64 image=
s.)"
> +endif
>  else
>  	@echo "  (install genisoimage to build centos/ubuntu images)"
>  endif
> diff --git a/tests/vm/aarch64vm.py b/tests/vm/aarch64vm.py
> new file mode 100644
> index 0000000000..3a9807cd43
> --- /dev/null
> +++ b/tests/vm/aarch64vm.py
> @@ -0,0 +1,105 @@
> +#!/usr/bin/env python3
> +#
> +# VM testing aarch64 library
> +#
> +# Copyright 2020 Linaro
> +#
> +# Authors:
> +#  Robert Foley <robert.foley@linaro.org>
> +#
> +# This code is licensed under the GPL version 2 or later.  See
> +# the COPYING file in the top-level directory.
> +#
> +import os
> +import sys
> +import subprocess
> +import basevm
> +from qemu.accel import kvm_available
> +
> +# This is the config needed for current version of QEMU.
> +# This works for both kvm and tcg.
> +CURRENT_CONFIG =3D {
> +    'cpu'          : "max",
> +    'machine'      : "virt,gic-version=3Dmax",
> +}
> +
> +# The minimum minor version of QEMU we will support with aarch64 VMs is =
3.
> +# QEMU versions less than 3 have various issues running these VMs.
> +QEMU_AARCH64_MIN_VERSION =3D 3
> +
> +# The DEFAULT_CONFIG will default to a version of
> +# parameters that works for backwards compatibility.
> +DEFAULT_CONFIG =3D {'kvm' : {'cpu'          : "host",
> +                           'machine'      : "virt,gic-version=3Dhost"},
> +                  'tcg' : {'cpu'          : "cortex-a57",
> +                           'machine'      : "virt"},
> +}
> +
> +def get_config_defaults(vmcls, default_config):
> +    """Fetch the configuration defaults for this VM,
> +       taking into consideration the defaults for
> +       aarch64 first, followed by the defaults for this VM."""
> +    config =3D default_config
> +    config.update(aarch_get_config_defaults(vmcls))
> +    return config
> +
> +def aarch_get_config_defaults(vmcls):
> +    """Set the defaults for current version of QEMU."""
> +    config =3D CURRENT_CONFIG
> +    args, argv =3D basevm.parse_args(vmcls)
> +    qemu_path =3D basevm.get_qemu_path(vmcls.arch, args.build_path)
> +    qemu_version =3D basevm.get_qemu_version(qemu_path)
> +    if qemu_version < QEMU_AARCH64_MIN_VERSION:
> +        error =3D "\nThis major version of QEMU {} is to old for aarch64=
 VMs.\n"\
> +                "The major version must be at least {}.\n"\
> +                "To continue with the current build of QEMU, "\
> +                "please restart with QEMU_LOCAL=3D1 .\n"
> +        print(error.format(qemu_version, QEMU_AARCH64_MIN_VERSION))
> +        exit(1)
> +    if qemu_version =3D=3D QEMU_AARCH64_MIN_VERSION:
> +        # We have an older version of QEMU,
> +        # set the config values for backwards compatibility.
> +        if kvm_available('aarch64'):
> +            config.update(DEFAULT_CONFIG['kvm'])
> +        else:
> +            config.update(DEFAULT_CONFIG['tcg'])
> +    return config
> +
> +def create_flash_images(flash_dir=3D"./"):
> +    """Creates the appropriate pflash files
> +       for an aarch64 VM."""
> +    flash0_path =3D get_flash_path(flash_dir, "flash0")
> +    flash1_path =3D get_flash_path(flash_dir, "flash1")
> +    fd_null =3D open(os.devnull, 'w')
> +    subprocess.check_call(["dd", "if=3D/dev/zero", "of=3D{}".format(flas=
h0_path),
> +                           "bs=3D1M", "count=3D64"],
> +                           stdout=3Dfd_null, stderr=3Dsubprocess.STDOUT)
> +    # A reliable way to get the QEMU EFI image is via an installed packa=
ge.
> +    efi_img =3D "/usr/share/qemu-efi-aarch64/QEMU_EFI.fd"
> +    if not os.path.exists(efi_img):
> +        sys.stderr.write("*** {} is missing\n".format(efi_img))
> +        sys.stderr.write("*** please install qemu-efi-aarch64 package\n")
> +        exit(3)

This is hardcoded when we have just probed for it.

<snip>

Otherwise it looks ok to me.

--=20
Alex Benn=C3=A9e

