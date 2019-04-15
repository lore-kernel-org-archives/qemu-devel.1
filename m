Received: from eggs.gnu.org ([209.51.188.92]:39422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hG3UA-0002mc-Ji
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 11:25:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hG3U9-0004ZX-H2
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 11:25:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45160)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1hG3U7-0004NI-9I
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 11:25:29 -0400
References: <20190415141547.15444-1-berrange@redhat.com>
	<CAFEAcA9353Sar3Uny0Qvx0Ex6jP-dzE2w4AjsA4O8gCEF3RdKA@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0ade556d-bdf1-4440-472a-1e3e6cb7387a@redhat.com>
Date: Mon, 15 Apr 2019 10:25:03 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9353Sar3Uny0Qvx0Ex6jP-dzE2w4AjsA4O8gCEF3RdKA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rmunhz8EBV5AIIGBA8utpeR5o9Z9RxV3D"
Subject: Re: [Qemu-devel] [PATCH v2] vl: set LC_CTYPE early in main() for
 all code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Bandan Das <bsd@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rmunhz8EBV5AIIGBA8utpeR5o9Z9RxV3D
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, Bandan Das <bsd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0ade556d-bdf1-4440-472a-1e3e6cb7387a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] vl: set LC_CTYPE early in main() for all
 code
References: <20190415141547.15444-1-berrange@redhat.com>
 <CAFEAcA9353Sar3Uny0Qvx0Ex6jP-dzE2w4AjsA4O8gCEF3RdKA@mail.gmail.com>
In-Reply-To: <CAFEAcA9353Sar3Uny0Qvx0Ex6jP-dzE2w4AjsA4O8gCEF3RdKA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/15/19 9:25 AM, Peter Maydell wrote:
> On Mon, 15 Apr 2019 at 15:17, Daniel P. Berrang=C3=A9 <berrange@redhat.=
com> wrote:
>>

> A few typo nits below...

Also:

>=20
>>
>> +    /*
>> +     * Ideally we would set LC_ALL, but QEMU currently isn't able to =
cope
>> +     * with arbitrary localization settings. In particular there are =
two
>> +     * known problems

"two known problems" but...

>> +     *
>> +     *   - The QMP monitor needs to use the C locale rules for numeri=
c
>> +     *     formatting. This would need a double/int -> string formatt=
er
>> +     *     that is locale independant.
>=20
> "independent"
>=20
>> +     *
>> +     *   - The QMP monitor needs to encode all data as UTF-8. This ne=
eds
>> +     *     to be updated to use iconv(3) to explicitly convert the cu=
rrent
>> +     *     locale's charset into utf-8
>> +     *
>> +     *   - Lots of codes uses is{upper,lower,alnum,...} functions, ex=
pecting
>=20
> "code"
>=20
>> +     *     C locale sorting behaviour. Most QEMU usage should likely =
be
>> +     *     changed to g_ascii_is{upper,lower,alnum...} to match code
>> +     *     assumptions, without being broken by locale settnigs.
>=20
> "settings"

=2E..three bullet points.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--rmunhz8EBV5AIIGBA8utpeR5o9Z9RxV3D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAly0ok8ACgkQp6FrSiUn
Q2p4XQf/QiH2f8maq7m0AN1EAZL3r4p8DpBsx2TW54RWHdQLBWyGoP1PHAiqOK+I
5+zTjCTDcN6eqA7OCc/Vi9IyNKCoX03I8ZfDQdKR5U2e6cAUTix0G2QH75Ke7l8n
CX77qthfAubJ4cv0weBbuUheYwXJNU5mmUSvPSX4RI+M6SXDzVySkX/th5Odilwa
g9NPxoTYQPpBlw4eElV9a7JZn172xGmC3PPAMtjbL9jbsTHAxiNttJYxof796emV
gpdMJavPRe2FZuiwBP9GMCds9iWW/ciBGOkpuMQC7B6pll3OuTJyN+uuoKhW3Q7k
4SZ/fQLvvHHQKwpjvlAFOLC/YDJS/g==
=33Gy
-----END PGP SIGNATURE-----

--rmunhz8EBV5AIIGBA8utpeR5o9Z9RxV3D--
