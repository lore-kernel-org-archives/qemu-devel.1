Received: from eggs.gnu.org ([2001:4830:134:3::10]:59035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXdSI-0003uR-0x
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 21:07:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXdSD-0000FI-BY
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 21:07:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50406)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dXdSD-0000F7-28
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 21:07:05 -0400
References: <20170628204452.41230-1-raj.khem@gmail.com>
	<d8913f99-d989-c79a-b0a0-78179e16ef72@vivier.eu>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0be13778-0c11-4ebd-7ce7-bf42a4a309f5@redhat.com>
Date: Tue, 18 Jul 2017 20:07:02 -0500
MIME-Version: 1.0
In-Reply-To: <d8913f99-d989-c79a-b0a0-78179e16ef72@vivier.eu>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="014LTSbSevn5gG0TvEbfuNpuUUdLwT1dj"
Subject: Re: [Qemu-devel] [PATCH] replace struct ucontext with ucontext_t
 type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, Khem Raj <raj.khem@gmail.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kamil Rytarowski <kamil@netbsd.org>, Riku Voipio <riku.voipio@iki.fi>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--014LTSbSevn5gG0TvEbfuNpuUUdLwT1dj
From: Eric Blake <eblake@redhat.com>
To: Laurent Vivier <laurent@vivier.eu>, Khem Raj <raj.khem@gmail.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kamil Rytarowski <kamil@netbsd.org>,
 Riku Voipio <riku.voipio@iki.fi>
Message-ID: <0be13778-0c11-4ebd-7ce7-bf42a4a309f5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] replace struct ucontext with ucontext_t type
References: <20170628204452.41230-1-raj.khem@gmail.com>
 <d8913f99-d989-c79a-b0a0-78179e16ef72@vivier.eu>
In-Reply-To: <d8913f99-d989-c79a-b0a0-78179e16ef72@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/29/2017 09:09 AM, Laurent Vivier wrote:

> ...
>> diff --git a/linux-user/signal.c b/linux-user/signal.c
>> index 3d18d1b3ee..2c55a4f600 100644
>> --- a/linux-user/signal.c
>> +++ b/linux-user/signal.c
>> @@ -3346,7 +3346,7 @@ static void setup_rt_frame(int sig, struct targe=
t_sigaction *ka,
>>      *
>>      *   a0 =3D signal number
>>      *   a1 =3D pointer to siginfo_t
>> -    *   a2 =3D pointer to struct ucontext
>> +    *   a2 =3D pointer to ucontext_t
>>      *
>>      * $25 and PC point to the signal handler, $29 points to the
>>      * struct sigframe.
>> @@ -3733,7 +3733,7 @@ struct target_signal_frame {
>> =20
>>  struct rt_signal_frame {
>>      siginfo_t info;
>> -    struct ucontext uc;
>> +    ucontext_t uc;
>>      uint32_t tramp[2];
>>  };
>> =20
>> @@ -3949,7 +3949,7 @@ struct rt_signal_frame {
>>      siginfo_t *pinfo;
>>      void *puc;
>>      siginfo_t info;
>> -    struct ucontext uc;
>> +    ucontext_t uc;
>>      uint16_t retcode[4];      /* Trampoline code. */
>>  };
>> =20
>=20
> I think these two rt_signal_frame are unused and can be removed.

Sounds like a separate patch, though.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--014LTSbSevn5gG0TvEbfuNpuUUdLwT1dj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAllusLYACgkQp6FrSiUn
Q2qiDgf/ZIBsOWMAX3WY3bUJrpReGgwEFcFvHTV37b2e0DDkKWXFeno7rr/+LoDm
JNu5d4CSIYobPrGPTcyiBFnpAVBqtp3+S4l8U+I8Fwft2NVnyDpYdUjptEf00wcC
bUWb1ownnao80LKWZyln0hLKdV+HLtDd8hXSVxoF6ThTHJsNcfrI6FpkCESV4dS+
Qa7sCgwTIE/gGrfiM4dZPV+vVOT3o/JothL1nSlSD4e8OrAr9b8S9FqhEC2OoJt/
tvlmR2iZ5abSp5JW6/P+5SOtkaxcfbLQDAOnn3z9gIfXiGONQbHLnznuCTVjetyk
5SLa+zZ1YIuIcJrajpE9SLiZFhyQRg==
=U+J9
-----END PGP SIGNATURE-----

--014LTSbSevn5gG0TvEbfuNpuUUdLwT1dj--
