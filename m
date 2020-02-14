Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B727C35242
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 23:32:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 110742086A
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 23:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nnUK/I3E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 110742086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2kRS-0002Zt-7Y
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 18:32:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50173)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j2kQc-00026t-1m
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 18:31:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j2kQa-00063r-48
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 18:31:21 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:43168)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j2kQV-00062E-9b
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 18:31:16 -0500
Received: by mail-pf1-x443.google.com with SMTP id s1so5591426pfh.10
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 15:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=fgFOBJqEZlCWv1H2h7m2spS3R9/5QkIbywanS54+sq8=;
 b=nnUK/I3E/yIVXG3vvRG1yxVNRLWG+3GaXNVZQ++3EZa5fg+MPF6trkTbQwNuXp0/fs
 U0YWo7DJ3GLhaoFOLZ7nLukL3ynaZiuhgFq9hqALIaQBSB1Ntf4VIBmb0mF1OuQ4m/uZ
 zl+t2hFUwlNDLag6kF1BGhyeIr+e/21phcYcifyyLkadZe9mkPkKhPU0vMquIGjGGumM
 6oVDmc6nkrpyunENQrKyH/jL9ROMf4wNkC0K4z23G4pIROOcnSPeqAIO8PSlUN2jvSWx
 BJQo1N9zP/Hs+JAhzaFysKQ8ZJhCQ2g552vz+8rqJfQhVR1EhP99dlR5sioSXfTujQ+8
 O3rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fgFOBJqEZlCWv1H2h7m2spS3R9/5QkIbywanS54+sq8=;
 b=WhV2g+efHcyDxoFd4DZP+UO0lKmik9RJd+KgsruFWf69dmM5pH9ix2tulb3YyhcXmL
 dOpp1YlXIC7BIxo144NBVkOWq5CPGxThqp1NAnvhq9QqWyq5/7+pH/aqrgCPvrdR0gFD
 1rs3RueObJQtiZfmc8ArglOxxbETRlQNVo/O2gkeVCuhJ5dBFjvuxLmdiULJxKVbs2yW
 ueXf5UyaATGBkmOU2cyxmhS2a+74uL6l/tfqc6d4mG5gTVhc8DxhHKwlF9FEZePLa1xT
 Ax9jNXUw8knDBO3AwgO8ZxCfMoUb1a82iVdHMb4c6Oas3eJ43VCSmzRmf4v429CXUpOT
 LFVw==
X-Gm-Message-State: APjAAAVI95mi1BopeQcEm3BoQdCoeteuUbbAH7DovId8+HmtwLS9g/jt
 MUE9iK7UggMYW+GsyyVOfZVXAw==
X-Google-Smtp-Source: APXvYqxUEZOEnWmMXQl3FsylJ+lr+gKQ59/HH5EX0rzgEkTXHAuUk8emlo0zOdQuhzqwop6vofQtcw==
X-Received: by 2002:a62:cd8c:: with SMTP id o134mr5686063pfg.22.1581723070903; 
 Fri, 14 Feb 2020 15:31:10 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 144sm8387900pfc.45.2020.02.14.15.31.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Feb 2020 15:31:10 -0800 (PST)
Subject: Re: [PATCH] accel/tcg: fix race in cpu_exec_step_atomic (bug 1863025)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200214144952.15502-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <dc224902-b8bb-934e-947a-4417449566ea@linaro.org>
Date: Fri, 14 Feb 2020 15:31:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200214144952.15502-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: Bug 1863025 <1863025@bugs.launchpad.net>,
 Richard Henderson <rth@twiddle.net>, Yifan <me@yifanlu.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/14/20 6:49 AM, Alex Bennée wrote:
> The bug describes a race whereby cpu_exec_step_atomic can acquire a TB
> which is invalidated by a tb_flush before we execute it. This doesn't
> affect the other cpu_exec modes as a tb_flush by it's nature can only
> occur on a quiescent system. The race was described as:
> 
>   B2. tcg_cpu_exec => cpu_exec => tb_find => tb_gen_code
>   B3. tcg_tb_alloc obtains a new TB
> 
>       C3. TB obtained with tb_lookup__cpu_state or tb_gen_code
>           (same TB as B2)
> 
>           A3. start_exclusive critical section entered
>           A4. do_tb_flush is called, TB memory freed/re-allocated
>           A5. end_exclusive exits critical section
> 
>   B2. tcg_cpu_exec => cpu_exec => tb_find => tb_gen_code
>   B3. tcg_tb_alloc reallocates TB from B2
> 
>       C4. start_exclusive critical section entered
>       C5. cpu_tb_exec executes the TB code that was free in A4
> 
> The simplest fix is to widen the exclusive period to include the TB
> lookup. As a result we can drop the complication of checking we are in
> the exclusive region before we end it.

I'm not 100% keen on having the tb_gen_code within the exclusive region.  It
implies a much larger delay on (at least) the first execution of the atomic
operation.

But I suppose until recently we had a global lock around code generation, and
this is only slightly worse.  Plus, it has the advantage of being dead simple,
and without the races vs tb_ctx.tb_flush_count that exist in Yifan's patch.

Applied to tcg-next.


r~

