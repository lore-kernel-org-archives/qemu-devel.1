Received: from eggs.gnu.org ([2001:4830:134:3::10]:33171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eYO0Z-0007VT-Mh
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 22:21:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eYO0Y-0005UV-OL
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 22:21:55 -0500
Date: Mon, 8 Jan 2018 11:21:44 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180108032144.GB2123@lemon.usersys.redhat.com>
References: <20180105225753.30509-1-eblake@redhat.com>
	<151530501821.348.11085455560260888826@5adcb62bf0d6>
	<20180108025648.GA2123@lemon.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180108025648.GA2123@lemon.usersys.redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 00/20] add byte-based block_status
 driver callbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org, jcody@redhat.com, pl@kamp.de

On Mon, 01/08 10:56, Fam Zheng wrote:
> On Sat, 01/06 22:03, no-reply@patchew.org wrote:
> > /var/tmp/patchew-tester-tmp-zu_flv2_/src/block/iscsi.c: In function =E2=
=80=98iscsi_co_block_status=E2=80=99:
> > /var/tmp/patchew-tester-tmp-zu_flv2_/src/block/iscsi.c:755:14: error:=
 =E2=80=98iTask.task=E2=80=99 may be used uninitialized in this function =
[-Werror=3Dmaybe-uninitialized]
> >      if (iTask.task !=3D NULL) {
> >          ~~~~~^~~~~
> > cc1: all warnings being treated as errors
> > make: *** [/var/tmp/patchew-tester-tmp-zu_flv2_/src/rules.mak:66: blo=
ck/iscsi.o] Error 1
> > make: *** Waiting for unfinished jobs....
> > =3D=3D=3D OUTPUT END =3D=3D=3D
> >=20
> > Test command exited with code: 2
>=20
> Seems introduced by e38bc23454ef763deb4405ebdee6a1081aa00bc8. I think t=
he easy
> fix is to initialize iTask.task to NULL.

I've posted a fix for this:

https://lists.gnu.org/archive/html/qemu-devel/2018-01/msg01132.html

Fam
