Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF18C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 13:49:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 638EB20652
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 13:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jKqKiKFB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 638EB20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57865 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL6eu-0003HR-DI
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 09:49:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL6be-0001IM-Vs
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 09:46:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL6be-0004DS-5u
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 09:46:06 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:37238)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL6be-0004D1-1b
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 09:46:06 -0400
Received: by mail-oi1-x243.google.com with SMTP id k6so8316457oic.4
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 06:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=6wTVpL+XmlLaM1Wd2Sj2ryiW9cRqs6MJOd+5+IrcM38=;
	b=jKqKiKFBQqZ7NoIcjtWY+gykII9kHulkVqZWlXpt09TQQzpZoQnfYcLUnZXglZWp9O
	ooVr/wj2Y9Xeep8M+2EITRoY9t1gtaZ52xMa0pJLBEbmukJivu0ws4R9oqnI1PIzIzYW
	gXCJKjnoy5LDcrfIeVfjhvjBM7PoapMY7xHDFf7nGbyibKSEDX9idI9EQQp/d4f968xN
	/3w790RAqHP9fXKrRHoD/pusw7E81TrT+IqE/j+suDiXkkJyaFC0z4FbxIihJBlepRTu
	hB3mUIIMgwe56d2GPIf9/YihiSKPjn6riEQYq1DyoUruktsDZucFivGr0NCARur/e2OR
	QKMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=6wTVpL+XmlLaM1Wd2Sj2ryiW9cRqs6MJOd+5+IrcM38=;
	b=Blzvsr2pUTTFw3+ARKPT6jYWLQbGEhSBEehGRJ+LD8opb56jGkuF0mGuD82AtdRu/4
	Y6gGjB+//b6NYTc70sU6fs1KwuFHIiY/uhApWeOGKyjLdavdKSp9qsahz7+WU54t7XPp
	5GmYLvefkz7HLH0XGBhtZdkGuBOt9svQJkH1/ilTJO0LsucPlUe6tJ8PrNPF842Uy7cH
	P0s+p7piOKJs3jInF+B1nmxu5b7EbW8AtsJmqqVcsO+aH8HBrjD1DvgKXagjb28v0Blr
	O1Hbd162pMH+H2zNpQxqmfTdRB2gRcUFVjgEpgNMTdWyATCEiyWG/lOHXssImXiZaFmj
	pkNA==
X-Gm-Message-State: APjAAAXkYXuzzs+ijC6mEPxEc8bD4idBuKrcliLW8YVygSx2TKsDoyS2
	x9RDYXIWb5LfLUQS9S2OZTywdoHsETpxTbw54yw3yk9LuG0=
X-Google-Smtp-Source: APXvYqzFdIhCDzPbQKWnDS1kjdoe+z3YBvVpM4Dt97PWWcBB+vz/9VFgnRhmh9l8X+pJaS2mzZOaBcr1tzJ/HlQvrhA=
X-Received: by 2002:a05:6808:301:: with SMTP id
	i1mr12984099oie.163.1556545565116; 
	Mon, 29 Apr 2019 06:46:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190328230404.12909-1-richard.henderson@linaro.org>
	<20190328230404.12909-7-richard.henderson@linaro.org>
In-Reply-To: <20190328230404.12909-7-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 14:45:53 +0100
Message-ID:
 <CAFEAcA8Hou2fB6VsP9fOe0EE9b6-R6_8AZWtLWFTKADQtKDJVQ@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] [PATCH for-4.1 v2 06/36] cpu: Replace ENV_GET_CPU
 with env_cpu
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
Message-ID: <20190429134553.9wJIp02mFyD2GA39T7pnUbWCuAK-OWxOUG_UuNu2S4A@z>

On Thu, 28 Mar 2019 at 23:41, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Now that we have both ArchCPU and CPUArchState, we can define
> this generically instead of via macro in each target's cpu.h.
>
> Acked-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

