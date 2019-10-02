Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2812C352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 15:23:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE02421848
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 15:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q423oyDi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE02421848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFgTR-0005qs-Uh
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 11:23:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47791)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iFgN6-0000K8-7d
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 11:16:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iFgN4-0007U1-H9
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 11:16:55 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:42130)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iFgN3-0007Rj-JS
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 11:16:53 -0400
Received: by mail-pl1-x643.google.com with SMTP id e5so7169563pls.9
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2019 08:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=05tls94euaalL4DwohLqpfyv0VHo5flj8PcM2IO60Ik=;
 b=q423oyDiT1KR2aho2xzaMLiIjYNyGqCROKCvVRItQ7JOG4MqK3YU/jUoxyBJp70onE
 k2qvpCR4Kr5saIB4hratTKb26cl9ycVpxQiLpR3lFzSoR0M3hBjN87aev4+jMRtUX86z
 nDtPvAeugJd+7FsL81O+iFXObZHRtrTe3uWW/yXJZ25TQ1k4nWiXSeWs/o1zisoUqhcG
 fZWe18a+jZf+jePdWFaCDpnd0x99WxW59WDgUpWMry6vDbpsaeIflCMY+FeRNIYqPLzw
 3uCvsPY7qiQtt4ygHCjCnzmer8Kx8SZkZQlm/zULkDbc2HNCsokgd+MsPjZZA0jFlYv+
 GXqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=05tls94euaalL4DwohLqpfyv0VHo5flj8PcM2IO60Ik=;
 b=pIaE6nglP/NYTVbQWuxPMHkKiqpakp/i+mQXa006yWeLhLG6NH1MRutFUBmyzpQ+88
 pVaTV1eVLOeNGM3b5Qi39Ani1xDpK7eekdY8u+kX0zscGzB8W7yoFyZYyJRyA//EbtsU
 RYbIwLTUWOz0lyXKbGV6emRNhyZ+hOZ/JgpoXrYY8l3+U/Jovv/3f0TxAvgd5zuaIVtN
 bDpUtfiUaU0l7EAnNkMymJleZtVYGZ5IaFW6g9JtPRi+28xGTqCceF71DfsLltUpY5Bi
 SiQ71CMVUkHx+YlvDlWdZ11D2r/iG27uWcWkoQ5XJ2gZY59PVypHlLMD6/zbBz9Pyxlb
 HnSg==
X-Gm-Message-State: APjAAAWspgc8OPCrZLH3qwvirH9YvqTOaq1gmrHoVNlMO7puEc3t+eif
 tHWQ64LJG3j3t8x7u31BK6cGTg==
X-Google-Smtp-Source: APXvYqyzthjqsqkvxmm+IrtXCYCzcpPeP8xDiW+fZlh1RnHyiaYN8gIuom3PwnMnad2t8X20LSvxxw==
X-Received: by 2002:a17:902:326:: with SMTP id
 35mr4352618pld.128.1570029408349; 
 Wed, 02 Oct 2019 08:16:48 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id s17sm30893669pgg.77.2019.10.02.08.16.46
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 02 Oct 2019 08:16:47 -0700 (PDT)
Subject: Re: [RFC PATCH] configure: deprecate 32 bit build hosts
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20190925233013.6449-1-alex.bennee@linaro.org>
 <CAFEAcA9vb5_Mi_axWpu7269Zg0xMLbiiV80ofLeyDpfws3G4nQ@mail.gmail.com>
 <4512b61a-ed82-e628-88e5-f44ef87c2b50@linaro.org>
 <20190930092519.GB11996@redhat.com> <87impakrky.fsf@linaro.org>
 <CAFEAcA8_Zt+4RuXh8ww3Xm5=fQT+e_XcjZ6VC2N9k5mzLy0bnw@mail.gmail.com>
 <ddf455e3-742e-81ce-c51a-d783e8d2ad55@ilande.co.uk>
 <58da7aa4-877b-2c85-71f5-e703a841e6d4@linaro.org>
 <20191002091037.GB607@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <02ab8cdf-1011-2bbb-c720-731c2b68537e@linaro.org>
Date: Wed, 2 Oct 2019 08:16:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191002091037.GB607@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "qemu-discuss@nongnu.org" <qemu-discuss@nongnu.org>,
 qemu-s390x <qemu-s390x@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/2/19 2:10 AM, Daniel P. Berrangé wrote:
>> GCC only implements int128_t for 64-bit targets.
> 
> QEMU probes for that during configure  and sets CONFIG_INT128
> 
> If I'm reading correctly include/qemu/int128.h then provides a
> fallback type based on a struct with two int64s.
> 
> This has some inconvenience though as you have to use the the (inline)
> function calls for all the basic operands and will be less efficient
> when using the fallback.
> 
> Presumably this is not viable for TCG ?

A structure (for some ABIs) may be passed and returned by invisible reference.
 It's not impossible (nothing's impossible), but it adds previously unnecessary
complexity to allocate that storage on the jit stack.

Actually manipulating one 128-bit value consumes 4/6 of the i386 registers,
which I can well imagine could wind up causing problems.  Certainly
manipulating two values at once is out of the question.  That's less of a
problem for arm and mips.

Anyway, all of the pain points go away if we assume 64-bit.


r~

