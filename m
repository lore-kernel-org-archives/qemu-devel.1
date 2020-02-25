Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 826BDC35E04
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 15:57:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F4052072D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 15:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sgynCbD6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F4052072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6caa-0000xP-Fd
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 10:57:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36233)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j6cYn-0006Hv-TG
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:55:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j6cYm-0007dt-NN
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:55:49 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:38596)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j6cYm-0007dI-F3
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:55:48 -0500
Received: by mail-pl1-x644.google.com with SMTP id p7so1278345pli.5
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 07:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=5T4zoGkohe+BCUHPUlsCXWuDwV2ufiEtB/JT6ZKH1O4=;
 b=sgynCbD6TrZO4f80YloovP9v2tHwlEzsWK1Wi/b3Up5KqhAyvM4YMVqIbl8HZ+RTo0
 QK1HSsOvcVRFt9aPh+RWg42ESnFZo3Ydq2sojYJVME9dg4RowLa4b3j8ZEvKgDZo1af1
 F7dedbOrtwOoDxyLQdMMHsRKZ59JWl1vu2SZLBpeZj1l2A0f4ZU9QeVCqpYImFoUKo9f
 FlnnYF+EtHcxSODiJXP2dwmxCuxeJ/XakInc06hhI1OwuIDtdrZ6GaQBWRxTiO/SjKrM
 72iUgkB3DiLe3Ip4J6+EuCUjTzOHB9ib+JXAx21H62YdTpOr8a0Zv/f8hpkizwpBM8Al
 D+tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5T4zoGkohe+BCUHPUlsCXWuDwV2ufiEtB/JT6ZKH1O4=;
 b=A/wppUFO/nOWeRBgjnThFfy5B5sSuQlKlOhgDs5kjmf4T0mVWDaGJkRl0NjeY4R/kN
 neR5m+8AL/arkrX1aOCRIxNvcRRRU0ap7WZWrz06Ao3dRibe9jbqQoB671xumiO8Bb7u
 D15H2kK/yAGwFNOe5kRKxICf9z4U0uqX+6ABohR876NIX7EqAxO3MICO/DcM8+luCkab
 ikFrbbXsOPUWwvJDIzDbNQQ6OQX6zZNEWFWN7up6GHo7j7AW2zKr4i/Es8LYFuwl87W9
 J6jDIK25WDo9/v8fdKV6ctMloeVRX/upVFNgqnRB7qc9dQ5GpXe3cY9zxoc22OMyFvmg
 Hhbw==
X-Gm-Message-State: APjAAAW/0b/66wS6/GZu9tWuKvPKwMEQC1ByzTSOOHrgONUF+YrWHdg3
 N4kaZbiPXmChuw1MDMy/yhMP+g==
X-Google-Smtp-Source: APXvYqyF9vkfv8qwJ3Fc6dylrMHp8nTHAe/mL5HlXC3WylmZaX3GqTpbkpeKciqWk1ZVRkQw10QPdQ==
X-Received: by 2002:a17:90a:f492:: with SMTP id
 bx18mr6190570pjb.118.1582646146910; 
 Tue, 25 Feb 2020 07:55:46 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 b3sm17873768pft.73.2020.02.25.07.55.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2020 07:55:46 -0800 (PST)
Subject: Re: [PATCH v2 05/17] target/arm: Improve ID_AA64PFR0 FP/SIMD
 validation
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200224222232.13807-1-richard.henderson@linaro.org>
 <20200224222232.13807-6-richard.henderson@linaro.org>
 <CAFEAcA9WZbZj_hPemTGr+Rkh--VmZt1eis189+ExuPVNipgo_A@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <49741058-7dbf-d20f-95ce-5bf9b5e5bdb2@linaro.org>
Date: Tue, 25 Feb 2020 07:55:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9WZbZj_hPemTGr+Rkh--VmZt1eis189+ExuPVNipgo_A@mail.gmail.com>
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/25/20 5:24 AM, Peter Maydell wrote:
> This check is supposed to be "did the user accidentally specify
> some incompatible settings on their '-cpu,+this,-that' option?".
> By making it check the actual ID register values, you're turning
> it into also a check on "does the implementation specify sane
> ID register values", which (a) is useful for TCG but ought to
> be an assert and (b) we shouldn't be checking for KVM in case
> the h/w is giving us dubious ID values.

Hmm.  Because kvm64 unconditionally set VFP and NEON, you're right.  It was
only kvm32 that was examining id registers.

The only consequence of kvm giving us dubious id values that I can see is if
ADVSIMD is on, but FP is off, we won't migrate the register set.

Do you want me to add a tcg_enabled check, or shall we just drop the patch?
The existing test is good enough for just checking the command-line.


r~

