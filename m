Received: from eggs.gnu.org ([2001:4830:134:3::10]:53487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fQWDd-0000py-83
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 07:03:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fQWDW-000514-Ll
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 07:03:09 -0400
References: <20180518180440-mutt-send-email-mst@kernel.org>
	<20180524113251.GB4660@redhat.com>
	<d9bb2cb9-d9dc-8fe0-a767-10d9cbbab803@redhat.com>
	<20180528183058.GG2209@redhat.com>
	<20180528183833.GJ4580@localhost.localdomain>
	<20180528212054.GH2209@redhat.com> <20180528212510.GC4660@redhat.com>
	<20180529064415.GA4756@localhost.localdomain>
	<2b3eef00-f326-c1e6-0e4b-b7602646eec4@redhat.com>
	<20180605092159.GA2544@work-vm>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <46ef4200-eccf-7e65-d3a0-69e4a7414b51@redhat.com>
Date: Wed, 6 Jun 2018 13:02:56 +0200
MIME-Version: 1.0
In-Reply-To: <20180605092159.GA2544@work-vm>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hFP5C7ZZlGQc42qdhK0e839pkKkBqm9l8"
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
Cc: Kevin Wolf <kwolf@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hFP5C7ZZlGQc42qdhK0e839pkKkBqm9l8
From: Max Reitz <mreitz@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, stefanha@redhat.com
Message-ID: <46ef4200-eccf-7e65-d3a0-69e4a7414b51@redhat.com>
Subject: Re: [Qemu-devel] storing machine data in qcow images?
References: <20180518180440-mutt-send-email-mst@kernel.org>
 <20180524113251.GB4660@redhat.com>
 <d9bb2cb9-d9dc-8fe0-a767-10d9cbbab803@redhat.com>
 <20180528183058.GG2209@redhat.com>
 <20180528183833.GJ4580@localhost.localdomain>
 <20180528212054.GH2209@redhat.com> <20180528212510.GC4660@redhat.com>
 <20180529064415.GA4756@localhost.localdomain>
 <2b3eef00-f326-c1e6-0e4b-b7602646eec4@redhat.com>
 <20180605092159.GA2544@work-vm>
In-Reply-To: <20180605092159.GA2544@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-06-05 11:21, Dr. David Alan Gilbert wrote:
> <reawakening a fizzled out thread>
>=20
> This seems to have fizzled out because of a lack of a concrete proposal=
;
> so here is one based on a reply to Max's post:
>=20
> * Max Reitz (mreitz@redhat.com) wrote:
>=20
> <snip>
>=20
>> The original problem was that you need to supply a machine type to qem=
u,
>> and that multiple common architectures now have multiple machine types=

>> and not necessarily all work with a single image.  So far so good, but=
 I
>> have two issues here already:
>>
>> (1) How is qemu supposed to interpret that information?  If it's store=
d
>> in the image file, I don't see a nice way of retrieving it before the
>> machine is initialized, at least not with qemu's current architecture.=

>=20
> <snip>
>=20
>> (2) Again, I personally just really don't like saving such information=

>> in a disk image.  One actual argument I can bring up for that distaste=

>> is this: Suppose, you have multiple images attached to your VM.  Now t=
he
>> VM wants to store the machine type.  Where does it go?  Into all of
>> them?
>=20
> <snip>
>=20
>> So I think if we decide to store the machine type, that is kind of a
>> slippery slope and then there are good arguments for storing even more=

>> configuration options in the file, too.  But I really, really don't li=
ke
>> that.
>=20
> <snip>
>=20
>> For another, how do we store the data?  key-value seems wrong if we wa=
nt
>> to store everything.  JSON might be fine.  But eventually we just want=

>> basically a qemu configuration file in there, I would think (which may=

>> support JSON at some point?).   So basically we would store the data a=
s
>> a binary blob and let the rest of qemu do its thing with it.  But then=

>> please tell me why I fought so valiantly against storing random bitmap=
s
>> in qcow2 files.  I hate the idea of making qcow2 a random archive
>> format.  We have tar for that.
>=20
> <snip>
>=20
>> tl;dr: I really don't get why it's so hard to supply a config file alo=
ng
>> with a qcow2 image.  Is it so hard for people to realize that a VM doe=
s
>> not only consist of a disk?
>=20
> Yes! Because in many cases that's all it needs, and it's ready to run
> with no unpacking.

It clearly is not, or we would not have this discussion.

The disk image is only enough if you want the default values for all of
qemu's configuration options, because today (and if I were to decide, in
the future, too) disk images do not configure the VM (well, they
configure the guest, but not the VM itself).

