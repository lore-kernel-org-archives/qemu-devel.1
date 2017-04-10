Received: from eggs.gnu.org ([2001:4830:134:3::10]:60420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cxaoz-0000UO-FN
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 11:01:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cxaos-0008UO-QL
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 11:01:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60112)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cxaos-0008U0-HE
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 11:01:30 -0400
References: <1491814757-62684-1-git-send-email-longpeng2@huawei.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <54cc08ec-ecd1-74f6-5a5a-d4df94dd6758@redhat.com>
Date: Mon, 10 Apr 2017 10:01:27 -0500
MIME-Version: 1.0
In-Reply-To: <1491814757-62684-1-git-send-email-longpeng2@huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UXJp00nwc8eB9qHC43pUSPJdOHw4ks9Pi"
Subject: Re: [Qemu-devel] [PATCH for-2.10 01/19] crypto: cipher: introduce
 context free function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Longpeng(Mike)" <longpeng2@huawei.com>, berrange@redhat.com
Cc: xuquan8@huawei.com, arei.gonglei@huawei.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UXJp00nwc8eB9qHC43pUSPJdOHw4ks9Pi
From: Eric Blake <eblake@redhat.com>
To: "Longpeng(Mike)" <longpeng2@huawei.com>, berrange@redhat.com
Cc: xuquan8@huawei.com, arei.gonglei@huawei.com, qemu-devel@nongnu.org
Message-ID: <54cc08ec-ecd1-74f6-5a5a-d4df94dd6758@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 01/19] crypto: cipher: introduce
 context free function
References: <1491814757-62684-1-git-send-email-longpeng2@huawei.com>
In-Reply-To: <1491814757-62684-1-git-send-email-longpeng2@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/10/2017 03:59 AM, Longpeng(Mike) wrote:
> Refactors the qcrypto_cipher_free(), splits it into two parts. One
> is gcrypt/nettle__cipher_free_ctx() to free the special context.

Your mail forgot to include 'In-Reply-To:' and 'References:' headers;
and therefore you resulted in sending 20 top-level threads instead of 19
replies to the 0/19 cover letter (the one with Message-ID:
<1491814997-58268-1-git-send-email-longpeng2@huawei.com>).  Please fix
your setup for sending patch series, as it gets very hard to follow
improperly threaded series.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--UXJp00nwc8eB9qHC43pUSPJdOHw4ks9Pi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY655HAAoJEKeha0olJ0NqmdkIAI43A0iiMG4LdVnUmJ/KlUxz
KRD6IEaKY56v2DT8wZ1uTomDCVwaK1omvWtTeA9nbmysjqtv5lHIhtTcA+p8KVnk
2Ac67paysQajHn8XLyzC+yKw2g8Nd1T43F5nNHKi/d1doichswzxt5LES73h88hI
/PrTZW+mvIRHj5h/8GQu+xeVX0gHDriVRff0bhK44W75ICx76FROVq61DUP16qzL
NX6jEygURc29lOoeK3mJePpjIz5Df1Fo1QalmGOllsP0aUedoBgZQu3UM4t6GNLb
Ol/mu5j8cgCLVfoK9Nuns3QDstLs2EeMt498jI9gRQttvYKDzvft3wT/EHRMpyQ=
=z/Vk
-----END PGP SIGNATURE-----

--UXJp00nwc8eB9qHC43pUSPJdOHw4ks9Pi--
