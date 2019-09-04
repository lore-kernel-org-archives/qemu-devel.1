Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379DAC3A5A2
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 02:41:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E28E22CEA
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 02:41:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E28E22CEA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5LEw-0004Fr-V8
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 22:41:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43142)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1i5LEJ-0003p2-Bk
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 22:41:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1i5LEH-0005CU-56
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 22:41:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42748)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1i5LEG-0005Be-TD
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 22:41:05 -0400
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6D6B587642
 for <qemu-devel@nongnu.org>; Wed,  4 Sep 2019 02:41:03 +0000 (UTC)
Received: by mail-pf1-f199.google.com with SMTP id r7so3223390pfg.2
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 19:41:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=eKwILVGrsx9/jrqhObIIeI6sRcQEt8PVlaSdQ8fdHuU=;
 b=CZzFSxx6nCTbzVQdb2jnYqUiA3BjdUsOpSn8dh4nE8tP5bEQSa+/eUUguAqW3IJDQo
 DttxUwszn43GFEqUQ7qPjHDseR0aRrFhkUltdgSjMv4/JAYsKFaoLZT4y8Ps68SDFeG7
 BHi0EhhS/ZvNkBX1hf7zcmcB5U97aRaahka9cFXwtVh/2YoI5jZ0mTR9tQ8jNN00AREa
 062nDAPcmFpt+Ift3pEJMzbJ2EpKBTwWgYPICnKQlQZJGqwFWC9RuuLM5+IjzsARzNAw
 1ZAXPi3PuUaE6vNAbl629nXHhWASz+CrJtCcFq5hzKtRvvPL2iaFxE/rknemQlS57hF+
 q0GQ==
X-Gm-Message-State: APjAAAXK8gy9n+hg9n3W+AKG0RguU4AoGlzupWiTENRCrrqYsN2C6aRJ
 B41u96FSwTt6gHTWCBW7QGy/BTUJlPA+kkFtkHmg14oFbposkDgXFvTuFTHNjVG3A14KK80xkXK
 UYp+syA10djLTg/w=
X-Received: by 2002:a17:90a:8081:: with SMTP id
 c1mr2670454pjn.62.1567564862972; 
 Tue, 03 Sep 2019 19:41:02 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzfa7J1UibDp/G5aN6amlxqhQr0JOgP2niHZ/OMs8A1BMc+3Wlpf9sxmQy9IsDUfsb6lkz+9g==
X-Received: by 2002:a17:90a:8081:: with SMTP id
 c1mr2670444pjn.62.1567564862744; 
 Tue, 03 Sep 2019 19:41:02 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id s13sm21718304pfm.12.2019.09.03.19.40.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2019 19:41:01 -0700 (PDT)
Date: Wed, 4 Sep 2019 10:40:51 +0800
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190904024051.GE30402@xz-x1>
References: <20190902012647.1761-1-tony.nguyen@bt.com>
 <CAFEAcA-4Tpa4qTCBXMTX+1n3fDK48d3ZFYn5CckOD7weqAWrcA@mail.gmail.com>
 <20190903164712.GA85777@imac.local>
 <CAFEAcA-FAJV1XEAZ7bcrstOWPv6wpAuZ4WjVo8bf+ewiWQYopA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-FAJV1XEAZ7bcrstOWPv6wpAuZ4WjVo8bf+ewiWQYopA@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] memory: Set notdirty_mem_ops validator
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
Cc: Tony Nguyen <tony.nguyen@bt.com>, Richard Henderson <rth@twiddle.net>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 03, 2019 at 05:50:56PM +0100, Peter Maydell wrote:
> On Tue, 3 Sep 2019 at 17:47, Tony Nguyen <tony.nguyen@bt.com> wrote:
> >
> > On Tue, Sep 03, 2019 at 11:25:28AM +0100, Peter Maydell wrote:
> > > On Mon, 2 Sep 2019 at 02:36, Tony Nguyen <tony.nguyen@bt.com> wrote:
> > > >
> > > > Existing read rejecting validator was mistakenly cleared.
> > > >
> > > > Reads dispatched to io_mem_notdirty then segfaults as there is no read
> > > > handler.
> > >
> > > Do you have the commit hash for where we introduced the
> > > bug that this is fixing?
> > >
> > > thanks
> > > -- PMM
> > >
> >
> > ad52878f97610757390148fe5d5b4cc5ad15c585.
> >
> > Please feel free to amend my commit message.
> 
> Thanks.
> 
> > I do not understand why sun4u booting Solaris 10 triggers the bug.
> 
> Do you have a backtrace of QEMU from the segfault? I'm having trouble
> thinking of what the situation is when we'd try to invoke the
> read handler on io_mem_notdirty...

I've no good understanding of how PHYS_SECTION_NOTDIRTY is used
yet... though from what I understand that's the thing this patch wants
to fix.  Because after the broken commit, this line will be
overwritten:

    .valid.accepts = notdirty_mem_accepts,

and accept() will be reset to NULL.

With that, memory_region_access_valid(is_write=false) could return
valid now (so a read could happen), while it should never, logically?

Regards,

-- 
Peter Xu

