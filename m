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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DBFC47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 16:39:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12EE72078C
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 16:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3kHak5a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12EE72078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jW0bp-0006YD-1V
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 12:39:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jW0b8-0005oz-Kg; Tue, 05 May 2020 12:39:10 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:39012)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jW0b5-00033B-V0; Tue, 05 May 2020 12:39:10 -0400
Received: by mail-io1-xd42.google.com with SMTP id w4so2633270ioc.6;
 Tue, 05 May 2020 09:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Lv4S3CuiIrBolDrocQDs3BbWijeM1TY9spl4Z9e+pPI=;
 b=h3kHak5aY4ZhpjFhbgMv2yG01lKZE7LA1GdQjCjsZTaUkyAxR9ciZHVwgDby0vYk1b
 5Xx7sWDbGN+3/BazChDnx29psSFahWeFXiZXO+CQM13vLvxlWIYi0aDNKuXj3vj0qSfD
 nr6eH0SKJ2ge25xvrzoscIgKnc6qCIOP8OCcLY+XyJHOP1G9/4Wsfu4mymHB5ySFrVlL
 9nAJrJMi2xphL2dxmdH53T5wFHwSxclVQ/EH78pJdEJG9FXFZ1ULM6jHvjaz58n/sfQ3
 i0O2itUYfryqKGIWYeGpdxctEPUdWktdtahMkNBv9ilJLAkFy8yEA5umyd7KEN5E9IFV
 Anog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Lv4S3CuiIrBolDrocQDs3BbWijeM1TY9spl4Z9e+pPI=;
 b=TGrlI3GqoL+hxH9tpLUuAkXMoIz1SGv/uR0JTZ/AEwQM+IPN9n5bP9hqeyuvvLSUig
 +Ta+ZoT11uEQ7LPtJ1szPyZSn0ooDqrIkvGAe6UyKn6aIWT1VF3u8fthTUV+x74lXACE
 GeYSZgg2E8oYcTx/kI8NnoOlg11eawfCeWW7Y4pTJWK75ZFUosLx7i//JO9vRtmWl5hM
 bKBW2Kg54DXX7XuvMcZKHZWTdo72df4K5eNuU3LNdf23ln5TM5iGLIeVbett5JqWCQqs
 Ut9yYFoBIUvdGZXQ45Xfv2o8MuS9MsVIzq2AnTscRzW/XmBelzRGq8BVI2eaL/kUmRQ6
 ufLw==
X-Gm-Message-State: AGi0PubAvzSLGBldfdL/O5UQVTTT97sHmCmV92kxBbLDkggyvkWCWGG6
 Mba/0AVeT8gtGZh62AGKxwDH8OpTA2a8oNvSbuk=
X-Google-Smtp-Source: APiQypJ96AtmpUZgDuWA1g8DYId/wzJoJga1tjB0NTHGkhHs/tksDgwpwQ1FT+Jd1+pIt1ZOg9BEMyUvMov/3bo/jRg=
X-Received: by 2002:a02:1a01:: with SMTP id 1mr4507932jai.26.1588696745906;
 Tue, 05 May 2020 09:39:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200430162439.2659-1-edgar.iglesias@gmail.com>
 <20200430162439.2659-3-edgar.iglesias@gmail.com>
In-Reply-To: <20200430162439.2659-3-edgar.iglesias@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 5 May 2020 09:30:24 -0700
Message-ID: <CAKmqyKMN4gKvwkOz-RYO9dD6hqeN4G0-083j6ZM5nG=ee-yTfQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/9] hw/net/xilinx_axienet: Cleanup stream->push
 assignment
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
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

On Thu, Apr 30, 2020 at 9:26 AM Edgar E. Iglesias
<edgar.iglesias@gmail.com> wrote:
>
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> Split the shared stream_class_init function to assign
> stream->push with better type-safety.
>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/net/xilinx_axienet.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
> index 0f97510d8a..84073753d7 100644
> --- a/hw/net/xilinx_axienet.c
> +++ b/hw/net/xilinx_axienet.c
> @@ -1029,11 +1029,19 @@ static void xilinx_enet_class_init(ObjectClass *klass, void *data)
>      dc->reset = xilinx_axienet_reset;
>  }
>
> -static void xilinx_enet_stream_class_init(ObjectClass *klass, void *data)
> +static void xilinx_enet_control_stream_class_init(ObjectClass *klass,
> +                                                  void *data)
>  {
>      StreamSlaveClass *ssc = STREAM_SLAVE_CLASS(klass);
>
> -    ssc->push = data;
> +    ssc->push = xilinx_axienet_control_stream_push;
> +}
> +
> +static void xilinx_enet_data_stream_class_init(ObjectClass *klass, void *data)
> +{
> +    StreamSlaveClass *ssc = STREAM_SLAVE_CLASS(klass);
> +
> +    ssc->push = xilinx_axienet_data_stream_push;
>  }
>
>  static const TypeInfo xilinx_enet_info = {
> @@ -1048,8 +1056,7 @@ static const TypeInfo xilinx_enet_data_stream_info = {
>      .name          = TYPE_XILINX_AXI_ENET_DATA_STREAM,
>      .parent        = TYPE_OBJECT,
>      .instance_size = sizeof(struct XilinxAXIEnetStreamSlave),
> -    .class_init    = xilinx_enet_stream_class_init,
> -    .class_data    = xilinx_axienet_data_stream_push,
> +    .class_init    = xilinx_enet_data_stream_class_init,
>      .interfaces = (InterfaceInfo[]) {
>              { TYPE_STREAM_SLAVE },
>              { }
> @@ -1060,8 +1067,7 @@ static const TypeInfo xilinx_enet_control_stream_info = {
>      .name          = TYPE_XILINX_AXI_ENET_CONTROL_STREAM,
>      .parent        = TYPE_OBJECT,
>      .instance_size = sizeof(struct XilinxAXIEnetStreamSlave),
> -    .class_init    = xilinx_enet_stream_class_init,
> -    .class_data    = xilinx_axienet_control_stream_push,
> +    .class_init    = xilinx_enet_control_stream_class_init,
>      .interfaces = (InterfaceInfo[]) {
>              { TYPE_STREAM_SLAVE },
>              { }
> --
> 2.20.1
>
>

