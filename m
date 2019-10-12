Return-Path: <SRS0=IrLN=YF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9B7C4360C
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 05:06:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31A5421850
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 05:06:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31A5421850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJ9bU-00021t-AL
	for qemu-devel@archiver.kernel.org; Sat, 12 Oct 2019 01:06:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39177)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qi1.zhang@intel.com>) id 1iJ9af-0001Vw-Dd
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 01:05:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <qi1.zhang@intel.com>) id 1iJ9ad-00080r-Ib
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 01:05:16 -0400
Received: from mga17.intel.com ([192.55.52.151]:17250)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <qi1.zhang@intel.com>) id 1iJ9ac-0007qi-JL
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 01:05:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 11 Oct 2019 22:05:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,286,1566889200"; d="scan'208";a="278342166"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
 by orsmga001.jf.intel.com with ESMTP; 11 Oct 2019 22:05:05 -0700
Received: from fmsmsx113.amr.corp.intel.com (10.18.116.7) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 11 Oct 2019 22:05:04 -0700
Received: from shsmsx103.ccr.corp.intel.com (10.239.4.69) by
 FMSMSX113.amr.corp.intel.com (10.18.116.7) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 11 Oct 2019 22:05:04 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.176]) by
 SHSMSX103.ccr.corp.intel.com ([169.254.4.165]) with mapi id 14.03.0439.000;
 Sat, 12 Oct 2019 13:05:03 +0800
From: "Zhang, Qi1" <qi1.zhang@intel.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH v1 0/2] TM field check failed
Thread-Topic: [PATCH v1 0/2] TM field check failed
Thread-Index: AQHVfYJsDS0JWsT0T0+4XnwWVduvaadWeXdw
Date: Sat, 12 Oct 2019 05:05:02 +0000
Message-ID: <215440059103624D9AD9D1DCACBF45DD3E85CB3D@shsmsx102.ccr.corp.intel.com>
References: <cover.1570498233.git.qi1.zhang@intel.com>
In-Reply-To: <cover.1570498233.git.qi1.zhang@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYzI2YjQ4NDktMmFkZC00Y2RiLTg3YTMtOTdlN2M2ZDQxZWIzIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiMlBXWUZaUlwvYStqK1BleXZ2Vzh0UGRMRkJpdjQ2TFNWanJ4cFFURENYQTBwNkIzeGp5OGQxZWhwXC9cL1RWTkhhNiJ9
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.151
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
Cc: "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "Qi, Yadong" <yadong.qi@intel.com>, "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello, everyone

May I know you have comments on this patch set? Thank you!

BRs
Qi Zhang
> -----Original Message-----
> From: Zhang, Qi1 <qi1.zhang@intel.com>
> Sent: Tuesday, October 8, 2019 10:35 AM
> To: qemu-devel@nongnu.org
> Cc: mst@redhat.com; marcel.apfelbaum@gmail.com; pbonzini@redhat.com;
> rth@twiddle.net; ehabkost@redhat.com; Zhang, Qi1 <qi1.zhang@intel.com>;
> Qi, Yadong <yadong.qi@intel.com>
> Subject: [PATCH v1 0/2] TM field check failed
>=20
> From: "Zhang, Qi" <qi1.zhang@intel.com>
>=20
> spilt the reserved fields arrays and remove TM field from reserved bits
>=20
> Changelog V1:
>   add descriptons
>=20
> Zhang, Qi (2):
>   intel_iommu: split the resevred fields arrays into two ones
>   intel_iommu: TM field should not be in reserved bits
>=20
>  hw/i386/intel_iommu.c          | 35 ++++++++++++++++++++--------------
>  hw/i386/intel_iommu_internal.h | 17 +++++++++++++----
>  2 files changed, 34 insertions(+), 18 deletions(-)
>=20
> --
> 2.20.1


