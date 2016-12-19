Received: from eggs.gnu.org ([2001:4830:134:3::10]:42373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cIzuY-0002KX-Ah
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 10:31:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cIzuX-0001Jv-9o
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 10:31:34 -0500
References: <1482187106-85065-1-git-send-email-sochin.jiang@huawei.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <59e42380-f605-2a93-c4bc-17cec914fcfe@redhat.com>
Date: Mon, 19 Dec 2016 09:31:24 -0600
MIME-Version: 1.0
In-Reply-To: <1482187106-85065-1-git-send-email-sochin.jiang@huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XQx0OVKt5LOxMSAeeAEQwDNocG6gq1I4A"
Subject: Re: [Qemu-devel] [PATCH] mirror: prevent 'top' mode mirroring when
 no backing file specified on the destination
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: sochin jiang <sochin.jiang@huawei.com>, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com
Cc: xieyingtai@huawei.com, qemu-block@nongnu.org, subo7@huawei.com, eric.fangyi@huawei.com, qemu-devel@nongnu.org, wangjie88@huawei.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XQx0OVKt5LOxMSAeeAEQwDNocG6gq1I4A
From: Eric Blake <eblake@redhat.com>
To: sochin jiang <sochin.jiang@huawei.com>, jcody@redhat.com,
 kwolf@redhat.com, mreitz@redhat.com
Cc: xieyingtai@huawei.com, qemu-block@nongnu.org, subo7@huawei.com,
 eric.fangyi@huawei.com, qemu-devel@nongnu.org, wangjie88@huawei.com
Message-ID: <59e42380-f605-2a93-c4bc-17cec914fcfe@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] mirror: prevent 'top' mode mirroring when no
 backing file specified on the destination
References: <1482187106-85065-1-git-send-email-sochin.jiang@huawei.com>
In-Reply-To: <1482187106-85065-1-git-send-email-sochin.jiang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/19/2016 04:38 PM, sochin jiang wrote:
>  Mirroring using 'top' mode without backing file specified on the targe=
t can be success,
>  but end with a disaster.
>=20
>  For example:
>    Migration can be success in this situation while the virtual machine=
 on the destination
>  is no longer usable because of backing lost.
>=20

I think this is a premature policy decision.  Even though the user can
abuse it to lose data, I think there is still enough technical reason
for why a user might have a valid use case for doing this (perhaps for
creating incremental backups, where the user plans on re-chaining data
back together using 'qemu-img rebase -u'), so I don't think we should
forbid it at the qemu level.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--XQx0OVKt5LOxMSAeeAEQwDNocG6gq1I4A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYV/1MAAoJEKeha0olJ0NqB4oH/3DoP/lfKx1/rbA79YvMu4Di
qlFTiVZYyGCv6N8oPYrn1W9Q42Vdwi6KzjTOjR6s2F/Ez5N4PAj7RRSXtrlZel14
tv38ERYtv9ynT8UWL6+bMM0/5HpaA8eU92hX4PVAWvUvGQtn/wJsfmPsFqopi7Ue
oeH9VyAyvbyGH2pCkYwdl7EU1AD9ZikCZy65D63FcUNfPbfgI45pY4BeobdKWFXP
YqYDZTmNa13idhcX3kzo+ltUgAJepjxgk8V8lhlw6zo/kMtpWRv1B9lPNLzuxg1F
6Ze8jMDYM3CohLvpxldkKfoS2gEZ+eWUBlBX3LYeRA4JmtBcosc2wyAym1ElEtY=
=lF/P
-----END PGP SIGNATURE-----

--XQx0OVKt5LOxMSAeeAEQwDNocG6gq1I4A--
