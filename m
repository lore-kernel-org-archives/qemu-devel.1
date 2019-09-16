Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 423A1C4CEC7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 01:52:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 179F72067D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 01:52:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 179F72067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9gC2-00018P-6w
	for qemu-devel@archiver.kernel.org; Sun, 15 Sep 2019 21:52:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47032)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kevin.tian@intel.com>) id 1i9gBM-0000cR-Mi
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 21:52:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kevin.tian@intel.com>) id 1i9gBK-0007rq-EU
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 21:51:59 -0400
Received: from mga09.intel.com ([134.134.136.24]:55483)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kevin.tian@intel.com>)
 id 1i9gBK-0007r8-6L
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 21:51:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 15 Sep 2019 18:51:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,510,1559545200"; d="scan'208";a="193309394"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
 by FMSMGA003.fm.intel.com with ESMTP; 15 Sep 2019 18:51:48 -0700
Received: from fmsmsx119.amr.corp.intel.com (10.18.124.207) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 15 Sep 2019 18:51:48 -0700
Received: from shsmsx105.ccr.corp.intel.com (10.239.4.158) by
 FMSMSX119.amr.corp.intel.com (10.18.124.207) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 15 Sep 2019 18:51:48 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.32]) by
 SHSMSX105.ccr.corp.intel.com ([169.254.11.23]) with mapi id 14.03.0439.000;
 Mon, 16 Sep 2019 09:51:46 +0800
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Wang <jasowang@redhat.com>
Thread-Topic: vhost, iova, and dirty page tracking
Thread-Index: AdVsLg/AAnCsYtAES/qfxc77B9v7gQ==
Date: Mon, 16 Sep 2019 01:51:46 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D577BEA@SHSMSX104.ccr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNWZhOTM3MzUtYzk2MC00MzhiLWJkZWQtMDJiZjBjZTY1ZGZhIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiK09TQm5uU1Q2WURHdG1wbG45Y0VTeFJYYmJFbDV3XC9YZlFkSXdMXC9EM0hLVEVReE13NFBuUGdydkZMTFd4b1VRIn0=
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.24
Subject: [Qemu-devel] vhost, iova, and dirty page tracking
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
Cc: "Alex Williamson
 \(alex.williamson@redhat.com\)" <alex.williamson@redhat.com>, "Zhao,
 Yan Y" <yan.y.zhao@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, Jason

We had a discussion about dirty page tracking in VFIO, when vIOMMU
is enabled:

https://lists.nongnu.org/archive/html/qemu-devel/2019-09/msg02690.html

It's actually a similar model as vhost - Qemu cannot interpose the fast-pat=
h
DMAs thus relies on the kernel part to track and report dirty page informat=
ion.
Currently Qemu tracks dirty pages in GFN level, thus demanding a translatio=
n
from IOVA to GPA. Then the open in our discussion is where this translation
should happen. Doing the translation in kernel implies a device iotlb flavo=
r,
which is what vhost implements today. It requires potentially large trackin=
g
structures in the host kernel, but leveraging the existing log_sync flow in=
 Qemu.
On the other hand, Qemu may perform log_sync for every removal of IOVA
mapping and then do the translation itself, then avoiding the GPA awareness
in the kernel side. It needs some change to current Qemu log-sync flow, and=
=20
may bring more overhead if IOVA is frequently unmapped.

So we'd like to hear about your opinions, especially about how you came
down to the current iotlb approach for vhost.=20

p.s. Alex's comment is also copied here from original thread.

> So vhost must then be configuring a listener across system memory
> rather than only against the device AddressSpace like we do in vfio,
> such that it get's log_sync() callbacks for the actual GPA space rather
> than only the IOVA space.  OTOH, QEMU could understand that the device
> AddressSpace has a translate function and apply the IOVA dirty bits to
> the system memory AddressSpace.  Wouldn't it make more sense for
> QEMU
> to perform a log_sync() prior to removing a MemoryRegionSection within
> an AddressSpace and update the GPA rather than pushing GPA awareness
> and potentially large tracking structures into the host kernel?

Thanks
Kevin

