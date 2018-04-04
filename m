Received: from eggs.gnu.org ([2001:4830:134:3::10]:51271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f3diU-0006tI-5y
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 04:24:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f3diR-0002gu-3S
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 04:24:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59198 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1f3diQ-0002gg-V9
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 04:24:23 -0400
Date: Wed, 4 Apr 2018 16:24:19 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180404082419.GF12052@lemon.usersys.redhat.com>
References: <20180404025201.11921-1-famz@redhat.com>
	<20180404081919.GC3186@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180404081919.GC3186@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/3] Add a CentOS test image to run docker
 tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, pbonzini@redhat.com, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>

On Wed, 04/04 09:19, Daniel P. Berrang=E9 wrote:
> On Wed, Apr 04, 2018 at 10:51:58AM +0800, Fam Zheng wrote:
> > Docker testing on patchew has long suffered from 'make check' hanging=
s. The
> > cleanness of VM testing is the cure. Now let's add a CentOS 7 image t=
o run the
> > tests.  It's purely ad-hoc, but hopefully still easy to understand an=
d use for
> > everyone.
>=20
> If our automated tests are hanging, then developers could hit those han=
gs
> to, and depending on where the problem is, end users could hit the hang=
s
> in production deployment.
>=20
> IOW, hangs in the testing aren't something we should just hide away by
> changing the way we run tests - we need to identify & fix the hangs.

This will not hide anything. It just helps how we clean up everything
(especially the hanging test process in patchew) when timeout, and doesn'=
t
affect how we identify and report timeouts.

Fam
