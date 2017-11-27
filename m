Received: from eggs.gnu.org ([2001:4830:134:3::10]:53215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <simon@invisiblethingslab.com>) id 1eJ87f-0006rE-8I
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 20:22:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <simon@invisiblethingslab.com>) id 1eJ87c-0002da-3y
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 20:22:11 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:47571)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <simon@invisiblethingslab.com>)
	id 1eJ87b-0002dK-UN
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 20:22:08 -0500
References: <20170505133952.29885-1-philippevoinov@gmail.com>
From: Simon Gaiser <simon@invisiblethingslab.com>
Message-ID: <2ef7d19a-b4c3-6ab2-827f-804fdbb87b9a@invisiblethingslab.com>
Date: Mon, 27 Nov 2017 01:22:00 +0000
MIME-Version: 1.0
In-Reply-To: <20170505133952.29885-1-philippevoinov@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="1GeADqfrg9FTNxIXLMlrvU2GJLP9xDc9U"
Subject: Re: [Qemu-devel] ui: Support non-zero minimum values for absolute
 input axes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe Voinov <philippevoinov@gmail.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1GeADqfrg9FTNxIXLMlrvU2GJLP9xDc9U
From: Simon Gaiser <simon@invisiblethingslab.com>
To: Philippe Voinov <philippevoinov@gmail.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <2ef7d19a-b4c3-6ab2-827f-804fdbb87b9a@invisiblethingslab.com>
Subject: Re: ui: Support non-zero minimum values for absolute input axes
References: <20170505133952.29885-1-philippevoinov@gmail.com>
In-Reply-To: <20170505133952.29885-1-philippevoinov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Philippe Voinov:
> This patch refactors ui/input.c to support absolute axis
> minimum values other than 0. All dependent calls to qemu_input_queue_ab=
s
> have been updated to explicitly supply 0 as the axis minimum value.

Shouldn't the patch also also pass old_value - 1 as the second argument?
Before qemu_input_queue_abs() expected the size and now the maximal
value.


--1GeADqfrg9FTNxIXLMlrvU2GJLP9xDc9U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE3E8ezGzG3N1CTQ//kO9xfO/xly8FAlobaL8ACgkQkO9xfO/x
ly8Ptw//ecLE+JcrPryy7F0sePH/1LRtyLGlFIyAjuk1auwfGeYtHPM3CCaKF1QA
TnBP3PO7Yia5OBZ53ZnZgv9/qWpcQqsNOfxA2vCLzAoBzpxLt2/o5tfZ5kdOw80O
wCjsKsYddzp/2Avv/UHwCTtzj+/d16MSPywxNKRwxxwBhKNFBdPF5vMuNgJaKQgO
EtnphGRPdNi/7NS2QmPX7vZ57Tpy+ogGlhb7F2Rsi8RjCqSisPHk7M3yzWMpGju1
U6jjmRWtjrPCFpBxuGo4tN0sNYM359TdQV1PpOplnhdpMF7xBrYG7LDm83Mj0gfn
R+cOAcKyTuKkrkiJ68jHK3IKzlOMNEuguWM390WTTRv8h0UA1Ow6jmERLI70J5qq
hiVNDOJXZh19E0BSW6r6zKPtlSZGw/gtpwGc7vIKG7X0TQzwST5qB5mWlm3JXAWv
BwPbMdqDD6ii4H2qecr9WdGenYZPEpog7nrQMFVsHtV+oO5/193teM7TXNHKjJAR
cGOS7rZX+/yQkdgkOcE+Tw6ymBqbd1MbjI9wwgVbfQHn9lFWx5HhI+2IFY0TEGzO
fNxKpAh4Kl2HMZK3f9wp/TJtp2xhu4Ez3f+rWc1AencS1BNwL/uGtp8cDMMi8qz2
r2L8CZ8mxTfmQHa7muRMmib2POcirmugQ4Fnubzg4VQBP3zP+AA=
=NU5e
-----END PGP SIGNATURE-----

--1GeADqfrg9FTNxIXLMlrvU2GJLP9xDc9U--
