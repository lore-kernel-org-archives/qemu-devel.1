Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC4EC433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 06:28:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19DBC20775
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 06:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dc37uVFW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19DBC20775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jq9kk-0006CD-6w
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 02:28:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33482)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jq9k4-0005m3-82
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 02:27:40 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50897
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jq9k1-00048Z-Ew
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 02:27:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593498455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AJK+57nlJJxstvlD+D/YkAt+I+m0b6vti+pj+Hj8jfE=;
 b=Dc37uVFWgcYywmwIrIMofZzsYLfSHXk21WkUpduKK46hYJSWexZzOPQVVFSkIAA8eyAj4L
 q2NzYpz2yVyI44WdGRF6IgI0A9vfskbyeIK+br1pl4tWigAgaP3Pq5UoYoOwOtMqNSQm3p
 sUyCGFwuwUrgo+xG91q9arLOuFVhJSg=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-HtTBKETSOCqjvl5MiWGfPQ-1; Tue, 30 Jun 2020 02:27:32 -0400
X-MC-Unique: HtTBKETSOCqjvl5MiWGfPQ-1
Received: by mail-pj1-f69.google.com with SMTP id fr7so9442257pjb.4
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 23:27:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AJK+57nlJJxstvlD+D/YkAt+I+m0b6vti+pj+Hj8jfE=;
 b=kedw9pkgU2vMjjwwwrbiUwecx8ME5uifL1zlcnBRgCB6OzofLLMiQuKNFGYiBZ9V3z
 MfA4ZNtEC5EbOhXHsQGmMmjDB/ODyOthZBKG58EhLHBkjD/B/0i1zbaW5qRrB7ZsCiQu
 jmOeoDx5Q7OPkCBPBZs/sZXRSW6xfXFO7Z03CRNdEl9awplkTNIxw1A90Mnarf24IX7m
 FETYfSWN4Bl5pg00eCiBIeK0iE/BCUBbSnbtvgqQSujSSyROy+Flp36WhBi4ilQ6wLPX
 xKmu7efk4QAski7rqoyXplgFqMPclXYQNBIqxZHNWeQ6EmNcx2w455rpk/hLhXaZu8OY
 jT7A==
X-Gm-Message-State: AOAM533rEgc2ZOU7uRcSuu4qxW29GUX01Tg1BiEOBa6Ua5AO5vMBSJtP
 Tw03vhtbhpuJJzf48fnW0qXiCWzTyUNkNifqZ47UFJVdGd/e1lNQGu8xOm0vYyCjy5CROz8AsW+
 zcIeFCzGk/TZm8CPIE30MyyIXNJ6RSYc=
X-Received: by 2002:a63:ff52:: with SMTP id s18mr13963653pgk.203.1593498450803; 
 Mon, 29 Jun 2020 23:27:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyJKHcaUVxb/GrR5ktI3p/X9/x0Tue9ptCca3TY3g7/327XZxmdtVfgKWDvNI3IwsAsbUssQie3otWqJmGfIdQ=
X-Received: by 2002:a63:ff52:: with SMTP id s18mr13963615pgk.203.1593498450508; 
 Mon, 29 Jun 2020 23:27:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200622153756.19189-1-lulu@redhat.com>
 <20200622153756.19189-6-lulu@redhat.com>
 <3efd6790-a5eb-c165-06cd-3de708380b15@redhat.com>
In-Reply-To: <3efd6790-a5eb-c165-06cd-3de708380b15@redhat.com>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 30 Jun 2020 14:27:19 +0800
Message-ID: <CACLfguWDMN7D+6RF2755up-GxVJEJLUbp-gQF9JGhk_Gov71pA@mail.gmail.com>
Subject: Re: [PATCH v1 05/10] vhost-backend: export the vhost backend helper
To: Laurent Vivier <lvivier@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lulu@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 01:11:03
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

