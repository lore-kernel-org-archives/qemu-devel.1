Received: from eggs.gnu.org ([2001:4830:134:3::10]:49266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fQZV3-0002GQ-M7
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 10:33:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fQZV1-0002Ko-Q3
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 10:33:21 -0400
References: <20180529064415.GA4756@localhost.localdomain>
	<2b3eef00-f326-c1e6-0e4b-b7602646eec4@redhat.com>
	<20180606123237.2235ae4a@kitsune.suse.cz>
	<bc97cdc3-85ba-e053-0816-b6bc431064fb@redhat.com>
	<20180606131929.44d0fd6b@kitsune.suse.cz>
	<93233bff-604b-c891-90ce-64fe1eaaaab5@redhat.com>
	<20180606113720.GA2661@work-vm>
	<2c833e2c-f0bb-ea98-a703-54fb9447bd2f@redhat.com>
	<20180606121624.GD2661@work-vm>
	<2d572c2f-8dda-87db-ec26-6f2230375424@redhat.com>
	<20180606140233.GF2660@work-vm>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <66366ae1-1db8-7121-bfcc-f2096d0c954f@redhat.com>
Date: Wed, 6 Jun 2018 16:33:03 +0200
MIME-Version: 1.0
In-Reply-To: <20180606140233.GF2660@work-vm>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="gLfVTqEavfXD9R2cNcTLZUAbLrCJ5ApzH"
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
Cc: Kevin Wolf <kwolf@redhat.com>, ehabkost@redhat.com, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, qemu-devel@nongnu.org, stefanha@redhat.com, =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gLfVTqEavfXD9R2cNcTLZUAbLrCJ5ApzH
From: Max Reitz <mreitz@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, ehabkost@redhat.com,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 "Richard W.M. Jones" <rjones@redhat.com>, qemu-devel@nongnu.org,
 stefanha@redhat.com, =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>
Message-ID: <66366ae1-1db8-7121-bfcc-f2096d0c954f@redhat.com>
Subject: Re: [Qemu-devel] storing machine data in qcow images?
References: <20180529064415.GA4756@localhost.localdomain>
 <2b3eef00-f326-c1e6-0e4b-b7602646eec4@redhat.com>
 <20180606123237.2235ae4a@kitsune.suse.cz>
 <bc97cdc3-85ba-e053-0816-b6bc431064fb@redhat.com>
 <20180606131929.44d0fd6b@kitsune.suse.cz>
 <93233bff-604b-c891-90ce-64fe1eaaaab5@redhat.com>
 <20180606113720.GA2661@work-vm>
 <2c833e2c-f0bb-ea98-a703-54fb9447bd2f@redhat.com>
 <20180606121624.GD2661@work-vm>
 <2d572c2f-8dda-87db-ec26-6f2230375424@redhat.com>
 <20180606140233.GF2660@work-vm>
In-Reply-To: <20180606140233.GF2660@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-06-06 16:02, Dr. David Alan Gilbert wrote:
> * Max Reitz (mreitz@redhat.com) wrote:
>> On 2018-06-06 14:16, Dr. David Alan Gilbert wrote:
>>> * Max Reitz (mreitz@redhat.com) wrote:
>>>> On 2018-06-06 13:37, Dr. David Alan Gilbert wrote:
>>>>> * Max Reitz (mreitz@redhat.com) wrote:
>>>>>> On 2018-06-06 13:19, Michal Such=C3=A1nek wrote:
>>>>>>> On Wed, 6 Jun 2018 13:02:53 +0200
>>>>>>> Max Reitz <mreitz@redhat.com> wrote:
>>>>>>>
>>>>>>>> On 2018-06-06 12:32, Michal Such=C3=A1nek wrote:
>>>>>>>>> On Tue, 29 May 2018 12:14:15 +0200
>>>>>>>>> Max Reitz <mreitz@redhat.com> wrote:
>>>>
>>>> [...]
>>>>
>>>>>>>>>> Unless I have got something terribly wrong (which is indeed a
>>>>>>>>>> possibility!), to me this proposal means basically to turn qco=
w2
>>>>>>>>>> into (1) a VM description format for qemu, and (2) to turn it =
into
>>>>>>>>>> an archive format on the way. =20
>>>>>>>>>
>>>>>>>>> And if you go all the way you can store multiple disks along wi=
th
>>>>>>>>> the VM definition so you can have the whole appliance in one fi=
le.
>>>>>>>>> It conveniently solves the problem of synchronizing snapshots a=
cross
>>>>>>>>> multiple disk images and the question where to store the machin=
e
>>>>>>>>> state if you want to suspend it.  =20
>>>>>>>>
>>>>>>>> Yeah, but why make qcow2 that format?  That's what I completely =
fail
>>>>>>>> to understand.
>>>>>>>>
>>>>>>>> If you want to have a single VM description file that contains t=
he VM
>>>>>>>> configuration and some qcow2/raw/whatever files along with it fo=
r the
>>>>>>>> guest disk data, sure, go ahead.  But why does the format of the=
 whole
>>>>>>>> thing need to be qcow2?
>>>>>>>
>>>>>>> Because then qemu can access the disk data from the image directl=
y
>>>>>>> without any need for extraction, copying to different file, etc.
>>>>>>
>>>>>> This does not explain why it needs to be qcow2.  There is absolute=
ly no
>>>>>> reason why you couldn't use qcow2 files in-place inside of another=
 file.
>>>>>
>>>>> Because then we'd have to change the whole stack to take advantage =
of
>>>>> that.  Adding a feature into qcow2 means nothing else changes.
>>>>
>>>> Because it's a hack, right.  Storing binary data in a qcow2 file,
>>>> completely ignoring it in qemu (and being completely unusable to any=

>>>> potential other users of the qcow2 format[1]) and only interpreting =
it
>>>> somewhere up the stack is a hack.
>>>
>>> It's not a hack!
>>> Seriously it's not.
>>> There's nothing wrong with it being aimed higher up the stack than qe=
mu,
>>
>> Not really, but storing that information in a disk image file is, from=

>> my perspective.  So far, qcow2 was always just for qemu.  (Hmm...  May=
be
>> backing links weren't, but at least they were intended for qemu origin=
ally.)
>>
>> So this would mix information for different layers inside qcow2 which =
to
>> me sounds weird.  Maybe I just have to get used to it.
>=20
> The important point is it's explicitly for a different layer; we're not=

> mixing it - the guest can never get to this information.

Neither can it get to bitmaps, but bitmaps are still for qemu.

>                                                           It also saves=

> the higher level management layers ever having to look at the data the
> guest can get to, which is a security advantage.

Er, well, yes, but guessing configuration options from the guest disk
contents is definitely a bad idea, I agree on that anyway.

> From my point of view, it really is the sticky label on the disc rather=

> than the contents of it.

Sure, which is why I wouldn't put it in qcow2.  Content and meta-content
is what qcow2 currently stores, but not how to use it.

>>> the problem we started off with was what happens when a user download=
s
>>> a VM image and tries to import it into their VM system;
>>
>> Well, the VM system should choke without a config file. O:-)
>>
>>>                                                         weve already
>>> got 2+ layers of management stuff in there - I want the information t=
o
>>> guide those layers, not form a complete set of configuration.
>>
>> But I do.
>>
>> If we store some information, I don't see why we don't store all of it=
=2E
>=20
> Hmm, now that generally I don't like:

