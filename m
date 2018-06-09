Received: from eggs.gnu.org ([2001:4830:134:3::10]:52030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fRlV8-0000Gb-FA
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 17:34:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fRlV6-0005vM-CE
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 17:34:22 -0400
References: <20180605092159.GA2544@work-vm>
	<46ef4200-eccf-7e65-d3a0-69e4a7414b51@redhat.com>
	<20180606111406.GD2660@work-vm>
	<9e8b49fb-0162-bf35-21bb-acc0dc28555f@redhat.com>
	<20180606120050.GB2661@work-vm>
	<61a301dd-8e50-8799-8328-341d6ab744f5@redhat.com>
	<20180606143134.GG2660@work-vm>
	<39bcee27-329a-61d8-47fa-678b431b0a79@redhat.com>
	<20180606175551-mutt-send-email-mst@kernel.org>
	<8fc775cd-f98c-c795-3935-855e56f01b68@redhat.com>
	<20180608002005-mutt-send-email-mst@kernel.org>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <5dc0b886-a7c3-50a6-e4db-bde26919af3a@redhat.com>
Date: Sat, 9 Jun 2018 23:34:03 +0200
MIME-Version: 1.0
In-Reply-To: <20180608002005-mutt-send-email-mst@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vqNpRm4TCVOoZCzmkDIEsSYM8HMzWytHY"
Subject: Re: [Qemu-devel] storing machine data in qcow images?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, armbru@redhat.com, qemu-devel@nongnu.org, "Richard W.M. Jones" <rjones@redhat.com>, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vqNpRm4TCVOoZCzmkDIEsSYM8HMzWytHY
From: Max Reitz <mreitz@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, armbru@redhat.com,
 qemu-devel@nongnu.org, "Richard W.M. Jones" <rjones@redhat.com>,
 stefanha@redhat.com
Message-ID: <5dc0b886-a7c3-50a6-e4db-bde26919af3a@redhat.com>
Subject: Re: [Qemu-devel] storing machine data in qcow images?
References: <20180605092159.GA2544@work-vm>
 <46ef4200-eccf-7e65-d3a0-69e4a7414b51@redhat.com>
 <20180606111406.GD2660@work-vm>
 <9e8b49fb-0162-bf35-21bb-acc0dc28555f@redhat.com>
 <20180606120050.GB2661@work-vm>
 <61a301dd-8e50-8799-8328-341d6ab744f5@redhat.com>
 <20180606143134.GG2660@work-vm>
 <39bcee27-329a-61d8-47fa-678b431b0a79@redhat.com>
 <20180606175551-mutt-send-email-mst@kernel.org>
 <8fc775cd-f98c-c795-3935-855e56f01b68@redhat.com>
 <20180608002005-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180608002005-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-06-07 23:43, Michael S. Tsirkin wrote:
> On Wed, Jun 06, 2018 at 07:06:27PM +0200, Max Reitz wrote:

[...]

>> Er, yeah, OK.  But it was my understanding that we decided that we hav=
e
>> a management layer on top of qemu to make things simple.
>=20
> Who's we?

Everyone I'm usually talking to when it comes to adding features to the
block layer, be it on the mailing list or at KVM Forum.

Also my own judgment, when I look at how extensively the block layer
uses QMP, which by definition is not meant to be used by humans.

So this is strongly biased by my immediate environment.

>           I don't think the QEMU community completely gave up on people=

> using QEMU directly. It will need to be much more user-friendly than it=

> is right now.

You are the very first person I hear this from.  Don't take this as
disagreement, it's just that most of the energy recently seem to go into
making qemu interoperate more easily with management layers than with
end users.  Those goals are not necessarily mutually exclusive, but one
thing this changes did was to make "modern" qemu configuration rather
verbose, which is not what I'd call user-friendly.

>               But it's possible. Fabrice built an emulator in
> javascript, you go to a URL bam it runs a VM.

So?

You can still give qemu an image directly and bam it runs a VM.  It's
just that you get an i440 with an IDE HDD, probably like the JS qemu.

The whole point of this thread was that you might want to run q35, and I
don't know, maybe virtio-blk/scsi.  So exactly what you don't get from
the JS VM.

qemu would be very easy to use if it didn't offer any configuration
options.  The problem is that is offers a huge load of configuration
options and it is not reasonable to expect every user to know all of them=
=2E

One way to solve this is to add a management layer which knows all of
the options and may choose good defaults based on knowledge that the
qemu process itself doesn't have (i.e. "put implementation in qemu, and
choose the policy in the management layer").  This is at least what the
block layer usually chooses to do.

>> Also, this is once more a case of first deciding what we want at all.
>=20
> Who's we here again?

The participants of this discussion.  Maybe I should have said "you"
because it doesn't necessarily concern myself.

OTOH, we don't have an appliance solution so far (as far as I'm aware),
so I suppose it concerns all of the qemu community, and probably
everyone working somewhere up any qemu management stack as well.

