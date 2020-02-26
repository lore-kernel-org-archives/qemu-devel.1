Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF2DDC4BA24
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 20:17:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A583A21D7E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 20:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="azI04b+8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A583A21D7E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j737F-0001NS-Rb
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 15:17:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52628)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jimw@sifive.com>) id 1j736N-0000oH-86
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 15:16:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jimw@sifive.com>) id 1j736M-0007Rw-1c
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 15:16:14 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:44649)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jimw@sifive.com>) id 1j736L-0007O8-Ow
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 15:16:13 -0500
Received: by mail-pf1-x444.google.com with SMTP id y5so319174pfb.11
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 12:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Nok9qv+wkzhDcKoXaJgQjFCCfdLB1x47k3synkZL/A0=;
 b=azI04b+88s5jkPhAG5Z5fRq0bxOC6dPyqfTgq6uiGjEOOu2+pMrDt8CK8nTUPEp8RW
 dZWPqU3jV3SSw0dd7eNxwYh2IY1/yxIAoiBqgdmMK/HUzSdowvLomo14bta2uWOmQbE4
 go9N7M/ofrtSXa2B2HnCTRwnc8oM9XDaOVR/KDC1CTgl/Bqak9fGvq8hnW07KkBsG0zv
 NQAqpdprodiSuBq4YdY+6WpM0x6Y4bhoJ7vWJIkfJiDyZan1kv79ELD/bNFDJZ/zW9AN
 wRZzEg+NieEu/TkxGgAaUqWuMaTivzo35MZG+s+oF8CQDg8HSGqraX/5ABK4uM1/IdW2
 NuNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Nok9qv+wkzhDcKoXaJgQjFCCfdLB1x47k3synkZL/A0=;
 b=cSW1xcKzo5VInWb+wyc4Y7sPJvwAfwGxlnpgRD1Y5zemN2N7IMLi4AkV+4eQHH4L3E
 0/sCS/IQizu8k5tPkNfyWxIaXpT2kiNf0ELPjcBJdRE9+e1c5Es2q6SeLeLNtHr06JdP
 Qe0imrjK49II68ew8Y3YTe1IGD+r5QcqL5pu0kqY3mrjWIxh9reS23vNpzr1i7Rg6X4x
 HqOp2mxa3dUgd1ceuzevXlob+EPxdIoDdADsusWNk2JSaZ0Sj0VKUD/QiWpjtThvZF4W
 L3AyPvF84G1YagQfG9u/t8dXiAwAee1dg64Rp4QqKKQvJGVqcVxFZrDerD+8hjOsprMI
 Jvdg==
X-Gm-Message-State: APjAAAVsRov8RRtA0+4jSrkFWhojrU95u7OJSzKhN9Vp/KRr22YXA/pM
 h9FmVyQwOGBVvXy5MUXWysmIjw==
X-Google-Smtp-Source: APXvYqxlWgSsZY9En9EsJfZ4j5n2IuJKa+L/RZoEOX65jnQ4m+TxlIK7JJsmDIpmL6WMFpSw5DTLOQ==
X-Received: by 2002:a63:921a:: with SMTP id o26mr559819pgd.246.1582748172556; 
 Wed, 26 Feb 2020 12:16:12 -0800 (PST)
Received: from [10.17.0.226] ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id w184sm3394544pgw.84.2020.02.26.12.16.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2020 12:16:12 -0800 (PST)
Subject: Re: [PATCH v5 3/4] target/riscv: support vector extension csr
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, richard.henderson@linaro.org,
 alistair23@gmail.com, chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200221094531.61894-1-zhiwei_liu@c-sky.com>
 <20200221094531.61894-4-zhiwei_liu@c-sky.com>
From: Jim Wilson <jimw@sifive.com>
Message-ID: <39e7abd9-bd5e-5114-975a-5bd3161c6690@sifive.com>
Date: Wed, 26 Feb 2020 12:16:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200221094531.61894-4-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Cc: wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/21/20 1:45 AM, LIU Zhiwei wrote:
> +/* Vector Fixed-Point round model */
> +#define FSR_VXRM_SHIFT      9
> +#define FSR_VXRM            (0x3 << FSR_VXRM_SHIFT)
> +
> +/* Vector Fixed-Point saturation flag */
> +#define FSR_VXSAT_SHIFT     8
> +#define FSR_VXSAT           (0x1 << FSR_VXSAT_SHIFT)

These bits have been moved into the new VCSR register.  And the offsets 
are wrong because these bits are no longer above the FP status bits in 
the FCSR.  So this needs to be rvv 0.7.1 specific.

> +/* User Vector CSRs */
> +#define CSR_VSTART          0x008
> +#define CSR_VXSAT           0x009
> +#define CSR_VXRM            0x00a
> +#define CSR_VL              0xc20
> +#define CSR_VTYPE           0xc21

This is missing two new CSRs, VCSR and VLENB.

> +    /* loose check condition for fcsr in vector extension */
> +    if ((csrno == CSR_FCSR) && (env->misa & RVV)) {
> +        return 0;
> +    }

This is wrong for the current spec, because the vector status bits 
aren't in the FCSR anymore.  So this also needs to be rvv 0.7.1 specific.

Jim

