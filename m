Received: from eggs.gnu.org ([2001:4830:134:3::10]:50395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1duEgp-0005fl-Pg
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 05:19:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1duEgm-0001bg-HR
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 05:19:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56000)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1duEgm-0001ag-7Q
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 05:19:32 -0400
Date: Tue, 19 Sep 2017 10:19:21 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170919091921.GD2107@work-vm>
References: <20170914185314.GA3280@work-vm>
	<20170915044622.GO3617@pxdev.xzpeter.org>
	<CAJ+F1CKGsYbK5M6WKGSCioFCFY79WjFCtEQGqudiuA-QZTfOCA@mail.gmail.com>
	<20170918083737.GD3617@pxdev.xzpeter.org>
	<CAJ+F1C+ZE2xDVK8Ni7CaVbH6NHEz0-xXh_1gqwF-jf6T0iA16Q@mail.gmail.com>
	<20170918105516.GD2581@work-vm>
	<CAJ+F1CL3UwzTO7APLnR1MUFg+XWF1B8VJkmNQGBa3bqB_bXNfg@mail.gmail.com>
	<20170918112618.GF2581@work-vm>
	<CAJ+F1CLkTZMgUtpPUu_3SkscYDRuM0+zjWsiJ6-a-CtZYOLhBA@mail.gmail.com>
	<20170919062903.GH3617@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170919062903.GH3617@pxdev.xzpeter.org>
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
To: Peter Xu <peterx@redhat.com>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>, QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>

* Peter Xu (peterx@redhat.com) wrote:
> On Mon, Sep 18, 2017 at 06:09:29PM +0200, Marc-Andr=E9 Lureau wrote:
> > On Mon, Sep 18, 2017 at 1:26 PM, Dr. David Alan Gilbert
> > <dgilbert@redhat.com> wrote:
> > > * Marc-Andr=E9 Lureau (marcandre.lureau@gmail.com) wrote:
> > >> Hi
> > >>
> > >> On Mon, Sep 18, 2017 at 12:55 PM, Dr. David Alan Gilbert
> > >> <dgilbert@redhat.com> wrote:
> > >> > * Marc-Andr=E9 Lureau (marcandre.lureau@gmail.com) wrote:
> > >> >> Hi
> > >> >>
> > >> >> On Mon, Sep 18, 2017 at 10:37 AM, Peter Xu <peterx@redhat.com> =
wrote:
> > >> >> > On Fri, Sep 15, 2017 at 01:14:47PM +0200, Marc-Andr=E9 Lureau=
 wrote:
> > >> >> >> Hi
> > >> >> >>
> > >> >> >> On Thu, Sep 14, 2017 at 9:46 PM, Peter Xu <peterx@redhat.com=
> wrote:
> > >> >> >> > On Thu, Sep 14, 2017 at 07:53:15PM +0100, Dr. David Alan G=
ilbert wrote:
> > >> >> >> >> * Marc-Andr=E9 Lureau (marcandre.lureau@gmail.com) wrote:
> > >> >> >> >> > Hi
> > >> >> >> >> >
> > >> >> >> >> > On Thu, Sep 14, 2017 at 9:50 AM, Peter Xu <peterx@redha=
t.com> wrote:
> > >> >> >> >> > > This series was born from this one:
> > >> >> >> >> > >
> > >> >> >> >> > >   https://lists.gnu.org/archive/html/qemu-devel/2017-=
08/msg04310.html
> > >> >> >> >> > >
> > >> >> >> >> > > The design comes from Markus, and also the whole-bunc=
h-of discussions
> > >> >> >> >> > > in previous thread.  My heartful thanks to Markus, Da=
niel, Dave,
> > >> >> >> >> > > Stefan, etc. on discussing the topic (...again!), pro=
viding shiny
> > >> >> >> >> > > ideas and suggestions.  Finally we got such a solutio=
n that seems to
> > >> >> >> >> > > satisfy everyone.
> > >> >> >> >> > >
> > >> >> >> >> > > I re-started the versioning since this series is tota=
lly different
> > >> >> >> >> > > from previous one.  Now it's version 1.
> > >> >> >> >> > >
> > >> >> >> >> > > In case new reviewers come along the way without read=
ing previous
> > >> >> >> >> > > discussions, I will try to do a summary on what this =
is all about.
> > >> >> >> >> > >
> > >> >> >> >> > > What is OOB execution?
> > >> >> >> >> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> > >> >> >> >> > >
> > >> >> >> >> > > It's the shortcut of Out-Of-Band execution, its name =
is given by
> > >> >> >> >> > > Markus.  It's a way to quickly execute a QMP request.=
  Say, originally
