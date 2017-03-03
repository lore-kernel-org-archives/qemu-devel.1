Received: from eggs.gnu.org ([2001:4830:134:3::10]:58161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjtCB-00076F-LQ
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:48:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjtC8-0002lS-GI
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:48:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41422)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cjtC8-0002l8-7V
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:48:52 -0500
References: <20170302195337.31558-1-alex.bennee@linaro.org>
	<20170302195337.31558-5-alex.bennee@linaro.org>
	<CAFEAcA_REYx=z1x9K_P1UK4j-fNyZ3717UrHDCLVySPanb28KQ@mail.gmail.com>
	<87pohy1uyk.fsf@linaro.org>
	<CAFEAcA9UWALr0iQZrjdCMrPJeZ4f-GYufG9USgtqtmGOQ1uqnQ@mail.gmail.com>
	<02c25dfe-1d90-6434-08c5-37826afbd993@twiddle.net>
	<92cbdbeb-4e68-2290-951e-604d8508bd5d@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ab356b04-c35b-3511-9b65-bd514ace5e8c@redhat.com>
Date: Fri, 3 Mar 2017 13:48:48 -0600
MIME-Version: 1.0
In-Reply-To: <92cbdbeb-4e68-2290-951e-604d8508bd5d@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rbdQ4ME6hfxxOgA9gvwnIApWRSaOlmjTa"
Subject: Re: [Qemu-devel] [PATCH v2 04/11] translate: downgrade IRQ BQL
 asserts to tcg_debug_assert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: MTTCG Devel <mttcg@greensocs.com>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alvise Rigo <a.rigo@virtualopensystems.com>, QEMU Developers <qemu-devel@nongnu.org>, "Emilio G. Cota" <cota@braap.org>, Paolo Bonzini <pbonzini@redhat.com>, Pranith Kumar <bobby.prani@gmail.com>, =?UTF-8?B?S09OUkFEIEZyw6lkw6lyaWM=?= <fred.konrad@greensocs.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rbdQ4ME6hfxxOgA9gvwnIApWRSaOlmjTa
From: Eric Blake <eblake@redhat.com>
To: Richard Henderson <rth@twiddle.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: MTTCG Devel <mttcg@greensocs.com>,
 Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>,
 Peter Crosthwaite <crosthwaite.peter@gmail.com>,
 Alvise Rigo <a.rigo@virtualopensystems.com>,
 QEMU Developers <qemu-devel@nongnu.org>, "Emilio G. Cota" <cota@braap.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Pranith Kumar <bobby.prani@gmail.com>,
 =?UTF-8?B?S09OUkFEIEZyw6lkw6lyaWM=?= <fred.konrad@greensocs.com>
Message-ID: <ab356b04-c35b-3511-9b65-bd514ace5e8c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 04/11] translate: downgrade IRQ BQL
 asserts to tcg_debug_assert
References: <20170302195337.31558-1-alex.bennee@linaro.org>
 <20170302195337.31558-5-alex.bennee@linaro.org>
 <CAFEAcA_REYx=z1x9K_P1UK4j-fNyZ3717UrHDCLVySPanb28KQ@mail.gmail.com>
 <87pohy1uyk.fsf@linaro.org>
 <CAFEAcA9UWALr0iQZrjdCMrPJeZ4f-GYufG9USgtqtmGOQ1uqnQ@mail.gmail.com>
 <02c25dfe-1d90-6434-08c5-37826afbd993@twiddle.net>
 <92cbdbeb-4e68-2290-951e-604d8508bd5d@redhat.com>
In-Reply-To: <92cbdbeb-4e68-2290-951e-604d8508bd5d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/03/2017 01:47 PM, Eric Blake wrote:
> On 03/03/2017 01:35 PM, Richard Henderson wrote:
>>
>> Which is exactly the point when you have a condition like (X > 0);
>> letting the compiler have the same information for the production buil=
d
>> that it would have gleaned from the debug build.
>>
>> But that's not the same as dropping the assert, which is what you want=
ed.
>>
>> On the other hand, isn't "assert" instead of "g_assert" exactly what y=
ou
>> wanted?  Don't we define NDEBUG for production builds?
>=20
> No - no one in their right mind defines NDEBUG for qemu.  For better or=

> worse, there are too many places where we liberally use assert(), and
> where the code WILL crash and burn when it falls through to subsequent
> code if a failed assert() is not equivalent to a fatal exit.  (I still
> try to make sure we avoid any new side-effects in assert in my code
> reviews, but there's no way you'll convince me to audit the code base
> for NDEBUG-safety violations).

A quick git grep shows, among others:

hw/scsi/mptsas.c:     * When we do, we might be able to re-enable NDEBUG
below.
hw/scsi/mptsas.c:#ifdef NDEBUG
hw/scsi/mptsas.c:#error building with NDEBUG is not supported
hw/virtio/virtio.c:     * When we do, we might be able to re-enable
NDEBUG below.
hw/virtio/virtio.c:#ifdef NDEBUG
hw/virtio/virtio.c:#error building with NDEBUG is not supported


--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--rbdQ4ME6hfxxOgA9gvwnIApWRSaOlmjTa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYucigAAoJEKeha0olJ0Nq0h4IAJkcY09iocUSwZqxhx/ktKUG
GUWJcQurssoJEuMT49VwAJNU8pBGd5EuVjdkvFnQWcOpm/iDPZKQUKIa76Lq9rsy
qEVGYURG9fgJ00nf6+nRcVdv5n3eYEsmkAYpK3J3YOsHsZEi+rg0dfEuuc5QqXPt
AlXigvBXj7lgNSHKTKnrVFCwUtuAQM9Okez+ZHyNnzohpBil9zZWdF4kDU/qJt7Q
mToCL5fUSBYnbSETySLUghdDox9wbNUZfJ+Mjd4lzQKpigDzNktwEG8l7H3V/z8F
5PVwENwDcu7wEfBq1trgipsu2MW0zJ7RvOuRMgQlRjUQhtS9JmUp+33F/y1XGuw=
=H+c+
-----END PGP SIGNATURE-----

--rbdQ4ME6hfxxOgA9gvwnIApWRSaOlmjTa--
