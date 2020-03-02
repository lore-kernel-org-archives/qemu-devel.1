Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6181AC3F2D2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 07:01:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CBF1246C3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 07:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HstC6MTE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CBF1246C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8f5H-0004o8-74
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 02:01:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55558)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1j8f4D-0004H9-3I
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 02:00:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1j8f4B-0006nk-JP
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 02:00:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34117
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1j8f44-0006ll-M5
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 02:00:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583132432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pJPHW/B4K/ertS9fqXtY7QcFEbntxL3B6NcflKIdZrc=;
 b=HstC6MTE3bvSCAvFTLxVuaEyZbhb61wDJKrmYXnOIvcpfaGuD7HGdCN7IjfYyifU9PTqbQ
 NXfdInhNcMueyHT3WFdFmiLIezNJABjGUuq5sxiCPTO52HxP8zocM58KF4PUfPrnOlbUdt
 Sv8CFFJ6k8lxISSLop8JXFmwv2xAEMQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-L4rHQvSfPH-H1DD393_o6w-1; Mon, 02 Mar 2020 02:00:24 -0500
X-MC-Unique: L4rHQvSfPH-H1DD393_o6w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42213107B274;
 Mon,  2 Mar 2020 07:00:22 +0000 (UTC)
Received: from [10.36.116.59] (ovpn-116-59.ams2.redhat.com [10.36.116.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5E82010027AB;
 Mon,  2 Mar 2020 07:00:05 +0000 (UTC)
Subject: Re: [Qemu-devel] [PATCH RFC v5 0/5] virtio-iommu: VFIO integration
To: Bharat Bhushan <bharatb.yadav@gmail.com>
References: <20181127064101.25887-1-Bharat.Bhushan@nxp.com>
 <2a788c05-cd9b-1e69-14dd-864633a1df95@redhat.com>
 <CAHS=5b3g_6rHzFvF4-RDu2cn_tsP4TmJp+rFxPgiWpo-2kdnYA@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <7393a1e7-d5ea-c87f-6f36-6e4e8ad2d8e7@redhat.com>
Date: Mon, 2 Mar 2020 08:00:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAHS=5b3g_6rHzFvF4-RDu2cn_tsP4TmJp+rFxPgiWpo-2kdnYA@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "drjones@redhat.com" <drjones@redhat.com>,
 Tomasz Nowicki <tnowicki@marvell.com>, "mst@redhat.com" <mst@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Bharat Bhushan <bharatb.linux@gmail.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "linu.cherian@cavium.com" <linu.cherian@cavium.com>,
 "linuc.decode@gmail.com" <linuc.decode@gmail.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Bharat,

On 3/2/20 6:12 AM, Bharat Bhushan wrote:
>=20
> Hi Eric,=C2=A0
>=20
> On Fri, Feb 28, 2020 at 3:06 PM Auger Eric <eric.auger@redhat.com
> <mailto:eric.auger@redhat.com>> wrote:
>=20
>     Hi Bharat,
>=20
>     On 11/27/18 7:52 AM, Bharat Bhushan wrote:
>     > This patch series integrates VFIO with virtio-iommu. This is
>     > tested with assigning 2 pci devices to Virtual Machine.
>     >
>     > This version is mainly about rebasing on v9 version on
>     > virtio-iommu device framework from Eric Augur.
>     >
>     > This patch series allows PCI pass-through using virtio-iommu.
>     >
>     > This series is based on:
>     >=C2=A0 - virtio-iommu kernel driver by Jean-Philippe Brucker
>     >=C2=A0 =C2=A0 =C2=A0[PATCH v5 0/7] Add virtio-iommu driver
>     >=C2=A0 =C2=A0 =C2=A0git://linux-arm.org/kvmtool-jpb.git
>     <http://linux-arm.org/kvmtool-jpb.git> virtio-iommu/v0.9
>     >
>     >=C2=A0 - virtio-iommu device emulation by Eric Augur.
>     >=C2=A0 =C2=A0 [RFC,v9,00/17] VIRTIO-IOMMU device
>     >=C2=A0 =C2=A0 https://github.com/eauger/qemu/tree/v3.1.0-rc2-virtio-=
iommu-v0.9
>=20
>     Now we have the driver and the base qemu device upstream we may resum=
e
>     this activity to complete the VFIO integration. Do you intend the
>     respin? Otherwise let me know if you want me to help.
>=20
>=20
> Yes Eric, I am planning to respin the changes.
>=20
> Can you please point to latest changes (qemu/Linux both).
the driver and the base qemu device are upstream. This only boots in DT
mode at the moment with machvirt. Use -virtio-iommu-pci to instantiate
the device. About the qemu device, you will find latest changes in the
v16 history log: https://patchwork.kernel.org/cover/11382271/

Thanks

Eric

>=20
> Thanks
> -Bharat
>=20
>     Thanks
>=20
>     Eric
>     >
>     > v4->v5:
>     >=C2=A0 - Rebase to v9 version from Eric
>     >=C2=A0 - PCIe device hotplug fix
>     >=C2=A0 - Added Patch 1/5 from Eric previous series (Eric somehow dro=
pped in
>     >=C2=A0 =C2=A0 last version.
>     >=C2=A0 - Patch "Translate the MSI doorbell in kvm_arch_fixup_msi_rou=
te"
>     >=C2=A0 =C2=A0 already integrated with vsmmu3
>     >
>     > v3->v4:
>     >=C2=A0 - Rebase to v4 version from Eric
>     >=C2=A0 - Fixes from Eric with DPDK in VM
>     >=C2=A0 - Logical division in multiple patches
>     >
>     > v2->v3:
>     >=C2=A0 - This series is based on "[RFC v3 0/8] VIRTIO-IOMMU device"
>     >=C2=A0 =C2=A0 Which is based on top of v2.10-rc0 that
>     >=C2=A0 - Fixed issue with two PCI devices
>     >=C2=A0 - Addressed review comments
>     >
>     > v1->v2:
>     >=C2=A0 =C2=A0- Added trace events
>     >=C2=A0 =C2=A0- removed vSMMU3 link in patch description
>     >
>     > Bharat Bhushan (4):
>     >=C2=A0 =C2=A0virtio-iommu: Add iommu notifier for iommu-map/unmap
>     >=C2=A0 =C2=A0virtio-iommu: Call iommu notifier on attach/detach
>     >=C2=A0 =C2=A0virtio-iommu: add virtio-iommu replay
>     >=C2=A0 =C2=A0virtio-iommu: handle IOMMU Notifier flag changes
>     >
>     > Eric Auger (1):
>     >=C2=A0 =C2=A0hw/vfio/common: Do not print error when viommu translat=
es into
>     an mmio
>     >=C2=A0 =C2=A0 =C2=A0region
>     >
>     >=C2=A0 hw/vfio/common.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 -
>     >=C2=A0 hw/virtio/trace-events=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A05 +
>     >=C2=A0 hw/virtio/virtio-iommu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 1=
90
>     ++++++++++++++++++++++++++++++-
>     >=C2=A0 include/hw/virtio/virtio-iommu.h |=C2=A0 =C2=A06 +
>     >=C2=A0 4 files changed, 198 insertions(+), 5 deletions(-)
>     >
>=20
>=20
>=20
> --=20
> -Bharat


