Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 064E5C43215
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 17:23:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5D022075E
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 17:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="IqMzU7kf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5D022075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX7E7-00067R-WF
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 12:23:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47997)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iX72C-0000OH-2Z
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 12:11:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iX729-0006Q2-Nv
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 12:11:23 -0500
Received: from mail-eopbgr40094.outbound.protection.outlook.com
 ([40.107.4.94]:29223 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iX727-0006MJ-O1; Tue, 19 Nov 2019 12:11:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e1JsqMl7S6qy9l5TMrnEquVxtrw0ohQ0m19vfVSB3pgn/aM8xT37nAIw3b8AfIf4FFyR5fsK3Pjzaa3pyi15ixoY/owvo9EjFpiBfAGCxx+TizvPrx0sqExSHmVjtsyu/5TL1AmsYNCmkR5yPX3hAvrkQn3Bfnr4VaUXSE4+tqAt46Lfovva5YCPNX6XDdP6kI/TjRDsXUFCSZipgD04om523hIZ+os5NCDqVJOZWQEumbwu9jBCVePAqsHacO/esRq8kEtZ9t2lp/Iza+0QkQfNfTAXonOT1ADXfYRqeVfcjEBxsEgTzK4+M+nUduwBVwLwvEeT1qrtm4IhEq+Qgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sn5nY4uV2UrIYqWC93yb/PzVCuvgO1L5w6IgTffFo/g=;
 b=NMUkpAbyVHaNZPoCdGDN5+F9mE8gAJ/fX2l8B6Zn3cDd2aHnPqj15MUi3N79MuTxcaPPfwELK7mPvNE69k8nk5LVlbIgjHbUWqQEtTplcjvxMqLEDrLMzScsE+Oiu5HIcgP+3T2OwXE5f69p1VK1VgqsjjYLKxQOMYgQOxiQnqwBgWHD5lW89yuKZCCbQAd9ZqMjUlukOcDi2LO+FzVL71Q9RKHmoGLb9Q9tPGhuPyGj3NbHjC0yyxgx2VRUbBEtPLFC1sqmXjdBNwXtog/H9ofToIV1uoNjENXbIusM6mL0tnfgxHaTgcsc++OANzl5VMvvbpoNx9lcShDhcmf8CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sn5nY4uV2UrIYqWC93yb/PzVCuvgO1L5w6IgTffFo/g=;
 b=IqMzU7kfVyZIPB0qJuMWTttLki1MsIDFbPY/H39/lexMG4hNNHZh7Hp1WtanW/xt8OCNRTstJarwMuDCYL5Nrp8fK9bN4WfAX+JEmbb5W5Jv4nC7CvzrQNDD3k8IYr/PTkjJmd9ynXPPR39XDaW8WqmdhFmlQO+ZFTg5+ECMYuk=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4936.eurprd08.prod.outlook.com (10.255.122.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.22; Tue, 19 Nov 2019 17:11:15 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2451.031; Tue, 19 Nov 2019
 17:11:15 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 0/4] fix & merge block_status_above and is_allocated_above
Thread-Topic: [PATCH 0/4] fix & merge block_status_above and is_allocated_above
Thread-Index: AQHVnJu0qDM7Hy9Fo0iUR1ci8onW5KeSu8mAgAADrwA=
Date: Tue, 19 Nov 2019 17:11:14 +0000
Message-ID: <ab2be956-0b44-f737-4416-322ca4024d9b@virtuozzo.com>
References: <20191116163410.12129-1-vsementsov@virtuozzo.com>
 <20191119165801.GF229732@stefanha-x1.localdomain>
In-Reply-To: <20191119165801.GF229732@stefanha-x1.localdomain>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P195CA0023.EURP195.PROD.OUTLOOK.COM (2603:10a6:3:fd::33)
 To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191119201112587
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e85eb2a9-fa4d-4925-61c0-08d76d137bc8
x-ms-traffictypediagnostic: AM6PR08MB4936:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB4936E2E720E1EA4EE8274D87C14C0@AM6PR08MB4936.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 022649CC2C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(366004)(396003)(346002)(376002)(39850400004)(53754006)(199004)(189003)(66066001)(25786009)(107886003)(52116002)(486006)(6246003)(7736002)(305945005)(36756003)(478600001)(6916009)(99286004)(54906003)(316002)(8676002)(81156014)(81166006)(8936002)(4326008)(6116002)(6512007)(14454004)(66946007)(3846002)(76176011)(5660300002)(31686004)(31696002)(6506007)(66476007)(26005)(66556008)(229853002)(6486002)(6436002)(186003)(2906002)(256004)(2616005)(11346002)(71200400001)(64756008)(102836004)(66446008)(386003)(476003)(86362001)(446003)(14444005)(71190400001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4936;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1h5/xCJmfmq6c3xxtC+XTlHlQ8dHD9VVuA7KfPL8AJ28R0Z6S3hlxp0/wjBmICy0qj9HPiBiEqbH2q6kg55UX/FjiBd7nejFNwH8728IYvi/WvEZqBzsPER+FY7yD4xwtqFLPCXgmTXN1h6hs0vaxesTXkq1SNFE1LQhJipi5IDDjVFpRxzKoGAKtzL8DbYBwnNY9gMtn4jzRDv3ppdrd+0hLNE7O/HSetI6vY3+KmknzEaM7n5ryGzuyUsoz17Ifcdnd8u1m64Q2FEIB27wz4g7zptEOvE040M1nKLHeJxe1QwJ1Y81WBspkzqerTGEoD19kvRB0doYLGQ48ZCDWpWY5fLBzVjUtRHrafspSIPZ3HvmrYuXOUMQ3NbP/AcL+fwTTENOtaPH10S1f/ofKvoeKXKolHpC8katwVuZlrK2jDjY9edDcLHPRGDObvnD
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <54BEE21FC4EC3C4EA8C745D2E1A01F77@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e85eb2a9-fa4d-4925-61c0-08d76d137bc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2019 17:11:14.7179 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y711X+1abQOrgyUZ+RClohGgWzR8TTLSz5O7fIU90DLccY1x+cFee09gpoxmsBE0bsElK7mX7JoruoQKsYDqJnkF3EwyjxTDoSo4z7zZhy4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4936
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.94
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "fam@euphon.net" <fam@euphon.net>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

19.11.2019 19:58, Stefan Hajnoczi wrote:
> On Sat, Nov 16, 2019 at 07:34:06PM +0300, Vladimir Sementsov-Ogievskiy wr=
ote:
>> Hi all!
>>
>> I wanted to understand, what is the real difference between bdrv_block_s=
tatus_above
>> and bdrv_is_allocated_above, IMHO bdrv_is_allocated_above should work th=
rough
>> bdrv_block_status_above..
>>
>> And I found the problem: bdrv_is_allocated_above considers space after E=
OF as
>> UNALLOCATED for intermediate nodes..
>>
>> UNALLOCATED is not about allocation at fs level, but about should we go =
to backing or
>> not.. And it seems incorrect for me, as in case of short backing file, w=
e'll read
>> zeroes after EOF, instead of going further by backing chain.
>>
>> This leads to the following effect:
>>
>> ./qemu-img create -f qcow2 base.qcow2 2M
>> ./qemu-io -c "write -P 0x1 0 2M" base.qcow2
>>
>> ./qemu-img create -f qcow2 -b base.qcow2 mid.qcow2 1M
>> ./qemu-img create -f qcow2 -b mid.qcow2 top.qcow2 2M
>>
>> Region 1M..2M is shadowed by short middle image, so guest sees zeroes:
>> ./qemu-io -c "read -P 0 1M 1M" top.qcow2
>> read 1048576/1048576 bytes at offset 1048576
>> 1 MiB, 1 ops; 00.00 sec (22.795 GiB/sec and 23341.5807 ops/sec)
>>
>> But after commit guest visible state is changed, which seems wrong for m=
e:
>> ./qemu-img commit top.qcow2 -b mid.qcow2
>>
>> ./qemu-io -c "read -P 0 1M 1M" mid.qcow2
>> Pattern verification failed at offset 1048576, 1048576 bytes
>> read 1048576/1048576 bytes at offset 1048576
>> 1 MiB, 1 ops; 00.00 sec (4.981 GiB/sec and 5100.4794 ops/sec)
>>
>> ./qemu-io -c "read -P 1 1M 1M" mid.qcow2
>> read 1048576/1048576 bytes at offset 1048576
>> 1 MiB, 1 ops; 00.00 sec (3.365 GiB/sec and 3446.1606 ops/sec)
>>
>>
>> I don't know, is it a real bug, as I don't know, do we support backing f=
ile larger than
>> its parent. Still, I'm not sure that this behavior of bdrv_is_allocated_=
above don't lead
>> to other problems.
>=20
> It seems correct that a backing file limits the virtual disk size of its
> backing chain.
>=20
> The "qemu-img commit" behavior seems counter-intuitive at first, but the
> problem there is that the top-most image file is larger than its backing
> file - not that the backing chain has differing sizes.  Committing
> should not lose data, mid.qcow2 will be grown and then you get the
> result you've observed.
>=20
> I consider this a little weird but not a bug.  Does anyone else have
> opinions?
>=20

I thing, that the fact that read and block_status treats space after EOF
in different ways is a bug anyway.

Also, block_status behavior don't correspond to our definition of
BDRV_BLOCK_ALLOCATED (see Kevin's response)

Also, as I explained in parallel branch, such situation is possible for exa=
mple
when we interleave incremental backup creation with vm disk resize.

So, then, we have incremental backup chain with different sizes like in
example. Assume we want to merge some sequential incremental backups into
one (aka, remove incremental backup), it may be done with help of commit.
And we get final image, where we see data from base backup instead of
zeros. This is illegal, vm should not get access to this data.

Possibly, similar thing is possible with snapshots.

--=20
Best regards,
Vladimir

