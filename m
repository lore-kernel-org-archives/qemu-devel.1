Received: from eggs.gnu.org ([2001:4830:134:3::10]:33647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gSkvb-0006Ks-5K
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 10:42:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gSkva-0007H7-Ia
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 10:42:03 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:44866)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gSkva-0007Ge-Be
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 10:42:02 -0500
Received: by mail-ot1-x341.google.com with SMTP id f18so5435808otl.11
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 07:42:02 -0800 (PST)
MIME-Version: 1.0
References: <1543407172-16175-1-git-send-email-peng.hao2@zte.com.cn>
	<1543407172-16175-4-git-send-email-peng.hao2@zte.com.cn>
In-Reply-To: <1543407172-16175-4-git-send-email-peng.hao2@zte.com.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 30 Nov 2018 15:41:50 +0000
Message-ID: <CAFEAcA_c12Fvo7mffuiGRR7Rd2k+Li0a8TSu_6j1OiyBTY_Bxw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH V10 3/9] hw/misc/pvpanic: Add the MMIO
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peng Hao <peng.hao2@zte.com.cn>
Cc: Andrew Jones <drjones@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On Wed, 28 Nov 2018 at 03:50, Peng Hao <peng.hao2@zte.com.cn> wrote:
>
> Add pvpanic new type "TYPE_PVPANIC_MMIO"
>
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>  hw/misc/pvpanic.c         | 50 +++++++++++++++++++++++++++++++++++++++++++----
>  include/hw/misc/pvpanic.h |  1 +
>  2 files changed, 47 insertions(+), 4 deletions(-)
>


> +static void pvpanic_mmio_initfn(Object *obj)
> +{
> +    PVPanicMMIOState *s = PVPANIC_MMIO_DEVICE(obj);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
> +
> +    memory_region_init_io(&s->mr, OBJECT(s), &pvpanic_ops, s,
> +                          TYPE_PVPANIC_MMIO, 2);

Why did you choose to make the memory region 2 bytes wide?
The ISA i/o port interface seems to be a 1 byte wide one.

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
