Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 458D2C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 21:32:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 075D920880
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 21:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i+NzBgta"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 075D920880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoaUI-0008Tv-1y
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 17:32:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33327)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hoaU6-000841-O9
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 17:32:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hoaU5-0003vd-0l
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 17:32:09 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:33205)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hoaU3-0003s1-TC
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 17:32:08 -0400
Received: by mail-pl1-x642.google.com with SMTP id c14so16159264plo.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 14:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=bwzHMJBnIyiZ4wlVPVA1APQri3e0iv6//yr1gDM3/V8=;
 b=i+NzBgtaiBlNj0ZnEMhcJpxSpSB+UGX000u19IMMLxM33hQ3v80CRWyaKn7NF4zEig
 9wMVmv8C/peQZvUw/uhQU8rWY0Tbp49IG7XJBbyU4yZDyQ5HBFReaqsxNnbIR9xZd8xP
 X1rgLj9WDXTAqbHhKQVZDg4/2xyZSBUEJLxFPDrRlCRfbbsvMalpsZkL2ObXF4cvaSAg
 gwxU6lKmT9BiWA+YY1tFFN4eGaZbRaCxKmWKbPWZuY0XP0uWauhhp/3pH7fntRIM7CtD
 7vfJstWarSHFLC8Eg0zQbiIx258j8GlLsD4PzIszc0WOrLVNDuC+gIzhaaON7EoSxKmm
 J9jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bwzHMJBnIyiZ4wlVPVA1APQri3e0iv6//yr1gDM3/V8=;
 b=CBepftnf5CB5tWlTacDvVLhvQAriZ3mVBpJ1ndhY/yv+1eTTE//taOUcDt0jPxlEEy
 +QOEI1Ssfyd2r1hHnWEz5gUFkumlITFq3f0xRUOZeV4N1t3vi6L4vDAramAVTvlhcWkX
 aK7IbICAXj7grtrVBBQxQhKHqVdIMCpbqjtnL7+EIvjTZWBUZG+SO9zOTMSNSL9xZVY2
 7f/XyGe8YW38fmMX6HNzoWhTA2KgOJ/P7EcBJHt8a+n2JzTFAGxe1wuuk8HTQEiV+F5i
 sd+dGErEtezMMy70wNHkL++/IpX5lwzBTBOwUkWYMQoiN8wtAgHCZIM1YZkWB4FOIweL
 aj5A==
X-Gm-Message-State: APjAAAUAMpQubx4GA81lF7Khjgu2eNnk+tEuKAN/Zm7KHt4oXfSXQzhd
 UkxcXtYbLHFI/pBtxpiWMDgWWxzfRfc=
X-Google-Smtp-Source: APXvYqwxxmRVRzWtcMSxFxc5Q9muy2TmDZw5EWXvmDzIUGpRwFlseKVlCGwo/Yoozu8p2qD1KvSxjA==
X-Received: by 2002:a17:902:9a49:: with SMTP id
 x9mr59541052plv.282.1563571911378; 
 Fri, 19 Jul 2019 14:31:51 -0700 (PDT)
Received: from [192.168.1.11] (97-126-117-207.tukw.qwest.net. [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id a3sm22758089pfc.70.2019.07.19.14.31.49
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 19 Jul 2019 14:31:50 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190307170440.3113-1-richard.henderson@linaro.org>
 <20190307170440.3113-21-richard.henderson@linaro.org>
 <CAFEAcA9R8kDqLxVVFjJFx_tuNFYXJWQDCv2vEyuBdLXtjMETWQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <8b6a7e87-81d7-503b-80be-6bebdda23b30@linaro.org>
Date: Fri, 19 Jul 2019 14:31:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9R8kDqLxVVFjJFx_tuNFYXJWQDCv2vEyuBdLXtjMETWQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: Re: [Qemu-devel] [PATCH v4 20/22] target/arm: Create a TLB entry
 for tag physical address space
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/19/19 8:48 AM, Peter Maydell wrote:
> Playing around with this series, I have discovered that if
> the board model doesn't create the tag-memory then target/arm/cpu.c
> will not create the 'cpu-tag-memory' AddressSpace. But nothing
> disables the usage of the target_tlb_bit2, and then when
> arm_cpu_tlb_fill() does a tlb_set_page_with_attrs() using
> an attrs with target_tlb_bit2 set then we assert in
> cpu_asidx_from_attrs() because cpu->num_ases is 2 and
> cc->asidx_from_attrs() returned an out of range number (ie 2).

Oops.

> Is the tag-memory mandatory for MTE? If so we should either
> disable MTE if no tag-memory is provided, or else fail
> realize of the CPU; not sure which. If it's not mandatory
> then we need to avoid asserting :-)

I'm not sure.  I'll need to study the docs again.

There is an MTE support level at which some of the EL0 bits are recognized but
no tags are supported: ID_AA64PFR0_EL1.MTE == 1.  But that's not quite the same
as what you're asking.


r~

