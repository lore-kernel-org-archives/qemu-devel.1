Received: from eggs.gnu.org ([209.51.188.92]:53363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ghHCB-0007R4-Rf
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:59:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ghHC9-00075c-1l
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:59:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55452)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1ghHC8-00074X-AW
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:59:08 -0500
References: <20180906111107.30684-1-danielhb413@gmail.com>
	<47023eb5-41f1-1b60-1094-d607999e93b6@redhat.com>
	<20190109142140.GC4867@localhost.localdomain>
	<095e7b09-5d84-3437-782d-97fa6ca372ee@redhat.com>
	<20190109144818.GE4867@localhost.localdomain>
	<756f6997-cb66-a82b-ae13-babb0e5fa827@redhat.com>
	<20190109151348.GG4867@localhost.localdomain>
	<a6f406c1-6154-bc25-bde3-68e7ff62c527@redhat.com>
	<20190109164529.GH4867@localhost.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <5f9d7d0e-c503-78f9-ca42-c251b91438d1@redhat.com>
Date: Wed, 9 Jan 2019 17:58:58 +0100
MIME-Version: 1.0
In-Reply-To: <20190109164529.GH4867@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1R3SxyH0tj5nUPSY07lSyEcAdy99WN9s5"
Subject: Re: [Qemu-devel] [PATCH v2 0/3] HMP/snapshot changes - do not use
 ID anymore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org, dgilbert@redhat.com, armbru@redhat.com, muriloo@linux.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1R3SxyH0tj5nUPSY07lSyEcAdy99WN9s5
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org,
 dgilbert@redhat.com, armbru@redhat.com, muriloo@linux.ibm.com
Message-ID: <5f9d7d0e-c503-78f9-ca42-c251b91438d1@redhat.com>
Subject: Re: [PATCH v2 0/3] HMP/snapshot changes - do not use ID anymore
References: <20180906111107.30684-1-danielhb413@gmail.com>
 <47023eb5-41f1-1b60-1094-d607999e93b6@redhat.com>
 <20190109142140.GC4867@localhost.localdomain>
 <095e7b09-5d84-3437-782d-97fa6ca372ee@redhat.com>
 <20190109144818.GE4867@localhost.localdomain>
 <756f6997-cb66-a82b-ae13-babb0e5fa827@redhat.com>
 <20190109151348.GG4867@localhost.localdomain>
 <a6f406c1-6154-bc25-bde3-68e7ff62c527@redhat.com>
 <20190109164529.GH4867@localhost.localdomain>
In-Reply-To: <20190109164529.GH4867@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 09.01.19 17:45, Kevin Wolf wrote:
> Am 09.01.2019 um 17:27 hat Max Reitz geschrieben:
>> On 09.01.19 16:13, Kevin Wolf wrote:
>>> Am 09.01.2019 um 15:54 hat Max Reitz geschrieben:
>>>> On 09.01.19 15:48, Kevin Wolf wrote:
>>>>> Am 09.01.2019 um 15:27 hat Max Reitz geschrieben:
>>>>>> On 09.01.19 15:21, Kevin Wolf wrote:
>>>>>>> Am 09.01.2019 um 15:10 hat Max Reitz geschrieben:
>>>>>>>> On 06.09.18 13:11, Daniel Henrique Barboza wrote:
>>>>>>>>> changes in v2:
>>>>>>>>> - removed the "RFC" marker;
>>>>>>>>> - added a new patch (patch 2) that removes
>>>>>>>>> bdrv_snapshot_delete_by_id_or_name from the code;
>>>>>>>>> - made changes in patch 1 as suggested by Murilo;
>>>>>>>>> - previous patch set link:
>>>>>>>>> https://lists.gnu.org/archive/html/qemu-devel/2018-08/msg04658.=
html
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> It is not uncommon to see bugs being opened by testers that att=
empt to
>>>>>>>>> create VM snapshots using HMP. It turns out that "0" and "1" ar=
e quite
>>>>>>>>> common snapshot names and they trigger a lot of bugs. I gave an=
 example
>>>>>>>>> in the commit message of patch 1, but to sum up here: QEMU trea=
ts the
>>>>>>>>> input of savevm/loadvm/delvm sometimes as 'ID', sometimes as 'n=
ame'. It
>>>>>>>>> is documented as such, but this can lead to strange situations.=

