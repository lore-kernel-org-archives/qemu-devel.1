Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA174C54FCC
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 06:27:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9773E206D6
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 06:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKz86htW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9773E206D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQmNS-0005yS-MX
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 02:27:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50050)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQmLx-0004ot-GL
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 02:25:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQmLx-0008Kp-3I
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 02:25:53 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54047)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQmLw-0008HX-LB
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 02:25:52 -0400
Received: by mail-wm1-x342.google.com with SMTP id t63so2199171wmt.3
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 23:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oMhaLB0D3FZSrLtBgMOThNEzfHHqOWhL1q0atzWNPJI=;
 b=mKz86htWw2Oqw5S5h1eY5dZImwmm2yOlohXaplPtdGJ183eSNnd4vHTFHaF/GtJFz4
 yJAkux8KjtJZNxyZz9THL0CXB3fkVZgYDNhWMXy7o9sgvVVr9d1b9XziRdx2GYITQbUL
 G3rvv1M/SxlagJ9WixULCacSylF9/bDkB5p7bp8P0MV+b6W1+DnaHGI1/wWtZAtIiber
 dGkr6GhZ0SRwgMrmW3LTKzLEZY5mR4QYsS6jW8bst+2A3ybjPu1NZgJtSNDZ7pN4bBz+
 GXiWr6M5ZZE6s/tcIf7WriusaYQJhvWRULYgoQFlNWX5eGYiA3h9knbft6zLcEMYh0Q8
 D/mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=oMhaLB0D3FZSrLtBgMOThNEzfHHqOWhL1q0atzWNPJI=;
 b=tgxLM1xSl4WpqxwAFbxepv683HqMrJ5z9xKF2xNX42iVAdAkSsiU38P5cbmJO52tD/
 QaKboCGWq/N/sTueha0CniCoWfNpwjRXny6ZPX45YIRf6HMAYnPADaSPXUaAOxhRVEc9
 J4G5HOxdbcEnyv9qQvdD36lvMga4XILKZ0C+37yvjn7U4boS7lzjW5wxl63IHNQFGd3V
 /bwny9jsB5pPMdPVuSYGSFF2W/1Fk0H/yMcnjIAer0PVP720GX0nJ3G8WJoyBJ9PXeZ6
 bwunUMQsArWBs+NFHKaW488qLMsueBp/Qk9zzrU414q99FUkGa9DBQzQxyq+JF1xzDWI
 /HKw==
X-Gm-Message-State: AGi0PubV+w4gleUYlgsjKD71uyxf5E+/V9teuUV+3PrkX28xh+pNQE4b
 7IBQFPHzJdvkSToktiM/xfXi/3TLKIE=
X-Google-Smtp-Source: APiQypLULKtUcmPTbSt6CedEWmUrjBfTK4uttZDJ8jcIJ06881sOaQkTzLrp+RXiRO0p1y5/wFcNFA==
X-Received: by 2002:a05:600c:2:: with SMTP id g2mr3298804wmc.85.1587450350089; 
 Mon, 20 Apr 2020 23:25:50 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id n6sm2088207wmc.28.2020.04.20.23.25.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Apr 2020 23:25:49 -0700 (PDT)
Subject: Re: [PATCH v3 6/7] wire in the dwc-hsotg (dwc2) USB host controller
 emulation
