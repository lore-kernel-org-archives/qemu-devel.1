Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30108C33CA9
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 02:23:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFAD92080D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 02:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tG0k1okR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFAD92080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irBrf-000537-30
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 21:23:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50116)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1irBr4-0004ax-CO
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 21:22:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1irBr3-0005i5-70
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 21:22:54 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:44626)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1irBr2-0005gy-UK
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 21:22:53 -0500
Received: by mail-pl1-x644.google.com with SMTP id az3so4583314plb.11
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2020 18:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=zaMRfDDkwZFafC/d7zTUCZiiLUs80i9tPo/guQhpPYk=;
 b=tG0k1okRg6PF/SUOmbHMDtEdrpNXFkRPk+u9qzpYNJ43OQ8wvBn1uqXbfL08GlvH0T
 K9nmsgiMPZMTxFAeGhsVvRBp179IAFsfSifJBiLw5TTd4+SVP7Th9mI5FyLnRR+qDmze
 9rHClOZLIhj7gw2QL06ccI4TxAutXski8ByfmpushqLuFJjuXzjIBHOiiZHls1A+7Ya2
 W5AcCYSyAMXWve4vf7TG48yKq4i6ydTGOhyugsa3bFmLwyKtjTcqJVF4N91PAaQQiS7D
 HminyQlKfV/gfa/jR8t1XeX3TjuTJhPFVqE7C2RRbUoAkORA/Lq3fdJgI1ye4r7XfJoa
 cxVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zaMRfDDkwZFafC/d7zTUCZiiLUs80i9tPo/guQhpPYk=;
 b=pNbXOGbP9H2gB+wZ0RYNamMvY77Q/yIRiBlMZWfDWiHimvob9Fa2V9SBdckuICYg9G
 g09oVFCwWm5XMzC91The8z2dQ74WgtST/5nDXgmbuWLrj80I/vZtuQbRgfV3fKZUUvJU
 JrfPC7O2RQSHnnJ8Sa6X+LR4hSvCWtvrSFAmHnLTBq90YTUO7BNdbRRtK/23URruQvP4
 rUuRygTfMbZ9+3hJ9yKkL7G8+DQi4MbixUOnK7iZ0UkL3QKHFTVFfUggtQN2hHMAUVux
 cBTNv+3Lof0CAH+X69k1Kn1JTQ8ed7EOyVeYJ95oer+NVsn+c2tbo+gcdqDx4Blbsy77
 SvlA==
X-Gm-Message-State: APjAAAUrBWzKe7aD2GZr55GR/aqVctp/3glcmKx4vZXh/EUKTdUcio/R
 dBQ7k9n9POwlRtlobDDNpwRz/Q==
X-Google-Smtp-Source: APXvYqyRBTBN/J+WLMJ0AlYXzTkOErUBjPWJfJHuqHHWbexG0x8xs7219Ho0pvGKongS+BbW4g6w9A==
X-Received: by 2002:a17:902:7406:: with SMTP id
 g6mr162776pll.103.1578968571659; 
 Mon, 13 Jan 2020 18:22:51 -0800 (PST)
Received: from [192.168.3.43] (rrcs-66-91-136-155.west.biz.rr.com.
 [66.91.136.155])
 by smtp.gmail.com with ESMTPSA id y38sm14853715pgk.33.2020.01.13.18.22.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jan 2020 18:22:51 -0800 (PST)
Subject: Re: [PATCH 2/3] RISC-V: use FIELD macro to define tb flags
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, Alistair.Francis@wdc.com,
 palmer@dabbelt.com, chihmin.chao@sifive.com, jimw@sifive.com,
 bmeng.cn@gmail.com
References: <20200110081220.891-1-zhiwei_liu@c-sky.com>
 <20200110081220.891-2-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0df8de4c-b348-370f-bdd8-17a60f29505c@linaro.org>
Date: Mon, 13 Jan 2020 16:22:46 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200110081220.891-2-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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
Cc: wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/9/20 10:12 PM, LIU Zhiwei wrote:
>      if (riscv_cpu_fp_enabled(env)) {
> -        *flags |= TB_FLAGS_MSTATUS_FS;
> +        flags = FIELD_DP32(flags, TB_FLAGS, FS, (env->mstatus & MSTATUS_FS));
>      }

This is wrong.  You're inserting the low two bits of

  env->mstatus & MSTATUS_FS

into TB_FLAGS.  Which, knowing that MSTATUS_FS == 0x6000, is of course always 0.

Because of how TB_FLAGS_MSTATUS_FS is defined, overlapping MSTATUS_FS, you
could just have

    *flags |= env->mstatus & MSTATUS_FS;


BTW, the *existing* code is wrong.  This merges all non-disabled states to
dirty.  This means that the code in mark_fs_dirty in translate.c that handles
initial and clean states is unreachable, and that the kernel's dirty state
tracking will not work.

Has the riscv kernel stopped doing lazy fp context switching?  I would imagine
that it has if this code is to be believed...

BTW2, for the purpose of tb_flags, initial and clean states are identical.  We
should probably fold them, to avoid generating two different TBs for the two
states.


r~

