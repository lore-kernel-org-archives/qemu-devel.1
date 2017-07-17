Received: from eggs.gnu.org ([2001:4830:134:3::10]:51595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1dX6br-0004e8-T5
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:02:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1dX6bn-0007FW-W4
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:02:51 -0400
Received: from mail-wr0-f182.google.com ([209.85.128.182]:35188)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1dX6bn-0007FA-QE
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:02:47 -0400
Received: by mail-wr0-f182.google.com with SMTP id w4so23143916wrb.2
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 07:02:47 -0700 (PDT)
Date: Mon, 17 Jul 2017 16:02:44 +0200
From: =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
Message-ID: <20170717160244.0112c61e@fiorina>
In-Reply-To: <CAFEAcA8jRjEDRv0hmG1U3H=kCdBX=NoVNqCo7giCVkiwiBo+Lw@mail.gmail.com>
References: <1493271996-23607-1-git-send-email-mdroth@linux.vnet.ibm.com>
	<1493271996-23607-8-git-send-email-mdroth@linux.vnet.ibm.com>
	<CAFEAcA8jRjEDRv0hmG1U3H=kCdBX=NoVNqCo7giCVkiwiBo+Lw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v2 7/8] qga: Add 'guest-get-users' command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>, Vinzenz Feenstra <vfeenstr@redhat.com>

On Thu, 13 Jul 2017 15:56:25 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On 27 April 2017 at 06:46, Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
> > From: Vinzenz Feenstra <vfeenstr@redhat.com>
> >
> > A command that will list all currently logged in users, and the time
> > since when they are logged in.
> >
> > Examples:
> >
> > virsh # qemu-agent-command F25 '{ "execute": "guest-get-users" }'
> > {"return":[{"login-time":1490622289.903835,"user":"root"}]}
> >
> > virsh # qemu-agent-command Win2k12r2 '{ "execute": "guest-get-users" }'
> > {"return":[{"login-time":1490351044.670552,"domain":"LADIDA",
> > "user":"Administrator"}]}
> >
> > Signed-off-by: Vinzenz Feenstra <vfeenstr@redhat.com>
> > * make g_hash_table_contains compat func inline to avoid
> >   unused warnings
> > Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
>=20
> > diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> > index 915df9e..ba06be4 100644
> > --- a/qga/commands-posix.c
> > +++ b/qga/commands-posix.c
> > @@ -15,6 +15,7 @@
> >  #include <sys/ioctl.h>
> >  #include <sys/wait.h>
> >  #include <dirent.h>
> > +#include <utmpx.h>
>=20
> Hi. I've just noticed that this breaks the build on OpenBSD,
> which doesn't have utmpx.h or the functions it provides.
> OpenBSD is currently close to falling off our list of
> hosts we care about, but still it would be nice if we
> could do a configure check for utmpx.h and have a fallback
> 'unsupported' code path for hosts where it doesn't exist.

Hi,

I have just sent a patch that should fix this.

https://lists.nongnu.org/archive/html/qemu-devel/2017-07/msg05086.html

Could you please test if it solves the issue properly?

Thanks,

    Tomas Golembiovsky

>=20
> thanks
> -- PMM
>=20


--=20
Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
