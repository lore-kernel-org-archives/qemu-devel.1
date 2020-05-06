Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A631C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 11:39:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9C6220714
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 11:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MuxYx4VM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9C6220714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWIP0-0001mW-U7
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 07:39:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50624)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jWIO8-0000xv-4F; Wed, 06 May 2020 07:38:56 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43455)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jWIO7-0005qC-5r; Wed, 06 May 2020 07:38:55 -0400
Received: by mail-wr1-x444.google.com with SMTP id i15so1362957wrx.10;
 Wed, 06 May 2020 04:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=yrJD0nf/1yh/ai4LTsZD9jBphmSNiHQQnt08pdWzbfM=;
 b=MuxYx4VMIwNmEBDBea7dUfKGGlH5AN4mc6pT2GI068FAbjQtn3wsO9LjDE/5/Oz4Cp
 2tZr2H8Vl/WzA4BqB/hIgBNqZSrpIq2m4wOycZN2kWL2jBB2NCaE2UTRI31s8UqCC0m8
 XwADi1k9qYoXu6Buyi1W4Ld4kDvQ2rF3UnsRPn4cbONk8C/20usxdrhDjVVGmVMncD3E
 W+HH0caGCwfz7mvfAyC1b7cZEV49NjbFRlHcTmf9/IRadFEaff4ajq8dQfrNzgfOAdt1
 JmvEt8ODvsbZqX2ejH2fV9u9lKomtxkE85DoB3HZg+NUUGr6AbBPssuZNGv/c/WTXSiF
 oIkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yrJD0nf/1yh/ai4LTsZD9jBphmSNiHQQnt08pdWzbfM=;
 b=X8UykLDwKpN8XfHKOaD6bwHJ2U316P0MQsD66yfAvDMiQAAPBLA97GTrZISGsvrbQl
 NoStPAqDOBR1zcioa+iv159gOxGrsveBkp4ucax925haa7UR6zBQhV/XWrCO/8zyp6V8
 L1eVEhcVC8ksT2IvuRh43trAOJgsCjDRLbGRMqh9WKZudoO0TWMvEuqVTxRhp2h6RgIn
 L+oofcYSNLiKwB1lePjBaKeFXNOn6tYktYpj+s6boXYtv0LnP3uHJQVOodO0VPl0b1BW
 WY65mcsIUGikFcB4CmaXzpsakzExl4/FSrIH0FEtjUOQEjkf1BcxcVb+2MdKTNYGAcAu
 rdPQ==
X-Gm-Message-State: AGi0PuYQmC6loVPcydwtsGxO6CXHJq6TSaThmX6XQFxPJvHvp50+S5a7
 npje3MTvhjXTu0K9obIeCU4=
X-Google-Smtp-Source: APiQypLdAP3l5NRPBCiYq5YRUhUpVHPz9VEk4un13QcbaJhcyEvdthf+d066Qcdtq2PsmVfRmoqCKA==
X-Received: by 2002:adf:dd8b:: with SMTP id x11mr8548161wrl.238.1588765132923; 
 Wed, 06 May 2020 04:38:52 -0700 (PDT)
Received: from [192.168.1.37] (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id t4sm2714342wri.54.2020.05.06.04.38.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 May 2020 04:38:52 -0700 (PDT)
Subject: Re: [PATCH v2 2/9] hw/net/xilinx_axienet: Cleanup stream->push
 assignment
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
References: <20200506082513.18751-1-edgar.iglesias@gmail.com>
 <20200506082513.18751-3-edgar.iglesias@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9e75e512-c09f-8c48-1971-fecc4850ffc1@amsat.org>
Date: Wed, 6 May 2020 13:38:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200506082513.18751-3-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: damien.hedde@greensocs.com, peter.maydell@linaro.org,
 sstabellini@kernel.org, edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, jasowang@redhat.com, alistair@alistair23.me,
 frederic.konrad@adacore.com, qemu-arm@nongnu.org, figlesia@xilinx.com,
 luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/6/20 10:25 AM, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> 
> Split the shared stream_class_init function to assign
> stream->push with better type-safety.
> 
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   hw/net/xilinx_axienet.c | 18 ++++++++++++------
>   1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
> index 0f97510d8a..84073753d7 100644
> --- a/hw/net/xilinx_axienet.c
> +++ b/hw/net/xilinx_axienet.c
> @@ -1029,11 +1029,19 @@ static void xilinx_enet_class_init(ObjectClass *klass, void *data)
>       dc->reset = xilinx_axienet_reset;
>   }
>   
> -static void xilinx_enet_stream_class_init(ObjectClass *klass, void *data)
> +static void xilinx_enet_control_stream_class_init(ObjectClass *klass,
> +                                                  void *data)
>   {
>       StreamSlaveClass *ssc = STREAM_SLAVE_CLASS(klass);
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
>   }
>   
>   static const TypeInfo xilinx_enet_info = {
> @@ -1048,8 +1056,7 @@ static const TypeInfo xilinx_enet_data_stream_info = {
>       .name          = TYPE_XILINX_AXI_ENET_DATA_STREAM,
>       .parent        = TYPE_OBJECT,
>       .instance_size = sizeof(struct XilinxAXIEnetStreamSlave),
> -    .class_init    = xilinx_enet_stream_class_init,
> -    .class_data    = xilinx_axienet_data_stream_push,
> +    .class_init    = xilinx_enet_data_stream_class_init,
>       .interfaces = (InterfaceInfo[]) {
>               { TYPE_STREAM_SLAVE },
>               { }
> @@ -1060,8 +1067,7 @@ static const TypeInfo xilinx_enet_control_stream_info = {
>       .name          = TYPE_XILINX_AXI_ENET_CONTROL_STREAM,
>       .parent        = TYPE_OBJECT,
>       .instance_size = sizeof(struct XilinxAXIEnetStreamSlave),
> -    .class_init    = xilinx_enet_stream_class_init,
> -    .class_data    = xilinx_axienet_control_stream_push,
> +    .class_init    = xilinx_enet_control_stream_class_init,
>       .interfaces = (InterfaceInfo[]) {
>               { TYPE_STREAM_SLAVE },
>               { }
> 

