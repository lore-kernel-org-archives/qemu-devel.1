Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FCFC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 14:02:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 676AE20706
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 14:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CckqTFhN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 676AE20706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k82CD-0006y6-Ky
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 10:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57666)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k82BH-0006BZ-Bk
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 10:01:41 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35011
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k82BE-0006BO-6o
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 10:01:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597759294;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rrwtjcc59FKFdiu14kgbgMszFPOq1+seSeiPIIo1giU=;
 b=CckqTFhNt2Xvo1P2zQFbxjdG+Wh5UFYYa0zoKOAL5EWByYmMn7yRraLT4GSAUwztanPLfb
 AiNG2g8Ifuwdo4xbugwWEu1cJhBtzhqwN+1Jv0sH19Hl+1tsPvEjfdvR5vdrq4y/ZlFqeB
 cNHLUqVuy6JLhvGraOwgQ/JLhEYqKN4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-HYWw8WCvOx-4PqmwXWo1aA-1; Tue, 18 Aug 2020 10:01:30 -0400
X-MC-Unique: HYWw8WCvOx-4PqmwXWo1aA-1
Received: by mail-wr1-f69.google.com with SMTP id r14so8311428wrq.3
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 07:01:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=rrwtjcc59FKFdiu14kgbgMszFPOq1+seSeiPIIo1giU=;
 b=UgMK47G0t7SJ3sjxDrLeOqVyd8+CD3pe4WV41htHGApmn8qQotK0kxYkzWVcItkB/2
 71yuSOdCZe1i1k9pWcLVdnBKkI7dXg1HtWD/vybVzJq5dnuM27ZW/vCDZ4/yMJWPRMZA
 UpiOh5xWUYf2OYruKOPpp7nlgoNi/ICZ/bHOsKYHZ7FAxqT/GLRDP/+YdkE5yyTJE34e
 W3E82side3r7QNUBVLkoIGA6tgnSFLuQls8QjdWAFK7dz3D5aLSHmjEztHjCi3P3bjmL
 nVtsiHKRmpCYdH9gxc33hke8pPC7GPjDBycXgb+2UOCzb5TSKBF+X+97LOrXGZp8TrLD
 VW/A==
X-Gm-Message-State: AOAM530DdGmKpcIFBCppBUoB0wYDDpU6bwIrTuOr6cM+1UhuLve8iQ31
 TkhQqdkGLej5JPmewGWKn0yvE6JAOamwIZZ/jKsgSxon0yTmZb8SUFoIP1RzkvP6dv3cH5DJDLi
 ewwLzSqrkAArfnEw=
X-Received: by 2002:adf:f606:: with SMTP id t6mr21623281wrp.182.1597759289076; 
 Tue, 18 Aug 2020 07:01:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzYs7AFsJhYw1nVW9LBmgQlEd+SPOy9FcLoPeaHUBNTZm5HhIQ1McP0RvgdB3IrOGqvQ67mWg==
X-Received: by 2002:adf:f606:: with SMTP id t6mr21623252wrp.182.1597759288687; 
 Tue, 18 Aug 2020 07:01:28 -0700 (PDT)
Received: from steredhat ([5.180.207.22])
 by smtp.gmail.com with ESMTPSA id u66sm48164wmu.37.2020.08.18.07.01.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2020 07:01:27 -0700 (PDT)
Date: Tue, 18 Aug 2020 16:01:20 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: virtio-vsock requires 'disable-legacy=on' in QEMU 5.1
Message-ID: <20200818140120.c46fsf6cia2ol53v@steredhat>
References: <CAGxU2F7pVNWtJG2BM2bk9qtJ_UHgDw4kjVqRmL-=yme7VX83Vg@mail.gmail.com>
 <20200813112820.62ffd63e.cohuck@redhat.com>
 <20200813102430.vjnc56anqjaxn4tw@steredhat.lan>
 <20200813123737.25ba11d2.cohuck@redhat.com>
 <20200813120415.s5we6mihe6fywm4a@steredhat.lan>
 <20200817122746.0b786372.cohuck@redhat.com>
 <20200817131128.lgxn3pyzuzly4edp@steredhat>
 <20200818144450.0701d68c.cohuck@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200818144450.0701d68c.cohuck@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 02:16:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Halil Pasic <pasic@linux.ibm.com>, Qinghua Cheng <qcheng@redhat.com>,
 qemu devel list <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 18, 2020 at 02:44:50PM +0200, Cornelia Huck wrote:
