Received: from eggs.gnu.org ([2001:4830:134:3::10]:52518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1duC22-00058M-VL
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 02:29:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1duC1z-00071L-KR
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 02:29:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36366)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1duC1z-00070e-BI
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 02:29:15 -0400
Date: Tue, 19 Sep 2017 14:29:03 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170919062903.GH3617@pxdev.xzpeter.org>
References: <CAJ+F1CL1CekcYq2xnrkhsjyx17FDSgppP1C+YqL0iNgv8HbwYQ@mail.gmail.com>
	<20170914185314.GA3280@work-vm>
	<20170915044622.GO3617@pxdev.xzpeter.org>
	<CAJ+F1CKGsYbK5M6WKGSCioFCFY79WjFCtEQGqudiuA-QZTfOCA@mail.gmail.com>
	<20170918083737.GD3617@pxdev.xzpeter.org>
	<CAJ+F1C+ZE2xDVK8Ni7CaVbH6NHEz0-xXh_1gqwF-jf6T0iA16Q@mail.gmail.com>
	<20170918105516.GD2581@work-vm>
	<CAJ+F1CL3UwzTO7APLnR1MUFg+XWF1B8VJkmNQGBa3bqB_bXNfg@mail.gmail.com>
	<20170918112618.GF2581@work-vm>
	<CAJ+F1CLkTZMgUtpPUu_3SkscYDRuM0+zjWsiJ6-a-CtZYOLhBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ+F1CLkTZMgUtpPUu_3SkscYDRuM0+zjWsiJ6-a-CtZYOLhBA@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 00/15] QMP: out-of-band (OOB) execution
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Mon, Sep 18, 2017 at 06:09:29PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> On Mon, Sep 18, 2017 at 1:26 PM, Dr. David Alan Gilbert
> <dgilbert@redhat.com> wrote:
> > * Marc-Andr=C3=A9 Lureau (marcandre.lureau@gmail.com) wrote:
> >> Hi
> >>
> >> On Mon, Sep 18, 2017 at 12:55 PM, Dr. David Alan Gilbert
> >> <dgilbert@redhat.com> wrote:
> >> > * Marc-Andr=C3=A9 Lureau (marcandre.lureau@gmail.com) wrote:
> >> >> Hi
> >> >>
> >> >> On Mon, Sep 18, 2017 at 10:37 AM, Peter Xu <peterx@redhat.com> wr=
ote:
> >> >> > On Fri, Sep 15, 2017 at 01:14:47PM +0200, Marc-Andr=C3=A9 Lurea=
u wrote:
> >> >> >> Hi
> >> >> >>
> >> >> >> On Thu, Sep 14, 2017 at 9:46 PM, Peter Xu <peterx@redhat.com> =
wrote:
> >> >> >> > On Thu, Sep 14, 2017 at 07:53:15PM +0100, Dr. David Alan Gil=
bert wrote:
> >> >> >> >> * Marc-Andr=C3=A9 Lureau (marcandre.lureau@gmail.com) wrote=
:
> >> >> >> >> > Hi
> >> >> >> >> >
> >> >> >> >> > On Thu, Sep 14, 2017 at 9:50 AM, Peter Xu <peterx@redhat.=
com> wrote:
> >> >> >> >> > > This series was born from this one:
> >> >> >> >> > >
> >> >> >> >> > >   https://lists.gnu.org/archive/html/qemu-devel/2017-08=
/msg04310.html
> >> >> >> >> > >
> >> >> >> >> > > The design comes from Markus, and also the whole-bunch-=
of discussions
> >> >> >> >> > > in previous thread.  My heartful thanks to Markus, Dani=
el, Dave,
> >> >> >> >> > > Stefan, etc. on discussing the topic (...again!), provi=
ding shiny
> >> >> >> >> > > ideas and suggestions.  Finally we got such a solution =
that seems to
> >> >> >> >> > > satisfy everyone.
> >> >> >> >> > >
> >> >> >> >> > > I re-started the versioning since this series is totall=
y different
> >> >> >> >> > > from previous one.  Now it's version 1.
> >> >> >> >> > >
> >> >> >> >> > > In case new reviewers come along the way without readin=
g previous
> >> >> >> >> > > discussions, I will try to do a summary on what this is=
 all about.
