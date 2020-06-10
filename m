Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B519FC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 05:04:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FA06207ED
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 05:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QpXJBIhI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FA06207ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jisuS-0003GP-JW
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 01:04:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38642)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jistF-0001Yu-Pu
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 01:03:05 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42817
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jistE-0006k5-RQ
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 01:03:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591765384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T/upDCx01GdERUHpJlRe7Oz/0B2gBrBsEEG7dEJ+abI=;
 b=QpXJBIhIbvjBEad60sWAJoOQfnHGLx2BCOHSnkJvPSjaRVmljWbAje8ttxjcRtU1vPqm87
 7siEmGk/u9FYUTqbV2MCwbQx93a2VGUHrbmwO4mG/1HDWLbRjE8bALexojPx2mShqW9Ker
 bFE0fhrYtLH5ddRIAdG7jzQRqmjA6/c=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-CAYHDlnOMoCexgcomlm5GA-1; Wed, 10 Jun 2020 01:03:02 -0400
X-MC-Unique: CAYHDlnOMoCexgcomlm5GA-1
Received: by mail-wr1-f69.google.com with SMTP id o1so533348wrm.17
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 22:03:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=8IcsRjtTdo74nCjrSCz2Nc6lJqJfiL9KrQ/X6w5Z0lY=;
 b=anWAp0UnbWT3dTytcA0f2P7o5U8aSpAN9mxvg8fAoG9Kg8dGHwybV6gsZu+INWYHkv
 shSZ6t/D0TAEfhjCMpoKQmVNXDPLbznPHgSm+9Vj0gMBfKJpRHRz8pW8/TLic3WUGqXv
 S0wYAMNUV5f390Ssuaz1meV6wNkoXj8HFPDLJscw00LElcs6QB5fLwa6amrB6AsA90yh
 JJ72ShAxXSE9UAzi9DvYx2eh+FH8jXgyeqzAkZuYMzNjHGtOO49IRWuVvIrng62oDgSE
 jEvG/aR+bungzOOYafGzx05XGUdC3ypYh4hOiRQhnF0LK47HxSFDyfXs42H1A6pZ6YMw
 ahCg==
X-Gm-Message-State: AOAM531e683g5HJWprOYnWTA4oi6D5gAnLhub1RVaTIpbMwiEdgQ6rqn
 fj9p/ojyYoW4xU/xhewB9jia9vhk92JZxet1+IDYKRJZqLaCo/+YxxNpQ6/WI7gBZ9B1jQIkT0t
 Q0da13mjYcXkho8I=
X-Received: by 2002:a5d:4bcb:: with SMTP id l11mr1488215wrt.363.1591765381520; 
 Tue, 09 Jun 2020 22:03:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzPKp42yvyDvcG4pEoe05bFDis1ItREwXw/2pMArk7VQm3LA53rEKpiaqrdbj2x6oARuE33pQ==
X-Received: by 2002:a5d:4bcb:: with SMTP id l11mr1488203wrt.363.1591765381314; 
 Tue, 09 Jun 2020 22:03:01 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
 by smtp.gmail.com with ESMTPSA id j5sm6443977wrm.57.2020.06.09.22.02.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 22:03:00 -0700 (PDT)
Date: Wed, 10 Jun 2020 01:02:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v2 0/7] virtio: enable VIRTIO_F_RING_PACKED for all devices
Message-ID: <20200610010158-mutt-send-email-mst@kernel.org>
References: <20200609170218.246468-1-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200609170218.246468-1-stefanha@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:22:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 jasowang@redhat.com, cohuck@redhat.com, qemu-devel@nongnu.org,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 09, 2020 at 06:02:11PM +0100, Stefan Hajnoczi wrote:
> v2:
>  * Add libvhost-user VHOST_USER_GET_FEATURES patch to start reporting feature
>    bits correctly (already reviewed by Marc-André Lureau)
>  * Rephrase doc comments and drop vhost_get_default_features() [Jason]
>  * Simplify hw/core/machine.c compat props by setting packed=off on the
>    virtio-dev base class [Jason]
> 
> The VIRTIO 1.1 packed virtqueue layout improves performance and guest driver
> support has been available since Linux v5.0. virtio-blk benchmarks show it is
> beneficial for non-net devices too so I wrote patches to enable it for all
> devices.

It's exciting that it's widely useful!
Could you include some numbers please though?
No need to be exhaustive ...

> It turned out to be trickier than I expected because vhost feature negotiation
> is currently not ready for new virtqueue feature bits like
> VIRTIO_F_RING_PACKED.
> 
> Patch 1 fixes libqos. Patch 2 fixes libvhost-user. Patch 3 adds clarifications
> to the vhost-user specification. Patches 4-6 solve the vhost feature issues in
> QEMU. Finally, Patch 6 enables packed virtqueues.
> 
> Stefan Hajnoczi (7):
>   tests/libqos: mask out VIRTIO_F_RING_PACKED for now
>   libvhost-user: advertise vring features
>   docs: document non-net VHOST_USER_GET_FEATURES behavior
>   vhost: involve device backends in feature negotiation
>   vhost-user-blk: add VIRTIO_F_RING_PACKED feature bit
>   vhost-scsi: add VIRTIO_F_VERSION_1 and VIRTIO_F_RING_PACKED
>   virtio: enable VIRTIO_F_RING_PACKED for all devices
> 
>  include/hw/virtio/vhost.h               |  1 +
>  include/hw/virtio/virtio-gpu.h          |  2 ++
>  include/hw/virtio/virtio.h              |  2 +-
>  include/sysemu/cryptodev-vhost.h        | 11 +++++++++++
>  backends/cryptodev-vhost.c              | 21 +++++++++++++++++++++
>  contrib/libvhost-user/libvhost-user.c   | 10 ++++++++++
>  contrib/vhost-user-blk/vhost-user-blk.c |  4 +---
>  hw/block/vhost-user-blk.c               |  1 +
>  hw/core/machine.c                       |  4 +++-
>  hw/display/vhost-user-gpu.c             | 18 ++++++++++++++++++
>  hw/display/virtio-gpu-base.c            |  2 +-
>  hw/input/vhost-user-input.c             | 11 +++++++++++
>  hw/scsi/vhost-scsi.c                    |  2 ++
>  hw/scsi/vhost-user-scsi.c               |  2 ++
>  hw/virtio/vhost-user-fs.c               |  6 ++++--
>  hw/virtio/vhost-vsock.c                 |  7 +++++--
>  hw/virtio/vhost.c                       | 24 ++++++++++++++++++++++++
>  hw/virtio/virtio-crypto.c               |  3 ++-
>  tests/qtest/libqos/virtio.c             |  3 ++-
>  docs/interop/vhost-user.rst             | 21 +++++++++++++++++++++
>  20 files changed, 143 insertions(+), 12 deletions(-)
> 
> -- 
> 2.26.2
> 


