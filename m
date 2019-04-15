Received: from eggs.gnu.org ([209.51.188.92]:59579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hFyJQ-0003a4-42
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 05:54:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hFyJP-0005uC-7p
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 05:54:04 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:33316)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hFyJO-0005tj-VG
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 05:54:03 -0400
Received: by mail-wr1-x436.google.com with SMTP id q1so21106303wrp.0
	for <qemu-devel@nongnu.org>; Mon, 15 Apr 2019 02:54:02 -0700 (PDT)
Date: Mon, 15 Apr 2019 10:54:00 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190415095400.GD29134@stefanha-x1.localdomain>
References: <839EC771-5973-4B05-BC76-D6CC5EE63A43@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cHMo6Wbp1wrKhbfi"
Content-Disposition: inline
In-Reply-To: <839EC771-5973-4B05-BC76-D6CC5EE63A43@gmail.com>
Subject: Re: [Qemu-devel] Booting from a Bootcamp partition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, John Snow <jsnow@redhat.com>


--cHMo6Wbp1wrKhbfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 14, 2019 at 07:33:17PM -0400, Programmingkid wrote:
> Hi I was wondering if anyone has been able to boot from a bootcamp partit=
ion inside of QEMU. I know this partition can be used in QEMU but my own at=
tempts at booting Windows 7 on my bootcamp partition did not work. I always=
 see "A disk read error occurred". Has anyone else been successful at this?=
=20

Hi,
It's difficult to help without more information:
1. What is your QEMU command-line?
2. What is the partition table on the disk?

General problems with booting Windows are usually caused by a guest
configuration that doesn't match the hardware configuration that Windows
was installed under.  Can you check that the AHCI bus address of the
disk and partition numbering matches what Windows expected?

It may also be useful to enable tracing (see docs/devel/tracing.txt) to
see what the ahci_* trace event log says.  I have CCed John Snow, one of
the few people who can read this log :).

Stefan

--cHMo6Wbp1wrKhbfi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJctFS4AAoJEJykq7OBq3PIukYIAIS4icUascjT/GGtZCcQ1Xtb
YWpRKWxfq7dDcRIGeRN+kIiBim+BcV36LaEb0QfDg82KzvNI55GFy/PhfZrrf5RA
7eoIJmwqghGYOWJZaWN3dOQtnKKhy6RDNiLIhwead7Kt10XSHP5vUQm6nFKhiemt
BYbw93Oe3bLmgBNBEmykgooEr8WZinJ/iL+/lZbjdP86CuvSWEipJjzcBXoghXgR
5A5IfpYlJplM3kH/KzLGdiicw1oMyqW1Sd4/raigQKIEEPLytHpub/P2HF4ABHH4
MAb96GaYZsui/bxBF76dgmbdXHHNgwIqimwaNI/lsC6qyty5l1wGWwojh+7PPjc=
=R1Fm
-----END PGP SIGNATURE-----

--cHMo6Wbp1wrKhbfi--
