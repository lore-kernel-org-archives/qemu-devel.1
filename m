Received: from eggs.gnu.org ([2001:4830:134:3::10]:51030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fQcZK-0006nX-KX
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 13:50:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fQcZG-0004KT-FN
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 13:49:58 -0400
References: <20180529064415.GA4756@localhost.localdomain>
	<2b3eef00-f326-c1e6-0e4b-b7602646eec4@redhat.com>
	<20180605092159.GA2544@work-vm>
	<46ef4200-eccf-7e65-d3a0-69e4a7414b51@redhat.com>
	<20180606111406.GD2660@work-vm>
	<9e8b49fb-0162-bf35-21bb-acc0dc28555f@redhat.com>
	<20180606120050.GB2661@work-vm>
	<61a301dd-8e50-8799-8328-341d6ab744f5@redhat.com>
	<20180606143134.GG2660@work-vm>
	<39bcee27-329a-61d8-47fa-678b431b0a79@redhat.com>
	<20180606150507.GJ2660@work-vm>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <50e0280a-9885-f91c-4820-257dc2b65d8f@redhat.com>
Date: Wed, 6 Jun 2018 19:49:42 +0200
MIME-Version: 1.0
In-Reply-To: <20180606150507.GJ2660@work-vm>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mIgg0TCGKoHMPU8Om6uFTaHkF0f42RcoQ"
Subject: Re: [Qemu-devel] storing machine data in qcow images?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, armbru@redhat.com, qemu-devel@nongnu.org, "Richard W.M. Jones" <rjones@redhat.com>, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mIgg0TCGKoHMPU8Om6uFTaHkF0f42RcoQ
From: Max Reitz <mreitz@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, armbru@redhat.com,
 qemu-devel@nongnu.org, "Richard W.M. Jones" <rjones@redhat.com>,
 stefanha@redhat.com
Message-ID: <50e0280a-9885-f91c-4820-257dc2b65d8f@redhat.com>
Subject: Re: [Qemu-devel] storing machine data in qcow images?
References: <20180529064415.GA4756@localhost.localdomain>
 <2b3eef00-f326-c1e6-0e4b-b7602646eec4@redhat.com>
 <20180605092159.GA2544@work-vm>
 <46ef4200-eccf-7e65-d3a0-69e4a7414b51@redhat.com>
 <20180606111406.GD2660@work-vm>
 <9e8b49fb-0162-bf35-21bb-acc0dc28555f@redhat.com>
 <20180606120050.GB2661@work-vm>
 <61a301dd-8e50-8799-8328-341d6ab744f5@redhat.com>
 <20180606143134.GG2660@work-vm>
 <39bcee27-329a-61d8-47fa-678b431b0a79@redhat.com>
 <20180606150507.GJ2660@work-vm>
In-Reply-To: <20180606150507.GJ2660@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-06-06 17:05, Dr. David Alan Gilbert wrote:
> * Max Reitz (mreitz@redhat.com) wrote:
>> On 2018-06-06 16:31, Dr. David Alan Gilbert wrote:
>>> * Max Reitz (mreitz@redhat.com) wrote:
>>>> On 2018-06-06 14:00, Dr. David Alan Gilbert wrote:
>>>>> * Max Reitz (mreitz@redhat.com) wrote:
>>>>>> On 2018-06-06 13:14, Dr. David Alan Gilbert wrote:
>>>>>>> * Max Reitz (mreitz@redhat.com) wrote:
>>>>>>>> On 2018-06-05 11:21, Dr. David Alan Gilbert wrote:
>>>>>>>>> <reawakening a fizzled out thread>
>>>
>>> <snip>
>>>
>>>>>>> The problem with having a separate file is that you either have t=
o copy
>>>>>>> it around with the image=20
>>>>>>
>>>>>> Which is just an inconvenience.
>>>>>
>>>>> It's more than that;  if it's a separate file then the tools can't
>>>>> rely on users supplying it, and frankly they won't and they'll stil=
l
>>>>> just supply an image.
>>>>
>>>> At which point you throw an error and tell them to specify the confi=
g file.
>>>
>>> No:
>>>    a) At the moment they get away with it for images since they're al=
l
>>>       'pc' and the management layers do the right thing.
>>
>> So so far nobody has complained?  I don't really see the problem then.=

