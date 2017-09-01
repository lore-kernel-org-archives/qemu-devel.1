Received: from eggs.gnu.org ([2001:4830:134:3::10]:39891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dnrai-0007dX-2E
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 15:26:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dnrae-00069M-Tj
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 15:26:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43234)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1dnrae-00068L-L8
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 15:26:52 -0400
References: <87r2w6eq5n.fsf@gmail.com> <87h8x1yox3.fsf@dusky.pond.sub.org>
	<20170830170941.GB24565@stefanha-x1.localdomain>
	<87bmmwi6r6.fsf@dusky.pond.sub.org>
	<CAFEAcA8r-EqOjZDvP=0mYG7QQ83MU-54RL9Bu8Eb_wPzQo1M7Q@mail.gmail.com>
	<87r2vrlwr3.fsf@dusky.pond.sub.org> <20170831131412.GK17315@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <a763a037-7279-793b-5b92-3b956a85a5b5@redhat.com>
Date: Fri, 1 Sep 2017 21:26:46 +0200
MIME-Version: 1.0
In-Reply-To: <20170831131412.GK17315@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pHrIDOXX7lth1I5D36FKiRPh74GhjF0m8"
Subject: Re: [Qemu-devel] [PATCH] scripts: Support building with Python 3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, David Michael <fedora.dm0@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pHrIDOXX7lth1I5D36FKiRPh74GhjF0m8
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 David Michael <fedora.dm0@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <a763a037-7279-793b-5b92-3b956a85a5b5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] scripts: Support building with Python 3
References: <87r2w6eq5n.fsf@gmail.com> <87h8x1yox3.fsf@dusky.pond.sub.org>
 <20170830170941.GB24565@stefanha-x1.localdomain>
 <87bmmwi6r6.fsf@dusky.pond.sub.org>
 <CAFEAcA8r-EqOjZDvP=0mYG7QQ83MU-54RL9Bu8Eb_wPzQo1M7Q@mail.gmail.com>
 <87r2vrlwr3.fsf@dusky.pond.sub.org> <20170831131412.GK17315@redhat.com>
In-Reply-To: <20170831131412.GK17315@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-08-31 15:14, Daniel P. Berrange wrote:

[...]

> NB, some distros have already changed /usr/bin/python to point to py3
> so all the files with #!/usr/bin/python in QEMU are already broken on
> those distros.

For what it's worth, I (at least used to) build qemu regularly on Arch
Linux and the only issue I encountered with this is that the iotests
wouldn't work.  As a workaround, I made the check script detect that
interpreter line and just run the script through the interpreter
configured through --python, so it works now...

So from what I could tell, everything worked when you specify
--python=3Dpython2.

Max


--pHrIDOXX7lth1I5D36FKiRPh74GhjF0m8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlmptHcSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AuOgIAKHBO/UPeroCrGnLmVFaOwqvX7C/1njH
swK2LCjkURhhfib9rQWATnffEehNN2apChAydvTP2uRyOGEiA2wmgpiNDvHqDUBN
Zp0VpWWpaOz7yr3CMV552OBunIlCh1xh3Irsbek8BvLDNOdpaz/p1rzzy8uBe/Ga
FkEV00Gpez2PSZmlUMJTnW2iexTvk37cSDvSA+0OsnlLeba8dbJufWNEq8eqR+HC
5sy8DCNB9TbFoQMWvBIVPO68hQuk3MQyN2DEAMBZIeheFOHPA1EPwJ80R3jtwD7v
uzwKuFjlmCjjA54KLGZ6aiQclCE9AWjqZi5HbkWA0Z13Xx+IYxpbMzk=
=P4SA
-----END PGP SIGNATURE-----

--pHrIDOXX7lth1I5D36FKiRPh74GhjF0m8--
