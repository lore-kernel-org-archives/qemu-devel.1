Received: from eggs.gnu.org ([209.51.188.92]:36294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1gtr8h-00079Y-DZ
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 04:47:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1gtr8g-0007DL-Id
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 04:47:35 -0500
Received: from mail.weilnetz.de ([37.120.169.71]:52112
	helo=v2201612906741603.powersrv.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sw@weilnetz.de>) id 1gtr8c-0007Bc-3T
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 04:47:32 -0500
References: <CAChFQ9RNaHyROB47QeLwc6cLCCnFx4SmXKV7rbs1MYjk7S0sbw@mail.gmail.com>
	<20190131104911.GF19982@redhat.com> <20190213093241.GF13960@redhat.com>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <ff76ebe0-7f72-f68a-01c7-366b30a1245e@weilnetz.de>
Date: Wed, 13 Feb 2019 10:47:04 +0100
MIME-Version: 1.0
In-Reply-To: <20190213093241.GF13960@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] NSIS - including DLL dependencies for Windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, Adam Baxter <voltagex@voltagex.org>
Cc: qemu-devel@nongnu.org

On 13.02.19 10:32, Daniel P. Berrang=C3=A9 wrote:
> FYI, I re-discovered a way to do this without needing wine, just plain
> binutils
>=20
>   x86_64-w64-mingw32-objdump -p /path/to/binary.exe | grep "DLL Name" |=
 awk '{print $3}'


See also https://github.com/gsauthof/pe-util. The command line tool
peldd displays the DLLs recursively.

Regards
Stefan
