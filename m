Received: from eggs.gnu.org ([2001:4830:134:3::10]:46800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1dPddO-0003Zi-MY
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 19:41:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1dPddJ-0008EY-RI
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 19:41:34 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:34053)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1dPddJ-0008Dh-Jr
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 19:41:29 -0400
Received: by mail-wr0-f174.google.com with SMTP id 77so151480977wrb.1
	for <qemu-devel@nongnu.org>; Mon, 26 Jun 2017 16:41:28 -0700 (PDT)
Date: Tue, 27 Jun 2017 01:41:22 +0200
From: =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
Message-ID: <20170627014122.579f4a2e@fiorina>
In-Reply-To: <CAJ+F1C+2QiQMxzMQvaMDV8gmU95+Q46-QbA1gPOZ-NCJSLTX5Q@mail.gmail.com>
References: <cover.1496836915.git.tgolembi@redhat.com>
	<CAJ+F1C+2QiQMxzMQvaMDV8gmU95+Q46-QbA1gPOZ-NCJSLTX5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 0/1] qemu-ga: add guest-get-osinfo
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@gmail.com>
Cc: Eric Blake <eblake@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Vinzenz 'evilissimo' Feenstra <vfeenstr@redhat.com>, qemu-devel@nongnu.org

Hi,

On Mon, 26 Jun 2017 12:27:57 +0000
Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> wrote:

> Hi
>=20
> On Wed, Jun 7, 2017 at 2:02 PM Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolemb=
i@redhat.com>
> wrote:
>=20
> > v5:
> > - fixed build failure with older glib
> > - fixed coding style issues
> > - fixed one log string
> >
> > This is a continuation of the work started by Vinzenz Feenstra in the
> > threads:
> >
> > https://lists.nongnu.org/archive/html/qemu-devel/2017-03/msg04154.html
> > https://lists.nongnu.org/archive/html/qemu-devel/2017-03/msg04302.html
> > https://lists.nongnu.org/archive/html/qemu-devel/2017-03/msg06262.html
> >
> > The idea is to report some basic information from uname and from
> > os-release file, if it is present. On MS Windows, where neither uname
> > nor os-release exist we fill the values based on the information we can
> > get from the OS.
> >
> > The example output on Fedora is:
> >
> > {
> >   "return": {
> >     "kernel-version": "#1 SMP Mon May 8 18:46:06 UTC 2017",
> >     "kernel-release": "4.10.15-200.fc25.x86_64",
> >     "machine-hardware": "x86_64",
> >     "id": "fedora",
> >     "name": "Fedora",
> >     "pretty-name": "Fedora 25 (Server Edition)",
> >     "version": "25 (Server Edition)",
> >     "variant": "Server Edition",
> >     "version-id": "25",
> >     "variant-id": "server"
> >   }
> > }
> >
> > The example output on MS Windows 10 is:
> >
> > {
> >   "return": {
> >     "kernel-version": "10.0",
> >     "kernel-release": "10240",
> >     "machine-hardware": "x86_64",
> >     "id": "mswindows",
> >     "name": "Microsoft Windows",
> >     "pretty-name": "Windows 10 Enterprise",
> >     "version": "Microsoft Windows 10",
> >     "version-id": "10",
> >     "variant": "client",
> >     "variant-id": "client"
> >   }
> > }
> >
> > One issue I see with the current implementation is that one is not able
> > to distinguish between various (non-linux) POSIX systems from the
> > returned values. That's because without os-release file (which I assume
> > is not common on non-linux platforms) only kernel-version,
> > kernel-release and machine-hardware are returned and telling what OS is
> > running there is a guessing game. Is this a problem?
> >
> >
> I don't know, but I would rather solve this problem at OS & os-release
> level. Raise your concerns on the XDG/osrelease mailing list?
>=20
>=20
> > Also the qapi documentiaton probably need some polishing. Unfortunately,
> > so far I was unable to get qapi parser satisfied and still include all
> > the important information.
> >
>=20
> You mean the doc parser? What's the issue?
>=20

In the end no issue at all. It turned out my problems were caused by
stray quotes.

    Tomas

> >
> >     Tomas Golembiovsky
> >
> > Tom=C3=A1=C5=A1 Golembiovsk=C3=BD (1):
> >   qemu-ga: add guest-get-osinfo command
> >
> >  configure            |   2 +-
> >  qga/commands-posix.c | 160
> > ++++++++++++++++++++++++++++++++++++++++++++++++
> >  qga/commands-win32.c | 170
> > +++++++++++++++++++++++++++++++++++++++++++++++++++
> >  qga/qapi-schema.json |  57 +++++++++++++++++
> >  4 files changed, 388 insertions(+), 1 deletion(-)
> >
> > --
> > 2.13.0
> >
> > --
> Marc-Andr=C3=A9 Lureau


--=20
Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
