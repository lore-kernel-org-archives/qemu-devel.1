Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EFFC04AA7
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 00:29:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E473217F5
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 00:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="smGEPcvf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E473217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36888 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQLJY-0002l0-Rl
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 20:29:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQLD0-0006xS-T2
	for qemu-devel@nongnu.org; Mon, 13 May 2019 20:22:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQLAi-0006wQ-Ry
	for qemu-devel@nongnu.org; Mon, 13 May 2019 20:22:16 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:46808)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hQLAS-0006a3-Mp
	for qemu-devel@nongnu.org; Mon, 13 May 2019 20:19:43 -0400
Received: by mail-pl1-x643.google.com with SMTP id r18so2518383pls.13
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 17:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=oIkVmNeg/B6R6chvnMOItPsHgkpWpa1zwyyIpqDbq8U=;
	b=smGEPcvfryodsu89HYqKa+pH71m0dQ4b+n4PT/VkjVHNdcjRgI+pUwOHknA39XXyUR
	21zXC+jAwQZRzZSvXk2np58yvXS1tLdoTI2q3fj+Zqz9RiqWTOyX8lm9+gOtbWYqRlr+
	v0YUff3Lna7ayHDdPdiUC7U9VHicqadOvjGDtABD69KeC+ruTCqz+3leBU91kJTBisrv
	nxCebAT4SZ8KHA1tk8TEB2e/fTHb8Wj4AixPDVwmBu5js4M/5ijxddvUK2gifkqJWnwo
	q72eezB2EgGo4EqwYpX9C+tfvDZ7u1hW4NIs0ousGgzof4r3uUIdUO5+R9FSHFCSCmWI
	fHiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=oIkVmNeg/B6R6chvnMOItPsHgkpWpa1zwyyIpqDbq8U=;
	b=OdR+x9RrpsD9XQ775mYkm5H8zV0Yor0HUI2e+QdTC6aSwv+t7rtgesRq9oHGPNqNo2
	sMKXS6KkGxrzVkocSPPp05dtXD0uIIhg3yzWSyo52C7BetjOdLJoPsgsWiUALhneu2Ha
	0czOEuROgUl2IcYTzoXGDsDMt0Rjjte0+4XQj+ygi5exSIYSLZBcupN1fxLLCCS1Srcf
	zBoPgTyp8tMNxZABNnFiOx7WFJVUg9DKhmsfqzSqxPJ8Qml7BFWUwple/Y5DupM6ZIgn
	MSBCr7ZfDrcQSZ+r3WQtTY6XoasXFOardxD5FZZIy7oYFeAog+wCtt1Q87si/mgZItDw
	N0LA==
X-Gm-Message-State: APjAAAXBasg8wP/V63F682AS1FhPUaUJG4QYqv5O8XLnNS/1DbOs2n14
	frJXACBd5alJLqF/coqct/j33A==
X-Google-Smtp-Source: APXvYqyKLcKZgeVS11lth1/OtmQv29bWX9OYnBzsmTA+4BxENjoSbHKZ1KIC04FnJUtY4DrKGExmdQ==
X-Received: by 2002:a17:902:347:: with SMTP id
	65mr21660592pld.232.1557793175127; 
	Mon, 13 May 2019 17:19:35 -0700 (PDT)
Received: from [192.168.1.11] (97-113-13-231.tukw.qwest.net. [97.113.13.231])
	by smtp.gmail.com with ESMTPSA id
	w12sm15385978pgp.51.2019.05.13.17.19.33
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 13 May 2019 17:19:34 -0700 (PDT)
To: Alistair Francis <Alistair.Francis@wdc.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
References: <ed7713d9b6c523d1c453ed7ac5de5501ef8cf405.1557792121.git.alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <28f47fb8-78e2-942a-a678-0d44553ddc55@linaro.org>
Date: Mon, 13 May 2019 17:19:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <ed7713d9b6c523d1c453ed7ac5de5501ef8cf405.1557792121.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: Re: [Qemu-devel] [PATCH v1 1/1] target/arm: Fix vector operation
 segfault
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
	"alistair23@gmail.com" <alistair23@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/13/19 5:08 PM, Alistair Francis wrote:
> We hit the second switch case as
> NEON_3R_VQADD and NEON_3R_VQSUB don't return from the function in the
> first switch case.

That's the bug, not here in this second switch.


r~