>>>>>>>>>
>>>>>>>>> Given that it is strange for an API to consider a parameter to =
be 2 fields
>>>>>>>>> at the same time, and inadvently treating them as one or the ot=
her, and
>>>>>>>>> that removing the ID field is too drastic, my idea here is to k=
eep the
>>>>>>>>> ID field for internal control, but do not let the user set it.
>>>>>>>>>
>>>>>>>>> I guess there's room for discussion about considering this chan=
ge an API
>>>>>>>>> change or not. It doesn't affect users of HMP and it doesn't af=
fect Libvirt,
>>>>>>>>> but simplifying the meaning of the parameters of savevm/loadvm/=
delvm.
>>>>>>>>
>>>>>>>> (Yes, very late reply, I'm sorry...)
>>>>>>>>
>>>>>>>> I do think it affects users of HMP, because right now you can de=
lete
>>>>>>>> snapshots with their ID, and after this series you cannot.
>>>>>>>
>>>>>>> Can there be snapshots that can't be identified by a snapshot nam=
e, but
>>>>>>> only by their ID?
>>>>>>
>>>>>> I don't know, but what I meant is that if you have scripts to do a=
ll
>>>>>> this, you might have to adjust them with this change.
>>>>>
>>>>> That's what the H in HMP means.
>>>>>
>>>>>>>> I think we had a short discussion about just disallowing numeric=

>>>>>>>> snapshot names.  How bad would that be?
>>>>>>>
>>>>>>> It would be incompatible with existing images and result in a mor=
e
>>>>>>> complex snapshot identifier resolution. Why would it be any bette=
r?
>>>>>>
>>>>>> It wouldn't be incompatible with existing images if we'd just disa=
llow
>>>>>> creating such snapshots.  I don't see how the identifier resolutio=
n
>>>>>> would be more complex.
>>>>>>
>>>>>> I don't know if it'd be better.  I'd just find it simpler (for us,=
 that
>>>>>> is -- for users, I'm not sure).
>>>>>
>>>>> Identifier resolution A:
>>>>> - Find a snapshot that has the given identifier as a name
>>>>> - If no such snapshot exists, it is an error
>>>>>
>>>>> Identifier resolution B:
>>>>> - If the identifier is a number, find a snapshot that has the given=

>>>>>   identifier as its ID
>>>>> - If the identifier is not a number, find a snapshot that has the g=
iven
>>>>>   identifier as a name
>>>>> - If no such snapshot exists, it is an error
>>>>
>>>> No, my idea was to keep the resolution the same as it is; just to fo=
rbid
>>>> creating new snapshots with numeric names.  This would prevent users=

>>>> from getting into the whole situation.
>>>
>>> That's the version with an even more complex resolution method C. :-)=

>>
>> How so if the resolution method stays the same?  Because it already is=

>> too complex?
>>
>> If so, yes, that is an argument.  I was arguing for the simplest patch=

>> instead of the simplest code, true.
>=20
> Yes, because it already is too complex. Not even necessarily the code
> (even though that's true as well), but most importantly the interface.
>=20
>>> I actually think the current behaviour is more confusing than helpful=
=2E
>>> Without looking into the code or trying it out, I couldn't even tell
>>> whether ID or name takes precedence if there is a matching snapshot f=
or
>>> both. Considering your proposal, it's probably the ID, but how should=
 a
>>> user know that? (If against all expectations documentation exists, it=

>>> doesn't count because nobody reads that.)
>>
>> It isn't more confusing than it is right now.  With my proposal, all
>> current images are simply as confusing as they are right now (I think =
ID
>> takes precedence, yes), but if you create new snapshots, it's clear,
>> since you simply cannot create names that could be IDs.
>=20
> I agree. But wasn't the goal of the patch to make it less confusing tha=
n
> it is right now?

My approach would make it less confusing, too, just not for old images.
 But if you have images lying around with numeric snapshot names,
chances are you must have realized at some point that the ID takes
precedence.

But of course my approach would have to have benefits over this series,
as the latter exists already.  Hm.  The interface and code would remain
more complex, so that's a bad point.

A good point is that I think it's the less dangerous incompatible
change.  What's the worst that can happen if we disallow giving numeric
names?  You get an error with something that used to work.  Ouch, but
not horrible.

What's the worst that could happen with this series?  You used to give
all of your snapshots numeric names, but somehow you were able to deal
with it by always using the IDs when specifying existing snapshots.[1]
Now the behavior is changed and the name takes precedence -- so maybe
you delete the wrong snapshot or revert to the wrong one.  That's not so
good.

[1] I admit that it's more reasonable to assume you were just lucky it
worked, because for every snapshot, its name just happened to match its
ID.  If so, changing behavior doesn't bite you.


So I'm unsure.  I agree that this series is probably what we would have
wanted from the start, but I don't know if the change isn't a bit
adventurous.

Max


--1R3SxyH0tj5nUPSY07lSyEcAdy99WN9s5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlw2KFIACgkQ9AfbAGHV
z0BpTQf+MtUSYbdbHdl5empFCHWik8yJkYWy/BAEBniPxP4bviqFKJE8Az4CLeFY
GxHF7gtdxIRF4yOwGma08vKbbzN3uiBD0vmjWoYle/xlCgjBAUOCG8IBrygZhSQL
UqNj9TdoXupysUnTWdRna4GqTtwbhPnl0nwBdSZx+WPWizycSvsuaoifdt9SesaQ
cskAK9JETsIgbvkVCcBltmWHr7fioKpT5Qpjv9OQIhtsQwx76HZQj1YBGPSLTsAe
RBTyQMKOrFslxPDGf8+tsDsxCjNNh+O9g3tnB3AGGAXcmCy0kudcR+m5Za9tXlaN
SuWDDU73HfvjV9gKHQukfmBN4PqtYQ==
=dsbI
-----END PGP SIGNATURE-----

--1R3SxyH0tj5nUPSY07lSyEcAdy99WN9s5--
