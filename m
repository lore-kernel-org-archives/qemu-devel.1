Received: from eggs.gnu.org ([2001:4830:134:3::10]:55821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cZj20-0004RN-Th
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 13:56:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cZj1z-00060F-Ho
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 13:56:24 -0500
References: <20170126110435.2777-1-berrange@redhat.com>
	<20170126110435.2777-4-berrange@redhat.com>
	<20170126123530.GB23095@lemon.Home> <20170126132708.GB29127@redhat.com>
	<6a9aeec8-d4ee-a0aa-7e04-0ee4295fef80@redhat.com>
	<8a13c995-c094-2704-c770-214132b2d6cf@redhat.com>
	<20170201121658.GF3232@redhat.com>
	<c4d38998-b862-90e6-6c4b-4b96a8d17bb4@redhat.com>
	<20170201122854.GG3232@redhat.com>
	<37f445c0-c174-bca4-7073-7aa6c64046b0@redhat.com>
	<87bmul9hfc.fsf@dusky.pond.sub.org>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <d03de140-db6b-26ed-6cc9-958591843483@redhat.com>
Date: Fri, 3 Feb 2017 19:56:11 +0100
MIME-Version: 1.0
In-Reply-To: <87bmul9hfc.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ka3JQboPVNwu8kVxvga9qOTx2LDiJSgfe"
Subject: Re: [Qemu-devel] [PATCH v1 3/6] qemu-img: add support for -n arg to
 dd command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ka3JQboPVNwu8kVxvga9qOTx2LDiJSgfe
From: Max Reitz <mreitz@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Kevin Wolf
 <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Message-ID: <d03de140-db6b-26ed-6cc9-958591843483@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 3/6] qemu-img: add support for -n arg to
 dd command
References: <20170126110435.2777-1-berrange@redhat.com>
 <20170126110435.2777-4-berrange@redhat.com>
 <20170126123530.GB23095@lemon.Home> <20170126132708.GB29127@redhat.com>
 <6a9aeec8-d4ee-a0aa-7e04-0ee4295fef80@redhat.com>
 <8a13c995-c094-2704-c770-214132b2d6cf@redhat.com>
 <20170201121658.GF3232@redhat.com>
 <c4d38998-b862-90e6-6c4b-4b96a8d17bb4@redhat.com>
 <20170201122854.GG3232@redhat.com>
 <37f445c0-c174-bca4-7073-7aa6c64046b0@redhat.com>
 <87bmul9hfc.fsf@dusky.pond.sub.org>
In-Reply-To: <87bmul9hfc.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 02.02.2017 08:32, Markus Armbruster wrote:
> Max Reitz <mreitz@redhat.com> writes:
>=20
>> On 01.02.2017 13:28, Daniel P. Berrange wrote:
>>> On Wed, Feb 01, 2017 at 01:23:54PM +0100, Max Reitz wrote:
>>>> On 01.02.2017 13:16, Daniel P. Berrange wrote:
>>>>> On Wed, Feb 01, 2017 at 01:13:39PM +0100, Max Reitz wrote:
>>>>>> On 30.01.2017 19:37, Eric Blake wrote:
>>>>>>> On 01/26/2017 07:27 AM, Daniel P. Berrange wrote:
>>>>>>>> On Thu, Jan 26, 2017 at 08:35:30PM +0800, Fam Zheng wrote:
>>>>>>>>> On Thu, 01/26 11:04, Daniel P. Berrange wrote:
>>>>>>>>>> The -n arg to the convert command allows use of a pre-existing=
 image,
>>>>>>>>>> rather than creating a new image. This adds a -n arg to the dd=
 command
>>>>>>>>>> to get feature parity.
>>>>>>>>>
>>>>>>>>> I remember there was a discussion about changing qemu-img dd's =
default to a
>>>>>>>>> "conv=3Dnocreat" semantic, if so, "-n" might not be that useful=
=2E But that part
>>>>>>>>> hasn't made it into the tree, and I'm not sure which direction =
we should take.
>>>>>>>>> (Personally I think default to nocreat is a good idea).
>>>>>>>>
>>>>>>>> Use nocreat by default would be semantically different from real=
 "dd"
>>>>>>>> binary which feels undesirable if the goal is to make "qemu-img =
dd"
>>>>>>>> be as consistent with "dd" as possible.
>>>>>>>>
>>>>>>>> It would be trivial to rewrite this patch to add support for the=
 "conv"
>>>>>>>> option, allowing the user to explicitly give 'qemu-img dd conv=3D=
nocreat'
>>>>>>>> instead of my 'qemu-img dd -n' syntax, without changing default =
semantics.
>>>>>>>
>>>>>>> Adding 'conv=3Dnocreat' (and not '-n') feels like the right way t=
o me.
>>>>>>
>>>>>> The original idea was to make conv=3Dnocreat a mandatory option, I=
 think.
