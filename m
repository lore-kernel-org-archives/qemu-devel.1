Received: from eggs.gnu.org ([2001:4830:134:3::10]:37578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d1968-0000T0-CH
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 06:14:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d1967-0001JZ-AP
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 06:14:00 -0400
Date: Thu, 20 Apr 2017 18:13:51 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170420101351.GJ24486@lemon.lan>
References: <20170420075237.18219-1-famz@redhat.com>
	<149267590581.42.16656996221803790280@c05f1edc8ed1>
	<20170420083202.GF24486@lemon.lan>
	<20170420100343.GC4747@noname.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170420100343.GC4747@noname.redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v13 00/20] block: Image locking series
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

On Thu, 04/20 12:03, Kevin Wolf wrote:
> Am 20.04.2017 um 10:32 hat Fam Zheng geschrieben:
> > > /var/tmp/patchew-tester-tmp-7vbaovju/src/block/file-posix.c: In fun=
ction =E2=80=98raw_handle_lock_update=E2=80=99:
> > > /var/tmp/patchew-tester-tmp-7vbaovju/src/block/file-posix.c:1117:17=
: error: =E2=80=98lock_fd=E2=80=99 may be used uninitialized in this func=
tion [-Werror=3Dmaybe-uninitialized]
> > >                  qemu_close(lock_fd);
> > >                  ^~~~~~~~~~~~~~~~~~~
> > > cc1: all warnings being treated as errors
> > > /var/tmp/patchew-tester-tmp-7vbaovju/src/rules.mak:69: recipe for t=
arget 'block/file-posix.o' failed
> >=20
> > False positive. lock_fd is initialized in a "if (op =3D=3D RAW_LT_PRE=
PARE)" branch
> > above, and we are in a "case RAW_LT_PREPARE" switch branch too.
>=20
> Even if it's a false positive, obviously we still need to work around
> the build failure.

Sure, easy to do. I'll initialize the variable.

Fam
