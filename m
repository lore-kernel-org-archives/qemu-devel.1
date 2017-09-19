Received: from eggs.gnu.org ([2001:4830:134:3::10]:38016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1duNaJ-0007yv-Qv
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 14:49:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1duNaF-00066o-SB
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 14:49:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35058)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1duNaF-00066D-HB
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 14:49:23 -0400
Date: Tue, 19 Sep 2017 19:49:04 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170919184903.GJ2107@work-vm>
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
Content-Type: text/plain; charset=iso-8859-1
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
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: Peter Xu <peterx@redhat.com>, QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>

* Marc-Andr=E9 Lureau (marcandre.lureau@gmail.com) wrote:
> On Mon, Sep 18, 2017 at 1:26 PM, Dr. David Alan Gilbert
> <dgilbert@redhat.com> wrote:
> > * Marc-Andr=E9 Lureau (marcandre.lureau@gmail.com) wrote:
> >> Hi
> >>
> >> On Mon, Sep 18, 2017 at 12:55 PM, Dr. David Alan Gilbert
> >> <dgilbert@redhat.com> wrote:
> >> > * Marc-Andr=E9 Lureau (marcandre.lureau@gmail.com) wrote:
> >> >> Hi
> >> >>
> >> >> On Mon, Sep 18, 2017 at 10:37 AM, Peter Xu <peterx@redhat.com> wr=
ote:
> >> >> > On Fri, Sep 15, 2017 at 01:14:47PM +0200, Marc-Andr=E9 Lureau w=
rote:
> >> >> >> Hi
> >> >> >>
> >> >> >> On Thu, Sep 14, 2017 at 9:46 PM, Peter Xu <peterx@redhat.com> =
wrote:
> >> >> >> > On Thu, Sep 14, 2017 at 07:53:15PM +0100, Dr. David Alan Gil=
bert wrote:
> >> >> >> >> * Marc-Andr=E9 Lureau (marcandre.lureau@gmail.com) wrote:
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

I think I'm just requiring each monitor that connects to have a unique
set of IDs;  I don't really want the objects that Eric suggests; I'll
just take a string starting with a unique ID.

> >> How would you tell it not to use old IDs? Just by writing an unwritt=
en
> >> rule, because we don't want to fix the per connection client session
> >> handling in qemu?
> >
> > BY writing a written rule!  This out of order stuff we're adding here
> > is a change to the interface and we can define what we require of the
> > client.  As long as what we expect is reasonable then we might end
> > up with something that's simpler for both the client and qemu.
>=20
> As long as we don't break existing qmp clients.

Right.

> > And I worry this series keeps getting more and more complex for weird
> > edge cases.
>=20
> That's an interesting point-of-view. I see the point in fixing weird
> edge cases in qemu RPC code. More than other code we develop with
> weird edge cases in mind & tests, like the parsing/checking of the
> json schema for ex, in a similar area with the same maintainer.

I'm more worried here about the ability to execute non-blocking
commands; and to be able to do it without rewriting the planet.
If we can avoid having edge-cases by just defining what's required
then I'm happy.

Dave

> > Dave
> >
> >> >
> >> > Dave
> >> >
> >> >> >
> >> >> > Then, if client disconnected and reconnected, it should not hav=
e the
> >> >> > problem to generate duplicated id for request, since it should =
know
> >> >> > what requests it has sent already.  A simplest case I can think=
 of is,
> >> >> > the ID should contains the following tuple:
> >> >>
> >> >> If you assume the "same" client will recover its state, yes.
> >> >>
> >> >> >
> >> >> >   (client name, client unique ID, request ID)
> >> >> >
> >> >> > Here "client name" can be something like "libvirt", which is th=
e name
> >> >> > of client application;
> >> >> >
> >> >> > "client unique ID" can be anything generated when client starts=
, it
> >> >> > identifies a single client session, maybe a UUID.
> >> >> >
> >> >> > "request ID" can be a unsigned integer starts from zero, and in=
creases
> >> >> > each time the client sends one request.
> >> >>
> >> >> This is introducing  session handling, and can be done in server =
side
> >> >> only without changes in the protocol I believe.
> >> >>
> >> >> >
> >> >> > I believe current libvirt is using "client name" + "request ID"=
.  It's
> >> >> > something similar (after all I think we don't normally have >1 =
libvirt
> >> >> > to manage single QEMU, so I think it should be good enough).
> >> >>
> >> >> I am not sure we should base our protocol usage assumptions based=
 on
