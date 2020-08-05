Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BB1C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 17:01:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B04C322D00
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 17:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QJWu+y9m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B04C322D00
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3Mnb-0004z0-1X
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 13:01:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59954)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k3Mmf-0004Kb-QZ
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 13:00:57 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530]:46760)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k3Mmd-0005ox-7t
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 13:00:57 -0400
Received: by mail-pg1-x530.google.com with SMTP id p8so8670266pgn.13
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2020 10:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=osJ2w+V9cZlk83KQovNCzTBOfhPvNCOTBe1WQBXex7o=;
 b=QJWu+y9m3V7SE1wNRsLdIEHCSbwHUOmovMOGk1xgsWBXwXlPgNp01Ck0/Pp3BF/1rT
 Rz1Aifm3/6rwqZn2vnRm2nbceCH/lSZqgTJmm6q8sOiRvYFIBiKyqUliTgV9hb6M4atE
 oAfZQ+1nMnZgGX1fC01D+kM4GaPWR1fxvwhqcX/otcGYmda6FriZLedzij5P8UY3CzjA
 zceJHJedwakQbyz6+iA7c5gcngg5swvVpRRRakOXKXtiZEijoFUrJVjYIS6WJMxxEtJM
 fDzgcpFFHPA87G8BHm3GdQ8mIwXs4ZRO7DPTFE3IdVBCzi5c5DBo/DQF8g9ieWNMHdoJ
 sRSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=osJ2w+V9cZlk83KQovNCzTBOfhPvNCOTBe1WQBXex7o=;
 b=jWIlLV718P/ZY4AC0c41Xep3aEwNGSfY+6KxjiYYhM1uj48p58Vfs73xfPPPd+oNNk
 q6jM9trY50hdBC3T2sxY8kvsbl1kFu1O+p3pstSzghPsJWCYMNHRrtQvpQh1OsWbGnuX
 QQQfVIJfmU2Pl68f2H1Jk89QCbP62fo+KekaDh2ICtnuthom4s7ZJYSTBjoqPcyMooWu
 ccVSqt3frcD47VvEDafi3m7hrCY14xEWLmU0qkgkc4nP+LysbL/mrLPgpt/Q0qAXfa/Y
 6jDM1OKTP+ae84PTQHJPs1m2JKcz4yW1JFfx3vKHXEh7xXdnbQLH+gf+H/+ner5gMEiM
 nHaw==
X-Gm-Message-State: AOAM530QKxxtcs9YxoOdKNe1rINzzXfcWs2PXMDHWcb3Zi2SZGdZhC+3
 ztv2MxWTq0IhdT2jBmXka9QMcQ==
X-Google-Smtp-Source: ABdhPJzQJ/EEfJRsmkRFPU+9t4B/n7GFyI6EDFDgoU+ZATPvv8T+BiowXtEPbDo9LUMhJ2p2XFDcgg==
X-Received: by 2002:a62:1c0f:: with SMTP id c15mr4114148pfc.235.1596646852800; 
 Wed, 05 Aug 2020 10:00:52 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 193sm4022388pfu.169.2020.08.05.10.00.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Aug 2020 10:00:52 -0700 (PDT)
Subject: Re: v8.1M cpu emulation and target-arm feature-identification strategy
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <CAFEAcA_6zbOfdVi+Tp18seaEy4don1GurVya+E+QXRGrZ_WVLg@mail.gmail.com>
 <2c5ed9d8-6d79-1b53-5588-8fb9efebf0fa@linaro.org> <87tuxhkpo2.fsf@linaro.org>
 <CAFEAcA8+acTg6KoBDW5-7FvnrW=vDMXohWfTAXtTFv6BDqyuRQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a1e53e0c-fbab-a789-5f07-cfae99b6042a@linaro.org>
Date: Wed, 5 Aug 2020 10:00:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8+acTg6KoBDW5-7FvnrW=vDMXohWfTAXtTFv6BDqyuRQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/5/20 9:52 AM, Peter Maydell wrote:
> On Wed, 5 Aug 2020 at 17:45, Alex Bennée <alex.bennee@linaro.org> wrote:
>> I wouldn't test other feature bits but what stopping us adding:
>>
>>     struct ARMISARegisters {
>>         uint32_t id_isar0;
>>         ...
>>         uint64_t id_aa64dfr1;
>>         /*
>>          * The following are synthetic flags for features not exposed to
>>          * the directly exposed to the guest but needed by QEMU's
>>          * feature detection.
>>          */
>>         bool v81m_lob;
>>     } isar;
> 
> Nothing, except we already have a set of synthetic flags, that's
> what the ARM_FEATURE_* are...
> 
>> That said we still seem to have a number of ARM_FEATURE flags, are we
>> hoping they all go away eventually?
> 
> I think that they're a mixed bag. Some represent cleanups we
> haven't got round to doing yet (eg ARM_FEATURE_NEON, which would
> be a fair chunk of work, or ARM_FEATURE_PXN which would be pretty
> trivial to change to looking at ID_MMFR0.VMSA >=4). Some are
> features that pre-date the ID feature bit scheme and so might
> be awkward to convert (eg ARM_FEATURE_XSCALE). One or two
> we've already converted and just forgot to take out of the
> enum (eg ARM_FEATURE_CRC)...

I've always assumed we'd never get rid of all of them.

Older ones like XSCALE are obvious, but I don't think there's a clear indicator
for V{5,6,7,8} either.


r~

