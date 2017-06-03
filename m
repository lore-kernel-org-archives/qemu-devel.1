Received: from eggs.gnu.org ([2001:4830:134:3::10]:38876)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1dH668-00073k-73
	for qemu-devel@nongnu.org; Sat, 03 Jun 2017 06:15:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1dH664-00071f-U0
	for qemu-devel@nongnu.org; Sat, 03 Jun 2017 06:15:56 -0400
Received: from mout.gmx.net ([212.227.17.21]:50840)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1dH664-00071X-I6
	for qemu-devel@nongnu.org; Sat, 03 Jun 2017 06:15:52 -0400
References: <1496414138-7622-1-git-send-email-peter.maydell@linaro.org>
	<ed2675f7-08f7-5bcd-2ed3-3ecb865e54fe@codingfarm.de>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <962c8e37-8cc1-ff7d-d88d-ff3e2934146b@gmx.com>
Date: Sat, 3 Jun 2017 12:17:42 +0200
MIME-Version: 1.0
In-Reply-To: <ed2675f7-08f7-5bcd-2ed3-3ecb865e54fe@codingfarm.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="umNvTrjRdamrNXaWplvT8aXKNCFIGEMhq"
Subject: Re: [Qemu-devel] [PATCH] configure: Define NCURSES_WIDECHAR if
 we're using curses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Rainer_M=c3=bcller?= <raimue@codingfarm.de>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Chad Joan <chadjoan@gmail.com>, Laszlo Ersek <lersek@redhat.com>, patches@linaro.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--umNvTrjRdamrNXaWplvT8aXKNCFIGEMhq
From: Kamil Rytarowski <n54@gmx.com>
To: =?UTF-8?Q?Rainer_M=c3=bcller?= <raimue@codingfarm.de>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Chad Joan <chadjoan@gmail.com>,
 Laszlo Ersek <lersek@redhat.com>, patches@linaro.org
Message-ID: <962c8e37-8cc1-ff7d-d88d-ff3e2934146b@gmx.com>
Subject: Re: [Qemu-devel] [PATCH] configure: Define NCURSES_WIDECHAR if we're
 using curses
References: <1496414138-7622-1-git-send-email-peter.maydell@linaro.org>
 <ed2675f7-08f7-5bcd-2ed3-3ecb865e54fe@codingfarm.de>
In-Reply-To: <ed2675f7-08f7-5bcd-2ed3-3ecb865e54fe@codingfarm.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03.06.2017 12:13, Rainer M=C3=BCller wrote:
> On 2017-06-02 16:35, Peter Maydell wrote:
>> diff --git a/configure b/configure
>> index 0586ec9..6aca5d1 100755
>> --- a/configure
>> +++ b/configure
>> @@ -3053,6 +3053,8 @@ int main(void) {
>>  EOF
>>    IFS=3D:
>>    for curses_inc in $curses_inc_list; do
>> +    # Make sure we get the wide character prototypes
>> +    curses_inc=3D"-DNCURSES_WIDECHAR $curses_inc"
>>      IFS=3D:
>>      for curses_lib in $curses_lib_list; do
>>        unset IFS
>>
>=20
> Thank you for getting back to this. I can confirm that this patch fixes=

> --enable-curses for me on Mac OS X.
>=20
> Although this already works as is, I would use -DNCURSES_WIDECHAR=3D1 a=
s
> ncurses.h uses #if and not #ifdef to check for this.
>=20

-DNCURSES_WIDECHAR evaluates to 1 for #if

> Rainer
>=20



--umNvTrjRdamrNXaWplvT8aXKNCFIGEMhq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZMozTAAoJEEuzCOmwLnZsBYQP/R5O9I1EeI3S3xcwlOrJhvaR
pR1KjXYnHaRbfbSOG6hoeON74bavwLvNfTxu6z8Ou3wv93g49pxDRJ9eFRl7lis9
da8MnxvN1c2H4a1x5jwbOMJ1PfSqjWydHqxf1dCgQwjFjV63QPmUKR1Vwp3oo1ma
bNLBK6JKYsV4wt3Z7gpQDMykfeZKpp44Ej1GBwvyo5bkUqHJRGmqSoFtyIeqYzMs
p+PRL4PBB0MYHLkVqP9iERq/Q13S7yqRUNV4ZRoZ6gfKPBdL6n71O/lqrAz1aUAg
vRGvEoos70KbnI8ejJMYtLvPacqkv3C2L6HazQNYMEJQ1R9D+U8TpJq/3SciQNyl
YkOeLGWDN9cYohf6Boa3piLThKMBkTtdFQdYXycyputi02MWCfEuNifDlo/AeruW
7VF+VhyXxQQZmUSQMwNs1FmkDAyLjhYLIWFLKKVr8RSE2wBhz5AGFq1cFGf610qP
t+p77pTsQ+r3ksYzEU65pHltxCU5A0JOqCCTcLp2MB21Oc5UUHIf+Ri9NHZmqyTR
EsJisilzd1O82S81gtoIZj9/Rd5ZDMN/vdu1nyc3ZtgvXrxLGgSeT5qNQbZUsJ7B
GE+VdoH97nlWlPx3b11JJVHXIG5pylWbAPoL/I0fkh0ADn1VOSPRlYB9icom0JvY
KTld5s9LCeel/uQPf24J
=PUJv
-----END PGP SIGNATURE-----

--umNvTrjRdamrNXaWplvT8aXKNCFIGEMhq--
