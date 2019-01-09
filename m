Received: from eggs.gnu.org ([209.51.188.92]:55311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ghHIA-0004GL-RP
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 12:05:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ghHI5-0001Ne-64
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 12:05:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46630)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1ghHI4-0001N8-TF
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 12:05:17 -0500
References: <20180906111107.30684-1-danielhb413@gmail.com>
	<47023eb5-41f1-1b60-1094-d607999e93b6@redhat.com>
	<a030d899-5a1a-b8b9-4c59-cca4bc304c1d@gmail.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <200ecea3-1ef4-3ecf-6b37-f6e45fef3849@redhat.com>
Date: Wed, 9 Jan 2019 18:05:11 +0100
MIME-Version: 1.0
In-Reply-To: <a030d899-5a1a-b8b9-4c59-cca4bc304c1d@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="A94HxPqe6i1TDavp4tf5Bpb7UxvvrsNKr"
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
To: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, kwolf@redhat.com, armbru@redhat.com, muriloo@linux.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--A94HxPqe6i1TDavp4tf5Bpb7UxvvrsNKr
From: Max Reitz <mreitz@redhat.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, kwolf@redhat.com, armbru@redhat.com,
 muriloo@linux.ibm.com
Message-ID: <200ecea3-1ef4-3ecf-6b37-f6e45fef3849@redhat.com>
Subject: Re: [PATCH v2 0/3] HMP/snapshot changes - do not use ID anymore
References: <20180906111107.30684-1-danielhb413@gmail.com>
 <47023eb5-41f1-1b60-1094-d607999e93b6@redhat.com>
 <a030d899-5a1a-b8b9-4c59-cca4bc304c1d@gmail.com>
In-Reply-To: <a030d899-5a1a-b8b9-4c59-cca4bc304c1d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09.01.19 17:57, Daniel Henrique Barboza wrote:
>=20
>=20
> On 1/9/19 12:10 PM, Max Reitz wrote:
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
>>> Given that it is strange for an API to consider a parameter to be 2
>>> fields
>>> at the same time, and inadvently treating them as one or the other, a=
nd
>>> that removing the ID field is too drastic, my idea here is to keep th=
e
>>> ID field for internal control, but do not let the user set it.
>>>
>>> I guess there's room for discussion about considering this change an =
API
>>> change or not. It doesn't affect users of HMP and it doesn't affect
>>> Libvirt,
>>> but simplifying the meaning of the parameters of savevm/loadvm/delvm.=

>> (Yes, very late reply, I'm sorry...)
>>
>> I do think it affects users of HMP, because right now you can delete
>> snapshots with their ID, and after this series you cannot.
>=20
> That's true. My idea here was simple: the user can't reliably exclude
> via snapshot ID today
> because we're hiding the ID field in info snapshots:
>=20
>=20
> =C2=A0=C2=A0=C2=A0 (qemu) savevm 0
> =C2=A0=C2=A0=C2=A0 (qemu) info snapshots
> =C2=A0=C2=A0=C2=A0 List of snapshots present on all disks:
> =C2=A0=C2=A0=C2=A0 ID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TAG=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 VM SIZE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DATE VM CLOCK
> =C2=A0=C2=A0=C2=A0 --=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 741M 2018-07-31 13:39:56 00=
:41:25.313
>=20
>=20
> Thus, what will end up happening is that the user will be forced to use=
 the
> TAG of the snapshot since this is the only available information.

But you can get it through e.g. qemu-img info.

Snapshot list:
ID        TAG                 VM SIZE                DATE       VM CLOCK
1         0                      1.6M 2019-01-09 18:01:21   00:00:02.657

So it's not impossible to get.

>> I think we had a short discussion about just disallowing numeric
>> snapshot names.=C2=A0 How bad would that be?
>=20
>=20
> This was my first idea when evaluating what to do in this case. I gave
> it up because
> I found it to be too extreme. People would start complaining "I was abl=
e
> to do
> savevm 0 and now I can't".

True.  But it wouldn't be impossible to do, we'd need to deprecate
numeric names, print a warning for two releases, and then we can make it
an error.

Hm...  If we had a proper deprecation warning in this series, I suppose
it wouldn't be dangerous anymore.  Can we just print a warning whenever
the user specified an ID?  (i.e. if some snapshot's ID matches the
string given by the user and the snapshot's name does not)

Max


--A94HxPqe6i1TDavp4tf5Bpb7UxvvrsNKr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlw2KccACgkQ9AfbAGHV
z0B6dAf/bfLcb1Et6tiPofeORruSqXYNLCUvMmJW943Iiy0Ne5cEZlgcnOdfUStk
3MZNqfjFtomPY6WKQ5popu4DtuW8J+BiW4Nd2T2ujDSZHFjZVxN0aB7Ac+Ge83Il
DB9Qa/rrn8gTmmjWXuGYYIxk7CtxXQ+BTDBsVpBG6Y0E/1N91y56aCNCD7c2/4uS
QtISe04S6S6XPyInMJ5zDmXCU17Lx4gWlz1fErC4dIiTzDRMwEAs5PK6V5OE69NS
B40OGVyYpxYoqB6cJ2epgwJ+QWdcaNmVatlW4tG/8OIZdBS1SSvyKT+IsBBs+b0f
qxRgZXRwTngBdRs3mtPGUpn1aiPLqg==
=a+OS
-----END PGP SIGNATURE-----

--A94HxPqe6i1TDavp4tf5Bpb7UxvvrsNKr--