>                      Different people want different things. Enough
> people seem to want to store tagged data with a disk image that it migh=
t
> be worth someone's while to try to add that capability for starters to
> qemu-img.

I disagree, and I will explain why below. [1]

>> Dave wants configuration options for the upper management layer which
>> are completely opaque to qemu.  That has nothing to do whatsoever with=

>> the usability of qemu itself.
>=20
> That's why I keep saying, let's start with implementing a mechanism,
> worry about policy later if at all.

[1] I wholeheartedly disagree.

Say you have this mechanism now.  Whatever mechanism it is, because
there isn't even any consensus on that (you'd like key-value binary
object storage, Dave just wants a simple strong with some key-value
format that hasn't been defined in detail, although he has given some
proposals).

Then you need to implement something on top of it, store some values,
interpret them somehow.  And this is exactly what I am asking right now.
 What do you want to store?  Where do you want to interpret it?

I do not understand why you think it's harder to decide that now than
after you have extended qcow2.

I absolutely do think designing the qcow2 extension at least becomes
simpler if you do that design now.


There is a case to be made that one shouldn't worry too much about the
future.  Sometimes you just gotta start somewhere and see where it
leads, maybe the initial design was crap, too bad, then you need to
start over.  But at least you got something done.

But we have talked for half a week now.  In my very personal opinion we
definitely haven't reached the point yet where we just need to start
with something.  Appliances would be a big thing, no need to rush it.

[...]

> I think what we are seeing here is many people jumping on the
> bandwagon and finding more and more uses for ability to store
> meta-data in the qcow2 file.

I don't see that here, but it may very well be true that other people
may find it useful even for other purposes than appliances.

> This just means we should make it flexible enough to possibly
> support more uses. It does not mean we need to make it
> read mail on day 1.

So you are saying that we may end up with multiple parties storing
(meta-)data independently in the qcow2 file?

That would be an argument on why we'd want opaque metadata storage
before there are concrete design documents, and on why it doesn't matter
that you focus on qemu whereas others focus on the management layer.

Though it would mean opaque storage, as I've said, and that storing data
in the qcow2 file still probably does not make sense for some of the
possible use cases.  For instance, you propose storing data for qemu
proper without any management layer, but this poses the question again
of who should interpret that data.  (A management layer may just query
the image before launching qemu and then set the appropriate options,
but it gets difficult for the block layer to open the qcow2 image and
change the machine type when qemu is already running.  Though maybe you
could at least error out when incompatible options have been used to
launch qemu.  Hm.  Another question was who'd be supposed to store the
data.)

[...]

>> And if you make the format decidedly qcow2-independent, the whole
>> "putting it into qcow2 is the simplest implementation" argument become=
s
>> rather weak.
>=20
> I don't see why. Yes I think it's a separate format that we should just=

> allow storing in qcow2 for usability.

It becomes weak because storing it in qcow2 would no longer be the
simplest implementation if you'd need to be able to read it from a file
outside of a qcow2 image anyway.

It still may be the easiest use case for users.

[...]

>> But all of that writing once again comes down to this: You are talking=

