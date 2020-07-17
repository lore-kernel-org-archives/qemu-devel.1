Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC305C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 18:39:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8681920704
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 18:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="svGLgEhG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8681920704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwVGd-0000X5-P4
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 14:39:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42978)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jwVFl-0008O1-7i
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 14:38:37 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b]:34612)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jwVFi-0003BS-Tw
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 14:38:36 -0400
Received: by mail-pj1-x102b.google.com with SMTP id cv18so4316327pjb.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2020 11:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=i1g+2o8hoVIZpaiWtNVjo1AhqeO5g2dgbSDo0QrTVm4=;
 b=svGLgEhGYDVQO2INjp54MglwzuCWf3Beda6GnmgWFYiCtF+PVbJoXXuGzTCLA8HTCZ
 cKfaU8sDe3sKGNy7Yx4u1YBte4GlkRJI+0XMRGwXAubhPkGDtxYDyanvikv3WQXAK1QA
 1tr/z/hXJzZgAaDI/zyCeVC7aMMAuI9oRLdrhGh2mfVbTkHjQLTeBspCDbqG7zXB4NN8
 eWVnDSWgbBT+FSVkuIQMMb27tiNCXwkB7h5E5LoqMPrM77bnzOnOTkbAatxpCBoXR1jv
 2D+86Phs2JHKNxF1qZmnEbA3Yj8waPCyppNGC3csw3sbA8ZSxJcw1QKAaRdU1DbE5cFK
 aPjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=i1g+2o8hoVIZpaiWtNVjo1AhqeO5g2dgbSDo0QrTVm4=;
 b=AOQ02oHEO1B8qIMk92yJtOw1uTU1K2Ouy8cYTnVN47QYEKYy4kVMSZ6zL+VHFhXekJ
 qFX5wg/zcOqYFry+hbthORbEq7+Qj7Z8nET3NAdWLVDgasL9YA/osyqiPA4yq68igRWB
 bhH3s2ONGrPSKRq+jePVxmkSSMs6F0V0A6o5Dkbf1bHxeaCOYG0HwIMeXGGRzNCYb7TI
 qNzH7fxiaHCDXBLhiVcDE0pTfrUfuymJk32E5DyYLgxl7rZqi+n/36wuLddMugGLv4Kc
 8FZqYs3x/KWxvskuo6pQh92F2APITHAemqpzm5nghCS3ciqhFz/QDI35amFkthBPGIdI
 OvKA==
X-Gm-Message-State: AOAM530hRtesSxrMLeJypQvl1TSu+4TgXN3UMwkUzHMEGnGy/POCG5cG
 Gy/o8Nb2x9JXdcGUC3dQW6OT7w==
X-Google-Smtp-Source: ABdhPJxS3SmYinXwI9IgE6/XfjqEaFvcduUcv86OJjpaBkIdYLkBMHwUY12GBhboGayZ++1EytI0SA==
X-Received: by 2002:a17:90a:ff16:: with SMTP id
 ce22mr11767709pjb.160.1595011113227; 
 Fri, 17 Jul 2020 11:38:33 -0700 (PDT)
Received: from [192.168.1.11] (216-160-65-90.tukw.qwest.net. [216.160.65.90])
 by smtp.gmail.com with ESMTPSA id
 2sm8778124pfa.110.2020.07.17.11.38.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jul 2020 11:38:32 -0700 (PDT)
Subject: Re: [RFC PATCH-for-5.1] hw/pci-host/q35: Ignore write of reserved
 PCIEXBAR LENGTH field
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200717181724.27493-1-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <edf80e5a-b698-b9dc-f867-8fa920f41786@linaro.org>
Date: Fri, 17 Jul 2020 11:38:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200717181724.27493-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Alexander Bulekov <alxndr@bu.edu>, qemu-stable@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/17/20 11:17 AM, Philippe Mathieu-Daudé wrote:
>      case MCH_HOST_BRIDGE_PCIEXBAR_LENGTH_RVD:
> -    default:
> -        abort();
> +        qemu_log_mask(LOG_GUEST_ERROR, "Q35: Reserved PCIEXBAR LENGTH\n");
> +        return;
>      }

Did you really want to remove the default case?

I guess the mask means that only *_RVD is left over, but the default sorta
self-documents that.

Either way,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

