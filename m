Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB69C352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 11:59:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F10DC20714
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 11:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ya08aq24"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F10DC20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1UCM-0007Ff-2k
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 06:59:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49976)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j1UBi-0006hy-Kx
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 06:58:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j1UBf-0008NM-Ok
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 06:58:45 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20030
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j1UBf-0008GP-K6
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 06:58:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581422322;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mKQwhjigBKlCLUJlEgsrdGbfM93C9WAohs84qh2X5Vg=;
 b=Ya08aq24tklIGUUxYWL+vhsV31kfk0gaWcB0WeSivMhCs+8gbSjg7Lo+kLPHGUAunbz6qE
 prcuEdwEsTCq5vuHNb9/KSin1lrmEgTbOjBgKWaTN0J4OUCNcHS7J02+CRHWWdwQHeQVC4
 heqNlkQpQmDEJUGsLNS4eyw91en4vCM=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-38XTYdUlMxqRYo25Im8bcw-1; Tue, 11 Feb 2020 06:58:39 -0500
Received: by mail-qk1-f200.google.com with SMTP id r142so3450315qke.3
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 03:58:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=VHVm75D8rqdio+fBEx7/QYHo8H/jQwK3ulKDlXOb1xI=;
 b=RY5J9Ufr3G9mUJdr92H1E1Ces9cgzi8F8Yx2y1LflaMwj1AA6gU1VLw1rVK49bjKAb
 M66UsBAOETDIpRLX1jjB/TlJbDgCFfGQY+De6l0JYN10ZIpQSxZ9uQpHeEiNPKL0G6Gw
 P7Y8vBEFA+ZRzwcAO/KqBivG5BNOFymnf2Rk0m69sTJNBWQN/EVHz7s5MU41xLSGpudh
 Pm94DmVC86pyNiI/Tw15htyrOIARH7GesJmy+paeQtZoJzYtU0VtK+NjCLEpt1ULtYq3
 buxNo9Oo2HtcemerQk14qWtNu2a+H2ASXk1gCr4ydd+1E17wLSJKMn6ao3vybygnIxoT
 AfDw==
X-Gm-Message-State: APjAAAXGfZwf+YeWaBfsOMIL6r5woYTrgVpimXKUxuKDkmhk8xLqO5gE
 SNYIUqW8j458HCSesp2SNFuD7v9Nc4nzB1YCQW6GUaIs3abqKZboGKT/MQJKvTBUlbhq4KLEtsE
 nvMpBrO8igniAt2U=
X-Received: by 2002:ac8:4e46:: with SMTP id e6mr2062801qtw.9.1581422319023;
 Tue, 11 Feb 2020 03:58:39 -0800 (PST)
X-Google-Smtp-Source: APXvYqy3iwCy7bP7e6NfjLXRRT82iDb6Mi5NXCWXeUBQu8ZeoM18uqn2tMhurYWG6eCqvIq/nZKg1w==
X-Received: by 2002:ac8:4e46:: with SMTP id e6mr2062781qtw.9.1581422318713;
 Tue, 11 Feb 2020 03:58:38 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
 by smtp.gmail.com with ESMTPSA id e64sm2004999qtd.45.2020.02.11.03.58.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2020 03:58:37 -0800 (PST)
Date: Tue, 11 Feb 2020 06:58:33 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [virtio-dev] Re: [PATCH v2 4/5] virtio-mmio: add MSI interrupt
 feature support
Message-ID: <20200211065319-mutt-send-email-mst@kernel.org>
References: <cover.1581305609.git.zhabin@linux.alibaba.com>
 <4c3d13be5a391b1fc50416838de57d903cbf8038.1581305609.git.zhabin@linux.alibaba.com>
 <0c71ff9d-1a7f-cfd2-e682-71b181bdeae4@redhat.com>
 <c42c8b49-5357-f341-2942-ba84afc25437@linux.intel.com>
 <ad96269f-753d-54b8-a4ae-59d1595dd3b2@redhat.com>
 <5522f205-207b-b012-6631-3cc77dde3bfe@linux.intel.com>
 <45e22435-08d3-08fe-8843-d8db02fcb8e3@redhat.com>
MIME-Version: 1.0
In-Reply-To: <45e22435-08d3-08fe-8843-d8db02fcb8e3@redhat.com>
X-MC-Unique: 38XTYdUlMxqRYo25Im8bcw-1
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

