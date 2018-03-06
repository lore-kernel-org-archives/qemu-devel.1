Received: from eggs.gnu.org ([2001:4830:134:3::10]:50441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1etKUr-0004vp-0n
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 16:51:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1etKUq-00031k-7c
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 16:51:45 -0500
References: <20180205202232.19254-1-mreitz@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <73838a0c-d960-d24d-b706-a0ecbcbe7aaf@redhat.com>
Date: Tue, 6 Mar 2018 16:51:30 -0500
MIME-Version: 1.0
In-Reply-To: <20180205202232.19254-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 0/2] block/ssh: Implement
 .bdrv_refresh_filename()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Richard W . M . Jones" <rjones@redhat.com>, qemu-devel@nongnu.org



On 02/05/2018 03:22 PM, Max Reitz wrote:
> This series implements .bdrv_refresh_filename() for the ssh block
> driver, along with an appropriate .bdrv_dirname() so we don't chop off
> query strings for backing files with relative filenames.
>=20
> This series depends on my =E2=80=9Cblock: Fix some filename generation =
issues=E2=80=9D
> series and on Pino's =E2=80=9Cssh: switch from libssh2 to libssh=E2=80=9D=
 patch.
>=20
> Based-on: 20180205151835.20812-1-mreitz@redhat.com
> Based-on: 20180118164439.2120-1-ptoscano@redhat.com
>=20
>=20
> Max Reitz (2):
>   block/ssh: Implement .bdrv_refresh_filename()
>   block/ssh: Implement .bdrv_dirname()
>=20
>  block/ssh.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++------
>  1 file changed, 65 insertions(+), 7 deletions(-)
>=20

Did this one rot on the vine?

>1 month old.
