Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F069C28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 23:07:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27CC0246CC
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 23:07:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27CC0246CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60163 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWU8r-00026U-7y
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 19:07:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hWU82-0001af-6R
	for qemu-devel@nongnu.org; Thu, 30 May 2019 19:06:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hWU80-0000Pl-PY
	for qemu-devel@nongnu.org; Thu, 30 May 2019 19:06:34 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43192)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hWU80-0000PM-KV
	for qemu-devel@nongnu.org; Thu, 30 May 2019 19:06:32 -0400
Received: by mail-qk1-f195.google.com with SMTP id m14so5059045qka.10
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 16:06:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=JXYckEVZFc2X4Cr2di0V7uOzexpqXLkh6u+eZgRPQ5Y=;
	b=hhyecFxD+6G78T9aVFj2WdprP1xVr2CNVZ1gjGA4lnvI9CrnhfteA+14xDZ8YxY+hu
	JsKh0/REpPIgXuRaZ55fKiGYDK9gDLch3siZeQg1/d0exoAviGX6OZ2MyfQFL+L2Z3Ip
	8wqxzEvXAY1CDfsF9GfWVjSTCipY+n/wJl9ujhNMViNB7Se2kauNbkgvdmbt8/dpceAx
	wRmbMnFb/cDhJ3Yx+V1h9cRC8+ghK28DBnfmHmPBJIv7hrM9Tsw6ByftlA4NtltVM1hX
	qbSAIZxFe/v41qafTw4f1Qy9aYzQmJ3rN4mxj5lx6W8tt2/+cjJjxUI8GrExdD+65i1c
	vGNw==
X-Gm-Message-State: APjAAAVvM5E9+84zH6BulK6hyhoqnyNtf5BNv97Si7IlCPKsWlDkDD28
	7y9SCHx1uJ/uNDT7mteCOi6gCQ==
X-Google-Smtp-Source: APXvYqwDT1K7M+jYCtuaOaTFjkVwcQT/szQHZqU+ssCwuhO6gz4d7K14pSHFyB0jV3rPnBZBjQnf7A==
X-Received: by 2002:a37:4e92:: with SMTP id c140mr5720353qkb.48.1559257592055; 
	Thu, 30 May 2019 16:06:32 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net.
	[100.0.197.103]) by smtp.gmail.com with ESMTPSA id
	q24sm3192386qtq.58.2019.05.30.16.06.30
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 30 May 2019 16:06:31 -0700 (PDT)
Date: Thu, 30 May 2019 19:06:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190530190322-mutt-send-email-mst@kernel.org>
References: <20190517125820.2885-1-jfreimann@redhat.com>
	<20190517125820.2885-4-jfreimann@redhat.com>
	<20190521094504.GB2915@work-vm>
	<20190530145645.tjwkgi4hae5yblsi@jenstp.localdomain>
	<20190530134631-mutt-send-email-mst@kernel.org>
	<20190530180022.GB2864@work-vm>
	<20190530140419-mutt-send-email-mst@kernel.org>
	<20190530182210.GA22103@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530182210.GA22103@habkost.net>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.222.195
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
Cc: pkrempa@redhat.com, berrange@redhat.com, aadam@redhat.com,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	qemu-devel@nongnu.org, laine@redhat.com,
	Jens Freimann <jfreimann@redhat.com>, ailan@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 30, 2019 at 03:22:10PM -0300, Eduardo Habkost wrote:
