Received: from eggs.gnu.org ([2001:4830:134:3::10]:49174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fIHi9-00075g-C8
	for qemu-devel@nongnu.org; Mon, 14 May 2018 13:56:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fIHi8-0000pb-MA
	for qemu-devel@nongnu.org; Mon, 14 May 2018 13:56:37 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-24-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <5b487570-c0e0-43fe-bf63-935d24318622@redhat.com>
Date: Mon, 14 May 2018 19:56:30 +0200
MIME-Version: 1.0
In-Reply-To: <20180509162637.15575-24-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JuTtCeqOs9gumIAW6RWiNlVnCSFD2PFhq"
Subject: Re: [Qemu-devel] [PATCH 23/42] blockjob: Split
 block_job_event_pending()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JuTtCeqOs9gumIAW6RWiNlVnCSFD2PFhq
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <5b487570-c0e0-43fe-bf63-935d24318622@redhat.com>
Subject: Re: [PATCH 23/42] blockjob: Split block_job_event_pending()
References: <20180509162637.15575-1-kwolf@redhat.com>
 <20180509162637.15575-24-kwolf@redhat.com>
In-Reply-To: <20180509162637.15575-24-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-09 18:26, Kevin Wolf wrote:
> block_job_event_pending() doesn't only send a QMP event, but it also
> transitions to the PENDING state. Split the function so that we get one=

> part only sending the event (like other block_job_event_* functions) an=
d
> another part than does the state transition.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  blockjob.c | 27 ++++++++++++++++++---------
>  1 file changed, 18 insertions(+), 9 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--JuTtCeqOs9gumIAW6RWiNlVnCSFD2PFhq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlr5zc4ACgkQ9AfbAGHV
z0A1Uwf/aEUPTwLt5BCQMuKzzOZLeZfmq2mdYFQhOH9LIBjBckMI1bU3GXyZBuEs
e20hApHsVRNncN6ty3l8hC6U3hwAkn0ElOffVezYYrbWb159hvGOqq61KigoRvAz
2v4ZLvUZC6F9C1VddnLKp44Xe/FrhqSGwnWl6FgCPJJPdau3NAPzAGTyGMr23QLP
sRxaFvjLaKxMuUYROrHlB2qZCoomL/Wcw5RRRL18QwXLwR+B4BGEtzErJ8VwwC8y
MFRCzcWgvTMQ/CbljNhA2bjoscT6qLfqexVHFF+99aLKw7As2lzYF2RDvHKE/CB5
rgWSVgPHtS0RkcOHO33VmRlhQ1xQVA==
=0rxe
-----END PGP SIGNATURE-----

--JuTtCeqOs9gumIAW6RWiNlVnCSFD2PFhq--
