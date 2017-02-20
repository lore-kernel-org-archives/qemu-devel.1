Received: from eggs.gnu.org ([2001:4830:134:3::10]:57925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cfsPe-0002kq-5n
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 13:10:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cfsPb-0000gP-2X
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 13:10:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51516)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cfsPa-0000gC-QG
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 13:10:11 -0500
References: <1487266760-80500-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1487266760-80500-2-git-send-email-anton.nefedov@virtuozzo.com>
	<6882690d-5972-8b42-61ad-302531dc6d7e@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1cc2dad1-8ffd-0b7a-1a2a-881db663488f@redhat.com>
Date: Mon, 20 Feb 2017 19:10:04 +0100
MIME-Version: 1.0
In-Reply-To: <6882690d-5972-8b42-61ad-302531dc6d7e@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="J6S79KQwI2nAVoO9MTakSs6S2kc688Dbd"
Subject: Re: [Qemu-devel] [PATCH] qmp-events: fix GUEST_PANICKED description
 formatting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--J6S79KQwI2nAVoO9MTakSs6S2kc688Dbd
From: Paolo Bonzini <pbonzini@redhat.com>
To: Eric Blake <eblake@redhat.com>,
 Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, den@openvz.org
Message-ID: <1cc2dad1-8ffd-0b7a-1a2a-881db663488f@redhat.com>
Subject: Re: [PATCH] qmp-events: fix GUEST_PANICKED description formatting
References: <1487266760-80500-1-git-send-email-anton.nefedov@virtuozzo.com>
 <1487266760-80500-2-git-send-email-anton.nefedov@virtuozzo.com>
 <6882690d-5972-8b42-61ad-302531dc6d7e@redhat.com>
In-Reply-To: <6882690d-5972-8b42-61ad-302531dc6d7e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 16/02/2017 20:36, Eric Blake wrote:
> On that grounds, you already need the 'if (info)' for more than just th=
e
> free, so this code motion is no longer quite as important.  But now I'm=

> noticing that it looks weird because you are freeing an input parameter=
=2E
>  Generally, transfer semantics like that are screwy - it's probably
> better if the caller of qemu_system_guest_panicked() is the one freeing=

> info, rather than requiring that the caller pass in malloc'd memory tha=
t
> gets freed as a side effect and must not be referenced afterwards in th=
e
> caller.  In other words, I think the code motion is unnecessary, but
> that the qapi_free_GuestPanicInformation() call is probably in the wron=
g
> function to begin with.

Even better then would be to just pass a CPUState* and let
qemu_system_guest_panicked get the GuestPanicInformation via the QOM
property.

But for 2.9, we only need to change the union.  Eric, can you do that
for us since my QAPI-fu is limited?

Paolo


--J6S79KQwI2nAVoO9MTakSs6S2kc688Dbd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYqzD8AAoJEL/70l94x66DNkMH/jYT7Z6NYZ+4BHBDjwyTFf0V
DWDOTMug5ghgj6saMel7EWtKkehZgE4wyrGoZaRX3OLaKzwqWlEDE+o+s7mz+CLl
voJgy1FeJN4ioceuQ2m077ZBTpnFVfYbKCu9lUIwRHiUDAjaQ5F2Zbc7p2gkPOYz
CE4QweN2VTWu2hUTcvlj2FE2WR2Ljkcq1VCaSw+xmrJjtwEI/Ja77SQMktutriGN
E+4f1kXaQRU64SeL7O3O1WCCN8+TZwAv8jIXafEQ+YLILeOdb/IV3v6ZdDwzoX/4
XOwRdeRvue3gAjS0aHXn5QVucltnMPn328JGWojV04VAAhZtIgycbI4NfKdUP/c=
=IrdS
-----END PGP SIGNATURE-----

--J6S79KQwI2nAVoO9MTakSs6S2kc688Dbd--
