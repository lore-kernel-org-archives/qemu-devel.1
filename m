Received: from eggs.gnu.org ([209.51.188.92]:58249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gmfFT-0005Nz-32
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 08:40:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gmfDM-00048j-Ii
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 08:38:42 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:34845)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gmfDL-000446-8t
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 08:38:40 -0500
Received: by mail-oi1-x242.google.com with SMTP id v6so4839533oif.2
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 05:38:35 -0800 (PST)
MIME-Version: 1.0
References: <20190123212234.32068-1-stefanha@redhat.com>
In-Reply-To: <20190123212234.32068-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 24 Jan 2019 13:38:21 +0000
Message-ID: <CAFEAcA_Edcs-w4UCmARzwV69XUw61ey0qO08_nuEC=Zsvi0N6w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 0/5] arm: microbit Non-Volatile Memory
 Controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>, Qemu-block <qemu-block@nongnu.org>, Thomas Huth <thuth@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, Julia Suvorova <jusual@mail.ru>, Laurent Vivier <lvivier@redhat.com>, Jim Mussared <jim@groklearning.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <contrib@steffen-goertz.de>, Richard Henderson <rth@twiddle.net>

On Wed, 23 Jan 2019 at 21:23, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> v2:
>  * Add Patch 2 to call memory_region_flush_rom_device() from pflash devices
>    [Peter]
>
> This series adds the Non-Volatile Memory Controller, which controls access to
> the User Information Control Registers (UICR), Factory Information Control
> Registers (FICR), and flash memory.
>
> This is the last piece of microbit work needed to make basic programs like
> Micropython "Hello world" work under QEMU.

I've applied patches 1, 3, 4 and 5 to target-arm.next, thanks.
Philippe has review comments on 2 and it's not really microbit
related anyway.

thanks
-- PMM
