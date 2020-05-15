Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E77FC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 23:48:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEBC020657
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 23:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="mi94eL1N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEBC020657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZk4J-0000Gu-2i
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 19:48:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60540)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kevin.tian@intel.com>)
 id 1jZk3d-0008ER-BB
 for qemu-devel@nongnu.org; Fri, 15 May 2020 19:48:01 -0400
Received: from mga04.intel.com ([192.55.52.120]:36335)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kevin.tian@intel.com>)
 id 1jZk3a-0003SQ-L8
 for qemu-devel@nongnu.org; Fri, 15 May 2020 19:48:00 -0400
IronPort-SDR: jm8fpsiSvpyUahX++o8h5IePllFzLh5pd+t348Cx54AgWzErsMa7MN3k9B8+rGGi+ZtMfg4cga
 hl/nKE8Kz6Yg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2020 16:47:45 -0700
IronPort-SDR: y+W6JxcCyxWaFuwjzCMvk8mjMuextMOA5Goee+zgfOoKq+3A+/0+VYM/rSGcYq52f77dFGu6dz
 OdhIpvVdtikA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,396,1583222400"; d="scan'208";a="342158148"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
 by orsmga001.jf.intel.com with ESMTP; 15 May 2020 16:47:45 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 15 May 2020 16:47:44 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 15 May 2020 16:47:37 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 15 May 2020 16:47:37 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Fri, 15 May 2020 16:47:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UuVFTyQd/ybdAtMsfd6+orUhlwin0nXui2fYje4C/3U1f+M6/tRxDvPRp7Q6xEQUGm+BgJ3mi6vMeT6nEqGq2ysP4eJCdI/HX2PfzQzWdZ+7GqKRvt8IzI9ccJuimjQON7znF6id2qvtFwCVndPBIkSCpUuusTiDNOcgyEutULTXE5Yx46XD1nXBjpEdBY9s9/mEqTyfREYl+UOa9drkP9Mc6TOfDpTkwJeKEPIZboPGr6mwS/iNT+MRafXkFc9h+UwM85svXA/cp4kExdWa3Nfowdajgy4Xd73YxDc9xLlA0iB5kud/78Rpg8bjVZSuZj+RxObg0RQ0voVB1amZew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l7igEPUibxdiab/930pemJWPB/unxoGni0pXXsKKkvo=;
 b=jlQLEpOUVwWgIVc6Hue9WPK1SyKpClxtBGmLAx+d6r3ZJ4e0YigIJiwi0GI4/+v2uX4FAN2TT/r0tTcgSUgm3Kg/VycAltDp7ZQpXKcmpCmu6f/hir+tnl6K1FXk1c/HuqGe2d8eaWpMlc0FMuuNtw4MppTIgOP4Bv1ushWlpdFNWSaVHZ/jcqfv2OLWzKKFBUPpyuCxO6MK4qrj6FSYHXQWtWDsxCsznwz+R6JG3pXjvDmBBUTbHjIspHIZsrcsvEoTJtqh6JWcw1u6JkY43D0WK1aQkszi1vaE8wi+rAuONPzAst4/UB86wGNrVChK6hMggW58YRvz5q6o322zsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l7igEPUibxdiab/930pemJWPB/unxoGni0pXXsKKkvo=;
 b=mi94eL1NFYBsxkyNjgIaz8Zw30p7zZ+pO1t6ce862O9kNKOukzwSXBWDowf3rvM7FA8zZrCT+K9HU6vawYc5WeSAJ+pynNc4N419Du0d7a3ElNqU7vG44BGFQW3rBrKbQCNYRyoYp8TAA3SnfRNnKrLk25Js1FoZ2lwp+0Sz7Tc=
Received: from MWHPR11MB1645.namprd11.prod.outlook.com (2603:10b6:301:b::12)
 by MWHPR11MB0063.namprd11.prod.outlook.com (2603:10b6:301:6c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.24; Fri, 15 May
 2020 23:47:35 +0000
Received: from MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::b441:f6bd:703b:ba41]) by MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::b441:f6bd:703b:ba41%2]) with mapi id 15.20.3000.022; Fri, 15 May 2020
 23:47:35 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Kirti Wankhede <kwankhede@nvidia.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "cjia@nvidia.com" <cjia@nvidia.com>
Subject: RE: [PATCH Kernel v21 0/8] Add UAPIs to support migration for VFIO
 devices
Thread-Topic: [PATCH Kernel v21 0/8] Add UAPIs to support migration for VFIO
 devices
