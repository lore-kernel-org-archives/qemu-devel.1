Received: from eggs.gnu.org ([2001:4830:134:3::10]:43192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecZW3-0000Zd-Uf
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 11:27:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecZVz-00014Z-78
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 11:27:43 -0500
Received: from mail-qt0-x22b.google.com ([2607:f8b0:400d:c0d::22b]:42443)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecZVz-00014Q-1x
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 11:27:39 -0500
Received: by mail-qt0-x22b.google.com with SMTP id c2so5122641qtn.9
	for <qemu-devel@nongnu.org>; Fri, 19 Jan 2018 08:27:38 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180115115309.23982-1-quintela@redhat.com>
	<CAFEAcA-SxiJyKa84UwG8CESpkTXEM9AG5HqEgpPrzSFwrTPzYg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d746e2e8-3690-c27e-f816-9892b36d8a1c@amsat.org>
Date: Fri, 19 Jan 2018 13:27:23 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-SxiJyKa84UwG8CESpkTXEM9AG5HqEgpPrzSFwrTPzYg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="Yh6jBHNABqqnVBuXFJOMqL6y760KTwQE1"
Subject: Re: [Qemu-devel] [PULL 00/27] Migration pull
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: Laurent Vivier <lvivier@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Yh6jBHNABqqnVBuXFJOMqL6y760KTwQE1
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Alexey Perevalov <a.perevalov@samsung.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: Laurent Vivier <lvivier@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <d746e2e8-3690-c27e-f816-9892b36d8a1c@amsat.org>
Subject: Re: [Qemu-devel] [PULL 00/27] Migration pull
References: <20180115115309.23982-1-quintela@redhat.com>
 <CAFEAcA-SxiJyKa84UwG8CESpkTXEM9AG5HqEgpPrzSFwrTPzYg@mail.gmail.com>
In-Reply-To: <CAFEAcA-SxiJyKa84UwG8CESpkTXEM9AG5HqEgpPrzSFwrTPzYg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/15/2018 01:14 PM, Peter Maydell wrote:
> On 15 January 2018 at 11:52, Juan Quintela <quintela@redhat.com> wrote:=

>> Hi
>> - rebase on top of lastest
>> - fix compilation on 32bit machines
>> - add Peter Xu cleanups
>>
>> Please, apply.
>>
>> The following changes since commit fd06527b80c88c8dde1b35fdc692685b68d=
2fd93:
>>
>>   Merge remote-tracking branch 'remotes/thibault/tags/samuel-thibault'=
 into staging (2018-01-15 10:39:29 +0000)
>>
>> are available in the Git repository at:
>>
>>   git://github.com/juanquintela/qemu.git tags/migration/20180115
>>
>> for you to fetch changes up to 816306826a45f4d15352e32d157172af3a35899=
f:
>>
>>   migration: remove notify in fd_error (2018-01-15 12:48:13 +0100)
>>
>> ----------------------------------------------------------------
>> migration/next for 20180115
>=20
> Applied, thanks.

We have armel/armhf/powerpc hosts failing since this pull due to commit
3be98be4e9f.

Those target are currently tested on Shippable CI, eventually adding an
IRC bot we could notice.

I know companies using QEMU system in embedded armel/armhf hosts, I
don't know about the ppc32 hosts.
This is however unlikely the migration features are used there.

If 64bit atomic op are required for migration (performance/security) but
not on 32bit system, one way to fix it could be to have the migration
code being optional... so we can disable it on 32bit hosts.

Regards,

Phil.


--Yh6jBHNABqqnVBuXFJOMqL6y760KTwQE1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlpiHGsACgkQ4+MsLN6t
wN7Z4Q/5ATVeVKHEHlJEBoNO12LweNT/UgMxL3tF1mOYbIsH2xUf39DerfLkW6Sq
9ly06GgQegtWfqKQSJX+hX62XacOk9m+2EoXJ1yYdgYuj4ug0ZqKsFrY0j9zTomJ
43kEqgMh38cA/H0WxL0XV1n8zptQcIicKtdYbXxWk3bAXTZpaDP/GRjmTPnWgiIb
cAZfbZBoezyOEVuFoJcF7PIcOkSgFYUffNrZbn8fUZjhkxuEpSVV8AJl16oR5AAZ
Qw5WQba+MuQDnkQWxJdL4tFA3PJ3hSUFj+38G3/18gRNWeT5PGl3y6OJIvyEZpyI
+8i4ILCiznUBfVVHv9flmUEiOrY6hD3lrLsQ7X0dUDTzQmooqWYdO3g27xggeRsF
GUmwWaBQA9yUs007rtpdwxi3ebIyMCSwpwi13mFqhBXdzs6r2ohUrCDsOQ43Rlgn
JRrEVLh4B0it2ui2VqT8fWcJNICzqumI9SnIvdrxxkuRui0zZc1U+e5qw2aTEpvQ
+WwQ4S3WEF0IhF5xEt9LfaU2yZMR4cNZYofH98MobciHIe5ljgj1+s25VV8M/efS
3Q5YBAIO9JpkH6fLpIorvT/2DMrVYLdR406KtdudWnokq1YT66MTNawN3RhTNVYa
3YjV+1wnkgGRcNHlBILtnWrpDpbLbHXzR/KZVpww2Rebs+CQ/nI=
=nJZL
-----END PGP SIGNATURE-----

--Yh6jBHNABqqnVBuXFJOMqL6y760KTwQE1--
