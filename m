Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB99C04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 21:04:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE1D42685F
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 21:04:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE1D42685F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40883 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXu7k-0000P8-NK
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 17:04:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hXu6q-0008Sf-Vf
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 17:03:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hXu6p-0004Tn-S9
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 17:03:12 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35451)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hXu6p-0004QB-MK
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 17:03:11 -0400
Received: by mail-qk1-f194.google.com with SMTP id l128so1433573qke.2
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 14:03:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=G37mA9WyvOMHe9AujiBYpDrLVKO6bniCNGvfUxk4/4s=;
	b=mLUZSR8oLPR2LRn4fohwothFU8eUyak//60PuTfmSUEELypw7g8OZuKZCppuEldM0D
	qH5s2FtuG/mLGCcDxfvFLwmY5jQKDtL3U/yxZDLZSBh7SajHmd79v1NJuiquznzkuBG0
	c6CppZ4pPv3WYQM2CKYtQ8CzlARaJxekACgruzEtMNjDESAB+FBroIcuv0zV84WgN5J1
	x2m7SP+/aXLPTYwBZg2X5yGNfefF4ssqoPoph7d5bONdNkIHrCoGsyzpS2TS5vkiUb9h
	vnYrWBrcNPumplOzePBXt2oLG5lyfdmyawHLgm6lK+qX/WPQ2fwMx/vMO/JGTShhmlGo
	Qesw==
X-Gm-Message-State: APjAAAVLWViWAMUYcVhqHqYoxRgNcH7e+yv5qOTNqrzUGUKP50OjtKRh
	t9PVA0njcLihHdwMQHjTlWiYTQ==
X-Google-Smtp-Source: APXvYqxXA4CK6H4ZfWHSf5HWR7l7Wi3EiusQRY8Jij9jJuiltpNSiBmAF9WD3Qj9uF6m3A7H5+1eVA==
X-Received: by 2002:a37:634f:: with SMTP id x76mr23181573qkb.205.1559595790340;
	Mon, 03 Jun 2019 14:03:10 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net.
	[100.0.197.103]) by smtp.gmail.com with ESMTPSA id
	n10sm7075779qke.72.2019.06.03.14.03.08
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Mon, 03 Jun 2019 14:03:09 -0700 (PDT)
Date: Mon, 3 Jun 2019 17:03:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Greg Kurz <groug@kaod.org>
Message-ID: <20190603170137-mutt-send-email-mst@kernel.org>
References: <20190529070955.25565-1-xieyongji@baidu.com>
	<20190529070955.25565-3-xieyongji@baidu.com>
	<20190603221639.5e4ddac1@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603221639.5e4ddac1@bahia.lab.toulouse-stg.fr.ibm.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.222.194
Subject: Re: [Qemu-devel] [PATCH 2/5] virtio: Migrate the "start_on_kick"
 flag
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
Cc: elohimes@gmail.com, Xie Yongji <xieyongji@baidu.com>, dgilbert@redhat.com,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 03, 2019 at 10:16:39PM +0200, Greg Kurz wrote:
> On Wed, 29 May 2019 15:09:52 +0800
> elohimes@gmail.com wrote:
> 
> > From: Xie Yongji <xieyongji@baidu.com>
> > 
> > We should migrate the "start_on_kick" flag so that we
> > would not miss starting device on kicking at startup
> > after migration.
> > 
> 
> Hmm... IIUC "start_on_kick" means "virtio 1.0 transitional device that has
> not been started yet", ie:
> 
> !vdev->started &&
> (virtio_host_has_feature(vdev, VIRTIO_F_VERSION_1) &&
>  !virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1))

Or a legacy device I guess?

> If so, not sure why you need this extra field in the first place, but
> you probably don't need to migrate it. Just recalculate in a post load
> callback.
> 
> > Signed-off-by: Xie Yongji <xieyongji@baidu.com>
> > ---
> >  hw/virtio/virtio.c | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> > 
> > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > index fc8fca81ad..4d4ff67791 100644
> > --- a/hw/virtio/virtio.c
> > +++ b/hw/virtio/virtio.c
> > @@ -1802,6 +1802,13 @@ static bool virtio_started_needed(void *opaque)
> >      return vdev->started;
> >  }
> >  
> > +static bool virtio_start_on_kick_needed(void *opaque)
> > +{
> > +    VirtIODevice *vdev = opaque;
> > +
> > +    return vdev->start_on_kick;
> > +}
> > +
> >  static const VMStateDescription vmstate_virtqueue = {
> >      .name = "virtqueue_state",
> >      .version_id = 1,
> > @@ -1941,6 +1948,17 @@ static const VMStateDescription vmstate_virtio_started = {
> >      }
> >  };
> >  
> > +static const VMStateDescription vmstate_virtio_start_on_kick = {
> > +    .name = "virtio/start_on_kick",
> > +    .version_id = 1,
> > +    .minimum_version_id = 1,
> > +    .needed = &virtio_start_on_kick_needed,
> > +    .fields = (VMStateField[]) {
> > +        VMSTATE_BOOL(start_on_kick, VirtIODevice),
> > +        VMSTATE_END_OF_LIST()
> > +    }
> > +};
> > +
> >  static const VMStateDescription vmstate_virtio = {
> >      .name = "virtio",
> >      .version_id = 1,
> > @@ -1957,6 +1975,7 @@ static const VMStateDescription vmstate_virtio = {
> >          &vmstate_virtio_broken,
> >          &vmstate_virtio_extra_state,
> >          &vmstate_virtio_started,
> > +        &vmstate_virtio_start_on_kick,
> >          NULL
> >      }
> >  };

