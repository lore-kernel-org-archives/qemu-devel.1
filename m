Received: from eggs.gnu.org ([2001:4830:134:3::10]:35639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cyfoK-0004Pr-8M
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 10:33:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cyfoG-0006PG-5r
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 10:33:24 -0400
References: <20170412204641.GA15762@localhost.localdomain>
	<f5bf12f4-e4fd-87c7-a714-e412cee63e36@redhat.com>
	<20170412222251.GB15762@localhost.localdomain>
	<20170412235420.GB8607@lemon>
	<CAFEAcA9yt49a61JLN-Sv=dFSz6rGC30hxb9=oHDqRnvpyjZXQQ@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d2553d23-6710-5a1a-8efb-1d8379a1849e@redhat.com>
Date: Thu, 13 Apr 2017 09:33:06 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9yt49a61JLN-Sv=dFSz6rGC30hxb9=oHDqRnvpyjZXQQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rNuDG50TDiREq7Bf3suAeCNkdM90dxtce"
Subject: Re: [Qemu-devel] Regression from 2.8: stuck in bdrv_drain()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>, Jeff Cody <jcody@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rNuDG50TDiREq7Bf3suAeCNkdM90dxtce
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 Jeff Cody <jcody@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>
Message-ID: <d2553d23-6710-5a1a-8efb-1d8379a1849e@redhat.com>
Subject: Re: [Qemu-devel] Regression from 2.8: stuck in bdrv_drain()
References: <20170412204641.GA15762@localhost.localdomain>
 <f5bf12f4-e4fd-87c7-a714-e412cee63e36@redhat.com>
 <20170412222251.GB15762@localhost.localdomain> <20170412235420.GB8607@lemon>
 <CAFEAcA9yt49a61JLN-Sv=dFSz6rGC30hxb9=oHDqRnvpyjZXQQ@mail.gmail.com>
In-Reply-To: <CAFEAcA9yt49a61JLN-Sv=dFSz6rGC30hxb9=oHDqRnvpyjZXQQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/13/2017 04:48 AM, Peter Maydell wrote:
> On 13 April 2017 at 00:54, Fam Zheng <famz@redhat.com> wrote:
>> John and I confirmed that this can be fixed by this pending patch:
>>
>> [PATCH for-2.9 4/5] block: Drain BH in bdrv_drained_begin
>>
>> https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg01018.html
>>
>> It didn't make it into 2.9-rc4 because of limited time. :(
>>
>> Looks like there is no -rc5, we'll have to document this as a known is=
sue.
>=20
> Well, we *hope* there is no -rc5, but if the bug is genuinely
> a "we can't release like this" bug we will obviously have to
> do another rc. Basically you all as the block maintainers should
> make the call about whether it's release-critical or not.

Just curious: is there a technical reason we couldn't spin an -rc5 today
(with just the fix to this issue), and slip the schedule only by two
days instead of a full week?  And/or shorten the time for testing -rc5
from the usual 7 days into 5?

I don't know what other constraints we have to play with, so feel free
to tell me that my idea is not feasible.  Also, while I'm a block layer
contributor, I'm not one of its co-maintainers, so I'd trust the replies
from others a bit more than mine when deciding what to do here.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--rNuDG50TDiREq7Bf3suAeCNkdM90dxtce
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY74wiAAoJEKeha0olJ0Nq/hEH/Aq6xWaRt3rgsxhkq1TFhHSS
w1V+nWomBM+/IMz7rVIqTM1Tk1hPfjg06xVyiD0wFuMbGExMVqy8XHKZFj2tfEXk
F9q1aU6SM2tC5yUEM/yBsJBK0FttKvQaiumZRbUi48LMvmiWd2/p2geC5q8bZhId
qtB7jujVFt7RoBgPu34bv+Yt+LyeY0+9ZZXp8SEt7c4vu6ABaaT8GSj+F8RLCNA9
CeLFrsbbyxMDj7q3qKfub/y1irtlEiH3rG5X6ZIAblCu8YCLSQ77Rzr8Qt6u0CFa
MnSZBbkHCLttPfVVnue/5Z1pio9Nq0hh+83UNXMBWhAz1iMrgcm2ITFk3dtSYg0=
=pPDN
-----END PGP SIGNATURE-----

--rNuDG50TDiREq7Bf3suAeCNkdM90dxtce--
