Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C9AC433EB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 16:08:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CA152065E
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 16:08:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CA152065E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxYLT-0008Eo-HB
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 12:08:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59944)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jxYKt-0007fO-N3
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 12:08:15 -0400
Received: from 1.mo68.mail-out.ovh.net ([46.105.41.146]:33817)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jxYKr-0002wp-Q4
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 12:08:15 -0400
Received: from player691.ha.ovh.net (unknown [10.110.171.148])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id 1BB42173DA9
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2020 18:08:02 +0200 (CEST)
Received: from kaod.org (bad36-1-78-202-132-1.fbx.proxad.net [78.202.132.1])
 (Authenticated sender: clg@kaod.org)
 by player691.ha.ovh.net (Postfix) with ESMTPSA id 3F9C81498A4D2;
 Mon, 20 Jul 2020 16:07:55 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-97G0025bee732f-b8c7-4e32-8983-4cc0222cbcde,6196D7FED5334CEB3A8C25BBD62C6C93FB7A110A)
 smtp.auth=clg@kaod.org
Subject: Re: [PATCH-for-5.1] hw/misc/aspeed_sdmc: Fix incorrect memory size
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200720095829.22839-1-f4bug@amsat.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <ed5e6bd0-0962-b182-3348-d3c6655ef35e@kaod.org>
Date: Mon, 20 Jul 2020 18:07:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200720095829.22839-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 13934700199559531281
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrgeeggdejfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepfeffvddtudegieefudeugffhjefgieegieegleettdehgfeiieevueeihfegfefgnecukfhppedtrddtrddtrddtpdejkedrvddtvddrudefvddrudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheiledurdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=46.105.41.146; envelope-from=clg@kaod.org;
 helo=1.mo68.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 12:08:03
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Andrew Jeffery <andrew@aj.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/20/20 11:58 AM, Philippe Mathieu-Daudé wrote:
> The SDRAM Memory Controller has a 32-bit address bus, thus
> supports up to 4 GiB of DRAM. There is a signed to unsigned
> conversion error with the AST2600 maximum memory size:
> 
>   (uint64_t)(2048 << 20) = (uint64_t)(-2147483648)
>                          = 0xffffffff40000000
>                          = 16 EiB - 2 GiB
> 
> Fix by using the IEC suffixes which are usually safer, and add
> a check to verify the memory is valid. This would have catched
> this bug:
> 
>     Unexpected error in aspeed_sdmc_realize() at hw/misc/aspeed_sdmc.c:261:
>     qemu-system-arm: Invalid RAM size 16 EiB

Indeed :/

> 
> Fixes: 1550d72679 ("aspeed/sdmc: Add AST2600 support")
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/misc/aspeed_sdmc.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
> index 0737d8de81..76dd7e6a20 100644
> --- a/hw/misc/aspeed_sdmc.c
> +++ b/hw/misc/aspeed_sdmc.c
> @@ -256,6 +256,12 @@ static void aspeed_sdmc_realize(DeviceState *dev, Error **errp)
>      AspeedSDMCClass *asc = ASPEED_SDMC_GET_CLASS(s);
>  
>      s->max_ram_size = asc->max_ram_size;
> +    if (s->max_ram_size >= 4 * GiB) {
> +        char *szstr = size_to_str(s->max_ram_size);
> +        error_setg(errp, "Invalid RAM size %s", szstr);
> +        g_free(szstr);
> +        return;
> +    }
>

I would put an assert() since the max RAM size is not user configurable. 

C.

>      memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_sdmc_ops, s,
>                            TYPE_ASPEED_SDMC, 0x1000);
> @@ -341,7 +347,7 @@ static void aspeed_2400_sdmc_class_init(ObjectClass *klass, void *data)
>      AspeedSDMCClass *asc = ASPEED_SDMC_CLASS(klass);
>  
>      dc->desc = "ASPEED 2400 SDRAM Memory Controller";
> -    asc->max_ram_size = 512 << 20;
> +    asc->max_ram_size = 512 * MiB;
>      asc->compute_conf = aspeed_2400_sdmc_compute_conf;
>      asc->write = aspeed_2400_sdmc_write;
>      asc->valid_ram_sizes = aspeed_2400_ram_sizes;
> @@ -408,7 +414,7 @@ static void aspeed_2500_sdmc_class_init(ObjectClass *klass, void *data)
>      AspeedSDMCClass *asc = ASPEED_SDMC_CLASS(klass);
>  
>      dc->desc = "ASPEED 2500 SDRAM Memory Controller";
> -    asc->max_ram_size = 1024 << 20;
> +    asc->max_ram_size = 1 * GiB;
>      asc->compute_conf = aspeed_2500_sdmc_compute_conf;
>      asc->write = aspeed_2500_sdmc_write;
>      asc->valid_ram_sizes = aspeed_2500_ram_sizes;
> @@ -485,7 +491,7 @@ static void aspeed_2600_sdmc_class_init(ObjectClass *klass, void *data)
>      AspeedSDMCClass *asc = ASPEED_SDMC_CLASS(klass);
>  
>      dc->desc = "ASPEED 2600 SDRAM Memory Controller";
> -    asc->max_ram_size = 2048 << 20;
> +    asc->max_ram_size = 2 * GiB;
>      asc->compute_conf = aspeed_2600_sdmc_compute_conf;
>      asc->write = aspeed_2600_sdmc_write;
>      asc->valid_ram_sizes = aspeed_2600_ram_sizes;
> 