> On Thu, May 30, 2019 at 02:09:42PM -0400, Michael S. Tsirkin wrote:
> > On Thu, May 30, 2019 at 07:00:23PM +0100, Dr. David Alan Gilbert wrote:
> > > * Michael S. Tsirkin (mst@redhat.com) wrote:
> > > > On Thu, May 30, 2019 at 04:56:45PM +0200, Jens Freimann wrote:
> > > > > Hi David,
> > > > > 
> > > > > sorry for the  delayed reply.
> > > > > 
> > > > > On Tue, May 28, 2019 at 11:04:15AM -0400, Michael S. Tsirkin wrote:
> > > > > > On Tue, May 21, 2019 at 10:45:05AM +0100, Dr. David Alan Gilbert wrote:
> > > > > > > * Jens Freimann (jfreimann@redhat.com) wrote:
> > > > > > > > +static void virtio_net_primary_plug_timer(void *opaque);
> > > > > > > > +
> > > > > > > >  static void virtio_net_set_link_status(NetClientState *nc)
> > > > > > > >  {
> > > > > > > >      VirtIONet *n = qemu_get_nic_opaque(nc);
> > > > > > > > @@ -786,6 +796,14 @@ static void virtio_net_set_features(VirtIODevice *vdev, uint64_t features)
> > > > > > > >      } else {
> > > > > > > >          memset(n->vlans, 0xff, MAX_VLAN >> 3);
> > > > > > > >      }
> > > > > > > > +
> > > > > > > > +    if (virtio_has_feature(features, VIRTIO_NET_F_STANDBY)) {
> > > > > > > > +        atomic_set(&n->primary_should_be_hidden, false);
> > > > > > > > +        if (n->primary_device_timer)
> > > > > > > > +            timer_mod(n->primary_device_timer,
> > > > > > > > +                qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) +
> > > > > > > > +                4000);
> > > > > > > > +    }
> > > > > > > 
> > > > > > > What's this magic timer constant and why?
> > > > > 
> > > > > To be honest it's a leftover from previous versions (before I took
> > > > > over) of the patches and I'm not sure why the timer is there.
> > > > > I removed it and so far see no reason to keep it.
> > > > > 
> > > > > > > 
> > > > > > > >  }
> > > > > > > >
> > > > > > > >  static int virtio_net_handle_rx_mode(VirtIONet *n, uint8_t cmd,
> > > > > > > > @@ -2626,6 +2644,87 @@ void virtio_net_set_netclient_name(VirtIONet *n, const char *name,
> > > > > > > >      n->netclient_type = g_strdup(type);
> > > > > > > >  }
> > > > > > > >
> > > > > > > > +static void virtio_net_primary_plug_timer(void *opaque)
> > > > > > > > +{
> > > > > > > > +    VirtIONet *n = opaque;
> > > > > > > > +    Error *err = NULL;
> > > > > > > > +
> > > > > > > > +    if (n->primary_device_dict)
> > > > > > > > +        n->primary_device_opts = qemu_opts_from_qdict(qemu_find_opts("device"),
> > > > > > > > +            n->primary_device_dict, &err);
> > > > > > > > +    if (n->primary_device_opts) {
> > > > > > > > +        n->primary_dev = qdev_device_add(n->primary_device_opts, &err);
> > > > > > > > +        error_setg(&err, "virtio_net: couldn't plug in primary device");
> > > > > > > > +        return;
> > > > > > > > +    }
> > > > > > > > +    if (!n->primary_device_dict && err) {
> > > > > > > > +        if (n->primary_device_timer) {
> > > > > > > > +            timer_mod(n->primary_device_timer,
> > > > > > > > +                qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) +
> > > > > > > > +                100);
> > > > > > > 
> > > > > > > same here.
> > > > > 
> > > > > see above
> > > > > 
> > > > > > > 
> > > > > > > 
> > > > > > > > +        }
> > > > > > > > +    }
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +static void virtio_net_handle_migration_primary(VirtIONet *n,
> > > > > > > > +                                                MigrationState *s)
> > > > > > > > +{
> > > > > > > > +    Error *err = NULL;
> > > > > > > > +    bool should_be_hidden = atomic_read(&n->primary_should_be_hidden);
> > > > > > > > +
> > > > > > > > +    n->primary_dev = qdev_find_recursive(sysbus_get_default(),
> > > > > > > > +            n->primary_device_id);
> > > > > > > > +    if (!n->primary_dev) {
> > > > > > > > +        error_setg(&err, "virtio_net: couldn't find primary device");
> > > > > > > 
> > > > > > > There's something broken with the error handling in this function - the
> > > > > > > 'err' never goes anywhere - I don't think it ever gets printed or
> > > > > > > reported or stops the migration.
> > > > > 
> > > > > yes, I'll fix it.
> > > > > 
> > > > > > > > +    }
> > > > > > > > +    if (migration_in_setup(s) && !should_be_hidden && n->primary_dev) {
> > > > > > > > +        qdev_unplug(n->primary_dev, &err);
> > > > > > > 
> > > > > > > Not knowing unplug well; can you just explain - is that device hard
> > > > > > > unplugged and it's gone by the time this function returns or is it still
> > > > > > > hanging around for some indeterminate time?
> > > > > 
> > > > > Qemu will trigger an unplug request via pcie attention button in which case
> > > > > there could be a delay by the guest operating system. We could give it some
> > > > > amount of time and if nothing happens try surpise removal or handle the
> > > > > error otherwise.
> > > > > 
> > > > > 
> > > > > regards,
> > > > > Jens
> > > > 
> > > > That's a subject for another day. Let's get the basic thing
> > > > working.
> > > 
> > > Well no, we need to know this thing isn't going to hang in the migration
> > > setup phase, or if it does how we recover.
> > 
> > 
> > This thing is *supposed* to be stuck in migration startup phase
> > if guest is malicious.
> > 
> > If migration does not progress management needs
> > a way to detect this and cancel.
> > 
> > Some more documentation about how this is supposed to happen
> > would be helpful.
> 
> Do we have confirmation from libvirt developers that this would
> be a reasonable API for them?
> 
> 
> > >  This patch series is very
> > > odd precisely because it's trying to do the unplug itself in the
> > > migration phase rather than let the management layer do it - so unless
> > > it's nailed down how to make sure that's really really bullet proof
> > > then we've got to go back and ask the question about whether we should
> > > really fix it so it can be done by the management layer.
> > > 
> > > Dave
> > 
> > management already said they can't because files get closed and
> > resources freed on unplug and so they might not be able to re-add device
> > on migration failure. We do it in migration because that is
> > where failures can happen and we can recover.
> 
> We are capable of providing an API to libvirt where files won't
> get closed when a device is unplugged, if necessary.
> 
> This might become necessary if libvirt or management software
> developers tell us the interface we are providing is not going to
> work for them.
> 
> -- 
> Eduardo

Yes. It's just lots of extremely low level interfaces
and all rather pointless.

And down the road extensions like surprise removal support will make it
all cleaner and more transparent. Floating things up to libvirt means
all these low level details will require more and more hacks.

-- 
MST

