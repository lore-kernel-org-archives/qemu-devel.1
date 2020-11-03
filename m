Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6767C388F7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 12:54:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E7C920735
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 12:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5MGobrj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E7C920735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZvpb-0006TK-VP
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 07:54:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54862)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kZvoK-0005UL-Lv; Tue, 03 Nov 2020 07:53:16 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38789)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kZvoJ-0002mX-1t; Tue, 03 Nov 2020 07:53:16 -0500
Received: by mail-wr1-x442.google.com with SMTP id n18so18430338wrs.5;
 Tue, 03 Nov 2020 04:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=yS9D08AZ8afaCK1IP15sJZEX9oODx19DUeQp9SORkyU=;
 b=Y5MGobrjMyptbaKsDzpZb2PPbtg0ShYaD3ZKPWpTyAkJpvrW9zlHx4RkLhjDgweZuD
 h3tkN22E0a8H8YNsaWRXVa0r1VnGenW9Te/43ygvO2CxWOPdlGZUETW1wP2dpvGJIjyN
 8h6ZOFkw8pFfFpuq2MmL1ruXjvhdn5VXsjQrVcXeYbk2ReLhI70oAGooDjTWk0Md6TSz
 mdx3k3hbzXuVcgmlWMui/JXjG1SmLkblw2zWVrqOIT+wIfvFx0mbogdWRd12M1KP4Oth
 QtOateaa9sH3E9lTvSWpGpjrB3ZcCf+YUjs+ioVsI0Tdw7d9YYW8RWw3YCuWOS7/H0au
 QzjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yS9D08AZ8afaCK1IP15sJZEX9oODx19DUeQp9SORkyU=;
 b=AfYsD844lT+7U4sBSeMi5uTMrk6XrhSMF+TjBLZ/q/66dv5ltJ0HxkFtpPPLKrQCFx
 yKGA3GvqLO2Q+5SiTYVeOTX+IbBw/zAcLaNCL08ENdsEhcd+54qbYUctERudZovTuF7j
 75do6Nv0rCFoUDdqhwirplZKOJ7KQWEsbjf59SQVDG9shxCKkXLIn3FMyTXOwBJZs26a
 5DLf6R6ObgZcdkrRC1EEqbjCldmRd/SahDngHAvsVzf4QW0tk8X0/IKCJnlQOqHumpkm
 z3I9JEEjP97Qc7/0zFfCCZI0qo+f0H4/ix4/W1WiH4fWmXJNoEFnE1FVNcNA9m2ICojR
 2aRg==
X-Gm-Message-State: AOAM532/IUQgz6nW821T7e1TDiZv1HKHqFKIMr6yj+bAxwiDptFXSDNw
 pFz5muVygZ1lJv9+T/vgPfjBA2TORHk=
X-Google-Smtp-Source: ABdhPJy5/Lme0k9LC3bce/nCOS5ntFfjzWf6I/0vs0LQ0c9Ug+pRS/D2Ib2rKvlfDVvw0XRhu3qP7Q==
X-Received: by 2002:adf:fd82:: with SMTP id d2mr25964305wrr.304.1604407992815; 
 Tue, 03 Nov 2020 04:53:12 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id y11sm2682554wmj.36.2020.11.03.04.53.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2020 04:53:12 -0800 (PST)
Subject: Re: [PATCH 5/30] mips tcg: Fix Lesser GPL version number
To: Chetan Pant <chetan4windows@gmail.com>, qemu-trivial@nongnu.org
References: <20201014134902.14291-1-chetan4windows@gmail.com>
 <20201016143509.26692-1-chetan4windows@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9c9dc7ef-fad7-fa11-5e13-ecd931e517dd@amsat.org>
Date: Tue, 3 Nov 2020 13:53:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201016143509.26692-1-chetan4windows@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10/16/20 4:35 PM, Chetan Pant wrote:
> There is no "version 2" of the "Lesser" General Public License.
> It is either "GPL version 2.0" or "Lesser GPL version 2.1".
> This patch replaces all occurrences of "Lesser GPL version 2" with
> "Lesser GPL version 2.1" in comment section.
> 
> Signed-off-by: Chetan Pant <chetan4windows@gmail.com>
> ---
>  hw/mips/cps.c                    | 2 +-
>  hw/misc/mips_cpc.c               | 2 +-
>  hw/misc/mips_itu.c               | 2 +-
>  include/hw/mips/cps.h            | 2 +-
>  include/hw/misc/mips_cpc.h       | 2 +-
>  include/hw/misc/mips_itu.h       | 2 +-
>  target/mips/cp0_helper.c         | 2 +-
>  target/mips/dsp_helper.c         | 2 +-
>  target/mips/fpu_helper.c         | 2 +-
>  target/mips/gdbstub.c            | 2 +-
>  target/mips/helper.c             | 2 +-
>  target/mips/lmmi_helper.c        | 2 +-
>  target/mips/mips-semi.c          | 2 +-
>  target/mips/msa_helper.c         | 2 +-
>  target/mips/op_helper.c          | 2 +-
>  target/mips/translate.c          | 2 +-
>  target/mips/translate_init.c.inc | 2 +-
>  17 files changed, 17 insertions(+), 17 deletions(-)

Thanks, applied to mips-next (split in 2 patches:
target/mips and hw/mips).

