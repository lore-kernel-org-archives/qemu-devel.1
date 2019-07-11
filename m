Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435EDC74A52
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 13:03:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 151AA21019
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 13:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AsI1MWJn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 151AA21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlYiz-0003Ql-BG
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 09:03:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33901)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hlYhd-0001uY-NJ
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 09:01:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hlYhb-0007qN-8F
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 09:01:37 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:34288)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hlYhb-0007pv-32
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 09:01:35 -0400
Received: by mail-ot1-x341.google.com with SMTP id n5so5764186otk.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 06:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DlCBAK869R2VULvL3hzvYE8/WG0a4e51TGIc7viUdU0=;
 b=AsI1MWJn6QKiJuTT6EP1tTKFcdNT0QvBfFpZfj4Gl+qBt3NrjbLomnXIIJKJPGR9Dt
 0OmqBOfXs+2SVq7CbtDqrEGLbHL/6t64xHu8dVZTErvN/AXtGpJYIeIBRZ0a0EIGiwwq
 7Yafex+ftj8MmhXYkYxCZyzjiBW8+WB8TtnZgDMjqTDNJSBmMbw7kgZicDhEnxbfgOCP
 EAxhDws/6+h7e5ozy0ak90l1FmmYiKDvaBZsiVRJsKsQpCDWzZjqznqdzD5fc4y9LkNg
 UaO/a3GcUzxWcwQE3JrKOIMlEwiVFvhpURAFG466w9nCaalu4Lhvu2qBZgBonTahywfl
 Pn9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DlCBAK869R2VULvL3hzvYE8/WG0a4e51TGIc7viUdU0=;
 b=LMg5h7mbOThclee05sEWkans8FXX267CEANnYTQJduzCBCn2SS2k115Rpx5ptTnUal
 /9hesPtXR1K90cnHVcQhRpPLFxtTLPDMeFW7hYRomh3SRoSGkhChUakXXqXSg3SOKI9y
 DaFYa+9fuM3xr8+Gk7H6arK3pateIJmYiIEUbRdWTz8dnZLc7FiHpNX+8nnhW2lPvSww
 lpIPDYmukFsKKEBeSbK52DmrRalejE9A9PIliMDfqL2L+2PHQedT0t/yNU8DnrEdlEMe
 m3pUV7aumGfZkPF7P73BO32Fx1/SNzQWLtc8HN+lSCs7qIuv8wkOBsalclroS5V9QnM5
 JuPg==
X-Gm-Message-State: APjAAAWylmxbXVmfAg1z/dAVEXi8oi6kwy8z9KySJtx9ha5QBLDUlk1f
 ZcGQAuHN+t48QCv5gKSvW1audXYPrSWttUqBU5PEUA==
X-Google-Smtp-Source: APXvYqwsgtkq45KEyG0cWRGfkI61XQc4V1sn0YwWe1f4asohpxHLm0qSO8KvFEKrRc9EAwK1tmdCxxB1piVY52qzz1Q=
X-Received: by 2002:a9d:711e:: with SMTP id n30mr3084074otj.97.1562850094117; 
 Thu, 11 Jul 2019 06:01:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190711104412.31233-1-quintela@redhat.com>
 <5828a0c7-bcb4-2ca4-eec3-cb44f9ab1312@de.ibm.com>
In-Reply-To: <5828a0c7-bcb4-2ca4-eec3-cb44f9ab1312@de.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jul 2019 14:01:23 +0100
Message-ID: <CAFEAcA_5Kb0aAyJKjv7OEGP8MzUvNYxvmuDcWhL8kT1zcUrCag@mail.gmail.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
 kvm-devel <kvm@vger.kernel.org>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 11 Jul 2019 at 13:56, Christian Borntraeger
<borntraeger@de.ibm.com> wrote:
>
>
>
> On 11.07.19 12:43, Juan Quintela wrote:
> > The following changes since commit 6df2cdf44a82426f7a59dcb03f0dd2181ed7fdfa:
> >
> >   Update version for v4.1.0-rc0 release (2019-07-09 17:21:53 +0100)
> >
> > are available in the Git repository at:
> >
> >   https://github.com/juanquintela/qemu.git tags/migration-pull-request
> >
> > for you to fetch changes up to 0b47e79b3d04f500b6f3490628905ec5884133df:
> >
> >   migration: allow private destination ram with x-ignore-shared (2019-07-11 12:30:40 +0200)
> >
> > ----------------------------------------------------------------
> > Migration pull request
> >
> > ----------------------------------------------------------------
> >
> [...]
> >  include/exec/memory.h        |   19 +
> >  include/exec/memory.h.rej    |   26 +
> >  include/exec/ram_addr.h      |   92 +-
> >  include/exec/ram_addr.h.orig |  488 +++
> [...]
> >  migration/ram.c              |   93 +-
> >  migration/ram.c.orig         | 4599 ++++++++++++++++++++++++++++++++++
> >  migration/ram.c.rej          |   33 +
>
> The .ref and .orig look odd. And they are is not part of the patches.

Good catch -- git diff says they are part of the pullreq so
they'd have ended up in the git repo if you hadn't noticed them.

thanks
-- PMM

