Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B13C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 08:06:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21CE720657
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 08:06:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21CE720657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZVMK-0001rN-9U
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 04:06:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49794)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhang.zhanghailiang@huawei.com>)
 id 1jZVLU-0001HK-M1
 for qemu-devel@nongnu.org; Fri, 15 May 2020 04:05:28 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2522 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhang.zhanghailiang@huawei.com>)
 id 1jZVLT-0001s6-8e
 for qemu-devel@nongnu.org; Fri, 15 May 2020 04:05:28 -0400
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.54])
 by Forcepoint Email with ESMTP id F0EB0D870590A0260618;
 Fri, 15 May 2020 16:05:21 +0800 (CST)
Received: from dggeme707-chm.china.huawei.com (10.1.199.103) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Fri, 15 May 2020 16:05:21 +0800
Received: from dggeme756-chm.china.huawei.com (10.3.19.102) by
 dggeme707-chm.china.huawei.com (10.1.199.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Fri, 15 May 2020 16:05:21 +0800
Received: from dggeme756-chm.china.huawei.com ([10.6.80.68]) by
 dggeme756-chm.china.huawei.com ([10.6.80.68]) with mapi id 15.01.1913.007;
 Fri, 15 May 2020 16:05:21 +0800
From: Zhanghailiang <zhang.zhanghailiang@huawei.com>
To: "Zhang, Chen" <chen.zhang@intel.com>
Subject: RE: About migration/colo issue
Thread-Topic: About migration/colo issue
Thread-Index: AdYqZjudkmlVb8B9TvKOADpJ4VTuWP//vbYA//9sGvA=
Date: Fri, 15 May 2020 08:05:21 +0000
Message-ID: <c5381e8bae0142618a9f4e9d7d7421bf@huawei.com>
References: <7a26ed7efed94d2dbff591521d31076a@intel.com>
 <20200515091208.40817d99@luklap>
In-Reply-To: <20200515091208.40817d99@luklap>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.173.220.30]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.188;
 envelope-from=zhang.zhanghailiang@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 02:24:19
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
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
Cc: Jason Wang <jasowang@redhat.com>, Lukas Straub <lukasstraub2@web.de>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Li Zhijian <lizhijian@cn.fujitsu.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

I can't reproduce this issue with the qemu upstream either,
It works well.

Did you use an old version ?

Thanks,
Hailiang


> -----Original Message-----
> From: Lukas Straub [mailto:lukasstraub2@web.de]
> Sent: Friday, May 15, 2020 3:12 PM
> To: Zhang, Chen <chen.zhang@intel.com>
> Cc: Zhanghailiang <zhang.zhanghailiang@huawei.com>; Dr . David Alan
> Gilbert <dgilbert@redhat.com>; qemu-devel <qemu-devel@nongnu.org>; Li
> Zhijian <lizhijian@cn.fujitsu.com>; Jason Wang <jasowang@redhat.com>
> Subject: Re: About migration/colo issue
>=20
> On Fri, 15 May 2020 03:16:18 +0000
> "Zhang, Chen" <chen.zhang@intel.com> wrote:
>=20
> > Hi Hailiang/Dave.
> >
> > I found a urgent problem in current upstream code, COLO will stuck on
> secondary checkpoint and later.
> > The guest will stuck by this issue.
> > I have bisect upstream code, this issue caused by Hailiang's optimize p=
atch:
>=20
> Hmm, I'm on v5.0.0 (where that commit is in) and I don't have this issue =
in
> my testing.
>=20
> Regards,
> Lukas Straub
>=20
> > From 0393031a16735835a441b6d6e0495a1bd14adb90 Mon Sep 17
> 00:00:00 2001
> > From: zhanghailiang <zhang.zhanghailiang@huawei.com>
> > Date: Mon, 24 Feb 2020 14:54:10 +0800
> > Subject: [PATCH] COLO: Optimize memory back-up process
> >
> > This patch will reduce the downtime of VM for the initial process,
> > Previously, we copied all these memory in preparing stage of COLO
> > while we need to stop VM, which is a time-consuming process.
> > Here we optimize it by a trick, back-up every page while in migration
> > process while COLO is enabled, though it affects the speed of the
> > migration, but it obviously reduce the downtime of back-up all SVM'S
> > memory in COLO preparing stage.
> >
> > Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
> > Message-Id:
> <20200224065414.36524-5-zhang.zhanghailiang@huawei.com>
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> >   minor typo fixes
> >
> > Hailiang, do you have time to look into it?
> >
> > ...

