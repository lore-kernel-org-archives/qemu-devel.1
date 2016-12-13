Received: from eggs.gnu.org ([2001:4830:134:3::10]:57577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cGmSj-0002Xm-BU
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 07:45:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cGmSe-0007ol-L4
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 07:45:41 -0500
Received: from mail-vk0-f50.google.com ([209.85.213.50]:33920)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cGmSe-0007oQ-Gv
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 07:45:36 -0500
Received: by mail-vk0-f50.google.com with SMTP id x186so59235360vkd.1
	for <qemu-devel@nongnu.org>; Tue, 13 Dec 2016 04:45:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161209143703.29457-1-drjones@redhat.com>
References: <20161209143703.29457-1-drjones@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Dec 2016 12:44:14 +0000
Message-ID: <CAFEAcA96=O+ui5PNtOEC_-p=nuj-HCuDv9smSC73FsaF0g-g8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] hw/intc/arm_gicv3_common: fix aff3 in typer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 9 December 2016 at 14:37, Andrew Jones <drjones@redhat.com> wrote:
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> ---
>  hw/intc/arm_gicv3_common.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
> index 0f8c4b86e023..0aa9b9ca6655 100644
> --- a/hw/intc/arm_gicv3_common.c
> +++ b/hw/intc/arm_gicv3_common.c
> @@ -204,7 +204,8 @@ static void arm_gicv3_common_realize(DeviceState *dev, Error **errp)
>          /* The CPU mp-affinity property is in MPIDR register format; squash
>           * the affinity bytes into 32 bits as the GICR_TYPER has them.
>           */
> -        cpu_affid = (cpu_affid & 0xFF00000000ULL >> 8) | (cpu_affid & 0xFFFFFF);
> +        cpu_affid = ((cpu_affid & 0xFF00000000ULL) >> 8) |
> +                     (cpu_affid & 0xFFFFFF);
>          s->cpu[i].gicr_typer = (cpu_affid << 32) |
>              (1 << 24) |
>              (i << 8) |

Oops :-)

Applied to target-arm.next for 2.9, thanks.

-- PMM
