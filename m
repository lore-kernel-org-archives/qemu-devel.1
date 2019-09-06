Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8638CC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 14:16:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 507D72082C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 14:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l2pk2Z3P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 507D72082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6F1z-0002JY-FR
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 10:16:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50067)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i6F0k-0001Rr-TP
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 10:14:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i6F0j-0003he-EV
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 10:14:50 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:43939)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i6F0j-0003hJ-6Q
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 10:14:49 -0400
Received: by mail-oi1-x242.google.com with SMTP id t84so5044490oih.10
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2019 07:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+MI/buveC5g1hY2RyGTp5eabnWHE3/MWmcR7hsKTc9s=;
 b=l2pk2Z3Pjj8ru4i1VrNa+QCIQi1etYcJdLeXCyL7cBZOjTXpEZNzzudXqVxbVJJ5M0
 0EjrUfn0qibkybjeP2psScX3XAL0AWhYEVoome2oDCxq2KFIsHnePmZ9V0zaw3DjOME0
 VCVeCmqaDhAELmTq/+mlXWNJVRTeDQ2CANKSVZXcgUW1+8K2jDKu3eNxcmAMEwXqPS2H
 ApYx5faph6/Lf9Z/uKgeB0QqYfmxMLIV07pVKeei8+U9eWnZZTppRV9ujVPKn26QMkF7
 kBx9uRTL020uKqNNzTj86JtUj5o+ock9BeiRTx+TwZgeYgfUX1u8mUN/UlbXutrzRCnn
 /aZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+MI/buveC5g1hY2RyGTp5eabnWHE3/MWmcR7hsKTc9s=;
 b=FFxdvZFEHwZFKBe7W+on4y/cUGC0Wpl4BCBBzLNFbR8B+NFGr/GRcvquyMBiI9QACY
 eKH4AqQPcySmkrgIhcIjAwgY8jXE1D8GMo+BqVrZ0S4sN7DVeTnKpFf+mnWts74Y11mP
 6cyeWohT4nUUn8bWaJC/BdqWXi+l5L4lYsiRLs2TndlqFDYwKN3ueuxod03UjsFNThr0
 F9Sv9f05X7g6YiUk+UctWAaLdlqiopmfi/3IRb43RNOaJIktjc0pLQgw+vG1mQAdoItr
 +/33TP2DZrnuDX32/Ot9IbobM0ZVJvHpSp59+SexPROZhpzdC7qYz9Ge+a0N5/MaGYE/
 k/ZA==
X-Gm-Message-State: APjAAAUI6tVEJnUOkqziwOwreMPbfOuZCvQa0DICZl8+dddydAFQ/ySi
 DchHLXibivGMYqksPBsqp5pDVNVyoZnguyqLRU+UUA==
X-Google-Smtp-Source: APXvYqy3at3Q1xy7kl2gOMJy5cdqFLe8MKSw2RXSVA6CxBWL8Xmn9RTwOl5afsnZ1EqCOpSw+cj9SHhRYbjN5tqn6J4=
X-Received: by 2002:aca:4814:: with SMTP id v20mr7113742oia.98.1567779287859; 
 Fri, 06 Sep 2019 07:14:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190902012647.1761-1-tony.nguyen@bt.com>
 <CAFEAcA-4Tpa4qTCBXMTX+1n3fDK48d3ZFYn5CckOD7weqAWrcA@mail.gmail.com>
 <20190903164712.GA85777@imac.local>
 <CAFEAcA-FAJV1XEAZ7bcrstOWPv6wpAuZ4WjVo8bf+ewiWQYopA@mail.gmail.com>
 <20190904024051.GE30402@xz-x1>
In-Reply-To: <20190904024051.GE30402@xz-x1>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Sep 2019 15:14:36 +0100
Message-ID: <CAFEAcA8W0FjJ0gxgn1MU35JoUWyjzBH6HaN8JEonwNWXk8envw@mail.gmail.com>
To: Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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

On Wed, 4 Sep 2019 at 03:41, Peter Xu <peterx@redhat.com> wrote:
> On Tue, Sep 03, 2019 at 05:50:56PM +0100, Peter Maydell wrote:
> > Do you have a backtrace of QEMU from the segfault? I'm having trouble
> > thinking of what the situation is when we'd try to invoke the
> > read handler on io_mem_notdirty...
>
> I've no good understanding of how PHYS_SECTION_NOTDIRTY is used
> yet... though from what I understand that's the thing this patch wants
> to fix.  Because after the broken commit, this line will be
> overwritten:
>
>     .valid.accepts = notdirty_mem_accepts,
>
> and accept() will be reset to NULL.
>
> With that, memory_region_access_valid(is_write=false) could return
> valid now (so a read could happen), while it should never, logically?

Having looked into this a bit further, I think that the problem here
is that in commit 30d7e098d5c38644359 we accidentally removed the
code for TLB_RECHECK-type TLB entries that handled the "actually this
is a RAM access" case after repeating the tlb_fill(). So instead of
read accesses to notdirty-mem going through that code and never getting
into the io_readx() function, now they do. That combined with the
bug where we made the .valid.accepts assignment stop working means
you can get into this segfault. This is quite rare because I think
only Arm M-profile CPUs and Sparc when using the 'invert endian'
page table bit (ie Solaris guests doing PCI stuff) will do this.

If we apply this patch to reinstate .valid.accepts then instead
of a segfault we'll get a guest exception; which is still not
the right behaviour.

So I think we need to:
 (1) fix the cputlb code to reinstate the "handle RAM immediately"
     codepath
 (2) either allow reads to notdirty-mem MRs (ie make them just
     read from the host backing RAM), or define them to be a QEMU
     bug and make them assert immediately the read is attempted

thanks
-- PMM

