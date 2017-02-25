Received: from eggs.gnu.org ([2001:4830:134:3::10]:57436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cheWR-0005Rt-Vf
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 10:44:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cheWN-0002p5-50
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 10:44:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45356)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cheWM-0002p0-Sq
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 10:44:31 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B55B66371F
	for <qemu-devel@nongnu.org>; Sat, 25 Feb 2017 15:44:30 +0000 (UTC)
References: <1487886317-27400-1-git-send-email-armbru@redhat.com>
	<1487886317-27400-10-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4623eb6a-5cac-2a25-1173-9e94dd90ae5b@redhat.com>
Date: Sat, 25 Feb 2017 09:44:28 -0600
MIME-Version: 1.0
In-Reply-To: <1487886317-27400-10-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="oKpFhpMTOjfrcou2xgHaktNg5wC4MrOLl"
Subject: Re: [Qemu-devel] [PATCH 09/21] qapi: Improve a QObject input
 visitor error message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oKpFhpMTOjfrcou2xgHaktNg5wC4MrOLl
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <4623eb6a-5cac-2a25-1173-9e94dd90ae5b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 09/21] qapi: Improve a QObject input visitor
 error message
References: <1487886317-27400-1-git-send-email-armbru@redhat.com>
 <1487886317-27400-10-git-send-email-armbru@redhat.com>
In-Reply-To: <1487886317-27400-10-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/23/2017 03:45 PM, Markus Armbruster wrote:
> The QObject input visitor has three error message formats:
>=20
> * Parameter '%s' is missing
> * "Invalid parameter type for '%s', expected: %s"
> * "QMP input object member '%s' is unexpected"
>=20
> The '%s' are member names (or "null", but I'll fix that later).
>=20
> The last error message calls the thing "QMP input object member"
> instead of "parameter".  Misleading when the visitor is used on
> QObjects that don't come from QMP.  Change it to "Parameter '%s' is
> unexpected".
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qapi/qobject-input-visitor.c | 3 +--
>  tests/test-qga.c             | 2 +-
>  2 files changed, 2 insertions(+), 3 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--oKpFhpMTOjfrcou2xgHaktNg5wC4MrOLl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYsaZcAAoJEKeha0olJ0NqjkgH/0cYxDvC0deraZ55hTyoo9Iu
hHf9pDTvDIgGvH7EQhqrA3R4GV4HAO9SxEg8JhKA7fXdy4Dcr9DevUpMFodD4Rch
Dz85Gxt/QOeEwvMypF3Zu/xnF77Ci04wZQy1HRV51o4g0GTIbO2KR0RorELMBVE+
cfNXEa/gh7uuYhcsKnkw+niCo1/9TzxwrJX13yB1uzcfAiPTJQHkt/Wuv1XMwMhM
wIrOwH//hdiqQkGI0P+rzUiJkk8BEs/ImUuma6W5NPOf5Jr59yLwJLK3DoV+apjM
M7q0xGAs9byW3XBuw5x/cT4UyTs/oS4dK1j0s02CJDgkh/tujEEyLil2aNRLGp8=
=2hUl
-----END PGP SIGNATURE-----

--oKpFhpMTOjfrcou2xgHaktNg5wC4MrOLl--
