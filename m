Received: from eggs.gnu.org ([2001:4830:134:3::10]:58375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fQWZx-0001lG-3F
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 07:26:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fQWZv-0007nP-7G
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 07:26:13 -0400
References: <20180524113251.GB4660@redhat.com>
	<d9bb2cb9-d9dc-8fe0-a767-10d9cbbab803@redhat.com>
	<20180528183058.GG2209@redhat.com>
	<20180528183833.GJ4580@localhost.localdomain>
	<20180528212054.GH2209@redhat.com> <20180528212510.GC4660@redhat.com>
	<20180529064415.GA4756@localhost.localdomain>
	<2b3eef00-f326-c1e6-0e4b-b7602646eec4@redhat.com>
	<20180605092159.GA2544@work-vm>
	<46ef4200-eccf-7e65-d3a0-69e4a7414b51@redhat.com>
	<20180606111406.GD2660@work-vm>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <9e8b49fb-0162-bf35-21bb-acc0dc28555f@redhat.com>
Date: Wed, 6 Jun 2018 13:26:01 +0200
MIME-Version: 1.0
In-Reply-To: <20180606111406.GD2660@work-vm>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NCDbRRaxjnohWEJftWpWYlHh3A87lTo1s"
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
Cc: Kevin Wolf <kwolf@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, armbru@redhat.com, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NCDbRRaxjnohWEJftWpWYlHh3A87lTo1s
From: Max Reitz <mreitz@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>,
 armbru@redhat.com, qemu-block@nongnu.org, "Michael S. Tsirkin"
 <mst@redhat.com>, qemu-devel@nongnu.org, stefanha@redhat.com
Message-ID: <9e8b49fb-0162-bf35-21bb-acc0dc28555f@redhat.com>
Subject: Re: [Qemu-devel] storing machine data in qcow images?
References: <20180524113251.GB4660@redhat.com>
 <d9bb2cb9-d9dc-8fe0-a767-10d9cbbab803@redhat.com>
 <20180528183058.GG2209@redhat.com>
 <20180528183833.GJ4580@localhost.localdomain>
 <20180528212054.GH2209@redhat.com> <20180528212510.GC4660@redhat.com>
 <20180529064415.GA4756@localhost.localdomain>
 <2b3eef00-f326-c1e6-0e4b-b7602646eec4@redhat.com>
 <20180605092159.GA2544@work-vm>
 <46ef4200-eccf-7e65-d3a0-69e4a7414b51@redhat.com>
 <20180606111406.GD2660@work-vm>
In-Reply-To: <20180606111406.GD2660@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-06-06 13:14, Dr. David Alan Gilbert wrote:
> * Max Reitz (mreitz@redhat.com) wrote:
>> On 2018-06-05 11:21, Dr. David Alan Gilbert wrote:
>>> <reawakening a fizzled out thread>
>>>
>>> This seems to have fizzled out because of a lack of a concrete propos=
al;
>>> so here is one based on a reply to Max's post:
>>>
>>> * Max Reitz (mreitz@redhat.com) wrote:
>>>
>>> <snip>
>>>
>>>> The original problem was that you need to supply a machine type to q=
emu,
>>>> and that multiple common architectures now have multiple machine typ=
es
>>>> and not necessarily all work with a single image.  So far so good, b=
ut I
>>>> have two issues here already:
>>>>
>>>> (1) How is qemu supposed to interpret that information?  If it's sto=
red
>>>> in the image file, I don't see a nice way of retrieving it before th=
e
>>>> machine is initialized, at least not with qemu's current architectur=
e.
>>>
>>> <snip>
>>>
>>>> (2) Again, I personally just really don't like saving such informati=
on
>>>> in a disk image.  One actual argument I can bring up for that distas=
te
>>>> is this: Suppose, you have multiple images attached to your VM.  Now=
 the
>>>> VM wants to store the machine type.  Where does it go?  Into all of
>>>> them?
>>>
>>> <snip>
>>>
>>>> So I think if we decide to store the machine type, that is kind of a=

>>>> slippery slope and then there are good arguments for storing even mo=
re
>>>> configuration options in the file, too.  But I really, really don't =
like
>>>> that.
>>>
>>> <snip>
>>>
>>>> For another, how do we store the data?  key-value seems wrong if we =
want
>>>> to store everything.  JSON might be fine.  But eventually we just wa=
nt
>>>> basically a qemu configuration file in there, I would think (which m=
ay
>>>> support JSON at some point?).   So basically we would store the data=
 as
>>>> a binary blob and let the rest of qemu do its thing with it.  But th=
en
>>>> please tell me why I fought so valiantly against storing random bitm=
aps
>>>> in qcow2 files.  I hate the idea of making qcow2 a random archive
>>>> format.  We have tar for that.
>>>
>>> <snip>
>>>
>>>> tl;dr: I really don't get why it's so hard to supply a config file a=
long
>>>> with a qcow2 image.  Is it so hard for people to realize that a VM d=
oes
>>>> not only consist of a disk?
>>>
>>> Yes! Because in many cases that's all it needs, and it's ready to run=

>>> with no unpacking.
>>
>> It clearly is not, or we would not have this discussion.
>>
>> The disk image is only enough if you want the default values for all o=
f
>> qemu's configuration options, because today (and if I were to decide, =
in
>> the future, too) disk images do not configure the VM (well, they
>> configure the guest, but not the VM itself).
>=20
> The problem with having a separate file is that you either have to copy=

