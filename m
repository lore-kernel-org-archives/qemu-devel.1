Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6EC0C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 07:34:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75A66206DB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 07:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h7Rf0hgm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75A66206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1mXt-00018n-L8
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 02:34:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56685)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j1mWc-0008Ff-G2
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 02:33:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j1mWb-0000Gk-1m
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 02:33:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51314
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j1mWZ-0000FE-AE
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 02:33:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581492809;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/BM69+Y7TajZn6asrNdzUdIiEbpq1Rz3isd25gnT8r8=;
 b=h7Rf0hgmcS41peO1QP0g4FyfguTDvewdVKDOQwCQ1o56a1ku8Bthnhz1afXgRPcbzP0mPz
 eNT+JBBbezABnelYjvyZuMcC0tMHoOvMXdZaHN1jZG4rqYJ9CtvWTJwY05F0Drb3OmJxS1
 lPjeNM56GJ8wqhzUkkGsm/UxUZX48zI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-NLXPXGZENOi38G6opLkp-w-1; Wed, 12 Feb 2020 02:33:25 -0500
Received: by mail-qv1-f70.google.com with SMTP id g15so885715qvq.20
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 23:33:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=sJhg7KkEzOGnn4hSvrDQwQ/QlaSsdTM15d7DcDDIQpU=;
 b=AgaPy0E+X8Zgx2llVxJm3ZFiS9X8E6qc90YwWPJQHvjB95cw2WzhRaTvM/GEYsCcXe
 QWe3D2ieXC8B7CcWL6J/PbEbIPI5ZgUtWlhRQ0cHboi+AMM/9ZR7q0O4lN7MlkLT4gWY
 doNxvUl9ht4N58kY5T0n1FoAYUXtddRqgqLj/q2SyKspcW7M5spTdfjA/Ozu9RvzxSLN
 WAh4rmq8DTT78Lxr5Ayp/3GalMqWX37AW6wWX5w5mwi32vPsN6+NoM7jhVIHo7vQdVHg
 NKzG7btc9DyoDTgumx9+23065MaECzYFD/Bb2LJ+6AwSMUvoyVUUNOL77PZLGtMlNA3x
 44Qg==
X-Gm-Message-State: APjAAAWweCvLrnWFqiqi/x8RdamrTMOxbMVARjz5sI1gRb+NWkwULqbG
 pVsxcS9uyFze4OOCfnjcKlv2LrMDyJVRRti64rg2reYL8+dDRmpilFcpXcjN0nyYmBf3HkwNv72
 pOvEJ0/bpxYpdSuA=
X-Received: by 2002:a37:7245:: with SMTP id n66mr6550697qkc.202.1581492805429; 
 Tue, 11 Feb 2020 23:33:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqzrwLw9tJ+j7cQsj4KIfybcSmpt4S0r5Ij00Kd6ddFwi9Qet0H0RfsmeBuMxbC3RCsQtJIU9A==
X-Received: by 2002:a37:7245:: with SMTP id n66mr6550688qkc.202.1581492805139; 
 Tue, 11 Feb 2020 23:33:25 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
 by smtp.gmail.com with ESMTPSA id k15sm3284451qkk.103.2020.02.11.23.33.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2020 23:33:24 -0800 (PST)
Date: Wed, 12 Feb 2020 02:33:19 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Liu, Jing2" <jing2.liu@linux.intel.com>
Subject: Re: [virtio-dev] Re: [PATCH v2 4/5] virtio-mmio: add MSI interrupt
 feature support
