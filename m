Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E315C76190
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 17:34:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9087229F3
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 17:34:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9087229F3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqhdB-0005vl-Te
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 13:34:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38074)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hqhcs-0005Dj-UC
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 13:33:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hqhcr-0007HJ-JQ
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 13:33:58 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36749)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hqhcr-0007G9-Dx
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 13:33:57 -0400
Received: by mail-qk1-f193.google.com with SMTP id g18so37042031qkl.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 10:33:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=wrnrwwipYpAStl3wG0T5xEH4kyINKwE/QX5O+1M0R1E=;
 b=U6TAFxPMaKiZYYfYBP8fTiKY222gGe8m8b+vvVQ5V7goTv6pWQ5qoHZX+tfoHu7m6u
 h1Izoiz/hY7Li/aj1ynZZSSP2iCI0WV52Fe08ZLW/KBJPG4adMCTK4py3Jn/DH1qOFsb
 fnBnxR9X9Le6NfTzveZzafIiwuZQWZMHAvLgDdrW+DhUYfwB7+DF7gBMJQ1vgjHKSFO4
 mUHhhRXfblWF6a8hLxh7kJQ7F/ZXJtwEkKxOh6reh539r/CB12+PzhNBVKh15Dp2VMdV
 WXUs9f5bvLcdJZs97pZpp6M/B6PSSCqFxpJxXlAcIqA9YdgBCYxi1aZn1IbAKZsERCyn
 baXQ==
X-Gm-Message-State: APjAAAV6J4hXhYRDaBLomYg2HQgl8f9dCetMivi+HgQOiytQtx2lEA+y
 C00px6qdF+mjfd9ZW/qTPja0xg==
X-Google-Smtp-Source: APXvYqyy2Pip7ozDIDYAH1WPJbAQLD7M1hVm6RzDkPWgr3KLTMnUjpvYK/PFWD6pJkU2Lok3Un3AgA==
X-Received: by 2002:a37:b381:: with SMTP id
 c123mr60950696qkf.349.1564076036425; 
 Thu, 25 Jul 2019 10:33:56 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
 by smtp.gmail.com with ESMTPSA id
 t197sm21921007qke.2.2019.07.25.10.33.52
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 25 Jul 2019 10:33:55 -0700 (PDT)
Date: Thu, 25 Jul 2019 13:33:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190725132521-mutt-send-email-mst@kernel.org>
References: <20190719102915.GG18585@stefanha-x1.localdomain>
 <8736j2p22w.fsf@redhat.com>
 <CAJSP0QXTSwk4eJteC0wTB7LGoHY3=7t4G-eNfgREQ6k+GzV2_w@mail.gmail.com>
 <904248411098104fcf7db22382172057e50db76c.camel@intel.com>
 <87tvbdrvin.fsf@redhat.com>
 <CAJSP0QW1NrYwC6a61jj_vgJOJO7ofJOVUcz6Bf4z720OiN_0rw@mail.gmail.com>
 <c1464003-38f9-95ee-c42a-fb1d370df0ab@redhat.com>
 <c9c811f4-6108-f5b1-31f5-3f757f51cf3c@redhat.com>
 <20190725104331-mutt-send-email-mst@kernel.org>
 <6d318abf-4afa-a1dc-a4e8-3a2d0a6de297@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d318abf-4afa-a1dc-a4e8-3a2d0a6de297@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.222.193
Subject: Re: [Qemu-devel] [PATCH v3 0/4] Introduce the microvm machine type
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
Cc: "ehabkost@redhat.com" <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "maran.wilson@oracle.com" <maran.wilson@oracle.com>, "Montes,
 Julio" <julio.montes@intel.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kraxel@redhat.com" <kraxel@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>,
 "sgarzare@redhat.com" <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 25, 2019 at 05:35:01PM +0200, Paolo Bonzini wrote:
> On 25/07/19 16:46, Michael S. Tsirkin wrote:
> > Actually, I think I have a better idea.
> > At the moment we just get an exit on these reads and return all-ones.
> > Yes, in theory there could be a UR bit set in a bunch of
> > registers but in practice no one cares about these,
> > and I don't think we implement them.
> > So how about mapping a single page, read-only, and filling it
> > with all-ones?
> 
> Yes, that's nice indeed. :)  But it does have some cost, in terms of
> either number of VMAs or QEMU RSS since the MMCONFIG area is large.
> 
> What breaks if we return all zeroes?  Zero is not a valid vendor ID.
> 
> Paolo

It isn't but that's not what baremetal does. So there's some risk
there ...

Why is all zeroes better? We still need to map it, right?

-- 
MST

