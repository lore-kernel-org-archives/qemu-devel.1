Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B82C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 07:00:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 282E820674
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 07:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILI4yRAO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 282E820674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgNNZ-0006Tx-D8
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 03:00:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33394)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1jgNMe-0005ue-09; Wed, 03 Jun 2020 02:59:04 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:43010)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1jgNMc-0003Ca-J1; Wed, 03 Jun 2020 02:59:03 -0400
Received: by mail-pf1-x444.google.com with SMTP id 23so90189pfw.10;
 Tue, 02 Jun 2020 23:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hk02yA3AAIv20hnvc4goIAM8sloOroEwArDp7coBn9A=;
 b=ILI4yRAOQ2sN7rQHkaQvoVWcUBkF++tMBXEl3S6iKUn9tWAqPnOrM9C+rifYRT6Lkn
 xSsCozMI2flju+pkKa+CM07VRtPWpGOPUo5a3rHP93E4r4TWYbwV1953F1ZSxJmXRVc/
 oxknl2LaF43QhFRLXbnFuDCrBmrLqURl6WmxpRdmBUZdviLz2T7EfABUbkqlFuRccrLz
 yNShaT5vYq7CEiJoTwJb3GKm2wQsBcq7KWkEzrf40Sc2yC0ly3is6HpjnCbauNl9jR1a
 AFaepimptBUoupJrzQpJYO5VWhBV7dSgp3CPu07KtBpl1A8N6gEPmMagAt/c4ptGZsJ2
 iTiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=hk02yA3AAIv20hnvc4goIAM8sloOroEwArDp7coBn9A=;
 b=T0lXVEpwqSw2D0XsgxGnLd17rrfj+rQE9zpg7nwXitUreqdbbaieEXUytXRVHTULpg
 l29AsV8JzbgsXXC3VngFSO69QOPMgJ59S3V8pbkZZpF8B3UxesA3F1bMQQfknWJJVr4M
 Dyy8bLAL7FpY5bz1L/hB9s8T0xnn8guwVgecdjZGaIjSfhqK9NjC57GfQSJfhQSqhEAr
 vk2vjMPP4MBIFI9N1pcJ66whUpyNFk1B7LTXPjUDiA2/DiFHS9/cQr3vezP4La1oWdhS
 lyi2c5F84cHfou7WmEPjnxCHh7x+aJNHUiZrX/5hLJS6ygMVh3wULEjWWswJYrxXE7Tv
 5Lww==
X-Gm-Message-State: AOAM530EF5/8AxxDjfQxk0b4TPVRu3u+Yw5RR5rR3J0/Ex9/gdA8jRsp
 KJwNFBitw1fAlpb3C/1r95tXDlM0
X-Google-Smtp-Source: ABdhPJzmr3tJuOTffgaE8iR1LhVtKsKVd1ppSA3KNqGI3zWnKnrJusO5p4bbZ1gY4r13XeraldFLaw==
X-Received: by 2002:a17:90a:3669:: with SMTP id
 s96mr3944739pjb.149.1591167540430; 
 Tue, 02 Jun 2020 23:59:00 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id 9sm1275441pju.1.2020.06.02.23.58.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jun 2020 23:59:00 -0700 (PDT)
