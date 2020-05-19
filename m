Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 010BDC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 17:03:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C06C720708
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 17:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J+t2n9bh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C06C720708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb5dw-0006sG-VR
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 13:03:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60796)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jb5bJ-0004X8-Ol
 for qemu-devel@nongnu.org; Tue, 19 May 2020 13:00:21 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:37266)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jb5bH-0000Hq-TI
 for qemu-devel@nongnu.org; Tue, 19 May 2020 13:00:21 -0400
Received: by mail-pf1-x441.google.com with SMTP id y198so197929pfb.4
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 10:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=vpjLHWY8x5R66trQfUAgPxcH3HDBjTQaYzaO9OU16nk=;
 b=J+t2n9bhm5GeG1ho5bcj1/n28BDVAlvKoxqbDeYg7/hwXMcNMv0UPs60z4ug0FHjan
 Eq5h7RQy+M5moYi6J6dWfuwsvk1YXdOImLpRRFAYMM48pXnyqwjsjEksZxp6OQYY7yc/
 XApX9I3I9+PEWYjJI3gFQVeiaKpnRCXOqu55mBhzw+zzBvD9KWDAULUcCMvxN5D/12gP
 N18wNwGfm3ZAO92VPq+SwKSQqbkpSPJLq4HpHDcLMjB2fjEjJVoBQQvzGxrDXUVdflTS
 1w3b9A+P+d0ZBX+/VQARzFjeyoWREyeUXAMcoBC+qr2kYGOvzLOmP6xD2aLLOJSCjFbQ
 qJ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vpjLHWY8x5R66trQfUAgPxcH3HDBjTQaYzaO9OU16nk=;
 b=t2ltazppBEvQtOzSUNI6Vb7VDmlUbuLBoRtjR+R4cGse4k2u5CC9vsbAbqpk/83Wzp
 BkDSov9ngmTZGzBIpbtO6zcXMbsPCQeOa5goJckLwdEW3Dv7zUK3w++PsyOHhwh5J8g/
 7hepqYMwax1bQYMoNsl9GZ/qcY/JO/hfW9vXpPDeSiZ9tZqY/Qg1wkCG7E7Jj63/p48Y
 ixPdxpl9zjj/NEpuOBz9lIYclThaym8UBed/kMbNw08Q3bQgSwFzEv4omO3tN1Wl2dWw
 pAdRmsdbmhDzTfPMzJcbqMoPlw3ICiwV6lxSp8sYduE2eD7T1adhxrcZ9LfqbMLKh7Ey
 dPhw==
X-Gm-Message-State: AOAM531A10v8qbG9LVLYIvyk5ON8G8+WwIw0bkvLYqx+69IfmpcaSbko
 Qy52x3EFUlHOVHWjcnH3can00g==
X-Google-Smtp-Source: ABdhPJy0g6Q+ZD0gSMNvj+be2qj7VOsoCNwS7H6S+RfqKsg4XsvDBjitynk4MQhVdOUXQ+PAulM4/A==
X-Received: by 2002:a62:a518:: with SMTP id v24mr27307pfm.295.1589907616199;
 Tue, 19 May 2020 10:00:16 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id u20sm48706pfn.144.2020.05.19.10.00.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2020 10:00:15 -0700 (PDT)
Subject: Re: [PATCH] Provide a NetBSD specific aarch64 cpu_signal_handler
To: Nick Hudson <skrll@netbsd.org>, qemu-devel@nongnu.org
References: <20200517101529.5367-1-skrll@netbsd.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a854b977-3fa3-fa11-982a-12ec7cb80461@linaro.org>
Date: Tue, 19 May 2020 10:00:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200517101529.5367-1-skrll@netbsd.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kamil Rytarowski <kamil@netbsd.org>,
 Riku Voipio <riku.voipio@iki.fi>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/17/20 3:15 AM, Nick Hudson wrote:
> Fix qemu build on NetBSD/evbarm-aarch64 by providing a NetBSD specific
> cpu_signal_handler.
> 
> Signed-off-by: Nick Hudson <skrll@netbsd.org>
> ---
>  accel/tcg/user-exec.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Queued to tcg-next.


r~

