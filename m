Received: from eggs.gnu.org ([2001:4830:134:3::10]:59774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dmhhB-00019G-WF
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 10:40:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dmhh8-0003sq-1o
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 10:40:49 -0400
References: <20170829120836.16091-1-berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ac13cdf8-7725-8d5a-9c8b-49ad51eba38e@redhat.com>
Date: Tue, 29 Aug 2017 09:40:35 -0500
MIME-Version: 1.0
In-Reply-To: <20170829120836.16091-1-berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9gTI37VWVnWTTngGR74SUkEdMgWUerS07"
Subject: Re: [Qemu-devel] [PATCH] misc: Remove unused Error variables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-trivial <qemu-trivial@nongnu.org>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9gTI37VWVnWTTngGR74SUkEdMgWUerS07
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, qemu-trivial <qemu-trivial@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <ac13cdf8-7725-8d5a-9c8b-49ad51eba38e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] misc: Remove unused Error variables
References: <20170829120836.16091-1-berto@igalia.com>
In-Reply-To: <20170829120836.16091-1-berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/29/2017 07:08 AM, Alberto Garcia wrote:
> There's a few cases which we're passing an Error pointer to a function
> only to discard it immediately afterwards without checking it. In
> these cases we can simply remove the variable and pass NULL instead.

Could also go in via qemu-trivial or Markus' error tree (both added in
cc) if the block maintainers don't take it quickly.

>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow.c  | 12 +++---------
>  block/qcow2.c |  8 ++------
>  dump.c        |  4 +---
>  3 files changed, 6 insertions(+), 18 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--9gTI37VWVnWTTngGR74SUkEdMgWUerS07
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmlfOMACgkQp6FrSiUn
Q2qn0wf/eO7j8LYPU2hj3Tg6gfCxEVUtxc/sNzyQixGSgCo9Ud8Jan5/EVV9lJAP
XjJPAyNYQBUl5XV7WUrfjm4HDReMCn50xXQOTHcsOCP2TNfnQ6AwWJMiL3NQJFv7
o5Xk8MrLMyOMC3tcf13S6LIDCslZdVPhlDO0ezvP5GW/ldHrFnmtbe6fxWBxHP99
48GinYPKZmkT7psGklZA+/rF5vy4JJu9WPE0RG5dj2b7fgUW6AiXObe7apBSWYRt
w4z6NUO5hEkyE+TRiAzCIA6QF72WfXsWWEyrOvmSKobRvAeJjoEYJAMKqkDbtbaB
C27D9FQjya4BGB7cdzjtr5Md550hvA==
=qViJ
-----END PGP SIGNATURE-----

--9gTI37VWVnWTTngGR74SUkEdMgWUerS07--
