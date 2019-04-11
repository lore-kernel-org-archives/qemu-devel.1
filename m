Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2161BC10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 09:53:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E58692084D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 09:53:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E58692084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45312 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEWOX-00036h-6m
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 05:53:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEWN1-0002Dc-N4
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 05:51:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEWN0-0006Dm-Jb
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 05:51:47 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40489)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hEWN0-0006DR-BP
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 05:51:46 -0400
Received: by mail-wm1-f65.google.com with SMTP id z24so5862410wmi.5
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 02:51:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=Mp30IB44MiPLuhouHlkUWN/YLA9o/SrFfSccwHJCheU=;
	b=KXZajVwkFrJ5eUKJtFgW9pR/4eKJ+sbNglm3DNcJOSH2S7BmKIPaG6lC0gqbqQV+FR
	KYxBvKHe3oZ09dGcVWRRnE85ZFEWrnkC352UkX/bnyWaf3n/tUmadDDsyODhCvxqrEbD
	IOVI81oWINn9XoVi73jTZx3cBrIbAMG4MIcQ4W1rkRrctfw0NQNoN1dsEkD+tk/Ac2QJ
	Qf52zThnxaxS5EkRxaA6d8wJyjvLJRSm0CkpzX8SR2FcL+T45PhzNgkDzokIYdqKwTdi
	BUrnsUH+JNuhHQf57d01ZG9bwNGWGfWRolbCKjfnXkVUFnQxBBSZWw6DDusBxs+FipSC
	e3CQ==
X-Gm-Message-State: APjAAAWN5k9wDFbPrNEpmlUQ2M0HesjtUPNRy1k2ORtnaz9JoJ7ekAsB
	ZfMU5R1IQkJcUjFExXUa5QzxJw==
X-Google-Smtp-Source: APXvYqyl3RKpdbuRJLTxRJet1hUvAK1oEPCrvkBPhbbOtrjndO1yhHdLR5ywreVTh94VeBmnuUhWmQ==
X-Received: by 2002:a7b:c155:: with SMTP id z21mr6022648wmi.1.1554976305402;
	Thu, 11 Apr 2019 02:51:45 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193])
	by smtp.gmail.com with ESMTPSA id d3sm9586088wmf.46.2019.04.11.02.51.44
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 11 Apr 2019 02:51:44 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190315032629.21234-1-richard.henderson@linaro.org>
	<20190315032629.21234-17-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <cd584bda-744e-f25f-a35d-cda8dcbeec09@redhat.com>
Date: Thu, 11 Apr 2019 11:51:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190315032629.21234-17-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH v3 16/23] aspeed/scu: Use
 qemu_guest_getrandom_nofail
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org,
	=?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
	Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411095144.S5-gOcycfpYlP7c8PQpRPiseS2ztOge-VU-PUGeDMpU@z>

On 3/15/19 4:26 AM, Richard Henderson wrote:
> The random number is intended for use by the guest.  As such, we should
> honor the -seed argument for reproducibility.  Use the *_nofail routine
> instead of rolling our own error handling locally.
> 
> Cc: qemu-arm@nongnu.org
> Cc: Cédric Le Goater <clg@kaod.org>
> Cc: Andrew Jeffery <andrew@aj.id.au>
> Cc: Joel Stanley <joel@jms.id.au>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  hw/misc/aspeed_scu.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
> index c8217740ef..ab1e18ed4b 100644
> --- a/hw/misc/aspeed_scu.c
> +++ b/hw/misc/aspeed_scu.c
> @@ -16,7 +16,7 @@
>  #include "qapi/visitor.h"
>  #include "qemu/bitops.h"
>  #include "qemu/log.h"
> -#include "crypto/random.h"
> +#include "qemu/guest-random.h"
>  #include "trace.h"
>  
>  #define TO_REG(offset) ((offset) >> 2)
> @@ -157,14 +157,8 @@ static const uint32_t ast2500_a1_resets[ASPEED_SCU_NR_REGS] = {
>  
>  static uint32_t aspeed_scu_get_random(void)
>  {
> -    Error *err = NULL;
>      uint32_t num;
> -
> -    if (qcrypto_random_bytes((uint8_t *)&num, sizeof(num), &err)) {
> -        error_report_err(err);
> -        exit(1);
> -    }
> -
> +    qemu_guest_getrandom_nofail(&num, sizeof(num));
>      return num;
>  }
>  
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

