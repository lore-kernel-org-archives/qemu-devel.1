Received: from eggs.gnu.org ([2001:4830:134:3::10]:37888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnoAy-0001EH-6q
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 11:15:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnoAx-0007Lw-A7
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 11:15:52 -0400
References: <1489478243-10366-1-git-send-email-jemmy858585@gmail.com>
	<420d9095-bde2-6573-e883-ab6b57d4a860@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <12d49a77-0a1d-6488-5652-2c09643a7b05@redhat.com>
Date: Tue, 14 Mar 2017 10:15:36 -0500
MIME-Version: 1.0
In-Reply-To: <420d9095-bde2-6573-e883-ab6b57d4a860@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hd6D4XoQEmlQNxHJ7jDJcAHbH07pf4hLO"
Subject: Re: [Qemu-devel] [PATCH] migration/block: Avoid involve into
 blk_drain too frequently
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jemmy858585@gmail.com, stefanha@redhat.com, famz@redhat.com, quintela@redhat.com, dgilbert@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hd6D4XoQEmlQNxHJ7jDJcAHbH07pf4hLO
From: Eric Blake <eblake@redhat.com>
To: jemmy858585@gmail.com, stefanha@redhat.com, famz@redhat.com,
 quintela@redhat.com, dgilbert@redhat.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Message-ID: <12d49a77-0a1d-6488-5652-2c09643a7b05@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] migration/block: Avoid involve into
 blk_drain too frequently
References: <1489478243-10366-1-git-send-email-jemmy858585@gmail.com>
 <420d9095-bde2-6573-e883-ab6b57d4a860@redhat.com>
In-Reply-To: <420d9095-bde2-6573-e883-ab6b57d4a860@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/14/2017 10:12 AM, Eric Blake wrote:
> On 03/14/2017 02:57 AM, jemmy858585@gmail.com wrote:
>> From: Lidong Chen <jemmy858585@gmail.com>
>>
>> Increase bmds->cur_dirty after submit io, so reduce the frequency invo=
lve into blk_drain, and improve the performance obviously when block migr=
ation.
>=20
> Long line; please wrap your commit messages, preferably around 70 bytes=

> since 'git log' displays them indented, and it is still nice to read
> them in an 80-column window.

Also, in the subject:

s/involve into/invoking/

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--hd6D4XoQEmlQNxHJ7jDJcAHbH07pf4hLO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYyAkYAAoJEKeha0olJ0NqRYsH+wcMPfzFSHrBE4COUOw62vCv
uSyFIrngw76UNtGU/S6+NLarqPNGrn0rCA2VFmGi6KYOx2ZYm72sI7JaWHnMzgKb
OBMDfij0BEXbqKyAIxed0jzVZeqAnyeOY94lI8+4S2zF15C9KpZKG7an9gC19Y+y
vYTca+Khn4kYQsLfaDS9mEa47VMkYknVI7n4vZyknMhaBr1Pz1d1blU1qChvk9un
ca4tkCv+v5zhUWqEAgxOTKdUKEUcLP71jjJEI3Piisaf3OWJEpQJ1499nbDCwTC2
9h1t4CDAQobxsPMsgQ9xaDPKR4GO7oEoirKeJjZp7TtzLRVrJypI9FinqWCN8oo=
=0i+F
-----END PGP SIGNATURE-----

--hd6D4XoQEmlQNxHJ7jDJcAHbH07pf4hLO--