>>>>>> qemu-img was supposed error out if the user did not specify it.
>>>>>
>>>>> I'm not really seeing a benefit in doing that - it would just break=

>>>>> existing usage of qemu-img dd for no obvious benefit.
>>>>
>>>> Well... Is there existing usage?
>>>
>>> It shipped in 2.8.0 though, so imho that means we have to assume ther=
e
>>> are users, and thus additions must to be backwards compatible from no=
w
>>> on.
>>
>> Depends. I don't think there are too many users, so we could still
>> justify a change if there's a very good reason for it.
>>
>> I do agree that it's probably not a very good reason, though.
>>
>>>> The benefit would be that one could (should?) expect qemu-img dd to
>>>> behave on disk images as if they were block devices; and dd to a blo=
ck
>>>> device will not truncate or "recreate" it.
>>>>
>>>> If you don't give nocreat, it's thus a bit unclear whether you want =
to
>>>> delete and recreate the target or whether you want to write into it.=

>>>> Some may expect qemu-img dd to behave as if the target is a normal f=
ile
>>>> (delete and recreate it), others may expect it's treated like a bloc=
k
>>>> device (just write into it). If you force the user to specify nocrea=
t,
>>>> it would make the behavior clear.
>>>>
>>>> (And you can always delete+recreate the target with qemu-img create.=
)
>>>>
>>>> It's all a bit complicated. :-/
>>>
>>> If the goal is to be compatible with /usr/bin/dd then IIUC, the behav=
iour
>>> needs to be
>>>
>>>  - If target is a block device, then silently assume nocreat|notrunc
>>>    is set, even if not specified by user
>>>
>>>  - If target is a file, then silently create & truncate the file
>>>    unless nocreat or notrunc are set
>>
>> Yes. But you could easily argue that every image file is a "block devi=
ce".
>=20
> No.  /bin/dd treats exactly block special files as block special files,=

> so the qemu-img command that tries to behave like it should do, too.

*/usr*/bin/dd (O:-)) also treats qcow2 files like raw files.

> In case you say that's inconvenient: pretty much everything about dd's
> archaic user interface is inconvenient.  If you want convenient, roll
> your own.  If you want familiar, stick to the original.

I agree. But qemu-img dd already is not dd. It interprets disk image
files as virtual disks instead of as plain files. The question is
whether virtual disks are to be treated as block devices or as files.

I don't have a strong opinion on the matter. Either way will surprise
some people. The original issue was whether to make nocreat/notrunc a
mandatory option, so if we didn't have any backwards compatibility
issues, it would be the following two surprises:

(1) Don't make nocreat/notrunc mandatory (as it is now). Then people
    who expect qemu-img dd to treat image files as block devices will
    be surprised that all their data is gone. Bad.

(2) Make it mandatory. Then people who don't expect this (i.e.
    everyone) will be surprised about the error message "nocreat is
    mandatory, please use it." Then they will fix their command line
    and can proceed. Much less bad.

Of course, "much less bad" is offset by the fact that everyone is
affected. I think it's still less bad, though.

But we do have backwards compatibility to care about (at least a bit),
so I don't think it's worth changing the behavior now.


You may argue that actually nobody will be affected by (1). But I don't
think so. I personally usually use dd to copy something off or onto a
device file, often block devices. Disk images literally are block
devices in the guest. It is entirely conceivable that someone would (a)
associate dd with "copy things from/to block devices" and (b) assume
that *qemu*-img dd behaves as from the guest's perspective (where the
image is a block device).

That is because qemu-img dd does *not* view the image entirely from the
host's perspective. It does interpret the image file contents, i.e., it
does look at it from a guest's perspective in that regard.


I agree that qemu-img dd probably was a bad idea. I agree that we need
to make sure people know that it is basically a different interface of
qemu-img convert.

Yes, yes, I'll get to write the conversion and man page updates when I
find the time to do so.

Max


--ka3JQboPVNwu8kVxvga9qOTx2LDiJSgfe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliU0ksSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ACWQH/jR7zBps80CjL/vfz/9KXrgSsgmE4e+X
P7pbDKtovLs+b1uGOEBObryMrmcjFS8oHnwVwb+8J1coXn66fFDHCSXKg8TQuzu2
plw0Q8h6BoXXuo7eEPX35fxizXzO0GmE2earl8YYDOOH2Ww5Uadp7I3BlI/1Wtn+
E8he0m4qA/VHkR9TnygwA9SyS9ZPx1EdsuzIs3+5drcRCTctPOtvtrZArb7IL0k/
a4M5GS4KjTTLfwKEJCJwMXa3KxCLvcyVADY01/DaRrl2WezOFehf2MzdxmiVbRTV
lM3dOEr4hjmC3vTPZIL0xmznJA2KKHkiq0iL6yKGKBeFCO3gkJZsK7A=
=HzzQ
-----END PGP SIGNATURE-----

--ka3JQboPVNwu8kVxvga9qOTx2LDiJSgfe--
