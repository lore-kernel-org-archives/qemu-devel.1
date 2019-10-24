Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB4FCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:21:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 867D021906
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="JJk2gPuT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 867D021906
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNdzS-0006sW-6N
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 10:21:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48681)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iNcRD-0001xl-BW
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 08:42:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iNcRB-0000J2-25
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 08:41:58 -0400
Received: from mail-eopbgr10103.outbound.protection.outlook.com
 ([40.107.1.103]:64891 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iNcR6-0000Ge-Kh; Thu, 24 Oct 2019 08:41:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hORMKaZ/fZyN2m2nga1zug2/oROncIKS6F7zzVvwxA0y0Z5M6hYiWNEpxiDRLI6Yks5GwMYb07iWu4E/q73UeqGTGnAR+8teP8c0IFmACd2rLgLFdMAtOBkDztkO5ZbrJT2lBh+i5fBx1YLXdwFSmW/7VRzGXY3TrequV1PVBb+fWRyGX9rIh3DZmeUiUv1UK8+7ZWjK0z2X7TLPMiRebliNpJYtCOOGnnjuHTCjFdfi5d97kf8BDz/30X9IwuOM9NKpEkR/Q3juqzv3NJ8Qh1wNaXX5PSARajNZ5AGsizBqII0vFtz3XBOdU9dOB3WIR6ZGV9F2qFPLzuX/v2Zdwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CNXbi4UgmZCm+uQpBW3I7FwkQWKVCagZ60XyHa9EIGE=;
 b=NbQVgfxXUd3I0OTID7K0x2I0Bf+YcfGoFa8ZhwOxUfCJGj7SCzTPXPBQ7xliDO/nLULRJA17sXvLvyG1PaIPJrPJJbvvlKXTSYWvi+yASTH6JmSLyqAsutw4X6VLyWECxsTiHCAoCt7FfyhEJ7huiwFMQ/GeQ7jn6zlX1CQjRk83ol962kaQmVBlLpdYjV5SorBxPD+X9uIPNvjc0Dlg1dHq+u7F1MjddRh+jNZM0+iBzp+PH2StcXG3D70ChKC/xzCSSrm5OVqNmE+eQrS7+NtsqJgC0ZnRmKMtPCtWMeafmEfgBQ1mV3b4sngklWagEC+ZyB1QYnePjAi7McPd+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CNXbi4UgmZCm+uQpBW3I7FwkQWKVCagZ60XyHa9EIGE=;
 b=JJk2gPuT2f2vEtrelFEtpDVCXTLDeSUv9Gic0KeF6ohJUtGY8hr2woej7pBGwi5H3BSLjMcFeMTDv1Gt1PtZtSWv3aiT1CT++mPMnBsopoGjXi/AHhi5eTg/ZDkhnXP76Rf0fhc3LI6DvA5dJSI4pQ++T+j0wq0T9J/zyT4F9V4=
Received: from AM0PR08MB4435.eurprd08.prod.outlook.com (20.179.35.83) by
 AM0PR08MB3602.eurprd08.prod.outlook.com (20.177.109.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.17; Thu, 24 Oct 2019 12:41:50 +0000
Received: from AM0PR08MB4435.eurprd08.prod.outlook.com
 ([fe80::4461:dd32:b358:110c]) by AM0PR08MB4435.eurprd08.prod.outlook.com
 ([fe80::4461:dd32:b358:110c%7]) with mapi id 15.20.2367.027; Thu, 24 Oct 2019
 12:41:50 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 3/3] qcow2: Fix corruption bug in
 qcow2_detect_metadata_preallocation()
Thread-Topic: [PATCH 3/3] qcow2: Fix corruption bug in
 qcow2_detect_metadata_preallocation()
Thread-Index: AQHVibZRVvKZmtdwLUmUBJHEqcF3fadpnRCAgAAIqwCAABelAA==
Date: Thu, 24 Oct 2019 12:41:50 +0000
Message-ID: <d241e754-d6be-1d91-6a45-ca3200c3f1a3@virtuozzo.com>
References: <20191023152620.13166-1-kwolf@redhat.com>
 <20191023152620.13166-4-kwolf@redhat.com>
 <3cfee2ed-cebb-44ef-82ce-77a77c1a9e6a@virtuozzo.com>
 <20191024111710.GC6200@linux.fritz.box>
In-Reply-To: <20191024111710.GC6200@linux.fritz.box>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR07CA0001.eurprd07.prod.outlook.com
 (2603:10a6:7:67::11) To AM0PR08MB4435.eurprd08.prod.outlook.com
 (2603:10a6:208:144::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191024154148056
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7a01c2fd-0d46-4573-2458-08d7587f8a34
x-ms-traffictypediagnostic: AM0PR08MB3602:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB36022C91FE19E7B7216FF73FC16A0@AM0PR08MB3602.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0200DDA8BE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(396003)(346002)(39840400004)(376002)(366004)(189003)(199004)(52314003)(6486002)(99286004)(478600001)(64756008)(66446008)(186003)(14444005)(6512007)(6436002)(256004)(66946007)(4326008)(14454004)(486006)(2616005)(11346002)(476003)(446003)(31686004)(25786009)(71200400001)(71190400001)(66556008)(76176011)(229853002)(52116002)(26005)(6246003)(102836004)(6506007)(386003)(2906002)(305945005)(66476007)(7736002)(6916009)(36756003)(54906003)(3846002)(8676002)(316002)(81156014)(86362001)(81166006)(5660300002)(6116002)(66066001)(31696002)(8936002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3602;
 H:AM0PR08MB4435.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 805B4ly0CtZfOp/v6r+uK3cqzU+gbgXv0QSL1Asv9wBtyK4q66kOZAq7rZvaM/tnN8z3YNg2WBnyBXTtXLinm5S2pucKtmn6vNYfqJzcOCERoY0uoQTKKebsiZsxx7so0SAhA329dfdHVHjowJXPKlI6cQG4vs/4AWPXSzNvFYfOFiw683dmunV5TmZ6NekACPJXLdKHkCYdrhrw9MQJIGuoUiJpvIZ6ws2sANI+SZEIJN5SljS4LHQfIs20i4mzy7AmBMBOvC9NQtK1y8HwC64nhj8GNtKTX59PODQF7iiN65TuGGgjA0k2p5A9lKjSoCj+Usr7vjZl/0M//DjpAcEOi/1uyUQsrJUkIQ8fIMKc+n3RNKpjhVm3TLOHBHdpTTbt9fkAK57ObUgTLOJLAo72J9ssJicV3JmcJc87ataKzl0r/HvjEaNOkjfbvSL2
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <6E0430CED5A44C46BDDA639F073742C7@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a01c2fd-0d46-4573-2458-08d7587f8a34
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2019 12:41:50.1047 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WrMeyGor9288o0P7V+t2S+4oDIhy+oqVVlgCKibO+skG34HTbV4zhLWJydY2KWeiBMOuZuC0HJuZfHMrik5/PJw3nZaITbYEXGX3iooIcAU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3602
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.103
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
 Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "lersek@redhat.com" <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

24.10.2019 14:17, Kevin Wolf wrote:
> Am 24.10.2019 um 12:46 hat Vladimir Sementsov-Ogievskiy geschrieben:
>> 23.10.2019 18:26, Kevin Wolf wrote:
>>> qcow2_detect_metadata_preallocation() calls qcow2_get_refcount() which
>>> requires s->lock to be taken to protect its accesses to the refcount
>>> table and refcount blocks. However, nothing in this code path actually
>>> took the lock. This could cause the same cache entry to be used by two
>>> requests at the same time, for different tables at different offsets,
>>> resulting in image corruption.
>>>
>>> As it would be preferable to base the detection on consistent data (eve=
n
>>> though it's just heuristics), let's take the lock not only around the
>>> qcow2_get_refcount() calls, but around the whole function.
>>>
>>> This patch takes the lock in qcow2_co_block_status() earlier and assert=
s
>>> in qcow2_detect_metadata_preallocation() that we hold the lock.
>>>
>>> Fixes: 69f47505ee66afaa513305de0c1895a224e52c45
>>> Cc: qemu-stable@nongnu.org
>>> Reported-by: Michael Weiser <michael@weiser.dinsnail.net>
>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>
>> Oh, I'm very sorry. I was going to backport this patch, and found that i=
t's
>> fixed in our downstream long ago, even before last upstream version patc=
h sent :(
>=20
> Seriously? Is your downstream QEMU so divergent from upstream that you
> wouldn't notice something like this? I think you really have to improve
> something there.

How to improve it? Months and years are passed to bring patches into upstre=
am,
of course we have to live with a bunch (now it's nearer to 300 and this is =
a lot
better then 500+ in the recent past) of patches above Rhel release.

>=20
> I mean, we have a serious data corruptor in the 4.1 release and I wasted
> days to debug this, and you've been sitting on a fix for months without
> telling anyone?

Of course, it was not my goal to hide the fix, I'll do my best to avoid thi=
s
in future. Very sorry for your time wasted.

> This isn't a memory leak or something, this kills
> people's images. It's eating their data.

Possibly, I didn't know about data corruption. For some reason I decided th=
at
lock should be taken here, I don't remember. Still I should have
applied it to upstream version too, of course.

>=20
> Modifying an image format driver requires utmost care and I think I'll
> try to make sure to allow only few qcow2 changes per release in the
> future. Too many changes were made in too short time, and with too
> little care, and there are even more qcow2 patches pending. Please check
> whether these series actually match your downstream code.

The difference is that I didn't move the lock() but add separate lock()/unl=
ock()
pair around qcow2_detect_metadata_preallocation(). I think there is no seri=
ous
difference.

> Anyway, we'll
> tread very carefully now with the pending patches, even if it means
> delaying them for another release or two.

What do you mean? What to do with sent patches during several months?

> Stability is way more
> important for an image format driver than new features and
> optimisations.

Agree. But I think, the main source of stability is testing.

>=20
> Do whatever you need to fix your downstream process, but seriously, this
> must not ever happen again.
>=20

I don't see how to improve the process to exclude such problems. But I'll
of course will do my best to avoid them.



--=20
Best regards,
Vladimir