> it around with the image=20

Which is just an inconvenience.

I understand it is an inconvenience and it would be nice to change it,
but please understand that I do not want qcow2 to become a filesystem
just to relieve an inconvenience.

(Note: I understand that you may not want qcow2 to become a filesystem,
but I do get the impression from others.)

>                           or have an archive. If you have an archive
> you have to have an unpacking step which then copies, potentially a lot=

> of data taking some reasonable amount of time.

I'm sure this can be optimized, but yes, I get that.

(If you use e.g. tar and store the image data starting on an FS cluster
boundary (64 kB should be more than sufficient), I assume there is a way
to extract that data into a new file without copying anything.)

>                                                 Storing a simple bit
> of data with the image avoids that.

It is not a simple bit of data, as evidenced by the discussion about
storing binary blobs and MIME types going on.

>>> I think we should have:
>>>
>>> --------------------------------------------------------------
>>> Layer 0:
>>>    QCOW provides a way to store a single string of arbitrary (but
>>> limited?) length.
>>>    QCOW provides a way to replace the string by a new string.
>>>    The original or the new string will be stored after that;
>>>    never some mix.
>>>    Where a file 'b' has a backing file 'a', 'b' inherits the
>>>    string from 'a' unless 'b' has it's own string.
>>>    Snapshots inherit their string from the main unless they have
>>>    their own string.
>>>
>>> Layer 1:
>>>    The string shall always be a JSON 'object'; i.e. of the form
>>>     { "something": ... , "more": ... }
>>>
>>>    The key strings shall be non-null and non-empty and shall
>>>    be unique.
>>>
>>> Layer 2:
>>>    '.'s in the key string shall indicate hierarchy
>>
>> I don't understand why we we'd need dotted syntax when we already have=

>> JSON, but that's not my issue.
>=20
> I think someone earlier in the thread had asked about how we handled
> hierarchy so I added it.
>=20
>>>    Key strings shall be listed in qemu's=20
>>>       docs/specs/qcow-keys.rst
>>>
>>>       that shall indicate their meaning and the meaning and
>>>       valid formatting of the value associated with the,
>>>
>>>    Key strings shall start with either:
>>>       qemu.   in which case they must be listed in a file in
>>>               the qemu source tree
>>>
>>>       a reverse dotted name unique to the submitter, they may
>>>               be listed in the same file in the source tree, e.g.
>>>       com.redhat.
>>
>> So this is just another configuration file format.
>>
>>> Layer 3:
>>>    QEMU shall, for a given qcow2 file be able to dump the
>>>    key values.
>>>
>>> Layer 4:
>>>    On creating a VM by importing a qcow2, a management layer
>>>    shall inspect the key/values to influence the configuration
>>>    of the VM created.   Where it imports multiple qcow2's it
>>>    shall inspect all the files and flag disagreements.
>>>
>>>    Management layers shall, on creating a qcow2 shall set the
>>>    keys based on the VM the qcow2 is created for.  If the qcow2
>>>    is created as an additional disk for an exisitng VM it's
>>>    fine to leave the string empty (e.g. for a data disk).
>>
>> This at least solves the issue of where qemu should store the data (qe=
mu
>> doesn't care), and how qemu should interpret it (not at all).
>>
>> But I really, really, really do not like storing arbitrary data in qco=
w2
>> files.  I hated it badly enough when qemu knew what to do with it, but=
 I
>> hate it even more when even qemu has no idea what to do with it.
>>
>> Having a specification of what everything means in the qemu tree makes=

>> things less unbearable, but not to my liking still.
>=20
> Have you said why you hate it so much?
> Your hate for it seems to be making a simple solution hard.

Because it's a disk image format.  Data therein should be relevant to
the disk image.  I see qcow2 as a representation of data stored on a
physical storage medium.

Some metadata associated directly with that is fine (such as dirty
bitmaps, backing chains, things like that).  But configuring the whole
VM seems out of scope to me.

Also, making qcow2 a filesystem is not a simple solution.

=2E..OK, let me back off here, I may be over-interpreting things and
throwing opinions of different people into one pot.

Maybe you don't want qcow2 to be a filesystem, and you just want to
store a single binary blob.  Well, OK, that's not that bad.  But in any
case, I wouldn't call it a simple solution anymore.

Yes, storing just the machine type somewhere would be possible with a
simple solution; but as I said (and the whole thread shows since then),
this is a slippery slope, and suddenly we arrive at storing arbitrary
binary data (like images?!) along with MIME types.  That will not be
possible with a simple solution anymore, I don't think.

>>> --------------------------------------------------------------
>>>   =20
>>>
>>> Some reasoning:
>>>    a) I've avoided the problem of when QEMU interprets the value
>>>       by ignoring it and giving it to management layers at the point
>>>       of VM import.
>>
>> Yes, but in the process you've made it completely opaque to qemu,
>> basically, which doesn't really make it better for me.  Not that
>> qemu-specific information in qcow2 files would be what I want, but, we=
ll.
>>
>> But it does solve technical issues, I concede that.
>>
>>>    b) I hate JSON, but there again nailing down a fixed format
>>>       seems easiest and it makes the job of QCOW easy - a single
>>>       string.
>>
>> Not really.  The string can be rather long, so you probably don't want=

