Return-Path: <SRS0=PlQC=BZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F22CC433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 16:17:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A1A323AA0
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 16:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+iRFUyf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A1A323AA0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6yrb-0002M5-5y
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 12:16:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58352)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6ypx-0000Ig-MZ; Sat, 15 Aug 2020 12:15:17 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51890)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6ypw-0003DC-68; Sat, 15 Aug 2020 12:15:17 -0400
Received: by mail-wm1-x343.google.com with SMTP id p14so9847279wmg.1;
 Sat, 15 Aug 2020 09:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=i7QpRGtek9kVvNw7rdh6kZdsur5t/BbscrRJyKtiOlQ=;
 b=J+iRFUyfyxBs9psl70itcL9zm3xr8vtozBc5Qz0C4DcGrXC547cHMZFDl+3FJJhUgg
 BAVqVH2MPyMOAZf4rUfeLeBHbwZ3WVN/ZS0yH5+ABp2llzqPuoVq47AGuZeyKZhNXvj9
 8MjP1d4zDP7tJq7hCVMZX9SiAUE/LkKkOEdmrLuYoH9d/ZTN00EhFGpbkqrCvZ/STpZ7
 la4EVjqa1JY+288cMnu/vP53qg5t/a0dc5Vr25Zz4+4joEeoFybx/CaiJ/vSbMhvwi0j
 1wseaXSfGZhSJv/kf4d2SKDiBAG9opWPJBhf9oadIwf0gqkt9tv1QRzwPnsHSKtqHsu2
 r0FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=i7QpRGtek9kVvNw7rdh6kZdsur5t/BbscrRJyKtiOlQ=;
 b=mb4d7a9opcwUlLiTNMfPDfRfYXXMs2ymBga/nftDNFUi0zCL6Wv8EpT92v8o/wyADp
 3qn8cYfvXgsf6EGmit7DNOMYD64AziA1onq8rGcoqPluUilO2AQlXPGbbD3CrFxPC2E/
 +TwFE8NItb5k8hMyv0N6m8jD/+CIwdJlwKxxMz6qKsgRzFFkFBB8GFV5We1bcq3DzCPk
 vCD5jAI4uPeNzzYgvPMQUPG252mqRZEqLebOO9ONdjJF/TBXiBD8msjcogoxxsyhGYld
 8akknhr1GTPWmgdyYSHJC4jjEtjs5JMMLHsB/a4L4o7JSyMPbPaSFEyUVPjV66sb3uD5
 Uugw==
X-Gm-Message-State: AOAM5311b5NS6yTSHLKIP75bN9W55nAaTJ3K9i07odr2I2PBy+AeEDDV
 seDh5bHi8PhzNEGTnb8Q6VLIYcfwtjA=
X-Google-Smtp-Source: ABdhPJyZNNYPUreDoz6nuSDJBha5n5gjRqGCDcKmNzdeDA6+Q9envGNpo4xR/oKL49sIP3WLqUNQFw==
X-Received: by 2002:a1c:448a:: with SMTP id r132mr5633981wma.158.1597477912864; 
 Sat, 15 Aug 2020 00:51:52 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id g145sm27175944wmg.23.2020.08.15.00.51.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Aug 2020 00:51:52 -0700 (PDT)
Subject: Re: [PATCH 09/18] hw/sd: sdhci: Make sdhci_poweron_reset() internal
 visible
To: Bin Meng <bmeng.cn@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <1597423256-14847-1-git-send-email-bmeng.cn@gmail.com>
 <1597423256-14847-10-git-send-email-bmeng.cn@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e68381fd-e4cd-a56a-ab44-ff603242e1cc@amsat.org>
Date: Sat, 15 Aug 2020 09:51:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1597423256-14847-10-git-send-email-bmeng.cn@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Bin Meng <bin.meng@windriver.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/14/20 6:40 PM, Bin Meng wrote:
> From: Bin Meng <bin.meng@windriver.com>
> 
> sdhci_poweron_reset() might be needed for any SDHCI compatible
> device that is built on top of the generic SDHCI device.

NAck. Please use device_legacy_reset() instead.

In next patch:

  device_legacy_reset(DEVICE(&sdhci->slot));

Thanks,

Phil.

> 
> Signed-off-by: Bin Meng <bin.meng@windriver.com>
> ---
> 
>  hw/sd/sdhci-internal.h | 1 +
>  hw/sd/sdhci.c          | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/sd/sdhci-internal.h b/hw/sd/sdhci-internal.h
> index e8c753d..b587e8e 100644
> --- a/hw/sd/sdhci-internal.h
> +++ b/hw/sd/sdhci-internal.h
> @@ -342,5 +342,6 @@ void sdhci_uninitfn(SDHCIState *s);
>  void sdhci_common_realize(SDHCIState *s, Error **errp);
>  void sdhci_common_unrealize(SDHCIState *s);
>  void sdhci_common_class_init(ObjectClass *klass, void *data);
> +void sdhci_poweron_reset(DeviceState *dev);
>  
>  #endif
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index deac181..20f2fe0 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -294,7 +294,7 @@ static void sdhci_reset(SDHCIState *s)
>      s->pending_insert_state = false;
>  }
>  
> -static void sdhci_poweron_reset(DeviceState *dev)
> +void sdhci_poweron_reset(DeviceState *dev)
>  {
>      /* QOM (ie power-on) reset. This is identical to reset
>       * commanded via device register apart from handling of the
> 


