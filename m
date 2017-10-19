Received: from eggs.gnu.org ([2001:4830:134:3::10]:58511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e5C5u-0003Sf-G7
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 10:46:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e5C5t-0001UP-JP
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 10:46:46 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:53959)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e5C5t-0001Tw-C5
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 10:46:45 -0400
Received: by mail-wm0-x243.google.com with SMTP id q132so16902782wmd.2
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 07:46:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.10.1710171708130.27209@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1710171708130.27209@sstabellini-ThinkPad-X260>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Oct 2017 15:46:23 +0100
Message-ID: <CAFEAcA9zXAmNPL8TsLKSPbm8Er_KLK8Ubwth6=nL6WD87OmBQw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] aarch64: advertise the GIC system register
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "xen-devel@lists.xen.org" <xen-devel@lists.xen.org>, julien.grall@arm.com, qemu-arm <qemu-arm@nongnu.org>

On 18 October 2017 at 01:10, Stefano Stabellini <sstabellini@kernel.org> wrote:
> Advertise the presence of the GIC system register interface (1<<24)
> according to H9.248 of the ARM ARM.
>
> This patch allows Xen to boot on QEMU aarch64.
>
> Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>
>
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 670c07a..a451763 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -136,7 +136,7 @@ static void aarch64_a57_initfn(Object *obj)
>      cpu->id_isar3 = 0x01112131;
>      cpu->id_isar4 = 0x00011142;
>      cpu->id_isar5 = 0x00011121;
> -    cpu->id_aa64pfr0 = 0x00002222;
> +    cpu->id_aa64pfr0 = 0x01002222;
>      cpu->id_aa64dfr0 = 0x10305106;
>      cpu->pmceid0 = 0x00000000;
>      cpu->pmceid1 = 0x00000000;
> @@ -196,7 +196,7 @@ static void aarch64_a53_initfn(Object *obj)
>      cpu->id_isar3 = 0x01112131;
>      cpu->id_isar4 = 0x00011142;
>      cpu->id_isar5 = 0x00011121;
> -    cpu->id_aa64pfr0 = 0x00002222;
> +    cpu->id_aa64pfr0 = 0x01002222;
>      cpu->id_aa64dfr0 = 0x10305106;
>      cpu->id_aa64isar0 = 0x00011120;
>      cpu->id_aa64mmfr0 = 0x00001122; /* 40 bit physical addr */

Whoops -- we missed this when we added the GICv3 support, because
Linux doesn't check it.

Applied to target-arm.next, thanks.

-- PMM
