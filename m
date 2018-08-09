Received: from eggs.gnu.org ([2001:4830:134:3::10]:45325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fnm3s-0007a3-Lo
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 10:37:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fnm3q-0007xC-23
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 10:37:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40694 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fnm3p-0007vn-QF
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 10:37:09 -0400
References: <20180809141403.11296-1-olaf@aepfle.de>
	<20180809162403.32c53c50.olaf@aepfle.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <30203041-c944-1a12-d983-9735756dc334@redhat.com>
Date: Thu, 9 Aug 2018 16:37:05 +0200
MIME-Version: 1.0
In-Reply-To: <20180809162403.32c53c50.olaf@aepfle.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="H9t8UsAfbrzBex4Daj9cIFClPDjjbk06s"
Subject: Re: [Qemu-devel] [PATCH v1] exec: handle NULL pointer in
 flatview_read_continue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Olaf Hering <olaf@aepfle.de>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "open list:Overall" <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--H9t8UsAfbrzBex4Daj9cIFClPDjjbk06s
From: Paolo Bonzini <pbonzini@redhat.com>
To: Olaf Hering <olaf@aepfle.de>,
 Peter Crosthwaite <crosthwaite.peter@gmail.com>,
 Richard Henderson <rth@twiddle.net>,
 "open list:Overall" <qemu-devel@nongnu.org>
Message-ID: <30203041-c944-1a12-d983-9735756dc334@redhat.com>
Subject: Re: [PATCH v1] exec: handle NULL pointer in flatview_read_continue
References: <20180809141403.11296-1-olaf@aepfle.de>
 <20180809162403.32c53c50.olaf@aepfle.de>
In-Reply-To: <20180809162403.32c53c50.olaf@aepfle.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 09/08/2018 16:24, Olaf Hering wrote:
> Am Thu,  9 Aug 2018 16:14:03 +0200 schrieb Olaf Hering
> <olaf@aepfle.de>:
>=20
>> The codepaths behind qemu_ram_ptr_length can return NULL.
>
> While that might be a bug by itself, the question is why in that case
> no memset(buf, 0xff, l) is done?

If no RAM is allocated (i.e. xen_map_cache will return NULL), however,
the memory should not be registered as RAM with the memory API.  So I
think the bug is in Xen code.

Paolo


--H9t8UsAfbrzBex4Daj9cIFClPDjjbk06s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAltsUZEACgkQv/vSX3jH
roMeKAf/VOOusc7rXr1njVMXrbOz4q81FPhk0Od/+G2nKILqp1hQu6xqJJ8gPIH8
l5OUXlBsT36mCw7GGVERPH6u/YflMHcSDfwZYt5YEoNuVMxdG8EvnUCN6UHUta7w
uX3gHMM8/G8off/N6xVtF/0WfViK1wOXPdgHZyPK26T30qUQ/Ix5SXm0yUzi5b+Y
EXNIvgZcFLOIVJ/eUN5Hyf2d+hsV87wsNWff0TFFE4ENQdoPzmICGYqUA6avLtRB
ioqdCmQxZCnXCckMf/iyaccjGZHvAmGg/RNcVVXOOoZ7Se0p6U7SQTAY0zMBapuI
0BxCNRcYRc9GUlnB2Vi8oID599aUWg==
=Morl
-----END PGP SIGNATURE-----

--H9t8UsAfbrzBex4Daj9cIFClPDjjbk06s--