Me neither.

>   a) That really would make it hypervisor specific

Yes.

>   b) It would be a lot of data

Yes.

>   c) Generally, the supplier of an image doesn't know how the end-user
>      wants it configured - although for some appliances they might.

Well, yes.  But just storing very basic information limits the use case
to a very basic case anyway, doesn't it?  So this wouldn't be worse.

Everything beyond a very basic use case can expect the user to take 30
seconds to download and pass a config file.

>   d) Remember the only problem we had when we got here was how to stop
>      the user shooting themselves in the foot by connecting the wrong
>      image to the wrong VM type.

Hm.  How exactly is that shooting yourself in the foot?  Won't it just
not work?

>                                   So I'm expecting to use this to
>      contain requirements, nothing more.

I assumed you'd want to relieve users of having to specify config
options in basic use cases.  This is why I believed it would be natural
to expand that scope.

So why is it so dangerous to connect a disk you just downloaded to e.g.
the wrong machine type?  I assumed it just wouldn't work and you'd try
again, until you realized that maybe you should read the download
description and do as it says ("download this config file, pass it").

>>>> That is not necessarily a negative point, hacks can work wonderfully=

>>>> well, and they usually are simple, that is correct.  But the thing i=
s
>>>> that I feel like people have grand visions of what to get out of thi=
s.
>>>> Imagine, a single file that can configure all and any VM!
>>>>
>>>> But hacks usually only solve a single issue.  Once you try to extend=
 a
