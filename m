Received: from eggs.gnu.org ([2001:4830:134:3::10]:39915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f9bMt-0006tG-UR
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 15:06:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f9bMq-0003wC-Q5
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 15:06:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60826 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f9bMq-0003vk-J6
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 15:06:44 -0400
References: <m2efj9q2i2.fsf@gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d540f8da-3f0a-71a9-0050-8e8f95153f1c@redhat.com>
Date: Fri, 20 Apr 2018 14:06:31 -0500
MIME-Version: 1.0
In-Reply-To: <m2efj9q2i2.fsf@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="45QMQyEa3wgM5TDcGh6FhUUgUNKOiGuuF"
Subject: Re: [Qemu-devel] qemu-io read do not dump buffer when in quiet mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Junpeng.Li" <ctlaltlaltc@gmail.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--45QMQyEa3wgM5TDcGh6FhUUgUNKOiGuuF
From: Eric Blake <eblake@redhat.com>
To: "Junpeng.Li" <ctlaltlaltc@gmail.com>, qemu-devel@nongnu.org
Message-ID: <d540f8da-3f0a-71a9-0050-8e8f95153f1c@redhat.com>
Subject: Re: [Qemu-devel] qemu-io read do not dump buffer when in quiet mode
References: <m2efj9q2i2.fsf@gmail.com>
In-Reply-To: <m2efj9q2i2.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/20/2018 11:14 AM, Junpeng.Li wrote:
>=20
> Hi, everyone. I found a question or maybe a bug during use qemu-io to r=
ead
> a range file and take the params -vq to dump buffer and do not show
> I/O statistics. I use the params -vq what i want is just dump buffer
> but do not show I/O statistics, but as the result show it is not.
>=20
> Like below command, it do not dump buffer to standard output.
>=20
> qemu-io -r -c "read -vq 0 1024" /tmp/test.qcow2
>=20
> I saw the source code, when has qflag value it just goto out and do
> not dump buffer when qflag and vflag has value at the same time.
>=20
>     if (qflag) {
>         goto out;
>     }
>=20
>     if (vflag) {
>         dump_buffer(buf, offset, qiov.size);
>     }
>=20
> quiet mode here, it mean do not show I/O statistics or mean complete qu=
iet?

You're welcome to provide a patch to make it have saner behavior.  As
long as running qemu-iotests doesn't break, we are pretty much free to
refactor qemu-io as it is more a tool for internal testing than for
external use.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--45QMQyEa3wgM5TDcGh6FhUUgUNKOiGuuF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlraOjwACgkQp6FrSiUn
Q2o0hwgAsLAnH5A3pEle37BbLccbZrOmw4JWOedGSlJTLSu6XZtFWk66anwXBAir
JJbl0JhXysIcm/t0hXoc8Zyk4wx6l8tlX28pL6tbkskDNPxV8ARc17n3mFnfOLPD
kZ694O9KAFQZ4syLcEnSFdE6Z2whgtz/wggCxVoJ6BgFqGb6SMSFuByXDyltBVFe
OW/YYMOSnBW9/11HsvNZrdkO7ymkbtYzYovFXOByTYYqR9DielRGnE7r2dAQNKaF
1ef6/YE1rzO25Hv40dR9tIkNzkFCrkeE5G3IvB6hrs4PGtzGTaSYVH6HACASVoe7
sPgHRDvKo9xpjcM4z1BZ0gOq+mXLug==
=GxSs
-----END PGP SIGNATURE-----

--45QMQyEa3wgM5TDcGh6FhUUgUNKOiGuuF--
