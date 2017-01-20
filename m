Received: from eggs.gnu.org ([2001:4830:134:3::10]:41975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cUaIZ-0007WZ-EE
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 09:36:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cUaIV-0007C6-H0
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 09:36:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44474)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cUaIV-0007Bh-89
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 09:36:11 -0500
References: <1484859998-25074-1-git-send-email-mst@redhat.com>
	<1484859998-25074-3-git-send-email-mst@redhat.com>
	<20170120094124.GB2658@work-vm>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7af547e6-8758-388a-17e9-9f749e927da2@redhat.com>
Date: Fri, 20 Jan 2017 08:36:08 -0600
MIME-Version: 1.0
In-Reply-To: <20170120094124.GB2658@work-vm>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="oRFPsHufXLG2pSjudvDKprsi92OCBFqMA"
Subject: Re: [Qemu-devel] [PATCH v3 2/4] compiler: rework BUG_ON using a
 struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oRFPsHufXLG2pSjudvDKprsi92OCBFqMA
From: Eric Blake <eblake@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Message-ID: <7af547e6-8758-388a-17e9-9f749e927da2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/4] compiler: rework BUG_ON using a
 struct
References: <1484859998-25074-1-git-send-email-mst@redhat.com>
 <1484859998-25074-3-git-send-email-mst@redhat.com>
 <20170120094124.GB2658@work-vm>
In-Reply-To: <20170120094124.GB2658@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/20/2017 03:41 AM, Dr. David Alan Gilbert wrote:

>> -#define QEMU_BUILD_BUG_ON(x) \
>> -    typedef char glue(qemu_build_bug_on__, __LINE__)[(x) ? -1 : 1] \
>> -        __attribute__((unused))
>> +#define QEMU_BUILD_BUG_ON_STRUCT(x) \
>> +    struct { \
>> +        int qemu_build_bug_on : (x) ? -1 : 1; \
>> +    }
>=20
> The problem with this is it can't be used as an expression, where as
> your previous version could.
> I've got a similar case (see previous reply) that needed an expression
> bug-on that would evaluate to zero.

Keep reading the series - the version usable in an expression is
QEMU_BUILD_BUG_ON_ZERO, introduced in 3/4.  Patch 2/4 is just rewriting
the existing check, with no change in the fact that it is still a
declaration.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--oRFPsHufXLG2pSjudvDKprsi92OCBFqMA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYgiBYAAoJEKeha0olJ0NqwfQH/11zvL6/jAAR0UM22DkDRanp
HX/ifR5W/1HbQPOatHmmtHYxOD6ZvLMTUZlHN9MjWeavpv5ye51XQ+PWF1gMl5RE
45bk8cVwmQ8IeUhw9vqxAJpOdThTWVaRdUZVfI8v6bQU8+atxoqFQjbTNI67r57I
taZm3sJbd9rfcsR4sQxpI78tb3AaRW3MAziZ8vYn6wi/e0D0J/rZsZ2vaTQQeRi4
XRKKgp4LB/z4pamol7bZBPKxOMMvO+X5ul5bP7VM+AWMpQLmoZB5miQXzMuz9vUm
M9IuLjKLVLvd3VIcdrZELrdJBwsuHep1ey53De7BHKO9kn2crqKaL+KPbao1XhI=
=FzmS
-----END PGP SIGNATURE-----

--oRFPsHufXLG2pSjudvDKprsi92OCBFqMA--
