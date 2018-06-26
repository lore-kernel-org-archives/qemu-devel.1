Received: from eggs.gnu.org ([2001:4830:134:3::10]:37732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fXk99-0003PP-Pc
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 05:20:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fXk90-0000mB-EP
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 05:20:23 -0400
References: <20180619093124.24011-1-luc.michel@greensocs.com>
	<d3c05355-4eda-f501-8f04-d808f416393a@web.de>
	<CAFEAcA80O-6ycsVFEkfTSYCakQQZyGy9VV-+2rx6dE3-Ffd-Ng@mail.gmail.com>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <cfbf6580-61ef-f586-2f9e-5ec9d999de8c@greensocs.com>
Date: Tue, 26 Jun 2018 11:20:06 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA80O-6ycsVFEkfTSYCakQQZyGy9VV-+2rx6dE3-Ffd-Ng@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="AV15jx9VyFl8lB3t2zxgIIhJZkkqk0WWH"
Subject: Re: [Qemu-devel] [PATCH v2 0/7] arm_gic: add virtualization
 extensions support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Jan Kiszka <jan.kiszka@web.de>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Sai Pavan Boddu <saipava@xilinx.com>, Edgar Iglesias <edgari@xilinx.com>, Mark Burton <mark.burton@greensocs.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AV15jx9VyFl8lB3t2zxgIIhJZkkqk0WWH
From: Luc Michel <luc.michel@greensocs.com>
To: Peter Maydell <peter.maydell@linaro.org>, Jan Kiszka <jan.kiszka@web.de>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Sai Pavan Boddu <saipava@xilinx.com>, Edgar Iglesias <edgari@xilinx.com>,
 Mark Burton <mark.burton@greensocs.com>
Message-ID: <cfbf6580-61ef-f586-2f9e-5ec9d999de8c@greensocs.com>
Subject: Re: [PATCH v2 0/7] arm_gic: add virtualization extensions support
References: <20180619093124.24011-1-luc.michel@greensocs.com>
 <d3c05355-4eda-f501-8f04-d808f416393a@web.de>
 <CAFEAcA80O-6ycsVFEkfTSYCakQQZyGy9VV-+2rx6dE3-Ffd-Ng@mail.gmail.com>
In-Reply-To: <CAFEAcA80O-6ycsVFEkfTSYCakQQZyGy9VV-+2rx6dE3-Ffd-Ng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/25/2018 01:12 PM, Peter Maydell wrote:
> On 25 June 2018 at 05:55, Jan Kiszka <jan.kiszka@web.de> wrote:
>> On 2018-06-19 11:31, luc.michel@greensocs.com wrote:
>>> From: Luc MICHEL <luc.michel@greensocs.com>
>>>
>>> This patch series add support for the virtualization extensions in th=
e
>>> ARM GICv2 interrupt controller.
>>>
>>> The first two commits do some refactoring to prepare for the
>>> implementation. Commits 3 and 4 are the actual implementation. The la=
st
>>> commit updates the ZynqMP implementation to support virtualization.
>>
>> Is it enabled for the virt machine as well? Seems we are missing some
>> mapping of GICV and GICH there.
>=20
> I agree that it would be very nice to see this enabled for the
> 'virt' board; it's a bit tricky for me to test otherwise. It
> should just be a matter of mapping in the GICV and GICH,
> wiring up the maintenance interrupt, and advertising it
> correctly in the DTB and ACPI data...
OK, I'll give it a look for the v3 then.
>=20
> I'm hoping to get to reviewing this series this afternoon.
>=20
> thanks
> -- PMM
>=20


--AV15jx9VyFl8lB3t2zxgIIhJZkkqk0WWH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUvSC0Bi15mxw2PT5d8knW3QnTr4FAlsyBUYACgkQd8knW3Qn
Tr7YpA/+JZrar53rJQo1GnNfr6ZS+EDirClfbBh4Rff8KJLMF5BELu71Va8jCkeN
4eDL93f/CurhQHVHjT8mj1paWpMZDxdl5Vnv/dQB9VvsYBRaohacFbbyGFu53Roy
n7hu0+2qCmobAerCdXIAos8GhFHMS0RUxHXNt9IT2FeeEhR+BGcMw2H/R7sN92tk
SiUrY/4zahUrSKsrei9cC6cHzijgAKIDVhPM9B2fVFKGM79qHA8Y/amgGVHy1/sj
TxBQLPzEls2cvzUJ/ISsRJdW499fbBwJ65bAl6P8ZaTNevLTjuxEEZqkzGXeY2X7
RAOo8/kfTaA6vlXcdDmcpHTUwSSRRNYdmRSysl30A0pC7ygd4QxLAfnIcH0CA0WA
JaSsNe3semWfdBcDpGFC/lCWZ14bV0bSTMh1o5bYTCL/e0EjN+2SabTrn8hJyODQ
b+oPnMAH/7MeG5mGdNW6klGCZjquv9dAtmRr7u/R/i2nxZVvhozsoPivei7r4IYH
bjfklyFlZCXnkpj35Rmhe3m8h3Gt2L5958oneYD3YW1qcUOlStOZ4kFx0SNV8fUV
riy+RRaPpufBk1VdvBqAZpqx1z/DLKPnMJvWv4+fhfeoYY110qpwL34EH/yBSkUS
507RoKD3vNQSZf5fKjeghBACwu5qRHEtNEhVA5jDmO6gSKiQ5Fg=
=X4Ob
-----END PGP SIGNATURE-----

--AV15jx9VyFl8lB3t2zxgIIhJZkkqk0WWH--
