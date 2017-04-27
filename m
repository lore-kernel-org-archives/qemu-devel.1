Received: from eggs.gnu.org ([2001:4830:134:3::10]:34195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3s2F-00063k-BY
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 18:37:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3s2B-0002hP-Dl
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 18:37:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41514)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d3s2B-0002gO-4U
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 18:37:11 -0400
References: <20170427213202.13512-1-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8c8261bd-d854-cf32-9fab-011c11e3afb5@redhat.com>
Date: Thu, 27 Apr 2017 17:37:08 -0500
MIME-Version: 1.0
In-Reply-To: <20170427213202.13512-1-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wQT7i9EAtkJXGOrlI7nJEO1cxR7BjGdHM"
Subject: Re: [Qemu-devel] [PATCH v4 0/4] event: Add source information to
 SHUTDOWN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, alistair.francis@xilinx.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wQT7i9EAtkJXGOrlI7nJEO1cxR7BjGdHM
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, alistair.francis@xilinx.com
Message-ID: <8c8261bd-d854-cf32-9fab-011c11e3afb5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 0/4] event: Add source information to
 SHUTDOWN
References: <20170427213202.13512-1-eblake@redhat.com>
In-Reply-To: <20170427213202.13512-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/27/2017 04:31 PM, Eric Blake wrote:
> v2 was here:
> https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg03185.html
> v3 was here:
> https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg05515.html
>=20
> Since then:
> - s/ShutdownType/ShutdownCause/ to avoid conflict with mingw header pol=
lution
> - fix long line
>=20
> Eric Blake (4):
>   shutdown: Simplify shutdown_signal
>   shutdown: Prepare for use of an enum in reset/shutdown_request
>   shutdown: Add source information to SHUTDOWN and RESET
>   RFC: shutdown: Expose full ShutdownCause across QMP
>=20
>  qapi-schema.json            |    26 +
>  qapi/event.json             |    12 +-
>  include/sysemu/sysemu.h     |     6 +-
>  trace/generated-tracers.h   | 18523 ++++++++++++++++++++++++++++++++++=
++++++++

Bleargh. I 'git add'ed too much.  Apologies for the spam. v5 coming up.


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--wQT7i9EAtkJXGOrlI7nJEO1cxR7BjGdHM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZAnKUAAoJEKeha0olJ0Nq2v8IAIZRptt6iIuJh/TJj3gCuyXA
yib7yqyT7Rq39of4C/GCWjL4Ks5ju6hvSu7RQS+8b59aiTA2X6VBu/ixIIUG3Y5I
fNB4L++7K94O2zNA5+8lJed3cWvaF6MQTWVLd3LoQ/lAwaemDWsFKuwucZ2IsLsr
SA0/5xzfsLKAS0sHpyJSDZCU+psLYNDcDlomV0Rjhz7R4TKsjg6fwiNovLknY32D
unBH8f8WRfy/A9RQMhqJn2JR2vOhMVgkR1sdQgCaXbGJqBNBxro5DvNw7RzZTAM/
oZxnSFsoMMVxuBKbAcn5/VwI9onLP7/MsM5dln9QGduZnHY6C7LavB77B3e4Ir0=
=5k5D
-----END PGP SIGNATURE-----

--wQT7i9EAtkJXGOrlI7nJEO1cxR7BjGdHM--
