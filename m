Received: from eggs.gnu.org ([2001:4830:134:3::10]:41688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cOt8z-0004k8-3x
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 16:30:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cOt8u-0003SU-91
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 16:30:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59864)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cOt8t-0003R7-Re
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 16:30:44 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E9D363B714
	for <qemu-devel@nongnu.org>; Wed,  4 Jan 2017 21:30:43 +0000 (UTC)
References: <20161212224325.20790-1-marcandre.lureau@redhat.com>
	<20161212224325.20790-11-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b40056c0-7a84-f8b1-0261-fee55f1ec774@redhat.com>
Date: Wed, 4 Jan 2017 15:30:40 -0600
MIME-Version: 1.0
In-Reply-To: <20161212224325.20790-11-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8hgWNpUqImBHK8JaF5XfUWBphpsR3u4iv"
Subject: Re: [Qemu-devel] [PATCH 10/54] char: rename CharDriverState Chardev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8hgWNpUqImBHK8JaF5XfUWBphpsR3u4iv
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Message-ID: <b40056c0-7a84-f8b1-0261-fee55f1ec774@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 10/54] char: rename CharDriverState Chardev
References: <20161212224325.20790-1-marcandre.lureau@redhat.com>
 <20161212224325.20790-11-marcandre.lureau@redhat.com>
In-Reply-To: <20161212224325.20790-11-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/12/2016 04:42 PM, Marc-Andr=C3=A9 Lureau wrote:
> Uniformify chardev type name.

"Uniformify" - cute :)  I might have written:

Pick a uniform chardev type name.

instead of inventing a word, but you're call on whether to keep it.

>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  81 files changed, 728 insertions(+), 725 deletions(-)

Big, but mostly mechanical.

> @@ -268,9 +268,9 @@ static int baum_deferred_init(BaumDriverState *baum=
)
>  }
> =20
>  /* The serial port can receive more of our data */
> -static void baum_accept_input(struct CharDriverState *chr)
> +static void baum_accept_input(struct Chardev *chr)

Do we still need the 'struct' in this parameter list?  Separate cleanup
may be okay.

A grep on your github chrfe branch shows that it looks like you got them
all, so
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--8hgWNpUqImBHK8JaF5XfUWBphpsR3u4iv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYbWmBAAoJEKeha0olJ0NqvNkIALCsrafyYs12zulWy7FJ9O8C
BXS1rKSB5Yf2I+VxVWqTQk3/yv0th9edeoAMbvk/C7DfgUaoRM7C7gHYKGMoorxU
Kj31l5b00NP78Hm05tr421GWNSaAXDEETtcPo7fLZJcR7x4Y0t+URnd+c5VCTpiP
Q8nx7+TKYBWkJDL3wePV7bzF3km77LFRuJdhmjjBwVHasVJ2cVm/fqTybKu6K8d9
VoBJl4lDgcXvxCfTXEthKVIsmQY1sUPAUrVQteEtKQM9OdfJUGU1eYjaMKTct73a
p5/lTAI0ShIh9FkdpwRcZNMSprdAN/pl3+dAmXuxrXnToaxvnZYljuZ/L6i/a1c=
=xDO7
-----END PGP SIGNATURE-----

--8hgWNpUqImBHK8JaF5XfUWBphpsR3u4iv--
