Received: from eggs.gnu.org ([2001:4830:134:3::10]:39963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fo6Xx-0000SI-2K
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 08:29:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fo6Xt-0001Dp-Sf
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 08:29:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47374 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fo6Xt-0001Cv-Ir
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 08:29:33 -0400
References: <20180809141403.11296-1-olaf@aepfle.de>
	<20180809162403.32c53c50.olaf@aepfle.de>
	<30203041-c944-1a12-d983-9735756dc334@redhat.com>
	<20180809163816.092a7c8c.olaf@aepfle.de>
	<a75c67d5-816d-a603-b7bb-12a28f034fb1@redhat.com>
	<20180809165549.5c92d5f4.olaf@aepfle.de>
	<dba2887e-a59c-d05e-1642-b22623199cc5@redhat.com>
	<840c9f90-3299-e2e5-63b6-5d368d15da5c@redhat.com>
	<20180810123221.785ae741.olaf@aepfle.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a08c692b-5e62-9469-db63-b4b439e9afc3@redhat.com>
Date: Fri, 10 Aug 2018 14:29:28 +0200
MIME-Version: 1.0
In-Reply-To: <20180810123221.785ae741.olaf@aepfle.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="VfSYDt897f0VrjITHGXSpYueXNe3AS1Dh"
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
To: Olaf Hering <olaf@aepfle.de>
Cc: Richard Henderson <rth@twiddle.net>, "open list:Overall" <qemu-devel@nongnu.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VfSYDt897f0VrjITHGXSpYueXNe3AS1Dh
From: Paolo Bonzini <pbonzini@redhat.com>
To: Olaf Hering <olaf@aepfle.de>
Cc: Richard Henderson <rth@twiddle.net>,
 "open list:Overall" <qemu-devel@nongnu.org>,
 Peter Crosthwaite <crosthwaite.peter@gmail.com>
Message-ID: <a08c692b-5e62-9469-db63-b4b439e9afc3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1] exec: handle NULL pointer in
 flatview_read_continue
References: <20180809141403.11296-1-olaf@aepfle.de>
 <20180809162403.32c53c50.olaf@aepfle.de>
 <30203041-c944-1a12-d983-9735756dc334@redhat.com>
 <20180809163816.092a7c8c.olaf@aepfle.de>
 <a75c67d5-816d-a603-b7bb-12a28f034fb1@redhat.com>
 <20180809165549.5c92d5f4.olaf@aepfle.de>
 <dba2887e-a59c-d05e-1642-b22623199cc5@redhat.com>
 <840c9f90-3299-e2e5-63b6-5d368d15da5c@redhat.com>
 <20180810123221.785ae741.olaf@aepfle.de>
In-Reply-To: <20180810123221.785ae741.olaf@aepfle.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 10/08/2018 12:32, Olaf Hering wrote:
> Am Fri, 10 Aug 2018 12:25:09 +0200
> schrieb Paolo Bonzini <pbonzini@redhat.com>:
>=20
>> There are many more callers of qemu_ram_ptr_length, and none of them c=
heck the result.
>=20
> So you mean that function must not return NULL?
> Or should the caller check for the result?

Either, but the former would of course be much simpler if possible.

Paolo


--VfSYDt897f0VrjITHGXSpYueXNe3AS1Dh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAltthSkACgkQv/vSX3jH
roNc8gf+P1xXiTb5/OuYtoP1L8FdrNE5bWjIYvDC9uyyjAC+x0W1v71bzs1pkR5r
Fd92gG01IS11YztVxc0XkyABaF9/vIDKII+cHGT0Kv1jiBm2kl2De6pggeozdB7l
GIBM7AbzlzboYyOsCR1YLBt1CikF/GMCoPHFkmgFZ7M4ain4wK4sez5anLVlq8DA
6TWzNmG/t33K7SnvhLSVKxgMmbFluJ0Ugo23Vl0CPm4nzPowxrXWldfMoXUGRap7
JHxy38YnxgeWLRKl7I8a/qrb12ptOkN/PXhoc4fkrQmqc5qvKpRlGH/oHwzfciG0
hjSXpB5u0dqxqDP7F9KsYfRn+JQ1+g==
=Bq9H
-----END PGP SIGNATURE-----

--VfSYDt897f0VrjITHGXSpYueXNe3AS1Dh--
