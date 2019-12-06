Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F789C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 18:54:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFCC6206DF
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 18:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pQy42ixr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFCC6206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idIkg-0002hd-Ny
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 13:54:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57229)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1idHyy-000409-4s
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 13:05:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1idHyw-0005zL-Qx
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 13:05:35 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:39315)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1idHyw-0005sQ-GN
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 13:05:34 -0500
Received: by mail-pf1-x441.google.com with SMTP id 2so3712661pfx.6
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 10:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=u+zfmB+GQiFMKMGY09la3VUx4ibV3jw6mD5lvbjuXQg=;
 b=pQy42ixrgcbTTghLZhbnSpKP9/BYUr2xSybxPi0r4Ff7d/w3IU1bu+JYyTpaBmZXu/
 krBsQ6WBA8aMjoeqQmPTD9fUulf+VQyh0/H7SJv2AeyC1eJpHxO21owJ/nGP1Tvorvej
 CnV2ofQYElLErqPKGyCjMOh5fsqULmOp0amGsJNXs3GwiMD3mngECe63znxa79dRr3Ju
 OXdt2wiUzSskEHAauIWgZqcwNOHuiUH/zlfIPuPCPCOOo1myazVygHb06Vp1QHW7tSpf
 yfpe/1uWEqALpaM1y5RyK53HJ73Sfyz1T8Y5L7MyPh8HLbimQo7v+wbbIivqRCgcVo7W
 1MDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=u+zfmB+GQiFMKMGY09la3VUx4ibV3jw6mD5lvbjuXQg=;
 b=tkDl9frkoYCaL2sdRSZbCmU/rwMdC7mBO971B7HXIJET03ZU4W9SyUb8dxJ3v0iDDk
 b+ZU4Wn3MeTcmcr+mVMEFkL0xXBfCy/D9Kseem3x6YdQHMlgDRnEcCaO0w1+stdieKsU
 peDd3HepNuy6UQpT5ChloS0z7fTqigrknOVBF4PN1B3l1jwrBA1BcQAVEppHl9BOydb1
 SQytovZGFcpuxFOUB6p0zDs837dEE7gE01Ue23tc99Ll13lx4yqUOdw9oNBQufwC3uMx
 vJM+DelsuuOjpA+1pBf+P89eMUJErf9u8p/67OAFUNwU0ye7zkyJT5HX/rUaBPNQdQlG
 7o4Q==
X-Gm-Message-State: APjAAAVw962+7EhfThx+3IOTYk9A+PsMrTW9AXfrvQze7zF4JfZvj14L
 ACyZwcP8ANN1Hh95sr1+JQ568g==
X-Google-Smtp-Source: APXvYqyGf4tBlIITWx73yW9pm5VBNd0Vyrid4QjvSmyWtpEkjMY7i/NncfTepkVqyTtlEFuhLDWfSA==
X-Received: by 2002:a62:7986:: with SMTP id
 u128mr16433604pfc.192.1575655532959; 
 Fri, 06 Dec 2019 10:05:32 -0800 (PST)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id m7sm17710785pfb.153.2019.12.06.10.05.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Dec 2019 10:05:32 -0800 (PST)
Subject: Re: [PATCH v4 09/40] target/arm: Rename ARMMMUIdx_S2NS to
 ARMMMUIdx_Stage2
To: Peter Maydell <peter.maydell@linaro.org>
References: <20191203022937.1474-1-richard.henderson@linaro.org>
 <20191203022937.1474-10-richard.henderson@linaro.org>
 <CAFEAcA-2mpUSjwnkAJGdwHX5P0xvF_eZyVLt9xPv57330Qu3dg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8bafc341-7560-14c5-3534-cb299c5b9428@linaro.org>
Date: Fri, 6 Dec 2019 10:05:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-2mpUSjwnkAJGdwHX5P0xvF_eZyVLt9xPv57330Qu3dg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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

On 12/6/19 7:46 AM, Peter Maydell wrote:
> On Tue, 3 Dec 2019 at 02:29, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> The EL1&0 regime is the only one that uses 2-stage translation.
> 
> ...now what happens when we support secure EL2 and we need a
> secure stage 2 MMUIdx ?

ARMMMUIdx_SStage2?

Or probably some other massive rearrangement, because SecEL2 looks as if it
might need 4 new mmu_idx (secure el2&0-el0, secure el2&0-el2, secure
el2&0-el2-pan, secure stage2), which would put the total at 18, which overflows
the current limit of 16.


r~

