Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00879C4363C
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 19:48:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 667C82193E
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 19:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="ZA5GmhWw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 667C82193E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKRo0-0004gE-Bk
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 15:48:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51746)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc.michel@greensocs.com>)
 id 1kKRij-0002sb-Ns; Mon, 21 Sep 2020 15:43:29 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:40732)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc.michel@greensocs.com>)
 id 1kKRii-0008RW-2I; Mon, 21 Sep 2020 15:43:29 -0400
Received: from [172.17.10.14] (unknown [172.17.10.14])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 86C2121CBD;
 Mon, 21 Sep 2020 19:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1600717405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YxJBix3d7PhTD31XVGO0NuBDtpjiRRtoggn07D34y1M=;
 b=ZA5GmhWwsmmbZe6fei/MKCg8TO6o50eRdwAr4wb2SXt95ZjMlnQU8pNx/vo+nP/ntAntPH
 AngUsO/1HMIuCwvsxMGDzKFTuQe7idTtI36WuK5fxRvMNS7TeOyfeH/U4bpYNtO8RKcJaY
 TZakpW0+gqaIZvtfH8e1yQDiihdwpZM=
Subject: Re: [PATCH v2 3/5] hw/timer/bcm2835: Rename variable holding
 CTRL_STATUS register
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200921035257.434532-1-f4bug@amsat.org>
 <20200921035257.434532-4-f4bug@amsat.org>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <e1835d9c-4380-6f5c-23be-5ddbe1bf8077@greensocs.com>
Date: Mon, 21 Sep 2020 21:44:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200921035257.434532-4-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=5.135.226.135;
 envelope-from=luc.michel@greensocs.com; helo=beetle.greensocs.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 15:38:48
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Paul Zimmerman <pauldzim@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/21/20 5:52 AM, Philippe Mathieu-Daudé wrote:
> The variable holding the CTRL_STATUS register is misnamed
> 'status'. Rename it 'ctrl_status' to make it more obvious
> this register is also used to control the peripheral.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Reviewed-by: Luc Michel <luc.michel@greensocs.com>

> ---
>   include/hw/timer/bcm2835_systmr.h | 2 +-
>   hw/timer/bcm2835_systmr.c         | 8 ++++----
>   2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/hw/timer/bcm2835_systmr.h b/include/hw/timer/bcm2835_systmr.h
> index 11272837a6b..e0db9e9e12b 100644
> --- a/include/hw/timer/bcm2835_systmr.h
> +++ b/include/hw/timer/bcm2835_systmr.h
> @@ -29,7 +29,7 @@ struct BCM2835SystemTimerState {
>       qemu_irq irq;
>   
>       struct {
> -        uint32_t status;
> +        uint32_t ctrl_status;
>           uint32_t compare[BCM2835_SYSTIMER_COUNT];
>       } reg;
>   };
> diff --git a/hw/timer/bcm2835_systmr.c b/hw/timer/bcm2835_systmr.c
> index ff8c5536610..b234e83824f 100644
> --- a/hw/timer/bcm2835_systmr.c
> +++ b/hw/timer/bcm2835_systmr.c
> @@ -30,7 +30,7 @@ REG32(COMPARE3,     0x18)
>   
>   static void bcm2835_systmr_update_irq(BCM2835SystemTimerState *s)
>   {
> -    bool enable = !!s->reg.status;
> +    bool enable = !!s->reg.ctrl_status;
>   
>       trace_bcm2835_systmr_irq(enable);
>       qemu_set_irq(s->irq, enable);
> @@ -52,7 +52,7 @@ static uint64_t bcm2835_systmr_read(void *opaque, hwaddr offset,
>   
>       switch (offset) {
>       case A_CTRL_STATUS:
> -        r = s->reg.status;
> +        r = s->reg.ctrl_status;
>           break;
>       case A_COMPARE0 ... A_COMPARE3:
>           r = s->reg.compare[(offset - A_COMPARE0) >> 2];
> @@ -82,7 +82,7 @@ static void bcm2835_systmr_write(void *opaque, hwaddr offset,
>       trace_bcm2835_systmr_write(offset, value);
>       switch (offset) {
>       case A_CTRL_STATUS:
> -        s->reg.status &= ~value; /* Ack */
> +        s->reg.ctrl_status &= ~value; /* Ack */
>           bcm2835_systmr_update_irq(s);
>           break;
>       case A_COMPARE0 ... A_COMPARE3:
> @@ -133,7 +133,7 @@ static const VMStateDescription bcm2835_systmr_vmstate = {
>       .version_id = 1,
>       .minimum_version_id = 1,
>       .fields = (VMStateField[]) {
> -        VMSTATE_UINT32(reg.status, BCM2835SystemTimerState),
> +        VMSTATE_UINT32(reg.ctrl_status, BCM2835SystemTimerState),
>           VMSTATE_UINT32_ARRAY(reg.compare, BCM2835SystemTimerState,
>                                BCM2835_SYSTIMER_COUNT),
>           VMSTATE_END_OF_LIST()
> 

