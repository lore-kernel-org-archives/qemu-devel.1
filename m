Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C9FC43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 11:59:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D72521670
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 11:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zNGDjncK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D72521670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45080 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLRQE-0003Sr-8R
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 07:59:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLROQ-0002EI-HB
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 07:57:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLRIK-0008Mt-8x
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 07:51:32 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:42540)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLRIJ-0008M6-Tn
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 07:51:32 -0400
Received: by mail-oi1-x244.google.com with SMTP id k9so7942482oig.9
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 04:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=Lub6QN6RvBJem+jkF1tV7MSZouTG5xWnZ6dZpewcOeg=;
	b=zNGDjncKX2ppbf3t83md5fDt98Wri1IBarBFUYHaMVtOGeSCBrOmt0wnFZvziR2Icp
	R6+kyw24TdzY3iQy5V5i9wucLPbCZkyBLPUug9LWANqZvaZuqXAgA7JUauwIR1KdPZWG
	gGEdDM0CnVuVf+l3SQRf8w7+HEJUO23WnzrDPcLSYauNzgufDMbbmPzF8jptG1sEwYyd
	aM2c3cJO5agcaZWsMR7+O4S9X4HpTlhErNZIqo75EzHFuyM8dZuX8gKzwZYhJ/3uJ/qS
	vqr58v7lf4vQqlziGdPrixdogATq8ZL4GEDFu1/xGGu3+HFftRql7baocFVlCk7xw2kZ
	BPTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=Lub6QN6RvBJem+jkF1tV7MSZouTG5xWnZ6dZpewcOeg=;
	b=XiXd6zxKkTE9R4jM6yHEl0kxubO5TkJPu/1IQRvb1i0xN9ah9WkDfqYKM0X1pY1JnC
	Hk/UoTtfXKuzdWqraP1o7h39lefV4xiNkymBz8a7VwH9INvJpNzbcWdkQ83E2wmEeME/
	8OTl5l2BL7f1pbNMgdGDhNMOGzR4fg0a8xgw4lrO+6rTpBXMTVV26gIorXDW3Fd56EUB
	Xseb91fHTbZRKu5T8jSkpzNo2ngsxItUBRdUF8Yk/NsBU2BbZ7+SfWUnoF/MNl4F2P8G
	cQDeWownPrAoOCfjBioLO4NoDhoifN1OaDwqhaWGJf4/7iqD3+ByEDMfYe0mfeTliKmV
	maCg==
X-Gm-Message-State: APjAAAXJ5XdpMWpFgyiqBM4KZY9ooiJOwjV+KJiwbYqxiUpE0cVN5qvT
	9d027mgZQ6U0VsBCybJ4lAZ7a+Nln0HdoGE4dNpdjg==
X-Google-Smtp-Source: APXvYqya7uZcsev8/Tdc2yo8Nd3a2kPNnHJiLyc6rc3atgrB8O3/sWLPKPf3FlKEKTtKOOflmykqth2K1+CjCwOpSYM=
X-Received: by 2002:aca:e054:: with SMTP id x81mr2658119oig.146.1556625090879; 
	Tue, 30 Apr 2019 04:51:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190403034358.21999-1-richard.henderson@linaro.org>
	<20190403034358.21999-7-richard.henderson@linaro.org>
In-Reply-To: <20190403034358.21999-7-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Apr 2019 12:51:20 +0100
Message-ID:
 <CAFEAcA-Qq=mif4eOyH7V-fy4KNYxiuKpyK95mDnmzvHPfv5P1Q@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::244
Subject: Re: [Qemu-devel] [PATCH 06/26] target/hppa: Convert to
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430115120.19dDTDwUD1TsJizQy57uf0_a7HenQs_Ti388VnBfsKo@z>

On Wed, 3 Apr 2019 at 04:49, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/hppa/cpu.h        |  8 ++++----
>  target/hppa/cpu.c        |  5 ++---
>  target/hppa/mem_helper.c | 22 +++++++++++++++++-----
>  3 files changed, 23 insertions(+), 12 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

