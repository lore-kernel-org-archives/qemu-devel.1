Received: from eggs.gnu.org ([2001:4830:134:3::10]:35561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fufbU-0007ZH-KE
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 11:08:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fufaW-0001x5-Vd
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 11:07:30 -0400
Received: from mail-by2nam05on071c.outbound.protection.outlook.com
	([2a01:111:f400:fe52::71c]:7995
	helo=NAM05-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fufaW-0001v0-GQ
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 11:07:24 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Tue, 28 Aug 2018 15:07:05 +0000
Message-ID: <BN7PR08MB48680621D40A0A8800E9AEF6C60A0@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <20180828130041.26445-1-jancraig@amazon.com>,
	<20180828130041.26445-3-jancraig@amazon.com>
In-Reply-To: <20180828130041.26445-3-jancraig@amazon.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
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
To: Craig Janeczek <jancraig@amazon.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>

> From: Craig Janeczek <jancraig@amazon.com>
> Sent: Tuesday, August 28, 2018 3:00 PM
> To: qemu-devel@nongnu.org
> Cc: Aleksandar Markovic; aurelien@aurel32.net; Craig Janeczek
> Subject: [PATCH v3 2/8] target/mips: Add all MXU opcodes
>=20
> Adds all MXU opcodes to the opcode enum. The MXU opcodes overlap with
> existing misc and Loongson 2F copcodes. The enums were updated to
> reflect the multiple possible meanings where applicable.
>=20
> Signed-off-by: Craig Janeczek <jancraig@amazon.com>

It is good that all codes are covered, but this situation with overlap is u=
nnatural.

Try creating a separate enum for MXU opcodes, and rearranging switch statem=
ent, taking into account what instructions set is supported by the CPU in q=
uestion.=
