Received: from eggs.gnu.org ([2001:4830:134:3::10]:52215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eHd0f-0004Am-NX
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 16:56:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eHd0d-000622-31
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 16:56:44 -0500
References: <20171122101958.17065-1-vsementsov@virtuozzo.com>
	<20171122101958.17065-5-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <29b61d23-ddb9-962f-9913-4139598b18b8@redhat.com>
Date: Wed, 22 Nov 2017 15:56:34 -0600
MIME-Version: 1.0
In-Reply-To: <20171122101958.17065-5-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="VnHiTuQgjpid9JxJ251P8URqcFcAx2WFr"
Subject: Re: [Qemu-devel] [PATCH 4/5] nbd: rename nbd_option and
 nbd_opt_reply
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, kwolf@redhat.com, mreitz@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VnHiTuQgjpid9JxJ251P8URqcFcAx2WFr
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, kwolf@redhat.com, mreitz@redhat.com, den@openvz.org
Message-ID: <29b61d23-ddb9-962f-9913-4139598b18b8@redhat.com>
Subject: Re: [PATCH 4/5] nbd: rename nbd_option and nbd_opt_reply
References: <20171122101958.17065-1-vsementsov@virtuozzo.com>
 <20171122101958.17065-5-vsementsov@virtuozzo.com>
In-Reply-To: <20171122101958.17065-5-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/22/2017 04:19 AM, Vladimir Sementsov-Ogievskiy wrote:
> Rename nbd_optino and nbd_opt_reply to NBDOption and NBDOptionReply

s/optino/option/

> to correspond to Qemu coding style and other structures here.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  include/block/nbd.h |  8 ++++----
>  nbd/client.c        | 12 ++++++------
>  2 files changed, 10 insertions(+), 10 deletions(-)
>=20
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--VnHiTuQgjpid9JxJ251P8URqcFcAx2WFr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloV8pIACgkQp6FrSiUn
Q2peIQf+Py3Zu365m5hUcVFa6o0mEuZm4PZopNzmUb6IoIhEmlzywwoZ+ObNzP+w
9F0CtHZQ1v061Zcrn6/2d7MYJlP3MvcaFzT7EhOLcg6NVvkSJn3iStil9GQfPLJ0
6wwlcxxnTg0VTL7WCTtwvjeuOcS+cQwRhDJVmEMkTb2ks2s8jQUOv+i8LSwFzfwS
CRhTM9zy7Ct/0aIBGTxYtKJcFWr5ZL8mLMXwPMsigAg1rGIVk+iMBa8/jO//KRCd
y8/BnQhzcknYUqiIUSGmkaKH5BfuNL3AqPssg/COdfkkGRl/Eg7C9IOXmZbHkmEW
QbXd+S74gk2E0wQwlD1K5ejSNe59xg==
=/mXY
-----END PGP SIGNATURE-----

--VnHiTuQgjpid9JxJ251P8URqcFcAx2WFr--