>>
>> If deploying a disk and using all the defaults works out for users,
>> great.  If they want more options, apparently they already know they
>> have to provide some config.
>=20
> This problem all came about because of q35.  We can't change defaults t=
o
> use q35 because importing existing images might break so we need to
> start flagging stuff as q35 - all we're trying to do is make stuff no
> more broken than today.

Well, I really don't want to go into this much further.  I understand
that you see it as a bug prevention.  But as I've said, we've always had
this issue, e.g. with minimum RAM required.  It's nothing new.

But the most important thing is that other people seem to really
disagree on your "I don't want it to get an appliance" stance.

>>>    b) They'll give the wrong config file - then you'd need to add a f=
lag
>>>      to detect that - which means you'd need to add something to the
>>>      qcow to match it to the config; loop back to teh start!
>>
>> I'm not sure how seriously I should take this argument.  Do stupid
>> things, win stupid prizes.
>>
>> If that's the issue, add a UUID to qcow2 files and reference it from t=
he
>> config file.
>=20
> Is a UUID a small string :-)

Well, it certainly isn't unheard of for disk image formats, so I'm much
more inclined to include it.

Though UUIDs tend to be nasty to handle, but as long as they don't
change...  Oh well.

>>> We should make this EASY for users.
>>
>> To me, having a simple config file they can edit manually certainly
>> seems simpler than having to use specific tools to edit it inside of t=
he
>> qcow2 file.
>=20
> The users never touch the tools; they click and import the VM image.

Not really, no.  I know these are the end users, but others (the
providers) probably do want to edit the config file.

[...]

>>>>>>>                                                 Storing a simple =
bit
>>>>>>> of data with the image avoids that.
>>>>>>
>>>>>> It is not a simple bit of data, as evidenced by the discussion abo=
ut
>>>>>> storing binary blobs and MIME types going on.
>>>>>
>>>>> All of the things they've suggested can be done inside that one blo=
b;
>>>>> even inside the json (or any other structure in that blob).
>>>>
>>>> Right, from qcow2's perspective it's a blob of data.  But you can pu=
t a
>>>> whole filesystem into a blob of data, and I get the impression that =
this
>>>> is what some are trying to do.
>>>>
>>>> Once we store larger amounts of binary data in that blob (which is w=
hat
>>>> I'm fearing from comments on MIME types and PNG images), people will=

>>>> realize that always having to re-store the whole blob if you modify
>>>> something in the middle is inefficient and that it needs to be
>>>> optimized.  I don't think you want to do that, but we haven't
>>>> implemented any of this yet and people are already asking for such
>>>> binary data inside of the blob.
>>>>
>>>> I suspect it'll only get worse over time.
>>>> I think the most difficult thing about this discussion is that there=
 are
>>>> different targets.
>>>>
>>>> You just want to store a bit of information.  OK, good, but then I'd=
 say
>>>> we could even just prepend that to the image file in a small header.=

>>>
>>>
>>> I think you're over-reading what people are asking for.
>>> I think the PNG suggestion is again the 'label on the front' for a lo=
go.
>>
>> Which is OK if you store like everything, but very much over the top f=
or
>> your suggestion.  Again, different people want different things and I
>> feel like that is the real discussion we should be having right now an=
d
>> not necessarily where to store it.
>>
>> Because I think (maybe I'm wrong, though) where to store it heavily
>> depends on what we want to store and how we want to use it.
>>
>>> I've not seen anything that's not for either:
>>>   a) The user to know what the image is
>>
>> I thought the use case was they just downloaded it.
>=20
> Or pulled it from that big directory of images.

I don't know what to say.

Maybe this: I do not believe you can convince me that this is a
reasonable use case.  Please do not make me fix the problems people get
because they cannot identify their own files.

>> Otherwise, they should manage their filenames reasonably, come on.
>> Seriously, adding a cute picture because users are too stupid to manag=
e
>> their VMs is *not* qcow2's problem.
>=20
> Well, it's someones problem; we already have magic to display those
> images in some of the higher level tools.

Sure.  virt-manager gives me cute pictures for my VMs, and I'm grateful
for that.  (Actually just cute names, but you know.)

But I absolutely do not see this as a qcow2-level issue.  It might be an
appliance-level issue, though.

>>>   b) The management layer to know what type of VM to create
>>
>> Apparently this is really what you want.  I really still don't see the=

