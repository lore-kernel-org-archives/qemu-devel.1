Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C16CA9EAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 22:43:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1E4620862
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 22:43:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1E4620862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPaCl-0006W3-1B
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 18:43:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55963)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iPaBp-0005jz-HW
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 18:42:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iPaBi-0006PD-Lk
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 18:42:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45144)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iPaBi-0006Lj-DR
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 18:42:06 -0400
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A5B0759451
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 22:42:04 +0000 (UTC)
Received: by mail-qt1-f197.google.com with SMTP id n34so470385qta.12
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 15:42:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=b2nesOLD+004NlXxV8mrTgiVywLkpbC7X1sXYdkYl5A=;
 b=nvWKcyHu9NoG6Cmc/DdhGq+vCw5OE8CXAiXTXnJa1Mve6KjsF4XE6sZkTHdlEI1HGC
 D2tgEAJsNKA3vAWlRZB/bf+eDtFVG225dcCtIIIqviyHhub9KYWoceRc/YC4P+Zz03ZL
 ueBo8AwZBCRaYpJq7+98GOjJEFxxUiTaXWWJgNggG1vjsHJYqcipj7b42HSXcOwo72d7
 EpmVUOh8gWXlFsi9NvLKMYuztpDEo5Ldj5Vpjj6QkxxIngFoYUl5DIY8dsfvqZcl8Tfx
 RJadi3Cn6rDSvbzhh3Q6TLKp64S4Ydzm0vuCvC64aMjcKEPkvX0JMvGXj+6wRkzlj1fW
 ol9g==
X-Gm-Message-State: APjAAAVypmKt+aLnsDR5J1MFxK4DxvWrBa9jMWJsyqftp59z9jgL+6p1
 81qvi6bbKLUmLk3s4tQkw7giL8pIc7bVBY0o732EvuvTJUd+GGEaCgVVh/6JhJ/HVlf8fNjRIHt
 jPZlD8zFzPUwIkAU=
X-Received: by 2002:a05:620a:210f:: with SMTP id
 l15mr7563957qkl.271.1572388923921; 
 Tue, 29 Oct 2019 15:42:03 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzHg/ywbDOM1u0Gwr0GuASTBxPgmLebdvihT4ArTo2hbzxdqJIYUvV7myU+OxRcN2itAC7LVw==
X-Received: by 2002:a05:620a:210f:: with SMTP id
 l15mr7563934qkl.271.1572388923577; 
 Tue, 29 Oct 2019 15:42:03 -0700 (PDT)
Received: from redhat.com (94.222.26.109.rev.sfr.net. [109.26.222.94])
 by smtp.gmail.com with ESMTPSA id x39sm88128qth.92.2019.10.29.15.42.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2019 15:42:02 -0700 (PDT)
Date: Tue, 29 Oct 2019 18:41:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jens Freimann <jfreimann@redhat.com>
Subject: Re: [PATCH v6 06/11] qapi: add failover negotiated event
Message-ID: <20191029184036-mutt-send-email-mst@kernel.org>
References: <20191025121930.6855-1-jfreimann@redhat.com>
 <20191025121930.6855-7-jfreimann@redhat.com>
 <87wocsrkfp.fsf@dusky.pond.sub.org>
 <20191025173921.n6rk24uxnhuibgrc@jenstp.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025173921.n6rk24uxnhuibgrc@jenstp.localdomain>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: pkrempa@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 aadam@redhat.com, jasowang@redhat.com, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, alex.williamson@redhat.com, laine@redhat.com,
 ailan@redhat.com, dgilbert@redhat.com, parav@mellanox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 25, 2019 at 07:39:21PM +0200, Jens Freimann wrote:
> On Fri, Oct 25, 2019 at 04:03:54PM +0200, Markus Armbruster wrote:
> > Bear with me, I know next to nothing about failover.
> > 
> > Jens Freimann <jfreimann@redhat.com> writes:
> > 
> > > This event is sent to let libvirt know that VIRTIO_NET_F_STANDBY feature
> > > was enabled. The primary device this virtio-net device is associated
> > > with, will now be hotplugged via qdev_device_add().
> > 
> > Passive voice deftly avoids telling the reader who will do the
> > hot-plugging.  Intentional?
> 
> Not really, it's in the comment to the event. The hotplug will be
> done by the virtio-net device code that activates the feature, in
> virtio_net_set_features().
> 
> > 
> > > Signed-off-by: Jens Freimann <jfreimann@redhat.com>
> > > Acked-by: Cornelia Huck <cohuck@redhat.com>
> > > ---
> > >  qapi/net.json | 19 +++++++++++++++++++
> > >  1 file changed, 19 insertions(+)
> > > 
> > > diff --git a/qapi/net.json b/qapi/net.json
> > > index 728990f4fb..ea6eeee4f7 100644
> > > --- a/qapi/net.json
> > > +++ b/qapi/net.json
> > > @@ -737,3 +737,22 @@
> > >  ##
> > >  { 'command': 'announce-self', 'boxed': true,
> > >    'data' : 'AnnounceParameters'}
> > > +
> > > +##
> > > +# @FAILOVER_NEGOTIATED:
> > > +#
> > > +# Emitted when VIRTIO_NET_F_STANDBY was enabled during feature negotiation.
> > > +# Failover primary devices which were hidden (not hotplugged when requested)
> > > +# before will now be hotplugged by the virtio-net standby device.
> > > +#
> > > +# device-id: QEMU device id of the unplugged device
> > 
> > @device-id is new since v5.
> > 
> > A quick skim of
> > https://www.kernel.org/doc/html/latest/networking/net_failover.html
> > tells me there are three devices involved: master, primary slave,
> > standby slave.  Which one is @device-id?  Or am I confused?
> 
> Yes, the device-id is new and it's the device-id of the standby (i.e.
> virtio-net) device.
> 
> regards,
> Jens

And now I am confused.
How is standby "the unplugged device"?
Why not just say "the standby device"?

-- 
MST

