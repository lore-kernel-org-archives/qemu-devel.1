Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18707C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 10:23:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D89D52081B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 10:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Qr8rEOww"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D89D52081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7dIY-0008C4-W6
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 06:22:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55587)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i7dEB-0004an-BL
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 06:18:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i7dE9-0007aQ-Q8
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 06:18:26 -0400
Received: from mail-eopbgr30115.outbound.protection.outlook.com
 ([40.107.3.115]:14148 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i7dE9-0007Zj-9r; Tue, 10 Sep 2019 06:18:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kDEcR2sCt6fQmFuEC+nxG7rg0q684PgHhWyfkv15NFac71luUIAElxu/hTMRHVzLGQLe6oYZg3MyWyzNrBsxGRTjiThBw/WjUsrD3OoG4eZbcNX2gLBMH1nrGboDv8f9n30ZZQW5IbLrPKLwocmbrvBZCcxlSX2RRqw+2BDWDa2GmjTyEsZ+SWGqhiq0OOf2HhuS5XY0yU5IyCd536WGAnroOd/7TXuTm5++3X+KsZGrgYdepLkWHz8uS/IDLEOFEfpHiLZy8TThFF8z6lbtPteTqTG5A15OvDMfGSnTzx8TmoRkviLIxmCm+Dep9SfEekeBRAo4mQ89Huvn9je1EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uHBqSHDuzHWIboSHsFjpXvmn0xxO9TCg/I+ybUAJ/IA=;
 b=ODqlVzajyh5spcx6sKhjIZVjyFsCsJU61DUPjh60+qvNFNFFdxb73gpHhPYha2EFwVp9KVfNwHi0uP1Kv9FBrIDFcYjA2EhTaS0KL8AJl5lLxFN4kJqretgqeuFhPwRL4PpPQQ8XsDWQ+SrWibfFDL/ZpFNIRYj8ne8gLwQEGlYi9nnvwVw6yhDJk4cPs16De6DQfhBtA/v2ryJ2i0cftfIt6x9On1n/8YScntVr7FZKzep66s8cmICgg/vKcisoUXj5NG1x6LRsCuHNVnoWmWCDOK8av7FbOSt28TW6E5KmLMpnKnGvs54Q1Z1nuPtQEEYJlSHFRbhMLmX8D5WZjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uHBqSHDuzHWIboSHsFjpXvmn0xxO9TCg/I+ybUAJ/IA=;
 b=Qr8rEOwwJqhPiHsDfsxS8HaeCSSDCTLZpVHWuXM8YnfeNIXpt8AHuyVXT5yneBqQ2DJxAY08mHZLAe1uDAnNdbb1YCOS4ZD00DqX0/rwi069WvqYSDibdq4+5I770Bx/Z99x2zPVDij2dgevO4u9cL6fvhFh/I+BILdw/WZlYWc=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5084.eurprd08.prod.outlook.com (10.255.4.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.18; Tue, 10 Sep 2019 10:18:22 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2241.018; Tue, 10 Sep 2019
 10:18:22 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v10 04/14] block/backup: introduce BlockCopyState
Thread-Index: AQHVX03FFzbmaM/Nm0mHXVJ2sTGOiKcjXkKAgABGsID//9DwAIAADU8AgAEU5gCAAAgnAIAAB5qAgAA+gYD//9wcAIAAARGA
Date: Tue, 10 Sep 2019 10:18:22 +0000
Message-ID: <b5791983-bd73-80ab-104c-c0f48e6a4566@virtuozzo.com>
References: <20190830161228.54238-1-vsementsov@virtuozzo.com>
 <20190830161228.54238-5-vsementsov@virtuozzo.com>
 <ae856032-2d6f-adb8-939b-410708dea596@redhat.com>
 <01bc8974-b9a5-8312-fe24-e2fbe87ab13d@virtuozzo.com>
 <e94365cd-3bdf-4055-10de-abad4f65225b@redhat.com>
 <d4b6869a-a711-f911-2b29-c7062aa44aa6@virtuozzo.com>
 <80720d39-b9d6-d693-0f6a-0a078d6056e0@redhat.com>
 <577ab66d-ea14-a363-0b8a-92932198c284@virtuozzo.com>
 <310835ca-4aa9-0c4f-5d18-1a89e2e0be74@redhat.com>
 <c6859d2b-e530-8e5a-375d-87954c974e0d@virtuozzo.com>
 <079112b9-7a54-1c10-6f89-145d866115f2@redhat.com>
In-Reply-To: <079112b9-7a54-1c10-6f89-145d866115f2@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0341.eurprd05.prod.outlook.com
 (2603:10a6:7:92::36) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190910131819732
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d3a3b73-45e3-4480-7f1c-08d735d8354e
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5084; 
x-ms-traffictypediagnostic: DB8PR08MB5084:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB50847A32F11F8670A9F96BB8C1B60@DB8PR08MB5084.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 01565FED4C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(39840400004)(136003)(376002)(396003)(366004)(199004)(189003)(52314003)(5660300002)(81156014)(66066001)(386003)(6506007)(7416002)(229853002)(71200400001)(31686004)(71190400001)(6486002)(478600001)(476003)(2616005)(11346002)(6116002)(2501003)(26005)(186003)(256004)(102836004)(36756003)(86362001)(31696002)(99286004)(2906002)(316002)(6436002)(53546011)(25786009)(14454004)(486006)(446003)(76176011)(54906003)(110136005)(6246003)(6512007)(107886003)(305945005)(7736002)(66476007)(81166006)(8936002)(4326008)(53936002)(66556008)(8676002)(66946007)(3846002)(66446008)(64756008)(52116002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5084;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fYpH21X228zqeA4lx5RM7bwuUZdyoqQCngy/RJl6rhPVKfqi5LvN4HUh+uIZUetPlwRmFJgBkZjXPVyC1YLEEqQe5p5tWLNAEGjCUpj5VzYffZKDxmQ60vXlydgkCgNmmm0xJKm05bclwA682paQSQi3phr2MrUMoNrYT2gJSmTMK+qfc7/RGyRQ8YCNKzatPC21vvYXYrW/OmDyFTw5z7cibZQ6nd2TAIhkp7hJM0xKFFZPt9aKmLDNfDoMMOBhB9V13vIVyacKAinb/2tESJzvk+dXmb3oPLJGdb7ThODhDMygiuokar3Bh2lfB4gq2SBrKZo/NptMc0KNE3c9y3ANZpbtUTceDt2qhwfAlOSE54uYnF0qg3MYUcY8ocVJxaG/irc2YXSHshQ3wHVrQCbJU6VOevJI36NcvEBEjHs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AE37A32B62E5C942BECB47E8C5C6B135@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d3a3b73-45e3-4480-7f1c-08d735d8354e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2019 10:18:22.1760 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ySLddajOP6tDprt1l7R5+LSDNJSTK8jLUsXySqUDLEUBHbKeeR2bgrCg4OEW/C3oCsXeQt0lj+7qrGyPStbv3ddbfX71GY9SPl13VbTeUU8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5084
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.115
Subject: Re: [Qemu-devel] [PATCH v10 04/14] block/backup: introduce
 BlockCopyState
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTAuMDkuMjAxOSAxMzoxNCwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAxMC4wOS4xOSAxMToyMiwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4gDQo+IFsuLi5dDQo+IA0KPj4g
T2ssIHRoYW4NCj4+DQo+PiA0LiBQb3N0cG9uZSBpbXByb3ZlbWVudHMgZm9yIGEgZm9sbG93LXVw
IChhbnl3YXksIGZpbmFsbHksIGJsb2NrLWNvcHkgc2hvdWxkDQo+PiB1c2UgYmxvY2tfc3RhdHVz
IHRvIGNvcHkgYnkgbGFyZ2VyIGNodW5rcywgbGlrZSBtaXJyb3IgZG9lcyksIGFuZCBpbXByb3Zl
IHRoZQ0KPj4gY29tbWVudCBsaWtlIHRoaXM6DQo+Pg0KPj4gIiIiDQo+PiBVc2VkIGZvciBqb2Ig
c3luYz10b3AgbW9kZSwgd2hpY2ggY3VycmVudGx5IHdvcmtzIGFzIGZvbGxvd3MgKHRoZSBzaXpl
IG9mIHRoZQ0KPj4gY29tbWVudCBkZWZpbml0ZWx5IHNob3dzIHVuY2xlYW4gZGVzaWduLCBidXQg
dGhpcyBpcyBhIFRPRE8gdG8gaW1wcm92ZSBpdCk6DQo+PiBJZiBqb2Igc3RhcnRlZCBpbiBzeW5j
PXRvcCBtb2RlLCB3aGljaCBtZWFucyB0aGF0IHdlIHdhbnQgdG8gY29weSBvbmx5IHBhcnRzDQo+
PiBhbGxvY2F0ZWQgaW4gdG9wIGxheWVyLCBqb2Igc2hvdWxkIGJlaGF2ZSBsaWtlIHRoaXM6DQo+
Pg0KPj4gMS4gQ3JlYXRlIGJsb2NrLWNvcHkgc3RhdGUgd2l0aCBza2lwX3VuYWxsb2NhdGVkID0g
dHJ1ZS4NCj4+IDIuIFRoZW4sIGJsb2NrX2NvcHkoKSB3aWxsIGF1dG9tYXRpY2FsbHkgY2hlY2sg
Zm9yIGFsbG9jYXRpb24gaW4gdG9wIGxheWVyLA0KPj4gYW5kIGRvIG5vdCBjb3B5IGFyZWFzIHdo
aWNoIGFyZSBub3QgYWxsb2NhdGVkIGluIHRvcCBsYXllci4gU28sIGZvciBleGFtcGxlLA0KPj4g
Y29weS1iZWZvcmUtd3JpdGUgb3BlcmF0aW9ucyBpbiBiYWNrdXAgd29ya3MgY29ycmVjdGx5IGV2
ZW4gYmVmb3JlIFszLl0NCj4+IDMuIFNlcXVlbnRpYWxseSBjYWxsIGJsb2NrX2NvcHlfcmVzZXRf
dW5hbGxvY2F0ZWQoKSB0byBjb3ZlciB0aGUgd2hvbGUgc291cmNlDQo+PiBub2RlLCBjb3B5X2Jp
dG1hcCB3aWxsIGJlIHVwZGF0ZWQgY29ycmVzcG9uZGluZ2x5Lg0KPj4gNC4gVW5zZXQgc2tpcF91
bmFsbG9jYXRlZCB2YXJpYWJsZSBpbiBibG9jay1jb3B5IHN0YXRlLCB0byBhdm9pZCBleHRyYSAo
YXMNCj4+IGV2ZXJ5dGhpbmcgaXMgY292ZXJlZCBieSBbMy5dKSBibG9jay1zdGF0dXMgcXVlcmll
cyBpbiBibG9ja19jb3B5KCkgY2FsbHMNCj4+IDUuIERvIHNlcXVlbnRpYWwgY29weWluZyBieSBs
b29wIG9mIGJsb2NrX2NvcHkoKSBjYWxscywgYWxsIG5lZWRlZCBhbGxvY2F0aW9uDQo+PiBpbmZv
cm1hdGlvbiBpcyBhbHJlYWR5IGluIGNvcHlfYml0bWFwLg0KPj4NCj4+ICAgRnJvbSBibG9ja19j
b3B5KCkgc2lkZSwgaXQgYmVoYXZlcyBsaWtlIHRoaXM6DQo+PiBJZiBza2lwX3VuYWxsb2NhdGVk
IGlzIHNldCwgYmxvY2tfY29weSgpIHdpbGwgcmVzZXQgaW4gY29weV9iaXRtYXAgYXJlYXMNCj4+
IHVuYWxsb2NhdGVkIGluIHRvcCBpbWFnZSAoc28gdGhleSB3aWxsIG5vdCBiZSBjb3BpZWQpLiBX
aGVuZXZlciBhbnkgc3VjaA0KPj4gYXJlYSBpcyBjbGVhcmVkLCBwcm9ncmVzc19yZXNldF9jYWxs
YmFjayB3aWxsIGJlIGludm9rZWQuIE5vdGUsIHRoYXQNCj4+IHByb2dyZXNzX3Jlc2V0X2NhbGxi
YWNrIGlzIGNhbGxlZCBmcm9tIGJsb2NrX2NvcHlfcmVzZXRfdW5hbGxvY2F0ZWQoKSB0b28uDQo+
PiAiIiINCj4gDQo+IENhbiB0aGlzIG5vdCBiZSBzaW1wbGlmaWVkPw0KPiANCj4gIiIiDQo+IFVz
ZWQgYnkgc3luYz10b3Agam9icywgd2hpY2ggZmlyc3Qgc2NhbiB0aGUgc291cmNlIG5vZGUgZm9y
IHVuYWxsb2NhdGVkDQo+IGFyZWFzIGFuZCBjbGVhciB0aGVtIGluIHRoZSBjb3B5X2JpdG1hcC4g
IER1cmluZyB0aGlzIHByb2Nlc3MsIHRoZQ0KPiBiaXRtYXAgaXMgdGh1cyBub3QgZnVsbHkgaW5p
dGlhbGl6ZWQ6IEl0IG1heSBzdGlsbCBoYXZlIGJpdHMgc2V0IGZvcg0KPiBhcmVhcyB0aGF0IGFy
ZSB1bmFsbG9jYXRlZCBhbmQgc2hvdWxkIGFjdHVhbGx5IG5vdCBiZSBjb3BpZWQuDQo+IA0KPiBU
aGlzIGlzIGluZGljYXRlZCBieSBza2lwX3VuYWxsb2NhdGVkLg0KPiANCj4gSW4gdGhpcyBjYXNl
LCBibG9ja19jb3B5KCkgd2lsbCBxdWVyeSB0aGUgc291cmNl4oCZcyBhbGxvY2F0aW9uIHN0YXR1
cywNCj4gc2tpcCB1bmFsbG9jYXRlZCByZWdpb25zLCBjbGVhciB0aGVtIGluIHRoZSBjb3B5X2Jp
dG1hcCwgYW5kIGludm9rZQ0KPiBibG9ja19jb3B5X3Jlc2V0X3VuYWxsb2NhdGVkKCkgZXZlcnkg
dGltZSBpdCBkb2VzLg0KPiANCj4gT3RoZXJ3aXNlLCBibG9ja19jb3B5KCkgY29waWVzIGV2ZXJ5
dGhpbmcgdGhhdOKAmXMgZGlydHkgaW4gdGhlIGNvcHlfYml0bWFwLg0KPiAiIiINCj4gDQoNCk9L
LCB0aGFua3MpDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

