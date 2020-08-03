Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99199C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 15:13:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EBB620775
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 15:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7Zk8rBx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EBB620775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2c9b-0001Ed-Jy
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 11:13:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k2c8x-0000UF-K4; Mon, 03 Aug 2020 11:12:51 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55511)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k2c8v-0002pr-RH; Mon, 03 Aug 2020 11:12:51 -0400
Received: by mail-wm1-x343.google.com with SMTP id 9so14619092wmj.5;
 Mon, 03 Aug 2020 08:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=1e3lSfJs56vgQa17PMAI9CB1G1Wmu+nSqZ4gwDK4N6E=;
 b=i7Zk8rBxrmIqw1zybp2tpTqaqnu/nlI6Rq+pVnJ5IEj8fvPPTYTeMfuwnWHeea+4Sg
 crF3S1+qv8oTqnV2WfTTUSqnO1HgZUcsWJkPBitPvHRw6YOBkOAYAjYMR3eQCze+VZSD
 30z9517WxsZCgG6XBxuGArjs7kB48BL10o4soRbM2FweoOn6KZpgl1l99fEGHTL+u8Gr
 G2jkO9jJf4wOWwKW4l3sU7gCqMeoQFMFQwFcTeSZdH2PqcNxjRK0qKsE6T+YZLkhwiNi
 s5BhdIPABPFkycfn2myLye49nL+3osenLc/3qWKv/uhzagylF2vYFkC141aVIrUlEggK
 VWOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1e3lSfJs56vgQa17PMAI9CB1G1Wmu+nSqZ4gwDK4N6E=;
 b=r9D7EXQN5Tm35clociTUq8EMrsV58mXzMf7bciymIfAmk1nobUMPOcERkUS1FxBEbQ
 izP8Ds5w1hHXgwlPR4p87UpJA5hkB29AubVzs1hqShtE9QW7xmpRCVwTbhJ5iNcOlYQ8
 jiWmyjxnBVceEBgw9tzW3cFK/jxpdZhVwg5UXuTmKxF33Y0qro59sk6+kWeg5cgz2L/9
 GqiasHBGwNdTlh0LwzG9UmU5EnqE+KBTL1qurbsR+QFe7ePjigP0ArGqZjW9Z067Yp76
 f3VXF8Ey0RbDkCyD0yF1zi6dfs6LnhsptN15K+7cc42a3Yjcyb9n0THP1z/uDYr9LXA4
 jZhA==
X-Gm-Message-State: AOAM5331g2FNeiKY3rrkILd4dfbRnbgtmb6oJNqzhj8rcEzACl/kO1MA
 Wm5mR0HutmIiWqKXFygMEDo=
X-Google-Smtp-Source: ABdhPJxJ7vj19JHs7/3Zi9AaatfZUyVXpLJAT1/46hqAjBJF/+mEfcsgGoOSPbSrIQoJrl3cZNiFMg==
X-Received: by 2002:a1c:6a18:: with SMTP id f24mr428227wmc.94.1596467567921;
 Mon, 03 Aug 2020 08:12:47 -0700 (PDT)
Received: from [192.168.1.43] (214.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.214])
 by smtp.gmail.com with ESMTPSA id t14sm28498625wrg.38.2020.08.03.08.12.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2020 08:12:47 -0700 (PDT)
Subject: Re: [PATCH for-5.1] hw/timer/imx_epit: Avoid assertion when CR.SWR is
 written
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200727154550.3409-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <16de518e-d36f-2b8d-8598-985275524897@amsat.org>
Date: Mon, 3 Aug 2020 17:12:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200727154550.3409-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
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
Cc: Peter Chubb <peter.chubb@nicta.com.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/27/20 5:45 PM, Peter Maydell wrote:
> The imx_epit device has a software-controllable reset triggered by
> setting the SWR bit in the CR register. An error in commit cc2722ec83ad9
> means that we will end up assert()ing if the guest does this, because
> the code in imx_epit_write() starts ptimer transactions, and then
> imx_epit_reset() also starts ptimre transactions, triggering
> "ptimer_transaction_begin: Assertion `!s->in_transaction' failed".
> 
> The cleanest way to avoid this double-transaction is to move the
> start-transaction for the CR write handling down below the check of
> the SWR bit.
> 
> Fixes: https://bugs.launchpad.net/qemu/+bug/1880424

Thanks for looking at this.

> Fixes: cc2722ec83ad944505fe
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I don't have a test image for KZM so this is the minimal
> obviously-safe change. I'm pretty sure that actually we could
> add a "break" after the imx_epit_reset() call because all of
> the work done by the following code is duplicating the ptimer
> setup done by the reset function. But I'm not really happy making
> that change without a test image...

Agreed. I'd add a comment in the code to not forget about this...

> ---
>  hw/timer/imx_epit.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/timer/imx_epit.c b/hw/timer/imx_epit.c
> index baf6338e1a6..4f51e6e12da 100644
> --- a/hw/timer/imx_epit.c
> +++ b/hw/timer/imx_epit.c
> @@ -199,15 +199,18 @@ static void imx_epit_write(void *opaque, hwaddr offset, uint64_t value,
>  
>      switch (offset >> 2) {
>      case 0: /* CR */
> -        ptimer_transaction_begin(s->timer_cmp);
> -        ptimer_transaction_begin(s->timer_reload);
>  
>          oldcr = s->cr;
>          s->cr = value & 0x03ffffff;
>          if (s->cr & CR_SWR) {
>              /* handle the reset */
>              imx_epit_reset(DEVICE(s));

... such:
               /* break; ??? */

Anyway:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> -        } else {
> +        }
> +
> +        ptimer_transaction_begin(s->timer_cmp);
> +        ptimer_transaction_begin(s->timer_reload);
> +
> +        if (!(s->cr & CR_SWR)) {
>              imx_epit_set_freq(s);
>          }
>  
> 