>> to store it in the image header, and thus it's just a binary blob from=

>> qcow2's perspective, essentially.
>=20
> Yes, but it's a single blob - I'm not asking for multiple keyed blobs
> or the ability to update individual blobs; just one blob that I can
> replace.

OK, you aren't, but others seem to be.

Or, well, you call it a single blob.  But actually the current ideas
seem to be to store a rather large configuration tree with binary data
in that blob, so to me personally there is absolutely no functional
difference to just storing a tar file in that blob.

So correct me if I'm wrong, but to me it appears that you effectively
want to store a filesystem in qcow2.[1]  Well, that's better than making
qcow2 the filesystem, but it still appears just the wrong way around to m=
e.

[1] Yes, I know that the guest disk already contains an FS. :-P

>>>       (I would suggest in layer2 that the keys are sorted, but
>>>       that's a pain to do in some json creators)
>>>    c) Forcing the registry of keys might avoid silly duplication.
>>>       We can but hope.
>>>    d) I've not said it's a libvirt XML file since that seems
>>>       a bit prescriptive.
>>>
>>> Some initial suggested keys:
>>>
>>>    "qemu.machine-types": [ "q35", "i440fx" ]
>>>    "qemu.min-ram-MB": 1024
>>
>> I still don't understand why you'd want to put the configuration into
>> qcow2 instead of the other way around.
>>
>> Or why you'd want to use a single file at all, because as this whole
>> thread shows, a disk image alone is clearly not sufficient to describe=
 a VM.
>>
>> (Or it may be in simple cases, but then that's because you don't need
>> any configuration.)
>=20
> Because it avoids the unpacking associated with archives.

I'm not talking about unpacking.  I'm talking about a potentially new
format which allows accessing the qcow2 file in-place.  It would
probably be trivial to write a block driver to allow this.

(And as I wrote in my response to Michal, I suspect that tar could
actually allow this, even though it would probably not be the ideal forma=
t.)

Max


--NCDbRRaxjnohWEJftWpWYlHh3A87lTo1s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsXxMoACgkQ9AfbAGHV
z0A+gwgAobtOf7plaqMcygjdkmR/s5JqH5IH+lMkoCV/DZaZWwFTnMhajgfB9kvR
BkwbV4Lbcjm9rxhn0UBokXK0p/urxf5JTgvlMKc+xpkEkS0vasAaG2ccUKHI23En
ZiqeIJ9Tfykfcm/yyTD+TsGjty19ZmWC3yP6R8FeLpR69wuTuFAoSj2HfMi8OdHg
yezsE3/1EqWRLUtpqaZScNF+V1yNngAmN5xt85Fv+2SwsDHYPn8eZ/RFS41wRCY+
ve5A+jmn0P1+qf1j5V9yRrUouEWADVg9RNMq5bFBa+/agSwp8YQhVcdJwTOUflQz
Lw/NFcd+/69vaW2+DY4OvJiRJkjqZw==
=5nau
-----END PGP SIGNATURE-----

--NCDbRRaxjnohWEJftWpWYlHh3A87lTo1s--
