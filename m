Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76099C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 22:31:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38DAA20656
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 22:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yv2DfLaR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38DAA20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAL01-0004sV-Fg
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 18:31:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55416)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kAKz1-00040u-41; Mon, 24 Aug 2020 18:30:31 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:37180)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kAKyy-0003Nn-QS; Mon, 24 Aug 2020 18:30:30 -0400
Received: by mail-io1-xd42.google.com with SMTP id b16so10477289ioj.4;
 Mon, 24 Aug 2020 15:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4CyWbdP5iO0Wlh/bmeZ88cYoBglVSBZngM56nSVAFT4=;
 b=Yv2DfLaRxByJMSxlfTa+iFjN3nPSK14itcTGJdMN97P18LkRWlF2jd8BpimgAvJqOH
 H6MnNFiFLfbRbqBoF5wTICxFQLb8PXCSfuiGrfS7zC+Jicjcuj/uKt9hsdIO0XUZLiN+
 KZfQ8oPM0kDBzxd5/2tOwNYH+GtAsGhpcsRoJy8KfKsMDWMbWudKKLnNxQ3xLRBgLwQY
 HlOBFXBd7J5wEFgM6ZeJHM/cQ2+o8lnhrvTUdI/0ZgGLdVd+LuuTCyKVcYAQ9urWCauE
 OqLFcY/bIcWPj3NI8gN8kEIPfSs+Wm7IEN5w+8yEGAHbeQvFA604EDSw1ChMZGMiwusU
 kg0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4CyWbdP5iO0Wlh/bmeZ88cYoBglVSBZngM56nSVAFT4=;
 b=aIbDFTntjkB0TaWzb9Xff33kjtvf/pQSFoo1x43HWiE1/tRwclFUN2sBI0ZW/EfObw
 MkiLY4A7K8u6sz2nf3ozIsRhp8giHrcAQQS1lkztsj/1Ogfvhiq7x7dI/bRwzp2qf501
 Klk8p/p5vAGqJOMFEkIIf5SKc3eFcEF2wE751+VPHbt7xPOxQWEvOTQjUtEe0Y3yw0i7
 hx1m2Sv8BCxcHYUF6oCpyyMIzCteioNjvvuh9/vW7xj4YuAIsHmKAvhs+EdfVFC4gFea
 fCNy8O5kTfN+0PbZsSwlEsCncQtFqXLWdeC/QhU/fwSKkJMo7FnLM4Fek5kSiUqaiwbL
 znsw==
X-Gm-Message-State: AOAM532ECZDWZIARYWeZ0eTAsP5g7yFar7TL+ICBUFijKrJBV0GO1o8B
 pGHzbwzqV5f7qRQV4iCkzKnuY+KibLfNVyRBloY=
X-Google-Smtp-Source: ABdhPJz9il9hM0dW+HBzbmlPKniCwECxNO/8hMVPKUBsEqoDCV/QwL6e34Gfpb7J9nJJLX3xq5Xw7liyP6eOecuqpPM=
X-Received: by 2002:a6b:e006:: with SMTP id z6mr6579306iog.118.1598308227054; 
 Mon, 24 Aug 2020 15:30:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200824215721.2960162-1-ehabkost@redhat.com>
 <20200824215721.2960162-2-ehabkost@redhat.com>
In-Reply-To: <20200824215721.2960162-2-ehabkost@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 24 Aug 2020 15:19:46 -0700
Message-ID: <CAKmqyKMRBS3FXr==vwbvLmisMxH42PEysh_9WHBMRXc__7NRxQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] xilinx_axidma: Use typedef name for instance_size
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d42;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 24, 2020 at 2:58 PM Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> This makes the code consistent with the rest of QOM code in QEMU,
> and will make automated conversion to type declaration macros
> simpler.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
> Cc: Alistair Francis <alistair@alistair23.me>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: qemu-arm@nongnu.org
> Cc: qemu-devel@nongnu.org
> ---
>  hw/dma/xilinx_axidma.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
> index a4812e480a..5ad8bd3d2e 100644
> --- a/hw/dma/xilinx_axidma.c
> +++ b/hw/dma/xilinx_axidma.c
> @@ -634,7 +634,7 @@ static const TypeInfo axidma_info = {
>  static const TypeInfo xilinx_axidma_data_stream_info = {
>      .name          = TYPE_XILINX_AXI_DMA_DATA_STREAM,
>      .parent        = TYPE_OBJECT,
> -    .instance_size = sizeof(struct XilinxAXIDMAStreamSlave),
> +    .instance_size = sizeof(XilinxAXIDMAStreamSlave),
>      .class_init    = xilinx_axidma_stream_class_init,
>      .class_data    = &xilinx_axidma_data_stream_class,
>      .interfaces = (InterfaceInfo[]) {
> @@ -646,7 +646,7 @@ static const TypeInfo xilinx_axidma_data_stream_info = {
>  static const TypeInfo xilinx_axidma_control_stream_info = {
>      .name          = TYPE_XILINX_AXI_DMA_CONTROL_STREAM,
>      .parent        = TYPE_OBJECT,
> -    .instance_size = sizeof(struct XilinxAXIDMAStreamSlave),
> +    .instance_size = sizeof(XilinxAXIDMAStreamSlave),
>      .class_init    = xilinx_axidma_stream_class_init,
>      .class_data    = &xilinx_axidma_control_stream_class,
>      .interfaces = (InterfaceInfo[]) {
> --
> 2.26.2
>
>

