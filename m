Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86B4C4BA0A
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 08:42:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A779924656
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 08:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aWkp1KTG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A779924656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6sH9-00067J-SD
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 03:42:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40867)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j6sGQ-0005cM-ML
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 03:41:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j6sGP-0000zT-Jg
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 03:41:54 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:35585)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j6sGP-0000xx-D7
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 03:41:53 -0500
Received: by mail-ot1-x341.google.com with SMTP id r16so2253483otd.2
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 00:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hs4Gx1l043Wyd/UJbyquAHW+qxU1Xk/fpYPCsw+P84A=;
 b=aWkp1KTGswB2Vp1Z0Lrwsg4y/Z02IysxAue2exAaKNU7dIUxCT4qt4WPVs6PtTGxnq
 ixlzone/dBZI6F2lEen7TyldV9Be7H4k1UvgYXKLuq/o1cIKLAxXJGdPO6wDF1oqWuOS
 kt/V6LzwC30VYYwMS91c4gFoyIwxJ+xLCP1gsGxQYbDFMRbDc8VDzJo8qMcqHBb93x12
 E+NuNacoW6hs6bP3J5vN6xZNjUo72rix1s8KXjDzCxovS252/qyjzV63Ihsb3rFXhdH1
 n7A7nr0sHUANOqGUWnHnP9L1lEJqD1zN7hecYYfAQz8wzT/pqNJ2AmXr6qD5hh/3Gj2T
 kDsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hs4Gx1l043Wyd/UJbyquAHW+qxU1Xk/fpYPCsw+P84A=;
 b=iXSwxYxnNdVMqIKIqZC5NIr5IYMkyo8pNenQBzIwsyi4qujtyAIXcHe+9oAggoOY5+
 DxM0YEgKVfd05sC7jdfWzx8i2FQRd1rO0BEiPSH37hQla8IMP+VcEMMazLk/u2MWHNXM
 jJ0Wr0JQj7WetULR2x4+0SOb9soM2h1OsHKc6335UOga6iAnQoSE5FHucMDYPoEmKh6a
 WsidIbBKhJraJQ6SO/1rNLp8DlAMjEnaXVR+7xFJrfZq+bufGEB43222P3nghjp8Hiyh
 phluS6Nul6CBrlUymTt4U6ILvfVHquqFUgHTwBs6tBKScjcf0W1XjkZqKRTvVfXd9ql1
 RToQ==
X-Gm-Message-State: APjAAAU/Pjn+MWVNxXg32CUtcOt79L0YW7YsBSjkq+JLOn5lXJfkhS7H
 rtia11X6Nh0nyfT1G80X1YO4o+0f8SebluSoPf5jYQ==
X-Google-Smtp-Source: APXvYqz86jbZuwrf7wR5WijazETW4RcuUqr+d7GFrOfWaN5C8B19ro7vnv8WJbzXBtmANyquzdKbRvlNW2HeH/lphb8=
X-Received: by 2002:a9d:68d9:: with SMTP id i25mr2097178oto.135.1582706512565; 
 Wed, 26 Feb 2020 00:41:52 -0800 (PST)
MIME-Version: 1.0
References: <CAPan3Wq-MVwcJQELP8n+g33CR7tsiGXQ698gA177nd2my9hWCw@mail.gmail.com>
In-Reply-To: <CAPan3Wq-MVwcJQELP8n+g33CR7tsiGXQ698gA177nd2my9hWCw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 26 Feb 2020 08:41:41 +0000
Message-ID: <CAFEAcA_azGqyzbxegpK8ch_bums6Wtd=U7cNxvM=bAJ-Ld2DDA@mail.gmail.com>
Subject: Re: Sudden slowdown of ARM emulation in master
To: Niek Linnenbank <nieklinnenbank@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 25 Feb 2020 at 23:08, Niek Linnenbank <nieklinnenbank@gmail.com> wrote:

> Just now I was working on some small fixes for the cubieboard machine and rebasing my Allwinner H3 branches.
> While doing some testing, I noticed that suddenly the machines were much slower than before.
> I only see this happening when I rebase to this commit:
>    ca6155c0f2bd39b4b4162533be401c98bd960820 ("Merge tag 'patchew/20200219160953.13771-1-imammedo@redhat.com' of https://github.com/patchew-project/qemu into HEAD")

Yeah, I noticed a slowdown yesterday as well, but haven't tracked it down
as yet. The first thing would be to do a git bisect to try to narrow
down what commit caused it.

thanks
-- PMM

