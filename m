Received: from eggs.gnu.org ([209.51.188.92]:55414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gpdeM-00069R-R6
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 13:34:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gpdeL-00084o-VY
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 13:34:50 -0500
References: <20190128165830.165170-1-vsementsov@virtuozzo.com>
	<eb482fb2-5934-c786-1b23-f46054bbdb39@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a24a7b8b-83ce-3787-162f-ace7c09d362c@redhat.com>
Date: Fri, 1 Feb 2019 12:34:36 -0600
MIME-Version: 1.0
In-Reply-To: <eb482fb2-5934-c786-1b23-f46054bbdb39@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="S8IkVhWS4NRtL6yx3s6iCscvgVgp3eJOG"
Subject: Re: [Qemu-devel] [PATCH] nbd: generalize usage of nbd_read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--S8IkVhWS4NRtL6yx3s6iCscvgVgp3eJOG
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com
Message-ID: <a24a7b8b-83ce-3787-162f-ace7c09d362c@redhat.com>
Subject: Re: [PATCH] nbd: generalize usage of nbd_read
References: <20190128165830.165170-1-vsementsov@virtuozzo.com>
 <eb482fb2-5934-c786-1b23-f46054bbdb39@redhat.com>
In-Reply-To: <eb482fb2-5934-c786-1b23-f46054bbdb39@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/1/19 12:27 PM, Eric Blake wrote:

>=20
>=20
>> +
>> +#define DEF_NBD_READ(bits) \
>> +static inline int nbd_read ## bits(QIOChannel *ioc, uint ## bits ## _=
t * val, \
>=20
> checkpatch didn't flag it, but I think our style is '*val', not '* val'=
=2E

But it DOES flag '*val' as a false positive.  Oh well.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--S8IkVhWS4NRtL6yx3s6iCscvgVgp3eJOG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxUkTwACgkQp6FrSiUn
Q2oNsQf/VJumbwljAw8Yq+UAezZYIaZf9yVOP3yGhbiodGwqoT/eYmnqrzIrcV5V
ArG1wKhNrw035Yuy0o5P0GUwSrI20uQ1RQeZ+WOYZSMnIzW9HDkHreStiowWd/t/
S1wlHZKXHpRI/VPNkSyu7TROA5QiIJtoAt7/O34SHQ9/zIUg/b0bL7MfSQYdYu89
uozc+UBuxKQlqUHyc+30K1iTCI+BTQRpgxkOwMnHnBvzn0CmzRE4UqiEJD+RDIV/
1qQpGv1MWG6oxFKuAXRWeCxQ6W+cz3T6gtLkixOF5thJV7lTSx4DybAcGyy3MfiP
KvjJo+atf8GXbEKglbP4d8SsOUoFzQ==
=hYOa
-----END PGP SIGNATURE-----

--S8IkVhWS4NRtL6yx3s6iCscvgVgp3eJOG--
