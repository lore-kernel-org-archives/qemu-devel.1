Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD3D2C388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 09:22:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06F152192A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 09:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sb8ZgQrH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06F152192A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVtGr-0006i2-Qv
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 05:22:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55916)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1kVtFV-0005Uw-OC
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 05:20:39 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:44388)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1kVtFT-0007FC-Ta
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 05:20:37 -0400
Received: by mail-lj1-x242.google.com with SMTP id a5so792529ljj.11
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2020 02:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=SdYhznL+gDWQptJESVss5N7QJK7OSdgGQC5qmRJTYPs=;
 b=Sb8ZgQrHiv68FjlUtuRP/beTA9Pp3n4Mcb9xxlg8dWLx8BmuvBo4JTGuVFb/pGGk0d
 V9wwEFqxvmAjYQtcEHAcDThC5Y8dlROrFzH+5mBrM4IBL9sdz6NPCdkSuNTCX1+iUVOx
 e3CyimvYdiEWiJ/XRmJvHJNgJQb4Wl+Nc6DnldfhYmaOOxMi0RbIW/X4oOR5O35ujvm7
 3vlr/PNKmuNAO5TWrT0HwiUF1lfcazUGxcah8TrySLDXinDfRW4NuIk2iVFUZJf90mPH
 rj9QX6fjCAIJUwqiDOFDdsAjLjvJIHg3IofTPdM8MX7E9fwKrmsNn5F5lcSvNC3m0ySh
 hTyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=SdYhznL+gDWQptJESVss5N7QJK7OSdgGQC5qmRJTYPs=;
 b=UM7dBwZk2Uhp6gIt5Z8z1QYQ5ici0TCXg+ynkCwii+nnZozdcXVOhnqxG6Fm+jfHJU
 jj5JHQaHae2UQrAcKGPKlCBTP9EeF8NGmE5vOdyIyAUyKg6vXgCID/Ap5VIieaFHtX+O
 +OuGjAUa+9adsjyfTuUXxzCYchJ7V9s2kCWNziNxjuUBIFWQmpoRUC8SfDyXw8HMLrUV
 SQhWdk7gy7jx/JNrsRrNJDGNJqANGN6dDwhzjlbgK77yCzktRVxDHs3Hz2DSW/QLpPJM
 CniWpR3745PX2em6pxbo9bker3Dtq2en9rzM+Nv/MSZR29exuLYsM6ZuSCaRihuvHrjU
 9krw==
X-Gm-Message-State: AOAM533j/Ob7TYhNm+pZNYCUVLevB1g/rCa8uewVHMI37Va7tBNztk0J
 rE/8nqpP9t7rfuc3xZm5I6A=
X-Google-Smtp-Source: ABdhPJxwBMTG0r7u+HTNT5Q2OXCAgpRCWyU6qZXx7cx7hWQ18y7S3loqg9Irj9J95J46Jh2ho1cATw==
X-Received: by 2002:a2e:9bd2:: with SMTP id w18mr496593ljj.186.1603444832542; 
 Fri, 23 Oct 2020 02:20:32 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id c26sm106538lji.18.2020.10.23.02.20.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2020 02:20:31 -0700 (PDT)
Date: Fri, 23 Oct 2020 11:20:27 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
Subject: Re: [PATCH] hw/arm: fix min_cpus for xlnx-versal-virt platform
Message-ID: <20201023092027.GH2954729@toto>
References: <160343854912.8460.17915238517799132371.stgit@pasha-ThinkPad-X280>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160343854912.8460.17915238517799132371.stgit@pasha-ThinkPad-X280>
Received-SPF: pass client-ip=2a00:1450:4864:20::242;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: peter.maydell@linaro.org, alistair@alistair23.me, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 23, 2020 at 10:35:49AM +0300, Pavel Dovgalyuk wrote:
> This patch sets min_cpus field for xlnx-versal-virt platform,
> because it always creates XLNX_VERSAL_NR_ACPUS cpus even with
> -smp 1 command line option.

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>



> 
> Signed-off-by: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
> ---
>  hw/arm/xlnx-versal-virt.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
> index 03e23201b1..ee1282241e 100644
> --- a/hw/arm/xlnx-versal-virt.c
> +++ b/hw/arm/xlnx-versal-virt.c
> @@ -561,6 +561,7 @@ static void versal_virt_machine_class_init(ObjectClass *oc, void *data)
>  
>      mc->desc = "Xilinx Versal Virtual development board";
>      mc->init = versal_virt_init;
> +    mc->min_cpus = XLNX_VERSAL_NR_ACPUS;
>      mc->max_cpus = XLNX_VERSAL_NR_ACPUS;
>      mc->default_cpus = XLNX_VERSAL_NR_ACPUS;
>      mc->no_cdrom = true;
> 

