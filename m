Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C04CCA9EBB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 11:47:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3412521655
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 11:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="A5W55rvs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3412521655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNbaq-00018o-NS
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 07:47:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32948)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <den@virtuozzo.com>) id 1iNb4D-0005Lr-Un
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:14:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <den@virtuozzo.com>) id 1iNb4C-000227-IQ
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:14:09 -0400
Received: from mail-he1eur01on0708.outbound.protection.outlook.com
 ([2a01:111:f400:fe1e::708]:3328
 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <den@virtuozzo.com>)
 id 1iNb49-0001zd-UQ; Thu, 24 Oct 2019 07:14:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k3fomcLYihLpzmVQUyCVFvGdtF8yyxnsEKvg6wpK+0cln69n9vd/GLwjX/CD/o400szonyON5EGSRX0O2kXaRAdVKsVHGF6HlzcLoIfyiyGh/4U5Vm67nxb32f4H1FAawoziMOmiBY+Kxwp+WNcOvO6MmRqoqpCfqSqI2uHNpsx0DsFItLW1+dDB3g6oaTG0sNPcTws4UOL+N7H+9+2UyD5jn1BmG18c0uLlZET80v/dU9hYXlbZJsM3t1nyI8DGKyPZB5EYmNprm7GAAMjz815cWU9AGJ9kS5v2QDlXQ6aB/bniJ569vVyMkjbiF+pJSdRw3M0bhAlZyWPe8k9YLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hxhLi3QYg0sD1RLbwgCis0jEXkdIzkI6rA24E+B1GUs=;
 b=Chq6802//AvJ6Y/IsefgSvQ4LJe0JL4xmFgFYGOYWKtgw9TQMH5p68K6br9axGHbFaUNkEqKWyrZ89Xh73nJIbPyR1AkK9kH4olpdRFiHlx13xdakljXHSUC0DnEENSskSSS7GrFWWQgKySem5MV0n9WAT/B6LIZRFug3Wws/+HtIs8bAzdlhryQYkvEcF9A6sC8RLwmJFyHhSzh81DV4bS6pTua87eQHh/bMX4561Eyeb6qqokSV4BlbPuuTckxF2lJ4nnF5bzJBXQ32KOTyhgQuA8Owh6seyODncypErSXoX4Ycp4FXMSACcA27aIzKnDNQe7rL2E3tPiL5fSR7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hxhLi3QYg0sD1RLbwgCis0jEXkdIzkI6rA24E+B1GUs=;
 b=A5W55rvs+f4p7NCzPYNszFlipK1alrx2QJzqzBGFKkKe4PtWyPRcxTuBoXBCxtnxni/v5vbcTC3VZgD7z+pq4i4Nglt9kQt4ig99+lNHuS6Qwnw80lUT3wxfPMg+20U7TLhZWxtzLWXRt3N6lLX3uOa8YgMfNLfGfOUCS/FUmI0=
Received: from DB6PR0801MB1702.eurprd08.prod.outlook.com (10.169.221.21) by
 DB6PR0801MB1685.eurprd08.prod.outlook.com (10.169.225.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Thu, 24 Oct 2019 11:14:02 +0000
Received: from DB6PR0801MB1702.eurprd08.prod.outlook.com
 ([fe80::f849:2ba0:2a0b:5b34]) by DB6PR0801MB1702.eurprd08.prod.outlook.com
 ([fe80::f849:2ba0:2a0b:5b34%7]) with mapi id 15.20.2347.030; Thu, 24 Oct 2019
 11:14:02 +0000
From: Denis Lunev <den@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 2/3] qcow2: Assert that qcow2_cache_get() callers hold
 s->lock
Thread-Topic: [PATCH 2/3] qcow2: Assert that qcow2_cache_get() callers hold
 s->lock
Thread-Index: AQHVibZRoCM6NbrZp0+Q3TpWlZwDWKdpws2A///dggCAAASJAA==
Date: Thu, 24 Oct 2019 11:14:02 +0000
Message-ID: <b244c211-aa73-b4f9-7313-474e909359fb@virtuozzo.com>
References: <20191023152620.13166-1-kwolf@redhat.com>
 <20191023152620.13166-3-kwolf@redhat.com>
 <3600fb84-e1f1-c70a-4b83-e7a379f50614@virtuozzo.com>
 <20191024105746.GB6200@linux.fritz.box>
