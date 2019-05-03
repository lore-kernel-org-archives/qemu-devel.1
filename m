Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A04BDC43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 10:36:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E9D9206C3
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 10:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yuZwU0wq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E9D9206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37867 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMVYH-0004rO-HX
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 06:36:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMVX1-0004El-8D
	for qemu-devel@nongnu.org; Fri, 03 May 2019 06:35:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMVX0-0001RG-88
	for qemu-devel@nongnu.org; Fri, 03 May 2019 06:35:07 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:44003)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hMVX0-0001Oa-0P
	for qemu-devel@nongnu.org; Fri, 03 May 2019 06:35:06 -0400
Received: by mail-oi1-x243.google.com with SMTP id j9so3292292oie.10
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 03:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=W8p7sct4LMp93fn1JCApAKZ7MtzmC3ws7T9s70vdvAU=;
	b=yuZwU0wq+d61MYI/ZI9VHvOIEtQq2b/R8mGUJG7RhFzuGc3JALGZQBeuq8D/YrT8q3
	C1LdwSgXkudtkz7GR/kP9uAP3q4g5KngDNa5J3apcDATFSkZ8zd90r4ZPzXu6AyK/GMs
	3TeOMKuf5q5wdiH7IN//4DZFQWnsJMlTL0po420JZ4ETa31Jajo0/Wmai1F8eVY9YQ7G
	TJXJGD0sf9ZazOwvjGpX+zg6ff0oeki7v0/Ql7tSBuoRL1zJuX4ry/kV9Y7qEMdGCL1B
	bU2Mk9J9WvaueDqFMc4hhU4Cb1lZ32+Sw4y6s41ZU0MClS9a0iOumLx8dxaOdwNlt5Ty
	95LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=W8p7sct4LMp93fn1JCApAKZ7MtzmC3ws7T9s70vdvAU=;
	b=kLJcotYz1Ym4j/n5W3GrA5TgaKIczuuKeTUl9EFRNSr+KGsz2ICb6kJ1q5aRUS8GAY
	QIFCRN+F6e90XqZ2PItPd3LshQzmG+lWWlD353UnOIMtHxRwYPJfJhefX+PYNGwVs0JI
	KD3dG0cpmPObM4q6EYY7mCvezlbAaYwvIAIPKLTqY5lSkh6CO9FK1OFyhVr3NXOptQa6
	snx7xDuqRV1SFgiUW9zR9uhQjK65ZCcCugL3/jmFmZRy3r2lfnTgscU2D0MECVlS/IvK
	l5P3Uzmsq5gzGm7kJ9BXVrQd8bNE6gHeZa6HHiwxZZ3sVqiyRffn7owrmgP4eKPdJgMu
	i9YA==
X-Gm-Message-State: APjAAAU8jVmyV+3UPgb7Ast4X1An+0iwjUaJuG3i9Des/P2XywCpZ/Uk
	QivhYeCM1ii2rULrJZs6dbWaLBVHjhZvuX2v3w9oPA==
X-Google-Smtp-Source: APXvYqzYYrpW7go7sKkA4LMn1/WCp5cBnoQRealULYrw/pLw+8WDCq/jUELfV2NnAXVrR0PVfQCZsAe8uzy0VxIbEHI=
X-Received: by 2002:aca:4b04:: with SMTP id y4mr5493572oia.170.1556879704999; 
	Fri, 03 May 2019 03:35:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190502185835.15185-1-laurent@vivier.eu>
In-Reply-To: <20190502185835.15185-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 May 2019 11:34:53 +0100
Message-ID:
 <CAFEAcA9-hAU5dxUmSWtbvrPEXE-nCP1uLvLbOby-_EXZ27o+8g@mail.gmail.com>
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] [PULL 00/13] Trivial branch patches
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Viktor Prutyanov <viktor.prutyanov@phystech.edu>,
	QEMU Trivial <qemu-trivial@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>,
	Jason Wang <jasowang@redhat.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Fabien Chouteau <chouteau@adacore.com>,
	Michael Roth <mdroth@linux.vnet.ibm.com>,
	Gerd Hoffmann <kraxel@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
	=?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
	Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503103453.jf_o3GpPorRBH7W1sE8YzgsLyF1PCW4Xmjl3EYgyL-A@z>

On Thu, 2 May 2019 at 19:58, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit 8482ff2eb3bb95020eb2f370a9b3ea26511e41df:
>
>   Merge remote-tracking branch 'remotes/jnsnow/tags/bitmaps-pull-request' into staging (2019-05-02 12:04:51 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/trivial-branch-pull-request
>
> for you to fetch changes up to f7c03a68b814254df414977ff299468fbf0fa1c0:
>
>   sockets: avoid string truncation warnings when copying UNIX path (2019-05-02 20:50:47 +0200)
>
> ----------------------------------------------------------------
> Pull request trivial branch 2019-05-02
>
> ----------------------------------------------------------------

Markus's "Clean up includes" patch breaks 'make check' on
big-endian hosts:
cd /home/pm215/qemu/build/all/tests/fp && ./fp-test -s -l 1 -r all  i32_to_f16 i
64_to_f16 i32_to_f32 i64_to_f32 i32_to_f64 i64_to_f64 i32_to_f128 i64_to_f128 >
 int-to-float.out 2>&1 || (cat  int-to-float.out && exit 1;)
>> Testing i32_to_f16, rounding near_even
^M372 tests total.
^M372 tests performed.
In 372 tests, no errors found in i32_to_f16, rounding near_even.
>> Testing i32_to_f16, rounding minMag
[...]
^MErrors found in i32_to_f128:
1006FFFF  => +0000.000000000000401B006FFFF00000 .....
        expected +401B.006FFFF000000000000000000000 .....
^M0001DDEB  => +0000.000000000000400FDDEB00000000 .....
        expected +400F.DDEB000000000000000000000000 .....
^MFFF6FFFC  => +0000.000000000000C012200080000000 .....
        expected -4012.2000800000000000000000000000 .....
^MFFFFFFF8  => +0000.000000000000C002000000000000 .....
        expected -4002.0000000000000000000000000000 .....
[etc]

(I had to bounce Markus' own pullreq from a week or
so back because it had this patch in too and also failed
for this reason.)

thanks
-- PMM