Message-ID: <20200212023051-mutt-send-email-mst@kernel.org>
References: <cover.1581305609.git.zhabin@linux.alibaba.com>
 <4c3d13be5a391b1fc50416838de57d903cbf8038.1581305609.git.zhabin@linux.alibaba.com>
 <0c71ff9d-1a7f-cfd2-e682-71b181bdeae4@redhat.com>
 <c42c8b49-5357-f341-2942-ba84afc25437@linux.intel.com>
 <ad96269f-753d-54b8-a4ae-59d1595dd3b2@redhat.com>
 <5522f205-207b-b012-6631-3cc77dde3bfe@linux.intel.com>
 <45e22435-08d3-08fe-8843-d8db02fcb8e3@redhat.com>
 <4c19292f-9d25-a859-3dde-6dd5a03fdf0b@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <4c19292f-9d25-a859-3dde-6dd5a03fdf0b@linux.intel.com>
X-MC-Unique: NLXPXGZENOi38G6opLkp-w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: virtio-dev@lists.oasis-open.org, Zha Bin <zhabin@linux.alibaba.com>,
 slp@redhat.com, Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
 qemu-devel@nongnu.org, chao.p.peng@linux.intel.com, gerry@linux.alibaba.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 12, 2020 at 11:54:53AM +0800, Liu, Jing2 wrote:
>=20
> On 2/11/2020 3:40 PM, Jason Wang wrote:
>=20
>=20
>     On 2020/2/11 =E4=B8=8B=E5=8D=882:02, Liu, Jing2 wrote:
>=20
>=20
>=20
>         On 2/11/2020 12:02 PM, Jason Wang wrote:
>=20
>=20
>             On 2020/2/11 =E4=B8=8A=E5=8D=8811:35, Liu, Jing2 wrote:
>=20
>=20
>                 On 2/11/2020 11:17 AM, Jason Wang wrote:
>=20
>=20
>                     On 2020/2/10 =E4=B8=8B=E5=8D=885:05, Zha Bin wrote:
>=20
>                         From: Liu Jiang<gerry@linux.alibaba.com>
>=20
>                         Userspace VMMs (e.g. Qemu microvm, Firecracker) t=
ake
>                         advantage of using
>                         virtio over mmio devices as a lightweight machine=
 model
>                         for modern
>                         cloud. The standard virtio over MMIO transport la=
yer
>                         only supports one
>                         legacy interrupt, which is much heavier than virt=
io
>                         over PCI transport
>                         layer using MSI. Legacy interrupt has long work p=
ath
>                         and causes specific
>                         VMExits in following cases, which would considera=
bly
>                         slow down the
>                         performance:
>=20
>                         1) read interrupt status register
>                         2) update interrupt status register
>                         3) write IOAPIC EOI register
>=20
>                         We proposed to add MSI support for virtio over MM=
IO via
>                         new feature
>                         bit VIRTIO_F_MMIO_MSI[1] which increases the inte=
rrupt
>                         performance.
>=20
>                         With the VIRTIO_F_MMIO_MSI feature bit supported,=
 the
>                         virtio-mmio MSI
>                         uses msi_sharing[1] to indicate the event and vec=
tor
>                         mapping.
>                         Bit 1 is 0: device uses non-sharing and fixed vec=
tor
>                         per event mapping.
>                         Bit 1 is 1: device uses sharing mode and dynamic
>                         mapping.
>=20
>=20
>=20
>                     I believe dynamic mapping should cover the case of fi=
xed
>                     vector?
>=20
>=20
>                 Actually this bit *aims* for msi sharing or msi non-shari=
ng.
>=20
>                 It means, when msi sharing bit is 1, device doesn't want =
vector
>                 per queue
>=20
>                 (it wants msi vector sharing as name) and doesn't want a =
high
>                 interrupt rate.
>=20
>                 So driver turns to !per_vq_vectors and has to do dynamica=
l
>                 mapping.
>=20
>                 So they are opposite not superset.
>=20
>                 Thanks!
>=20
>                 Jing
>=20
>=20
>=20
>             I think you need add more comments on the command.
>=20
>             E.g if I want to map vector 0 to queue 1, how do I need to do=
?
>=20
>             write(1, queue_sel);
>             write(0, vector_sel);
>=20
>=20
>         That's true. Besides, two commands are used for msi sharing mode,
>=20
>         VIRTIO_MMIO_MSI_CMD_MAP_CONFIG and VIRTIO_MMIO_MSI_CMD_MAP_QUEUE.
>=20
>         "To set up the event and vector mapping for MSI sharing mode, dri=
ver
>         SHOULD write a valid MsiVecSel followed by
>         VIRTIO_MMIO_MSI_CMD_MAP_CONFIG/VIRTIO_MMIO_MSI_CMD_MAP_QUEUE comm=
and to
>         map the configuration change/selected queue events respectively.=
=C2=A0 "
>         (See spec patch 5/5)
>=20
>         So if driver detects the msi sharing mode, when it does setup vq,
>         writes the queue_sel (this already exists in setup vq), vector se=
l and
>         then MAP_QUEUE command to do the queue event mapping.
>=20
>=20
>=20
>     So actually the per vq msix could be done through this.
>=20
> Right, per vq msix can also be mapped by the 2 commands if we want.=C2=A0
>=20
> The current design benefits for those devices requesting per vq msi that =
driver
>=20
> doesn't have to map during setup each queue,
>=20
> since we define the relationship by default.

