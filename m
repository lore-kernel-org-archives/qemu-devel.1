Received: from eggs.gnu.org ([209.51.188.92]:53342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ghFFZ-0000ia-0X
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 09:54:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ghFFX-0005sm-Oy
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 09:54:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40308)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1ghFFV-0005pp-Ms
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 09:54:31 -0500
References: <20180906111107.30684-1-danielhb413@gmail.com>
	<47023eb5-41f1-1b60-1094-d607999e93b6@redhat.com>
	<20190109142140.GC4867@localhost.localdomain>
	<095e7b09-5d84-3437-782d-97fa6ca372ee@redhat.com>
	<20190109144818.GE4867@localhost.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <756f6997-cb66-a82b-ae13-babb0e5fa827@redhat.com>
Date: Wed, 9 Jan 2019 15:54:06 +0100
MIME-Version: 1.0
In-Reply-To: <20190109144818.GE4867@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5eKuNbJlofeJdgAdGqCdkgJ0ND1p7IXg2"
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
--5eKuNbJlofeJdgAdGqCdkgJ0ND1p7IXg2
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org,
 dgilbert@redhat.com, armbru@redhat.com, muriloo@linux.ibm.com
Message-ID: <756f6997-cb66-a82b-ae13-babb0e5fa827@redhat.com>
Subject: Re: [PATCH v2 0/3] HMP/snapshot changes - do not use ID anymore
References: <20180906111107.30684-1-danielhb413@gmail.com>
 <47023eb5-41f1-1b60-1094-d607999e93b6@redhat.com>
 <20190109142140.GC4867@localhost.localdomain>
 <095e7b09-5d84-3437-782d-97fa6ca372ee@redhat.com>
 <20190109144818.GE4867@localhost.localdomain>
In-Reply-To: <20190109144818.GE4867@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 09.01.19 15:48, Kevin Wolf wrote:
> Am 09.01.2019 um 15:27 hat Max Reitz geschrieben:
>> On 09.01.19 15:21, Kevin Wolf wrote:
>>> Am 09.01.2019 um 15:10 hat Max Reitz geschrieben:
>>>> On 06.09.18 13:11, Daniel Henrique Barboza wrote:
>>>>> changes in v2:
>>>>> - removed the "RFC" marker;
>>>>> - added a new patch (patch 2) that removes
>>>>> bdrv_snapshot_delete_by_id_or_name from the code;
>>>>> - made changes in patch 1 as suggested by Murilo;
>>>>> - previous patch set link:
>>>>> https://lists.gnu.org/archive/html/qemu-devel/2018-08/msg04658.html=

>>>>>
>>>>>
>>>>> It is not uncommon to see bugs being opened by testers that attempt=
 to
>>>>> create VM snapshots using HMP. It turns out that "0" and "1" are qu=
ite
>>>>> common snapshot names and they trigger a lot of bugs. I gave an exa=
mple
>>>>> in the commit message of patch 1, but to sum up here: QEMU treats t=
he
>>>>> input of savevm/loadvm/delvm sometimes as 'ID', sometimes as 'name'=
=2E It
>>>>> is documented as such, but this can lead to strange situations.
>>>>>
>>>>> Given that it is strange for an API to consider a parameter to be 2=
 fields
>>>>> at the same time, and inadvently treating them as one or the other,=
 and
>>>>> that removing the ID field is too drastic, my idea here is to keep =
the
>>>>> ID field for internal control, but do not let the user set it.
>>>>>
>>>>> I guess there's room for discussion about considering this change a=
n API
>>>>> change or not. It doesn't affect users of HMP and it doesn't affect=
 Libvirt,
>>>>> but simplifying the meaning of the parameters of savevm/loadvm/delv=
m.
>>>>
>>>> (Yes, very late reply, I'm sorry...)
>>>>
>>>> I do think it affects users of HMP, because right now you can delete=

>>>> snapshots with their ID, and after this series you cannot.
>>>
>>> Can there be snapshots that can't be identified by a snapshot name, b=
ut
>>> only by their ID?
>>
>> I don't know, but what I meant is that if you have scripts to do all
>> this, you might have to adjust them with this change.
>=20
> That's what the H in HMP means.
>=20
>>>> I think we had a short discussion about just disallowing numeric
>>>> snapshot names.  How bad would that be?
>>>
>>> It would be incompatible with existing images and result in a more
>>> complex snapshot identifier resolution. Why would it be any better?
>>
>> It wouldn't be incompatible with existing images if we'd just disallow=

>> creating such snapshots.  I don't see how the identifier resolution
>> would be more complex.
>>
>> I don't know if it'd be better.  I'd just find it simpler (for us, tha=
t
>> is -- for users, I'm not sure).
>=20
> Identifier resolution A:
> - Find a snapshot that has the given identifier as a name
> - If no such snapshot exists, it is an error
>=20
> Identifier resolution B:
> - If the identifier is a number, find a snapshot that has the given
>   identifier as its ID
> - If the identifier is not a number, find a snapshot that has the given=

>   identifier as a name
> - If no such snapshot exists, it is an error

No, my idea was to keep the resolution the same as it is; just to forbid
creating new snapshots with numeric names.  This would prevent users
from getting into the whole situation.

Max


--5eKuNbJlofeJdgAdGqCdkgJ0ND1p7IXg2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlw2Cw4ACgkQ9AfbAGHV
z0Ar7Qf9FMihpzSIjPW8PAwLH4/EJkm7MG67s7GIeBjpDKh4BKMyrLsd2He04NFP
z43iHuWjFICL+k3zvkNW7BJ26UBnbBjJq0Jm3iNg4vuAYFfVdArpAvKWVdEkLHHa
/NaGf48iUOZw0QkmoTfMlEPTu+LNShf3jpclqHWp4tzcycBZCoHBiZiRxPQEcq5z
pU/+iN+sGTPvUutvk0hExxqe1IebncQOFqsMvSKAvTe936D2P0xryGxLya96Zlna
rR8XBQhdB1x55VOaIvrTDRw9SvP8A3yRlqBdeKihh62/qIRz4X3JNLuYOQAoSLhd
0JMg4aFv6rk30hVJgdyUbecmGo2FVw==
=tADK
-----END PGP SIGNATURE-----

--5eKuNbJlofeJdgAdGqCdkgJ0ND1p7IXg2--
