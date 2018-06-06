Received: from eggs.gnu.org ([2001:4830:134:3::10]:35942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fQWzi-0006s5-W5
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 07:52:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fQWzh-0004MI-NB
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 07:52:51 -0400
References: <20180518180440-mutt-send-email-mst@kernel.org>
	<20180524113251.GB4660@redhat.com>
	<d9bb2cb9-d9dc-8fe0-a767-10d9cbbab803@redhat.com>
	<20180528183058.GG2209@redhat.com>
	<20180528183833.GJ4580@localhost.localdomain>
	<20180528212054.GH2209@redhat.com> <20180528212510.GC4660@redhat.com>
	<20180529064415.GA4756@localhost.localdomain>
	<2b3eef00-f326-c1e6-0e4b-b7602646eec4@redhat.com>
	<20180606123237.2235ae4a@kitsune.suse.cz>
	<bc97cdc3-85ba-e053-0816-b6bc431064fb@redhat.com>
	<20180606131929.44d0fd6b@kitsune.suse.cz>
	<93233bff-604b-c891-90ce-64fe1eaaaab5@redhat.com>
	<20180606134327.05de9616@kitsune.suse.cz>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <94cea1d9-d934-85d1-66d4-dbfc82b8dd53@redhat.com>
Date: Wed, 6 Jun 2018 13:52:35 +0200
MIME-Version: 1.0
In-Reply-To: <20180606134327.05de9616@kitsune.suse.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1li3T9cWtUcMJpOKIZB6UwPl6bLkrfuKB"
Subject: Re: [Qemu-devel] storing machine data in qcow images?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>
Cc: Kevin Wolf <kwolf@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, qemu-devel@nongnu.org, stefanha@redhat.com, ehabkost@redhat.com, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1li3T9cWtUcMJpOKIZB6UwPl6bLkrfuKB
From: Max Reitz <mreitz@redhat.com>
To: =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>
Cc: Kevin Wolf <kwolf@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>,
 qemu-devel@nongnu.org, stefanha@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <94cea1d9-d934-85d1-66d4-dbfc82b8dd53@redhat.com>
Subject: Re: [Qemu-devel] storing machine data in qcow images?
References: <20180518180440-mutt-send-email-mst@kernel.org>
 <20180524113251.GB4660@redhat.com>
 <d9bb2cb9-d9dc-8fe0-a767-10d9cbbab803@redhat.com>
 <20180528183058.GG2209@redhat.com>
 <20180528183833.GJ4580@localhost.localdomain>
 <20180528212054.GH2209@redhat.com> <20180528212510.GC4660@redhat.com>
 <20180529064415.GA4756@localhost.localdomain>
 <2b3eef00-f326-c1e6-0e4b-b7602646eec4@redhat.com>
 <20180606123237.2235ae4a@kitsune.suse.cz>
 <bc97cdc3-85ba-e053-0816-b6bc431064fb@redhat.com>
 <20180606131929.44d0fd6b@kitsune.suse.cz>
 <93233bff-604b-c891-90ce-64fe1eaaaab5@redhat.com>
 <20180606134327.05de9616@kitsune.suse.cz>
In-Reply-To: <20180606134327.05de9616@kitsune.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-06-06 13:43, Michal Such=C3=A1nek wrote:
> On Wed, 6 Jun 2018 13:32:47 +0200
> Max Reitz <mreitz@redhat.com> wrote:
>=20
>> On 2018-06-06 13:19, Michal Such=C3=A1nek wrote:
>>> On Wed, 6 Jun 2018 13:02:53 +0200
>>> Max Reitz <mreitz@redhat.com> wrote:
>>>  =20
>>>> On 2018-06-06 12:32, Michal Such=C3=A1nek wrote: =20
>>>>> On Tue, 29 May 2018 12:14:15 +0200
>>>>> Max Reitz <mreitz@redhat.com> wrote:

[...]

>>>>>> I hate the idea of making qcow2 a random archive format.   =20
>>>>>
>>>>> What's wrong with that?   =20
>>>>
>>>> The fact that qcow2 isn't.
>>>>
>>>> From my perspective it would increase the format's complexity to a
>>>> point where you could just create a new format altogether.  Well,
>>>> actually, all you do is design a filesystem (or reuse an existing
>>>> one).
>>>> =20
>>>>>> We have tar for that.   =20
>>>>>
>>>>> It does not support expanding the stored files.   =20
>>>>
>>>> Nor does qcow2, because it does not support storing files at all. =20
>>>
>>> AFAICT from the previous discussion it already does allow storing
>>> multiple data streams that can be changed independently so it
>>> basically is an archive format or filesystem except the streams are
>>> not named nor easily accessible separately outside of qemu. =20
>>
>> I don't quite understand what you are referring to.  We have
>> snapshots, we have bitmaps, yes, but all of that are related directly
>> to the stored guest disk data.
>>
>> The only thing we currently have in qcow2 that is opaque is the VM
>> state that can be stored in snapshots (and don't hold me responsible
>> for that).
>=20
> But it has to be related to the stored disk data only because of your
> dislike for stuff not related to the disk data. Not for a technical
> reason. The format can sustain storing unrelated data.

Yes.  Technically, you can even store data without qcow2 knowing, except
that qemu-img check -r leaks will delete it, but yeah.

>>>> Secondly, that completely depends on how you use it.  You can
>>>> freely expand the last file in the archive, for instance.  Also
>>>> I've seen people store files in chunks so they can indeed resize
>>>> it.
>>>>
>>>> (I'm wondering if we could write a block driver that could provide
>>>> such a chunk allocation transparently to qcow2...  Note that a
>>>> qcow2 file does not need to be continuous, so you could in theory
>>>> indeed store the qcow2 file and its data in completely separate
>>>> places in a tar file.) =20
>>>
>>> Which basically invents another new filesystem on top of tar for no
>>> good reason. Especially when we have already support for storage
>>> format that is capable enough. =20
>>
>> No different from inventing a filesystem on top of qcow2.
>>
>> I don't think qcow2 is any more capable than tar.
>=20
> It can natively resize the objects it stores.

It does not store arbitrary objects.  It stores a guest disk (and
snapshots), and bitmaps.  These are stored in directory structures so
new chunks can be dynamically added.  Note that both use slightly
different structures.

Yes, it is technically possible to use a similar structure to store
arbitrary objects.  But currently it does not have that capability.

>                                                tar cannot do that so yo=
u
> will have to store random nonsense in the tar archive that only makes
> sense for your fs/tar driver.

Right.  But what's the difference to storing random nonsense in a qcow2
file that not even makes sense to qemu?

>>>> What I'm trying to get at is that qcow2 was not designed to be a
>>>> container format for arbitrary files.  If you want to make it such,
>>>> I'm sure there are existing formats that work better. =20
>>>
>>> Such as? =20
>>
>> ext2?
>=20
> So you want an ext2 driver in qemu instead of expanding qcow2 to work
> not only for a single disk but also for an appliance?

Yes, because ext2 was designed to be a proper filesystem.  I'm not an FS
designer.  Well, not a good one anyway.  So I don't trust myself on
extending qcow2 to be a good FS -- and why would I, when there are
already numerous FS around.

>> It seems to me that you want to make qcow2 a filesystem.  Sure, the FS=

>> we'd end up with would probably be simpler than ext2, but I assume
>> thanks to feature creep we'd eventually end up with a qcow2 format
>> that is a worse FS than real FS (especially performance-wise), but
>> that is similarly complex.
>=20
> I do not see how the complexity increases drastically by assigning
> user-visible names to some of the data stored in the image. I am not
> familiar with the internals, though.

As I said, qcow2 does not store objects currently.  It stores specific
data structures that differ.  There is no common "object structure".

>>>>>> Unless I have got something terribly wrong (which is indeed a
>>>>>> possibility!), to me this proposal means basically to turn qcow2
>>>>>> into (1) a VM description format for qemu, and (2) to turn it
>>>>>> into an archive format on the way.   =20
>>>>>
>>>>> And if you go all the way you can store multiple disks along with
>>>>> the VM definition so you can have the whole appliance in one file.
>>>>> It conveniently solves the problem of synchronizing snapshots
>>>>> across multiple disk images and the question where to store the
>>>>> machine state if you want to suspend it.    =20
>>>>
>>>> Yeah, but why make qcow2 that format?  That's what I completely
>>>> fail to understand.
>>>>
>>>> If you want to have a single VM description file that contains the
>>>> VM configuration and some qcow2/raw/whatever files along with it
>>>> for the guest disk data, sure, go ahead.  But why does the format
>>>> of the whole thing need to be qcow2? =20
>>>
>>> Because then qemu can access the disk data from the image directly
>>> without any need for extraction, copying to different file, etc. =20
>>
>> This does not explain why it needs to be qcow2.  There is absolutely
>> no reason why you couldn't use qcow2 files in-place inside of another
>> file.
>=20
> qemu cannot read the disk data from the file in-place.

Hu?  Why not?

Max


--1li3T9cWtUcMJpOKIZB6UwPl6bLkrfuKB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsXywMACgkQ9AfbAGHV
z0Dl/ggAwLc3J8Zrq0FYlq+C8NgLioTub9GRxewlCbJFcNoZtHXtNZAJLj0h/B66
829w0llJaaTAXadMLQG1WXbthv0595RMv5XCt4zBrQ6FtdJWBethZs7l/MPzqiGg
ABhS7c0Pl3rfiCeKtmqZ15Aprr+ox3ptD/ABrI11hjSGJ4FMZgetoxRG6+EXdjKK
U470xdQ4EA/JwIhvXtCeTTRY4KPYcd9lOvD+7l/zVF6M4XCx4D8tnCV5NXhXeg6J
8EroUTRWC5B5XqCVXRABoH5yCz7GPvm6C8hBM4t50ztS6JUM7hVwNv7GuyQlW43c
IXBjnOb7vidgt/igmgHqjXeOi8YcFA==
=aXPM
-----END PGP SIGNATURE-----

--1li3T9cWtUcMJpOKIZB6UwPl6bLkrfuKB--
