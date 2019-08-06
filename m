Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4698C31E40
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 10:58:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBA81206A2
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 10:58:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBA81206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huxAQ-0000wY-3L
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 06:58:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47464)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sgarzare@redhat.com>) id 1huxA2-0000PX-Hu
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 06:57:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1huxA1-0006JZ-KM
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 06:57:46 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34194)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1huxA1-0006J3-EQ
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 06:57:45 -0400
Received: by mail-wr1-f66.google.com with SMTP id 31so87473197wrm.1
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2019 03:57:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Bm++tRfJLR6gx6xLf4+qVNoCTr6y24Gn+Rxn9bUAAMg=;
 b=uKpNdlICbvX51bU5HPMfODjAlPd/VTCtYO0H0W4ZAKORVvBFApELYpDN7+ze103BZI
 HsZG2xPCdybM4gTgFiXkJUt+6d2ZsMhLGbuXUySPW80sKs5Y5eafeDvaW2lgiWyOmjzz
 j3Qtig/H+coVjta4u4haISLfr90m8bOKMtbHP1XhqTdkF0+BtMj/0Xko1QwmnjTS/yJX
 1CLfUq7t7cxAPnrcpfGUIyOfIVYrP6P/lTirCKtpt4V63tufwuhRsMp01Bqb4fweD/2i
 z84w5J4zwMVyFGwdTvTvMUtXTliNS+qeQaP9ddVvspPlXLii4/mkQO8OUvBle7fBFG9I
 fLtw==
X-Gm-Message-State: APjAAAWz2PSO2Evq2nMs1bys0TjX1AYkmGYlC7M+LdzQRwGVMMPaBQkc
 3vIPht0gSYeB/iN8rlW53bY/gA==
X-Google-Smtp-Source: APXvYqxEJL31VETj+SDiuIHDewxWcXaqxn2XWezfxTnDNel9pafaK6oo2dxcrcO8Yb8dOoitg15PRw==
X-Received: by 2002:adf:afe7:: with SMTP id y39mr4040045wrd.350.1565089062785; 
 Tue, 06 Aug 2019 03:57:42 -0700 (PDT)
Received: from steredhat (host122-201-dynamic.13-79-r.retail.telecomitalia.it.
 [79.13.201.122])
 by smtp.gmail.com with ESMTPSA id l9sm68223969wmh.36.2019.08.06.03.57.41
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 06 Aug 2019 03:57:42 -0700 (PDT)
Date: Tue, 6 Aug 2019 12:57:39 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bin Meng <bmeng.cn@gmail.com>
Message-ID: <20190806105739.ypoa545l4vigsscg@steredhat>
References: <1565020374-23888-1-git-send-email-bmeng.cn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565020374-23888-1-git-send-email-bmeng.cn@gmail.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH] hw: net: cadence_gem: Fix build errors in
 DB_PRINT()
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
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jason Wang <jasowang@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 05, 2019 at 08:52:54AM -0700, Bin Meng wrote:
> When CADENCE_GEM_ERR_DEBUG is turned on, there are several
> compilation errors in DB_PRINT(). Fix them.
> 
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> ---
> 
>  hw/net/cadence_gem.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
> index d412085..7516e8f 100644
> --- a/hw/net/cadence_gem.c
> +++ b/hw/net/cadence_gem.c
> @@ -983,8 +983,9 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
>              return -1;
>          }
>  
> -        DB_PRINT("copy %d bytes to 0x%x\n", MIN(bytes_to_copy, rxbufsize),
> -                rx_desc_get_buffer(s->rx_desc[q]));
> +        DB_PRINT("copy %d bytes to " TARGET_FMT_plx "\n",
> +                 MIN(bytes_to_copy, rxbufsize),
> +                 rx_desc_get_buffer(s, s->rx_desc[q]));
>  
>          /* Copy packet data to emulated DMA buffer */
>          address_space_write(&s->dma_as, rx_desc_get_buffer(s, s->rx_desc[q]) +
> @@ -1157,7 +1158,7 @@ static void gem_transmit(CadenceGEMState *s)
>              if (tx_desc_get_length(desc) > sizeof(tx_packet) -
>                                                 (p - tx_packet)) {
>                  DB_PRINT("TX descriptor @ 0x%x too large: size 0x%x space " \
> -                         "0x%x\n", (unsigned)packet_desc_addr,
> +                         "0x%lx\n", (unsigned)packet_desc_addr,

What about using 'z' modifier? I mean "0x%zx" to print sizeof(..).

Thanks,
Stefano

