Received: from eggs.gnu.org ([209.51.188.92]:45288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ghGju-0000ze-BS
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:29:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ghGjs-0008Qa-7F
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:29:58 -0500
References: <20190102140535.11512-1-cfergeau@redhat.com>
	<20190102180158.GA6015@natto.ory.fergeau.eu>
	<4ff5eb04-e1e0-7126-c08d-58d1f28b4f27@redhat.com>
	<87o98sii5b.fsf@dusky.pond.sub.org>
	<20190107163606.GL23773@natto.ory.fergeau.eu>
	<87pnt7bflk.fsf@dusky.pond.sub.org>
	<d8a41aa9-42bf-94f0-d6e6-347547dc39da@redhat.com>
	<87bm4pewa8.fsf@dusky.pond.sub.org>
	<61b1ab31-e39d-1187-d8bd-42370eef5547@redhat.com>
	<87pnt5by66.fsf@dusky.pond.sub.org>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <9b4d3d72-7ea7-18b8-21d8-05f04b6a76c5@redhat.com>
Date: Wed, 9 Jan 2019 17:29:51 +0100
MIME-Version: 1.0
In-Reply-To: <87pnt5by66.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="iCnG07j1TAj36lrjaSBkz0Cr9qygYc7LP"
Subject: Re: [Qemu-devel] [PATCH] json: Fix % handling when not interpolating
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Christophe Fergeau <cfergeau@redhat.com>, qemu-stable@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iCnG07j1TAj36lrjaSBkz0Cr9qygYc7LP
From: Max Reitz <mreitz@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Christophe Fergeau <cfergeau@redhat.com>, qemu-stable@nongnu.org
Message-ID: <9b4d3d72-7ea7-18b8-21d8-05f04b6a76c5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] json: Fix % handling when not interpolating
References: <20190102140535.11512-1-cfergeau@redhat.com>
 <20190102180158.GA6015@natto.ory.fergeau.eu>
 <4ff5eb04-e1e0-7126-c08d-58d1f28b4f27@redhat.com>
 <87o98sii5b.fsf@dusky.pond.sub.org>
 <20190107163606.GL23773@natto.ory.fergeau.eu>
 <87pnt7bflk.fsf@dusky.pond.sub.org>
 <d8a41aa9-42bf-94f0-d6e6-347547dc39da@redhat.com>
 <87bm4pewa8.fsf@dusky.pond.sub.org>
 <61b1ab31-e39d-1187-d8bd-42370eef5547@redhat.com>
 <87pnt5by66.fsf@dusky.pond.sub.org>
In-Reply-To: <87pnt5by66.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09.01.19 17:20, Markus Armbruster wrote:
> Max Reitz <mreitz@redhat.com> writes:
>=20
>> On 09.01.19 15:32, Markus Armbruster wrote:
>>> Max Reitz <mreitz@redhat.com> writes:
>>>
>>>> On 08.01.19 11:36, Markus Armbruster wrote:
>>>>> Copying block maintainers for help with assessing the bug's (non-)i=
mpact
>>>>> on security.
>>>>>
>>>>> Christophe Fergeau <cfergeau@redhat.com> writes:
>>>>>
>>>>>> On Mon, Jan 07, 2019 at 04:47:44PM +0100, Markus Armbruster wrote:=

