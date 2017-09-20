Received: from eggs.gnu.org ([2001:4830:134:3::10]:54846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1duWls-0004eq-06
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 00:38:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1duWlo-0002p0-1E
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 00:38:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43808)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1duWln-0002ki-MU
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 00:37:55 -0400
Date: Wed, 20 Sep 2017 12:37:41 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170920043741.GR3617@pxdev.xzpeter.org>
References: <20170915044622.GO3617@pxdev.xzpeter.org>
	<CAJ+F1CKGsYbK5M6WKGSCioFCFY79WjFCtEQGqudiuA-QZTfOCA@mail.gmail.com>
	<20170918083737.GD3617@pxdev.xzpeter.org>
	<CAJ+F1C+ZE2xDVK8Ni7CaVbH6NHEz0-xXh_1gqwF-jf6T0iA16Q@mail.gmail.com>
	<20170918105516.GD2581@work-vm>
	<CAJ+F1CL3UwzTO7APLnR1MUFg+XWF1B8VJkmNQGBa3bqB_bXNfg@mail.gmail.com>
	<20170918112618.GF2581@work-vm>
	<CAJ+F1CLkTZMgUtpPUu_3SkscYDRuM0+zjWsiJ6-a-CtZYOLhBA@mail.gmail.com>
	<20170919062903.GH3617@pxdev.xzpeter.org>
	<20170919091921.GD2107@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170919091921.GD2107@work-vm>
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>, QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Tue, Sep 19, 2017 at 10:19:21AM +0100, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > On Mon, Sep 18, 2017 at 06:09:29PM +0200, Marc-Andr=C3=A9 Lureau wrot=
e:
> > > On Mon, Sep 18, 2017 at 1:26 PM, Dr. David Alan Gilbert
> > > <dgilbert@redhat.com> wrote:
> > > > * Marc-Andr=C3=A9 Lureau (marcandre.lureau@gmail.com) wrote:
> > > >> Hi
> > > >>
> > > >> On Mon, Sep 18, 2017 at 12:55 PM, Dr. David Alan Gilbert
> > > >> <dgilbert@redhat.com> wrote:
> > > >> > * Marc-Andr=C3=A9 Lureau (marcandre.lureau@gmail.com) wrote:
> > > >> >> Hi
> > > >> >>
> > > >> >> On Mon, Sep 18, 2017 at 10:37 AM, Peter Xu <peterx@redhat.com=
> wrote:
> > > >> >> > On Fri, Sep 15, 2017 at 01:14:47PM +0200, Marc-Andr=C3=A9 L=
ureau wrote:
> > > >> >> >> Hi
> > > >> >> >>
> > > >> >> >> On Thu, Sep 14, 2017 at 9:46 PM, Peter Xu <peterx@redhat.c=
om> wrote:
> > > >> >> >> > On Thu, Sep 14, 2017 at 07:53:15PM +0100, Dr. David Alan=
 Gilbert wrote:
