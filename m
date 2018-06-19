Received: from eggs.gnu.org ([2001:4830:134:3::10]:42311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fVFOg-0008A7-0x
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 08:06:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fVFOc-0002NA-2b
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 08:06:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42360)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fVFOb-0002Mp-Rh
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 08:06:01 -0400
Date: Tue, 19 Jun 2018 09:05:54 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180619120554.GP7451@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAFEAcA-ZEH+SxhPOoPj+FkgSykikQq0cGUZdXnhvN5C2PE=i6w@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/13] Python queue, 2018-06-11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>

On Tue, Jun 19, 2018 at 12:13:41PM +0100, Peter Maydell wrote:
> On 11 June 2018 at 18:42, Eduardo Habkost <ehabkost@redhat.com> wrote:
> > The following changes since commit 0d2fa03dae4fbe185a082f361342b1e30a=
ed4582:
> >
> >   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm=
-20180608' into staging (2018-06-08 16:26:51 +0100)
> >
> > are available in the Git repository at:
> >
> >   git://github.com/ehabkost/qemu.git tags/python-next-pull-request
> >
> > for you to fetch changes up to c7883412440905b41dde7e70f4af782932e80e=
90:
> >
> >   python: Remove scripts/ordereddict.py (2018-06-08 16:40:54 -0300)
> >
> > ----------------------------------------------------------------
> > Python queue, 2018-06-11
> >
> > * Make code compatible with Python 3 using 'futurize --stage1'
> > * Require Python >=3D 2.7 and remove Python 2.6 compatibility
> >   modules
> >
> > ----------------------------------------------------------------
>=20
> Hi; I noticed that running configure on my machine can now produce a
> python traceback from docker.py:
>=20
> make: Entering directory '/home/petmay01/linaro/qemu-for-merges/build/a=
lldbg'
> config-host.mak is out-of-date, running configure
> Traceback (most recent call last):
>   File "/home/petmay01/linaro/qemu-for-merges/tests/docker/docker.py",
> line 29, in <module>
>     from StringIO import StringIO
> ImportError: No module named 'StringIO'
> Install prefix    /usr/local
> [etc]
>=20
> I don't know if this is because of this change, but this is the
> most recent change involving python...

This seems to be introduced by:

commit 51a12b51fd3693a16eb73362713a98d467e15af7
Author: Alex Benn=E9e <alex.bennee@linaro.org>
Date:   Wed Apr 4 14:24:39 2018 +0100

    configure: add test for docker availability

    This tests for a working docker installation without sudo and sets up
    config-host.mak accordingly. This will be useful from cross compiling
    things in the future.

    Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
    Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

tests/docker/docker.py is still python2-only but ./configure is
trying to run it using $python (which can be Python 3).

--=20
Eduardo
