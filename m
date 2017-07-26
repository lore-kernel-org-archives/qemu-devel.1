Received: from eggs.gnu.org ([2001:4830:134:3::10]:37166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1daQZd-0007Bm-W3
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 13:58:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1daQZd-0004mP-54
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 13:58:18 -0400
Date: Wed, 26 Jul 2017 18:58:08 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170726175808.GD3600@stefanha-x1.localdomain>
References: <20170721034730.25612-1-crosa@redhat.com>
	<20170721123325.GC18014@stefanha-x1.localdomain>
	<20170721140155.GQ17693@redhat.com>
	<bcf52c05-1d73-a56f-98ae-7029a924786b@redhat.com>
	<20170725154921.GS23343@stefanha-x1.localdomain>
	<547d0cd0-052c-a1e5-e116-483d2a176ab8@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XvKFcGCOAo53UbWW"
Content-Disposition: inline
In-Reply-To: <547d0cd0-052c-a1e5-e116-483d2a176ab8@redhat.com>
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


--XvKFcGCOAo53UbWW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2017 at 12:16:13PM -0400, Cleber Rosa wrote:
> On 07/25/2017 11:49 AM, Stefan Hajnoczi wrote:
> > On Fri, Jul 21, 2017 at 10:21:24AM -0400, Cleber Rosa wrote:
> >> On 07/21/2017 10:01 AM, Daniel P. Berrange wrote:
> >>> On Fri, Jul 21, 2017 at 01:33:25PM +0100, Stefan Hajnoczi wrote:
> >>>> On Thu, Jul 20, 2017 at 11:47:27PM -0400, Cleber Rosa wrote:
> >> Without the static capabilities defined, the dynamic check would be
> >> influenced by the run time environment.  It would really mean "qemu-io
> >> running on this environment (filesystem?) can do native aio".  Again,
> >> that's not the best type of information to depend on when writing test=
s.
> >=20
> > Can you explain this more?
> >=20
> > It seems logical to me that if qemu-io in this environment cannot do
> > aio=3Dnative then we must skip those tests.
> >=20
> > Stefan
> >=20
>=20
> OK, let's abstract a bit more.  Let's take this part of your statement:
>=20
>  "if qemu-io in this environment cannot do aio=3Dnative"
>=20
> Let's call that a feature check.  Depending on how the *feature check*
> is written, a negative result may hide a test failure, because it would
> now be skipped.

You are saying a pass->skip transition can hide a failure but ./check
tracks skipped tests.  See tests/qemu-iotests/check.log for a
pass/fail/skip history.

It is the job of the CI system to flag up pass/fail/skip transitions.
You're no worse off using feature tests.

Stefan

--XvKFcGCOAo53UbWW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZeNgwAAoJEJykq7OBq3PIqTEIAMX5G3m0DREZQdn9orwCW9un
dmJNa4+K7xH64rAQWwKM9wudBTfvW8A/DD+iexWTzlmWtK0r/AjYd8kirobNx+a9
dLtygL3ka9yYvGWJT9u7pWBgPqcROKS3Qdy3R6p5cnMcDP7UQBuqmLHq9O0bUsgw
QoDUJRtUzoYSGOuE+vOZN5Gi6YUexHBYwoiUnaiX8lS5dYzbMZhJYBYd6Rm7cKtJ
N5UsjInJ6T+DWE2aw6lSbxM4XXizLFkt9aYbeRBEy6MydbM/xSnl7bvz+R/ulGiT
O0fnGK/o3jckAcpNSEH8rW8THi63qK2PmEjXhdlwxBzvECWWLQ1/N0B6DsDs+Fo=
=5Sck
-----END PGP SIGNATURE-----

--XvKFcGCOAo53UbWW--
