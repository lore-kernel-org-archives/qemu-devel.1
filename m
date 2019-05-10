Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF6BCC04AB1
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 02:13:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84B0B2183F
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 02:13:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84B0B2183F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35503 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOv1z-0007IR-B2
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 22:13:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1hOv1C-0006yx-Iv
	for qemu-devel@nongnu.org; Thu, 09 May 2019 22:12:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1hOv1B-0003rt-Jt
	for qemu-devel@nongnu.org; Thu, 09 May 2019 22:12:14 -0400
Received: from mga17.intel.com ([192.55.52.151]:54267)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chen.zhang@intel.com>)
	id 1hOv1B-0003np-Ae
	for qemu-devel@nongnu.org; Thu, 09 May 2019 22:12:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
	by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	09 May 2019 19:11:59 -0700
X-ExtLoop1: 1
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
	by orsmga007.jf.intel.com with ESMTP; 09 May 2019 19:11:59 -0700
Received: from fmsmsx120.amr.corp.intel.com (10.18.124.208) by
	FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server
	(TLS) id 14.3.408.0; Thu, 9 May 2019 19:11:59 -0700
Received: from shsmsx106.ccr.corp.intel.com (10.239.4.159) by
	fmsmsx120.amr.corp.intel.com (10.18.124.208) with Microsoft SMTP Server
	(TLS) id 14.3.408.0; Thu, 9 May 2019 19:11:58 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.249]) by
	SHSMSX106.ccr.corp.intel.com ([169.254.10.213]) with mapi id
	14.03.0415.000; Fri, 10 May 2019 10:11:57 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Laurent Vivier <laurent@vivier.eu>, "Dr. David Alan Gilbert"
	<dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, zhanghailiang
	<zhang.zhanghailiang@huawei.com>, Markus Armbruster <armbru@redhat.com>,
	qemu-dev <qemu-devel@nongnu.org>
Thread-Topic: [PATCH 0/3] Optimize COLO related codes and description
Thread-Index: AQHU/BAW19/M3tO3NkWEwIS71wZk1aZjsmmQ
Date: Fri, 10 May 2019 02:11:56 +0000
Message-ID: <9CFF81C0F6B98A43A459C9EDAD400D7806107E13@shsmsx102.ccr.corp.intel.com>
References: <20190426090730.2691-1-chen.zhang@intel.com>
In-Reply-To: <20190426090730.2691-1-chen.zhang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYmNmZWJkMDItMGIzMy00MDBjLWI0MTItNDA3MmM4MWViZDJiIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoibTRaOURtMnF3WUkxQlNtMWw0c1NIRTRUa2o5QUx5ekhGRjdpR3daXC9YUHlWS3NyMWFRK0JlZTgwXC80MTl4WlhGIn0=
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.151
Subject: Re: [Qemu-devel] [PATCH 0/3] Optimize COLO related codes and
 description
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Dave,

I noticed that you have reviewed all the patches in this series, can you qu=
eue it?

Thanks
Zhang Chen


> -----Original Message-----
> From: Zhang, Chen
> Sent: Friday, April 26, 2019 5:07 PM
> To: Laurent Vivier <laurent@vivier.eu>; Dr. David Alan Gilbert
> <dgilbert@redhat.com>; Juan Quintela <quintela@redhat.com>; zhanghailiang
> <zhang.zhanghailiang@huawei.com>; Markus Armbruster
> <armbru@redhat.com>; qemu-dev <qemu-devel@nongnu.org>
> Cc: Zhang Chen <zhangckid@gmail.com>; Zhang, Chen <chen.zhang@intel.com>
> Subject: [PATCH 0/3] Optimize COLO related codes and description
>=20
> From: Zhang Chen <chen.zhang@intel.com>
>=20
> In this series we optimize codes and fix some tiny issues.
>=20
> Zhang Chen (3):
>   migration/colo.c: Remove redundant input parameter
>   migration/colo.h: Remove obsolete codes
>   qemu-option.hx: Update missed parameter for colo-compare
>=20
>  include/migration/colo.h  | 4 +---
>  migration/colo-failover.c | 2 +-
>  migration/colo.c          | 2 +-
>  qemu-options.hx           | 9 ++++++---
>  4 files changed, 9 insertions(+), 8 deletions(-)
>=20
> --
> 2.17.GIT


