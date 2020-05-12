Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FC6C54E8D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 07:11:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECC2120733
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 07:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHbgTmjt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECC2120733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYP4C-00021J-6J
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 03:11:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54210)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jYP2y-0000FC-BM
 for qemu-devel@nongnu.org; Tue, 12 May 2020 03:09:48 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40675)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jYP2x-00008V-Lw
 for qemu-devel@nongnu.org; Tue, 12 May 2020 03:09:48 -0400
Received: by mail-wr1-x441.google.com with SMTP id e16so13959836wra.7
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 00:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=VLetCKrTZaX3pxpP21e6xWGqA9uqweCMGGS3bx+xiAg=;
 b=VHbgTmjtcpBFfFU+1wy3rbAX6t9LB13S7OTtmW90L5+X6EicP+iGoudAH1uipRz+kX
 cjLPIB5+IOaqr7yMsC3HQgCMV0fZRCRrlDnpwA+ZnL83HYptj53yRdbpIsuDi7nIHV+O
 I7XNTIGbVXO/N0rzkYSLQxr5/NYMNYhGl4dMe91ocYMi1h2YkTmyJoFC0JBgCnMikPbe
 WYJ6NjIO/t6xigHM72u90jqGmCBZRWx38N8lXCtq3aP1H5SzoKhou3K8yhFw0tWHFIk5
 F5UlR3lPnmTc32Grm0suR/4pvgXarvJSFQcdS+PciocRQrwyMPZhomTB6jNL64VzsVk/
 sMaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VLetCKrTZaX3pxpP21e6xWGqA9uqweCMGGS3bx+xiAg=;
 b=OS5MzzwIIgNAOom7H5Zg10s88IKnSJfdFTW7ZEyPjePxK+xTN6G1Mk33Zli0vRKVQK
 swq0Oo2MNZm24Wh/0Xnyl28RtlPzG99GQu6WbzhSQscpiAo3dmUZy6NcE2lHEyR3ggNe
 ThW9PkfuGB4gb8TZstzjqsA0o+7RZx4QbGIbPlcdRDRTCRO9BvV81AHNScSuB/4DmMKp
 s3VFdatF2517cCvKGsqbjhfy3/ZCNGhp4zwCovqpeRVWkaqN7gKbBOF5Y8MJZsalnkGG
 7jJU6xf1IU6p2Ou5gG7Q7EFd4uesqlqzkkjwhe8sqgB/QRo+fFZWXwBsE4Kr7Vq+s9jV
 2QOQ==
X-Gm-Message-State: AGi0Pua7NUo3p3WkANQRUE9kVCJO9QVR/vtZNSl3VWpmSY4pkiuN4reR
 KCvaGChQxaqekKP01KhxPNc=
X-Google-Smtp-Source: APiQypLSpnmAF7sQq+gypAwXpgElbEEsvA2FmXQWE40/THFNiZkCO+DJZGTy1S/f2v/YeU53LohEGw==
X-Received: by 2002:adf:8403:: with SMTP id 3mr22363248wrf.186.1589267385354; 
 Tue, 12 May 2020 00:09:45 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id e22sm6162137wrc.41.2020.05.12.00.09.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2020 00:09:44 -0700 (PDT)
Subject: Re: [PATCH 2/2] target/mips/kvm: Assert unreachable code is not used
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20200429082916.10669-1-f4bug@amsat.org>
 <20200429082916.10669-3-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e33820ee-0013-bed9-ef06-9a66995f6405@amsat.org>
Date: Tue, 12 May 2020 09:09:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200429082916.10669-3-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
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
Cc: Huacai Chen <chenhuacai@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Huacai Chen <chenhc@lemote.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+Paolo

On 4/29/20 10:29 AM, Philippe Mathieu-Daudé wrote:
> This code must not be used outside of KVM. Abort if it is.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>   target/mips/kvm.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/target/mips/kvm.c b/target/mips/kvm.c
> index de3e26ef1f..050bfbd7fa 100644
> --- a/target/mips/kvm.c
> +++ b/target/mips/kvm.c
> @@ -196,9 +196,7 @@ int kvm_mips_set_interrupt(MIPSCPU *cpu, int irq, int level)
>       CPUState *cs = CPU(cpu);
>       struct kvm_mips_interrupt intr;
>   
> -    if (!kvm_enabled()) {
> -        return 0;
> -    }
> +    assert(kvm_enabled());
>   
>       intr.cpu = -1;
>   
> @@ -219,9 +217,7 @@ int kvm_mips_set_ipi_interrupt(MIPSCPU *cpu, int irq, int level)
>       CPUState *dest_cs = CPU(cpu);
>       struct kvm_mips_interrupt intr;
>   
> -    if (!kvm_enabled()) {
> -        return 0;
> -    }
> +    assert(kvm_enabled());
>   
>       intr.cpu = dest_cs->cpu_index;
>   
> 

