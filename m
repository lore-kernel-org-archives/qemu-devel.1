Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D2DAC04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 16:20:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E562C2085A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 16:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TkzBc7fD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E562C2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50839 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQaAd-0002Ku-6K
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 12:20:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hQa10-0002r6-F6
	for qemu-devel@nongnu.org; Tue, 14 May 2019 12:10:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hQa0z-0000ty-Jm
	for qemu-devel@nongnu.org; Tue, 14 May 2019 12:10:54 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:39857)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hQa0y-0000r9-4N; Tue, 14 May 2019 12:10:52 -0400
Received: by mail-lj1-x242.google.com with SMTP id a10so6880296ljf.6;
	Tue, 14 May 2019 09:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=ZpmdCK+ZGwEPJRy3Nfak62DAqT/DdkPrXc34xgi3TxU=;
	b=TkzBc7fDo6TZGdbmm5Yqzir6G13RxLdvzfGPBNOoe9WgHrE8JCDX6aHjUaYEVw86X+
	2c15fiDqHp8uAfU5s0IlfNc0a9cqHrLxgnXEUkoTDHETUjnU2kXQhUHHGz2TR8yKTg37
	48vWLgHPTqxvfjCXWNdTPPE2oPNWI7rxlvsTWSd+OYFEps7SDTIgsgd9Jir7fSs1jLpV
	qjOmmp1K0wF1vxMZjXVXjmEagMOuYdy7Ah4e7MHpRtFK2D95+ak9z0B9hLlk4zkbxRrQ
	c99fZOrShjddDPVXlmkj8KSTmZrlYSUDPttGxvDVZ2xemN9jqPzQ++ZTksejPCM8T1Fa
	ur3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=ZpmdCK+ZGwEPJRy3Nfak62DAqT/DdkPrXc34xgi3TxU=;
	b=UEs5qTbtj0Frm1vJJ1h1clRLFTZvhE7AfJIXu4hlXn9uH6roV3dQPZaVlGZDmBAuHa
	w10E0S0CxLqILXrsZRNjX43kd9zTj0IT465bmmqWbJVv8j6Wa3f5ZfPGv7JQZqBiowuf
	lpbZ6OKjN1Dxj2FDxQWckZyCDTvX+GphlVlFeDGoZyZGskUNTEr2C9ttF7lclgmy9L0X
	QAppGA2Q9ozYeAFzi1oDraQHCNgjZVrPy9wJoN1vt4irPPmkcSO4BHV5CNn/Bqrq3wdl
	bXtJavCl2D8lNm/Yf1FnPAAVOSJOAeC1SnN4rxRUq++dTlF+jgkhPkgvSptxfcQcfUW/
	NmPg==
X-Gm-Message-State: APjAAAXtUvjXF8rsSquxgWT7+H4bgkgzx97+o7BkZyQNjP7u+rkviiqR
	UvO16ihOHNJ76PPf4mOatpDCgxcLRH34wvSKjOw=
X-Google-Smtp-Source: APXvYqx73SEdAbxr0FGeaobrMexAhaJyFlcN0leHOQ/G3DF0R9JHqk/jGsWp/g4O0ecG7EjNfyaoqd6Z60kjfUj3pqA=
X-Received: by 2002:a2e:8709:: with SMTP id m9mr17508557lji.140.1557850248896; 
	Tue, 14 May 2019 09:10:48 -0700 (PDT)
MIME-Version: 1.0
References: <ed7713d9b6c523d1c453ed7ac5de5501ef8cf405.1557792121.git.alistair.francis@wdc.com>
	<28f47fb8-78e2-942a-a678-0d44553ddc55@linaro.org>
In-Reply-To: <28f47fb8-78e2-942a-a678-0d44553ddc55@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 14 May 2019 09:08:34 -0700
Message-ID: <CAKmqyKNkWuuyVUMOyM0zfDsWVTiMotzuoxs8nOYJaqKegPbnFQ@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::242
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
	"qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
	Alistair Francis <Alistair.Francis@wdc.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 13, 2019 at 5:19 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 5/13/19 5:08 PM, Alistair Francis wrote:
> > We hit the second switch case as
> > NEON_3R_VQADD and NEON_3R_VQSUB don't return from the function in the
> > first switch case.
>
> That's the bug, not here in this second switch.

Ah ok, I couldn't tell if it was there or not, I'll send a v2.

Alistair

>
>
> r~

