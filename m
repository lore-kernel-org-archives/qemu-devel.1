Received: from eggs.gnu.org ([2001:4830:134:3::10]:59822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e5cLo-0002Bo-Pb
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 14:48:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e5cLl-0003RU-Mv
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 14:48:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:13807)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1e5cLl-0003RJ-Dj
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 14:48:53 -0400
References: <150851985854.6309.16575977719112120440.stgit@bahia.lan>
From: Eric Blake <eblake@redhat.com>
Message-ID: <87522374-7a70-304b-4492-f176f4ee5e0d@redhat.com>
Date: Fri, 20 Oct 2017 13:48:50 -0500
MIME-Version: 1.0
In-Reply-To: <150851985854.6309.16575977719112120440.stgit@bahia.lan>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1rtF33dmpVFnFH9jbFrGMWTdG9vsKECuX"
Subject: Re: [Qemu-devel] [PATCH] 9pfs: fix v9fs_mark_fids_unreclaim()
 return value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1rtF33dmpVFnFH9jbFrGMWTdG9vsKECuX
From: Eric Blake <eblake@redhat.com>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Message-ID: <87522374-7a70-304b-4492-f176f4ee5e0d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] 9pfs: fix v9fs_mark_fids_unreclaim() return
 value
References: <150851985854.6309.16575977719112120440.stgit@bahia.lan>
In-Reply-To: <150851985854.6309.16575977719112120440.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/20/2017 12:17 PM, Greg Kurz wrote:
> The return value of v9fs_mark_fids_unreclaim() is then propagated to
> pdu_complete(). It should be a negative errno, not -1.

(which happens to be -EPERM on Linux. I like that GNU Hurd picked errno
values far away from 1, so that -1 is distinguishable from a negative
errno on that platform, but I haven't seen evidence of whether anyone
cares if qemu and/or 9pfs compiles on Hurd...)

>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/9pfs/9p.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--1rtF33dmpVFnFH9jbFrGMWTdG9vsKECuX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnqRRIACgkQp6FrSiUn
Q2qN5AgAkbIvpUFOYtntCEBWNTFL8ph2yrKDzbhkXPJQOtelAaCQqtAeIYqqtf3L
XvPF8C+SaKc5CLsNVkgN+v1VeKLfSFqr1d/4BDrEujUF1HlTxYMsT90Yun6kI9ci
tvImvTVrAlYO+dhSRmBG9+XJqRmwBb6zMyVV/Hvi2xO6n+Sm0H32Zyv+y+2i+tBn
zxbGHtK+S1SuJ4ptz1GBNO4FR5AfZVRPaDQ6EorARghqbtne7PNJE6ORSndWNy/v
us+k/wYwPJHToy3etM+4qc/45BU0O5b1ZwXRMFYRRLL9quliqe2qtl4HcMQJLt2c
6P+hosqZRQDqmle8i+riFNvR87Gjew==
=zbH9
-----END PGP SIGNATURE-----

--1rtF33dmpVFnFH9jbFrGMWTdG9vsKECuX--
