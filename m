Received: from eggs.gnu.org ([2001:4830:134:3::10]:37783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=771b48d5d=jancraig@amazon.com>)
	id 1fufg4-0002p2-Jh
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 11:13:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=771b48d5d=jancraig@amazon.com>)
	id 1fufg1-0005fY-GL
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 11:13:08 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:53275)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=771b48d5d=jancraig@amazon.com>)
	id 1fufg1-0005fH-Bv
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 11:13:05 -0400
From: "Janeczek, Craig" <jancraig@amazon.com>
Date: Tue, 28 Aug 2018 15:13:01 +0000
Message-ID: <b9eab9396a6e4270b9e536a4fe84a54d@EX13D12UEA003.ant.amazon.com>
References: <20180828130041.26445-1-jancraig@amazon.com>,
	<20180828130041.26445-3-jancraig@amazon.com>
	<BN7PR08MB48680621D40A0A8800E9AEF6C60A0@BN7PR08MB4868.namprd08.prod.outlook.com>
In-Reply-To: <BN7PR08MB48680621D40A0A8800E9AEF6C60A0@BN7PR08MB4868.namprd08.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 2/8] target/mips: Add all MXU opcodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>

I see that I can check the loongson instructions by checking for INSN_LOONG=
SON2F. Using MXU if that is not set

What should I check for the mult or misc instructions that were there first=
?

-----Original Message-----
From: Aleksandar Markovic <amarkovic@wavecomp.com>=20
Sent: Tuesday, August 28, 2018 11:07 AM
To: Janeczek, Craig <jancraig@amazon.com>; qemu-devel@nongnu.org
Cc: aurelien@aurel32.net
Subject: Re: [PATCH v3 2/8] target/mips: Add all MXU opcodes

> From: Craig Janeczek <jancraig@amazon.com>
> Sent: Tuesday, August 28, 2018 3:00 PM
> To: qemu-devel@nongnu.org
> Cc: Aleksandar Markovic; aurelien@aurel32.net; Craig Janeczek
> Subject: [PATCH v3 2/8] target/mips: Add all MXU opcodes
>=20
> Adds all MXU opcodes to the opcode enum. The MXU opcodes overlap with=20
> existing misc and Loongson 2F copcodes. The enums were updated to=20
> reflect the multiple possible meanings where applicable.
>=20
> Signed-off-by: Craig Janeczek <jancraig@amazon.com>

It is good that all codes are covered, but this situation with overlap is u=
nnatural.

Try creating a separate enum for MXU opcodes, and rearranging switch statem=
ent, taking into account what instructions set is supported by the CPU in q=
uestion.
