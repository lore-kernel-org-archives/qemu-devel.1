Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C14C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 21:53:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FEC122400
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 21:53:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FEC122400
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUd5U-0002WA-Ca
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 17:53:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49398)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kUd4u-00026t-Nj
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 17:52:28 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:34866
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kUd4r-0005YP-8P
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 17:52:28 -0400
Received: from host86-148-246-80.range86-148.btcentralplus.com
 ([86.148.246.80] helo=[192.168.1.65])
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kUd4q-0002IO-Ox; Mon, 19 Oct 2020 22:52:28 +0100
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20201012170950.3491912-1-f4bug@amsat.org>
 <20201012170950.3491912-5-f4bug@amsat.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <6e7036fd-da9c-c7b9-b606-91414bb92e1e@ilande.co.uk>
Date: Mon, 19 Oct 2020 22:52:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201012170950.3491912-5-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.148.246.80
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 4/6] hw/pci-host/sabre: Report unimplemented accesses via
 UNIMP log_mask
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk;
 helo=mail.default.ilande.uk0.bigv.io
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/10/2020 18:09, Philippe Mathieu-Daudé wrote:

> Report unimplemented register accesses using qemu_log_mask(UNIMP).
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>   hw/pci-host/sabre.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/pci-host/sabre.c b/hw/pci-host/sabre.c
> index 3645bc962cb..4412e23131c 100644
> --- a/hw/pci-host/sabre.c
> +++ b/hw/pci-host/sabre.c
> @@ -121,8 +121,10 @@ static void sabre_config_write(void *opaque, hwaddr addr,
>       trace_sabre_config_write(addr, val);
>   
>       switch (addr) {
> -    case 0x30 ... 0x4f: /* DMA error registers */
> -        /* XXX: not implemented yet */
> +    case  0x30 ...  0x4f: /* DMA error registers */
> +        qemu_log_mask(LOG_UNIMP,
> +                      "%s: Register 0x%02" HWADDR_PRIX " not implemented\n",
> +                      __func__, addr);
>           break;
>       case 0xc00 ... 0xc3f: /* PCI interrupt control */
>           if (addr & 4) {
> @@ -198,8 +200,10 @@ static uint64_t sabre_config_read(void *opaque,
>       uint32_t val = 0;
>   
>       switch (addr) {
> -    case 0x30 ... 0x4f: /* DMA error registers */
> -        /* XXX: not implemented yet */
> +    case  0x30 ...  0x4f: /* DMA error registers */
> +        qemu_log_mask(LOG_UNIMP,
> +                      "%s: Register 0x%02" HWADDR_PRIX " not implemented\n",
> +                      __func__, addr);
>           break;
>       case 0xc00 ... 0xc3f: /* PCI interrupt control */
>           if (addr & 4) {

It seems as if there are quite a few other registers that haven't been implemented 
here which aren't mentioned in the comments. My preference would be to rework this 
patch so that the comments for the unimplemented registers are all at the end of the 
switch() with the fallthrough to default, and then update patch 6 to use LOG_UNIMP so 
everything is logged in one place.


ATB,

Mark.

