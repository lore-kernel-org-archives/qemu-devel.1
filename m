Received: from eggs.gnu.org ([209.51.188.92]:34352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gtX0s-0002qC-Td
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 07:18:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gtX0q-00018W-Vm
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 07:18:10 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40437)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gtX0l-0000vx-86
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 07:18:05 -0500
Received: by mail-wm1-f66.google.com with SMTP id q21so2774086wmc.5
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 04:18:02 -0800 (PST)
References: <20190204231815.29661-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e3dc8b86-6f4e-97e9-3ae2-81d996850fbe@redhat.com>
Date: Tue, 12 Feb 2019 13:17:59 +0100
MIME-Version: 1.0
In-Reply-To: <20190204231815.29661-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 00/11] hw: Remove "hw/devices.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <rth@twiddle.net>, Andrew Jeffery <andrew@aj.id.au>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Jan Kiszka <jan.kiszka@web.de>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Michael Walle <michael@walle.cc>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-ppc@nongnu.org, Peter Chubb <peter.chubb@nicta.com.au>, Beniamino Galvani <b.galvani@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>, Magnus Damm <magnus.damm@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Joel Stanley <joel@jms.id.au>, Andrzej Zaborowski <balrogg@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-arm@nongnu.org, Jason Wang <jasowang@redhat.com>, Rob Herring <robh@kernel.org>

On 2/5/19 12:18 AM, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> As his first comment describes itself, the "hw/devices.h" contains
> declarations for "Devices that have nowhere better to go."
> This series remove it, creating new headers for devices covered there.
> MAINTAINERS is updated.
> I also included 2 cleanups while working on this, in "qemu/typedefs.h"
> and "hw/net/ne2000-isa.h" header guard.
> 
> v2:
> - added R-b, T-b tags
> - addressed many review comments from Thomas
> 
> v1: https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg00611.html

ping?

Since it is mostly touch (old) ARM boards, Peter can you do a quick
review and give your Ack-by, so it can go via the Trivial/Misc tree?
Half of the series is already reviewed by Thomas.

Thanks,

Phil.