>>>>>>> Eric Blake <eblake@redhat.com> writes:
>>>>>>>
>>>>>>>> On 1/2/19 12:01 PM, Christophe Fergeau wrote:
>>>>>>>>> Adding Markus to cc: list, I forgot to do it when sending the p=
atch.
>>>>>>>>
>>>>>>>> Also worth backporting via qemu-stable, now in cc.
>>>>>>>>
>>>>>>>>>
>>>>>>>>> Christophe
>>>>>>>>>
>>>>>>>>> On Wed, Jan 02, 2019 at 03:05:35PM +0100, Christophe Fergeau wr=
ote:
>>>>>>>>>> commit 8bca4613 added support for %% in json strings when inte=
rpolating,
>>>>>>>>>> but in doing so, this broke handling of % when not interpolati=
ng as the
>>>>>>>>>> '%' is skipped in both cases.
>>>>>>>>>> This commit ensures we only try to handle %% when interpolatin=
g.
>>>>>>>
>>>>>>> Impact?
>>>>>>>
>>>>>>> If you're unable to assess, could you give us at least a reproduc=
er?
>>>>>>
>>>>>> This all came from https://lists.freedesktop.org/archives/spice-de=
vel/2018-December/046644.html
>>>>>> Setting up a VM with libvirt with <graphics type=3D'spice' autopor=
t=3D'yes' passwd=3D'password%'/>
>>>>>> fails to start with:
>>>>>>   qemu-system-x86_64: qobject/json-parser.c:146: parse_string: Ass=
ertion `*ptr' failed.
>>>>>>
>>>>>> If you use 'password%%' as the password instead, when trying to co=
nnect
>>>>>> to the VM, you type 'password%' as the password instead of 'passwo=
rd%%'
>>>>>> as configured in the domain XML.
>>>>>
>>>>> Thanks.
>>>>>
>>>>> As the commit message says, the bug bites when we parse a string
>>>>> containing '%s' with !ctxt->ap.  The parser then swallows a charact=
er.
>>>>> If it swallows the terminating '"', it fails the assertion.
>>>>>
>>>>> We parse with !ctxt->ap in the following cases:
>>>>>
>>>>> * Tests (tests/check-qjson.c, tests/test-qobject-input-visitor.c,
>>>>>   tests/test-visitor-serialization.c)
>>>>>
>>>>>   Plenty of tests, but we still failed to cover the buggy case :(
>>>>>
>>>>> * QMP input (monitor.c)
>>>>>
>>>>> * QGA input (qga/main.c)
>>>>>
>>>>> * qobject_from_json()
>>>>>
>>>>>   - JSON pseudo-filenames (block.c)
>>>>>
>>>>>     These are pseudo-filenames starting with "json:".
>>>>>
>>>>>   - JSON key pairs (block/rbd.c)
>>>>>
>>>>>     As far as I can tell, these can come only from pseudo-filenames=

>>>>>     starting with "rbd:".
>>>>>
>>>>>   - JSON command line option arguments of -display and -blockdev
>>>>>     (qobject-input-visitor.c)
>>>>>
>>>>>     Reproducer: -blockdev '{"%"}'
>>>>>
>>>>> Command line, QMP and QGA input are trusted.
>>>>>
>>>>> Filenames are trusted when they come from command line, QMP or HMP.=

>>>>> They are untrusted when they come from from image file headers.
>>>>> Example: QCOW2 backing file name.  Note that this is *not* the secu=
rity
>>>>> boundary between host and guest.  It's the boundary between host an=
d an
>>>>> image file from an untrusted source.
>>>>>
>>>>> I can't see how the bug could be exploited.  Neither failing an
>>>>> assertion nor skipping a character in a filename of your choice is
>>>>> interesting.  We don't support compiling with NDEBUG.
>>>>>
>>>>> Kevin, Max, do you agree?
>>>>
>>>> I wouldn't call it "not interesting" if adding an image to your VM a=
t
>>>> runtime can crash the whole thing.
>>>>
>>>> (qemu-img create -f qcow2 -u -b 'json:{"%"}' foo.qcow2 64M)
>>>
>>> "Not interesting" strictly from the point of view of exploiting the b=
ug
>>> to penetrate trust boundaries.
>>>
>>>> Whether this is a security issue...  I don't know, but it is a DoS.
>>>
>>> I'm not sure whether feeding untrusted images to QEMU is a good idea =
in
>>> general --- there's so much that could go wrong.  How hardened agains=
t
>>> abuse are out block drivers?
>>
>> They are supposed to handle such cases gracefully, that's for sure.  A=
t
>> least for qcow2 we do care about it.
>>
>>> I figure what distinguishes this case is how utterly trivial creating=
 a
>>> "bad" image is.
>>
>> I don't think an untrusted image should be able to crash qemu.
>=20
> "Should" in the sense of "if they don't, it's a bug, and we'll do what
> we can to fix it", or "if they don't, I'll be surprised"?

Depends.  If it's Linux's VMM design (lazy allocation + OOM killer), I
don't care.  If there is something we can do to fix it, I do think it's
a bug.

Max

>>> Anyway, you are the block layer maintainers, so you get to decide
>>> whether to give this the full security bug treatment.  I'm merely the=

>>> clown who broke it %-/
>>
>> Er, then I suppose it is no security bug? O:-)
>=20
> I'm not charging toll for the bridge I built for you ;


--iCnG07j1TAj36lrjaSBkz0Cr9qygYc7LP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlw2IX8ACgkQ9AfbAGHV
z0AvMQgAt8lDibsj9dllcWhw+U012jfQUle5BrS6YSV8exQx4gjLdsZRuH6cwcUi
aF9XprKX8jGvO4nPqZBpyS0NbeYNs82xVqjjp34MNXYthocz2hp4aruOkAZnuEfR
lwXLilPAiwebC29Y+raIt16gI63v4foqzW8hopqFEUyf/1tNIKrrU5Nel1ZFvRCp
3a1IJLqy6+jCKZn+RTlxIW4ubXQzaXaV4etwyg6Pk4xzt664CklpoeIhz85fJz3u
ERmgYTDbcoFf+qYCJukJh/rNGMjV4pBf9GPD4LPEBAO8i0NRlnzSGnoIcmoPeRL6
sGGzh+segGMOvlzPOEYZBo7AHMBCFQ==
=Fq7H
-----END PGP SIGNATURE-----

--iCnG07j1TAj36lrjaSBkz0Cr9qygYc7LP--
