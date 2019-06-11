Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4974C31E44
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 20:50:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC88920684
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 20:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sGiu9fE4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC88920684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55386 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hanic-0000aQ-Ad
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 16:50:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54456)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hanfo-0007Z5-5g
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 16:47:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hanfn-0003Hl-7Z
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 16:47:16 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:40719)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hanfm-0003Fd-UL
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 16:47:15 -0400
Received: by mail-pf1-x441.google.com with SMTP id p184so4876608pfp.7
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2019 13:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=R9lmnVStkdhvdSGPq/Fxtap0/Y82nacehX0TKh1C0uU=;
 b=sGiu9fE4UbSEYLouPOeF4SpM49AIbbMP0jAP+oppQSXK+WsM9sqU2k12mNGwT/AKa4
 PqkIktxZFX0SAPW+KPK8a9AOUeLezgS36e2/eWaH27+aNa+EnmrPheJs00dIzbS44S5A
 xtgBH8V7KnGxpxPs+gNib+0g6CrhGWRXRux1j+vzPejfivlByTGrDZjlSQXte0ANopp7
 Cl88/xuHXChF/ULA0nb/h52d1I9KGuGSchESsvp9G6+YuztiTmFOwdyo5YdPxi+huWmx
 i55lsqDXJjigvkZR0h+Ba67lpHkdTW8EhqetRdSF+lbLocthexErukDnKttRzLkCBpH1
 1Z8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=R9lmnVStkdhvdSGPq/Fxtap0/Y82nacehX0TKh1C0uU=;
 b=ioOCa1ARGdWX3A8TnWkFrp40hda3F1vQYqP5Wqt5yCGkE0tcxyjLBDx1+S/aklI+42
 /CaNC1Wcgui18Iy4qM1lqGhMZVa/9fc3st7t6RWllQU6ReZnAL97FmTcy7Ah/a1Knao5
 yTetPuYLam4Dgg2inO4j0XW1yZMtUr3yT4o1tBt5YyuM5+jY88E7iIZLi2oeoV/xq9CA
 TR6yl3i9O0oKIzr2SBOkzQfkFKehHSqr8oitjj9LjsvZ8VMBmSCb7rnCMCaCEmK0Hc/r
 6ejFgNgITUr727w6f/XegSZR/VU0SHPrtQh/UtKQKjy9DEGVDxkPve2hnL6rhLx+od0X
 pn9w==
X-Gm-Message-State: APjAAAXfDr62samlzuYKFKsxWS5iT9YnV/cGDmTo7DCM2xEgrIpZHvDY
 RKMj6yo8PllosoL0karLgDcwXw==
X-Google-Smtp-Source: APXvYqzWb/XCBV2ROMjzTRIj00PWWNfKirB/WfM08gn7ULXH7wTIugp9pGqUWL7NlPR0ZyNRo4VAHA==
X-Received: by 2002:a62:fb10:: with SMTP id x16mr83059111pfm.112.1560286033450; 
 Tue, 11 Jun 2019 13:47:13 -0700 (PDT)
Received: from [192.168.1.11] (97-113-13-231.tukw.qwest.net. [97.113.13.231])
 by smtp.gmail.com with ESMTPSA id
 q7sm14486487pfb.32.2019.06.11.13.47.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 11 Jun 2019 13:47:12 -0700 (PDT)
To: Michael Rolnik <mrolnik@gmail.com>
References: <20190606193012.37715-1-mrolnik@gmail.com>
 <20190606193012.37715-5-mrolnik@gmail.com>
 <9c74618e-eb1e-0225-11dc-fe51e634d265@linaro.org>
 <CAK4993gLwXopG=EFNePsHJYmTZ5uU7EgbGe3Ad4ofOdCxQX-Mg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <8429d379-c7e5-72b2-31cf-c4fa80f70695@linaro.org>
Date: Tue, 11 Jun 2019 13:47:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAK4993gLwXopG=EFNePsHJYmTZ5uU7EgbGe3Ad4ofOdCxQX-Mg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: Re: [Qemu-devel] [PATCH v21 4/7] target/avr: Add instruction
 translation
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/11/19 1:21 PM, Michael Rolnik wrote:
> I merged all you fixes and I get an assert(use_icount) in cpu_loop_exec_tb
> function, it happens on an instruction following SBRC.
> what might cause it?

No idea.  What is your test case?  And your tree, just in case there was an
error in the merging.

Looking through output from

  qemu-avr-tests/instruction-tests/bin/SBR.elf

     14a:       00 fc           sbrc    r0, 0
     14c:       0f ef           ldi     r16, 0xFF       ; 255

it works for me:

 ---- 000000a5
 movi_i32 tmp2,$0x1
 and_i32 tmp1,r0,tmp2

 ---- 000000a6
 movi_i32 tmp2,$0x0
 brcond_i32 tmp1,tmp2,eq,$L1
 movi_i32 r16,$0xff
 set_label $L1


r~

