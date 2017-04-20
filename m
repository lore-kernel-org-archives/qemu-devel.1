Received: from eggs.gnu.org ([2001:4830:134:3::10]:59960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d1BwU-0000i4-9a
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 09:16:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d1BwQ-0004G7-21
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 09:16:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40424)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d1BwP-0004FD-Ga
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 09:16:09 -0400
References: <1492685851-27921-1-git-send-email-lu.zhipeng@zte.com.cn>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b88c7ee7-0221-8166-72af-64e172e5056f@redhat.com>
Date: Thu, 20 Apr 2017 08:16:05 -0500
MIME-Version: 1.0
In-Reply-To: <1492685851-27921-1-git-send-email-lu.zhipeng@zte.com.cn>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GViAcdwBA3lb1EUpMfC22MexXNxGtUE4j"
Subject: Re: [Qemu-devel] [PATCH] qga: Add support network interface
 statistics in guest-network-get-interfaces command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ZhiPeng Lu <lu.zhipeng@zte.com.cn>, mdroth@linux.vnet.ibm.com
Cc: berrange@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GViAcdwBA3lb1EUpMfC22MexXNxGtUE4j
From: Eric Blake <eblake@redhat.com>
To: ZhiPeng Lu <lu.zhipeng@zte.com.cn>, mdroth@linux.vnet.ibm.com
Cc: berrange@redhat.com, qemu-devel@nongnu.org
Message-ID: <b88c7ee7-0221-8166-72af-64e172e5056f@redhat.com>
Subject: Re: [PATCH] qga: Add support network interface statistics in
 guest-network-get-interfaces command
References: <1492685851-27921-1-git-send-email-lu.zhipeng@zte.com.cn>
In-Reply-To: <1492685851-27921-1-git-send-email-lu.zhipeng@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/20/2017 05:57 AM, ZhiPeng Lu wrote:
> we can get the  network interface statistics inside  a virtual machine =
by
> guest-network-get-interfaces command.
> it is very userful for us to monitor and analyze network traff.
>=20
> Signed-off-by: ZhiPeng Lu <lu.zhipeng@zte.com.cn>
> Signed-off-by: DanielP.Berrange <berrange@redhat.com>
> Reviewed-by: EricBlake  <eblake@redhat.com>
> ---
>  qga/commands-posix.c | 73 ++++++++++++++++++++++++++++++++++++++++++++=
+++++++-
>  qga/qapi-schema.json | 28 +++++++++++++++++++-
>  2 files changed, 99 insertions(+), 2 deletions(-)

It looks like you resent this as v2; see my comments there. It will need =
v3.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--GViAcdwBA3lb1EUpMfC22MexXNxGtUE4j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY+LSVAAoJEKeha0olJ0Nq0yIH/3U8OrwRyPkRfdAeTnQu0dqf
uRBKhPZlyOWhbdLzN3ksJVCgEZzCVv/H6p83lXCR8YVIGYTvYmBKtyboI54pwkQ5
W6c/6JgqRcMN4+or0lwQB5pG9PSU+Pn9VBQ+bOpQmIzWbIhYigvl5Vm5nn+fvkuR
CqKafWZL8n8cZQvXiRZ+OqetbZcmXx2IeL7IRyWPO6RAPS6+tsxJm/vQpVRf/m2w
fol4LUSLovqZqO0sp2QmJ3MdjMOrXemFidWoFmRqGPV/NTB+hqh6H1qE06qlmU0m
l47orpZl7b9UtnZA5RKTKk6Jb1I4ICdRZ1+WK6gj/RoHC5MK9tUff4/jj2skoX4=
=6JwQ
-----END PGP SIGNATURE-----

--GViAcdwBA3lb1EUpMfC22MexXNxGtUE4j--
