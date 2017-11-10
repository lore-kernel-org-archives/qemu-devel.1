Received: from eggs.gnu.org ([2001:4830:134:3::10]:56738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eDDh2-000602-SJ
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 13:06:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eDDh1-0004v2-FF
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 13:06:16 -0500
References: <20171004152553.30263-1-mreitz@redhat.com>
	<87zi7u4hob.fsf@dusky.pond.sub.org>
	<f051da3e-9181-0e72-b9eb-4e9c2d61e971@redhat.com>
	<20171110174742.GI5466@localhost.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b21aaff4-13bf-e6a3-e90f-6e80584bfcb7@redhat.com>
Date: Fri, 10 Nov 2017 19:06:05 +0100
MIME-Version: 1.0
In-Reply-To: <20171110174742.GI5466@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="K9EF78wtILIRo0M4K6ia1rjAfRdLDlE9n"
Subject: Re: [Qemu-devel] [PATCH v6 0/6] block: Don't compare strings in
 bdrv_reopen_prepare()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--K9EF78wtILIRo0M4K6ia1rjAfRdLDlE9n
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Message-ID: <b21aaff4-13bf-e6a3-e90f-6e80584bfcb7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 0/6] block: Don't compare strings in
 bdrv_reopen_prepare()
References: <20171004152553.30263-1-mreitz@redhat.com>
 <87zi7u4hob.fsf@dusky.pond.sub.org>
 <f051da3e-9181-0e72-b9eb-4e9c2d61e971@redhat.com>
 <20171110174742.GI5466@localhost.localdomain>
In-Reply-To: <20171110174742.GI5466@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 2017-11-10 18:47, Kevin Wolf wrote:
> Am 10.11.2017 um 18:36 hat Max Reitz geschrieben:
>> On 2017-11-10 10:16, Markus Armbruster wrote:
>>> Max Reitz <mreitz@redhat.com> writes:
>>>
>>>> bdrv_reopen_prepare() assumes that all BDS options are strings, whic=
h is
>>>> not necessarily correct. This series introduces a new qobject_is_equ=
al()
>>>> function which can be used to test whether any options have changed,=

>>>> independently of their type.
>>>
>>> Series looks ready to me.  It touches QAPI to achieve its purpose in =
the
>>> block layer; I'd be fine with merging it via a block tree.
>>
>> Thanks!  So now it's my problem to figure out whether this is 2.11
>> material...? :-)
>=20
> The test case in patch 5 segfaults without the series. Why would it not=

> be a bug fix (=3D 2.11 material)?

Because it adds a whole lot of QAPI code, and the segfault is a clear
NULL pointer dereference which you can only get through HMP.  But then
again, the only place where the new code is used is from the place of
the bug fix itself, so I guess no regressions are possible.

So if it is a bug fix, why have you not applied it? :-)


Applied to my block branch for 2.11:

https://github.com/XanClic/qemu/commits/block

Max


--K9EF78wtILIRo0M4K6ia1rjAfRdLDlE9n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloF6o0SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AElQH/18GPfCOh+64+znwEg60JVmFRKYR+a+K
npeRxcb+Flv929GTAc863OyUPesI1itl/W7DZKtunLyhxY6vBhzoPV/X50fMSL2q
jO7UchYbqdHGC1MR6u6qEEBjvC3eONJBBRVXAzGtf7T5FjYKg50WNvVm0/rGrlxB
tw2xh66PtW9YOoGuHzZML6RFrlNJOu4dxs4q2sr6QnQs1wnKDDhj8/MuAxxst1tG
PMIKSHuPTzSt6YmsT9vGMpuJzP4nCwnyqzb5NOftpBGgKzsmuTcNe+KTAJZkHWLG
jGU+DwOSGH3or2KTS15devZLjYKr6sGKdwmixuY9UTKB5shyEhmUe8U=
=dLT8
-----END PGP SIGNATURE-----

--K9EF78wtILIRo0M4K6ia1rjAfRdLDlE9n--
