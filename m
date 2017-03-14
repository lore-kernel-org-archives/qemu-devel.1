Received: from eggs.gnu.org ([2001:4830:134:3::10]:58994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnnqU-0007nF-GI
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 10:54:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnnqQ-00058H-Jl
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 10:54:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56126)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cnnqQ-00056w-BH
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 10:54:38 -0400
References: <20170314102747.31395-1-fanc.fnst@cn.fujitsu.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7110d95e-d500-a1ee-c590-2f44460d9881@redhat.com>
Date: Tue, 14 Mar 2017 09:54:34 -0500
MIME-Version: 1.0
In-Reply-To: <20170314102747.31395-1-fanc.fnst@cn.fujitsu.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2x685KH860557lgWQjon5lnXoAx5S79KA"
Subject: Re: [Qemu-devel] [PATCH] Output dirty-bytes-rate instead of
 dirty-pages-rate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Chao Fan <fanc.fnst@cn.fujitsu.com>, quintela@redhat.com, dgilbert@redhat.com, qemu-devel@nongnu.org, berrange@redhat.com
Cc: caoj.fnst@cn.fujitsu.com, douly.fnst@cn.fujitsu.com, maozy.fnst@cn.fujitsu.com, Li Zhijian <lizhijian@cn.fujitsu.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2x685KH860557lgWQjon5lnXoAx5S79KA
From: Eric Blake <eblake@redhat.com>
To: Chao Fan <fanc.fnst@cn.fujitsu.com>, quintela@redhat.com,
 dgilbert@redhat.com, qemu-devel@nongnu.org, berrange@redhat.com
Cc: caoj.fnst@cn.fujitsu.com, douly.fnst@cn.fujitsu.com,
 maozy.fnst@cn.fujitsu.com, Li Zhijian <lizhijian@cn.fujitsu.com>
Message-ID: <7110d95e-d500-a1ee-c590-2f44460d9881@redhat.com>
Subject: Re: [PATCH] Output dirty-bytes-rate instead of dirty-pages-rate
References: <20170314102747.31395-1-fanc.fnst@cn.fujitsu.com>
In-Reply-To: <20170314102747.31395-1-fanc.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/14/2017 05:27 AM, Chao Fan wrote:
> In hmp, dirty-bytes-rate is more friendly than dirty-pages-rate.
> It's also better for other tools to determine the cpu throttle
> value in different architecture.
>=20
> Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> ---

In addition to the (good) comments you've gotten on not breaking
existing fields, and the choice between a single new field giving the
page size (with all fields favoring pages) or lots of new fields giving
bytes, I have another comment:

> @@ -575,12 +572,15 @@
>  # @postcopy-requests: The number of page requests received from the de=
stination
>  #        (since 2.7)
>  #
> +# @dirty-bytes-rate: how many bytes  dirtied by second by the
> +#        guest (since 2.9)

You've missed soft freeze.  Is this really bug-fix quality to be adding
it into the release this late in the game for 2.9, or should it be
deferred to 2.10?

And while this is just a new field to an existing command, rather than a
new command entirely, it's also worth thinking about Markus' edict for
testsuite coverage:
https://lists.gnu.org/archive/html/qemu-devel/2017-03/msg00296.html

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--2x685KH860557lgWQjon5lnXoAx5S79KA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYyAQqAAoJEKeha0olJ0Nq8NIH/0eUECH4b69pFC4Qvba1jNpx
i0N+UaGHhI+km36AU5kjOkOJzHkY5AlXeXc15XpErE09Xwmxp504rPSu+HRbOCFA
oUkJIlVN0ZQL0Lm5CHE2sb4+4xq2DrIlZ/QY9ygMP9V2jkf2gurPeNvmC0NqUQ9x
Y1ZxQLLrajdtxtocEI98PgfQekJzWlzyHZr9nM3ZOkTUj0Bv6zPD7cc4r/ChuE2q
r0LaeK0kHU2RRDlHv/GokCnaACfrljkulSZ9MhNq0vummHZwC+ivw9e2KUUs/MF5
GgTxlJkGr/UGWtI1ukJ1Le4EtmRPccCgAhkltOd4UfnSvBX9lzfInDk/b1urzlE=
=QzhK
-----END PGP SIGNATURE-----

--2x685KH860557lgWQjon5lnXoAx5S79KA--
