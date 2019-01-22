Received: from eggs.gnu.org ([209.51.188.92]:36071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gm1Tf-0000V1-JQ
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:12:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gm1Te-0003sS-Lh
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:12:51 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:41364)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gm1Te-0003hl-EU
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:12:50 -0500
Received: by mail-ot1-x342.google.com with SMTP id u16so24675729otk.8
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 11:12:25 -0800 (PST)
MIME-Version: 1.0
References: <20190120143452.21683-1-stefanha@redhat.com>
	<20190120143452.21683-3-stefanha@redhat.com>
In-Reply-To: <20190120143452.21683-3-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Jan 2019 16:34:34 +0000
Message-ID: <CAFEAcA94tq-8EMOewoxAzgg0i+sbf-+giMrThyHEBY2NawqDjQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/4] hw/nvram/nrf51_nvm: Add nRF51
 non-volatile memories
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Joel Stanley <joel@jms.id.au>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <contrib@steffen-goertz.de>, qemu-arm <qemu-arm@nongnu.org>

On Sun, 20 Jan 2019 at 14:35, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> From: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
>
> The nRF51 contains three regions of non-volatile memory (NVM):
> - CODE (R/W): contains code
> - FICR (R): Factory information like code size, chip id etc.
> - UICR (R/W): Changeable configuration data. Lock bits, Code
>   protection configuration, Bootloader address, Nordic SoftRadio
>   configuration, Firmware configuration.
>
> Read and write access to the memories is managed by the
> Non-volatile memory controller.
>
> Memory schema:
>  [ CPU ] -+- [ NVM, either FICR, UICR or CODE ]
>           |      |
>           \- [ NVMC ]
>
> Signed-off-by: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  * Fix device-introspect-test segfault due to missing owner when
>    initializing FICR and UICR memory regions [Peter]
>  * Fix off-by-one assertion checks [Peter]
>  * Fix missing whitespace at end of comment [Peter]
>  * Clear UICR on reset - we'd need a block device for true
>    non-volatility [Peter]
>  * Use memory_region_flush_rom_device() to dirty/invalidate memory
>    [Peter]
> ---


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
