Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B51C6C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 14:05:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EABE215EA
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 14:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H+6RLkCE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EABE215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58061 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL6uE-0001mB-Fu
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 10:05:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL6t6-0001Kj-Tg
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:04:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL6t4-0000LP-Ux
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:04:08 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:45128)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL6t4-0000Gd-PK
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:04:06 -0400
Received: by mail-ot1-x342.google.com with SMTP id e5so8656929otk.12
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 07:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=9gB9u4fZWMKhyWWcA+AdpSevho1krQKQMacS6plvRBw=;
	b=H+6RLkCEU0t7nYbJ/xWmK5t0/hycr2TQrHvR49a6fBqbWyP86qTQppQHwfYwkYurce
	kquerF7JAbBKSzwM7iCvmzsl+ijK2Qb00dt/pm8NahJ1/JkijNPASrHzwn+RC8P9HQja
	grk0dnPQ4gHYodn5YwAmCsumJUGflO9ivM5qAfR5H7KMcSvadIvY/Ug7szT6+pF+amnV
	J5V4zm9rqF3Dzur4/lxm84vptjqs4ASYijEsvRcnmgf/pe1GyxuFKJ4N80s7BUMGjVk9
	5iAZrrmEQaHccNXIZbiitCDIZzWrx/ZqpOcoLLtcYHGyaF8xVGKMwzNH1zIeM38x1jOh
	pT9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=9gB9u4fZWMKhyWWcA+AdpSevho1krQKQMacS6plvRBw=;
	b=mW5XZCjUPNopIpNqBe06jGJgHnrvmP75ZHXxd7UTYlXFxAufFIYW+4Eh7zNnhrFHy2
	8Nh148QmnwuN1M69RarZZut8httOWCeICWXFvTlpr311B3aQUgRr57mlPZEa9owJQTQW
	FDobhGhBHdrYtKSF+6SEBaNvicE267VM5mJmWUnDn5pYaW+7jufsdIbpx3qa3t+E+yJu
	mixJcZwpgJjUetJRlwkFORNwKN4/sVRNVh9BRipRTF4bEgm42N+0PL82uv0LufGK5eTD
	1+9Ew6VHWlnuhrfSQjEkTdpTeAAU+NVSp3FYZhiLf9hjj3iRjY/q6lR9ykb4xYvt5kr0
	LsYQ==
X-Gm-Message-State: APjAAAVhX7KMUAy7MOqxrIHCrBwdwTVP+ENzVqQgZ6uzFMsAd0ooxu7N
	GcyQhh2AIZJKZlzhAuHZCDVRd+DbqbjZ4w6bMkBNNA==
X-Google-Smtp-Source: APXvYqzlz7MbFfGip+7h1FKYjtPxbtkaxDBneoSrUYzIUGc7tila20cFPOE8yJ26eKNpEtPQAoLSaitF5uFN0eFnUI8=
X-Received: by 2002:a9d:404:: with SMTP id 4mr36473313otc.352.1556546642727;
	Mon, 29 Apr 2019 07:04:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190328230404.12909-1-richard.henderson@linaro.org>
	<20190328230404.12909-9-richard.henderson@linaro.org>
In-Reply-To: <20190328230404.12909-9-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 15:03:51 +0100
Message-ID:
 <CAFEAcA-ha4XBihDiYG131HVQSq8N7ZrhbsdbBAACdwYh4QA4uw@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PATCH for-4.1 v2 08/36] target/alpha: Use env_cpu,
 env_archcpu
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
Message-ID: <20190429140351.HxHlSebvleV28L1qLE9ehdHCHPpfE51WFaB08ztwhQw@z>

On Thu, 28 Mar 2019 at 23:23, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> With exactly one exception, most uses of alpha_env_get_cpu
> were failures to use the more proper, ENV_GET_CPU macro,
> now replaced by env_cpu.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/alpha/cpu.h          | 5 -----
>  linux-user/alpha/cpu_loop.c | 2 +-
>  target/alpha/helper.c       | 8 +++-----
>  target/alpha/sys_helper.c   | 8 ++++----
>  4 files changed, 8 insertions(+), 15 deletions(-)
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