> On Mon, 17 Aug 2020 15:11:28 +0200
> Stefano Garzarella <sgarzare@redhat.com> wrote:
> 
> > On Mon, Aug 17, 2020 at 12:27:46PM +0200, Cornelia Huck wrote:
> > > On Thu, 13 Aug 2020 14:04:15 +0200
> > > Stefano Garzarella <sgarzare@redhat.com> wrote:
> > >   
> > > > On Thu, Aug 13, 2020 at 12:37:37PM +0200, Cornelia Huck wrote:  
> > > > > On Thu, 13 Aug 2020 12:24:30 +0200
> > > > > Stefano Garzarella <sgarzare@redhat.com> wrote:
> > > > >     
> > > > > > On Thu, Aug 13, 2020 at 11:28:20AM +0200, Cornelia Huck wrote:    
> > > > > > > We basically have three possible ways to deal with this:
> > > > > > > 
> > > > > > > - Force it to modern (i.e., what you have been doing; would need the
> > > > > > >   equivalent changes in ccw as well.)      
> > > > > > 
> > > > > > Oo, thanks for pointing out ccw!
> > > > > > I don't know ccw well, in this case should we set dev->max_rev to 1 or 2
> > > > > > to force to modern?    
> > > > > 
> > > > > No, ->max_rev is the wrong side of the limit :) You want    
> > > > 
> > > > Well :-) Thanks!
> > > >   
> > > > > 
> > > > >     ccw_dev->force_revision_1 = true;
> > > > > 
> > > > > in _instance_init() (see e.g. virtio-ccw-gpu.c).
> > > > >     
> > > > > >     
> > > > > > >   Pro: looks like the cleanest approach.
> > > > > > >   Con: not sure if we would need backwards compatibility support,
> > > > > > >   which looks hairy.      
> > > > > > 
> > > > > > Not sure too.    
> > > > > 
> > > > > Yes, I'm not sure at all how to handle user-specified values for
> > > > > legacy/modern.  
> > > 
> > > Thinking a bit more about it, I'm not sure whether we even *can*
> > > provide backwards compatibility: we have different autoconfigurations
> > > for PCI based upon where it is plugged, and ccw does not have a way to
> > > turn legacy on/off, except from within the code.  
> > 
> > Yes, I discovered today for example that the PCIe bus set auto-legacy
> > mode to off.
> 
> And vhost-vsock actually really seems to be modern-only, see below.
> 
> > 
> > >   
> > > > >     
> > > > > >     
> > > > > > > - Add vsock to the list of devices with legacy support.
> > > > > > >   Pro: Existing setups continue to work.
> > > > > > >   Con: If vsock is really virtio-1-only, we still carry around
> > > > > > >   possibly broken legacy support.      
> > > > > > 
> > > > > > I'm not sure it is virtio-1-only, but virtio-vsock was introduced in
> > > > > > 2016, so I supposed it is modern-only.    
> > > > > 
> > > > > Yes, I would guess so as well.
> > > > >     
> > > > > > 
> > > > > > How can I verify that? Maybe forcing legacy mode and run some tests.    
> > > > > 
> > > > > Probably yes. The likeliest area with issues is probably endianness, so
> > > > > maybe with something big endian in the mix?
> > > > >     
> > > > 
> > > > Yeah, I'll try this setup!
> 
> Ok, I tried this now with an x86 host and an s390x guest. Reverted the
> checking commit, tried both with a -ccw and a -pci device and your ncat
> example.
> - When using virtio-1, both devices work fine.
> - When using the -pci device with disable-modern=yes, I get "reset by
>   peer".
> - When using the -ccw device with max_revision=0, I get an instant
>   timeout.

Great, thanks for testing!

> 
> Smells like endianness problems (aka weird things are happening).

Yeah.

> 
> Also noticed that vhost-vsock-ccw does not have an immediate problem,
> even with the commit: The code only checks whether the device has been
> forced to legacy, not whether legacy is allowed (which cannot be
> controlled by the user anyway). Probably best to address after we've
> dealt with the vhost-vsock issue and made sure that there are no other
> problems.

Make sense!

> 
> > > >   
> > > > > >     
> > > > > > > - Do nothing, have users force legacy off. Bad idea, as ccw has no way
> > > > > > >   to do that on the command line.
> > > > > > > 
> > > > > > > The first option is probably best.  
> > > 
> > > The first option is now "force modern, but with no backwards
> > > compatibility", which is not that great; but "allow legacy, even though
> > > it should not exist" is not particularly appealing, either... what a
> > > mess :(  
> > 
> > Yeah, it's a mess :-( anyway I still prefer option 1, it seems a little
> > bit more correct to me.
> 
> It seems to me that the status before this was "works by accident, but
> only if we're not negotiating to legacy, or the guest/host are both
> little endian". IOW, no visible breakage for most people (or we'd
> probably have heard of it already). Now we have a setup that's correct,
> but forces users to adapt their QEMU command lines. Option 1 would
> eliminate the need to do that, but would cause possibly
> not-really-fixable migration issues (you can probably deal with that
> manually, detaching and re-attaching the device as a last resort.)
> 
> So, force modern, probably also remove the -transitional device type,
> and put a prominent explanation into the change log?
> 

I completely agree with your analysis and solution.

So, for now we need to patch vhost-vsock-pci and vhost-user-vsock-pci,
and queue the patches in stable.

Do you prefer to send them? Otherwise I can do that.

Thanks again for the help and the test with s390x guest!
Stefano


