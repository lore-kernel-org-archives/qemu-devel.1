Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42077C00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 16:22:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7289520719
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 16:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p8In6fQS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7289520719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYXAF-0006aS-8B
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 12:22:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51172)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kYX9W-00068w-Gk
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 12:21:22 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:37045)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kYX9R-00005a-5b
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 12:21:21 -0400
Received: by mail-pl1-x641.google.com with SMTP id b12so3198206plr.4
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 09:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=v6DMkAk9rzxcVpG0lFTErhiJaEWWLHIzE+pMe9PhI+Q=;
 b=p8In6fQSZWNjGnaT/DQuEDQJH21uwujcYfbqjPioFT6FSV+jVxlO1FMNs2kCeBuZxB
 Nk7hW2YTZNTPgzvtkygYj/QfDTNE/qIz1y68tftwMRu6sBMhHHGH86mzWZoSKCTGxxrB
 fBax0KU0TD5g7w56rkVMhCc8+l8k/IRpjN3gUKMr/vPOt84pkeiWfwPXfSFPv+gO1veY
 E2XHRmEip+8mQJQAvJEnnh7sUUOqsi3bszzunxCfLG62f9uDIFYMwBnATaqXynJn4v4N
 l3EyjW5fHJe14pGgOCsT2VEHY6DLzX1yta78aEa0NWfB/Nl0dRmUCDc7nkNuZUqfCr3j
 SIcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=v6DMkAk9rzxcVpG0lFTErhiJaEWWLHIzE+pMe9PhI+Q=;
 b=JHrlvIjuV2NE9O5kiQv7IHgL9/oOVLkO8iNMq1/pF2IsffJY5EB/qfLnJqwEYBXJWt
 HfzPThcUUVI5514Yl1KHED92zW/QgXKGfddJVRRVUCTYRAmlmm+LXjArVd//4sYAyviH
 1IkhaQlXqudO/4rzsaF66X3ZtZpX7mgQTbPggN0+Q9689OeN66BCdxiAhwNlw0MXGFKY
 jHnjOQGc9w3cBGZBPLI1lIFCAUYHXSmcFtsUIBA/xhHsNuHtVmCfwwCsDwzXbvNTMvqi
 Rt673/zncnuSOScb39SRi+bVFIqOTIBApE1SEp1/DqOVRrU6TguKBamWF+DEs2stgtSJ
 CteQ==
X-Gm-Message-State: AOAM531a4uXxPHm40IXK3U9d4dGbBNEgs3/8wLnZwx3cldSckqvQcLo/
 5lJMDxhowPwFCA5ZVA+gNBdy3w==
X-Google-Smtp-Source: ABdhPJyVUEabIWbp3fvwK9/j0shgtIpUa6W2baK+ANG0KZj+N6o1NE8wJEghNItst+8EhaxEYxn02A==
X-Received: by 2002:a17:902:ab94:b029:d6:9c3:e99e with SMTP id
 f20-20020a170902ab94b02900d609c3e99emr9581333plr.68.1604074875279; 
 Fri, 30 Oct 2020 09:21:15 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id l18sm6494855pfd.210.2020.10.30.09.21.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2020 09:21:13 -0700 (PDT)
Subject: Re: [PATCH] target/s390x: fix execution with icount
To: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>, qemu-devel@nongnu.org
References: <160404699734.17100.6515653500382355060.stgit@pasha-ThinkPad-X280>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <fd06fcf1-3850-3858-5e02-908d642d5229@linaro.org>
Date: Fri, 30 Oct 2020 09:21:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <160404699734.17100.6515653500382355060.stgit@pasha-ThinkPad-X280>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.253,
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
Cc: thuth@redhat.com, cohuck@redhat.com, rth@twiddle.net, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/30/20 1:36 AM, Pavel Dovgalyuk wrote:
> This patch adds some gen_io_start() calls to allow execution
> of s390x targets in icount mode with -smp 1.
> It enables deterministic timers and record/replay features.

Thanks for pointing this out.

There are enough of these that I think it would be worthwhile to annotate them
in insn-data.def instead, much as we do for privileged instructions with IF_PRIV.

Perhaps call it IF_IO?


r~

