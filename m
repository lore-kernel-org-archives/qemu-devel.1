Received: from eggs.gnu.org ([209.51.188.92]:52741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1gkEQC-0006Qo-Gx
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 15:37:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1gkEQB-0005z4-Gk
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 15:37:52 -0500
Received: from mail.weilnetz.de ([37.120.169.71]:40908
	helo=v2201612906741603.powersrv.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sw@weilnetz.de>) id 1gkEQB-0005wV-7Y
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 15:37:51 -0500
From: Stefan Weil <sw@weilnetz.de>
References: <1521039163-138-1-git-send-email-juterry@microsoft.com>
Message-ID: <00e8dbed-6ada-d023-46b9-89881fcbfb1f@weilnetz.de>
Date: Thu, 17 Jan 2019 21:37:44 +0100
MIME-Version: 1.0
In-Reply-To: <1521039163-138-1-git-send-email-juterry@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/3] WHPX introduce changes for Windows
 Insider SDK 17110
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Justin Terry (VM)" <juterry@microsoft.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, ehabkost@redhat.com, rth@twiddle.net

Am 14.03.2018 um 15:52 schrieb Justin Terry (VM) via Qemu-devel:
> This change set fixes two breaking changes that were introduced in the
> Windows Insider SDK 17110. First, a change to the WHvGetCapability func=
tion
> decl to include the 'out' WrittenSizeInBytes. Second, changes to the
> WHvSetPartitionProperty function decl and WHV_PARTITION_PROPERTY struct=
ure
> to directly pass the PropertyCode at invocation.
>=20
> Lastly, it introduces a major performance improvement in whpx_vcpu_post=
_run
> using the VpContext exit structure rather than another round trip call =
to
> WHvGetVirtualProcessorRegisters to synchronize vp state.
>=20
> QEMU compiled against this SDK (17110+) is expected to work on all Wind=
ows
> Insider Builds (17115+).
>=20
> Thanks,
> Justin Terry


Hi Justin,

as far as I know it still not possible to cross build a legal QEMU for
Windows on a Linux machine due to the license limitations of the SDK
which is needed. The header files needed for the QEMU build are "All
rights reserved".

People often ask me to add WHPX support to the QEMU installer for
Windows, but I have to tell them that I cannot do that currently.

This problem could be solved if the necessary header files were added to
QEMU with a permissive license by someone who has the rights to do so.

Could you add WinHvEmulation.h and WinHvPlatform.h or am I allowed to
make such files from the documentation at https://docs.microsoft.com/?

Thanks,
Stefan Weil
