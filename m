Return-Path: <SRS0=KEGy=6R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E298C28CBC
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2020 07:48:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35A362078E
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2020 07:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMqmmF2Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35A362078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jV9Ml-00056t-CM
	for qemu-devel@archiver.kernel.org; Sun, 03 May 2020 03:48:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcel.apfelbaum@gmail.com>)
 id 1jV9Ln-0004Vl-Nf
 for qemu-devel@nongnu.org; Sun, 03 May 2020 03:47:47 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41809)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcel.apfelbaum@gmail.com>)
 id 1jV9Lj-00058n-UX
 for qemu-devel@nongnu.org; Sun, 03 May 2020 03:47:46 -0400
Received: by mail-wr1-x442.google.com with SMTP id g13so17036943wrb.8
 for <qemu-devel@nongnu.org>; Sun, 03 May 2020 00:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=+Sa5a/v/JrvU7cvwkWZH94gFzpewKp4jXyxSIWZAiW0=;
 b=BMqmmF2ZWvf+uZjgpfUGbBv8rS2sMr8N3o87xA1tyJdNrd8ygFaTCC4uXnB8jADmRK
 VELtJ6SXXFjz082B3Uzzv6Aj7VTYpntuJ1K2PW1jg0hWEN7uZNyHe1XGWU//uXGreFEr
 Hq6mBiPfMS9eONbYIGNbU7f0tu2Ktpormck9BVrHI+ZZHQfWFQvTUWD3hNV6WIG+VPfd
 6Qtv946En4e6dIEnus5k42MfHyY9KSGWFffFQxUVcAMGICA1WLFGtTQ//e2dtxJnvHQZ
 Zi4rWUMARnlKqkg1wH8lQ4PD/w2aJDAWKNsSCadRjHJxYr0NMCdibkHEY45WZPlPJHF7
 9oXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=+Sa5a/v/JrvU7cvwkWZH94gFzpewKp4jXyxSIWZAiW0=;
 b=q6TlIllcxKk5e9dABvpMdvLQ5cgxzPH/1b4DclGi4kg7HzQMlXzP7kzsqczh+tfXpo
 p6SnoFqx+JoHwAoe6Bo0CH8Xca8ArA/1KAzRrZhwiCQ89S1/SiF6++71aWEx0MOAzLRE
 PIl0U6kO0dcCIdk8+DtAK3ayr0Ru0n5GX+hKuMwZtDJwNuSCX3/HPfY2S7d/cO0ymjcr
 /yPqCG+GNgT+2cmicyWrOsE2fkKwFhKTiHNAr7xr6C9M7CyLMpIEa5hzRiYzSDX8BUBu
 VhiYqYiGV26ITxdnWEu9OMoQIeTM8H9Nvfg/ecIhDHaegDKA1ESAJKfMO7CBvzbtfaG6
 WCYw==
X-Gm-Message-State: AGi0PuY6IEymiJMTQspaq8Q/5j8CcpRKMQSDxxLJrVgUJtp4uvppt3Wr
 fFkqkpwFVab2WQURA0NIO/m0akyibfc=
X-Google-Smtp-Source: APiQypLXSl9TKZExXF8AUAFwDsG71mUr7u4egd3j/M+iu8DqCg8T23/xhEPpYeOWJuqWWuaDC1WNZQ==
X-Received: by 2002:adf:aa8e:: with SMTP id h14mr14060721wrc.371.1588492061751; 
 Sun, 03 May 2020 00:47:41 -0700 (PDT)
Received: from [192.168.86.46] ([37.142.144.12])
 by smtp.gmail.com with ESMTPSA id s24sm7836946wmj.28.2020.05.03.00.47.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 May 2020 00:47:41 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] hw/pci/pcie: Replace PCI_DEVICE() casts with
 existing variable
To: Julia Suvorova <jusual@redhat.com>, qemu-devel@nongnu.org
References: <20200427182440.92433-1-jusual@redhat.com>
 <20200427182440.92433-3-jusual@redhat.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <16ad0f06-4b93-9201-76da-185ac37a8dfe@gmail.com>
Date: Sun, 3 May 2020 10:47:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200427182440.92433-3-jusual@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=marcel.apfelbaum@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 4/27/20 9:24 PM, Julia Suvorova wrote:
> A little cleanup is possible because of hotplug_pdev introduction.
>
> Signed-off-by: Julia Suvorova <jusual@redhat.com>
> ---
>   hw/pci/pcie.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index 6b48d04d2c..abc99b6eff 100644
> --- a/hw/pci/pcie.c
> +++ b/hw/pci/pcie.c
> @@ -449,7 +449,7 @@ void pcie_cap_slot_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
>               pci_word_test_and_set_mask(exp_cap + PCI_EXP_LNKSTA,
>                                          PCI_EXP_LNKSTA_DLLLA);
>           }
> -        pcie_cap_slot_event(PCI_DEVICE(hotplug_dev),
> +        pcie_cap_slot_event(hotplug_pdev,
>                               PCI_EXP_HP_EV_PDC | PCI_EXP_HP_EV_ABP);
>       }
>   }
> @@ -490,7 +490,7 @@ void pcie_cap_slot_unplug_request_cb(HotplugHandler *hotplug_dev,
>           return;
>       }
>   
> -    pcie_cap_slot_plug_common(PCI_DEVICE(hotplug_dev), dev, &local_err);
> +    pcie_cap_slot_plug_common(hotplug_pdev, dev, &local_err);
>       if (local_err) {
>           error_propagate(errp, local_err);
>           return;
> @@ -509,7 +509,7 @@ void pcie_cap_slot_unplug_request_cb(HotplugHandler *hotplug_dev,
>           return;
>       }
>   
> -    pcie_cap_slot_push_attention_button(PCI_DEVICE(hotplug_dev));
> +    pcie_cap_slot_push_attention_button(hotplug_pdev);
>   }
>   
>   /* pci express slot for pci express root/downstream port

Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

Thanks,
Marcel

