Received: from eggs.gnu.org ([2001:4830:134:3::10]:57446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fQZn3-0007ud-Qm
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 10:52:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fQZn1-0003ch-Is
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 10:51:57 -0400
References: <20180528212054.GH2209@redhat.com>
	<20180528212510.GC4660@redhat.com>
	<20180529064415.GA4756@localhost.localdomain>
	<2b3eef00-f326-c1e6-0e4b-b7602646eec4@redhat.com>
	<20180605092159.GA2544@work-vm>
	<46ef4200-eccf-7e65-d3a0-69e4a7414b51@redhat.com>
	<20180606111406.GD2660@work-vm>
	<9e8b49fb-0162-bf35-21bb-acc0dc28555f@redhat.com>
	<20180606120050.GB2661@work-vm>
	<61a301dd-8e50-8799-8328-341d6ab744f5@redhat.com>
	<20180606143134.GG2660@work-vm>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <39bcee27-329a-61d8-47fa-678b431b0a79@redhat.com>
Date: Wed, 6 Jun 2018 16:51:39 +0200
MIME-Version: 1.0
In-Reply-To: <20180606143134.GG2660@work-vm>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="zO8lCRSOI2qZ58J5uMobgTZcu22B9lNxj"
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
--zO8lCRSOI2qZ58J5uMobgTZcu22B9lNxj
From: Max Reitz <mreitz@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, armbru@redhat.com,
 qemu-devel@nongnu.org, "Richard W.M. Jones" <rjones@redhat.com>,
 stefanha@redhat.com
Message-ID: <39bcee27-329a-61d8-47fa-678b431b0a79@redhat.com>
Subject: Re: [Qemu-devel] storing machine data in qcow images?
References: <20180528212054.GH2209@redhat.com>
 <20180528212510.GC4660@redhat.com>
 <20180529064415.GA4756@localhost.localdomain>
 <2b3eef00-f326-c1e6-0e4b-b7602646eec4@redhat.com>
 <20180605092159.GA2544@work-vm>
 <46ef4200-eccf-7e65-d3a0-69e4a7414b51@redhat.com>
 <20180606111406.GD2660@work-vm>
 <9e8b49fb-0162-bf35-21bb-acc0dc28555f@redhat.com>
 <20180606120050.GB2661@work-vm>
 <61a301dd-8e50-8799-8328-341d6ab744f5@redhat.com>
 <20180606143134.GG2660@work-vm>
In-Reply-To: <20180606143134.GG2660@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-06-06 16:31, Dr. David Alan Gilbert wrote:
> * Max Reitz (mreitz@redhat.com) wrote:
>> On 2018-06-06 14:00, Dr. David Alan Gilbert wrote:
>>> * Max Reitz (mreitz@redhat.com) wrote:
>>>> On 2018-06-06 13:14, Dr. David Alan Gilbert wrote:
>>>>> * Max Reitz (mreitz@redhat.com) wrote:
>>>>>> On 2018-06-05 11:21, Dr. David Alan Gilbert wrote:
>>>>>>> <reawakening a fizzled out thread>
>=20
> <snip>
>=20
>>>>> The problem with having a separate file is that you either have to =
copy
>>>>> it around with the image=20
>>>>
>>>> Which is just an inconvenience.
>>>
>>> It's more than that;  if it's a separate file then the tools can't
>>> rely on users supplying it, and frankly they won't and they'll still
>>> just supply an image.
>>
>> At which point you throw an error and tell them to specify the config =
file.
>=20
> No:
>    a) At the moment they get away with it for images since they're all
>       'pc' and the management layers do the right thing.

So so far nobody has complained?  I don't really see the problem then.

If deploying a disk and using all the defaults works out for users,
great.  If they want more options, apparently they already know they
have to provide some config.

>    b) They'll give the wrong config file - then you'd need to add a fla=
g
>      to detect that - which means you'd need to add something to the
>      qcow to match it to the config; loop back to teh start!

I'm not sure how seriously I should take this argument.  Do stupid
things, win stupid prizes.

If that's the issue, add a UUID to qcow2 files and reference it from the
config file.

> We should make this EASY for users.

To me, having a simple config file they can edit manually certainly
seems simpler than having to use specific tools to edit it inside of the
qcow2 file.

>>>> I understand it is an inconvenience and it would be nice to change i=
t,
>>>> but please understand that I do not want qcow2 to become a filesyste=
m
>>>> just to relieve an inconvenience.
>>>
>>> I very much don't want it to be a filesystem; my reason for writing
>>> down my spec the way I did was to make it clear that the only
>>> thing I want of qcow2 is a single blob, no more; I don't want naming
>>> of the blob or anything else.
>>>
>>>> (Note: I understand that you may not want qcow2 to become a filesyst=
em,
>>>> but I do get the impression from others.)
>>>
>>> My aim was to specify it to fulfill the requirements that everyone
>>> else had asked for, but still only having one unmodifiable blob in qc=
ow.
>>>
>>>>>                           or have an archive. If you have an archiv=
e
>>>>> you have to have an unpacking step which then copies, potentially a=
 lot
