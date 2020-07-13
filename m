Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C5DBC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 18:02:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26773206F0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 18:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQiIPXhr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26773206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv2mw-0000nY-Dz
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 14:02:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60328)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jv2mD-0008KZ-Tm; Mon, 13 Jul 2020 14:02:05 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:41114)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jv2mC-0000Jo-BN; Mon, 13 Jul 2020 14:02:05 -0400
Received: by mail-ej1-x642.google.com with SMTP id dp18so18279632ejc.8;
 Mon, 13 Jul 2020 11:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:from:to:cc:references:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dgnlr4CxUbjxTJlk7odjXNamg+5YK9WSByX24B6wm74=;
 b=eQiIPXhr13Lpq6/SVz3R4KrchoRV9pj1pTVipIfUQX3aGEMoNbClrexl428EGUdXKJ
 i5vV1ivSP8V6mTO8WKeZRKcRkobgHjOPcaX0vSSBbgGqjtaawSYlEGL2Hu5IpVw5ewSI
 mS5A9H6HBgO0awWkbphrVw1WIlughPCTgadk21fIi/gVfyHvf9iMcqfxepYyHCm4eGkv
 qdYxY5fsYfDbuv8cUGhVIIvH8R2sORWjF0bZH0leiHrlNOXEZbv2QqGyj1xrzdiBOC/c
 ESL3ewHgwsms/Kp1AyJZGiGg3CCs1rqjStky1P/LEPRQIYQpvxYrAdkzExIaatZD3FOU
 f0eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:from:to:cc:references:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=dgnlr4CxUbjxTJlk7odjXNamg+5YK9WSByX24B6wm74=;
 b=jrda+DHUFBYQUCh2Q9I62sfRnLkEtqAU/EKuWndmJTjBCFqLXtK85cBwuVi6RNfdEM
 XcoRy689ZQ0iqaeCHlFfcmRUkOgZKlJ2T6LGPAOSGI/Rqo7UND1kgPIviBYXWmM2zl+T
 jRsx8xFkBGTjxBHPI4vCA0yXSakHgX9Dih7r+TVHEermDV8IzOwNd4ytzsymv9VvMqBl
 bb97xaRs+O2f0VLu62tLuTMRvlElwEL24kLG1k5ZH+UgnD/z9O6oYZ2NxyYOZsHguFuN
 zKC0sNneWX5aWH68ZV4UHoEJ1chQU3731fbLxWqrubKdYVwb/qEgjiFEIkKsNWxb/2le
 vj3w==
X-Gm-Message-State: AOAM531xzKxgrv4iaeiLqx6JdzY1EXTmo4A1XV7P7iCJVqUGaMiEFnvq
 Ob7dWSJKu4gto02F91njqbW/jdtGBfM=
X-Google-Smtp-Source: ABdhPJyvFGPOBYFO9UG5LGW/TyY4uYLN89HBy8yHUEIUtW2YBu855FlYgRcA98r9BG6ltwpG7B4p8w==
X-Received: by 2002:a17:906:ecb6:: with SMTP id
 qh22mr840113ejb.230.1594663322510; 
 Mon, 13 Jul 2020 11:02:02 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id jo25sm10274716ejb.116.2020.07.13.11.02.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2020 11:02:01 -0700 (PDT)
Subject: Re: [PATCH v5 10/11] hw/arm: Wire up BMC boot flash for npcm750-evb
 and quanta-gsj
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Havard Skinnemoen <hskinnemoen@google.com>, peter.maydell@linaro.org
References: <20200709003608.3834629-1-hskinnemoen@google.com>
 <20200709003608.3834629-11-hskinnemoen@google.com>
 <109d52ed-65bf-0fcc-98f1-47b7a6671d0b@kaod.org>
 <9f0855f1-1319-81b3-7758-ba53e5d733e9@amsat.org>
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
Message-ID: <776ce1d8-4f1c-9284-69b0-4e17356aa615@amsat.org>
Date: Mon, 13 Jul 2020 20:02:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <9f0855f1-1319-81b3-7758-ba53e5d733e9@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x642.google.com
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
Cc: kfting@nuvoton.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Avi.Fishman@nuvoton.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/13/20 7:59 PM, Philippe Mathieu-Daudé wrote:
> On 7/13/20 4:57 PM, Cédric Le Goater wrote:
>> On 7/9/20 2:36 AM, Havard Skinnemoen wrote:
>>> This allows these NPCM7xx-based boards to boot from a flash image, e.g.
>>> one built with OpenBMC. For example like this:
>>>
>>> IMAGE=${OPENBMC}/build/tmp/deploy/images/gsj/image-bmc
>>> qemu-system-arm -machine quanta-gsj -nographic \
>>> 	-bios ~/qemu/bootrom/npcm7xx_bootrom.bin \
>>> 	-drive file=${IMAGE},if=mtd,bus=0,unit=0,format=raw,snapshot=on
>>>
>>> Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
>>> Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
>>
>> May be we don't need to create the flash object if dinfo is NULL.
> 
> Well, this is not wrong since m25p80_realize() check for the 'drive'
> property, but I'd rather avoid using fake block, and instead force
> users wanting an empty flash to use '-drive driver=null-co,...'.
> 
> So I prefer Cédric suggestion too.

Ah I see the model is fixed, is this SPI flash soldered on the
board?

> 
>> Reviewed-by: Cédric Le Goater <clg@kaod.org>
>> Tested-by: Cédric Le Goater <clg@kaod.org>
>>
>> Nice ! 
>>
>> We need a SPI controller model and a network device model now. 
>>
>> npcm7xx_bootrom.bin is a bit of a pain. Could we include it in 
>> the QEMU roms ? 
> 
> Ah, this is what I asked on patch #6 ;)
> 

