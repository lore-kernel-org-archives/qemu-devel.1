Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D707EC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 01:00:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE07120885
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 01:00:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE07120885
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfvI0-0003g1-Tr
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 21:00:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33904)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1jfvHQ-0003Bu-Dn
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 20:59:48 -0400
Received: from mga12.intel.com ([192.55.52.136]:34277)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1jfvHM-0001qj-Ej
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 20:59:47 -0400
IronPort-SDR: MSdpfg/FHT2iQ5go0S4TJySK0x7ibWTDOB6usR8yQVsAIsH11b+a0/MN1ayaT1YRErpFutSvrx
 giWy6c3+RLiA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2020 17:59:38 -0700
IronPort-SDR: DQD46fTD3ShFbQmudHsWGUn6HOoyPlCsim+6ctfV9kZCVnJFC6eKvL87aVe8Bb4LqsrRBlript
 HeLw/PYnbpDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,462,1583222400"; d="scan'208";a="415994537"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
 by orsmga004.jf.intel.com with ESMTP; 01 Jun 2020 17:59:38 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 1 Jun 2020 17:59:37 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 SHSMSX605.ccr.corp.intel.com (10.109.6.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 2 Jun 2020 08:59:35 +0800
Received: from shsmsx605.ccr.corp.intel.com ([10.109.6.215]) by
 SHSMSX605.ccr.corp.intel.com ([10.109.6.215]) with mapi id 15.01.1713.004;
 Tue, 2 Jun 2020 08:59:35 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Lukas Straub <lukasstraub2@web.de>, Alberto Garcia <berto@igalia.com>
Subject: RE: [PATCH] block/quorum.c: Decrease child index when del_child
Thread-Topic: [PATCH] block/quorum.c: Decrease child index when del_child
Thread-Index: AQHWN+aTrP+1AKdhD06H7tqE9iXzWajDC60AgAB+swCAAPeNAA==
Date: Tue, 2 Jun 2020 00:59:35 +0000
Message-ID: <764ae861837f4aa798e01d84dea4d4b3@intel.com>
References: <20200601071956.18006-1-chen.zhang@intel.com>
 <w515zcbm5p3.fsf@maestria.local.igalia.com> <20200601201200.10e2ea59@luklap>
In-Reply-To: <20200601201200.10e2ea59@luklap>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.36]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=192.55.52.136; envelope-from=chen.zhang@intel.com;
 helo=mga12.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/01 20:59:38
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Jason Wang <jasowang@redhat.com>, qemu-dev <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Zhang Chen <zhangckid@gmail.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Oh, I missed the patch detail. I just reviewed overall view on your series.
Looks your patch is good for me.

Thanks
Zhang Chen

> -----Original Message-----
> From: Lukas Straub <lukasstraub2@web.de>
> Sent: Tuesday, June 2, 2020 2:12 AM
> To: Alberto Garcia <berto@igalia.com>
> Cc: Zhang, Chen <chen.zhang@intel.com>; Kevin Wolf <kwolf@redhat.com>;
> Max Reitz <mreitz@redhat.com>; qemu-dev <qemu-devel@nongnu.org>;
> Jason Wang <jasowang@redhat.com>; Zhanghailiang
> <zhang.zhanghailiang@huawei.com>; Dr . David Alan Gilbert
> <dgilbert@redhat.com>; Zhang Chen <zhangckid@gmail.com>
> Subject: Re: [PATCH] block/quorum.c: Decrease child index when del_child
>=20
> On Mon, 01 Jun 2020 12:38:32 +0200
> Alberto Garcia <berto@igalia.com> wrote:
> > As I explained a few weeks ago this patch is not correct.
> > quorum_del_child() allows you to remove any child from the Quorum
> > device, so nothing guarantees that next_child_index-1 is free.
> >
> > https://lists.gnu.org/archive/html/qemu-block/2020-05/msg00634.html
> >
> > Berto
> >
>=20
> Hi,
> Did you have a look at my series? There it's fixed properly:
> https://lore.kernel.org/qemu-
> devel/9df6b3723ec30cb749ceaa555d82a29a6d79496d.1589199922.git.lukasstr
> aub2@web.de/
>=20
> Regards,
> Lukas Straub

