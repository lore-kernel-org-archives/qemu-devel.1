Received: from eggs.gnu.org ([2001:4830:134:3::10]:41122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fn1C6-0005d1-RR
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 08:34:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fn1C3-0008EH-Of
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 08:34:34 -0400
Received: from mail-co1nam05on070c.outbound.protection.outlook.com
	([2a01:111:f400:fe50::70c]:2941
	helo=NAM05-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fn1C3-0008Dt-Bb
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 08:34:31 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Tue, 7 Aug 2018 12:34:12 +0000
Message-ID: <BN7PR08MB48688EB667F7EDFF86B90D2CC6200@BN7PR08MB4868.namprd08.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] Question: How to integrate simple tests for a new
 platform so that they fit in well within QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Petar Jovanovic <pjovanovic@wavecomp.com>, Peter Maydell <peter.maydell@linaro.org>

Hello, folks.

We are introducing a new MIPS platform - called nanoMIPS - to the QEMU.

Besides providing new functionality, we would like to integrate into QEMU s=
ome basic testing capabilities for that new platform. Something like this:

    Enable user to specify cross compiler and, using QEMU Linux user mode:
        a. execute several tests that are just almost minimal tests of emul=
ation of selected instructions.
        b. execute several tests that are just almost minimal tests of tran=
slation of selected system calls.

In other words, this would enable a user to run "smoke tests" for nanoMIPS =
platform, and perhaps to use these tests as a starting point for some other=
 tests.

My question is:

1. Is this a good idea at all?
2. If yes, what would be the best way to integrate these tests into current=
 QEMU test organization?

I appreciate any opinion of yours.

Regards,
Aleksandar
