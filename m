Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3126EC33CB3
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 01:38:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B46C20723
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 01:38:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B46C20723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iru7E-0002SH-2k
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 20:38:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38583)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fengzhimin1@huawei.com>) id 1iru6a-0001Kj-G9
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 20:37:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fengzhimin1@huawei.com>) id 1iru6Y-0005A7-EJ
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 20:37:52 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2052 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <fengzhimin1@huawei.com>)
 id 1iru6Y-00055v-4A
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 20:37:50 -0500
Received: from dggemi402-hub.china.huawei.com (unknown [172.30.72.57])
 by Forcepoint Email with ESMTP id E046D7A06898A84C5F42;
 Thu, 16 Jan 2020 09:37:39 +0800 (CST)
Received: from DGGEMI424-HUB.china.huawei.com (10.1.199.153) by
 dggemi402-hub.china.huawei.com (10.3.17.135) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 16 Jan 2020 09:37:39 +0800
Received: from DGGEMI529-MBX.china.huawei.com ([169.254.6.126]) by
 DGGEMI424-HUB.china.huawei.com ([10.1.199.153]) with mapi id 14.03.0439.000;
 Thu, 16 Jan 2020 09:37:29 +0800
From: fengzhimin <fengzhimin1@huawei.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: RE: [PATCH RFC 00/12] *** mulitple RDMA channels for migration ***
Thread-Topic: [PATCH RFC 00/12] *** mulitple RDMA channels for migration ***
Thread-Index: AQHVxqmab+9P2XNBF02K7i5pLeYjYKfrqJIAgADiZSA=
Date: Thu, 16 Jan 2020 01:37:29 +0000
Message-ID: <03C2A65461456D4EBE9E6D4D0D96C583FBC921@DGGEMI529-MBX.china.huawei.com>
References: <20200109045922.904-1-fengzhimin1@huawei.com>
 <20200115195724.GL3811@work-vm>
In-Reply-To: <20200115195724.GL3811@work-vm>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.173.220.198]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.189
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
Cc: Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 "quintela@redhat.com" <quintela@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "jemmy858585@gmail.com" <jemmy858585@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thanks for your review. I will add more trace_ calls in the next version(V2=
) and modify its according to your suggestions.

-----Original Message-----
From: Dr. David Alan Gilbert [mailto:dgilbert@redhat.com]=20
Sent: Thursday, January 16, 2020 3:57 AM
To: fengzhimin <fengzhimin1@huawei.com>
Cc: quintela@redhat.com; armbru@redhat.com; eblake@redhat.com; qemu-devel@n=
ongnu.org; Zhanghailiang <zhang.zhanghailiang@huawei.com>; jemmy858585@gmai=
l.com
Subject: Re: [PATCH RFC 00/12] *** mulitple RDMA channels for migration ***

* Zhimin Feng (fengzhimin1@huawei.com) wrote:
> From: fengzhimin <fengzhimin1@huawei.com>
>=20
> Currently there is a single channel for RDMA migration, this causes=20
> the problem that the network bandwidth is not fully utilized for=20
> 25Gigabit NIC. Inspired by the Multifd, we use two RDMA channels to=20
> send RAM pages, which we call MultiRDMA.
>=20
> We compare the migration performance of MultiRDMA with origin RDMA=20
> migration. The VM specifications for migration are as follows:
> - VM use 4k page;
> - the number of VCPU is 4;
> - the total memory is 16Gigabit;
> - use 'mempress' tool to pressurize VM(mempress 8000 500);
> - use 25Gigabit network card to migrate;
>=20
> For origin RDMA and MultiRDMA migration, the total migration times of=20
> VM are as follows:
> +++++++++++++++++++++++++++++++++++++++++++++++++
> |             | NOT rdma-pin-all | rdma-pin-all |
> +++++++++++++++++++++++++++++++++++++++++++++++++
> | origin RDMA |       18 s       |     23 s     |
> -------------------------------------------------
> |  MultiRDMA  |       13 s       |     18 s     |
> +++++++++++++++++++++++++++++++++++++++++++++++++

Very nice.

> For NOT rdma-pin-all migration, the multiRDMA can improve the total=20
> migration time by about 27.8%.
> For rdma-pin-all migration, the multiRDMA can improve the total=20
> migration time by about 21.7%.
>=20
> Test the multiRDMA migration like this:
> 'virsh migrate --live --rdma-parallel --migrateuri rdma://hostname=20
> domain qemu+tcp://hostname/system'

It will take me a while to finish the review; but another general suggestio=
n is add more trace_ calls; it will make it easier to diagnose problems lat=
er.

Dave

>=20
> fengzhimin (12):
>   migration: Add multiRDMA capability support
>   migration: Export the 'migration_incoming_setup' function          =20
>              and add the 'migrate_use_rdma_pin_all' function
>   migration: Create the multi-rdma-channels parameter
>   migration/rdma: Create multiRDMA migration threads
>   migration/rdma: Create the multiRDMA channels
>   migration/rdma: Transmit initial package
>   migration/rdma: Be sure all channels are created
>   migration/rdma: register memory for multiRDMA channels
>   migration/rdma: Wait for all multiRDMA to complete registration
>   migration/rdma: use multiRDMA to send RAM block for rdma-pin-all mode
>   migration/rdma: use multiRDMA to send RAM block for NOT rdma-pin-all
>                   mode
>   migration/rdma: only register the virt-ram block for MultiRDMA
>=20
>  migration/migration.c |   55 +-
>  migration/migration.h |    6 +
>  migration/rdma.c      | 1320 +++++++++++++++++++++++++++++++++++++----
>  monitor/hmp-cmds.c    |    7 +
>  qapi/migration.json   |   27 +-
>  5 files changed, 1285 insertions(+), 130 deletions(-)
>=20
> --
> 2.19.1
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


