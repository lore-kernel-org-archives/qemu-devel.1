Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA400C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 09:19:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E2C520714
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 09:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eGb111jh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E2C520714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1oAq-0004KZ-JI
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 04:19:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45200)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j1o8a-0001ja-6l
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 04:16:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j1o8Y-0007gL-Jq
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 04:16:52 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22086
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j1o8Y-0007g2-Fj
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 04:16:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581499009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5oPFW//rfYqitXpF7UFR4CjTBiftc64vYEWBsVfVPNw=;
 b=eGb111jhqlzsmRIe2bBflAqIL3J+vxNV/Zz39CZMOkzGiQg0iyX07Y1dZJoCtDCZf6OO04
 eSJAgFpUqmJd9v0YSrWCsXMm6TJPVrD+eGJfzCjhzssQpShvQV3Imyr/tlj3uI88QBEl5N
 BEZ2B8Y+oovgx7v0+RoaHHSjbPZfk/U=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-1jwA1S85OXu4r-QNNkqX6w-1; Wed, 12 Feb 2020 04:16:45 -0500
Received: by mail-qk1-f197.google.com with SMTP id d134so954028qkc.0
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 01:16:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=eOrcxBN3Ffsr7y2F9lFDNYIJNDU6sv9JJHCKV3qJVyo=;
 b=DJVkg1mOK65l0KxmwOdGUO37CxzVE8Sk2pNrttzGGOa9uYPdKimcC8/+EacBLTW8V0
 UWMbuQdHqXHNqA8REVlK5Ke5fNJayM/wmYDMYJANYbTNrl+sAgNH3M9e9BTC1LvQu8I6
 TlTu72YyQ8QOxWRbPVZomgg04zsgqKfNVgaaEnQ9y4hCauMkCP7KEy1ZP8F3lWObR0qx
 iMBaT++A4KuZzvoEu5Jm+lo0WoH9bJRMk5JVjFID7kmtZx4UVQXzejJj/A6orFntq36A
 cVKpicrdwnwY93v/60ZCQEVL6mPolT9z3heSeD3gb0HGUzZ1phaYP3MyqiwGWoLEZRxD
 4IhA==
X-Gm-Message-State: APjAAAU3gEAWzXbYxJkzrMzoIF884Uv+/k/YutIoa3KRcQwhM5gKqDwW
 2ps/LgFQeT5MBXiwWIdGgPihvwV7OjfZudW4r/l1pHC4F6oMh3OT0tb687nVLdVAVqT0oQftU9b
 OcqEpOpIaTFQsaWA=
X-Received: by 2002:a37:9dc8:: with SMTP id g191mr9962490qke.171.1581499005212; 
 Wed, 12 Feb 2020 01:16:45 -0800 (PST)
X-Google-Smtp-Source: APXvYqwZMeIgD1zES4kwmMJQQIP9axRnL04ygcXLc51UT8hgfY5e+hXRM88XDUs9E6jjUdXBNgLa0w==
X-Received: by 2002:a37:9dc8:: with SMTP id g191mr9962473qke.171.1581499004928; 
 Wed, 12 Feb 2020 01:16:44 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
 by smtp.gmail.com with ESMTPSA id k50sm3874242qtc.90.2020.02.12.01.16.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2020 01:16:44 -0800 (PST)
Date: Wed, 12 Feb 2020 04:16:39 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [virtio-dev] Re: [PATCH v2 4/5] virtio-mmio: add MSI interrupt
 feature support
Message-ID: <20200212041554-mutt-send-email-mst@kernel.org>
References: <cover.1581305609.git.zhabin@linux.alibaba.com>
 <4c3d13be5a391b1fc50416838de57d903cbf8038.1581305609.git.zhabin@linux.alibaba.com>
 <0c71ff9d-1a7f-cfd2-e682-71b181bdeae4@redhat.com>
 <c42c8b49-5357-f341-2942-ba84afc25437@linux.intel.com>
 <ad96269f-753d-54b8-a4ae-59d1595dd3b2@redhat.com>
 <5522f205-207b-b012-6631-3cc77dde3bfe@linux.intel.com>
 <45e22435-08d3-08fe-8843-d8db02fcb8e3@redhat.com>
 <4c19292f-9d25-a859-3dde-6dd5a03fdf0b@linux.intel.com>
 <44209f3c-613c-3766-ca83-321b77b0f0dd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <44209f3c-613c-3766-ca83-321b77b0f0dd@redhat.com>