> I think we should have:
>=20
> --------------------------------------------------------------
> Layer 0:
>    QCOW provides a way to store a single string of arbitrary (but
> limited?) length.
>    QCOW provides a way to replace the string by a new string.
>    The original or the new string will be stored after that;
>    never some mix.
>    Where a file 'b' has a backing file 'a', 'b' inherits the
>    string from 'a' unless 'b' has it's own string.
>    Snapshots inherit their string from the main unless they have
>    their own string.
>=20
> Layer 1:
>    The string shall always be a JSON 'object'; i.e. of the form
>     { "something": ... , "more": ... }
>=20
>    The key strings shall be non-null and non-empty and shall
>    be unique.
>=20
> Layer 2:
>    '.'s in the key string shall indicate hierarchy

I don't understand why we we'd need dotted syntax when we already have
JSON, but that's not my issue.

>    Key strings shall be listed in qemu's=20
>       docs/specs/qcow-keys.rst
>=20
>       that shall indicate their meaning and the meaning and
>       valid formatting of the value associated with the,
>=20
>    Key strings shall start with either:
>       qemu.   in which case they must be listed in a file in
>               the qemu source tree
>=20
>       a reverse dotted name unique to the submitter, they may
>               be listed in the same file in the source tree, e.g.
>       com.redhat.

So this is just another configuration file format.

> Layer 3:
>    QEMU shall, for a given qcow2 file be able to dump the
>    key values.
>=20
> Layer 4:
>    On creating a VM by importing a qcow2, a management layer
>    shall inspect the key/values to influence the configuration
>    of the VM created.   Where it imports multiple qcow2's it
>    shall inspect all the files and flag disagreements.
>=20
>    Management layers shall, on creating a qcow2 shall set the
>    keys based on the VM the qcow2 is created for.  If the qcow2
>    is created as an additional disk for an exisitng VM it's
>    fine to leave the string empty (e.g. for a data disk).

This at least solves the issue of where qemu should store the data (qemu
doesn't care), and how qemu should interpret it (not at all).

But I really, really, really do not like storing arbitrary data in qcow2
files.  I hated it badly enough when qemu knew what to do with it, but I
hate it even more when even qemu has no idea what to do with it.

Having a specification of what everything means in the qemu tree makes
things less unbearable, but not to my liking still.

> --------------------------------------------------------------
>   =20
>=20
> Some reasoning:
>    a) I've avoided the problem of when QEMU interprets the value
>       by ignoring it and giving it to management layers at the point
>       of VM import.

Yes, but in the process you've made it completely opaque to qemu,
basically, which doesn't really make it better for me.  Not that
qemu-specific information in qcow2 files would be what I want, but, well.=


But it does solve technical issues, I concede that.

>    b) I hate JSON, but there again nailing down a fixed format
>       seems easiest and it makes the job of QCOW easy - a single
>       string.

Not really.  The string can be rather long, so you probably don't want
to store it in the image header, and thus it's just a binary blob from
qcow2's perspective, essentially.

>       (I would suggest in layer2 that the keys are sorted, but
>       that's a pain to do in some json creators)
>    c) Forcing the registry of keys might avoid silly duplication.
>       We can but hope.
>    d) I've not said it's a libvirt XML file since that seems
>       a bit prescriptive.
>=20
> Some initial suggested keys:
>=20
>    "qemu.machine-types": [ "q35", "i440fx" ]
>    "qemu.min-ram-MB": 1024

I still don't understand why you'd want to put the configuration into
qcow2 instead of the other way around.

Or why you'd want to use a single file at all, because as this whole
thread shows, a disk image alone is clearly not sufficient to describe a =
VM.

(Or it may be in simple cases, but then that's because you don't need
any configuration.)

Max


--hFP5C7ZZlGQc42qdhK0e839pkKkBqm9l8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsXv2AACgkQ9AfbAGHV
z0DV9Qf/RtU2i1zzyM0VfO+zGOKbIeApNaCmEbdj+pJSwRoWRDPplA8nQkUFQ3kS
0fvB4T5Ey8TZozaW5mL2FEQfePbxNsFLDFsiwa+C9l3Id0gt2muSYKYPsolqa+jW
+f4EOfa5qR1Ami0t2lygHPyoiuxM9OOy3OYbPIEFkDMK9a9PY6I5f1cKwmpg5+jZ
p77XTnq030LLklCJNGXSuX3KBXXoDpu+ZbWZ1H8z5N6a7ePcYvAHDdzCc5TF2eZo
NoNao1RzDkP+rui7Y9ACDgcS2FVVTF7U/HaWodF3s8wtOt5z7CSdqc98f+VWB/mE
2Pb5nB3R7kAJg6luqy/NkdtwFzHECw==
=mw60
-----END PGP SIGNATURE-----

--hFP5C7ZZlGQc42qdhK0e839pkKkBqm9l8--
