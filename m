Return-Path: <SRS0=ex3l=EN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73628C388F7
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 21:10:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B410020723
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 21:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n52EO/0G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B410020723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbVTD-0002WL-Lz
	for qemu-devel@archiver.kernel.org; Sat, 07 Nov 2020 16:09:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kbVSH-000236-4x
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 16:09:01 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39956)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kbVSF-00023P-De
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 16:09:00 -0500
Received: by mail-wm1-x342.google.com with SMTP id t67so151765wmt.5
 for <qemu-devel@nongnu.org>; Sat, 07 Nov 2020 13:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=AZOz1KbVGO1PF6nPUfaRLdflyDNl/dm4E8SY6QR5h7U=;
 b=n52EO/0GKsnoo0bmVWC47oZloBFDSXBme6fbEzCndyLoFRHlrijLp7pcNWetQ9s5mN
 ToBLFpRIfterlVFrp3INtv5krRg7MrU3jQ1hD+6IHqAeTgJfLfNX49Lp4U95aOjRVe63
 xZ7CNXdg52FDG10HzYac1Z1IqWmdAxmByIyPiGecPD1ByteYy3IWuXg5lciQHPYnvt3q
 t4MdiG5wjWxY2uWstgzcv2RLMPzJumdqkduQ8i565g/5w+mgv87Q7lMaXs4WsZc8BXIa
 n8PQwjWLwllf04ZufhxRMXk2Io+KXEa6kqyYXSTfWpw0JmIjsAR2IVglbjQPcbss+mFp
 BG1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=AZOz1KbVGO1PF6nPUfaRLdflyDNl/dm4E8SY6QR5h7U=;
 b=JTO9I2djB7VnO+vkHkptkZ9sdV96bfHk9fXw3KcTL/nbItKo9vwZmYrwRnmlPfGIRh
 S7/mFfLpknvhWXbuqbKheHvHijROd+816nSKVz68aeFez4B12bbee/RxInJyRMoRXgBj
 Wu+dhZs79n1lrmHAlw1UFqyVMO1u0YrAwEYug3NP6+EXcmToXbF5dlbagG6WuQ98pOdU
 bIv9l/etb8shXa/Eolf2lyreKRPcsqkES+r8gxLrA7pevJcbadsi4RTb37idkMG5YCN1
 a2m/efBM2TgxwAZTLdJSKaoav/rMyFVDyaolpF5cs9tbIR6gcUaGHVqo0S4rg2bQVQPp
 fWmQ==
X-Gm-Message-State: AOAM531Q8LIaMnF2KTtIDiKkZD8ORNFWpzkkOzArIRyokv9gY2I32QzV
 wWoEp/LksrnP8OkelshyuWAFDg==
X-Google-Smtp-Source: ABdhPJyHM/bHEMujdKT7rp899i0tfLeG/36yDWotvDCK/iNIyUFMQbtBAJi+6gcuqwtdnncLx5EX6Q==
X-Received: by 2002:a7b:c848:: with SMTP id c8mr4171681wml.86.1604783337252;
 Sat, 07 Nov 2020 13:08:57 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c2sm7413052wmf.47.2020.11.07.13.08.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2020 13:08:56 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6B0CA1FF7E;
 Sat,  7 Nov 2020 21:08:55 +0000 (GMT)
References: <20201106032921.600200-1-richard.henderson@linaro.org>
 <20201106032921.600200-2-richard.henderson@linaro.org>
 <87tuu28bwy.fsf@linaro.org>
 <bfd043eb-cf7d-b5a4-bb26-e8ef07bfb2b5@linaro.org>
User-agent: mu4e 1.5.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v3 01/41] tcg: Enhance flush_icache_range with separate
 data pointer
In-reply-to: <bfd043eb-cf7d-b5a4-bb26-e8ef07bfb2b5@linaro.org>
Date: Sat, 07 Nov 2020 21:08:55 +0000
Message-ID: <87r1p498ns.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x342.google.com
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
Cc: j@getutm.app, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 11/6/20 12:31 PM, Alex Benn=C3=A9e wrote:
>>> +/* Flush the dcache at RW, and the icache at RX, as necessary. */
>>> +static inline void flush_idcache_range(uintptr_t rx, uintptr_t rw, siz=
e_t len)
>>>  {
>>> -    __builtin___clear_cache((char *)start, (char *)stop);
>>> +    /* TODO: Copy this from gcc to avoid 4 loops instead of 2. */
>>=20
>> Why not do it now?
>
> Do you really want to be including that into a patch that touches all host
> backends?  I do it later, in a change by itself.

Ahh I hadn't noticed. I was just thrown by the TODO and wondering what
it was.

>
>> I take it i386 is just too primitive to care about flushing things?
>
> Or the reverse.  ;-)
>
>
> r~


--=20
Alex Benn=C3=A9e

