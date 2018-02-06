Received: from eggs.gnu.org ([2001:4830:134:3::10]:41755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ej1wO-00069t-O2
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 07:01:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ej1wF-0001mQ-5B
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 07:01:36 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180206103941.13985-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f299cc78-6d7c-f66b-6662-e1498559ef21@amsat.org>
Date: Tue, 6 Feb 2018 09:01:19 -0300
MIME-Version: 1.0
In-Reply-To: <20180206103941.13985-1-peter.maydell@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="mA3i7GS5yF3BbUkLiRFvAc7CoLhUGrong"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH] target/arm/translate.c: Fix
 missing 'break' for TT insns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mA3i7GS5yF3BbUkLiRFvAc7CoLhUGrong
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: patches@linaro.org
Message-ID: <f299cc78-6d7c-f66b-6662-e1498559ef21@amsat.org>
Subject: Re: [Qemu-arm] [PATCH] target/arm/translate.c: Fix missing 'break'
 for TT insns
References: <20180206103941.13985-1-peter.maydell@linaro.org>
In-Reply-To: <20180206103941.13985-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/06/2018 07:39 AM, Peter Maydell wrote:
> The code where we added the TT instruction was accidentally

"In 5158de241b0 ..."

> missing a 'break', which meant that after generating the code
> to execute the TT we would fall through to 'goto illegal_op'
> and generate code to take an UNDEF insn.>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

> ---
> Doh...
>=20
>  target/arm/translate.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 55826b7e5a..572c4d1cb6 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -9926,6 +9926,7 @@ static void disas_thumb2_insn(DisasContext *s, ui=
nt32_t insn)
>                          tcg_temp_free_i32(addr);
>                          tcg_temp_free_i32(op);
>                          store_reg(s, rd, ttresp);
> +                        break;
>                      }
>                      goto illegal_op;
>                  }
>=20


--mA3i7GS5yF3BbUkLiRFvAc7CoLhUGrong
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlp5mQ8ACgkQ4+MsLN6t
wN4aiBAAvWauOIxILXDXXVjX7VcRTb4/zxGy0gNbzGKUc1xhollp2g+2P7Jeq0qo
svpwPajSeeu4Bd98TcC7lFi1GVBe3l0krZTeIFbW58kgi/VahMyBXATAQJwsu9Ac
96XuMdH8l42XMfQ83KIyGgku+J2lQ270XPTqCRVw49X667kuXIlgolKWauuLJ2cf
7Aw9/kkZjG5/QHzF2Lst+OzbnLSEd5z1rfKdx6usTTLlHGBSxTCcRXAfbNSrNJ2Y
XO/AP7PzfhA+Xtl7+JIyNW11yUJwCMcSYbz2qS4X9PfuNE8FPaZnM+chGNoccZFs
B2Zbg5o3ykq/KTqqdplqM+R9q2AyhTzsU2Xy39QtiDfHopNXI5goE5I4L7rJXPiT
6gIQXrpZ70csIO9mX4h8y5HM1v/Bq8XO+EDXIkWPgcQvsH74j1FIKs595oyP4b9a
MC7cSeAuBFzB9OkupmX8zGbEReuIZQwsvrAkXy+8So7aMnXQZKKrMmcAje7VpXbW
sRiiynPoH44w04tlNtqhCAjKGP/nXaJagTpR7IqnvcRrzsewcWJgZ/MmqopNWrC7
X5a76Kcq3bLjYD1yD66wXx4J8NOYpnYLyYu9zA7x+ddcHi+akn90ywp6yuzZMnRr
vpx/voO7pOADgUcNILvRVbybPZeJBR0J6VMkK+MKzfFLBm17eYU=
=AbIQ
-----END PGP SIGNATURE-----

--mA3i7GS5yF3BbUkLiRFvAc7CoLhUGrong--
