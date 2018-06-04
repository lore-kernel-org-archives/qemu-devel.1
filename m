Received: from eggs.gnu.org ([2001:4830:134:3::10]:44988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fPrc2-0003ng-1l
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:41:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fPrbz-0000Jp-EK
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:41:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50214 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fPrbz-0000JM-7X
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:41:35 -0400
References: <1468840039-14576-1-git-send-email-dgilbert@redhat.com>
	<CAFEAcA9fuXSHrFGd8Ox6UKsHzqEsiG9aZW8FGYZ4vjn0ufDOSw@mail.gmail.com>
	<20160718170025.GB6470@work-vm>
	<d7ce76d8-479b-6876-ce0e-0e9a9f5f0dfb@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c8b7f93a-5a86-8fc1-fc50-a7a0a60e4e73@redhat.com>
Date: Mon, 4 Jun 2018 17:41:26 +0200
MIME-Version: 1.0
In-Reply-To: <d7ce76d8-479b-6876-ce0e-0e9a9f5f0dfb@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="gd6xdF9KgB3piiLLhMPJWbDSnmKGlqeJp"
Subject: Re: [Qemu-devel] [PATCH 0/1] vmstatification of 0323 [for 2.8?]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gd6xdF9KgB3piiLLhMPJWbDSnmKGlqeJp
From: Paolo Bonzini <pbonzini@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>
Message-ID: <c8b7f93a-5a86-8fc1-fc50-a7a0a60e4e73@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/1] vmstatification of 0323 [for 2.8?]
References: <1468840039-14576-1-git-send-email-dgilbert@redhat.com>
 <CAFEAcA9fuXSHrFGd8Ox6UKsHzqEsiG9aZW8FGYZ4vjn0ufDOSw@mail.gmail.com>
 <20160718170025.GB6470@work-vm>
 <d7ce76d8-479b-6876-ce0e-0e9a9f5f0dfb@amsat.org>
In-Reply-To: <d7ce76d8-479b-6876-ce0e-0e9a9f5f0dfb@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/06/2018 07:09, Philippe Mathieu-Daud=C3=A9 wrote:
>=20
> I realized the binary expect CMD8 to not return, to use the SD card
> with Spec v1.x. Which is the very patch Paul Brook attached...
> http://lists.nongnu.org/archive/html/qemu-devel/2012-04/msg03790.html
>=20
> curl
> http://lists.nongnu.org/archive/html/qemu-devel/2012-04/txtwo8B9rbn9w.t=
xt
>=20
>      case 8:	/* CMD8:   SEND_IF_COND */
> +        if (sd->spi) {
> +            goto bad_cmd;
> +        }
>          /* Physical Layer Specification Version 2.00 command */
>          switch (sd->state) {
>          case sd_idle_state:

Can you send it with SoB?  Thanks!

Paolo


--gd6xdF9KgB3piiLLhMPJWbDSnmKGlqeJp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAlsVXakACgkQv/vSX3jH
roP7Zwf+Pva1Ld1n8EcZhlgfFi15ZthXs9ro3kht9IZp2u4Jx9+WaOzyZed7j64x
wYKj+8Pi3o5kOd2vbQEao4VCzeLzCkRUr5r7sbyuKCxuCllI0AxAOUt+CzU/ZIHu
JP8Brl3HbWP+Z9+Oczdey29Qg2sOMLQX3+xiq+d8yKDS82c5jxaW+2Icq7ZkbTHt
ATWGvLhpP2/Vhke/FEGL6xysfqnmoyOZKeqa4+AvTsP3UpmpkMP+gV1hrOwwSMNE
ucv9lyvkND+Lbwhu3+tNV5ToyW11JJtQT3J4NFQUtj40vpzpyNdsR0vlUT1tHddH
C+FmWjwyU/I0ohAcvRVwGy8M9qSjfg==
=C1HM
-----END PGP SIGNATURE-----

--gd6xdF9KgB3piiLLhMPJWbDSnmKGlqeJp--
