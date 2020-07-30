Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFD2C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 12:28:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 391C12074B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 12:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H67eqjEV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 391C12074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k17fq-0006YG-Ia
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 08:28:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53056)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k17ex-00064S-In
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 08:27:43 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634]:47032)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k17er-0005kj-FP
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 08:27:42 -0400
Received: by mail-pl1-x634.google.com with SMTP id k13so6142138plk.13
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 05:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=0b3dRDlok4eTJZfgVkBj+lYoyi4tcWWlSRgfYqrWfr8=;
 b=H67eqjEV1GlGVsY8KLGbZoJVlxyOWwrQFA9qibdIWaLquLtspruVjfIws8fjZ49l/H
 gmHzcO0DZTYsqcMxazOE43wsmefPhw5uOsEoTq3dmCM4PdGRL2wB9poLOZ8EqaOjTYen
 h/pDFrCSxLe6ljQqRzBQZShvr0rn87qq7vPf0t/S3loWhmGBMWOAbdexeYUFAlA4r0fc
 bbz2nz3jo8jo70ZrRilzWbcP9TJYfkXDNmkc9k/9yGh7chMXGLk2sPUxgBaOpkJgPcNm
 3pNwRKGIxtMlsBhMYGZ08vj5FE6ld4aa6DYzrIpZ+GjpRhHg9+VeKjm31pLW5yfSX9Pz
 Sadw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0b3dRDlok4eTJZfgVkBj+lYoyi4tcWWlSRgfYqrWfr8=;
 b=aACnRrbS1NehlRZh8gpiLOBd2DLCi57dEUbsvesrMsmo5rfJGWAITZJ4vSTUNPOge+
 rh/WGfMgSwZgXsOYDkXzBJBTRxfl+EMW3P8RilAUdoXmavutM6BylWrssqjp7aPF+spX
 8upQzMOa5+98f5C7duc5rBrtUs2Xs3/0TyynMyloJ/mmfAhW5jCLPDjUHquWIcOfQpm9
 7XXf89O7oHoAg4UKVOvbfZwxBq/kF6BKCr+f8PPNi1rj7z5P80KQWrOJ56CUCNlnaqsq
 aljQ9M2LOKNhGb33ycyirnH+/eiKeMu1/jJ/TskcVlwNcDzICgKmN+Ozr8BrHPcat2JA
 C3yQ==
X-Gm-Message-State: AOAM532SL6tzWecLwN0VznrqZPb6nGWndSUMOClStDgpwS6NIQ09XjMf
 ii6xeMLtW/57x+Xy5uXTjKWxng==
X-Google-Smtp-Source: ABdhPJwkXf0ayBQ8mAz4nPkAG1/KN+eqI2yls9HUzWq9yVomvJZc9q57puTr9pMcSSuWTCY6gThTlg==
X-Received: by 2002:a63:6c0a:: with SMTP id h10mr34449497pgc.11.1596112055481; 
 Thu, 30 Jul 2020 05:27:35 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id s125sm4294749pfc.63.2020.07.30.05.27.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2020 05:27:34 -0700 (PDT)
Subject: Re: [RFC v2 01/76] target/riscv: drop vector 0.7.1 support
To: Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <alistair23@gmail.com>
References: <20200722091641.8834-2-frank.chang@sifive.com>
 <mhng-0246b27e-f392-45a9-806e-9998bb5ede5e@palmerdabbelt-glaptop1>
 <CAKmqyKMEraiyw_r7U3v8K-2pdipBh3otaPOaNPLKtpvqPe780A@mail.gmail.com>
 <CAE_xrPi0Rc88P4wehno_ewjH_-wCm5bicO-rae-ZYsAgVpyOBw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5a3b8461-51ba-8fdf-03a0-31da01cd6d91@linaro.org>
Date: Thu, 30 Jul 2020 05:27:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAE_xrPi0Rc88P4wehno_ewjH_-wCm5bicO-rae-ZYsAgVpyOBw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/30/20 1:07 AM, Frank Chang wrote:
> So, if it's okay, we can skip RVV v0.9 and bump to RVV v1.0 directly in our
> next version of patchset.
> Which I think may relieve the burden for the community to maintain
> multi-version of vector drafts.

That would be my preference.  Thanks,


r~

