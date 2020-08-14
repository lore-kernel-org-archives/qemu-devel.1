Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA73FC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 20:21:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90E0720768
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 20:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sy0MJoaN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90E0720768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6gCW-0002FF-Oj
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 16:21:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34228)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6gBk-0001cf-F6
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 16:20:32 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:35124)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6gBg-0002Gj-Qb
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 16:20:31 -0400
Received: by mail-pj1-x1041.google.com with SMTP id t6so4900212pjr.0
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 13:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=i8e5wpvadDMalVNCXdPf+4pSKUfsoxxXp2can4ioDiw=;
 b=Sy0MJoaNksFQBAUHLr/3Al5HeHqEzEKQm5lEnuvtPWazFFgmJCy2iYG8gS5Qt8t+g8
 l9CAx2VgDLV2PhVXlwMEqPXGH14+ylD1eTUXuAlsPcfElws+tHux+jc5nOhfeMhPWmHq
 HUsyKoFVo3DrUOLrYejs6NPAdQ/VYNHTArIvcxo+yhU9VUKjZCWDYAFi8bvMPSsvMopS
 Aer0soiGaCJCm8hpFXjicmGFcl8CW24m44kX2U+ofFnDN5Ylaz8F5hzT6sOeEUjcz4sp
 f3oTG7Ly14RV696F196cOrNSae2ijcvPJ71dr31uNPms/qqv8d4jMqF3Xldl3Oj5132X
 ogag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=i8e5wpvadDMalVNCXdPf+4pSKUfsoxxXp2can4ioDiw=;
 b=MzbldhsMtNX1XGSahn+B1aivsxbpoFJYaiNG20LymGKfbme3VPRz/zb5xo4jzXWI/0
 WPbGDyIJ8B9lLBqFW7NM2NQU6DL6GvdgRScyL/igTaUNqDtX6XBF94f79ejmP00rY/W6
 3tXlDYR5ZBP2miDZaM/bDp3aqGiwTsZ//NCHVwLqVLNUOf6ZeHtncmh7rRzJeOZ+gD1p
 jvJ8sHKenXCx/YJD1Uzsa9iLvIE45o3Q+yBXLksB8PDiJacCfqFnOjQljCIm0+ToehwK
 nOdYg6syfk7W3PLFnA6IK/SEkzKoq3li/AOZPaNXR10orQ7al+cquZ8jz76xoYVDH2zt
 vRCg==
X-Gm-Message-State: AOAM5318UxQFnw8u781h4jRtZbsCJUfkhpdxPwKWRAm3JzDh5E5Am2GY
 jZcJdV2eoqJJ6BXWxtIsoXcFyw==
X-Google-Smtp-Source: ABdhPJxjrZ5vbT3fm58Ee+zHiHaVGyal5Cii25wWmHaoZBzQ0kAiYxPgV5KbKu0575Ww8kOF1gT2kA==
X-Received: by 2002:a17:90b:3d7:: with SMTP id
 go23mr3424094pjb.44.1597436427105; 
 Fri, 14 Aug 2020 13:20:27 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id m29sm9183101pgc.55.2020.08.14.13.20.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2020 13:20:26 -0700 (PDT)
Subject: Re: [PATCH v5 01/14] cpu-timers, icount: new modules
To: Claudio Fontana <cfontana@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>
References: <20200812183250.9221-1-cfontana@suse.de>
 <20200812183250.9221-2-cfontana@suse.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <10efbc6b-8e10-39f4-53cd-9a627e436f62@linaro.org>
Date: Fri, 14 Aug 2020 13:20:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200812183250.9221-2-cfontana@suse.de>
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>, Wenchao Wang <wenchao.wang@intel.com>,
 haxm-team@intel.com, Sunil Muthuswamy <sunilmut@microsoft.com>,
 Richard Henderson <rth@twiddle.net>, Colin Xu <colin.xu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/12/20 11:32 AM, Claudio Fontana wrote:
> +/*
> + * Return the icount enablement state:
> + *
> + * 0 = Disabled - Do not count executed instructions.
> + * 1 = Enabled - Fixed conversion of insn to ns via "shift" option
> + * 2 = Enabled - Runtime adaptive algorithm to compute shift
> + */
> +int icount_enabled(void);

Why does use_icount need to change to a function?

If it does, or even if this just comes under the heading of cleanup, it should
certainly be done in a separate patch.

Either way, I think we should expose the fact that this is always disabled when
#ifndef CONFIG_TCG, just like we do for tcg_enabled().

> -        if (use_icount) {
> -            return cpu_get_icount();
> +        if (icount_enabled()) {
> +            return icount_get();

Renaming of other functions like this should also be done in a separate patch.


r~

