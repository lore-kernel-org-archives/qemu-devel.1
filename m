Received: from eggs.gnu.org ([2001:4830:134:3::10]:56491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ePD6d-0001FN-Mj
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 14:54:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ePD6a-0001lP-If
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 14:54:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57988)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ePD6a-0001ka-9f
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 14:54:12 -0500
References: <20170911110623.24981-1-marcandre.lureau@redhat.com>
	<20170911110623.24981-33-marcandre.lureau@redhat.com>
	<87fu8eerg3.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c7a5ba3b-9206-ed31-1273-a9e18b986bd3@redhat.com>
Date: Wed, 13 Dec 2017 13:54:07 -0600
MIME-Version: 1.0
In-Reply-To: <87fu8eerg3.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="N53aoMJxvxH3XMt1ro0frP6XFx0AQrFNc"
Subject: Re: [Qemu-devel] [PATCH v3 32/50] qapi2texi: add 'If:' section to
 generated documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--N53aoMJxvxH3XMt1ro0frP6XFx0AQrFNc
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>
Message-ID: <c7a5ba3b-9206-ed31-1273-a9e18b986bd3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 32/50] qapi2texi: add 'If:' section to
 generated documentation
References: <20170911110623.24981-1-marcandre.lureau@redhat.com>
 <20170911110623.24981-33-marcandre.lureau@redhat.com>
 <87fu8eerg3.fsf@dusky.pond.sub.org>
In-Reply-To: <87fu8eerg3.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/13/2017 06:35 AM, Markus Armbruster wrote:
> Cc: Eric for an additional pair of eyeballs.
>=20
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>=20
>> The documentation is generated only once, and doesn't know C
>> pre-conditions. Add 'If:' sections for top-level entities.
>=20
> Is this what we want?
>=20
> QMP also exists only once.  Should the generated qemu-qmp-ref.* documen=
t
> that instance of QMP, or should it document all potential instances of
> QMP?
>=20

I can go either way; it's nice to know that the binary that this copy of
documentation was bundled with only understands these terms (the binary
was compiled without HAVE_FOO, so any code guarded by HAVE_FOO doesn't
need to be documented); but that limits the usability of that
documentation to just that binary.  It's also useful to have
fully-generic documentation hosted on the website, where everything is
documented (the documentation describes all possible builds of qemu
2.12, not just the one you installed), while mentioning the conditional
nature of the documented feature ("qemu in general knows about these
things; but check your particular binary by doing XYZ to learn if that
support was compiled in to your binary").

So having typed that, I think I'm leaning slightly towards documenting
everything, including conditionals, rather than trimming the document to
match the current build conditions.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--N53aoMJxvxH3XMt1ro0frP6XFx0AQrFNc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloxhV8ACgkQp6FrSiUn
Q2qGxwf+LvIQSo0bCeKsa67HvzcxqMouxaXalA9MTSi5o1Qg+DSGUI1PAVxay4rs
J+sMCjkMgimivwD2YLeWAaMcS6Jp3/1OOX65zHOx24i+pIWo5fdKV5pW+yt1AA4B
5MsNT0GJq19zqP78/BMJnXOry51zRSy1pXs679pm6ygg+KAzD7z+E4U7ZoECiGe4
IUGzvcKGUurVULaWJpxAT2SqWPp3tVMF6tsoX4NtbFkSBXxUhXQvQnwsdDnb/t7b
x5qwRkM/qY4K76zfVzotTioCEW1AMccy2zcwUFocmAKzWrxPxQoYk9WR9HYybdH8
K7JBbjrHcQ9Udc25C6LRSshXXbpKgg==
=6KRB
-----END PGP SIGNATURE-----

--N53aoMJxvxH3XMt1ro0frP6XFx0AQrFNc--
