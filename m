Received: from eggs.gnu.org ([2001:4830:134:3::10]:59286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f9HEn-000239-Nk
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 17:37:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f9HEj-0007bj-Qe
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 17:37:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46094 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f9HEj-0007bY-LE
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 17:37:01 -0400
References: <20180419135901.30035-1-alex.bennee@linaro.org>
	<20180419135901.30035-4-alex.bennee@linaro.org>
	<e35eeb70-4bbc-a0fe-2903-6cf58d1729fe@linaro.org>
	<48da6bcd-ecab-52d1-aee1-ed99be90d428@linaro.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3bff98d5-9ce7-68eb-c8d6-731a8458ab9d@redhat.com>
Date: Thu, 19 Apr 2018 16:36:56 -0500
MIME-Version: 1.0
In-Reply-To: <48da6bcd-ecab-52d1-aee1-ed99be90d428@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="syrIqcZBX8RwYkXJRjcUgwjCUrdANC2X8"
Subject: Re: [Qemu-devel] [PATCH v2 03/43] configure: add support for
 --cross-cc-FOO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--syrIqcZBX8RwYkXJRjcUgwjCUrdANC2X8
From: Eric Blake <eblake@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 peter.maydell@linaro.org, cota@braap.org, famz@redhat.com,
 berrange@redhat.com, f4bug@amsat.org, balrogg@gmail.com,
 aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org
Message-ID: <3bff98d5-9ce7-68eb-c8d6-731a8458ab9d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 03/43] configure: add support for
 --cross-cc-FOO
References: <20180419135901.30035-1-alex.bennee@linaro.org>
 <20180419135901.30035-4-alex.bennee@linaro.org>
 <e35eeb70-4bbc-a0fe-2903-6cf58d1729fe@linaro.org>
 <48da6bcd-ecab-52d1-aee1-ed99be90d428@linaro.org>
In-Reply-To: <48da6bcd-ecab-52d1-aee1-ed99be90d428@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/19/2018 03:47 PM, Richard Henderson wrote:
> On 04/19/2018 10:41 AM, Richard Henderson wrote:
>> On 04/19/2018 03:58 AM, Alex Benn=C3=A9e wrote:
>>> +  --cross-cc-*) cc_arch=3D${opt#--cross-cc-}
>>> +                eval "cross_cc_${cc_arch}=3D\$optarg"
>>
>> This doesn't work as intended.
>>
>> Given e.g. --cross-cc-aarch64=3Daarch64-linux-gcc
>>
>> + cc_arch=3Daarch64=3Daarch64-linux-gcc
>> + eval 'cross_cc_aarch64=3Daarch64-linux-gcc=3D$optarg'
>> ++ cross_cc_aarch64=3Daarch64-linux-gcc=3Daarch64-linux-gcc
>>
>> Which sets the variable "cross_cc_aarch64"
>> to "aarch64-linux-gcc=3Daarch64-linux-gcc".
>> Which of course won't exist to execute.
>=20
> -  --cross-cc-*) cc_arch=3D${opt#--cross-cc-}
> +  --cross-cc-*) cc_arch=3D$(expr "$opt" : '--cross-cc-\([^=3D]*\)')

Forking an expr subshell may not be needed; how about:

--cross-cc-*) cc_arch=3D${opt#--cross-cc-}; cc_arch=3D${cc_arch%%=3D*}

to strip both the --cross-cc- prefix, and any suffix starting at the
first =3D.

>=20
> seems to do the trick.  Obviously a similar change will be needed for
> --cross-cc-flags-*.
>=20
>=20
> r~
>=20
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--syrIqcZBX8RwYkXJRjcUgwjCUrdANC2X8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrZC/gACgkQp6FrSiUn
Q2rQcwgAq7oJYuNTrGTHvyBTpwrgQXc9GOsY6pqTQYeC6wZ+8/hB3rw+BGcTHNH1
gETjlh7dqtKm5qJPxJdRsFCLhNjbk+SW3JCQjkv8pC+GnALx4ms7VsIYFkRy23Xf
6LnOxdKzjzS94A3S/9t5RCqh48951V4l0Q3ZyVv2WDc0qKq6cIOpt3wyu8mPJCS1
EClOVZFZP2ZX5C5piMR4w5dhVwXrIO34bI5f198dXzprTnQpfmk0aEaQM8UvqOn4
rtyOqgxhFicu0ZDKDuwSi1euPaChcFAlqdSWhycsuCKQoX7ECrP3iPKe3+8w/zxL
81KTLuT0x2xpfI6OwA2ZyxPLkMFs6g==
=dQRM
-----END PGP SIGNATURE-----

--syrIqcZBX8RwYkXJRjcUgwjCUrdANC2X8--
