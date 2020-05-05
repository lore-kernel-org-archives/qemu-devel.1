Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3237C47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 20:10:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D88320721
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 20:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EE7e5wIk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D88320721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jW3tr-0006mG-Ii
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 16:10:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41910)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jW3rN-0002Ur-Q8; Tue, 05 May 2020 16:08:09 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:40783)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jW3rM-0000Qu-TI; Tue, 05 May 2020 16:08:09 -0400
Received: by mail-io1-xd43.google.com with SMTP id c2so3353419iow.7;
 Tue, 05 May 2020 13:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RoOEeV0Az4OaTUF+aerwT3MsNeW3h+6uK+DB1VeoGGg=;
 b=EE7e5wIkmmi1uZshOHH3VfIVM+e3jMtLPK0mXQYJhQnAz2ii/FHuXgQzqImCkrl0Ku
 aiIx9Zn7P2EunIUkvsw+i2I/ASx2HbiLSIGQeBY5vLcbxk/HdIO9dScqhlhupN1bYC2I
 nO6HTgkfYsjdBjt+FVVga5zDjTxHkSdFuTvkFdahjhhyist4Fw2BucnKm4IEcXOGMRYZ
 7s2c/7TMhrRO6FgjzV0/HKfQzKK6Q4iYCUzyid2+dgDL7MyFnTfjuQyWF54rT66C26sa
 /Ux+SoCS/EeqFZoWIVyckMleW5DJBwPGL2FoEqk1eMaxJGFn51t3/WeOvkTvwPDmVoE1
 BRGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RoOEeV0Az4OaTUF+aerwT3MsNeW3h+6uK+DB1VeoGGg=;
 b=BML9Ad8b+f4W+OBWqFGs7OerSfSXfv6pqKagpDNWfA/pd0eZsiBvF8Hj5v/B3PZ9r/
 dk+AoMmrj4wxgP6bdMKUEoLhKHss7FNFBQfnPvmFfLcboG2S3jVtj853llyyMZ6DaM4E
 Ek/lldm+srtKJLOJsG7gOgd7TsdJaOW0LhsYOkBvEETnswLiytpDY4OAGfVqUPzITyQo
 /Esox3yP8Uv4oZ5J0dFwPUzYIqdFCk69SzHHYLpByGlJJNo4ephBK6jEnUHdjnveSgDH
 sZeYPaYm7Cn2nEUDNBgysNI9BoaEac0h0A0ZntvaRqyG/7TsCnGLwL7iptI2wniuELpK
 knAA==
X-Gm-Message-State: AGi0PuYY7Wp/KfMOrmWi/72Y95qNa+o2dWQqZaOjprfPFxJXCtotXLqy
 t9iDEl5voXAL1VNnzeZXAF4FFiiU+7hJ6X11L3I=
X-Google-Smtp-Source: APiQypIZzWbvRzuJ13zGQ5i3pbqi1UAsFCluOeprFNffSsBg5xvCNIo6XdSImVSI93AAg9L9XwvL42mWC794E86eYBQ=
X-Received: by 2002:a02:966a:: with SMTP id c97mr5339403jai.106.1588709287343; 
 Tue, 05 May 2020 13:08:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200430162439.2659-1-edgar.iglesias@gmail.com>
 <20200430162439.2659-9-edgar.iglesias@gmail.com>
In-Reply-To: <20200430162439.2659-9-edgar.iglesias@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 5 May 2020 12:59:15 -0700
Message-ID: <CAKmqyKOA8k5dOMCJC4KOteYJWDoT4w9J8VHNDHDkjcNmgPRefg@mail.gmail.com>
Subject: Re: [PATCH v1 8/9] hw/dma/xilinx_axidma: s2mm: Support stream
 fragments
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d43;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Edgar Iglesias <edgar.iglesias@xilinx.com>,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Francisco Iglesias <frasse.iglesias@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>, figlesia@xilinx.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 30, 2020 at 9:31 AM Edgar E. Iglesias
<edgar.iglesias@gmail.com> wrote:
>
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> Add support for stream fragments.
>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/dma/xilinx_axidma.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
> index 101d32a965..87be9cade7 100644
> --- a/hw/dma/xilinx_axidma.c
> +++ b/hw/dma/xilinx_axidma.c
> @@ -110,6 +110,7 @@ struct Stream {
>
>      int nr;
>
> +    bool sof;
>      struct SDesc desc;
>      unsigned int complete_cnt;
>      uint32_t regs[R_MAX];
> @@ -174,6 +175,7 @@ static void stream_reset(struct Stream *s)
>  {
>      s->regs[R_DMASR] = DMASR_HALTED;  /* starts up halted.  */
>      s->regs[R_DMACR] = 1 << 16; /* Starts with one in compl threshold.  */
> +    s->sof = true;
>  }
>
>  /* Map an offset addr into a channel index.  */
> @@ -321,12 +323,11 @@ static void stream_process_mem2s(struct Stream *s, StreamSlave *tx_data_dev,
>  }
>
>  static size_t stream_process_s2mem(struct Stream *s, unsigned char *buf,
> -                                   size_t len)
> +                                   size_t len, bool eop)
>  {
>      uint32_t prev_d;
>      unsigned int rxlen;
>      size_t pos = 0;
> -    int sof = 1;
>
>      if (!stream_running(s) || stream_idle(s)) {
>          return 0;
> @@ -352,16 +353,16 @@ static size_t stream_process_s2mem(struct Stream *s, unsigned char *buf,
>          pos += rxlen;
>
>          /* Update the descriptor.  */
> -        if (!len) {
> +        if (eop) {
>              stream_complete(s);
>              memcpy(s->desc.app, s->app, sizeof(s->desc.app));
>              s->desc.status |= SDESC_STATUS_EOF;
>          }
>
> -        s->desc.status |= sof << SDESC_STATUS_SOF_BIT;
> +        s->desc.status |= s->sof << SDESC_STATUS_SOF_BIT;
>          s->desc.status |= SDESC_STATUS_COMPLETE;
>          stream_desc_store(s, s->regs[R_CURDESC]);
> -        sof = 0;
> +        s->sof = eop;
>
>          /* Advance.  */
>          prev_d = s->regs[R_CURDESC];
> @@ -426,8 +427,7 @@ xilinx_axidma_data_stream_push(StreamSlave *obj, unsigned char *buf, size_t len,
>      struct Stream *s = &ds->dma->streams[1];
>      size_t ret;
>
> -    assert(eop);
> -    ret = stream_process_s2mem(s, buf, len);
> +    ret = stream_process_s2mem(s, buf, len, eop);
>      stream_update_irq(s);
>      return ret;
>  }
> --
> 2.20.1
>
>