> > >> >> >> >> > > QMP is going throw these steps:
> > >> >> >> >> > >
> > >> >> >> >> > >       JSON Parser --> QMP Dispatcher --> Respond
> > >> >> >> >> > >           /|\    (2)                (3)     |
> > >> >> >> >> > >        (1) |                               \|/ (4)
> > >> >> >> >> > >            +---------  main thread  --------+
> > >> >> >> >> > >
> > >> >> >> >> > > The requests are executed by the so-called QMP-dispat=
cher after the
> > >> >> >> >> > > JSON is parsed.  If OOB is on, we run the command dir=
ectly in the
> > >> >> >> >> > > parser and quickly returns.
> > >> >> >> >> >
> > >> >> >> >> > All commands should have the "id" field mandatory in th=
is case, else
> > >> >> >> >> > the client will not distinguish the replies coming from=
 the last/oob
> > >> >> >> >> > and the previous commands.
> > >> >> >> >> >
> > >> >> >> >> > This should probably be enforced upfront by client capa=
bility checks,
> > >> >> >> >> > more below.
> > >> >> >> >
> > >> >> >> > Hmm yes since the oob commands are actually running in asy=
nc way,
> > >> >> >> > request ID should be needed here.  However I'm not sure wh=
ether
> > >> >> >> > enabling the whole "request ID" thing is too big for this =
"try to be
> > >> >> >> > small" oob change... And IMHO it suites better to be part =
of the whole
> > >> >> >> > async work (no matter which implementation we'll use).
> > >> >> >> >
> > >> >> >> > How about this: we make "id" mandatory for "run-oob" reque=
sts only.
> > >> >> >> > For oob commands, they will always have ID then no orderin=
g issue, and
> > >> >> >> > we can do it async; for the rest of non-oob commands, we s=
till allow
> > >> >> >> > them to go without ID, and since they are not oob, they'll=
 always be
> > >> >> >> > done in order as well.  Would this work?
> > >> >> >>
> > >> >> >> This mixed-mode is imho more complicated to deal with than h=
aving the
> > >> >> >> protocol enforced one way or the other, but that should work=
.
> > >> >> >>
> > >> >> >> >
> > >> >> >> >> >
> > >> >> >> >> > > Yeah I know in current code the parser calls dispatch=
er directly
> > >> >> >> >> > > (please see handle_qmp_command()).  However it's not =
true again after
> > >> >> >> >> > > this series (parser will has its own IO thread, and d=
ispatcher will
> > >> >> >> >> > > still be run in main thread).  So this OOB does bring=
s something
> > >> >> >> >> > > different.
> > >> >> >> >> > >
> > >> >> >> >> > > There are more details on why OOB and the difference/=
relationship
> > >> >> >> >> > > between OOB, async QMP, block/general jobs, etc.. but=
 IMHO that's
> > >> >> >> >> > > slightly out of topic (and believe me, it's not easy =
for me to
> > >> >> >> >> > > summarize that).  For more information, please refers=
 to [1].
> > >> >> >> >> > >
> > >> >> >> >> > > Summary ends here.
> > >> >> >> >> > >
> > >> >> >> >> > > Some Implementation Details
> > >> >> >> >> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >> >> >> >> > >
> > >> >> >> >> > > Again, I mentioned that the old QMP workflow is this:
> > >> >> >> >> > >
> > >> >> >> >> > >       JSON Parser --> QMP Dispatcher --> Respond
> > >> >> >> >> > >           /|\    (2)                (3)     |
> > >> >> >> >> > >        (1) |                               \|/ (4)
> > >> >> >> >> > >            +---------  main thread  --------+
> > >> >> >> >> > >
> > >> >> >> >> > > What this series does is, firstly:
> > >> >> >> >> > >
> > >> >> >> >> > >       JSON Parser     QMP Dispatcher --> Respond
> > >> >> >> >> > >           /|\ |           /|\       (4)     |
> > >> >> >> >> > >            |  | (2)        | (3)            |  (5)
> > >> >> >> >> > >        (1) |  +----->      |               \|/
> > >> >> >> >> > >            +---------  main thread  <-------+
> > >> >> >> >> > >
> > >> >> >> >> > > And further:
> > >> >> >> >> > >
> > >> >> >> >> > >                queue/kick
> > >> >> >> >> > >      JSON Parser =3D=3D=3D=3D=3D=3D> QMP Dispatcher -=
-> Respond
> > >> >> >> >> > >          /|\ |     (3)       /|\        (4)    |
> > >> >> >> >> > >       (1) |  | (2)            |                |  (5)
> > >> >> >> >> > >           | \|/               |               \|/
> > >> >> >> >> > >         IO thread         main thread  <-------+
> > >> >> >> >> >
> > >> >> >> >> > Is the queue per monitor or per client?
> > >> >> >> >
> > >> >> >> > The queue is currently global. I think yes maybe at least =
we can do it
> > >> >> >> > per monitor, but I am not sure whether that is urgent or c=
an be
> > >> >> >> > postponed.  After all now QMPRequest (please refer to patc=
h 11) is
> > >> >> >> > defined as (mon, id, req) tuple, so at least "id" namespac=
e is
> > >> >> >> > per-monitor.
> > >> >> >> >
> > >> >> >> >> > And is the dispatching going
> > >> >> >> >> > to be processed even if the client is disconnected, and=
 are new
> > >> >> >> >> > clients going to receive the replies from previous clie=
nts
> > >> >> >> >> > commands?
> > >> >> >> >
> > >> >> >> > [1]
> > >> >> >> >
> > >> >> >> > (will discuss together below)
> > >> >> >> >
> > >> >> >> >> > I
> > >> >> >> >> > believe there should be a per-client context, so there =
won't be "id"
> > >> >> >> >> > request conflicts.
> > >> >> >> >
> > >> >> >> > I'd say I am not familiar with this "client" idea, since a=
fter all
> > >> >> >> > IMHO one monitor is currently designed to mostly work with=
 a single
> > >> >> >> > client. Say, unix sockets, telnet, all these backends are =
only single
> > >> >> >> > channeled, and one monitor instance can only work with one=
 client at a
> > >> >> >> > time.  Then do we really need to add this client layer upo=
n it?  IMHO
> > >> >> >> > the user can just provide more monitors if they wants more=
 clients
> > >> >> >> > (and at least these clients should know the existance of t=
he others or
> > >> >> >> > there might be problem, otherwise user2 will fail a migrat=
ion, finally
> > >> >> >> > noticed that user1 has already triggered one), and the use=
r should
> > >> >> >> > manage them well.
> > >> >> >>
> > >> >> >> qemu should support a management layer / libvirt restart/rec=
onnect.
> > >> >> >> Afaik, it mostly work today. There might be a cases where li=
bvirt can
> > >> >> >> be confused if it receives a reply from a previous connectio=
n command,
> > >> >> >> but due to the sync processing of the chardev, I am not sure=
 you can
> > >> >> >> get in this situation.  By adding "oob" commands and queuing=
, the
> > >> >> >> client will have to remember which was the last "id" used, o=
r it will
> > >> >> >> create more conflict after a reconnect.
> > >> >> >>
> > >> >> >> Imho we should introduce the client/connection concept to av=
oid this
> > >> >> >> confusion (unexpected reply & per client id space).
> > >> >> >
> > >> >> > Hmm I agree that the reconnect feature would be nice, but if =
so IMHO
> > >> >> > instead of throwing responses away when client disconnect, we=
 should
> > >> >> > really keep them, and when the client reconnects, we queue th=
e
> > >> >> > responses again.
> > >> >> >
> > >> >> > I think we have other quite simple ways to solve the "unexpec=
ted
> > >> >> > reply" and "per-client-id duplication" issues you have mentio=
ned.
> > >> >> >
> > >> >> > Firstly, when client gets unexpected replies ("id" field not =
in its
> > >> >> > own request queue), the client should just ignore that reply,=
 which
> > >> >> > seems natural to me.
> > >> >>
> > >> >> The trouble is that it may legitimately use the same "id" value=
 for
> > >> >> new requests. And I don't see a simple way to handle that witho=
ut
> > >> >> races.
> > >> >
> > >> > Under what circumstances can it reuse the same ID for new reques=
ts?
> > >> > Can't we simply tell it not to?
> > >>
> > >> I don't see any restriction today in the protocol in connecting wi=
th a
> > >> new client that may not know anything from a previous client.
> > >
> > > Well, it knows it's doing a reconnection.
> >=20
> > If you assume the "same client" reconnects to the monitor, I agree.
> > But this is a restriction of monitor usage.
>=20
> In monitor_qmp_event(), we can empty the request queue when got
> CHR_EVENT_CLOSED.  Would that be a solution?

What happens to commands that are in flight?

Dave

> --=20
> Peter Xu
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
