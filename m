Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB51C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 13:25:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7F672080C
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 13:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F51DG9ow"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7F672080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5qke-0000tT-5x
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 09:25:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47066)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k5qk4-0000Si-C7
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 09:24:32 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:38707)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k5qk2-0002mW-MW
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 09:24:32 -0400
Received: by mail-wr1-x436.google.com with SMTP id a14so2031965wra.5
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 06:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=EuH22a14Ngp3+O+hW+mT9vPNEBG9MUGijeLlSHk9I1c=;
 b=F51DG9ow9PcwCn+ErPW0SebhhDeqOZEGKYO4/x4XIqBaQl8IcKmRRl9xE3/uSEBa74
 /t0jX9qdjvqkxuuT+40h1TwehqPmRqNety5WGgST7A5WXEsZSvLjtT200vAxAHmL5V2z
 49vjuvfY8+mPN3fdfIgi+eiDVeTkblID0yWZEYI5CpZNc5jzeNwpPwJLEi1FJuD8L5mw
 YnAfmz3s3MaQzkZujb2k7vzHe9J0ApDknzAs722uoG+v3AIad7qVHdxYG/A5x3wMn+UI
 MHyfPx4bLqKLINZIUieTOqEMso7tgItljQPdZXdyLcbPsqwLw7SuEPteGL5OmdwE+7Wo
 dEuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EuH22a14Ngp3+O+hW+mT9vPNEBG9MUGijeLlSHk9I1c=;
 b=E0LC/PQbA9SMNVt51vu24GeHD2s9hZLJtfVVGqMno7X1+kUmq3MUav5JKM78nQaGHB
 GN6pCvJa9j9oHsrBxJfK5pIPDEhYoNHePlAJAIf6XfTGAFMgabevg69Yr3MHaNq1B6/p
 sI4XSB2S9FWFaPRhBdkiuOdn829K0GCvgt5iXeKNHiO/EVFGFtMpFhiOOMuHtkz+P0cq
 1yGdhKphZpwB8kPQmV23CnNG+IjQ4sWLfLveUkKIoo7I8/7d6V3rrZfF51i0POqcSorh
 9p5YSpGxzxNzRAOLB6ImoeEYQBxysKFvhB6Px5K3vAsJC49zBkYTcH+4b7sdlpQFQUg4
 MTiw==
X-Gm-Message-State: AOAM532iJS/z/J8YiCsFBJeyGDGArnv2AYWSW1Zt+q3QX0NcRtN/18+m
 REQuEeLjSw98EEJuURO4MfbUyw0U
X-Google-Smtp-Source: ABdhPJz3D0BTxgysc19zqT9oKlZ1q4DXMApaG1KMRAjfUFxd6O8nzQdAcLIRaraSnwR3I/bfvHq2gg==
X-Received: by 2002:adf:dd01:: with SMTP id a1mr11461818wrm.301.1597238668882; 
 Wed, 12 Aug 2020 06:24:28 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id c10sm4047337wrx.15.2020.08.12.06.24.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2020 06:24:28 -0700 (PDT)
Subject: Re: [PATCH 000/147] Meson integration for 5.2
To: Howard Spoelstra <hsp.cat7@gmail.com>,
 qemu-devel qemu-devel <qemu-devel@nongnu.org>
References: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
 <20200811154241.4vzuxvhbwt7ztfvh@steredhat>
 <CABLmASH9rXQjnYYbADtaq5f4c0uqr+kv10p=hC7GR9wF-EzPUw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2548b5fb-97cd-2d7d-8a7e-33b93f3003cb@amsat.org>
Date: Wed, 12 Aug 2020 15:24:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CABLmASH9rXQjnYYbADtaq5f4c0uqr+kv10p=hC7GR9wF-EzPUw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x436.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi Howard,

On 8/12/20 8:32 AM, Howard Spoelstra wrote:
> Hi,
> 
> I just compiled qemu-system-ppc using the the meson-poc-next branch with:
> git clone -b meson-poc-next http://www.github.com/bonzini/qemu
> qemu-mesonbuild-next

I notice you refer to github while Paolo mentioned gitlab in the
cover:

"This is available from https://gitlab.com/bonzini/qemu.git branch"

I am not sure he maintains both sync, can you retest using the gitlab
branch?

> cd qemu-mesonbuild-next
> mkdir build
> cd build
> ../configure --target-list="ppc-softmmu" --enable-sdl --enable-gtk
> --disable-werror
> 
> qemu-system-ppc is invoked as follows:
> 
> ./qemu-system-ppc -L pc-bios \
> -M mac99,via=pmu -m 512 -sdl \
> -serial stdio \
> -drive file=/home/hsp/Mac-disks/9.2.img,format=raw,media=disk \
> -boot c
> 
> Both SDL and GTK GUis are not found, while the configuration overview lists:
> SDL support: YES
> GTK support: YES
> 
> Terminal says:
> qemu-system-ppc: Display 'sdl' is not available, or
> qemu-system-ppc: Display 'gtk' is not available.
> 
> So qemu starts with the vnc server only.
> 
> Best,
> Howard
> 

