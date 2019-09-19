Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DA3C4CEC4
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 13:56:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F60E21D6C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 13:56:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F60E21D6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAwvZ-0005GV-7z
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 09:56:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49629)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iAwgO-0004Hy-RD
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 09:41:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iAwgI-0003UI-Vd
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 09:41:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38160)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iAwgI-0003Sk-3x
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 09:41:10 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 45AF53C919
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 13:41:08 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id t185so1664933wmg.4
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 06:41:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JyVcq6QNd+Ibgp+/I6fPLr0QMJpfD1F2fjpsmJKmmSI=;
 b=HQWKtjS/yR+RtBIL5wGGQNJGNPj6O5ZrPBrWeg+BjMhFaJZnv3M9YWcM+97m9J6Jv2
 9/2tZF5Z9b/HcHY6iDtP5i8ejGzONR2D3n/6cWGwS7yU3cUym1g5aA2XB6f1R1Zf3ssp
 Ll5Pbtse1J79awwrfGne0W1mRupANMHuP5nBmsFZYTJoE9pPT2j3Aq5lETxBUNfE/xTT
 zx5Noy5IJ5BgANhJMZe2xoF0lL5aVZFa9jFNI4NGZjJVf9P5ly+HNbm+OaT/3rDhiHrk
 yEcXSmqE652lJscbw6dMlJWaCsasMupPRqnV8lxauN4rEOSzAtiGjwhGuo9K/VQ/DNku
 jJZw==
X-Gm-Message-State: APjAAAVm3opI/ERigL9F/c7NmJxFlJP4tkjFwkgrMogtjGB0W2Rzepzd
 kcTg5dnunDsQKZuqCpEjvKuoc4KB+Fe1myec2nwD0hwxSgzPSTsVSrMagabiUgqR1dbEjb34zRU
 l7HXa8VSO5gYNu3U=
X-Received: by 2002:a1c:4946:: with SMTP id w67mr2918589wma.131.1568900467013; 
 Thu, 19 Sep 2019 06:41:07 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy5Y29PcwfKZJJY6v6ootWBFyNiz3SHmYG+J0Ro2QS6awZvyaNnAqKMC3eBB5VZufbmfPboUg==
X-Received: by 2002:a1c:4946:: with SMTP id w67mr2918573wma.131.1568900466745; 
 Thu, 19 Sep 2019 06:41:06 -0700 (PDT)
Received: from [192.168.1.115] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id c132sm8095513wme.27.2019.09.19.06.41.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Sep 2019 06:41:06 -0700 (PDT)
To: Laszlo Ersek <lersek@redhat.com>, qemu devel list <qemu-devel@nongnu.org>
References: <20190918171141.15957-1-lersek@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <f2cf7004-5bc0-93ad-fe09-2bb6cfbbe116@redhat.com>
Date: Thu, 19 Sep 2019 15:41:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190918171141.15957-1-lersek@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] edk2 build scripts: work around
 TianoCore#1607 without forcing Python 2
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Laszlo,

On 9/18/19 7:11 PM, Laszlo Ersek wrote:
> It turns out that forcing python2 for running the edk2 "build" utility =
is
> neither necessary nor sufficient.
>=20
> Forcing python2 is not sufficient for two reasons:
>=20
> - QEMU is moving away from python2, with python2 nearing EOL,
>=20
> - according to my most recent testing, the lacking dependency informati=
on
>   in the makefiles that are generated by edk2's "build" utility can cau=
se
>   parallel build failures even when "build" is executed by python2.
>=20
> And forcing python2 is not necessary because we can still return to the
> original idea of filtering out jobserver-related options from MAKEFLAGS=
.
> So do that.
>=20
> With this patch, the guest UEFI binaries that are used as part of the B=
IOS
> tables test, and the OVMF and ArmVirtQemu platform firmwares, will be
> built strictly in a single job, regardless of an outermost "-jN" make
> option. Alas, there appears to be no reliable way to build edk2 in an
> (outer make, inner make) environment, with a jobserver enabled.
>=20
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: John Snow <jsnow@redhat.com>
> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reported-by: John Snow <jsnow@redhat.com>
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> ---
>=20
> Notes:
>     - Tested on RHEL7 (where the outer "make" sets the old-style
>       "--jobserver-fds" flag) and on Fedora 29 (where the outer "make" =
sets
>       the new-style "--jobserver-auth" flag).
>    =20
>     - I've rebuilt all the edk2 binaries with this patch applied. Every=
thing
>       works fine. However, if you test this patch, you might notice tha=
t git
>       reports all the build products as modified. That's because when u=
sing
>       the python3 code in edk2 BaseTools, the generated makefiles diffe=
r
>       greatly from the ones generated when running in python2 mode (e.g=
. due
>       to different random seeds in python hashes / dictionaries). As a
>       result, parts of the firmware volumes / firmware filesystems coul=
d
>       appear in a different order than before. This is harmless, and do=
esn't
>       necessitate checking in the rebuilt binaries.
>=20
>  roms/edk2-build.sh             |  4 +---
>  roms/edk2-funcs.sh             | 17 +++++++++++++++++
>  tests/uefi-test-tools/build.sh |  6 +++---
>  3 files changed, 21 insertions(+), 6 deletions(-)
>=20
> diff --git a/roms/edk2-build.sh b/roms/edk2-build.sh
> index 4f46f8a6a217..8161c55ef507 100755
> --- a/roms/edk2-build.sh
> +++ b/roms/edk2-build.sh
> @@ -27,9 +27,6 @@ shift $num_args
> =20
>  cd edk2
> =20
> -# Work around <https://bugzilla.tianocore.org/show_bug.cgi?id=3D1607>.
> -export PYTHON_COMMAND=3Dpython2
> -
>  # Source "edksetup.sh" carefully.
>  set +e +u +C
>  source ./edksetup.sh
> @@ -43,6 +40,7 @@ fi
>  # any), for the edk2 "build" utility.
>  source ../edk2-funcs.sh
>  edk2_toolchain=3D$(qemu_edk2_get_toolchain "$emulation_target")
> +MAKEFLAGS=3D$(qemu_edk2_quirk_tianocore_1607 "$MAKEFLAGS")
>  edk2_thread_count=3D$(qemu_edk2_get_thread_count "$MAKEFLAGS")
>  qemu_edk2_set_cross_env "$emulation_target"
> =20
> diff --git a/roms/edk2-funcs.sh b/roms/edk2-funcs.sh
> index a9fae7ee891b..3f4485b201f1 100644
> --- a/roms/edk2-funcs.sh
> +++ b/roms/edk2-funcs.sh
> @@ -251,3 +251,20 @@ qemu_edk2_get_thread_count()
>      printf '1\n'
>    fi
>  }
> +
> +
> +# Work around <https://bugzilla.tianocore.org/show_bug.cgi?id=3D1607> =
by
> +# filtering jobserver-related flags out of MAKEFLAGS. Print the result=
 to the
