Received: from eggs.gnu.org ([2001:4830:134:3::10]:46603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gM95x-0005LK-M8
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 05:05:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gM95n-0001wK-SY
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 05:05:21 -0500
Received: from mail-eopbgr730120.outbound.protection.outlook.com
	([40.107.73.120]:63582
	helo=NAM05-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gM95f-0001oG-FK
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 05:05:09 -0500
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Mon, 12 Nov 2018 10:04:58 +0000
Message-ID: <CY4PR2201MB12548AC0153261DF7E3BABECC6C10@CY4PR2201MB1254.namprd22.prod.outlook.com>
References: <20181111233622.8976-1-f4bug@amsat.org>
	<20181111233622.8976-9-f4bug@amsat.org>
	<BN6PR2201MB1251ADAEA3C596FD3F1AB3E6C6C10@BN6PR2201MB1251.namprd22.prod.outlook.com>,
	<ad3bd757-861d-2086-94e5-64779cd0affb@linaro.org>
In-Reply-To: <ad3bd757-861d-2086-94e5-64779cd0affb@linaro.org>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [RFC PATCH 08/11] target/mips: Add a decodetree
 stub
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Peer Adelt <peer.adelt@hni.uni-paderborn.de>, Richard Henderson <rth@twiddle.net>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

Hello, Richard.

I am a little taken aback by your tone. I hope we can communicate in much f=
riendlier maner, as we used to do.

>You have just this year added yet another encoding scheme for nanomips. Yo=
ur statement "well tested over many years" is a bit of a stretch.

I wrote "mostly stable mature", not "all stable mature".

>If you do not wish to work on this, that's your prerogative.  But I don't =
think
you should be arbitrarily shutting down experimentation on this line before=
 it
has a chance to show results.

I am not preventing anyone from experimenting. I just want to warn Philippe=
 about high-level view that the code in question, although not the nicest, =
works, and is planned to be maintained with minimal changes. The focus of M=
IPS target is on adding new architectures and ASEs, and (I correct myself) =
it could be that decodetree would kick in in such cases - but not for matur=
e code driving older architectures. It just doesn't make enough sense.

Thanks,
Aleksandar

________________________________________
From: Richard Henderson <richard.henderson@linaro.org>
Sent: Monday, November 12, 2018 9:58:05 AM
To: Aleksandar Markovic; Philippe Mathieu-Daud=E9; Bastian Koppelmann; Peer=
 Adelt; Richard Henderson
Cc: qemu-devel@nongnu.org; Aurelien Jarno
Subject: Re: [Qemu-devel] [RFC PATCH 08/11] target/mips: Add a decodetree s=
tub

On 11/12/18 6:37 AM, Aleksandar Markovic wrote:
>> Subject: [RFC PATCH 08/11] target/mips: Add a decodetree stub
>
> There is no plan to use decodetree for MIPS target. MIPS decoding engine =
is
> mostly stable mature code that was well tested over many years, and there=
 is no
> point in introducing such drastic change to the code that works.

This attitude is unnecessarily obstructionist.

The reorganization of the instruction implementation that is implied by a
transition to decodetree is exactly what you and I talked about some months=
 ago.

The ability to use multiple decodetree parsers to vector directly to the
instruction implementations would help unify code across multiple encoding
schemes.  (There 4 now: mips, mips16, micromips, nanomips; and mipsr6 is
different enough that it could be considered a 5th encoding.)

In a sample transition of 10 insns that Phillipe sent me via private email =
this
weekend, I noticed an existing bug in MULT{,U} that fails to enforce rd =3D=
=3D 0 on
cpus that have only one accumulator -- any bets there are no more to be fou=
nd?
 You have just this year added yet another encoding scheme for nanomips.  Y=
our
statement "well tested over many years" is a bit of a stretch.

If you do not wish to work on this, that's your prerogative.  But I don't t=
hink
you should be arbitrarily shutting down experimentation on this line before=
 it
has a chance to show results.


r~
