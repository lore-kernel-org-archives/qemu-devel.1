Received: from eggs.gnu.org ([209.51.188.92]:40570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ghFNM-0007Wc-MC
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 10:02:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ghFNK-0005Mx-5n
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 10:02:36 -0500
References: <20190102140535.11512-1-cfergeau@redhat.com>
	<20190102180158.GA6015@natto.ory.fergeau.eu>
	<4ff5eb04-e1e0-7126-c08d-58d1f28b4f27@redhat.com>
	<87o98sii5b.fsf@dusky.pond.sub.org>
	<20190107163606.GL23773@natto.ory.fergeau.eu>
	<87pnt7bflk.fsf@dusky.pond.sub.org>
	<d8a41aa9-42bf-94f0-d6e6-347547dc39da@redhat.com>
	<87bm4pewa8.fsf@dusky.pond.sub.org> <20190109144925.GT3998@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <5ad4e813-64e4-4761-9675-7d73527ded9a@redhat.com>
Date: Wed, 9 Jan 2019 16:02:28 +0100
MIME-Version: 1.0
In-Reply-To: <20190109144925.GT3998@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="zUyYo1GwUKqU7bjsBgwyKV1oALIHUGqlz"
Subject: Re: [Qemu-devel] [PATCH] json: Fix % handling when not interpolating
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Christophe Fergeau <cfergeau@redhat.com>, qemu-stable@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zUyYo1GwUKqU7bjsBgwyKV1oALIHUGqlz
From: Max Reitz <mreitz@redhat.com>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Christophe Fergeau <cfergeau@redhat.com>, qemu-stable@nongnu.org
Message-ID: <5ad4e813-64e4-4761-9675-7d73527ded9a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] json: Fix % handling when not interpolating
References: <20190102140535.11512-1-cfergeau@redhat.com>
 <20190102180158.GA6015@natto.ory.fergeau.eu>
 <4ff5eb04-e1e0-7126-c08d-58d1f28b4f27@redhat.com>
 <87o98sii5b.fsf@dusky.pond.sub.org>
 <20190107163606.GL23773@natto.ory.fergeau.eu>
 <87pnt7bflk.fsf@dusky.pond.sub.org>
 <d8a41aa9-42bf-94f0-d6e6-347547dc39da@redhat.com>
 <87bm4pewa8.fsf@dusky.pond.sub.org> <20190109144925.GT3998@redhat.com>