> >> >> >> >> > >
> >> >> >> >> > > What is OOB execution?
> >> >> >> >> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> >> >> >> >> > >
> >> >> >> >> > > It's the shortcut of Out-Of-Band execution, its name is=
 given by
> >> >> >> >> > > Markus.  It's a way to quickly execute a QMP request.  =
Say, originally
> >> >> >> >> > > QMP is going throw these steps:
> >> >> >> >> > >
> >> >> >> >> > >       JSON Parser --> QMP Dispatcher --> Respond
> >> >> >> >> > >           /|\    (2)                (3)     |
> >> >> >> >> > >        (1) |                               \|/ (4)
> >> >> >> >> > >            +---------  main thread  --------+
> >> >> >> >> > >
> >> >> >> >> > > The requests are executed by the so-called QMP-dispatch=
er after the
> >> >> >> >> > > JSON is parsed.  If OOB is on, we run the command direc=
tly in the
> >> >> >> >> > > parser and quickly returns.
> >> >> >> >> >
> >> >> >> >> > All commands should have the "id" field mandatory in this=
 case, else
> >> >> >> >> > the client will not distinguish the replies coming from t=
he last/oob
> >> >> >> >> > and the previous commands.
> >> >> >> >> >
> >> >> >> >> > This should probably be enforced upfront by client capabi=
lity checks,
> >> >> >> >> > more below.
> >> >> >> >
> >> >> >> > Hmm yes since the oob commands are actually running in async=
 way,
> >> >> >> > request ID should be needed here.  However I'm not sure whet=
her
> >> >> >> > enabling the whole "request ID" thing is too big for this "t=
ry to be
> >> >> >> > small" oob change... And IMHO it suites better to be part of=
 the whole
