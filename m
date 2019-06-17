Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D22C1C31E57
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 11:56:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E9132084D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 11:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="GnII3dWN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E9132084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46346 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcqF6-0004lf-Ur
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 07:56:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54869)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hcpx5-0002iI-Ru
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 07:37:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hcpx4-0001IO-Ot
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 07:37:31 -0400
Received: from mail-eopbgr30132.outbound.protection.outlook.com
 ([40.107.3.132]:48157 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hcpws-0000qg-3J; Mon, 17 Jun 2019 07:37:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=laJ+Fby4QKpF8tNMME71dm8kl7sZGNDLIG5KFMc0Flg=;
 b=GnII3dWNn9KedWT0WqsM2Czou9Nx5MtGpgcLu71DHbRx3Sxu1k+vGl4lHngTZ9FkUVOrCg4KTg8Ra08x1zC6K74DByE6Pw6ST/VcokecNHzlGxu/dS6h3SZH7+wACyznbnPt00Ub399oCv3tESP8FI13WiYLzEHh2NsJA31qTH4=
Received: from DBBPR08MB4838.eurprd08.prod.outlook.com (20.179.46.151) by
 DBBPR08MB4442.eurprd08.prod.outlook.com (20.179.43.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.15; Mon, 17 Jun 2019 11:37:08 +0000
Received: from DBBPR08MB4838.eurprd08.prod.outlook.com
 ([fe80::9c49:321c:cc13:35d3]) by DBBPR08MB4838.eurprd08.prod.outlook.com
 ([fe80::9c49:321c:cc13:35d3%3]) with mapi id 15.20.1987.014; Mon, 17 Jun 2019
 11:37:08 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH 0/4] qapi: block-dirty-bitmap-remove
 transaction action
Thread-Index: AQHVGgPy0pH+2tKaiUKYa9aZeS7UJaaQy/WAgA8B/IA=
Date: Mon, 17 Jun 2019 11:37:07 +0000
Message-ID: <125166e6-2983-aaa8-2dad-14c5c7081fd8@virtuozzo.com>
References: <20190603120005.37394-1-vsementsov@virtuozzo.com>
 <54598cf4-a326-5385-2d86-d2dd43f26f47@redhat.com>
In-Reply-To: <54598cf4-a326-5385-2d86-d2dd43f26f47@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P190CA0052.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::41)
 To DBBPR08MB4838.eurprd08.prod.outlook.com
 (2603:10a6:10:d9::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190617143705388
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: acc2b526-bbff-43cd-4277-08d6f3182104
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DBBPR08MB4442; 
x-ms-traffictypediagnostic: DBBPR08MB4442:
x-microsoft-antispam-prvs: <DBBPR08MB444213585C19CA5F4060D09FC1EB0@DBBPR08MB4442.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 0071BFA85B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(376002)(39840400004)(396003)(346002)(136003)(199004)(189003)(53754006)(36756003)(316002)(110136005)(54906003)(68736007)(6512007)(31686004)(2906002)(8676002)(81156014)(81166006)(8936002)(53936002)(6246003)(229853002)(6436002)(6486002)(107886003)(6116002)(66066001)(3846002)(14454004)(4326008)(25786009)(478600001)(2501003)(5660300002)(256004)(102836004)(2201001)(6506007)(386003)(71190400001)(53546011)(7736002)(99286004)(31696002)(76176011)(86362001)(305945005)(52116002)(71200400001)(4744005)(446003)(11346002)(186003)(476003)(2616005)(66476007)(66556008)(64756008)(66446008)(66946007)(486006)(73956011)(26005)(14143004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DBBPR08MB4442;
 H:DBBPR08MB4838.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: aB1v8Ylm99f9ynZxJc08zy38vk8olQQA9kJEhgiuYOSPZxjktQsrkzKCKylmbw6LXSdKhJXGGBc5u5i9dgGR+iqh4gFLF01wTAso8D2wJt3v/dG184kM8Q/DC8FUJ/OW3XDOvEgzxv2YOkMcVzOsMKZVO6AQplEWPaBxoo2IiCA3wWVshDJqCgeBiCuxQ6MALT9k96E6E8UdyNitItlqZzc8fOi1B5b/PlovIHl7QIxncx6YCdXNaxjIHXmySKKibhDuiYVJL9d3Wmew3zsiObLS2qGm4VLCExS/Gb4WmU970LnDhOuvmZkybte6BdyeQAvMNp8ksZGznmpOCEoHUCAlTvp42LWq9A7FedTfuUCMQ2g7QJ/0RAXjb1viP+/KmZqsuT2QYEo8mmeUGV9DwaTTc7NR2mVVqGy9abGuPlI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <157863AC68CBE248AA102801D2032E1E@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acc2b526-bbff-43cd-4277-08d6f3182104
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2019 11:37:07.9844 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4442
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.132
Subject: Re: [Qemu-devel] [PATCH 0/4] qapi: block-dirty-bitmap-remove
 transaction action
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
 Denis Lunev <den@virtuozzo.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 Nikolay Shirokovskiy <nshirokovskiy@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDguMDYuMjAxOSAxOjI2LCBKb2huIFNub3cgd3JvdGU6DQo+IA0KPiANCj4gT24gNi8zLzE5IDg6
MDAgQU0sIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+PiBIaSBhbGwhDQo+
Pg0KPj4gSGVyZSBpcyBibG9jay1kaXJ0eS1iaXRtYXAtcmVtb3ZlIHRyYW5zYWN0aW9uIGFjdGlv
bi4NCj4+DQo+PiBJdCBpcyB1c2VkIHRvIGRvIHRyYW5zYWN0aW9uYWwgbW92ZW1lbnQgb2YgdGhl
IGJpdG1hcCAod2hpY2ggaXMNCj4+IHBvc3NpYmxlIGluIGNvbmp1bmN0aW9uIHdpdGggbWVyZ2Ug
Y29tbWFuZCkuIFRyYW5zYWN0aW9uYWwgYml0bWFwDQo+PiBtb3ZlbWVudCBpcyBuZWVkZWQgaW4g
c2NlbmFyaW9zIHdpdGggZXh0ZXJuYWwgc25hcHNob3QsIHdoZW4gd2UgZG9uJ3QNCj4+IHdhbnQg
dG8gbGVhdmUgY29weSBvZiB0aGUgYml0bWFwIGluIHRoZSBiYXNlIGltYWdlLg0KPj4NCj4gDQo+
IE9oLCBpbnRlcmVzdGluZy4gSSBzZWUgd2h5IHlvdSB3YW50IHRoaXMgbm93LiBPSywgbGV0J3Mg
ZG8gaXQuDQo+IA0KDQoNCkhpIEpvaG4hDQoNCkhtbSwgY291bGQgeW91IHN0YWdlIGl0LCBvciBz
aG91bGQgSSBmaXggc29tZXRoaW5nPyBTZWVtcyBJJ3ZlIGFuc3dlcmVkIGFsbCBxdWVzdGlvbnMu
DQpXZSBuZWVkIHRoaXMgZm9yIG91ciBuZWFyZXN0IHJlbGVhc2UgYW5kIHdhbnRpbmcgdG8gYXZv
aWQgeC12ei0gcHJlZml4ZXMgaW4gdGhlIEFQSSwNCkknZCBiZSB2ZXJ5IGdyYXRlZnVsIGlmIHdl
IG1lcmdlIGl0IHNvb24uDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

