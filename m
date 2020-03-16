Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C958C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 14:55:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00EF020674
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 14:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cwruJUwg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00EF020674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDr9W-0000rY-Ee
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 10:55:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47499)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jDpHW-00074G-SO
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:55:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jDpHU-0000w2-DP
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:55:46 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:43651)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jDpHU-0000iN-2e
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:55:44 -0400
Received: by mail-oi1-x243.google.com with SMTP id p125so17604778oif.10
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 05:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=T57J5C1FH/BaOyqAd+oZU73r1nP66CTxyDcT2hHrSiw=;
 b=cwruJUwgWlhOcMJ8zHhpbR0yj6mUjim1YqzPA89aWyajm/UrAawUGQJTmSjPh35NAy
 lhA9VgDEbAO5KDVp5DyzRHju54uMIs3Qgon3/hHG1vICnK0vjj1S9KrPBLmvgZjVp5Ao
 2Em3Ftwaj3wM/BtZ2GcT4XblG9pWPRCyPd3hCHKnzOkAm8/QrJdbIbeX7MAgoONaCJ/m
 4/oR3NfS+ElwUwrM66Gc1PQgZtfGqkitnUoXPs52u6BaNR4mFL94157ApU3mJfNnzXII
 TA7HMtRrq4DhjuiWhG3joLyugSjGpcKQ6EV4xn8nnK6xXEF8hBzQhJUVpIAcH9QcZAUy
 5QIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=T57J5C1FH/BaOyqAd+oZU73r1nP66CTxyDcT2hHrSiw=;
 b=F5PaotIwglT2h6evAVmQBB/hgLX1n0Dk+eTn0tbPxcMBhnUYlF9M3I33MBXN8q8WAO
 Oo1hhs3PTWqv0rLhYSfB97d8L7S8lQvTKlSJKXypW9PHqBcYlmjdTlQ7qUzgOaKHAZOG
 FRXzgLeJOI5x+48ya2c4SSxtGfvsC6YXOI6PWnKNi6EHt0KtXPcEhgSL2bxb9gjqkz9z
 Pql+JAkr6s3eHI5pc7ExzVrm1VInOOTPZEIlYT6Qi2j5jrrhtinCzWPY7wIe632+egpN
 qRPeI+PoGlQyy0IRUe5Ouj//rB+LRcZ4Xaw1J6KMyKa9OoFCgn958amEXgyfNlXQp+aj
 i0Mw==
X-Gm-Message-State: ANhLgQ0NjO1hSXj6ESh6JGpeHm/y6MQGhlBLbcp4Ecb20RoVuxqo3Q4g
 MOjFg4TgaaauxGBNKr+A4YjwF65pmNe/FfsPnNKevw==
X-Google-Smtp-Source: ADFU+vtcV0tW8F51R9Z7ct48JquHvseRplTSoVrHGvuZwQaZNKWuBk6jrVQMukhO4xmlaAR71IrzIoRB6XD+Qqni2vM=
X-Received: by 2002:aca:190f:: with SMTP id l15mr6455757oii.48.1584363342975; 
 Mon, 16 Mar 2020 05:55:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200316114050.3167-1-jiangyifei@huawei.com>
 <20200316114050.3167-3-jiangyifei@huawei.com>
In-Reply-To: <20200316114050.3167-3-jiangyifei@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Mar 2020 12:55:31 +0000
Message-ID: <CAFEAcA_JC70gt140h6r9o1DrjaBXAatJCdjc+wYKL3ZPiZAZEg@mail.gmail.com>
Subject: Re: [PATCH 2/2] accel/tcg: avoid integer overflow
To: Yifei Jiang <jiangyifei@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>, limingwang@huawei.com,
 victor.zhangxiaofeng@huawei.com, QEMU Developers <qemu-devel@nongnu.org>,
 Euler Robot <euler.robot@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 dengkai1@huawei.com, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 16 Mar 2020 at 12:14, Yifei Jiang <jiangyifei@huawei.com> wrote:
>
> This fixes coverity issues 75235919, etc.,
>     1524    /* Handle CPU specific unaligned behaviour */
> CID 75235919: (OVERFLOW_BEFORE_WIDEN)
>     1525. overflow_before_widen: Potentially overflowing expression "1 << a_bits" with type "int" (32 bits, signed) is evaluated using 32-bit arithmetic, and then used in a context that expects an expression of type "target_ulong" (64 bits, unsigned).
>     1525    if (addr & ((1 << a_bits) - 1)) {

This is a Coverity false positive. The value of a_bits in
these cases can never be big enough for 1 << a_bits
to overflow, because it indicates an alignment requirement
and will at most be 6 (indicating a 64-byte-alignment).

thanks
-- PMM

