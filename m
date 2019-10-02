Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5943DC352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 15:37:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10F4D21920
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 15:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="f+tiW/mb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10F4D21920
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFgh4-0002hw-3U
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 11:37:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50982)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iFgfg-00026C-BM
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 11:36:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iFgfe-0005pO-Qv
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 11:36:08 -0400
Received: from mail-eopbgr40122.outbound.protection.outlook.com
 ([40.107.4.122]:3043 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iFgfa-0005nc-7d; Wed, 02 Oct 2019 11:36:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MTEI/U1s7H2n238thmQoobwAoAywZFJ3fwANEKB8szagCr+6n/M0j5ACHSAmVd2FQFlRJ6Fs+4kITEQJnlag3VxSVhFRoPDRgTBVR38NQyrrAwYfuLT5qjvBvLJBhYGo2dyU86HsW7aJmfQPlPBpH1CAx1LdybDHlQC3dBXuF5BkX42TLPUKLwI+MGhQIiSTwZ68Aj/cIUfQeYxBuCLQXn2JeavoQ9DkOkVPkRcU/EoqlAq4RWeLYap9AjX+0Uq1lK3l///jzefoZS3ek1CfuZYa+jAmlWDtKdTw0T/CbwFGtpBma2ir7VlnVZYxGE07rA0p7bWRxzd4/Znr/+cTKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xonQxQB1KOC+E5xI+hco2VOtAd21sbnbjuMNki4P/+c=;
 b=WbnIlpgBvDk7Lely0pJ9sDuqCnJgduply/pGB0nBdanbw3/nHhhEmeLVdnBeL7LgGhtsFwlE/r74EFpyAUwHk9yWIW66T6h/RyJoIBRpdwhwSQ8xWdmmerXRWIM/nHeBPUpPXGZVhUsf0G1J4hL6nV53I36mutMexG8hHGesQ9L2RNeXIt3hpbeAimAjgzrr/kwF9GiepgxIwHoGDDm94CZFuVGkVh+rTHJ7CNEgI9RTSYrltPsECn624NOPdTKnIgYQRIS5Hkuu3TnpNnL0pK2KcQyLGR7CePTm28Du45zPah2cJRfW5Sog9vXtpiX5g3vsdyk9RG7IBgnXaWHKdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xonQxQB1KOC+E5xI+hco2VOtAd21sbnbjuMNki4P/+c=;
 b=f+tiW/mbe7DZTqDv9+qh0fHtEpVUNfz7paDS2ncp/oM4KytN1ND42ampDqFPTgF/5CPTQVwab3lpunjUUHhfAMiEEMJfUVD+QGio47zbeHis+JP68lS5f7+k9oO1H8sAZp2rC928pwjD8FsuhTo0ryE7wdxDcdHhmt5EL4cT5FU=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5099.eurprd08.prod.outlook.com (10.255.18.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Wed, 2 Oct 2019 15:35:59 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f%2]) with mapi id 15.20.2305.023; Wed, 2 Oct 2019
 15:35:59 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Andrey Shinkevich
 <andrey.shinkevich@virtuozzo.com>
