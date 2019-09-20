Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20751C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 08:44:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69BF62070C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 08:44:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69BF62070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBEWh-000064-Iz
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 04:44:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46720)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iBEVB-0007N4-83
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 04:42:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iBEV9-0004kj-6T
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 04:42:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38414)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iBEV8-0004k1-VO
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 04:42:51 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 06A2581F01
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 08:42:50 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id j125so888039wmj.6
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 01:42:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=I99yEqVt8ErdRcPezRudbiSjiEhzxG2nkFaLU6G7TLo=;
 b=rRaLdXnQCqsg5bJVs9Sj3NOy5qzlo01sT5gkIFWj3v0IDN7qwEmMMrpMDD4vUpgEZB
 mtYmCvnoYlbzCFDIKI3JvtdBknrfFnwtoHMLbafDwiw3pl6H+YAkMkWhkzYNvdY4O4x+
 QTex3lb2A8Kjz/m2EITCxZPDoqSbOkZQtQjrVRlvtt3BFHdeAPIwTj+AZKqlMrLYBrl/
 IXvRZSeGF/xZOHPCbqVsbu23sEoR/UbJJ1OlZoYKmm14KmTaPYcGEs/PLFXK3l+EE/ca
 VVEPEk+C8JCBgX4NESNvAxUCPclhbN9xFd/8PuKHUvjMAxBcGNnSc/vm0g4VMYRE9IqR
 6z+Q==
X-Gm-Message-State: APjAAAXOYBYYOThLuPH9FSmgSK2kTv5oA7mY15BT46EJaSw/rIH6Whnd
 FzdR5brGlws7ipxXvKUgmmfjgXyVQAUifiRmRSx38Lcw7eMWu0JzlyV7Svt75LjGVlgrNNvkqQl
 +phnU7bMEpna/6Is=
X-Received: by 2002:a05:600c:1103:: with SMTP id
 b3mr2577801wma.3.1568968968721; 
 Fri, 20 Sep 2019 01:42:48 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwuKqP9EQtyWs+gmCT2jo9jKwKC29Iv4nPHGfWSOqKy+tjHCDee480IsdmMaJU88n0US4AHow==
X-Received: by 2002:a05:600c:1103:: with SMTP id
 b3mr2577783wma.3.1568968968456; 
 Fri, 20 Sep 2019 01:42:48 -0700 (PDT)
Received: from [192.168.1.40] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id o19sm1687538wro.50.2019.09.20.01.42.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Sep 2019 01:42:47 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] edk2 build scripts: work around TianoCore#1607
 without forcing Python 2
To: Laszlo Ersek <lersek@redhat.com>, qemu devel list <qemu-devel@nongnu.org>
References: <20190920083808.21399-1-lersek@redhat.com>
 <20190920083808.21399-3-lersek@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <2c2681d1-5a36-195b-312f-7757fcb89bbd@redhat.com>
Date: Fri, 20 Sep 2019 10:42:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190920083808.21399-3-lersek@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: John Snow <jsnow@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/20/19 10:38 AM, Laszlo Ersek wrote:
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
> While at it, cut short edk2's auto-detection of the python3.* minor
> version, by setting PYTHON_COMMAND to "python3" (which we expect to be
> available wherever we intend to build edk2).

Yes! This fixes it :)

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
>     v2:
>    =20
>     - set PYTHON_COMMAND to python3; update commit message [Phil]
>    =20
>     - do not pick up any feedback tags from v1 (v2 is not a trivial upd=
ate)
>    =20
>     v1:
>    =20
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
>  roms/Makefile                  |  1 +
>  tests/uefi-test-tools/Makefile |  1 +
>  roms/edk2-build.sh             |  4 ++--
>  roms/edk2-funcs.sh             | 17 +++++++++++++++++
>  tests/uefi-test-tools/build.sh |  6 ++++--
>  5 files changed, 25 insertions(+), 4 deletions(-)
>=20
> diff --git a/roms/Makefile b/roms/Makefile
> index 6cf07d3b44ee..06339efa6fc4 100644
> --- a/roms/Makefile
> +++ b/roms/Makefile
> @@ -141,6 +141,7 @@ build-efi-roms: build-pxe-roms
>  #
>  edk2-basetools:
>  	$(MAKE) -C edk2/BaseTools \
> +		PYTHON_COMMAND=3D$${EDK2_PYTHON_COMMAND:-python3} \
>  		EXTRA_OPTFLAGS=3D'$(EDK2_BASETOOLS_OPTFLAGS)' \
>  		EXTRA_LDFLAGS=3D'$(EDK2_BASETOOLS_LDFLAGS)'
> =20
> diff --git a/tests/uefi-test-tools/Makefile b/tests/uefi-test-tools/Mak=
efile
> index 7e0177d7337e..1dcddcdbbabf 100644
> --- a/tests/uefi-test-tools/Makefile
> +++ b/tests/uefi-test-tools/Makefile
> @@ -100,6 +100,7 @@ Build/bios-tables-test.%.efi: build-edk2-tools
> =20
>  build-edk2-tools:
>  	$(MAKE) -C $(edk2_dir)/BaseTools \
> +		PYTHON_COMMAND=3D$${EDK2_PYTHON_COMMAND:-python3} \
>  		EXTRA_OPTFLAGS=3D'$(EDK2_BASETOOLS_OPTFLAGS)' \
>  		EXTRA_LDFLAGS=3D'$(EDK2_BASETOOLS_LDFLAGS)'
> =20
> diff --git a/roms/edk2-build.sh b/roms/edk2-build.sh
> index 4f46f8a6a217..d5391c763728 100755
> --- a/roms/edk2-build.sh
> +++ b/roms/edk2-build.sh
> @@ -27,8 +27,7 @@ shift $num_args
> =20
>  cd edk2
> =20
> -# Work around <https://bugzilla.tianocore.org/show_bug.cgi?id=3D1607>.
> -export PYTHON_COMMAND=3Dpython2
> +export PYTHON_COMMAND=3D${EDK2_PYTHON_COMMAND:-python3}
> =20
>  # Source "edksetup.sh" carefully.
>  set +e +u +C
> @@ -43,6 +42,7 @@ fi
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
> index 8aa7935c43bb..3b78f3084069 100755
> --- a/tests/uefi-test-tools/build.sh
> +++ b/tests/uefi-test-tools/build.sh
> @@ -29,8 +29,7 @@ export PACKAGES_PATH=3D$(realpath -- "$edk2_dir")
>  export WORKSPACE=3D$PWD
>  mkdir -p Conf
> =20
> -# Work around <https://bugzilla.tianocore.org/show_bug.cgi?id=3D1607>.
> -export PYTHON_COMMAND=3Dpython2
> +export PYTHON_COMMAND=3D${EDK2_PYTHON_COMMAND:-python3}
> =20
>  # Source "edksetup.sh" carefully.
>  set +e +u +C
> @@ -46,12 +45,15 @@ fi
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

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