>> difficulty in supplying a config file (or the danger in not doing so, =
or
>> in supplying the wrong one), but, hey, it would be a nice feature inde=
ed.
>>
>> (I just don't like the tradeoff in complexity.)
>=20
> Remember, give this to someone who doesn't understand what the
> difference is between the machine types etc.

But you don't tell them "Configure this machine type".  There are two
download links.  One says "Disk image".  The other says "VM config
file".  The description says to download both and to import the VM
config file into their management application, which will then proceed
to ask for the disk image (automatically, perchance!), and that's it.
No understanding required.

[...]

>>>> And really, I still believe in my slippery slope argument, which mea=
ns
>>>> that even if you just want to innocently store a machine type, we wi=
ll
>>>> end up with something vastly more complex in the end.
>>>>
>>>> Finally, it appears to me that you have a simple problem, found one
>>>> possible solution, and now you just focus on that solution instead o=
f
>>>> taking a step back and looking at the problem again.
>>>>
>>>> The problem: You want to store a binary blob and a disk image togeth=
er.
>>>>
>>>> Your solution: qcow2 has refcounting and thus "occupation bits".  Yo=
u
>>>> can put data into it and it will leave it alone, as long as that are=
a is
>>>> marked as occupied.  Let's put the data into the qcow2 file.
>>>>
>>>> OK, let's look at the problem and its constraints again.
>>>>
>>>> Hard constraint: Store a single file.
>>>> (I don't think this is a hard constraint, because I haven't been
>>>> convinced yet that handling more than a single file is so bad.)
>>>
>>> See above; I think it is.
>>
>> I know, but you haven't convinced me yet. :-)
>>
>>> My other hard contraint is that no tool has to change unless
>>> it wants to make use of the new data.
>>
>> Sure that it isn't a soft constraint?  If most tools can stay unchange=
d
>> but some very specific ones have to be changed, that seems reasonable =
to me.
>=20
> The hard constraint is the normal path stays unchanged; we can change
> the tools to make use of the extra data, but not change what's out
> there.

Ah, right, because you want the data to be visible in previously legacy
VMs, too.  I see.  Though I'd argue that legacy VMs are already covered
by a management application which can store all of that information
somewhere else.  Managing multiple files is easy for a management
application and never visible to the user.  Exporting and importing VMs
is the point at which it would get visible, but I'd think that is just a
temporary state (before the VM is imported into the user's management
application, at which point that target application can just create its
own configuration file again).

>>>> Soft constraint: Max doesn't like storing blobs in qcow2.
>>>>
>>>> So one solution is to ignore the soft constraint.  OK, valid solutio=
n, I
>>>> give you that.  But it doesn't leave me content, probably understand=
ably so.
>>
>> [...]
>>
>>>> But really, if you create a VM, you need a configuration.  Like if y=
ou
>>>> set up a new computer, you need to know what you want.  Usually ther=
e is
>>>> no sticky label, but you just have to know and input it manually.  M=
aybe
>>>> you have a sheet of paper, which I'd call the configuration file.
>>>
>>> Most things are figurable-out by the management tools/defaults or
>>> are dependent on the whim of the user - we're only trying to stop the=

>>> user doing things that wont work.
>>
>> But what's so bad about an empty screen because the user hasn't read t=
he
>> download description?
>=20
> Because it's got to be EASY for the customer; seriously - stop punishin=
g
> the user for not noticing something.
> We've got to help the users, if not we get people asking why their VM
> system has given them a black screen, or why the image they just
> downloaded didn't work - it's basic user friendliness.

Again, to me that user friendliness would be provided by not telling
people to download disk images, but by telling them to download
configuration files, which get imported as a VM, at which point the
application asks for the disk image.

> It's not obvious why it's failed; if it was as simple as a nice box
> popping up telling them they'd booted it wouldn't be too bad; but some
> of them will waste 3 hours trying to figure out wth happened.

If they imported the config file instead of the disk first, they'd get
the box.

> *seriously* think about our users.

The thing is that the only report I've heard about something like this
is from myself.  I always had issue with remembering to pump up the
minimum amount of RAM required to boot a Linux image.

But I do realize that if the download page not only offered a raw disk
image, but a qemu config file with it, I would have used it.

>>> Simpler example; what stops you trying to put the PPC qcow image into=

>>> your x86 VM system - nothing that I know of.  I just want to stop the=

>>> users shooting themselves in the foot.
>>
>> They haven't shot themselves in the foot, they've just wasted a bit of=

>> their time, which could've been avoided by reading before clicking.
>=20
> *seriously* think about our users.

I do and I realize that setting the machine type is not sufficient.
What you are now asking for is an appliance.

I don't like to repeat myself again and again, but I do still think an
appliance would be nice to have.  *But*:

I do not think qemu is the right place to manage it, though I may be
wrong.  Also, you do not want it to make an appliance.

And most importantly, if we want appliances, we have to think seriously
about it and not just handwave it as "Max doesn't want a tiny bit of
data in a qcow2 file, what a party spoiler.  Let's just force him or
make someone else add support and start some random thing, because we
gotta start somewhere, right?"

I do not get that impression from you, I should say.  I do get the
impression that you think more seriously about this than I do, but I
also believe that you should gather what everybody wants instead of just
arguing with me that it needs to be in qcow2.

I do not believe that I have any authority on what configuration options
we need to store whatsoever.  I can only give hunches there and what I'd
find useful.

But I do believe that I have some authority over what makes sense in
qcow2 and what doesn't.  So if you get a consensus on what to store (and
there is no consensus on that whatsoever), you can indeed make me add
support in qcow2, because I believe at that point there will be very
good arguments for adding such support.