> +# standard output.
> +#
> +# Parameters:
> +#   $1: the value of the MAKEFLAGS variable
> +qemu_edk2_quirk_tianocore_1607()
> +{
> +  local makeflags=3D"$1"
> +
> +  printf %s "$makeflags" \
> +  | LC_ALL=3DC sed --regexp-extended \
> +      --expression=3D's/--jobserver-(auth|fds)=3D[0-9]+,[0-9]+//' \
> +      --expression=3D's/-j([0-9]+)?//'
> +}
> diff --git a/tests/uefi-test-tools/build.sh b/tests/uefi-test-tools/bui=
ld.sh
> index 8aa7935c43bb..eba7964a163b 100755
> --- a/tests/uefi-test-tools/build.sh
> +++ b/tests/uefi-test-tools/build.sh
> @@ -29,9 +29,6 @@ export PACKAGES_PATH=3D$(realpath -- "$edk2_dir")
>  export WORKSPACE=3D$PWD
>  mkdir -p Conf
> =20
> -# Work around <https://bugzilla.tianocore.org/show_bug.cgi?id=3D1607>.
> -export PYTHON_COMMAND=3Dpython2
> -
>  # Source "edksetup.sh" carefully.
>  set +e +u +C
>  source "$PACKAGES_PATH/edksetup.sh"
> @@ -46,12 +43,15 @@ fi
>  source "$edk2_dir/../edk2-funcs.sh"
>  edk2_arch=3D$(qemu_edk2_get_arch "$emulation_target")
>  edk2_toolchain=3D$(qemu_edk2_get_toolchain "$emulation_target")
> +MAKEFLAGS=3D$(qemu_edk2_quirk_tianocore_1607 "$MAKEFLAGS")
> +edk2_thread_count=3D$(qemu_edk2_get_thread_count "$MAKEFLAGS")
>  qemu_edk2_set_cross_env "$emulation_target"
> =20
>  # Build the UEFI binary
>  mkdir -p log
>  build \
>    --arch=3D"$edk2_arch" \
> +  -n "$edk2_thread_count" \
>    --buildtarget=3DDEBUG \
>    --platform=3DUefiTestToolsPkg/UefiTestToolsPkg.dsc \
>    --tagname=3D"$edk2_toolchain" \
>=20

Very clear explanation, thanks.
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Hmm this failed on Ubuntu Xenial which is the image we use for Travis-CI:

$ lsb_release -a
Distributor ID:	Ubuntu
Description:	Ubuntu 16.04.6 LTS
Release:	16.04
Codename:	xenial

make -f Makefile.edk2
make[1]: Entering directory '/home/phil/qemu/roms'
if test -d edk2/.git; then \
	cd edk2 && git submodule update --init --force; \
fi
./edk2-build.sh \
	aarch64 \
	--arch=3DAARCH64 \
	--platform=3DArmVirtPkg/ArmVirtQemu.dsc \
	-D NETWORK_IP6_ENABLE \
	-D NETWORK_HTTP_BOOT_ENABLE
WORKSPACE: /home/phil/qemu/roms/edk2
EDK_TOOLS_PATH: /home/phil/qemu/roms/edk2/BaseTools
CONF_PATH: /home/phil/qemu/roms/edk2/Conf
Copying $EDK_TOOLS_PATH/Conf/build_rule.template
     to /home/phil/qemu/roms/edk2/Conf/build_rule.txt
Copying $EDK_TOOLS_PATH/Conf/tools_def.template
     to /home/phil/qemu/roms/edk2/Conf/tools_def.txt
Copying $EDK_TOOLS_PATH/Conf/target.template
     to /home/phil/qemu/roms/edk2/Conf/target.txt
pyenv: python3.7: command not found
The `python3.7' command exists in these Python versions:
  3.7
  3.7.1

Makefile.edk2:62: recipe for target '../pc-bios/edk2-aarch64-code.fd' fai=
led
make[1]: *** [../pc-bios/edk2-aarch64-code.fd] Error 127
make[1]: Leaving directory '/home/phil/qemu/roms'
Makefile:168: recipe for target 'efi' failed
make: *** [efi] Error 2
make: Leaving directory '/home/phil/qemu/roms'
The command "make -C roms efi -j2" exited with 2.

The local Python3 version is:

$ apt-cache show python3-minimal
Package: python3-minimal
Version: 3.5.1-3

Any idea which script is choosing python3.7?

