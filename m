Received: from eggs.gnu.org ([2001:4830:134:3::10]:34456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f3L0V-0005HV-KM
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 08:25:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f3L0U-0002pW-IP
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 08:25:47 -0400
Date: Tue, 3 Apr 2018 14:25:30 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180403122516.GA11070@localhost.localdomain>
References: <20180329112053.5399-1-ldoktor@redhat.com>
	<20180329112053.5399-2-ldoktor@redhat.com>
	<00157f9f-9e66-5243-ae95-3af67c98c72f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <00157f9f-9e66-5243-ae95-3af67c98c72f@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/1] qemu-iotests: Use ppc64 qemu_arch
 on ppc64le host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-block@nongnu.org

Am 29.03.2018 um 16:31 hat Max Reitz geschrieben:
> On 2018-03-29 13:20, Luk=C3=A1=C5=A1 Doktor wrote:
> > The qemu target does not always correspond to the host machine type. =
For
> > example ppc64le machine target is ppc64. Let's introduce "qemu_arch"
> > variable to store the matching qemu architecture related to the curre=
nt
> > architecture and use it when auto-detecting the default qemu binary.
> >=20
> > Signed-off-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
> > ---
> >  tests/qemu-iotests/check         | 4 ++--
> >  tests/qemu-iotests/common.config | 1 +
> >  2 files changed, 3 insertions(+), 2 deletions(-)
>=20
> Thanks, applied to my block branch:
>=20
> https://github.com/XanClic/qemu/commits/block

Please don't forget to CC qemu-block and qemu-devel for patches to
qemu-iotests (the kvm list isn't really necessary, though). Adding it to
this reply so that people can see that something was merged.

Kevin
