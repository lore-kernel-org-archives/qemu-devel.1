Received: from eggs.gnu.org ([2001:4830:134:3::10]:48629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ewWBf-0003Ol-MY
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 12:57:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ewWBZ-0001mK-Rz
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 12:57:07 -0400
Date: Thu, 15 Mar 2018 17:56:49 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180315165649.GE3876@localhost.localdomain>
References: <20180313161803.1814-1-kwolf@redhat.com>
	<CAFEAcA-u_++4suoFBnea--7hajd1Mnb1kadwRc+GjZvHXvou-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-u_++4suoFBnea--7hajd1Mnb1kadwRc+GjZvHXvou-Q@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/41] Block layer patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, jsnow@redhat.com

Am 15.03.2018 um 17:42 hat Peter Maydell geschrieben:
> On 13 March 2018 at 16:17, Kevin Wolf <kwolf@redhat.com> wrote:
> > The following changes since commit 22ef7ba8e8ce7fef297549b3defcac3337=
42b804:
> >
> >   Merge remote-tracking branch 'remotes/famz/tags/staging-pull-reques=
t' into staging (2018-03-13 11:42:45 +0000)
> >
> > are available in the git repository at:
> >
> >   git://repo.or.cz/qemu/kevin.git tags/for-upstream
> >
> > for you to fetch changes up to be6c885842efded81a20f4ca24f0d4e123a80c=
00:
> >
> >   block/mirror: change the semantic of 'force' of block-job-cancel (2=
018-03-13 16:54:47 +0100)
> >
> > ----------------------------------------------------------------
> > Block layer patches
> >
> > ----------------------------------------------------------------
>=20
> I get a compile failure here on some hosts:
>=20
> /home/pm215/qemu/blockjob.c: In function =E2=80=98block_job_txn_apply.i=
sra.8=E2=80=99:
> /home/pm215/qemu/blockjob.c:524:5: error: =E2=80=98rc=E2=80=99 may be u=
sed
> uninitialized in this function [-Werror=3Dmaybe-uninitialized]
>      return rc;
>      ^
>=20
> I guess the compiler can't always figure out whether there is
> guaranteed to be at least one thing in the list ?

I think so.

John, I'll just modify your patch 'blockjobs: add prepare callback' to
initialise rc =3D 0 in this function and send a v2 pull request.

Kevin
