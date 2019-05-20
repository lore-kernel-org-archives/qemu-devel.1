Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9802BC04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 11:43:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67B2920645
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 11:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OhVFDSdT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67B2920645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33881 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSgho-00040Q-EC
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 07:43:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hSggw-0003ej-FC
	for qemu-devel@nongnu.org; Mon, 20 May 2019 07:42:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hSggv-0000oQ-5H
	for qemu-devel@nongnu.org; Mon, 20 May 2019 07:42:54 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334]:39940)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hSggu-0000ny-S4
	for qemu-devel@nongnu.org; Mon, 20 May 2019 07:42:53 -0400
Received: by mail-ot1-x334.google.com with SMTP id u11so12636720otq.7
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 04:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=npd+JrQ6WpYAl7u7MexmkFymy5jmmjxMIZP2py62wkQ=;
	b=OhVFDSdTKVBojQ+hXY+z0bgmC+XOLBhQ8Ghr2+S3TfswJ3EjC2rg32XF0oWpOu3oWB
	xE3n+NgVaITfj6RgAS+5e0gJNog+GurniHDI8iD+sDQE0DH+lQyvwbdbqymhsvTCsDrP
	RCyhPhoASkE/mTMZmwwOeyRGFeuNepBOyQIYBn7LYL3Ih16dzwg1ZC8UMZCjlOUXFhSP
	ylkTt0IUzMO75yZoCwBVVQOcX1w1sFL40i8KOqNd05PJ/JcJIaTpPNmk2/5RJsFSiZE9
	mijVqU/Kn9MIvaKSPOzruXxgQO2NH6CUbIKb9FU8VxbqoYrBO3ic1mUdb7pmUwXj1mkv
	/I3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=npd+JrQ6WpYAl7u7MexmkFymy5jmmjxMIZP2py62wkQ=;
	b=tDtVamZRP8Wmoy4NAfpWNpAUe2e9ffYZVBmrtSPIg5WC9X/36Y7BvCgaTUdvPsJ7VT
	Gu5EOqj66uwkx0jEWMvoFH1Wgzyx9XrO+4DCfiv/Q90hiPx6B7si08VO5b7lcTNvQEPX
	c6v7/Scraek370dM9J6B8nbl9a5cy96IJKwl9qSuPcOtkHzx0o7Nv0D0mTpAuSM7q3Or
	5wsuFFJ/lr4/9YsD7tgKMwwxDvBi9H1JNKkVvflIjxW2gpbvaHjV7MFlNf/a2gdmsG8k
	apv/dC/H+/kWtUDdTNwpS1kCIXUeTuqenXM+Vj1ekvumiX2smFJIwnVBd1k6yFoeuqBz
	GKyA==
X-Gm-Message-State: APjAAAWsXFDQOeIv8dr2thEnfYq2ba6FvqQOp0/MnfrjXozMNcc5jMcf
	J1baHx/VpQREWTk+ULKoIYnHFt1F5YpC0Yklaf+e2Q==
X-Google-Smtp-Source: APXvYqyrH/OO/7jB79KLJw4PcvyS9HoJkiMErL7bk2MJhD9Ql60YkSsW/JdcGiaqZfXSirbpuvpXqwOHwNP5mFn7Clw=
X-Received: by 2002:a05:6830:149a:: with SMTP id
	s26mr15137342otq.221.1558352571513; 
	Mon, 20 May 2019 04:42:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190519143702.5587-1-richard.henderson@linaro.org>
In-Reply-To: <20190519143702.5587-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 May 2019 12:42:38 +0100
Message-ID: <CAFEAcA_A6uSH6KmBVyXPMFXkyf5fz7g0Y9o+Fan82W7tDGjx9g@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::334
Subject: Re: [Qemu-devel] [PULL 0/2] target/alpha: Fix user-only
 floating-point exceptions
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

On Sun, 19 May 2019 at 15:37, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The following changes since commit 1b46b4daa6fbf45eddcf77877379a0afac341df9:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/ui-20190517-pull-request' into staging (2019-05-17 17:25:19 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-axp-20190519
>
> for you to fetch changes up to 21ba856499f9c0ccdc05ed04432df059ae76b337:
>
>   target/alpha: Fix user-only floating-point exceptions (2019-05-19 07:30:03 -0700)
>
> ----------------------------------------------------------------
> Fix https://bugs.launchpad.net/bugs/1701835
>
> ----------------------------------------------------------------
> Richard Henderson (2):
>       target/alpha: Clean up alpha_cpu_dump_state
>       target/alpha: Fix user-only floating-point exceptions
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

