Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F66C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 16:08:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E98A221582
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 16:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="thbUYW6z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E98A221582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihFP7-00070O-43
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 11:08:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40719)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ihFOX-0006YO-Lh
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 11:08:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ihFOW-0000vk-M2
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 11:08:21 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:43188)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ihFOW-0000pw-I2
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 11:08:20 -0500
Received: by mail-ot1-x344.google.com with SMTP id p8so14279167oth.10
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 08:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=quqEcBZm6ZgH7nO7zteu3tS9msScNxiSze5l+g6Ih0s=;
 b=thbUYW6z3+m5Mb/+UCGDLkQYDETFM2hu7mD54159R36+SJxuQaHh+0pwixvIb859zn
 D4/GpaiHGtTb6SIsM6n1+B5g73qpAWKmP2lhhfZUqwWWXa+x9qrCZNJTnGJ3gL960Cr6
 GmnNcd1c8EDiOD762zh75QETdVp7Xw1D8QLFEAGWd5r9pzvlwgK5gDTrzp9llGDt+VmJ
 pGNpQwQg8r/ueAC1AVlHVY/vyNagTGFZIQUKbKP1hT5p34R45HRPsTc/KSoj2zkO/bEq
 kS5RM2buHs8HnqokwsnXmLLqBTE0yTLNsvospMcsEL27V/eNHYDPdb4mY1oubS2shpeC
 69Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=quqEcBZm6ZgH7nO7zteu3tS9msScNxiSze5l+g6Ih0s=;
 b=q/vkGOTNKVyWwBtgQzVAsmnKquhWWX422iCqoJUQgh6FzOUThSjVwLVtDnIBkWURcl
 8pjPmjF/UaOBssWkNs81L9AyzWZA4XoV8ef+j0600mO2+5mdFXoMRwlQi4bqBseI0tTs
 Ngxtbi1n2FvAWNwyScsluUz/P09HvdbFWRk0ccxLUpRV/fyWUz+MGhjx3m17vTCqdqKX
 IYFqISR/63J8UdiRO0l6YdZIIzs83R925IwdHpdRpP/Xyyl+j7rLuPD2lnrOu7+qN+CJ
 iAOt7JWJMPXARIO99CjYgHBdzmARX7o/dRkd4dynNESH4P88Uc8NL26SccT+9EIJTHU4
 8TkA==
X-Gm-Message-State: APjAAAWD3/q+CeyZlQ5J+0EAGACT0R7qvJZbvuWRHwHPHmrA8Fyk1myQ
 8dYya6Z6b5kSHpdf1Kw/mlOymVzR5R35Tn/Hsf8mUQ==
X-Google-Smtp-Source: APXvYqykcXklOc7RDYpkUhPnXIsOB5/MahrIm4DlsnpzKF726qk5Bs4tPFjqvu5WrXrB7xVIlzJPoS25S/Pb5hOAEPU=
X-Received: by 2002:a05:6830:13d3:: with SMTP id
 e19mr38870538otq.135.1576598899525; 
 Tue, 17 Dec 2019 08:08:19 -0800 (PST)
MIME-Version: 1.0
References: <20191209134552.27733-1-philmd@redhat.com>
 <CAFXwXrmi=AqO9djosRt7vEGm5XDmnBt7KhHn9AQAWbVPLp+QkA@mail.gmail.com>
In-Reply-To: <CAFXwXrmi=AqO9djosRt7vEGm5XDmnBt7KhHn9AQAWbVPLp+QkA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Dec 2019 16:08:08 +0000
Message-ID: <CAFEAcA9cOr03j9H1Z7YPyFKDViG5hS2mv4ATnWWWoWoKa9fb5Q@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Display helpful message when hflags mismatch
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 17 Dec 2019 at 16:02, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On Mon, 9 Dec 2019 at 03:46, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
> >
> > Instead of crashing in a confuse way, give some hint to the user
> > about why we aborted. He might report the issue without having
> > to use a debugger.
> >
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > ---
> >  target/arm/helper.c | 18 +++++++++++++++---
> >  1 file changed, 15 insertions(+), 3 deletions(-)
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>



Applied to target-arm.next, thanks.

-- PMM

