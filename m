Received: from eggs.gnu.org ([2001:4830:134:3::10]:57079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1fnjSF-00075T-Ri
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:50:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1fnjSD-0008Da-5i
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:50:11 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36345)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1fnjSC-0008DF-Tr
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:50:09 -0400
Received: by mail-wm0-f66.google.com with SMTP id w24-v6so6107452wmc.1
	for <qemu-devel@nongnu.org>; Thu, 09 Aug 2018 04:50:08 -0700 (PDT)
Date: Thu, 9 Aug 2018 13:50:03 +0200
From: =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
Message-ID: <20180809135003.75fe8fa3@fiorina>
In-Reply-To: <e91a6eb7-d5b2-93e6-05bf-65270ccb8736@redhat.com>
References: <cover.1533639095.git.tgolembi@redhat.com>
	<23ca1636f8e238b2ffaded962519d2be1e3b5d3a.1533639095.git.tgolembi@redhat.com>
	<e91a6eb7-d5b2-93e6-05bf-65270ccb8736@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 4/4] qga: report serial ID and device
 node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On Tue, 7 Aug 2018 08:52:37 -0500
Eric Blake <eblake@redhat.com> wrote:

> On 08/07/2018 05:51 AM, Tom=C3=A1=C5=A1 Golembiovsk=C3=BD wrote:
> > On Linux the functionality depends on libudev.
> >=20
> > Example from Linux:
> >=20
> >      {
> >        "name": "dm-2",
> >        "mountpoint": "/",
> >        ...
> >        "disk": [
> >          {
> >            "serial": "SAMSUNG_MZ7LN512HCHP-000L1_S1ZKNXAG822493",
> >            "dev": "/dev/sda2",
> >            ...
> >          }
> >        ],
> >      }
> >=20
> > Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
> > --- =20
>=20
> > +++ b/qga/commands-posix.c
> > @@ -47,6 +47,7 @@ extern char **environ;
> >   #include <sys/socket.h>
> >   #include <net/if.h>
> >   #include <sys/statvfs.h>
> > +#include <libudev.h> =20
>=20
> Is libudev universally available on BSD systems and always preinstalled=20
> on Linux systems, or does this need a configure probe?

The code is specific to Linux. I couldn't find portable way of querying
the serial number.

libudev is part of systemd, so it should generally be there. But I
suppose we should not break on systems that don't use it. I'll add
configure check for it.

    Tomas

--=20
Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
