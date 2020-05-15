Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF220C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 08:08:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96B4A20657
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 08:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PorXFlv6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96B4A20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZVOH-0003db-Q4
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 04:08:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jZVNh-00039f-QN
 for qemu-devel@nongnu.org; Fri, 15 May 2020 04:07:45 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:55374)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jZVNg-0003Fo-VZ
 for qemu-devel@nongnu.org; Fri, 15 May 2020 04:07:45 -0400
Received: by mail-wm1-x341.google.com with SMTP id f13so1327230wmc.5
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 01:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=vM/6IYm4ycFfvaOmQSdqIBED+vD4JDV550AD2JvoFsA=;
 b=PorXFlv6+ObpSuAZ008vws5UFHhnFnLMXOfS3kWzloUXR8Ix5y4ZPnfA5PBQSlL7ms
 Ka9SaN0H/+OHGQvVD/+F4LcpmiHS8U90S+tkF+zcwKoDn/4WD/RUS4CBrFYxEY9L15Tw
 7pkYbDZ3RzYcRLF4nnKX7oe4lQ0JlwX1jNOsHgfu2i481aVw2XQFtfMcDob3Qo1mKJWS
 xQ8bSzZMcF1CG/QQPN80wK4fvb2mt6Q6EUEqrXyh41iCz/Pt2EiWe2kq8sns+alA2fq3
 Oir+UNKEwLCTaOes7gRjT82aaD7TgmuNT/CHrejDkNqc1pHCI6Abgf259KEFnS+1QRem
 i7WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vM/6IYm4ycFfvaOmQSdqIBED+vD4JDV550AD2JvoFsA=;
 b=TgcpyAYfPOv7EERFS26s93aZm7gMlTEQVLRn4nC96ErBYq4+GEn1+NglzJ8uHcNm+I
 XYnux2qnq77WZw1YMdp9IRorLLtRXsZojyCLcSJ1OJhgpltnuw+w/SK5a3jIEtolItXU
 h9g+JurI5Y5kL+e0OcaQMo7E0nyoHNzDkScfGNjDar1fx+wO1YwV1ZEyHyqXSw7Wndpb
 WpTUEq1DSBYeXxPfYXVwVJALmFviiEW0p8XQMvUFEZBm4wIU+MdNQGGQuBgHs2VUgGWa
 Z3gJ0zqoyGCg1UvOfUaHTXQCBrTY28MOCmez27lenwPzM3GjF7lYvejtWrqHOB9+Phe+
 3G4Q==
X-Gm-Message-State: AOAM532nXfRvMrynBjW4Fr4u9/wrwssLJDsEJ0IovDH2t4CKLalJm3Ju
 nGwv8wQWHue4bDbQZZ2NoyhAm6jCvMM=
X-Google-Smtp-Source: ABdhPJyBysbz9VCYl6R9DCBVtCsxCc67Ak4rJmklChxkAe5ySf09HjR/rSXeITGJoxYv9u3ivk7/5w==
X-Received: by 2002:a05:600c:2614:: with SMTP id
 h20mr2729682wma.155.1589530063269; 
 Fri, 15 May 2020 01:07:43 -0700 (PDT)
Received: from [192.168.1.39] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id e22sm2509042wrc.41.2020.05.15.01.07.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2020 01:07:42 -0700 (PDT)
Subject: Re: [PATCH v5 2/7] dwc-hsotg (dwc2) USB host controller register
 definitions
To: Paul Zimmerman <pauldzim@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>
References: <20200512064900.28554-1-pauldzim@gmail.com>
 <20200512064900.28554-3-pauldzim@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5c445de9-14d0-f4fd-2419-6a0401501423@amsat.org>
Date: Fri, 15 May 2020 10:07:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200512064900.28554-3-pauldzim@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/12/20 8:48 AM, Paul Zimmerman wrote:
> Import the dwc-hsotg (dwc2) register definitions file from the
> Linux kernel. This is a copy of drivers/usb/dwc2/hw.h from the
> mainline Linux kernel, the only changes being two instances of
> 'u32' changed to 'uint32_t' to  allow it to compile. Checkpatch
> throws a boatload of errors due to the tab indentation, but I
> would rather import it as-is than reformat it.

Thinking loudly, should this go under linux-headers/?

> 
> Signed-off-by: Paul Zimmerman <pauldzim@gmail.com>
> ---
>   include/hw/usb/dwc2-regs.h | 895 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 895 insertions(+)
>   create mode 100644 include/hw/usb/dwc2-regs.h
> 
> diff --git a/include/hw/usb/dwc2-regs.h b/include/hw/usb/dwc2-regs.h
> new file mode 100644
> index 0000000000..96dc07fb6f
> --- /dev/null
> +++ b/include/hw/usb/dwc2-regs.h
> @@ -0,0 +1,895 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)

Can you use QEMU /* style */ for this single line please?

> +/*
> + * hw.h - DesignWare HS OTG Controller hardware definitions
> + *
> + * Copyright 2004-2013 Synopsys, Inc.

Please add also "imported from Linux kernel file drivers/usb/dwc2/hw.h 
of commit ...".

> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions
> + * are met:
> + * 1. Redistributions of source code must retain the above copyright
> + *    notice, this list of conditions, and the following disclaimer,
> + *    without modification.
> + * 2. Redistributions in binary form must reproduce the above copyright
> + *    notice, this list of conditions and the following disclaimer in the
> + *    documentation and/or other materials provided with the distribution.
> + * 3. The names of the above-listed copyright holders may not be used
> + *    to endorse or promote products derived from this software without
> + *    specific prior written permission.
> + *
> + * ALTERNATIVELY, this software may be distributed under the terms of the
> + * GNU General Public License ("GPL") as published by the Free Software
> + * Foundation; either version 2 of the License, or (at your option) any
> + * later version.
> + *
> + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
> + * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
> + * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
> + * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
> + * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
> + * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
> + * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
> + * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
> + * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
> + * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
> + * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + */
> +
> +#ifndef __DWC2_HW_H__
> +#define __DWC2_HW_H__
[...]