>>>>> of data taking some reasonable amount of time.
>>>>
>>>> I'm sure this can be optimized, but yes, I get that.
>>>>
>>>> (If you use e.g. tar and store the image data starting on an FS clus=
ter
>>>> boundary (64 kB should be more than sufficient), I assume there is a=
 way
>>>> to extract that data into a new file without copying anything.)
>>>
>>> But then we have to modify all the current things that know how to
>>> handle a qcow2.
>>
>> Not in this case because it'd still be a flat qcow2 file in a simple t=
ar
>> archive.
>>
>> But you're right if we had a more complex format (like chunks stored i=
n
>> a tar file).
>=20
> My only problem with using the tar like that is that all tools
> everywhere would need to be updated to be able to parse them.
> (Note if adding a blob to qcow2 like I'm asking for would break existin=
g
> qcow2 users then I don't want it either).

OK, so I suppose this goes back to "let's decide what we really want to
configure first, and how we can limit our scope in an effective and
long-lasting way".

>>>>>                                                 Storing a simple bi=
t
>>>>> of data with the image avoids that.
>>>>
>>>> It is not a simple bit of data, as evidenced by the discussion about=

>>>> storing binary blobs and MIME types going on.
>>>
>>> All of the things they've suggested can be done inside that one blob;=

>>> even inside the json (or any other structure in that blob).
>>
>> Right, from qcow2's perspective it's a blob of data.  But you can put =
a
>> whole filesystem into a blob of data, and I get the impression that th=
is
>> is what some are trying to do.
>>
>> Once we store larger amounts of binary data in that blob (which is wha=
t
>> I'm fearing from comments on MIME types and PNG images), people will
>> realize that always having to re-store the whole blob if you modify
>> something in the middle is inefficient and that it needs to be
>> optimized.  I don't think you want to do that, but we haven't
>> implemented any of this yet and people are already asking for such
>> binary data inside of the blob.
>>
>> I suspect it'll only get worse over time.
>> I think the most difficult thing about this discussion is that there a=
re
>> different targets.
>>
>> You just want to store a bit of information.  OK, good, but then I'd s=
ay
>> we could even just prepend that to the image file in a small header.
>=20
>=20
> I think you're over-reading what people are asking for.
> I think the PNG suggestion is again the 'label on the front' for a logo=
=2E

Which is OK if you store like everything, but very much over the top for
your suggestion.  Again, different people want different things and I
feel like that is the real discussion we should be having right now and
not necessarily where to store it.

Because I think (maybe I'm wrong, though) where to store it heavily
depends on what we want to store and how we want to use it.

> I've not seen anything that's not for either:
>   a) The user to know what the image is

I thought the use case was they just downloaded it.

Otherwise, they should manage their filenames reasonably, come on.
Seriously, adding a cute picture because users are too stupid to manage
their VMs is *not* qcow2's problem.

>   b) The management layer to know what type of VM to create

Apparently this is really what you want.  I really still don't see the
difficulty in supplying a config file (or the danger in not doing so, or
in supplying the wrong one), but, hey, it would be a nice feature indeed.=


(I just don't like the tradeoff in complexity.)

>> (Note that extending that header would not even be too complicated,
>> because you can easily move the qcow2 header somewhere else.  Say you
>> move it back by one cluster (e.g. 64 kB), then you just put the cluste=
r
>> that was there originally to the end of the file, which is pretty much=

>> trivial.  Then you copy that original data there and overwrite it with=

>> the image header.  Done.)
>>
>> Others want to store more binary data.  Then this may get inefficient
>> and insufficient.  But I'd think at this point it gets really
>> problematic to put the data into the qcow2 file because it really
>> doesn't belong there.  (I can't imagine anything that would warrant a
>> MIME type.)
>=20
> No, I can't imagine why anyone wants a MIME type either.
>=20
>> Then I've heard proposals of storing multiple disk images.  Yes, you
>> could store multiple disks inside of a single qcow2 file, but it would=

>> be basically exactly the same as storing just multiple qcow2 files, so=
=2E..
>=20
> No, completely agree.

So, yeah, we need a discussion on what to store first, probably in a new
thread, and maybe one that is not about qcow2 specifically.

>> And really, I still believe in my slippery slope argument, which means=

>> that even if you just want to innocently store a machine type, we will=

>> end up with something vastly more complex in the end.
>>
>> Finally, it appears to me that you have a simple problem, found one
>> possible solution, and now you just focus on that solution instead of
>> taking a step back and looking at the problem again.
>>
>> The problem: You want to store a binary blob and a disk image together=
=2E
>>
>> Your solution: qcow2 has refcounting and thus "occupation bits".  You
>> can put data into it and it will leave it alone, as long as that area =
is
>> marked as occupied.  Let's put the data into the qcow2 file.
>>
>> OK, let's look at the problem and its constraints again.
>>
>> Hard constraint: Store a single file.
>> (I don't think this is a hard constraint, because I haven't been
>> convinced yet that handling more than a single file is so bad.)
>=20
> See above; I think it is.

I know, but you haven't convinced me yet. :-)

> My other hard contraint is that no tool has to change unless
> it wants to make use of the new data.

Sure that it isn't a soft constraint?  If most tools can stay unchanged
but some very specific ones have to be changed, that seems reasonable to =
me.

>> Soft constraint: Max doesn't like storing blobs in qcow2.
>>
>> So one solution is to ignore the soft constraint.  OK, valid solution,=
 I
>> give you that.  But it doesn't leave me content, probably understandab=
ly so.

[...]

>> But really, if you create a VM, you need a configuration.  Like if you=

>> set up a new computer, you need to know what you want.  Usually there =
is
>> no sticky label, but you just have to know and input it manually.  May=
be
>> you have a sheet of paper, which I'd call the configuration file.
>=20
> Most things are figurable-out by the management tools/defaults or
> are dependent on the whim of the user - we're only trying to stop the
> user doing things that wont work.

But what's so bad about an empty screen because the user hasn't read the
download description?

> Simpler example; what stops you trying to put the PPC qcow image into
> your x86 VM system - nothing that I know of.  I just want to stop the
> users shooting themselves in the foot.

They haven't shot themselves in the foot, they've just wasted a bit of
their time, which could've been avoided by reading before clicking.

[...]

>>>>>>> --------------------------------------------------------------
>>>>>>>   =20
>>>>>>>
>>>>>>> Some reasoning:
>>>>>>>    a) I've avoided the problem of when QEMU interprets the value
>>>>>>>       by ignoring it and giving it to management layers at the po=
int
>>>>>>>       of VM import.
>>>>>>
>>>>>> Yes, but in the process you've made it completely opaque to qemu,
>>>>>> basically, which doesn't really make it better for me.  Not that
>>>>>> qemu-specific information in qcow2 files would be what I want, but=
, well.
>>>>>>
>>>>>> But it does solve technical issues, I concede that.
>>>>>>
>>>>>>>    b) I hate JSON, but there again nailing down a fixed format
>>>>>>>       seems easiest and it makes the job of QCOW easy - a single
>>>>>>>       string.
>>>>>>
>>>>>> Not really.  The string can be rather long, so you probably don't =
want
>>>>>> to store it in the image header, and thus it's just a binary blob =
from
>>>>>> qcow2's perspective, essentially.
>>>>>
>>>>> Yes, but it's a single blob - I'm not asking for multiple keyed blo=
bs
>>>>> or the ability to update individual blobs; just one blob that I can=

