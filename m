Return-Path: <SRS0=SwYc=4S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D69C3F2CD
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2020 18:37:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FAB2246B9
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2020 18:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rjSBcTi5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FAB2246B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8TSw-0002VK-MV
	for qemu-devel@archiver.kernel.org; Sun, 01 Mar 2020 13:37:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38741)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j8TSN-00022y-Mz
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 13:36:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j8TSM-0007Ip-DF
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 13:36:51 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:42697)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j8TSM-0007Ib-6V
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 13:36:50 -0500
Received: by mail-pf1-x441.google.com with SMTP id 15so4404379pfo.9
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2020 10:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=rHD5Ziw47sHLGVuGTJjhnC2FvKM1d3tGTev96vvVnDw=;
 b=rjSBcTi574tDw/Fdr2aPs8GItUEB8ZAwiD5XX9P/dOBsFlRIvlcsP0/2be4LkCYYQS
 tpDNfb/iW/eMlmBJl2v+y6JtL0aLIPRDFeufNOC3LpNxjUk2vIKCWXAylVIMeHQfeER2
 COtJ5yGgHQwLDC1Pm5fU9WPJN8yA65LuxOgqYV6Q0lWMjuN2AQuItZuhLkqmattZUA8T
 5zXSOc4fpdxUURY0hkmx/2JZqb+tnx2wM4QBrRaxihXentAKXAiWdW3CSFmf7ucK8rsb
 zYIKMgyUlFYCfSTcHgE7JnbAMpgibYTyZ9nmaUCV6EAU33jVMiiDYA4Mas/yg8Wqjl3Z
 FnyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rHD5Ziw47sHLGVuGTJjhnC2FvKM1d3tGTev96vvVnDw=;
 b=jLtpFLZ/xsXyP9YdkibHc0I4AFuAhwgTa0H1nX+xPKn1siEusLaEocADp7u+O8JC2k
 TnH7LENiVV0bVGMXM+JDNLTbxeDr8DnRycBfwk8I+ekIOd8Js/mVknF8cw486PbqBMg+
 m3MagWwCcSuMQyYZfwGxLc8eOeVIO1/rNW2wOjA7JHUesGhhVZnibTpQ3PHx99iic0n6
 ASj8aEx6C7PaZ+kpvZeUB4iSLKR7l+tB9+M0ARK2k0V1PFBAH5MjNFAOOFRKzDB5gDXx
 Nkrfyejyczmz+o0vJ45chMa1TNo1C3ttgOcoGApAuFPWPow2eyHFsthM0s2vZMRYtQXg
 joYA==
X-Gm-Message-State: ANhLgQ1oY6h6c/I3ryQp/YFeRCLq8YeK546sR2LTNv0AR9pWa5hOZZCJ
 6wPC0Y3ESLrNpPZxpO+va8JcUQ==
X-Google-Smtp-Source: ADFU+vu5R6J16RQTim3yuX/8visM2Z6cXVUfhug1Qu31ib5F3F7STp8MQBzpVQxCtOlEWUzkQAXAXQ==
X-Received: by 2002:a62:7bc5:: with SMTP id
 w188mr10266803pfc.207.1583087808562; 
 Sun, 01 Mar 2020 10:36:48 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 w17sm17778246pfi.56.2020.03.01.10.36.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Mar 2020 10:36:47 -0800 (PST)
Subject: Re: [PATCH] i386: Fix GCC warning with snprintf when HAX is enabled
To: Julio Faracco <jcfaracco@gmail.com>, qemu-devel@nongnu.org
References: <20200301163523.13581-1-jcfaracco@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e1cbcfca-2faa-9860-3e14-8f67f7d798c5@linaro.org>
Date: Sun, 1 Mar 2020 10:36:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200301163523.13581-1-jcfaracco@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/1/20 8:35 AM, Julio Faracco wrote:
> When HAX is enabled (--enable-hax), GCC 9.2.1 reports issues with
> snprintf(). This commit is checking if snprintf returns an error. This
> is a simple way to avoid this warnings.
> 
> For more details, one example of warning:
>   CC      i386-softmmu/target/i386/hax-posix.o
> qemu/target/i386/hax-posix.c: In function ‘hax_host_open_vm’:
> qemu/target/i386/hax-posix.c:124:56: error: ‘%02d’ directive output may be
> truncated writing between 2 and 11 bytes into a region of size 3
> [-Werror=format-truncation=]
>   124 |     snprintf(name, sizeof HAX_VM_DEVFS, "/dev/hax_vm/vm%02d", vm_id);
>       |                                                        ^~~~
> qemu/target/i386/hax-posix.c:124:41: note: directive argument in the range
> [-2147483648, 64]


The code bounds vm_id from the top (64) but not the bottom.  The compiler has
(correctly) determined that negative values will overflow your buffer.

I suggest either an assert vs negative values as a local change, or to change
the type of vm_id (universally, if possible) to an unsigned type.


r~