So as long as we are in this thread which bears a "qcow" in its subject,
I will respond and say "no".

>>>>>>>>> --------------------------------------------------------------
>>>>>>>>>   =20
>>>>>>>>>
>>>>>>>>> Some reasoning:
>>>>>>>>>    a) I've avoided the problem of when QEMU interprets the valu=
e
>>>>>>>>>       by ignoring it and giving it to management layers at the =
point
>>>>>>>>>       of VM import.
>>>>>>>>
>>>>>>>> Yes, but in the process you've made it completely opaque to qemu=
,
>>>>>>>> basically, which doesn't really make it better for me.  Not that=

>>>>>>>> qemu-specific information in qcow2 files would be what I want, b=
ut, well.
>>>>>>>>
>>>>>>>> But it does solve technical issues, I concede that.
>>>>>>>>
>>>>>>>>>    b) I hate JSON, but there again nailing down a fixed format
>>>>>>>>>       seems easiest and it makes the job of QCOW easy - a singl=
e
>>>>>>>>>       string.
>>>>>>>>
>>>>>>>> Not really.  The string can be rather long, so you probably don'=
t want
>>>>>>>> to store it in the image header, and thus it's just a binary blo=
b from
>>>>>>>> qcow2's perspective, essentially.
>>>>>>>
>>>>>>> Yes, but it's a single blob - I'm not asking for multiple keyed b=
lobs
>>>>>>> or the ability to update individual blobs; just one blob that I c=
an
>>>>>>> replace.
>>>>>>
>>>>>> OK, you aren't, but others seem to be.
>>>>>>
>>>>>> Or, well, you call it a single blob.  But actually the current ide=
as
>>>>>> seem to be to store a rather large configuration tree with binary =
data
>>>>>> in that blob, so to me personally there is absolutely no functiona=
l
>>>>>> difference to just storing a tar file in that blob.
>>>>>>
>>>>>> So correct me if I'm wrong, but to me it appears that you effectiv=
ely
>>>>>> want to store a filesystem in qcow2.[1]  Well, that's better than =
making
>>>>>> qcow2 the filesystem, but it still appears just the wrong way arou=
nd to me.
>>>>>
>>>>> It's different in the sense that what we end up with is still a qco=
w2;
>>>>> anything that just handles qcow2's and can pass them through doesn'=
t
>>>>> need to do anything different; users don't need to do anything
>>>>> different.  No one has to pack/unpack the file.
>>>>
>>>> Packing/unpacking is a strawman because I'm doing my best to give
>>>> proposals that completely avoid that.
>>>>
>>>> Users do need to do something different, because users do need to
>>>> realize that today there is no way to store VM configuration and dis=
k
>>>> data in a single file.  So if they already start VMs just based on a=

