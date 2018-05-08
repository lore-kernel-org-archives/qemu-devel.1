Received: from eggs.gnu.org ([2001:4830:134:3::10]:41971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fG4qW-00075g-AG
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:48:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fG4qQ-00014o-K4
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:48:08 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:42021)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fG4qQ-00014h-Cb
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:48:02 -0400
Received: by mail-qt0-x242.google.com with SMTP id c2-v6so41597455qtn.9
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 08:48:02 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171108022828.7242-1-f4bug@amsat.org>
	<23253f77-ccc8-220d-3028-f27945f9542c@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <791dd038-8811-6335-75f7-6dd309ff0ff7@amsat.org>
Date: Tue, 8 May 2018 12:47:52 -0300
MIME-Version: 1.0
In-Reply-To: <23253f77-ccc8-220d-3028-f27945f9542c@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="ZSprd6xDe2YhGhpHOTPH1xZG5tr0TfKm7"
Subject: Re: [Qemu-devel] [RFC PATCH 0/6] generic way to deprecate machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZSprd6xDe2YhGhpHOTPH1xZG5tr0TfKm7
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Marcel Apfelbaum <marcel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Message-ID: <791dd038-8811-6335-75f7-6dd309ff0ff7@amsat.org>
Subject: Re: [Qemu-devel] [RFC PATCH 0/6] generic way to deprecate machines
References: <20171108022828.7242-1-f4bug@amsat.org>
 <23253f77-ccc8-220d-3028-f27945f9542c@redhat.com>
In-Reply-To: <23253f77-ccc8-220d-3028-f27945f9542c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

On 05/04/2018 02:15 PM, Thomas Huth wrote:
> On 08.11.2017 03:28, Philippe Mathieu-Daud=C3=A9 wrote:
>>
>> This series intends to provide a simple and common way to deprecate
>> machines between releases. It may be extended to deprecate devices.
>=20
> *ping*
>=20
> Philippe, I just discovered your findings wrt to the Gumstix machines o=
n
> https://wiki.qemu.org/Features/LegacyRemoval#Deprecated_machines ...
> sounds reasonable, so I think we should really continue here and mark
> those as deprecated. And pc-0.10 and pc-0.11, too.

Ironically I have been using the Gumstix machines quite a lot for the SD
'subsystem' refactor, using the MMC commands in U-Boot (I am unable to
reach the Linux userland since the kernel crashes), and plan to add SD
integration tests via Avocado.

This raises:

- What will happens if I add tests downloading running on their compiled
u-boot
(https://downloads.gumstix.com/images/angstrom/developer/2012-01-22-1750/=
u-boot.bin)
and the company decides to remove this old directory?
Since sometimes old open-source software are hard to rebuild with recent
compilers, should we consider to use a public storage to keep
open-source (signed) blobs we can use for integration testing?

Avocado has a 'vmimage library' which could be extended, adding support
for binary url + detached gpg signatures from some QEMU maintainers?

(I am also using old Gentoo/Debian packaged HPPA/Alpha Linux kernel for
Avocado SuperIO tests, which aren't guaranteed to stay downloadable
forever).

- Maybe I have to volunteer to update the Gumstix section from Orphan
'Odd Fixes' to keep those tests.

> Do you have some spare time to respin your patch series?

I'll make some.

Regards,

Phil.

>=20
>  Thomas
>


--ZSprd6xDe2YhGhpHOTPH1xZG5tr0TfKm7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlrxxqgACgkQ4+MsLN6t
wN73Pw//TIqcxpLe2R6J7IKiZHOzeZaUImOxvWWDyDDocsaz7h0GQIYXZUfPtcuI
yYhlGyk30ISjUujTn9OEpa+2pNmBIrqDIS7gqHsG4YfRVkJkXgr9mEjyrDbjcrPl
2FZv96hsmg6iF3ZpIFHTzbIhu1e2GEddfF9G+9wPhSUzDDHx7fSn+Ra5vxeaJRlm
3tkMKbKM5W1tKqJDCge2BDiVsfn6Unxy6hp9TIKJq6eVv3b4IM3vY81qANZRGSza
G7x2nFTIdPXO5HF0K4Q7S0FCT8eUPeKPS7R7ETbPZxFOL4Y3/3Ylvm0gLmGoMbid
nQs5PX2DbHJpYaDjgylu1B0ycdiCOiPXHlt9Dn4uKGtd+gygnPQ76hZILScJwWfj
i+xEqpdPxCSvqNeUN53hPvtVBlJPjnjkau8DNhY05MTbux5g0huANhwJVN1vBnOE
rYJpTZpGRv8kAvJQLZOdAIG5v5RgdkzJh421rcdcUJwE87yG6NMp071o9R9zI8vj
RNrvBPhHWGlwqnOOEJYJyabWC8mkFULQ78JyjtnqXSjuQRtE60sVQpNwmF5agLqk
XIhtU24Y/B3ywEMD20FNeuquzErrGxElhTdtSLqyoQp92B6L3D7H+krTmA6ZE4i/
C1zR5e7eoGFKvVbW1YP3im720fxP/pqixS8rmxqnd4zqBgmFlyI=
=FF9T
-----END PGP SIGNATURE-----

--ZSprd6xDe2YhGhpHOTPH1xZG5tr0TfKm7--
