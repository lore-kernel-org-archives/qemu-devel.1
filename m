Received: from eggs.gnu.org ([2001:4830:134:3::10]:36562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f6FSF-0000wh-L9
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 09:06:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f6FSC-0000XO-Go
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 09:06:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47046 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f6FSC-0000X2-AN
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 09:06:24 -0400
References: <20180410124913.10832-1-peterx@redhat.com>
	<20180410124913.10832-3-peterx@redhat.com>
	<20180411014532.GB28698@stefanha-x1.localdomain>
	<20180411034954.GC13887@xz-mi>
	<d2ab39a4-2ffc-ddee-299d-007e9850cebb@redhat.com>
	<20180411093526.GH13887@xz-mi>
	<4183b7d5-83c5-5401-3ac4-937bb40a14e8@redhat.com>
	<20180411094812.GI13887@xz-mi>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a22bd066-79b8-575b-4104-b260b350c356@redhat.com>
Date: Wed, 11 Apr 2018 08:06:04 -0500
MIME-Version: 1.0
In-Reply-To: <20180411094812.GI13887@xz-mi>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GVGdWQ0MI4o49NQ0iq98seavfekje25m1"
Subject: Re: [Qemu-devel] [PATCH 2/2] qemu-thread: let cur_mon be per-thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GVGdWQ0MI4o49NQ0iq98seavfekje25m1
From: Eric Blake <eblake@redhat.com>
To: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
 <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <a22bd066-79b8-575b-4104-b260b350c356@redhat.com>
Subject: Re: [PATCH 2/2] qemu-thread: let cur_mon be per-thread
References: <20180410124913.10832-1-peterx@redhat.com>
 <20180410124913.10832-3-peterx@redhat.com>
 <20180411014532.GB28698@stefanha-x1.localdomain>
 <20180411034954.GC13887@xz-mi>
 <d2ab39a4-2ffc-ddee-299d-007e9850cebb@redhat.com>
 <20180411093526.GH13887@xz-mi>
 <4183b7d5-83c5-5401-3ac4-937bb40a14e8@redhat.com>
 <20180411094812.GI13887@xz-mi>
In-Reply-To: <20180411094812.GI13887@xz-mi>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/11/2018 04:48 AM, Peter Xu wrote:

> Okay. :) Thanks for confirming.  Then let me repost this patch without
> touching the qemu-threads.
>=20
> Btw, do you want me to repost the first patch separately too, or keep
> the code as is?  I believe it depends on whether you treat that one as
> a cleanup or not.  Thanks,

The first patch is no longer necessary for your new approach, but as it
is a cleanup and you've already written it, it does not hurt to still
send it as a separate cleanup patch useful in its own right.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--GVGdWQ0MI4o49NQ0iq98seavfekje25m1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrOCDwACgkQp6FrSiUn
Q2qk2AgAjTHXn8MfJxgLWHs80kEWx9H4aXlWJy+A5X8rv+9OxRlXy68Eyd+/hHXh
d9kiyh5lcHzoWBuEYjAf408Sye787Qa0sumNwDTZEeOw3/IMBpn1vJRtAYLHZIWO
WljKRj1GVDYQeicLCY9a7h/wHs9VtB7/BEfF1lF+bzkVEOlVn2Fsjn+gArcwrNuH
bp1SAXkdwBd9Lyvv8NQ3Whc+83lohQOtdMUCCnOlpI6q3xFieaYtZh6PYzT7vEEo
pfoCmFOTpNguHLXeWwRfmxv/g/WhHg4rHDZ9IjupJLrqiIKBnColOqIUecrsoz+e
G+sUTYFY5zLCawvBNYpxZdDaBhffgw==
=d3Kc
-----END PGP SIGNATURE-----

--GVGdWQ0MI4o49NQ0iq98seavfekje25m1--
