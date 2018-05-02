Received: from eggs.gnu.org ([2001:4830:134:3::10]:56604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fDso1-0001be-Uf
	for qemu-devel@nongnu.org; Wed, 02 May 2018 10:32:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fDsnx-0004c7-Vg
	for qemu-devel@nongnu.org; Wed, 02 May 2018 10:32:29 -0400
Date: Wed, 2 May 2018 10:32:15 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20180502143215.GB22414@localhost.localdomain>
References: <20180501220509.14152-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180501220509.14152-1-mreitz@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/2] block/mirror: Make cancel always
 cancel pre-READY
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>

On Wed, May 02, 2018 at 12:05:07AM +0200, Max Reitz wrote:
> Currently, you cannot cancel a mirror job without the @force flag set.
> This is intentional once source and target are in sync, but probably no=
t
> so much before that happens.  The main reason for me thinking this is
> because it is an undocumented change in 2.12.0 in respect to 2.11.
>=20
> (b76e4458b1eb3c32e9824fe6aa51f67d2b251748 only notes a behavior change
>  after READY, but not before.)
>=20
>=20
> This series depends on Stefan=E2=80=99s patch =E2=80=9Cblock/mirror: ho=
nor ratelimit
> again=E2=80=9D (which is in Jeff=E2=80=99s queue).
>=20
> Based-on: <20180424123527.19168-1-stefanha@redhat.com>
>=20
>=20
> Max Reitz (2):
>   block/mirror: Make cancel always cancel pre-READY
>   iotests: Add test for cancelling a mirror job
>=20
>  block/mirror.c             |   4 +-
>  tests/qemu-iotests/218     | 138 +++++++++++++++++++++++++++++++++++++=
++++++++
>  tests/qemu-iotests/218.out |  30 ++++++++++
>  tests/qemu-iotests/group   |   1 +
>  4 files changed, 172 insertions(+), 1 deletion(-)
>  create mode 100755 tests/qemu-iotests/218
>  create mode 100644 tests/qemu-iotests/218.out
>=20
> --=20
> 2.14.3
>=20

Thanks,

Applied to my block branch:

git://github.com/codyprime/qemu-kvm-jtc block

-Jeff
