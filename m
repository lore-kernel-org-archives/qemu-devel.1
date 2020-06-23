Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08467C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 20:27:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C830A206EB
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 20:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IMTfmnIX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C830A206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnpVW-0002Rj-VE
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 16:27:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37798)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jnpUn-00017v-3Y
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 16:26:17 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:52061)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jnpUl-0000i3-2O
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 16:26:16 -0400
Received: by mail-pj1-x1044.google.com with SMTP id ga6so1981815pjb.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 13:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=wBtke9yeW1Delmeo3VpaPXqIsj/bo4GibryAyfFIa3s=;
 b=IMTfmnIXs8zpHLgsD9yUiqHdHqYBTEPk+IjLu1LE/TUwWiGxByNw16zPiYf95Qpcq/
 d2zJub8SFlqo/DLpmbmU80NCv7TKOG4MzpMl7ifh3fU/lZ6ipC1fdIhPsLLCYdUz8li/
 CbbRB73jz+ni+lQNdSj9bYe1wFEEoDV6PMJ8Tqyo8sXf3JE4bn7N/e6U6+DcWaF7jKZw
 RzSNCPArWOuLfE4GdnZHbOssXjmdjTqSz6BOzLSsWNo97BcEFsbVbPm13KFKeM0n/SWp
 C3JKJiiz8cW6JNKAq8T/1a9cvUqaIwGYGhWG19vZcbfpKxhjzREBAUr8si52f5PSucct
 Z1Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wBtke9yeW1Delmeo3VpaPXqIsj/bo4GibryAyfFIa3s=;
 b=sppHuyTOYouVTQof/cJZi13DoB+6j2XYBHhEQIIH731lWeMWD8uSBe5YJbJorZ6ZGw
 OB9mFJWXc6sVL8VD/36gZh62BgEZeFvHW7KJI/giHh+gJHvba8oRvy39jEBAUA5yYEfC
 jXGboIxBhFZR7mV2Jc/HdZEwFa5a1aF+3B0IVR92f0UgBJ1AMB/DP8C8Zqgx3i38knXd
 EyBBUvJGwTbfKFCKXYhJ+LzDsFJVANdRrjhXuMUcxurBTeioNjeu9Fh1G36gApLvoLZp
 Aw2HyAkOKax3Ccxan7E4FmUpiv89yX3a5nG1xac9yrLcrd1H6wQtEw9fs0wd3GKJ6PGT
 t42w==
X-Gm-Message-State: AOAM531Ca+uLWw/4MRsSn/irMJb8O6SYYIsfPDKCJRL3WFJugqqdJnFh
 nfAECTacA13y0Z7tbf0OUwuycdmJCWY=
X-Google-Smtp-Source: ABdhPJzyI8j1O2SUdfILxiRu4Apgs8RZJZo2U5QikQ3usPJlKy+bVgYFrlrfnXKl/KHwcMdQg9sakg==
X-Received: by 2002:a17:902:778d:: with SMTP id
 o13mr7986876pll.247.1592943972952; 
 Tue, 23 Jun 2020 13:26:12 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id k7sm7562171pgh.46.2020.06.23.13.26.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2020 13:26:11 -0700 (PDT)
Subject: Re: [PATCH v3 00/25] risu cleanups and improvements
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200522023440.26261-1-richard.henderson@linaro.org>
 <87v9ji88cj.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f869289e-cb6a-2197-d627-81d56f4e7513@linaro.org>
Date: Tue, 23 Jun 2020 13:26:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <87v9ji88cj.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1044.google.com
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/23/20 2:00 AM, Alex Bennée wrote:
> 
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> Version 3 changes the --dump option to --fulldump and --diffdump,
>> after an off-hand suggestion by Alex.
>>
>> These are now mode options, similar to --master.  Which means that
>> dumping is an orthogonal apprentice type, which means that we can
>> dump from a socket.  I'm not sure that will be useful as such, but
>> I think it makes main be a bit cleaner.
> 
> Hmm recording traces I ran into a difference, need to track down if its
> a master or apprentice bug (both are native):
> 
>   ./builds/arm64/risu aarch64-all-v8dot0/insn_LDAPR__INC.risu.bin -t aarch64-all-v8dot0/insn_LDAPR__INC.risu.bin.trace
> 
> fails with:
> 
>   loading test image aarch64-all-v8dot0/insn_LDAPR__INC.risu.bin...
>   starting apprentice image at 0xffff8548c000
>   starting image
>   Mismatch reg after 4 checkpoints
>   master reginfo:
>   faulting insn 38bfc1f4
>   .
>   .
>   .
>   mismatch detail (master : apprentice):
>     X15    : 0000ffff9eba41dc vs 0000ffff8548c1dc

Did this work before?  I can't see how.

Your v8dot0 string is suspicious, because LDAPR is a v8.3 instruction.  Are you
sure you're testing what you think you are?


r~

