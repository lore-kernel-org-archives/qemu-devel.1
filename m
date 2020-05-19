Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A42CC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 18:02:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 119BD207D3
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 18:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="okPVb8xR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 119BD207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb6ZI-0005dU-7C
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 14:02:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jb6YP-0004n2-Gq
 for qemu-devel@nongnu.org; Tue, 19 May 2020 14:01:25 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:40056)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jb6YO-0004CS-AX
 for qemu-devel@nongnu.org; Tue, 19 May 2020 14:01:24 -0400
Received: by mail-pf1-x444.google.com with SMTP id x2so260896pfx.7
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 11:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=jNRy7qXi/jMFlgVX0Nib+9yBSWrIPnnEcjWGS4PLQSw=;
 b=okPVb8xRt8WTrux5KBKX5gbpKITO0B2VNt9R8rfeSqZUCFoZGszKoEvmMXMhNrbp9x
 NTtVmt1oD5djuzPDnkCwqsv/YV4eK7dZ9U3AcciAJeoRhWRugZz5vJtibF7H2BxxSNsY
 UuYuDpAisU2zv2kOFk+difLgOqaaj2B+pA6kubpA7kwCc0NRn4Pdl5NLEnuOh42U97HF
 9Ct5HE9UBRX76tDdDQR7qeWUTqrmhox9wqFcROnkLtCV+dSlGYajT0Rzk3hWRGGryAgx
 NnVvGnvIKu2Q12fFfYj1863SMA7ClSqECgZsPMvvBfNaLd1R0bIPCxMNCMbbtgzlZhdc
 F7/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jNRy7qXi/jMFlgVX0Nib+9yBSWrIPnnEcjWGS4PLQSw=;
 b=XhqYTIfmyfyUNOfPpCUmyp1QYixa4jb01rsitDW9h1KE5iuSZ1NC74Ao2xs3q+rhzK
 hQUTF/SMnimC8Rt32w/EhnQVC08DVbJdfYytJG9FiMSMJCmxtYTwEgX0NVLanXIz9yBY
 TW+PeIWyUrzLk+GhBEsYJdvl03lJNHKGrMlOR0vs9Jo2SwU/h4uQ6C+i1xPZyBRvtClv
 nUC+Uju3XbSbiv3h9HKLHY7NP6V8IomA0giEqNgzOn6e5glyxsryNFuEftLr2zrr4eOM
 TZV7cevwNcrm6J4+Fyu2MFbm7U3TnC2nZJYst7Ep2FcVSuDrx+GTxH1dAdMwVHBjIcrz
 WnQA==
X-Gm-Message-State: AOAM533UNH2Qxdj3WYiof6yTHiXPpIoLFmqudwnDfYLeP5BNBAtxYAQx
 Ta0UosiLA+AgOD1e5IbGh8JUow==
X-Google-Smtp-Source: ABdhPJyRBDu1xIwmJmxyRlslx709eN5fSDUQkDy8AhGnOHw49FosKsMkfGwDZag4wWcr3r2nhzokhw==
X-Received: by 2002:aa7:96d7:: with SMTP id h23mr244553pfq.259.1589911282593; 
 Tue, 19 May 2020 11:01:22 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id 16sm174913pjg.56.2020.05.19.11.01.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2020 11:01:21 -0700 (PDT)
Subject: Re: [PATCH 0/2] Update use_goto_tb() in hppa and rx targets
To: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>, qemu-devel@nongnu.org,
 rth@twiddle.net, ysato@users.sourceforge.jp
References: <20200519162144.10831-1-ahmedkhaledkaraman@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a0f3967f-e125-d888-bc6d-44414edbfd5b@linaro.org>
Date: Tue, 19 May 2020 11:01:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200519162144.10831-1-ahmedkhaledkaraman@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: aleksandar.qemu.devel@gmail.com, alex.bennee@linaro.org,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/19/20 9:21 AM, Ahmed Karaman wrote:
> The issue arose because the page crossings check in use_goto_tb()
> function is required only in the system mode. Checking it in both modes
> causes an unnecessary overhead in the user mode.

It is not only required in system mode.

You can see failures in user-mode if you modify executable pages, or change
their permissions with mmap.  Such as if the guest program contains a JIT.


r~

