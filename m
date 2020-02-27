Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B222C3F2C4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 21:45:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36A15246A1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 21:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jRcVLAfE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36A15246A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7QyQ-0008NS-5H
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 16:45:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41740)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j7Qxh-0007n6-Ek
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 16:44:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j7Qxg-0004R4-F9
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 16:44:53 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:45994)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j7Qxg-0004Qc-A7
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 16:44:52 -0500
Received: by mail-ot1-x343.google.com with SMTP id 59so627647otp.12
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 13:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tPwHyCJOQdlkW/9tqROjADY7bM36Bpf2aEcA0iVPo0s=;
 b=jRcVLAfE4YhBTeLuyfS1tJgxfuascJM8A5FgEclAv8rhvGVEeynycT7TgcX8+L4ziy
 Pabq4wCtavIYQXpKHLg2p9xz47uTyCMOcReiKBFNEWfS7v0WnWwCTATCpdG5kX84LLXv
 heQjpMEIus3hNMFATZD9upvNPaXCU+XIJifsE7KDy2H6TDCiiFZ6kyeKvAfR43ILcQCe
 KWBEGmaZkiD8vfcnr00a/Va6yWsw/HTFKz4qoxLU9ZhYHvWCQL8xTCuWKLovBecoP8w7
 ZeRlc/It/aWeC2gvmzPKZ8uix+hnybfWtdyDisfvn17b4ExbgAToIIV4CPlp6knHaXjq
 djcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tPwHyCJOQdlkW/9tqROjADY7bM36Bpf2aEcA0iVPo0s=;
 b=tXSX0bUmECRpwBNjyk07i/vYLIX4jRrv1ufISRqAapGv2gTiq39howWiAQUWHAI7rr
 ngEPXCdPWEj0QERl5O4wAWHoo/wZa523pZ8lXFPA+8ctWW+47NII8edQCfPg19ebmwDk
 Zqiz4T4DlsT1UvNNhKlXCfX1i3iQt4JUJ0JYkbP2Hc3rOK01a9ckDOYEabWM4IIC6ZEi
 03LBMbLIiIDkTjFxlbQwYAtMh3TErpfJiw7eq5tcbNw/eXfn+aj27vI4fo3Apq1tzb2h
 hsF6YFN6YYyO/t4Gtp4lxd7Mqnzas58733PhKVeSuSyisJd0La69K78+2NXdRN2biPtw
 BHYg==
X-Gm-Message-State: APjAAAU2zARKPv8T7K2xhL7RwEmERvrDjgeHLeT45I1Nk3oeFjBDjavH
 6vNlRM6ksYEF8lyTfUDXFyx8TrgXxHs9DmfM2R1kRg==
X-Google-Smtp-Source: APXvYqzAkwmTwGwaCHPs25JAPJXmB+MgnuHAH0QuEqfJt0RrEiny4W7aBQwQ/xrhjXhHLg+/pYhyggG2o7RRWuZsr7g=
X-Received: by 2002:a9d:68d9:: with SMTP id i25mr770594oto.135.1582839891414; 
 Thu, 27 Feb 2020 13:44:51 -0800 (PST)
MIME-Version: 1.0
References: <20200227115005.66349-1-root@stephanos.io>
 <20200227115005.66349-3-root@stephanos.io>
 <88ad7129-9654-088d-6569-066949973a86@redhat.com>
 <CAKmqyKMkTsgqSEWhrkCmbQ3LMNz1OgdeHE6zFaMsZdRjAFvdRA@mail.gmail.com>
In-Reply-To: <CAKmqyKMkTsgqSEWhrkCmbQ3LMNz1OgdeHE6zFaMsZdRjAFvdRA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Feb 2020 21:44:40 +0000
Message-ID: <CAFEAcA_i9Qjvq1Bp8Me2JnUwL5bwEaUTi+8uvusNMcoc7OwfkQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] hw/arm/armv7m: Downgrade CPU reset handler priority
To: Alistair Francis <alistair23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: Stephanos Ioannidis <root@stephanos.io>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 27 Feb 2020 at 21:37, Alistair Francis <alistair23@gmail.com> wrote:
> I do hit this problem, Peter described a workaround in the previous
> version of this patch, that is to link at address 0 instead of the
> alias address.

Do you happen to have a simple test case you can send me
that demonstrates the bug? That will save me a bit of
messing around when I come to try to fix it...

thanks
-- PMM

