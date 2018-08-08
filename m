Received: from eggs.gnu.org ([2001:4830:134:3::10]:56808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fnJKj-0003H4-Kj
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 03:56:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fnJKg-00049r-Ia
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 03:56:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43980 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fnJKg-00049W-C2
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 03:56:38 -0400
References: <BN7PR08MB48688EB667F7EDFF86B90D2CC6200@BN7PR08MB4868.namprd08.prod.outlook.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e589005c-cea6-5ad4-983b-9dda0eac003d@redhat.com>
Date: Wed, 8 Aug 2018 09:56:34 +0200
MIME-Version: 1.0
In-Reply-To: <BN7PR08MB48688EB667F7EDFF86B90D2CC6200@BN7PR08MB4868.namprd08.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Question: How to integrate simple tests for a new
 platform so that they fit in well within QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: Petar Jovanovic <pjovanovic@wavecomp.com>, Peter Maydell <peter.maydell@linaro.org>

On 08/07/2018 02:34 PM, Aleksandar Markovic wrote:
> Hello, folks.
>=20
> We are introducing a new MIPS platform - called nanoMIPS - to the QEMU.
>=20
> Besides providing new functionality, we would like to integrate into QE=
MU some basic testing capabilities for that new platform. Something like =
this:
>=20
>     Enable user to specify cross compiler and, using QEMU Linux user mo=
de:
>         a. execute several tests that are just almost minimal tests of =
emulation of selected instructions.
>         b. execute several tests that are just almost minimal tests of =
translation of selected system calls.
>=20
> In other words, this would enable a user to run "smoke tests" for nanoM=
IPS platform, and perhaps to use these tests as a starting point for some=
 other tests.
>=20
> My question is:
>=20
> 1. Is this a good idea at all?

Yes, it certainly is!

> 2. If yes, what would be the best way to integrate these tests into cur=
rent QEMU test organization?

Best way is to use the test infrastructure in tests/tcg (see mail from
Richard).
Another possibility is to add a simple test to tests/boot-serial-test.c
- but this only works if your machine can output something to the serial
console with some few lines of assembly code.

 Thomas
