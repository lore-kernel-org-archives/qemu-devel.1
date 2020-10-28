Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C66C388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 14:47:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90D62247A4
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 14:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N+tQTGXA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90D62247A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXmjs-0007A6-FA
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 10:47:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36448)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kXmhy-0005tB-Rt
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 10:45:51 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a]:44810)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kXmhw-000215-TX
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 10:45:50 -0400
Received: by mail-pf1-x42a.google.com with SMTP id 133so3040984pfx.11
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2020 07:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=bICBZsvrn+7fbhKzrpYvOE7h3JBmra+jcxO9sCMfAgU=;
 b=N+tQTGXAa6AkF/TLfIqbFM/gOeHYsqbvP8p0+KbvVUDMOkvAIL5+RO4vEBpzllBkvW
 sza/P71aNGuMd6dc7fYdf73xF27LVqYUwF7fH5huyJiH3UY2knnGhuBZ+gxGbX9kSzjJ
 IY7O+SviXeJvMjm3Mr697DH5ZZ/Soh4wBcnOEJvfHtsx2SQJN6TPkfi1YkpoRgulHXMD
 GBUccpnDjPu9L/50J+Bl6GJ9eXFbJN5Z7xIaKtsmVwQDBnyY5v1FJz/HHXSyMWVW3b47
 Np2NFfnzGSTsTf2leFynOGN46eRdZWYfeVSIe9JNbevvc4pCZyYyP6aYLik1NQuv0L3m
 +SmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bICBZsvrn+7fbhKzrpYvOE7h3JBmra+jcxO9sCMfAgU=;
 b=iNJjSb7WfND1g/bUqxCJmkzZW7MHFHLopRAZqMWjMx3KPS2/wmTmBuOOT4Qkozx600
 69Cgw3bGSt0ESLhE1TGM1H35/GCe80ov2idtpF5OGPaWakJiAGfxsz8HiJauB4g/3fOl
 ojkYDswafBRzNUZj5Aefl09f9QG+7qZ3G7qmFA2MSy9HJlzMu4GzZpbyw9cj90UZY72n
 EvbCoy6wh0L+vrecCHC9AsKd0Jtsc8LX87s68CACEW3Wri8F0Gcx8c8A6+YIDl9lQ06E
 EgMg3aNtssn8ifb3RFCDMLBI2YZg+ffGgghIFFueb4a0nFT9mVIBRY4arqSpgVaKwOva
 nX3g==
X-Gm-Message-State: AOAM530/311tRaxU4c3V67FGA3RvYRtPZ2xjohz7YVlnhIG7GWK0AqX+
 AZeZdHTJGft1Co1Fc1zRQ4mNpg==
X-Google-Smtp-Source: ABdhPJwBEKzek5i3SVMnvSsS5vvlVildI8eUnS6P/DcqoU+YDIE2NDbn54zzsXEYIt8s4gKrkLqT5g==
X-Received: by 2002:a62:30c2:0:b029:152:83fd:5615 with SMTP id
 w185-20020a6230c20000b029015283fd5615mr7917260pfw.22.1603896347147; 
 Wed, 28 Oct 2020 07:45:47 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 189sm6382987pfw.215.2020.10.28.07.45.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2020 07:45:45 -0700 (PDT)
Subject: Re: Help on TCG asserts
To: Sai Pavan Boddu <saipava@xilinx.com>,
 QEMU Developers <qemu-devel@nongnu.org>
References: <BY5PR02MB677272B3B2FB297EFBDF20E2CA170@BY5PR02MB6772.namprd02.prod.outlook.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9a641423-3278-0691-2b6b-c1dff6d06ed9@linaro.org>
Date: Wed, 28 Oct 2020 07:45:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BY5PR02MB677272B3B2FB297EFBDF20E2CA170@BY5PR02MB6772.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.921,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/27/20 9:15 PM, Sai Pavan Boddu wrote:
> 336 static void set_jmp_reset_offset(TCGContext *s, int which)
>              337 {
>              338     size_t off = tcg_current_code_size(s);
>              339     s->tb_jmp_reset_offset[which] = off;
>              340     /* Make sure that we didn't overflow the stored offset.  */
>       >>> 341     assert(s->tb_jmp_reset_offset[which] == off);
>              342 }
> 
> Can anyone give some color on what to look out for. As I see, tcg seems to have
> some restriction of code size it could handle, but I’m confused how to control
> that in qemu.

It does mean that the generated code block is too large, and it needs to be
split.  I'm surprised you hit this though, since it means that something else
has gone wrong beforehand.

Is there a test case you can share?


r~