Subject: Re: [PATCH 1/2] sd: sdhci: Implement basic vendor specific register
 support
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200603052404.30788-1-linux@roeck-us.net>
 <20200603052404.30788-2-linux@roeck-us.net>
 <bac1b68a-3cee-5e60-dd6e-a866b04d2226@amsat.org>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 xsFNBE6H1WcBEACu6jIcw5kZ5dGeJ7E7B2uweQR/4FGxH10/H1O1+ApmcQ9i87XdZQiB9cpN
 RYHA7RCEK2dh6dDccykQk3bC90xXMPg+O3R+C/SkwcnUak1UZaeK/SwQbq/t0tkMzYDRxfJ7
 nyFiKxUehbNF3r9qlJgPqONwX5vJy4/GvDHdddSCxV41P/ejsZ8PykxyJs98UWhF54tGRWFl
 7i1xvaDB9lN5WTLRKSO7wICuLiSz5WZHXMkyF4d+/O5ll7yz/o/JxK5vO/sduYDIlFTvBZDh
 gzaEtNf5tQjsjG4io8E0Yq0ViobLkS2RTNZT8ICq/Jmvl0SpbHRvYwa2DhNsK0YjHFQBB0FX
 IdhdUEzNefcNcYvqigJpdICoP2e4yJSyflHFO4dr0OrdnGLe1Zi/8Xo/2+M1dSSEt196rXaC
 kwu2KgIgmkRBb3cp2vIBBIIowU8W3qC1+w+RdMUrZxKGWJ3juwcgveJlzMpMZNyM1jobSXZ0
 VHGMNJ3MwXlrEFPXaYJgibcg6brM6wGfX/LBvc/haWw4yO24lT5eitm4UBdIy9pKkKmHHh7s
 jfZJkB5fWKVdoCv/omy6UyH6ykLOPFugl+hVL2Prf8xrXuZe1CMS7ID9Lc8FaL1ROIN/W8Vk
 BIsJMaWOhks//7d92Uf3EArDlDShwR2+D+AMon8NULuLBHiEUQARAQABzTJHdWVudGVyIFJv
 ZWNrIChMaW51eCBhY2NvdW50KSA8bGludXhAcm9lY2stdXMubmV0PsLBgQQTAQIAKwIbAwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4ACGQEFAlVcphcFCRmg06EACgkQyx8mb86fmYFg0RAA
 nzXJzuPkLJaOmSIzPAqqnutACchT/meCOgMEpS5oLf6xn5ySZkl23OxuhpMZTVX+49c9pvBx
 hpvl5bCWFu5qC1jC2eWRYU+aZZE4sxMaAGeWenQJsiG9lP8wkfCJP3ockNu0ZXXAXwIbY1O1
 c+l11zQkZw89zNgWgKobKzrDMBFOYtAh0pAInZ9TSn7oA4Ctejouo5wUugmk8MrDtUVXmEA9
 7f9fgKYSwl/H7dfKKsS1bDOpyJlqhEAH94BHJdK/b1tzwJCFAXFhMlmlbYEk8kWjcxQgDWMu
 GAthQzSuAyhqyZwFcOlMCNbAcTSQawSo3B9yM9mHJne5RrAbVz4TWLnEaX8gA5xK3uCNCeyI
 sqYuzA4OzcMwnnTASvzsGZoYHTFP3DQwf2nzxD6yBGCfwNGIYfS0i8YN8XcBgEcDFMWpOQhT
 Pu3HeztMnF3HXrc0t7e5rDW9zCh3k2PA6D2NV4fews9KDFhLlTfCVzf0PS1dRVVWM+4jVl6l
 HRIAgWp+2/f8dx5vPc4Ycp4IsZN0l1h9uT7qm1KTwz+sSl1zOqKD/BpfGNZfLRRxrXthvvY8
 BltcuZ4+PGFTcRkMytUbMDFMF9Cjd2W9dXD35PEtvj8wnEyzIos8bbgtLrGTv/SYhmPpahJA
 l8hPhYvmAvpOmusUUyB30StsHIU2LLccUPPOwU0ETofVZwEQALlLbQeBDTDbwQYrj0gbx3bq
 7kpKABxN2MqeuqGr02DpS9883d/t7ontxasXoEz2GTioevvRmllJlPQERVxM8gQoNg22twF7
 pB/zsrIjxkE9heE4wYfN1AyzT+AxgYN6f8hVQ7Nrc9XgZZe+8IkuW/Nf64KzNJXnSH4u6nJM
 J2+Dt274YoFcXR1nG76Q259mKwzbCukKbd6piL+VsT/qBrLhZe9Ivbjq5WMdkQKnP7gYKCAi
 pNVJC4enWfivZsYupMd9qn7Uv/oCZDYoBTdMSBUblaLMwlcjnPpOYK5rfHvC4opxl+P/Vzyz
 6WC2TLkPtKvYvXmdsI6rnEI4Uucg0Au/Ulg7aqqKhzGPIbVaL+U0Wk82nz6hz+WP2ggTrY1w
 ZlPlRt8WM9w6WfLf2j+PuGklj37m+KvaOEfLsF1v464dSpy1tQVHhhp8LFTxh/6RWkRIR2uF
 I4v3Xu/k5D0LhaZHpQ4C+xKsQxpTGuYh2tnRaRL14YMW1dlI3HfeB2gj7Yc8XdHh9vkpPyuT
 nY/ZsFbnvBtiw7GchKKri2gDhRb2QNNDyBnQn5mRFw7CyuFclAksOdV/sdpQnYlYcRQWOUGY
 HhQ5eqTRZjm9z+qQe/T0HQpmiPTqQcIaG/edgKVTUjITfA7AJMKLQHgp04Vylb+G6jocnQQX
 JqvvP09whbqrABEBAAHCwWUEGAECAA8CGwwFAlVcpi8FCRmg08MACgkQyx8mb86fmYHNRQ/+
 J0OZsBYP4leJvQF8lx9zif+v4ZY/6C9tTcUv/KNAE5leyrD4IKbnV4PnbrVhjq861it/zRQW
 cFpWQszZyWRwNPWUUz7ejmm9lAwPbr8xWT4qMSA43VKQ7ZCeTQJ4TC8kjqtcbw41SjkjrcTG
 wF52zFO4bOWyovVAPncvV9eGA/vtnd3xEZXQiSt91kBSqK28yjxAqK/c3G6i7IX2rg6pzgqh
 hiH3/1qM2M/LSuqAv0Rwrt/k+pZXE+B4Ud42hwmMr0TfhNxG+X7YKvjKC+SjPjqp0CaztQ0H
 nsDLSLElVROxCd9m8CAUuHplgmR3seYCOrT4jriMFBtKNPtj2EE4DNV4s7k0Zy+6iRQ8G8ng
 QjsSqYJx8iAR8JRB7Gm2rQOMv8lSRdjva++GT0VLXtHULdlzg8VjDnFZ3lfz5PWEOeIMk7Rj
 trjv82EZtrhLuLjHRCaG50OOm0hwPSk1J64R8O3HjSLdertmw7eyAYOo4RuWJguYMg5DRnBk
 WkRwrSuCn7UG+qVWZeKEsFKFOkynOs3pVbcbq1pxbhk3TRWCGRU5JolI4ohy/7JV1TVbjiDI
 HP/aVnm6NC8of26P40Pg8EdAhajZnHHjA7FrJXsy3cyIGqvg9os4rNkUWmrCfLLsZDHD8FnU
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <081d1cc3-31d3-0144-8bc0-00105f810cdc@roeck-us.net>
Date: Tue, 2 Jun 2020 23:58:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <bac1b68a-3cee-5e60-dd6e-a866b04d2226@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=groeck7@gmail.com; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Jean-Christophe Dubois <jcd@tribudubois.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/2/20 11:37 PM, Philippe Mathieu-Daudé wrote:
> Hi Guenter,
> 
> On 6/3/20 7:24 AM, Guenter Roeck wrote:
>> The Linux kernel's IMX code now uses vendor specific commands.
>> This results in endless warnings when booting the Linux kernel.
>>
>> sdhci-esdhc-imx 2194000.usdhc: esdhc_wait_for_card_clock_gate_off:
>> 	card clock still not gate off in 100us!.
>>
>> Implement support for the vendor specific command implemented in IMX hardware
>> to be able to avoid this warning.
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>  hw/sd/sdhci-internal.h |  5 +++++
>>  hw/sd/sdhci.c          | 18 +++++++++++++++++-
>>  include/hw/sd/sdhci.h  |  5 +++++
>>  3 files changed, 27 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/sd/sdhci-internal.h b/hw/sd/sdhci-internal.h
>> index e7c8a523b5..e8c753d6d1 100644
>> --- a/hw/sd/sdhci-internal.h
>> +++ b/hw/sd/sdhci-internal.h
>> @@ -75,6 +75,7 @@
>>  #define SDHC_CMD_INHIBIT               0x00000001
>>  #define SDHC_DATA_INHIBIT              0x00000002
>>  #define SDHC_DAT_LINE_ACTIVE           0x00000004
>> +#define SDHC_IMX_CLOCK_GATE_OFF        0x00000080
>>  #define SDHC_DOING_WRITE               0x00000100
>>  #define SDHC_DOING_READ                0x00000200
>>  #define SDHC_SPACE_AVAILABLE           0x00000400
>> @@ -289,7 +290,10 @@ extern const VMStateDescription sdhci_vmstate;
>>  
>>  
>>  #define ESDHC_MIX_CTRL                  0x48
>> +
>>  #define ESDHC_VENDOR_SPEC               0xc0
>> +#define ESDHC_IMX_FRC_SDCLK_ON          (1 << 8)
> 
> I searched for the datasheet but couldn't find any, so I suppose it is
> only available under NDA. I can not review much (in particular I wanted
> to check the register sizes), anyway the overall looks OK:
> 

