Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E5BC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 16:20:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 322882064B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 16:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uTmVcfv+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 322882064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtCo1-0004Mp-Fe
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 12:20:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44140)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jtCml-0002fo-8c
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 12:19:03 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:53648)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jtCmj-0004An-I6
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 12:19:02 -0400
Received: by mail-pj1-x1041.google.com with SMTP id cm21so1429734pjb.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 09:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=/n+FAmOYSoblXOgSLxC1cJcJpdl6jJ8L0qlAqEmstiQ=;
 b=uTmVcfv+kk1/KS3Hx33XmWBL9V+cdFd+aLRAU9F+hacai3E0+R+srgmRpde5B0SiFF
 HLsJHeROvtH8fagOW8SSKr/yKClEYlEyDBukw3ZUAp3a2iDOxzKxpeJkQ3rhyov2ezn0
 YvHtgd9598TkBU69YLa0k073SKsL9oTGAt3o6WZyLcgXa/fWG1JQkCynzApMgFgcLKSb
 JDJGZ2vzcMSIJPUFdyRLo6ExE38kiAdSXWglQL1wzOCAQ/jD3Gk4nRUNkXZLpBhM5y5E
 3U9D32jdv4DhOzaJ7Nv4ZN+kKCF+eJ52Ahi579cwe2kVXETIrrOQrRy0lKMUENgvNCa3
 jlng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/n+FAmOYSoblXOgSLxC1cJcJpdl6jJ8L0qlAqEmstiQ=;
 b=riuFqhh3/b21wAJt5O01pw5MuSdPyKVjn91KZxzaa0jvKhUCYWNM4ivJKHuSMK6+QW
 Fz2KmXkm07TJ3Rv0QU09uGHpOLBnZDC3IDWnRhQ1KguntTqaQsYvg6rqv+06cJy7eCgw
 Ya7DyQtb+/PmvtZy/5dPBJZ99kmjXUCC/kj3QaRApyGFtsSyB4lEiksTRmIwQvOi8OxN
 2C0WtKs0sx91EJl5+54GJ23gwUjAtdugW6nGbAwnlAoLS1oCU5sFpHIirqbPc8DO3jP3
 RhNv37YhcnMGDYHWhXeJ7DtztQJpfszSmlVYLr6ODJkdMknXz2uV8M10FctjZNGuLXTW
 CAEQ==
X-Gm-Message-State: AOAM531B9HQppCjQhDe9ST2qcEuaYElr8drVlFVr3dFQUFUT/2+N7kB0
 KCpw0XpwTx3okoUaqddib0ztnZhVO3E=
X-Google-Smtp-Source: ABdhPJzMT4inMdMmOFOj9RAAf2NU2uwVOBhQ/VnA+FKpALQvgpb8f58xsb3a/o5ckjqatUc/zyUAaA==
X-Received: by 2002:a17:90a:db0b:: with SMTP id
 g11mr10603777pjv.11.1594225139971; 
 Wed, 08 Jul 2020 09:18:59 -0700 (PDT)
Received: from [192.168.7.121] (24-113-145-216.wavecable.com. [24.113.145.216])
 by smtp.gmail.com with ESMTPSA id u19sm319684pfk.98.2020.07.08.09.18.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2020 09:18:59 -0700 (PDT)
Subject: Re: [PATCH 08/21] target/xtensa: don't access BR regfile directly
To: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org
References: <20200706234737.32378-1-jcmvbkbc@gmail.com>
 <20200706234737.32378-9-jcmvbkbc@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <020dafac-832b-5325-4c5a-f18f5fd1136a@linaro.org>
Date: Wed, 8 Jul 2020 09:18:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200706234737.32378-9-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/6/20 4:47 PM, Max Filippov wrote:
> BR registers used in FPU comparison opcodes are available as opcode
> arguments for translators. Use them. This simplifies comparison helpers
> interface and makes them usable in FLIX bundles.
> 
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
>  target/xtensa/fpu_helper.c | 42 +++++++++++++++++---------------------
>  target/xtensa/helper.h     | 14 ++++++-------
>  target/xtensa/translate.c  | 20 ++++++++++++++----
>  3 files changed, 42 insertions(+), 34 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

