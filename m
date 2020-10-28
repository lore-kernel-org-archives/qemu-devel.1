Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 115E9C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 19:52:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F12F21D7D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 19:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECKc0br3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F12F21D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXrUv-0006ma-BH
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 15:52:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44918)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kXrTp-0005Vn-Kp; Wed, 28 Oct 2020 15:51:34 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:33238)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kXrTk-00041S-1G; Wed, 28 Oct 2020 15:51:32 -0400
Received: by mail-ed1-x543.google.com with SMTP id v4so801905edi.0;
 Wed, 28 Oct 2020 12:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=3DVHJqPncYLTQ0Zr7d38lbdEhNA1N1MpZfkSs+R9RCI=;
 b=ECKc0br3wKpS3a6TiNDLSYC5gUMe+CkCoV3iXTTNvisCIlmHBBY12+9tY6dRPU8fuw
 pHncfwWuLsEMw9cY9mRz1xQLk8CJsVbJYgXUDFFPw9aCKBHpS0V4GtmR5KvNEleMxQxt
 YrIhSmevSwp00/vZmCZ2RefnlWRgN6lSnUHEBSfo2APti5JGeSBZXt7lHtjg6Y1cnlMW
 PlAlxXcIL0kJ6WbTy5y5kcPcW5rPpUAmf/SgFxGAai7WQLcsZPi+TluzMQb1GkP7qO2B
 5NlkpZvuCT+lh698y12hQP30F+0Ywyp/SzYUe11yAa3mx//w8flgbgMvdzw1zedgihc8
 WFpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3DVHJqPncYLTQ0Zr7d38lbdEhNA1N1MpZfkSs+R9RCI=;
 b=pN2ggRMM8zv20crkDCzgaQKIJvviGQbbudskTHTHtHYHxTjVsBvdqMnVy6P3dq78Bj
 L3g9LAsCo229LmRMjVWq857WPW6rm6kOGIAn+ldv5EXNxHSZDSmaRlzjKhKY7I051e9y
 WeODj+q9sBUUYVvKpJsXb9JYX3pKucuularXgTxlBPfk1EAFHgDsc369lcy2fS+52V1S
 Ybn0OYWqm/7qrHgGLpTl4e3bSwGXXmpWbULi3TQL7YsA/tJdeiGmZOZoAeFL1ASfWZYc
 sC7JAEO117NEdzlDt42ErG/7Jf8sKfoABQIKkMNHK/nGDCEmToUck0NKP1bVxq/WgYwT
 zLMA==
X-Gm-Message-State: AOAM530OqkOUjMoe5BoghPPZYMAiHnZiYxDP8V0dkV3uxm/nyrQ64y0a
 LXL1GpxgV8wmBqYZUgFzXXQ=
X-Google-Smtp-Source: ABdhPJwefK/LmLDxh9WCP7cGIMRFOOrxSLNwcFszvsDMAR65Bm9B7ysmXpDrx+QFpcD8CEXzZ3xeHA==
X-Received: by 2002:aa7:c704:: with SMTP id i4mr544682edq.51.1603914685957;
 Wed, 28 Oct 2020 12:51:25 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id p20sm272427ejd.78.2020.10.28.12.51.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2020 12:51:25 -0700 (PDT)
Subject: Re: [PATCH 2/2] target/arm: Fix VUDOT/VSDOT (scalar) on big-endian
 hosts
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20201028191712.4910-1-peter.maydell@linaro.org>
 <20201028191712.4910-3-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b44e71d6-4321-59e5-2e5b-4dd5b17def9b@amsat.org>
Date: Wed, 28 Oct 2020 20:51:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201028191712.4910-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.921,
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/28/20 8:17 PM, Peter Maydell wrote:
> The helper functions for performing the udot/sdot operations against
> a scalar were not using an address-swizzling macro when converting
> the index of the scalar element into a pointer into the vm array.
> This had no effect on little-endian hosts but meant we generated
> incorrect results on big-endian hosts.
> 
> For these insns, the index is indexing over group of 4 8-bit values,
> so 32 bits per indexed entity, and H4() is therefore what we want.
> (For Neon the only possible input indexes are 0 and 1.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I believe that gvec_udot_idx_h and gvec_sdot_idx_h are OK
> because the index there is over groups of 4*16-bit values,
> which are 64 bits each.
> ---
>  target/arm/vec_helper.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

