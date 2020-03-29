Return-Path: <SRS0=qvFP=5O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABB3C43331
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Mar 2020 13:50:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 036C82073B
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Mar 2020 13:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IOLwShcl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 036C82073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIYKw-0003vG-6v
	for qemu-devel@archiver.kernel.org; Sun, 29 Mar 2020 09:50:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59293)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jIYJn-0003LS-P9
 for qemu-devel@nongnu.org; Sun, 29 Mar 2020 09:49:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jIYJm-0002Vu-7e
 for qemu-devel@nongnu.org; Sun, 29 Mar 2020 09:49:39 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:33967)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jIYJm-0002Ul-1X
 for qemu-devel@nongnu.org; Sun, 29 Mar 2020 09:49:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585489777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ss5++7rjdtwI5mlZq/PYW9Fk4Zcy4pQpA/qzsiRBccI=;
 b=IOLwShclY3W3iWdvvPHAts29eW77tQD1WZpPb4x9HMwsUtQs5shD7cJJBkOzD/NHsLmnlT
 k8UC5eSLcZXwoPdN60hQBu7VFnNZCP9iE/3+7d+LvD7TefeBDbNmivpmgpZWdIjuvKdRCI
 gcOloLsLBHeg+Z0KZE9MPhfSYPxJU1U=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-133-1Xk_mbm4Pp-WYHVGoe3U7Q-1; Sun, 29 Mar 2020 09:49:35 -0400
X-MC-Unique: 1Xk_mbm4Pp-WYHVGoe3U7Q-1
Received: by mail-wr1-f69.google.com with SMTP id e10so8552757wrm.2
 for <qemu-devel@nongnu.org>; Sun, 29 Mar 2020 06:49:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=rhbZ1vr28obMTdZInCa7gBjHKYPfQMbjZVjfD32ozkc=;
 b=rmn952EjMUSG3qdYzvmAv5B8MWmO4jjsKfeh90eLqcS1c5oD4Ijoao+oWFO1ahbfhr
 PdiQp1tkYSO1yC51BPFLLnvpLTtZnsaTLOdJ9SzbtFK3Lvf/uPyrZ8m1ulY4YKrfxsKz
 6PpkSN1jTl6jfAMgwAHJowxAd5WWYmhfeIaq/1Fz36Pmx3DsdmHox8xeFxC4D2vJBbzL
 6Huh2tnr0C+n2hr8TVKSIVG9OKJq7Pt2n42a9vSEeBXucVD575WEBvezZMtqIapEb9VO
 CZS1kOBXX6R/+uenSmseLKvohx+3mTXaDw+2KeiR8hjAp0Xkk/YpdAvcuATsAcFuQww1
 ZFAw==
X-Gm-Message-State: ANhLgQ37tAYYdwC3ql5cx3eD/j1SG+cSjoJ+g7IrIkRCjJ0dpH48gRJn
 qUtwQERWH1gVFdssI1Gw+G+/uEUY1miXaFOZmjlHAd9S283LBbELS0RJG7IrvmzbRGQEgKzVT1L
 6fHafpGbcLaCyVDY=
X-Received: by 2002:a1c:7504:: with SMTP id o4mr8404710wmc.111.1585489774252; 
 Sun, 29 Mar 2020 06:49:34 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuQi0FAoUwsWKUxDqioByfOL+Ec9ka7+E8+K2gOVpUgIoZtPS45PGk1yZuhV89g6TSfRyHTBg==
X-Received: by 2002:a1c:7504:: with SMTP id o4mr8404693wmc.111.1585489774048; 
 Sun, 29 Mar 2020 06:49:34 -0700 (PDT)
Received: from redhat.com (bzq-79-183-139-129.red.bezeqint.net.
 [79.183.139.129])
 by smtp.gmail.com with ESMTPSA id i8sm18453706wrb.41.2020.03.29.06.49.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Mar 2020 06:49:33 -0700 (PDT)
Date: Sun, 29 Mar 2020 09:49:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH RESEND v3 0/4] virtio-pci: enable blk and scsi
 multi-queue by default
Message-ID: <20200329094907-mutt-send-email-mst@kernel.org>
References: <20200320103041.129527-1-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200320103041.129527-1-stefanha@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, slp@redhat.com, cohuck@redhat.com,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Mar 20, 2020 at 10:30:37AM +0000, Stefan Hajnoczi wrote:
> v3:
>  * Add new performance results that demonstrate the scalability
>  * Mention that this is PCI-specific [Cornelia]
> v2:
>  * Let the virtio-DEVICE-pci device select num-queues because the optimal
>    multi-queue configuration may differ between virtio-pci, virtio-mmio, =
and
>    virtio-ccw [Cornelia]


I'd like to queue it for merge after the release. If possible
please ping me after the release to help make sure it didn't get
dropped.

Thanks!


> Enabling multi-queue on virtio-pci storage devices improves performance o=
n SMP
> guests because the completion interrupt is handled on the vCPU that submi=
tted
> the I/O request.  This avoids IPIs inside the guest.
>=20
> Note that performance is unchanged in these cases:
> 1. Uniprocessor guests.  They don't have IPIs.
> 2. Application threads might be scheduled on the sole vCPU that handles
>    completion interrupts purely by chance.  (This is one reason why bench=
mark
>    results can vary noticably between runs.)
> 3. Users may bind the application to the vCPU that handles completion
>    interrupts.
>=20
> Set the number of queues to the number of vCPUs by default on virtio-blk =
and
> virtio-scsi PCI devices.  Older machine types continue to default to 1 qu=
eue
> for live migration compatibility.
>=20
> Random read performance:
>       IOPS
> q=3D1    78k
> q=3D32  104k  +33%
>=20
> Boot time:
>       Duration
> q=3D1        51s
> q=3D32     1m41s  +98%
>=20
> Guest configuration: 32 vCPUs, 101 virtio-blk-pci disks
>=20
> Previously measured results on a 4 vCPU guest were also positive but show=
ed a
> smaller 1-4% performance improvement.  They are no longer valid because
> significant event loop optimizations have been merged.
>=20
> Stefan Hajnoczi (4):
>   virtio-scsi: introduce a constant for fixed virtqueues
>   virtio-scsi: default num_queues to -smp N
>   virtio-blk: default num_queues to -smp N
>   vhost-user-blk: default num_queues to -smp N
>=20
>  hw/block/vhost-user-blk.c          |  6 +++++-
>  hw/block/virtio-blk.c              |  6 +++++-
>  hw/core/machine.c                  |  5 +++++
>  hw/scsi/vhost-scsi.c               |  3 ++-
>  hw/scsi/vhost-user-scsi.c          |  5 +++--
>  hw/scsi/virtio-scsi.c              | 13 +++++++++----
>  hw/virtio/vhost-scsi-pci.c         | 10 ++++++++--
>  hw/virtio/vhost-user-blk-pci.c     |  6 ++++++
>  hw/virtio/vhost-user-scsi-pci.c    | 10 ++++++++--
>  hw/virtio/virtio-blk-pci.c         |  9 ++++++++-
>  hw/virtio/virtio-scsi-pci.c        | 10 ++++++++--
>  include/hw/virtio/vhost-user-blk.h |  2 ++
>  include/hw/virtio/virtio-blk.h     |  2 ++
>  include/hw/virtio/virtio-scsi.h    |  5 +++++
>  14 files changed, 76 insertions(+), 16 deletions(-)
>=20
> --=20
> 2.24.1
>=20


