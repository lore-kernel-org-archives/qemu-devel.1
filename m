Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4119C433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 15:20:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CC562065F
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 15:20:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PZCAB173"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CC562065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyzV3-0004aw-Kz
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 11:20:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35222)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jyzTd-0003a4-Dl
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 11:19:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39124
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jyzTa-0004rY-Hj
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 11:19:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595603948;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HdXz8HUO/8AfwWdAyF2bnseuF+JoIWSzIyAKFrriT5o=;
 b=PZCAB173Tf33RGVhGkWkvEEHXFS02OKWemWg14G3aQ5cexcVHstevYPoRWNJ9Lc9rtoseM
 r0n7ELamdBdfei2BqczoaH36epHRMHOpBtgvipv+i3SMsDvEaE83rCmXxJ/rpXOrF1kHy/
 AC+SgAm6nZrNwnSnUVgTRX6HB8tyWYI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-jCYCqYxCMsSg4tKG14QxqQ-1; Fri, 24 Jul 2020 11:18:03 -0400
X-MC-Unique: jCYCqYxCMsSg4tKG14QxqQ-1
Received: by mail-wr1-f69.google.com with SMTP id v4so2260048wrb.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2020 08:18:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=HdXz8HUO/8AfwWdAyF2bnseuF+JoIWSzIyAKFrriT5o=;
 b=d0vZMxu3WDj1Dgi7PMrGOvygRVfpOzzlSmWRLR+Eb7guGLj5khZ/8FJBHJuuVdApso
 7EtZBFcx8qkgjZE+Qo1wEMHCFnb0GIcM8wIZcvVf6hBn2RcYqNqfXlWDXWHhSBZx3zln
 /mnGS/ri9K7Tsr6GrgaiUBwMKxs0jUvUdPSapS27aBhP/FyxsbWYW2cPWe1zuLjZe7o8
 9QhF2g+Kedl3io1ISMe/vtkvL1pkxkVoK+4r9vA9ZG3vZQyTFKipvg3VI0AYa5uQUrEm
 azBQPiu14vADOCoDs3SOHMwx+HO20dbX7VDaAVmjFZZHdgpECQZ+zeQJLks73mfnzOft
 deFA==
X-Gm-Message-State: AOAM532pmf9eCACHsZ4D+64Fv+hFbcYKyyFXuwLBG09AVcJtwyoDdgDh
 v80iYnMODWW7vVb6zaLeLe0mKGYRiOhG6sKgvUxqTSGU1YXlEFZrx+E05yNgY03jSHq8ic68yX0
 8Ka9ftzdq3VwbE4s=
X-Received: by 2002:a7b:c2f7:: with SMTP id e23mr9052321wmk.175.1595603881738; 
 Fri, 24 Jul 2020 08:18:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzyK7DtyFywHIbL+OT6I8ZokPdmmpzpTwQh0EJz3j1uusJD/yqYvKgRH156pvwjIJmWqTkjYQ==
X-Received: by 2002:a7b:c2f7:: with SMTP id e23mr9052297wmk.175.1595603881339; 
 Fri, 24 Jul 2020 08:18:01 -0700 (PDT)
Received: from redhat.com (bzq-79-179-105-63.red.bezeqint.net. [79.179.105.63])
 by smtp.gmail.com with ESMTPSA id n189sm7724129wmf.38.2020.07.24.08.17.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2020 08:18:00 -0700 (PDT)
Date: Fri, 24 Jul 2020 11:17:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [BUG] vhost-vdpa: qemu-system-s390x crashes with second
 virtio-net-ccw device
Message-ID: <20200724111512-mutt-send-email-mst@kernel.org>
References: <20200724152718.4e1cbc9e.cohuck@redhat.com>
 <20200724092906-mutt-send-email-mst@kernel.org>
 <20200724165627.70c6dfd6.cohuck@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200724165627.70c6dfd6.cohuck@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 08:55:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-s390x@nongnu.org, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, Cindy Lu <lulu@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 24, 2020 at 04:56:27PM +0200, Cornelia Huck wrote:
> On Fri, 24 Jul 2020 09:30:58 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Fri, Jul 24, 2020 at 03:27:18PM +0200, Cornelia Huck wrote:
> > > When I start qemu with a second virtio-net-ccw device (i.e. adding
> > > -device virtio-net-ccw in addition to the autogenerated device), I get
> > > a segfault. gdb points to
> > > 
> > > #0  0x000055d6ab52681d in virtio_net_get_config (vdev=<optimized out>, 
> > >     config=0x55d6ad9e3f80 "RT") at /home/cohuck/git/qemu/hw/net/virtio-net.c:146
> > > 146	    if (nc->peer->info->type == NET_CLIENT_DRIVER_VHOST_VDPA) {
> > > 
> > > (backtrace doesn't go further)
> 
> The core was incomplete, but running under gdb directly shows that it
> is just a bog-standard config space access (first for that device).
> 
> The cause of the crash is that nc->peer is not set... no idea how that
> can happen, not that familiar with that part of QEMU. (Should the code
> check, or is that really something that should not happen?)
> 
> What I don't understand is why it is set correctly for the first,
> autogenerated virtio-net-ccw device, but not for the second one, and
> why virtio-net-pci doesn't show these problems. The only difference
> between -ccw and -pci that comes to my mind here is that config space
> accesses for ccw are done via an asynchronous operation, so timing
> might be different.

Hopefully Jason has an idea. Could you post a full command line
please? Do you need a working guest to trigger this? Does this trigger
on an x86 host?

> > > 
> > > Starting qemu with no additional "-device virtio-net-ccw" (i.e., only
> > > the autogenerated virtio-net-ccw device is present) works. Specifying
> > > several "-device virtio-net-pci" works as well.
> > > 
> > > Things break with 1e0a84ea49b6 ("vhost-vdpa: introduce vhost-vdpa net
> > > client"), 38140cc4d971 ("vhost_net: introduce set_config & get_config")
> > > works (in-between state does not compile).  
> > 
> > Ouch. I didn't test all in-between states :(
> > But I wish we had a 0-day instrastructure like kernel has,
> > that catches things like that.
> 
> Yep, that would be useful... so patchew only builds the complete series?
> 
> > 
> > > This is reproducible with tcg as well. Same problem both with
> > > --enable-vhost-vdpa and --disable-vhost-vdpa.
> > > 
> > > Have not yet tried to figure out what might be special with
> > > virtio-ccw... anyone have an idea?
> > > 
> > > [This should probably be considered a blocker?]  
> 
> I think so, as it makes s390x unusable with more that one
> virtio-net-ccw device, and I don't even see a workaround.


