Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DF0C74A52
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 12:40:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32B0E2084B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 12:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uPjeCcZy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32B0E2084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlYNH-0005Ce-Al
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 08:40:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56196)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hlYMm-0004nj-Hg
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 08:40:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hlYMl-0004Rn-ER
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 08:40:04 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:38527)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hlYMl-0004R1-7y
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 08:40:03 -0400
Received: by mail-oi1-x242.google.com with SMTP id v186so4352066oie.5
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 05:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3Yt4EscGigEBnlnjY7wWgkB/ov60rXHSlmHTWLza6n4=;
 b=uPjeCcZyt2xFKg2rAD3fkzlSCJR/DUfzg8UN7frwQfq/6628hhyOdtkgFGlnrlPdrt
 ERiC/eSwlKnAuUDJp5O4YN5EXSBnqtEahX141CDob0ECQ3QRSaWjy4u1PZVICqjSCque
 byOjTttw4zsDSxomIowXeUSOtA7fpRjD8etTHX670QMsP3pLR7J20R8Cilw6xHY+HyzT
 EY3lv53l62ZtI4eHQhLmUGxZrh3W4Mo5V9Pf7Wi5kjjaSqFmsfKixxhX2sEFlJ0zk+mR
 T9A6gX0B4mFmFe6CFf7GG5mscP5WS0kk3CJwtnJIDWUjpt7Bxm6Pzz6+CfPXQBnhQkX+
 DfFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3Yt4EscGigEBnlnjY7wWgkB/ov60rXHSlmHTWLza6n4=;
 b=MgpOLod+ekhg/WZXX+Ds4rCeTa4QEMf2EVuu77v5NVDINivWHau5a6vuuVC8qV/Hzk
 Bi4mzjPDfgFQ5dHCF21D3Of5zdcRzEdHdE5z/MxaKVZNpSzY5E7rTtu/KsKU5KsaXS6u
 fsUAYDLyp+Gi7nPyeLjNDORNDqo3qwzjFQ04sUDhiVf9Ra1IevJ04pf7xm0869+SLXG2
 h7gyy3oGhRUu+p0gabiKfRHqsMwCKrdtpmSmQkhHE3W8xWE6PpaXhOxh1rdq72TFxhrB
 xOEKSsybxldp3R/JBkfBXXnoadjVx+fs7Bj+DKhyMaIVjWJz7vaIjfmFLBfkK+aCQb2o
 /j1A==
X-Gm-Message-State: APjAAAXLiaPxZXRnLj79hJIshpAj+U0bu91S+w+JoLRyaAz0uNXfFpgZ
 VsSkSakaS7kHnKXSi3wjxS27uE2R3y/0vx7ey16jJQ==
X-Google-Smtp-Source: APXvYqx88tSye8THszfgMMvEEcruY6rukK6VV++UTAkaz8tl3XLtSypsMIu65tZSvL5XnyBEfwT4Uo2D1KRoMzGoS+o=
X-Received: by 2002:a05:6808:8c2:: with SMTP id
 k2mr2178732oij.98.1562848801716; 
 Thu, 11 Jul 2019 05:40:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190711104412.31233-1-quintela@redhat.com>
In-Reply-To: <20190711104412.31233-1-quintela@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jul 2019 13:39:50 +0100
Message-ID: <CAFEAcA8uwgmV47Dt8e=ZRLzssXKWn+1DivDFEuN5s2+N1FJX3w@mail.gmail.com>
To: Juan Quintela <quintela@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] [PULL 00/19] Migration patches
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 kvm-devel <kvm@vger.kernel.org>, QEMU Developers <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 11 Jul 2019 at 11:56, Juan Quintela <quintela@redhat.com> wrote:
>
> The following changes since commit 6df2cdf44a82426f7a59dcb03f0dd2181ed7fdfa:
>
>   Update version for v4.1.0-rc0 release (2019-07-09 17:21:53 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/juanquintela/qemu.git tags/migration-pull-request
>
> for you to fetch changes up to 0b47e79b3d04f500b6f3490628905ec5884133df:
>
>   migration: allow private destination ram with x-ignore-shared (2019-07-11 12:30:40 +0200)
>
> ----------------------------------------------------------------
> Migration pull request
>
> ----------------------------------------------------------------

Hi; this fails "make check" on aarch32 host (possibly a general
32-bit host issue, as this is the only 32-bit host I test on):

MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
tests/test-bitmap -m=quick -k --tap < /dev/null |
./scripts/tap-driver.pl --test-name="test-bitmap"
**
ERROR:/home/peter.maydell/qemu/tests/test-bitmap.c:39:check_bitmap_copy_with_offset:
assertion failed (bmap1 == bmap2)
Aborted
ERROR - Bail out!
ERROR:/home/peter.maydell/qemu/tests/test-bitmap.c:39:check_bitmap_copy_with_offset:
assertion failed (bmap1 == bmap2)
/home/peter.maydell/qemu/tests/Makefile.include:904: recipe for target
'check-unit' failed

thanks
-- PMM

