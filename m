Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE58C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 09:22:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3464A20652
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 09:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TZHJTdFF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3464A20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42018 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLOxh-00086t-EY
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 05:22:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLOw0-0007An-S3
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 05:20:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLOvz-0008Cx-LR
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 05:20:20 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330]:36078)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLOvz-0008CJ-Ep
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 05:20:19 -0400
Received: by mail-ot1-x330.google.com with SMTP id b18so2270617otq.3
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 02:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=S0c7WuJi7MNEwBbI2zq2tQMQlITD2/gFA+K0BBa8Q6o=;
	b=TZHJTdFFzUmj9ucQYwXSNDVbPSx0Xyx0MwZzmBq7PnsrHw07KFYZH60u9axY/S4jzz
	UQxZUql8fPE1D8S+b67SAW/Lh5dxLpnEYg+kB98Oha1yGHP5oWI24M79Rr/GZNUGGQ4x
	YcvZslVUgkw2X+33PyDpgZhfqZapjmCcTFqsXESLdV4yDGUKXsHrwhfoFL6p6QVf03fR
	t/eg/fm0YKM7cF2GHGKZ33CY74pvJFMr5o2nyR6rvkwwKVbMk4CmkM7CEJc3CNyabHaK
	1Mk+9DsfVwtoqd8rYvYf4gWOUDPRQTaEwRnG+glvKkVG6uZ1Pd9m2HuQkkunMsqbHMEp
	C/EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=S0c7WuJi7MNEwBbI2zq2tQMQlITD2/gFA+K0BBa8Q6o=;
	b=RE3m79LWJkvotaQ2s5tdaJ8GVd2++ikOksFKP3fyQANZfb6ZmQnbxkgCEV8Q61XV98
	+e0q2hgOmD+3mSnW6HQLqX8Vg1KbwxA/2RcrlTqXt7HAt4Gxexb8I2LXCst7S95HD7ck
	ftpbe6vMGjIofuXkdT690fMvuGeJD42lSjhxSritmXlG/AXWzYG2TNTtM7MlHFpG8meG
	nrtje/kNn7l5tgaKeB8TsytfouKSliBazPi0l1qyhEi92+R/6zvla+hjKEuW/TNqI5lM
	7AJ0oekWwHjGSsTQqrwvD80GAObSkybWms8LlCK4foCtRj0xVbJrHSK7hyQSCdSlHezB
	ghgQ==
X-Gm-Message-State: APjAAAXiBJ3ZzZPhy1ZSk9w4aDSunKAyR6u0+uYWN3mE4ltn8q00t1Di
	2fcw8tCLc3UQhYORpkxFXgQV+zjT1k+CSQZtOFTkXg==
X-Google-Smtp-Source: APXvYqxFLWL99SlfzngvGFlCLLXI8yR01kbmn+jrqUWcsd6xHt6lBlhwdjUOjv+L2sH5PnRIuc2dtJBucjmXXGie4Gc=
X-Received: by 2002:a9d:6156:: with SMTP id c22mr11633834otk.363.1556616018514;
	Tue, 30 Apr 2019 02:20:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190429161046.10527-1-stefanha@gmail.com>
In-Reply-To: <20190429161046.10527-1-stefanha@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Apr 2019 10:20:07 +0100
Message-ID:
 <CAFEAcA9nP668u3zkBfR8sRyPXfdRLo7W9P+ezv5SMtn26=Dr-Q@mail.gmail.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::330
Subject: Re: [Qemu-devel] [PULL 0/1] Tracing patches
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430092007.dcOBzwMDBFTt4mGHCVnQQDYFXPrIraiA5u10q6Vq6IA@z>

On Mon, 29 Apr 2019 at 17:10, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>
> The following changes since commit e0fb2c3d89aa77057ac4aa073e01f4ca484449b0:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20190426' into staging (2019-04-28 11:43:10 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/stefanha/qemu.git tags/tracing-pull-request
>
> for you to fetch changes up to b1939fcd438b7140cb8f2685dee026bb112819d7:
>
>   trace: fix runstate tracing (2019-04-29 11:57:19 -0400)
>
> ----------------------------------------------------------------
> Pull request
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

