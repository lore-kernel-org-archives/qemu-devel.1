Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EEC2C43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 22:20:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46F9B206DF
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 22:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ndKfk1Rn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46F9B206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icd0J-00053r-DZ
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 17:20:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33497)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1icczS-0004Ux-B3
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 17:19:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1icczR-00073p-1b
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 17:19:22 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:60943)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1icczM-0006ap-Mt; Wed, 04 Dec 2019 17:19:17 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47StYR6phNz9sPh; Thu,  5 Dec 2019 09:19:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1575497947;
 bh=ZRl0dB7AgtWIBBT9E7jSBUi/q1ZtvFAnnSdY14TlBNs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ndKfk1Rnz1HrJyK9yXBPXzU7IdxEc1sfwPBgv8tbdFiUnDC4NbTc/Fgg5bpI8JBAb
 IeMj2bmnmXXSUSyeVA1yX4xZ9rPFcETl+WghaW3vPnTgfEgLxGeRzDKfzCJ7G8er4w
 xvmzX2HcfdnuLMBbRxQ9h5ITjlCJQ2Q0jg/trNlU=
Date: Thu, 5 Dec 2019 09:09:17 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2 7/7] travis.yml: Enable builds on arm64, ppc64le and
 s390x
Message-ID: <20191204220917.GC5031@umbus.fritz.box>
References: <20191204154618.23560-1-thuth@redhat.com>
 <20191204154618.23560-8-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="VywGB/WGlW4DM4P8"
Content-Disposition: inline
In-Reply-To: <20191204154618.23560-8-thuth@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: qemu-block@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>,
 Eric Auger <eric.auger@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--VywGB/WGlW4DM4P8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 04, 2019 at 04:46:18PM +0100, Thomas Huth wrote:
> Travis recently added the possibility to test on these architectures,
> too, so let's enable them in our travis.yml file to extend our test
> coverage.
>=20
> Unfortunately, the libssh in this Ubuntu version (bionic) is in a pretty
> unusable Frankenstein state and libspice-server-dev is not available here,
> so we can not use the global list of packages to install, but have to
> provide individual package lists instead.
>=20
> Also, some of the iotests crash when using "dist: bionic" on arm64
> and ppc64le, thus these two builders have to use "dist: xenial" until
> the problem is understood / fixed.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  .travis.yml | 86 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 86 insertions(+)
>=20
> diff --git a/.travis.yml b/.travis.yml
> index 445b0646c1..0e6458b0af 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -354,6 +354,92 @@ matrix:
>          - TEST_CMD=3D"make -j3 check-tcg V=3D1"
>          - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
> =20
> +    - arch: arm64
> +      dist: xenial
> +      addons:
> +        apt_packages:
> +          - libaio-dev
> +          - libattr1-dev
> +          - libbrlapi-dev
> +          - libcap-ng-dev
> +          - libgcrypt20-dev
> +          - libgnutls28-dev
> +          - libgtk-3-dev
> +          - libiscsi-dev
> +          - liblttng-ust-dev
> +          - libncurses5-dev
> +          - libnfs-dev
> +          - libnss3-dev
> +          - libpixman-1-dev
> +          - libpng-dev
> +          - librados-dev
> +          - libsdl2-dev
> +          - libseccomp-dev
> +          - liburcu-dev
> +          - libusb-1.0-0-dev
> +          - libvdeplug-dev
> +          - libvte-2.91-dev
> +      env:
> +        - TEST_CMD=3D"make check check-tcg V=3D1"
> +        - CONFIG=3D"--disable-containers --target-list=3D${MAIN_SOFTMMU_=
TARGETS}"
> +
> +    - arch: ppc64le
> +      dist: xenial
> +      addons:
> +        apt_packages:
> +          - libaio-dev
> +          - libattr1-dev
> +          - libbrlapi-dev
> +          - libcap-ng-dev
> +          - libgcrypt20-dev
> +          - libgnutls28-dev
> +          - libgtk-3-dev
> +          - libiscsi-dev
> +          - liblttng-ust-dev
> +          - libncurses5-dev
> +          - libnfs-dev
> +          - libnss3-dev
> +          - libpixman-1-dev
> +          - libpng-dev
> +          - librados-dev
> +          - libsdl2-dev
> +          - libseccomp-dev
> +          - liburcu-dev
> +          - libusb-1.0-0-dev
> +          - libvdeplug-dev
> +          - libvte-2.91-dev
> +      env:
> +        - TEST_CMD=3D"make check check-tcg V=3D1"
> +        - CONFIG=3D"--disable-containers --target-list=3D${MAIN_SOFTMMU_=
TARGETS},ppc64le-linux-user"
> +
> +    - arch: s390x
> +      dist: bionic
> +      addons:
> +        apt_packages:
> +          - libaio-dev
> +          - libattr1-dev
> +          - libbrlapi-dev
> +          - libcap-ng-dev
> +          - libgcrypt20-dev
> +          - libgnutls28-dev
> +          - libgtk-3-dev
> +          - libiscsi-dev
> +          - liblttng-ust-dev
> +          - libncurses5-dev
> +          - libnfs-dev
> +          - libnss3-dev
> +          - libpixman-1-dev
> +          - libpng-dev
> +          - librados-dev
> +          - libsdl2-dev
> +          - libseccomp-dev
> +          - liburcu-dev
> +          - libusb-1.0-0-dev
> +          - libvdeplug-dev
> +          - libvte-2.91-dev
> +      env:
> +        - TEST_CMD=3D"make check check-tcg V=3D1"
> +        - CONFIG=3D"--disable-containers --target-list=3D${MAIN_SOFTMMU_=
TARGETS},s390x-linux-user"
> =20
>      # Release builds
>      # The make-release script expect a QEMU version, so our tag must sta=
rt with a 'v'.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--VywGB/WGlW4DM4P8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3oLooACgkQbDjKyiDZ
s5Lllg//WE8DzeXrGVpXW5qQza8pjQXkjXb7QsYXlbimmkvHOPjtgABj24YYw3/9
aa2BLOQtqekxt96c2/1W+bITCrn1HXtE3GNx4HvSaVKIrezJVPgLNgPU6yWlNgHm
tensOUtgUaAEjPQEP8yHQz1JXK38sIWve/YAEFHiO1OVezH/XTRRQpdYhZUZU2Ui
ocvcJoKWIfk27pE1+AJ4OHo4+WVygDARlqdS5RKdGISd7LKlszdYyRctiuGNiW3K
joMisJriXQrOfBvG+HYLuXckhYKiV0BRMRVWDX1w6ghEWLEjOVsr7Qtdf/pwXHx8
YszZ7EEY9GlOMhG5jdD2uFEMIKM8wnZrpoMo8AbnWAujjBTZL8fj22Bk7/THqg/n
sMZ1x3D/f4ElBeOJ/eLffswCczUw+EQzQZ5qo5kugzeMbIjyeEkN9OBtjOboV959
ZTjgkCTmKA50MNmzdbm8TNRVZUdgOHYMqbZXnpDPw5ILQ9gjWdF7BxpUZmBfRmkU
dWxxDwl1pnvzn+XL/zadCp3PYR0dscrSUG+c55+hK/cMCggP4V7AdJOitv3x1oj6
oqguACYaOVpsItUwmiQHKf5raSyPK6tPuicrjBilerT8v60hnisNJ0EVirdX1/xL
UJfc8yXgQvwrRLA8NTWl6Y9GVPlB1qa1afrih/xh2nyk2bk0oIM=
=Skw2
-----END PGP SIGNATURE-----

--VywGB/WGlW4DM4P8--

