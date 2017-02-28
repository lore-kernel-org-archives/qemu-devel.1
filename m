Received: from eggs.gnu.org ([2001:4830:134:3::10]:48176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cir6r-0000n4-Bo
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 18:23:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cir6q-0000Tz-Au
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 18:23:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33918)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cir6q-0000TW-2T
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 18:23:08 -0500
References: <20170221141451.28305-1-marcandre.lureau@redhat.com>
	<CAJ+F1C+67=zo_u0Ae0r08tpxbSFU3VmVe_NLu6Pdq0wV6_sC0w@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <45c20324-927b-a843-bcdd-a4d438ec2bc9@redhat.com>
Date: Tue, 28 Feb 2017 17:23:06 -0600
MIME-Version: 1.0
In-Reply-To: <CAJ+F1C+67=zo_u0Ae0r08tpxbSFU3VmVe_NLu6Pdq0wV6_sC0w@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="VJKHgmjr4VGTPLngVlqIADiKSQ4QNbpp4"
Subject: Re: [Qemu-devel] [PATCH v2 00/30] Various memory leak fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VJKHgmjr4VGTPLngVlqIADiKSQ4QNbpp4
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 qemu-devel@nongnu.org
Message-ID: <45c20324-927b-a843-bcdd-a4d438ec2bc9@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 00/30] Various memory leak fixes
References: <20170221141451.28305-1-marcandre.lureau@redhat.com>
 <CAJ+F1C+67=zo_u0Ae0r08tpxbSFU3VmVe_NLu6Pdq0wV6_sC0w@mail.gmail.com>
In-Reply-To: <CAJ+F1C+67=zo_u0Ae0r08tpxbSFU3VmVe_NLu6Pdq0wV6_sC0w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/27/2017 05:04 AM, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Tue, Feb 21, 2017 at 6:27 PM Marc-Andr=C3=A9 Lureau <
> marcandre.lureau@redhat.com> wrote:
>=20
>> After this series removing a few memory leaks, make check with ASAN
>> enabled gives a "clean" run with x86_64-softmmu target (there are
>> warnings related to coroutine makecontext/swapcontext).
>>
>> This should help spot memory related regressions when introducing one.=

>>
>> Note: some of these patches were sent and reviewed previously but not
>> yet applied, I rebased them and included them here for completeness.
>>
>=20
> The series is missing reviews of the following patches: 8, 9, 11, 12, 1=
7,
> 19, 20, 28, 29
>=20
> Any volunteer? Thanks!

I think we've covered it all now; if not, ping me for another review.

As these are leak fixes, I think they are appropriate even if your pull
request missed soft freeze.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--VJKHgmjr4VGTPLngVlqIADiKSQ4QNbpp4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYtgZaAAoJEKeha0olJ0NqyXcH/3VW3ge118IsjwD5vFfj68/x
Ni/UOyCl/2FF9BDM4nJe5ZOhPKLkRpU7lk6KWfflV/9TVnuZPuu0BLaLocEN6Hts
7vuQ5fb0t/4UmVwVY2354pOy8faevvPWziE2oPL50M00kdDo1BNQJKTyKj4XoRwi
FvLs/yz/iA9+3gNqYl+xwOWLieneZWycRIcI//D6+kkpfb5u6XAcUK22uLS67ii+
MvYpgLh81onwxEJxjgnLRYOlDaPRaPm9gRTPHZob/1vO5eKKyw71+GDBKav5W52s
EgRKPv/acrzmNlW6wXduWrLKlF2NzXmsmAnZFNY+GEsHLQKTxWDuIyxtyMAIHcE=
=PRCX
-----END PGP SIGNATURE-----

--VJKHgmjr4VGTPLngVlqIADiKSQ4QNbpp4--
