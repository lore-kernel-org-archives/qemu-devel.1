Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 367BDC43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 12:58:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2DAB21670
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 12:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WXOalJt5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2DAB21670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46897 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLSLT-0005DB-8g
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 08:58:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLSKi-0004v4-K3
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 08:58:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLSKe-0000Wn-PZ
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 08:58:04 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:37887)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLSKb-0000VW-Ev
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 08:57:58 -0400
Received: by mail-oi1-x242.google.com with SMTP id k6so11137332oic.4
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 05:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=VKzAMeXgP5xZnftALNyfMgZYzeU7n7X+Hiuu99OttYE=;
	b=WXOalJt5VGn+3thVI/ysFCyqIAi7DCp97ihsH+yhRMyp8ygrvuwAjbPPuEOvX8HtXB
	zfcBsJoYbqCs3/W3QZYY2eMBlvNEOuFu8bYx3JMDGGvbwGk05sL/P/vXX36nGjDEVJFZ
	w3/NESvtR1kn6i+m3sXaaNwzegPcik7bB0U+ZPr2kbGVNffr+fmZBDocolGW9McN4TpP
	V9XukvSL5hM0tbvWX84uKxUtc251nym5hMwaggMXhrPF2eeCOcpXybSJ2yNuISt7/YdA
	p66xBaawfbS4m0hcn0pRiSZ2cyYUody5kbC/KCA21oxep59hh4YRqsv7tt27fqeSjKdN
	ooGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=VKzAMeXgP5xZnftALNyfMgZYzeU7n7X+Hiuu99OttYE=;
	b=JqnjRpQfUHLtoQrRopbfVMG5cCZs+68ku3UUMzL3+IP0hS2Jz7J8UfiUa+kcSJyW0N
	xRdZiSsV61X4ChysqaiuW6xwj/bgcWDbGni/rlTpB348kSXP/7JfBxTfHLa5oaXJ68QJ
	2tkBDiS4zjfdcbm1QfOXKR1vdIqtrwRYEhl/6g9qih0PixNXU6no+zs3KMRsCPjK2gfl
	F9We6JYAtWvis0XUlpXtiSKyd4UtrasW4Xdxzpyc8yvP9omlSD5h7Mal2IKBLXOWi1T8
	ELeV3MV0AB8CF5M4aXMEP36UbOk8vdaEw5eyGzr70qKFxsF/hW3hojGDQhXsEb5zpAYf
	h5SQ==
X-Gm-Message-State: APjAAAVcsj0yVhJP5SnGrDUFG9JFzNsFYxLIEAkMo3EyHPhBfomFxEVs
	qUFnVlv6nXlnxdQChs1pevqvfLB43xHoLgskM9KoXg==
X-Google-Smtp-Source: APXvYqzblnnCgzU6RjOpa8Sh6v0C+JHsHe2RSEUHR/XVqFNieOKj+2Uexlv1CxeD4hSROjJDkffZ72aXMv0M9gJxpRk=
X-Received: by 2002:aca:ab12:: with SMTP id u18mr2650716oie.48.1556629074807; 
	Tue, 30 Apr 2019 05:57:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190223023957.18865-1-richard.henderson@linaro.org>
In-Reply-To: <20190223023957.18865-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Apr 2019 13:57:44 +0100
Message-ID:
 <CAFEAcA-30AuFEP6hYE-CEFTr7wosAi6Mugrp=FH-xWx4X-pNww@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] [PATCH+RFC 0/6] target/arm: Define cortex-a{73, 75,
 76}
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430125744.7MImJlKGaJdau0H6ZILeqH6pe5uM6zbznAJYQdhGtiw@z>

On Sat, 23 Feb 2019 at 02:40, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> There have been several announcements since the a72.
>
> The a75 and a76 entries are RFC because, while they boot with a 3.15
> kernel, they do not boot with a 5.0-rc7 kernel.  I'm really not sure
> where things have gone off the rails.  It'll take some more serious
> tracing to figure out what went wrong.
>
> I post this now mostly to get feedback on patch 5.  Should we do
> more to elide *all* of the aa32 system registers for that case?

We should make sure we don't expose non-existent sysregs to
EL0, but it's harmless to define aa32 PL1_RW sysregs in
an AArch64-only-for-EL1-and-up CPU -- the guest is just never
able to access them. (This is the inverse of the way we define
a lot of AArch64 sysregs for AArch32 CPUs).

The thing to watch out for here is that where we have AArch32 and
AArch64 aliases of each other, we tend to define one as the
"real thing" and the other as the alias, which matters for
migration. If we've used the AArch32 version as the "real thing"
then we can't just skip the definition or we'll drop the register
state from the migration stream entirely.

thanks
-- PMM

