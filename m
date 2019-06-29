Return-Path: <SRS0=rHaa=U4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0443C4321A
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2019 10:18:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85603214AF
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2019 10:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i9ay43QC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85603214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhARE-0007TA-CO
	for qemu-devel@archiver.kernel.org; Sat, 29 Jun 2019 06:18:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43443)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hhAOh-0006fV-No
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 06:15:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hhAOd-0002GS-RA
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 06:15:53 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:47031)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hhAOd-0002F5-Ec
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 06:15:51 -0400
Received: by mail-wr1-x436.google.com with SMTP id n4so8684091wrw.13
 for <qemu-devel@nongnu.org>; Sat, 29 Jun 2019 03:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=khjAK4SdxhZ2MRcVNa966cejxUgneJVwFueaH5g/biw=;
 b=i9ay43QC4MCSM69MNV7dgfKIW+XrW5StrybvqtiOyWjsaxCJW/Q3zUSfP19OA+/zfO
 jrCLbGcqGPyUtUl1metQ/K+jEyQdPljDFm6YPIUA9wNW9V9csBB4obTsRI+BmGG/8McX
 WlzU5XAaJhaKEm0QWIJOYbWyt1TVYCZ/j2pLy4d2es/3cHLd++kNt+yRqSgkdjJ6vLmE
 Hpm9tjFT7wWUm7tACWKSyFC9fUxWjOLC3GQKpPI1RsAjxInK7zfy4cGC4DLT0apQ0OAQ
 j1lHvXD1gTH6d+4O+0YpHmqAx9/egY0vEIJcy5KyyMdMVc70Loy/guTn4bhQYV3gSDuY
 gZmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=khjAK4SdxhZ2MRcVNa966cejxUgneJVwFueaH5g/biw=;
 b=IColTNxrGYaq4ORf7Tsy7c677H50UKT0mJKThqw4UT9WhPJtk8pXuePJQsqHJ9UXJE
 2AJdLy87F9rZ+6fHhEOa7iArCjFGRvyZotsqPGv9LBywg+Aa/Vq1jyFQOuDPirO1dM2v
 ZUdOsfHgfmX5rJ7D+I7ksT5ElRQc1f0jPF/aydHa+7CfRtXR4H7J5kOpNPjiCKRONVEQ
 daiUIYsZ5UoNNWXhv4yXq5zV9KiDOk9nqwC5MQ6eKv1Jl6lMnUaloqWe96sur/ukgG1R
 e94mjkvozs1968nJ1jGiKwL7mDFR5dMqMAQuLTmHYb8X4GgStJDuntPdOzI6BWKs92fw
 Mwzw==
X-Gm-Message-State: APjAAAWi1c8vUuvAELNce/65B8MdG1rHpBk08iyi0PdZNaWOXl5oW2BX
 +CPrENZlC0+YyhQRVNyOvf+mFg==
X-Google-Smtp-Source: APXvYqxNnYBhbg8M1q/5RlxXHdPUeydY7ucqbAewFDlApqfEs/u3vbV6RpXsJw1HGevh7ZIJF2Jnzg==
X-Received: by 2002:adf:f98b:: with SMTP id f11mr5792668wrr.231.1561803348790; 
 Sat, 29 Jun 2019 03:15:48 -0700 (PDT)
Received: from [192.168.2.137] (93-34-153-63.ip50.fastwebnet.it.
 [93.34.153.63])
 by smtp.gmail.com with ESMTPSA id d10sm4145604wro.18.2019.06.29.03.15.46
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 29 Jun 2019 03:15:47 -0700 (PDT)
To: Lucien Murray-Pitts <lucienmp.qemu@gmail.com>
References: <2136180936.260219.1561641583358.ref@mail.yahoo.com>
 <2136180936.260219.1561641583358@mail.yahoo.com>
 <1079763171.281101.1561641752988@mail.yahoo.com>
 <e4c1fbc4-3e43-5df4-a17c-527d98d9763c@linaro.org>
 <20190628002713.GA19257@localhost.localdomain>
 <eadb57ae-256d-0bb7-5988-f493662a5caf@linaro.org>
 <20190628155030.GA34320@localhost.localdomain>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <ea16a81c-5b94-8dd0-8339-2bd82733aed2@linaro.org>
Date: Sat, 29 Jun 2019 12:15:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190628155030.GA34320@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
Subject: Re: [Qemu-devel] RFC: Why does target/m68k RTE insn. use
 gen_exception
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
Cc: Lucien Anti-Spam <lucienmp_antispam@yahoo.com>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/28/19 5:50 PM, Lucien Murray-Pitts wrote:
>  op_helper.c
>    static void m68k_interrupt_all(CPUM68KState *env, int is_hw)
>    ...
>      if (cs->exception_index == EXCP_ACCESS) {
>       ...
>       do_stack_frame(env, &sp, 7, oldsr, 0, retaddr /*LMP: BROKEN - needs PC NEXT*/);
> 
> Actually according to the MC68000 manuals the "return address" (the PC saved on
> the stack) can be upto 5 instructions later due to prefetch. So some pc_next
> would best be used here.

The way I read it from the 68040 manual, it's "the pc of the instruction
executing at the time the fault was detected".  Well, we did in fact detect the
fault at "retaddr", so that seems to be the right answer.  The fact that real
hardware has a different pipeline and detects the fault later seems immaterial,
and largely irrelevant, since the programmer wasn't given any guarantees for
what sort of value appears in that slot.

> I am triggering this from inside my device by doing the following, since that memory address
> should dynamically cause a bus error (I hope this is the right way to do it)
>    cpuclass->do_unassigned_access( s->cpu, /*addr*/0x0, /*is_write*/1, /*is_exec*/0, opaque, /*size*/4);


For a device to raise a bus error, it should return MEMTX_ERROR (or something).
 This eventually reaches cpu_transaction_failed, which has all of the data that
you seem to be missing above.


r~

