Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C34C352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 12:09:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AED45206D7
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 12:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bVVMGT7Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AED45206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1UMW-0002RV-K2
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 07:09:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52369)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j1ULm-0001l6-5Q
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 07:09:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j1ULk-0005WV-D4
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 07:09:10 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37252
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j1ULk-0005Uz-7m
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 07:09:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581422947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KDgD49iQwJGzkZoJjWbF5ftA+E3GrMa2UrLOyCTzSpc=;
 b=bVVMGT7QtnqzCLnaJKgjky7kJFT4IVcYV5ii6TToOo5YENdgWG6ctVC+YGS73qD1X60tVi
 vT2V862puNNnTanAveDGDsycZaBeH9TJ4pkBnl9JuP3sRSTlHLqbLw6Z6g/dYgjVsMuIuF
 AnLcDj2hEvXRyPBqaQgs1cpCgk+YdZ0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-LBuNgkWcOuWDL43qXJmrbw-1; Tue, 11 Feb 2020 07:09:04 -0500
Received: by mail-qk1-f200.google.com with SMTP id n126so6875498qkc.18
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 04:09:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=ufoJT05czgf06ShT8pfV9Iol2IxotHxx6vkzP8roYuc=;
 b=OmOdkE+eeGZ3YNVppftZpxiidGKSU/Wjcy7PIZGyAoG4AIZ3Zd47jYs/lsSJzT6nJv
 YQhGXk+itOsqNU8qpvWC2xSQT5T96NHuYPmIxAAcpchw3ixRM7Y6qtuXdVCbtQXnaGPL
 69KUD8yjfCIlCMFQScRFH3F7H8J/rHKYvB24xmzPcPK07es/mee/DvQuqa0B8geK/w/D
 4boB5+dzCh8t6RCF4cPmZX6hp+QwnEi3PR9lyfFR8o21GrtrCJtZJCFrgMmKJH8k4Xg3
 I8KYxFAD2vd6IdZT402nN22+GJH9I7CO7hjnjItXpLgQ4ATwgnsCclSOYgjeQVZ4m2Ws
 +eIA==
X-Gm-Message-State: APjAAAVXpZybxrX2B1MSp+h59FrTlu2HQpN8cL4xrTlasP4quTxcYcdp
 sgew9J72RdOnQwB3iIaEtzXt29+rx5HcJCGxPCi65BOzL6KNhiHGe+XwezuNOI91prAt9/JV2DT
 d68BrT5Sm//40Ml0=
X-Received: by 2002:a05:620a:2218:: with SMTP id
 m24mr5895579qkh.442.1581422944001; 
 Tue, 11 Feb 2020 04:09:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqxOkWykl/bzXB1cDdfnXTHW8u+3R2Hz17uN99zDLH5T5H+7OEGnlmCqphx5dLGWOWkVHeL7qA==
X-Received: by 2002:a05:620a:2218:: with SMTP id
 m24mr5895559qkh.442.1581422943717; 
 Tue, 11 Feb 2020 04:09:03 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
 by smtp.gmail.com with ESMTPSA id r6sm1997742qtm.63.2020.02.11.04.09.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2020 04:09:02 -0800 (PST)
Date: Tue, 11 Feb 2020 07:08:58 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [virtio-dev] Re: [PATCH v2 4/5] virtio-mmio: add MSI interrupt
 feature support
Message-ID: <20200211070523-mutt-send-email-mst@kernel.org>
References: <cover.1581305609.git.zhabin@linux.alibaba.com>
 <4c3d13be5a391b1fc50416838de57d903cbf8038.1581305609.git.zhabin@linux.alibaba.com>
 <0c71ff9d-1a7f-cfd2-e682-71b181bdeae4@redhat.com>
 <c42c8b49-5357-f341-2942-ba84afc25437@linux.intel.com>
 <ad96269f-753d-54b8-a4ae-59d1595dd3b2@redhat.com>
 <5522f205-207b-b012-6631-3cc77dde3bfe@linux.intel.com>
 <45e22435-08d3-08fe-8843-d8db02fcb8e3@redhat.com>
 <20200211065319-mutt-send-email-mst@kernel.org>
 <c4a78a15-c889-df3f-3e1e-7df1a4d67838@redhat.com>
MIME-Version: 1.0
In-Reply-To: <c4a78a15-c889-df3f-3e1e-7df1a4d67838@redhat.com>
X-MC-Unique: LBuNgkWcOuWDL43qXJmrbw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 slp@redhat.com, "Liu, Jing2" <jing2.liu@linux.intel.com>,
 linux-kernel@vger.kernel.org, qemu-devel@nongnu.org,
 chao.p.peng@linux.intel.com, gerry@linux.alibaba.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Feb 11, 2020 at 08:04:24PM +0800, Jason Wang wrote:
>=20
> On 2020/2/11 =E4=B8=8B=E5=8D=887:58, Michael S. Tsirkin wrote:
> > On Tue, Feb 11, 2020 at 03:40:23PM +0800, Jason Wang wrote:
> > > On 2020/2/11 =E4=B8=8B=E5=8D=882:02, Liu, Jing2 wrote:
> > > > On 2/11/2020 12:02 PM, Jason Wang wrote:
> > > > > On 2020/2/11 =E4=B8=8A=E5=8D=8811:35, Liu, Jing2 wrote:
> > > > > > On 2/11/2020 11:17 AM, Jason Wang wrote:
> > > > > > > On 2020/2/10 =E4=B8=8B=E5=8D=885:05, Zha Bin wrote:
> > > > > > > > From: Liu Jiang<gerry@linux.alibaba.com>
> > > > > > > >=20
> > > > > > > > Userspace VMMs (e.g. Qemu microvm, Firecracker) take
> > > > > > > > advantage of using
> > > > > > > > virtio over mmio devices as a lightweight machine model for=
 modern
> > > > > > > > cloud. The standard virtio over MMIO transport layer
> > > > > > > > only supports one
> > > > > > > > legacy interrupt, which is much heavier than virtio over
> > > > > > > > PCI transport
> > > > > > > > layer using MSI. Legacy interrupt has long work path and
> > > > > > > > causes specific
> > > > > > > > VMExits in following cases, which would considerably slow d=
own the
> > > > > > > > performance:
> > > > > > > >=20
> > > > > > > > 1) read interrupt status register
> > > > > > > > 2) update interrupt status register
> > > > > > > > 3) write IOAPIC EOI register
> > > > > > > >=20
> > > > > > > > We proposed to add MSI support for virtio over MMIO via new=
 feature
> > > > > > > > bit VIRTIO_F_MMIO_MSI[1] which increases the interrupt perf=
ormance.
> > > > > > > >=20
> > > > > > > > With the VIRTIO_F_MMIO_MSI feature bit supported, the virti=
o-mmio MSI
> > > > > > > > uses msi_sharing[1] to indicate the event and vector mappin=
g.
> > > > > > > > Bit 1 is 0: device uses non-sharing and fixed vector per
> > > > > > > > event mapping.
> > > > > > > > Bit 1 is 1: device uses sharing mode and dynamic mapping.
> > > > > > > I believe dynamic mapping should cover the case of fixed vect=
or?
> > > > > > >=20
> > > > > > Actually this bit*aims*  for msi sharing or msi non-sharing.
> > > > > >=20
> > > > > > It means, when msi sharing bit is 1, device doesn't want vector
> > > > > > per queue
> > > > > >=20
> > > > > > (it wants msi vector sharing as name) and doesn't want a high
> > > > > > interrupt rate.
> > > > > >=20
> > > > > > So driver turns to !per_vq_vectors and has to do dynamical mapp=
ing.
> > > > > >=20
> > > > > > So they are opposite not superset.
> > > > > >=20
> > > > > > Thanks!
> > > > > >=20
> > > > > > Jing
> > > > > I think you need add more comments on the command.
> > > > >=20
> > > > > E.g if I want to map vector 0 to queue 1, how do I need to do?
> > > > >=20
> > > > > write(1, queue_sel);
> > > > > write(0, vector_sel);
> > > > That's true. Besides, two commands are used for msi sharing mode,
> > > >=20
> > > > VIRTIO_MMIO_MSI_CMD_MAP_CONFIG and VIRTIO_MMIO_MSI_CMD_MAP_QUEUE.
> > > >=20
> > > > "To set up the event and vector mapping for MSI sharing mode, drive=
r
> > > > SHOULD write a valid MsiVecSel followed by
> > > > VIRTIO_MMIO_MSI_CMD_MAP_CONFIG/VIRTIO_MMIO_MSI_CMD_MAP_QUEUE comman=
d to
> > > > map the configuration change/selected queue events respectively.=C2=
=A0 " (See
> > > > spec patch 5/5)
> > > >=20
> > > > So if driver detects the msi sharing mode, when it does setup vq, w=
rites
> > > > the queue_sel (this already exists in setup vq), vector sel and the=
n
> > > > MAP_QUEUE command to do the queue event mapping.
> > > >=20
> > > So actually the per vq msix could be done through this. I don't get w=
hy you
> > > need to introduce MSI_SHARING_MASK which is the charge of driver inst=
ead of
> > > device. The interrupt rate should have no direct relationship with wh=
ether
> > > it has been shared or not.
> > >=20
> > > Btw, you introduce mask/unmask without pending, how to deal with the =
lost
> > > interrupt during the masking then?
> > pending can be an internal device register. as long as device
> > does not lose interrupts while masked, all's well.
>=20
>=20
> You meant raise the interrupt during unmask automatically?
>=20


yes - that's also what pci does.

the guest visible pending bit is partially implemented in qemu
as per pci spec but it's unused.

> >=20
> > There's value is being able to say "this queue sends no
> > interrupts do not bother checking used notification area".
> > so we need way to say that. So I guess an enable interrupts
> > register might have some value...
> > But besides that, it's enough to have mask/unmask/address/data
> > per vq.
>=20
>=20
> Just to check, do you mean "per vector" here?
>=20
> Thanks
>=20

No, per VQ. An indirection VQ -> vector -> address/data isn't
necessary for PCI either, but that ship has sailed.

--=20
MST


