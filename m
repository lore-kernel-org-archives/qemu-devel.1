Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5049EC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 12:16:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 214D120714
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 12:16:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 214D120714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJFoW-0001iI-8b
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 08:16:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33421)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1jJFn3-0000HD-CV
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 08:14:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1jJFn1-00049G-Mu
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 08:14:44 -0400
Received: from mga05.intel.com ([192.55.52.43]:58741)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1jJFn1-00047a-Dg
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 08:14:43 -0400
IronPort-SDR: bJD5kVQdGA0pFEI8AfwMa85UrC8m9+29v2F3ocQqy6ItAxiTAYjFIOeGAQB3krh1QIbYKj1kDX
 no5OmoJSknzg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2020 05:14:39 -0700
IronPort-SDR: c/jlAASeeo0D7kvxdr2lVtRZVL9ME7VTbiviH+twBhyeGW5bh/L6Rctv5SYK1q1Zy4PcaYbWo0
 OnwnjyEdy7Zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,327,1580803200"; d="scan'208";a="448652713"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
 by fmsmga005.fm.intel.com with ESMTP; 31 Mar 2020 05:14:39 -0700
Received: from fmsmsx117.amr.corp.intel.com (10.18.116.17) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 31 Mar 2020 05:14:39 -0700
Received: from shsmsx105.ccr.corp.intel.com (10.239.4.158) by
 fmsmsx117.amr.corp.intel.com (10.18.116.17) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 31 Mar 2020 05:14:39 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.225]) by
 SHSMSX105.ccr.corp.intel.com ([169.254.11.213]) with mapi id 14.03.0439.000;
 Tue, 31 Mar 2020 20:14:35 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Auger Eric <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>
Subject: RE: [PATCH v2 06/22] hw/pci: introduce
 pci_device_set/unset_iommu_context()
Thread-Topic: [PATCH v2 06/22] hw/pci: introduce
 pci_device_set/unset_iommu_context()
Thread-Index: AQHWBkpmHXYvTlvRRkmnYpsj2ZFsFqhg3xyAgAG8g4A=
Date: Tue, 31 Mar 2020 12:14:35 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A21AE8C@SHSMSX104.ccr.corp.intel.com>
References: <1585542301-84087-1-git-send-email-yi.l.liu@intel.com>
 <1585542301-84087-7-git-send-email-yi.l.liu@intel.com>
 <01381db5-6f5f-8022-6891-e1a8dd7c3e65@redhat.com>
In-Reply-To: <01381db5-6f5f-8022-6891-e1a8dd7c3e65@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 192.55.52.43
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
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "mst@redhat.com" <mst@redhat.com>, "Tian, 
 Jun J" <jun.j.tian@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Wu, Hao" <hao.wu@intel.com>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Eric,

> From: Auger Eric < eric.auger@redhat.com>
> Sent: Tuesday, March 31, 2020 1:30 AM
> To: Liu, Yi L <yi.l.liu@intel.com>; qemu-devel@nongnu.org;
> Subject: Re: [PATCH v2 06/22] hw/pci: introduce
> pci_device_set/unset_iommu_context()
>=20
> Yi,
> On 3/30/20 6:24 AM, Liu Yi L wrote:
> > This patch adds pci_device_set/unset_iommu_context() to set/unset
> > host_iommu_context for a given device. New callback is added in
> > PCIIOMMUOps. As such, vIOMMU could make use of host IOMMU capability.
> > e.g setup nested translation.
>=20
> I think you need to explain what this practically is supposed to do.
> such as: by attaching such context to a PCI device (for example VFIO
> assigned?), you tell the host that this PCIe device is protected by a FL
> stage controlled by the guest or something like that - if this is
> correct understanding (?) -

I'd like to say by attaching such context to a PCI device (for
example VFIO assigned), this PCIe device is protected by a host
IOMMU w/ nested-translation capability. Its DMA would be protected
either through the FL stage controlled by the guest together with
a SL stage page table owned by host or a single stage page table
owned by host (e.g. shadow solution). It depends on the choice of
vIOMMU the pci_device_set/unset_iommu_context() finally pass the
context to vIOMMU. If vIOMMU binds guest FL stage page table to host,
then it is prior case. If vIOMMU doesn't, do bind, then it is the
latter case.

Regards,
Yi Liu


