Received: from eggs.gnu.org ([2001:4830:134:3::10]:59987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ePAIh-0003ya-4D
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 11:54:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ePAIg-0005dL-Ak
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 11:54:31 -0500
Received: from mail-ot0-x233.google.com ([2607:f8b0:4003:c0f::233]:33273)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ePAIg-0005cv-5z
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 11:54:30 -0500
Received: by mail-ot0-x233.google.com with SMTP id h9so2530850oti.0
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 08:54:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1513183941-24300-1-git-send-email-peter.maydell@linaro.org>
References: <1513183941-24300-1-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 13 Dec 2017 16:54:08 +0000
Message-ID: <CAFEAcA8HswEKDPpj=cM711rNU2zwPuDXW7886=Oa2HBDmZxdCg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 0/2] GICv2 & GICv3: RAZ/WI
 reserved addresses rather than aborting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Laszlo Ersek <lersek@redhat.com>, "patches@linaro.org" <patches@linaro.org>, qemu-stable <qemu-stable@nongnu.org>

On 13 December 2017 at 16:52, Peter Maydell <peter.maydell@linaro.org> wrote:
> The GICv2 and GICv3 specifications say that reserved register
> addresses should RAZ/WI.  This means we need to return MEMTX_OK, not
> MEMTX_ERROR, because now that we support generating external aborts
> the latter will cause an abort on new board models.
>
> In particular, at least some versions of UEFI try to
> access a reserved address in the GICv3 redistributor
> (at SGI_base + 0x184) and fail to boot on the virt board
> without this.
>
> thanks
> -- PMM
>
> Peter Maydell (2):
>   hw/intc/arm_gicv3: Make reserved register addresses RAZ/WI
>   hw/intc/arm_gic: reserved register addresses are RAZ/WI

Oops, forgot the cc-stable tags:

Cc: qemu-stable@nongnu.org

thanks
-- PMM
