Received: from eggs.gnu.org ([2001:4830:134:3::10]:43866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g9aYd-0003p4-O2
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 14:47:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g9aYc-0000py-RQ
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 14:47:07 -0400
References: <cover.1537367701.git.berto@igalia.com>
	<ba0e2f728d7b2a0bbf5c0f44d907a4c7e3723501.1537367701.git.berto@igalia.com>
	<204d1911-765b-bd4b-27b8-3f1a35a6b9d6@redhat.com>
	<w517eis71cp.fsf@maestria.local.igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <1b2e5d06-7b80-43d9-7b66-9b69b67445a5@redhat.com>
Date: Mon, 8 Oct 2018 20:46:57 +0200
MIME-Version: 1.0
In-Reply-To: <w517eis71cp.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="uyHwCM98Zie4tVnLKM2w1XiPQVCxLKaJ6"
Subject: Re: [Qemu-devel] [PATCH 14/14] block: Stop passing flags to
 bdrv_reopen_queue_child()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uyHwCM98Zie4tVnLKM2w1XiPQVCxLKaJ6
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <1b2e5d06-7b80-43d9-7b66-9b69b67445a5@redhat.com>
Subject: Re: [PATCH 14/14] block: Stop passing flags to
 bdrv_reopen_queue_child()
References: <cover.1537367701.git.berto@igalia.com>
 <ba0e2f728d7b2a0bbf5c0f44d907a4c7e3723501.1537367701.git.berto@igalia.com>
 <204d1911-765b-bd4b-27b8-3f1a35a6b9d6@redhat.com>
 <w517eis71cp.fsf@maestria.local.igalia.com>
In-Reply-To: <w517eis71cp.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08.10.18 20:13, Alberto Garcia wrote:
> On Mon 08 Oct 2018 04:48:50 AM CEST, Max Reitz wrote:
>=20
>>> +    /* Old values are used for options that aren't set yet */
>>> +    old_options =3D qdict_clone_shallow(bs->options);
>>> +    bdrv_join_options(bs, options, old_options);
>>> +    qobject_unref(old_options);
>>> +
>>> +    /* We have the final set of options so let's update the flags */=

>>> +    {
>>> +        Error *local_err =3D NULL;
>>> +        QemuOpts *opts;
>>> +        QDict *options_copy =3D qdict_clone_shallow(options);
>>
>> I-I'm not sure this conforms to our coding style.
>>
>> While I applaud your effort to keep the patch size small, I know for
>> sure I don't want to read code like this.  (Unless it's necessary
>> because of some variables' lifetimes.)
>=20
> I actually think it makes the code more readable if there are variables=

> with a very limited scope (like in this case). But I can also rewrite i=
t
> using a more traditional style.

I think it should be a function call then.

Max


--uyHwCM98Zie4tVnLKM2w1XiPQVCxLKaJ6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlu7piEACgkQ9AfbAGHV
z0BtcAgAr4DnNEavwRX2sq4IuVkb5s2GVg0fG8ZC2B0HU9W3Gl5Zv1qNnYpz2xgy
G3vTGifcO2qNNo0+jTMMnPOxNpHIWsK6gYYY8tPLAXsrz/t/nsbYFXcDam7ggN4f
8Au5cUyik3i+Nt56wRsOKexSVYGStfafu/1XxU3OnUPwLnBMeM/i8oJqHuID1x3m
aNnMD7cP+Mees9S97unZ5fPvnfev6xE3PQd4JojIzP2gKnCR7LuGET+yeP+k6fLr
osTtvdwjVZVgol+GyA34u3qsF5K3Z8wHpZq5LFGdmqN1KoBv8PmDh/77CuYnCRs3
uxTpGqIiCY5zy3lPxYlvFjLymW5t8A==
=x5mK
-----END PGP SIGNATURE-----

--uyHwCM98Zie4tVnLKM2w1XiPQVCxLKaJ6--
