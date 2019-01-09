Received: from eggs.gnu.org ([209.51.188.92]:55992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghHKO-00066N-EG
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 12:07:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghHKN-0002jB-JV
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 12:07:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49082)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ghHKN-0002iT-AU
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 12:07:39 -0500
References: <20180906111107.30684-1-danielhb413@gmail.com>
	<47023eb5-41f1-1b60-1094-d607999e93b6@redhat.com>
	<a030d899-5a1a-b8b9-4c59-cca4bc304c1d@gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dabcb93d-050d-b64f-a995-8f066b325c70@redhat.com>
Date: Wed, 9 Jan 2019 11:07:36 -0600
MIME-Version: 1.0
In-Reply-To: <a030d899-5a1a-b8b9-4c59-cca4bc304c1d@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="i1enR5EDGs9V78ZS8QJi0XHTaD6XgIJrL"
Subject: Re: [Qemu-devel] [PATCH v2 0/3] HMP/snapshot changes - do not use
 ID anymore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb413@gmail.com>, Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, muriloo@linux.ibm.com, dgilbert@redhat.com, armbru@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--i1enR5EDGs9V78ZS8QJi0XHTaD6XgIJrL
From: Eric Blake <eblake@redhat.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, muriloo@linux.ibm.com, dgilbert@redhat.com,
 armbru@redhat.com
Message-ID: <dabcb93d-050d-b64f-a995-8f066b325c70@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/3] HMP/snapshot changes - do not use ID
 anymore
References: <20180906111107.30684-1-danielhb413@gmail.com>
 <47023eb5-41f1-1b60-1094-d607999e93b6@redhat.com>
 <a030d899-5a1a-b8b9-4c59-cca4bc304c1d@gmail.com>
In-Reply-To: <a030d899-5a1a-b8b9-4c59-cca4bc304c1d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/9/19 10:57 AM, Daniel Henrique Barboza wrote:

>> I think we had a short discussion about just disallowing numeric
>> snapshot names.=C2=A0 How bad would that be?
>=20
>=20
> This was my first idea when evaluating what to do in this case. I gave
> it up because
> I found it to be too extreme. People would start complaining "I was abl=
e
> to do
> savevm 0 and now I can't".

I could live with that, especially if it serves to prevent even more
bugs of "I did this and now my image is broken" (I, for one, have known
about the confusion of breaking an image by using a number as a snapshot
name as far back as 2011). What I can't live with is:

"I have an old image where I did savevm 0, and now want to modernize the
image, but the new tools refuse to even let me read from name 0".

I also agree that the code is already so hairy, and the reason we have
punted on solving the issue (for 8 years now!) is because there are so
many corner cases to consider.  It also means that I'm reluctant to
review the patch, because it will require a significant chunk of time
and mental effort to ensure that whatever patch is proposed does not
break something important.  But in general, I'm glad that you are trying
to get the issue fixed, even if the conversation on HOW to fix it is
still undergoing a choice of bikeshed paint colors.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--i1enR5EDGs9V78ZS8QJi0XHTaD6XgIJrL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEY3OaSlgimHGqKqRv3g5py3orov0FAlw2KlgACgkQ3g5py3or
ov1BQQgAl3ioenAVaPSUEigt/KJAYOSM1N0gig3zAu5e/s7Sfqth8/N9qIEmNN/G
JvUrUCuLYY8yyB7o4v+muA6HXRiPGy5lwL93thpGt3ivK9/xdeIVJ05tW0JL4cbh
O5HA7M4xq8SeDFhLsH1diG0b9UbvjbOilvql91l6MhVtNoBoY9GR+a4GKjmGWQdq
zes4PKV+qUOA8gK7d48KX+zmn40SwNszQ/2Hl9A6gXdtWbQYP/lSzY4HhtUXxAoX
xPpTb6y3JPEZvqEc/yX5nvIMiCRCererVnTKUL3oAIDQNLe+ma1bHZJXxoV1ErDo
8WZtTFChDaeWPx+xALQfzYE3MryZ6w==
=LtWg
-----END PGP SIGNATURE-----

--i1enR5EDGs9V78ZS8QJi0XHTaD6XgIJrL--
