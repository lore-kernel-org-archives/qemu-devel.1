Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F26C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 18:22:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A58492072D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 18:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XYO00QxE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A58492072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihHU9-0005rG-OD
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 13:22:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43252)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ihHTM-0004sI-F9
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 13:21:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ihHTL-00086X-9t
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 13:21:28 -0500
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236]:46957)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ihHTL-00080w-3h
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 13:21:27 -0500
Received: by mail-oi1-x236.google.com with SMTP id p67so1346746oib.13
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 10:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JrKCEf5Astrn0/xoTbZ590jsZld6Yg3kva5Wsd3CBT4=;
 b=XYO00QxEXjN0zBUSrHfiKhDJlWVcq/LtBn4siZqWGzoqPrHKFQ74TUMCLrEmTxKgTy
 Z7NsqHljhxwVcN7x+yHFrKG3pHyCrvqlEgTGKZYcgBu9/OnQo33oiIbM/QoVdXoCpkqc
 /2ldh0MAYxo3JdR7IY4CzucrGFTi264+LOPS3jgvnL4xbjwTNgsCFAtKz2ghzqb/XYfN
 vzdYHWT65d1FFQIicg9vW5tAxmps0+ULunIZXWW9ba+ulGRSUkeGC1z99M7pLkKs22gE
 qTn1lxS78Ys6lXsguOwtZv+9X2FrTkclGN/k61XQqoP9pOhSe05YfyjhwE7rGBEDuz7A
 2EOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JrKCEf5Astrn0/xoTbZ590jsZld6Yg3kva5Wsd3CBT4=;
 b=TFnO3zIllgWZfarQGWV4VxKRD9lc8EBe361kl71ZldUChwZ6joYi1J6hrzLTpFaxkB
 PZxeb9FshHBtX+ElHmbRjWxiZVtcZiPrXVLOMD4AD8DarC8TjU9bpho+i36zIhqX1/Ym
 qnsEgGJ4+k3ze5iltl+4OutoBQHCum4azijINbKRBwqFv74wPEpBQXbBP2k8RDcQZnvG
 M3gAfGSWuGVVS580O0+b4ksX23YWQmSivWDwhoQPAL5UDte2i9iMko2wrsIM4mnGxCHs
 QIfjLWcvcj67OKZ3iJnnD99pls16KUTJLWWUA9aBTMmjprBFsLPcMBCzV8GQ4m4UvUD/
 rY2w==
X-Gm-Message-State: APjAAAUdrxFBaVprvuO1WmA1KB0TdK6wAZzPLpFe71jJlpzKmoi6Vf0b
 LnaYPIAfgtd9/bYzUguKyPrrUvLc2YhbUVP5aUNN7A==
X-Google-Smtp-Source: APXvYqyIjhkBdVdsw2ngzKrG0sh74uc3DZtMuwRZkNtBNyAXwJ+ce7UHTKNNByoqqa6++6xwbpwQrFqFOe+kQEpQYQE=
X-Received: by 2002:aca:edd5:: with SMTP id l204mr2427253oih.98.1576606886324; 
 Tue, 17 Dec 2019 10:21:26 -0800 (PST)
MIME-Version: 1.0
References: <BYAPR02MB48863165DEE32E5C563E93F4DE650@BYAPR02MB4886.namprd02.prod.outlook.com>
 <CAL1e-=jvmJNiZR4iLDL-97qm=v+2s0cwn5YTzJQ=JZ_gwOe4tQ@mail.gmail.com>
 <BYAPR02MB4886C8D82898F1E406C124F8DE7E0@BYAPR02MB4886.namprd02.prod.outlook.com>
 <BYAPR02MB48865884056A88B660B620FCDE770@BYAPR02MB4886.namprd02.prod.outlook.com>
 <87d0dw83uz.fsf@linaro.org>
 <BYAPR02MB48866E2D82D9C76ABBECA842DE760@BYAPR02MB4886.namprd02.prod.outlook.com>
 <ffe58977-f251-df34-4bd0-62e32f78cc1a@linaro.org>
 <SN6PR02MB48953397AA553FA7456E7CFCDE700@SN6PR02MB4895.namprd02.prod.outlook.com>
 <BYAPR02MB488640DD7CC887E5FCC0F167DE500@BYAPR02MB4886.namprd02.prod.outlook.com>
In-Reply-To: <BYAPR02MB488640DD7CC887E5FCC0F167DE500@BYAPR02MB4886.namprd02.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Dec 2019 18:21:15 +0000
Message-ID: <CAFEAcA-TpZfqbWjGX-tD0Osapt_K4yuTBg6+B=ZxU4MuVr7omg@mail.gmail.com>
Subject: Re: QEMU for Qualcomm Hexagon - KVM Forum talk and code available
To: Taylor Simpson <tsimpson@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::236
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
Cc: Alessandro Di Federico <ale@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Niccol=C3=B2_Izzo?= <izzoniccolo@gmail.com>,
 "nizzo@rev.ng" <nizzo@rev.ng>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 17 Dec 2019 at 18:16, Taylor Simpson <tsimpson@quicinc.com> wrote:
> Question 1:
> I see this error from checkpatch.pl
> ERROR: Macros with complex values should be enclosed in parenthesis
> However, there are times when the code will not compile with parenthesis.  For example, we have a file that defined all the instruction attributes.  Each line has
> DEF_ATTRIB(LOAD, "Loads from memory", "", "")
> So, we create an enum of all the possible attributes as follows
> enum {
> #define DEF_ATTRIB(NAME, ...) A_##NAME,
> #include "attribs_def.h"
> #undef DEF_ATTRIB
> };

checkpatch is often right, but also often wrong,
especially for C macros which are in the general case
impossible to parse. If the error makes no sense, you can
ignore it.

> Question 2:
> What is the best source of guidance on breaking down support for a new target into a patch series?

Look at how previous ports did it. Also I thought we'd
had a subthread on how best to split things up, but maybe I'm
misremembering.

>  I see avr being reviewed currently.  I have mostly new files: 12 in linux-user/hexagon, and ~50 in target/hexagon.  I also need to add test cases and a container for the toolchain.  Is it OK to break things down mostly at file boundaries?

No, file boundaries are generally a bad choice of breakdown.
You want to split at conceptual boundaries, ie one chunk
of functionality that can be comprehended in one go without
having to refer forward to other patches.

thanks
-- PMM

