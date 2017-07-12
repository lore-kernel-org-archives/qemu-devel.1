Received: from eggs.gnu.org ([2001:4830:134:3::10]:54201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dVL0K-0000l2-TS
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 13:00:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dVL0J-00087R-GB
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 13:00:48 -0400
References: <20170511182705.23648-1-jsnow@redhat.com>
	<19a665be-12c2-2876-0438-08327d94473e@redhat.com>
	<6b8d6c51-d849-75fa-59c1-dd256471c0dc@redhat.com>
	<815d2530-7767-0f1d-d9d4-3b6c8de0260b@redhat.com>
	<de0c59c3-2516-db0e-1a02-99b3ea0a0a65@redhat.com>
	<ea023ed7-4925-b338-8636-435103ce757b@redhat.com>
	<20170516081703.GB4438@noname.redhat.com>
	<48a7f2f9-5f79-f944-71ce-2a988e5d468b@redhat.com>
	<dd12265d-e764-34ee-8d1e-504f27b78614@redhat.com>
	<20170712145634.GF4917@noname.str.redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <5b0adf36-60c4-192c-4f30-a8c1d681f50d@redhat.com>
Date: Wed, 12 Jul 2017 19:00:34 +0200
MIME-Version: 1.0
In-Reply-To: <20170712145634.GF4917@noname.str.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kNEcor4M8WuDV0jO11CJCaReNdJACTnI3"
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
To: Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kNEcor4M8WuDV0jO11CJCaReNdJACTnI3
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Message-ID: <5b0adf36-60c4-192c-4f30-a8c1d681f50d@redhat.com>
Subject: Re: [PATCH v4] qemu-img: Check for backing image if specified during
 create
References: <20170511182705.23648-1-jsnow@redhat.com>
 <19a665be-12c2-2876-0438-08327d94473e@redhat.com>
 <6b8d6c51-d849-75fa-59c1-dd256471c0dc@redhat.com>
 <815d2530-7767-0f1d-d9d4-3b6c8de0260b@redhat.com>
 <de0c59c3-2516-db0e-1a02-99b3ea0a0a65@redhat.com>
 <ea023ed7-4925-b338-8636-435103ce757b@redhat.com>
 <20170516081703.GB4438@noname.redhat.com>
 <48a7f2f9-5f79-f944-71ce-2a988e5d468b@redhat.com>
 <dd12265d-e764-34ee-8d1e-504f27b78614@redhat.com>
 <20170712145634.GF4917@noname.str.redhat.com>
In-Reply-To: <20170712145634.GF4917@noname.str.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 2017-07-12 16:56, Kevin Wolf wrote:
> Am 12.07.2017 um 16:42 hat Eric Blake geschrieben:
>> On 05/17/2017 07:38 AM, Max Reitz wrote:
>>
>>>>>>>>>> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1213786
>>>>>>>>>>
>>>>>>>>>> Or, rather, force the open of a backing image if one was speci=
fied
>>>>>>>>>> for creation. Using a similar -unsafe option as rebase, allow =
qemu-img
>>>>>>>>>> to ignore the backing file validation if possible.
>>>>>>>>>>
>>>>>>>>
>>
>>>>> I suspect this is because the backing file is opened somewhere and
>>>>> trying to open it breaks now with the locking series applied.
>>>>
>>>> I think we can legitimately set force-shared=3Don for opening the ba=
cking
>>>> file when testing whether the file exists.
>>>
>>> For testing whether the file exists, probably. I wouldn't call it
>>> legitimately because I don't like making that the default at all, but=
 it
>>> should work.
>>>
>>> But then we have to differentiate between testing whether the file
>>> exists and opening it to read its size; I'm even more wary regarding =
the
>>> latter.
>>>
>>> All in all, I've stated my opinion on this matter on IRC: I don't kno=
w
>>> how much we need this patch. It's nice to have, it's convenient to kn=
ow
>>> you have mistyped the backing filename before you try to use the imag=
e
>>> in qemu, but it's not critical. I don't consider the current behavior=
 a
>>> bug per-se, it's just counterintuitive behavior (that will not cut yo=
ur
>>> head off if you don't know it, though!).
>>>
>>
>> The fact that this topic came up on the mailing list again means we
>> should probably consider something along these lines for 2.10.
>>
>>> (Also, we have a lot of counterintuitive behavior. See this:
>>>
>>> $ qemu-img create -f qcow2 sub/backing.qcow2 64M
>>> Formatting 'sub/backing.qcow2', fmt=3Dqcow2 size=3D67108864 encryptio=
n=3Doff
>>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
>>> $ qemu-img create -f qcow2 -b sub/backing.qcow2 sub/top.qcow2
>>> qemu-img: sub/top.qcow2: Could not open 'sub/sub/backing.qcow2': No s=
uch
>>> file or directory
>>>
>>> Yeah, sure, you'll know after you've done the mistake once. But the s=
ame
>>> applies here, too, doesn't it...?)
>>>
>>> So for me, it's a question of convenience: How much does the current
>>> behavior annoy users? How much annoyance will changing the behavior
>>> bring? I'm not (or rather, no longer) convinced the former outweighs =
the
>>> latter, especially since it means having to change management tools
>>> (which create external snapshots with qemu-img create while the backi=
ng
>>> image is in use by qemu).
>>>
>>> If you think otherwise, well, you're the main maintainer. :-)
>>>
>>> Max
>>>
>>>
>>> PS: Can there be a middle ground? Like just printing a warning if the=

>>> backing file cannot be opened and we don't absolutely have to?
>>
>> Middle ground may be harder, but may be nicer (especially since we are=

>> talking about tightening behavior, making things that used to work now=

>> fail is not nice if there is not a transition period where it first ju=
st
>> warns).
>=20
> We can do the nowadays usual thing: Add a -u option, print a deprecatio=
n
> warning if we don't have -u and can't open the backing file, and put
> it into the list of things to remove in 3.0.

Works for me.

Max


--kNEcor4M8WuDV0jO11CJCaReNdJACTnI3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZZlWyEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQO9r
B/4gU4r8OW2L2bTqklgPRyODQMPjRl/fkKWgIfUWzc79dg9bKi7AuySfNR7uVSc3
bc8mZBmS350DjUrswUGM/uTw7CpIitC2m3Zog8yVpsO5sKyFZHtwlLhs/bZHMcXG
Tct0ihQeEGrixm8h5oRa/O/KqYo6BeNUqA9Jaub717belDcZOjnON3PBlesmA4s0
SGkMhF7hpsRrwmosXwQ51mIYva2qbnTXD5BZOSGouxQTZYmTKDmvG25Qh5rRhkXl
y0kvJz1BucdL2abuF1ueT6p7uIOvwaErdDz+Q3CukvFU/C/WmO0MmWD2PG/LI78J
1uNEYss3bHQc55pvRXx3USiS
=MTSR
-----END PGP SIGNATURE-----

--kNEcor4M8WuDV0jO11CJCaReNdJACTnI3--
