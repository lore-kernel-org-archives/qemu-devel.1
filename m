Received: from eggs.gnu.org ([209.51.188.92]:53358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1hEIuP-0004sO-W1
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 15:29:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1hEItB-0004Zd-6A
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 15:28:06 -0400
Received: from mail.weilnetz.de ([37.120.169.71]:45520
	helo=v2201612906741603.powersrv.de)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1hEItA-0004Ys-QZ
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 15:28:05 -0400
References: <20190404185730.GA22512@ls3530.dellerweb.de>
	<CAFEAcA9xP8CtXEruuzPHCyuDT5EyMMHFGdCJdfFBhX+C2Jr36A@mail.gmail.com>
	<b48c6984-f0fc-a597-53a0-4869c822ce73@gmx.de>
	<068f4832-7e0b-8850-ffa0-fcf1ecd50295@redhat.com>
	<20190405090212.GF6105@redhat.com>
	<740ce541-c92d-5369-1191-eb73fc861fdd@redhat.com>
	<a53b3bab-5aa4-b37f-f194-7788bce1d04b@weilnetz.de>
	<b6df5f4b-d567-bab0-fb9d-78ca20154ec7@redhat.com>
	<0e30df69-c534-da63-a21b-813281b39b86@redhat.com>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <d251a37c-4bf2-27a3-9714-c443ee1cb1e2@weilnetz.de>
Date: Wed, 10 Apr 2019 21:22:11 +0200
MIME-Version: 1.0
In-Reply-To: <0e30df69-c534-da63-a21b-813281b39b86@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] configure: Automatically fall back to TCI
 on non-release architectures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Helge Deller <deller@gmx.de>, Michael Tokarev <mjt@tls.msk.ru>, QEMU Developers <qemu-devel@nongnu.org>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Aurelien Jarno <aurelien@aurel32.net>

On 10.04.19 10:22, Thomas Huth wrote:
> Additionally, I think it should be possible to compile with the
> x86_64-linux-user target and then to run "make check-tcg" ... however,
> that currently crashes with:
>=20
> TODO qemu/tcg/tci.c:859: tcg_qemu_tb_exec()
> qemu/tcg/tci.c:859: tcg fatal error
> qemu: uncaught target signal 11 (Segmentation fault) - core dumped

That's easy to fix. I implemented only those TCG opcodes which really
were executed during testing. This test triggers an assertion because it
needs INDEX_op_ld16u_i64 which was missing up to now.

I'll send a patch which adds support for INDEX_op_ld16u_i64.

Thank you for your tests.

Stefan
