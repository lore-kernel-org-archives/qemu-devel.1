Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C5C7C10F03
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 01:30:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E266E218D2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 01:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HgcPb5y+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E266E218D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33985 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJ6k7-0005Gp-4S
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 21:30:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ6hb-0003IR-CE
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 21:28:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ6QM-0000fI-DA
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 21:10:12 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:37850)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hJ6QM-0000dQ-6u
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 21:10:10 -0400
Received: by mail-pf1-x444.google.com with SMTP id 8so8385342pfr.4
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 18:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=q8TwHAD9KwFnBIO0KaXZmx6DPy4UhsaMneZio0TCMM0=;
	b=HgcPb5y+fII6sdy5gQ98Vqi8AL/ItOmU5uIdaRDhux3BQTeq6r4+j7+/BhtZ4TVUma
	XIMeESzQo9QIRv/kIzJAq4OeVeM9hq+Vo562UD8BefB/w6eKi2DhTD5n5vgwYC0awAq/
	RFrrWZJ2qcCHNR1cicYjNsJSmfhDisfF+zTxP8/EKMZpMdJofyQ1GfDoJNGd3+I2Upt8
	98tDcRZzjeGof8aOJsjdeUidorzWvp2kNjhecNelaMJHiQl8BqLIm6yWyaFKOxuu90rm
	2fMw2uCa5RF2SNYGoKfwy8Fm0sUPXaVs6WRtlBfkgmUE+lN/AMVQZ8/0SE8TJKaUdBDB
	9ROg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=q8TwHAD9KwFnBIO0KaXZmx6DPy4UhsaMneZio0TCMM0=;
	b=N3pI1xyeohPjzzRXzuMbj5PoAa5uTt4/cok5jPPamtSOzNJT3wBDOsJX1f2wdtvkcn
	wt8WfjpmjWVCj4W5MGxU5eZ8N11pYV8FvNj5DOOtun6N2yYQ/xyoJ8syxs0V5Uo5uy2X
	6d3TocC5xsVgcUJeZ6D3b4GhqMplFZuaFzr+/z2VZr3VamFu2rW+hRC6IADCW+vPGid9
	+tL4CRC7Qa8VFG2mHbRGOLpPDBFk0r3vls2yMqGPQDPZFgPz8RBeONDMsb70SpYTgnJ7
	9DpYqgIOZZ8Df3yYKvErMUk3JUUG+vTRD38e0+27mw88JJARI9ipQEnvuQZmZzBDZBc6
	+BGg==
X-Gm-Message-State: APjAAAVzgQ2zfdJPQTG8p7Gpubg79glfV0X62cx1eOj4YWJCvdfrZxrZ
	/p3JB6m1Sz7NWU9sLY/RCOk4SXSBysQ=
X-Google-Smtp-Source: APXvYqzmUNiQ2zmA1ADGFy3SXNPBWxuDspXn9Gi93usTlgs37nLnbRlL0dzF90slGhDE9Zxdc3YsvA==
X-Received: by 2002:a65:6546:: with SMTP id a6mr3987527pgw.5.1556068208672;
	Tue, 23 Apr 2019 18:10:08 -0700 (PDT)
Received: from [192.168.1.11] (97-113-179-147.tukw.qwest.net. [97.113.179.147])
	by smtp.gmail.com with ESMTPSA id l1sm19665052pgp.9.2019.04.23.18.10.07
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 23 Apr 2019 18:10:07 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
References: <20190416125744.27770-1-peter.maydell@linaro.org>
	<20190416125744.27770-22-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <8ab80d37-fc52-55ba-71b1-635a535f6c5a@linaro.org>
Date: Tue, 23 Apr 2019 18:10:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416125744.27770-22-peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: Re: [Qemu-devel] [PATCH 21/26] target/arm: New function
 armv7m_nvic_set_pending_lazyfp()
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
Message-ID: <20190424011005.2hXfbRr_j1Z9Nj5Vor-0gybnGUUUF9i22RhHsYiN2a0@z>

On 4/16/19 5:57 AM, Peter Maydell wrote:
> In the v7M architecture, if an exception is generated in the process
> of doing the lazy stacking of FP registers, the handling of
> possible escalation to HardFault is treated differently to the normal
> approach: it works based on the saved information about exception
> readiness that was stored in the FPCCR when the stack frame was
> created. Provide a new function armv7m_nvic_set_pending_lazyfp()
> which pends exceptions during lazy stacking, and implements
> this logic.
> 
> This corresponds to the pseudocode TakePreserveFPException().
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.h      | 12 ++++++
>  hw/intc/armv7m_nvic.c | 96 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 108 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


