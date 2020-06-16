Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD74C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 12:21:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8281A21475
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 12:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rw29xS6y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8281A21475
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlAbD-0004dy-Ol
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 08:21:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53712)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jlAad-0004AA-9J
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 08:21:19 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30508
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jlAaa-0003N8-Mm
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 08:21:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592310074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LD7/AT3rHe13OpUmiiIAWVEt6bG1RuW612JueMVIk58=;
 b=Rw29xS6yg2TEbUpLXl6dOjpDJzDSx8GXpcLNxEnKmy2YSVqvvLkAr7rcFd8OawgSIw77pf
 LIl08WtYqlSTFlerKVnO2AqDuYDjbh0WCTEnin25wi3LLZLR3BkRZQ+ovpuwtOQLKtytHQ
 sVGgWwmnp0gxo2Fo6OEGqGMs/uUALto=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-DR5erkgvM6qepaw1nMiFNA-1; Tue, 16 Jun 2020 08:21:13 -0400
X-MC-Unique: DR5erkgvM6qepaw1nMiFNA-1
Received: by mail-pg1-f200.google.com with SMTP id 72so729306pgb.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 05:21:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LD7/AT3rHe13OpUmiiIAWVEt6bG1RuW612JueMVIk58=;
 b=mXWvntPFAtVGkuheK/aER1ZWQTWiAwkTpNOzuBF9lbitaUFDGesGp9AzVpuqA4hQwW
 bMVUrJI+X5e5k6QTQ3agXPoWk5Gc7jMPcj2iyGFo6U7syuyrtBqdxQWx0EWG/B/n3TjF
 6EEWn6K+FaUVQ+Z1qq9l4gz+ih4H2N6JJRSWI9yHNW0+G1cY+/p8M1sfs4M9tJzIv36v
 kJzdzmoRra1eTJ236WHPAN8R0FyCYSNFDyJu/eq1WfSXun1NubBlUiWaBuQfXLbgfiIt
 fE7rFmkj5w7BXjD4wo/tQSQtn3mcofQCA486YvhnU/UILCfS74DP1p8hIfX8j99rU9dH
 iFPg==
X-Gm-Message-State: AOAM530yUjasoLN9zxQW8cl2zZUxK0QOsbv22DF08B+mmIGnXfMT40+8
 JNuuoR5eVi6dLgTwWLTVdbNwcRO4bny4jg5SuTBx4W8lEoTDDafjHbRr2QH1LYPmLTzpvY6A8jz
 e40l0evZumATiGXGEovzc9ZBbJsbKJDc=
X-Received: by 2002:a17:90a:1aaa:: with SMTP id
 p39mr2592460pjp.127.1592310072176; 
 Tue, 16 Jun 2020 05:21:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwJdF7tDQQaHrhE1lbGmPiT4tQlDge1AGGLtsCgtsiWKFmppc4p7t10dvwpM1sWgfLifrBZZ0cq6/rwhf/mVOo=
X-Received: by 2002:a17:90a:1aaa:: with SMTP id
 p39mr2592414pjp.127.1592310071885; 
 Tue, 16 Jun 2020 05:21:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200529140620.28759-1-lulu@redhat.com>
 <20200529140620.28759-6-lulu@redhat.com>
 <06bdcfcb-0fed-a2fa-7f79-6c5d08a70934@redhat.com>
In-Reply-To: <06bdcfcb-0fed-a2fa-7f79-6c5d08a70934@redhat.com>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 16 Jun 2020 20:21:00 +0800
Message-ID: <CACLfguWFWUfLO=9oL1aRFt1D7E9UDx6UsJfzqbORn2L43Kig2w@mail.gmail.com>
Subject: Re: [RFC v3 5/8] vhost: introduce vhost_set_vring_ready method
To: Laurent Vivier <lvivier@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 02:01:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: rdunlap@infradead.org, Michael Tsirkin <mst@redhat.com>,
 mhabets@solarflare.com, qemu-devel@nongnu.org,
 Rob Miller <rob.miller@broadcom.com>, saugatm@xilinx.com,
 Markus Armbruster <armbru@redhat.com>, hch@infradead.org,
 Eugenio Perez Martin <eperezma@redhat.com>, jgg@mellanox.com,
 Jason Wang <jasowang@redhat.com>, Shahaf Shuler <shahafs@mellanox.com>,
 kevin.tian@intel.com, parav@mellanox.com,
 Vitaly Mireyno <vmireyno@marvell.com>, "Liang,
 Cunming" <cunming.liang@intel.com>, gdawar@xilinx.com, jiri@mellanox.com,
 xiao.w.wang@intel.com, Stefan Hajnoczi <stefanha@redhat.com>, "Wang,
 Zhihong" <zhihong.wang@intel.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>, Ariel Adam <aadam@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, hanand@xilinx.com, "Zhu,
 Lingshan" <lingshan.zhu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 16, 2020 at 4:04 PM Laurent Vivier <lvivier@redhat.com> wrote:
