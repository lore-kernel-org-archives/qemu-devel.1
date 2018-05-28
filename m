Received: from eggs.gnu.org ([2001:4830:134:3::10]:48647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNAkq-00034m-N0
	for qemu-devel@nongnu.org; Mon, 28 May 2018 01:31:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNAkn-0002fq-KY
	for qemu-devel@nongnu.org; Mon, 28 May 2018 01:31:36 -0400
Received: from mail-qt0-x22c.google.com ([2607:f8b0:400d:c0d::22c]:41804)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNAkn-0002fk-ES
	for qemu-devel@nongnu.org; Mon, 28 May 2018 01:31:33 -0400
Received: by mail-qt0-x22c.google.com with SMTP id g13-v6so13623749qth.8
	for <qemu-devel@nongnu.org>; Sun, 27 May 2018 22:31:33 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <CAFEAcA-hha7jMSfPTdNEVKhuJr4nwAx4wKmEk5E9+j-JS4U14w@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <26ea29aa-6087-b6e1-be4d-eb40cd089233@amsat.org>
Date: Mon, 28 May 2018 02:31:27 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-hha7jMSfPTdNEVKhuJr4nwAx4wKmEk5E9+j-JS4U14w@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="hm78QzO3y5nux2uV1V6ANxT0GkfUMZ4By"
Subject: Re: [Qemu-devel] release retrospective, next release timing,
 numbering
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hm78QzO3y5nux2uV1V6ANxT0GkfUMZ4By
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <26ea29aa-6087-b6e1-be4d-eb40cd089233@amsat.org>
Subject: Re: [Qemu-devel] release retrospective, next release timing,
 numbering
References: <CAFEAcA-hha7jMSfPTdNEVKhuJr4nwAx4wKmEk5E9+j-JS4U14w@mail.gmail.com>
In-Reply-To: <CAFEAcA-hha7jMSfPTdNEVKhuJr4nwAx4wKmEk5E9+j-JS4U14w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/27/2018 12:51 PM, Peter Maydell wrote:
> Hi; I usually let people forget about releases for a month or
> so before bringing this topic up, but:
[...]
> That will make the next release be 3.0.0.
[...]
> (3) retrospective, lessons learned &c
[...]
>  * provide your opinions here ?

Maybe v3 is a good opportunity to update QEMU standards...

- Clarify which APIs are outdated
  (Add /* DEPRECATED (use: NiceApi3.0) */ comments around)

- Select some up-to-date and recommended (well-documented)
  boards/device/block examples for newcomers (add in Wiki)

Some more painful ideas:

- Public function/structures added/modified get documentation
  (kernel-doc / Sphinx)

- New feature gets unit-qtesting (make check-unit)

- New device gets acceptance qtesting (make check-qtest)

- New board gets integration qtesting (boot BIOS/FW, Avocado)

I understand each maintainer manage his tree with his own criterion, IMO
these might be the minimum requested for paid contributors.

Regards,

Phil.


--hm78QzO3y5nux2uV1V6ANxT0GkfUMZ4By
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlsLlC8ACgkQ4+MsLN6t
wN6ROw/6AivOQtSVwc73iDBPE3AyvAba+dBsZMsVISDNTgjoWJaX9bhIg0jkU1du
usBeCtvnXxc9BVA7AKOKMuo3JGDXTUBW2HkYUWNzs2RjGbI/V8Vfm4+zZcpmv4Du
0QHpSiPwNzhc3xtNQTl+qbqb1f1YjE+ZQGlSArRJ6JirmbtZ28Ws/AVsMeYUNHeN
O9uRUK4Da/4oZIBP5+Ofp2pnbiNLy5c2FVHtnsjQRtOtD3tNaaDUpcK8YLUl/MYC
Fhm5xMJ5Ocjnea58A7zwkN903kQUe570XsvtQZHH0dFrNwk8ojzAraSJ4yRVUd8K
pWSCJHh8bU+ATzLRh/VpLq5eJ4Mh5AP1DP5Go0Id2lJ76ySUS3Erhv3c5nSuf9XO
JFuxGeGOmLRhl34l9vPIP515RJ15zlJ6LeSn2Fu/pM4V8xWQiJOcKeuxvT3mS7/7
CNDxCayregxPykEr/wlehs36OD+uGm/JDwVZR2f9Nw1mzUcnWFN3JvPR0ne59xQ5
CVk1qsrH7sQyyLg3UabVUqZV2bpO1mpPN9v1yQ5yHm//M8k+DDj6gxY1NVqeGB4z
lBJLD7gxfR++LR5W6SDQURxmJ/JcFRTI1UE0DJGiKe1o2MbfAbXkfBuNuH7ynatx
4ttp9RaDzJK8YdJIEXmAe36NHDM64VmE08aQdzhJ+1efxIEFMgI=
=xw5B
-----END PGP SIGNATURE-----

--hm78QzO3y5nux2uV1V6ANxT0GkfUMZ4By--
