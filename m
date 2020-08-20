Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F8F4C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 05:39:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A0272072D
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 05:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U83qzEeh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A0272072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8dIE-0000dx-8D
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 01:39:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44338)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k8dHQ-0008W8-9n; Thu, 20 Aug 2020 01:38:28 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:52911)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k8dHO-0001Nb-Mw; Thu, 20 Aug 2020 01:38:28 -0400
Received: by mail-wm1-x341.google.com with SMTP id x5so501850wmi.2;
 Wed, 19 Aug 2020 22:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:from:to:cc:references:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=q+HRhC2IgY//z59ulxtUsGfvyqLVF7NdB3ZThEhPJvg=;
 b=U83qzEehyHeQhkVOE7K6L2yOtBukrdtMishumWqB2v9CuUO3rvHKILB/m6gkJDY4sh
 zHUDs32Xy6eC3kr5TPzE36igfpWPwOnc1ALK7ZuowgYz4v5k3N2Iq74vJu7Nq/d++WUu
 7pKWoXLAbaHli3V/Gmd3GKR0rExDoVV1QMbmUWVIg9TxD7m529UWa2XRg10+cQttng7A
 hi0Okdzi4poJunoojE2GIEfZK9zu8hDNnsDT+wUj5wmOQABV8RtnoO567LqoRINpinfQ
 Loq+Po0+riRsznnqzWCm8z0Lt/kQ9KXZM9qq7hFd6pBQhbrV3xW9+XXGq17U3058XW2x
 wncg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:from:to:cc:references:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=q+HRhC2IgY//z59ulxtUsGfvyqLVF7NdB3ZThEhPJvg=;
 b=ow5Nto3A/m5u56tZMHHYfAArgsMrO+GOZmIfeKPePOUv/fEMb0PCYq5k6uS7FWXJ/n
 1E12fQAsJgMpTHj+1DvxfMl2fSVG4q4XFkI8UdWqV4FDhkfx/aVA+OidlzjiSkgRlZAo
 RgTQc64DGBtpNEhR/5Irl+gSjTYHOZt3GLAQjL4Uc9KqE5GAKvu/p0+oLKRVODQ6Fhm6
 70WQAOW2XDfp1tu123rfNkNbPAfnr585M6puyIi+KSEG3b2rh4WVMR5p8SBaqit0VnU1
 MPSTmC5GAjhhruQ+Z75xON3pK4fR7GAlupzQorIGxh8AWVgRvQSZiBVCMKYElsOXjNYX
 w8DA==
X-Gm-Message-State: AOAM533dTSNdCag4NB65l4PI2nv+i0HkFtscobzG2oxNtWAF5eBMKPcL
 af3MWCTaLAfQJIYZFM6uImE=
X-Google-Smtp-Source: ABdhPJyY/2Ypx8Ls6imdU13t9bcaLqXj/lBVjbH3qyAaHEhVKCk5jND4zf/IQcUVZkH+gZ7Ej6Onyg==
X-Received: by 2002:a1c:48c2:: with SMTP id v185mr1655199wma.5.1597901904858; 
 Wed, 19 Aug 2020 22:38:24 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id y2sm2109090wmg.25.2020.08.19.22.38.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2020 22:38:24 -0700 (PDT)
Subject: Re: [PATCH v7 13/13] tests/acceptance: console boot tests for
 quanta-gsj
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Havard Skinnemoen <hskinnemoen@google.com>,
 Peter Maydell <peter.maydell@linaro.org>, Richard Henderson
 <rth@twiddle.net>, Eric Blake <eblake@redhat.com>
References: <20200811004607.2133149-1-hskinnemoen@google.com>
 <20200811004607.2133149-14-hskinnemoen@google.com>
 <64f8cd56-306e-4961-488b-36c666894a54@amsat.org>
 <CAFQmdRbvSKYJ00tE_79Eh+gW_ge8kEco=1gqFtvMcoJGraozdw@mail.gmail.com>
 <CAFQmdRZCk5Rqb1C2TRCEUMaKmF608g2_Or8mLCTSG03nCQ1Ygg@mail.gmail.com>
 <28a30c64-7cc5-4b4f-2be2-b3d3af511cb1@amsat.org>
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
Message-ID: <d5d11bb5-3f66-5a93-5ea7-1cb01edc8d6a@amsat.org>
Date: Thu, 20 Aug 2020 07:38:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <28a30c64-7cc5-4b4f-2be2-b3d3af511cb1@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
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
Cc: IS20 Avi Fishman <Avi.Fishman@nuvoton.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 CS20 KFTing <kfting@nuvoton.com>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Cleber Rosa <crosa@redhat.com>, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/20/20 7:29 AM, Philippe Mathieu-Daudé wrote:
> +Eric / Richard for compiler optimizations.
> 
> On 8/20/20 3:53 AM, Havard Skinnemoen wrote:
>> On Tue, Aug 11, 2020 at 8:26 PM Havard Skinnemoen
>> <hskinnemoen@google.com> wrote:
>>>
>>> On Tue, Aug 11, 2020 at 1:48 AM Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>>> INTERRUPTED: Test interrupted by SIGTERM
>>>> Runner error occurred: Timeout reached
>>>> (240.45 s)
>>>>
>>>> Is that expected?
>>>
>>> I'm not sure why it only happens when running direct kernel boot with
>>> unoptimized qemu, but it seems a little happier if I enable a few more
>>> peripherals that I have queued up (sd, ehci, ohci and rng), though not
>>> enough.
>>>
>>> It still stalls for an awfully long time on "console: Run /init as
>>> init process" though. I'm not sure what it's doing there. With -O2 it
>>> only takes a couple of seconds to move on.
>>
>> So it turns out that the kernel gets _really_ sluggish when skipping
>> the clock initialization normally done by the boot loader.