> >> >> libvirt only, but rather on what is possible today (like queuing
> >> >> requests in the socket etc..).
> >> >>
> >> >> > Then even if client disconnect and reconnect, request ID won't =
lose,
> >> >> > and no duplication would happen IMHO.
> >> >> >
> >> >> >>
> >> >> >> >
> >> >> >> >> >
> >> >> >> >> > >
> >> >> >> >> > > Then it introduced the "allow-oob" parameter in QAPI sc=
hema to define
> >> >> >> >> > > commands, and "run-oob" flag to let oob-allowed command=
 to run in the
> >> >> >> >> > > parser.
> >> >> >> >> >
> >> >> >> >> > From a protocol point of view, I find that "run-oob" dist=
inction per
> >> >> >> >> > command a bit pointless. It helps with legacy client that=
 wouldn't
> >> >> >> >> > expect out-of-order replies if qemu were to run oob comma=
nds oob by
> >> >> >> >> > default though.
> >> >> >> >
> >> >> >> > After all oob somehow breaks existing rules or sync executio=
n.  I
> >> >> >> > thought the more important goal was at least to keep the leg=
acy
> >> >> >> > behaviors when adding new things, no?
> >> >> >>
> >> >> >> Of course we have to keep compatibily. What do you mean by "oo=
b
> >> >> >> somehow breaks existing rules or sync execution"? oob means qu=
euing
> >> >> >> and unordered reply support, so clearly this is breaking the c=
urrent
> >> >> >> "mostly ordered" behaviour (mostly because events may still co=
me any
> >> >> >> time..., and the reconnect issue discussed above).
> >> >> >
> >> >> > Yes.  That's what I mean, it breaks the synchronous scemantic. =
 But
> >> >> > I should definitely not call it a "break" though since old clie=
nts
> >> >> > will work perfectly fine with it.  Sorry for the bad wording.
> >> >> >
> >> >> >>
> >> >> >> >> > Clients shouldn't care about how/where a command is
> >> >> >> >> > being queued or not. If they send a command, they want it=
 processed as
> >> >> >> >> > quickly as possible. However, it can be interesting to kn=
ow if the
> >> >> >> >> > implementation of the command will be able to deliver oob=
, so that
> >> >> >> >> > data in the introspection could be useful.
> >> >> >> >> >
> >> >> >> >> > I would rather propose a client/server capability in qmp_=
capabilities,
> >> >> >> >> > call it "oob":
> >> >> >> >> >
> >> >> >> >> > This capability indicates oob commands support.
> >> >> >> >>
> >> >> >> >> The problem is indicating which commands support oob as opp=
osed to
> >> >> >> >> indicating whether oob is present at all.  Future versions =
will
> >> >> >> >> probably make more commands oob-able and a client will want=
 to know
> >> >> >> >> whether it can rely on a particular command being non-block=
ing.
> >> >> >> >
> >> >> >> > Yes.
> >> >> >> >
> >> >> >> > And IMHO we don't urgently need that "whether the server glo=
bally
> >> >> >> > supports oob" thing.  Client can just know that from query-q=
mp-schema
> >> >> >> > already - there will always be the "allow-oob" new field for=
 command
> >> >> >> > typed entries.  IMHO that's a solid hint.
> >> >> >> >
> >> >> >> > But I don't object to return it as well in qmp_capabilities.
> >> >> >>
> >> >> >> Does it feel right that the client can specify how the command=
 are
