Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F812C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 14:39:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB1E120673
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 14:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qJzVaYIb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB1E120673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58541 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL7Re-00074N-Ro
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 10:39:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL7Pb-000674-8T
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:37:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL7Pa-0004eH-Ei
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:37:43 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:44559)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL7Pa-0004e0-AZ
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:37:42 -0400
Received: by mail-oi1-x243.google.com with SMTP id t184so5947544oie.11
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 07:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=UZhJHD4wqW5eLU2yHntefOfW12UYfbHUsm1CM9U5/WI=;
	b=qJzVaYIbdRqFXrn42SNKvAhULlcBJHW3/Tz0rRuut4gdGc+201O0EJHMDaEgdIWko2
	tr2BMoek7YHJXEztobhhutUcHa/b5qg94tzydPNmx1eFkY7TIX/vwh0RvE6iG7SCu5jR
	Apy0cd/r9oRk6kovFYDsPSL8pyjLZdWFHC9h+kb8Ldkf0f7fX3A7ssHOkHmqGnzfVf1O
	0lFGd7Xc9D+GYDdtPdoSE0ctX3eA6RtwJsVK5zBUhuzFQsIKUyeGh46EAKSUiN3tjhzj
	ohfr5lXv592Gxx6W/+Q7ugZ5ROmyX6w5Aa4CtBAMj+Q2x6m8CbkYXhB0dKScl8SazQZz
	wIKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=UZhJHD4wqW5eLU2yHntefOfW12UYfbHUsm1CM9U5/WI=;
	b=j0qLzKggotRrkjYAJCAcWheUBc5uvSN6wZw4g5wRW5RJUbSr4kIo0SH3EgEMU91eWY
	1Yo03OfC4xR/48PFC46Pd7T9q/nWFnjCqw7iWHMvHTjWnoP2PdapEK2pwBCi8KKhUFa0
	liw2EKyfQNAMWZDcnPm1yOh2FOuo/hOYkvYkb7FwWOCafhSkajgLQorxTgjT8KASM1Al
	JRS0Tdpw0P2T1asCLJQrhj9fghomfkXFqCqblnsGwfZ4QWYTvdC6NwDJc0ZalaJjiHNh
	hSHN14ROXI+ao3tB/k71mn/JcSY0R0T/0aNVGjUDsYHq939rSkNDZpnGvnRViijmKG0i
	7qXA==
X-Gm-Message-State: APjAAAVVOEnZafFMiUKeRKTty9IcV9K/lngo4irc0i2B+u5ZBaPpmsZj
	SxCHp0wGd28VaA5OSRY4emEM9xgWYC6v8gYsZ7zcLQ==
X-Google-Smtp-Source: APXvYqwyL68ueW24xVywroyWgu5aUiFPqjDmblntkbxgZon6REpjH2che6ARRGIMQMx+3QlOt1Y4m2ukJVxL9QicVzE=
X-Received: by 2002:a05:6808:301:: with SMTP id
	i1mr13155564oie.163.1556548661744; 
	Mon, 29 Apr 2019 07:37:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190328230404.12909-1-richard.henderson@linaro.org>
	<20190328230404.12909-30-richard.henderson@linaro.org>
In-Reply-To: <20190328230404.12909-30-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 15:37:30 +0100
Message-ID:
 <CAFEAcA8uZNvVgysf-b5y5qpfMXcNm8dGWcsaDydHMB7_nyNj6A@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] [PATCH for-4.1 v2 29/36] cpu: Move ENV_OFFSET to
 exec/gen-icount.h
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
Message-ID: <20190429143730.UaTzYSWIYAX0oGg4ZAI-rkY-Eml6GwBBr40RNfYjwsY@z>

On Thu, 28 Mar 2019 at 23:32, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Now that we have ArchCPU, we can define this generically,
> in the one place that needs it.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

