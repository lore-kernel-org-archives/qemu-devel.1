Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB76C28CC3
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 19:37:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 386CE26E6F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 19:37:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 386CE26E6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48210 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWnLa-00006E-CW
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 15:37:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hWnKd-00084K-FA
	for qemu-devel@nongnu.org; Fri, 31 May 2019 15:36:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hWnKc-0000Ip-Ai
	for qemu-devel@nongnu.org; Fri, 31 May 2019 15:36:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35160)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hWnKc-0000HS-2u
	for qemu-devel@nongnu.org; Fri, 31 May 2019 15:36:50 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 451BB3179B67;
	Fri, 31 May 2019 19:36:45 +0000 (UTC)
Received: from localhost (ovpn-120-246.rdu2.redhat.com [10.10.120.246])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 33893D1E4;
	Fri, 31 May 2019 19:36:40 +0000 (UTC)
Date: Fri, 31 May 2019 16:36:33 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Yongji Xie <elohimes@gmail.com>
Message-ID: <20190531193633.GI22103@habkost.net>
References: <20190520231008.20140-1-mst@redhat.com>
	<20190320112646.3712-2-xieyongji@baidu.com>
	<20190524121909.277ae31e@bahia.lan>
	<CAONzpcbf+AcY4yEO6hBnyp1dBaV4XgUrSTdU55B3S+wcn6gOVA@mail.gmail.com>
	<20190527124446.6b809c7f@bahia.lan>
	<20190527145329-mutt-send-email-mst@kernel.org>
	<CAONzpcb6dtsnYhVW+yy0FijXtHoLavXX_bwStVEZC1hqJr9wSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAONzpcb6dtsnYhVW+yy0FijXtHoLavXX_bwStVEZC1hqJr9wSQ@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Fri, 31 May 2019 19:36:49 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL v2 04/36] virtio: Introduce started flag to
 VirtioDevice
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Zhang Yu <zhangyu31@baidu.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Greg Kurz <groug@kaod.org>, qemu-devel <qemu-devel@nongnu.org>,
	Xie Yongji <xieyongji@baidu.com>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 28, 2019 at 10:48:09AM +0800, Yongji Xie wrote:
> On Tue, 28 May 2019 at 02:54, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, May 27, 2019 at 12:44:46PM +0200, Greg Kurz wrote:
> > > On Fri, 24 May 2019 19:56:06 +0800
> > > Yongji Xie <elohimes@gmail.com> wrote:
> > >
> > > > On Fri, 24 May 2019 at 18:20, Greg Kurz <groug@kaod.org> wrote:
> > > > >
> > > > > On Mon, 20 May 2019 19:10:35 -0400
> > > > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > >
> > > > > > From: Xie Yongji <xieyongji@baidu.com>
[...]
> > > > > > @@ -1770,6 +1796,13 @@ static bool virtio_broken_needed(void *opaque)
> > > > > >      return vdev->broken;
> > > > > >  }
> > > > > >
> > > > > > +static bool virtio_started_needed(void *opaque)
> > > > > > +{
> > > > > > +    VirtIODevice *vdev = opaque;
> > > > > > +
> > > > > > +    return vdev->started;
> > > > >
> > > > > Existing machine types don't know about the "virtio/started" subsection. This
> > > > > breaks migration to older QEMUs if the driver has started the device, ie. most
> > > > > probably always when it comes to live migration.
> > > > >
> > > > > My understanding is that we do try to support backward migration though. It
> > > > > is a regular practice in datacenters to migrate workloads without having to
> > > > > take care of the QEMU version. FWIW I had to fix similar issues downstream
> > > > > many times in the past because customers had filed bugs.
> > > > >
> > > >
> > > > If we do need to support backward migration, for this patch, what I
> > > > can think of is to only migrate the flag in the case that guest kicks
> > > > but not set DRIVER_OK. This could fix backward migration in most case.
> > >
> > > You mean something like that ?
> > >
> > > static bool virtio_started_needed(void *opaque)
> > > {
> > >     VirtIODevice *vdev = opaque;
> > >
> > >     return vdev->started && !(vdev->status & VIRTIO_CONFIG_S_DRIVER_OK);
> > > }
> > >
> > > > Not sure if there is a more general approach...
> > > >
> > >
> > > Another approach would be to only implement the started flag for
> > > machine version > 4.0. This can be achieved by adding a "use-started"
> > > property to the base virtio device, true by default and set to
> > > false by hw_compat_4_0.
> >
> > I think this is best frankly.
> >
> 
> Only implement the started flag for machine version > 4.0 might not be
> good because vhost-user-blk now need to use this flag. How about only
> migrating this flag for machine version > 4.0 instead?

Was this implemented?  Is migration from QEMU 4.1 to QEMU 4.0
currently broken?

-- 
Eduardo

