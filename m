Received: from eggs.gnu.org ([2001:4830:134:3::10]:41248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dkA72-00016Y-Kc
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 10:25:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dkA71-0006m3-Oc
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 10:25:00 -0400
Date: Tue, 22 Aug 2017 17:22:46 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170822142246.x2wtondegbcmm7fy@postretch>
References: <20170822101535.4695-1-el13635@mail.ntua.gr>
	<20170822101535.4695-6-el13635@mail.ntua.gr>
	<w51tw0zg01x.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bnahpbh22u5vsx33"
Content-Disposition: inline
In-Reply-To: <w51tw0zg01x.fsf@maestria.local.igalia.com>
Subject: Re: [Qemu-devel] [PATCH v7 5/6] block: add throttle block filter
 driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>


--bnahpbh22u5vsx33
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 22, 2017 at 04:16:26PM +0200, Alberto Garcia wrote:
>On Tue 22 Aug 2017 12:15:34 PM CEST, Manos Pitsidianakis wrote:
>> @@ -548,6 +548,11 @@ void throttle_group_unregister_tgm(ThrottleGroupMem=
ber *tgm)
>>      ThrottleGroupMember *token;
>>      int i;
>>
>> +    if (!ts) {
>> +        /* Discard uninitialized tgm */
>> +        return;
>> +    }
>> +
>
>Is this change needed in case throttle_configure_tgm() fails?

Yes, now all errors are before throttle_group_register_tgm(), therefore=20
the unregister part in throttle_close() will not have valid data.

--bnahpbh22u5vsx33
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAlmcPjYACgkQc2J8L2kN
9xBTHg//bWF1bmlpTB+ZjSZ9UMlCLnRcQbPc/Nn6PveJ/TB8/yKiQvHwnhT7lmf+
HSOr4uA3ghH8wXHWnZ6wj8wQFLMw2FIl0S0J3sCb+2rjqpoMraVtweYM/Ic7N2LV
lnBSI+ErXpqC+fhw6Cg4MxYFGUhjDiueSr9QyDATgWMdcgy385tC+G8i+UmLszMY
L5+3WZKHMr3GYvwSqRqJzPbAtEpIfo93PsABTEKOD+Ik4L54quCy8dKHlgLrx+QJ
BEYR75cPpsmFIGXN2OXangP8GvBW0Mb+dqp0ZSEFGweSzoYfzsG7Wyd8R+kou4oS
MKlxYpR2Tbmtg/ECiWpfMJjyQ+vEantNqUymjpBzisnE31a+Zgfh0AIloGo/vanc
SI85yWtI7mR20x234NnchFd9aYMKjjCRZf/HOOpR++7AozPxvMOCPC26FM9cgmGZ
vPh46GKstlw1ef2PyTll6N63QBGBLZrpkGrF/BJBXHnmRaa0LWR1v28YrG9mek1m
tHoY83noSdk77NqPXdD6I6xO+ZQA0K4YwxIqikD66B8As7zb1MYxL5YsB0LH00SE
+SOJj9QTFDKNLXrnj3fSKSRkaoI+HVpYz9yUfFxd3hccXG5o+86y6fKKkLCTcjlj
Nk7VB38LnCs+c+tRzomdH/RQ70DbC8Daqek+ApQbl/LRxdWn1Bg=
=hI9w
-----END PGP SIGNATURE-----

--bnahpbh22u5vsx33--
