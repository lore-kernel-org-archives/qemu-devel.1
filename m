Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6362AC33CB3
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 23:08:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32700222C3
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 23:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hXL34IWL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32700222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irrmJ-0007Q9-C9
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 18:08:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46860)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1irrlc-0006b5-9s
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 18:08:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1irrlb-0007ri-2s
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 18:08:03 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:46835)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1irrla-0007qT-RQ
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 18:08:03 -0500
Received: by mail-pf1-x442.google.com with SMTP id n9so9210452pff.13
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 15:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=BQHJvRoCxkMjIFqwUcXROLAq68d80gqdA++H8mJBCr4=;
 b=hXL34IWLMSBwFLd+Eu0glsfzsNbl3L2cvoX0mWx4yUOvxsY9ElD6ieUEmz3wU4CdaB
 HCS2TTMRzlcM+yHPGtDabBm3FdwQa1GreQ+4SvS8BItohyIf4Uw0Fi/fTaw82jZIwBf6
 cdvPgLc/cr0vBSQGK84L1gMHFRLnG+7vCB96Mt3ve9hUX9psL0aftxckEeOGL1+6PjQA
 +sr/A60nuOHpaR29U16kBPpHKaahef/vlob8msAm6iO3xu6K2h1HCzwi35xKio055935
 86fzL/o3FJhs/ge2RHuiuijv4iQNTUWgNGVdb8YCv7rK8R6wL6IxqIt66oNq2TfPIfid
 HzWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BQHJvRoCxkMjIFqwUcXROLAq68d80gqdA++H8mJBCr4=;
 b=qbfqxMWR/21VED+LD3bYh+so+rckzIpCea8sB9vpMqzmvNzw5E8oBnuKG2qm1bekEO
 uyNbyQbTTY/vytx5LBiBKXTcFfoZE/ZEt7qS+vC9o48jnuxbBuelKCoMFGgK2ICSMgyT
 Q7N3EHh+gSY9L9g6NqHcYPwI8IaMKOWFje3Isqrost0WlblliSnaHTCv8xmK9Q5i6hkf
 8T8v0hGWK1lzsLMj2P3T6NKuRQD4mch7W/wxq7TEkN6gEotrsLIYpfQNt/ia3iXIwcoF
 +m3lhthB2RlJxq90myabVtfXPn1fmdRZ3lRZMV92mgOyW/SX5agMbQaCAYo3Fh4JyXqD
 vAWg==
X-Gm-Message-State: APjAAAVlb1gpaFo2bu/SKFGgAmRyNIVMsaDwcUTVvbgdKsZTxu/4bIPo
 UlMRLT5YoYLZLdnRmg5Y9nlEuQ==
X-Google-Smtp-Source: APXvYqwcd7V6ZrIjsmiYqjJb+0dsNFwOAxtRMVG8M9hu19uu8mbtJFH09zfchCJANwmhH4xWJWIN9Q==
X-Received: by 2002:a62:ac03:: with SMTP id v3mr33774883pfe.17.1579129681571; 
 Wed, 15 Jan 2020 15:08:01 -0800 (PST)
Received: from [192.168.3.43] (rrcs-66-91-136-155.west.biz.rr.com.
 [66.91.136.155])
 by smtp.gmail.com with ESMTPSA id 136sm21322699pgg.74.2020.01.15.15.08.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2020 15:08:00 -0800 (PST)
Subject: Re: [PATCH v5 20/22] tests/tcg/aarch64: add test-sve-ioctl
 guest-debug test
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200114150953.27659-1-alex.bennee@linaro.org>
 <20200114150953.27659-21-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2731815f-9a72-390b-0a8e-73b77c4b62b6@linaro.org>
Date: Wed, 15 Jan 2020 13:07:57 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200114150953.27659-21-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/14/20 5:09 AM, Alex Bennée wrote:
> This test exercises the gdbstub while runing the sve-iotcl test. I
> haven't plubmed it into make system as we need a way of verifying if
> gdb has the right support for SVE.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v4
>   - interrogate ZCR_EL1 directly as no longer have vg

Note that ZCR_EL1 does not give you the correct answer if the hypervisor has
set ZCR_EL2 to something lower.  Also, ZCR_EL1 it itself not correct if the
hardware does not support all vector sizes.

See some of Andrew Jones' qemu command-line work.  Try -cpu max,sve512=on and
then use the ioctl to set vq to 3 (sve384).  The result will be an effective vq
of 2 (sve256).

We *really* need vg, as computed from sve_zcr_len_for_el().


r~

