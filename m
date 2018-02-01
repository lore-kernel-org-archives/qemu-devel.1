Received: from eggs.gnu.org ([2001:4830:134:3::10]:57647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ehGQq-0006t2-Nv
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 10:05:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ehGQm-0002EB-09
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 10:05:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59140)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ehGQl-0002Dt-QZ
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 10:05:39 -0500
References: <20180201144430.14441-1-pbonzini@redhat.com>
	<20180201144430.14441-5-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <495e389b-7fea-903c-6c40-1583ba85ef9f@redhat.com>
Date: Thu, 1 Feb 2018 09:05:33 -0600
MIME-Version: 1.0
In-Reply-To: <20180201144430.14441-5-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="RgPfK2iIQygZ1IpoQUVjPWdbUh8CeipLd"
Subject: Re: [Qemu-devel] [PATCH 4/6] cpus: tcg: unregister thread with RCU,
 fix exiting of loop on unplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: linzc@zju.edu.cn

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RgPfK2iIQygZ1IpoQUVjPWdbUh8CeipLd
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: linzc@zju.edu.cn
Message-ID: <495e389b-7fea-903c-6c40-1583ba85ef9f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 4/6] cpus: tcg: unregister thread with RCU,
 fix exiting of loop on unplug
References: <20180201144430.14441-1-pbonzini@redhat.com>
 <20180201144430.14441-5-pbonzini@redhat.com>
In-Reply-To: <20180201144430.14441-5-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/01/2018 08:44 AM, Paolo Bonzini wrote:
> Keep running until cpu_can_run(cpu) becomes false, for consistency
> with other acceslerators.

s/acceslerators/accelerators/

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--RgPfK2iIQygZ1IpoQUVjPWdbUh8CeipLd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpzLL0ACgkQp6FrSiUn
Q2rGFAf+N5sKmmasaZlYA4f37DZagUKVAtUyIlP01WFYPn5Lnn0gTnN2L1l3jrmt
o1hQKnaVmI+z3DPY3+475WC0bZjrd/aMwSGGxjIqqiz8l/9xk4PxWc8gwQHkvUrM
bRhLKQVneuhR6VFs4UxDy920iXxFEJT946p6iqnUVnYLiEi9TJXkxQCorwGLWgEq
p2tbFehHu7fan/1qJ3Jy9q/R0BV9izL73ouOTAoYyCmvsEhIdVmNJ/NlZq2zk38P
PW8l/HpvNTndx8LXBCaQnD4aQQZYCjkkw7q9JulGykIckvrymWh8NFYO/l3Gda7G
huuRb7aGJUf/eYkshrGUcaEjO+bc/g==
=a/Sh
-----END PGP SIGNATURE-----

--RgPfK2iIQygZ1IpoQUVjPWdbUh8CeipLd--
