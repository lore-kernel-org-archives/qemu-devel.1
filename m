Received: from eggs.gnu.org ([2001:4830:134:3::10]:36774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dLA33-000600-T7
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 11:17:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dLA32-00069i-NC
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 11:17:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57411)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dLA32-00069C-ES
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 11:17:32 -0400
Date: Wed, 14 Jun 2017 16:17:27 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170614151727.GN4370@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170607175419.13558-1-berrange@redhat.com>
	<CAFEAcA8eXe2+65KTYPHDpXgK2X3k=bdvVFdWfAAzP-OeWgL1gw@mail.gmail.com>
	<20170614105023.GG4370@redhat.com>
	<15e25d8e-4a2d-6d2a-95b3-9b045abf7af6@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <15e25d8e-4a2d-6d2a-95b3-9b045abf7af6@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v1 0/5] Merge sockets 2017/06/07
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Wed, Jun 14, 2017 at 12:13:33PM -0300, Philippe Mathieu-Daud=C3=A9 wro=
te:
> Hi Daniel,
>=20
> On 06/14/2017 07:50 AM, Daniel P. Berrange wrote:
> > On Mon, Jun 12, 2017 at 02:14:19PM +0100, Peter Maydell wrote:
> > > On 7 June 2017 at 18:54, Daniel P. Berrange <berrange@redhat.com> w=
rote:
> > > > The following changes since commit 0db1851becbefe3e50cfc03776fb1f=
75817376af:
> > > >=20
> > > >   Merge remote-tracking branch 'remotes/vivier/tags/m68k-for-2.10=
-pull-request' into staging (2017-06-07 11:56:00 +0100)
> > > >=20
> > > > are available in the git repository at:
> > > >=20
> > > >   git://github.com/berrange/qemu tags/pull-sockets-2017-06-07-1
> > > >=20
> > > > for you to fetch changes up to 8dd2c27927b93aa352c43e8f0b9437f85d=
2f5f55:
> > > >=20
> > > >   tests: add functional test validating ipv4/ipv6 address flag ha=
ndling (2017-06-07 17:15:08 +0100)
> > > >=20
> > > > ----------------------------------------------------------------
> > > > Merge sockets 2017/06/07 v1
> > > >=20
> > > > ----------------------------------------------------------------
> > >=20
> > > Hi; I'm afraid this ran into 'make check' problems:
> > >=20
> > > On OSX and FreeBSD:
> > >   GTESTER check-qtest-i386
> > > ERROR:/Users/pm215/src/qemu-for-merges/tests/test-sockets-proto.c:8=
25:void
> > > test_listen(const void *): assertion failed: (data->ipv6 !=3D 0)
> > > GTester: last random seed: R02Sc21fa7784ab13d0fd3274d86c5a52367
> > > **
> > > ERROR:/Users/pm215/src/qemu-for-merges/tests/test-sockets-proto.c:8=
25:void
> > > test_listen(const void *): assertion failed: (data->ipv6 !=3D 0)
> > > GTester: last random seed: R02Sdf653a63e8d9a5d03bfadb49122f3e9a
> >=20
> > Ok, it appears that getaddrinfo() returns different results for "loca=
lhost"
> > on FreeBSD/OSX, compared to Linux. Linux returns IPv4 first, then IPv=
6,
> > while FreeBSD/OSX return IPv6 first then IPv4. The sockets code is wo=
rking
> > correctly, but the unit test is not seeing the expected results, sinc=
e its
> > data tables are expecting the Linux behaviour. Not sure how I'll fix =
this
> > yet, perhaps I'll just #ifdef __linux__ as a temporary hack.
>=20
> On Linux it depends of your /etc/gai.conf(5), on FreeBSD it depends on
> ip6addrctl(8) policy.
>=20
> I'm not sure about this hack, temporary tends to last...

Yeah, I'm thinking about a way to adapt the test suite to cope with
the arbitrary ordering, rather than assuming an "out of the box"
gai.conf setup.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