>>>> hack, it breaks down and becomes insufficient.
>>>>
>>>> If we want a grand vision where a single file stores the whole VM, w=
hy
>>>> not invest the work and make it right from the start?
>>>
>>> Because we won't get it right; however much we bikeshed about it
>>> we'll just end up with a mess.
>>
>> Sure, but the same thing applies to putting it into qcow2.  The
>> difference is, for something outside of qcow2, throwing it away and
>> starting over is simple.
>>
>> When putting it into qcow2, we can only do that if we really just put =
a
>> binary blob there that isn't described in the specification.
>=20
> Well, it's why I'm going for defined key/values that are stored in the
> blob and only a few of them.  We've got a reasonable chance of being
> able to define what we want from 3-4 key/values, it should be a lot
> easier than trying to define a grand scheme.

Yes, as long as we can agree on how we can justify to future generations
why we really only want these very few very specific values.

>>>                                  The right thing is to put in somethi=
ng
>>> to hold configuration and then review the items of configuration we
>>> add properly as we define them.
>>
>> OK, but review them on what terms?  Whether they are simple enough?
>=20
> Well, I'll take simple, make sense - whatever - feel free to be the
> maintainer for that list!

OK, none. :-P

It would need to be a very strict requirement, in any case.  Just
"simple" or "dense" do not suffice, because those can be stretched.

>> As I said, I would want a whole configuration if we allow some
>> configuration.
>=20
> Well then you could go for libvirt XML as the contents; but I think
> that's crossing layers even more.
> (I would have veered more to it being exactly the same as an OVA
> description except for rjones dislike of it)

Well, the format doesn't really matter for now, I think it's most
important to first talk about what kind of scope we want.

>> (More below)
>>
>>>> [1] Yes, I concede that there are probably no other users of qcow2. =
 But
>>>> please forgive me for assuming that qcow2 was in a sense designed to=
 be
>>>> a rather general image format that not only qemu could use.
>>>
>>> What makes it QEMU specific?  It's basically just the same key/value
>>> setup as OVA, except putting them inside the qcow2.
>>
>> Well, not necessarily qemu-specific, but
>> ${management_software}-specific, which comes down to the same.  Or,
>> well, I'd think that, but hold on.
>>
>>> We could use the same keys/value definitions as OVA in the blob,
>>> although their definitions aren't very portable either.
>>
>> So you're proposing that we only add options that seem portable for an=
y VM?
>=20
> Hmm.  We should probably split them, so there should be general options=

> (e.g. minimum-ram) but also hypervisor specifics
> (qemu.machine-class=3Dq35); but that doesn't mean you can't add keys
> for multiple hypervisors into the one blob.  I mean
> something like:
>     minimum-ram =3D 1G
>     qemu.machine-class =3D q35
>     anothervm.machine-class =3D ....

Well, and that's my issue.  Once you have application-specific info, you
can go wild.  And I would go wild, without a reasonable and strict
requirement that the information we want to store has to fulfill.

For the record, I would've liked it if you'd said "only portable
options".  But I would have replied that I would fear we'd still end up
with someone saying "I'd like to store X and Y, let's just put them into
the specification, then they are portable [even if only this stack
supports them]" and we wouldn't really have won anything.

Max


--gLfVTqEavfXD9R2cNcTLZUAbLrCJ5ApzH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsX8J8ACgkQ9AfbAGHV
z0DJHQf/TC6R42JhVKZVR+oNti6vYt6eWvDcnsI7YlbKsAhaiNAG8B8yO/2+5gEU
DKEDpO3nOCeFgCh/t/6SegoYFyNUH6n3deAt58/tkeuO87cu3coUpswVMz151fYr
zFs+UT6YWxBQ0Wcepu+2IUGwsrUzaCcYM4hdpX+HictTEWthVEPYvaXd3wYh8MFM
JNzGHXLdOWL6bDu4wKVSLNrkzlfRSU4lVB40uC1dT0ssH1rdX/mv6tNOKPQekvn4
r7Hwp81nvhA587JL4N7VQlinWsQvEuR5HibMYK/cd3xnl0s0q3y7JL//+aeQMXMx
kD+Kfj88jtPZ2U9yCFfrzSDgc4gP8Q==
=OZNY
-----END PGP SIGNATURE-----

--gLfVTqEavfXD9R2cNcTLZUAbLrCJ5ApzH--
