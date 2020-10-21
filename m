Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C5CC4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 09:26:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B45421D7B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 09:26:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B45421D7B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVAOL-0006J2-BV
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 05:26:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58956)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhang.zhanghailiang@huawei.com>)
 id 1kVANM-0005RG-B4
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 05:25:44 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2944 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhang.zhanghailiang@huawei.com>)
 id 1kVANH-0003Nc-Vm
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 05:25:43 -0400
Received: from dggeme759-chm.china.huawei.com (unknown [172.30.72.55])
 by Forcepoint Email with ESMTP id 6B47C1BAB99C6D98C7F1;
 Wed, 21 Oct 2020 17:25:29 +0800 (CST)
Received: from dggeme756-chm.china.huawei.com (10.3.19.102) by
 dggeme759-chm.china.huawei.com (10.3.19.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Wed, 21 Oct 2020 17:25:28 +0800
Received: from dggeme756-chm.china.huawei.com ([10.6.80.68]) by
 dggeme756-chm.china.huawei.com ([10.6.80.68]) with mapi id 15.01.1913.007;
 Wed, 21 Oct 2020 17:25:29 +0800
From: Zhanghailiang <zhang.zhanghailiang@huawei.com>
To: zhengchuan <zhengchuan@huawei.com>, "quintela@redhat.com"
 <quintela@redhat.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>
Subject: RE: [PATCH v3 00/18] Support Multifd for RDMA migration 
Thread-Topic: [PATCH v3 00/18] Support Multifd for RDMA migration 
Thread-Index: AQHWpDtZDjzq2DgEFkWMVc69bTara6mhzg8A
Date: Wed, 21 Oct 2020 09:25:28 +0000
Message-ID: <2ea09ca2cc8c494390b506877f6e5e2c@huawei.com>
References: <1602908748-43335-1-git-send-email-zhengchuan@huawei.com>
In-Reply-To: <1602908748-43335-1-git-send-email-zhengchuan@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.186.52]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.187;
 envelope-from=zhang.zhanghailiang@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 05:25:30
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
Cc: "Chenzhendong \(alex\)" <alex.chen@huawei.com>,
 yubihong <yubihong@huawei.com>, "wanghao \(O\)" <wanghao232@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Xiexiangyou <xiexiangyou@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi zhengchuan,

> -----Original Message-----
> From: zhengchuan
> Sent: Saturday, October 17, 2020 12:26 PM
> To: quintela@redhat.com; dgilbert@redhat.com
> Cc: Zhanghailiang <zhang.zhanghailiang@huawei.com>; Chenzhendong (alex)
> <alex.chen@huawei.com>; Xiexiangyou <xiexiangyou@huawei.com>; wanghao
> (O) <wanghao232@huawei.com>; yubihong <yubihong@huawei.com>;
> fengzhimin1@huawei.com; qemu-devel@nongnu.org
> Subject: [PATCH v3 00/18] Support Multifd for RDMA migration
>=20
> Now I continue to support multifd for RDMA migration based on my colleagu=
e
> zhiming's work:)
>=20
> The previous RFC patches is listed below:
> v1:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg669455.html
> v2:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg679188.html
>=20
> As descried in previous RFC, the RDMA bandwidth is not fully utilized for=
 over
> 25Gigabit NIC because of single channel for RDMA migration.
> This patch series is going to support multifd for RDMA migration based on=
 multifd
> framework.
>=20
> Comparsion is between origion and multifd RDMA migration is re-tested for=
 v3.
> The VM specifications for migration are as follows:
> - VM use 4k page;
> - the number of VCPU is 4;
> - the total memory is 16Gigabit;
> - use 'mempress' tool to pressurize VM(mempress 8000 500);
> - use 25Gigabit network card to migrate;
>=20
> For origin RDMA and MultiRDMA migration, the total migration times of VM =
are
> as follows:
> +++++++++++++++++++++++++++++++++++++++++++++++++
> |             | NOT rdma-pin-all | rdma-pin-all |
> +++++++++++++++++++++++++++++++++++++++++++++++++
> | origin RDMA |       26 s       |     29 s     |
> -------------------------------------------------
> |  MultiRDMA  |       16 s       |     17 s     |
> +++++++++++++++++++++++++++++++++++++++++++++++++
>=20
> Test the multifd RDMA migration like this:
> virsh migrate --live --multiFd --migrateuri

There is no option '--multiFd' for virsh commands, It seems that, we added =
this private option for internal usage.
It's better to provide testing method by using qemu commands.


Thanks.

> rdma://192.168.1.100 [VM] --listen-address 0.0.0.0
> qemu+tcp://192.168.1.100/system --verbose
>=20
> v2 -> v3:
>     create multifd ops for both tcp and rdma
>     do not export rdma to avoid multifd code in mess
>     fix build issue for non-rdma
>     fix some codestyle and buggy code
>=20
> Chuan Zheng (18):
>   migration/rdma: add the 'migrate_use_rdma_pin_all' function
>   migration/rdma: judge whether or not the RDMA is used for migration
>   migration/rdma: create multifd_setup_ops for Tx/Rx thread
>   migration/rdma: add multifd_setup_ops for rdma
>   migration/rdma: do not need sync main for rdma
>   migration/rdma: export MultiFDSendParams/MultiFDRecvParams
>   migration/rdma: add rdma field into multifd send/recv param
>   migration/rdma: export getQIOChannel to get QIOchannel in rdma
>   migration/rdma: add multifd_rdma_load_setup() to setup multifd rdma
>   migration/rdma: Create the multifd recv channels for RDMA
>   migration/rdma: record host_port for multifd RDMA
>   migration/rdma: Create the multifd send channels for RDMA
>   migration/rdma: Add the function for dynamic page registration
>   migration/rdma: register memory for multifd RDMA channels
>   migration/rdma: only register the memory for multifd channels
>   migration/rdma: add rdma_channel into Migrationstate field
>   migration/rdma: send data for both rdma-pin-all and NOT rdma-pin-all
>     mode
>   migration/rdma: RDMA cleanup for multifd migration
>=20
>  migration/migration.c |  24 +++
>  migration/migration.h |  11 ++
>  migration/multifd.c   |  97 +++++++++-
>  migration/multifd.h   |  24 +++
>  migration/qemu-file.c |   5 +
>  migration/qemu-file.h |   1 +
>  migration/rdma.c      | 503
> +++++++++++++++++++++++++++++++++++++++++++++++++-
>  7 files changed, 653 insertions(+), 12 deletions(-)
>=20
> --
> 1.8.3.1


