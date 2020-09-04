Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7927BC433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 04:37:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E84F206CA
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 04:37:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E84F206CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kE3TX-00084N-FG
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 00:37:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35004)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangxinxin.wang@huawei.com>)
 id 1kE3Sl-0007a6-Ds
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 00:36:35 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2106 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangxinxin.wang@huawei.com>)
 id 1kE3Sj-0002eh-2p
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 00:36:34 -0400
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.54])
 by Forcepoint Email with ESMTP id 2E4ACC983F7A0247B93A;
 Fri,  4 Sep 2020 12:36:22 +0800 (CST)
Received: from dggema721-chm.china.huawei.com (10.3.20.85) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Fri, 4 Sep 2020 12:36:21 +0800
Received: from dggema771-chm.china.huawei.com (10.1.198.213) by
 dggema721-chm.china.huawei.com (10.3.20.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Fri, 4 Sep 2020 12:36:21 +0800
Received: from dggema771-chm.china.huawei.com ([10.9.128.123]) by
 dggema771-chm.china.huawei.com ([10.9.128.123]) with mapi id 15.01.1913.007;
 Fri, 4 Sep 2020 12:36:21 +0800
From: "Wangxin (Alexander)" <wangxinxin.wang@huawei.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH 0/2][RFC] exclude ivshmem mr from vhost sections
Thread-Topic: [PATCH 0/2][RFC] exclude ivshmem mr from vhost sections
Thread-Index: AQHWfSIAySFupkREukSwljGh+8mH/KlX7qDw
Date: Fri, 4 Sep 2020 04:36:21 +0000
Message-ID: <0ecd02b3b6104a7eb8a2f8aa54f6064e@huawei.com>
References: <20200828095953.2276-1-wangxinxin.wang@huawei.com>
In-Reply-To: <20200828095953.2276-1-wangxinxin.wang@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.149.106]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.189;
 envelope-from=wangxinxin.wang@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 00:36:23
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "Zhoujian \(jay\)" <jianjay.zhou@huawei.com>,
 "Huangweidong \(C\)" <weidong.huang@huawei.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>, "mst@redhat.com" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping.=20

>=20
> The ivshmem me now mapped to vhost memory regions, and it reduces
> the number of available memslots of vhost backend, which may
> causes vhost backend memory slots limit check failure in
> vhost dev init.
>=20
> Since ivshmem_bar2 not normal RAM in Guest, and it shouldn't
> have vhost DMAing into them, exclude it from the vhost sections.
>=20
> The 1st patch re-spin Dave's patch, see link
>   https://lists.nongnu.org/archive/html/qemu-devel/2020-01/msg02370.html
>=20
> However, I'm not sure is there any side effects, or maybe it's
> better to add a new device property like 'novhost/nodma'?
>=20
> Thanks,
> Xin
>=20
> Wang Xin (2):
>   memory: Allow a MemoryRegion to be marked no_vhost
>   misc/ivshmem: Mark shared memory regions as no vhost
>=20
>  hw/misc/ivshmem.c     |  2 ++
>  hw/virtio/vhost.c     |  5 ++++-
>  include/exec/memory.h | 21 +++++++++++++++++++++
>  softmmu/memory.c      | 15 +++++++++++++++
>  4 files changed, 42 insertions(+), 1 deletion(-)
>=20
> --
> 2.26.0.windows.1
>=20