In-Reply-To: <20191024105746.GB6200@linux.fritz.box>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0202CA0035.eurprd02.prod.outlook.com
 (2603:10a6:3:e4::21) To DB6PR0801MB1702.eurprd08.prod.outlook.com
 (2603:10a6:4:2f::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=den@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 716905c6-80d7-449e-6ebc-08d758734692
x-ms-traffictypediagnostic: DB6PR0801MB1685:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0801MB1685B8CEC7303E089B0BB824B66A0@DB6PR0801MB1685.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:203;
x-forefront-prvs: 0200DDA8BE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(136003)(366004)(39840400004)(346002)(376002)(189003)(199004)(52314003)(86362001)(8936002)(2906002)(99286004)(486006)(476003)(2616005)(11346002)(446003)(66446008)(6512007)(66476007)(66556008)(64756008)(25786009)(66946007)(6246003)(31696002)(8676002)(71200400001)(71190400001)(6486002)(386003)(81156014)(76176011)(52116002)(81166006)(53546011)(6506007)(36756003)(6436002)(14454004)(305945005)(229853002)(54906003)(316002)(7736002)(3846002)(5660300002)(6116002)(66066001)(256004)(14444005)(186003)(6916009)(4326008)(102836004)(26005)(31686004)(478600001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB6PR0801MB1685;
 H:DB6PR0801MB1702.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IgO+PaUWawRHkdavLyVcdJomVDQOVZAf9O+kiBGSnR+bgfMbQxdBvwReLwADWrpWGZsBJPM0OLnFvXwwtb+6HUMLBs/EM0ZYLb4dybvAuybAdgavuMQ8TlG1R9HweR93Akep+XxJVuAYL77QElBTcbfV0+wBq9dGEomAIDPXWT1JY92H0gfWlaBu3xJMirWRV6SDHnhyJibgN+sjmwQqNg8xHzulfIyPhOWGi0kOqnQVY7GBWS3gjVlYu/MV9bndlNg/Z9ogJs/qXjQRki0DTut9MnxMt85j3YkOywdcC8lwT8sod9fss1kYga11LbWWMNVccHtvD61Ythpp954LL2SDx6XA8pZ/jTuxK5HWS6LWSrNUIfX3bSfcIY2LsI6GO0FqLi8JmmstVWPZoeXt4iA3EFvDKhEVofpkCLyw0mxtBqnbWjbkF71xDFA9AF1f
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <DB0E61B9902FB449B14C01A391672EE8@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 716905c6-80d7-449e-6ebc-08d758734692
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2019 11:14:02.6948 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eS5891G+yNdx2AiWd4EbhpCB0THJyvIrUf3CJsXdSCFZfvTInI0H8rlZcxlb9hygThCLucA/U/hv2ThtuKxf1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1685
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe1e::708
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
Cc: "psyhomb@gmail.com" <psyhomb@gmail.com>,
 "michael@weiser.dinsnail.net" <michael@weiser.dinsnail.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "lersek@redhat.com" <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/24/19 1:57 PM, Kevin Wolf wrote:
> Am 24.10.2019 um 12:01 hat Denis Lunev geschrieben:
>> On 10/23/19 6:26 PM, Kevin Wolf wrote:
>>> qcow2_cache_do_get() requires that s->lock is locked because it can
>>> yield between picking a cache entry and actually taking ownership of it
>>> by setting offset and increasing the reference count.
>>>
>>> Add an assertion to make sure the caller really holds the lock. The
>>> function can be called outside of coroutine context, where bdrv_pread
>>> and flushes become synchronous operations. The lock cannot and need not
>>> be taken in this case.
>>>
>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>> ---
>>>  block/qcow2-cache.c | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/block/qcow2-cache.c b/block/qcow2-cache.c
>>> index d29b038a67..75b13dad99 100644
>>> --- a/block/qcow2-cache.c
>>> +++ b/block/qcow2-cache.c
>>> @@ -327,6 +327,9 @@ static int qcow2_cache_do_get(BlockDriverState *bs,=
 Qcow2Cache *c,
>>>      int min_lru_index =3D -1;
>>> =20
>>>      assert(offset !=3D 0);
>>> +    if (qemu_in_coroutine()) {
>>> +        qemu_co_mutex_assert_locked(&s->lock);
>>> +    }
>> that is looking not good to me. If this is really requires lock, we shou=
ld
>> check for the lock always. In the other hand we could face missed
>> lock out of coroutine.
> As the commit message explains, outside of coroutine context, we can't
> yield and bdrv_pread and bdrv_flush become synchronous operations
> instead, so there is nothing else that we need to protect against.
>
> Kevin
>
Hmm. It seems I was not careful enough with reading entire message.
I am fine with this though it looks a bit tricky to me as such things
can change in the future.

Anyway, you could consider this as

Reviewed-by: Denis V. Lunev <den@openvz.org>

Den

