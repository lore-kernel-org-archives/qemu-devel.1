Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE07C76190
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 20:31:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71F7F218EA
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 20:31:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71F7F218EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqkOT-0002s4-KH
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 16:31:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42212)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hqkOI-0002SW-Kl
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 16:31:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hqkOH-0000Sx-5q
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 16:31:06 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40381)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hqkOG-0000NX-U7
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 16:31:05 -0400
Received: by mail-qt1-f193.google.com with SMTP id a15so50377968qtn.7
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 13:30:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=LcKAIQaE7rY0SLRL9gx2w/QqyGgwEEgyEDElE1CgGDU=;
 b=uUnCR4amsVWWles03t3L4EsJSE1PHhUxkcMABGNBJ+FREMC02vD2hoLwB6Gn41TlSp
 sBccBY1b54VLad/DrZ/GJLPVIjKw9S6riLFuG7+aZtYux6bfA80TyfkRoNg6eDC+oQa4
 95pzd/0o2VBxbuxo8CmXGM8O4PJW6bzXnVd+YkBZlbTcqGJYOjlr9XPlHRF5bjnVZ/IS
 S4lZyTPbPLynOJNjbNDPVYWkvFHALpYreh+5jBhnmN2AOaKrLq4nsb5jN1Hk20ns40Uy
 jbILsoA5hlhznFmjcdzKB9JKVGdzc3b6Wv4sqOzvxbjrlcARt1a8eJbGrh/IcXXv/oDd
 abFA==
X-Gm-Message-State: APjAAAWetXLIS4oac/alTPVgQlXfBPjAmZVD+5cDc3C/1LDxV3ewHyP8
 Zy2yhjUazpxkvcad+PReSSIhWQ==
X-Google-Smtp-Source: APXvYqzlo6pb1n33BCHjkq6x7aPwwo1qes6T7nuQdmyOcUo4a5LVTSdUuVIqbxyNU15WYoZtoeJTSA==
X-Received: by 2002:ac8:43d8:: with SMTP id w24mr63643322qtn.25.1564086650712; 
 Thu, 25 Jul 2019 13:30:50 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
 by smtp.gmail.com with ESMTPSA id
 u18sm21559439qkj.98.2019.07.25.13.30.47
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 25 Jul 2019 13:30:49 -0700 (PDT)
Date: Thu, 25 Jul 2019 16:30:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190725161646-mutt-send-email-mst@kernel.org>
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

I think I know what you are thinking of doing:
map /dev/zero so we get a single VMA but all mapped to
a single zero pte?

We could start with that, at least as an experiment.
Further:

- we can limit the amount of fragmentation and simply
  unmap everything if we exceed a specific limit:
  with more than X devices it's no longer a lightweight
  VM anyway :)

- we can implement /dev/ones. in fact, we can implement
  /dev/byteXX for each possible value, the cost will
  be only 1M on a 4k page system.
  it might come in handy for e.g. free page hinting:
  at the moment if guest memory is poisoned
  we can not unmap it, with this trick we can
  map it to /dev/byteXX.

Note that the kvm memory array is still fragmented.
Again, we can fallback on disabling the optimization
if there are too many devices.


-- 
MST

