Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83BFBC28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 17:48:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F49A25EBA
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 17:48:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F49A25EBA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57308 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWP9p-00041j-OA
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 13:48:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hWP8v-0003i1-0i
	for qemu-devel@nongnu.org; Thu, 30 May 2019 13:47:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hWP8t-0000Ae-R7
	for qemu-devel@nongnu.org; Thu, 30 May 2019 13:47:08 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33285)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hWP8t-00007U-Le
	for qemu-devel@nongnu.org; Thu, 30 May 2019 13:47:07 -0400
Received: by mail-oi1-f194.google.com with SMTP id q186so5647892oia.0
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 10:47:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=AYAekB/SaWzUaKSjTqmZROklJHeygc6KpWtZS8BrK8I=;
	b=UAXhOWmxX+VU4/mgLTJKsK8tGMsr5fws/dpF8DDNkkqlGkM5cVPc+ysuXkF0WstA6M
	FcgQAirzuoy3kCBiGrgV4UJqONpecvR/EPNat4ralqR025acLyy7VswmYXElBARyKUQ1
	ZLubrXje5ZodNpspHUelll6RCJSIDCVwGgxXVFSaRnIej+fs6WNP/Ug215aOz+WhUthe
	LL7zL2F4o0GiTaprlZ0lZF/0buI/7+1dg1srJfcrCnBRFmRKFMe84U04653blYxC9jWa
	FIiBkgCkHSMWpIc/N3aD2ihCDPROrzowRrWL5nSdUhJkgPN7LAA//kfrNAJ5tvVLBapr
	Gm8Q==
X-Gm-Message-State: APjAAAWj8H12JcXT/XdYnL8vYQwEIjuheIflGguSTGN0YtMi74HdncQe
	KxoYJ6GbN1gPf8+MAWp4+Tevdw==
X-Google-Smtp-Source: APXvYqxVaKBLq4TKVym8B6jex0xyDE5K/nPmnKKra0+j189LD1dBqIzvlg2Vuo+aXKAuHIXwEzY6Ow==
X-Received: by 2002:aca:4f8e:: with SMTP id d136mr3135302oib.122.1559238422687;
	Thu, 30 May 2019 10:47:02 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net.
	[100.0.197.103]) by smtp.gmail.com with ESMTPSA id
	l65sm1211965oif.20.2019.05.30.10.47.00
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 30 May 2019 10:47:01 -0700 (PDT)
Date: Thu, 30 May 2019 13:46:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jens Freimann <jfreimann@redhat.com>
Message-ID: <20190530134631-mutt-send-email-mst@kernel.org>
References: <20190517125820.2885-1-jfreimann@redhat.com>
	<20190517125820.2885-4-jfreimann@redhat.com>
	<20190521094504.GB2915@work-vm>
	<20190530145645.tjwkgi4hae5yblsi@jenstp.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530145645.tjwkgi4hae5yblsi@jenstp.localdomain>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.167.194
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
Cc: pkrempa@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
	aadam@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	qemu-devel@nongnu.org, laine@redhat.com, ailan@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 30, 2019 at 04:56:45PM +0200, Jens Freimann wrote:
> Hi David,
> 
> sorry for the  delayed reply.
> 
> On Tue, May 28, 2019 at 11:04:15AM -0400, Michael S. Tsirkin wrote:
> > On Tue, May 21, 2019 at 10:45:05AM +0100, Dr. David Alan Gilbert wrote:
> > > * Jens Freimann (jfreimann@redhat.com) wrote:
> > > > +static void virtio_net_primary_plug_timer(void *opaque);
> > > > +
> > > >  static void virtio_net_set_link_status(NetClientState *nc)
> > > >  {
> > > >      VirtIONet *n = qemu_get_nic_opaque(nc);
> > > > @@ -786,6 +796,14 @@ static void virtio_net_set_features(VirtIODevice *vdev, uint64_t features)
> > > >      } else {
> > > >          memset(n->vlans, 0xff, MAX_VLAN >> 3);
> > > >      }
> > > > +
> > > > +    if (virtio_has_feature(features, VIRTIO_NET_F_STANDBY)) {
> > > > +        atomic_set(&n->primary_should_be_hidden, false);
> > > > +        if (n->primary_device_timer)
> > > > +            timer_mod(n->primary_device_timer,
> > > > +                qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) +
> > > > +                4000);
> > > > +    }
> > > 
> > > What's this magic timer constant and why?
> 
> To be honest it's a leftover from previous versions (before I took
> over) of the patches and I'm not sure why the timer is there.
> I removed it and so far see no reason to keep it.
> 
> > > 
> > > >  }
> > > >
> > > >  static int virtio_net_handle_rx_mode(VirtIONet *n, uint8_t cmd,
> > > > @@ -2626,6 +2644,87 @@ void virtio_net_set_netclient_name(VirtIONet *n, const char *name,
> > > >      n->netclient_type = g_strdup(type);
> > > >  }
> > > >
> > > > +static void virtio_net_primary_plug_timer(void *opaque)
> > > > +{
> > > > +    VirtIONet *n = opaque;
> > > > +    Error *err = NULL;
> > > > +
> > > > +    if (n->primary_device_dict)
> > > > +        n->primary_device_opts = qemu_opts_from_qdict(qemu_find_opts("device"),
> > > > +            n->primary_device_dict, &err);
> > > > +    if (n->primary_device_opts) {
> > > > +        n->primary_dev = qdev_device_add(n->primary_device_opts, &err);
> > > > +        error_setg(&err, "virtio_net: couldn't plug in primary device");
> > > > +        return;
> > > > +    }
> > > > +    if (!n->primary_device_dict && err) {
> > > > +        if (n->primary_device_timer) {
> > > > +            timer_mod(n->primary_device_timer,
> > > > +                qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) +
> > > > +                100);
> > > 
> > > same here.
> 
> see above
> 
> > > 
> > > 
> > > > +        }
> > > > +    }
> > > > +}
> > > > +
> > > > +static void virtio_net_handle_migration_primary(VirtIONet *n,
> > > > +                                                MigrationState *s)
> > > > +{
> > > > +    Error *err = NULL;
> > > > +    bool should_be_hidden = atomic_read(&n->primary_should_be_hidden);
> > > > +
> > > > +    n->primary_dev = qdev_find_recursive(sysbus_get_default(),
> > > > +            n->primary_device_id);
> > > > +    if (!n->primary_dev) {
> > > > +        error_setg(&err, "virtio_net: couldn't find primary device");
> > > 
> > > There's something broken with the error handling in this function - the
> > > 'err' never goes anywhere - I don't think it ever gets printed or
> > > reported or stops the migration.
> 
> yes, I'll fix it.
> 
> > > > +    }
> > > > +    if (migration_in_setup(s) && !should_be_hidden && n->primary_dev) {
> > > > +        qdev_unplug(n->primary_dev, &err);
> > > 
> > > Not knowing unplug well; can you just explain - is that device hard
> > > unplugged and it's gone by the time this function returns or is it still
> > > hanging around for some indeterminate time?
> 
> Qemu will trigger an unplug request via pcie attention button in which case
> there could be a delay by the guest operating system. We could give it some
> amount of time and if nothing happens try surpise removal or handle the
> error otherwise.
> 
> 
> regards,
> Jens

That's a subject for another day. Let's get the basic thing
working.

-- 
MST

