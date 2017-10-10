Received: from eggs.gnu.org ([2001:4830:134:3::10]:51742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e1zm7-0001HO-Qp
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 15:01:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e1zm3-0001J3-PZ
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 15:01:07 -0400
References: <20171004020048.26379-1-eblake@redhat.com>
	<20171004020048.26379-2-eblake@redhat.com>
	<20171010135940.GJ4177@dhcp-200-186.str.redhat.com>
	<67e98ca7-e861-a646-b701-b8f7453f2951@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <46e7ca23-fb38-7620-90fb-04982e5b9ad0@redhat.com>
Date: Tue, 10 Oct 2017 14:00:48 -0500
MIME-Version: 1.0
In-Reply-To: <67e98ca7-e861-a646-b701-b8f7453f2951@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="aMdi0EilwwGTwiM5MMsocvKFee7f1vqku"
Subject: Re: [Qemu-devel] [PATCH v5 01/23] block: Allow NULL file for
 bdrv_get_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: famz@redhat.com, qemu-block@nongnu.org, Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, jsnow@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aMdi0EilwwGTwiM5MMsocvKFee7f1vqku
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: famz@redhat.com, qemu-block@nongnu.org, Jeff Cody <jcody@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, jsnow@redhat.com
Message-ID: <46e7ca23-fb38-7620-90fb-04982e5b9ad0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 01/23] block: Allow NULL file for
 bdrv_get_block_status()
References: <20171004020048.26379-1-eblake@redhat.com>
 <20171004020048.26379-2-eblake@redhat.com>
 <20171010135940.GJ4177@dhcp-200-186.str.redhat.com>
 <67e98ca7-e861-a646-b701-b8f7453f2951@redhat.com>
In-Reply-To: <67e98ca7-e861-a646-b701-b8f7453f2951@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/10/2017 09:43 AM, Eric Blake wrote:

>>> ---
>>> v5: use second label for cleaner exit logic [John], use local_pnum
>=20
>>> @@ -1811,16 +1811,19 @@ static int64_t coroutine_fn bdrv_co_get_block=
_status(BlockDriverState *bs,
>>>      int64_t total_sectors;
>>>      int64_t n;
>>>      int64_t ret, ret2;
>>> +    BlockDriverState *local_file =3D NULL;
>>> +    int local_pnum =3D 0;
>>
>> I don't quite see what the point of local_pnum is if we assert anyway
>> that the real pnum is non-NULL.
>=20
> I did it in parallel with fallout from John's review on v4:
> https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg06958.html
>=20
> but since it wasn't specifically asked for, and is now getting
> questions, I'm fine with not having it in v6.

Okay, I re-read v4, and here's the comment (on 21/23) that led to my
experiment in v5 patch 1 with local_pnum:

https://lists.gnu.org/archive/html/qemu-devel/2017-10/msg00293.html

and I did argue:

https://lists.gnu.org/archive/html/qemu-devel/2017-10/msg00311.html

>> Is it asking for trouble to be updating pnum here before we undo our
>> alignment corrections? For readability reasons and preventing an
>> accidental context-based oopsy-daisy.
>=20
> As in, write the code to make all calculations in a temporary, and then=

> assign *pnum only at the end?  I suppose I can tweak the code along
> those lines, but I'm not sure it will make the end result any more legi=
ble.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--aMdi0EilwwGTwiM5MMsocvKFee7f1vqku
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlndGOAACgkQp6FrSiUn
Q2okTQgAjJ6LLNNbH2KfaIy3xOGd2/KxljZ3Ue9im4dNurIdntPcYsEntiMXd+Rm
xstpq/P+tRBfU4jMg1BKatgqKAYXMBK55/T/sJHCXd58kBbk/gJhKvOK8CMrRoju
opsixutBhehSNMJWrYxTE3jGJMcnSV/ajYVPC7YY//xREYBsLAWlPMBeK93xm8MQ
XDJPm332xwzRCxj7ZgjU6uLANYXELHgR59i/NLFo44aH5VkffDltc+j4XTxKcDxn
93bxN+NrTAtwDAB46+48t4uhQvWPrx/v2NQghGobvE93NhQ3Xbg8mVzEbjPzoNcC
I+nNNl/+PnkPAJaQ6pbZHAJMR9a0fw==
=mZhq
-----END PGP SIGNATURE-----

--aMdi0EilwwGTwiM5MMsocvKFee7f1vqku--
