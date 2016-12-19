Received: from eggs.gnu.org ([2001:4830:134:3::10]:55022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cIvew-0008HJ-Vh
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 05:59:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cIver-0005g7-E7
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 05:59:11 -0500
Received: from mail-wj0-x22d.google.com ([2a00:1450:400c:c01::22d]:33152)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cIver-0005e7-7q
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 05:59:05 -0500
Received: by mail-wj0-x22d.google.com with SMTP id xy5so145529332wjc.0
	for <qemu-devel@nongnu.org>; Mon, 19 Dec 2016 02:59:02 -0800 (PST)
Date: Mon, 19 Dec 2016 10:58:59 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20161219105859.GB17374@stefanha-x1.localdomain>
References: <CA+scX6=9y4wDBWzXyqpGh9U__usKUa6sxwdc63iA8YRmpWFPqA@mail.gmail.com>
	<20161214193107.GB20648@stefanha-x1.localdomain>
	<CA+scX6=oc_eGteY8A0d8tuwzJFSu9M_6wnXBd5Tp=XGrg8FotQ@mail.gmail.com>
	<CA+scX6n+xcY7qi=XbBcno=OQOfUfJf77ZGfS2s5FbhUCEHQp3A@mail.gmail.com>
	<20161215080634.GF26169@stefanha-x1.localdomain>
	<CA+scX6=Lk8Ea=vkFt_3c5v+n8gbr+uAb7hZ8vM1svzBZWwX7nQ@mail.gmail.com>
	<20161216094850.GA4129@stefanha-x1.localdomain>
	<CA+scX6k2u5E0E6M07S_WOd0633=x1OnLi9jvXVrED+YB3bzaWA@mail.gmail.com>
	<CA+scX6kS1CB8RcFgG-ErgEf7qS2YakNmo0hiEJfmpPfmEReG+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="neYutvxvOLaeuPCA"
Content-Disposition: inline
In-Reply-To: <CA+scX6kS1CB8RcFgG-ErgEf7qS2YakNmo0hiEJfmpPfmEReG+w@mail.gmail.com>
Subject: Re: [Qemu-devel] Lock contention in QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Weiwei Jia <harrynjit@gmail.com>
Cc: qemu-devel@nongnu.org


--neYutvxvOLaeuPCA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 16, 2016 at 04:42:54PM -0500, Weiwei Jia wrote:
> Has x-data-plane been used (or accepted) widely in systems. I have
> this concern since if it hasn't been widely accepted, it may
> have/cause some problems we don't know. Do you know some hidden
> problems which may caused by QEMU x-data-plane feature in systems?

By now virtio-blk dataplane has been tested a fair amount.  virtio-scsi
dataplane is more recent.

I'm not aware of known issues with virtio-blk dataplane in modern QEMU
but you seem to be using an older QEMU.  Originally dataplane had a lot
of limitations (no live migration, no image file formats, no block
jobs) so be sure to check that your QEMU supports these things with
dataplane if you need the features.

Stefan

--neYutvxvOLaeuPCA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYV71zAAoJEJykq7OBq3PI9n4IAKQla+WKJnlQTcvPtxTtaa8p
sa2oo8C/uqbpDrRP6JW7CPIS2fG4JhOKMbctk0oWwY2UWlqyUR02raKqNm0GT5cy
OEJ+E0ZchxCyFfk+Z2OWt2h0JT8sMdQU2p8LUPCtQMMFPzYu/Co7OT817jpD2aEm
/VWbtKeL1f4De1tGJ8qbTFwMXa6e5M0MYggpaV1HhUiEimi0lYPEobo27lSPJ5oj
siXfVZ6W67cF9VzFDGx+2bdXjyBF03rpnB/ka+MWq9QT2RpZP1BxjNraaWypEJbi
4HSZeJLm+zNPAvzQHbloAo1MQBnS0Bq0RcuNiKYpdEzKrdEGAOwjzIM9KaLsfko=
=jxR+
-----END PGP SIGNATURE-----

--neYutvxvOLaeuPCA--
