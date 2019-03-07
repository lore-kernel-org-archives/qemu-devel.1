Received: from eggs.gnu.org ([209.51.188.92]:50693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h1qMm-0003g5-Fd
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 05:35:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h1qMg-0003YX-JQ
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 05:35:07 -0500
Date: Thu, 7 Mar 2019 11:34:55 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190307103455.GA5786@linux.fritz.box>
References: <1545387387-9613-1-git-send-email-baiyaowei@cmss.chinamobile.com>
	<20190306215633.GM6818@localhost.localdomain>
	<20190307102206.GC2843@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
In-Reply-To: <20190307102206.GC2843@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] tcmu: Introduce qemu-tcmu
 utility
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Yaowei Bai <baiyaowei@cmss.chinamobile.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, Amar Tumballi <atumball@redhat.com>, Mike Christie <mchristi@redhat.com>, Prasanna Kalever <pkalever@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Xiubo Li <xiubli@redhat.com>


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 07.03.2019 um 11:22 hat Stefan Hajnoczi geschrieben:
> On Wed, Mar 06, 2019 at 10:56:33PM +0100, Kevin Wolf wrote:
> > Am 21.12.2018 um 11:16 hat Yaowei Bai geschrieben:
> > * The first priority should be adding an in-process iscsi target that
> >   can be managed with QMP, similar to the built-in NBD server.
>=20
> Using the in-kernel SCSI target with TCMU, or do you mean implementing
> the iSCSI network protocol inside QEMU?

Using TCMU in this case, of course. This point was about external tool
vs. exporting from a running QEMU instance, not about how to implement
the actual functionality.

Building an external command line tool around QMP functionality is easy,
but the reverse way isn't necessarily. This is why I think QMP-based
should come first.

Kevin

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcgPPPAAoJEH8JsnLIjy/WZloQAJmDzxVkkbkFjH987hYoq7i4
hy+NP0e8aBvDWzq+MTYeN2MS3S3EC2nP36P7EWKiWN000Wm9nMz4gPzavR1N5831
LhgnMmwWi+/vxCe8sIyAAIJBw3kkIeZc/CLGjGLVUs3r6N1WEcxw3qQBwu+wKt3+
i655AD8SV9rim2UKPGoF/p7wNurrGm5He2CRhQ8Gu2qC5l9NvgjaQNic4aEnfv8l
oOwePTU0/mSE8WeQGvADFPH5TdtEDnwl+LWQGpT88TwvRUOwIXKMAcLLcbIybZEr
f4x8ZGtcQn+bruOvu5yAVP+iH/81da0YfVfgSzDOsddyvurAb2NmPKWCsbz00dOo
8atWJOjpwHughb9fhDKtG5ir0RSRoxLypEtH1VnGHUwz/idAy0XhNtFThjTgVIX+
t9Kqjz8t5ebYpKOVE9lmpBkb0y90KXA85aiTfJtE1dCDxhTEipJ+EhMfLcClSnhp
2oDXHfIRrAsQzHxsfbcAp4n/jZvWVVGiVrzV5ps5BvdZMybC2LHw0u6EciRMuqkN
9L+7A0nwlY3l6NUFdAgNMr9d7H6UFXI41173Y4GeiFKywCLjfHImg1/SPvKn9pyy
r3NI6vyFC6OQt5JnbssacIaFEEIAa/XJV6vST8N7c5LcVf4RV7hecv38tYzvCM+s
Cm8/7gCwJzPm2ZYsos55
=EHWC
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