Subject: Re: [PATCH v2 0/6] qcow2: advanced compression options
Thread-Topic: [PATCH v2 0/6] qcow2: advanced compression options
Thread-Index: AQHVeSzo7pDSi4l2rkmT1MDetXhuAadHc8yAgAAIA4A=
Date: Wed, 2 Oct 2019 15:35:59 +0000
Message-ID: <75c7393b-5ad0-66d5-9592-388f0260a0de@virtuozzo.com>
References: <157002883347.27524.13510585852065141081@8230166b0665>
In-Reply-To: <157002883347.27524.13510585852065141081@8230166b0665>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P18901CA0007.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:3:8b::17) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191002183555922
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0113cf09-01c9-497d-dedd-08d7474e3943
x-ms-traffictypediagnostic: DB8PR08MB5099:
x-ms-exchange-purlcount: 4
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB5099D9EE61BA59AE4BA7A5CAC19C0@DB8PR08MB5099.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0178184651
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(39850400004)(376002)(136003)(346002)(366004)(199004)(189003)(478600001)(2501003)(8676002)(4326008)(5660300002)(14454004)(81156014)(86362001)(110136005)(316002)(8936002)(31696002)(31686004)(2616005)(486006)(446003)(476003)(11346002)(6636002)(36756003)(7416002)(6116002)(3846002)(2906002)(6436002)(99286004)(26005)(54906003)(52116002)(81166006)(102836004)(66946007)(6506007)(386003)(6486002)(25786009)(186003)(6306002)(229853002)(6246003)(66066001)(966005)(6512007)(256004)(14444005)(66446008)(7736002)(305945005)(71200400001)(66476007)(66556008)(64756008)(71190400001)(76176011);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5099;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iqnxzexTujZDuJAaEFybYDMJNC+4Vwoj/VajrEGHvde6DOgrshuZrfzfbrjS5BeEbS1P/jrDKM9pooNhw0VzaKlvZLzzz5KV48esv4CaH3uHSMeVpY0BnpXHSEodDfpgiDBq2BSP2JgOmHsoPZIjXHYJrSw2mR/1VoCISGJBwaQOE15jBTSUDImlrpAWsM/l1kXwrWwwqvA7IqxZXdAawkw7esCaLet2I3pkEeKq9zGVgQSigDfy95b+oRDkBrJHsbEm+JPd5+dDtwtbgx07nfO0cNYShc2OFeYAuvOy1443uynL5bb41sIv1/RzJ5JwEceKcBOKPWOgHSRGF+gNCa1IkKk5eTnoOErO5Vx2ZTlqjWLFYWx7jl9CSma8+a9tlKHKJeyglrwNjeFSQAIQEDWzevTL3GYHtyA8mvy824L/uZvb2wO5SFn7emVfjVh7GYJN3dfFioynKlL2YNtEWQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <629EB2481972734E8B4EDB445956436F@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0113cf09-01c9-497d-dedd-08d7474e3943
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2019 15:35:59.1326 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 03hqOSi7iGE0L+c+PTWmkV7w//PUvDsRFM9jWOuuW6FO2ivuD73LPDOXXKlFocTMviu8o8LF63EKmkCk04kkIf8nCkPjX2JjOXT4IrqIK98=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5099
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.122
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
 "patchew-devel@redhat.com" <patchew-devel@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGksDQoNCjAyLjEwLjIwMTkgMTg6MDcsIG5vLXJlcGx5QHBhdGNoZXcub3JnIHdyb3RlOg0KPiBQ
