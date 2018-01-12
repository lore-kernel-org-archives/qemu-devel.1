Received: from eggs.gnu.org ([2001:4830:134:3::10]:57731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ea0BW-0006sQ-AJ
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 09:19:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ea0BT-0001jF-M7
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 09:19:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47270)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ea0BT-0001il-FK
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 09:19:51 -0500
Date: Fri, 12 Jan 2018 14:18:50 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180112141850.GB11423@stefanha-x1.localdomain>
References: <20171219084557.9801-1-peterx@redhat.com>
	<20171219084557.9801-22-peterx@redhat.com>
	<20180109140810.GF31400@stefanha-x1.localdomain>
	<20180112062351.GM2551@xz-mi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v9Ux+11Zm5mwPlX6"
Content-Disposition: inline
In-Reply-To: <20180112062351.GM2551@xz-mi>
Subject: Re: [Qemu-devel] [RFC v6 21/27] qmp: support out-of-band (oob)
 execution
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>


--v9Ux+11Zm5mwPlX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 12, 2018 at 02:23:51PM +0800, Peter Xu wrote:
> Good to know the "?:" syntax...  Thanks,

It's a gcc extension and not part of the C standard:

https://gcc.gnu.org/onlinedocs/gcc/Conditionals.html#Conditionals

However, QEMU already uses it in several places so we can take advantage
of it.

Stefan

--v9Ux+11Zm5mwPlX6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaWMPKAAoJEJykq7OBq3PILOsIAL81HO18CnP9a8Pw9FCbuTMf
HYlbrwiXICSwtlJOx0MewkeJe2XQwuiRqgA2u0mjJrymtHNNbZuNFH+FITzsd0b5
sxqsktxE9a9Hz9YOIpiFvntHj4ms6JTbjNBYpRFZqfJLkf3QJmFCmMSbMmffNSqp
o8lc9QeEwVAD771qJS/xoyFMNeFz9SOZTgI2f2s8Q+cWC/6mFtv/XK+WV7JH8c3U
Y0mC3qK72LyLbCeX/hXfAWDGwGzntNcKUjuFaAIEkn7XxZfRTN1/8k+Z5RVeI5UQ
BP4TdNPH7zNF0vc9YTXVyk2i8JJL7Ny998gaXxGP74Vpo9hNDd415puLxFR19I4=
=p/WL
-----END PGP SIGNATURE-----

--v9Ux+11Zm5mwPlX6--
