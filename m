Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA94C3B187
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 13:57:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E96202086A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 13:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h1hmd8W+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E96202086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1W29-0004wM-5J
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 08:57:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44708)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j1W1T-0004IV-IK
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 08:56:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j1W1S-0002Az-0N
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 08:56:19 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44624
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j1W1R-00029o-Rd
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 08:56:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581429377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ot+mSjZekSIpzP1S4N0YD3kSgoELPn+R2PsVJWhPUVQ=;
 b=h1hmd8W+YpCFAtdogpnQegylHFLrCjSCRhjME7o5J3yyhiZzFrT7eaO3aJWwPmUhHI9ovt
 MCFngeBQB6faaOiu61pm/BLOlfoV5rZMXa+5MUt4eGrFsIDRQWXXHLR7k/pW1ewXDzPkFE
 RgUR4V2Z+K+yA/luen/ymX6ZL9tY1A8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-06yauQnsNFqH17T_UUiQzw-1; Tue, 11 Feb 2020 08:56:13 -0500
Received: by mail-qt1-f200.google.com with SMTP id x8so6592744qtq.14
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 05:56:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=/ZGSSd0qAWCCAIXhhuQYtsSqOzZMu1jV05CPY04Wpc8=;
 b=EZuFuTLnkxUtyQbRF8Bg18Zt2HLt8c1FTlo0cTC/Ogl7v7ZqrQmD/+JJNn+XgeSQQW
 YR/KGRjF5PmYn+mpIENur57Ua+/Lh+XY7aM2YmE8qWKlsCaKDLYQeogFraQngXZluYH3
 iNluV+jlC6v+3LtpXn7mV/WitwruSg5R6M3cvgxJfCA1N0Oi0pomnfCGG5tb60vJOLZ8
 LVQH5YEZw2D+mGOjjkDY7W3fzICauD5uFoitRMRblWsgTg3p26pTB8sREfozIqfUGRSk
 x2jnUcT/38/c8HW7ebSgD+XQCf5uQi17agjJ40L4/da+HduO1vJbuYxnvKCZaYCFOFwZ
 Q/sw==
X-Gm-Message-State: APjAAAVC4M+saodK9ENiczRcFW6fzli6mQQQPu++4puP9NmO4a5dKh8V
 ZQ+YxKQK3iEi79txYRurVD1qwSOtdDw/0gmcaIqGpK5JiC8EMll8b+7PSlA8COXLSKzLFRMnDri
 hxjIyWkirVcJtCr4=
X-Received: by 2002:ac8:365c:: with SMTP id n28mr2494736qtb.260.1581429373062; 
 Tue, 11 Feb 2020 05:56:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqx8K8WUtYh12q1yplM3i4ec/zzVvKratI3IylDR8gUDHiCSd+sGD6TcEP/iJSgNWSmCla1GfQ==
X-Received: by 2002:ac8:365c:: with SMTP id n28mr2494718qtb.260.1581429372758; 
 Tue, 11 Feb 2020 05:56:12 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
 by smtp.gmail.com with ESMTPSA id g53sm2178305qtk.76.2020.02.11.05.56.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2020 05:56:11 -0800 (PST)
Date: Tue, 11 Feb 2020 08:56:06 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v15 0/9] VIRTIO-IOMMU device
Message-ID: <20200211085526-mutt-send-email-mst@kernel.org>
References: <20200208120022.1920-1-eric.auger@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200208120022.1920-1-eric.auger@redhat.com>
X-MC-Unique: 06yauQnsNFqH17T_UUiQzw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: peter.maydell@linaro.org, kevin.tian@intel.com, tnowicki@marvell.com,
 jean-philippe@linaro.org, quintela@redhat.com, qemu-devel@nongnu.org,
 peterx@redhat.com, dgilbert@redhat.com, bharatb.linux@gmail.com,
 qemu-arm@nongnu.org, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Feb 08, 2020 at 01:00:13PM +0100, Eric Auger wrote:
> This series implements the QEMU virtio-iommu device.
>=20
> This matches the v0.12 spec (voted) and the corresponding
> virtio-iommu driver upstreamed in 5.3. All kernel dependencies
> are resolved for DT integration. The virtio-iommu can be
> instantiated in ARM virt using:
>=20
> "-device virtio-iommu-pci".
>=20
> Non DT mode is not yet supported as it has non resolved kernel
> dependencies [1].
>=20
> This feature targets 5.0.
>=20
> Integration with vhost devices and vfio devices is not part
> of this series. Please follow Bharat's respins [2].
>=20
> Best Regards
>=20
> Eric


Looks good.
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

I can see this merged through ARM tree, or through my tree with
Peters's ack for the ARM bits.


> This series can be found at:
> https://github.com/eauger/qemu/tree/v4.2-virtio-iommu-v15
>=20
> References:
> [1] [RFC 00/13] virtio-iommu on non-devicetree platforms
> [2] [PATCH RFC v5 0/5] virtio-iommu: VFIO integration
>=20
> Testing:
> - tested with guest using virtio-net-pci
>   (,vhost=3Doff,iommu_platform,disable-modern=3Doff,disable-legacy=3Don)
>   and virtio-blk-pci
> - migration
>=20
> History:
>=20
> v14 -> v15:
> - removed x-dt-binding and just kept check on hotplug_handler
> - removed "tests: Add virtio-iommu test" as the check on
>   hotplug_handler fails on PC machine
> - destroy mappings in put_domain and remove
>   g_tree_destroy(domain->mappings) in virtio_iommu_detach
>=20
> v13 -> v14:
> - added "virtio-iommu-pci: Introduce the x-dt-binding option"
> - Removed the mappings gtree ref counting and simply delete
>   the gtree when the last EP is detached from the domain
> - call virtio_iommu_detach_endpoint_from_domain from
>   virtio_iommu_put_endpoint
>=20
> v12 -> v13:
> - Take into account Peter's comments
> - fix qtest error and accomodate for directory changes in
>   test
> - remove "[PATCH v12 01/13] migration: Support QLIST migration"
>   which is now upstream
> - fix iommu_find_iommu_pcibus()
> - squash commits as requested by Peter
> - remove spurious guest log
>=20
> ../..
>=20
> Eric Auger (9):
>   virtio-iommu: Add skeleton
>   virtio-iommu: Decode the command payload
>   virtio-iommu: Implement attach/detach command
>   virtio-iommu: Implement map/unmap
>   virtio-iommu: Implement translate
>   virtio-iommu: Implement fault reporting
>   virtio-iommu-pci: Add virtio iommu pci support
>   hw/arm/virt: Add the virtio-iommu device tree mappings
>   virtio-iommu: Support migration
>=20
>  hw/arm/virt.c                    |  57 +-
>  hw/virtio/Kconfig                |   5 +
>  hw/virtio/Makefile.objs          |   2 +
>  hw/virtio/trace-events           |  20 +
>  hw/virtio/virtio-iommu-pci.c     | 103 ++++
>  hw/virtio/virtio-iommu.c         | 890 +++++++++++++++++++++++++++++++
>  include/hw/arm/virt.h            |   2 +
>  include/hw/pci/pci.h             |   1 +
>  include/hw/virtio/virtio-iommu.h |  61 +++
>  qdev-monitor.c                   |   1 +
>  10 files changed, 1135 insertions(+), 7 deletions(-)
>  create mode 100644 hw/virtio/virtio-iommu-pci.c
>  create mode 100644 hw/virtio/virtio-iommu.c
>  create mode 100644 include/hw/virtio/virtio-iommu.h
>=20
> --=20
> 2.20.1