YXRjaGV3IFVSTDogaHR0cHM6Ly9wYXRjaGV3Lm9yZy9RRU1VLzE1NzAwMjYxNjYtNzQ4NTY2LTEt
Z2l0LXNlbmQtZW1haWwtYW5kcmV5LnNoaW5rZXZpY2hAdmlydHVvenpvLmNvbS8NCj4gDQo+IA0K
PiANCj4gSGksDQo+IA0KPiBUaGlzIHNlcmllcyBmYWlsZWQgdGhlIGRvY2tlci1xdWlja0BjZW50
b3M3IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1hbmRzIGFuZA0KPiB0
aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQsIHlvdSBjYW4g
cHJvYmFibHkgcmVwcm9kdWNlIGl0DQo+IGxvY2FsbHkuDQo+IA0KPiA9PT0gVEVTVCBTQ1JJUFQg
QkVHSU4gPT09DQo+ICMhL2Jpbi9iYXNoDQo+IG1ha2UgZG9ja2VyLWltYWdlLWNlbnRvczcgVj0x
IE5FVFdPUks9MQ0KPiB0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2VudG9zNyBTSE9XX0VO
Vj0xIEo9MTQgTkVUV09SSz0xDQo+ID09PSBURVNUIFNDUklQVCBFTkQgPT09DQo+IA0KPiAgICBD
QyAgICAgIGJsb2NrL3BhcmFsbGVscy5vDQo+ICAgIENDICAgICAgYmxvY2svYmxrbG9nd3JpdGVz
Lm8NCj4gICAgQ0MgICAgICBibG9jay9ibG9jay1iYWNrZW5kLm8NCj4gL3RtcC9xZW11LXRlc3Qv
c3JjL2Jsb2NrL3Fjb3cyLmM6NDA3Nzo2NDogZXJyb3I6IHVua25vd24gdHlwZSBuYW1lICdBaW9U
YXNrJw0KPiAgIHN0YXRpYyBjb3JvdXRpbmVfZm4gaW50IHFjb3cyX2NvX3B3cml0ZXZfY29tcHJl
c3NlZF90YXNrX2VudHJ5KEFpb1Rhc2sgKnRhc2spDQo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXg0KPiAvdG1wL3FlbXUt
dGVzdC9zcmMvYmxvY2svcWNvdzIuYzogSW4gZnVuY3Rpb24gJ3Fjb3cyX2NvX3B3cml0ZXZfY29t
cHJlc3NlZF9wYXJ0JzoNCj4gL3RtcC9xZW11LXRlc3Qvc3JjL2Jsb2NrL3Fjb3cyLmM6NDA5ODo1
OiBlcnJvcjogdW5rbm93biB0eXBlIG5hbWUgJ0Fpb1Rhc2tQb29sJw0KPiAgICAgICBBaW9UYXNr
UG9vbCAqYWlvID0gTlVMTDsNCj4gICAgICAgXg0KDQoNCldobyBrbm93cywgd2hhdCBpcyB3cm9u
ZyB3aXRoIGl0PyBTZWVtcyBwYXRjaGV3IGlnbm9yZXMgQmFzZWQtb246IHRhZyBpbiBjb3Zlci1s
ZXR0ZXIsDQp3aGljaCBpcyB3cml0dGVuIGFzICJCYXNlZC1vbjogaHR0cHM6Ly9naXRodWIuY29t
L1hhbkNsaWMvcWVtdS5naXQgYmxvY2siLi4uDQpUaGVzZSBuZXcgdHlwZXMgYW5kIGZ1bmN0aW9u
cyBhcmUgZGVmaW5lZCBpbiBNYXgncyBibG9jayBicmFuY2guDQoNCg0KPiAvdG1wL3FlbXUtdGVz
dC9zcmMvYmxvY2svcWNvdzIuYzo0MTIzOjU6IGVycm9yOiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBv
ZiBmdW5jdGlvbiAnYWlvX3Rhc2tfcG9vbF9zdGF0dXMnIFstV2Vycm9yPWltcGxpY2l0LWZ1bmN0
aW9uLWRlY2xhcmF0aW9uXQ0KPiAgICAgICB3aGlsZSAoYnl0ZXMgJiYgYWlvX3Rhc2tfcG9vbF9z
dGF0dXMoYWlvKSA9PSAwKSB7DQo+ICAgICAgIF4NCj4gL3RtcC9xZW11LXRlc3Qvc3JjL2Jsb2Nr
L3Fjb3cyLmM6NDEyMzo1OiBlcnJvcjogbmVzdGVkIGV4dGVybiBkZWNsYXJhdGlvbiBvZiAnYWlv
X3Rhc2tfcG9vbF9zdGF0dXMnIFstV2Vycm9yPW5lc3RlZC1leHRlcm5zXQ0KPiAvdG1wL3FlbXUt
dGVzdC9zcmMvYmxvY2svcWNvdzIuYzo0MTMwOjEzOiBlcnJvcjogaW1wbGljaXQgZGVjbGFyYXRp
b24gb2YgZnVuY3Rpb24gJ2Fpb190YXNrX3Bvb2xfbmV3JyBbLVdlcnJvcj1pbXBsaWNpdC1mdW5j
dGlvbi1kZWNsYXJhdGlvbl0NCj4gICAgICAgICAgICAgICBhaW8gPSBhaW9fdGFza19wb29sX25l
dyhRQ09XMl9NQVhfV09SS0VSUyk7DQo+ICAgICAgICAgICAgICAgXg0KPiAvdG1wL3FlbXUtdGVz
dC9zcmMvYmxvY2svcWNvdzIuYzo0MTMwOjEzOiBlcnJvcjogbmVzdGVkIGV4dGVybiBkZWNsYXJh
dGlvbiBvZiAnYWlvX3Rhc2tfcG9vbF9uZXcnIFstV2Vycm9yPW5lc3RlZC1leHRlcm5zXQ0KPiAv
dG1wL3FlbXUtdGVzdC9zcmMvYmxvY2svcWNvdzIuYzo0MTMwOjM3OiBlcnJvcjogJ1FDT1cyX01B
WF9XT1JLRVJTJyB1bmRlY2xhcmVkIChmaXJzdCB1c2UgaW4gdGhpcyBmdW5jdGlvbikNCj4gICAg
ICAgICAgICAgICBhaW8gPSBhaW9fdGFza19wb29sX25ldyhRQ09XMl9NQVhfV09SS0VSUyk7DQo+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXg0KPiAvdG1wL3FlbXUtdGVz
dC9zcmMvYmxvY2svcWNvdzIuYzo0MTMwOjM3OiBub3RlOiBlYWNoIHVuZGVjbGFyZWQgaWRlbnRp
ZmllciBpcyByZXBvcnRlZCBvbmx5IG9uY2UgZm9yIGVhY2ggZnVuY3Rpb24gaXQgYXBwZWFycyBp
bg0KPiAvdG1wL3FlbXUtdGVzdC9zcmMvYmxvY2svcWNvdzIuYzo0MTMzOjk6IGVycm9yOiBpbXBs
aWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiAncWNvdzJfYWRkX3Rhc2snIFstV2Vycm9yPWlt
cGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQ0KPiAgICAgICAgICAgcmV0ID0gcWNvdzJfYWRk
X3Rhc2soYnMsIGFpbywgcWNvdzJfY29fcHdyaXRldl9jb21wcmVzc2VkX3Rhc2tfZW50cnksDQo+
ICAgICAgICAgICBeDQo+IC90bXAvcWVtdS10ZXN0L3NyYy9ibG9jay9xY293Mi5jOjQxMzM6OTog
ZXJyb3I6IG5lc3RlZCBleHRlcm4gZGVjbGFyYXRpb24gb2YgJ3Fjb3cyX2FkZF90YXNrJyBbLVdl
cnJvcj1uZXN0ZWQtZXh0ZXJuc10NCj4gL3RtcC9xZW11LXRlc3Qvc3JjL2Jsb2NrL3Fjb3cyLmM6
NDEzMzozOTogZXJyb3I6ICdxY293Ml9jb19wd3JpdGV2X2NvbXByZXNzZWRfdGFza19lbnRyeScg
dW5kZWNsYXJlZCAoZmlyc3QgdXNlIGluIHRoaXMgZnVuY3Rpb24pDQo+ICAgICAgICAgICByZXQg
PSBxY293Ml9hZGRfdGFzayhicywgYWlvLCBxY293Ml9jb19wd3JpdGV2X2NvbXByZXNzZWRfdGFz
a19lbnRyeSwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4NCj4g
L3RtcC9xZW11LXRlc3Qvc3JjL2Jsb2NrL3Fjb3cyLmM6NDE0NTo5OiBlcnJvcjogaW1wbGljaXQg
ZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24gJ2Fpb190YXNrX3Bvb2xfd2FpdF9hbGwnIFstV2Vycm9y
PWltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQ0KPiAgICAgICAgICAgYWlvX3Rhc2tfcG9v
bF93YWl0X2FsbChhaW8pOw0KPiAgICAgICAgICAgXg0KPiAvdG1wL3FlbXUtdGVzdC9zcmMvYmxv
Y2svcWNvdzIuYzo0MTQ1Ojk6IGVycm9yOiBuZXN0ZWQgZXh0ZXJuIGRlY2xhcmF0aW9uIG9mICdh
aW9fdGFza19wb29sX3dhaXRfYWxsJyBbLVdlcnJvcj1uZXN0ZWQtZXh0ZXJuc10NCj4gL3RtcC9x
ZW11LXRlc3Qvc3JjL2Jsb2NrL3Fjb3cyLmM6IEF0IHRvcCBsZXZlbDoNCj4gL3RtcC9xZW11LXRl
c3Qvc3JjL2Jsb2NrL3Fjb3cyLmM6NDAxMjoxOiBlcnJvcjogJ3Fjb3cyX2NvX3B3cml0ZXZfY29t
cHJlc3NlZF90YXNrJyBkZWZpbmVkIGJ1dCBub3QgdXNlZCBbLVdlcnJvcj11bnVzZWQtZnVuY3Rp
b25dDQo+ICAgcWNvdzJfY29fcHdyaXRldl9jb21wcmVzc2VkX3Rhc2soQmxvY2tEcml2ZXJTdGF0
ZSAqYnMsDQo+ICAgXg0KPiBjYzE6IGFsbCB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9y
cw0KPiBtYWtlOiAqKiogW2Jsb2NrL3Fjb3cyLm9dIEVycm9yIDENCj4gbWFrZTogKioqIFdhaXRp
bmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4NCj4gVHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxs
IGxhc3QpOg0KPiAgICBGaWxlICIuL3Rlc3RzL2RvY2tlci9kb2NrZXIucHkiLCBsaW5lIDY2Miwg
aW4gPG1vZHVsZT4NCj4gLS0tDQo+ICAgICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNv
ZGUsIGNtZCkNCj4gc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snc3Vk
bycsICctbicsICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFlbXUuaW5zdGFuY2Uu
dXVpZD00YTBmYTk4MWNkYjc0YjQ4OTQ2ZjYyZDNkZjk1NmJmMScsICctdScsICcxMDAxJywgJy0t
c2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJtJywgJy1lJywgJ1RBUkdF
VF9MSVNUPScsICctZScsICdFWFRSQV9DT05GSUdVUkVfT1BUUz0nLCAnLWUnLCAnVj0nLCAnLWUn
LCAnSj0xNCcsICctZScsICdERUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9MScsICctZScsICdDQ0FD
SEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Ly5jYWNoZS9xZW11
LWRvY2tlci1jY2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hl
dy10ZXN0ZXItdG1wLXprMXQwcHdsL3NyYy9kb2NrZXItc3JjLjIwMTktMTAtMDItMTEuMDUuMzQu
MjgwOTQ6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXU6Y2VudG9zNycsICcvdmFyL3RtcC9xZW11
L3J1bicsICd0ZXN0LXF1aWNrJ10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuDQo+
IGZpbHRlcj0tLWZpbHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPTRhMGZhOTgxY2Ri
NzRiNDg5NDZmNjJkM2RmOTU2YmYxDQo+IG1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3Ig
MQ0KPiBtYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXIt
dG1wLXprMXQwcHdsL3NyYycNCj4gbWFrZTogKioqIFtkb2NrZXItcnVuLXRlc3QtcXVpY2tAY2Vu
dG9zN10gRXJyb3IgMg0KPiANCj4gcmVhbCAgICAxbTM5LjI2OHMNCj4gdXNlciAgICAwbTcuOTg0
cw0KPiANCj4gDQo+IFRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQNCj4gaHR0cDovL3BhdGNo
ZXcub3JnL2xvZ3MvMTU3MDAyNjE2Ni03NDg1NjYtMS1naXQtc2VuZC1lbWFpbC1hbmRyZXkuc2hp
bmtldmljaEB2aXJ0dW96em8uY29tL3Rlc3RpbmcuZG9ja2VyLXF1aWNrQGNlbnRvczcvP3R5cGU9
bWVzc2FnZS4NCj4gLS0tDQo+IEVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNo
ZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4NCj4gUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0
byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20NCj4gDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpW
bGFkaW1pcg0K

