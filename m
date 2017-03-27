Received: from eggs.gnu.org ([2001:4830:134:3::10]:54758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1csaLu-00030b-Qo
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 15:30:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1csaLr-00013V-Tn
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 15:30:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:5042)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1csaLr-000126-LB
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 15:30:51 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B5996804F1
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 19:30:50 +0000 (UTC)
References: <1490621195-2228-1-git-send-email-armbru@redhat.com>
	<1490621195-2228-9-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <88f70b55-a43b-2515-7150-d0501557256c@redhat.com>
Date: Mon, 27 Mar 2017 14:30:43 -0500
MIME-Version: 1.0
In-Reply-To: <1490621195-2228-9-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="blC0hR64FvEkMHWTo7pHK1oK7DvAtiG7B"
Subject: Re: [Qemu-devel] [PATCH RFC v3 for-2.9 08/11] rbd: Revert -blockdev
 and -drive parameter auth-supported
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: jdurgin@redhat.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--blC0hR64FvEkMHWTo7pHK1oK7DvAtiG7B
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: jdurgin@redhat.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com
Message-ID: <88f70b55-a43b-2515-7150-d0501557256c@redhat.com>
Subject: Re: [PATCH RFC v3 for-2.9 08/11] rbd: Revert -blockdev and -drive
 parameter auth-supported
References: <1490621195-2228-1-git-send-email-armbru@redhat.com>
 <1490621195-2228-9-git-send-email-armbru@redhat.com>
In-Reply-To: <1490621195-2228-9-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/27/2017 08:26 AM, Markus Armbruster wrote:
> This reverts half of commit 0a55679.  We're having second thoughts on
> the QAPI schema (and thus the external interface), and haven't reached
> consensus, yet.  Issues include:
>=20

> Let's avoid painting ourselves into a corner now, and revert the
> feature for 2.9.

There may still be some tweaks to improve the commit message and/or code
comments to clarify things that tripped me up until later in the
subthread, but now that I understand the difference between pseudo-file
format (where the key-value pair backdoor still works for libvirt's
usage of -drive file=3Drbd:...) and QemuOpts format (-drive driver=3Drbd,=
=2E..
which didn't really exist in 2.8, and where we don't want to bake in
something we don't like in 2.9), I agree with the move.

>=20
> Note that users can still configure authentication methods with a
> configuration file.  They probably do that anyway if they use Ceph
> outside QEMU as well.
>=20
> qemu_rbd_array_opts()'s parameter @type now must be RBD_MON_HOST,
> which is silly.  This will be cleaned up shortly.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  block/rbd.c          | 31 +++----------------------------
>  qapi/block-core.json | 24 ------------------------
>  2 files changed, 3 insertions(+), 52 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--blC0hR64FvEkMHWTo7pHK1oK7DvAtiG7B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY2WhjAAoJEKeha0olJ0NqgHUIAJJGXEUOFpUWaaksMTNCKxl0
VAPJrtb9vADwL/jbB+aGQI3omjuYxTCS2WncJ1Cwex5g0uBTBzJic9Rh/xVNYJHf
hhtFAtLvlW9qe0pKKplzJBOvZ0Bmn6GWs9dVT2NbJ0UXrjjI8DAkQgzlyPEaNKRQ
G5XHO5D2dwscXGOSq2CiI7ZhMhdKdeHGiqYoo7AaMF+lndCMnCNZMW3SXS8bnAmb
Vm5/dlmAEdmmeZumf4NkmdXUewBTOpuBxBl14LBCJkOZwAkmf7OUGOk5u9ZSqZik
TilYsCJUqAGCu1l5kmGxYTgJ44xtmSf8A5zle9Z/8DP9sS31OQ6YzMKBne6vaWg=
=lyP7
-----END PGP SIGNATURE-----

--blC0hR64FvEkMHWTo7pHK1oK7DvAtiG7B--
