Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E423AC47259
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 20:07:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE6AB20735
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 20:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5sEqTB+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE6AB20735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jW3qN-0000eL-Pg
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 16:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41590)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jW3pP-0007xi-GO; Tue, 05 May 2020 16:06:07 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:36448)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jW3pM-00033F-82; Tue, 05 May 2020 16:06:07 -0400
Received: by mail-il1-x143.google.com with SMTP id c16so26373ilr.3;
 Tue, 05 May 2020 13:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dtj2we7KH3HvnMoW35RtDJPYL8qTvt82pQ++4qEa2tA=;
 b=Z5sEqTB+UTWDlKdTVZJHCB0e3hIsmE5OgwBXJjuPPlENpNJUSmdMILv/fOAwIRzoMk
 wqJ9j5ta7prQU+d82hKQjv0BvtaAkaCvuFUauVX4X4hJUx0Pa0k0LiC3amXJFKQJHybC
 bvi3T5SdQ+yHGyU1jqXyEH4sFCUJSwtg/lVPH95yw85oi3fn04XQYvZFDleGknxHhZZ3
 yaUpqYaY53AAez6oeZRZGl68vKlPq1SJXeirJZ0VxwquAW/EjcwgRzVBNYRq+S7LkBY6
 Oei7iPUBkPWdYuoahIze5RefCWIRpwKWv3TLTi9bWQy7r8veKxkSvZC0//fmlre0YUCH
 h2+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dtj2we7KH3HvnMoW35RtDJPYL8qTvt82pQ++4qEa2tA=;
 b=jd1poCg5pWDYV7rLJYOs/VMw9vM6LSRemPJS/eoDA/zwA805PK7fVQ8//rmd5oW2GT
 qaXId93FU0nEaRlDlbD/253UohYdeOFcFqDeHyDzu0pApH6Ol0IwosLs1qPOpF+7Bop9
 X2HTQbwh7TrtCrENkVb4VKO2mG6DOufUEuanayh3YGzFVKGj80yKL75Pt4uAMXL3ph53
 d/dTPxW6f3f0bNZVzvv5GM4GEHw9hN4KV+ALoOR0wshCtksYVTVMAtZwa9F9KSx0ElLC
 az0W0wE4efW+1HuzZuAsT2736lwdFmH5rKfdVDE5UDEVzufaJqQHqH+9ZDBtkgLIaLZO
 3VjA==
X-Gm-Message-State: AGi0Pub16dCjozLlMF+vO/d2Cus8Osq5RrbB6nvp2oKXzOXTz1EnanUp
 WQlBZZzME10X0jbQWaPLnDUYvSbJjOlmrz8l9VI=
X-Google-Smtp-Source: APiQypI3elxF25Kib+wiP7Kygge+HsvSIdiEzZN6twWZpSEsd1ZBMBt6yhDXUr9Bk/VT4w99xg1lAHuNhAIjtE2iLEI=
X-Received: by 2002:a92:d0c6:: with SMTP id y6mr5841208ila.227.1588709162741; 
 Tue, 05 May 2020 13:06:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200430162439.2659-1-edgar.iglesias@gmail.com>
 <20200430162439.2659-8-edgar.iglesias@gmail.com>
In-Reply-To: <20200430162439.2659-8-edgar.iglesias@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 5 May 2020 12:57:17 -0700
Message-ID: <CAKmqyKPSUzqQxvKEvu3TYJao4sVhFXz62OyVkoW2cpNpt8jFFQ@mail.gmail.com>
Subject: Re: [PATCH v1 7/9] hw/dma/xilinx_axidma: mm2s: Stream descriptor by
 descriptor
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::143;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x143.google.com
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
> Stream descriptor by descriptor from memory instead of
> buffering entire packets before pushing. This enables
> non-packet streaming clients to work and also lifts the
> limitation that our internal DMA buffer needs to be able
> to hold entire packets.
>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/dma/xilinx_axidma.c | 31 +++++++++++++++++--------------
>  1 file changed, 17 insertions(+), 14 deletions(-)
>
> diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
> index a770e12c96..101d32a965 100644
> --- a/hw/dma/xilinx_axidma.c
> +++ b/hw/dma/xilinx_axidma.c
> @@ -111,7 +111,6 @@ struct Stream {
>      int nr;
>
>      struct SDesc desc;
> -    int pos;
>      unsigned int complete_cnt;
>      uint32_t regs[R_MAX];
>      uint8_t app[20];
> @@ -267,7 +266,9 @@ static void stream_process_mem2s(struct Stream *s, StreamSlave *tx_data_dev,
>                                   StreamSlave *tx_control_dev)
>  {
>      uint32_t prev_d;
> -    unsigned int txlen;
> +    uint32_t txlen;
> +    uint64_t addr;
> +    bool eop;
>
>      if (!stream_running(s) || stream_idle(s)) {
>          return;
> @@ -282,24 +283,26 @@ static void stream_process_mem2s(struct Stream *s, StreamSlave *tx_data_dev,
>          }
>
>          if (stream_desc_sof(&s->desc)) {
> -            s->pos = 0;
>              stream_push(tx_control_dev, s->desc.app, sizeof(s->desc.app), true);
>          }
>
>          txlen = s->desc.control & SDESC_CTRL_LEN_MASK;
> -        if ((txlen + s->pos) > sizeof s->txbuf) {
> -            hw_error("%s: too small internal txbuf! %d\n", __func__,
> -                     txlen + s->pos);
> -        }
>
> -        address_space_read(&s->dma->as, s->desc.buffer_address,
> -                           MEMTXATTRS_UNSPECIFIED,
> -                           s->txbuf + s->pos, txlen);
> -        s->pos += txlen;
> +        eop = stream_desc_eof(&s->desc);
> +        addr = s->desc.buffer_address;
> +        while (txlen) {
> +            unsigned int len;
> +
> +            len = txlen > sizeof s->txbuf ? sizeof s->txbuf : txlen;
> +            address_space_read(&s->dma->as, addr,
> +                               MEMTXATTRS_UNSPECIFIED,
> +                               s->txbuf, len);
> +            stream_push(tx_data_dev, s->txbuf, len, eop && len == txlen);
> +            txlen -= len;
> +            addr += len;
> +        }
>
> -        if (stream_desc_eof(&s->desc)) {
> -            stream_push(tx_data_dev, s->txbuf, s->pos, true);
> -            s->pos = 0;
> +        if (eop) {
>              stream_complete(s);
>          }
>
> --
> 2.20.1
>
>

