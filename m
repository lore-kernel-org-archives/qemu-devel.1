Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B63BAC2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 14:13:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 824992082F
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 14:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pj874XHu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 824992082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1slW-00064B-Mo
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 09:13:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44117)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j1sku-0005ba-TE
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 09:12:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j1skt-0005KO-ON
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 09:12:44 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:43379)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j1skt-0005Jw-JO
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 09:12:43 -0500
Received: by mail-oi1-x242.google.com with SMTP id p125so2090993oif.10
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 06:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=T1KoKCipT6DDlQUg2csp9tAFx3+odkejeYb/qy3UgZ8=;
 b=Pj874XHux3vIC/lRrB91glIieEg5z1qbAuh8I8lSJh27QUAwkRy18M5pOpxqCWAHtz
 DDd6tiDeImzZn+FgmVtLhpkJ/8mHwf+2001knrzzofSBA0NlUq8xknwJXvywtEGP+fSI
 9TcZe/AezihxdC0dqTDzSnCsAjfeXpP90gUtF/cw9JvK5avJlA7ZikS9mnfIaC0KWNQt
 8JYvXzAJJROMfwtgQgOWibB3NZABN8z7pKDd2xMh0OzLLnppQHxq9NwbUBbhWM9kUHgx
 6Rm5JejioCSv/Wb3AQF4zTrQ8Es7lh2sOBxa8tIs5/yutZ4gGWlA5JxUUCU84L/tQBbU
 Uc0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=T1KoKCipT6DDlQUg2csp9tAFx3+odkejeYb/qy3UgZ8=;
 b=QNdUwIPkTiIZLGt4my2TPNa12PvCRQkjFcFcWeYWqbgZVE3xaW+25GP1KMkz1lmN3+
 BvM3gAynPzHqV5q+8TzYUsHmvdv9/4TCIatZ5kmkuQ9BF8OGYuH3+c1QQkPv4iTHTK81
 Qnq0wUdKNFZPXpAsZgZ2EoHmmq6LLMT7ifnvdmbgagpOjQJ/tYpSFiZhJ7Q2SHjYvfNZ
 atOnUHaFkGmjsB3M3/mxdIXXaOLaiL44D8UK/xQ20v4SVbLDdSzExbG7r6KgMCyy6iLG
 T/BjsvfgMTuLov4MboNQIcD852SkZY9BqiCj5jvO1/WFVGtapZPr6Gsts+BRHSUgd90n
 ePCg==
X-Gm-Message-State: APjAAAVtmU/ET71Kus2kyeHvYz6hDmPM3xKsLB97EuVjfxJrvE8rMlOD
 AYkMQkkd/0KICqdmEgyl+F3qLjjgRR7UAguzRG3+9A==
X-Google-Smtp-Source: APXvYqyMvlIRIywKHKWU/kN8BCiP21YVDgaeTzqTjMyeQk5+NHOFfLhKtK2znYLvUGLjUyJ3+z7xXekVLbAP6I22AP0=
X-Received: by 2002:a05:6808:3b2:: with SMTP id
 n18mr6087412oie.146.1581516762619; 
 Wed, 12 Feb 2020 06:12:42 -0800 (PST)
MIME-Version: 1.0
References: <20200212125658.644558-1-laurent@vivier.eu>
 <20200212125658.644558-5-laurent@vivier.eu>
In-Reply-To: <20200212125658.644558-5-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 12 Feb 2020 14:12:31 +0000
Message-ID: <CAFEAcA95OA015GYqUNgtvKWRQ+SFHzU9W1LXNGOKfG3FcEshyQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] linux-user: fix use of SIGRTMIN
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: Marlies Ruck <marlies.ruck@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 Josh Kunz <jkz@google.com>, Taylor Simpson <tsimpson@quicinc.com>,
 Matus Kysel <mkysel@tachyum.com>,
 =?UTF-8?B?TWlsb8WhIFN0b2phbm92acSH?= <milos.stojanovic@rt-rk.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 12 Feb 2020 at 12:57, Laurent Vivier <laurent@vivier.eu> wrote:
>
> Some RT signals can be in use by glibc,
> it's why SIGRTMIN (34) is generally greater than __SIGRTMIN (32).
>
> So SIGRTMIN cannot be mapped to TARGET_SIGRTMIN.
>
> Instead of swapping only SIGRTMIN and SIGRTMAX, map all the
> range [TARGET_SIGRTMIN ... TARGET_SIGRTMAX - X] to
>       [__SIGRTMIN + X ... SIGRTMAX ]
> (SIGRTMIN is __SIGRTMIN + X).
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> Reviewed-by: Taylor Simson <tsimpson@quicinc.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

