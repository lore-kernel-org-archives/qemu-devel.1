Received: from eggs.gnu.org ([2001:4830:134:3::10]:54365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ckyGJ-0000jC-8P
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 14:25:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ckyGI-00040b-Fc
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 14:25:39 -0500
References: <1488826849-32384-1-git-send-email-armbru@redhat.com>
	<1488826849-32384-3-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <77b194be-5cb5-472e-cc94-8533aba177b3@redhat.com>
Date: Mon, 6 Mar 2017 13:25:29 -0600
MIME-Version: 1.0
In-Reply-To: <1488826849-32384-3-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ub7rIOWeVlvvJG6caIslc2NGFltbqiqJC"
Subject: Re: [Qemu-devel] [PATCH v2 02/15] sheepdog: Fix error handling in
 sd_snapshot_delete()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, jcody@redhat.com, ndevos@redhat.com, f4bug@amsat.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ub7rIOWeVlvvJG6caIslc2NGFltbqiqJC
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mitake.hitoshi@lab.ntt.co.jp,
 namei.unix@gmail.com, jcody@redhat.com, ndevos@redhat.com, f4bug@amsat.org
Message-ID: <77b194be-5cb5-472e-cc94-8533aba177b3@redhat.com>
Subject: Re: [PATCH v2 02/15] sheepdog: Fix error handling in
 sd_snapshot_delete()
References: <1488826849-32384-1-git-send-email-armbru@redhat.com>
 <1488826849-32384-3-git-send-email-armbru@redhat.com>
In-Reply-To: <1488826849-32384-3-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/06/2017 01:00 PM, Markus Armbruster wrote:
> As a bdrv_snapshot_delete() method, sd_snapshot_delete() must set an
> error and return negative errno on failure.  It sometimes returns -1,
> and sometimes neglects to set an error.  It also prints error messages
> with error_report().  Fix all that.
>=20
> Moreover, its handling of an attempt to delete an nonexistent snapshot

s/an nonexistent/a nonexistent/

> is wrong: it error_report()s and succeeds.  Fix it to set an error and
> return -ENOENT instead.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  block/sheepdog.c | 41 +++++++++++++++++++----------------------
>  1 file changed, 19 insertions(+), 22 deletions(-)

R-by stands.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--ub7rIOWeVlvvJG6caIslc2NGFltbqiqJC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYvbepAAoJEKeha0olJ0Nq6coH/j9lZsP1rfibCSnN3Pt610fc
knNee5pdrhkDFgiRoOlEHjo3Aaow+f8MT3bEqf+NxYUiJlTkhfEFj9/i7NBb0wus
bcfsoau00KqpL/pd+ulwa87o9XqX2A6BFqOenivXLlqcFcESTGXp/dQSx/1ctwA3
l5cMKFhLFXiVtVqumvF6QcwJNK6dbHl445S33/s8Ic5d9W+DxAm1Rb8FxC2Jqko5
+Wq/zXPjtecJVRtOMEZe44oFWdKxEhQBfqtZgYJED7QXkH3pRShK13tfCjXT4y/a
YEztm7eMUIpMfJ5nXAx+YILiDkhgacTA0czJazPk+KTP5LE+DCdTSaAQJvx/SRg=
=9KUy
-----END PGP SIGNATURE-----

--ub7rIOWeVlvvJG6caIslc2NGFltbqiqJC--