>> about qemu.  Dave is talking about something higher in the management
>> layer.  Those are different things, and as I said, we first need to fi=
nd
>> common ground there.
>=20
> The common ground is that both me and Dave find it useful to store meta=
-data
> in the disk image.

Though it seems to me that you have very different ideas on how to store
it.  As far as I have understood, Dave just wants to store a bit of data
that might even go into the image header, whereas you'd prefer a
full-blown infrastructure for binary storage and large objects, because
someone might want that at some point.

That isn't to say I personally prefer either, it just means that those
are different and deciding on one naturally changes what to do.

There may be even other approaches, I don't know.

And my idea was that we should evaluate the different use cases for
storing arbitrary metadata in a qcow2 file, and then we'd see whether it
does or doesn't make sense to do so, for each case.

I think making qemu store something in the qcow2 file doesn't bring too
much because first, qemu couldn't really interpret that information by
itself (it could at best detect conflicting configuration, though in my
head checking qemu configuration in the qcow2 driver screams complexity;
and storing that information automatically would be problematic); and
secondly, I don't think that we can solve the complexity that is modern
qemu configuration by just putting it into a qcow2 file.  That will only
work as long as the user doesn't want to change anything.  There is
probably much more to say, but all of that would deserve its own thread.

Regarding designing an appliance format, there has already been some
discussion, so I won't say anything about that now, except that it too
should go into its own thread so that people are aware and don't think
it's just a qcow2 issue.

>> This is exactly why I said "where to store it heavily depends on what =
we
>> want to store and how we want to use it."  As long as we don't know
>> that, all of us are using strawman arguments where some other party
>> suddenly chimes in and says "no, no, no, this is not what I'm talking
>> about".  Yes, maybe you aren't, but someone else is.
>>
>> [...]
>=20
> Looks like discussion has run its course.
>=20
> I think it's time for someone motivated enough to send a patch.
> If enough interested people ack it, we will know it addresses
> some of their needs.

OK, but don't expect me to merge it at the current state of this
discussion[2].  If you or someone else sends a patch, I may raise my
concerns (though I will probably not NACK it) and I will defer the
decision to Kevin.

[2] By that I mean that I will not merge a feature-adding patch with a
justification of "We'll find a use for it later", which is exactly what
you've said in this mail.  (Though Dave does have concrete intentions,
so if he can expand on that, give an ACK and explain why this is worth
the effort (and the effort depends on the implementation complexity),
then things will probably be different.)

[...]

>> So you want appliances, do I understand that correctly?  Because that =
is
>> exactly what Dave doesn't want.
>=20
> That's policy. I see no need to prevent people from building appliances=
,

Dave does.  He explicitly raised the idea of limiting the things that
can be stored in a qcow2 file, precisely because he didn't want the
feature to become too complex.

> though right now I'm not interested in building them myself.
> We there's a mechanism both kinds of people can use, then great.

Such a flexible feature means complexity, and in my opinion a complex
feature needs a reasonable justification.  "People will find a use for
it" is not reasonable.

Although it really is not unlikely that I'm wrong and that a flexible
metadata storage does not need to be complex.

[...]

>>> Software developers are being paid for saving people's time.
>>
>> Very good point, but I did say something like this before: I do not
>> oppose appliances whatsoever.  In fact, it seems like a nice thing to =
have.
>>
>> But, here's the deal: I do not think putting that data into qcow2 to b=
e
>> the best solution.  Furthermore, I have things to do that I consider
>> more important than developing an appliance solution.  Therefore, it's=

>> not like I'm sitting around doing nothing when I could be developing a=

>> solution to this issue here.
>>
>> I kept saying that I consider all of this an inconvenience.  Yes, it
>> would be nice to have.  But I have things on my to do list that are ha=
rd
>> feature requests, things that people really do need.  We all have.  We=

>> all need to decide how we can use our own time as efficiently as
>> possible.  And I do not think that developing an appliance solution
>> would be the best use of my time.  (Until my manager disagrees.)
>=20
> As long as you don't start sending nacks on the basis that it's also no=
t
> the best use of other's time, I don't mind.

