Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66707FA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 15:51:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E55B21835
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 15:51:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E55B21835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL84A-0006LV-V3
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 11:51:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52339)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iL7Dt-0006Rv-Pv
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 10:57:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iL7Ds-0003TM-M8
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 10:57:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48906)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iL7Ds-0003Sm-DN
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 10:57:52 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5D73883F3F
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 14:57:51 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id h4so1083702wrx.15
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 07:57:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=o5+mN5TWocD074lChA+EtfESe1UDQF/8fNvSRG/oXdc=;
 b=T2jUyUHBV5yq5g5HOCKfgfJO+6Y/YVW239ltd4HT7GiwLV8X130sqDlgFC3DfwpzDQ
 YLq4nVw2+vc8ug20iLz4+fyFMhXsUSWxSURMIcyxAC6RXIbR1xmhVxROrmYr+YH2RJtM
 rX9x5TdHbsVmEHVKEGuryfpOtGydiSD1x8AkVvakQy9afXGPSb2VFwLV5M1jVYFCMOkS
 3lPlWcXKetnVDQcipU3DyQs9XIHL6RzS+WPH59plD1toRss/NYJalEjpjVyoF09hinad
 fChBnQUJbDMues0S5RDpVKA9L3bSeQVKI4OMedVzVYZ1GRf64H7Q/fQuQvq6BnCuT0mG
 NPYw==
X-Gm-Message-State: APjAAAWKCgb+f/JUKEo70MeMT2h/U8TvxHqLOuZ/x2V9gQTnlGmeOw1R
 Jaful/FrKB5NjaXLrRsoTlG0Tx349IWJLHmz87ULIp2eg3HXOgVc16j3jR4HeV9wY748tQk/p1X
 G1+vmMz+MnXwdLFA=
X-Received: by 2002:adf:ed49:: with SMTP id u9mr3345418wro.229.1571324270000; 
 Thu, 17 Oct 2019 07:57:50 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyvlsipnDQOGuTSRWJXCYCbRTMN7USRD+lufA69xqQgOllIx3S/gWXBWgMphYlqXNB8s+E1wQ==
X-Received: by 2002:adf:ed49:: with SMTP id u9mr3345403wro.229.1571324269810; 
 Thu, 17 Oct 2019 07:57:49 -0700 (PDT)
Received: from [192.168.50.32] (243.red-88-26-246.staticip.rima-tde.net.
 [88.26.246.243])
 by smtp.gmail.com with ESMTPSA id g13sm2511574wrm.42.2019.10.17.07.57.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2019 07:57:49 -0700 (PDT)
Subject: Re: [PATCH 1/3] hw/net/fsl_etsec/etsec.c: Switch to transaction-based
 ptimer API
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20191017132122.4402-1-peter.maydell@linaro.org>
 <20191017132122.4402-2-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d95174ee-9ee1-f977-8755-2f9b3de01e0c@redhat.com>
Date: Thu, 17 Oct 2019 16:57:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191017132122.4402-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Jason Wang <jasowang@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/17/19 3:21 PM, Peter Maydell wrote:
> Switch the fsl_etsec code away from bottom-half based ptimers to
> the new transaction-based ptimer API.  This just requires adding
> begin/commit calls around the various places that modify the ptimer
> state, and using the new ptimer_init() function to create the timer.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/net/fsl_etsec/etsec.h | 1 -
>   hw/net/fsl_etsec/etsec.c | 9 +++++----
>   2 files changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/net/fsl_etsec/etsec.h b/hw/net/fsl_etsec/etsec.h
> index 09d05c21338..7951c3ad65f 100644
> --- a/hw/net/fsl_etsec/etsec.h
> +++ b/hw/net/fsl_etsec/etsec.h
> @@ -141,7 +141,6 @@ typedef struct eTSEC {
>       uint16_t phy_control;
>  =20
>       /* Polling */
> -    QEMUBH *bh;
>       struct ptimer_state *ptimer;
>  =20
>       /* Whether we should flush the rx queue when buffer becomes avail=
able. */
> diff --git a/hw/net/fsl_etsec/etsec.c b/hw/net/fsl_etsec/etsec.c
> index d9b3e8c691e..717de76569a 100644
> --- a/hw/net/fsl_etsec/etsec.c
> +++ b/hw/net/fsl_etsec/etsec.c
> @@ -34,7 +34,6 @@
>   #include "etsec.h"
>   #include "registers.h"
>   #include "qemu/log.h"
> -#include "qemu/main-loop.h"
>   #include "qemu/module.h"
>  =20
>   /* #define HEX_DUMP */
> @@ -195,9 +194,11 @@ static void write_dmactrl(eTSEC          *etsec,
>  =20
>       if (!(value & DMACTRL_WOP)) {
>           /* Start polling */
> +        ptimer_transaction_begin(etsec->ptimer);
>           ptimer_stop(etsec->ptimer);
>           ptimer_set_count(etsec->ptimer, 1);
>           ptimer_run(etsec->ptimer, 1);
> +        ptimer_transaction_commit(etsec->ptimer);
>       }
>   }
>  =20
> @@ -391,10 +392,10 @@ static void etsec_realize(DeviceState *dev, Error=
 **errp)
>                                 object_get_typename(OBJECT(dev)), dev->=
id, etsec);
>       qemu_format_nic_info_str(qemu_get_queue(etsec->nic), etsec->conf.=
macaddr.a);
>  =20
> -
> -    etsec->bh     =3D qemu_bh_new(etsec_timer_hit, etsec);
> -    etsec->ptimer =3D ptimer_init_with_bh(etsec->bh, PTIMER_POLICY_DEF=
AULT);
> +    etsec->ptimer =3D ptimer_init(etsec_timer_hit, etsec, PTIMER_POLIC=
Y_DEFAULT);
> +    ptimer_transaction_begin(etsec->ptimer);
>       ptimer_set_freq(etsec->ptimer, 100);
> +    ptimer_transaction_commit(etsec->ptimer);
>   }
>  =20
>   static void etsec_instance_init(Object *obj)
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

