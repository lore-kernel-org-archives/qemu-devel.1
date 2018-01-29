Received: from eggs.gnu.org ([2001:4830:134:3::10]:37781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eg9ud-00021L-Iy
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 08:56:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eg9ua-0002qJ-H3
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 08:55:55 -0500
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:34434)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eg9ua-0002pk-9S
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 08:55:52 -0500
Received: by mail-wm0-x233.google.com with SMTP id j21so36560030wmh.1
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 05:55:52 -0800 (PST)
Date: Mon, 29 Jan 2018 13:55:48 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180129135548.GJ20446@stefanha-x1.localdomain>
References: <1516655269-1785-1-git-send-email-juterry@microsoft.com>
	<20180125110144.GD27269@stefanha-x1.localdomain>
	<CY4PR2101MB08663FFAC4CD385DDD4C31B1B6E10@CY4PR2101MB0866.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3MMMIZFJzhAsRj/+"
Content-Disposition: inline
In-Reply-To: <CY4PR2101MB08663FFAC4CD385DDD4C31B1B6E10@CY4PR2101MB0866.namprd21.prod.outlook.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/4] Updates based on feedback.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Justin Terry (VM)" <juterry@microsoft.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "crosthwaite.peter@gmail.com" <crosthwaite.peter@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "ehabkost@redhat.com" <ehabkost@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>


--3MMMIZFJzhAsRj/+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2018 at 08:12:57PM +0000, Justin Terry (VM) via Qemu-devel =
wrote:
> I have only tried Ubuntu and Windows guests. Is there a set you would rec=
ommend to try out?
>=20
> As for limitations, this set of patches allows for both bios and efi base=
d boots (we have been using TianoCore). We will continue to submit patches =
around performance tuning on the platform but basic functionality is up and=
 running in this set. The VGA interrupt path can be improved and we are loo=
king at options here to make this a smoother experience. And as mentioned i=
n the update we don't have CPUID support fully implemented yet for migratio=
n scenarios. Was there a specific set of things you were wondering that I c=
ould investigate or provide clarity on?

That sounds good.  I was just wondering what the general status was.

There is no particular set of tests I had in mind.  The KVM kernel
module has a test suite called kvm-unit-tests for low-level guest code
tests (http://www.linux-kvm.org/page/KVM-unit-tests).  There are also
high-level tests written using the Avocado framework
(https://www.linux-kvm.org/page/Avocado).  Neither of these is
immediately useful or necessary for WHPX though.

Stefan

--3MMMIZFJzhAsRj/+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJabyfkAAoJEJykq7OBq3PIs74IAJNLViK01ov99gXAqDJrYLIT
C51n+h+J+wjf2p3VvYHUw2JjMagQqOoLXe92EkygTnlzCrnEhrVP9b536uqVrTx4
Y4xus5g+qfF8da+xAWIbgARisXJpy1h+7l3VxMwO/6IVQzJH93zbsqq4rdCXsWgM
ZPsssTVV2UWSF7nfCMIOF+lXiEQnrvGTh4rWGTh9oidCoHmSyDOtf8X9FO1IF+sC
3BhhJsEfqzWMUAklbTb0psIQkKMobDF7SwKQNV0GW0IUF0o8DNoMzjaK4wDPT1M/
wtXKLa6rcIgaV4PzPXIJoVuRaDi0MHK4p0jwmOUvYUKEMzSWvNW4jcVbjrK1oDQ=
=ttrD
-----END PGP SIGNATURE-----

--3MMMIZFJzhAsRj/+--
