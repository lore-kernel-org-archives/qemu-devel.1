Received: from eggs.gnu.org ([2001:4830:134:3::10]:42994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dazU7-0003Fw-S4
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 03:14:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dazU4-00007W-Mb
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 03:14:55 -0400
Date: Fri, 28 Jul 2017 09:14:48 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170728091448.6b1ec0c6@gondolin>
In-Reply-To: <36f410cd-ef86-aa08-9922-5cbd1e565a54@redhat.com>
References: <20170728053610.15770-1-f4bug@amsat.org>
	<20170728053610.15770-8-f4bug@amsat.org>
	<36f410cd-ef86-aa08-9922-5cbd1e565a54@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 07/47] MAINTAINERS: add missing entry for
 vfio/ccw
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>, qemu-trivial@nongnu.org, qemu-devel@nongnu.org

On Fri, 28 Jul 2017 09:02:27 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 28.07.2017 07:35, Philippe Mathieu-Daud=C3=A9 wrote:
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > ---
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index ddf6f3f6d8..69987b5e5b 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1029,6 +1029,7 @@ S: Supported
> >  F: hw/vfio/ccw.c
> >  F: hw/s390x/s390-ccw.c
> >  F: include/hw/s390x/s390-ccw.h
> > +F: linux-headers/linux/vfio_ccw.h =20
>=20
> Again a linux-header ... I don't think we need an entry for this in
> MAINTAINERS since the file is maintained in the Linux kernel instead.

Agreed, even if it's the same maintainer in this case.

What about a catchall pattern for the linux-headers instead that points
to the update-headers script? If you're updating these without running
the script, you're doing something wrong (as soon as the patchset is
ready for inclusion, at least.)
