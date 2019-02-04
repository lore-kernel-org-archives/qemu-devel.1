Received: from eggs.gnu.org ([209.51.188.92]:59645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqo5b-0002O3-RX
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 18:55:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqo5a-0007zs-Bp
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 18:55:47 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34278)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gqo5Y-0007wB-EE
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 18:55:45 -0500
Received: by mail-wr1-f68.google.com with SMTP id f7so1835386wrp.1
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 15:55:38 -0800 (PST)
References: <20190129175403.18017-1-philmd@redhat.com>
	<20190129175403.18017-11-philmd@redhat.com>
	<7c5ac6a4-0d1f-2ee1-af9b-16833480188a@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a3b97154-d00c-b930-8f13-c87f7fbdf0eb@redhat.com>
Date: Tue, 5 Feb 2019 00:55:34 +0100
MIME-Version: 1.0
In-Reply-To: <7c5ac6a4-0d1f-2ee1-af9b-16833480188a@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="uIxg97lMc9cQQng5dMMZbORTiVYxICF3c"
Subject: Re: [Qemu-devel] [RFC PATCH v2 10/18] qemu-iotests: Ensure GNU sed
 is used
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Brad Smith <brad@comstyle.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fam Zheng <fam@euphon.net>, "Michael S. Tsirkin" <mst@redhat.com>, Kamil Rytarowski <kamil@netbsd.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uIxg97lMc9cQQng5dMMZbORTiVYxICF3c
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Eric Blake <eblake@redhat.com>, Brad Smith <brad@comstyle.com>,
 qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Fam Zheng <fam@euphon.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, Kamil Rytarowski <kamil@netbsd.org>
Message-ID: <a3b97154-d00c-b930-8f13-c87f7fbdf0eb@redhat.com>
Subject: Re: [RFC PATCH v2 10/18] qemu-iotests: Ensure GNU sed is used
References: <20190129175403.18017-1-philmd@redhat.com>
 <20190129175403.18017-11-philmd@redhat.com>
 <7c5ac6a4-0d1f-2ee1-af9b-16833480188a@redhat.com>
In-Reply-To: <7c5ac6a4-0d1f-2ee1-af9b-16833480188a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/29/19 11:21 PM, Eric Blake wrote:
> On 1/29/19 11:53 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>> Various sed regexp from common.filter use sed GNU extensions.
>> Instead of spending time to write these regex to be POSIX compliant,
>> verify the GNU sed is available and use it.
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>> I think the test isn't well placed in common.filter and should be in
>> common.rc, but couldn't get that working.
>> ---
>=20
>> +++ b/tests/qemu-iotests/common.filter
>> @@ -23,37 +23,37 @@
>>  #
>>  _filter_date()
>>  {
>> -    sed \
>> +    ${SED} \
>=20
> I might have written $SED instead of ${SED}, but that's merely
> aesthetics and not a correctness issue.
>=20
>=20
>> +++ b/tests/qemu-iotests/common.rc
>> @@ -17,6 +17,18 @@
>>  # along with this program.  If not, see <http://www.gnu.org/licenses/=
>.
>>  #
>> =20
>=20
> If SED is inherited in the environment prior to this point,...
>=20
>> +for sed in sed gsed; do
>> +    (command $sed --version | grep 'GNU sed') > /dev/null 2>&1
>=20
> Why do you need command here? (It doesn't hurt, but I also don't see ho=
w
> it helps).

I copy/pasted the 'dd' use in the same file :/

>=20
>> +    if [ "$?" -eq 0 ]; then
>> +        SED=3D$sed
>> +        break
>> +    fi
>> +done
>=20
> ...but neither sed nor gsed are GNU sed,
>=20
>> +if [ -z "$SED" ]; then
>> +    echo "$0: GNU sed not found"
>> +    exit 1
>> +fi
>=20
> ...then you fail to diagnose that. Fix it by adding SED=3D prior to the=
 loop.

Good point, thanks!

Regards,

Phil.


--uIxg97lMc9cQQng5dMMZbORTiVYxICF3c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEicHnj2Ae6GyGdJXLoqP9bt6twN4FAlxY0PcACgkQoqP9bt6t
wN4Thw/+PNVOEmGtrUyYgutlf5VBIgRVuyNud5PteZyDwNFjAv7MKbt303ZlFWum
alCBZK8OVXEGdlch5/50AVnHQagxNDiQPzu4lghWFVAZz7qQQntaPBJRUWYF7b1+
0JJxDCk+b+P7eAadFbWRnQnaRTxLlWXgBC1R2Lwp3lqSsIgwC+7tpNx8fsUxrbZQ
2QmyJA4T7MKzEJKK6x1QLVRxz+5BttmG9B+4bf0PNtCACnhWC/AHZjXZ9jn6mmQl
9XIJpnoNukqU3vkosBTif0ZEhdkHL4QLA/rqkLw3Ve+KqbsJ0yg3H4Aq3JHM7ul7
orZN+zrBPEazR22QNRrgi/4ieUC2B06iLcPk77p30VJSa7zETLr2YBFvT7jFf2om
4WYZSzinTZkl8RYohTrsiZbbv4CSvrJv0vObg9F6E7LnwD/QNQnzhvbvahZ4Zddl
P9QQq8l4jvE3PCiqFyWY1GFW+rTK65tZzQRfVUSX6DmiqTZFIMIowTXgsOlAzuYo
2SArpe6aSrsyNPmhrk77J4DHzHihrxuftcoeqO8efmK1hUc0uAyRslG2HRoA81Qh
NO5IUTOOGGTcTAKBgcYZMMVADwNTcF0wxocZ1+L9CFAgXghvWO5S2KMJmiOIXwiN
GdqlAhI2fzoED/oo+HtdL+kWA3IjwV4ZxOjM7dxvC7G6rQ+tzD8=
=ONWB
-----END PGP SIGNATURE-----

--uIxg97lMc9cQQng5dMMZbORTiVYxICF3c--
