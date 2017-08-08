Received: from eggs.gnu.org ([2001:4830:134:3::10]:55425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfBF0-0007K9-MT
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 16:36:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfBEz-0007C9-HA
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 16:36:38 -0400
References: <20170808183306.27474-1-jsnow@redhat.com>
	<20170808183306.27474-4-jsnow@redhat.com>
	<45a96c91-8261-d1f7-e312-3d872051e7d8@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9ec1df21-4083-8e94-b5ed-46833c15c36c@redhat.com>
Date: Tue, 8 Aug 2017 15:36:24 -0500
MIME-Version: 1.0
In-Reply-To: <45a96c91-8261-d1f7-e312-3d872051e7d8@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="B6QlO0O7Mj92I5A0bO9OFkh2gQH6sGxfv"
Subject: Re: [Qemu-devel] [PATCH 3/9] IDE: add tracing for data ports
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--B6QlO0O7Mj92I5A0bO9OFkh2gQH6sGxfv
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
Message-ID: <9ec1df21-4083-8e94-b5ed-46833c15c36c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/9] IDE: add tracing for data ports
References: <20170808183306.27474-1-jsnow@redhat.com>
 <20170808183306.27474-4-jsnow@redhat.com>
 <45a96c91-8261-d1f7-e312-3d872051e7d8@redhat.com>
In-Reply-To: <45a96c91-8261-d1f7-e312-3d872051e7d8@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/08/2017 03:30 PM, Eric Blake wrote:
> On 08/08/2017 01:33 PM, John Snow wrote:
>> To be used sparingly, but still interesting in the case of small
>> firmwares designed to reproduce bugs in QEMU IDE.
>=20
> Is that because the trace would fire so frequently in normal usage that=

> it will drown the user in noise?
>=20
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>  hw/ide/core.c | 12 +++++++++++-
>>  1 file changed, 11 insertions(+), 1 deletion(-)
>>
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>

Argh. I had two compose windows open at once. R-b is only valid if you
fix the time-traveling trace-events changes :)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--B6QlO0O7Mj92I5A0bO9OFkh2gQH6sGxfv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmKIMgACgkQp6FrSiUn
Q2rhaAf+LTZL/UsIYZ+gNk4pOaaECizeWol1J96Lw3Oi5VZ5vG/MVbHornFt7e8T
FbEvBLsdkf9oyyMqCo8VrbBYDK3D1oSoGZv7NwksMn7knMYvrNeM6r1v+c4YV/LF
DkjsRqfU5uULPu7LMyoeDNMleMv+bt/QMVCZQTG6ovbvkYjIgiuoGmWDFEkeN/ov
wYbt1xAYFtAmn6T9hXR70+l1t8TpNAuDfKPGTs3le43W6pBRzSJYrbh3FlUaAgxr
DvyBOhWD70jMq45e7JAh1E9LJZmRkfQgzYliffVTpLJ902D14o9fqgesjdzF0YiH
VREwhHQvt0ph9XoX1hd6SFOYULHKDg==
=MlT5
-----END PGP SIGNATURE-----

--B6QlO0O7Mj92I5A0bO9OFkh2gQH6sGxfv--
