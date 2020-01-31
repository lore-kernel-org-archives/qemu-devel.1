Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24040C33CB2
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 11:44:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDA18206F0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 11:44:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDA18206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixUiy-0000Ni-73
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 06:44:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45701)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1ixUgm-0006Ol-GC
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 06:42:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1ixUgl-0007Ss-FQ
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 06:42:20 -0500
Received: from mga06.intel.com ([134.134.136.31]:39336)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1ixUgl-0007QZ-6w
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 06:42:19 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 31 Jan 2020 03:42:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,385,1574150400"; d="scan'208";a="323340350"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by fmsmga001.fm.intel.com with ESMTP; 31 Jan 2020 03:42:17 -0800
Received: from shsmsx153.ccr.corp.intel.com (10.239.6.53) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 31 Jan 2020 03:42:16 -0800
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.197]) by
 SHSMSX153.ccr.corp.intel.com ([169.254.12.97]) with mapi id 14.03.0439.000;
 Fri, 31 Jan 2020 19:41:53 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: RE: [RFC v3 07/25] header file update VFIO/IOMMU vSVA APIs
Thread-Topic: [RFC v3 07/25] header file update VFIO/IOMMU vSVA APIs
Thread-Index: AQHV1p1OoTYvvVpt3kqFgb7urV9AkKgBC/CAgAOdaoA=
Date: Fri, 31 Jan 2020 11:41:53 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A1992E4@SHSMSX104.ccr.corp.intel.com>
References: <1580300216-86172-1-git-send-email-yi.l.liu@intel.com>
 <1580300216-86172-8-git-send-email-yi.l.liu@intel.com>
 <20200129132841.6900963f.cohuck@redhat.com>
In-Reply-To: <20200129132841.6900963f.cohuck@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMTZlNTYwNjAtYTNlNC00MjQ1LTlmNzUtMDEwODViMThjYTVjIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiSGFGb0hiNjF0N0g3c2d3UmQrXC8xYXJEeFhib3NhQW1TYkNBXC91dE42SVFXRCs4RXN0eXN0U3BDMWZNT3NpajFCIn0=
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.31
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
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>,
 "Tian, Jun J" <jun.j.tian@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Wu, Hao" <hao.wu@intel.com>,
 "Sun, Yi Y" <yi.y.sun@intel.com>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: kvm-owner@vger.kernel.org [mailto:kvm-owner@vger.kernel.org] On Beh=
alf
> Of Cornelia Huck
> Sent: Wednesday, January 29, 2020 8:29 PM
> To: Liu, Yi L <yi.l.liu@intel.com>
> Subject: Re: [RFC v3 07/25] header file update VFIO/IOMMU vSVA APIs
>=20
> On Wed, 29 Jan 2020 04:16:38 -0800
> "Liu, Yi L" <yi.l.liu@intel.com> wrote:
>=20
> > From: Liu Yi L <yi.l.liu@intel.com>
> >
> > The kernel uapi/linux/iommu.h header file includes the extensions for
> > vSVA support. e.g. bind gpasid, iommu fault report related user
> > structures and etc.
> >
> > Cc: Kevin Tian <kevin.tian@intel.com>
> > Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Cc: Peter Xu <peterx@redhat.com>
> > Cc: Yi Sun <yi.y.sun@linux.intel.com>
> > Cc: Michael S. Tsirkin <mst@redhat.com>
> > Cc: Cornelia Huck <cohuck@redhat.com>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > ---
> >  linux-headers/linux/iommu.h | 372
> > ++++++++++++++++++++++++++++++++++++++++++++
> >  linux-headers/linux/vfio.h  | 148 ++++++++++++++++++
> >  2 files changed, 520 insertions(+)
> >  create mode 100644 linux-headers/linux/iommu.h
>=20
> Please add a note that this is to be replaced with a full headers update,=
 so that it
> doesn't get missed :)

Exactly, thanks for the reminder. I expect to have a full headers update wh=
en
the whole vSVA series is accepted. :-)

Thanks,
Yi Liu