> >> >> >> processed / queued ? Isn't it preferable to leave that to the =
server
> >> >> >> to decide? Why would a client specify that? And should the ser=
ver be
> >> >> >> expected to behave differently? What the client needs to be ab=
le is to
> >> >> >> match the unordered replies, and that can be stated during cap
> >> >> >> negotiation / qmp_capabilties. The server is expected to do a =
best
> >> >> >> effort to handle commands and their priorities. If the client =
needs
> >> >> >> several command queue, it is simpler to open several connectio=
n rather
> >> >> >> than trying to fit that weird priority logic in the protocol i=
mho.
> >> >> >
> >> >> > Sorry I may have missed the point here.  We were discussing abo=
ut a
> >> >> > global hint for "oob" support, am I right?  Then, could I ask w=
hat's
> >> >> > the "weird priority logic" you mentioned?
> >> >>
> >> >> I call per-message oob hint a kind of priority logic, since you c=
an
> >> >> make the same request without oob in the same session and in para=
llel.
> >> >>
> >> >> >>
> >> >> >> >
> >> >> >> >>
> >> >> >> >> > An oob command is a regular client message request with t=
he "id"
> >> >> >> >> > member mandatory, but the reply may be delivered
> >> >> >> >> > out of order by the server if the client supports
> >> >> >> >> > it too.
> >> >> >> >> >
> >> >> >> >> > If both the server and the client have the "oob" capabili=
ty, the
> >> >> >> >> > server can handle new client requests while previous requ=
ests are being
> >> >> >> >> > processed.
> >> >> >> >> >
> >> >> >> >> > If the client doesn't have the "oob" capability, it may s=
till call
> >> >> >> >> > an oob command, and make multiple outstanding calls. In t=
his case,
> >> >> >> >> > the commands are processed in order, so the replies will =
also be in
> >> >> >> >> > order. The "id" member isn't mandatory in this case.
> >> >> >> >> >
> >> >> >> >> > The client should match the replies with the "id" member =
associated
> >> >> >> >> > with the requests.
> >> >> >> >> >
> >> >> >> >> > When a client is disconnected, the pending commands are n=
ot
> >> >> >> >> > necessarily cancelled. But the future clients will not ge=
t replies from
> >> >> >> >> > commands they didn't make (they might, however, receive s=
ide-effects
> >> >> >> >> > events).
> >> >> >> >>
> >> >> >> >> What's the behaviour on the current monitor?
> >> >> >> >
> >> >> >> > Yeah I want to ask the same question, along with questioning=
 about
> >> >> >> > above [1].
> >> >> >> >
> >> >> >> > IMHO this series will not change the behaviors of these, so =
IMHO the
> >> >> >> > behaviors will be the same before/after this series. E.g., w=
hen client
> >> >> >> > dropped right after the command is executed, I think we will=
 still
> >> >> >> > execute the command, though we should encounter something od=
d in
> >> >> >> > monitor_json_emitter() somewhere when we want to respond.  A=
nd it will
> >> >> >> > happen the same after this series.
> >> >> >>
> >> >> >> I think it can get worse after your series, because you queue =
the
> >> >> >> commands, so clearly a new client can get replies from an old =
client
> >> >> >> commands. As said above, I am not convinced you can get in tha=
t
> >> >> >> situation with current code.
> >> >> >
> >> >> > Hmm, seems so.  But would this a big problem?
> >> >> >
> >> >> > I really think the new client should just throw that response a=
way if
> >> >> > it does not really know that response (from peeking at "id" fie=
ld),
> >> >> > just like my opinion above.
> >> >>
> >> >> This is a high expectation.
> >> >>
> >> >>
> >> >> --
> >> >> Marc-Andr=E9 Lureau
> >> > --
> >> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> >>
> >>
> >>
> >> --
> >> Marc-Andr=E9 Lureau
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>=20
>=20
>=20
> --=20
> Marc-Andr=E9 Lureau
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
