Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F925C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 13:35:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD8982075E
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 13:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qDTMSoYw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD8982075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40838 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMYLZ-0002Tg-0I
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 09:35:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMYKU-0001y5-BD
	for qemu-devel@nongnu.org; Fri, 03 May 2019 09:34:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMYKR-0002TJ-M8
	for qemu-devel@nongnu.org; Fri, 03 May 2019 09:34:21 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:42078)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hMYKP-0002Ji-0E
	for qemu-devel@nongnu.org; Fri, 03 May 2019 09:34:17 -0400
Received: by mail-ot1-x342.google.com with SMTP id f23so5269560otl.9
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 06:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=s0ASd/NXbuwDTPMnweznDAH4VIMGLMzVeOqmXZbhbKY=;
	b=qDTMSoYwdYGix1Y2WlMEWpCZRWoSBdXqLxMzhKr8zeSucadqazQe2uMe6VsLlKHqef
	VDMqlj+KF9oVB9/nKcd/IX2uRMlIH63isuTNfqQuBdOfcbf7o1bWAkXJRsQbWC7/Zdix
	VEqhoM8Q8F0RFgHiGFyepxFLBgtcVd45eewtSxPjWp4/ovdtfkRDgtQv+Rjbg7/uR5cU
	wO+MWh90AgGnb3/bJ/fUOS0q2pkKrkR4SXEgH/a95FeimzWKTwy3vqzn9FpYbeKoFLEw
	gJI+vaons3W9/cGb3ImiSj5TKAqnGt4MywqVxPeDjIBA3CtK6v3JIKeXxxMJastlZV1y
	5l+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=s0ASd/NXbuwDTPMnweznDAH4VIMGLMzVeOqmXZbhbKY=;
	b=rdFDtPWLKlojMrSDmwd9OFPP1SUefHWqrYCvfib3rGHH1eYStSB9oITZd6xEHdUrbf
	plHwJFBGHG3JxkZ7k4zRXYk5AyL+527Q/zaJWXwkn0IrHovYIzYLUSPWI6+HxH7vttiE
	fGwxrfwBfPWxxVumqU1x9nqhBA7r0NPnTtWg9dsucRMtP+bqy1JsDwki5lY8v3Zs3we5
	eTWuDpGfGBqcaBhdhO5HJEuXR9NSX32pyOrerURpHkQE/PokD0Q0xSfafHsTlbyVUsko
	/QzFO3InzqfDLGTV1jxeGTU7M9u8um1F1vQGumCRZ5Ykdbm/xu3AKyqyH6qT8CEQKsUe
	35pA==
X-Gm-Message-State: APjAAAVPmUcg5XZ44cQyhlAjTmkFZ4MQv45n0pHXg+VnJzMhXPa4us0K
	oCzzerlOAk/hc9OOdPhx5Gt8QU3lchtVhWhxO7T9aw==
X-Google-Smtp-Source: APXvYqxc7wBmyh0duihvNnP4Pb3DbE+w5kTagTvggVhmV97rv9t3KeOSFMPNtOglvjILeySyuq4FIw5Y841YoQ7/PoA=
X-Received: by 2002:a9d:404:: with SMTP id 4mr6426899otc.352.1556890453968;
	Fri, 03 May 2019 06:34:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190430044036.1144-1-joel@jms.id.au>
	<20190430044036.1144-2-joel@jms.id.au>
In-Reply-To: <20190430044036.1144-2-joel@jms.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 May 2019 14:34:02 +0100
Message-ID:
 <CAFEAcA-A-2RYAibPMRxKM6RPabxiOH-DLAzyRu8s5c3Vz+KFgQ@mail.gmail.com>
To: Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v3 1/2] hw: timer: Add ASPEED RTC device
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm <qemu-arm@nongnu.org>,
	=?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503133402.YvUYrAwoe7TdsCO5GQgg47vtgvwgvwqETmr9BNxyjME@z>

On Tue, 30 Apr 2019 at 05:40, Joel Stanley <joel@jms.id.au> wrote:
>
> The RTC is modeled to provide time and date functionality. It is
> initialised at zero to match the hardware.
>
> There is no modelling of the alarm functionality, which includes the IRQ
> line. As there is no guest code to exercise this function that is
> acceptable for now.
>
> Signed-off-by: Joel Stanley <joel@jms.id.au>


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

