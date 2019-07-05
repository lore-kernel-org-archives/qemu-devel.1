Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ECECC4649B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 10:50:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A77521850
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 10:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="iRPBjNAx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A77521850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjLno-0003On-AK
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 06:50:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59182)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <n54@gmx.com>) id 1hjLmR-0002gE-MH
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 06:49:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <n54@gmx.com>) id 1hjLmI-0003tL-Py
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 06:49:25 -0400
Received: from mout.gmx.net ([212.227.15.18]:42899)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <n54@gmx.com>) id 1hjLmI-0003jO-3c
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 06:49:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1562323746;
 bh=BY+YmpNhNEB96mMFnpT+Gq8c7mY+XexQoQQlxfbJLdo=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=iRPBjNAxk5LaUZrvzg/A93zndTS9Aocz0YNoQQm8wROA28rGGhCrLWkm7lADg4Fc6
 yjAyffTjoC/o2qYrFjk0Ce3y2pnavA/kJldkYiJp0tBXkQKl4QM6Fq6EQKuwb3COWz
 naYQ8M7zoSeBscLpKo8eK8pFYAFyFDGQZjH6I0Sc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.241] ([89.71.135.231]) by mail.gmx.com (mrgmx003
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0MGjfl-1hnSGu1bhx-00DYCE; Fri, 05
 Jul 2019 12:42:41 +0200
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20190617043858.8290-1-kraxel@redhat.com>
 <20190617043858.8290-10-kraxel@redhat.com> <87zhlsvkx1.fsf@zen.linaroharston>
From: Kamil Rytarowski <n54@gmx.com>
Openpgp: preference=signencrypt
Autocrypt: addr=n54@gmx.com; prefer-encrypt=mutual; keydata=
 mQINBFVwUF8BEADHmOg7PFLIcSDdMx5HNDYr8MY2ExGfUTrKwPndbt3peaa5lHsK+UGoPG48
 KiWkhEaMmjaXHFa7XgVpJHhFmNoJXfPgjI/sOKTMCPQ5DEHEHTibC4mta7IBAk+rmnaOF0k8
 bxHfP8Qbls66wvicrAfTRXn/1ReeNc3NP4Sq39PoVHkfQTlnQiD4eAqBdq61B7DhzjhbKAZ4
 RsNtLfB6eOv9qvmblUzs50ChYewM9hvn+c7MdDH+x2UXoSDhkBDkKcJGkX91evos8s9AuoEd
 D32X5e+bmdUGe8Cr3cAZJ8IEXR6F9828/kxzPliMsCWVRx1Fr28baCJOUGgFPNr3ips78m9+
 Iw8PdQ101jU0dvucDFxw/1SCGYEZzV+O/237oRPuLCiDX5nhQoxf6dn9ukQleLBMNy2BLI4H
 g342NhF21HLA+KlyLOHaMKQCKzlal+zVNZTRTCh/ikMhsxWQjBfnqTDbMj85DnWwtump27SI
 qhPjUnS0a6MKoS/A+hbi64k5zztkvloELfCSrX7NyBTT0jgF2IGFIxZMrKCtQ9StcGMCV9MX
 tjcBy6fj7QMontEaIDRJEMjg8UIGw1B687OhalOv1ISia4xOWvpYAM6ipgqh6tBQmFzasL9P
 h1RtcVdFpFbhwVlr1Bly8c25gBNQHL5GUjLMn45LlQz50OzrkwARAQABtCdLYW1pbCBSeXRh
 cm93c2tpIChOZXRCU0QpIDxuNTRAZ214LmNvbT6JAjwEEwEIACYCGyMHCwkIBwMCAQYVCAIJ
 CgsEFgIDAQIeAQIXgAUCVbKGFwIZAQAKCRBLswjpsC52bIVpD/9i8npieI91xMIVvAHIUMeo
 cQO0IrNb+b/PuTj2qNemdwU7dhVJ7tVU5O1H2hI2M4rHGzjzDTxYzdxka0+A8CVEuvFdf6sF
 lXlXF0wM7rC6MoaB0QLAKxkZB5OtCILxLx7Bl2Y4cTPMU9v+qSL6yrdmhxogkufa4d6O9Zl/
 FCWO2kH/BphKOiDtbyvdo2WULSLWP2IXN+0rCpNL4wbTfYLgV9JtMf8f0naGsdy7BFuDWsIE
 vtHh8dkQZP7dz6Qy67kx8negZaehSEgXwiae0HwQIn3xTQrFmBDALDsCgXuLWPTvglSkqTak
 uG+8X5fyTy0cU10TNKsU+rFBO+/xsUoIQOGrARwfWOIfJNPelzh/qigSnyNQNH8u5vFRPg9n
 fqB/AcvvAvtOYOo8EN9Ofx11gNj397NXc5HBQTrX6k5GNAeBWE3Ng1uO6scIwAS7qGnqGezU
 ABmQKLN37gmJiiGwhQAnSE6HILLBC5Z2b0S2rQsPKg8WgUmPa1YIcDkDtNB/LJcDsdU4Fm+r
 U2ksKU7tGD2ZfBt8H2nqfPKKeB+Uv/TBigjRvx/m70vjhqVxwCZA9Fqr9vkQkZroNfqP+3dp
 Z5V5fjmxO5abE2+IikSvFagwMtgx56i8Yrr2BzE8P5/S4cKq1kgyQoF+lVGDKRkUKCv1i4Fo
 aftnSxN8jTFZDbkCDQRVcFBfARAAutbzb8wAHGL5FPPWKErQ3Bsrp9RDTVqRzp7kBMOtd/14
 MrOsWWyiml4XnvBYsJuhZWomFoeulcOXAPoTJ2vTw6erWYtdOiZymfQ3GMWpxzgkOVeNjsFF
 9AQ38FCMKmIDs9dgn+KXSIXlZA34khKLd163SN5U/KHfYlnnocec31u+7rVa1hlF5DBSSpoi
 s8cs41foBYC5NsB/i+yqGIlfzHy7pC2u5kyQCuJotLH4y0rT5X+YBC7z7cqKChtILNDGw0ht
 qps29fwOGBE/FWmu8CbpSHj8pvg7uUyQcKbZbNChBfWtOJKdjnNs5VHf2ec95SwYmWl6Xz66
 G892HY4ODtvl05/kh0qtdJd2oI4gJBsBx/N1585/3JYN4k78GIHTnML3xJydRRs9wwM3AXf/
 iDGrMyY7qHQVXJLdO5nPe7LHg48vryCMkBnTMw5iNFPVCu5w1BaZyHxuS2HvpsgUtQoBa2QE
 P1jYNI+2qgoiIG4VQDhYtrD0WJaYdi/C2UVDxRy07dt73SV3RQ7ijOiUrz4g3/deFKY16/1k
 sE+N5Sc5Tjt84ChjO3nJRbHrQxd6dCOElR70e3R2yAuSB4m7LJpO20IB9CtWhlF/0AtfL91W
 O8GGGqLWB0Z04hmwRs/l8T4WWIlykLshbunWN6jsP1Y27FeilTZ+Pc9mYOEUFfEAEQEAAYkC
 HwQYAQgACQUCVXBQXwIbDAAKCRBLswjpsC52bPayD/9jE8mdNudrudSxbDB2vf8pU8r5flCq
 vIkfOdpZGV/Wx/Zx+HFHHp+b2aNBGSNyFTnph1Ku9bvg06vD0o+b7SdA1vrBgRG41t0OCIyf
 vejz65Xpin2EtCllcBM8zUCxHo43blON8fNw70P1Ec0loBp4TAal1MiXbB8kxRTRcEPVO9YF
 9NPsFxycoWl0ZSvu4ESrQlrjRbVv+W0Fy/XqcQwEtDziFQHQXNRbTy8INPD49CsB7BkKRK+f
 1vMmw7SxfsyEhyCgo9ZWfHb/+w9T5h+UhF87L/m287z7W+s4aCAPBzjbIWhtngGJJwIgiWdI
 I9J6YJLcHLvVZLw7xzA/flcjc0VfzOgJOJw3hBukHnEz7/CKgnABwyNu52P+PQbxVTiTjMKm
 06eV732u9ZLD9ZgEazfmyGDHzsuzoXwsRnmcnbwYYAiynS+vfGl5oMtMa5qzsPhlzuvRlXHm
 zr8VjF8c9RThvyZyyHtWYAqNmBecMvM0whigjMeoAMJ5LtpyZgxjbHj1XnVdNBZgfJkOzsc/
 twffi7RYphRx0d9z5UZ1Yl5Rvl05vTaJ7YhhNC7xuE8yGOQmDUsPDwWqO/eXUDErJjCOBR5b
 0yILqRPYNT0Fj/th9gtEbZy1Gp0TVBkZM3tfjDRu43Pn6iSKObO/j0rNuq1LwN/EMxDifeZO
 4XSbcg==
Message-ID: <5d0e35f4-964e-e6e0-d644-ea19fc9cd029@gmx.com>
Date: Fri, 5 Jul 2019 12:43:06 +0200
User-Agent: Mozilla/5.0 (X11; NetBSD amd64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <87zhlsvkx1.fsf@zen.linaroharston>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="wTd1Fp5WyOXVY7xFQL1tFHSEdVCcOpvGF"
X-Provags-ID: V03:K1:yWemEPvfqyILSBR0qDakKOu+AZ4R3uMrm3sumZ54lRNPYvEMuvU
 OZFXF8SL4lNAhkiM29t3UrEqjW1Kf9BKPoJVnugVDlI2hT+pl4FEkazvhK6877BjF2DT6N0
 oj5h9f3QGCt/qQMTGHKMdEa4BKR4YPsdCgATdarp9SNrLmCAzujFVHYppjOJRKLXXQW3Ymc
 DrTq1juDK3NQap5rIJyHA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tdqc2FW9h9c=:uEBfvU/OYou7OEA0Yrk27A
 +LkB6RFVG/9FRrHz/fimvdMTZhcCy93jj7TidxErwQHrxT31AGQ9L5Ua1IoskftxGIGN3vE72
 Vx490caGoKAmPzVD+gnz099XwCGewrBgV3o9GzsfVQeJADGau67UkV/ypru/Wu+bNWywIG0Hl
 1tkHY2AMeC7cYrDYesp1FOl5oeBwLk50VCcNGGSVNXMmr9HMB6ZghyfzUxXOWpo2+EqoSKf13
 d9V+VzBmfJtl18M+yjoFK53D8EHoqmOvT2YYvQhmWGKGt2BWjmDABgyKFHsKqo7OafBQMqHTx
 fQNfjo1z6rmSKCrMY9IHLQLuyHiQQDPjOuLxSAonTK90nQdwq6yxO1hoAyfGf5j0DHp7oRC55
 HjN1I8YzPuhaXPcS/8W215z7dgjcQozy+r9e8YEV0Lgkn5Fel9Fc9vIPg1ZgALHMFUydUTlD2
 22ADs46yzfOvWWycr3itLb+peCsUenaPW5Vaskp1tKjKFFhRThv1scP5jvZ2ggMnkcjcB4EeT
 isaCyg1s/Ym9RFQOg5z58dzd02lltQL90GqGrk1id+rfqOQtC9sCpyZQ/mGOHenOrEe1PlheC
 lB6gRenhiToXEUHjixP4aY9YnZiIsAN2EVnoRYnCheHUTi5EL0H4y6m5anFmWZBEcqd6Bvn8M
 aFBrjLvporYM2vWe9S/kgzzFAmsJ74+6y8p+qoosfosswBMKhl1wg1UCUpYYgDdUgaCzGdSEY
 y+CZsIIVCdFhgY1BvGANQBj6h7r5ojqvFBIdlWSJWnlK6+i2xdH8455qaEKjw7TILJ9jAkPn6
 v0MsYOWL9ZfT4Q0qeGeqitOSoyr5tsqdSkRi9fg2G3fY3pa/UEWBKpVI1uVg7PzP1CsZwVo4f
 tjdqlHcfHInQ6nW8Hp0YTIVSb4R13uZiClZkfr5wIFI2vzOAIc5fmH1G8Bgj9pIa3ICIf3rom
 FqgzgCwq0mSD1KTUSQQcSX+yK6S61knibolCAeFhj+hJ9TFVbVJE3DD50xVb9am6+gz0G+4NS
 Vmzmtanm4OTdFZyc0jKJ7UWa7paGN4BEmwDawW0hGCLRsaufINTQ5cJdZoZf8wZRhw==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.15.18
Subject: Re: [Qemu-devel] [PATCH v4 09/11] tests/vm: netbsd autoinstall,
 using serial console
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Ed Maste <emaste@freebsd.org>, qemu-devel@nongnu.org,
 Kamil Rytarowski <kamil@netbsd.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Brad Smith <brad@comstyle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wTd1Fp5WyOXVY7xFQL1tFHSEdVCcOpvGF
Content-Type: multipart/mixed; boundary="QViwpiMFOUQ1eeLb18T9sBYLkF5rLQ1Jf";
 protected-headers="v1"
From: Kamil Rytarowski <n54@gmx.com>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Ed Maste <emaste@freebsd.org>, qemu-devel@nongnu.org,
 Kamil Rytarowski <kamil@netbsd.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Brad Smith <brad@comstyle.com>
Message-ID: <5d0e35f4-964e-e6e0-d644-ea19fc9cd029@gmx.com>
Subject: Re: [Qemu-devel] [PATCH v4 09/11] tests/vm: netbsd autoinstall, using
 serial console
References: <20190617043858.8290-1-kraxel@redhat.com>
 <20190617043858.8290-10-kraxel@redhat.com> <87zhlsvkx1.fsf@zen.linaroharston>
In-Reply-To: <87zhlsvkx1.fsf@zen.linaroharston>

--QViwpiMFOUQ1eeLb18T9sBYLkF5rLQ1Jf
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 05.07.2019 12:24, Alex Benn=C3=A9e wrote:
>=20
> Gerd Hoffmann <kraxel@redhat.com> writes:
>=20
>> Instead of fetching the prebuilt image from patchew download the insta=
ll
>> iso and prepare the image locally.  Install to disk, using the serial
>> console.  Create qemu user, configure ssh login.  Install packages
>> needed for qemu builds.
>=20
> I've had to drop this from my v3 PR as Peter was seeing a very
> slow/hanging install when running his merge tests. I've tried to
> reproduce and I see it stall while installing packages but nowhere near=

> the delay Peter has seen.
>=20
> Any pointers on how to debug gratefully received.
>=20

Does it use virtio? There were performance issues with virio disk device.=


>>
>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>> Reviewed-by: Kamil Rytarowski <n54@gmx.com>
>> Tested-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  tests/vm/netbsd | 187 +++++++++++++++++++++++++++++++++++++++++++++--=
-
>>  1 file changed, 177 insertions(+), 10 deletions(-)
>>
>> diff --git a/tests/vm/netbsd b/tests/vm/netbsd
>> index 4c6624ea5ed5..be59a2c1da1d 100755
>> --- a/tests/vm/netbsd
>> +++ b/tests/vm/netbsd
>> @@ -2,10 +2,11 @@
>>  #
>>  # NetBSD VM image
>>  #
>> -# Copyright 2017 Red Hat Inc.
>> +# Copyright 2017-2019 Red Hat Inc.
>>  #
>>  # Authors:
>>  #  Fam Zheng <famz@redhat.com>
>> +#  Gerd Hoffmann <kraxel@redhat.com>
>>  #
>>  # This code is licensed under the GPL version 2 or later.  See
>>  # the COPYING file in the top-level directory.
>> @@ -13,32 +14,198 @@
>>
>>  import os
>>  import sys
>> +import time
>>  import subprocess
>>  import basevm
>>
>>  class NetBSDVM(basevm.BaseVM):
>>      name =3D "netbsd"
>>      arch =3D "x86_64"
>> +
>> +    link =3D "https://cdn.netbsd.org/pub/NetBSD/NetBSD-8.0/images/Net=
BSD-8.0-amd64.iso"
>> +    size =3D "20G"
>> +    pkgs =3D [
>> +        # tools
>> +        "git-base",
>> +        "pkgconf",
>> +        "xz",
>> +        "python37",
>> +
>> +        # gnu tools
>> +        "bash",
>> +        "gmake",
>> +        "gsed",
>> +        "flex", "bison",
>> +
>> +        # libs: crypto
>> +        "gnutls",
>> +
>> +        # libs: images
>> +        "jpeg",
>> +        "png",
>> +
>> +	# libs: ui
>> +        "SDL2",
>> +        "gtk3+",
>> +        "libxkbcommon",
>> +    ]
>> +
>>      BUILD_SCRIPT =3D """
>>          set -e;
>> -        rm -rf /var/tmp/qemu-test.*
>> -        cd $(mktemp -d /var/tmp/qemu-test.XXXXXX);
>> +        rm -rf /home/qemu/qemu-test.*
>> +        cd $(mktemp -d /home/qemu/qemu-test.XXXXXX);
>> +        mkdir src build; cd src;
>>          tar -xf /dev/rld1a;
>> -        ./configure --python=3Dpython2.7 {configure_opts};
>> +        cd ../build
>> +        ../src/configure --python=3Dpython3.7 --disable-opengl {confi=
gure_opts};
>>          gmake --output-sync -j{jobs} {target} {verbose};
>>      """
>> +    poweroff =3D "/sbin/poweroff"
>>
>>      def build_image(self, img):
>> -        cimg =3D self._download_with_cache("http://download.patchew.o=
rg/netbsd-7.1-amd64.img.xz",
>> -                                         sha256sum=3D'b633d565b0eac3d=
02015cd0c81440bd8a7a8df8512615ac1ee05d318be015732')
>> -        img_tmp_xz =3D img + ".tmp.xz"
>> +        cimg =3D self._download_with_cache(self.link)
>>          img_tmp =3D img + ".tmp"
>> -        sys.stderr.write("Extracting the image...\n")
>> -        subprocess.check_call(["cp", "-f", cimg, img_tmp_xz])
>> -        subprocess.check_call(["xz", "-dvf", img_tmp_xz])
>> +        iso =3D img + ".install.iso"
>> +
>> +        self.print_step("Preparing iso and disk image")
>> +        subprocess.check_call(["cp", "-f", cimg, iso])
>> +        subprocess.check_call(["qemu-img", "create", "-f", "qcow2",
>> +                               img_tmp, self.size])
>> +
>> +        self.print_step("Booting installer")
>> +        self.boot(img_tmp, extra_args =3D [
>> +            "-bios", "pc-bios/bios-256k.bin",
>> +            "-machine", "graphics=3Doff",
>> +            "-cdrom", iso
>> +        ])
>> +        self.console_init()
>> +        self.console_wait("Primary Bootstrap")
>> +
>> +        # serial console boot menu output doesn't work for some
>> +        # reason, so we have to fly blind ...
>> +        for char in list("5consdev com0\n"):
>> +            time.sleep(0.2)
>> +            self.console_send(char)
>> +            self.console_wait("")
>> +        self.console_wait_send("> ", "boot\n")
>> +
>> +        self.console_wait_send("Terminal type",            "xterm\n")=

>> +        self.console_wait_send("a: Installation messages", "a\n")
>> +        self.console_wait_send("b: US-English",            "b\n")
>> +        self.console_wait_send("a: Install NetBSD",        "a\n")
>> +        self.console_wait("Shall we continue?")
>> +        self.console_wait_send("b: Yes",                   "b\n")
>> +
>> +        self.console_wait_send("a: ld0",                   "a\n")
>> +        self.console_wait_send("a: This is the correct",   "a\n")
>> +        self.console_wait_send("b: Use the entire disk",   "b\n")
>> +        self.console_wait("NetBSD bootcode")
>> +        self.console_wait_send("a: Yes",                   "a\n")
>> +        self.console_wait_send("b: Use existing part",     "b\n")
>> +        self.console_wait_send("x: Partition sizes ok",    "x\n")
>> +        self.console_wait_send("for your NetBSD disk",     "\n")
>> +        self.console_wait("Shall we continue?")
>> +        self.console_wait_send("b: Yes",                   "b\n")
>> +
>> +        self.console_wait_send("b: Use serial port com0",  "b\n")
>> +        self.console_wait_send("f: Set serial baud rate",  "f\n")
>> +        self.console_wait_send("a: 9600",                  "a\n")
>> +        self.console_wait_send("x: Exit",                  "x\n")
>> +
>> +        self.console_wait_send("a: Full installation",     "a\n")
>> +        self.console_wait_send("a: CD-ROM",                "a\n")
>> +
>> +        self.print_step("Installation started now, this will take a w=
hile")
>> +        self.console_wait_send("Hit enter to continue",    "\n")
>> +
>> +        self.console_wait_send("d: Change root password",  "d\n")
>> +        self.console_wait_send("a: Yes",                   "a\n")
>> +        self.console_wait("New password:")
>> +        self.console_send("%s\n" % self.ROOT_PASS)
>> +        self.console_wait("New password:")
>> +        self.console_send("%s\n" % self.ROOT_PASS)
>> +        self.console_wait("Retype new password:")
>> +        self.console_send("%s\n" % self.ROOT_PASS)
>> +
>> +        self.console_wait_send("o: Add a user",            "o\n")
>> +        self.console_wait("username")
>> +        self.console_send("%s\n" % self.GUEST_USER)
>> +        self.console_wait("to group wheel")
>> +        self.console_wait_send("a: Yes",                   "a\n")
>> +        self.console_wait_send("a: /bin/sh",               "a\n")
>> +        self.console_wait("New password:")
>> +        self.console_send("%s\n" % self.GUEST_PASS)
>> +        self.console_wait("New password:")
>> +        self.console_send("%s\n" % self.GUEST_PASS)
>> +        self.console_wait("Retype new password:")
>> +        self.console_send("%s\n" % self.GUEST_PASS)
>> +
>> +        self.console_wait_send("a: Configure network",     "a\n")
>> +        self.console_wait_send("a: vioif0",                "a\n")
>> +        self.console_wait_send("Network media type",       "\n")
>> +        self.console_wait("autoconfiguration")
>> +        self.console_wait_send("a: Yes",                   "a\n")
>> +        self.console_wait_send("DNS domain",               "localnet\=
n")
>> +        self.console_wait("Are they OK?")
>> +        self.console_wait_send("a: Yes",                   "a\n")
>> +        self.console_wait("installed in /etc")
>> +        self.console_wait_send("a: Yes",                   "a\n")
>> +
>> +        self.console_wait_send("e: Enable install",        "e\n")
>> +        proxy =3D os.environ.get("http_proxy")
>> +        if not proxy is None:
>> +            self.console_wait_send("f: Proxy",             "f\n")
>> +            self.console_wait("Proxy")
>> +            self.console_send("%s\n" % proxy)
>> +        self.console_wait_send("x: Install pkgin",         "x\n")
>> +        self.console_init(1200)
>> +        self.console_wait_send("Hit enter to continue", "\n")
>> +        self.console_init()
>> +
>> +        self.console_wait_send("g: Enable sshd",           "g\n")
>> +        self.console_wait_send("x: Finished conf",         "x\n")
>> +        self.console_wait_send("Hit enter to continue",    "\n")
>> +
>> +        self.print_step("Installation finished, rebooting")
>> +        self.console_wait_send("d: Reboot the computer",   "d\n")
>> +
>> +        # setup qemu user
>> +        prompt =3D "localhost$"
>> +        self.console_ssh_init(prompt, self.GUEST_USER, self.GUEST_PAS=
S)
>> +        self.console_wait_send(prompt, "exit\n")
>> +
>> +        # setup root user
>> +        prompt =3D "localhost#"
>> +        self.console_ssh_init(prompt, "root", self.ROOT_PASS)
>> +        self.console_sshd_config(prompt)
>> +
>> +        # setup virtio-blk #1 (tarfile)
>> +        self.console_wait(prompt)
>> +        self.console_send("echo 'chmod 666 /dev/rld1a' >> /etc/rc.loc=
al\n")
>> +
>> +        # turn off mprotect (conflicts with tcg)
>> +        self.console_wait(prompt)
>> +        self.console_send("echo security.pax.mprotect.enabled=3D0 >> =
/etc/sysctl.conf\n")
>> +
>> +        self.print_step("Configuration finished, rebooting")
>> +        self.console_wait_send(prompt, "reboot\n")
>> +        self.console_wait("login:")
>> +        self.wait_ssh()
>> +
>> +        self.print_step("Installing packages")
>> +        self.ssh_root_check("pkgin update\n")
>> +        self.ssh_root_check("pkgin -y install %s\n" % " ".join(self.p=
kgs))
>> +
>> +        # shutdown
>> +        self.ssh_root(self.poweroff)
>> +        self.console_wait("entering state S5")
>> +        self.wait()
>> +
>>          if os.path.exists(img):
>>              os.remove(img)
>>          os.rename(img_tmp, img)
>> +        os.remove(iso)
>> +        self.print_step("All done")
>>
>>  if __name__ =3D=3D "__main__":
>>      sys.exit(basevm.main(NetBSDVM))
>=20
>=20
> --
> Alex Benn=C3=A9e
>=20



--QViwpiMFOUQ1eeLb18T9sBYLkF5rLQ1Jf--

--wTd1Fp5WyOXVY7xFQL1tFHSEdVCcOpvGF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEELaxVpweEzw+lMDwuS7MI6bAudmwFAl0fKbsACgkQS7MI6bAu
dmzzoBAAv62gwG5yBf3oofKJOZOKoELBnbpA1rqfTxnGcRyVgAEmuOllTazO0YUE
vTFtHGw9DKFPOFnDe8l+eWs7A+pLwFpLlh/EX3nQtsD3oDmeKyHKmDHriRX0Ozr8
Bh6Z0Wr/XPOAlSQ0JFHvSB6FgGu7XB7fEAdidfGvFEfnzM91A56tnWEBZaQOnxMJ
5k4oXugxsAvS3zx4dd9jyBsYtqAvQuRBEhB24J1ciDzay75qMbKrGxcwSTW6dh1K
UDKDbWn3Ndku+froj7STxSvVoEIrUogmoDh1toRRrNIx/IbmUDz8YEok0DBSphFw
RpdgqMqF0V02To189I+dE5sY8EUP/T7Wy1Uwx8MV+zau4PKoDMXpkge9pKY49idi
IHN8CJeyGO8Y8PzeaeuAatQeYv3YT4eFndyck8smuF67W/48go5DY5DIz9sK0mOh
czby/DDNuDlGiLzlr6+NG9Rf36eiDXwufdOjjfZ0xkF8jKBUWfS5NnAyhK4il2Pm
K6N5DnkveMIh1gdAdsJbVwBKnWDt1cMQXhc7h1AG4sYLRD0EeELY6kLj65CGL+aQ
oeSCRQY8PrVQ67rSY2Ihbcsa58wJmuR4UApZs6PyHzLFPcTdUbNDrCIIZ1+u4h9t
jaE4AOAEIxXJkfhH8MbmFBdGCr+7CBUvmMDZTBcZZCoXaY9nlDQ=
=v1nf
-----END PGP SIGNATURE-----

--wTd1Fp5WyOXVY7xFQL1tFHSEdVCcOpvGF--

