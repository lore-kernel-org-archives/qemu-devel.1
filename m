Received: from eggs.gnu.org ([2001:4830:134:3::10]:36435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1duf1p-0002vF-A8
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:27:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1duf1M-00042b-3p
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:27:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52302)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1duf1L-00042C-R9
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:26:32 -0400
References: <20170919180038.26056-1-dgilbert@redhat.com>
	<20170919180038.26056-6-dgilbert@redhat.com>
	<20170920035512.GF18491@lemon>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5b02462e-99c3-eb72-3481-93a26fc405e4@redhat.com>
Date: Wed, 20 Sep 2017 08:26:22 -0500
MIME-Version: 1.0
In-Reply-To: <20170920035512.GF18491@lemon>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="jj3e063sv0Gnj0TIdrqOqKiCqqMdS7KnO"
Subject: Re: [Qemu-devel] [PATCH 5/5] migration: Route more error paths
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: peter.maydell@linaro.org, quintela@redhat.com, cohuck@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com, rth@twiddle.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jj3e063sv0Gnj0TIdrqOqKiCqqMdS7KnO
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>,
 "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: peter.maydell@linaro.org, quintela@redhat.com, cohuck@redhat.com,
 qemu-devel@nongnu.org, peterx@redhat.com, rth@twiddle.net
Message-ID: <5b02462e-99c3-eb72-3481-93a26fc405e4@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 5/5] migration: Route more error paths
References: <20170919180038.26056-1-dgilbert@redhat.com>
 <20170919180038.26056-6-dgilbert@redhat.com> <20170920035512.GF18491@lemon>
In-Reply-To: <20170920035512.GF18491@lemon>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/19/2017 10:55 PM, Fam Zheng wrote:
> On Tue, 09/19 19:00, Dr. David Alan Gilbert (git) wrote:
>> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>>
>> vmstate_save is called in a few places, and vmstate_save_state is
>> called in lots of places.
>>
>> Route error returns from the easier cases back up;  there are lots
>> of more complex cases where there own error paths need fixing.
>=20

>> +++ b/tests/test-vmstate.c
>> @@ -70,7 +70,7 @@ static void save_vmstate(const VMStateDescription *d=
esc, void *obj)
>>      QEMUFile *f =3D open_test_file(true);
>> =20
>>      /* Save file with vmstate */
>> -    vmstate_save_state(f, desc, obj, NULL);
>> +    g_assert(!vmstate_save_state(f, desc, obj, NULL));
>=20
> Though this is test code, isn't putting anything with a side effect int=
o an
> assert expression a very bad pattern in general?

Indeed - although we don't disable asserts (as of commit 262a69f4), this
should still be separated into running vmstate_save_state()
unconditionally, then asserting that the result stored into a temporary
variable matches expectations.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--jj3e063sv0Gnj0TIdrqOqKiCqqMdS7KnO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnCbH4ACgkQp6FrSiUn
Q2psVwf+N/mHXchr6CVu8h+rfJejFkaRgrMm9UZd/iQiTksiv4fRxW0W0WGdgGPK
1b298sCYhsEAjA2pGXa5pEKH7MGjw47Xrxi3CTf/9IMj8pqWynuzTfW5x8utDMEl
vFwID88fw5ytPusQeIv3GK4MbJVOjelOf0Z8axstJDgyPkAtaShNLDXK4tr9vVCs
DpI45eiYTp4ZMbwZFT8OuoLCsdJobJ1G32XWnakeNgZW2vUAFUS87kovAzbQa3Eq
HBkOlyL270/l+zb0A+WdIBzZiX1dfV8IIhdzA5HW2dpLb548rLdd73Jw5XSaXDNW
Lz3RsBjM07rYOP6EMmwXl028A44N7Q==
=9mh0
-----END PGP SIGNATURE-----

--jj3e063sv0Gnj0TIdrqOqKiCqqMdS7KnO--
