Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7714AC433E1
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 17:57:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BA4C206E9
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 17:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r2Z4Wr7X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BA4C206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtEJz-0005lp-Jx
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 13:57:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jtEJA-0005EH-Jt; Wed, 08 Jul 2020 13:56:36 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37666)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jtEJ7-0000ES-84; Wed, 08 Jul 2020 13:56:36 -0400
Received: by mail-wr1-x443.google.com with SMTP id a6so49932164wrm.4;
 Wed, 08 Jul 2020 10:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:from:to:cc:references:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=U22wiPzF5RU+s2ekAx6AOl4uGlWcRAb453GfD82ZKhI=;
 b=r2Z4Wr7X8gfFC1/cRRJAelXMyipOkpKqLZiiPdq4DJxeBAZxVywTm/rk8P7mmV+QYd
 SQL8Tuqmao2lS40+2ET+boBL2Uy7okY3h+HX5g3HlL23X+/ZXbLD7mONnXsuabOdqkGt
 R+AA8/kP7sXzue5BxIie3Tf/tOCWtWsF6QWrP/y152QxtZIkkpZ3XwFtU6Z8RXEM+noy
 496zBLMD4eI+AuaFIlba0EM6KcROZsFYeIsRD4eJVlqCuCPo9O4Npf4V1kUjAld8NRlu
 GrMHQiG5U8yiEX2DLQglR4eFW+oQpQKMtR+wCBF9/CSem5IffF+xvVnYWsjkUkFbFVMl
 ounw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:from:to:cc:references:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=U22wiPzF5RU+s2ekAx6AOl4uGlWcRAb453GfD82ZKhI=;
 b=AdmiFTPeJ242DLFA1/g8Sf76Bh6xPDcCY3iNm8MSpG1s0Dw1P9HVwicOAMQx8bzH5F
 MBnjKmtKKji797k6H9Nf1ZssAkzDhhszTxsEKlpKlshp/5FjN2Ij9dXnW1cZ2iM/VA6Q
 DdpqNc3Py0qADx7Kjk6eXvDlJkwG67m8WPN/Ka9eM5HI5IE5yj3Qt982VnIcwsPKsL3J
 LFCJ5Q6Eac4s5UfHbaAvXKJgJtEiSYRS0xoGPy7jcJMqdTByI6p9rU/aqLydLmnatpak
 pEljlxnGZwXX5giUsJ4udbz8omAUs6syCsfGTSJMJghsbyZA1XXDAV9IX222KUjhY+Nr
 Nsog==
X-Gm-Message-State: AOAM533I/2mYsQSoXBYYJ1o/QPvfo0CTUDmMk++clktOmzlL1pM/5+zQ
 OHV2ntxbN7oUV8OvdN9GKWM=
X-Google-Smtp-Source: ABdhPJw0Bx7oZO8GPqre+725wRTsIGfUTag+9Go3qpoW6lfyZnxvXDgbWnL0dGk/Wix71MgQAaNPnw==
X-Received: by 2002:a5d:4903:: with SMTP id x3mr63261187wrq.351.1594230991418; 
 Wed, 08 Jul 2020 10:56:31 -0700 (PDT)
