Received: from eggs.gnu.org ([209.51.188.92]:46109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gpRh9-00009q-Dr
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 00:48:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gpRh8-0001Qq-Q4
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 00:48:55 -0500
Date: Fri, 1 Feb 2019 13:48:49 +0800
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190201054849.GH23131@stefanha-x1.localdomain>
References: <CABdb7345_Nu_kpsSDGq7OyOSuKmgtyS-DuXTafkGeaCCXzV5LQ@mail.gmail.com>
	<VI1PR1001MB1373B1F3C97D9528166E2305B7C40@VI1PR1001MB1373.EURPRD10.PROD.OUTLOOK.COM>
	<CABdb735e_NjY47LRZ58+zvKGmCRQKAmFo-HhByhsosRzQkOgxA@mail.gmail.com>
	<HE1PR1001MB1371F7874B487B0907C42A7EB7C50@HE1PR1001MB1371.EURPRD10.PROD.OUTLOOK.COM>
	<CABdb7372Pv3hR4S8C0TCV19u9XAKn=y0VmreGuZavhOjqRrypQ@mail.gmail.com>
	<VI1PR1001MB13731144A5E55914A9E414A5B7DA0@VI1PR1001MB1373.EURPRD10.PROD.OUTLOOK.COM>
	<CABdb7377U9SpZno1kU6+TuARUmqfMMcC2uuwXTHqSZpLsqB7Gw@mail.gmail.com>
	<1498199343.2815.0@smtp-mail.outlook.com>
	<VI1PR1001MB13731EF256C1E7380E1D657AB7D90@VI1PR1001MB1373.EURPRD10.PROD.OUTLOOK.COM>
	<VI1PR0602MB324559765BFE372F75D52E57A4910@VI1PR0602MB3245.eurprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Bg2esWel0ueIH/G/"
Content-Disposition: inline
In-Reply-To: <VI1PR0602MB324559765BFE372F75D52E57A4910@VI1PR0602MB3245.eurprd06.prod.outlook.com>
Subject: Re: [Qemu-devel] [Qemu-block] Guest unresponsive after Virtqueue
 size exceeded error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fernando Casas =?iso-8859-1?Q?Sch=F6ssow?= <casasfernando@hotmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>


--Bg2esWel0ueIH/G/
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 31, 2019 at 11:32:32AM +0000, Fernando Casas Sch=F6ssow wrote:
> Sorry for resurrecting this thread after so long but I just upgraded the =
host to Qemu 3.1 and libvirt 4.10 and I'm still facing this problem.
> At the moment I cannot use virtio disks (virtio-blk nor virtio-scsi) with=
 my guests in order to avoid this issue so as a workaround I'm using SATA e=
mulated storage which is not ideal but is perfectly stable.
>=20
> Do you have any suggestions on how can I progress troubleshooting?
> Qemu is not crashing so I don't have any dumps that can be analyzed. The =
guest is just "stuck" and all I can do is destroy it and start it again.
> It's really frustrating that after all this time I couldn't find the caus=
e for this issue so any ideas are welcome.

Hi Fernando,
Please post your QEMU command-line (ps aux | grep qemu) and the details
of the guest operating system and version.

Stefan

--Bg2esWel0ueIH/G/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcU93BAAoJEJykq7OBq3PIsE4H/RIG4LhQvuoXg9fR+0oVaqIO
LjmjCzA7wQGtAqp01Inl9n2k0V3/5bX+KvQMSL3hq4Luih5ZXYColr59llTLT61u
NM4rnpSKkA7I6e/b0utH7plhCa2Pyu6jqjEjJrpYw9VPJLsi6u+6lj23NX7dZeM5
QRUEUxZBMlNSkt1N0OJ4ged44Y9XIMfcCQGytc90rTr732t/j312RdS28FvxVTv6
bqmKIPmL7tgTx+dvFOA3eSWSMVTAnF7qldmk8BX9Pp8JvJ3sRvzyuL3SD/s/l2t1
ls8zEUrqCLU52GUAOr3F4j8MrxZmcI51L4SIealMXsa2sO2BpJnkFex6xdlGUaQ=
=ogaC
-----END PGP SIGNATURE-----

--Bg2esWel0ueIH/G/--