On Thu, Jun 25, 2020 at 11:07 PM Laurent Vivier <lvivier@redhat.com> wrote:
>
> On 22/06/2020 17:37, Cindy Lu wrote:
> > export the helper then we can reuse them in other backend
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  hw/virtio/vhost-backend.c         | 18 +++++++++---------
> >  include/hw/virtio/vhost-backend.h | 28 ++++++++++++++++++++++++++++
> >  2 files changed, 37 insertions(+), 9 deletions(-)
> >
>
> This looks weird to export all these functions whereas they are all
> already exported by the vhost_ops structure.
>
> So if vhost-vdpa is not a subset of vhost-kernel and if these functions
> will diverge from vhost-backend.c definition in the future, perhaps it
> is wise to already copy their definitions right now in vhost-vdpa.c
> rather than exporting them now and to have to copy them in the future in
> vhost-vdpa.c to modify them.
>
> It will also simplify the definition of vhost_kernel_call().
>
> Thanks,
> Laurent
>
Thanks Laurent, will fix this
> > diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
> > index 48905383f8..660e9e8588 100644
> > --- a/hw/virtio/vhost-backend.c
> > +++ b/hw/virtio/vhost-backend.c
> > @@ -89,7 +89,7 @@ static int vhost_kernel_scsi_get_abi_version(struct vhost_dev *dev, int *version
> >      return vhost_kernel_call(dev, VHOST_SCSI_GET_ABI_VERSION, version);
> >  }
> >
> > -static int vhost_kernel_set_log_base(struct vhost_dev *dev, uint64_t base,
> > +int vhost_kernel_set_log_base(struct vhost_dev *dev, uint64_t base,
> >                                       struct vhost_log *log)
> >  {
> >      return vhost_kernel_call(dev, VHOST_SET_LOG_BASE, &base);
> > @@ -101,7 +101,7 @@ static int vhost_kernel_set_mem_table(struct vhost_dev *dev,
> >      return vhost_kernel_call(dev, VHOST_SET_MEM_TABLE, mem);
> >  }
> >
> > -static int vhost_kernel_set_vring_addr(struct vhost_dev *dev,
> > +int vhost_kernel_set_vring_addr(struct vhost_dev *dev,
> >                                         struct vhost_vring_addr *addr)
> >  {
> >      return vhost_kernel_call(dev, VHOST_SET_VRING_ADDR, addr);
> > @@ -113,31 +113,31 @@ static int vhost_kernel_set_vring_endian(struct vhost_dev *dev,
> >      return vhost_kernel_call(dev, VHOST_SET_VRING_ENDIAN, ring);
> >  }
> >
> > -static int vhost_kernel_set_vring_num(struct vhost_dev *dev,
> > +int vhost_kernel_set_vring_num(struct vhost_dev *dev,
> >                                        struct vhost_vring_state *ring)
> >  {
> >      return vhost_kernel_call(dev, VHOST_SET_VRING_NUM, ring);
> >  }
> >
> > -static int vhost_kernel_set_vring_base(struct vhost_dev *dev,
> > +int vhost_kernel_set_vring_base(struct vhost_dev *dev,
> >                                         struct vhost_vring_state *ring)
> >  {
> >      return vhost_kernel_call(dev, VHOST_SET_VRING_BASE, ring);
> >  }
> >
> > -static int vhost_kernel_get_vring_base(struct vhost_dev *dev,
> > +int vhost_kernel_get_vring_base(struct vhost_dev *dev,
> >                                         struct vhost_vring_state *ring)
> >  {
> >      return vhost_kernel_call(dev, VHOST_GET_VRING_BASE, ring);
> >  }
> >
> > -static int vhost_kernel_set_vring_kick(struct vhost_dev *dev,
> > +int vhost_kernel_set_vring_kick(struct vhost_dev *dev,
> >                                         struct vhost_vring_file *file)
> >  {
> >      return vhost_kernel_call(dev, VHOST_SET_VRING_KICK, file);
> >  }
> >
> > -static int vhost_kernel_set_vring_call(struct vhost_dev *dev,
> > +int vhost_kernel_set_vring_call(struct vhost_dev *dev,
> >                                         struct vhost_vring_file *file)
> >  {
> >      return vhost_kernel_call(dev, VHOST_SET_VRING_CALL, file);
> > @@ -155,13 +155,13 @@ static int vhost_kernel_set_features(struct vhost_dev *dev,
> >      return vhost_kernel_call(dev, VHOST_SET_FEATURES, &features);
> >  }
> >
> > -static int vhost_kernel_get_features(struct vhost_dev *dev,
> > +int vhost_kernel_get_features(struct vhost_dev *dev,
> >                                       uint64_t *features)
> >  {
> >      return vhost_kernel_call(dev, VHOST_GET_FEATURES, features);
> >  }
> >
> > -static int vhost_kernel_set_owner(struct vhost_dev *dev)
> > +int vhost_kernel_set_owner(struct vhost_dev *dev)
> >  {
> >      return vhost_kernel_call(dev, VHOST_SET_OWNER, NULL);
> >  }
> > diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
> > index 6f6670783f..300b59c172 100644
> > --- a/include/hw/virtio/vhost-backend.h
> > +++ b/include/hw/virtio/vhost-backend.h
> > @@ -172,4 +172,32 @@ int vhost_backend_handle_iotlb_msg(struct vhost_dev *dev,
> >
> >  int vhost_user_gpu_set_socket(struct vhost_dev *dev, int fd);
> >
> > +
> > +int vhost_kernel_set_log_base(struct vhost_dev *dev, uint64_t base,
> > +                                     struct vhost_log *log);
> > +
> > +int vhost_kernel_set_vring_addr(struct vhost_dev *dev,
> > +                                       struct vhost_vring_addr *addr);
> > +
> > +int vhost_kernel_set_vring_num(struct vhost_dev *dev,
> > +                                      struct vhost_vring_state *ring);
> > +
> > +int vhost_kernel_set_vring_base(struct vhost_dev *dev,
> > +                                       struct vhost_vring_state *ring);
> > +
> > +int vhost_kernel_get_vring_base(struct vhost_dev *dev,
> > +                                       struct vhost_vring_state *ring);
> > +
> > +int vhost_kernel_set_vring_kick(struct vhost_dev *dev,
> > +                                       struct vhost_vring_file *file);
> > +
> > +int vhost_kernel_set_vring_call(struct vhost_dev *dev,
> > +                                       struct vhost_vring_file *file);
> > +
> > +int vhost_kernel_set_owner(struct vhost_dev *dev);
> > +
> > +int vhost_kernel_get_features(struct vhost_dev *dev,
> > +                                     uint64_t *features);
> > +
> > +
> >  #endif /* VHOST_BACKEND_H */
> >
>


