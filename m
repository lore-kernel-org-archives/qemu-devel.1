Received: from eggs.gnu.org ([209.51.188.92]:45937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gjrND-0002vP-UM
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 15:01:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gjrND-0008B3-4P
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 15:01:15 -0500
References: <20190112175812.27068-1-eblake@redhat.com>
	<20190112175812.27068-16-eblake@redhat.com>
	<75e42dc3-440b-f0e8-c52f-99621235b12c@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <898e6da2-912f-edda-d38a-1e032a89f3d3@redhat.com>
Date: Wed, 16 Jan 2019 14:01:06 -0600
MIME-Version: 1.0
In-Reply-To: <75e42dc3-440b-f0e8-c52f-99621235b12c@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="xJLUbdliQKyfCjKNvZ07RJZIRvCXn0RcG"
Subject: Re: [Qemu-devel] [PATCH v3 15/19] nbd/client: Add
 nbd_receive_export_list()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "nsoffer@redhat.com" <nsoffer@redhat.com>, "rjones@redhat.com" <rjones@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xJLUbdliQKyfCjKNvZ07RJZIRvCXn0RcG
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "nsoffer@redhat.com" <nsoffer@redhat.com>,
 "rjones@redhat.com" <rjones@redhat.com>, "jsnow@redhat.com"
 <jsnow@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Message-ID: <898e6da2-912f-edda-d38a-1e032a89f3d3@redhat.com>
Subject: Re: [PATCH v3 15/19] nbd/client: Add nbd_receive_export_list()
References: <20190112175812.27068-1-eblake@redhat.com>
 <20190112175812.27068-16-eblake@redhat.com>
 <75e42dc3-440b-f0e8-c52f-99621235b12c@virtuozzo.com>
In-Reply-To: <75e42dc3-440b-f0e8-c52f-99621235b12c@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/16/19 4:15 AM, Vladimir Sementsov-Ogievskiy wrote:

>> This patch adds the low-level client code for grabbing the list
>> of exports.  It benefits from the recent refactoring patches, as
>> well as a minor tweak of changing nbd_opt_go() to nbd_opt_info_or_go()=
,

>> -/* Returns -1 if NBD_OPT_GO proves the export @info->name cannot be
>> +/*
>> + * Returns -1 if NBD_OPT_GO proves the export @info->name cannot be
>>    * used, 0 if NBD_OPT_GO is unsupported (fall back to NBD_OPT_LIST a=
nd
>>    * NBD_OPT_EXPORT_NAME in that case), and > 0 if the export is good =
to
>> - * go (with the rest of @info populated). */
>> -static int nbd_opt_go(QIOChannel *ioc, NBDExportInfo *info, Error **e=
rrp)
>> + * go (with the rest of @info populated).
>> + */
>=20
> Don't you want to upgrade a comment a little bit, to reflect support fo=
r OPT_INFO?

Yeah, but then the tweaks start to build up. I'll split the function
rename to a separate patch,

>>
>> -    trace_nbd_opt_go_start(info->name);
>> +    assert(opt =3D=3D NBD_OPT_GO || opt =3D=3D NBD_OPT_INFO);
>> +    trace_nbd_opt_go_start(nbd_opt_lookup(opt), info->name);
>=20
> I'd prefer to upgrade trace-point name too, as well as other several tr=
ace_nbd_opt_go_* trace
> points in the function.

and improve the traces there too.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--xJLUbdliQKyfCjKNvZ07RJZIRvCXn0RcG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlw/jYIACgkQp6FrSiUn
Q2qzVQf/aFEjfKmhlJxSuUU7U+XRlJj5jTl5fWvYb8TBo1DYUHeMtMBzFK/RAoxT
bthRRwJRi4f8wv2PEtLMyVAY9fr6tjQ29kd0TqgNk8Cq+42pkWH7MBTDqWGUgc67
8WWQek4y1O+xfsxtNDhgzulyMV3HkAva/BjHGwK7HrKSxTEkhzdka+alfzmbt4F/
AwGQrfv6XTwV5TTpTHQg8rSCkcstPl1HEvLcA0ByaJ+kogq8WCLtLV5hsDQIG6fY
FKLMgo4LluaLdYP87BoR3cF5CtbXGrdg4J9HH8kGi56X/i+puklbY4ohxUwrD7Ao
NVjnJFGmPLw0rnv+whq49FbOCkhHHw==
=2e4T
-----END PGP SIGNATURE-----

--xJLUbdliQKyfCjKNvZ07RJZIRvCXn0RcG--
