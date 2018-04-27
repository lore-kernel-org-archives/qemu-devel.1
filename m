Received: from eggs.gnu.org ([2001:4830:134:3::10]:59301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fC9TC-0003NL-Pi
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 15:55:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fC9T7-00084D-W9
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 15:55:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52870 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fC9T7-00083u-Pq
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 15:55:45 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4FEA54023156
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 19:55:45 +0000 (UTC)
References: <20180427192852.15013-1-lersek@redhat.com>
	<20180427192852.15013-6-lersek@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1f63da24-903d-2670-0973-c429ffa7661e@redhat.com>
Date: Fri, 27 Apr 2018 14:55:44 -0500
MIME-Version: 1.0
In-Reply-To: <20180427192852.15013-6-lersek@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="995kNXVCijE9qUPwm4xT6JDKq3TdtEjAL"
Subject: Re: [Qemu-devel] [PATCH v3 5/5] qapi: deprecate CpuInfoFast.arch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--995kNXVCijE9qUPwm4xT6JDKq3TdtEjAL
From: Eric Blake <eblake@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <1f63da24-903d-2670-0973-c429ffa7661e@redhat.com>
Subject: Re: [PATCH v3 5/5] qapi: deprecate CpuInfoFast.arch
References: <20180427192852.15013-1-lersek@redhat.com>
 <20180427192852.15013-6-lersek@redhat.com>
In-Reply-To: <20180427192852.15013-6-lersek@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/27/2018 02:28 PM, Laszlo Ersek wrote:
> The TARGET_BASE_ARCH values from "configure" don't all map to the
> @CpuInfoArch enum constants; in particular "s390x" from the former does=

> not match @s390 in the latter. Clients are known to rely on the @s390
> constant specifically, so we can't change it silently. Instead, depreca=
te
> the @CpuInfoFast.@arch member (in favor of @CpuInfoFast.@target) using =
the
> regular deprecation process.
>=20
> (No deprecation reminder is added to sysemu_target_to_cpuinfo_arch(): o=
nce
> @CpuInfoFast.@arch is removed, the assignment expression that calls
> sysemu_target_to_cpuinfo_arch() from qmp_query_cpus_fast() will have to=

> disappear; in turn the static function left without callers will also
> break the build, thus it'll have to go.)
>=20
> Cc: "Daniel P. Berrange" <berrange@redhat.com>
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> ---
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--995kNXVCijE9qUPwm4xT6JDKq3TdtEjAL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrjgEAACgkQp6FrSiUn
Q2oZZQgAlAzTW6laZPGhoe42UtWEQFGakbS6WSQxrBgakNBHM54GAFioYcInqWoC
HYsHjphyO/G85ZTUQOzy+/v3pFiM2uWPS4bP9LSufdaWLoESakp63kGgFvRF9PxE
12W0zS7mvsfqSw41+VbKfZFY3EtW1o+GT/VtZ0lNsOyKum2zLy/+x4wQy8+l5U8a
m2TX6kvBeXQEdn45YCQjVtDMxmt6iRAXj9via40NK89Yj3zsP7uxC4UxOudvP++V
NbX5sr8KnJpF4+LVEj/oS0uI8FJP+Wjp5igRLnL/GjzpxhPJDKlBr1rPcCZvImnI
x2WPOpK8f2HaZLTNqqVE2SLhbXtvWg==
=ddOe
-----END PGP SIGNATURE-----

--995kNXVCijE9qUPwm4xT6JDKq3TdtEjAL--
