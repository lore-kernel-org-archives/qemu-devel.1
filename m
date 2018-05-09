Received: from eggs.gnu.org ([2001:4830:134:3::10]:47640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fGMOe-0006t6-1t
	for qemu-devel@nongnu.org; Wed, 09 May 2018 06:32:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fGMOZ-0006rP-Vs
	for qemu-devel@nongnu.org; Wed, 09 May 2018 06:32:32 -0400
References: <20180418075045.27393-1-olaf@aepfle.de>
	<41df38a4-dc02-7c17-4877-26541fddd209@redhat.com>
	<d058d5e6-710b-2f34-9828-9ddde18069a1@redhat.com>
	<20180509074434.23de9dab.olaf@aepfle.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e823b03a-7269-7b43-99cb-6b734f5105db@redhat.com>
Date: Wed, 9 May 2018 12:32:13 +0200
MIME-Version: 1.0
In-Reply-To: <20180509074434.23de9dab.olaf@aepfle.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="n6Orlz0luk8fBsPrdZI5HD37hUyeMmbmL"
Subject: Re: [Qemu-devel] [PATCH v1] configure: recognize more rpmbuild
 macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Olaf Hering <olaf@aepfle.de>
Cc: qemu-trivial@nongnu.org, "open list:All patches CC here" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--n6Orlz0luk8fBsPrdZI5HD37hUyeMmbmL
From: Paolo Bonzini <pbonzini@redhat.com>
To: Olaf Hering <olaf@aepfle.de>
Cc: qemu-trivial@nongnu.org,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <f4bug@amsat.org>
Message-ID: <e823b03a-7269-7b43-99cb-6b734f5105db@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1] configure: recognize more rpmbuild macros
References: <20180418075045.27393-1-olaf@aepfle.de>
 <41df38a4-dc02-7c17-4877-26541fddd209@redhat.com>
 <d058d5e6-710b-2f34-9828-9ddde18069a1@redhat.com>
 <20180509074434.23de9dab.olaf@aepfle.de>
In-Reply-To: <20180509074434.23de9dab.olaf@aepfle.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 09/05/2018 07:44, Olaf Hering wrote:
> Am Wed, 9 May 2018 00:15:42 +0200
> schrieb Paolo Bonzini <pbonzini@redhat.com>:
>=20
>> Actually, --program-prefix=3D and --exec-prefix=3D have a meaning, the=
y
>> cannot just be ignored.  For now I've removed this line; what is the
>> exact incantation used by SUSE Linux?
>=20
> Like in every other rpm.rpm I guess:
>=20
> /usr/lib/rpm/macros:%_exec_prefix               %{_prefix}
> /usr/lib/rpm/macros:    --program-prefix=3D%{?_program_prefix} \\\
> /usr/lib/rpm/macros:    --exec-prefix=3D%{_exec_prefix} \\\
>=20
> Are you saying your %configure is different from my %configure?
> In any case, qemu has to tolerate both options.

I agree that it's a worthwhile improvement but it also has to fail if
use an argument other than the default (or implement them, which I'm
probably not advising here).  Otherwise packaging breaks if someone for
whatever reason overrides the %_program_prefix and %_exec_prefix macros.

Paolo


--n6Orlz0luk8fBsPrdZI5HD37hUyeMmbmL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAlryzjAACgkQv/vSX3jH
roN66Af+PP2rpTKeAtkkai2+rNwOxrt62UJcJyfWKFWPB4Ggq3SbFhBKNHO62xgP
xTVWAS6bGI5/5LCa8FziBbaPjza/UtU5FQGOnLjLonK0qS+03T0da+RXF7EkYCIA
O7mO2INRFi4xaAYYY9VvRSR/JF3ykRqvGuSR14Y1YgmIBstxjRQ8BNSSlr58+tER
VoC+nMOBH6VmIK2dwNGls1G+dYiZkTqbx8uWvGgLUrfziwZUjccB05SkxFbaXy2K
ZrHRgznc6Hp6fUyIUVAnMZHn4rwOWPg535Pbjks9hLSUPDn+JrDFOKy5tMmGGGOR
VZbitER70jN9rwEg1q0bSIakRu5WiA==
=OcrH
-----END PGP SIGNATURE-----

--n6Orlz0luk8fBsPrdZI5HD37hUyeMmbmL--
