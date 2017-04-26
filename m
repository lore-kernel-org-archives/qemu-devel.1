Received: from eggs.gnu.org ([2001:4830:134:3::10]:55685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3R8z-0003FN-4F
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 13:54:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3R8u-0002GN-Pc
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 13:54:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46877)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d3R8u-0002GD-GO
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 13:54:20 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 38ECF65D17
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 17:54:19 +0000 (UTC)
References: <20170426153900.21066-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3f6dc142-2faf-d4c5-e293-6691c2218133@redhat.com>
Date: Wed, 26 Apr 2017 12:54:12 -0500
MIME-Version: 1.0
In-Reply-To: <20170426153900.21066-1-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="m6nuOEaxAiRPHVuDd4BDnqiLREmridASr"
Subject: Re: [Qemu-devel] [PATCH] trace: disallow more than 10 arguments per
 trace event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--m6nuOEaxAiRPHVuDd4BDnqiLREmridASr
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <3f6dc142-2faf-d4c5-e293-6691c2218133@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] trace: disallow more than 10 arguments per
 trace event
References: <20170426153900.21066-1-berrange@redhat.com>
In-Reply-To: <20170426153900.21066-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/26/2017 10:39 AM, Daniel P. Berrange wrote:
> The UST trace backend can only cope with upto 10 arguments. To ensure w=
e

s/upto/up to/

> don't exceed the limit when UST is not compiled in, disallow more than
> 10 arguments upfront.
>=20
> This prevents the case where:
>=20
>   commit 0fc8aec7de64f2bf83a274a2a38b938ce03425d2

>=20
> regressed the fix done in
>=20
>   commit 2dfe5113b11ce0ddb08176ebb54ab7ac4104b413

>=20
> Now we get an immediate fail even when UST is disabled:
>=20
>   GEN     net/trace.h
> Traceback (most recent call last):
>   File "/home/berrange/src/virt/qemu/scripts/tracetool.py", line 154, i=
n <module>
>     main(sys.argv)
>   File "/home/berrange/src/virt/qemu/scripts/tracetool.py", line 145, i=
n main
>     events.extend(tracetool.read_events(fh))
>   File "/home/berrange/src/virt/qemu/scripts/tracetool/__init__.py", li=
ne 307, in read_events
>     event =3D Event.build(line)
>   File "/home/berrange/src/virt/qemu/scripts/tracetool/__init__.py", li=
ne 244, in build
>     event =3D Event(name, props, fmt, args)
>   File "/home/berrange/src/virt/qemu/scripts/tracetool/__init__.py", li=
ne 196, in __init__
>     "argument count" % name)
> ValueError: Event 'colo_compare_tcp_info' has more than maximum permitt=
ed argument count
> Makefile:96: recipe for target 'net/trace.h-timestamp' failed

Not necessarily the nicest-looking error, but sufficient to prevent the
regression.

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>=20
> Obviously dont apply this until 0fc8aec7de64f2bf83a274a2a38b938ce03425d=
2 has
> been reverted :-)

It now has: commit 51b9d495.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--m6nuOEaxAiRPHVuDd4BDnqiLREmridASr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZAN7FAAoJEKeha0olJ0NqwtYH/1cVDKFWwJnY61TMkTZxEiTj
lClljkAZNh9KgIenFH66jpluoUx4GEzsbq1gH3MdQZET5a5BUS6I7vJ2S0VzqKmF
BL40fZG/DdDsugR7XU6XjEb03FrE2gnBpPivl5iCev1/tS6E7hNLVREaH6Lxcv3J
gykTyxuQHJtUDsLGXbmvAOSWR3jQZiA++Rx3BiA7y+NmxIy+T3t0KY7mNzuO7bbn
4HTCB0C4smjezJSHgNlBxjrII/SsgbL8oFRpnwNmyBCiPAtgwcziVnZPVBvnKrlf
sBfNkRn+wruAhvv7KLEU3YgFSfSyM5ghT7ZAxsSzhCknFC75PLV5cO37xERjSxo=
=umuA
-----END PGP SIGNATURE-----

--m6nuOEaxAiRPHVuDd4BDnqiLREmridASr--
