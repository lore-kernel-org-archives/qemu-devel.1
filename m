Received: from eggs.gnu.org ([209.51.188.92]:55763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gmIfG-0000ff-Uj
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 08:33:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gmIfG-00019F-5r
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 08:33:58 -0500
References: <20181229122027.42245-1-vsementsov@virtuozzo.com>
	<20181229122027.42245-6-vsementsov@virtuozzo.com>
	<a4565e50-b670-333e-a3db-72ff5a42b776@redhat.com>
	<084ff0b6-1de8-1c17-f085-97a8b1aeb8b5@virtuozzo.com>
	<fab4d292-ea59-5e1f-ec43-486abc455e7c@redhat.com>
	<76562236-6535-a064-e8ed-6c2c2e285ac5@virtuozzo.com>
	<1b3d637d-f559-905f-69fb-da24fd697ad0@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <05293a20-b561-8d42-37c8-05179c69f4a9@redhat.com>
Date: Wed, 23 Jan 2019 14:33:43 +0100
MIME-Version: 1.0
In-Reply-To: <1b3d637d-f559-905f-69fb-da24fd697ad0@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9O9z9mmxenucp90DimMOcRuTxh5jVYxVz"
Subject: Re: [Qemu-devel] [PATCH v5 05/11] iotests: allow resume_drive by
 node name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "fam@euphon.net" <fam@euphon.net>, "stefanha@redhat.com" <stefanha@redhat.com>, "jcody@redhat.com" <jcody@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>, "eblake@redhat.com" <eblake@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9O9z9mmxenucp90DimMOcRuTxh5jVYxVz
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "fam@euphon.net" <fam@euphon.net>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "jcody@redhat.com" <jcody@redhat.com>, "kwolf@redhat.com"
 <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "eblake@redhat.com" <eblake@redhat.com>, "jsnow@redhat.com"
 <jsnow@redhat.com>
Message-ID: <05293a20-b561-8d42-37c8-05179c69f4a9@redhat.com>
Subject: Re: [PATCH v5 05/11] iotests: allow resume_drive by node name
References: <20181229122027.42245-1-vsementsov@virtuozzo.com>
 <20181229122027.42245-6-vsementsov@virtuozzo.com>
 <a4565e50-b670-333e-a3db-72ff5a42b776@redhat.com>
 <084ff0b6-1de8-1c17-f085-97a8b1aeb8b5@virtuozzo.com>
 <fab4d292-ea59-5e1f-ec43-486abc455e7c@redhat.com>
 <76562236-6535-a064-e8ed-6c2c2e285ac5@virtuozzo.com>
 <1b3d637d-f559-905f-69fb-da24fd697ad0@virtuozzo.com>
In-Reply-To: <1b3d637d-f559-905f-69fb-da24fd697ad0@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 23.01.19 14:31, Vladimir Sementsov-Ogievskiy wrote:
> 23.01.2019 16:22, Vladimir Sementsov-Ogievskiy wrote:
>> 16.01.2019 16:11, Max Reitz wrote:
>>> On 14.01.19 17:06, Vladimir Sementsov-Ogievskiy wrote:
>>>> 14.01.2019 17:46, Max Reitz wrote:
>>>>> On 29.12.18 13:20, Vladimir Sementsov-Ogievskiy wrote:
>>>>>> After node graph changes, we may not be able to resume_drive by de=
vice
>>>>>> name (backing files are not recursively searched). So, lets allow =
to
>>>>>> resume by node-name. Set constant name for breakpoints, to avoid
>>>>>> introducing extra parameters.
>>>>>
>>>>> Hm, I don't quite understand this reason.=C2=A0 Is this so you can =
create
>>>>> breakpoints on one node (which falls through to the first blkdebug =
node)
>>>>> and then remove them from another (falling through to the same blkd=
ebug
>>>>> node)?
>>>>
>>>> add/remove breakpoint goes through ->file children, but my filter li=
nks
>>>> active disk as ->backing. So, before block-job start we can insert b=
reakpoint
>>>> by device name. But then, when filter inserted, we can't remove brea=
kpoint,
>>>> because my filter hides blkdebug with active disk under ->backing li=
nk.
>>>>
>>>> Maybe, right solution would be support backing links in bdrv_debug_b=
reakpoint()
>>>> and bdrv_debug_remove_breakpoint() for the case when there is no fil=
e child.
>>>>
>>>> But being unsure about right behavior, I've decided to adjust the te=
st.
>>>>
>>>> What about just do both=C2=A0 add/remove breakpoint through blkdebug=
 node-name, to
>>>> make it less weird?
>>>
>>> Yes, I was mostly wondering about the "set constant name for
>>> breakpoints".=C2=A0 It doesn't seem necessary to me;
>>
>> It's just to not create extra parameters or something. Current code do=
n't allow
>> to create several breakpoints in one blkdebug anyway (as @drive is use=
d as
>> breakpoint name), so there is no reason for different names at all.
>>
>> I'll improve commit message to make it clean.
>>
>=20
> Hmmm.
>=20
> Or, finally, may be better to teach bdrv_debug_breakpoint() and
> bdrv_debug_remove_breakpoint() to skip filters with backing child?

I suppose that would be a question for my "Deal with filters" series.
It does make sense to me, though.

Max


--9O9z9mmxenucp90DimMOcRuTxh5jVYxVz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlxIbTcACgkQ9AfbAGHV
z0BjNgf/T5Z2BIiBv6iydA3W+IaEWQQa56ZXgEMznd0TpZfg+QEZ+RA7IO8U73kC
rQPx6dZ7ZaYSSyvNdkNTGozmxIjAt2lhWVDvJ9j8WYsix29jvVjA2lc9pVJmfgBw
zEfsb+08rOmlAG97zkNndSOXrCCNlIbfB9t6Kn5TXW9KW/5pYTAM1vVR5vX1y4a8
QgRKuHxZGH9wYfC6mm5lPAojHRyl7Hzk8MOwUKrVjNkAedF2+ocAZUOZApgfIgn3
AqzL3ksgxalMt4xcSM3XphiDliKB17zbjqPQdTQZt/l9oJm3FE0vLQf/CJYDmmW7
RLO9qxzVvF1BFnhQfKTHta9xE+J7MA==
=X4Qj
-----END PGP SIGNATURE-----

--9O9z9mmxenucp90DimMOcRuTxh5jVYxVz--