X-MC-Unique: 1jwA1S85OXu4r-QNNkqX6w-1
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

On Wed, Feb 12, 2020 at 05:06:52PM +0800, Jason Wang wrote:
>=20
> On 2020/2/12 =E4=B8=8A=E5=8D=8811:54, Liu, Jing2 wrote:
> >=20
> >=20
> > On 2/11/2020 3:40 PM, Jason Wang wrote:
> > >=20
> > > On 2020/2/11 =E4=B8=8B=E5=8D=882:02, Liu, Jing2 wrote:
> > > >=20
> > > >=20
> > > > On 2/11/2020 12:02 PM, Jason Wang wrote:
> > > > >=20
> > > > > On 2020/2/11 =E4=B8=8A=E5=8D=8811:35, Liu, Jing2 wrote:
> > > > > >=20
> > > > > > On 2/11/2020 11:17 AM, Jason Wang wrote:
> > > > > > >=20
> > > > > > > On 2020/2/10 =E4=B8=8B=E5=8D=885:05, Zha Bin wrote:
> > > > > > > > From: Liu Jiang<gerry@linux.alibaba.com>
> > > > > > > >=20
> > > > > > > > Userspace VMMs (e.g. Qemu microvm, Firecracker)
> > > > > > > > take advantage of using
> > > > > > > > virtio over mmio devices as a lightweight machine model for=
 modern