In-Reply-To: <20190109144925.GT3998@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09.01.19 15:49, Daniel P. Berrang=C3=A9 wrote:
> On Wed, Jan 09, 2019 at 03:32:47PM +0100, Markus Armbruster wrote:
>> Max Reitz <mreitz@redhat.com> writes:
>>
>>> On 08.01.19 11:36, Markus Armbruster wrote:
>>>> Copying block maintainers for help with assessing the bug's (non-)im=
pact
>>>> on security.
>>>>
>>>> Christophe Fergeau <cfergeau@redhat.com> writes:
>>>>
>>>>> On Mon, Jan 07, 2019 at 04:47:44PM +0100, Markus Armbruster wrote:
>>>>>> Eric Blake <eblake@redhat.com> writes:
>>>>>>
>>>>>>> On 1/2/19 12:01 PM, Christophe Fergeau wrote:
>>>>>>>> Adding Markus to cc: list, I forgot to do it when sending the pa=
tch.
>>>>>>>
>>>>>>> Also worth backporting via qemu-stable, now in cc.
>>>>>>>
>>>>>>>>
>>>>>>>> Christophe
>>>>>>>>
>>>>>>>> On Wed, Jan 02, 2019 at 03:05:35PM +0100, Christophe Fergeau wro=
te:
>>>>>>>>> commit 8bca4613 added support for %% in json strings when inter=
polating,
>>>>>>>>> but in doing so, this broke handling of % when not interpolatin=
g as the
>>>>>>>>> '%' is skipped in both cases.
>>>>>>>>> This commit ensures we only try to handle %% when interpolating=
=2E
>>>>>>
>>>>>> Impact?
>>>>>>
>>>>>> If you're unable to assess, could you give us at least a reproduce=
r?
>>>>>
>>>>> This all came from https://lists.freedesktop.org/archives/spice-dev=
el/2018-December/046644.html
>>>>> Setting up a VM with libvirt with <graphics type=3D'spice' autoport=
=3D'yes' passwd=3D'password%'/>
>>>>> fails to start with:
>>>>>   qemu-system-x86_64: qobject/json-parser.c:146: parse_string: Asse=
rtion `*ptr' failed.
>>>>>
>>>>> If you use 'password%%' as the password instead, when trying to con=
nect
>>>>> to the VM, you type 'password%' as the password instead of 'passwor=
d%%'
>>>>> as configured in the domain XML.
>>>>
>>>> Thanks.
>>>>
>>>> As the commit message says, the bug bites when we parse a string
>>>> containing '%s' with !ctxt->ap.  The parser then swallows a characte=
r.
>>>> If it swallows the terminating '"', it fails the assertion.
>>>>
>>>> We parse with !ctxt->ap in the following cases:
>>>>
>>>> * Tests (tests/check-qjson.c, tests/test-qobject-input-visitor.c,
>>>>   tests/test-visitor-serialization.c)
>>>>
>>>>   Plenty of tests, but we still failed to cover the buggy case :(
>>>>
>>>> * QMP input (monitor.c)
>>>>
>>>> * QGA input (qga/main.c)
>>>>
>>>> * qobject_from_json()
>>>>
>>>>   - JSON pseudo-filenames (block.c)
>>>>
>>>>     These are pseudo-filenames starting with "json:".
>>>>
>>>>   - JSON key pairs (block/rbd.c)
>>>>
>>>>     As far as I can tell, these can come only from pseudo-filenames
>>>>     starting with "rbd:".
>>>>
>>>>   - JSON command line option arguments of -display and -blockdev
>>>>     (qobject-input-visitor.c)
>>>>
>>>>     Reproducer: -blockdev '{"%"}'
>>>>
>>>> Command line, QMP and QGA input are trusted.
>>>>
>>>> Filenames are trusted when they come from command line, QMP or HMP.
>>>> They are untrusted when they come from from image file headers.
>>>> Example: QCOW2 backing file name.  Note that this is *not* the secur=
ity
>>>> boundary between host and guest.  It's the boundary between host and=
 an
>>>> image file from an untrusted source.
>>>>
>>>> I can't see how the bug could be exploited.  Neither failing an
>>>> assertion nor skipping a character in a filename of your choice is
>>>> interesting.  We don't support compiling with NDEBUG.
>>>>
>>>> Kevin, Max, do you agree?
>>>
>>> I wouldn't call it "not interesting" if adding an image to your VM at=

>>> runtime can crash the whole thing.
>>>
>>> (qemu-img create -f qcow2 -u -b 'json:{"%"}' foo.qcow2 64M)
>>
>> "Not interesting" strictly from the point of view of exploiting the bu=
g
>> to penetrate trust boundaries.
>>
>>> Whether this is a security issue...  I don't know, but it is a DoS.
>>
>> I'm not sure whether feeding untrusted images to QEMU is a good idea i=
n
>> general --- there's so much that could go wrong.  How hardened against=

>> abuse are out block drivers?
>>
>> I figure what distinguishes this case is how utterly trivial creating =
a
>> "bad" image is.
>=20
> Consider that you can already create a qcow2 image with a backing file
> of /etc/shadow.

If you cannot access this file, then it should just be an error and not
crash qemu.

If you can access this file, that's your own fault for bad permissions.

> Or create a qcow2 image many EB in size that causes QEMU=20
> to allocate massive amounts of RAM and/or burn CPU time, and so on.

That would be the qcow2 driver's fault.  We do try to open only images
which are sane.

And memory allocation failures should be handled gracefully, so the VM
shouldn't crash.  Well, at least qcow2 does its best, what Linux makes
of it, who knows.  (e.g. it may assign the memory to qemu and then the
OOM killer may crash it later)

> IOW, mgmt apps should never pass untrusted images to QEMU.  Crashing is=

> just one of many bad things, and probably not the worst that can happen=
=2E
>=20
> They need to do validation upfront in some manner if receiving an=20
> untrustworthy image. Openstack does this by running qemu-img, with=20
> limits set on virutal memory size, CPU time, and then rejecting any=20
> image with a backing file from being used at all.
>=20
>> Anyway, you are the block layer maintainers, so you get to decide
>> whether to give this the full security bug treatment.  I'm merely the
>> clown who broke it %-/
>=20
> Accepting an image with any backing file at all from an untrusted user
> would be a flaw in the layered management app itself, not QEMU.
>=20
> So I think it would only be considered a security bug in QEMU if there =
was=20
> a way for an unprivileged user to trick QEMU into writing malformed JSO=
N
> into an otherwise trusted image.

Not making it a security bug makes me happy, of course, but I don't
quite agree that qemu is not to blame if you pass it some image which
makes it crash.

Max


--zUyYo1GwUKqU7bjsBgwyKV1oALIHUGqlz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlw2DQQACgkQ9AfbAGHV
z0DM0Qf/TPiDMmTECaYWyybnbguCuagtBIw9X7e4Fibd3ico7buYt8Ku8NR5hht5
KCMMFgPfw/3y36H4qteBqbZqPdZ6eaQ8QVltxLkPu0FtKLQM19ln2YfzpankNGe/
XURYGFPFJzhw4APhpvG5lZx6Qd2e6cFOwokAE+uFXDLrBo1KwDtwS1Cqm/f22p+h
MMzUQqtYeF5TNhndCjGgnpOTinvobpn5RispkBz3l3RM0/lXKABjjFNJXe/Cg76G
AmRMY9w7zfRJ5wyY8TPC3GeF/VtdUdkf54ui9w8eNd6tqOJp8ODInRR3qk7VYWkR
v1jKG6kPOnyBDhiINU8RlvBGtO1czg==
=KN6Q
-----END PGP SIGNATURE-----

--zUyYo1GwUKqU7bjsBgwyKV1oALIHUGqlz--