>
> On 29/05/2020 16:06, Cindy Lu wrote:
> > From: Jason Wang <jasowang@redhat.com>
> >
> > Vhost-vdpa introduces VHOST_VDPA_SET_VRING_ENABLE which complies the
> > semantic of queue_enable defined in virtio spec. This method can be
> > used for preventing device from executing request for a specific
> > virtqueue. This patch introduces the vhost_ops for this.
> >
> > Note that, we've already had vhost_set_vring_enable which has different
> > semantic which allows to enable or disable a specific virtqueue for
> > some kinds of vhost backends. E.g vhost-user use this to changes the
> > number of active queue pairs.
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
>
> Add your S-o-b.
>
will fix this
> > ---
> >  hw/net/vhost_net-stub.c |  4 ++++
> >  hw/net/vhost_net.c      | 11 ++++++++++-
> >  include/net/vhost_net.h |  1 +
> >  3 files changed, 15 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/net/vhost_net-stub.c b/hw/net/vhost_net-stub.c
> > index aac0e98228..43e93e1a9a 100644
> > --- a/hw/net/vhost_net-stub.c
> > +++ b/hw/net/vhost_net-stub.c
> > @@ -86,6 +86,10 @@ int vhost_set_vring_enable(NetClientState *nc, int enable)
> >      return 0;
> >  }
> >
> > +int vhost_set_vring_ready(NetClientState *nc)
> > +{
> > +    return 0;
> > +}
>
> Add a blank line here.
>
will fix this
> >  int vhost_net_set_mtu(struct vhost_net *net, uint16_t mtu)
> >  {
> >      return 0;
> > diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> > index d1d421e3d9..e2bc7de2eb 100644
> > --- a/hw/net/vhost_net.c
> > +++ b/hw/net/vhost_net.c
> > @@ -344,7 +344,7 @@ int vhost_net_start(VirtIODevice *dev, NetClientState *ncs,
> >              goto err_start;
> >          }
> >
> > -        if (ncs[i].peer->vring_enable) {
> > +        if (peer->vring_enable) {
> >              /* restore vring enable state */
> >              r = vhost_set_vring_enable(peer, peer->vring_enable);
>
> Move this part to PATCH 2/8
>
will fix this
> > @@ -455,6 +455,15 @@ int vhost_set_vring_enable(NetClientState *nc, int enable)
> >      return 0;
> >  }
> >
> > +int vhost_set_vring_ready(NetClientState *nc)
> > +{
> > +    VHostNetState *net = get_vhost_net(nc);
> > +    const VhostOps *vhost_ops = net->dev.vhost_ops;
> > +    if (vhost_ops && vhost_ops->vhost_set_vring_ready) {
>
> The structure VhostOps doesn't declare the vhost_set_vring_ready field.
> Your patch is missing something and it could be not built.
>
> It is defined in PATCH 7/8. If you want to keep this patch you should
> move the declaration of "vhost_set_vring_ready_op vhost_set_vring_ready"
> (and related) to this patch.
>
Thanks  Laurent,  I will fix this

> > +        return vhost_ops->vhost_set_vring_ready(&net->dev);
> > +    }
> > +    return 0;
> > +}
>
> Add a blank line.
>
sure will fix this
> >  int vhost_net_set_mtu(struct vhost_net *net, uint16_t mtu)
> >  {
> >      const VhostOps *vhost_ops = net->dev.vhost_ops;
> > diff --git a/include/net/vhost_net.h b/include/net/vhost_net.h
> > index 77e47398c4..8a6f208189 100644
> > --- a/include/net/vhost_net.h
> > +++ b/include/net/vhost_net.h
> > @@ -35,6 +35,7 @@ int vhost_net_notify_migration_done(VHostNetState *net, char* mac_addr);
> >  VHostNetState *get_vhost_net(NetClientState *nc);
> >
> >  int vhost_set_vring_enable(NetClientState * nc, int enable);
> > +int vhost_set_vring_ready(NetClientState *nc);
> >
> >  uint64_t vhost_net_get_acked_features(VHostNetState *net);
> >
> >
>
> Thanks,
> Laurent
>


