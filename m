Received: from eggs.gnu.org ([2001:4830:134:3::10]:44121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1ddGcf-0004pn-RA
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 09:57:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1ddGca-000317-6b
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 09:57:09 -0400
Date: Thu, 3 Aug 2017 16:56:15 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170803133317.7a4w7o4s6vkeuze7@postretch>
References: <20170731095443.28211-1-el13635@mail.ntua.gr>
	<20170731095443.28211-6-el13635@mail.ntua.gr>
	<20170803080741.GA4456@dhcp-200-186.str.redhat.com>
	<b3d8be9b-0811-09f8-11a5-fd92e884da46@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="f5df33vqxadztx3a"
Content-Disposition: inline
In-Reply-To: <b3d8be9b-0811-09f8-11a5-fd92e884da46@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 5/7] block: add throttle block filter
 driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block <qemu-block@nongnu.org>, Alberto Garcia <berto@igalia.com>, qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>


--f5df33vqxadztx3a
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 03, 2017 at 06:58:30AM -0500, Eric Blake wrote:
>On 08/03/2017 03:07 AM, Kevin Wolf wrote:
>> Am 31.07.2017 um 11:54 hat Manos Pitsidianakis geschrieben:
>>> block/throttle.c uses existing I/O throttle infrastructure inside a
>>> block filter driver. I/O operations are intercepted in the filter's
>>> read/write coroutines, and referred to block/throttle-groups.c
>>>
>>> The driver can be used with the syntax
>>> -drive driver=3Dthrottle,file.filename=3Dfoo.qcow2, \
>>>         limits.iops-total=3D...,throttle-group=3Dbar
>>>
>>> The configuration flags and their semantics are identical to the
>>> hardcoded throttling ones.
>>>
>>> A node can be created referring to an existing group, and will overwrite
>>> its limits if any are specified, otherwise they are retained.
>>>
>>> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
>>> ---
>
>>> +
>>> +    .is_filter                          =3D   true,
>>> +};
>>
>> What about .bdrv_co_get_block_status?
>
>And if so, do you want my byte-based block status to go in first?  (Our
>two series conflict, so we need to pick who needs to rebase on top of
>the other).

No problem. My patch is in Kevin's branch for 2.11.  Feel free to merge=20
first if needed, I can rebase my patch if you do.=20

--f5df33vqxadztx3a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAlmDK38ACgkQc2J8L2kN
9xAp4Q/9FIwgBOcTs2oDHHp2ZkvGuB2v+cKXYHkaaTPExAORaYjPNtvhZVCiqfeE
97ihC9WBPXt8RxvZZWBynq4KpABhhS9ejcO+ZhqYgo2WhQKhuYFaaV1tJs5q7o5H
lEXJuH3puqLV1Frqkhd3eR9pZpTCRp6Ibyf6oLxywFfkEYB/IjdZXKhFRel2Q+Pe
XrzqRORRCZDX5CgD5Qlp4TQTm5QDuh0kwbusY6zbljStgGGDMl7+msP9R6P8QI1M
EkeQ+Sl302aaZDir6rRzKZoI3x1wM+1DGTjIqO9HGnktLIgm2HghNYlhP/Ft6NSC
UPT7upMnQY7tMsWs3Em+QyXj5NlgraZaJ0vgxpvsinUnH2WzuamWpZw1cVTYXoA0
I8jk0VSq6Pk+rquduml177XMawpfYj0TnpRGT5y4D5Ow+ScbrbWfTtQLSrzd3G2U
MnNRkaSWAe1Gf99oF4BjB7M0byEJaXiDa2CdIn20YfDJcmdP1urAtviN9scmS4DH
68qHpKMGSedaU6NOgKOCVVvvK1fBzKeaQFFbUDDee/qUmX5BDM5pAGGAvesDDwWU
niJ3NwQ5R6zy8RMSObTPnNfbXuUAhu5+iq2GsKBLlQ+gNTjVWpg7IrV1EYutAPD2
Qp9LnnLExgGy0rc0QhW9GfLVILdyEC48fAwy7MdKoMTpl/HQoOQ=
=QlGs
-----END PGP SIGNATURE-----

--f5df33vqxadztx3a--
