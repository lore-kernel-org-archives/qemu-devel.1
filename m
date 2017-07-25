Received: from eggs.gnu.org ([2001:4830:134:3::10]:57717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1da25S-0003NZ-Uj
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:49:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1da25S-0007Mc-9S
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:49:31 -0400
Date: Tue, 25 Jul 2017 16:49:21 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170725154921.GS23343@stefanha-x1.localdomain>
References: <20170721034730.25612-1-crosa@redhat.com>
	<20170721123325.GC18014@stefanha-x1.localdomain>
	<20170721140155.GQ17693@redhat.com>
	<bcf52c05-1d73-a56f-98ae-7029a924786b@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O3bhLwMadv7h6/J9"
Content-Disposition: inline
In-Reply-To: <bcf52c05-1d73-a56f-98ae-7029a924786b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/3] build configuration query tool and
 conditional (qemu-io)test skip
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Jing Liu <liujbjl@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>


--O3bhLwMadv7h6/J9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 21, 2017 at 10:21:24AM -0400, Cleber Rosa wrote:
> On 07/21/2017 10:01 AM, Daniel P. Berrange wrote:
> > On Fri, Jul 21, 2017 at 01:33:25PM +0100, Stefan Hajnoczi wrote:
> >> On Thu, Jul 20, 2017 at 11:47:27PM -0400, Cleber Rosa wrote:
> Without the static capabilities defined, the dynamic check would be
> influenced by the run time environment.  It would really mean "qemu-io
> running on this environment (filesystem?) can do native aio".  Again,
> that's not the best type of information to depend on when writing tests.

Can you explain this more?

It seems logical to me that if qemu-io in this environment cannot do
aio=native then we must skip those tests.

Stefan

--O3bhLwMadv7h6/J9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZd2iBAAoJEJykq7OBq3PISLIIAIKQ0+wd33fyXytQQv3QIW/M
f1dlIE+SZ7CMDn5lhleoBML0BCnKINRvTS8lOdBfloENGuwWFOp6Jh3ZLGItT9rq
woLraEmQS0uHQC8ZlCNJAwXO3fWaHfKhtROJLbHGW2xLfX68N9sfZINr6Z6N7GMJ
GUU11WqmEMhvhaGelIITqW00+72FqkT70LM5yML7/5Hc6RA9rw2a7s1Y9XPoZJmJ
ZUGsLnyfRLH5lf58jhOmsSBqQJhM2aDOrzUAY546a2wGvoh1jvzYUSib5PkChZRv
EbuOoCVeWe9q0pPzGrJq0gdf0VbJSY/uayqNpas5M23jJH7dIhA4aRzY2l93FQc=
=w6Ez
-----END PGP SIGNATURE-----

--O3bhLwMadv7h6/J9--
