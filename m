Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C41EC43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 18:52:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07642206DF
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 18:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ra0Ps2aX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07642206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idIii-0000JL-Uk
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 13:52:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48350)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1idHti-0006KE-U6
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 13:00:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1idHth-0005PU-I9
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 13:00:10 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:33589)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1idHth-0005J4-89
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 13:00:09 -0500
Received: by mail-pf1-x443.google.com with SMTP id y206so3723512pfb.0
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 10:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=p26an9r2CXB30mdsIXABb9LuiAqHiTdYDwy3yCrP5w0=;
 b=Ra0Ps2aXJPCrYY+ilgX5GQ0jkOXloGOh6Clsrrp3qkW7axSDFmjLmBQPy6JfyU+jr1
 B/+IddZL/fDBplQcK53qFB8mrBcyZhz69DZCig/hGTlShZIreexIQ/U+GJ71yv/GB0Bi
 S6m5MUcRnvBsFQ+d24xtt9Z/v++TUOEZYw0as0240BdGc9xtW150kzwlc4r1wbUQrB2k
 ZqSavhnkIIEecO/WaraB12zayqvF2HS+OKkZGibyPlHPQbHGRs43AU+qWL1bZc6ttJIV
 vZ4w1WcUdrXAJDC1oheqdYqti4UKTpDqzR7rOgz4WHrLzToSvGW1bK2nNC9CygCCzEur
 pdHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=p26an9r2CXB30mdsIXABb9LuiAqHiTdYDwy3yCrP5w0=;
 b=f+Fa3gaSicBSfsKfGpl/CjiHl+wF1P5ixRyMuX3LWhlOML0Vlzg0OTgWwmYG2lcBpr
 DLDzu7cKfPOQcxNToEepk+KoJU4cLfDJkvY4Q/GRrFL1z/2hrpP3KNMy/h1mz+ELqBAy
 v7Jr8iNgFQXUGA6EfXjy4wED7Rj6mDMY9Yv3wWXE/27PsxfmY99jrutTmUWeN/Y42lAD
 NHNofi9Ldenrc0gWxhhRZld6qT8nkTn7lwyez3VpII+mf784+YSugz8K8g+OWV9aoTIJ
 TPOrnhyQt2pJcDTsi2vFc7nTfhdxbiJYICsfXp71VGU8r46qfujS7fTFSVLsoKAq1Nb2
 9emg==
X-Gm-Message-State: APjAAAXQMjaZPu8lKH4VPnhMu9Abg8Nc2f3hvb3ya26HJOApR7cDky4Y
 UIl5sKDdpDWIcLPzHZFzGnkOKQ==
X-Google-Smtp-Source: APXvYqyumStn3u+gP+vn0nA1DirhN/5D1CZNKfvKe8TSFmfinkW76nEbD5Aks8z4NZZ+HHNv0vWnVA==
X-Received: by 2002:a65:42c2:: with SMTP id l2mr4768477pgp.172.1575655207700; 
 Fri, 06 Dec 2019 10:00:07 -0800 (PST)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id gc1sm3881082pjb.20.2019.12.06.10.00.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Dec 2019 10:00:06 -0800 (PST)
Subject: Re: [PATCH v4 08/40] target/arm: Rename ARMMMUIdx*_S12NSE* to
 ARMMMUIdx*_E10_*
To: Peter Maydell <peter.maydell@linaro.org>
References: <20191203022937.1474-1-richard.henderson@linaro.org>
 <20191203022937.1474-9-richard.henderson@linaro.org>
 <CAFEAcA9Bf1F0CcbsqASemuu+CxPSEUHBWzyR1Qo1QUTE9hBkKA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <95e1ce50-e98e-d7d2-8af6-d5f315b8fa95@linaro.org>
Date: Fri, 6 Dec 2019 10:00:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9Bf1F0CcbsqASemuu+CxPSEUHBWzyR1Qo1QUTE9hBkKA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/6/19 7:45 AM, Peter Maydell wrote:
> On Tue, 3 Dec 2019 at 02:29, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> This is part of a reorganization to the set of mmu_idx.
>> This emphasizes that they apply to the EL1&0 regime.
> 
> It loses the important point that they are stage 1&2
> translations rather than stage 1 or stage 2, though,
> and also now they're out of line with the naming convention
> that all the other indexes use :-(

It won't be out of line once all of the other renamings are done.


r~