>>>> disk, then they are assuming behavior we do not have and that I'd ca=
ll
>>>> naive.  But that is a strawman from my side, sorry.  Keeping naive u=
sers
>>>> happy is probably OK.
>>>
>>> Remember this all works fine now and has done for many years;
>>> it's the addition of q35 that breaks that assumption.
>>> The users can already blidly pick up the qcow2 image and stuff it in
>>
>> Which probably was blind luck already.  And if it wasn't, that means
>> they knew the defaults are what they want.  So now they'd know they
>> aren't and they have to offer a config file along with the disk image.=

>=20
> No, it's not blind look; it's that the management tools know how to get=

> it right.

Good!  I mean it.

>>> and it all works; all I want is for that to keep working.
>>
>> And all I say is that it's not unreasonable to expect users to realize=

>> that a VM is more than a disk image, just like a computer is more than=
 a
>> disk drive; and that handling two files really is not the end of the w=
orld.
>>
>> (And neither is wasting someone's time because they can't read.)
>=20
>=20
> *seriously* think about our users.

You haven't yet told me why expecting users to download two files
instead of one is so bad.  You just say they won't.

OK, so I'd say the VM config is more important.  That should be
displayed prominently and users should download that first, and that
would be nice because we could trivially emit errors when users forget
to download the disk images with them.

But you say that we unfortunately have reached a point where everyone
already uses disk images and nobody uses config files, so training
people to do something else is going to be practically impossible.

I can see your point, but I don't like that you accuse me of hating
users when I'm just saying that they've been doing it wrong.

Also, blackmail doesn't work.  As long as there is no consensus on what
to store, I don't like being told "but it's so easy" and "it will help a
great deal, you just hate our users".


Also, you were saying "shoot themselves in the foot".  To me that meant
they could seriously break something while that was apparently not the
case.  It just meant that they wasted some time, which yes, is bad
enough (not least because time is money), but it's not the end of the
world.  That is what I meant by everything you replied to "think about
our users".

>> Firstly, I agree it's a nice thing to have, but it's not worth it if w=
e
>> don't come up with clear rules on how to prevent developing a full
>> appliance format.
>>
>> Or maybe we want that (because I still believe that you can always com=
e
>> up with obscure options without which the VM won't boot in your specif=
ic
>> case), but then this is beyond just storing a tiny bit of data in a
>> qcow2 image.
>=20
> I don't want to protect them from really trying to shoot themselves in
> the foot; I just want to make sure the easy-path works.  Download an
> image, tell the tool to import; VM works. All good.

OK, good, that is a good use case that I understand.  I have exactly two
issues with it:

(1) I am not sure how far the easy path goes.  Ultimately, it does mean
an appliance to which in principle I am not opposed.

But there are many open questions for which there just is no consensus
yet.  What application is that appliance for? (qemu? libvirt? Some other
management application?)  Do we actually want a full-blown appliance?
Do we really want just qcow2 for appliances?

Before these questions are answered in a consensus, there is just no
reason to discuss what the best kind of representation is.

