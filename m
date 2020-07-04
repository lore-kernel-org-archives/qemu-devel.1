Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49AA2C433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 10:36:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 143D120890
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 10:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pmjXPSb+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 143D120890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrfX9-0003ou-Bf
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 06:36:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45202)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrfWZ-0003PE-W7
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 06:36:00 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:55232)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrfWY-0001iY-GY
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 06:35:59 -0400
Received: by mail-wm1-x342.google.com with SMTP id o8so34255823wmh.4
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 03:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:from:to:cc:references:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xueC0DC4KPZB0FASqlDthEjLsQc088F3xONQCmftnGY=;
 b=pmjXPSb+GywkoRG5i1G+7cIxmMP40G/eUehOrH8D5Vn8EBT2IqzPqWgvc7zEbZR5QM
 ULwNfCyTK1q4Jj5J9z1+CCcLnBx67YMAMFa8WATZLRLnuPL2LI1+nMZ5KqlSeHYWAau8
 LUqjnw1cIo5rRbf+go7zPtrit/zO+knhswgEWdEn/QknvpQMzu2kqtK5NaUkl+qnol8B
 CAMb3GztT+nRTsuFHUXyE8HOv7L56wm2qnWKuv/NJeBKeRiqDq3tqtqtetyP+TeHw8xV
 i4NIW9+R9a4YsOAoel3GUKBL49C0BcU7EbJT58gg/PKXwX2DZzuEn8+W9dS+5UAfwACW
 mi7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:from:to:cc:references:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=xueC0DC4KPZB0FASqlDthEjLsQc088F3xONQCmftnGY=;
 b=RUvCCMMt1HNLmPRq8478Itliv0p5WSkQPkkBgOYUOGSj2gubVAwEwecKvEcDQtfF8u
 /oVGfhZHO3J87LrqNC5B1ykSKZvnEBfudaDW0gKqajIKB1AzrGKDGr0SGup5AKHakziE
 bEgZEYrOSpCw76u7lOxG7WIur2VbY3rFGaWxdc9bl4OYxMhVSq6Eaw8JnHx+JY4N6+LC
 bGrsxt0ScJXYIcrUJliqr+0e6QNFDR6Gu0Pi+5xtPJgcxA/uiqyGMpUdj2XDmIQCv5i0
 9v/lKT1B0ztpKRyXkBgcNc7032OUsus5SpyNQi7aOkjilN8aNlKGWs8AqyPv5JnZ4P1b
 KjXw==
X-Gm-Message-State: AOAM531LAEg3zb7p/sfhIR2XN5E5SL3MJL73jJj/WkWhtJyPNJs/lstK
 GVCzj4KizTno4l6PFhUHcA74MXDMUIw=
X-Google-Smtp-Source: ABdhPJxllmIqPD2vLJw+s/F20wxraTM+Ez1eEUbtkUX/oe8BUZGPuUS6ZBNjIxJbedCR9wkvj4RC2g==
X-Received: by 2002:a7b:c4d8:: with SMTP id g24mr38597215wmk.127.1593858956843; 
 Sat, 04 Jul 2020 03:35:56 -0700 (PDT)
Received: from [192.168.1.39] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id x124sm11505260wmx.16.2020.07.04.03.35.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Jul 2020 03:35:56 -0700 (PDT)
Subject: Re: [PULL 15/29] dwc-hsotg (dwc2) USB host controller register
 definitions
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Paul Zimmerman <pauldzim@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>
References: <20200605165007.12095-1-peter.maydell@linaro.org>
 <20200605165007.12095-16-peter.maydell@linaro.org>
 <7b202654-1ff8-53e0-521a-7142db0187dd@amsat.org>
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
Message-ID: <cf9e5038-59d7-0790-b8e9-704b816b1600@amsat.org>
Date: Sat, 4 Jul 2020 12:35:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <7b202654-1ff8-53e0-521a-7142db0187dd@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/4/20 11:17 AM, Philippe Mathieu-Daudé wrote:
> Hi Paul,
> 
> On 6/5/20 6:49 PM, Peter Maydell wrote:
>> From: Paul Zimmerman <pauldzim@gmail.com>
>>
>> Import the dwc-hsotg (dwc2) register definitions file from the
>> Linux kernel. This is a copy of drivers/usb/dwc2/hw.h from the
>> mainline Linux kernel, the only changes being to the header, and
>> two instances of 'u32' changed to 'uint32_t' to allow it to
>> compile. Checkpatch throws a boatload of errors due to the tab
>> indentation, but I would rather import it as-is than reformat it.
>>
>> Signed-off-by: Paul Zimmerman <pauldzim@gmail.com>
>> Message-id: 20200520235349.21215-3-pauldzim@gmail.com
>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>  include/hw/usb/dwc2-regs.h | 899 +++++++++++++++++++++++++++++++++++++
>>  1 file changed, 899 insertions(+)
>>  create mode 100644 include/hw/usb/dwc2-regs.h
> 
> Can you add a section in MAINTAINERS to cover the dwc2 files you added?

Bah since I have it locally, I'll post it, interested parties can still
ack/nack it.

> Being listed as reviewer would help Gerd maintaining it, because that
> way you'd get notifications if someone makes a change.
> 
> Something like:
> 
> -- >8 --
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1652,6 +1652,13 @@ M: Samuel Thibault <samuel.thibault@ens-lyon.org>
>  S: Maintained
>  F: hw/usb/dev-serial.c
> 
> +USB (DWC2)
> +M: Gerd Hoffmann <kraxel@redhat.com>
> +R: Paul Zimmerman <pauldzim@gmail.com>
> +S: Maintained
> +F: hw/usb/hcd-dwc2.*
> +F: include/hw/usb/dwc2-regs.h
> +
>  VFIO
>  M: Alex Williamson <alex.williamson@redhat.com>
>  S: Supported
> ---
> 
> Thanks,
> 
> Phil.
> 

