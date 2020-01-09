Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D380BC32771
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 06:53:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CB622067D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 06:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="E4f9veOp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CB622067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipRhG-0003cJ-Hv
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 01:53:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46956)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <deller@gmx.de>) id 1ipRcx-0002Io-Vc
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 01:49:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <deller@gmx.de>) id 1ipRcw-0003jd-R1
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 01:49:07 -0500
Received: from mout.gmx.net ([212.227.17.21]:59235)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <deller@gmx.de>) id 1ipRcw-0003dW-C9
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 01:49:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1578552524;
 bh=OFs0HTM/N1G1xJsdSztJ2eEE6PT0F2vzY7ZbR5uysc4=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=E4f9veOpzDIwmpVuJAuOuVJ+/JpXSeKWcXlwmJROYEhq65qU+fAkHEYl7A1NCD0C4
 y0FPI1f38A+SPm0fH2hae6Dviiq21e2Iis5SlG+ZVlobL6dWOHp0GowTolyJvET//J
 SmyXYPUqz21ha4L4FOWGdOPqzovxK9TxEW3Jlr5U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.133.168]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MbzyJ-1jPJrv1p3H-00dYP3; Thu, 09
 Jan 2020 07:48:44 +0100
Subject: Re: [PATCH v2 0/3] hw/hppa/machine: Restrict the total memory size to
 3GB
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Igor Mammedov <imammedo@redhat.com>, Sven Schnelle <svens@stackframe.org>,
 qemu-devel@nongnu.org
References: <20200109000525.24744-1-f4bug@amsat.org>
 <a2cbbd1b-d42c-2cad-2d59-678c44aca046@linaro.org>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
 c2TFWAS8k6RLkk41ZUU8ENX8+qZx/Q==
Message-ID: <8f67bbf2-d8ef-fff5-592f-dd4fe7e88589@gmx.de>
Date: Thu, 9 Jan 2020 07:48:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <a2cbbd1b-d42c-2cad-2d59-678c44aca046@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yaaKN6XZSG2ngELoycHXlU6LhNM0Do75ZTXhcPu/s45pYtFvAxc
 GDIxxggeziyo0gsnVSkDQ1eFJewPEFo5/jy6U3gFCp4OlSK0EXfZco0m0bLHtuQ8rM+MZIL
 nahYoxgTcjAtB9L51Xbhbz+UrAXFOOdDRpVa0QEWzg5yPBtb7/bynPm/F5nM0UzEAwcvBV/
 fCj4ma3+O8Jqnk1S3UB9g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DZaYY+hUtCI=:pVA/LarstU7ath0eMeB+q2
 iEqzuW6SPddRrVPUth2p0CefmthAsHFzg7T69jFh5x3R2lS/EOJNaKL7nY4T41fe+JS02bGd7
 wkneylDFyNEUIuy8E53P5nUvyLHYYj7u1We8WGCCtc8U1OQQk2s7DipVgx9gWtpxT5D+erDoi
 kjyWSP0Rn6/rR7wY+2+9A4kIHpsRrHwYZNrRbIFfqqCkq+hg6R6bi1UDcCUbDVXREmf1R9wvM
 RyIUHFUj+bblZb3RMzB3bZUjYOKjEe4LHFzFORMYTnGuRKPr+xNjmWQ7KfXk+EARevI54gKr3
 7uzH3NDyeOFBvXMhXbDj7UsxM7GZKD0/0et/ecqGtmRwlU9YmWjAhH6ZOnrhwGuQr81RW6DZU
 luXXnvt1+tPHtjvye90vaKRwx492VRA9OsFV6EodI5DvLrEEnLaDRTAanYF6aiyc3bEw34pD1
 pthV61palWDhMJYgHbpTjtSgQONIVsM5ubVhJSspJc/+BuwbzvUbTadhFR8bPwVRHNh0Rc7mI
 BvrTuB1dG8reuCSTlnDQzYlY6FfNt4DdWqUv6u55lTD/9vYbf3goRfc9BGGE7pp6XJj9JgfDj
 s+5H4NqYHB2uQjdc3gqDFDt+j7PrKwf+RD/a7VtAeW5NpSeLJS9PummDY1gJawwhDHoSX1NVg
 a70/pqqNfdv2ZJewv6FSk/RFA9GwpsHu9gb95s8HF6VNqg2qm+L4K6cRaE/vsDKsGL5KAk362
 nQL9u6/Dy0ET6gcOE/eTly6skg2RI+zn9xCWkNfhXVEL9VnwTXY/VVVUwABIgB5JcvfKp1cAA
 zRAxupvZd2Ktz2ysL1A6+cezQmA0TXzPEaQyRyajQB4gZ31dKYI9Gtg4W5K/fGL1Tgp7SX5XO
 5R0sfESjfXm3rrRSGMLydFpwGKcdZRBQ6aw/UHbILEdxnAHYLueLBo2e04HvjZ5ErPZ0ljOgJ
 O8xbRubvDjdsygbOewQm3JHBYgODVC2CyHq8v/usD6E1cHq0nw9/GsWUdXQ+p8Z9hs9QEXvPD
 FfMNq1JM7XuJGo0syamqWvZkfY05dK1jUCzHEVa/5wSF3CnycVGIg4UO++diOO7J9pnVccRKV
 fmMrhZKKvU9zS/rBUvSrkDmN35BJqJrIbhjsqbd3kC5f1tXQck1Uh8EFOYaQjErUoneCzVEoW
 aEtJa1SKRaJB4A8CkQxB+/CvSHykYlpI0U0xZeVz4I6ZqyJW2+o2/bpu69pCQSsh9ctUcnPOA
 T7UptFHSwsCFe/piF2G4GqlUxeAjShh9BvAGtdw==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.21
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09.01.20 03:20, Richard Henderson wrote:
> On 1/9/20 11:05 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>> Philippe Mathieu-Daud=C3=A9 (3):
>>   hw/hppa/machine: Correctly check the firmware is in PDC range
>>   hw/hppa/machine: Restrict the total memory size to 3GB
>>   hw/hppa/machine: Map the PDC memory region with higher priority
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Acked-by: Helge Deller <deller@gmx.de>

