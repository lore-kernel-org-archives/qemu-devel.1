Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E314EC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 17:14:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13F9E21D7D
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 17:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fLsPK3OI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13F9E21D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQZUg-00039Z-V1
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 13:14:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49992)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kQZU6-0002cL-6K
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 13:13:42 -0400
Received: from mail-oo1-xc44.google.com ([2607:f8b0:4864:20::c44]:39294)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kQZU4-0006Ee-Gl
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 13:13:41 -0400
Received: by mail-oo1-xc44.google.com with SMTP id c4so1645546oou.6
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 10:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=z7dfDSuvx/c2gFB94Jskoi+PPftvQcHJk13W3TDs7HA=;
 b=fLsPK3OILvGhk7im1x2o5bdc8tXDQvH1bCEqV3l4EW7XPkhEKogzgt3D4i0ZZ5HSZN
 mwUIlcxOJyHTR+K9lkvLCcXLQd+tUypReqGwqTnD77p6x6WWi40UVztondK8BT8HVWwo
 +3/WBBgeYrUBe8ULWbrFBvalmSgfK+AcioxvCmtLPS67j8jceTLHmhhcGKKhVopJnKII
 Mk8fgwzLeG2La445MjLIVOlYFN4rk5Po2TsVmN844/yQra5/VThi+EXNeLTQnLKc1nIm
 XHd3NGsdLvFbq95eZ0OI6Goo5N35dBtviUeDPPGiyjl9nHg6jDknGQxcQH1v5/bmnCAa
 W8EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=z7dfDSuvx/c2gFB94Jskoi+PPftvQcHJk13W3TDs7HA=;
 b=Sb0VneKrsyBMvETx1qCl1D1tjuDwOjGHXBIUeoaX7/oppIClDJevE09l4eFv5n+oiQ
 oLyetr4NcL1Klcy53Ze/X8tHqRSAmjlGuzLE6PjUQCVdqYtIFglyZhEbBsQ5VJHVbo4n
 eZZ4TyRS0Qcx7Pz0z43h5kqpd+9yv6vW0eScclY06izcOim6eDYa5wQ6E59dpkCLkal8
 JMh6wboo3NfB4b3LujtOK/v3JvKQpz5Z2rhc+uUFeLd1ZdNvhxv4BE7rE6DQ5ZYi/51x
 3gYTdTGEQWQ2piZt68ZOQmNxaKNbug1iAbJ7Pf8C4t9p7G1XsCEuRrlVhGuaDtrMvZu1
 OKkw==
X-Gm-Message-State: AOAM530wsLpAdLCDeMTEq4WoeTR7WMxabaj4L7xrq4sNFPNYQD/q0Otz
 qbLOA49tRzFEf+dPvp74a9Ekxw==
X-Google-Smtp-Source: ABdhPJy1tMoisx+o78loeTz29fHJMnNH/XiQ9NxsSEWMCBqtVGD6pi+8cib8HUDgbmAjH+EEI8Pj9g==
X-Received: by 2002:a4a:3b91:: with SMTP id s139mr6121043oos.34.1602177219165; 
 Thu, 08 Oct 2020 10:13:39 -0700 (PDT)
Received: from [172.24.51.127] (168.189-204-159.bestelclientes.com.mx.
 [189.204.159.168])
 by smtp.gmail.com with ESMTPSA id j1sm5136690oii.5.2020.10.08.10.13.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2020 10:13:38 -0700 (PDT)
Subject: Re: [PATCH v10 7/8] linux-user/elfload: Parse NT_GNU_PROPERTY_TYPE_0
 notes
To: Peter Maydell <peter.maydell@linaro.org>
References: <20201002215955.254866-1-richard.henderson@linaro.org>
 <20201002215955.254866-8-richard.henderson@linaro.org>
 <CAFEAcA8jBAKe_tWAKzAXq4LFO5vk1H8AZN+s+3oWsLfoRugQdQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8ac9575b-4a2b-aa8a-3279-8ead52402d59@linaro.org>
Date: Thu, 8 Oct 2020 12:13:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8jBAKe_tWAKzAXq4LFO5vk1H8AZN+s+3oWsLfoRugQdQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c44;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.214,
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/8/20 9:02 AM, Peter Maydell wrote:
>> +            if (note[0] != 4 ||                       /* namesz */
>> +                note[1] < 12 ||                       /* descsz */
>> +                note[2] != NT_GNU_PROPERTY_TYPE_0 ||  /* type */
>> +                note[3] != gnu0_magic) {              /* name */
> 
> note[2] and note[3] are both basically magic numbers, AIUI.
> Why do we have a #define for one but we assemble the other
> with a const_le32() expression ?

Because one is defined as a number, and the other is defined as a string.  And
why *that* is, I don't know.  Silliness, perhaps.

> The spec for the .note.gnu.property section (which AIUI is
> https://raw.githubusercontent.com/wiki/hjl-tools/linux-abi/linux-abi-draft.pdf
> ) says that the n_desc (words 4 and up) is an array of program
> properties. There doesn't seem to be any guarantee that there
> is only one entry or that the FEATURE_1_AND entry is the first
> in the list. Don't we need to iterate through the array to find
> matches? This seems to be how the kernel does it:
>  https://elixir.bootlin.com/linux/latest/source/fs/binfmt_elf.c#L786

Hmm.  I missed that change since the first time I looked at the in-flight patch
set.

> (Is it worth adding the infrastructure to parse notes generically
> the way the kernel has? I dunno if we think it's likely we'll
> want to do this for more note types and/or other architectures
> in future, so it might just be pointless complexity.)

I dunno about that either.  I'm not really sure what "generically" would look
like without another exemplar.  I'll look at what else
arch_parse_elf_property() is being used for.


r~