Actually, I only had to register an account to be able to download
the datasheets from NXP. Register width is 32 bit.

> Acked-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
> Also:
> 
> Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
Thanks!

Guenter

>> +
>>  #define ESDHC_DLL_CTRL                  0x60
>>  
>>  #define ESDHC_TUNING_CTRL               0xcc
>> @@ -326,6 +330,7 @@ extern const VMStateDescription sdhci_vmstate;
>>  #define DEFINE_SDHCI_COMMON_PROPERTIES(_state) \
>>      DEFINE_PROP_UINT8("sd-spec-version", _state, sd_spec_version, 2), \
>>      DEFINE_PROP_UINT8("uhs", _state, uhs_mode, UHS_NOT_SUPPORTED), \
>> +    DEFINE_PROP_UINT8("vendor", _state, vendor, SDHCI_VENDOR_NONE), \
>>      \
>>      /* Capabilities registers provide information on supported
>>       * features of this specific host controller implementation */ \
>> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
>> index 1b75d7bab9..eb2be6529e 100644
>> --- a/hw/sd/sdhci.c
>> +++ b/hw/sd/sdhci.c
>> @@ -1569,11 +1569,13 @@ static uint64_t usdhc_read(void *opaque, hwaddr offset, unsigned size)
>>          }
>>          break;
>>  
>> +    case ESDHC_VENDOR_SPEC:
>> +        ret = s->vendor_spec;
>> +        break;
>>      case ESDHC_DLL_CTRL:
>>      case ESDHC_TUNE_CTRL_STATUS:
>>      case ESDHC_UNDOCUMENTED_REG27:
>>      case ESDHC_TUNING_CTRL:
>> -    case ESDHC_VENDOR_SPEC:
>>      case ESDHC_MIX_CTRL:
>>      case ESDHC_WTMK_LVL:
>>          ret = 0;
>> @@ -1596,7 +1598,21 @@ usdhc_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
>>      case ESDHC_UNDOCUMENTED_REG27:
>>      case ESDHC_TUNING_CTRL:
>>      case ESDHC_WTMK_LVL:
>> +        break;
>> +
>>      case ESDHC_VENDOR_SPEC:
>> +        s->vendor_spec = value;
>> +        switch (s->vendor) {
>> +        case SDHCI_VENDOR_IMX:
>> +            if (value & ESDHC_IMX_FRC_SDCLK_ON) {
>> +                s->prnsts &= ~SDHC_IMX_CLOCK_GATE_OFF;
>> +            } else {
>> +                s->prnsts |= SDHC_IMX_CLOCK_GATE_OFF;
>> +            }
>> +            break;
>> +        default:
>> +            break;
>> +        }
>>          break;
>>  
>>      case SDHC_HOSTCTL:
>> diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
>> index c6868c9699..5d9275f3d6 100644
>> --- a/include/hw/sd/sdhci.h
>> +++ b/include/hw/sd/sdhci.h
>> @@ -74,6 +74,7 @@ typedef struct SDHCIState {
>>      uint16_t acmd12errsts; /* Auto CMD12 error status register */
>>      uint16_t hostctl2;     /* Host Control 2 */
>>      uint64_t admasysaddr;  /* ADMA System Address Register */
>> +    uint16_t vendor_spec;  /* Vendor specific register */
>>  
>>      /* Read-only registers */
>>      uint64_t capareg;      /* Capabilities Register */
>> @@ -96,8 +97,12 @@ typedef struct SDHCIState {
>>      uint32_t quirks;
>>      uint8_t sd_spec_version;
>>      uint8_t uhs_mode;
>> +    uint8_t vendor;        /* For vendor specific functionality */
>>  } SDHCIState;
>>  
>> +#define SDHCI_VENDOR_NONE       0
>> +#define SDHCI_VENDOR_IMX        1
>> +
>>  /*
>>   * Controller does not provide transfer-complete interrupt when not
>>   * busy.
>>
> 


