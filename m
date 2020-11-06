Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C46D9C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 18:22:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBB2221D46
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 18:22:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBB2221D46
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmp.felk.cvut.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb6Nl-0006eb-Pp
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 13:22:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53164)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pisa@cmp.felk.cvut.cz>)
 id 1kb6Kl-0004bT-7s
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 13:19:35 -0500
Received: from relay.felk.cvut.cz ([2001:718:2:1611:0:1:0:70]:22447)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pisa@cmp.felk.cvut.cz>) id 1kb6Kj-00042a-DD
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 13:19:34 -0500
Received: from cmp.felk.cvut.cz (haar.felk.cvut.cz [147.32.84.19])
 by relay.felk.cvut.cz (8.15.2/8.15.2) with ESMTP id 0A6IIY5k048015;
 Fri, 6 Nov 2020 19:18:34 +0100 (CET)
 (envelope-from pisa@cmp.felk.cvut.cz)
Received: from haar.felk.cvut.cz (localhost [127.0.0.1])
 by cmp.felk.cvut.cz (8.14.0/8.12.3/SuSE Linux 0.6) with ESMTP id
 0A6IIY3B023691; Fri, 6 Nov 2020 19:18:34 +0100
Received: (from pisa@localhost)
 by haar.felk.cvut.cz (8.14.0/8.13.7/Submit) id 0A6IIXkp023689;
 Fri, 6 Nov 2020 19:18:33 +0100
X-Authentication-Warning: haar.felk.cvut.cz: pisa set sender to
 pisa@cmp.felk.cvut.cz using -f
From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH for-5.2 4/4] hw/net/ctucan_core: Use stl_le_p to write to
 tx_buffers
Date: Fri, 6 Nov 2020 19:18:33 +0100
User-Agent: KMail/1.9.10
References: <20201106171153.32673-1-peter.maydell@linaro.org>
 <20201106171153.32673-5-peter.maydell@linaro.org>
In-Reply-To: <20201106171153.32673-5-peter.maydell@linaro.org>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202011061918.33313.pisa@cmp.felk.cvut.cz>
X-FELK-MailScanner-Information: 
X-MailScanner-ID: 0A6IIY5k048015
X-FELK-MailScanner: Found to be clean
X-FELK-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
 score=-0.223, required 6, BAYES_00 -0.50, KHOP_HELO_FCRDNS 0.28,
 NICE_REPLY_A -0.00, SPF_HELO_NONE 0.00, SPF_NONE 0.00)
X-FELK-MailScanner-From: pisa@cmp.felk.cvut.cz
X-FELK-MailScanner-Watermark: 1605291515.27437@eQrfnyjRr4vEf7izM6uabA
Received-SPF: none client-ip=2001:718:2:1611:0:1:0:70;
 envelope-from=pisa@cmp.felk.cvut.cz; helo=relay.felk.cvut.cz
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/06 12:48:26
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Jason Wang <jasowang@redhat.com>, Vikram Garhwal <fnu.vikram@xilinx.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On Friday 06 of November 2020 18:11:53 Peter Maydell wrote:
> Instead of casting an address within a uint8_t array to a
> uint32_t*, use stl_le_p(). This handles possibly misaligned
> addresses which would otherwise crash on some hosts.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/net/can/ctucan_core.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/hw/net/can/ctucan_core.c b/hw/net/can/ctucan_core.c
> index f2ce978e5ec..e66526efa83 100644
> --- a/hw/net/can/ctucan_core.c
> +++ b/hw/net/can/ctucan_core.c
> @@ -305,8 +305,7 @@ void ctucan_mem_write(CtuCanCoreState *s, hwaddr addr,
> uint64_t val, addr %= CTUCAN_CORE_TXBUFF_SPAN;
>          assert(buff_num < CTUCAN_CORE_TXBUF_NUM);
>          if (addr < sizeof(s->tx_buffer[buff_num].data)) {
> -            uint32_t *bufp = (uint32_t *)(s->tx_buffer[buff_num].data +
> addr); -            *bufp = cpu_to_le32(val);
> +            stl_le_p(s->tx_buffer[buff_num].data + addr, val);
>          }
>      } else {
>          switch (addr & ~3) {

Acked-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>

even that I do not like stl_le_p name, because it differs from the Linux
kernel one. cpu_to_le32 matches. The pointer variant is cpu_to_le32p
on Linux kernel side, I think. stl is strange name and l for long
is problematic as well, if it is st32_le_p or st_le32_p I would recognize
that much easier.

Best wishes,

Pavel Pisa

