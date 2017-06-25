Received: from eggs.gnu.org ([2001:4830:134:3::10]:37545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1dPF25-0000X5-SS
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 17:25:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1dPF21-0005pL-P9
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 17:25:25 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:34426)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1dPF21-0005oi-IO
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 17:25:21 -0400
Received: by mail-wr0-f174.google.com with SMTP id 77so128951190wrb.1
	for <qemu-devel@nongnu.org>; Sun, 25 Jun 2017 14:25:20 -0700 (PDT)
Date: Sun, 25 Jun 2017 23:25:17 +0200
From: =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
Message-ID: <20170625232517.34d1ca38@fiorina>
In-Reply-To: <CAJ+F1C+-fXWoVjeML1Op67+h-nYbe03k-k0TYdkNA2RQ7t9-ow@mail.gmail.com>
References: <cover.1498222907.git.tgolembi@redhat.com>
	<CAJ+F1C+-fXWoVjeML1Op67+h-nYbe03k-k0TYdkNA2RQ7t9-ow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 0/3] qemu-ga: support for sending events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@gmail.com>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org

Hi,

On Fri, 23 Jun 2017 13:25:34 +0000
Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> wrote:

> Hi
>=20
> On Fri, Jun 23, 2017 at 3:03 PM Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolem=
bi@redhat.com>
> wrote:
>=20
> > This is just a draft, or a request for comments if you will.
> >
> > This patch sets drafts the support of sending events by QEMU Guest Agen=
t.
> > Events can plan important role in monitoring of the guest OS behaviour.=
 The
> > range of use cases ranges from events important for scheduling, e.g.
> > memory and
> > CPU usage statistics, to things like changes to IP addresses on network
> > interfaces to for example changes in the list of active users.
> >
> > For now the patch set adds single periodic callback function to the GA =
main
> > loop that can perform checks and trigger events that have occured since
> > previous run of the callback.
> >
> > We can of course take it one step further and add a general framwork for
> > periodically running any of the already implemented commands. Add a
> > function
> > that would maintain a list of registered checks. Client would use some
> > command
> > (register-monitor-command) passing it a command name and timeout in
> > seconds and
> > the monitoring handler would then run the specified command and report =
the
> > result... or report only if the return value changed since previous
> > invocation.
> > This feature would remove part of the communication overhead between
> > client and
> > GA.
> >
> > So before I invest any more time in either of these approaches, tell me.
> > Would
> > somethign like this be wanted or is that too controversial? Any other
> > thoughts
> > and ideas?
> >
> > =20
> It doesn't feel wrong, but Is there really too much overhead and/or laten=
cy
> if a request is periodic from the client? ie did you do some measurements
> before coming to this proposal?

No, I didn't do any measurements. And it may be even true that in the
grand scheme of things the overhead/latency may be insignificant, if we
imagine a client that repeatedly calls about 5 to 10 commands every 5 or
10 seconds. Still, it just feels like a more correct approach to me. But
that may be just my feeling, that's why I brought this to the list to
get the opinion of others.

    Tomas

>=20
> Tom=C3=A1=C5=A1 Golembiovsk=C3=BD (3):
> >   qemu-ga: add support for events
> >   qemu-ga: add simple event reporting memory statistics
> >   qemu-ga: add support for periodic command runner
> >
> >  Makefile               |  7 +++-
> >  qga/Makefile.objs      |  2 +-
> >  qga/channel-posix.c    |  8 +++++
> >  qga/channel-win32.c    |  6 ++++
> >  qga/channel.h          |  1 +
> >  qga/guest-agent-core.h |  1 +
> >  qga/main.c             | 98
> > ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  qga/qapi-event.json    | 35 ++++++++++++++++++
> >  qga/qapi-schema.json   |  2 ++
> >  9 files changed, 158 insertions(+), 2 deletions(-)
> >  create mode 100644 qga/qapi-event.json
> >
> > --
> > 2.13.1
> >
> >
> > -- =20
> Marc-Andr=C3=A9 Lureau


--=20
Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
