Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 939B3C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 16:47:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6112D20767
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 16:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qHLDjH8r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6112D20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDVv2-000479-KK
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 12:47:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40940)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDVu2-00030a-D6
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 12:46:30 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:38664)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDVu0-0006fB-Kj
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 12:46:30 -0400
Received: by mail-pf1-x441.google.com with SMTP id d22so3150775pfn.5
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 09:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=fDsBYm8xqvgH9QuPlr+UYKFUquY9Em5y4Nb9tpZXsE4=;
 b=qHLDjH8rID6dkx6XZ75KMSjkoGPKnA3Ij5ASH+qnvC9JRieuQoT/tGQR+3eMvZd79R
 auiYNfm8fkiFvo8cpOWa9d0Pg/MpTWfFEaKDWkM8pUN6Pf3QkUf5amWXvsEk5wandmxS
 01Ek2+zyJcX/2LyvFB4jLOCAQPyFWZyoAleUMrsN2OEy4hdzktQ9PIWCaaX16C4HuOPi
 mR2m9sVuqi8uu5QFpzN5j2grRVeXiY9E2fabPgZpRIzdl4HOstC5hyZzHyEU4IwKV1w6
 Kqr0gwMzsTvtkdG9ULJuWgKr2asdREhgzke40Yk18zFJDQTNcIDBkbGlssG7KPrgJRIp
 5hqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fDsBYm8xqvgH9QuPlr+UYKFUquY9Em5y4Nb9tpZXsE4=;
 b=V9MFC5WpeTRKOJrl9smyks6u0Ul3BDGyMDvB+k+28Tc8fcWA1kCTNRYseN+nHZOTZ+
 L2pJ/Ukv3JEN0EvE2r9Ou/TpcqShNFGFekT5757rYynuz+hIGu33kdZfdMndKVQPoKC9
 ktYuACbNEuu1AjsUN3YFYs7I/Tp2SwqU/GiVZXrMbn+vH3+0X7yyhoZ0EK81xjCRruZC
 M12TYWjxMsNJeVkHRbIo30GIpfdpjrXfNkXTiItF/jTzoLWzVJLoPVQJ19bGFiqHzVBD
 aPRKbJB30vpFVeQPmRjepExV6S3pvSS6PJszN29BvWRs1UfvB0e+jBrCPOxuP2IObPaz
 7VXA==
X-Gm-Message-State: AOAM532SY3D7/wP5La5rLeyYbiJU8/wlUhr9q1RyGnVnnC9Rbsj1Mcvi
 aGWGSXHJTq0O2Fe89S5yxRvBzA==
X-Google-Smtp-Source: ABdhPJyrhN6hId/2RX+lV0kQ+wN/pbHiGF7+dMjdKtdXlgbxYulCRWxEm1sFFYAmNBBwd1acy8BS3A==
X-Received: by 2002:a63:e747:: with SMTP id j7mr2554925pgk.107.1599065186912; 
 Wed, 02 Sep 2020 09:46:26 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 194sm17295pfy.44.2020.09.02.09.46.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2020 09:46:26 -0700 (PDT)
Subject: Re: [PATCH 4/7] hw/hppa: Inform SeaBIOS about fw_cfg port address
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
References: <20200901183452.24967-1-deller@gmx.de>
 <20200901183452.24967-5-deller@gmx.de>
 <6385bd44-9cf8-95c3-1e59-0e1fb209863f@linaro.org>
 <a56b96b3-9afc-0708-27bf-97d8095bde07@gmx.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <853e1911-81c3-709b-6a9c-b1f7ffd8f826@linaro.org>
Date: Wed, 2 Sep 2020 09:46:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a56b96b3-9afc-0708-27bf-97d8095bde07@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.324,
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
Cc: Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/2/20 4:24 AM, Helge Deller wrote:
> On 01.09.20 23:39, Richard Henderson wrote:
>> On 9/1/20 11:34 AM, Helge Deller wrote:
>>> -/* QEMU fw_cfg interface port */
>>> -#define QEMU_FW_CFG_IO_BASE     (MEMORY_HPA + 0x80)
>>> +#define FW_CFG_IO_BASE  0xfffa0000
>>
>> Why is this value changing?
> 
> Devices on hppa occupy at least 4k starting at the HPA,
> so MEMORY_HPA+4k is blocked (by Linux) for the memory module.
> I noticed this when testing the new Linux kernel patch to
> let the fw_cfg entries show up in Linux under /proc:
> https://patchwork.kernel.org/patch/11715133/
> The Linux kernel driver could not allocate the region for fw_cfg.
> This new base address seems to not conflict.

Then that information should be in a patch description, and the change should
be a completely separate patch.


r~

