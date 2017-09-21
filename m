Received: from eggs.gnu.org ([2001:4830:134:3::10]:34779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dv1kI-0002Ub-2R
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 09:42:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dv1kG-000192-UT
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 09:42:26 -0400
Date: Thu, 21 Sep 2017 16:42:11 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170921134211.ilym353a3pmeilc4@postretch>
References: <20170921131707.17364-1-el13635@mail.ntua.gr>
	<20170921133535.GI13703@lemon.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6qmngimrenc2lk6v"
Content-Disposition: inline
In-Reply-To: <20170921133535.GI13703@lemon.lan>
Subject: Re: [Qemu-devel] [PATCH v2 0/3] add bdrv_co_drain_begin/end
 BlockDriver callbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>


--6qmngimrenc2lk6v
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 21, 2017 at 09:35:35PM +0800, Fam Zheng wrote:
>On Thu, 09/21 16:17, Manos Pitsidianakis wrote:
>> This patch series renames bdrv_co_drain to bdrv_co_drain_begin and adds =
a new
>> bdrv_co_drain_end callback to match bdrv_drained_begin/end and
>> drained_begin/end of BdrvChild. This is needed because the throttle driv=
er
>> (block/throttle.c) needs a way to mark the end of the drain in order to =
toggle
>> io_limits_disabled correctly.
>
>Is this a bug fix? I.e. do we need to Cc qemu-stable@?
>
>Fam

No that's not needed, throttle is not in 2.10. The bug in this case is=20
that the drain would wait for the throttled requests to be completed as=20
they were scheduled by the I/O throttling instead of restarting the=20
queue and scheduling them right away.

--6qmngimrenc2lk6v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAlnDwbMACgkQc2J8L2kN
9xBKaBAAk58U0Esn3EOewqqvqyyzWY3Ht0QTfh/zjGPgHj32qVH859wW/WMqdD98
dSIcreYJmMPSlJ/t/15FK3odsF5Hawx67fMkWAJ7B3eRrQd12GdIzjIniiISc9Zv
4qCvDwEhVXxWwBud84eSUWlFK92NSC7hdZM7Zjtt3q5Azi58qa2jh5O9rTXDWncg
VCQNPMDL1l9pTYol5bBOmLdCQcWZcfjrT1e0FmeFBLe3InOBQ1cKg8wfxDs1LoY8
ByEea1LX2k++mqXA6UG3fyFZaYrgJmB0bMdxshfUVWtUUdFS5OR+JEtoN994FCFa
EZEYRgUXxjLO35vwXgHoebvi+4EeRAAPvrHO0VAZrDBTwr8hZofrDk5kllfHstYd
wu5Dfr1bLF+VP64SkmGywgIfCPc0MFO/E6WoMaDj083xO6FsqRNnZly9jM4NHNlM
cxdttcqtC5GEPsfq29mZ7mX5Hhpk1OQOtvpc6ObhueLIMA3UxP9De62GT/AXUw47
MZHJENal1WDCsKRauur4T1HrL1I5qBK4u4voN1Qj0BiyusY5E8vC7m1eEUpZ0lez
0YyUZXLocEe+hHUuRGVIzcrjTYSo+HnMNIBZUjj9v79KaQdF8+2i0ZcjHnuFWPQe
Zn6Ch2fzXVDzqtJIdfJ40dS5l0WEZ1SQVVqCmGCqV2dYFaN6ADQ=
=pMoX
-----END PGP SIGNATURE-----

--6qmngimrenc2lk6v--
