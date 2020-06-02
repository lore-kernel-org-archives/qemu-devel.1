Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811C0C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 00:07:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49053206A4
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 00:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qmmSlgAF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49053206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfuSN-0001BF-If
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 20:07:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jfuQz-0000Gv-SC
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 20:05:37 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:38632)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jfuQy-0001OZ-VJ
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 20:05:37 -0400
Received: by mail-pj1-x1042.google.com with SMTP id d6so563747pjs.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 17:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=USC0QeRyJ21r34DHkvDccmYpIyA+yP7p3StBtTBk/0U=;
 b=qmmSlgAFgFH23unbu7Dvyqs0D0w1Mswa08bFbkNRh2SYN0K8XafA3hoBHrxlfzmh4o
 e6DGlkKTUb6Ib9qJqhI+ipfkVuYa4aMB+psUrL2Fx1y83M2N0mHyOQPU+zV5a6Svan+O
 6G4m6F4Es25m0Vaffcae4pleIaoPgCRSRsYPHcEW+mdxxSgcZTQ1CT1gPTtnnh0AbYqJ
 he9b1J3rn8VSQTpZ4aZoSf0HRz0K2BAc4C/pxTTKFW8wiAsXQia2yJmu815E5DryKKl0
 wBwzGEViwoq7A1g2o4N7Ra+5xsdeXJrNYX+is/eTN5HjRdIqVAV4GCpfcQuxgfPQ4Jc4
 A+jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=USC0QeRyJ21r34DHkvDccmYpIyA+yP7p3StBtTBk/0U=;
 b=Rmo2a4+/VCurpGLlzaNe+1pep4UZrwQkILZg2EWd6xfsIWtfiSO7t0MLONLcxBtGcF
 ZZ1ruyCvb7DrpfDN+P5EGBZ8ExJhnCEqW4PR6ESbxhsdfvxwhxQ1cHPkBkGnw0InGXXM
 WDPMrq2p5DOncGvxPYMhF+piOOiBq+6Ow6JCyJlC9YkxMlr2aLVP4SdpnN+Znylotn6e
 4q93eYOqwt+7I0wYtRcKCaVv/exDeia8jAiOXqMULiK3Zt771mUtNWabaKdLtPYG6exd
 ZznyX2BjrcjorGRwmJ3lVaHLwoSquvpXZVIWxKxbKLugm5+T/+3n2qJkGNQ+5VNatWcF
 +3/A==
X-Gm-Message-State: AOAM531tdrWNeC2eFX8m1VsLpICgdzTpaMr/dxmd19rptQH05UGYdoUA
 7LKO4lF7BASt3VgHKgUJTXI5Jg==
X-Google-Smtp-Source: ABdhPJyGBcn6STEXlFR7PGOcCoKij32jGYPMcZp+PVbPjfk0IUjltI1fK/jL8nNxRODF1X8ZZ+QVog==
X-Received: by 2002:a17:90a:31c:: with SMTP id 28mr2314407pje.2.1591056334264; 
 Mon, 01 Jun 2020 17:05:34 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id r31sm525338pjg.2.2020.06.01.17.05.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2020 17:05:33 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] hw/usb: Move device-specific declarations to new
 'hcd-musb.h' header
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200601141536.15192-1-f4bug@amsat.org>
 <20200601141536.15192-3-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <74967516-96d3-d113-c38c-bd0f770f4270@linaro.org>
Date: Mon, 1 Jun 2020 17:05:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200601141536.15192-3-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <rth@twiddle.net>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/1/20 7:15 AM, Philippe Mathieu-Daudé wrote:
> Move the declarations for the MUSB-HDRC USB2.0 OTG compliant core
> into a separate header.
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  include/hw/usb.h          | 30 -------------------------
>  include/hw/usb/hcd-musb.h | 46 +++++++++++++++++++++++++++++++++++++++
>  hw/usb/hcd-musb.c         |  1 +
>  hw/usb/tusb6010.c         |  1 +
>  4 files changed, 48 insertions(+), 30 deletions(-)
>  create mode 100644 include/hw/usb/hcd-musb.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~



