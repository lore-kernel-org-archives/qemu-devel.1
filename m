Received: from eggs.gnu.org ([2001:4830:134:3::10]:50620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mar.krzeminski@gmail.com>) id 1cRNMQ-0000BH-PZ
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 13:10:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mar.krzeminski@gmail.com>) id 1cRNMM-0007Pz-JP
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 13:10:58 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:35474)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mar.krzeminski@gmail.com>)
	id 1cRNMM-0007Po-Cp
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 13:10:54 -0500
Received: by mail-wm0-x243.google.com with SMTP id l2so38370716wml.2
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 10:10:54 -0800 (PST)
References: <1483979087-32663-1-git-send-email-clg@kaod.org>
	<1483979087-32663-2-git-send-email-clg@kaod.org>
From: "mar.krzeminski" <mar.krzeminski@gmail.com>
Message-ID: <775357b3-6835-e7d1-8049-a78b0290bc28@gmail.com>
Date: Wed, 11 Jan 2017 19:10:49 +0100
MIME-Version: 1.0
In-Reply-To: <1483979087-32663-2-git-send-email-clg@kaod.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 01/11] aspeed/smc: remove call to reset
 in realize function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Marcin Krzeminski <marcin.krzeminski@nokia.com>

W dniu 09.01.2017 o 17:24, Cédric Le Goater pisze:
> This is useless as reset will be called later on.
>
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
Acked-by: Marcin Krzemiński <mar.krzeminski@gmail.com>
> ---
>   hw/ssi/aspeed_smc.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
> index 78f5aed53247..8a7217d4df6c 100644
> --- a/hw/ssi/aspeed_smc.c
> +++ b/hw/ssi/aspeed_smc.c
> @@ -541,8 +541,6 @@ static void aspeed_smc_realize(DeviceState *dev, Error **errp)
>           sysbus_init_irq(sbd, &s->cs_lines[i]);
>       }
>   
> -    aspeed_smc_reset(dev);
> -
>       /* The memory region for the controller registers */
>       memory_region_init_io(&s->mmio, OBJECT(s), &aspeed_smc_ops, s,
>                             s->ctrl->name, ASPEED_SMC_R_MAX * 4);
