Received: from eggs.gnu.org ([2001:4830:134:3::10]:39783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dGSaW-0008Lh-6r
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 12:04:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dGSaV-0000OT-CV
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 12:04:40 -0400
References: <1495830130-30611-1-git-send-email-kwolf@redhat.com>
	<1495830130-30611-11-git-send-email-kwolf@redhat.com>
	<20170531123259.GK16733@stefanha-x1.localdomain>
	<20170601155953.GG4987@noname.redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ce3f84f1-d294-009f-a72d-8776416599c0@redhat.com>
Date: Thu, 1 Jun 2017 18:04:25 +0200
MIME-Version: 1.0
In-Reply-To: <20170601155953.GG4987@noname.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pSuCmU4badjqqdMhReqgO0vJp2EF5oLc3"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 10/29] qed: Remove callback
 from qed_write_header()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, stefanha@redhat.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pSuCmU4badjqqdMhReqgO0vJp2EF5oLc3
From: Paolo Bonzini <pbonzini@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, stefanha@redhat.com,
 mreitz@redhat.com
Message-ID: <ce3f84f1-d294-009f-a72d-8776416599c0@redhat.com>
Subject: Re: [Qemu-block] [PATCH 10/29] qed: Remove callback from
 qed_write_header()
References: <1495830130-30611-1-git-send-email-kwolf@redhat.com>
 <1495830130-30611-11-git-send-email-kwolf@redhat.com>
 <20170531123259.GK16733@stefanha-x1.localdomain>
 <20170601155953.GG4987@noname.redhat.com>
In-Reply-To: <20170601155953.GG4987@noname.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 01/06/2017 17:59, Kevin Wolf wrote:
> Am 31.05.2017 um 14:32 hat Stefan Hajnoczi geschrieben:
>> On Fri, May 26, 2017 at 10:21:51PM +0200, Kevin Wolf wrote:
>>>  static void qed_clear_need_check(void *opaque, int ret)
>>>  {
>>>      BDRVQEDState *s =3D opaque;
>>> =20
>>>      if (ret) {
>>> -        qed_unplug_allocating_write_reqs(s);
>>> -        return;
>>> +        goto out;
>>>      }
>>> =20
>>>      s->header.features &=3D ~QED_F_NEED_CHECK;
>>> -    qed_write_header(s, qed_flush_after_clear_need_check, s);
>>> +    ret =3D qed_write_header(s);
>>> +    (void) ret;
>>> +
>>> +    ret =3D bdrv_flush(s->bs);
>>> +    (void) ret;
>>> +
>>> +out:
>>> +    qed_unplug_allocating_write_reqs(s);
>>>  }
>>
>> Should we unplug allocating write reqs before flushing?  The async cod=
e
>> kicks off a flush but doesn't wait for it to complete.
>=20
> You're right that moving it up would match the old code. Not sure if it=

> would make much of a difference, though, isn't the request queue draine=
d
> in the kernel anyway while doing a flush?

No, it isn't AFAIK.

Paolo


--pSuCmU4badjqqdMhReqgO0vJp2EF5oLc3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAlkwOwkACgkQv/vSX3jH
roN4WQgAmdVUyGgfUyVOwvzZPjGy9VRKElF2qvEzjYtS9hdbuS2hqe3WUTD8Hrmy
CoAF4tXSi9w2sR9OoKEBlrhP2hhkAlVI7A6wmBjHW98r8X5GEb9Jrt5bJQwwbS3C
E+amx5zrUB2it7Q6t831LFgb5F+1HtXE7zuR0+ebPkq8aYK2tiTr7u/m4PfioeuB
XeepGZv3zMzWw+8/8KpZA0YnLW3l88lcH2xwb9MEfR6grG/Y/23u6ZuC2t8ggQWE
93wyBZXESnSBsWWi2zJoneJEOMtLrg7FwIhaqxKaQnEcglVThUUJ8BFtb5qE66IB
QU5c3jIin0d8TMHKx0+y6jH4p0s7Sg==
=ThY1
-----END PGP SIGNATURE-----

--pSuCmU4badjqqdMhReqgO0vJp2EF5oLc3--
