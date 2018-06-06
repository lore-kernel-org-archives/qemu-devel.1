Received: from eggs.gnu.org ([2001:4830:134:3::10]:34524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fQWrM-00021w-1O
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 07:44:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fQWrK-0007xr-VE
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 07:44:12 -0400
References: <20180528183058.GG2209@redhat.com>
	<20180528183833.GJ4580@localhost.localdomain>
	<20180528212054.GH2209@redhat.com> <20180528212510.GC4660@redhat.com>
	<20180529064415.GA4756@localhost.localdomain>
	<2b3eef00-f326-c1e6-0e4b-b7602646eec4@redhat.com>
	<20180606123237.2235ae4a@kitsune.suse.cz>
	<bc97cdc3-85ba-e053-0816-b6bc431064fb@redhat.com>
	<20180606131929.44d0fd6b@kitsune.suse.cz>
	<93233bff-604b-c891-90ce-64fe1eaaaab5@redhat.com>
	<20180606113720.GA2661@work-vm>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <2c833e2c-f0bb-ea98-a703-54fb9447bd2f@redhat.com>
Date: Wed, 6 Jun 2018 13:44:02 +0200
MIME-Version: 1.0
In-Reply-To: <20180606113720.GA2661@work-vm>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="cgsRLNqQeUgx3fnzecvqyJPHAFEnQQwGy"
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
Cc: =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>, Kevin Wolf <kwolf@redhat.com>, ehabkost@redhat.com, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, qemu-devel@nongnu.org, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cgsRLNqQeUgx3fnzecvqyJPHAFEnQQwGy
From: Max Reitz <mreitz@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>,
 Kevin Wolf <kwolf@redhat.com>, ehabkost@redhat.com, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, "Richard W.M. Jones"
 <rjones@redhat.com>, qemu-devel@nongnu.org, stefanha@redhat.com
Message-ID: <2c833e2c-f0bb-ea98-a703-54fb9447bd2f@redhat.com>
Subject: Re: [Qemu-devel] storing machine data in qcow images?
References: <20180528183058.GG2209@redhat.com>
 <20180528183833.GJ4580@localhost.localdomain>
 <20180528212054.GH2209@redhat.com> <20180528212510.GC4660@redhat.com>
 <20180529064415.GA4756@localhost.localdomain>
 <2b3eef00-f326-c1e6-0e4b-b7602646eec4@redhat.com>
 <20180606123237.2235ae4a@kitsune.suse.cz>
 <bc97cdc3-85ba-e053-0816-b6bc431064fb@redhat.com>
 <20180606131929.44d0fd6b@kitsune.suse.cz>
 <93233bff-604b-c891-90ce-64fe1eaaaab5@redhat.com>
 <20180606113720.GA2661@work-vm>
In-Reply-To: <20180606113720.GA2661@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-06-06 13:37, Dr. David Alan Gilbert wrote:
> * Max Reitz (mreitz@redhat.com) wrote:
>> On 2018-06-06 13:19, Michal Such=C3=A1nek wrote:
>>> On Wed, 6 Jun 2018 13:02:53 +0200
>>> Max Reitz <mreitz@redhat.com> wrote:
>>>
>>>> On 2018-06-06 12:32, Michal Such=C3=A1nek wrote:
>>>>> On Tue, 29 May 2018 12:14:15 +0200
>>>>> Max Reitz <mreitz@redhat.com> wrote:

[...]

>>>>>> Unless I have got something terribly wrong (which is indeed a
>>>>>> possibility!), to me this proposal means basically to turn qcow2
>>>>>> into (1) a VM description format for qemu, and (2) to turn it into=

>>>>>> an archive format on the way. =20
>>>>>
>>>>> And if you go all the way you can store multiple disks along with
>>>>> the VM definition so you can have the whole appliance in one file.
>>>>> It conveniently solves the problem of synchronizing snapshots acros=
s
>>>>> multiple disk images and the question where to store the machine
>>>>> state if you want to suspend it.  =20
>>>>
>>>> Yeah, but why make qcow2 that format?  That's what I completely fail=

>>>> to understand.
>>>>
>>>> If you want to have a single VM description file that contains the V=
M
>>>> configuration and some qcow2/raw/whatever files along with it for th=
e
>>>> guest disk data, sure, go ahead.  But why does the format of the who=
le
>>>> thing need to be qcow2?
>>>
>>> Because then qemu can access the disk data from the image directly
>>> without any need for extraction, copying to different file, etc.
>>
>> This does not explain why it needs to be qcow2.  There is absolutely n=
o
>> reason why you couldn't use qcow2 files in-place inside of another fil=
e.
>=20
> Because then we'd have to change the whole stack to take advantage of
> that.  Adding a feature into qcow2 means nothing else changes.

Because it's a hack, right.  Storing binary data in a qcow2 file,
completely ignoring it in qemu (and being completely unusable to any
potential other users of the qcow2 format[1]) and only interpreting it
somewhere up the stack is a hack.

That is not necessarily a negative point, hacks can work wonderfully
well, and they usually are simple, that is correct.  But the thing is
that I feel like people have grand visions of what to get out of this.
Imagine, a single file that can configure all and any VM!

But hacks usually only solve a single issue.  Once you try to extend a
hack, it breaks down and becomes insufficient.

If we want a grand vision where a single file stores the whole VM, why
not invest the work and make it right from the start?

Max

[1] Yes, I concede that there are probably no other users of qcow2.  But
please forgive me for assuming that qcow2 was in a sense designed to be
a rather general image format that not only qemu could use.


--cgsRLNqQeUgx3fnzecvqyJPHAFEnQQwGy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsXyQIACgkQ9AfbAGHV
z0DsHwf9FQsqXlhpG5jgVY+LoB5e2jPMpA6bE1Es7RGND2MkQFnIArb1ki84QOT6
P+io2Gc66NC/Jn6TQqUzQxxSIaZycIhlZB2fkh5ZImY8VxwwIBrH9PnEazdlsqXH
fXagX84qHCmXnBrx5gUsISH5LGZYBmDiAG2C0VEPlep6r53qmstlLD1om/OjtGOm
jz7dWJJu4JvN9vJ+R3lhPXX5jXxIEBtoQuTNXN48ysRGG4C2rfnEgXh8diMYFb/z
lfn54jlTf6cGa5+lE6v+LA45wNM3k5R79g3grn32FJKBdjpFGRkux+z4ed7t5WG/
D7QWuhrYWD4GL+mgpy+4r21gF/NdrQ==
=tC5U
-----END PGP SIGNATURE-----

--cgsRLNqQeUgx3fnzecvqyJPHAFEnQQwGy--
