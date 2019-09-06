Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66DEC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 15:14:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D8C520842
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 15:14:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D8C520842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6FwC-0002Wb-Oy
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 11:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36158)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1i6Fv7-00023x-7Z
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 11:13:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1i6Fv4-0000Rk-Tq
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 11:13:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54902)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1i6Fv4-0000RW-Lb
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 11:13:02 -0400
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C3B0046288
 for <qemu-devel@nongnu.org>; Fri,  6 Sep 2019 15:13:01 +0000 (UTC)
Received: by mail-qt1-f198.google.com with SMTP id o34so6568798qtf.22
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2019 08:13:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=P1nVOwFtCbsVhqIC+RI/gvzSgYw6aHzVz9FJYR3AhFM=;
 b=Zw2FIJCKud5/97cmBmjB6NKVg5XokzRpteH7MI4Oof5O/2XvM15clANis4CMYIHbMJ
 mV862SjEZVGtLge/YE+qpmoXOI07KqlfaLoBjeo9rJYDjd1F1YU5v9XeRC2fKFY+YAyT
 xKUwiSWaRlKGjfsQ3UA633TyXyFQN3C1XIQiMfUxLZjf7zpbL/HdBQw3K/P0w+y5s/s1
 gD9cxNj6Xzj0PAs/E2wK6d+P5PrWiADZiuVOnVyP8CTXAO6N3LPG69YAecNHquBvFlaY
 lqhNRWm4a72zPGmPKUw1LzPsJVj4GEthXLOh74Fxg87SHbJoM4UFPVRpUh0rBr66ho8G
 fTgg==
X-Gm-Message-State: APjAAAV/sVSx416ieqJ3nmWnt0ycGp0EOu5HUfrV+M3xtAjKyfXYfpSa
 Z3iUuahsz2mr+Jjnxp+7qaAWhkeHqwXaBK5zCektVOtZUHsLFsP/BrOT+mxsYfw5N7ngKzgmHGJ
 j5nzj1zyWmTgitAo=
X-Received: by 2002:a37:9b48:: with SMTP id d69mr9612617qke.390.1567782781119; 
 Fri, 06 Sep 2019 08:13:01 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyHgkMoRD25dk09RbVSUcWW6ANs52gkzsDxqHcCP3rJvTfvigg3i6mJMGfNcJa20rn6HfTbzQ==
X-Received: by 2002:a37:9b48:: with SMTP id d69mr9612579qke.390.1567782780898; 
 Fri, 06 Sep 2019 08:13:00 -0700 (PDT)
Received: from redhat.com (bzq-79-176-40-226.red.bezeqint.net. [79.176.40.226])
 by smtp.gmail.com with ESMTPSA id k54sm3829851qtf.28.2019.09.06.08.12.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2019 08:12:59 -0700 (PDT)
Date: Fri, 6 Sep 2019 11:12:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Johannes Berg <johannes@sipsolutions.net>
Message-ID: <20190906110340-mutt-send-email-mst@kernel.org>
References: <20190902121233.13382-1-johannes@sipsolutions.net>
 <20190906121350.29202-1-johannes@sipsolutions.net>
 <20190906102217-mutt-send-email-mst@kernel.org>
 <be405c3ba658cdac7f68c91213c3b714ac24c1e3.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be405c3ba658cdac7f68c91213c3b714ac24c1e3.camel@sipsolutions.net>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC] libvhost-user: implement
 VHOST_USER_PROTOCOL_F_KICK_CALL_MSGS
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 06, 2019 at 04:48:39PM +0200, Johannes Berg wrote:
> Hi,
> 
> On Fri, 2019-09-06 at 10:22 -0400, Michael S. Tsirkin wrote:
> > On Fri, Sep 06, 2019 at 03:13:50PM +0300, Johannes Berg wrote:
> > > From: Johannes Berg <johannes.berg@intel.com>
> > > 
> > > Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> > 
> > a bit more content here about the motivation for this?
> 
> Heh, right, definitely needed.
> 
> I was just sending it out as the corresponding patch to the spec change
> RFC, where I explained more, so didn't really bother here yet. However,
> I evidently forgot to CC you on that:
> 
> https://lore.kernel.org/qemu-devel/20190902121233.13382-1-johannes@sipsolutions.net/


Oh. Apparently qemu mailman chose this time to kick me out
of list subscription (too many bounces or something?)
so I didn't see it.

> I'm still trying to implement it in User-Mode Linux (UML, ARCH=um),
> we've submitted patches for virtio/vhost-user support to that, but the
> simulation-bound IRQ handling is a bit complicated. I need to see how it
> turns out once I actually get it to work - I've gotten this extension,
> SLAVE_REQ and REPLY_ACK to work now, so need to "just" integrate with
> the time-travel mode I already have.
> 
> In any case, if you think that this is a stupid extension and say you
> will never accept it, I'll probably just implement a slightly more
> hackish way, setting vhost-user to polling mode and using out-of-band
> signalling or so. This seems a bit cleaner though, and if it's properly
> spec'ed and with sample code and all then it'll possibly be far more
> useful to others. (**)


What worries me is the load this places on the socket.
ATM if socket buffer is full qemu locks up, so we
need to be careful not to send too many messages.

> 
> 
> I think I also forgot to CC you on these two:
> https://lore.kernel.org/qemu-devel/20190828083401.2342-1-johannes@sipsolutions.net/
> https://lore.kernel.org/qemu-devel/20190903192505.10686-1-johannes@sipsolutions.net/
> 
> Again, sorry about that.
> 
> Btw, at least one of these files doesn't even have an entry in the
> maintainers file. Don't remember if it was the spec though or the
> libvhost-user stuff.
> 
> 
> (**) For example, there's the VMSimInt paper (***) that shows a very
> similar thing with QEMU, but works only with CPU emulation. With UML's
> time-travel mode made to work over virtio we can do similar things
> without CPU emulation. I suspect it's also possible to emulate the HPET
> or so in a KVM-based system, but seems far more tricky (to me at least).
> 
> (***) http://www.ikr.uni-stuttgart.de/Content/Publications/Archive/We_SIMUTools_2014_40209.pdf
> 
> Thanks,
> johannes