Point being to save some exits for configuration? How much does it
save? IMHO we need to find a way to drastically simplify this interface,
to cut down the new LOC to at most 100-200, proportionally to the
performance gain it gives.


>=20
>     I don't get why you need to introduce MSI_SHARING_MASK which is the c=
harge
>     of driver instead of device.
>=20
> MSI_SHARING_MASK is just for identifying the msi_sharing bit in readl(Msi=
State)
> (0x0c4). The device tells whether it wants msi_sharing.
>=20
> MsiState register: R
>=20
> le32 {
> =C2=A0=C2=A0=C2=A0 msi_enabled : 1;
> =C2=A0=C2=A0=C2=A0 msi_sharing: 1;
> =C2=A0=C2=A0=C2=A0 reserved : 30;
> };
>=20
>     The interrupt rate should have no direct relationship with whether it=
 has
>     been shared or not.
>=20
>=20
>=20
>     Btw, you introduce mask/unmask without pending, how to deal with the =
lost
>     interrupt during the masking then?
>=20
>=20
>=20
>         For msi non-sharing mode, no special action is needed because we =
make
>         the rule of per_vq_vector and fixed relationship.
>=20
>         Correct me if this is not that clear for spec/code comments.
>=20
>=20
>=20
>     The ABI is not as straightforward as PCI did. Why not just reuse the =
PCI
>     layout?
>=20
>     E.g having
>=20
>     queue_sel
>     queue_msix_vector
>     msix_config
>=20
>     for configuring map between msi vector and queues/config
>=20
> Thanks for the advice. :)
>=20
> Actually when looking into pci, the queue_msix_vector/msix_config is the =
msi
> vector index, which is the same as the mmio register MsiVecSel (0x0d0).
>=20
> So we don't introduce two extra registers for mapping even in sharing mod=
e.
>=20
> What do you think?
>=20
>=20
>=20
>     Then
>=20
>     vector_sel
>     address
>     data
>     pending
>     mask
>     unmask
>=20
>     for configuring msi table?
>=20
> PCI-like msix table is not introduced to device and instead simply use co=
mmands
> to tell the mask/configure/enable.
>=20
> Thanks!
>=20
> Jing
>=20
>=20
>     Thanks
>=20
>=20
>=20
>         Thanks!
>=20
>         Jing
>=20
>=20
>=20
>=20
>             ?
>=20
>             Thanks
>=20
>=20
>=20
>=20
>=20
>=20
>                     Thanks
>=20
>=20
>=20
>                     -----------------------------------------------------=
----------------
>=20
>                     To unsubscribe, e-mail:
>                     virtio-dev-unsubscribe@lists.oasis-open.org
>                     For additional commands, e-mail:
>                     virtio-dev-help@lists.oasis-open.org
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20


