Received: from eggs.gnu.org ([2001:4830:134:3::10]:40620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <riel@redhat.com>) id 1daTzW-0002Se-Ea
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 17:37:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <riel@redhat.com>) id 1daTzR-0004W9-FJ
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 17:37:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33086)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <riel@redhat.com>) id 1daTzR-0004VH-9k
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 17:37:09 -0400
Message-ID: <1501104453.26846.45.camel@redhat.com>
From: Rik van Riel <riel@redhat.com>
Date: Wed, 26 Jul 2017 17:27:33 -0400
In-Reply-To: <1063764405.34607875.1501076841865.JavaMail.zimbra@redhat.com>
References: <1455443283.33337333.1500618150787.JavaMail.zimbra@redhat.com>
	<CAPcyv4hpbk0jgp+mA=q05zVBV8ZSZvCvV68JJ4gjE3QhK70d1w@mail.gmail.com>
	<20170724102330.GE652@quack2.suse.cz>
	<1157879323.33809400.1500897967669.JavaMail.zimbra@redhat.com>
	<20170724123752.GN652@quack2.suse.cz>
	<1888117852.34216619.1500992835767.JavaMail.zimbra@redhat.com>
	<CAPcyv4in28F3FOVKp9abvrggxPuXdbGynF5=ZvBXCrywoa06JA@mail.gmail.com>
	<1501016375.26846.21.camel@redhat.com>
	<1063764405.34607875.1501076841865.JavaMail.zimbra@redhat.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-JYusrPMC9q1mTsTTcAte"
Mime-Version: 1.0
Subject: Re: [Qemu-devel] KVM "fake DAX" flushing interface - discussion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pankaj Gupta <pagupta@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>, Jan Kara <jack@suse.cz>, Stefan Hajnoczi <stefanha@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, kvm-devel <kvm@vger.kernel.org>, Qemu Developers <qemu-devel@nongnu.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@ml01.01.org>, ross zwisler <ross.zwisler@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Nitesh Narayan Lal <nilal@redhat.com>, xiaoguangrong eric <xiaoguangrong.eric@gmail.com>, Haozhong Zhang <haozhong.zhang@intel.com>, Ross Zwisler <ross.zwisler@intel.com>


--=-JYusrPMC9q1mTsTTcAte
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2017-07-26 at 09:47 -0400, Pankaj Gupta wrote:
> >=20
> Just want to summarize here(high level):
>=20
> This will require implementing new 'virtio-pmem' device which
> presents=C2=A0
> a DAX address range(like pmem) to guest with read/write(direct
> access)
> & device flush functionality. Also, qemu should implement
> corresponding
> support for flush using virtio.
>=20
Alternatively, the existing pmem code, with
a flush-only block device on the side, which
is somehow associated with the pmem device.

I wonder which alternative leads to the least
code duplication, and the least maintenance
hassle going forward.

--=20
All rights reversed
--=-JYusrPMC9q1mTsTTcAte
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJZeQlFAAoJEM553pKExN6DiSQH/1hmL95ousOGG7V/6Q2fhd+M
0PxKilryMGxgkwyqCJlYtsOlkgJfwr5BHNdQpyy0FEuUC6zbv1hQN9bcKmhjS7Ay
ix4JJ7Cc2GwYFO28olqdD3m8/kZZ4colOuJQH8aT+i/kxm1jHA4Sny0eqTkmblLG
SMAQlVIDlQjsMryknymzriiv9aCV0IEDWfUqcvidWH0mpf1TixGxAi0nosQAkzPz
8iCbsUt5ZiGNhbWIWIloIvMZwtFOW8rf+p/DwT9X3Rp8cCdCimHJDB9VnAugUnBP
v+a/pXGYaTiyyFm8dEIURNRLKufHlrZ/AORWGNjsPwpsTakcjLZuDg6B9wsBR80=
=KCNx
-----END PGP SIGNATURE-----

--=-JYusrPMC9q1mTsTTcAte--
