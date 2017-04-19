Received: from eggs.gnu.org ([2001:4830:134:3::10]:35200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0rqK-0005lP-8X
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 11:48:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0rqH-0002xn-6n
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 11:48:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42866)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d0rqG-0002xA-St
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 11:48:29 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B67E7C04B94A
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 15:48:27 +0000 (UTC)
References: <20170419144219.20371-1-pbonzini@redhat.com>
	<20170419144219.20371-2-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <25c60922-5cb3-99c4-dd60-05bf1b6faca4@redhat.com>
Date: Wed, 19 Apr 2017 10:48:26 -0500
MIME-Version: 1.0
In-Reply-To: <20170419144219.20371-2-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mUhmLSVp10bKasmiEchBeEinBwhIwUHXg"
Subject: Re: [Qemu-devel] [PATCH 01/11] blockjob: remove unnecessary check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mUhmLSVp10bKasmiEchBeEinBwhIwUHXg
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Message-ID: <25c60922-5cb3-99c4-dd60-05bf1b6faca4@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 01/11] blockjob: remove unnecessary check
References: <20170419144219.20371-1-pbonzini@redhat.com>
 <20170419144219.20371-2-pbonzini@redhat.com>
In-Reply-To: <20170419144219.20371-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/19/2017 09:42 AM, Paolo Bonzini wrote:
> !job is always checked prior to the call, drop it from here.
>=20
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  blockjob.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/blockjob.c b/blockjob.c
> index 6e48932..23022b3 100644
> --- a/blockjob.c
> +++ b/blockjob.c
> @@ -480,7 +480,7 @@ static bool block_job_should_pause(BlockJob *job)
> =20
>  bool block_job_user_paused(BlockJob *job)
>  {

Is it worth using some form of attribute((nonnull)) annotations on
various functions, to both state our intentions and let compilers help
us catch obvious places where we are violating our intentions?  That's
more of a generic question to all of qemu, and doesn't affect your
particular patch, other than your patch is an instance where the
annotation would be useful if we wanted to use them.

> -    return job ? job->user_paused : 0;
> +    return job->user_paused;
>  }
> =20
>  void coroutine_fn block_job_pause_point(BlockJob *job)
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--mUhmLSVp10bKasmiEchBeEinBwhIwUHXg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY94bKAAoJEKeha0olJ0NqAy0H/ju7Hl0dDYswVgTrtOEjPYHg
72Njdd823f9uLtVxmlzGNQlxORCIpFcC1/jNHamIxRK+2A7m/SpViMpRo2Y6ARFu
9dVi71k3okCrVInljZ1xXtviDPsPIVUB6hjCvJ04ttcaJeskUZ3JatHrlz7lhdoh
444UUqmOzTCPzz9avW4iPD0oGCJHI4tjzkhtgZpNyYf6eQcDz5UDeOTsbecySc9e
kwdphEy9oUUlfCVcix2ViJOwPMKY4k0zebtj7sXt5HgvE9hhkVqtb4lmUUJalIU5
iAMFbZbWhnAE5tEC2JmfitgTvvX9isQri5Fk/U6eMTzwQUUGipr32M3u0A++xM4=
=PBcd
-----END PGP SIGNATURE-----

--mUhmLSVp10bKasmiEchBeEinBwhIwUHXg--