> > > > > > > > cloud. The standard virtio over MMIO transport
> > > > > > > > layer only supports one
> > > > > > > > legacy interrupt, which is much heavier than
> > > > > > > > virtio over PCI transport
> > > > > > > > layer using MSI. Legacy interrupt has long work
> > > > > > > > path and causes specific
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
> > > > > > > > With the VIRTIO_F_MMIO_MSI feature bit
> > > > > > > > supported, the virtio-mmio MSI
> > > > > > > > uses msi_sharing[1] to indicate the event and vector mappin=
g.
> > > > > > > > Bit 1 is 0: device uses non-sharing and fixed
> > > > > > > > vector per event mapping.
> > > > > > > > Bit 1 is 1: device uses sharing mode and dynamic mapping.
> > > > > > >=20
> > > > > > >=20
> > > > > > > I believe dynamic mapping should cover the case of fixed vect=
or?
> > > > > > >=20
> > > > > > Actually this bit *aims* for msi sharing or msi non-sharing.
> > > > > >=20
> > > > > > It means, when msi sharing bit is 1, device doesn't want
> > > > > > vector per queue
> > > > > >=20
> > > > > > (it wants msi vector sharing as name) and doesn't want a
> > > > > > high interrupt rate.
> > > > > >=20
> > > > > > So driver turns to !per_vq_vectors and has to do dynamical mapp=
ing.
> > > > > >=20
> > > > > > So they are opposite not superset.
> > > > > >=20
> > > > > > Thanks!
> > > > > >=20
> > > > > > Jing
> > > > >=20
> > > > >=20
> > > > > I think you need add more comments on the command.
> > > > >=20
> > > > > E.g if I want to map vector 0 to queue 1, how do I need to do?
> > > > >=20
> > > > > write(1, queue_sel);
> > > > > write(0, vector_sel);
> > > >=20
> > > > That's true. Besides, two commands are used for msi sharing mode,
> > > >=20
> > > > VIRTIO_MMIO_MSI_CMD_MAP_CONFIG and VIRTIO_MMIO_MSI_CMD_MAP_QUEUE.
> > > >=20
> > > > "To set up the event and vector mapping for MSI sharing mode,
> > > > driver SHOULD write a valid MsiVecSel followed by
> > > > VIRTIO_MMIO_MSI_CMD_MAP_CONFIG/VIRTIO_MMIO_MSI_CMD_MAP_QUEUE
> > > > command to map the configuration change/selected queue events
> > > > respectively.=C2=A0 " (See spec patch 5/5)
> > > >=20
> > > > So if driver detects the msi sharing mode, when it does setup
> > > > vq, writes the queue_sel (this already exists in setup vq),
> > > > vector sel and then MAP_QUEUE command to do the queue event
> > > > mapping.
> > > >=20
> > >=20
> > > So actually the per vq msix could be done through this.
> >=20
> > Right, per vq msix can also be mapped by the 2 commands if we want.
> >=20
> > The current design benefits for those devices requesting per vq msi tha=
t
> > driver
> >=20
> > doesn't have to map during setup each queue,
> >=20
> > since we define the relationship by default.
> >=20
>=20
> Well since you've defined the dynamic mapping, having some "default" mapp=
ing
> won't help to reduce the complexity but increase it.
>=20
>=20
> >=20
> > > I don't get why you need to introduce MSI_SHARING_MASK which is the
> > > charge of driver instead of device.
> >=20
> > MSI_SHARING_MASK is just for identifying the msi_sharing bit in
> > readl(MsiState) (0x0c4). The device tells whether it wants msi_sharing.
> >=20
> > MsiState register: R
> >=20
> > le32 {
> > =C2=A0=C2=A0=C2=A0 msi_enabled : 1;
> > =C2=A0=C2=A0=C2=A0 msi_sharing: 1;
> > =C2=A0=C2=A0=C2=A0 reserved : 30;
> > };
> >=20
>=20
> The question is why device want such information.
>=20
>=20
> >=20
> > > The interrupt rate should have no direct relationship with whether
> > > it has been shared or not.
> >=20
> > >=20
> > > Btw, you introduce mask/unmask without pending, how to deal with the
> > > lost interrupt during the masking then?
> > >=20
> > >=20
> > > > For msi non-sharing mode, no special action is needed because we
> > > > make the rule of per_vq_vector and fixed relationship.
> > > >=20
> > > > Correct me if this is not that clear for spec/code comments.
> > > >=20
> > >=20
> > > The ABI is not as straightforward as PCI did. Why not just reuse the
> > > PCI layout?
> > >=20
> > > E.g having
> > >=20
> > > queue_sel
> > > queue_msix_vector
> > > msix_config
> > >=20
> > > for configuring map between msi vector and queues/config
> >=20
> > Thanks for the advice. :)
> >=20
> > Actually when looking into pci, the queue_msix_vector/msix_config is th=
e
> > msi vector index, which is the same as the mmio register MsiVecSel
> > (0x0d0).
> >=20
> > So we don't introduce two extra registers for mapping even in sharing
> > mode.
> >=20
> > What do you think?
> >=20
>=20
> I'm not sure I get the point, but I still prefer the separate vector_sel
> from queue_msix_vector.
>=20
> Btw, Michael propose per vq registers which could also work.
>=20
> Thanks
>=20

Right and I'd even ask a question: do we need shared MSI at all?
Is it somehow better than legacy interrupt? And why?
Performance numbers please.

> >=20
> > >=20
> > > Then
> > >=20
> > > vector_sel
> > > address
> > > data
> > > pending
> > > mask
> > > unmask
> > >=20
> > > for configuring msi table?
> >=20
> > PCI-like msix table is not introduced to device and instead simply use
> > commands to tell the mask/configure/enable.
> >=20
> > Thanks!
> >=20
> > Jing
> >=20
> > >=20
> > > Thanks
> > >=20
> > >=20
> > > > Thanks!
> > > >=20
> > > > Jing
> > > >=20
> > > >=20
> > > > >=20
> > > > > ?
> > > > >=20
> > > > > Thanks
> > > > >=20
> > > > >=20
> > > > > >=20
> > > > > >=20
> > > > > > > Thanks
> > > > > > >=20
> > > > > > >=20
> > > > > > >=20
> > > > > > > -------------------------------------------------------------=
--------
> > > > > > >=20
> > > > > > > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-op=
en.org
> > > > > > > For additional commands, e-mail:
> > > > > > > virtio-dev-help@lists.oasis-open.org
> > > > > > >=20
> > > > > >=20
> > > > >=20
> > >=20