To: Paul Zimmerman <pauldzim@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>
References: <20200421014551.10426-1-pauldzim@gmail.com>
 <20200421014551.10426-7-pauldzim@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Autocrypt: addr=f4bug@amsat.org; keydata=
 mQINBDU8rLoBEADb5b5dyglKgWF9uDbIjFXU4gDtcwiga9wJ/wX6xdhBqU8tlQ4BroH7AeRl
 u4zXP0QnBDAG7EetxlQzcfYbPmxFISWjckDBFvDbFsojrZmwF2/LkFSzlvKiN5KLghzzJhLO
 HhjGlF8deEZz/d/G8qzO9mIw8GIBS8uuWh6SIcG/qq7+y+2+aifaj92EdwU79apZepT/U3vN
 YrfcAuo1Ycy7/u0hJ7rlaFUn2Fu5KIgV2O++hHYtCCQfdPBg/+ujTL+U+sCDawCyq+9M5+LJ
 ojCzP9rViLZDd/gS6jX8T48hhidtbtsFRj/e9QpdZgDZfowRMVsRx+TB9yzjFdMO0YaYybXp
 dg/wCUepX5xmDBrle6cZ8VEe00+UQCAU1TY5Hs7QFfBbjgR3k9pgJzVXNUKcJ9DYQP0OBH9P
 ZbZvM0Ut2Bk6bLBO5iCVDOco0alrPkX7iJul2QWBy3Iy9j02GnA5jZ1Xtjr9kpCqQT+sRXso
 Vpm5TPGWaWljIeLWy/qL8drX1eyJzwTB3A36Ck4r3YmjMjfmvltSZB1uAdo1elHTlFEULpU/
 HiwvvqXQ9koB15U154VCuguvx/Qnboz8GFb9Uw8VyawzVxYVNME7xw7CQF8FYxzj6eI7rBf2
 Dj/II6wxWPgDEy3oUzuNOxTB7sT3b/Ym76yOJzWX5BylXQIJ5wARAQABtDFQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoRjRCVUcpIDxmNGJ1Z0BhbXNhdC5vcmc+iQJVBBMBCAA/AhsPBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgBYhBPqr514SkXIh3P1rsuPjLCzercDeBQJd660aBQks
 klzgAAoJEOPjLCzercDe2iMP+gMG2dUf+qHz2uG8nTBGMjgK0aEJrKVPodFA+iedQ5Kp3BMo
 jrTg3/DG1HMYdcvQu/NFLYwamUfUasyor1k+3dB23hY09O4xOsYJBWdilkBGsJTKErUmkUO2
 3J/kawosvYtJJSHUpw3N6mwz/iWnjkT8BPp7fFXSujV63aZWZINueTbK7Y8skFHI0zpype9s
 loU8xc4JBrieGccy3n4E/kogGrTG5jcMTNHZ106DsQkhFnjhWETp6g9xOKrzZQbETeRBOe4P
 sRsY9YSG2Sj+ZqmZePvO8LyzGRjYU7T6Z80S1xV0lH6KTMvq7vvz5rd92f3pL4YrXq+e//HZ
 JsiLen8LH/FRhTsWRgBtNYkOsd5F9NvfJtSM0qbX32cSXMAStDVnS4U+H2vCVCWnfNug2TdY
 7v4NtdpaCi4CBBa3ZtqYVOU05IoLnlx0miKTBMqmI05kpgX98pi2QUPJBYi/+yNu3fjjcuS9
 K5WmpNFTNi6yiBbNjJA5E2qUKbIT/RwQFQvhrxBUcRCuK4x/5uOZrysjFvhtR8YGm08h+8vS
 n0JCnJD5aBhiVdkohEFAz7e5YNrAg6kOA5IVRHB44lTBOatLqz7ntwdGD0rteKuHaUuXpTYy
 CRqCVAKqFJtxhvJvaX0vLS1Z2dwtDwhjfIdgPiKEGOgCNGH7R8l+aaM4OPOd
Message-ID: <f9ab000d-ef03-5925-991a-a5503cdba4f6@amsat.org>
Date: Tue, 21 Apr 2020 08:25:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200421014551.10426-7-pauldzim@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/21/20 3:45 AM, Paul Zimmerman wrote:
> Wire the dwc-hsotg (dwc2) emulation into Qemu
> 
> Signed-off-by: Paul Zimmerman <pauldzim@gmail.com>
> ---
>  hw/arm/bcm2835_peripherals.c         | 21 ++++++++++++++++++++-
>  hw/usb/Kconfig                       |  5 +++++
>  hw/usb/Makefile.objs                 |  1 +
>  include/hw/arm/bcm2835_peripherals.h |  3 ++-
>  4 files changed, 28 insertions(+), 2 deletions(-)
> 

This part ...

> diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
> index 464348ba14..d4d8c37c28 100644
> --- a/hw/usb/Kconfig
> +++ b/hw/usb/Kconfig
> @@ -46,6 +46,11 @@ config USB_MUSB
>      bool
>      select USB
>  
> +config USB_DWC2
> +    bool
> +    default y
> +    select USB
> +
>  config TUSB6010
>      bool
>      select USB_MUSB
> diff --git a/hw/usb/Makefile.objs b/hw/usb/Makefile.objs
> index 66835e5bf7..fa5c3fa1b8 100644
> --- a/hw/usb/Makefile.objs
> +++ b/hw/usb/Makefile.objs
> @@ -12,6 +12,7 @@ common-obj-$(CONFIG_USB_EHCI_SYSBUS) += hcd-ehci-sysbus.o
>  common-obj-$(CONFIG_USB_XHCI) += hcd-xhci.o
>  common-obj-$(CONFIG_USB_XHCI_NEC) += hcd-xhci-nec.o
>  common-obj-$(CONFIG_USB_MUSB) += hcd-musb.o
> +common-obj-$(CONFIG_USB_DWC2) += hcd-dwc2.o
>  
>  common-obj-$(CONFIG_TUSB6010) += tusb6010.o
>  common-obj-$(CONFIG_IMX)      += chipidea.o

... belongs to patch #4 'USB host controller emulation'.

