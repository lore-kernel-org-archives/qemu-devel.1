Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976E9C4363C
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 15:38:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 167A12074B
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 15:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJSgFPzd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 167A12074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kON97-0007Vm-0i
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 11:38:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kON5G-00030C-MY; Fri, 02 Oct 2020 11:34:58 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35851)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kON5E-00034O-Ih; Fri, 02 Oct 2020 11:34:58 -0400
Received: by mail-wm1-x342.google.com with SMTP id e2so2198663wme.1;
 Fri, 02 Oct 2020 08:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:from:to:cc:references:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/d3CzUA3lypjw4nnz152qE/pDG8fVawaHwwuebdJzYE=;
 b=WJSgFPzd7R4C6UjRhDUyxenBWvuxSpsMepkkhewHxaHXplvVTNbYMyW2Nk4uYHpa7Y
 YkonUtvYEW572FgXl/J04187HQ+ijUFdQpJVvG54lQMpGzHVOWPjpFsT9C+DMdE1rfbD
 y2N9zLRs2LP3Ge3jGbaxwLkM9+y7+03LB35MevN6LyF4v4frLkmn7feOLAFGtIJfxPLg
 /SokdhE9NZvs7Xrq5k20dZKEV0U+YCULg9kG1YR0Dl+PDwugrAg6Jvp0p+3jitH2pzDq
 3HeBfCB6f/ZTVXwsKKxMVs4Y7gNQPvVEl+SMWG824v2/QLt6Ya0xg8X8QhnpKHBcg4Au
 v9VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:from:to:cc:references:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=/d3CzUA3lypjw4nnz152qE/pDG8fVawaHwwuebdJzYE=;
 b=TAR0B4CcGe4YNlK6pu9u+zzoB7gWWlzcH3e6nEd5OjOTKouJvQT7BueWi62GyeDmeS
 Zas7NbDdKHgf/jEYG9GvYQ15WTctUkziSscl7/EVNWn+BrmOLmv7Wnpi1pjudrVLHgH6
 AnrULCud2kG1P48F2cniZqj4q0XMJquXMu+YCcAmDqUUXa9wRGY4lQ7/8W8ieftwh/Re
 G/KD+W2waDtZi7GWzanTQvFwmGJUJAxk4X9YAEqCXoGPyh9LsdLivRcUTOooxD8PIcdS
 G85fxZdzuIUFTAdzzlhWV2YWzVk0jksRtLqvjZyJ5D4oEM83nxECd8C/9Cr4ISrY5mtF
 JweQ==
X-Gm-Message-State: AOAM5332dzuu1kjhqV3m88FsloRBfSigL41x+NXi0luBogexmtrkq75H
 aISsCg41dpXTfNKxsZdKyp4=
X-Google-Smtp-Source: ABdhPJxLHrQVHOj42aYiGHVIzmjkw0laxAYNf8zLg6bYYMZHSbQcvjhQ+Piokihu8dK2lx6isxQqjg==
X-Received: by 2002:a1c:f715:: with SMTP id v21mr3777956wmh.117.1601652894089; 
 Fri, 02 Oct 2020 08:34:54 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id d6sm2215468wrq.67.2020.10.02.08.34.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Oct 2020 08:34:52 -0700 (PDT)
Subject: Re: [PATCH 09/14] hw/misc/bcm2835_cprman: add a clock mux skeleton
 implementation
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Luc Michel <luc@lmichel.fr>, qemu-devel@nongnu.org
References: <20200925101731.2159827-1-luc@lmichel.fr>
 <20200925101731.2159827-10-luc@lmichel.fr>
 <2a18bb94-1e6c-d853-3e6e-f6874b617a2b@amsat.org>
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
Message-ID: <d758d149-bca5-e52f-8d1f-65caf742a136@amsat.org>
Date: Fri, 2 Oct 2020 17:34:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <2a18bb94-1e6c-d853-3e6e-f6874b617a2b@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.256,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Andrew Baumann <Andrew.Baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/2/20 4:42 PM, Philippe Mathieu-Daudé wrote:
> On 9/25/20 12:17 PM, Luc Michel wrote:
>> The clock multiplexers are the last clock stage in the cprman. Each mux
>> outputs one clock signal that goes out of the cprman to the SoC
>> peripherals.
>>
>> Each mux has at most 10 sources. The sources 0 to 3 are common to all
>> muxes. They are:
>>    0. ground (no clock signal)
>>    1. the main oscillator (xosc)
>>    2. "test debug 0" clock
>>    3. "test debug 1" clock
>>
>> Test debug 0 and 1 are actual clock muxes that can be used as sources to
>> other muxes (for debug purpose).
>>
>> Sources 4 to 9 are mux specific and can be unpopulated (grounded). Those
>> sources are fed by the PLL channels outputs.
>>
>> One corner case exists for DSI0E and DSI0P muxes. They have their source
>> number 4 connected to an intermediate multiplexer that can select
>> between PLLA-DSI0 and PLLD-DSI0 channel. This multiplexer is called
>> DSI0HSCK and is not a clock mux as such. It is really a simple mux from
>> the hardware point of view (see https://elinux.org/The_Undocumented_Pi).
>> This mux is not implemented in this commit.
>>
>> Note that there is some muxes for which sources are unknown (because of
>> a lack of documentation). For those cases all the sources are connected
>> to ground in this implementation.
>>
>> Each clock mux output is exported by the cprman at the qdev level,
>> adding the suffix '-out' to the mux name to form the output clock name.
>> (E.g. the 'uart' mux sees its output exported as 'uart-out' at the
>> cprman level.)
>>
>> Signed-off-by: Luc Michel <luc@lmichel.fr>
>> ---
[...]
>>  struct BCM2835CprmanState {
>>      /*< private >*/
>>      SysBusDevice parent_obj;
>>  
>>      /*< public >*/
>>      MemoryRegion iomem;
>>  
>>      CprmanPLLState plls[CPRMAN_NUM_PLL];
>>      CprmanPLLChannelState channels[CPRMAN_NUM_PLL_CHANNEL];
>> +    CprmanClockMuxState clock_muxes[CPRMAN_NUM_CLOCK_MUX];
>>  
>>      uint32_t regs[CPRMAN_NUM_REGS];
>>      uint32_t xosc_freq;
>>  
>>      Clock *xosc;
>> +    Clock *gnd;
> 
> This one seems to belong to MachineState in "hw/boards.h".

Although it might be easier to have a singleton in hw/core/clock.c...

