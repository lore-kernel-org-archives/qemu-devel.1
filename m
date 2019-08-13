Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0155C32750
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 15:58:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A869A20578
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 15:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="fXC0ajHx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A869A20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxZBd-0003Av-VA
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 11:58:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53488)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxZ87-0002tJ-Tj
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 11:54:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxZ86-0007B0-M5
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 11:54:35 -0400
Received: from mail-eopbgr30104.outbound.protection.outlook.com
 ([40.107.3.104]:11182 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hxZ86-0007A0-3o; Tue, 13 Aug 2019 11:54:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e6Qr4tdX0w/QY7Mq1/K+4Mtt0l6Y4BFSht09riAIpwLzroyuThqvBLfrw/SdLlixfxPyQoJsX0BpXf4qW+OUcYAVUxPxgRSxp6iw6LVklvBf00b2vEh8SGSjaHHG5FTFGUvCw2hbFvhQs8ETmMBauQNZYnrcJdqiGqSFkIrKZgi6Rxc58SC/tH73I4WYizc0ebD4z5SAVuB0UdzQ4FYrzYkAiW42tOebSwSbQSVcX5RmxXCxZUiQz5bl9ZWcZtn2NQZsmotqlOeoElsgtUxQ1q/BP8QaYXO4Firava3BtZEdqlf+V2WhL3eLx7JQ3oAdROY/OzpHpGM6YveGDJxqYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5cYyvI768XBHhOY5cwERvSvxePi9x2BXsIMjw/rN+1M=;
 b=kBgjL5q1S288iHMNRU1Ii/2x606yPKuSj2eqsCliAnGDWhG7A74105yPOUQvcUzYGDWtXU2hkatXPJ9bTexSJ6nwhuWNwfQVvD7i8eVh+xg2jzVftL/euFdLiR1jTYZVxlfTww7iOy5YoVxQ6Kj26Gu2zueqa6IsnEvu2Qe+LV3gO8n3z8zPwANNvblwfgkOkD/FrDxmHOUmykbnxe4emPGisHQcGm1vF/ET2AmoyD1feSU2dJJqnAXUTL781nJ9p1+espjbEzkTnz0mf9SQ8Yf732ZBjj29dX2O3eIlQ0ck+5nNNitpAo8UK1VHIRfhPCGE8waxWtS6/P0rBNBGew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=virtuozzo.com;dmarc=pass action=none
 header.from=virtuozzo.com;dkim=pass header.d=virtuozzo.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5cYyvI768XBHhOY5cwERvSvxePi9x2BXsIMjw/rN+1M=;
 b=fXC0ajHx55hxyFyj8npIvaxx794lfh+nE204p3t/LcqZn9QCpnZKW1Jvv8eUpbziQfsyGsI3oI6N8T/tCzWpsOTREAYKFHivy1etulaYWmli3wHgVomeHvZYgLXPaFaz5zJqhZ9Jv59GEqtfd5hn8GEVk6El9fU+oA8/WZiRu10=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4025.eurprd08.prod.outlook.com (20.179.10.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.14; Tue, 13 Aug 2019 15:54:30 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2157.022; Tue, 13 Aug 2019
 15:54:30 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Thread-Topic: [PATCH 1/2] block/raw-format: switch to BDRV_BLOCK_DATA with
 BDRV_BLOCK_RECURSE
Thread-Index: AQHVUTlsaPHpCWSa5ku4nJrwFG1t86b4600AgAA9SACAABAVAIAAA6iA
Date: Tue, 13 Aug 2019 15:54:30 +0000
Message-ID: <2e70844b-bf08-9160-b3ca-21b364b74d48@virtuozzo.com>
References: <20190812181146.26121-1-vsementsov@virtuozzo.com>
 <20190812181146.26121-2-vsementsov@virtuozzo.com>
 <20190813110428.GE4663@localhost.localdomain>
 <fef7f4d1-b40e-6c84-3952-120a641a8061@redhat.com>
 <20190813154122.GL4663@localhost.localdomain>
In-Reply-To: <20190813154122.GL4663@localhost.localdomain>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR02CA0100.eurprd02.prod.outlook.com
 (2603:10a6:7:29::29) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190813185427925
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8859a93f-e879-4f1e-906c-08d720068732
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB4025; 
x-ms-traffictypediagnostic: DB8PR08MB4025:
x-microsoft-antispam-prvs: <DB8PR08MB402574D1B13C6037E4F4D9F8C1D20@DB8PR08MB4025.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01283822F8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(136003)(396003)(39850400004)(366004)(376002)(199004)(189003)(52314003)(8936002)(386003)(256004)(6512007)(4326008)(110136005)(66946007)(81156014)(66556008)(86362001)(25786009)(64756008)(31696002)(5660300002)(66446008)(54906003)(36756003)(66476007)(26005)(2906002)(486006)(2616005)(305945005)(446003)(6436002)(71190400001)(8676002)(6486002)(31686004)(316002)(66066001)(107886003)(81166006)(102836004)(6246003)(229853002)(6506007)(3846002)(14454004)(76176011)(52116002)(186003)(7736002)(53936002)(476003)(6116002)(99286004)(53546011)(71200400001)(11346002)(478600001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4025;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rhVzuRhV7SLp3OQKnTqUyse1LEn5UKpdZuBnWie+NVC30TNtkrUkcKxVPMFbanI8irNVS4ftK+QWwY6ZanuukeCZoF8VDlz8vRrWKa/kGCxHz5RMQeLGfufzL1h0IVwsPFxFyAnzmWVUwIcM/wJo6PVtECBDqFa2oHcO/c9v1E2uSKoskebry+CeG0n5mWwDUSYEWXkCH8wkXXWPKNr3l/J7VFxI3fnNZfuZhwRxVvAezYhzqZl3MPqZjT1+Dxp0Ht2AW5QfEfAVJZTqiQUKx+CePJs9aufmSTFyJ/QSGueFI+7vK8sJ2X2aSupaZ5OpdC/+NNTKc/wqjGtqjcbgW5hpVB2S9F0Vg72TpupoPyfQA5lL+CxPyPXETfgduf90KeuLXlQa38yrpC7gTUBHprwn6P+Edb/zY79936YAdec=
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <2EC4756029E31B468D2C119709891DAB@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8859a93f-e879-4f1e-906c-08d720068732
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2019 15:54:30.7376 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pVGWyzQrwThU2DRNB2WSNngP+70ULbpWRqkNx/YlS60tSrLRaZpY70OGtCjViqeTHMHtn5GET5KOn/rjs6YK3700q0AeOXOLILtXCHVZvME=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4025
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.104
Subject: Re: [Qemu-devel] [PATCH 1/2] block/raw-format: switch to
 BDRV_BLOCK_DATA with BDRV_BLOCK_RECURSE
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

13.08.2019 18:41, Kevin Wolf wrote:
> Am 13.08.2019 um 16:43 hat Max Reitz geschrieben:
>> On 13.08.19 13:04, Kevin Wolf wrote:
>>> Am 12.08.2019 um 20:11 hat Vladimir Sementsov-Ogievskiy geschrieben:
>>>> BDRV_BLOCK_RAW makes generic bdrv_co_block_status to fallthrough to
>>>> returned file. But is it correct behavior at all? If returned file
>>>> itself has a backing file, we may report as totally unallocated and
>>>> area which actually has data in bottom backing file.
>>>>
>>>> So, mirroring of qcow2 under raw-format is broken. Which is illustrate=
d
>>>> by following commit with a test. Let's make raw-format behave more
>>>> correctly returning BDRV_BLOCK_DATA.
>>>>
>>>> Suggested-by: Max Reitz <mreitz@redhat.com>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>
>>> After some reading, I think I came to the conclusion that RAW is the
>>> correct thing to do. There is indeed a problem, but this patch is tryin=
g
>>> to fix it in the wrong place.
>>>
>>> In the case where the backing file contains some data, and we have a
>>> 'raw' node above the qcow2 overlay node, the content of the respective
>>> block is not defined by the queried backing file layer, so it is
>>> completely correct that bdrv_is_allocated() returns false,like it would
>>> if you queried the qcow2 layer directly.
>>
>> I disagree.  The queried backing file layer is the raw node.  As I said,
>> in my opinion raw nodes are not filter nodes, neither in behavior (they
>> have an offset option), nor in how they are generally used (as a format)=
.
>>
>> The raw format does not support backing files.  Therefore, everything on
>> a raw node is allocated.
>>
>> (That is, like, my opinion.)
>>
>>>                                           If it returned true, we would
>>> copy everything, which isn't right either (the test cases should may ad=
d
>>> the qemu-img map output of the target so this becomes visible).
>>
>> It is right.
>=20
> So we don't even agree what mirroring the raw node should even mean.
>=20
> I can the see your point when you say that the raw node has no backing
> file, so everything should be copied. But I can also see the point that
> the raw node can really just be used as a filter that limits the data
> exposed from the qcow2 layer, and you want to keep the copy a COW
> overlay over the same backing file.
>=20
> Both are valid use cases in principle and there is no single right or
> wrong.
>=20
> We don't currently support the latter use case because we have only
> sync=3Dfull or sync=3Dtop, but if you could specify a base node instead, =
we
> could probably suport the case without all of the special-casing filter
> nodes and backing file childs.
>=20
> You would call bdrv_co_block_status_above() with the right base node and
> it would just recurse whereever the data is stored, be it bs->backing,
> bs->file or even driver-specific children. This would allow you to find
> out whether some block in the top node came from the base node that
> we're going to keep. If yes, skip it; if no, copy it.
>=20
> This way we wouldn't have to decide whether raw is a filter or not,
> because it wouldn't make a difference. The behaviour would only depend
> on the base node given by the user. If you specified the top-level qcow2
> file as the base, you get your full copy;

ahm, full-copy =3D base is NULL..

> if you specified the backing
> qcow2, you get the partial copy where the target still uses the same
> backing file.
>=20
> (Hm... It would only actually work if the offsets stay the same in the
> chain, which is true for backing file children, but not necessarily for
> other children.

Don't follow, what you mean by offsets stay the same and what is wrong with=
 it?

> Anyway, even if we don't gain much functionality, I
> really want a more generic model that avoids different types of nodes
> and edges as much as possible.)
>=20
> Kevin
>=20


--=20
Best regards,
Vladimir