> > > >> >> >> >> * Marc-Andr=C3=A9 Lureau (marcandre.lureau@gmail.com) w=
rote:
> > > >> >> >> >> > Hi
> > > >> >> >> >> >
> > > >> >> >> >> > On Thu, Sep 14, 2017 at 9:50 AM, Peter Xu <peterx@red=
hat.com> wrote:
> > > >> >> >> >> > > This series was born from this one:
> > > >> >> >> >> > >
> > > >> >> >> >> > >   https://lists.gnu.org/archive/html/qemu-devel/201=
7-08/msg04310.html
> > > >> >> >> >> > >
> > > >> >> >> >> > > The design comes from Markus, and also the whole-bu=
nch-of discussions
> > > >> >> >> >> > > in previous thread.  My heartful thanks to Markus, =
Daniel, Dave,
> > > >> >> >> >> > > Stefan, etc. on discussing the topic (...again!), p=
roviding shiny
> > > >> >> >> >> > > ideas and suggestions.  Finally we got such a solut=
ion that seems to
> > > >> >> >> >> > > satisfy everyone.
> > > >> >> >> >> > >
> > > >> >> >> >> > > I re-started the versioning since this series is to=
tally different
> > > >> >> >> >> > > from previous one.  Now it's version 1.
> > > >> >> >> >> > >
> > > >> >> >> >> > > In case new reviewers come along the way without re=
ading previous
> > > >> >> >> >> > > discussions, I will try to do a summary on what thi=
s is all about.
> > > >> >> >> >> > >
> > > >> >> >> >> > > What is OOB execution?
> > > >> >> >> >> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > > >> >> >> >> > >
> > > >> >> >> >> > > It's the shortcut of Out-Of-Band execution, its nam=
e is given by
> > > >> >> >> >> > > Markus.  It's a way to quickly execute a QMP reques=
t.  Say, originally
> > > >> >> >> >> > > QMP is going throw these steps:
> > > >> >> >> >> > >
> > > >> >> >> >> > >       JSON Parser --> QMP Dispatcher --> Respond
> > > >> >> >> >> > >           /|\    (2)                (3)     |
> > > >> >> >> >> > >        (1) |                               \|/ (4)
> > > >> >> >> >> > >            +---------  main thread  --------+
> > > >> >> >> >> > >
> > > >> >> >> >> > > The requests are executed by the so-called QMP-disp=
atcher after the
> > > >> >> >> >> > > JSON is parsed.  If OOB is on, we run the command d=
irectly in the
> > > >> >> >> >> > > parser and quickly returns.
> > > >> >> >> >> >
> > > >> >> >> >> > All commands should have the "id" field mandatory in =
this case, else
> > > >> >> >> >> > the client will not distinguish the replies coming fr=
om the last/oob
> > > >> >> >> >> > and the previous commands.
> > > >> >> >> >> >
> > > >> >> >> >> > This should probably be enforced upfront by client ca=
pability checks,
> > > >> >> >> >> > more below.
> > > >> >> >> >
> > > >> >> >> > Hmm yes since the oob commands are actually running in a=
sync way,
> > > >> >> >> > request ID should be needed here.  However I'm not sure =
whether
> > > >> >> >> > enabling the whole "request ID" thing is too big for thi=
s "try to be
> > > >> >> >> > small" oob change... And IMHO it suites better to be par=
t of the whole
> > > >> >> >> > async work (no matter which implementation we'll use).
> > > >> >> >> >
> > > >> >> >> > How about this: we make "id" mandatory for "run-oob" req=
uests only.
> > > >> >> >> > For oob commands, they will always have ID then no order=
ing issue, and
> > > >> >> >> > we can do it async; for the rest of non-oob commands, we=
 still allow
> > > >> >> >> > them to go without ID, and since they are not oob, they'=
ll always be
> > > >> >> >> > done in order as well.  Would this work?
> > > >> >> >>
> > > >> >> >> This mixed-mode is imho more complicated to deal with than=
 having the
> > > >> >> >> protocol enforced one way or the other, but that should wo=
rk.
> > > >> >> >>
> > > >> >> >> >
> > > >> >> >> >> >
> > > >> >> >> >> > > Yeah I know in current code the parser calls dispat=
cher directly
> > > >> >> >> >> > > (please see handle_qmp_command()).  However it's no=
t true again after
> > > >> >> >> >> > > this series (parser will has its own IO thread, and=
 dispatcher will
> > > >> >> >> >> > > still be run in main thread).  So this OOB does bri=
ngs something
> > > >> >> >> >> > > different.
> > > >> >> >> >> > >
> > > >> >> >> >> > > There are more details on why OOB and the differenc=
e/relationship
> > > >> >> >> >> > > between OOB, async QMP, block/general jobs, etc.. b=
ut IMHO that's
> > > >> >> >> >> > > slightly out of topic (and believe me, it's not eas=
y for me to
> > > >> >> >> >> > > summarize that).  For more information, please refe=
rs to [1].
> > > >> >> >> >> > >
> > > >> >> >> >> > > Summary ends here.
> > > >> >> >> >> > >
> > > >> >> >> >> > > Some Implementation Details
> > > >> >> >> >> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >> >> >> >> > >
> > > >> >> >> >> > > Again, I mentioned that the old QMP workflow is thi=
s:
> > > >> >> >> >> > >
> > > >> >> >> >> > >       JSON Parser --> QMP Dispatcher --> Respond
> > > >> >> >> >> > >           /|\    (2)                (3)     |
> > > >> >> >> >> > >        (1) |                               \|/ (4)
> > > >> >> >> >> > >            +---------  main thread  --------+
> > > >> >> >> >> > >
> > > >> >> >> >> > > What this series does is, firstly:
> > > >> >> >> >> > >
> > > >> >> >> >> > >       JSON Parser     QMP Dispatcher --> Respond
> > > >> >> >> >> > >           /|\ |           /|\       (4)     |
> > > >> >> >> >> > >            |  | (2)        | (3)            |  (5)
> > > >> >> >> >> > >        (1) |  +----->      |               \|/
> > > >> >> >> >> > >            +---------  main thread  <-------+
> > > >> >> >> >> > >
> > > >> >> >> >> > > And further:
> > > >> >> >> >> > >
> > > >> >> >> >> > >                queue/kick
> > > >> >> >> >> > >      JSON Parser =3D=3D=3D=3D=3D=3D> QMP Dispatcher=
 --> Respond
> > > >> >> >> >> > >          /|\ |     (3)       /|\        (4)    |
> > > >> >> >> >> > >       (1) |  | (2)            |                |  (=
5)
> > > >> >> >> >> > >           | \|/               |               \|/
> > > >> >> >> >> > >         IO thread         main thread  <-------+
> > > >> >> >> >> >
> > > >> >> >> >> > Is the queue per monitor or per client?
> > > >> >> >> >
> > > >> >> >> > The queue is currently global. I think yes maybe at leas=
t we can do it
> > > >> >> >> > per monitor, but I am not sure whether that is urgent or=
 can be
> > > >> >> >> > postponed.  After all now QMPRequest (please refer to pa=
tch 11) is
> > > >> >> >> > defined as (mon, id, req) tuple, so at least "id" namesp=
ace is
> > > >> >> >> > per-monitor.
> > > >> >> >> >
> > > >> >> >> >> > And is the dispatching going
> > > >> >> >> >> > to be processed even if the client is disconnected, a=
nd are new
> > > >> >> >> >> > clients going to receive the replies from previous cl=
ients
> > > >> >> >> >> > commands?
> > > >> >> >> >
> > > >> >> >> > [1]
> > > >> >> >> >
> > > >> >> >> > (will discuss together below)
> > > >> >> >> >
> > > >> >> >> >> > I
> > > >> >> >> >> > believe there should be a per-client context, so ther=
e won't be "id"
> > > >> >> >> >> > request conflicts.
> > > >> >> >> >
> > > >> >> >> > I'd say I am not familiar with this "client" idea, since=
 after all
> > > >> >> >> > IMHO one monitor is currently designed to mostly work wi=
th a single
> > > >> >> >> > client. Say, unix sockets, telnet, all these backends ar=
e only single
> > > >> >> >> > channeled, and one monitor instance can only work with o=
ne client at a
> > > >> >> >> > time.  Then do we really need to add this client layer u=
pon it?  IMHO
> > > >> >> >> > the user can just provide more monitors if they wants mo=
re clients
> > > >> >> >> > (and at least these clients should know the existance of=
 the others or
> > > >> >> >> > there might be problem, otherwise user2 will fail a migr=
ation, finally
> > > >> >> >> > noticed that user1 has already triggered one), and the u=
ser should
> > > >> >> >> > manage them well.
> > > >> >> >>
> > > >> >> >> qemu should support a management layer / libvirt restart/r=
econnect.
> > > >> >> >> Afaik, it mostly work today. There might be a cases where =
libvirt can
> > > >> >> >> be confused if it receives a reply from a previous connect=
ion command,
> > > >> >> >> but due to the sync processing of the chardev, I am not su=
re you can
> > > >> >> >> get in this situation.  By adding "oob" commands and queui=
ng, the
> > > >> >> >> client will have to remember which was the last "id" used,=
 or it will
> > > >> >> >> create more conflict after a reconnect.
> > > >> >> >>
> > > >> >> >> Imho we should introduce the client/connection concept to =
avoid this
> > > >> >> >> confusion (unexpected reply & per client id space).
> > > >> >> >
> > > >> >> > Hmm I agree that the reconnect feature would be nice, but i=
f so IMHO
> > > >> >> > instead of throwing responses away when client disconnect, =
we should
> > > >> >> > really keep them, and when the client reconnects, we queue =
the
> > > >> >> > responses again.
> > > >> >> >
> > > >> >> > I think we have other quite simple ways to solve the "unexp=
ected
> > > >> >> > reply" and "per-client-id duplication" issues you have ment=
ioned.
> > > >> >> >
> > > >> >> > Firstly, when client gets unexpected replies ("id" field no=
t in its
> > > >> >> > own request queue), the client should just ignore that repl=
y, which
> > > >> >> > seems natural to me.
> > > >> >>
> > > >> >> The trouble is that it may legitimately use the same "id" val=
ue for
> > > >> >> new requests. And I don't see a simple way to handle that wit=
hout
> > > >> >> races.
> > > >> >
> > > >> > Under what circumstances can it reuse the same ID for new requ=
ests?
> > > >> > Can't we simply tell it not to?
> > > >>
> > > >> I don't see any restriction today in the protocol in connecting =
with a
> > > >> new client that may not know anything from a previous client.
> > > >
> > > > Well, it knows it's doing a reconnection.
> > >=20
> > > If you assume the "same client" reconnects to the monitor, I agree.
> > > But this is a restriction of monitor usage.
> >=20
> > In monitor_qmp_event(), we can empty the request queue when got
> > CHR_EVENT_CLOSED.  Would that be a solution?
>=20
> What happens to commands that are in flight?

Good questioning...

I think we can track that one as well, say, provide a simple state
machine for Monitor (possibly with a lock) that can be either "idle",
"processing", "drop".

Then a normal routine to execution of command:

0. by default, monitor state "idle"
1. when dequeue the request, mark that monitor as "processing",
   execute the command
2. when reply: if still "processing", then do it; if "drop", then drop
   that reply for current command.  Here we'll reply.

Instead, if disconnect/reconnect happens:

0. by default, monitor state "idle"
1. when dequeue the request, mark that monitor as "processing",
   execute the command
2. port disconnected, in EVENT_CLOSED, we set state to "drop"
3. port reconnected, we do nothing (so the execution state keeps
   through reconnection)
4. when reply: if still "processing", then do it; if "drop", then drop
   that reply for current command.  Here we drop that reply.

But... IMHO this is too awkward only for this single "drop the last
command reply" purpose.  I would prefer to use documentation intead to
let client drop unknown responses directly if it's ok to everyone.

Thanks,

>=20
> Dave
>=20
> > --=20
> > Peter Xu
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

--=20
Peter Xu
