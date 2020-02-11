Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FFF4C352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 14:01:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFEB820873
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 14:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HU2KY7bX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFEB820873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1W6j-0006mg-W6
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 09:01:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45682)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j1W5f-0006A3-21
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 09:00:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j1W5Z-0007bs-Fs
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 09:00:38 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43063
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j1W5Z-0007bT-Br
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 09:00:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581429632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GahyNX71xRCfgVkTazCQzAG6WFA576akn0f6aQEUGi0=;
 b=HU2KY7bXKPAfzSCcYo2Cby8gjDZL+diu8ky/FDj//0mWxPW7LbmxovNnl/vhfx6jOfb/vu
 nTq58kfJ3pk1PEdIkzR8dBDT3Mn7iqvP+nT7p7Wr58fYbKz46N1HmiS+R81xKnP0wE/Ob+
 iZl+v9ysLVawTRzMz2IGff6Qg/V4HMk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-71-5fnFyc0fMm2Qgkiu_Kzhvg-1; Tue, 11 Feb 2020 09:00:28 -0500
Received: by mail-qv1-f72.google.com with SMTP id z9so7171350qvo.10
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 06:00:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=IiJCNKCKara6122SLriCEZQxiJm9yQK9HeliuKGXOc0=;
 b=L2omrmDUyNg1cYs//CKs84i4KBmn50D+jNZjK9MbHoWWhVU29y86fd7ES8/PB0406b
 7793I+YcKHBtLzJkLD6xlZ5bOwDz5HfHHocxw9y6YtmCm3Am0g7oqomFhqtyeSOSKfJm
 sdkLw4SZRTdsEACmkqWV73uYJ21cO2Vrze57LOY97KQGyTc/O7gChXk9ezYE2fI2MlTm
 UuHmDjXriDkvjtxYVtC8jBCi6CInmWwbwXLM/ypzVHf00vF3RubUjhnc/8iHR5FLFYS9
 /5OmbvPZ8zfY67ARLR1ebSB/g2cokCXJaBDmcL+wybVTdsfKK5/lDz7he69yJ99IeSTo
 laTg==
X-Gm-Message-State: APjAAAUnzH2ICwChe098wfrTK5w/ZkEwHt7/m37FUqKaRIicap6JmRMJ
 GOWIOx1mvtIM0DTSbRk2gSvfq23bWtNhMhCPAOnWXEfWcaeidl9ueTQVIS95HLRG0ZxjevBslC0
 sg0D8AVdbg6iOuOA=
X-Received: by 2002:ac8:38e6:: with SMTP id g35mr15121164qtc.120.1581429627220; 
 Tue, 11 Feb 2020 06:00:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqzul9u4swtFOk02v4Rwi5cC4SpS1I1htVnEFQL+BCn8ZrTnpx5sW3iqgZ6OFG5Lv6LVBMzmXQ==
X-Received: by 2002:ac8:38e6:: with SMTP id g35mr15121130qtc.120.1581429626863; 
 Tue, 11 Feb 2020 06:00:26 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
 by smtp.gmail.com with ESMTPSA id t23sm2118020qto.88.2020.02.11.06.00.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2020 06:00:26 -0800 (PST)
Date: Tue, 11 Feb 2020 09:00:21 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [virtio-dev] Re: [PATCH v2 4/5] virtio-mmio: add MSI interrupt
 feature support
Message-ID: <20200211090003-mutt-send-email-mst@kernel.org>
References: <4c3d13be5a391b1fc50416838de57d903cbf8038.1581305609.git.zhabin@linux.alibaba.com>
 <0c71ff9d-1a7f-cfd2-e682-71b181bdeae4@redhat.com>
 <c42c8b49-5357-f341-2942-ba84afc25437@linux.intel.com>
 <ad96269f-753d-54b8-a4ae-59d1595dd3b2@redhat.com>
 <5522f205-207b-b012-6631-3cc77dde3bfe@linux.intel.com>
 <45e22435-08d3-08fe-8843-d8db02fcb8e3@redhat.com>
 <20200211065319-mutt-send-email-mst@kernel.org>
 <c4a78a15-c889-df3f-3e1e-7df1a4d67838@redhat.com>
 <20200211070523-mutt-send-email-mst@kernel.org>
 <fdb19ef4-2003-6c6f-5c6f-c757a6320130@redhat.com>
MIME-Version: 1.0
In-Reply-To: <fdb19ef4-2003-6c6f-5c6f-c757a6320130@redhat.com>
X-MC-Unique: 5fnFyc0fMm2Qgkiu_Kzhvg-1
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

On Tue, Feb 11, 2020 at 08:18:54PM +0800, Jason Wang wrote:
>=20
> On 2020/2/11 =E4=B8=8B=E5=8D=888:08, Michael S. Tsirkin wrote:
> > On Tue, Feb 11, 2020 at 08:04:24PM +0800, Jason Wang wrote:
> > > On 2020/2/11 =E4=B8=8B=E5=8D=887:58, Michael S. Tsirkin wrote:
> > > > On Tue, Feb 11, 2020 at 03:40:23PM +0800, Jason Wang wrote:
> > > > > On 2020/2/11 =E4=B8=8B=E5=8D=882:02, Liu, Jing2 wrote:
> > > > > > On 2/11/2020 12:02 PM, Jason Wang wrote:
> > > > > > > On 2020/2/11 =E4=B8=8A=E5=8D=8811:35, Liu, Jing2 wrote:
> > > > > > > > On 2/11/2020 11:17 AM, Jason Wang wrote:
> > > > > > > > > On 2020/2/10 =E4=B8=8B=E5=8D=885:05, Zha Bin wrote:
> > > > > > > > > > From: Liu Jiang<gerry@linux.alibaba.com>
> > > > > > > > > >=20
> > > > > > > > > > Userspace VMMs (e.g. Qemu microvm, Firecracker) take
> > > > > > > > > > advantage of using
> > > > > > > > > > virtio over mmio devices as a lightweight machine model=
 for modern