>>>>> replace.
>>>>
>>>> OK, you aren't, but others seem to be.
>>>>
>>>> Or, well, you call it a single blob.  But actually the current ideas=

>>>> seem to be to store a rather large configuration tree with binary da=
ta
>>>> in that blob, so to me personally there is absolutely no functional
>>>> difference to just storing a tar file in that blob.
>>>>
>>>> So correct me if I'm wrong, but to me it appears that you effectivel=
y
>>>> want to store a filesystem in qcow2.[1]  Well, that's better than ma=
king
>>>> qcow2 the filesystem, but it still appears just the wrong way around=
 to me.
>>>
>>> It's different in the sense that what we end up with is still a qcow2=
;
>>> anything that just handles qcow2's and can pass them through doesn't
>>> need to do anything different; users don't need to do anything
>>> different.  No one has to pack/unpack the file.
>>
>> Packing/unpacking is a strawman because I'm doing my best to give
>> proposals that completely avoid that.
>>
>> Users do need to do something different, because users do need to
>> realize that today there is no way to store VM configuration and disk
>> data in a single file.  So if they already start VMs just based on a
>> disk, then they are assuming behavior we do not have and that I'd call=

>> naive.  But that is a strawman from my side, sorry.  Keeping naive use=
rs
>> happy is probably OK.
>=20
> Remember this all works fine now and has done for many years;
> it's the addition of q35 that breaks that assumption.
> The users can already blidly pick up the qcow2 image and stuff it in

Which probably was blind luck already.  And if it wasn't, that means
they knew the defaults are what they want.  So now they'd know they
aren't and they have to offer a config file along with the disk image.

> and it all works; all I want is for that to keep working.

