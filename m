Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A500C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 14:24:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72C2722244
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 14:24:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72C2722244
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUsYd-00083d-6N
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 10:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40748)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1kUsXR-0007Ai-P9; Tue, 20 Oct 2020 10:22:57 -0400
Received: from mga09.intel.com ([134.134.136.24]:28766)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1kUsXO-0007iJ-Aj; Tue, 20 Oct 2020 10:22:57 -0400
IronPort-SDR: MVyTYVvJkt55xHocMz2O/sywcwWt/Rb2TetNptpzSO3R6UZyftsRY5sVoOhO1Tbh+aoT+IFPqA
 mdKJRMJzdrAQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9779"; a="167333558"
X-IronPort-AV: E=Sophos;i="5.77,397,1596524400"; d="scan'208";a="167333558"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2020 07:22:46 -0700
IronPort-SDR: KzAQepGVWaI+/qBP7cTvU7u9nLm+6DFHsHHZ9ZdCayxgRWwo2LU0lmcv3RRlTg7uzptn8jSQJJ
 re3igYZB6cCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,397,1596524400"; d="scan'208";a="422517259"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by fmsmga001.fm.intel.com with ESMTP; 20 Oct 2020 07:22:46 -0700
Received: from shsmsx603.ccr.corp.intel.com (10.109.6.143) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 20 Oct 2020 07:22:45 -0700
Received: from shsmsx601.ccr.corp.intel.com (10.109.6.141) by
 SHSMSX603.ccr.corp.intel.com (10.109.6.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 20 Oct 2020 22:22:44 +0800
Received: from shsmsx601.ccr.corp.intel.com ([10.109.6.141]) by
 SHSMSX601.ccr.corp.intel.com ([10.109.6.141]) with mapi id 15.01.1713.004;
 Tue, 20 Oct 2020 22:22:44 +0800
From: "Wang, Wei W" <wei.w.wang@intel.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: RE: Question on Compression for Raw Image
Thread-Topic: Question on Compression for Raw Image
Thread-Index: Adamfp2lUlxQj0EMRyaTLkAdXyA8Qf//6umA//8QuPA=
Date: Tue, 20 Oct 2020 14:22:43 +0000
Message-ID: <6124d55766e4477299a5796a002276a0@intel.com>
References: <516589845d6f42d0b00784d16b59b5dc@intel.com>
 <20201020080051.GA4452@merkur.fritz.box>
In-Reply-To: <20201020080051.GA4452@merkur.fritz.box>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.239.127.36]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=134.134.136.24; envelope-from=wei.w.wang@intel.com;
 helo=mga09.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 10:22:47
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "lersek@redhat.com" <lersek@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tuesday, October 20, 2020 4:01 PM, Kevin Wolf wrote:
> Am 20.10.2020 um 03:31 hat Wang, Wei W geschrieben:
> > Hi,
> >
> > Does anyone know the reason why raw-format.c doesn't have
> compression
> > support (but qcow has the supported added)?  For example, raw image
> > backup with compression, "qemu-img convert -c -O raw origin.img
> > dist.img", doesn't work.
>=20
> A raw image is by definition a file that contains the exact same sequence=
 of
> bytes as the guest sees, without any additional information or encoding. =
If
> you compress a raw file, the guest will see compressed data on its hard d=
isk
> instead of the real data.

Ok, thanks. I'm thinking QEMU could do decompression of the compressed data=
 in raw.img when guest reads data.

>=20
> Anything you could do to add transparent compression to it would mean tha=
t
> it's not a raw image any more, but a new image format.
>=20
Yes, decompression makes it transparent to the guest. Would you think it's =
good to reuse the raw image implementation, just add the compress/decompres=
s option?

Thanks,
Wei

