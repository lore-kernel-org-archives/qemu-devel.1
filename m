Received: from eggs.gnu.org ([2001:4830:134:3::10]:55457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fl4kS-0006l2-2b
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 23:58:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fl4kO-0002HQ-Vy
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 23:58:00 -0400
Received: from mail-vk0-x22c.google.com ([2607:f8b0:400c:c05::22c]:37431)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fl4kO-0002Go-Oa
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 23:57:56 -0400
Received: by mail-vk0-x22c.google.com with SMTP id v72-v6so389399vkd.4
	for <qemu-devel@nongnu.org>; Wed, 01 Aug 2018 20:57:56 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <9cd33f65-c0df-637c-4d7e-90c8c4227216@amsat.org>
	<20180731104059.55s76c2ent772z4b@toto>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <24c01558-7352-74a6-31b8-9a495aa9fc13@amsat.org>
Date: Thu, 2 Aug 2018 00:57:48 -0300
MIME-Version: 1.0
In-Reply-To: <20180731104059.55s76c2ent772z4b@toto>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="MvBgox7lMwlhMza5AlK2DUOsCwy6o2pzK"
Subject: Re: [Qemu-devel] microblaze build failure due to definition clash
 on riscv
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis <alistair.francis@wdc.com>, Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, alistair23@gmail.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MvBgox7lMwlhMza5AlK2DUOsCwy6o2pzK
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>, Michael Clark <mjc@sifive.com>,
 Palmer Dabbelt <palmer@sifive.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, alistair23@gmail.com
Message-ID: <24c01558-7352-74a6-31b8-9a495aa9fc13@amsat.org>
Subject: Re: microblaze build failure due to definition clash on riscv
References: <9cd33f65-c0df-637c-4d7e-90c8c4227216@amsat.org>
 <20180731104059.55s76c2ent772z4b@toto>
In-Reply-To: <20180731104059.55s76c2ent772z4b@toto>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Oops I just realized I forgot to Cc the QEMU list, doing it now.

On 07/31/2018 07:40 AM, Edgar E. Iglesias wrote:
> On Mon, Jul 30, 2018 at 03:22:46PM -0300, Philippe Mathieu-Daud=C3=A9 w=
rote:
>> Hi, I'm getting this error while building microblaze on riscv host:
>>
>>   ...
>>   CC      disas/microblaze.o
>> disas/microblaze.c:179:0: error: "REG_SP" redefined [-Werror]
>>
>>  #define REG_SP  1 /* stack pointer */
>>
>> In file included from /usr/include/signal.h:306:0,
>>                  from include/qemu/osdep.h:101,
>>                  from disas/microblaze.c:36:
>> /usr/include/sys/ucontext.h:36:0: note: this is the location of the
>> previous definition
>>  # define REG_SP 2
>>
>> cc1: all warnings being treated as errors
>> make: *** [rules.mak:69: disas/microblaze.o] Error 1
>>
>>
>> Having /usr/include/sys/ucontext.h:
>>
>>      31 #ifdef __USE_MISC
>>      32 # define NGREG  32
>>      33
>>      34 # define REG_PC 0
>>      35 # define REG_RA 1
>>      36 # define REG_SP 2
>>      37 # define REG_TP 4
>>      38 # define REG_S0 8
>>      39 # define REG_S1 9
>>      40 # define REG_A0 10
>>      41 # define REG_S2 18
>>      42 # define REG_NARGS 8
>>
>> Edgar is it OK to rename REG_* -> MB_REG_*?
>=20
> Yes, no problems with me!
>=20
> Allthough it doesn't seem to be a good idea to have such generic names =
in riscv system header files.

OK this might be a Linux problem indeed, maybe this file lacks some
#ifdef __riscv (previous to the __USE_MISC?).

I'll wait for the riscv folks before to send a dumb rename patch.

Regards,

Phil.


--MvBgox7lMwlhMza5AlK2DUOsCwy6o2pzK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAltigTwACgkQ4+MsLN6t
wN5u3xAAmWvJpguEN67cXrLTT6rflj0Lsym4lyyUx/EUACs89e+q4h+uLsyon6pF
JdKB4qBvjEr8bR9zAkYEWtNdu+TO73HJrt++n7+lVT0A8nltEeEXlYSYh7QcLPSZ
gGIDnX1GfqddI0xdkqdge/mxI1yf4oggy8h3XVgy8HkMMA31ykLFMwbuE8H+wGUb
1GyaLDpk+RC8k2QfHRZ8Wxd/Q2b+i85L8f6tbXoYsmnXB9eRPgk9Y4guSPiuLe6c
3L/nCHy+m2q3/UhroLUHpTL6cCh3mt3e/FOUc78XIBPm3utCe/T+nxRZNHDEx1+G
jaMeMgcxolbZAYtk7NP5WFb6iGbN+ExJlRMqM28Vz71Mda+C+Ua5gf1nqhzdaKND
/HzKx2dK2KYcSJUqYaGvT/8xcTfj8G4qYq14mgD6YjpatEuymcKN0WaorPWQRhor
+7Tm20+GW2Ycioh+fb6fMN14V1jL2APe8/nvWhdVpkw1uIpF0oI431dAwPartrik
41Qfa+fDV0B2KQab7lCjmcfq0vEipyAz439JxoTUPqItgTD9U7Nl4NzokVj8QAXs
GzMre2+7K9EjvgRezc0GLeWGfwHixvsWrKLAixTk/vj6meDbedQD0Bstj8gpf9eQ
PffN4fvqcbiFd5GG9i333LyGiK3rEL1a1TXYzfg4dtxNHljHKUs=
=Ukul
-----END PGP SIGNATURE-----

--MvBgox7lMwlhMza5AlK2DUOsCwy6o2pzK--