And all I say is that it's not unreasonable to expect users to realize
that a VM is more than a disk image, just like a computer is more than a
disk drive; and that handling two files really is not the end of the worl=
d.

(And neither is wasting someone's time because they can't read.)

Firstly, I agree it's a nice thing to have, but it's not worth it if we
don't come up with clear rules on how to prevent developing a full
appliance format.

Or maybe we want that (because I still believe that you can always come
up with obscure options without which the VM won't boot in your specific
case), but then this is beyond just storing a tiny bit of data in a
qcow2 image.

[...]

>>>> [1] Yes, I know that the guest disk already contains an FS. :-P
>>>>
>>>>>>>       (I would suggest in layer2 that the keys are sorted, but
>>>>>>>       that's a pain to do in some json creators)
>>>>>>>    c) Forcing the registry of keys might avoid silly duplication.=

>>>>>>>       We can but hope.
>>>>>>>    d) I've not said it's a libvirt XML file since that seems
>>>>>>>       a bit prescriptive.
>>>>>>>
>>>>>>> Some initial suggested keys:
>>>>>>>
>>>>>>>    "qemu.machine-types": [ "q35", "i440fx" ]
>>>>>>>    "qemu.min-ram-MB": 1024
>>>>>>
>>>>>> I still don't understand why you'd want to put the configuration i=
nto
>>>>>> qcow2 instead of the other way around.
>>>>>>
>>>>>> Or why you'd want to use a single file at all, because as this who=
le
>>>>>> thread shows, a disk image alone is clearly not sufficient to desc=
ribe a VM.
>>>>>>
>>>>>> (Or it may be in simple cases, but then that's because you don't n=
eed
>>>>>> any configuration.)
>>>>>
>>>>> Because it avoids the unpacking associated with archives.
>>>>
>>>> I'm not talking about unpacking.  I'm talking about a potentially ne=
w
>>>> format which allows accessing the qcow2 file in-place.  It would
>>>> probably be trivial to write a block driver to allow this.
>>>>
>>>> (And as I wrote in my response to Michal, I suspect that tar could
>>>> actually allow this, even though it would probably not be the ideal =
format.)
>>>
>>> As above, I don't think this is trivial; you have to change all the
>>> layers;  lets say it was a tar; you'd have to somehow know that you'r=
e
>>> importing one of these special tars,
>>
>> Which is trivial because it's just "Hey, look, it's a tar with that
>> description file".
>=20
> Trivial? It's taking 100+ mails to add a tag to a qcow2 file! Can you
> imagine what it takes to change libvirt, openstack, ovirt and the rest?=


:-)

The implementation is trivial is what I meant, just like the
implementation would be rather simple for qcow2 to store a binary blob
and completely ignore it.

>>>                                      you also have to have a tool to
>>> create them;
>>
>> Also trivial.  Non-trivial is modifying them.
>>
>> The workflow would be to create the tar with an empty qcow2 file, the =
VM
>> description you want, and then just using it.
>>
>> Yes, using is more difficult, but it wouldn't be an own tool, it would=

>> be built into qemu.  I can't say how difficult that implementation wou=
ld
>> be, but it would not be trivial, that is correct.
>>
>>>              and you have to worry about whether that alignment
>>> is correct for the storage/memory you're using it with.
>>
>> Which would be difficult with tar, right.  But we don't have to use ta=
r.
>>
>> (And, no, I don't think creating a new container format is not worse f=
or
>> interoperability than adding a blob to qcow2.)
>=20
> If you were going to do this then you'd end up just using OVA.
> You couldn't justify yet another format.

Sure, the exact format doesn't matter to me (or at least currently I
don't think it does...).  I'm more interested in scope and what good it
actually brings.

Max


--zO8lCRSOI2qZ58J5uMobgTZcu22B9lNxj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsX9PsACgkQ9AfbAGHV
z0A6TQf9FMsssiLHgwgbubbhDey3xLFDGg7xU/7vs8P9DxnC6PJvrTJ02TCWZHqC
BGWW/YXaBlBd7R5LfhE53vcowWNPu4YgWEHA3i3ViPJVvDOSETzzXWWJD347FA3W
Ie77uVQlkSLGBEGE9PaUvOhve7verQsm21A1PDsLBLdMaeGxtsOUIUgscBP/Sgr9
v1vY6Jy5sAULNa8wJbBqkgRBtSCgQHWivqzD9WVEeEaXJcfdxZNwFgDS9wY0r3nx
aKuOjxqZ6ZqcA80WVh7VbbXv5V1SnVWRlW1dzcfbDqAenKSTPRMQfDFlKbhOL5MJ
9SdGPWRjyuj29PhYzRDh/6xePGl1+Q==
=9Lq4
-----END PGP SIGNATURE-----

--zO8lCRSOI2qZ58J5uMobgTZcu22B9lNxj--
