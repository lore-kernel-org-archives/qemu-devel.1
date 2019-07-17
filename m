Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D27C76188
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 03:12:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 217A620818
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 03:12:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 217A620818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnaMd-0005wC-0q
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 23:12:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35084)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <zhexu@redhat.com>) id 1hnaMS-0005YE-4i
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 23:12:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhexu@redhat.com>) id 1hnaMR-00006e-2i
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 23:12:08 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40368)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <zhexu@redhat.com>) id 1hnaMQ-00005j-T2
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 23:12:07 -0400
Received: by mail-pf1-f193.google.com with SMTP id p184so10081726pfp.7
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 20:12:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:date:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=5Cd+K10dF34Ps2D3ey6/NErbheXXyFs+WcBqcQkI4h0=;
 b=GhXERuHtxNpRPT1Nu57uxPaBWNVqRqO/I2+h3V20dwP/7DxBPtBsJpZKJH84XkwhnE
 J6kpkiqYHmF1NaQTF5umadjSgjKN7Vx7EqR3BJZ1TDz3eOTYgno+8wFq1kZeFJ15eOv2
 jmXH7JFdRxDxNI1ACTYy8ozVmAJ4pZkC40PzYSOgfJe5ovWkyRUZOVYcIS3SLUcfZiXX
 w8z6kC/0irNWmP18G0zX4hZat3BXIx+BbH2EUm9MyOYB1G+CxxXIeyHVZVXc7m3UvoBR
 /J8q3B5M2i3/pqP1LDzLbXKb7UVmDM+x9ywyRSwSCn3WPEHPpGByDI9AgBSxVvEiZZsF
 Rr/g==
X-Gm-Message-State: APjAAAXlh86cETeODDIZFaHu0rkBQ0UFmhAC85N791nPDpIhN5hnomqk
 UCexpZnPOfHOwZxoDxpBnwNrMA==
X-Google-Smtp-Source: APXvYqyK85Ihxnmib2nJCHXzkKfXeG3GEvxEamg7cYTSWw2NrnWdAMzZwPdqeCQSsrJLYcMgGoQHLA==
X-Received: by 2002:a63:ab08:: with SMTP id p8mr39177708pgf.340.1563333125924; 
 Tue, 16 Jul 2019 20:12:05 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id v27sm29230764pgn.76.2019.07.16.20.12.02
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 16 Jul 2019 20:12:05 -0700 (PDT)
From: Peter Xu <zhexu@redhat.com>
X-Google-Original-From: Peter Xu <peterx@redhat.com>
Date: Wed, 17 Jul 2019 11:11:55 +0800
To: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190717031155.GE30980@xz-x1>
References: <20190717012902.23958-1-richardw.yang@linux.intel.com>
 <20190717015910.GD30980@xz-x1> <20190717024637.GA17163@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190717024637.GA17163@richard>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.193
Subject: Re: [Qemu-devel] [RESEND][PATCH] bitmap: get last word mask from nr
 directly
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
Cc: quintela@redhat.com, corentincj@iksaif.net, pl@kamp.de,
 qemu-devel@nongnu.org, Peter Xu <zhexu@redhat.com>, kraxel@redhat.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 17, 2019 at 10:46:37AM +0800, Wei Yang wrote:
> On Wed, Jul 17, 2019 at 09:59:10AM +0800, Peter Xu wrote:
> >On Wed, Jul 17, 2019 at 09:29:02AM +0800, Wei Yang wrote:
> >> The value left in nr is the number of bits for the last word, which
> >> could be calculate the last word mask directly.
> >
> >Is it true even if start does not align to BITS_PER_LONG?
> >
> 
> Yes. Let me see how to explain this.
> 
> When you look into the definition of BITMAP_LAST_WORD_MASK, it takes the
> number of total bits and give the number of bits in last word. While the value
> matters for the input is the number of last word. This means the following
> equation stands
> 
>   BITMAP_LAST_WORD_MASK(size) == BITMAP_FIRST_WORD_MASK(size % BITS_PER_LONG)
> 
> Now let look at the calculation for nr. In each iteration, nr will be
> truncated to be aligned to BITS_PER_LONG. So when we exit the loop, nr keeps
> the number of bits in last word.
> 
> So we can leverage the result, no matter the start is aligned or not.

Yes, you are right.

Do you have plan to write some unit tests for these functions? :)

It'll be tests/test-bitmap.c.  IMHO the test cases could be even more
helpful to the QEMU project as a whole comparing to this patch to
guarantee changes like your patch won't break.

At the meantime I think you can also do that to bitmap_set_atomic.

Thanks,

-- 
Peter Xu

