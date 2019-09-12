Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 105A7C4CEC5
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 15:07:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0237206CD
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 15:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oysIk/GC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0237206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8Qgp-0006xg-0l
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 11:07:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36541)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i8Qfz-0006RX-5Y
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 11:06:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i8Qfx-0008Tv-UO
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 11:06:26 -0400
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:40508)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i8Qfx-0008TR-OU
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 11:06:25 -0400
Received: by mail-qk1-x744.google.com with SMTP id y144so16748570qkb.7
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 08:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=YbrEvrfE7CtApP37hPEnQbBClZnQCo5bnRS2HOfQZ3A=;
 b=oysIk/GCLuuzRLHjEZuz+FM4IXlTDoy6uRfPNuMQRkQ3/wxnrL/5f0BXVWAFkFcfZF
 r7/tDl4pKke9Yu7h7r0bgrEJsCeK65DdP0nWtzpQB+bynmJurwHoimmmRYkmZa+pnW0K
 +O3mozkzhCY6PEzc21n0MAmkGg8bsXmPvoqrgIp+qw3QSeMFxtdJhlbPt1ZvPLcXY91i
 B27umhbih6fFBG+1N2TCdcLmvgOd9Ff0YDu09PkpWMsw52wKWgBQSR5xtYYXuJyR9G5V
 UyzgK3TsAiR0H8+R49dCUZ369WBkjdinKxTh2s5dzYn0WTaLptWalSpJ7LU999ziqe1g
 mTBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YbrEvrfE7CtApP37hPEnQbBClZnQCo5bnRS2HOfQZ3A=;
 b=Dns6mncMZLZ2x1NCzDv3nquep9j9PC4qguojoOJUKSxwKzgdp6LgeBkxbOeDdExR3S
 pXSB2gPRgk8JhOVlR3osfDUxw9sKTrCTVgQVqQVeV+sdWgYep38Bhb/mvUnBHe1JphLa
 zFclhtxrsiK5IQeg2Uiz5AlbW38as+XCsPPVmuNi+whPgyT5pbhEELeIBb0pXsmGy9JR
 TUAlgYxMKutawcV5/fiLc8BiXHnp6uXovwC0e63Q9P2x1y/WhXeJBXQWdJ/zUmV9A912
 eD2mdsbpnxoclMvFNmaBCVZiZSL+tzwSsDbvL/APBcmpIKhRdyagz5Gx9XH1M5mmhptU
 Xl4Q==
X-Gm-Message-State: APjAAAVPn3w1ndXfAAMClzPd8MfUrbUsCIj5B5EwhITL0CPtbjN60eKI
 hP88KFMFCtonM32CJihtgZQCLg==
X-Google-Smtp-Source: APXvYqzb7YHSKJK8BdY4ypPlmyUocztSTZxOs0Wm9Qf492Yp4c+h8i7Yd/18ciL4cTie60A80OZVbQ==
X-Received: by 2002:a05:620a:1ed:: with SMTP id
 x13mr41517974qkn.188.1568300784534; 
 Thu, 12 Sep 2019 08:06:24 -0700 (PDT)
Received: from [172.20.5.51] ([67.69.50.154])
 by smtp.gmail.com with ESMTPSA id 139sm11828278qkf.14.2019.09.12.08.06.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Sep 2019 08:06:23 -0700 (PDT)
To: Chih-Min Chao <chihmin.chao@sifive.com>
References: <1568183141-67641-1-git-send-email-zhiwei_liu@c-sky.com>
 <1568183141-67641-2-git-send-email-zhiwei_liu@c-sky.com>
 <CAEiOBXUveMJGpavU7_zK0UTdNniQvnXnw5MvE-hu7yHCSw8MPQ@mail.gmail.com>
 <b9c89438-5346-e2ee-403b-3bc1fa1637bc@linaro.org>
 <CAEiOBXXsag8hfHJGcqKLVKcVkndC67iPikcp-01WACoBA4ev3Q@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <b227759b-5a2e-6bb2-c68b-9922d484b811@linaro.org>
Date: Thu, 12 Sep 2019 11:06:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAEiOBXXsag8hfHJGcqKLVKcVkndC67iPikcp-01WACoBA4ev3Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::744
Subject: Re: [Qemu-devel] [PATCH v2 01/17] RISC-V: add vfp field in
 CPURISCVState
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
Cc: Palmer Dabbelt <palmer@sifive.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, riku.voipio@iki.fi,
 laurent@vivier.eu, wxy194768@alibaba-inc.com,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 wenmeng_zhang@c-sky.com, Alistair Francis <Alistair.Francis@wdc.com>,
 liuzhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/12/19 10:53 AM, Chih-Min Chao wrote:
> 
> 
> On Thu, Sep 12, 2019 at 6:39 AM Richard Henderson <richard.henderson@linaro.org
> <mailto:richard.henderson@linaro.org>> wrote:
> 
>     On 9/11/19 10:51 AM, Chih-Min Chao wrote:
>     > Could  the VLEN be configurable in cpu initialization but not fixed in
>     > compilation phase ?
>     > Take the integer element as example  and the difference should be the
>     > stride of vfp.vreg[x] isn't continuous
> 
>     Do you really want an unbounded amount of vector register storage?
> 
> 
>  Hi Richard,
> 
> VLEN is implementation-defined parameter and the only limitation on spec is
> that it must be power of 2.
> What I prefer is the value could be adjustable in runtime.

Ok, fine, I suppose.  I'll let a risc-v maintainer opine on whether there
should be some sanity check on the bounds of VLEN.  If you really do have an
unbounded vlen, you'll need to consider carefully how you want to manage migration.

>     >     uint8_t *mem = malloc(size)
>     >     for (int idx = 0; idx < 32; ++idx) {
>     >         vfp.vreg[idx].u64 = (void *)&mem[idx * elem];
>     >         vfp.vreg[idx].u32 = (void *)&mem[idx * elem];
>     >         vfp.vreg[idx].u16 = (void *)&mem[idx * elem];
>     >    }
> 
>     This isn't adjusting the stride of the elements.  And in any case this would
>     have to be re-adjusted for every vsetvl.
> 
>  Not sure about the relation with vsetvl. Could you provide an example ?

Well, I think it's merely a matter of there's no point having so many different
pointers into the block of memory that provides the backing storage.  I've
asserted elsewhere in the thread that we shouldn't have an array of 32
"registers" anyway.


r~

