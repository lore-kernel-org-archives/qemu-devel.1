Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1880C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 18:15:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D2CE205CA
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 18:15:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D2CE205CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmp.felk.cvut.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb6H2-0002cw-FB
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 13:15:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51330)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pisa@cmp.felk.cvut.cz>)
 id 1kb6Dq-0008Cs-Om
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 13:12:26 -0500
Received: from relay.felk.cvut.cz ([2001:718:2:1611:0:1:0:70]:45241)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pisa@cmp.felk.cvut.cz>) id 1kb6Do-000379-8z
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 13:12:26 -0500
Received: from cmp.felk.cvut.cz (haar.felk.cvut.cz [147.32.84.19])
 by relay.felk.cvut.cz (8.15.2/8.15.2) with ESMTP id 0A6IBOX2047755;
 Fri, 6 Nov 2020 19:11:24 +0100 (CET)
 (envelope-from pisa@cmp.felk.cvut.cz)
Received: from haar.felk.cvut.cz (localhost [127.0.0.1])
 by cmp.felk.cvut.cz (8.14.0/8.12.3/SuSE Linux 0.6) with ESMTP id
 0A6IBOia022987; Fri, 6 Nov 2020 19:11:24 +0100
Received: (from pisa@localhost)
 by haar.felk.cvut.cz (8.14.0/8.13.7/Submit) id 0A6IBOht022986;
 Fri, 6 Nov 2020 19:11:24 +0100
X-Authentication-Warning: haar.felk.cvut.cz: pisa set sender to
 pisa@cmp.felk.cvut.cz using -f
From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH for-5.2 2/4] hw/net/can/ctucan: Avoid unused value in
 ctucan_send_ready_buffers()
Date: Fri, 6 Nov 2020 19:11:23 +0100
User-Agent: KMail/1.9.10
References: <20201106171153.32673-1-peter.maydell@linaro.org>
 <20201106171153.32673-3-peter.maydell@linaro.org>
In-Reply-To: <20201106171153.32673-3-peter.maydell@linaro.org>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202011061911.23866.pisa@cmp.felk.cvut.cz>
X-FELK-MailScanner-Information: 
X-MailScanner-ID: 0A6IBOX2047755
X-FELK-MailScanner: Found to be clean
X-FELK-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
 score=-0.223, required 6, BAYES_00 -0.50, KHOP_HELO_FCRDNS 0.28,
 NICE_REPLY_A -0.00, SPF_HELO_NONE 0.00, SPF_NONE 0.00)
X-FELK-MailScanner-From: pisa@cmp.felk.cvut.cz
X-FELK-MailScanner-Watermark: 1605291085.406@m6j23NmAYRI2I9vA9n7OZQ
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
 Ondrej Ille <ondrej.ille@gmail.com>, qemu-devel@nongnu.org,
 Jan =?utf-8?q?Charv=C3=A1t?= <charvj10@fel.cvut.cz>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello Peter,

this one is a little problematic. I understand that you want
to have clean code and no warnings reports from coverity.

On Friday 06 of November 2020 18:11:51 Peter Maydell wrote:
> Coverity points out that in ctucan_send_ready_buffers() we
> set buff_st_mask = 0xf << (i * 4) inside the loop, but then
> we never use it before overwriting it later.
>
> The only thing we use the mask for is as part of the code that is
> inserting the new buff_st field into tx_status.  That is more
> comprehensibly written using deposit32(), so do that and drop the
> mask variable entirely.
>
> We also update the buff_st local variable at multiple points
> during this function, but nothing can ever see these
> intermediate values, so just drop those, write the final
> TXT_TOK as a fixed constant value, and collapse the only
> remaining set/use of buff_st down into an extract32().
>
> Fixes: Coverity CID 1432869
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/net/can/ctucan_core.c | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)
>
> diff --git a/hw/net/can/ctucan_core.c b/hw/net/can/ctucan_core.c
> index ea09bf71a0c..f2ce978e5ec 100644
> --- a/hw/net/can/ctucan_core.c
> +++ b/hw/net/can/ctucan_core.c
> @@ -240,8 +240,6 @@ static void ctucan_send_ready_buffers(CtuCanCoreState
> *s) uint8_t *pf;
>      int buff2tx_idx;
>      uint32_t tx_prio_max;
> -    unsigned int buff_st;
> -    uint32_t buff_st_mask;
>
>      if (!s->mode_settings.s.ena) {
>          return;
> @@ -256,10 +254,7 @@ static void ctucan_send_ready_buffers(CtuCanCoreState
> *s) for (i = 0; i < CTUCAN_CORE_TXBUF_NUM; i++) {
>              uint32_t prio;
>
> -            buff_st_mask = 0xf << (i * 4);
> -            buff_st = (s->tx_status.u32 >> (i * 4)) & 0xf;
> -
> -            if (buff_st != TXT_RDY) {
> +            if (extract32(s->tx_status.u32, i * 4, 4) != TXT_RDY) {
>                  continue;
>              }

It is right replacement. Initially buff_st kept location of bits of the buffer 
found to be processed later. But after priorization of Tx this cannot
be used without recompute.

>              prio = (s->tx_priority.u32 >> (i * 4)) & 0x7;
> @@ -271,10 +266,7 @@ static void ctucan_send_ready_buffers(CtuCanCoreState
> *s) if (buff2tx_idx == -1) {
>              break;
>          }
> -        buff_st_mask = 0xf << (buff2tx_idx * 4);
> -        buff_st = (s->tx_status.u32 >> (buff2tx_idx * 4)) & 0xf;

There I would kept extracted state in the variable. Actual model is really
simplified to real hardware. Tx succeeds in zero time.

>          int_stat.u32 = 0;
> -        buff_st = TXT_RDY;

This is why the TXT_RDY state immediately changes to TXT_TOK. It works well
for actual simple CAN subsystem implementation. But if we want to implement
priorization of messages on emulated bus and even simulate real bus latency
by delay to state change and interrut delivery, then we need to proceed
through TXT_RDY state. If it is a problem for release, that your want to have
coverity clean source tree, then please left the line as a comment there
or use some trick with
           (void)buff_st;

Or if you prefer, use

  +        s->tx_status.u32 = deposit32(s->tx_status.u32,
  +                                     buff2tx_idx * 4, 4, TXT_RDY);

if it silent the coverity.

>          pf = s->tx_buffer[buff2tx_idx].data;
>          ctucan_buff2frame(pf, &frame);
>          s->status.s.idle = 0;
> @@ -283,12 +275,11 @@ static void ctucan_send_ready_buffers(CtuCanCoreState
> *s) s->status.s.idle = 1;
>          s->status.s.txs = 0;
>          s->tx_fr_ctr.s.tx_fr_ctr_val++;
> -        buff_st = TXT_TOK;
>          int_stat.s.txi = 1;
>          int_stat.s.txbhci = 1;
>          s->int_stat.u32 |= int_stat.u32 & ~s->int_mask.u32;
> -        s->tx_status.u32 = (s->tx_status.u32 & ~buff_st_mask) |
> -                        (buff_st << (buff2tx_idx * 4));
> +        s->tx_status.u32 = deposit32(s->tx_status.u32,
> +                                     buff2tx_idx * 4, 4, TXT_TOK);
>      } while (1);
>  }


Thanks for your time, I have planned to look and these and attempt
to provide solution which is acceptable but documents our intentions,
but it is on my tasks queue still,

Pavel

