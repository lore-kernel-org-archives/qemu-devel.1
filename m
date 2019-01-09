Received: from eggs.gnu.org ([209.51.188.92]:38668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ghEpO-000754-CR
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 09:27:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ghEpM-0007si-Hi
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 09:27:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34266)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1ghEpJ-0007mY-Tn
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 09:27:28 -0500
References: <20180906111107.30684-1-danielhb413@gmail.com>
	<47023eb5-41f1-1b60-1094-d607999e93b6@redhat.com>
	<20190109142140.GC4867@localhost.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <095e7b09-5d84-3437-782d-97fa6ca372ee@redhat.com>
Date: Wed, 9 Jan 2019 15:27:11 +0100
MIME-Version: 1.0
In-Reply-To: <20190109142140.GC4867@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="To9k9ZgKjYC5sqYOKBZJbP0tZs2xwwTz6"
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
--To9k9ZgKjYC5sqYOKBZJbP0tZs2xwwTz6
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org,
 dgilbert@redhat.com, armbru@redhat.com, muriloo@linux.ibm.com
Message-ID: <095e7b09-5d84-3437-782d-97fa6ca372ee@redhat.com>
Subject: Re: [PATCH v2 0/3] HMP/snapshot changes - do not use ID anymore
References: <20180906111107.30684-1-danielhb413@gmail.com>
 <47023eb5-41f1-1b60-1094-d607999e93b6@redhat.com>
 <20190109142140.GC4867@localhost.localdomain>
In-Reply-To: <20190109142140.GC4867@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 09.01.19 15:21, Kevin Wolf wrote:
> Am 09.01.2019 um 15:10 hat Max Reitz geschrieben:
>> On 06.09.18 13:11, Daniel Henrique Barboza wrote:
>>> changes in v2:
>>> - removed the "RFC" marker;
>>> - added a new patch (patch 2) that removes
>>> bdrv_snapshot_delete_by_id_or_name from the code;
>>> - made changes in patch 1 as suggested by Murilo;
>>> - previous patch set link:
>>> https://lists.gnu.org/archive/html/qemu-devel/2018-08/msg04658.html
>>>
>>>
>>> It is not uncommon to see bugs being opened by testers that attempt t=
o
>>> create VM snapshots using HMP. It turns out that "0" and "1" are quit=
e
>>> common snapshot names and they trigger a lot of bugs. I gave an examp=
le
>>> in the commit message of patch 1, but to sum up here: QEMU treats the=

>>> input of savevm/loadvm/delvm sometimes as 'ID', sometimes as 'name'. =
It
>>> is documented as such, but this can lead to strange situations.
>>>
>>> Given that it is strange for an API to consider a parameter to be 2 f=
ields
>>> at the same time, and inadvently treating them as one or the other, a=
nd
>>> that removing the ID field is too drastic, my idea here is to keep th=
e
>>> ID field for internal control, but do not let the user set it.
>>>
>>> I guess there's room for discussion about considering this change an =
API
>>> change or not. It doesn't affect users of HMP and it doesn't affect L=
ibvirt,
>>> but simplifying the meaning of the parameters of savevm/loadvm/delvm.=

>>
>> (Yes, very late reply, I'm sorry...)
>>
>> I do think it affects users of HMP, because right now you can delete
>> snapshots with their ID, and after this series you cannot.
>=20
> Can there be snapshots that can't be identified by a snapshot name, but=

> only by their ID?

I don't know, but what I meant is that if you have scripts to do all
this, you might have to adjust them with this change.

>> I think we had a short discussion about just disallowing numeric
>> snapshot names.  How bad would that be?
>=20
> It would be incompatible with existing images and result in a more
> complex snapshot identifier resolution. Why would it be any better?

It wouldn't be incompatible with existing images if we'd just disallow
creating such snapshots.  I don't see how the identifier resolution
would be more complex.

I don't know if it'd be better.  I'd just find it simpler (for us, that
is -- for users, I'm not sure).

Max


--To9k9ZgKjYC5sqYOKBZJbP0tZs2xwwTz6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlw2BL8ACgkQ9AfbAGHV
z0DZfwf/ePlPJsCnZf6abZKrAagtha1BiIWlsIoU3va0ksd8xl9e6RBA6GYSAdLv
s7Y2ebJt0XF8HKOh82p41slub7bs2Af6ago/3p4zQ1ietQszfvoTL0LL0lpiqaSp
K85K4jYHHidQk3k+yF6P2hHJWO1rr+Eo0G/7CEhy6fVN2blGdWlKatpjvhWHwk2F
V64yK1e2sM7WEWt5XRdWjhKVa1tlDs6UVAbHxYKjCnRardaL5n3lnxCIpqau0iF0
5OjeNIk04QpFxgNMMHvNi/dLw65idjb8HglOPDDoNGOKdZun2qBuQP05GAduWw2K
NqY/7oRSNb+ChdtNHizFoz4iAfqP7Q==
=hdyM
-----END PGP SIGNATURE-----

--To9k9ZgKjYC5sqYOKBZJbP0tZs2xwwTz6--
