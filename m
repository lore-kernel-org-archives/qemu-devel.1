Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD584C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 16:24:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33E922086A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 16:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="qYdgrAUW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33E922086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBLht-0002ZJ-AT
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 12:24:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49685)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iBLLQ-0004JA-RM
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 12:01:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iBLLJ-0001Cs-81
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 12:01:14 -0400
Received: from mail-eopbgr10103.outbound.protection.outlook.com
 ([40.107.1.103]:39194 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iBLLH-0001Bi-SS; Fri, 20 Sep 2019 12:01:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g1yqIt4mSG+e46pezi35sOtfe01NrZWdrqmyn7/QWwtYaXXi4d+ciOOBv3/FSVhmMhnB2cpvvrGyBcIMa1Edpwj2dhYyo6TWnBrPQiDx6ieXjKUdli2mOIpzSKS9N2D6tV/AXTgjp076iTbn4Tc5VNW8dNdNRK/3ETnyr8B9umPtqBiUJjIdE5r6oCHMPOsee0NQq556bZ4SJ0GXkB/Eu2LxHAiM2IIBdm34eSBoncIs9qkGmqCNLbwLdAeBgBTKdTzfVjWFJd48HZXWHnMueNYbRYAdrptX+EF8OOVBNyEKncDLoM5ud45b42nNCdaNPqDIGWKqqkbssOI/AMH0EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2323WnwTqTSOuVnPOiPoHRinZPN41ffrNzTaXuXF/Do=;
 b=LdNWNIjLsw4x+Lqinu4M7pwi5kqDHWqsmD0zaAZTMOxMPlwfZlYuHxIstweLR1GkWLq03FuKTJ8nYYw/+FwU66Iy2A2aKS3e/gEiVqrEAb5FUPaKCa+dsVEIWYwXFdDkrlPe7kX893OUngKVeRMb+LReIa/nPWuT+uJEXR/KszdyvIje6ck9RwUOEbYoOLRXgGvJKtXuWfbLyahZHW3ebvfI9QyNkBnH43FlW7AHJ+2TxuLuWoLiALssJjFLbWUUY5/53NpH9phyQlXlu4YvaKZE/h5cDQ+ZjVY5GjMAcvzSPMglwr7V2VI4K3jV2eLcAXV9x47hSW2O8rSilaXV0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2323WnwTqTSOuVnPOiPoHRinZPN41ffrNzTaXuXF/Do=;
 b=qYdgrAUWoZUAJMYfcvICF7GprxjOIUNMh60ERJPGu4ar68GGiclizS3yIkAF2M1W+kdEATv/JxhygCn3HjmZHpkr3AIa4jCCqK0vSrrGaGy1Ed5H15NTM7d2uaguCAfsXv88fU1OiNcDokgF1IQNTMTeFnxZQWYupIgimYfi5hU=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5386.eurprd08.prod.outlook.com (52.133.241.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.22; Fri, 20 Sep 2019 16:01:05 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2284.023; Fri, 20 Sep 2019
 16:01:05 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH v13 00/15] backup-top filter driver for backup
Thread-Topic: [PATCH v13 00/15] backup-top filter driver for backup
Thread-Index: AQHVb76i9BZRQxEM6EO0oeincwS7S6c0uBiAgAABnIA=
Date: Fri, 20 Sep 2019 16:01:05 +0000
Message-ID: <eeac5b7f-b841-0575-bc36-62326b2bd378@virtuozzo.com>
References: <20190920142056.12778-1-vsementsov@virtuozzo.com>
 <de10d9ad-52c9-525d-b36e-7497535d5360@redhat.com>
In-Reply-To: <de10d9ad-52c9-525d-b36e-7497535d5360@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0182.eurprd05.prod.outlook.com
 (2603:10a6:3:f8::30) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190920190101517
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eacf323f-4565-4204-4f62-08d73de3be08
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5386; 
x-ms-traffictypediagnostic: DB8PR08MB5386:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB53866732DFAFD2ED69B63136C1880@DB8PR08MB5386.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:475;
x-forefront-prvs: 0166B75B74
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(39840400004)(136003)(346002)(366004)(376002)(199004)(189003)(53754006)(386003)(6506007)(54906003)(110136005)(2616005)(11346002)(446003)(486006)(476003)(8676002)(81166006)(81156014)(76176011)(7416002)(5660300002)(8936002)(99286004)(316002)(26005)(186003)(52116002)(36756003)(6116002)(3846002)(2906002)(66476007)(305945005)(7736002)(102836004)(66556008)(6486002)(4744005)(6306002)(66946007)(966005)(25786009)(478600001)(53546011)(64756008)(71200400001)(66446008)(66066001)(6512007)(229853002)(6436002)(14454004)(4326008)(71190400001)(86362001)(256004)(6246003)(31696002)(2501003)(31686004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5386;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: g6t99Q5+Qn9M4l5pBH/x4dVcP+6bKqS8za6/K+gp8+2OePcKSeY0V8fZA00Vup8nYRHXTbHzpiGkW6DKwg1sdQY8qAnkkodOLArFsMCyrJJpiDcxx6XSPjQOCpTF2x0RFmdyEhAiZexeUzoNV2kv7eNkseF95b2KdTSNd7q7uuCU0J6p26uRh/eIrlKGZe+/9jC62hn2rBxukit+BvWlKyiYtRBh1OrMhjXDTfPC6vQ2xCVs3DytGEqUSPFS42/lsL7z1TAhIe7vL+4V/m9PR5ey7YeNJSvNsdsEtCZDXdjdqDByI8BaTXVkWhshNVGDysa3+1qFg3hDdshU8P97Y6VNemei9pwu0lN2gEVEKPa/A8LSwDFhutG4TV/a+vqwKWy2BHok9+9x5vhecVmCzOgK9RlTk1eRfPjIPxTaYX0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A4A5AE9770C2B6418DDC2C14F6BF20DC@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eacf323f-4565-4204-4f62-08d73de3be08
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2019 16:01:05.3702 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zVGkYbnCzH1Gibrd4rOsVQi6XHJmi8HgYhQObziH0ZkSC51e+uxbPn1F/A682RY5cDzvsSu8pv4EfwQsG1AWpTnOxe0RDXiWO/BdIkxLLM0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5386
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
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 Denis Lunev <den@virtuozzo.com>,
 "wencongyang2@huawei.com" <wencongyang2@huawei.com>,
 "xiechanglong.d@gmail.com" <xiechanglong.d@gmail.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jsnow@redhat.com" <jsnow@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjAuMDkuMjAxOSAxODo1NSwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAyMC4wOS4xOSAxNjoyMCwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IEhpIGFsbCENCj4+DQo+PiBU
aGVzZSBzZXJpZXMgaW50cm9kdWNlIGJhY2t1cC10b3AgZHJpdmVyLiBJdCdzIGEgZmlsdGVyLW5v
ZGUsIHdoaWNoDQo+PiBkbyBjb3B5LWJlZm9yZS13cml0ZSBvcGVyYXRpb24uIE1pcnJvciB1c2Vz
IGZpbHRlci1ub2RlIGZvciBoYW5kbGluZw0KPj4gZ3Vlc3Qgd3JpdGVzLCBsZXQncyBtb3ZlIHRv
IGZpbHRlci1ub2RlIChmcm9tIHdyaXRlLW5vdGlmaWVycykgZm9yDQo+PiBiYWNrdXAgdG9vLg0K
Pj4NCj4+IHYxMSx2MTIgLT4gdjEzIGNoYW5nZXM6DQo+Pg0KPj4gW3YxMiB3YXMgdHdvIGZpeGVz
IGluIHNlcGFyYXRlOiBbUEFUQ0ggdjEyIDAvMl0gYmFja3VwOiBjb3B5X3JhbmdlIGZpeGVzXQ0K
Pj4NCj4+IDAxOiBuZXcgaW4gdjEyLCBpbiB2MTMgY2hhbmdlIGNvbW1lbnQNCj4+IDAyOiBpbiB2
MTI6IGFkZCAiRml4ZXM6ICIgdG8gY29tbWl0IG1zZywgaW4gdjEzIGFkZCBKb2huJ3Mgci1iDQo+
PiAwNTogcmViYXNlIG9uIDAxDQo+PiAwNzogcmViYXNlIG9uIDAxLiBJdCBzdGlsbCBhIGNsZWFu
IG1vdmVtZW50LCBrZWVwIHItYg0KPiANCj4gVGhhbmtzLCBhcHBsaWVkIHRvIG15IGJsb2NrIGJy
YW5jaDoNCj4gDQo+IGh0dHBzOi8vZ2l0LnhhbmNsaWMubW9lL1hhbkNsaWMvcWVtdS9jb21taXRz
L2JyYW5jaC9ibG9jaw0KPiANCg0KWW91IG1hZGUgbXkgZGF5IQ0KVGhhbmsgeW91ISENCg0KLS0g
DQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

