Received: from eggs.gnu.org ([208.118.235.92]:43797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1gbAOO-00035J-UC
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 15:30:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1gbAOL-0001eN-88
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 15:30:32 -0500
Received: from mail.weilnetz.de ([37.120.169.71]:35624
	helo=v2201612906741603.powersrv.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sw@weilnetz.de>) id 1gbAOK-0001ZC-Gi
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 15:30:28 -0500
References: <20181127121724.19755-1-sw@weilnetz.de>
	<20181127121724.19755-3-sw@weilnetz.de>
	<CAL1e-=g9u5PONfeord2BUWsu-EKm7h2rx-_-9QarE=50JoZdfg@mail.gmail.com>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <349b9e4d-1aa3-7711-20d1-58025b2c26f6@weilnetz.de>
Date: Sun, 23 Dec 2018 21:30:15 +0100
MIME-Version: 1.0
In-Reply-To: <CAL1e-=g9u5PONfeord2BUWsu-EKm7h2rx-_-9QarE=50JoZdfg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.1 2/2] disas/nanomips: Fix format
 strings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>, Stefan Markovic <smarkovic@wavecomp.com>, Peter Maydell <peter.maydell@linaro.org>

On 23.12.18 18:10, Aleksandar Markovic wrote:
> Hi, Stefan,
>=20
> My plan is to accept this patch plus (in the same patch) following
> changes in nanomips.h:
>=20
> This code:
>=20
> typedef unsigned short uint16;
> typedef unsigned int uint32;
> typedef long long int64;
> typedef unsigned long long uint64;
>=20
> namespace img
> {
>     typedef unsigned long long address;
> }
>=20
> should become:
>=20
> typedef uint16_t uint16;
> typedef uint32_t uint32;
> typedef int64_t int64;
> typedef uint64_t uint64;
>=20
> namespace img
> {
>     typedef uint64_t address;
> }
>=20
> The reason is that I would like to keep custom types. The custom types
> names "uint32", "int64", etc. are admittedly too generic, but that
> will change in further development, and it looks do not bother any
> compiler so far. This means that patch 1/1 will not be applied.


I must admit that I don't understand the reason for keeping the custom
types (many software projects work very well with the POSIX types), but
the more important thing is to get the right format strings, and your
approach will work for that.

It's also good that you address the definition of the "address" data
type. Maybe using "typedef uintptr_t address" could also be used
(reducing the memory use for 32 bit systems).

Stefan


> There is no need for respin, I will do the corrections while
> integrating pull request.
>=20
> Please let me know if you object over this.
>=20
> Thanks again for bringing all these issues!
>=20
> Aleksandar
