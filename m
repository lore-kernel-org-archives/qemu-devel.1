Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F342C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 13:43:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9053A20774
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 13:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="owQjj5bB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9053A20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPQm7-00070J-9J
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 09:43:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51188)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kPQlL-0006ZZ-HC
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 09:42:47 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:42730)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kPQlJ-0007AK-LI
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 09:42:47 -0400
Received: by mail-ot1-x343.google.com with SMTP id m13so8608375otl.9
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 06:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=efAq1BrtrdGK1ExLtwFNXui7CzB1oZk3Sg49TU8ouUs=;
 b=owQjj5bBS+mIlxUcMCYA+ps7EOEC9TnKZsW9xdZL7Am7RHGktt2b3sy1NvV+vPvp5f
 qd+VR97uaM7CeyJY18FLHfnsLVBJ2G4r3QpDS1dAQ2Oz4Dr0n3Cm0lASUFEzxU2Sk+A9
 O3SNG24BJB1DB/eiUIASL0az7umquleWzHiVT0HOeFoFGIXYKO3RBW+Latsu+dJv67eJ
 o37/dQkmD7ASDhmueqIATZh4Te5PxWnZWO7k5DDmNo+O3xMFkXhHKMXuiMFbHu886gZ4
 bao3kKLbuzZCHXDZ9zRV1LtG2/+MbaaQm1tibcM2RsQyyDMoQtzvvdvxlRCH8vcHTyKw
 B2Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=efAq1BrtrdGK1ExLtwFNXui7CzB1oZk3Sg49TU8ouUs=;
 b=CRc2dWRny2Vt2cqVzEuBNeBoipp0cW/JYEM4OsnIT3+QDA4c20MW+gZY+YaTAOelMG
 T1kOSuFQ7xapx6sdArA1dS3z7UcZRF+wt0/Ft/JgqnusGynK3LdQUlh0V2SNjSnbW/Rc
 ruY7zMz5xfBtUH+0gg6g2kVdrHpdnfeRis+VvD8ytTqW7a86XOukb0lm62hdRB3qMZhe
 xgp9WF2qwi8tF6yQln0jjKXfyU5kZNkp+IN+FPnhCTw/PGucMs1KXBZKBoGqbSCQ7hvy
 RkDNHhbAg3ChRMKIGsBa2DNM7hb6w+rsSBLWAXeBuIsBY6Z6ezv7JC9ISnZOhCkJZRfJ
 dpfg==
X-Gm-Message-State: AOAM533NWa1Z1pXO3iLFGp1MvyFcpj0hwujNWv787VtnfXeOiWPdv1MC
 Gt4Vd8g37ToBUBNRoyXGEw0cdQ==
X-Google-Smtp-Source: ABdhPJz9NeBU16V1nngYWMrszUzgOXvIMCcXbd4jo0vmG0y/xoLIbdJ6zqoDK7m5nkm/FlpbtLteXA==
X-Received: by 2002:a9d:128d:: with SMTP id g13mr11114146otg.245.1601905364349; 
 Mon, 05 Oct 2020 06:42:44 -0700 (PDT)
Received: from [10.10.73.179] (fixed-187-189-51-144.totalplay.net.
 [187.189.51.144])
 by smtp.gmail.com with ESMTPSA id m205sm41786oib.43.2020.10.05.06.42.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2020 06:42:43 -0700 (PDT)
Subject: Re: [PATCH] configure: don't enable ASLR for --enable-debug Windows
 builds
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 pbonzini@redhat.com
References: <20201005133434.12614-1-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0d82444f-9032-1278-ba6f-c495cacf5a94@linaro.org>
Date: Mon, 5 Oct 2020 08:42:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201005133434.12614-1-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x343.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/5/20 8:34 AM, Mark Cave-Ayland wrote:
> Unlike other OSs it is not possible for gdb to temporarily disable ASLR when
> debugging executables on Windows which causes gdb to fail with memory access
> errors when trying to debug QEMU.
> 
> Keep ASLR enabled by default on Windows via the --dynamicbase compiler flag
> except for --enable-debug builds when there is a clear expectation that a
> functioning gdb is expected at the cost of slightly less security.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  configure | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