(2) And after this is answered, someone has to decide for themselves
that they think working on this is important enough.


I do assume that once we (or you, because I do not have real authority
there) have a consensus on (1), I believe that it will be evident
whether we need qcow2 support, or more generally, what kind of qemu
block layer support is required.  I just ask of you not to assume you'll
need qcow2 support beforehand.

Once you know you need qcow2 support for very specific reasons and for a
rather specific use case, we can continue the qcow2-specific part.  If
you have good reasons and a specific use case that multiple people agree
on, I will not oppose it and if I have the time, I can implement it
myself, if you need me to.


But the current hand-waving where everyone I'm talking with wants
something else (and nobody but you seems really clear about what they
want specifically) really does not make me want to add or back support no=
w.

[...]

>>>>>> I'm not talking about unpacking.  I'm talking about a potentially =
new
>>>>>> format which allows accessing the qcow2 file in-place.  It would
>>>>>> probably be trivial to write a block driver to allow this.
>>>>>>
>>>>>> (And as I wrote in my response to Michal, I suspect that tar could=

>>>>>> actually allow this, even though it would probably not be the idea=
l format.)
>>>>>
>>>>> As above, I don't think this is trivial; you have to change all the=

>>>>> layers;  lets say it was a tar; you'd have to somehow know that you=
're
>>>>> importing one of these special tars,
>>>>
>>>> Which is trivial because it's just "Hey, look, it's a tar with that
>>>> description file".
>>>
>>> Trivial? It's taking 100+ mails to add a tag to a qcow2 file! Can you=

>>> imagine what it takes to change libvirt, openstack, ovirt and the res=
t?
>>
>> :-)
>>
>> The implementation is trivial is what I meant, just like the
>> implementation would be rather simple for qcow2 to store a binary blob=

>> and completely ignore it.
>=20
> But then you'd have people shipping .newformat files as well as qcow2
> files and you'd have to persuade people to start doing that, and they'd=

> ship both or none or....

Hm.  Reasonable point.

I mean, I'd say it's not so hard, for multiple reasons.

First, I'd say that our users can figure it out.  But you don't think
they can figure out downloading two files (which may be right!  I can
understand that people can't know everything about every single tool
they use, and that it really is unreasonable to ask that of them,
although I do believe that people can intuitively know that a VM needs a
config file, which is why I'm still not of your exact opinion).  So if
they don't "want" to download two files, it is going to be difficult to
make them provide the new format.

Secondly, as far as I have understood you (and I mean you and not e.g.
Michael), you are mainly worried about the management layer.  I would
assume that the management layer could give users a specific way of
exporting VMs which makes things simpler than them having to find the
disk image themselves.  This would make exporting in the new format
trivial, because they'd do that automatically.

(This exporting process might allow exporting just the disk image, while
emitting a warning that this does not include VM configuration options.)

Max


--mIgg0TCGKoHMPU8Om6uFTaHkF0f42RcoQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsYHrYACgkQ9AfbAGHV
z0CEJgf+OZIaglMnaOlOCWP92NBRsc9INnFZZJNsCUHHReGd0h9FOYxnHWgJpa3C
/4cIi4gOYEMVsZ1vxyTNr5tEO+mW2Yp7FtDyHebemViqPztHUHniTYjDKgT8bzT4
mYG2yevee/S7mE0SPNxSeDna/G7kMrxwxhjNi7B0phDfXgRu+sZBGBcK+isHvYpm
9Zs5zlWdOP79q/6vDt3mQddQ1wyGxQTL46wfPPlwpsbUdVJ073nOQey17k87t9jM
v1+7AfZIMcagWeE1pw1CCWrjkVyhR2gL6esBd7WBXIIH60PXBLgwDOKt6+V9IeP9
TFFA+dwSdrPPYdgh7CHs05JRMhBDGQ==
=ElFg
-----END PGP SIGNATURE-----

--mIgg0TCGKoHMPU8Om6uFTaHkF0f42RcoQ--
