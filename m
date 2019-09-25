Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A1BAC432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 19:30:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5006620640
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 19:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="JPNADIWd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5006620640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDCzo-0004Ya-Vi
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 15:30:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42411)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iDCp8-0002mw-9R
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 15:19:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iDCp4-0002Nr-3H
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 15:19:35 -0400
Received: from mail-eopbgr130127.outbound.protection.outlook.com
 ([40.107.13.127]:26790 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iDCoy-0002Jz-To; Wed, 25 Sep 2019 15:19:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iPBN5NRsS2JOdhD3qMHX2aU05gzC6F47W5fPlDoyFcc5zkXIq3W1Abl/XLFEGXp7P5xju0xVxZBuGkbG1YFBfariqEKr9fj1AO4AisRM47fVto/gNLHTVvKiqKuxcCbF1tLWHDs/vW630wF+wz4gAl7EyvVcWctjpbz9JzMRUVU3b+YaLVAjsyH39c+87LI9noG6G3IbIXGVnSOxCukryODQ0gD4n3B+XK6PsxKZ+LMj8ZOkSjDFMpF4l8D6Y3MtcWzudV0r1lJfyXpBy9XNWqhqvLM/PYKCD0GBImV/Ai1h3dt6nH++8MPzqjVcm4nB0yPpbf5oVbRd1AjGKr+s3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7jSfNgvQhe03kapWLQ5ZSc7/bs26/TJgUMnW2wrcIJw=;
 b=AvxOHodepJXm8Flg3o3DmLUibnWEa17Mujw04KaRILvoE40ONc+/RTAfEFVXtNKwJocd5AXekI/OfiSqYWst8/Vu5J+nb27NAzeIyDBVTXw8c98GRQT2x089s87A6hKVoMLKNbpJvz9rp2pBq/yakC9aYeRbB2QEriBpXdoLEya6GQH8Hy+hhtCRXjG30Wf5OBfeLF3GJOWnNkhAgPu6wNnXy5//gLBLUl6U5ipFBBshRQKi0hm12Gt7VN36LjCZYNExhM8BtXeP+AvkIk7qC8jPe7YjU5xE5eTzFpclmjKmikPI8H3FUaRWmM8ju1+8ezxLraJjU7A2tMU8LrO4ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7jSfNgvQhe03kapWLQ5ZSc7/bs26/TJgUMnW2wrcIJw=;
 b=JPNADIWdF5xbwW+IP2801vgGLzyzQWslJDzyodXeTskQzenm4DH5NBQq9+qjsSNUPpg6yDxWOXIwsQN4sGNAKbAdOH7fPQa/NkuTDEWcnB2Ts+RiGoJYTe/fsW+koTubNT3ZF82PrM6DNwbPeKUs56IoveccK6syvfkg/t10kZc=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5097.eurprd08.prod.outlook.com (10.255.4.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.26; Wed, 25 Sep 2019 19:19:24 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2284.023; Wed, 25 Sep 2019
 19:19:24 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [PATCH v13 00/15] backup-top filter driver for backup
Thread-Topic: [PATCH v13 00/15] backup-top filter driver for backup
Thread-Index: AQHVb76i9BZRQxEM6EO0oeincwS7S6c8+vQA
Date: Wed, 25 Sep 2019 19:19:24 +0000
Message-ID: <9a0c66fe-f786-3f49-6fad-ffca04888659@virtuozzo.com>
References: <20190920142056.12778-1-vsementsov@virtuozzo.com>
In-Reply-To: <20190920142056.12778-1-vsementsov@virtuozzo.com>
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
x-ms-office365-filtering-correlation-id: 7673a58d-4d3f-4a21-7203-08d741ed46b7
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DB8PR08MB5097; 
x-ms-traffictypediagnostic: DB8PR08MB5097:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB509738BBF41BB9412C41B475C1870@DB8PR08MB5097.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 01713B2841
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(189003)(199004)(53754006)(66946007)(71200400001)(76116006)(2906002)(7416002)(102836004)(476003)(6916009)(6116002)(6506007)(5660300002)(8936002)(446003)(2351001)(54906003)(8676002)(256004)(14454004)(14444005)(5640700003)(229853002)(81156014)(7736002)(2616005)(99286004)(3846002)(53546011)(486006)(81166006)(31696002)(86362001)(11346002)(66446008)(6246003)(76176011)(64756008)(66476007)(66556008)(6486002)(2501003)(186003)(31686004)(4326008)(66066001)(6512007)(305945005)(6436002)(26005)(498600001)(25786009)(36756003)(71190400001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5097;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FuxKrXThrAjHPAIEWF4IBsiuZBcQf2YHlaXa5MmEUxnH+cdmmoiycRlpgcnKLa7mVMp21zpttv4ijPJY9B5HXKJMOYwYacob+/Gz3lnlQI1s96jXXS3ul3cG2V5+NiIYKvnNS9pjO22Rt5zxwwp1wVG8Nlw70fhmsC7klgTHcg3bW6D3nVR3RPzwAXx0G7IuU5UCsHLRasTCKhJZzhUY4bqJ/l9m0aWxz2trQXxNTeYdU0bEmvMU8EajCKdtqkx/E5U9lG4W6+oulNEbXYuJ9tR8uaIowyUvaG73A74zbMnif2gvLETBMaCmzuoMyL5midMoYlBrVjnFpWkoCAuweS+MyCWGWkK2zScuy5rhZSGEyXJt4t5N2Bz/LekA5zC3A8mQcg7mDgAIaiWhueI8P3sdGYoHHiHSeR8hqjOUJps=
Content-Type: text/plain; charset="koi8-r"
Content-ID: <74247AABF31AA142895F753F10D95288@virtuozzo.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7673a58d-4d3f-4a21-7203-08d741ed46b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2019 19:19:24.4295 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l2AYVxoaXAadneo2tI9L85sAWlzrXikI7Lu4kbAkeitxMZJrpRD6me8WB2auGzVHuNGp335bVQJ7SyyEhYZv0YB4eBa533FhHKJioF4ypJs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5097
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.127
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

Ogh :(=0A=
=0A=
And I realized that there is bigger problem with design:=0A=
=0A=
Assume failed copy in filter request: we want to mark bits dirty again=0A=
and release range lock on source.. But if we have some write reguests=0A=
in parallel, they may already passed backup-top filter, and they are =0A=
only waiting for range lock. When lock is free the will go on and will=0A=
not see bitmap changes..=0A=
=0A=
That means that we can't use range lock: waiting request must wait on=0A=
backup-top level, but range lock will not work on it, as they will =0A=
interfer with original write request.=0A=
=0A=
I have to rething it somehow, a kind of "intersecting requests" possibly =
=0A=
will be kept. I still don't like that current backup write-notifier =0A=
locks the whole region, even non-dirty bits, instead we should lock only =
=0A=
the region which we are handling at the moment.=0A=
=0A=
Patches 01-11 are still good themselves, as a preparation, let's keep them=
=0A=
=0A=
Patches 12-13 are good, but range lock is not appropriate for backup.. =0A=
May be they will be used for rewriting copy-on-read filter to copy in =0A=
filter code.. Still I'm not sure, as COR should work through block-copy =0A=
finally, and may possibly reuse same locking.=0A=
=0A=
On 20.09.2019 17:20, Vladimir Sementsov-Ogievskiy wrote:=0A=
> Hi all!=0A=
> =0A=
> These series introduce backup-top driver. It's a filter-node, which=0A=
> do copy-before-write operation. Mirror uses filter-node for handling=0A=
> guest writes, let's move to filter-node (from write-notifiers) for=0A=
> backup too.=0A=
> =0A=
> v11,v12 -> v13 changes:=0A=
> =0A=
> [v12 was two fixes in separate: [PATCH v12 0/2] backup: copy_range fixes]=
=0A=
> =0A=
> 01: new in v12, in v13 change comment=0A=
> 02: in v12: add "Fixes: " to commit msg, in v13 add John's r-b=0A=
> 05: rebase on 01=0A=
> 07: rebase on 01. It still a clean movement, keep r-b=0A=
> =0A=
> Vladimir Sementsov-Ogievskiy (15):=0A=
>    block/backup: fix max_transfer handling for copy_range=0A=
>    block/backup: fix backup_cow_with_offload for last cluster=0A=
>    block/backup: split shareable copying part from backup_do_cow=0A=
>    block/backup: improve comment about image fleecing=0A=
>    block/backup: introduce BlockCopyState=0A=
>    block/backup: fix block-comment style=0A=
>    block: move block_copy from block/backup.c to separate file=0A=
>    block: teach bdrv_debug_breakpoint skip filters with backing=0A=
>    iotests: prepare 124 and 257 bitmap querying for backup-top filter=0A=
>    iotests: 257: drop unused Drive.device field=0A=
>    iotests: 257: drop device_add=0A=
>    block/io: refactor wait_serialising_requests=0A=
>    block: add lock/unlock range functions=0A=
>    block: introduce backup-top filter driver=0A=
>    block/backup: use backup-top instead of write notifiers=0A=
> =0A=
>   qapi/block-core.json          |   8 +-=0A=
>   block/backup-top.h            |  37 ++=0A=
>   include/block/block-copy.h    |  84 ++++=0A=
>   include/block/block_int.h     |   5 +=0A=
>   block.c                       |  34 +-=0A=
>   block/backup-top.c            | 240 ++++++++++++=0A=
>   block/backup.c                | 440 ++++-----------------=0A=
>   block/block-copy.c            | 346 ++++++++++++++++=0A=
>   block/io.c                    |  68 +++-=0A=
>   block/replication.c           |   2 +-=0A=
>   blockdev.c                    |   1 +=0A=
>   block/Makefile.objs           |   3 +=0A=
>   block/trace-events            |  14 +-=0A=
>   tests/qemu-iotests/056        |   8 +-=0A=
>   tests/qemu-iotests/124        |  83 ++--=0A=
>   tests/qemu-iotests/257        |  91 ++---=0A=
>   tests/qemu-iotests/257.out    | 714 ++++++++++++++--------------------=
=0A=
>   tests/qemu-iotests/iotests.py |  27 ++=0A=
>   18 files changed, 1287 insertions(+), 918 deletions(-)=0A=
>   create mode 100644 block/backup-top.h=0A=
>   create mode 100644 include/block/block-copy.h=0A=
>   create mode 100644 block/backup-top.c=0A=
>   create mode 100644 block/block-copy.c=0A=
> =0A=

