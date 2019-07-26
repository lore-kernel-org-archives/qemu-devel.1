Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3834C7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 11:10:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A84521852
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 11:10:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A84521852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqy7R-0003sN-1l
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 07:10:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57257)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hqy7C-00034Q-95
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 07:10:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hqy79-0001ks-CE
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 07:10:21 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36088)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hqy76-0001Yy-DA
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 07:10:17 -0400
Received: by mail-qt1-f193.google.com with SMTP id z4so52209761qtc.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 04:10:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=vvcdHxTYqGYGDGOyOJGgugnlgzEVTGgvXQKh8K5JBSU=;
 b=H7P2b4SbTScwF5/hcTJ8RIB78nd5J8p5QTzWQML+GOR1448jQ+5Fa8Vi6nK2YMl4Pq
 z4HWFcQFv7CeLroCltSpP+8P0yTuS3Fwta3nkuNGSmvn14VbedWqiiHSysO7JHB2Ybdf
 fciu4b3VY0OQolqmatrPvJuc8Mr3JNcGO+pdMwqOEzTgO05ApeqIc8JnOnfnstqPOceV
 M0a0dH2BzzIU/ed0RCda5l06KITSRypcxBk/bPfxhB57njxf/I5j6pS0vC1+cTO0CVhq
 p4JG7/MZl+HNBpujc1iw12LjyBPH3pyOXTfP7Iau2j9YYoAI8jNO1r6XwM68C9o34rI8
 TsDg==
X-Gm-Message-State: APjAAAXVwdejLXETbbnv8bl9SM3ufC6z8rIXv4NDkqiCUHjc3ASVQxNJ
 1TmNqjeyAu2FSBy3KvySKtm4MA==
X-Google-Smtp-Source: APXvYqx0puGZGJFfJuW6jaz8uoAWrCY7PCgWI7XhJxHTCRVAu3k6Us8rqMIbGG7gsqhQUCIigVvoMw==
X-Received: by 2002:ac8:323a:: with SMTP id x55mr64355534qta.211.1564139411480; 
 Fri, 26 Jul 2019 04:10:11 -0700 (PDT)
Received: from redhat.com ([212.92.104.165])
 by smtp.gmail.com with ESMTPSA id l63sm22746671qkb.124.2019.07.26.04.10.06
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 04:10:10 -0700 (PDT)
Date: Fri, 26 Jul 2019 07:10:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190726065653-mutt-send-email-mst@kernel.org>
References: <CAJSP0QXTSwk4eJteC0wTB7LGoHY3=7t4G-eNfgREQ6k+GzV2_w@mail.gmail.com>
 <904248411098104fcf7db22382172057e50db76c.camel@intel.com>
 <87tvbdrvin.fsf@redhat.com>
 <CAJSP0QW1NrYwC6a61jj_vgJOJO7ofJOVUcz6Bf4z720OiN_0rw@mail.gmail.com>
 <c1464003-38f9-95ee-c42a-fb1d370df0ab@redhat.com>
 <c9c811f4-6108-f5b1-31f5-3f757f51cf3c@redhat.com>
 <20190725104331-mutt-send-email-mst@kernel.org>
 <6d318abf-4afa-a1dc-a4e8-3a2d0a6de297@redhat.com>
 <20190725161646-mutt-send-email-mst@kernel.org>
 <65d0458b-02bf-0e40-2851-b4becc911e4f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65d0458b-02bf-0e40-2851-b4becc911e4f@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.160.193
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

On Fri, Jul 26, 2019 at 09:57:51AM +0200, Paolo Bonzini wrote:
> On 25/07/19 22:30, Michael S. Tsirkin wrote:
> > On Thu, Jul 25, 2019 at 05:35:01PM +0200, Paolo Bonzini wrote:
> >> On 25/07/19 16:46, Michael S. Tsirkin wrote:
> >>> Actually, I think I have a better idea.
> >>> At the moment we just get an exit on these reads and return all-ones.
> >>> Yes, in theory there could be a UR bit set in a bunch of
> >>> registers but in practice no one cares about these,
> >>> and I don't think we implement them.
> >>> So how about mapping a single page, read-only, and filling it
> >>> with all-ones?
> >>
> >> Yes, that's nice indeed. :)  But it does have some cost, in terms of
> >> either number of VMAs or QEMU RSS since the MMCONFIG area is large.
> >>
> >> What breaks if we return all zeroes?  Zero is not a valid vendor ID.
> >>
> >> Paolo
> > 
> > I think I know what you are thinking of doing:
> > map /dev/zero so we get a single VMA but all mapped to
> > a single zero pte?
> 
> Yes, exactly.  You absolutely need to share the page because the guest
> could easily touch 32*256 pages just to scan function 0 on every bus and
> device, even if the VM has just 4 or 5 devices and all of them on the
> root complex.  And that causes fragmentation so you have to map bigger
> areas.
> 
> > - we can implement /dev/ones. in fact, we can implement
> >   /dev/byteXX for each possible value, the cost will
> >   be only 1M on a 4k page system.
> >   it might come in handy for e.g. free page hinting:
> >   at the moment if guest memory is poisoned
> >   we can not unmap it, with this trick we can
> >   map it to /dev/byteXX.
> 
> I also thought of /dev/ones, not sure how it would be accepted. :)  Also
> you cannot map lazily on page fault, otherwise you get a vmexit and it's
> slow again.  So /dev/ones needs to be written to use a huge page, possibly.
> 
> Paolo

It's not easy to do that - each device gets 4K within MCFG.

So what we need then is a kvm option to create an address range - or
maybe even a group of address ranges and aggressively map all pages in a
group to the same guest page on a fault of one page in the group.

-- 
MST

