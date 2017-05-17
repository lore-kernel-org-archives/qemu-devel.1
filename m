Received: from eggs.gnu.org ([2001:4830:134:3::10]:41864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dAyEJ-0005uU-Gt
	for qemu-devel@nongnu.org; Wed, 17 May 2017 08:39:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dAyEH-0008Sk-TQ
	for qemu-devel@nongnu.org; Wed, 17 May 2017 08:39:03 -0400
References: <20170511182705.23648-1-jsnow@redhat.com>
	<19a665be-12c2-2876-0438-08327d94473e@redhat.com>
	<6b8d6c51-d849-75fa-59c1-dd256471c0dc@redhat.com>
	<815d2530-7767-0f1d-d9d4-3b6c8de0260b@redhat.com>
	<de0c59c3-2516-db0e-1a02-99b3ea0a0a65@redhat.com>
	<ea023ed7-4925-b338-8636-435103ce757b@redhat.com>
	<20170516081703.GB4438@noname.redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <48a7f2f9-5f79-f944-71ce-2a988e5d468b@redhat.com>
Date: Wed, 17 May 2017 14:38:42 +0200
MIME-Version: 1.0
In-Reply-To: <20170516081703.GB4438@noname.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ejewoIFrA7Qk8Ge9Ss2rtjW1p2kh4QUJH"
Subject: Re: [Qemu-devel] [PATCH v4] qemu-img: Check for backing image if
 specified during create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: John Snow <jsnow@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ejewoIFrA7Qk8Ge9Ss2rtjW1p2kh4QUJH
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: John Snow <jsnow@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Message-ID: <48a7f2f9-5f79-f944-71ce-2a988e5d468b@redhat.com>
Subject: Re: [PATCH v4] qemu-img: Check for backing image if specified during
 create
References: <20170511182705.23648-1-jsnow@redhat.com>
 <19a665be-12c2-2876-0438-08327d94473e@redhat.com>
 <6b8d6c51-d849-75fa-59c1-dd256471c0dc@redhat.com>
 <815d2530-7767-0f1d-d9d4-3b6c8de0260b@redhat.com>
 <de0c59c3-2516-db0e-1a02-99b3ea0a0a65@redhat.com>
 <ea023ed7-4925-b338-8636-435103ce757b@redhat.com>
 <20170516081703.GB4438@noname.redhat.com>
In-Reply-To: <20170516081703.GB4438@noname.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 2017-05-16 10:17, Kevin Wolf wrote:
> Am 15.05.2017 um 21:17 hat Max Reitz geschrieben:
>> On 2017-05-15 20:41, Max Reitz wrote:
>>> On 2017-05-12 21:47, John Snow wrote:
>>>>
>>>>
>>>> On 05/12/2017 03:46 PM, Eric Blake wrote:
>>>>> On 05/12/2017 01:07 PM, Max Reitz wrote:
>>>>>> On 2017-05-11 20:27, John Snow wrote:
>>>>>>> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1213786
>>>>>>>
>>>>>>> Or, rather, force the open of a backing image if one was specifie=
d
>>>>>>> for creation. Using a similar -unsafe option as rebase, allow qem=
u-img
>>>>>>> to ignore the backing file validation if possible.
>>>>>>>
>>>>>
>>>>>>> +++ b/block.c
>>>>>>> @@ -4275,37 +4275,37 @@ void bdrv_img_create(const char *filename=
, const char *fmt,
>>>>>>>      // The size for the image must always be specified, with one=
 exception:
>>>>>>>      // If we are using a backing file, we can obtain the size fr=
om there
>>>>>>>      size =3D qemu_opt_get_size(opts, BLOCK_OPT_SIZE, 0);
>>>>>>> -    if (size =3D=3D -1) {
>>>>>>
>>>>>> "Hang on, why should this be -1 when the defval is 0? Where does t=
he -1
>>>>>> come from?"
>>>>>> "..."
>>>>>> "Oh, the option exists and is set to -1? Why is that?"
>>>>>> "..."
>>>>>> "Oh, because this function always sets it itself, and because @img=
_size
>>>>>> is set to (uint64_t)-1."
>>>>>
>>>>> I had pretty much the same conversation on my v1 review.
>>>>> https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg01097.html=

>>>>>
>>>>>>
>>>>>> First, I won't start with how signed integer overflow is
>>>>>> implementation-defined in C because I hope you have thrashed that =
out
>>>>>> with Eric (I hope that "to thrash out" is a good translation for
>>>>>> "auskaspern" (lit. "to buffoon out").).
>>>>>
>>>>> Sounds like a reasonable choice of words, even if I don't speak the=

>>>>> counterpart language to validate your translation.
>>>>>
>>>>> (uint64_t)-1 is well-defined in C (so I think we're just fine here)=
=2E But
>>>>> (int64_t)UINT64_MAX is where signed integer overflow does indeed th=
row
>>>>> wrinkles at you.
>>>
>>> We're not really fine because that conversion happens when the result=
 of
>>> qemu_opt_get_size() (a uint64_t) is stored in size (an int64_t).
>>>
>>>>> I seem to recall that qemu has chosen to use compiler flags and/or
>>>>> assumptions that we are using 2s-complement arithmetic with sane
>>>>> behavior (that is, tighter behavior than the bare minimum that C
>>>>> requires), because it was easier than auditing our code for strict =
C
>>>>> compliance on border cases of conversions from unsigned to signed t=
hat
>>>>> trigger undefined behavior.  But again, I don't think it affects th=
is
>>>>> patch (where our conversion is only from signed to unsigned, and th=
at is
>>>>> well-defined behavior).
>>>
>>> Right. Which is why I said I won't even start on it, but of course I
>>> did. O:-)
>>>
>>>>>> Second, well, at least we should put -1 as the default value here,=
 then.
>>>>>
>>>>> Indeed, now that two reviewers have tripped on it,
>>>>> qemu_opt_get_size(,,-1) would be nicer.
>>>>>
>>>>>>
>>>>>> Not strictly your fault or something that you need to fix, but it =
is
>>>>>> just a single line in the vicinity...
>>>>>>
>>>>>> Let me know if you want to address this, for now I'll leave a
>>>>>>
>>>>>> Reviewed-by: Max Reitz <mreitz@redhat.com>
>>>>>>
>>>>>> here if you don't want to.
>>>>>
>>>>> I'm okay whether you want to squash that fix into this patch, or wh=
ether
>>>>> you do it as a separate followup patch.
>>>>>
>>>>
>>>> I had considered the issue separate; but you're welcome to either wr=
ite
>>>> a patch or squish it into this one, I'm not going to be picky.
>>>
>>> Yep, it is a separate issue, just related. :-)
>>>
>>> But since you and Eric agree, I've squashed it in and thus I'm more t=
han
>>> glad to thank you very much and announce this patch as applied to my
>>> block branch:
>>>
>>> https://github.com/XanClic/qemu/commits/block
>>
>> ...well, so much for that. I'll have to unstage it again because it
>> breaks a bunch of iotests (41 85 96 118 139 141 144 155 156) due to
>> failing to acquire image locks. :-/
>>
>> I suspect this is because the backing file is opened somewhere and
>> trying to open it breaks now with the locking series applied.
>=20
> I think we can legitimately set force-shared=3Don for opening the backi=
ng
> file when testing whether the file exists.

For testing whether the file exists, probably. I wouldn't call it
legitimately because I don't like making that the default at all, but it
should work.

But then we have to differentiate between testing whether the file
exists and opening it to read its size; I'm even more wary regarding the
latter.

All in all, I've stated my opinion on this matter on IRC: I don't know
how much we need this patch. It's nice to have, it's convenient to know
you have mistyped the backing filename before you try to use the image
in qemu, but it's not critical. I don't consider the current behavior a
bug per-se, it's just counterintuitive behavior (that will not cut your
head off if you don't know it, though!).

(Also, we have a lot of counterintuitive behavior. See this:

$ qemu-img create -f qcow2 sub/backing.qcow2 64M
Formatting 'sub/backing.qcow2', fmt=3Dqcow2 size=3D67108864 encryption=3D=
off
cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
$ qemu-img create -f qcow2 -b sub/backing.qcow2 sub/top.qcow2
qemu-img: sub/top.qcow2: Could not open 'sub/sub/backing.qcow2': No such
file or directory

Yeah, sure, you'll know after you've done the mistake once. But the same
applies here, too, doesn't it...?)

So for me, it's a question of convenience: How much does the current
behavior annoy users? How much annoyance will changing the behavior
bring? I'm not (or rather, no longer) convinced the former outweighs the
latter, especially since it means having to change management tools
(which create external snapshots with qemu-img create while the backing
image is in use by qemu).

If you think otherwise, well, you're the main maintainer. :-)

Max


PS: Can there be a middle ground? Like just printing a warning if the
backing file cannot be opened and we don't absolutely have to?


--ejewoIFrA7Qk8Ge9Ss2rtjW1p2kh4QUJH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZHERTEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQJxy
B/9YtftgfvA5bYpBTnXOkJLsmPnHoC8jjnOsiPpthSZzeQqIphyMRy3uB/pKMsGd
5ZQjapC4h9GCP/j9zkGSdC1IIaVIPWOgRkWT+ZXBh5RCXqTCudw/FRuGD+AtDi+a
igk8TMuS4XdOorZ2LrzIqIEghXdwIameJ+0Szc63HT53KhyUEsx+jhnJ6CgSk/rN
Y/aHfPkkUa+Op94w1xCv35wMtEId/AkbmhXT+8V23B5ohTETuveWXeSli6A7O3Mq
Ukl66lEikPehD/FPhY/mB9T7k8TtdqI8Hfkq5ZRJYbDawN/MSGOEWONzNMoy04pA
VzTMvjGPEkqqsml19SuaNjrq
=V1/H
-----END PGP SIGNATURE-----

--ejewoIFrA7Qk8Ge9Ss2rtjW1p2kh4QUJH--
