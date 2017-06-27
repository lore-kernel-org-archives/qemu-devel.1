Received: from eggs.gnu.org ([2001:4830:134:3::10]:60415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dPvLd-0006Or-9h
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 14:36:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dPvLa-0003kY-MT
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 14:36:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:64572)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dPvLa-0003kF-E2
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 14:36:22 -0400
References: <20170618191101.3457-1-Sergio.G.DelReal@gmail.com>
	<b5df4ca0-a337-1385-58e3-5217ee00cbfb@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <79be8ef3-de2e-b498-4b1d-628bfcc71154@redhat.com>
Date: Tue, 27 Jun 2017 13:36:16 -0500
MIME-Version: 1.0
In-Reply-To: <b5df4ca0-a337-1385-58e3-5217ee00cbfb@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wvxSJLnpUxVkLMOXtVahv0Ao5aFof1s42"
Subject: Re: [Qemu-devel] [PATCH] vcpu_dirty: share the same field in
 CPUState for all accelerators
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>
Cc: James Hogan <james.hogan@imgtec.com>, Eduardo Habkost <ehabkost@redhat.com>, "open list:Overall" <kvm@vger.kernel.org>, "open list:CPU" <qemu-devel@nongnu.org>, Yongbok Kim <yongbok.kim@imgtec.com>, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wvxSJLnpUxVkLMOXtVahv0Ao5aFof1s42
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>
Cc: James Hogan <james.hogan@imgtec.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "open list:Overall" <kvm@vger.kernel.org>,
 "open list:CPU" <qemu-devel@nongnu.org>, Yongbok Kim
 <yongbok.kim@imgtec.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Message-ID: <79be8ef3-de2e-b498-4b1d-628bfcc71154@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] vcpu_dirty: share the same field in CPUState
 for all accelerators
References: <20170618191101.3457-1-Sergio.G.DelReal@gmail.com>
 <b5df4ca0-a337-1385-58e3-5217ee00cbfb@redhat.com>
In-Reply-To: <b5df4ca0-a337-1385-58e3-5217ee00cbfb@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/19/2017 11:35 AM, Paolo Bonzini wrote:
>=20
>=20
> On 18/06/2017 21:11, Sergio Andres Gomez Del Real wrote:
>> This patch simply replaces the separate boolean field in CPUState that=

>> kvm, hax (and upcoming hvf) have for keeping track of vcpu dirtiness
>> with a single shared field.
>>
>> Signed-off-by: Sergio Andres Gomez Del Real <Sergio.G.DelReal@gmail.co=
m>
>> ---

>>
>=20
> Thanks, I queued this patch for 2.9.

As in qemu-stable 2.9.1, or did you mean 2.10 mainline?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--wvxSJLnpUxVkLMOXtVahv0Ao5aFof1s42
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZUqWhAAoJEKeha0olJ0Nq2NgH/3cXlSFHY66lZU+LN3Zoet6R
vBaEzvXhzU5KSBr7mhIMSo/wYWH2449aY4qmq+53esUikRWdPs++AFeMWjvCAnXG
GR1emjmB+6gZS4QQsLRFBQKljjjlgRDQbVgC1AT8j+2ttnt/FBiLLOvZf1Dy4WYg
JqauLk7mber25McLcAuzb0xCskKExoZQyfrcq24g5i7/3//kaUBY3PoMArpgLK/O
ejqumT+/ca+/UZdGzkZBjqcco007InghQSe9nrqQvKHEoC5BoxuwFkCJpJR5IxG3
FME2XotLeWfkwNgh/ze6+684eKsCFJ69tVEz/QJpq3NyyzfCFgXbAwnrTm0HqlY=
=uC0S
-----END PGP SIGNATURE-----

--wvxSJLnpUxVkLMOXtVahv0Ao5aFof1s42--
