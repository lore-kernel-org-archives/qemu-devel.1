Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A87CC432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 19:33:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2343F21D7A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 19:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="GsO1XxzR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2343F21D7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDD2u-0007f2-2S
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 15:33:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48423)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iDCxU-0002xj-FW
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 15:28:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iDCxS-0001nb-Ij
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 15:28:16 -0400
Received: from mail-eopbgr40101.outbound.protection.outlook.com
 ([40.107.4.101]:54275 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iDCxO-0001iG-Ee; Wed, 25 Sep 2019 15:28:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P2jwWOFKuiRt5EGEgujMX7+8yYcgD346yPhSf2HRtUgFQmkb9tb4gZs/XzsOb/nhd9wXcFG9DSpZGRKgVnuQcg7MH1k14aOIGzNCuXX8v4fCTcgdwISvV4FrsK+5MeHWaNGspR2gMJD+BXpcnc1Gbo+UdIphQu1ZURJB6kMOqdVJwGr8d5t3ng5TpxZf5gN7Bv1RgRcoVSp5EzPMdX++WKDIwsnfMIoPxZ6fSAA7N3oX4KwZgA48gRwl1ZWUVtkGbjojn6/oUz42AzNNax8qoNvKBr7oOeVJEQVwchAtrv+y1JFo+ve/0ohcEl50h9hWLFA7ZbiKU0/WROcJkV1Nkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8rfRfexs3ywoZByRHPSXIHSluYPOHl6NU9iPNjsLUxo=;
 b=lZdu0mpRVXM22ELsMCpWBEdqKplZsI7nUAO07bmIuEd5MFn+v8dCWP3nExvMtV9gDOcasf5LwWbAmNEjarttWkGVneOQeQrTiwA3QkBP39uLKT8FhMLWC0V5eoa0702mu9WoitwiQpGhLs29NPg4JgGZ1KgLGHoKFCMobipRycNB/OjlnFZtD69xi45+HguEyw/yVN6B8jXOVfttA6+1XQTfDv0piNmBfHTdq5I+eRi7vp+Fr2rHEZtgeCCG1VdREqj7kYvbILUQ7njL1GhS5t40+vUUuBPY7J3neDE4gphsMOUnfmR3RCxFWJ5iZP164YPome71qOnUgmO0Q3BnlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8rfRfexs3ywoZByRHPSXIHSluYPOHl6NU9iPNjsLUxo=;
 b=GsO1XxzRil4EJmw/TUO4kDaQn99rZnU5k0X00/NvuHrqeiTBCioGH1qrHJhcaWG/T4nw8is6hPdkECRv6t87ruB43N+LRiuvF7VEG+zJ8XCKreDXv01UhQvisnBzf9W7ZUfSp2fVXseAbcD3Rq6FrTJrzdxzaK8ws1LipGmdbmg=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4170.eurprd08.prod.outlook.com (20.179.9.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.19; Wed, 25 Sep 2019 19:28:06 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2284.023; Wed, 25 Sep 2019
 19:28:06 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [PATCH v13 00/15] backup-top filter driver for backup
Thread-Topic: [PATCH v13 00/15] backup-top filter driver for backup
Thread-Index: AQHVb76i9BZRQxEM6EO0oeincwS7S6c8+vQAgAAGUQA=
Date: Wed, 25 Sep 2019 19:28:06 +0000
Message-ID: <16dc6262-06d7-29cf-a712-904f5a3c9627@virtuozzo.com>
References: <20190920142056.12778-1-vsementsov@virtuozzo.com>
 <9a0c66fe-f786-3f49-6fad-ffca04888659@virtuozzo.com>
In-Reply-To: <9a0c66fe-f786-3f49-6fad-ffca04888659@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: ru-RU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: DB8PR08MB5498.eurprd08.prod.outlook.com
 (15.20.2284.007)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-originating-ip: [79.98.8.19]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1367a84a-5056-4c90-b6ed-08d741ee7d9a
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DB8PR08MB4170; 
x-ms-traffictypediagnostic: DB8PR08MB4170:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB41706C28EDFD230AE4D28D96C1870@DB8PR08MB4170.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 01713B2841
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(39850400004)(366004)(136003)(396003)(376002)(53754006)(199004)(189003)(6916009)(26005)(99286004)(102836004)(76116006)(186003)(71200400001)(53546011)(71190400001)(6506007)(2501003)(476003)(2616005)(11346002)(66066001)(446003)(76176011)(54906003)(486006)(316002)(66946007)(66446008)(66476007)(66556008)(64756008)(6512007)(478600001)(8676002)(81156014)(81166006)(5640700003)(8936002)(4326008)(14454004)(25786009)(6246003)(229853002)(31686004)(6486002)(6436002)(256004)(14444005)(31696002)(36756003)(2906002)(86362001)(6116002)(2351001)(3846002)(7736002)(5660300002)(305945005)(7416002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4170;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zrq1E8Qpuvq9za1XJE7ZQeDU9ROzl0OwLVcheJMuiUbDc8Pbq0vkretqwJq/7aQXcd8dqUFtlKbVRPPyDZnFEBf1ZpbJBre/4CUbq4USF3PVRpYQrUzxTnhfzo4l6vPqtEffX1REIsW3fezzIOVm0gtaHYQ1fkmF2SV3Pq/UFivzx+nAO3XrWtKT5v8o63gkEMcXPYNHH8KZyJUIsu3aTx+j7tUaNW8J9P3KM34mWBeMMWMNx8Q6GLgBRrnt1nO3qj4fVyh7EqnjdLn5jZ4+qQXQxYVQxSm/xU55MSPhvu8jAHoLVHMB3H3SATXcvHGfwTFPo7Cbs2va8LMBc89u9uQISCR+1Fig/t9oDcxsiGeJiV/B5KGykNz7CF9A5RgoyFe2sdxx7+YDt8USQNHwL61n3UQ7WxAHPUZ4sTxI5Sk=
Content-Type: text/plain; charset="koi8-r"
Content-ID: <E4FCBA1AA50BB345B309B132A28B79C0@virtuozzo.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1367a84a-5056-4c90-b6ed-08d741ee7d9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2019 19:28:06.0346 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: akOBHqfgAm41nmiYC8gq590M6eP9LfrehYLOHANn4ssK8wVqpUnUXsl1tGkyc1F8cT0vGsjPTnMc2x9pFGoV0+IcrcFfMmQwQVMfbXDZy1E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4170
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.101
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
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 Denis Lunev <den@virtuozzo.com>,
 "wencongyang2@huawei.com" <wencongyang2@huawei.com>,
 "xiechanglong.d@gmail.com" <xiechanglong.d@gmail.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jsnow@redhat.com" <jsnow@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ops, I've sent unfinished message=0A=
=0A=
On 25.09.2019 22:19, Vladimir Sementsov-Ogievskiy wrote:=0A=
> Ogh :(=0A=
> =0A=
> And I realized that there is bigger problem with design:=0A=
> =0A=
> Assume failed copy in filter request: we want to mark bits dirty again=0A=
> and release range lock on source.. But if we have some write reguests=0A=
> in parallel, they may already passed backup-top filter, and they are=0A=
> only waiting for range lock. When lock is free the will go on and will=0A=
> not see bitmap changes..=0A=
> =0A=
> That means that we can't use range lock: waiting request must wait on=0A=
> backup-top level, but range lock will not work on it, as they will=0A=
> interfer with original write request.=0A=
=0A=
With such design we can't mark bits dirty again. We can switch to other =0A=
behavior: on failed block-copy in filter just cancel the whole =0A=
block-job.. But actually I think both behaviors should be available for =0A=
user:=0A=
1. if backup is important, better to fail guest writes if needed=0A=
2. if guest is important, better to fail backup job if failed to do =0A=
copy-before-write=0A=
=0A=
> =0A=
> I have to rething it somehow, a kind of "intersecting requests" possibly=
=0A=
> will be kept. I still don't like that current backup write-notifier=0A=
> locks the whole region, even non-dirty bits, instead we should lock only=
=0A=
> the region which we are handling at the moment.=0A=
> =0A=
> Patches 01-11 are still good themselves, as a preparation, let's keep the=
m=0A=
> =0A=
> Patches 12-13 are good, but range lock is not appropriate for backup..=0A=
> May be they will be used for rewriting copy-on-read filter to copy in=0A=
> filter code.. Still I'm not sure, as COR should work through block-copy=
=0A=
> finally, and may possibly reuse same locking.=0A=
=0A=
better drop 12-13 for now=0A=
=0A=
Patch 14 is good, let's keep it. It has correct abort() in =0A=
backup_top_cbw(), it's not dependent on 12-13, and it's waiting for =0A=
corrected combining of backup-top, backup and block-copy.=0A=
=0A=
And patch 15 is bad, I'll rewrite it. So, 16 is not needed too.=0A=
=0A=
> =0A=
> On 20.09.2019 17:20, Vladimir Sementsov-Ogievskiy wrote:=0A=
>> Hi all!=0A=
>>=0A=
>> These series introduce backup-top driver. It's a filter-node, which=0A=
>> do copy-before-write operation. Mirror uses filter-node for handling=0A=
>> guest writes, let's move to filter-node (from write-notifiers) for=0A=
>> backup too.=0A=
>>=0A=
>> v11,v12 -> v13 changes:=0A=
>>=0A=
>> [v12 was two fixes in separate: [PATCH v12 0/2] backup: copy_range fixes=
]=0A=
>>=0A=
>> 01: new in v12, in v13 change comment=0A=
>> 02: in v12: add "Fixes: " to commit msg, in v13 add John's r-b=0A=
>> 05: rebase on 01=0A=
>> 07: rebase on 01. It still a clean movement, keep r-b=0A=
>>=0A=
>> Vladimir Sementsov-Ogievskiy (15):=0A=
>>     block/backup: fix max_transfer handling for copy_range=0A=
>>     block/backup: fix backup_cow_with_offload for last cluster=0A=
>>     block/backup: split shareable copying part from backup_do_cow=0A=
>>     block/backup: improve comment about image fleecing=0A=
>>     block/backup: introduce BlockCopyState=0A=
>>     block/backup: fix block-comment style=0A=
>>     block: move block_copy from block/backup.c to separate file=0A=
>>     block: teach bdrv_debug_breakpoint skip filters with backing=0A=
>>     iotests: prepare 124 and 257 bitmap querying for backup-top filter=
=0A=
>>     iotests: 257: drop unused Drive.device field=0A=
>>     iotests: 257: drop device_add=0A=
>>     block/io: refactor wait_serialising_requests=0A=
>>     block: add lock/unlock range functions=0A=
>>     block: introduce backup-top filter driver=0A=
>>     block/backup: use backup-top instead of write notifiers=0A=
>>=0A=
>>    qapi/block-core.json          |   8 +-=0A=
>>    block/backup-top.h            |  37 ++=0A=
>>    include/block/block-copy.h    |  84 ++++=0A=
>>    include/block/block_int.h     |   5 +=0A=
>>    block.c                       |  34 +-=0A=
>>    block/backup-top.c            | 240 ++++++++++++=0A=
>>    block/backup.c                | 440 ++++-----------------=0A=
>>    block/block-copy.c            | 346 ++++++++++++++++=0A=
>>    block/io.c                    |  68 +++-=0A=
>>    block/replication.c           |   2 +-=0A=
>>    blockdev.c                    |   1 +=0A=
>>    block/Makefile.objs           |   3 +=0A=
>>    block/trace-events            |  14 +-=0A=
>>    tests/qemu-iotests/056        |   8 +-=0A=
>>    tests/qemu-iotests/124        |  83 ++--=0A=
>>    tests/qemu-iotests/257        |  91 ++---=0A=
>>    tests/qemu-iotests/257.out    | 714 ++++++++++++++-------------------=
-=0A=
>>    tests/qemu-iotests/iotests.py |  27 ++=0A=
>>    18 files changed, 1287 insertions(+), 918 deletions(-)=0A=
>>    create mode 100644 block/backup-top.h=0A=
>>    create mode 100644 include/block/block-copy.h=0A=
>>    create mode 100644 block/backup-top.c=0A=
>>    create mode 100644 block/block-copy.c=0A=
>>=0A=

