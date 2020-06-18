Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7642EC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 23:30:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CB4F2080D
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 23:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h1Ch18t7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CB4F2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jm3yp-0008Rq-FB
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 19:29:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40256)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jm3yD-0007ws-5i
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 19:29:21 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:34553)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jm3yB-0000pr-4H
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 19:29:20 -0400
Received: by mail-pf1-x443.google.com with SMTP id z63so3568543pfb.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 16:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=6yhwjBj5hehI1xsR228P7oqb1tMpv+/KQXBGhkoZEgo=;
 b=h1Ch18t7gZ1zWRA8LyarB/N8h80KLaklsJmyz1mD6j6EV8wqffjkitD3sXssVTUcPe
 dElYA8aOyNdMauxRWXZvLO99LGJZ/wWZ99kkGxxFpD4nDKc8+fOD9RWuxiqYBbKsv/XG
 HyqjaNMe4Inuz9mgYcwwF5q0lKjtWwIeiJOJiLH4b/Ge8CQN6fx0p+UK6upsfnFanTtx
 7U/pi6ZntwdlHy7vFSTWjOMqgEig6rLVdxnV8y72yGn2EmEwcc1RRz51k4Mu5X2cg/34
 nFAj5A5lMb3uFsanO3JMw+yn98LhUTVh0PMXWQa4Z7FZEvoVOtWtktycfdGSXmsPOFN4
 J2Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6yhwjBj5hehI1xsR228P7oqb1tMpv+/KQXBGhkoZEgo=;
 b=soGAfc+waood0IKNVWZBrfI3NAFOkHk5AkMtCkmTTmR03cU8Xk4DIAEi/h/JpZnT7Q
 xMDaVBzWU/+NT2vyGtXMctyHF8qTxyCmXxnnr2XajjJiIDiSLCDoyVi/omR05bnB8QSo
 z09hy2KlqjVmGla/8V0fY3mnOuRKyHjfj3rHXz1zEiLtkxRyeerMpiEkdntSpu+dsaIy
 0HToh2/ZOaVLKZuNnwpWq+bLNqX9LkUFWKQ7MaPQWv7H4P0YrDUiBz/+pxlV7ZXL1yuZ
 ZgXvXI40+8XqKGDJtw5wXwiZ1799D5kDnLeQq8Px/FswWyEi567Qx8o6EGW7+b0ApNVJ
 T1jA==
X-Gm-Message-State: AOAM532hmPjYN93E0bNoLkW5WQMPKE5+8w93oToBlKELsiZAEMD8cNJy
 kUo+XOaLPCIpFGB2yHU0/z/DwixP58k=
X-Google-Smtp-Source: ABdhPJxKnvWSnGXX6dkOx//eB/7h8+oDWjSO1nlsjq48UZpOzpV8SQeStBlfwWWR0n1P3/ls0PB6vg==
X-Received: by 2002:a63:4d5a:: with SMTP id n26mr788787pgl.85.1592522957268;
 Thu, 18 Jun 2020 16:29:17 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id i26sm3771080pfo.0.2020.06.18.16.29.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2020 16:29:16 -0700 (PDT)
Subject: Re: [PATCH 3/6] targetc/ppc: add vmulh{su}w instructions
To: Lijun Pan <ljp@linux.ibm.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
References: <20200613042029.22321-1-ljp@linux.ibm.com>
 <20200613042029.22321-4-ljp@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0777c1df-6010-ff2a-2bdf-72c381da7cbf@linaro.org>
Date: Thu, 18 Jun 2020 16:29:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200613042029.22321-4-ljp@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/12/20 9:20 PM, Lijun Pan wrote:
> +#define VMULH_DO(name, op, element, cast_orig, cast_temp)		\
> +    void helper_vmulh##name(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)	\
> +    {									\
> +	int i;								\
> +									\
> +	for (i = 0; i < ARRAY_SIZE(r->element); i++) {			\
> +		r->element[i] = (cast_orig)(((cast_temp)a->element[i] op \
> +				(cast_temp)b->element[i]) >> 32);	\
> +	}								\
> +    }
> +VMULH_DO(sw, *, s32, int32_t, int64_t)
> +VMULH_DO(uw, *, u32, uint32_t, uint64_t)
> +#undef VMULH_DO

There's no point in calling the macro "VMUL" and then passing in "op" as a
parameter.  Just inline the multiply directly.

Also, fix your indentation.


r~

