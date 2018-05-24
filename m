Received: from eggs.gnu.org ([2001:4830:134:3::10]:54999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fLqf4-0002KK-4O
	for qemu-devel@nongnu.org; Thu, 24 May 2018 09:52:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fLqez-0008Fp-I1
	for qemu-devel@nongnu.org; Thu, 24 May 2018 09:52:10 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:46704)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fLqez-0008FN-Af
	for qemu-devel@nongnu.org; Thu, 24 May 2018 09:52:05 -0400
Received: by mail-wr0-x242.google.com with SMTP id x9-v6so3273474wrl.13
	for <qemu-devel@nongnu.org>; Thu, 24 May 2018 06:52:04 -0700 (PDT)
Date: Thu, 24 May 2018 14:52:02 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180524135202.GA28984@stefanha-x1.localdomain>
References: <20180515143548.29841-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <20180515143548.29841-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] memory: get rid of
 memory_region_init_reservation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 15, 2018 at 04:35:48PM +0200, Paolo Bonzini wrote:
> The function has been deprecated for 2.5 years, and there are just a hand=
ful
> of users.  Convert them to memory_region_init_io with NULL callbacks,
> and while at it pass the right device as the owner.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  docs/devel/memory.txt |  5 ++---
>  hw/i386/kvm/i8254.c   |  2 +-
>  hw/i386/kvm/i8259.c   |  4 ++--
>  hw/i386/kvm/ioapic.c  |  2 +-
>  include/exec/memory.h | 23 -----------------------
>  5 files changed, 6 insertions(+), 30 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbBsOCAAoJEJykq7OBq3PIdgMH/1AgpcJOUHtabjmPQB2PklcH
D+ArxjHTF06LjvOHaVHrki0JgJiPIWNagNtKvEQ6v0sFHm3elSYI6eUrN6tdRqTc
DQ3lk1qGq0aqVphGT2PSV2wwLOhz9lamGoM1KQPATGCar4i81mvPe1DAJw7XbF1U
olK8tSCvJcTc2yuVmz5ahIO5T/N6Gk85PzjGfWRTXLgX03JjQXzsdu0mRvVRj8bZ
lfUAr90NYoQ0exG/JCHzMDOC9GxQvOq7jOKNpCB8UfKtIPKJbNYeiAs4qtT8ot4q
0h4oyHh2GzH/ie7cX5QFaDJvwd6h+L8K/tfor7wi6w1ghJmyS01sULfJfd9sQYU=
=x03Q
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
