Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD63C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 11:28:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75D2B206B8
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 11:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4SJmg7O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75D2B206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs3pW-0006rr-UD
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 07:28:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50742)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hs3oz-0006TM-0E
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 07:28:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hs3oy-0005PU-4b
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 07:28:04 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229]:44834)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hs3ox-0005MX-Jl
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 07:28:03 -0400
Received: by mail-oi1-x229.google.com with SMTP id e189so44862307oib.11
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2019 04:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=a6pOQ8qA0diwxYk2oM30wEwaa1RAlH9AlKBO71Kzrz0=;
 b=F4SJmg7OjaDVtNkHkrrTVkhTVnXqT4VIqV+X1p+Jl30ciFh2WdMiowCBi7HkJ7pvrj
 F/DCvkc8malJ9hFi+5OUHMHnyZgYjErpl0uNTBY7X6/9VFRBO4F2hes4IpW5+0290slb
 0YuSooEy781IoaKtQUxF+FTE+UTtG5kiYHogmyOyKyRB25ByqWHxdrrAEZJoyIZryUAv
 Yiz8u4/Krt8jpuJKrWypfDYd2yharB+WtW+6EpOnEETCMbcWNVY5hB/hVSCcyNVR3VZH
 y8zKqifI3Qt6T1rUG9da3nWpGy3fKKaP1dFG/iBsCS/ppJJvM8TtmnXeE7L0qKg3HyDU
 AZjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=a6pOQ8qA0diwxYk2oM30wEwaa1RAlH9AlKBO71Kzrz0=;
 b=JJRCOEnhyVa3zegnZ7234bTPAn6M/ivRMhU11bi9wEr15TDEgkNda3+co5uoOVhBWP
 lXmHVNXe21tSBjNVPIo3BNKGN/m8tqBuiTlFvWbcIG/dhUhCNVJeRX+SWHJPX2+OWGLq
 8yMCV74b4UqeYKfZmN0uGsQ0w4KF7+bD/yFm9pGD7JWwIEnKrGx7TPU8a7eJvGqM4+81
 1+dGNSyHtGBQ7KAHPGY3v/WnOaKF3lVxbGi+eyYdJM0LUzvYWBzni56Uq5VcTx1qq97R
 711nzymsDtmyHr5YyBZTl5Ldd018cMedH8b3CQw/QXTCA6hkVcXMG3RsrtlozZQ8YbXJ
 pwRQ==
X-Gm-Message-State: APjAAAW2PxpYKFhcb63vcOMpVBGtAXN3KpCcabPK5FApKCE+MctSutlx
 Cbhl1cVVDPrm3c8bvsT233ubATnvDoSj19M9jk4=
X-Google-Smtp-Source: APXvYqxic+QFnJihY8tpXSjjZxM+qL2qUW2adgqAr4lBS0H8APuEAsm5yh3Hz/OKJt6unNN8e4sJZr0SkWvPs/VoUro=
X-Received: by 2002:a54:4619:: with SMTP id p25mr31033370oip.62.1564399682401; 
 Mon, 29 Jul 2019 04:28:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAL1e-=jiySpoypabXMkUsO=2pqgUrRxUhac=JM_V=2sn2LPhWA@mail.gmail.com>
 <054d5b29-6482-1d71-3866-057dd00cb021@redhat.com>
 <CAL1e-=ikCpJO1bn=AKYSLWb8QNYkf6062ojxn+UN3svXCEQvFA@mail.gmail.com>
 <ff1c3cea-0de0-1717-44f2-f57b2c30a359@redhat.com>
 <fe175e72-48f3-1a20-f9f0-34fbbadcf4a4@redhat.com>
 <516690e2-fe70-0ff5-cf5d-c087dffb2113@redhat.com>
In-Reply-To: <516690e2-fe70-0ff5-cf5d-c087dffb2113@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 29 Jul 2019 13:27:51 +0200
Message-ID: <CAL1e-=iTyUnRcJwPf6EgLZUzjO3Pgo9yLBZKE3QipWJoyt_xGA@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::229
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [QUESTION] SDL 1.2 support
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
Cc: Thomas Huth <thuth@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

>
>
>
> >
> > I already spent 2h on this today, I have to continue other tasks
> > meanwhile, I might continue later.
>
> I spent 1 more hour installing the CodeScape MIPS SDK,...


Philippe, thank you so much for your 3 hours!

Regards,
Aleksandar