On Tue, Feb 11, 2020 at 03:40:23PM +0800, Jason Wang wrote:
>=20
> On 2020/2/11 =E4=B8=8B=E5=8D=882:02, Liu, Jing2 wrote:
> >=20
> >=20
> > On 2/11/2020 12:02 PM, Jason Wang wrote:
> > >=20
> > > On 2020/2/11 =E4=B8=8A=E5=8D=8811:35, Liu, Jing2 wrote:
> > > >=20
> > > > On 2/11/2020 11:17 AM, Jason Wang wrote:
> > > > >=20
> > > > > On 2020/2/10 =E4=B8=8B=E5=8D=885:05, Zha Bin wrote:
> > > > > > From: Liu Jiang<gerry@linux.alibaba.com>
> > > > > >=20
> > > > > > Userspace VMMs (e.g. Qemu microvm, Firecracker) take
> > > > > > advantage of using
> > > > > > virtio over mmio devices as a lightweight machine model for mod=
ern
> > > > > > cloud. The standard virtio over MMIO transport layer
> > > > > > only supports one
> > > > > > legacy interrupt, which is much heavier than virtio over
> > > > > > PCI transport
> > > > > > layer using MSI. Legacy interrupt has long work path and
> > > > > > causes specific
> > > > > > VMExits in following cases, which would considerably slow down =
the
> > > > > > performance:
> > > > > >=20
> > > > > > 1) read interrupt status register
> > > > > > 2) update interrupt status register
> > > > > > 3) write IOAPIC EOI register
> > > > > >=20
> > > > > > We proposed to add MSI support for virtio over MMIO via new fea=
ture
> > > > > > bit VIRTIO_F_MMIO_MSI[1] which increases the interrupt performa=
nce.
> > > > > >=20
> > > > > > With the VIRTIO_F_MMIO_MSI feature bit supported, the virtio-mm=
io MSI
> > > > > > uses msi_sharing[1] to indicate the event and vector mapping.
> > > > > > Bit 1 is 0: device uses non-sharing and fixed vector per
> > > > > > event mapping.
> > > > > > Bit 1 is 1: device uses sharing mode and dynamic mapping.
> > > > >=20
> > > > >=20
> > > > > I believe dynamic mapping should cover the case of fixed vector?
> > > > >=20
> > > > Actually this bit *aims* for msi sharing or msi non-sharing.
> > > >=20
> > > > It means, when msi sharing bit is 1, device doesn't want vector
> > > > per queue
> > > >=20
> > > > (it wants msi vector sharing as name) and doesn't want a high
> > > > interrupt rate.
> > > >=20
> > > > So driver turns to !per_vq_vectors and has to do dynamical mapping.
> > > >=20
> > > > So they are opposite not superset.
> > > >=20
> > > > Thanks!
> > > >=20
> > > > Jing
> > >=20
> > >=20
> > > I think you need add more comments on the command.
> > >=20
> > > E.g if I want to map vector 0 to queue 1, how do I need to do?
> > >=20
> > > write(1, queue_sel);
> > > write(0, vector_sel);
> >=20
> > That's true. Besides, two commands are used for msi sharing mode,
> >=20
> > VIRTIO_MMIO_MSI_CMD_MAP_CONFIG and VIRTIO_MMIO_MSI_CMD_MAP_QUEUE.
> >=20
> > "To set up the event and vector mapping for MSI sharing mode, driver
> > SHOULD write a valid MsiVecSel followed by
> > VIRTIO_MMIO_MSI_CMD_MAP_CONFIG/VIRTIO_MMIO_MSI_CMD_MAP_QUEUE command to
> > map the configuration change/selected queue events respectively.=C2=A0 =
" (See
> > spec patch 5/5)
> >=20
> > So if driver detects the msi sharing mode, when it does setup vq, write=
s
> > the queue_sel (this already exists in setup vq), vector sel and then
> > MAP_QUEUE command to do the queue event mapping.
> >=20
>=20
> So actually the per vq msix could be done through this. I don't get why y=
ou
> need to introduce MSI_SHARING_MASK which is the charge of driver instead =
of
> device. The interrupt rate should have no direct relationship with whethe=
r
> it has been shared or not.
>=20
> Btw, you introduce mask/unmask without pending, how to deal with the lost
> interrupt during the masking then?

pending can be an internal device register. as long as device
does not lose interrupts while masked, all's well.

There's value is being able to say "this queue sends no
interrupts do not bother checking used notification area".
so we need way to say that. So I guess an enable interrupts
register might have some value...
But besides that, it's enough to have mask/unmask/address/data
per vq.


>=20
> > For msi non-sharing mode, no special action is needed because we make
> > the rule of per_vq_vector and fixed relationship.
> >=20
> > Correct me if this is not that clear for spec/code comments.
> >=20
>=20
> The ABI is not as straightforward as PCI did. Why not just reuse the PCI
> layout?
>=20
> E.g having
>=20
> queue_sel
> queue_msix_vector
> msix_config
>=20
> for configuring map between msi vector and queues/config
>=20
> Then
>=20
> vector_sel
> address
> data
> pending
> mask
> unmask
>=20
> for configuring msi table?
>=20
> Thanks
>=20
>=20
> > Thanks!
> >=20
> > Jing
> >=20
> >=20
> > >=20
> > > ?
> > >=20
> > > Thanks
> > >=20
> > >=20
> > > >=20
> > > >=20
> > > > > Thanks
> > > > >=20
> > > > >=20
> > > > >=20
> > > > > -----------------------------------------------------------------=
----
> > > > > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.o=
rg
> > > > > For additional commands, e-mail: virtio-dev-help@lists.oasis-open=
.org
> > > > >=20
> > > >=20
> > >=20