Received: from [192.168.1.36] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id w16sm1303673wrg.95.2020.07.08.10.56.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2020 10:56:30 -0700 (PDT)
Subject: Re: [PATCH v4 05/12] hw/arm: Add NPCM730 and NPCM750 SoC models
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Havard Skinnemoen <hskinnemoen@google.com>, peter.maydell@linaro.org
References: <20200707184730.3047754-1-hskinnemoen@google.com>
 <20200707184730.3047754-6-hskinnemoen@google.com>
 <4b7130f2-032c-3067-b2b6-876a2b17b707@amsat.org>
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
Message-ID: <2d1e272b-6575-30df-22ff-5d720973951d@amsat.org>
Date: Wed, 8 Jul 2020 19:56:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <4b7130f2-032c-3067-b2b6-876a2b17b707@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: kfting@nuvoton.com, qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 Avi.Fishman@nuvoton.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/8/20 7:31 PM, Philippe Mathieu-Daudé wrote:
> Hi Havard,
> 
> On 7/7/20 8:47 PM, Havard Skinnemoen wrote:
>> The Nuvoton NPCM7xx SoC family are used to implement Baseboard
>> Management Controllers in servers. While the family includes four SoCs,
>> this patch implements limited support for two of them: NPCM730 (targeted
>> for Data Center applications) and NPCM750 (targeted for Enterprise
>> applications).
>>
>> This patch includes little more than the bare minimum needed to boot a
>> Linux kernel built with NPCM7xx support in direct-kernel mode:
>>
>>   - Two Cortex-A9 CPU cores with built-in periperhals.
>>   - Global Configuration Registers.
>>   - Clock Management.
>>   - 3 Timer Modules with 5 timers each.
>>   - 4 serial ports.
>>
>> The chips themselves have a lot more features, some of which will be
>> added to the model at a later stage.
[...]

>> +static void npcm7xx_realize(DeviceState *dev, Error **errp)
>> +{
>> +    NPCM7xxState *s = NPCM7XX(dev);
>> +    NPCM7xxClass *nc = NPCM7XX_GET_CLASS(s);
>> +    Error *err = NULL;
>> +    int i;
>> +
>> +    /* I/O space -- unimplemented unless overridden below. */
>> +    create_unimplemented_device("npcm7xx.io", NPCM7XX_MMIO_BA, NPCM7XX_MMIO_SZ);
> 
> I still insist this is not the best, but as "The data sheet for these
> SoCs is not generally available" there is not much I can suggest to
> improve.

From your other comment I found:

https://github.com/Nuvoton-Israel/bootblock/blob/master/SWC_HAL/Chips/npcm750/npcm750.h

In particular:

#define AHB1_BASE_ADDR                  0xF0000000      /* AHB1
allocation (Including APB allocations)  */
#define AHB18_BASE_ADDR                 0x80000000      /* AHB18
allocation  */
#define AHB3_BASE_ADDR                  0xA0000000      /* AHB3
allocation  */
#define XBUSR_BASE_ADDR                 0xC0002000      /* XBUS
registers  */
#define AHB14_BASE_ADDR                 0xE0000000      /* AHB14
Allocation  */
#define APB14_BASE_ADDR                 0xE0000000      /* APB14
Allocation  */
#define VDMX_BASE_ADDR                  0xE0800000      /* VDMX  */

XBUS doesn't seem important.

If SPI flashes aren't connected, returning bus transaction sounds
correct:

#define SPI0CS0_BASE_ADDR               0x80000000      /* SPI0 direct
access CS0  */
#define SPI0CS1_BASE_ADDR               0x88000000      /* SPI0 direct
access CS1  */
#define SPI0CS2_BASE_ADDR               0x90000000      /* SPI0 direct
access CS2  */
#define SPI0CS3_BASE_ADDR               0x98000000      /* SPI0 direct
access CS3  */

#define SPI3CS0_BASE_ADDR               0xA0000000      /* SPI3 direct
access CS0  */
#define SPI3CS1_BASE_ADDR               0xA8000000      /* SPI3 direct
access CS1  */
#define SPI3CS2_BASE_ADDR               0xB0000000      /* SPI3 direct
access CS2  */
#define SPI3CS3_BASE_ADDR               0xB8000000      /* SPI3 direct
access CS3  */

So I'd prefer you use:

  create_unimplemented_device("npcm7xx.AHB1",  0xf0000000, 256 * MiB);

Maybe for the PCI root complex:

  create_unimplemented_device("npcm7xx.AHB14", 0xe0000000, 256 * MiB);

What do you think?

Regards,

Phil.

