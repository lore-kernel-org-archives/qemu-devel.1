Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E079C3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 07:43:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41EF520870
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 07:43:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41EF520870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9lAW-0005Gj-FO
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 02:43:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40389)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kevin.tian@intel.com>) id 1j9l9j-0004ig-Py
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 02:42:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kevin.tian@intel.com>) id 1j9l9i-0006Cb-2o
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 02:42:55 -0500
Received: from mga02.intel.com ([134.134.136.20]:6540)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kevin.tian@intel.com>)
 id 1j9l9h-00067s-Ob; Thu, 05 Mar 2020 02:42:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 04 Mar 2020 23:42:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,517,1574150400"; d="scan'208";a="259101461"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by orsmga002.jf.intel.com with ESMTP; 04 Mar 2020 23:42:47 -0800
Received: from fmsmsx116.amr.corp.intel.com (10.18.116.20) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 4 Mar 2020 23:42:47 -0800
Received: from shsmsx108.ccr.corp.intel.com (10.239.4.97) by
 fmsmsx116.amr.corp.intel.com (10.18.116.20) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 4 Mar 2020 23:42:46 -0800
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.206]) by
 SHSMSX108.ccr.corp.intel.com ([169.254.8.235]) with mapi id 14.03.0439.000;
 Thu, 5 Mar 2020 15:42:44 +0800
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: RE: [PATCH v16 00/10] VIRTIO-IOMMU device
Thread-Topic: [PATCH v16 00/10] VIRTIO-IOMMU device
Thread-Index: AQHV4zqd/jWB2C+M5UeA/xtNxWrsyqgucl6AgAAqcACAByzBAIAAaY+AgAFXAoCAACrFAIAAh6qAgAEu9sD//8jdgIAAiFHg
Date: Thu, 5 Mar 2020 07:42:44 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D7BE360@SHSMSX104.ccr.corp.intel.com>
References: <20200214132745.23392-1-eric.auger@redhat.com>
 <20200227111717.GG1645630@redhat.com>
 <431cb39d-833c-6d02-d7b3-02b3e90446e2@redhat.com>
 <CAMj5Bkib3CTzCB02ScueFR84r28LGowF7uxYO8Ygmnj9X7oNOg@mail.gmail.com>
 <fea625f1-b58e-6da6-8e2a-f32fc9391fc8@redhat.com>
 <CAMj5Bkgm1LKbN3E2qTTxmrGhpmdL9NWarSfX-mYCWF0yt5E9eg@mail.gmail.com>
 <88e3b669-2998-41c0-83f7-de42a72a73e7@redhat.com>
 <20200304164717.GF646000@myrica>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D7BDFBB@SHSMSX104.ccr.corp.intel.com>
 <20200305073417.GA717767@myrica>
In-Reply-To: <20200305073417.GA717767@myrica>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMmM2NTc0YmYtMzcyZi00NWU0LWFhYjItNDRmNDZmZjFkM2NkIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiQjNiK0ZFcjIzWXp0RWtvT3hMemZDRTg1c0QrcGkxaWJ4UjNJRlRiRzZjejlNZ3NFZjZKbDArRWZ0eW04T25xUCJ9
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.20
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 "kenneth-lee-2012@foxmail.com" <kenneth-lee-2012@foxmail.com>,
 "tnowicki@marvell.com" <tnowicki@marvell.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "quintela@redhat.com" <quintela@redhat.com>,
 "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 Auger Eric <eric.auger@redhat.com>,
 "bharatb.linux@gmail.com" <bharatb.linux@gmail.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "Wangzhou \(B\)" <wangzhou1@hisilicon.com>,
 Zhangfei Gao <zhangfei.gao@gmail.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Sent: Thursday, March 5, 2020 3:34 PM
>=20
> On Thu, Mar 05, 2020 at 02:56:20AM +0000, Tian, Kevin wrote:
> > > From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > Sent: Thursday, March 5, 2020 12:47 AM
> > >
> > [...]
> > > > >
> > > > > * We can't use DVM in nested mode unless the VMID is shared with
> the
> > > > > CPU. For that we'll need the host SMMU driver to hook into the KV=
M
> > > VMID
> > > > > allocator, just like we do for the ASID allocator. I haven't yet
> > > > > investigated how to do that. It's possible to do vSVA without DVM
> > > > > though, by sending all TLB invalidations through the SMMU command
> > > queue.
> > > > > "
> > >
> > > Hm we're already mandating DVM for host SVA, so I'd say mandate it fo=
r
> > > vSVA as well. We'd avoid a ton of context switches, especially for th=
e zip
> > > accelerator which doesn't require ATC invalidations. The host needs t=
o
> pin
> > > the VMID allocated by KVM and write it in the endpoint's STE.
> > >
> >
> > Curious... what is DVM and how is it related to SVA? Is it SMMU specifi=
c?
>=20
> Yes it stands for "Distributed Virtual Memory", an Arm interconnect
> protocol. When sharing a process address space, TLB invalidations from th=
e
> CPU are broadcasted to the SMMU, so we don't have to send commands
> through
> the SMMU queue to invalidate IOTLBs. However ATCs from PCIe endpoints
> do
> not participate in DVM and still have to be invalidated by hand.
>=20

ah, got it. Thanks for explanation!

