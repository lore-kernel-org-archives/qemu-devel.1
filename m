Received: from eggs.gnu.org ([2001:4830:134:3::10]:44849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eC9l6-0002vl-VQ
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 14:42:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eC9l6-0000Eg-41
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 14:42:05 -0500
References: <cover.1508390588.git.alistair.francis@xilinx.com>
	<ad7c1de551fbc497743e4dd60335a75cb5365a15.1508390588.git.alistair.francis@xilinx.com>
	<87efpmccvu.fsf@secure.laptop> <87bmke4cu9.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <51d103e9-8d6b-8c83-dd69-effe997d4813@redhat.com>
Date: Tue, 7 Nov 2017 13:41:49 -0600
MIME-Version: 1.0
In-Reply-To: <87bmke4cu9.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="uwwnaKEfqEtGFaKvKrIFwaQN0bnBoTLvE"
Subject: Re: [Qemu-devel] [PATCH v3 01/46] Replace all occurances of
 __FUNCTION__ with __func__
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, Anthony Perard <anthony.perard@citrix.com>, qemu-arm@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, alistair23@gmail.com, Yongbok Kim <yongbok.kim@imgtec.com>, xen-devel@lists.xenproject.org, John Snow <jsnow@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uwwnaKEfqEtGFaKvKrIFwaQN0bnBoTLvE
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>, Fam Zheng <famz@redhat.com>,
 qemu-block@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Alistair Francis <alistair.francis@xilinx.com>,
 Anthony Perard <anthony.perard@citrix.com>, qemu-arm@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 alistair23@gmail.com, Yongbok Kim <yongbok.kim@imgtec.com>,
 xen-devel@lists.xenproject.org, John Snow <jsnow@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <51d103e9-8d6b-8c83-dd69-effe997d4813@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 01/46] Replace all occurances of
 __FUNCTION__ with __func__
References: <cover.1508390588.git.alistair.francis@xilinx.com>
 <ad7c1de551fbc497743e4dd60335a75cb5365a15.1508390588.git.alistair.francis@xilinx.com>
 <87efpmccvu.fsf@secure.laptop> <87bmke4cu9.fsf@dusky.pond.sub.org>
In-Reply-To: <87bmke4cu9.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/07/2017 04:12 AM, Markus Armbruster wrote:
> Juan Quintela <quintela@redhat.com> writes:
>=20
>> Alistair Francis <alistair.francis@xilinx.com> wrote:
>>> Replace all occurs of __FUNCTION__ except for the check in checkpatch=

>>> with the non GCC specific __func__.
>>>

>>> +++ b/audio/audio_int.h
>>> @@ -253,7 +253,7 @@ static inline int audio_ring_dist (int dst, int s=
rc, int len)
>>>  #define AUDIO_STRINGIFY(n) AUDIO_STRINGIFY_(n)
>>> =20
>>>  #if defined _MSC_VER || defined __GNUC__
>>> -#define AUDIO_FUNC __FUNCTION__
>>> +#define AUDIO_FUNC __func__
>>>  #else
>>>  #define AUDIO_FUNC __FILE__ ":" AUDIO_STRINGIFY (__LINE__)
>>>  #endif
>>
>> Unrelated to this patch ....
>> Do we really support other compilers than msc and gcc?
>=20
> Let me rephrase the question: do we really support compilers that don't=

> understand __func__?  The presence of numerous unconditional uses of
> __func__ in the tree means the answer is no.  Let's replace AUDIO_FUNC
> by plain __func__.

Answered elsewhere in patch 3/46 (where we DO replace AUDIO_FUNC by
__func__).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--uwwnaKEfqEtGFaKvKrIFwaQN0bnBoTLvE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloCDH0ACgkQp6FrSiUn
Q2pS9wf9GG4eL9iiIJxwjd5vCijsO1/RHRiPat6+DtxuejIILHJbB6EY4hHBalDI
xcshnT6eisNHvHvfWotdTn6oymhEBN7eVYGJqXucv3qXcBKsiQJZDnVqn/opnBVE
FGpvAybwkFLOzUbQyRuoehW0qAbYmuFPVlOtMgepuzbpXZ2sv7DdCueIuBGj+6PQ
eMVGSzQtgfVbxS8jYvv8l34aOaZHNrWjqwPNiYTaqo83/56On8sSghw8qrAT3xHT
RfbwM4Hh2NI6xFR8VlaZcBEWStWT2nKH3Bzj6s/PCjPLk+GhAn8UolaLxPK9XKMa
oHpLZWepo/fzcXHMglQxA3JeT0PMVA==
=3gMk
-----END PGP SIGNATURE-----

--uwwnaKEfqEtGFaKvKrIFwaQN0bnBoTLvE--
