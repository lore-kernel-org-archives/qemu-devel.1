Received: from eggs.gnu.org ([2001:4830:134:3::10]:39645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gChvs-0007Am-Vp
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 05:16:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gChvq-00049u-Sx
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 05:16:00 -0400
References: <cover.1539764043.git.artem.k.pisarenko@gmail.com>
	<f47b81dbce734e9806f9516eba8ca588e6321c2f.1539764043.git.artem.k.pisarenko@gmail.com>
	<20181017091204.GC22755@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5a83aab6-1277-cc0e-7913-964a8fea5265@redhat.com>
Date: Wed, 17 Oct 2018 11:15:36 +0200
MIME-Version: 1.0
In-Reply-To: <20181017091204.GC22755@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HVMQI1VYUJed7HU2cOHKRG2cwBRybjcRb"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 2/4] Introduce attributes
 to qemu timer subsystem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, Artem Pisarenko <artem.k.pisarenko@gmail.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, "open list:Block I/O path" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HVMQI1VYUJed7HU2cOHKRG2cwBRybjcRb
From: Paolo Bonzini <pbonzini@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>,
 Artem Pisarenko <artem.k.pisarenko@gmail.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Fam Zheng <famz@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 "open list:Block I/O path" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <5a83aab6-1277-cc0e-7913-964a8fea5265@redhat.com>
Subject: Re: [Qemu-block] [PATCH v2 2/4] Introduce attributes to qemu timer
 subsystem
References: <cover.1539764043.git.artem.k.pisarenko@gmail.com>
 <f47b81dbce734e9806f9516eba8ca588e6321c2f.1539764043.git.artem.k.pisarenko@gmail.com>
 <20181017091204.GC22755@stefanha-x1.localdomain>
In-Reply-To: <20181017091204.GC22755@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 17/10/2018 11:12, Stefan Hajnoczi wrote:
>> Attributes are simple flags, associated with individual timers for the=
ir whole lifetime.
>> They intended to be used to mark individual timers for special handlin=
g by various qemu features operating at qemu core level.
> I'm worried that this sentence suggests various parts of QEMU will stas=
h
> state in ts->attributes.  That's messy and they shouldn't do this.  Mak=
e
> the field private to qemu-timer.c.

Yes, the contents of the fields are private.  Are you suggesting a
different wording for the commit message or the "QEMU Timer attributes"
doc comment, or something more than that?  Possibly removing
timer_get_attributes altogether?

Paolo


--HVMQI1VYUJed7HU2cOHKRG2cwBRybjcRb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAlvG/bkACgkQv/vSX3jH
roMiGwf7BqDhDymtlnfed+AX40tqwDxcyhGKp06eMXgXq4uqf+Pd6vSE/b15E5pp
mNvpGE+2LdkgRCZkkA5Z4Z7DIlfLTzWpPErTYyFJWu3E5n3y7iBSiFczxG7mWOeL
DyBnzZ4j22yfppsnE7KjT0ZfcG6AouqxxaIlZnNNEfn5vgOt05pdXWAbVH5MZSiB
Uq7MSQqCe3q7lCH+LmYFMKdwiKgKLzkiXFV9yWSDcXHpJQsIYPv95ulA+yaCihdI
6K3Q4EPYaGv37V2Hhfecvhw0CRKd9LzqUBUrKkZghMOs5+tYdiwPhWTb7u2yaB+f
uDzGX3mUST5XW1aFEEN9EMsx+lwS8w==
=VBaX
-----END PGP SIGNATURE-----

--HVMQI1VYUJed7HU2cOHKRG2cwBRybjcRb--
