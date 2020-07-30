Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6F8C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 20:46:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 632BE2083E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 20:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YqeGcrUK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 632BE2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1FS0-0002Ub-Nn
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 16:46:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47238)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k1FQg-0001p1-Ma
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 16:45:30 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:44138)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k1FQe-0006lS-Q9
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 16:45:30 -0400
Received: by mail-oi1-x241.google.com with SMTP id h3so1305300oie.11
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 13:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=aBkYvXkJmJRapHaYhhDaM6BjCIDlswdRCmfla7GwHYA=;
 b=YqeGcrUKOCr8MEeMA+/b1iof0fzvvJJGI2h4iuCJiTOHJn6XbV7JzYWArye73dG9K4
 YGpP9X1gbJ6at4WN48DMuH1g7/18XFb1V9zBFRgXYQsFWrOBQPvc8le7PUJxY/6kB7VF
 xjFdCbUhJDCck3K7MEvnWmI+YU21v4Dxth+PSzZ/KlJKM6hvKzVip/xqMApoLtVqzxSw
 uIO7LZpbzs4+c5yzobbT+pyagL58ot7yqABHPPgKEIYZJjgUHWYJVBmxLI65fDCLnFC8
 WeafOo9qO93CSR5uNw/ItnLzlTn/STRI2Uvkxv6+1ICcG93mY9WbQwwFMSLqAg1XtoC7
 RN0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=aBkYvXkJmJRapHaYhhDaM6BjCIDlswdRCmfla7GwHYA=;
 b=s6Ye6dD4hZVGVx5UadJiTYs7LYFcTo40+kbhDpK8SD9Noj6/Hh3R/V8l2lB5ap0QSa
 DdblSKqkP8Cx90hTnflgD34VddFMZ/1teo3ZZPJjL0YgAaTKUs6Abz0LV1UmqRtFc7gc
 EaK2M16TmXbntxUl5qSZCBAiR2ueeV4HLEzYCdiE7mBuESjT+qDC4I08NJQUyZqx43so
 OrVtbY/ptzoGHD3rKbK4YreHnhxsLdVk0Ezkb6UyVXwTxvW4GSwXlhSX7UnDILPob2z7
 2CZpPkxRS3Ypcec6bqRLaugoirB0HyMGrjeT3z6A9A/UjNj6ELoi2P8hYpnYnqrhPO9i
 cYUw==
X-Gm-Message-State: AOAM531G9v+oZC7ryxkSuO7i/8PktlhX2JaUbTLJ8RigoT911tezhnwG
 GairIwEe1dI0+VPCsbGYE07eKGveVnqG7aYPLT05LA==
X-Google-Smtp-Source: ABdhPJwUhyfzQ2Q+qGHF8H7sCi+YU4ppR1ULdfb5Rj60/qoNUof8kctfEKokWujmR9Uug92cMsv87J5gqD9hxObzD7U=
X-Received: by 2002:aca:50c4:: with SMTP id e187mr601881oib.146.1596141927371; 
 Thu, 30 Jul 2020 13:45:27 -0700 (PDT)
MIME-Version: 1.0
References: <1596110248-7366-1-git-send-email-likaige@loongson.cn>
 <1596110248-7366-2-git-send-email-likaige@loongson.cn>
In-Reply-To: <1596110248-7366-2-git-send-email-likaige@loongson.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Jul 2020 21:45:16 +0100
Message-ID: <CAFEAcA85xA=T389_M5_vjvm=TPirMqxNDt0za65G2NOfaDHdWA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] target/arm: Fix compile error.
To: Kaige Li <likaige@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: David Hildenbrand <david@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 30 Jul 2020 at 12:58, Kaige Li <likaige@loongson.cn> wrote:
>
> When I compile qemu with such as:
>
> git clone https://git.qemu.org/git/qemu.git
> cd qemu
> git submodule init
> git submodule update --recursive
> ./configure
> make
>
> There is error log:
>
> /home/LiKaige/qemu/target/arm/translate-a64.c: In function =E2=80=98disas=
_ldst=E2=80=99:
> /home/LiKaige/qemu/target/arm/translate-a64.c:3392:5: error: =E2=80=98fn=
=E2=80=99 may be used uninitialized in this function [-Werror=3Dmaybe-unini=
tialized]
>      fn(cpu_reg(s, rt), clean_addr, tcg_rs, get_mem_index(s),
>      ^
> /home/LiKaige/qemu/target/arm/translate-a64.c:3318:22: note: =E2=80=98fn=
=E2=80=99 was declared here
>      AtomicThreeOpFn *fn;
>                       ^
> cc1: all warnings being treated as errors
>
> So, add an initiallization value NULL for fn to fix this.
>
> Signed-off-by: Kaige Li <likaige@loongson.cn>

Hi; I've taken this patch (but not patch 1 in the series)
into target-arm.next, with the commit message cleaned up
to quote the compiler version.

thanks
-- PMM