No, but I'm one of the qcow2 maintainers, so any feature added to qcow2
just is a burden to myself and may therefore cost me time.

Luckily there is another qcow2 maintainer, so I will not NACK features
based on the fact that they are just a burden.  If Kevin wants to merge
a feature that I don't deem sufficiently useful, then he can go right ahe=
ad.

[...]

>> And as I've said multiple times now, but I can't repeat myself often
>> enough, I think it would be most efficient if we worried about what we=

>> want to store first, before we worry about where to store it.  I belie=
ve
>> that once we have a hard requirement on what we want to store and how =
to
>> use it (that most people agree on), we will have a set of constraints =
on
>> how we can represent that data and where it needs to be stored, and th=
is
>> will give us a simple yes or no to the question whether the data needs=

>> to be stored in qcow2, or whether there is any better way (or whether =
it
>> can be stored in qcow2, but need not be).
>=20
> Well the subject says it, does it not? We want to store
> machine data there.

Are you sure?

Firstly, that is not sufficiently precise.  Do you want an appliance,
i.e. store everything?  Do you want to store just something and limit
everyone in what can be stored (Dave's proposal)?  That is a difference,
and that is exactly what I was asking.

Secondly, in this mail you even seemed to propose storing just any
metadata that might be related to a VM (or maybe not even that).  This
too has some (meta-?)influence on the design.

For instance, if you want to store only VM-related information, we can
document those structures in the qcow2 specification in the qemu tree
(or at least link to another document in the qemu tree).  But if you
want to be able to store any metadata that just anyone wants to store,
then that won't be possible.  (And this would have implications.  For
instance, someone might decide on storing metadata that makes the qcow2
image effectively unreadable (e.g. by storing a special backing link).
I wouldn't like that, but we couldn't do anything about it if we'd allow
storage of arbitrary metadata.)

[...]

>>> Old QEMU can't handle tar files. You need to unpack them,
>>> then figure out that there are two files in the tar, one
>>> is just for new qemu versions, one is portable. At which point
>>> you need to go figure out what is your QEMU version.
>>
>> And old qemu versions will just give you a blank screen for a qcow2 fi=
le
>> with required non-default options.
>=20
> Compatiblity is not worthless simply because we do not have time travel=
=2E

Dave was saying that the worst thing about the whole q35 thing is that
users download an image and have no idea why it isn't working.  Figuring
that out may take a long time, because nothing is even throwing an error
message.

If we had a new format, users couldn't even run it in qemu, so they
would quickly figure out that in order to run this VM, they need to
update their stack.

If we just add this information to qcow2, those users with outdated qemu
versions would again have to figure out why the image isn't working.

Sure, that is a minor issue that would solve itself by users slowly
upgrading their qemu, but it goes to show that compatibility may not
always be what is best.

Max


--vqNpRm4TCVOoZCzmkDIEsSYM8HMzWytHY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlscR8sACgkQ9AfbAGHV
z0A9/ggAo4prMEXzYuQPFNnDJlhr23axqQWpstAcJDJ4e4BbNWHiOSQhzakol4XE
UePjpGm5/Uq94ORZQp+XJd2+sukAvWgWiun5aNASD+7NHXgdu6HANQ7MwgIvSB3y
R2/taSavieuDk8iFuGUK9dFgODU7QeJ5op1XCuqEo6NKKnlMlOzUy1ihBcjLwudq
wD3RjWcOv7Uhb7vaz+XbxvpfNC6PshBH+gMA7e6NkQ4pZnUWHt9s73cWrB5ywPOR
sAhTJLJwCCpaqnEl3kwNQkSx+3EQYez2ByMUXv0htBuLFVMtIvB5xER06JPMtuM6
wsGNf35/ExWIg+5dPmkxzBI0K80n5w==
=/vpn
-----END PGP SIGNATURE-----

--vqNpRm4TCVOoZCzmkDIEsSYM8HMzWytHY--
