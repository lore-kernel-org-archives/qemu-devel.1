Received: from eggs.gnu.org ([2001:4830:134:3::10]:43892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fnKT9-0007Ro-RN
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 05:09:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fnKT8-0006CY-Qw
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 05:09:27 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:38776)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fnKT8-0006AH-Ix
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 05:09:26 -0400
Received: by mail-wm0-x244.google.com with SMTP id t25-v6so1951672wmi.3
	for <qemu-devel@nongnu.org>; Wed, 08 Aug 2018 02:09:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180806100114.21410-4-contrib@steffen-goertz.de>
References: <20180806100114.21410-1-contrib@steffen-goertz.de>
	<20180806100114.21410-4-contrib@steffen-goertz.de>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 8 Aug 2018 10:09:24 +0100
Message-ID: <CAJSP0QVrWiKtuRW+-EjFSJxrvWLtXWxsDHuvAuEe6yXOLWb72A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/7] tests: Add bbc:microbit / nRF51 test
 suite
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Steffen_G=C3=B6rtz?= <contrib@steffen-goertz.de>
Cc: qemu-devel <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>

On Mon, Aug 6, 2018 at 11:01 AM, Steffen G=C3=B6rtz
<contrib@steffen-goertz.de> wrote:
> +#define PAGE_SIZE           1024
> +#define FLASH_SIZE          (256 * PAGE_SIZE)
> +#define FLASH_BASE          0x00000000
> +#define UICR_BASE           0x10001000
> +#define UICR_SIZE           0x100
> +#define NVMC_BASE           0x4001E000UL
> +#define NVMC_READY          0x400
> +#define NVMC_CONFIG         0x504
> +#define NVMC_ERASEPAGE      0x508
> +#define NVMC_ERASEPCR1      0x508
> +#define NVMC_ERASEALL       0x50C
> +#define NVMC_ERASEPCR0      0x510
> +#define NVMC_ERASEUICR      0x514

All these constants could live in include/hw/arm/nrf51.h.  That way
tests do not need to duplicate them.  As more devices are implemented
we can expect this list to grow.

> +static void fill_and_erase(hwaddr base, hwaddr size, uint32_t address_re=
g)

Why hwaddr?  writel() and friends use uint64_t.
