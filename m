Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB81DC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 22:33:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 948C720656
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 22:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWTVQjo8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 948C720656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAL28-0007YB-TK
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 18:33:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55638)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kAL0K-0005Rc-5A; Mon, 24 Aug 2020 18:31:52 -0400
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:34958)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kAL0I-0003cT-8k; Mon, 24 Aug 2020 18:31:51 -0400
Received: by mail-il1-x142.google.com with SMTP id q14so8753976ilm.2;
 Mon, 24 Aug 2020 15:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6jhFcywO6Y8wq+zavJ0ww+xgsP8QGx5ARX43YJfFEg8=;
 b=PWTVQjo8JS5hJJXTGXcruPf8jjMrKL75jlMnFZVN/YcqkzkEa3mu7MLCwsMOZsaQdy
 y6q0LEMTMdW6/ow9+qy7ildRTuNoXQQkGvTCNPc88rzbk+CImxAPNvvjSp5TZmDsqc8T
 exmXJmujwN7bftkIq6bUisEmdkdGE5ls0e4lnwps1ViNrgQS80C0Muxsh9eOEKf7EDj9
 4PVhxxIn2zQocoLwqYr8z5rQGUjLMn6ATaCw9HZ8uxa05zjpziuPQgekBWHCVj7ZQlZs
 Xa9LbhGZ61p2GvyIlwPXQTkYxa2XaPuGzkuFCX1RPquSS5dTqRZdHtbosI1q09jPz2Dn
 qh+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6jhFcywO6Y8wq+zavJ0ww+xgsP8QGx5ARX43YJfFEg8=;
 b=S27ZY7d/br/HSspnKe865au7F3Z7rXJOMeRQSXEV02jrBzbb7pV6MLJL1X3F3Vxfos
 0wyftO0FIRZmIT8ZeJLkekFOkiq4L1JWScFIGRc78UX9nvn0fslpM68igu8AbaVOfi0a
 1kQojm4ffUFqApq/j9oJRo+U0y0cnrsecEEQqs5QcIXeliUnlnoLk5Y20LLhJ09ImRHs
 K347Xz5DfJ92MUytgk4CpPU6i2Oc2IWhC7pmN3tf3ayy7n2NxuJ7ArB9wm4jJDGmtaVT
 xoCaG6y+tNvSENKT2JWwaDXWWhMkovN24Pca9YAM+SKwWf2ommxBh3fb61b5gY/YREvA
 vwqQ==
X-Gm-Message-State: AOAM530kFjt4wuufFJrSkvUk91AmGimBCiWhJ2J1G5ktoaPTZEwy52xr
 ZvCsTbZ9jZjavhwJ4bhxEwWwA8vbfooQjqmgQLQ=
X-Google-Smtp-Source: ABdhPJyEACNJVMDcKBeMH7Zj81skXLWGqZdzLtGxwEFe5Gw+cqXXeRq3g/A0z80iKhYQsEC2baVIWFMf585ZqcmhUIA=
X-Received: by 2002:a92:9117:: with SMTP id t23mr7220673ild.177.1598308308419; 
 Mon, 24 Aug 2020 15:31:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200824215936.2961951-1-ehabkost@redhat.com>
 <20200824215936.2961951-5-ehabkost@redhat.com>
In-Reply-To: <20200824215936.2961951-5-ehabkost@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 24 Aug 2020 15:21:07 -0700
Message-ID: <CAKmqyKMeO96oAoKWFqV-TtN8HGnnfGKaNu4j4gE4HWcFuxgZBA@mail.gmail.com>
Subject: Re: [PATCH 4/6] xilinx_axienet: Use typedef name for instance_size
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::142;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x142.google.com
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
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 24, 2020 at 3:02 PM Eduardo Habkost <ehabkost@redhat.com> wrote:
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
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: qemu-arm@nongnu.org
> Cc: qemu-devel@nongnu.org
> ---
>  hw/net/xilinx_axienet.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
> index 1e48eb70c9..ceb4652938 100644
> --- a/hw/net/xilinx_axienet.c
> +++ b/hw/net/xilinx_axienet.c
> @@ -1069,7 +1069,7 @@ static const TypeInfo xilinx_enet_info = {
>  static const TypeInfo xilinx_enet_data_stream_info = {
>      .name          = TYPE_XILINX_AXI_ENET_DATA_STREAM,
>      .parent        = TYPE_OBJECT,
> -    .instance_size = sizeof(struct XilinxAXIEnetStreamSlave),
> +    .instance_size = sizeof(XilinxAXIEnetStreamSlave),
>      .class_init    = xilinx_enet_data_stream_class_init,
>      .interfaces = (InterfaceInfo[]) {
>              { TYPE_STREAM_SLAVE },
> @@ -1080,7 +1080,7 @@ static const TypeInfo xilinx_enet_data_stream_info = {
>  static const TypeInfo xilinx_enet_control_stream_info = {
>      .name          = TYPE_XILINX_AXI_ENET_CONTROL_STREAM,
>      .parent        = TYPE_OBJECT,
> -    .instance_size = sizeof(struct XilinxAXIEnetStreamSlave),
> +    .instance_size = sizeof(XilinxAXIEnetStreamSlave),
>      .class_init    = xilinx_enet_control_stream_class_init,
>      .interfaces = (InterfaceInfo[]) {
>              { TYPE_STREAM_SLAVE },
> --
> 2.26.2
>
>

