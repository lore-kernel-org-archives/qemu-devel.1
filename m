Received: from eggs.gnu.org ([2001:4830:134:3::10]:54150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dUVUq-0004EL-2X
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 06:00:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dUVUm-0005se-Lh
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 06:00:52 -0400
References: <20170622121713.27601-1-stefanha@redhat.com>
	<86920a79-2910-06d6-7833-54b4881dcc35@redhat.com>
	<20170710095211.GB14195@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3513e4a6-359b-2dc6-6313-2237d556c3af@redhat.com>
Date: Mon, 10 Jul 2017 12:00:25 +0200
MIME-Version: 1.0
In-Reply-To: <20170710095211.GB14195@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ifmVjAAb6WrQM450kcM7LgojbbQ63nMS4"
Subject: Re: [Qemu-devel] [PATCH] docs: add qemu-block-drivers(7) man page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ifmVjAAb6WrQM450kcM7LgojbbQ63nMS4
From: Paolo Bonzini <pbonzini@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org
Message-ID: <3513e4a6-359b-2dc6-6313-2237d556c3af@redhat.com>
Subject: Re: [PATCH] docs: add qemu-block-drivers(7) man page
References: <20170622121713.27601-1-stefanha@redhat.com>
 <86920a79-2910-06d6-7833-54b4881dcc35@redhat.com>
 <20170710095211.GB14195@stefanha-x1.localdomain>
In-Reply-To: <20170710095211.GB14195@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 10/07/2017 11:52, Stefan Hajnoczi wrote:
> On Wed, Jul 05, 2017 at 06:08:58PM +0200, Paolo Bonzini wrote:
>> On 22/06/2017 14:17, Stefan Hajnoczi wrote:
>>> +@c man begin SYNOPSIS
>>> +QEMU block driver reference manual
>>> +@c man end
>>> +
>>
>> I think this should be wrapped with @ignore / @end ignore.  Otherwise
>> looks like a great idea.
>=20
> Why is @ignore needed here?  qemu-doc.texi doesn't use it around @c man=

> begin SYNOPSIS either.
>=20
> I've checked both the qemu-doc and qemu-block-drivers output to confirm=

> that it appears correct in both man and txt formats.

In the qemu-doc manual, for example, the synopsys of qemu.1 appears at
the beginning of the "invocation" section:

   2.3 Invocation

      qemu-system-i386 [options] [disk_image]

   disk_image is a raw hard disk image for IDE hard disk 0. Some targets
   do not need a disk image.

   2.3.1 Standard options

   ...

In your case, "QEMU block driver reference manual" should not appear at
the top of the "Disk image file formats" section, so you need to hide it
from Texinfo.

Paolo


--ifmVjAAb6WrQM450kcM7LgojbbQ63nMS4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAlljUDwACgkQv/vSX3jH
roOMYwf/TWKFmelcC1TgTNZ0zQWN4cl/MOmpnqZYwWvsG7dzZIpYkn1CCdDCQSlE
z96+pV23UVxFwEA8TD/oZ5g5rRdLp2wt1+DU+a42y3ESLUHy794ygiVIaWOCc+t6
q4g/UrIfGMlYOZW0z9AhBo6NDNz/SSveRKNqbUTQgVR9ivRWkkDlAY38W1sk5GCg
7LgrIq7ElA1c9lyZjGEjmuOkOebb8l2IojzLXJqPvQrjX2JzSu03WtL77GbzuO6Y
ssekNkYbRI15JmqVA0f2WSyALuLWCYmyRVjg2j2Gb4wCt4TOZKo50gIHAX+0CICp
GuQ0DZG+fE6EtQhGbDsV0t32fy/GdQ==
=3B4d
-----END PGP SIGNATURE-----

--ifmVjAAb6WrQM450kcM7LgojbbQ63nMS4--
