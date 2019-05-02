Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE08C04AA9
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 15:25:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94BB120B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 15:25:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kpdIzsIk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94BB120B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53125 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMDab-0006kK-Rj
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 11:25:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMDZW-0005uI-Gk
	for qemu-devel@nongnu.org; Thu, 02 May 2019 11:24:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMDZV-00082B-15
	for qemu-devel@nongnu.org; Thu, 02 May 2019 11:24:30 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:38695)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hMDZT-00081q-TL
	for qemu-devel@nongnu.org; Thu, 02 May 2019 11:24:28 -0400
Received: by mail-pl1-x644.google.com with SMTP id a59so1188887pla.5
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 08:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=lMqG7DOLylP9ocx8Y4iYPTwT5hb1fZa0IBY7Jqr24dY=;
	b=kpdIzsIkhDRyaexb6t+eJPP+D6Bh9JArpYDUeO5ztf9k5NWxr3Wdz4DPVdvwbTrA68
	hN31IuvK1394fKADGT4yOPBOJH3mj4vokac2+A8AlAFujlY8+n2PkhRRZ3b2pYf7dKJ2
	koiYGYV5Sat3Nq4FYoQBoEVxdQwaSRxcwGvOeh4x0+KtloTbMcdYTZjdVMosD5qVEpa4
	4TiTyQu/8fBwzDuhjPC5IIdkUTWTbfzxdlkLKK0r0CyoP60+sVqcUvVa40bLAV6v6XVa
	1rktOdRNqojx/kSz1E3G2F081wOhLU6YQyfsMtD/nrBty2OlX+o7aIqbbAwhmQLwGeWA
	qFqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=lMqG7DOLylP9ocx8Y4iYPTwT5hb1fZa0IBY7Jqr24dY=;
	b=Ck4IpU86sNMKHDPjUhx66KtzWb7YgXyeyAvshJYSC7MC2kPPzn3BFlyLQ1ql9j20Pe
	61EHPbRt9I47DW//AKbSBheOg08mcY9815O7vV3fnwNA9apk+bvtHsIQeSNReWcP0go+
	upHWufMuRanX2DVA4RsBgyWSabLdouzJ8N65u9kmQfdKXmhu4xV3FmNAtaYiP6uL+0+f
	mswi6m/YTRqJtWqIQAaFO2LPlm+tMieAyUV2qXoQxJCbe1D5bH0HfTrY7LD+tAqfein4
	E5H9gfIFF1IFmcE5yyVNl6Cgl206xMpFO5Mud54bUp3Fs91ufTGndTVNzan8BZTPYxrC
	LHSg==
X-Gm-Message-State: APjAAAU/mufG9QW6f9CrVkr5JfZmoY/u/BiXsMzQlko6/PZ1dZLiZcU8
	EZNYx2ElGXpql0N7GYVP8Wc1hJUZ1Xg=
X-Google-Smtp-Source: APXvYqwZHlssyPqQqLui3kTEelEgLYa0TCHuSnh7mg9YV8xuX/NmS9HY/zO9caQZ+QylUHuYdboOOg==
X-Received: by 2002:a17:902:3064:: with SMTP id
	u91mr4433774plb.181.1556810664711; 
	Thu, 02 May 2019 08:24:24 -0700 (PDT)
Received: from [192.168.1.11] (97-113-189-189.tukw.qwest.net. [97.113.189.189])
	by smtp.gmail.com with ESMTPSA id
	y1sm52355450pgc.29.2019.05.02.08.24.23
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 02 May 2019 08:24:24 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org
References: <20190501050536.15580-1-richard.henderson@linaro.org>
	<20190501050536.15580-10-richard.henderson@linaro.org>
	<87imut5h10.fsf@zen.linaroharston>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <2b019ad5-396f-c337-499f-b120aea2e4ad@linaro.org>
Date: Thu, 2 May 2019 08:24:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87imut5h10.fsf@zen.linaroharston>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: Re: [Qemu-devel] [PATCH v2 09/29] tcg: Manually expand
 INDEX_op_dup_vec
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190502152421.6CVhnoRB_lK1TW7_6hnqcPdcTgRq91pmaOSW7q6ztH8@z>

On 5/2/19 2:42 AM, Alex Bennée wrote:
>> +static void tcg_reg_alloc_dup(TCGContext *s, const TCGOp *op)
>> +{
>> +    const TCGLifeData arg_life = op->life;
>> +    TCGRegSet dup_out_regs, dup_in_regs;
>> +    TCGTemp *its, *ots;
>> +    TCGType itype, vtype;
>> +    unsigned vece;
>> +    bool ok;
>> +
>> +    ots = arg_temp(op->args[0]);
>> +    its = arg_temp(op->args[1]);
>> +
>> +    /* There should be no fixed vector registers.  */
>> +    tcg_debug_assert(!ots->fixed_reg);
> 
> This threw me slightly. I guess you only really duplicate vectors so I'm
> wondering if this should be called tcg_vec_reg_alloc_dup? Or maybe just
> a bit of verbiage in a block comment above the helper?

Perhaps just a bit more verbiage.

The convention so far is "tcg_reg_alloc_<opcode>", where so far mov, movi, and
call have specialized allocators.  Everything else happens in tcg_reg_alloc_op.
 So tcg_reg_alloc_dup is correct for handling dup.


>> +    case TEMP_VAL_MEM:
>> +        /* TODO: dup from memory */
>> +        tcg_out_ld(s, itype, ots->reg, its->mem_base->reg,
>> its->mem_offset);
> 
> Should we be aborting here? That said it looks like you are loading
> something directly from the register memory address here...

No, we should not abort.  We load the scalar value into a register that we have
allocated that matches the input constraint for dup.  We then fall through...

> 
>> +        break;
>> +
>> +    default:
>> +        g_assert_not_reached();
>> +    }
>> +
>> +    /* We now have a vector input register, so dup must succeed. */
>> +    ok = tcg_out_dup_vec(s, vtype, vece, ots->reg, ots->reg);
>> +    tcg_debug_assert(ok);

... to here, where we duplicate the scalar across the vector.
Success.

The TODO comment is about duplicating directly from the memory slot, with a new
dupm primitive, which appears in the next patch.


r~

