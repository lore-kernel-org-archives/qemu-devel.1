Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E92AC76188
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 15:11:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68E7321903
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 15:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fsa4h5s0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68E7321903
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpZxx-0000sR-ML
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 11:11:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45437)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hpZxm-0000Ti-JG
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 11:10:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hpZxl-00053P-IC
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 11:10:54 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:35482)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hpZxl-000521-AB
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 11:10:53 -0400
Received: by mail-pg1-x543.google.com with SMTP id s1so11493282pgr.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2019 08:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=dKApOhgG1EBIWzsnGrV3Z40G86FWh4A1HF4cDTS2cR4=;
 b=Fsa4h5s0UsQzi6NT/Bbtpt0xLtZTTz4nhFZtgbkLeycIDMu12IFUW38c7r+TvwaKl3
 jlLDstac37OaY7HfRDEnXlJic/DLm4GcRjGNemG48r7W/f1bAVfN7bGRslgmcscMNggb
 1GkmCG3oidExrRp1d8waxI3bl3c1Y+AQmqrPGj2tBuX4RHlfEDSFaRC1gfa2GMAoEuo7
 ztVqrhcxPk7xTTm8vGC0HHLUlMw+ruYlqpu9wdfd9YzjlmRlTG8DiFLgVjIavkAmQdNc
 8ekOrB3CoEBXZNL0kcnNyLEExjXo8Q81BZrtb9aIFaRLrWs+Ido2Hz1R2FE36DvTi/fF
 L94Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dKApOhgG1EBIWzsnGrV3Z40G86FWh4A1HF4cDTS2cR4=;
 b=DQqTXyvUi+xcMYEqr2ZwGO4Rl2H7toMhlXG64crKBXpRnAvXvbUbXYqxU+3Y6MT1Ju
 ciqeh2mKdkt3cbqy4+KA8kBSS86OmQHWma4/hxTHxLhtd6upgiI6RKZzTB5MVqmQTGOM
 C/lld4oeAq/YaE5VyUskkwVHI0YOIiQyUp3cUUfqY8tntFdjSUxAEo8+kZJ83i0e9go2
 3dLoL32fHuTk1d/warFzfbiQnzYxkBZZYYfw4p+ekc2feMSMINAnX5pBfTdY9WZ163NV
 4RA5VT6OMuNdJ7dQ66oKkp0UJERMWTucrNCEWBqODyEw2jqrTuQOMNMx3Kk/vivODSa5
 qHLA==
X-Gm-Message-State: APjAAAVVIPw97DEsjiPlCvrd0/PchADBLI9lb39QFGLByBtRpc3VPqjM
 ubhttUPSWog40qrBIKBDIjs93g==
X-Google-Smtp-Source: APXvYqwu7OthObJLx94cgNkzSyIhI/dt5Ogd37ajHCoS0YTX/D+FX2qd6RuABmfejjzfatVla1Wl1A==
X-Received: by 2002:a63:6904:: with SMTP id e4mr11589082pgc.321.1563808251239; 
 Mon, 22 Jul 2019 08:10:51 -0700 (PDT)
Received: from [192.168.1.11] (97-126-117-207.tukw.qwest.net. [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id t29sm48408241pfq.156.2019.07.22.08.10.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 22 Jul 2019 08:10:50 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190719210326.15466-1-richard.henderson@linaro.org>
 <87k1cajzix.fsf@linaro.org> <87pnm2v28j.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <99bee3ae-be28-06af-a4f5-cbfb73e6c9fb@linaro.org>
Date: Mon, 22 Jul 2019 08:10:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87pnm2v28j.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: Re: [Qemu-devel] [PATCH for-4.2 00/24] target/arm: Implement
 ARMv8.1-VHE
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
Cc: peter.maydell@linaro.org, beata.michalska@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/22/19 2:37 AM, Alex Bennée wrote:
>>> Testing so far has been limited to booting a debian 9 system with
>>> a 4.9 kernel, and a fedora 30 system with a 5.1 kernel.  Both have
>>> KVM enabled, and both report enabling VHE is successful.
>>
>> check-tcg is throwing up errors for ARM:
>>
>> ERROR:/home/alex/lsrc/qemu.git/target/arm/helper.c:5353:define_arm_vh_e2h_redirects_aliases:assertion
>> failed: (src_reg != NULL)
> 
> I'm going to go out on a limb and say this is because the aliases
> registers are SoftMMU only. Do we even want to handle any re-directs for
> linux-user?

Ah, no.  Thanks for the inspection.


r~

