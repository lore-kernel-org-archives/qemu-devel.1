Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA2FC43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 16:26:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 661D3217BA
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 16:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jiXXc1cH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 661D3217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHrJV-0005w4-Bm
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 12:26:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59310)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kHrGa-0003zD-8Y
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 12:23:44 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b]:34332)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kHrGV-0005LV-0d
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 12:23:43 -0400
Received: by mail-pj1-x102b.google.com with SMTP id s14so1396382pju.1
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 09:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=MaRFDI0Od7Kzj7sPR45ZLPH1wQOrPdbchCBgRS+oAbg=;
 b=jiXXc1cH78hydvenE/z/1GelbvhA3rUS4zXKzUACTZulC1dfBAlScyzF0B0ghmnjRS
 kQ5N+tb7ZV1SI8dvoNCIYtdgBlCT1j96m5K7QZefn3ZJ9+aEb2yDdq03tyswuZSTk3L1
 a0yNSNMUDPtdoY+CukgmTOjJLW+v7pVbFX7/gdp16/3n38RMRkf0mqRNo+2I5P4q44+I
 Ol5uq6z4ql2HD4dna1Wu8ToS4IwIOHRd0KNVOmQeBjz8rZDfRPgwfGpGPslvctIf1qO2
 zlmijg3i6a2Ke8gFz41QwP4UoZuivHCyqeNcf3jWeUrdeddAcwqjrXh6uuJWAiSJQUaL
 J6cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MaRFDI0Od7Kzj7sPR45ZLPH1wQOrPdbchCBgRS+oAbg=;
 b=ZCcrx1ejanGT3Ivxnoas+MZ7lKvVIOcY/kI8GmM1+Fa7hL/xCCzydvPchZBfra8I7x
 vLZtY/o4Npeuj1j7sRIY032VhGt1yekRv4hYS4iii4WYykqq4hIJBnthGaZhnhb4M/0j
 oFL1SL8VY/tQCfFQudqSwm/rHw0ki3uRT/4su5eDCk5EWwL5USqKbuuP5hULvGAwJ8si
 LvOCALP0BgQuoGscY0QS7kHzFzmixicHOM5GhyWLp6BnUxC431Skxj5F2DSPwGGo91VK
 L9nZuhFUDlLcUEnWeqnamYxpim5YlQb4JUaiTKoao//JEaGL1UTlVkYANzgHGDCtTbH7
 hvgw==
X-Gm-Message-State: AOAM53305i5BMbc43r3XA06glBi85nXE1E9KjvqK2vfCXtEghVceUhFY
 BT8ZKL5JPvu24IbwVDX0KZKASA==
X-Google-Smtp-Source: ABdhPJz6PRbsdnT14VgqX2mf8+ohR3M+yfUkC62ItZAD/y2Z2ox9zXbLeGeEHeIXOwjWI1RCxyZzGw==
X-Received: by 2002:a17:90b:4003:: with SMTP id ie3mr140099pjb.1.1600100617461; 
 Mon, 14 Sep 2020 09:23:37 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id w185sm11334356pfc.36.2020.09.14.09.23.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2020 09:23:36 -0700 (PDT)
Subject: Re: [PATCH 01/11] capstone: Convert Makefile bits to meson bits
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200914000153.1725632-1-richard.henderson@linaro.org>
 <20200914000153.1725632-2-richard.henderson@linaro.org>
 <d5628860-7cc3-04af-601e-3f3941791573@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2824173e-8a2d-415a-f134-5f94d57a5d43@linaro.org>
Date: Mon, 14 Sep 2020 09:23:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d5628860-7cc3-04af-601e-3f3941791573@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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
Cc: luoyonggang@gmail.com, alex.bennee@linaro.org, thuth@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/14/20 6:28 AM, Paolo Bonzini wrote:
> We can simplify it further if we move the selection logic to
> meson.build.  Here in configure the whole capstone stanza
> is replaced by
> 
> capstone=auto
> ...
> case "$capstone" in
>   auto|git)
>     # Simpler to always update submodule, even if not needed
>     if test -e "${source_path}/.git" && test $git_update = 'yes' ; then
>       git_submodules="${git_submodules} capstone"
>     fi
>     test "$capstone" = git && capstone=internal
>     ;;
> esac

Do we really need to keep testing $source/.git and $git_update?
Surely we can accumulate git_submodules and then do (or not do) something with
that at the end without all of the tests?

> and in meson.build:
> 
> capstone = not_found
> build_internal_capstone = false
> if get_option('capstone') != 'no'
>   if get_option('capstone') != 'internal'
>     capstone = dependency('capstone',
>                           required: get_option('capstone') == 'system',
>                           method: 'pkg-config',
>                           static: enable_static)
>   endif
>   build_internal_capstone = not capstone.found()
> endif
> ...
> if build_internal_capstone
>   ...
>   capstone = declare_dependency(...)
> endif

This doesn't seem like it would do the right thing for capstone=auto,
--disable-git-update, and no system library.  In that case auto should resolve
to no.

I don't think we can move this detection to meson until the definition of
CONFIG_CAPSTONE is under control of meson.

> +option('capstone', type: 'combo', value: 'auto',
> +       choices: ['auto', 'system', 'internal', 'no'],
> +       description: 'How to find the capstone library')

I can certainly change this.  I presume this validates that the -Dcapstone=foo
value passed to meson is correct?


r~

