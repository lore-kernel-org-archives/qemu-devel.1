Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D417C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 14:00:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1C9420882
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 14:00:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1C9420882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAwzP-0001LY-0Z
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 10:00:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51590)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iAwww-00078M-7g
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 09:58:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iAwvS-0004r6-6F
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 09:56:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34844)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iAwvR-0004qP-UX
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 09:56:50 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EC2CA3DE31
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 13:56:48 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id g82so1845977wmg.9
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 06:56:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=v2I6cJQ2gMhHn5Uv0irVabSo7Krdii2/SDdZcHQQyAA=;
 b=UOP47zb+Rpbib02E1P+wSrpGK1kn/OlW6F5Dd+hvvj96yNou1Dc6GVj5NdWhM4Uzdo
 SpUATgam4meptNlogCMDtb6yDSbs+kB/kFZH67QBz2uS9RYQTN6Q11yIGQhxVb7aU02v
 TpyXSjRyOPowmUMFe1wIEoJ+dhs6xs9D5jkkrUUTML3vYotkozAI7IKk0hvKkQkYcDJ9
 ds2LD22eCcaOSqWQHi38OZn1GO/r6z/3xa1ZPu4jOKmICfQJ0n0KjhzDCAS3U1GIexQQ
 3hUPV38BgM0tyxZ/UQVvovuuLbtXbOQ3bx9vJS1YwrW0rJY5PHBTUyEZEGMRMgblcsaw
 hChA==
X-Gm-Message-State: APjAAAWjdPhY8jnCmhxj1rC/Vadx/Dpd1WNz5vu0yfvq9VAnZd6Azf0l
 O7KKbsrF9wxUSvFc1QbgLu2KHrtVeXF5dyYhr6jmNTsnqriwPzCuHLuBpxx4Zl/jpiVry/iMW/f
 lPOrZBGUOGG0s07E=
X-Received: by 2002:a1c:1f89:: with SMTP id f131mr2865063wmf.72.1568901407656; 
 Thu, 19 Sep 2019 06:56:47 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwXMTPpfwra8afzlfpJDAMbi3e2eyixFVUYyb0vC8OVB6X6QSTaE0C7ZongR18IpPGhaP/K8Q==
X-Received: by 2002:a1c:1f89:: with SMTP id f131mr2865050wmf.72.1568901407455; 
 Thu, 19 Sep 2019 06:56:47 -0700 (PDT)
Received: from [192.168.1.115] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id b184sm9257056wmg.47.2019.09.19.06.56.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Sep 2019 06:56:46 -0700 (PDT)
To: Laszlo Ersek <lersek@redhat.com>, qemu devel list
 <qemu-devel@nongnu.org>, Bruce Rogers <brogers@suse.com>
References: <20190918171141.15957-1-lersek@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <66358856-4819-cccf-363e-2d7b7e3bc6df@redhat.com>
Date: Thu, 19 Sep 2019 15:56:46 +0200
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
Cc: John Snow <jsnow@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Bruce,

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

Since I plan to queue this patch, do you mind testing this patch on your
distribution? I don't want to break your workflow.

Beware it creates ~3.5GiB of temporary data in roms/edk2/Build.

Thanks!

Meanwhile:
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

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

