Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3762C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 11:21:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76146206E2
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 11:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbM13EFU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76146206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfiVu-0002US-P5
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 07:21:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42872)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jfiVH-0001nc-M0
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 07:21:15 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:55902)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jfiVG-00032Y-R2
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 07:21:15 -0400
Received: by mail-wm1-x341.google.com with SMTP id c71so10291305wmd.5
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 04:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=pFN706MIghkMXR5z4Zf/k/9M2yHdLL0Xq5tQTIr7+Mk=;
 b=bbM13EFUEBKXygTPeMmzLXEw/k8tcBebg2ZZfQv/DoUZvqGD2E5lQCupeChkZ5k6lo
 A5urx88PZnQQWpI6+xTqmCj7n4P21GzBKSyWuW5q+1WB+wglCImEJO004cBxGpCgDDfz
 QJxwHi8/2yunelXUBFNFVeov2I84+qa+cOfq4FWX35hfltMsc+0oVU3NI/WR1Wtm6AYw
 PjOKOTqJe7uFPp+/FnvLNo7EbtMcenD1acpbm3JTBJU7aE9mZhlbwB39zl0EPaCQx+Nu
 q81xYU8CCyCUndOCKt7Mh6ABthmDhsiHTdkcYiwv7/vnlem0beUNEDpv2M5uiZe9BWh3
 lzSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pFN706MIghkMXR5z4Zf/k/9M2yHdLL0Xq5tQTIr7+Mk=;
 b=nFzQc3887L566fQv8b00kKCnEYYeK4rTA0vqTUCYn8RRHzKiy/pl91+0ex4C1uBtTE
 oxvKGplZkK+EeCVK0nRbRxB/SUSI02b3KpJUw7GjbmPyx/JNBM9slsm4w2vLIf2tGgEZ
 +RvWXsO3YWn+G52pNDfrXO+2V+ywthzl82HSWUvoHeQDE/0fxXrtsnwu2uynnhn26bLW
 knse4Y0jXaSqMZ2VF61l1Y46dVXWouKJDkd6oHtgdxHcY4Uf+i+WkjALMllqxPilUqbH
 AykkaHBfw0ReXJkgDHxB32hPdLLt68Ez+9MOSBc7ecDd4NBwM+rWsCfEFWeAv0Z9w/fc
 CX+g==
X-Gm-Message-State: AOAM533/9+ug5XSw0TS6CJegxYJ3S29cJcMpdLwGP2h6x/1tf6CBqE+i
 uL6IbJq6dP4QtSUKl8u/WBg=
X-Google-Smtp-Source: ABdhPJy8XnQVu+B5WDEiHJ1kzjS0Oo+PqA0VH3zg1Af8IY0NfV7WiPnDzVnj+kpj+CLMGHO5x+DLUA==
X-Received: by 2002:a1c:28c5:: with SMTP id o188mr20318993wmo.62.1591010473374; 
 Mon, 01 Jun 2020 04:21:13 -0700 (PDT)
Received: from [192.168.1.34] (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id p10sm21648979wra.78.2020.06.01.04.21.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2020 04:21:12 -0700 (PDT)
Subject: Re: [PATCH 0/3] exec: Kill CPUReadMemoryFunc/CPUWriteMemoryFunc
 typedefs
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200601075400.2043-1-f4bug@amsat.org>
 <CAFEAcA_bpWQr+ztbrYc03Kij8wwAJ2fm5v-Bi8Q3viApWvjW6A@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f6fde676-abee-8aca-fa21-b4a52c36fa44@amsat.org>
Date: Mon, 1 Jun 2020 13:21:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_bpWQr+ztbrYc03Kij8wwAJ2fm5v-Bi8Q3viApWvjW6A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/1/20 12:35 PM, Peter Maydell wrote:
> On Mon, 1 Jun 2020 at 08:54, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>> Followed Peter's suggestions:
>>
>>  * delete the unused MmeoryRegionMmio
>>  * move these typedefs into include/hw/usb.h and rename them
>>    to MUSBReadFunc and MUSBWriteFunc, since that's all they're
>>    used for now
> 
>>  include/exec/cpu-common.h |  3 ---
>>  include/exec/memory.h     |  6 -----
>>  include/hw/usb.h          | 30 -------------------------
>>  include/hw/usb/musb.h     | 47 +++++++++++++++++++++++++++++++++++++++
>>  hw/usb/hcd-musb.c         |  5 +++--
>>  hw/usb/tusb6010.c         |  1 +
> 
> I think we usually would give the .h file a name matching the .c file,
> so include/hw/usb/hcd-musb.h ?

Indeed, I'll update.

> 
> Either way, whole series:
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Thanks!

> 
> thanks
> -- PMM
> 

