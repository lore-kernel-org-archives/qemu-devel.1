Received: from eggs.gnu.org ([2001:4830:134:3::10]:36448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1dVX4d-0008GZ-85
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 01:54:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1dVX4a-0006lx-70
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 01:54:03 -0400
Received: from iserv.reactos.org ([188.40.64.40]:41834)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hpoussin@reactos.org>)
	id 1dVX4Z-0006hR-Ll
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 01:54:00 -0400
References: <20170621043401.19842-1-hpoussin@reactos.org>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <1b322dd0-963e-c29d-702c-c4cb4396b6f7@reactos.org>
Date: Thu, 13 Jul 2017 07:51:46 +0200
MIME-Version: 1.0
In-Reply-To: <20170621043401.19842-1-hpoussin@reactos.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 0/2] Support multiple adlib sound cards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Ping ?

Le 21/06/2017 à 06:33, Hervé Poussineau a écrit :
> Hi,
>
> This patchset removes a global variable in adlib emulation, and allows to
> have multiple adlib sound cards.
> Note that indentation seem off because I have replaced some tabulations by spaces.
>
> Before:
> qemu-system-i386 -device adlib,iobase=0x220 -device adlib,iobase=0x240
> qemu-system-i386: -device adlib,iobase=0x240: Cannot create more than 1 adlib device
>
> After:
> qemu-system-i386 -device adlib,iobase=0x220 -device adlib,iobase=0x240
> Machine starts.
>
> Hervé
>
> Hervé Poussineau (2):
>   audio/fmopl: modify timer callback to give opaque and channel
>     parameters in two arguments
>   audio/adlib: remove limitation of one adlib card
>
>  hw/audio/adlib.c | 14 +++-----------
>  hw/audio/fmopl.c | 18 +++++++++++++-----
>  hw/audio/fmopl.h |  7 ++++---
>  3 files changed, 20 insertions(+), 19 deletions(-)
>
