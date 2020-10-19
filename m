Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01E1C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 16:13:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4075F2225F
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 16:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gaxKbqXC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4075F2225F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUXmc-0002TX-5Y
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 12:13:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53412)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kUXaY-0007Fs-VY
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 12:00:48 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:45659)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kUXaW-0000uR-T5
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 12:00:46 -0400
Received: by mail-pf1-x442.google.com with SMTP id e7so178938pfn.12
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 09:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=ktXfc0M6AXq8Oo1fufQofEfLrkP7OroL2DgAT7LcHV4=;
 b=gaxKbqXCJW1mw3gDPnCKTc7tv1dUW9f/fD/v25O0MEl37CR7Dz5IrA4gVBtrdo7Szk
 IvaN3kH5xRWu34UWwq0Pa1HA8zSFYuuawQWRoLXPYF6WoVFK0VcnDUchAKIlGs4EmgTI
 bGAAMJRwfvvGy8Nk2I4uinlxRvLMhiu5+nSyhKlAAf02++3MJzE2gi/2MOKE0Cg7CH16
 N5WNeu3w12I/nJ4nTXHXKEv/Q50F2+2YGU2kHJNPHYUW2/kWQbKe657hM/UtFqVSswn7
 i9Z+LrCc/5BB3u9r/Z40jef7Di9m02Ij8nXb5TILyflNRt+t5zcXqlcj6hwzpqbAojoH
 wWmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ktXfc0M6AXq8Oo1fufQofEfLrkP7OroL2DgAT7LcHV4=;
 b=I6kvjit+9eJ688H/elpcjZ6kYaVIpMEIcq8MTXUy6ouFmwdXzZqhbMollzHKdZvs/T
 +qhROnB3VQLne+wTKlkYXboSS8Df+X01HCGYZfj7ey1fYHahe/gPRUHHGcS8074EHaCs
 7j9nAYkt5aX728S2XbtDmJ/hsGLW7GWPRj0CVJThtFWNiespPDccgdIZcTUKNLDGxrcD
 hVmoDaD+aMyXd0FvGb1YPvLomXoH/0aUrNmIaYZ/p2Jphg0SpLW9Ng6Sevjf+AEX4lzQ
 s8vqg994ycrWpXiKKOUerqqsf3nom3MGamhOM3IftRlWXz9phlKiN0rqNyJ5UxoPnDWR
 gc7Q==
X-Gm-Message-State: AOAM532CNQDyRYFg7qRv7MWcqLVJbEYM5Yw8YMAqKHWFSlRsEk7upknA
 UPthkkn9zzaIlmblIh9dWtmDs+bdEolv1A==
X-Google-Smtp-Source: ABdhPJyB6GRx3EFtKo6Hq6g9fmWgrr17NB5EBa6YDhe9QE80BiciYIM5gfKeduQz/1DnH7GaKOpEwA==
X-Received: by 2002:aa7:9811:0:b029:15d:2c0e:e947 with SMTP id
 e17-20020aa798110000b029015d2c0ee947mr252949pfl.76.1603123242529; 
 Mon, 19 Oct 2020 09:00:42 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id ng7sm21534pjb.14.2020.10.19.09.00.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2020 09:00:41 -0700 (PDT)
Subject: Re: [PATCH v2 10/10] target/arm: Implement FPSCR.LTPSIZE for
 M-profile LOB extension
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20201019151301.2046-1-peter.maydell@linaro.org>
 <20201019151301.2046-11-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <699b310b-8164-1c20-e858-ffa4d838318d@linaro.org>
Date: Mon, 19 Oct 2020 09:00:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201019151301.2046-11-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/19/20 8:13 AM, Peter Maydell wrote:
> If the M-profile low-overhead-branch extension is implemented, FPSCR
> bits [18:16] are a new field LTPSIZE.  If MVE is not implemented
> (currently always true for us) then this field always reads as 4 and
> ignores writes.
> 
> These bits used to be the vector-length field for the old
> short-vector extension, so we need to take care that they are not
> misinterpreted as setting vec_len. We do this with a rearrangement
> of the vfp_set_fpscr() code that deals with vec_len, vec_stride
> and also the QC bit; this obviates the need for the M-profile
> only masking step that we used to have at the start of the function.
> 
> We provide a new field in CPUState for LTPSIZE, even though this
> will always be 4, in preparation for MVE, so we don't have to
> come back later and split it out of the vfp.xregs[FPSCR] value.
> (This state struct field will be saved and restored as part of
> the FPSCR value via the vmstate_fpscr in machine.c.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.h        | 1 +
>  target/arm/cpu.c        | 9 +++++++++
>  target/arm/vfp_helper.c | 6 ++++++
>  3 files changed, 16 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