> >> >> >> > async work (no matter which implementation we'll use).
> >> >> >> >
> >> >> >> > How about this: we make "id" mandatory for "run-oob" request=
s only.
> >> >> >> > For oob commands, they will always have ID then no ordering =
issue, and
> >> >> >> > we can do it async; for the rest of non-oob commands, we sti=
ll allow
> >> >> >> > them to go without ID, and since they are not oob, they'll a=
lways be
> >> >> >> > done in order as well.  Would this work?
> >> >> >>
> >> >> >> This mixed-mode is imho more complicated to deal with than hav=
ing the
> >> >> >> protocol enforced one way or the other, but that should work.
> >> >> >>
> >> >> >> >
> >> >> >> >> >
> >> >> >> >> > > Yeah I know in current code the parser calls dispatcher=
 directly
> >> >> >> >> > > (please see handle_qmp_command()).  However it's not tr=
ue again after
> >> >> >> >> > > this series (parser will has its own IO thread, and dis=
patcher will
> >> >> >> >> > > still be run in main thread).  So this OOB does brings =
something
> >> >> >> >> > > different.
> >> >> >> >> > >
> >> >> >> >> > > There are more details on why OOB and the difference/re=
lationship
> >> >> >> >> > > between OOB, async QMP, block/general jobs, etc.. but I=
MHO that's
> >> >> >> >> > > slightly out of topic (and believe me, it's not easy fo=
r me to
> >> >> >> >> > > summarize that).  For more information, please refers t=
o [1].
> >> >> >> >> > >
> >> >> >> >> > > Summary ends here.
> >> >> >> >> > >
> >> >> >> >> > > Some Implementation Details
> >> >> >> >> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> >> >> >> >> > >
> >> >> >> >> > > Again, I mentioned that the old QMP workflow is this:
> >> >> >> >> > >
> >> >> >> >> > >       JSON Parser --> QMP Dispatcher --> Respond
> >> >> >> >> > >           /|\    (2)                (3)     |
> >> >> >> >> > >        (1) |                               \|/ (4)
> >> >> >> >> > >            +---------  main thread  --------+
> >> >> >> >> > >
> >> >> >> >> > > What this series does is, firstly:
> >> >> >> >> > >
> >> >> >> >> > >       JSON Parser     QMP Dispatcher --> Respond
> >> >> >> >> > >           /|\ |           /|\       (4)     |
> >> >> >> >> > >            |  | (2)        | (3)            |  (5)
> >> >> >> >> > >        (1) |  +----->      |               \|/
> >> >> >> >> > >            +---------  main thread  <-------+
> >> >> >> >> > >
> >> >> >> >> > > And further:
> >> >> >> >> > >
> >> >> >> >> > >                queue/kick
> >> >> >> >> > >      JSON Parser =3D=3D=3D=3D=3D=3D> QMP Dispatcher -->=
 Respond
> >> >> >> >> > >          /|\ |     (3)       /|\        (4)    |
> >> >> >> >> > >       (1) |  | (2)            |                |  (5)
> >> >> >> >> > >           | \|/               |               \|/
> >> >> >> >> > >         IO thread         main thread  <-------+
> >> >> >> >> >
> >> >> >> >> > Is the queue per monitor or per client?
> >> >> >> >
> >> >> >> > The queue is currently global. I think yes maybe at least we=
 can do it
> >> >> >> > per monitor, but I am not sure whether that is urgent or can=
 be
> >> >> >> > postponed.  After all now QMPRequest (please refer to patch =
11) is
> >> >> >> > defined as (mon, id, req) tuple, so at least "id" namespace =
is
> >> >> >> > per-monitor.
> >> >> >> >
> >> >> >> >> > And is the dispatching going
> >> >> >> >> > to be processed even if the client is disconnected, and a=
re new
> >> >> >> >> > clients going to receive the replies from previous client=
s
> >> >> >> >> > commands?
> >> >> >> >
> >> >> >> > [1]
> >> >> >> >
> >> >> >> > (will discuss together below)
> >> >> >> >
> >> >> >> >> > I
> >> >> >> >> > believe there should be a per-client context, so there wo=
n't be "id"
> >> >> >> >> > request conflicts.
> >> >> >> >
> >> >> >> > I'd say I am not familiar with this "client" idea, since aft=
er all
> >> >> >> > IMHO one monitor is currently designed to mostly work with a=
 single
> >> >> >> > client. Say, unix sockets, telnet, all these backends are on=
ly single
> >> >> >> > channeled, and one monitor instance can only work with one c=
lient at a
> >> >> >> > time.  Then do we really need to add this client layer upon =
it?  IMHO
> >> >> >> > the user can just provide more monitors if they wants more c=
lients
> >> >> >> > (and at least these clients should know the existance of the=
 others or
> >> >> >> > there might be problem, otherwise user2 will fail a migratio=
n, finally
> >> >> >> > noticed that user1 has already triggered one), and the user =
should
> >> >> >> > manage them well.
> >> >> >>
> >> >> >> qemu should support a management layer / libvirt restart/recon=
nect.
> >> >> >> Afaik, it mostly work today. There might be a cases where libv=
irt can
> >> >> >> be confused if it receives a reply from a previous connection =
command,
> >> >> >> but due to the sync processing of the chardev, I am not sure y=
ou can
> >> >> >> get in this situation.  By adding "oob" commands and queuing, =
the
> >> >> >> client will have to remember which was the last "id" used, or =
it will
> >> >> >> create more conflict after a reconnect.
> >> >> >>
> >> >> >> Imho we should introduce the client/connection concept to avoi=
d this
> >> >> >> confusion (unexpected reply & per client id space).
> >> >> >
> >> >> > Hmm I agree that the reconnect feature would be nice, but if so=
 IMHO
> >> >> > instead of throwing responses away when client disconnect, we s=
hould
> >> >> > really keep them, and when the client reconnects, we queue the
> >> >> > responses again.
> >> >> >
> >> >> > I think we have other quite simple ways to solve the "unexpecte=
d
> >> >> > reply" and "per-client-id duplication" issues you have mentione=
d.
> >> >> >
> >> >> > Firstly, when client gets unexpected replies ("id" field not in=
 its
> >> >> > own request queue), the client should just ignore that reply, w=
hich
> >> >> > seems natural to me.
> >> >>
> >> >> The trouble is that it may legitimately use the same "id" value f=
or
> >> >> new requests. And I don't see a simple way to handle that without
> >> >> races.
> >> >
> >> > Under what circumstances can it reuse the same ID for new requests=
?
> >> > Can't we simply tell it not to?
> >>
> >> I don't see any restriction today in the protocol in connecting with=
 a
> >> new client that may not know anything from a previous client.
> >
> > Well, it knows it's doing a reconnection.
>=20
> If you assume the "same client" reconnects to the monitor, I agree.
> But this is a restriction of monitor usage.

In monitor_qmp_event(), we can empty the request queue when got
CHR_EVENT_CLOSED.  Would that be a solution?

--=20
Peter Xu
