Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1804AC3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 22:29:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7F9220856
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 22:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BYENM0/d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7F9220856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2jyK-00018e-3w
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 18:29:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43144)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i2jxd-0000bt-O7
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 18:29:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i2jxc-00071B-Jr
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 18:29:09 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:41432)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i2jxc-00070w-AR
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 18:29:08 -0400
Received: by mail-pf1-x442.google.com with SMTP id 196so301449pfz.8
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2019 15:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:from:to:cc:references:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=IF9fJL+VeAQcEJG2C6t3bkzt138oQ5+LBv8tEkVKhEg=;
 b=BYENM0/dJhnEo3c0Bn4KsfpDPgGdNc4wZXr3+PQGxSNThfVU07uAAXQvtjVEZHdlCU
 O79Qtj+xMx20VNCFipXK09dlVY4gEjyMOBsJuxi5cOv1HqVsz1ei1izIfSj430kUr3Cr
 AzbF6daKxI3OJXPNGPad2iuqk6+N8JkfOYGXs9OfVb7b+TDIGwLCYGlPRdfGMxdK+awB
 fxhSRSfvGOEowYeGbptF91KdnFGXlLnvp9+UGYNBBjf2sOBluw1e9IC/mYvtkZbPqyL0
 mFAJmU+s4bz2m8Bdaj1fpqekrM9VOvj5eSIQ/I5u5TV+bo41vbhFsFOsX7blBWrbIsOx
 Wxfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IF9fJL+VeAQcEJG2C6t3bkzt138oQ5+LBv8tEkVKhEg=;
 b=sb6UlDiaC3bu3B7gfy/WFGlaWC82OvQTZYYSJzl19CNsGsobuKzAaNPtVrbD0Q5w/e
 PFCXGzH5qzixJjGNgopdPKbfPSvkEymX3y0P5aA4gX5vhA2oNmCtpr4DWVD9DoyvQ6gj
 s9ZPjV9h2Ub75ZK1602DR5mHskLbslu4/o9TW215PFmo0ExtCwl8B1qEEUhFjQDxxfB8
 +dI04PGMYOWkirEZX+eEGsXUriOdFYt2l63sN1A5aQVRM4pZUTL3krxZ7dqLryulj0w5
 agUhT1XSYgSiNvTLp4hBQEXY5S0Zwr9cwj0Qsfjvq+enO598WpDsMpzrBlRIZSu7KOBz
 Odow==
X-Gm-Message-State: APjAAAVMXpUfkODaWnY8NLzh5iqiTCEGPBm5NX0xk3JBPFdSw8YicBip
 yJVOGNr3cnibRqVeGMHsQkWALA==
X-Google-Smtp-Source: APXvYqzManRbM0sysI7MPoUErs/47ISuiuOnDBmfn8qZBWYpfvls2RVNHo+TjOBUfPfcpK9eDWo7qw==
X-Received: by 2002:a17:90a:be06:: with SMTP id
 a6mr1066370pjs.92.1566944946939; 
 Tue, 27 Aug 2019 15:29:06 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id n24sm226694pjq.21.2019.08.27.15.29.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 27 Aug 2019 15:29:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190819213755.26175-1-richard.henderson@linaro.org>
 <20190819213755.26175-19-richard.henderson@linaro.org>
 <CAFEAcA9qN47t8zXJ7X3TmhkigSEjf+esxVNwQ0m9X=qa2KF_bg@mail.gmail.com>
 <9fe4184f-7483-4207-2536-16ee798f3747@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <573345b1-5ea2-b88c-b07e-0281d2ea6f79@linaro.org>
Date: Tue, 27 Aug 2019 15:29:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <9fe4184f-7483-4207-2536-16ee798f3747@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: Re: [Qemu-devel] [PATCH v2 18/68] target/arm: Convert the rest of
 A32 Miscelaneous instructions
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

On 8/27/19 1:01 PM, Richard Henderson wrote:
> Other constraints, such as rd != 15 or imod != 0, should continue to return
> false so that a (potential) grouped insn can match.

Eh.  This is not the answer that the TT example suggests.

So far we are able to order the grouped insns such that
decoding directives like

    if t == 15 then SEE "TT";

are respected.  Since we do not generally do a very good
job of diagnosing all of the UNPREDICTABLE behavior, we
should not rely on getting all of it, e.g. by requiring
that if TT diagnoses some UNPRED that STREX also diagnoses
similar UNPRED.

I'm going to walk through the patch set and fix these.


r~

