Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_DR,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A27C28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 18:02:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3F0B25EEA
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 18:01:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3F0B25EEA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57461 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWPNG-0000Lz-Jy
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 14:01:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hWPM0-0007xA-5s
	for qemu-devel@nongnu.org; Thu, 30 May 2019 14:00:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hWPLx-0002iK-Am
	for qemu-devel@nongnu.org; Thu, 30 May 2019 14:00:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35162)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hWPLv-0002gB-LV
	for qemu-devel@nongnu.org; Thu, 30 May 2019 14:00:35 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BB426301988B
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 18:00:33 +0000 (UTC)
Received: from work-vm (ovpn-117-91.ams2.redhat.com [10.36.117.91])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B1C5719736;
	Thu, 30 May 2019 18:00:25 +0000 (UTC)
Date: Thu, 30 May 2019 19:00:23 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190530180022.GB2864@work-vm>
References: <20190517125820.2885-1-jfreimann@redhat.com>
	<20190517125820.2885-4-jfreimann@redhat.com>
	<20190521094504.GB2915@work-vm>
	<20190530145645.tjwkgi4hae5yblsi@jenstp.localdomain>
	<20190530134631-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530134631-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Thu, 30 May 2019 18:00:33 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
	aadam@redhat.com, qemu-devel@nongnu.org, laine@redhat.com,
	Jens Freimann <jfreimann@redhat.com>, ailan@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Michael S. Tsirkin (mst@redhat.com) wrote:
> On Thu, May 30, 2019 at 04:56:45PM +0200, Jens Freimann wrote:
> > Hi David,
> > 
> > sorry for the  delayed reply.
> > 
> > On Tue, May 28, 2019 at 11:04:15AM -0400, Michael S. Tsirkin wrote:
> > > On Tue, May 21, 2019 at 10:45:05AM +0100, Dr. David Alan Gilbert wrote:
> > > > * Jens Freimann (jfreimann@redhat.com) wrote:
> > > > > +static void virtio_net_primary_plug_timer(void *opaque);
> > > > > +
> > > > >  static void virtio_net_set_link_status(NetClientState *nc)
> > > > >  {
> > > > >      VirtIONet *n = qemu_get_nic_opaque(nc);
> > > > > @@ -786,6 +796,14 @@ static void virtio_net_set_features(VirtIODevice *vdev, uint64_t features)
> > > > >      } else {
> > > > >          memset(n->vlans, 0xff, MAX_VLAN >> 3);
> > > > >      }
> > > > > +
> > > > > +    if (virtio_has_feature(features, VIRTIO_NET_F_STANDBY)) {
> > > > > +        atomic_set(&n->primary_should_be_hidden, false);
> > > > > +        if (n->primary_device_timer)
> > > > > +            timer_mod(n->primary_device_timer,
> > > > > +                qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) +
> > > > > +                4000);
> > > > > +    }
> > > > 
> > > > What's this magic timer constant and why?
> > 
> > To be honest it's a leftover from previous versions (before I took
> > over) of the patches and I'm not sure why the timer is there.
> > I removed it and so far see no reason to keep it.
> > 
> > > > 
> > > > >  }
> > > > >
> > > > >  static int virtio_net_handle_rx_mode(VirtIONet *n, uint8_t cmd,
> > > > > @@ -2626,6 +2644,87 @@ void virtio_net_set_netclient_name(VirtIONet *n, const char *name,
> > > > >      n->netclient_type = g_strdup(type);
> > > > >  }
> > > > >
> > > > > +static void virtio_net_primary_plug_timer(void *opaque)
> > > > > +{
> > > > > +    VirtIONet *n = opaque;
> > > > > +    Error *err = NULL;
> > > > > +
> > > > > +    if (n->primary_device_dict)
> > > > > +        n->primary_device_opts = qemu_opts_from_qdict(qemu_find_opts("device"),
> > > > > +            n->primary_device_dict, &err);
> > > > > +    if (n->primary_device_opts) {
> > > > > +        n->primary_dev = qdev_device_add(n->primary_device_opts, &err);
> > > > > +        error_setg(&err, "virtio_net: couldn't plug in primary device");
> > > > > +        return;
> > > > > +    }
> > > > > +    if (!n->primary_device_dict && err) {
> > > > > +        if (n->primary_device_timer) {
> > > > > +            timer_mod(n->primary_device_timer,
> > > > > +                qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) +
> > > > > +                100);
> > > > 
> > > > same here.
> > 
> > see above
> > 
> > > > 
> > > > 
> > > > > +        }
> > > > > +    }
> > > > > +}
> > > > > +
> > > > > +static void virtio_net_handle_migration_primary(VirtIONet *n,
> > > > > +                                                MigrationState *s)
> > > > > +{
> > > > > +    Error *err = NULL;
> > > > > +    bool should_be_hidden = atomic_read(&n->primary_should_be_hidden);
> > > > > +
> > > > > +    n->primary_dev = qdev_find_recursive(sysbus_get_default(),
> > > > > +            n->primary_device_id);
> > > > > +    if (!n->primary_dev) {
> > > > > +        error_setg(&err, "virtio_net: couldn't find primary device");
> > > > 
> > > > There's something broken with the error handling in this function - the
> > > > 'err' never goes anywhere - I don't think it ever gets printed or
> > > > reported or stops the migration.
> > 
> > yes, I'll fix it.
> > 
> > > > > +    }
> > > > > +    if (migration_in_setup(s) && !should_be_hidden && n->primary_dev) {
> > > > > +        qdev_unplug(n->primary_dev, &err);
> > > > 
> > > > Not knowing unplug well; can you just explain - is that device hard
> > > > unplugged and it's gone by the time this function returns or is it still
> > > > hanging around for some indeterminate time?
> > 
> > Qemu will trigger an unplug request via pcie attention button in which case
> > there could be a delay by the guest operating system. We could give it some
> > amount of time and if nothing happens try surpise removal or handle the
> > error otherwise.
> > 
> > 
> > regards,
> > Jens
> 
> That's a subject for another day. Let's get the basic thing
> working.

Well no, we need to know this thing isn't going to hang in the migration
setup phase, or if it does how we recover.  This patch series is very
odd precisely because it's trying to do the unplug itself in the
migration phase rather than let the management layer do it - so unless
it's nailed down how to make sure that's really really bullet proof
then we've got to go back and ask the question about whether we should
really fix it so it can be done by the management layer.

Dave

> -- 
> MST
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

