Received: from eggs.gnu.org ([2001:4830:134:3::10]:46226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1etVw8-0007Si-EH
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 05:04:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1etVw7-00027d-Fy
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 05:04:40 -0500
Date: Wed, 7 Mar 2018 11:04:24 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180307100424.GA7917@localhost.localdomain>
References: <20180205202232.19254-1-mreitz@redhat.com>
	<73838a0c-d960-d24d-b706-a0ecbcbe7aaf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <73838a0c-d960-d24d-b706-a0ecbcbe7aaf@redhat.com>
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
To: John Snow <jsnow@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, "Richard W . M . Jones" <rjones@redhat.com>, qemu-devel@nongnu.org

Am 06.03.2018 um 22:51 hat John Snow geschrieben:
> On 02/05/2018 03:22 PM, Max Reitz wrote:
> > This series implements .bdrv_refresh_filename() for the ssh block
> > driver, along with an appropriate .bdrv_dirname() so we don't chop of=
f
> > query strings for backing files with relative filenames.
> >=20
> > This series depends on my =E2=80=9Cblock: Fix some filename generatio=
n issues=E2=80=9D
> > series and on Pino's =E2=80=9Cssh: switch from libssh2 to libssh=E2=80=
=9D patch.
> >=20
> > Based-on: 20180205151835.20812-1-mreitz@redhat.com
> > Based-on: 20180118164439.2120-1-ptoscano@redhat.com
> >=20
> >=20
> > Max Reitz (2):
> >   block/ssh: Implement .bdrv_refresh_filename()
> >   block/ssh: Implement .bdrv_dirname()
> >=20
> >  block/ssh.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++------
> >  1 file changed, 65 insertions(+), 7 deletions(-)
>=20
> Did this one rot on the vine?
>=20
> >1 month old.

The Based-on tags are the problem, in particular the first one. But yes,
we could possibly do more to review the dependencies...

Kevin
