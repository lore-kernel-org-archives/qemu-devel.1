Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9070FC04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 20:44:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B72226EFB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 20:44:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B72226EFB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48909 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWoOM-0003WN-PV
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 16:44:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hWoNa-0003D0-H7
	for qemu-devel@nongnu.org; Fri, 31 May 2019 16:43:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hWoNY-0006BN-NQ
	for qemu-devel@nongnu.org; Fri, 31 May 2019 16:43:58 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44375)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hWoNY-00063V-Ib
	for qemu-devel@nongnu.org; Fri, 31 May 2019 16:43:56 -0400
Received: by mail-qt1-f194.google.com with SMTP id x47so2510116qtk.11
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 13:43:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=I3VJTDC49V6uejUJqoYHVZdxU4fFHfuG0sZxJ/9TqrU=;
	b=pZR0icebz/akrAKY895dr/Dz3PEuSZOlqL7sTubVobH3yNKj/DJZBBgehs5F7VNQ5u
	D0YQTItwEcqI5h53i/8bKw/ozpZbie4u7rPN3rvtVQPfYZdsKtiz++uBXqIzf8Fbz15l
	zdv8OvBu6894Ge7Thsd+OtXBqNULPMrGEX/uUrhL/E/WdTDMSiVDII3wp5vrYORynGFk
	32aeOQdCG8nOWw6ceQrq46Wnf6kJToTgrPpRAU/AYY1gntNE1I85/j9E1w41QH1fp/1K
	5iICUp63rz5YTC1USe3zqnuXPEqlzJOz1kuylFXUHeSyKkfxgBGX5ybWUHAIXJHxDx7w
	mKUg==
X-Gm-Message-State: APjAAAWwBdth99hMdqtF9NYaiJeuLiaJfiZZv32A722A30RpxAT1z0Ug
	Lf8/7429bvmdL1J5olJ6GpejmA==
X-Google-Smtp-Source: APXvYqzvrbULZzJqDCFcFTMBMcdt5BH5LNOzfbMhAqokDgKDXY/5eqpNM8MAb4+6VNv4zVYY9ATqHw==
X-Received: by 2002:a0c:ba20:: with SMTP id w32mr10549150qvf.152.1559335428221;
	Fri, 31 May 2019 13:43:48 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net.
	[100.0.197.103])
	by smtp.gmail.com with ESMTPSA id c9sm5507301qtc.39.2019.05.31.13.43.45
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Fri, 31 May 2019 13:43:46 -0700 (PDT)
Date: Fri, 31 May 2019 16:43:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190531164209-mutt-send-email-mst@kernel.org>
References: <20190521094504.GB2915@work-vm>
	<20190530145645.tjwkgi4hae5yblsi@jenstp.localdomain>
	<20190530134631-mutt-send-email-mst@kernel.org>
	<20190530180022.GB2864@work-vm>
	<20190530140419-mutt-send-email-mst@kernel.org>
	<20190530182210.GA22103@habkost.net>
	<20190530190322-mutt-send-email-mst@kernel.org>
	<20190531170154.GB22103@habkost.net>
	<20190531135059-mutt-send-email-mst@kernel.org>
	<20190531184512.GN3169@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531184512.GN3169@work-vm>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.194
Subject: Re: [Qemu-devel] [PATCH 3/4] net/virtio: add failover support
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: pkrempa@redhat.com, berrange@redhat.com,
	Eduardo Habkost <ehabkost@redhat.com>, aadam@redhat.com,
	qemu-devel@nongnu.org, laine@redhat.com, jdenemar@redhat.com,
	Jens Freimann <jfreimann@redhat.com>, ailan@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 31, 2019 at 07:45:13PM +0100, Dr. David Alan Gilbert wrote:
> * Michael S. Tsirkin (mst@redhat.com) wrote:
> > On Fri, May 31, 2019 at 02:01:54PM -0300, Eduardo Habkost wrote:
> > > > Yes. It's just lots of extremely low level interfaces
> > > > and all rather pointless.
> > > > 
> > > > And down the road extensions like surprise removal support will make it
> > > > all cleaner and more transparent. Floating things up to libvirt means
> > > > all these low level details will require more and more hacks.
> > > 
> > > Why do you call it pointless?
> > 
> > We'd need APIs to manipulate device visibility to guest, hotplug
> > controller state and separately manipulate the resources allocated. This
> > is low level stuff that users really have no idea what to do about.
> > Exposing such a level of detail to management is imho pointless.
> > We are better off with a high level API, see below.
> 
> so I don't know much about vfio; but to me it strikes me that
> you wouldn't need that low level detail if we just reworked vfio
> to look more like all our other devices; something like:
> 
>   -vfiodev  host=02:00.0,id=gpu
>   -device vfio-pci,dev=gpu
> 
> The 'vfiodev' would own the resources; so to do this trick, the
> management layer would:
>    hotunplug the vfio-pci
>    migrate
> 
> if anything went wrong it would
>    hotplug the vfio-pci backin
> 
> you wouldn't have free'd up any resources because they belonged
> to the vfiodev.


IIUC that doesn't really work with passthrough
unless guests support surprise removal.


> > > If we want this to work before
> > > surprise removal is implemented, we need to provide an API that
> > > works for management software.
> > >  Don't we want to make this work
> > > without surprise removal too?
> > 
> > This patchset adds an optional, off by default support for
> > migrating guests with an assigned network device.
> > If enabled this requires guest to allow migration.
> > 
> > Of course this can be viewed as a security problem since it allows guest
> > to block migration. We can't detect a malicious guest reliably imho.
> > What we can do is report to management when guest allows migration.
> > Policy such what to do when this does not happen for a while and
> > what timeout to set would be up to management.
> > 
> > The API in question would be a high level one, something
> > along the lines of a single "guest allowed migration" event.
> 
> This is all fairly normal problems with hot unplugging - that's
> already dealt with at higher levels for normal hot unplugging.
> 
> The question here is to try to avoid duplicating that fairly
> painful process in qemu.
> 
> Dave
> > 
> > -- 
> > MST
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

