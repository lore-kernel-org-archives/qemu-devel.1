Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A603EC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 15:47:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ABAA206C3
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 15:47:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ABAA206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj2ww-0004s0-Mh
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 11:47:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52258)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jj2wI-0004OZ-3h
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 11:46:54 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:38161)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jj2wH-0002IM-0e
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 11:46:53 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1M1qbm-1jlFrb1uHI-002CWq; Wed, 10 Jun 2020 17:46:47 +0200
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200609122339.937862-1-armbru@redhat.com>
 <20200609122339.937862-9-armbru@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH v3 08/24] mac_via: Fix to realize "mos6522-q800-via*"
 devices
Message-ID: <4dc436b3-d074-9357-443b-cce3bd3f0ce5@vivier.eu>
Date: Wed, 10 Jun 2020 17:46:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200609122339.937862-9-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:mJ5q+jvhgTw1BrcQeuDqq1iQbCUiwXn7h5v84acaP/qvupXEOqb
 ep5nyfyzGjrPWaEkpyP0Q8YRlf5gkr8LKgGV5DYkmp/Qc09ahoSIcuhxAhXd02XHxQNMN06
 bYLHqOZCoWQieCYZtR9oM8juo6i9i/QWe6Obji8zTf/i5zTUKRMeX6weK9zXPGsnvzuQZv3
 UGOH0NpQYQ7QZktKsAQ6g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:APtzOO/hfB4=:MnyRqKNtnIW5+WLw7vYGnT
 PwjD2Q58MC73GEhibRmex6nqd8GHTI8R2/6JGpEOS9NaWeWJ/RdM65flkfxt2PjkrwanayWzJ
 mxHs49RJuMdvnvzPqKhLoWABx8v/IQ6blvIESM17sjDD4o2iKFLsPfqg/+YwglxoQ/fDsJw4R
 o6jnAY+hj0qAPVJUMZ4wQvqmA00eWcGouUkGVAmXWfYuGehNHNUkZzKwxelmhQWMUhamrBfdu
 CsYayJnLA85nlWQN/2rl4Kc7XC9JbPWdmu9KyVqPoV6fiKQpEln84iv7KoUF3FJTPLssc+0Lt
 9pDTE7tciDJkyCypqT6DhM53lBMkjtJuCn9bBsN1jtv/tIlU7ZhubJFjQEt56SwUjhdy0ePur
 ht7o7iOe8mnYJ7IOdF91I26O6Tl89ISZBso7Q78gdDzObLROPeF4WTRJmzjt7sA5xXUs8FPxU
 dqtFiOkpoKXALd1B/fzxEhWDso4Bsd3E9iy3apFBQjs+zQKIcFIh3MKu/zmtcerUu090t5PoG
 T+Xm2LwYJDNOiWPQoWfUq0b5piTTMGOBQr0F9LetQyFAzhrr9dIjD8CJpFgMOn8KhBep4mSkX
 Z4NC/ge4cxvsfY2VH7XMnnlivKq3NTByvy38EA4Hah3mLkSaScTsfzgGWRJI2TL85MpKSX0Kv
 PNMJAdqxgrz+WCUaVxpTGtDDtZfjd7EPlownLqtcxD73UKm1iZkablOtGaCad6Vn6mj80EcR2
 atkd/BRerOVyb6IYjnTTdS3+JvJgZoDpieb5+//oHGldcUVZn64zMhoSUR4ho5HizqnQ7FWQf
 JIzKQe0D5K7F5hU+3b1V0VJKnvAo4Fhk/LcYjC8vKeGsAGdJIw+7sbIgT0XAPxDGTla/jXa
Received-SPF: none client-ip=212.227.17.24; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 11:46:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Cc: pbonzini@redhat.com, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 berrange@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 09/06/2020 à 14:23, Markus Armbruster a écrit :
> mac_via_realize() creates a "mos6522-q800-via1" and a
> "mos6522-q800-via2" device, but neglects to realize them.  Affects
> machine q800.
> 
> In theory, a device becomes real only on realize.  In practice, the
> transition from unreal to real is a fuzzy one.  The work to make a
> device real can be spread between realize methods (fine),
> instance_init methods (wrong), and board code wiring up the device
> (fine as long as it effectively happens on realize).  Depending on
> what exactly is done where, a device can work even when we neglect
> to realize it.
> 
> These two appear to work.  Nevertheless, it's a clear misuse of the
> interface.  Even when it works today (more or less by chance), it can
> break tomorrow.
> 
> Fix by realizing them right away.
> 
> Fixes: 6dca62a0000f95e0b7020aa00d0ca9b2c421f341
> Cc: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/misc/mac_via.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
> index e05623d730..82614c155a 100644
> --- a/hw/misc/mac_via.c
> +++ b/hw/misc/mac_via.c
> @@ -890,6 +890,11 @@ static void mac_via_realize(DeviceState *dev, Error **errp)
>      object_property_add_alias(OBJECT(dev), "irq[1]", OBJECT(ms),
>                                SYSBUS_DEVICE_GPIO_IRQ "[0]");
>  
> +    object_property_set_bool(OBJECT(&m->mos6522_via1), true, "realized",
> +                             &error_abort);
> +    object_property_set_bool(OBJECT(&m->mos6522_via2), true, "realized",
> +                             &error_abort);
> +
>      /* Pass through mos6522 input IRQs */
>      qdev_pass_gpios(DEVICE(&m->mos6522_via1), dev, "via1-irq");
>      qdev_pass_gpios(DEVICE(&m->mos6522_via2), dev, "via2-irq");
> 

Tested-by: Laurent Vivier <laurent@vivier.eu>
Acked-by: Laurent Vivier <laurent@vivier.eu>

