Received: from eggs.gnu.org ([2001:4830:134:3::10]:59951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1edilz-0004pK-OS
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 15:32:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1edily-0005Tp-LI
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 15:32:55 -0500
References: <20180112090122.1702-1-klim.kireev@virtuozzo.com>
	<20180112090122.1702-2-klim.kireev@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a562774e-a8d8-d864-c639-6edb6f58df4a@redhat.com>
Date: Mon, 22 Jan 2018 14:32:43 -0600
MIME-Version: 1.0
In-Reply-To: <20180112090122.1702-2-klim.kireev@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JVF02KO680o5eeV8VZmTTCW9jJRWUz7LS"
Subject: Re: [Qemu-devel] [PATCH 1/5] docs/interop/prl-xml: description of
 Parallels Disk format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Klim Kireev <klim.kireev@virtuozzo.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org, stefanha@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JVF02KO680o5eeV8VZmTTCW9jJRWUz7LS
From: Eric Blake <eblake@redhat.com>
To: Klim Kireev <klim.kireev@virtuozzo.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org, stefanha@redhat.com,
 qemu-block@nongnu.org, mreitz@redhat.com
Message-ID: <a562774e-a8d8-d864-c639-6edb6f58df4a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/5] docs/interop/prl-xml: description of
 Parallels Disk format
References: <20180112090122.1702-1-klim.kireev@virtuozzo.com>
 <20180112090122.1702-2-klim.kireev@virtuozzo.com>
In-Reply-To: <20180112090122.1702-2-klim.kireev@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/12/2018 03:01 AM, Klim Kireev wrote:
> This patch adds main information about Parallels Disk
> format, which consists of DiskDescriptor.xml and other files.
>=20
> Signed-off-by: Edgar Kaziakhmedov <edgar.kaziakhmedov@virtuozzo.com>
> Signed-off-by: Klim Kireev <klim.kireev@virtuozzo.com>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  docs/interop/prl-xml.txt | 158 +++++++++++++++++++++++++++++++++++++++=
++++++++
>  1 file changed, 158 insertions(+)
>  create mode 100644 docs/interop/prl-xml.txt
>=20
> diff --git a/docs/interop/prl-xml.txt b/docs/interop/prl-xml.txt
> new file mode 100644
> index 0000000000..7031f8752c
> --- /dev/null
> +++ b/docs/interop/prl-xml.txt
> @@ -0,0 +1,158 @@
> +=3D License =3D
> +
> +Copyright (c) 2015-2017, Virtuozzo, Inc.

Want to claim 2018 as well?


> +
> +This specification contains minimal information about Parallels Disk F=
ormat,
> +which is enough to proper work with QEMU. Nevertheless, Parallels Clou=
d Server

s/proper/properly/

> +and Parallels Desktop are able to add some unspecified nodes to xml an=
d use
> +them, but they are for internal work and don't affect functionality. A=
lso it
> +uses auxiliary xml "Snapshot.xml", which allows to store optional snap=
shot

s/allows to store/allows storing/

> +information, but it doesn't influence open/read/write functionality. Q=
EMU and
> +other software should not use fields not covered in this document and
> +Snapshot.xml file and must leave them as is.
> +
> +=3D Parallels Disk Format =3D
> +
> +Parallels disk consists of two parts: the set of snapshots and the dis=
k

s/Parallels/A Parallels/

> +descriptor file, which stores information about all files and snapshot=
s.
> +
> +=3D=3D Definitions =3D=3D
> +    Snapshot       a record of the contents captured at a particular t=
ime,
> +                   capable of storing current state. A snapshot has UU=
ID and
> +                   parent UUID.

s/has UUID/has a UUID/

> +=3D=3D Disk_Parameters element =3D=3D
> +The Disk_Parameters element describes the physical layout of the virtu=
al disk
> +and some general settings.
> +
> +The Disk_Parameters element MUST contain the following child elements:=

> +    * Disk_size - number of sectors in the disk,
> +                  desired size of the disk.

In sectors and not bytes?  Is it possible to have an image that is not
sector-aligned?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--JVF02KO680o5eeV8VZmTTCW9jJRWUz7LS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpmSmsACgkQp6FrSiUn
Q2pm/wf/WQZ4AALPNE5cQI/+xZIevz0IBZ74WFGulxeXLjjObkTQxuU//tSOivFS
LXFVH7DUNgQWfvN2WCuh4GeFTH6zuBSgfO2uegGbh8vVbjIyEghFVNgdn6gg1yxp
0lo5xrmbiJUbOsQNSZMo/N6arBc/MRl4XhVXK57q7X32c2fEsIHGb2IhB457RPds
G3a5tgxIb4SCfnF9oB7NdbYweckYLCi20Qxk4myt2DvhZWjA1a62e+emO46J9Jop
fkCP19V+U81beQiWKSUVwbkljjB7pBxvC9QvNPvYu4Wpjsf9xAFXQYJ4RzEIvM7F
bOlLv9kktN8w1b8VL8dLg+u6SXe2Dg==
=gvs2
-----END PGP SIGNATURE-----

--JVF02KO680o5eeV8VZmTTCW9jJRWUz7LS--
