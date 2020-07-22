Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC39FC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 15:58:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BC0F22BEF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 15:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eUSfVgfL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BC0F22BEF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyH8E-0000zq-Of
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 11:58:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55468)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jyH7a-0000Ad-2w
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 11:57:30 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:44549)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jyH7Y-0000Dj-FA
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 11:57:29 -0400
Received: by mail-pl1-x642.google.com with SMTP id w17so1196398ply.11
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 08:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=h92YLNQeHZNhF7rnwb1Hv1of+/ZQ55ODKJJXMMS2iFU=;
 b=eUSfVgfLNAbKslf8fY1UAR2yO1AqJ2F3XzAgtBCgjMIYSlQeiWXc3maXa9aQH4fjzs
 LdIN8ZMn546GpBSs2pq1r37TGtprjRTCRN0ijuCyKuVAcykqvvc0wf7jQ5LAs/VnFhWU
 n/sVDiqWVYA/5RdTwrWxYX7Bh0x/ZkAhSmlf6wYadMx7xVXt7SyG4gFB5TmOPXbCquwG
 tY+sqkBQbuVrqDeU9loTlBWfFGaHkp/DConZDRIYWZhQsk+LcGLlF5P/gNBCeZ68iqe2
 5cFsgeXoJDupaNm705h5ZPockd1jWmHT1EH53ak/2gZjKKAlZ+S5rjLeGDjawBurF1sN
 0xUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=h92YLNQeHZNhF7rnwb1Hv1of+/ZQ55ODKJJXMMS2iFU=;
 b=KUMgsq/o3H5n8rgpjo+olplQCOMZIrmKcFpcICIrPMD6AxRgFEJ16bxgciZC7JQa6b
 s/8nmXR6Dg669WMwVkd8tf+YChxmUHhslhhPUJxLW6nDb4A7rxk1VW6yNUdHC+eRrxoU
 8VSBAp5PvRjMwD0qtqak3Y5/yjCoyU/R3y1a8k5+mvLnd3v6Cb5dGDEJUQ13zWAJBtsL
 5fsVPZ7RpCA3TT2c5E4NxxZUhhdEqkJoOXb8/zdY/pPe8FNz7Mcc7Ko+v8zpBiETvWgc
 dlU/mbV0KRoybEssp1Wh1YCM3XXwMIH2S5KT6hJC2SLc6RQMCydJIAvcEqwJA7otD2jy
 g8Mw==
X-Gm-Message-State: AOAM5310O/E1dCSMoEFdgADBXvoGZHPHsmznxWVbg0A9DI5tMxoyNaXu
 gIFKg1TMalseCeRA1q7EGcLOYw==
X-Google-Smtp-Source: ABdhPJyHHx5SsUjkK2LJkUss071kJApX4QzHCKSE1LQ0eIeXG6j8OV7TtNsta6DUBqlSTED6AvvUxA==
X-Received: by 2002:a17:902:bc49:: with SMTP id t9mr118689plz.17.1595433446820; 
 Wed, 22 Jul 2020 08:57:26 -0700 (PDT)
Received: from [192.168.1.11] (216-160-65-90.tukw.qwest.net. [216.160.65.90])
 by smtp.gmail.com with ESMTPSA id
 o17sm119151pjq.6.2020.07.22.08.57.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jul 2020 08:57:26 -0700 (PDT)
Subject: Re: [PATCH v2 06/12] accel/tcg: better handle memory constrained
 systems
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200722062902.24509-1-alex.bennee@linaro.org>
 <20200722062902.24509-7-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5d26e26f-55f7-5b74-bb9e-b97ea1040c05@linaro.org>
Date: Wed, 22 Jul 2020 08:57:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200722062902.24509-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: fam@euphon.net, berrange@redhat.com, f4bug@amsat.org,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>, cota@braap.org,
 Paolo Bonzini <pbonzini@redhat.com>, aurelien@aurel32.net,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/21/20 11:28 PM, Alex Bennée wrote:
> +        size_t phys_mem = qemu_get_host_physmem();
> +        if (phys_mem > 0 && phys_mem < (2 * DEFAULT_CODE_GEN_BUFFER_SIZE)) {
> +            tb_size = phys_mem / 8;
> +        } else {
> +            tb_size = DEFAULT_CODE_GEN_BUFFER_SIZE;
> +        }

I don't understand the 2 * DEFAULT part.

Does this make more sense as

    if (phys_mem == 0) {
        tb_size = default;
    } else {
        tb_size = MIN(default, phys_mem / 8);
    }

?


r~