> > > > > > > > > > cloud. The standard virtio over MMIO transport layer
> > > > > > > > > > only supports one
> > > > > > > > > > legacy interrupt, which is much heavier than virtio ove=
r
> > > > > > > > > > PCI transport
> > > > > > > > > > layer using MSI. Legacy interrupt has long work path an=
d
> > > > > > > > > > causes specific
> > > > > > > > > > VMExits in following cases, which would considerably sl=
ow down the
> > > > > > > > > > performance:
> > > > > > > > > >=20
> > > > > > > > > > 1) read interrupt status register
> > > > > > > > > > 2) update interrupt status register
> > > > > > > > > > 3) write IOAPIC EOI register
> > > > > > > > > >=20
> > > > > > > > > > We proposed to add MSI support for virtio over MMIO via=
 new feature
> > > > > > > > > > bit VIRTIO_F_MMIO_MSI[1] which increases the interrupt =
performance.
> > > > > > > > > >=20
> > > > > > > > > > With the VIRTIO_F_MMIO_MSI feature bit supported, the v=
irtio-mmio MSI
> > > > > > > > > > uses msi_sharing[1] to indicate the event and vector ma=
pping.
> > > > > > > > > > Bit 1 is 0: device uses non-sharing and fixed vector pe=
r
> > > > > > > > > > event mapping.
> > > > > > > > > > Bit 1 is 1: device uses sharing mode and dynamic mappin=
g.
> > > > > > > > > I believe dynamic mapping should cover the case of fixed =
vector?
> > > > > > > > >=20
> > > > > > > > Actually this bit*aims*  for msi sharing or msi non-sharing=
.
> > > > > > > >=20
> > > > > > > > It means, when msi sharing bit is 1, device doesn't want ve=
ctor
> > > > > > > > per queue
> > > > > > > >=20
> > > > > > > > (it wants msi vector sharing as name) and doesn't want a hi=
gh
> > > > > > > > interrupt rate.
> > > > > > > >=20
> > > > > > > > So driver turns to !per_vq_vectors and has to do dynamical =
mapping.
> > > > > > > >=20
> > > > > > > > So they are opposite not superset.
> > > > > > > >=20
> > > > > > > > Thanks!
> > > > > > > >=20
> > > > > > > > Jing
> > > > > > > I think you need add more comments on the command.
> > > > > > >=20
> > > > > > > E.g if I want to map vector 0 to queue 1, how do I need to do=
?
> > > > > > >=20
> > > > > > > write(1, queue_sel);
> > > > > > > write(0, vector_sel);
> > > > > > That's true. Besides, two commands are used for msi sharing mod=
e,
> > > > > >=20
> > > > > > VIRTIO_MMIO_MSI_CMD_MAP_CONFIG and VIRTIO_MMIO_MSI_CMD_MAP_QUEU=
E.
> > > > > >=20
> > > > > > "To set up the event and vector mapping for MSI sharing mode, d=
river
> > > > > > SHOULD write a valid MsiVecSel followed by
> > > > > > VIRTIO_MMIO_MSI_CMD_MAP_CONFIG/VIRTIO_MMIO_MSI_CMD_MAP_QUEUE co=
mmand to
> > > > > > map the configuration change/selected queue events respectively=
.=C2=A0 " (See
> > > > > > spec patch 5/5)
> > > > > >=20
> > > > > > So if driver detects the msi sharing mode, when it does setup v=
q, writes
> > > > > > the queue_sel (this already exists in setup vq), vector sel and=
 then
> > > > > > MAP_QUEUE command to do the queue event mapping.
> > > > > >=20
> > > > > So actually the per vq msix could be done through this. I don't g=
et why you
> > > > > need to introduce MSI_SHARING_MASK which is the charge of driver =
instead of
> > > > > device. The interrupt rate should have no direct relationship wit=
h whether
> > > > > it has been shared or not.
> > > > >=20
> > > > > Btw, you introduce mask/unmask without pending, how to deal with =
the lost
> > > > > interrupt during the masking then?
> > > > pending can be an internal device register. as long as device
> > > > does not lose interrupts while masked, all's well.
> > >=20
> > > You meant raise the interrupt during unmask automatically?
> > >=20
> >=20
> > yes - that's also what pci does.
> >=20
> > the guest visible pending bit is partially implemented in qemu
> > as per pci spec but it's unused.
>=20
>=20
> Ok.
>=20
>=20
> >=20
> > > > There's value is being able to say "this queue sends no
> > > > interrupts do not bother checking used notification area".
> > > > so we need way to say that. So I guess an enable interrupts
> > > > register might have some value...
> > > > But besides that, it's enough to have mask/unmask/address/data
> > > > per vq.
> > >=20
> > > Just to check, do you mean "per vector" here?
> > >=20
> > > Thanks
> > >=20
> > No, per VQ. An indirection VQ -> vector -> address/data isn't
> > necessary for PCI either, but that ship has sailed.
>=20
>=20
> Yes, it can work but it may bring extra effort when you want to mask a
> vector which is was shared by a lot of queues.
>=20
> Thanks
>=20

masking should be per vq too.

--=20
MST


