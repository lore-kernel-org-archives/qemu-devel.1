Received: from eggs.gnu.org ([2001:4830:134:3::10]:49157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fDvgK-0001WB-FP
	for qemu-devel@nongnu.org; Wed, 02 May 2018 13:36:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fDvgJ-0007DD-Lv
	for qemu-devel@nongnu.org; Wed, 02 May 2018 13:36:44 -0400
References: <20180501220509.14152-1-mreitz@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <33300462-e62e-7c07-f587-aeba1045ecd7@redhat.com>
Date: Wed, 2 May 2018 13:36:35 -0400
MIME-Version: 1.0
In-Reply-To: <20180501220509.14152-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org



On 05/01/2018 06:05 PM, Max Reitz wrote:
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

Way too late to the party, but all the same, since I was CC'd and I
already looked into it:

Reviewed-by: John Snow <jsnow@redhat.com>
