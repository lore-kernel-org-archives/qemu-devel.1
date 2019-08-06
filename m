Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A311C433FF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 15:54:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E85002070D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 15:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qrWOK/gv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E85002070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hv1mm-0001jb-9d
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 11:54:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39799)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hv1mO-0001E9-9t
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 11:53:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hv1mN-0002yr-8l
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 11:53:40 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:35031)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hv1mN-0002yM-18
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 11:53:39 -0400
Received: by mail-pg1-x543.google.com with SMTP id n4so84067pgv.2
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2019 08:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=SBXxT2xNMmL+bDeSQnhWV5BAJd/5Ujq99vRg/5LFopc=;
 b=qrWOK/gvWsOR37lgZQkecB9ScjRyPeZNoQQ9qb8gKBIZJhwZ+L7DxbH2DEVkQ+yeTV
 /xoy1qdliQTpgcytqEIKIip+kOOHuZJBTqjOxBUIumOSH9dsj+esEyScd1B+5XUTxlJL
 myJbFgWn7++aKKbxHjP6ev3wr+HNZ5fKgNsL0WlzCy/ZZeEOGoQhrmjSZ/A33x2NVUiX
 BenNlFvitpGcoZr0bOFRLqWxUS1cJ+K4PFvCQFhDAf3+erZGAyMEJAbZNd9YtCtbj4Nv
 Qj4g/9JxuVbD43Q9R7HPdS4v/n65dI2lsR6rO6+4ja+U32wmGipxx0XnfW0ptRYM4hGf
 n9MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SBXxT2xNMmL+bDeSQnhWV5BAJd/5Ujq99vRg/5LFopc=;
 b=URR6AmHKIQ4m9C/FKfVU+e0rYj2HtOP/IBbGEwP9iE4nCZwHBaifEuzXaAgOnO3M0Z
 XW0EuHaKgiMzFi4HVUixYztrZlj51RAlP7mvadDiS+d0dQgdF/TYyb604ZNx4qHSOazA
 ddB5dlQxbvxwpXu8lMxCfyUdXW6sgwr5m5zNx1a5BxmNnlJfCgLZvRHbyoQ0xXEV8iRr
 PhmiW7xuMGcbte3z/tZwelSJmcT8/OgBBtnMD69Ax9im1nmUHjRC2+W4gSWSp8UWxeV1
 DRDz1Ultr8n9BYr3phdz85Z2hL0+AaT+qMlotE9VTS/Rv7Dg52rNMe4DRBX660AvFIhD
 cWnw==
X-Gm-Message-State: APjAAAXwXsBfYdpVg4qdJ/fuZZrtou7jxIaEj2A61e4tZIwIqgDsIQw4
 wmYzEdKQwx24msFyUZ3XQ2ZHPA==
X-Google-Smtp-Source: APXvYqwTL7GfslmG/7We7B4urn1cnJ4oOsE4fRJtEB7xG10EOwG4EYpfxQerOvTyAprEYzC77A9g5Q==
X-Received: by 2002:a62:5253:: with SMTP id g80mr4325675pfb.179.1565106817593; 
 Tue, 06 Aug 2019 08:53:37 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f14sm7070219pgu.8.2019.08.06.08.53.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 06 Aug 2019 08:53:36 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190726175032.6769-1-richard.henderson@linaro.org>
 <20190726175032.6769-7-richard.henderson@linaro.org>
 <CAFEAcA_kmuX6bxR50eU_3nTdRcjON2nVTqVWiRamSRe6jui3ig@mail.gmail.com>
 <09b930e2-0a92-25a3-4e26-8bea1f437039@linaro.org>
 <CAFEAcA9yQQSYnwEeSNbx4P94deuG5v5fKs7gW4VgG7LFzBX03w@mail.gmail.com>
 <92a7e54e-678e-cf4e-fadc-373e1bd6a41b@linaro.org>
 <CAFEAcA_oy067xK9p51cKwRDcCVTaj2JuqE+11jLS5L_gFFyzrQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <58642e3d-d54a-80e4-cbe2-6b5ab06b36ec@linaro.org>
Date: Tue, 6 Aug 2019 08:53:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_oy067xK9p51cKwRDcCVTaj2JuqE+11jLS5L_gFFyzrQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: Re: [Qemu-devel] [PATCH 06/67] target/arm: Introduce pc_read
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/6/19 8:21 AM, Peter Maydell wrote:
> On Tue, 6 Aug 2019 at 16:04, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 8/6/19 3:00 AM, Peter Maydell wrote:
>>> Renaming pc_next would be a cross-target change, so let's put that
>>> on the shelf for the moment. Maybe just put a TODO comment to the
>>> effect that we could consider renaming in future ?
>>
>> I wasn't suggesting renaming the cross-target variable.
>>
>> I was suggesting shuffling around the current names, and using "pc_next" for
>> what it sounds like -- the pc of the next insn.
> 
> Oh, I see, so incrementing base->pc_next after we load
> the insn? Yeah, that would work too. Though it seems a bit
> odd to me to have the target-specific code modifying
> a field in the base struct -- that seems like it ought to
> be purely for the generic TCG code to use.

Part of the contract with translator.c is that base.pc_next is updated.  See
arm_post_translate_insn.

The difference would be to update early, immediately after reading the insn
word, before decode, instead of delaying the update until the end after decode.


r~

