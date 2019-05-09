Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DB2C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 15:44:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 869482173C
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 15:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KCby48E/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 869482173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56718 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOlE6-0006gc-0k
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 11:44:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOlCs-00065g-LY
	for qemu-devel@nongnu.org; Thu, 09 May 2019 11:43:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOlCp-0004Jh-Un
	for qemu-devel@nongnu.org; Thu, 09 May 2019 11:43:38 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:42562)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOlCp-0004JG-NI
	for qemu-devel@nongnu.org; Thu, 09 May 2019 11:43:35 -0400
Received: by mail-pl1-x642.google.com with SMTP id x15so1332800pln.9
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 08:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=vSqRbLC9tRBt5LJsiBuHY0niOl/8xtZfLGJvXyrScys=;
	b=KCby48E/JJmSBRjIsd1Gwt1TeynDMk3W3lsAOF0k0vFwhPPNJCn/yvTMcFgqhmmtvw
	PzMwhBA3uqbVpHango5TV88fiGS55ALSzkHGQjKOrpKnSinNZAlYWY4HXwcl75o+ymLh
	Cu1ewfAtXiS2fQnc61D5Gtvd2ZxzNwzXIReDMqGuw/YP7qZvazl9uCwULr1nXOTyD+3F
	BPSXjcGvc/u6AugqvBbM42lwf47GuxJJkvZsbD55nB1Wz1WRTF/ichBQm6phZuLHt2PG
	uGhrlnV041cptad2DMTvPIBh3Qzlig4g1HnvZ7LJpc2frBBIRZbprZqgnxV3EOUmnYfj
	xnpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=vSqRbLC9tRBt5LJsiBuHY0niOl/8xtZfLGJvXyrScys=;
	b=ELztDLCJ0AJPNqA4zDgtKkqd5jGoC8ehSIugxafupBfyhNbFIAz24V3OPepdCPygpG
	2lpGHgg7kQLnHgjQfocIbaf2fMSki+32Bq/+hML8vGCCHG6C/c/MjZ/O19Qlzq92c5bv
	JKQ/ugsINOzi4Ab4nLOloS2+yBEs59F5458a4t8a7ONTQDc++QeUNcor30hK5s4L1Vyj
	Wn9Dwojza07nGuFSVWvvA6xIQDmskLwpQmGuLXMCaBiz4bsMJjjZnGRdb73Tm5Wei8YM
	e4tet+FoKUfakH+N56QVMLHf0PbDbDluPaxzpLJ/qdwZkq3bb030dXwS7JBY44fBwXhm
	OUHw==
X-Gm-Message-State: APjAAAX3s5IvlyqegyJmazdE5CPsFRRyWbQgZiyFHG4apqD7JsfaFcjN
	TzEQq2lr/XOWpfxDs8XhdQd7ow==
X-Google-Smtp-Source: APXvYqzseoUtXHzavVlh/EVI/+4Ik60bH+i7ijUrQRTYq1BXgi43l8U7WSdD2PwrC2Tkx81/41R+wg==
X-Received: by 2002:a17:902:d917:: with SMTP id
	c23mr5899228plz.14.1557416614498; 
	Thu, 09 May 2019 08:43:34 -0700 (PDT)
Received: from [172.31.99.192] (50-248-210-99-static.hfc.comcastbusiness.net.
	[50.248.210.99])
	by smtp.gmail.com with ESMTPSA id m14sm81709pfj.29.2019.05.09.08.43.33
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 09 May 2019 08:43:33 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190509060246.4031-1-richard.henderson@linaro.org>
	<20190509060246.4031-15-richard.henderson@linaro.org>
	<CAFEAcA_ptiM8HWcvcu1+3DULec2uoYpLuLorNnPvDzvmhb+oXw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <95b693ad-d1ca-6356-40e7-185de1ec6bd9@linaro.org>
Date: Thu, 9 May 2019 08:43:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_ptiM8HWcvcu1+3DULec2uoYpLuLorNnPvDzvmhb+oXw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: Re: [Qemu-devel] [PATCH v2 14/27] target/nios2: Convert to
 CPUClass::tlb_fill
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
Cc: Marek Vasut <marex@denx.de>, Chris Wulff <crwulff@gmail.com>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/9/19 3:02 AM, Peter Maydell wrote:
> On Thu, 9 May 2019 at 07:10, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Remove the leftover debugging cpu_dump_state.
>>
>> Cc: Chris Wulff <crwulff@gmail.com>
>> Cc: Marek Vasut <marex@denx.de>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>> v2: Keep user-only and system tlb_fill separate.
>> ---
> 
>> -int nios2_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size,
>> -                               int rw, int mmu_idx)
>> +bool nios2_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>> +                        MMUAccessType access_type, int mmu_idx,
>> +                        bool probe, uintptr_t retaddr)
>>  {
>>      cs->exception_index = 0xaa;
>>      /* Page 0x1000 is kuser helper */
>>      if (address < 0x1000 || address >= 0x2000) {
>>          cpu_dump_state(cs, stderr, 0);
>>      }
>> -    return 1;
>> +    cpu_loop_exit_restore(cs, retaddr);
>>  }
> 
> Commit message says we delete cpu_dump_state() call but
> the code doesn't seem to change it?
> 
> Otherwise
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Argh.  Got lost in the other v2 changes.


r~