Hmm IIRC other boards are affected (raspi and orange-pi).

Maybe it is time to define some static inlined boolean function
in "qemu/compiler.h", maybe qemu_build_optimized()? Or not inlined
function but simply expand to true/false:

 /**
  * qemu_build_not_reached()
  *
  * The compiler, during optimization, is expected to prove that a call
  * to this function cannot be reached and remove it.  If the compiler
  * supports QEMU_ERROR, this will be reported at compile time; o therwise
  * this will be reported at link time due to the missing symbol.
  */
 #if defined(__OPTIMIZE__) && !defined(__NO_INLINE__)
 extern void QEMU_NORETURN QEMU_ERROR("code path is reachable")
     qemu_build_not_reached(void);
 #else
 #define qemu_build_not_reached()  g_assert_not_reached()
 #endif
+
+#if defined(__OPTIMIZE__)
+#define qemu_build_optimized() true
+#else
+#define qemu_build_optimized() false
+#endif

>>
>> I changed the reset value of CLKSEL like this:
>>
>> diff --git a/hw/misc/npcm7xx_clk.c b/hw/misc/npcm7xx_clk.c
>> index 21ab4200d1..5e9849410f 100644
>> --- a/hw/misc/npcm7xx_clk.c
>> +++ b/hw/misc/npcm7xx_clk.c
>> @@ -67,7 +67,7 @@ enum NPCM7xxCLKRegisters {
>>   */
>>  static const uint32_t cold_reset_values[NPCM7XX_CLK_NR_REGS] = {
>>      [NPCM7XX_CLK_CLKEN1]        = 0xffffffff,
>> -    [NPCM7XX_CLK_CLKSEL]        = 0x004aaaaa,
>> +    [NPCM7XX_CLK_CLKSEL]        = 0x004aaba9,
>>      [NPCM7XX_CLK_CLKDIV1]       = 0x5413f855,
>>      [NPCM7XX_CLK_PLLCON0]       = 0x00222101 | PLLCON_LOKI,
>>      [NPCM7XX_CLK_PLLCON1]       = 0x00202101 | PLLCON_LOKI,
>>
>> which switches the CPU core and UART to run from PLL2 instead of
>> CLKREF (25 MHz).
>>
>> With this change, the test passes without optimization:
>>
>>  (02/19) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_quanta_gsj_initrd:
>> PASS (39.62 s)
>>
>> It doesn't look like this change hurts booting from the bootrom (IIUC
>> the nuvoton bootblock overwrites CLKSEL anyway), but it's not super
>> clean.
>>
>> Perhaps I should make it conditional on kernel_filename being set? Or
>> would it be better to provide a write_board_setup hook for this?
> 
> QEMU prefers to avoid ifdef'ry at all cost. However I find this
> approach acceptable (anyway up to the maintainer):
> 
> +static void npcm7xx_clk_cold_reset_fixup(NPCM7xxCLKState *s)
> +{
> +#ifndef __OPTIMIZE__
> +    /*
> +     * When built without optimization, ...
> +     * so run CPU core and UART from PLL2 instead of CLKREF.
> +     */
> +    s->regs[NPCM7XX_CLK_CLKSEL] |= 0x103,
> +#endif
> +}
> 
>  static void npcm7xx_clk_enter_reset(Object *obj, ResetType type)
>  {
>      NPCM7xxCLKState *s = NPCM7XX_CLK(obj);
> 
>      QEMU_BUILD_BUG_ON(sizeof(s->regs) != sizeof(cold_reset_values));
> 
>      switch (type) {
>      case RESET_TYPE_COLD:
>          memcpy(s->regs, cold_reset_values, sizeof(cold_reset_values));
> +        npcm7xx_clk_cold_reset_fixup(s);
>          s->ref_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>          return;
>      }
>      ...
> 
> Regards,
> 
> Phil.
> 

