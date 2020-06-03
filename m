Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCF4C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 21:49:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EA322067B
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 21:49:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EA322067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgbGk-00067L-JH
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 17:49:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48796)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jgbG8-0005cV-3W
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 17:49:16 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:61878)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jgbG5-0008IV-L5
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 17:49:14 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id D2EA074594E;
 Wed,  3 Jun 2020 23:49:07 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id B2B14745712; Wed,  3 Jun 2020 23:49:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B14757456F8;
 Wed,  3 Jun 2020 23:49:07 +0200 (CEST)
Date: Wed, 3 Jun 2020 23:49:07 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: P J P <ppandit@redhat.com>
Subject: Re: [PATCH v2] ati-vga: check mm_index before recursive call
In-Reply-To: <20200603185522.1173354-1-ppandit@redhat.com>
Message-ID: <alpine.BSF.2.22.395.2006032345310.56892@zero.eik.bme.hu>
References: <20200603185522.1173354-1-ppandit@redhat.com>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
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
Cc: Prasad J Pandit <pjp@fedoraproject.org>, Yi Ren <c4tren@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Ren Ding <rding@gatech.edu>, Hanqing Zhao <hanqing@gatech.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 4 Jun 2020, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> While accessing VGA registers via ati_mm_read/write routines,
> a guest may set 's->regs.mm_index' such that it leads to infinite
> recursion. Check mm_index value to avoid it.
>
> Reported-by: Ren Ding <rding@gatech.edu>
> Reported-by: Hanqing Zhao <hanqing@gatech.edu>
> Reported-by: Yi Ren <c4tren@gmail.com>

Suggested-by: BALATON Zoltan <balaton@eik.bme.hu>

therefore I think this should work but someone else should give 
Reviewed-by to cross check this.

Regards,
BALATON Zoltan

> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
> hw/display/ati.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
> Update v2: add check before recursive call
>  -> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg00781.html
>
> diff --git a/hw/display/ati.c b/hw/display/ati.c
> index 065f197678..bda4a2d816 100644
> --- a/hw/display/ati.c
> +++ b/hw/display/ati.c
> @@ -285,7 +285,7 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
>             if (idx <= s->vga.vram_size - size) {
>                 val = ldn_le_p(s->vga.vram_ptr + idx, size);
>             }
> -        } else {
> +        } else if (s->regs.mm_index > MM_DATA + 3) {
>             val = ati_mm_read(s, s->regs.mm_index + addr - MM_DATA, size);
>         }
>         break;
> @@ -520,7 +520,7 @@ static void ati_mm_write(void *opaque, hwaddr addr,
>             if (idx <= s->vga.vram_size - size) {
>                 stn_le_p(s->vga.vram_ptr + idx, size, data);
>             }
> -        } else {
> +        } else if (s->regs.mm_index > MM_DATA + 3) {
>             ati_mm_write(s, s->regs.mm_index + addr - MM_DATA, data, size);
>         }
>         break;
>

