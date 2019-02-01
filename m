Received: from eggs.gnu.org ([209.51.188.92]:52103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpatE-0006vI-7m
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 10:38:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpatD-0006QP-11
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 10:38:00 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:45588)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gpatA-0006O8-Vf
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 10:37:58 -0500
Received: by mail-oi1-x244.google.com with SMTP id y1so6069485oie.12
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 07:37:55 -0800 (PST)
MIME-Version: 1.0
References: <20190201023357.22596-1-stefanha@redhat.com>
In-Reply-To: <20190201023357.22596-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Feb 2019 15:37:42 +0000
Message-ID: <CAFEAcA_EvJFyAW67=-9=bpVmnwO7vB88YH0BckNgPqiwOHX5FQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 0/3] arm: microbit Non-Volatile Memory
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, Julia Suvorova <jusual@mail.ru>, Joel Stanley <joel@jms.id.au>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <contrib@steffen-goertz.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Jim Mussared <jim@groklearning.com>

On Fri, 1 Feb 2019 at 02:34, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> v4:
>  * assert(offset + size <=3D s->flash_size) [Peter]
> v3:
>  * Fix endianness of s->storage[], tested by Joel Stanley <joel@jms.id.au=
> on
>    big-endian ppc [Peter]
>  * Fix off-by-one that prevented clearing the last page of flash
>  * Add missing memory_region_flush_rom_device() call to flash_write()
> v2:
>  * Add Patch 2 to call memory_region_flush_rom_device() from pflash devic=
es
>    [Peter]
>
> This series adds the Non-Volatile Memory Controller, which controls acces=
s to
> the User Information Control Registers (UICR), Factory Information Contro=
l
> Registers (FICR), and flash memory.
>
> This is the last piece of microbit work needed to make basic programs lik=
e
> Micropython "Hello world" work under QEMU.
>
> Originally sent as part of Steffen's longer microbit device emulation ser=
ies, I
> extracted this and deferred it until later because cleanups were necessar=
y:
>
>  * Use memory_region_flush_rom_device() to dirty/invalidate memory [Peter=
]
>    ^--- Paolo: I CCed you on this new memory API
>  * Fix device-introspect-test segfault due to missing owner when initiali=
zing
>    FICR and UICR memory regions [Peter]
>  * Fix off-by-one assertion checks [Peter]
>  * Fix missing whitespace at end of comment [Peter]
>  * Clear UICR on reset - we'd need a block device for true non-volatility
>    [Peter]
>
> Steffen G=C3=B6rtz (3):
>   hw/nvram/nrf51_nvm: Add nRF51 non-volatile memories
>   arm: Instantiate NRF51 special NVM's and NVMC
>   tests/microbit-test: Add tests for nRF51 NVMC



Applied to target-arm.next, thanks.

-- PMM