Thread-Index: AQHWKwJgK1FmT5Zjw0O/2+4X3jyq6aipz7lQ
Date: Fri, 15 May 2020 23:47:35 +0000
Message-ID: <MWHPR11MB1645A0F74E796E809174ED608CBD0@MWHPR11MB1645.namprd11.prod.outlook.com>
References: <1589577203-20640-1-git-send-email-kwankhede@nvidia.com>
In-Reply-To: <1589577203-20640-1-git-send-email-kwankhede@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.52.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f7058f5-aef7-4f20-f9db-08d7f92a5804
x-ms-traffictypediagnostic: MWHPR11MB0063:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB006300A4C6803AD1EA5C324A8CBD0@MWHPR11MB0063.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 04041A2886
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tjpoe+ihfcKQxZrEGpdf0V/0BuiEXPNUQPeXa9Tfp6O2P5dNl/hI60i9SHYnlpvmUl/D8MskDde2zJ5IxPg5IHPJwejOpfwOxq852TDHACCgfiOFfXrOxEnQXIpIX231JnW7f546k4fCGxqncWNpokIhPOrGO/iqjHa5ylb4YuLItS8mCsOTcKM76jXKjCljASxpVLFZmUk+mVahsE/D37fyhudHzYgE/JSWXHKOkyWEnV87EHrZUYimfAzLWkmhPsuUB0uQ+3ep9sbeDYGdv3ZvQCF/a9AHCelKxZi2J46mk8ysLmmccmx+76GN2G1jwE4ePmJ8bHCdimhcK0vO4dDhtKGAgrn60WVdh7KC/Q34EKEOyveksICidtriFouetOLbpNPrxprzzAgYXibswVc23gtaIl32KOm+jyuF+jAj4tV8boYskXvMgHzAHWgP6lHUPLZeQVHcwE5wKeMsVfqjF6zwd7eir3xZ8AuvdmBtElPyFWeTQ6OEYPRAs3wTkvI/QvTcL+vx3ZuRPdRb0w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1645.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(396003)(39860400002)(366004)(136003)(346002)(376002)(64756008)(66946007)(54906003)(33656002)(26005)(6506007)(66446008)(186003)(71200400001)(66556008)(7416002)(2906002)(5660300002)(478600001)(966005)(66476007)(86362001)(8936002)(7696005)(4326008)(76116006)(55016002)(52536014)(9686003)(316002)(8676002)(110136005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: b/a14nS8F7PIviY+m/1r6zr0QUwFM32ZOALcx9ATJ5XB5dXV2IL36/Zj6PmvLQBdikgE9ohnXzjjs5LM6cu4b8/mHWtHMQvta8lu/4xj9cV1JDoPq0X5PpdP0UYOMAz5kP62Spe8U1GkVvmZTx4Nvfq0OKjFIbhJB+bwDaUnA6xoCKTFC7Rkg6gaHqqXqBAt16tN/tLn9VyxBtuDIOnLHgoYfximMMFwu3Js4oNkDi8Kde5LdSwAPJPWJjuYc6m+i4RuGYl+ElXfkR2ii3Uc6dVePPWRLKZQC256Cjh0d9WeS595on7/aYlLaSCihT4ERhZsWtrNUmROXIDtePUJjKsahNsYAsDm1MACfKv7JbFOqlUFrqy4kwt17Lk5Z++eytAC43B7pyZlzGR0cYmX4W9IEEX5fjITZZSMLRqQ5yBj8R7Wgnkycw4mtDIMtaWTSukduZDAxQ9jvmdPTqcrcWk2jhJASmmGLL6KAOfUTYoSbIjCM3Fv4HQ1lzyI9/66
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f7058f5-aef7-4f20-f9db-08d7f92a5804
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2020 23:47:35.5129 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JxE7RFNrprc+9pkN3KU9Re4euIquuQxkpZvl5wlRRuaxsS+9CCMn/SrKf0OQndd9sYxgQF+c8KXVxxqrv9KA4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB0063
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.120; envelope-from=kevin.tian@intel.com;
 helo=mga04.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 19:47:46
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: "Zhengxiao.zx@Alibaba-inc.com" <Zhengxiao.zx@Alibaba-inc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Liu,
 Yi L" <yi.l.liu@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "eskultet@redhat.com" <eskultet@redhat.com>, "Yang,
 Ziye" <ziye.yang@intel.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
 "shuangtai.tst@alibaba-inc.com" <shuangtai.tst@alibaba-inc.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>, "Wang, 
 Zhi A" <zhi.a.wang@intel.com>, "mlevitsk@redhat.com" <mlevitsk@redhat.com>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "aik@ozlabs.ru" <aik@ozlabs.ru>,
 "eauger@redhat.com" <eauger@redhat.com>,
 "felipe@nutanix.com" <felipe@nutanix.com>,
 "jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>, "Liu,
 Changpeng" <changpeng.liu@intel.com>, "Ken.Xue@amd.com" <Ken.Xue@amd.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, Kirti,

Will you send out a new version in Qemu side, or previous v16 still applies=
?

Thanks
Kevin

> From: Kirti Wankhede
> Sent: Saturday, May 16, 2020 5:13 AM
>=20
> Hi,
>=20
> This patch set adds:
> * IOCTL VFIO_IOMMU_DIRTY_PAGES to get dirty pages bitmap with
>   respect to IOMMU container rather than per device. All pages pinned by
>   vendor driver through vfio_pin_pages external API has to be marked as
>   dirty during  migration. When IOMMU capable device is present in the
>   container and all pages are pinned and mapped, then all pages are marke=
d
>   dirty.
>   When there are CPU writes, CPU dirty page tracking can identify dirtied
>   pages, but any page pinned by vendor driver can also be written by
>   device. As of now there is no device which has hardware support for
>   dirty page tracking. So all pages which are pinned should be considered
>   as dirty.
>   This ioctl is also used to start/stop dirty pages tracking for pinned a=
nd
>   unpinned pages while migration is active.
>=20
> * Updated IOCTL VFIO_IOMMU_UNMAP_DMA to get dirty pages bitmap
> before
>   unmapping IO virtual address range.
>   With vIOMMU, during pre-copy phase of migration, while CPUs are still
>   running, IO virtual address unmap can happen while device still keeping
>   reference of guest pfns. Those pages should be reported as dirty before
>   unmap, so that VFIO user space application can copy content of those
>   pages from source to destination.
>=20
> * Patch 8 detect if IOMMU capable device driver is smart to report pages
>   to be marked dirty by pinning pages using vfio_pin_pages() API.
>=20
>=20
> Yet TODO:
> Since there is no device which has hardware support for system memmory
> dirty bitmap tracking, right now there is no other API from vendor driver
> to VFIO IOMMU module to report dirty pages. In future, when such
> hardware
> support will be implemented, an API will be required such that vendor
> driver could report dirty pages to VFIO module during migration phases.
>=20
> Adding revision history from previous QEMU patch set to understand KABI
> changes done till now
>=20
> v20 -> v21
> - Added checkin for GET_BITMAP ioctl for vfio_dma boundaries.
> - Updated unmap ioctl function - as suggested by Alex.
> - Updated comments in DIRTY_TRACKING ioctl definition - as suggested by
>   Cornelia.
>=20
> v19 -> v20
> - Fixed ioctl to get dirty bitmap to get bitmap of multiple vfio_dmas
> - Fixed unmap ioctl to get dirty bitmap of multiple vfio_dmas.
> - Removed flag definition from migration capability.
>=20
> v18 -> v19
> - Updated migration capability with supported page sizes bitmap for dirty
>   page tracking and  maximum bitmap size supported by kernel module.
> - Added patch to calculate and cache pgsize_bitmap when iommu-
> >domain_list
>   is updated.
> - Removed extra buffers added in previous version for bitmap manipulation
>   and optimised the code.
>=20
> v17 -> v18
> - Add migration capability to the capability chain for
> VFIO_IOMMU_GET_INFO
>   ioctl
> - Updated UMAP_DMA ioctl to return bitmap of multiple vfio_dma
>=20
> v16 -> v17
> - Fixed errors reported by kbuild test robot <lkp@intel.com> on i386
>=20
> v15 -> v16
> - Minor edits and nit picks (Auger Eric)
> - On copying bitmap to user, re-populated bitmap only for pinned pages,
>   excluding unmapped pages and CPU dirtied pages.
> - Patches are on tag: next-20200318 and 1-3 patches from Yan's series
>   https://lkml.org/lkml/2020/3/12/1255
>=20
> v14 -> v15
> - Minor edits and nit picks.
> - In the verification of user allocated bitmap memory, added check of
>    maximum size.
> - Patches are on tag: next-20200318 and 1-3 patches from Yan's series
>   https://lkml.org/lkml/2020/3/12/1255
>=20
> v13 -> v14
> - Added struct vfio_bitmap to kabi. updated structure
>   vfio_iommu_type1_dirty_bitmap_get and vfio_iommu_type1_dma_unmap.
> - All small changes suggested by Alex.
> - Patches are on tag: next-20200318 and 1-3 patches from Yan's series
>   https://lkml.org/lkml/2020/3/12/1255
>=20
> v12 -> v13
> - Changed bitmap allocation in vfio_iommu_type1 to per vfio_dma
> - Changed VFIO_IOMMU_DIRTY_PAGES ioctl behaviour to be per vfio_dma
> range.
> - Changed vfio_iommu_type1_dirty_bitmap structure to have separate data
>   field.
>=20
> v11 -> v12
> - Changed bitmap allocation in vfio_iommu_type1.
> - Remove atomicity of ref_count.
> - Updated comments for migration device state structure about error
>   reporting.
> - Nit picks from v11 reviews
>=20
> v10 -> v11
> - Fix pin pages API to free vpfn if it is marked as unpinned tracking pag=
e.
> - Added proposal to detect if IOMMU capable device calls external pin pag=
es
>   API to mark pages dirty.
> - Nit picks from v10 reviews
>=20
> v9 -> v10:
> - Updated existing VFIO_IOMMU_UNMAP_DMA ioctl to get dirty pages
> bitmap
>   during unmap while migration is active
> - Added flag in VFIO_IOMMU_GET_INFO to indicate driver support dirty page
>   tracking.
> - If iommu_mapped, mark all pages dirty.
> - Added unpinned pages tracking while migration is active.
> - Updated comments for migration device state structure with bit
>   combination table and state transition details.
>=20
> v8 -> v9:
> - Split patch set in 2 sets, Kernel and QEMU.
> - Dirty pages bitmap is queried from IOMMU container rather than from
>   vendor driver for per device. Added 2 ioctls to achieve this.
>=20
> v7 -> v8:
> - Updated comments for KABI
> - Added BAR address validation check during PCI device's config space loa=
d
>   as suggested by Dr. David Alan Gilbert.
> - Changed vfio_migration_set_state() to set or clear device state flags.
> - Some nit fixes.
>=20
> v6 -> v7:
> - Fix build failures.
>=20
> v5 -> v6:
> - Fix build failure.
>=20
> v4 -> v5:
> - Added decriptive comment about the sequence of access of members of
>   structure vfio_device_migration_info to be followed based on Alex's
>   suggestion
> - Updated get dirty pages sequence.
> - As per Cornelia Huck's suggestion, added callbacks to VFIODeviceOps to
>   get_object, save_config and load_config.
> - Fixed multiple nit picks.
> - Tested live migration with multiple vfio device assigned to a VM.
>=20
> v3 -> v4:
> - Added one more bit for _RESUMING flag to be set explicitly.
> - data_offset field is read-only for user space application.
> - data_size is read for every iteration before reading data from migratio=
n,
>   that is removed assumption that data will be till end of migration
>   region.
> - If vendor driver supports mappable sparsed region, map those region
>   during setup state of save/load, similarly unmap those from cleanup
>   routines.
> - Handles race condition that causes data corruption in migration region
>   during save device state by adding mutex and serialiaing save_buffer an=
d
>   get_dirty_pages routines.
> - Skip called get_dirty_pages routine for mapped MMIO region of device.
> - Added trace events.
> - Split into multiple functional patches.
>=20
> v2 -> v3:
> - Removed enum of VFIO device states. Defined VFIO device state with 2
>   bits.
> - Re-structured vfio_device_migration_info to keep it minimal and defined
>   action on read and write access on its members.
>=20
> v1 -> v2:
> - Defined MIGRATION region type and sub-type which should be used with
>   region type capability.
> - Re-structured vfio_device_migration_info. This structure will be placed
>   at 0th offset of migration region.
> - Replaced ioctl with read/write for trapped part of migration region.
> - Added both type of access support, trapped or mmapped, for data section
>   of the region.
> - Moved PCI device functions to pci file.
> - Added iteration to get dirty page bitmap until bitmap for all requested
>   pages are copied.
>=20
> Thanks,
> Kirti
>=20
>=20
>=20
> Kirti Wankhede (8):
>   vfio: UAPI for migration interface for device state
>   vfio iommu: Remove atomicity of ref_count of pinned pages
>   vfio iommu: Cache pgsize_bitmap in struct vfio_iommu
>   vfio iommu: Add ioctl definition for dirty pages tracking
>   vfio iommu: Implementation of ioctl for dirty pages tracking
>   vfio iommu: Update UNMAP_DMA ioctl to get dirty bitmap before unmap
>   vfio iommu: Add migration capability to report supported features
>   vfio: Selective dirty page tracking if IOMMU backed device pins pages
>=20
>  drivers/vfio/vfio.c             |  13 +-
>  drivers/vfio/vfio_iommu_type1.c | 569
> ++++++++++++++++++++++++++++++++++++----
>  include/linux/vfio.h            |   4 +-
>  include/uapi/linux/vfio.h       | 315 ++++++++++++++++++++++
>  4 files changed, 842 insertions(+), 59 deletions(-)
>=20
> --
> 2.7.0


