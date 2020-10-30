Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA0AC00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 09:09:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 872FF206DB
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 09:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tj5rtqly"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 872FF206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYQPh-0002P4-Ck
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 05:09:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55992)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1kYQP1-0001rv-0e
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 05:08:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55678)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1kYQOz-00062w-EY
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 05:08:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604048931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GM/V4oNzalO8Ogxmua/ft0yr4jeUSIteBuxw9Eqm5c4=;
 b=Tj5rtqlyzkFPt1hXWZ89jvOP9C3LF2TiLZsVrgGI/mvCMESJ1wrli3rJPxJ3tkhSJrTtov
 7+KfirkZ0CI6wJ+r/cNWDj8TZJAZEaTdLSuTFZotW7i03nW8o5cB+7P/J+uwPMFw2nqdPF
 3wsInmgAFTOQF8CzXzsPgBMlV7YMd2Q=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-CQaC34A2Mbe6t8D33OhAZA-1; Fri, 30 Oct 2020 05:08:49 -0400
X-MC-Unique: CQaC34A2Mbe6t8D33OhAZA-1
Received: by mail-pg1-f200.google.com with SMTP id e16so4212255pgm.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 02:08:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GM/V4oNzalO8Ogxmua/ft0yr4jeUSIteBuxw9Eqm5c4=;
 b=ZF7It2beP3DUX2q5WLcf0IxQN7dAFkO8UcB5HBg84CyygZV8oLCSoxnJAwg8tiYxW1
 eiJgpsP9AxnEDjxlbcHNb18sXtcg7HhA3U1i/lIWlhUFJuUwGfD2uif6t6po0sOG0L/7
 uf5rh2GNqYmj7cGk9/i7Lrkxi84tYILmlsCo/lPnztfUlUlwSP+iVlEPJc5Zm1rxVSCY
 8kQ5oNqnI67+tRGLgef0n+6XgX5fy2uEa/FiRs3MasvvapJhK8Ykzj8hr48WQ8nfVwkk
 +wsieYxWDdL53CmBaEbJhelLr7tqn0oar/4b1557XJqQ6iX48Ie4NEeQ/X3lfBpvKJjY
 NwxQ==
X-Gm-Message-State: AOAM5318+tnZVcIL+HEMgst45elgINxQP278v2BEKsgIiZ+oIsxvURlj
 if6bSkBCTRCVUl6DqSgvzDD0BjjA1wvMjNtGQ+0kYsput51JWWVktPTEHG2jybBmqFpMjK9vyxI
 0eu298wqDgDfks8MeNefFL8Pe1RklUGU=
X-Received: by 2002:a63:d54e:: with SMTP id v14mr1366712pgi.203.1604048928704; 
 Fri, 30 Oct 2020 02:08:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw5mWRJoyceGPovbycdYS9qGhDXPpfJqnSVLgDdTdPv/g8spNCXjKDrodiAx+nyAUjd+7vAFK9d3dF4RAUZ5b8=
X-Received: by 2002:a63:d54e:: with SMTP id v14mr1366683pgi.203.1604048928169; 
 Fri, 30 Oct 2020 02:08:48 -0700 (PDT)
MIME-Version: 1.0
References: <20201026062126.25255-1-lulu@redhat.com>
 <20201030045421-mutt-send-email-mst@kernel.org>
In-Reply-To: <20201030045421-mutt-send-email-mst@kernel.org>
From: Cindy Lu <lulu@redhat.com>
Date: Fri, 30 Oct 2020 17:08:37 +0800
Message-ID: <CACLfguX5PxEeNbchUMg12igj2twWqFxPywHv99G6LvL9ggA3GQ@mail.gmail.com>
Subject: Re: [PATCH v3] virtio-net: Add check for mac address while peer is
 vdpa
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lulu@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 01:22:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 30, 2020 at 4:55 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Oct 26, 2020 at 02:21:26PM +0800, Cindy Lu wrote:
> > Sometime vdpa get an all 0 mac address from the hardware, this will cause the traffic down
> > So we add the check for this part.
> > if we get an 0 mac address we will use the default mac address instead
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
>
> I wonder whether we can retrieve the mac earlier and fail init.
> That would be better than second-guessing bad configs ...
>
Sure, Thanks Michael and Jason, I will check this with NIC vendor
Thanks
Cindy

> > ---
> >  hw/net/virtio-net.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > index 9179013ac4..65a3a84573 100644
> > --- a/hw/net/virtio-net.c
> > +++ b/hw/net/virtio-net.c
> > @@ -126,6 +126,7 @@ static void virtio_net_get_config(VirtIODevice *vdev, uint8_t *config)
> >      VirtIONet *n = VIRTIO_NET(vdev);
> >      struct virtio_net_config netcfg;
> >      NetClientState *nc = qemu_get_queue(n->nic);
> > +    static const MACAddr zero = { .a = { 0, 0, 0, 0, 0, 0 } };
> >
> >      int ret = 0;
> >      memset(&netcfg, 0 , sizeof(struct virtio_net_config));
> > @@ -151,7 +152,11 @@ static void virtio_net_get_config(VirtIODevice *vdev, uint8_t *config)
> >          ret = vhost_net_get_config(get_vhost_net(nc->peer), (uint8_t *)&netcfg,
> >                                     n->config_size);
> >          if (ret != -1) {
> > -            memcpy(config, &netcfg, n->config_size);
> > +            if (memcmp(&netcfg.mac, &zero, sizeof(zero)) != 0) {
> > +                memcpy(config, &netcfg, n->config_size);
> > +            } else {
> > +                info_report("Get an all zero mac address from hardware");
> > +            }
> >          }
> >      }
> >  }
> > --
> > 2.21.3
>


