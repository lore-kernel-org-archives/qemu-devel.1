Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D57ECC10F14
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 08:42:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D96420673
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 08:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="gLc/2dft"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D96420673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHl4W-00024H-Lk
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 04:42:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57129)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iHl3Z-0001Lw-8s
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 04:41:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iHl3X-0007Pj-T0
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 04:41:21 -0400
Received: from mail-eopbgr150117.outbound.protection.outlook.com
 ([40.107.15.117]:47782 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iHl3Q-0007Cc-Sj; Tue, 08 Oct 2019 04:41:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aI8vVHQx10kuJDCM9lg1dVR55P8WuUYjEFQjrraxzTT5iOkB9temzR7O9AsO5abct0NA/J3kp23IQ6D1YQvIio1iwM/DVhZtd5CfluUddwd3THjx/JY4JEcY85BS5z3ve/uPrUtYDJulv5gL7b+eUVKSNkrz6itQ1nvpwIqVh8LJPuuY9ti1AEG/I1Yg1IFrcyVkMwkGgMLBZ3s1VKqRwjlIz2CQTuk9Im6Pt1dGqL1aeta8rZE7/XG7f//o0dD4//2PEYyavO+8Bs8oqdDwtvq5LzNVgaajVtjv5LQYXJA8Lrlz38mpp8BmCSvPoGYT4afUZ5gwm5D16P6AEDZ+Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HVo18PR/l2kDtXOZ1+ZLfwqLzjB/yLlC1tJf0jnJdyk=;
 b=Y55D1h05S45wCD7q4m0FEIKHMsYvsqF6Ksm6CMCfZ99Cn+aGxTnwGbQqEYEQ8H/USzp/3C2TJ8US6jDRNtxmKjCIN1NkEp8ToTeEXGn67Jc6glbrrmew0KP15H1F5LfdYE10UHMA7JPunFpm2ORCVl9qZyAeAO/WKhAyP0WrGl+rAYtfwh5Jg0QPwv0L/TgcLEKoTLFsjMjluXyazDYsDxur3uf9pWJKBimhYuG6x9OCGs4ekdBmppvQEJRlD+JXjdDar52khVOQQQR7HL4fGOTUYfdnAyLRRQXBR+9MdBICl/Yxz6CEyaM3wBZl9pL4TxuiXoT8csyzHplL4xcV4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HVo18PR/l2kDtXOZ1+ZLfwqLzjB/yLlC1tJf0jnJdyk=;
 b=gLc/2dfty6RTXbz7kiY2U/gLBcxNiCzdnjT9Zk0t39Or9YtHS8POrNr/e/t77JWmFRuGgl5bO+DvMe2W+nmkJaq6zyI3bZACMbJD9enlMw+XLgLYPcewH0dpT+rxZlIiT1WzMWkwSJWIizzKK9XqhgKmT9QqhN397yugyukFIBQ=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4955.eurprd08.prod.outlook.com (10.255.4.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.23; Tue, 8 Oct 2019 08:41:09 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f%2]) with mapi id 15.20.2327.023; Tue, 8 Oct 2019
 08:41:09 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v4 00/31] error: auto propagated local_err
Thread-Topic: [PATCH v4 00/31] error: auto propagated local_err
Thread-Index: AQHVeHBjrP5HIXy9eUuF1AJePQl1JqdQY7bDgAATpgA=
Date: Tue, 8 Oct 2019 08:41:08 +0000
Message-ID: <a449a64d-ca3c-2442-27b3-70b565545a36@virtuozzo.com>
References: <20191001155319.8066-1-vsementsov@virtuozzo.com>
 <87eeznn185.fsf@dusky.pond.sub.org>
In-Reply-To: <87eeznn185.fsf@dusky.pond.sub.org>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P189CA0019.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::32)
 To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191008114104001
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0cc70b6d-3cd3-49e3-e688-08d74bcb43e1
x-ms-traffictypediagnostic: DB8PR08MB4955:
x-microsoft-antispam-prvs: <DB8PR08MB495562D4B6087440A402EE3EC19A0@DB8PR08MB4955.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 01842C458A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(346002)(396003)(136003)(39850400004)(366004)(199004)(53754006)(189003)(52116002)(6916009)(8676002)(81166006)(478600001)(81156014)(14454004)(561944003)(25786009)(99286004)(54906003)(7416002)(7406005)(7736002)(31686004)(316002)(5660300002)(305945005)(76176011)(8936002)(476003)(6436002)(446003)(11346002)(66946007)(66556008)(64756008)(66446008)(66476007)(6506007)(71190400001)(2906002)(256004)(486006)(2616005)(229853002)(6486002)(26005)(6246003)(31696002)(86362001)(186003)(386003)(4326008)(36756003)(71200400001)(6512007)(102836004)(6116002)(3846002)(66066001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4955;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G+25fCvAQqj1rqegsJMPn8+cnoii5C8ZzxPfcdfBJKJwLiA239IlyOnxuSJF+JBKosE5M8hjzXj0BaKBZdsN1Yz0WzuDGLPI35KtE0B8gF+XrlMrj8YHNTgmN4o5yvXTilj4C+Hgl2MUnlZKrcRHLBEluZu0QCAXvSpNNrSMSXH7Y3zXQ6bD6MAC0kMDyVguS7svFwZTAQtekGeInzJ4kCPM4hpwzPFtU3pKjuK73zB+ZrMM67Kdr9tN5vWx/l5ohsWab6NqkIJoHCPzH07hEzztRjFYhtAkvYe+A4TxWJEF5RP3i/MULxWCozgjQQeJRweIJY735aITM2o8ec1C1lmkyyKlkjFr8wGtJyDzWQs/VIK/aht8DqC3YwejzPfPc19sGh3xOXuyn/hlOvFQxm8MqDn8XpdB5Uep7Y1r2Yk=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <150D088C8346574C84C31BF4A7915B17@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cc70b6d-3cd3-49e3-e688-08d74bcb43e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2019 08:41:09.0030 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5JrQfN61h5VsCE8T88jXidQhjj9OPSdUf+NtZGS/nTAZUo38S1EY0RrRsR9SGrVV46QuQxJ9+G9OKPoa5GASu2fI7vbXKdN/NQEtHjelsBA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4955
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.117
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
Cc: "fam@euphon.net" <fam@euphon.net>,
 "pburton@wavecomp.com" <pburton@wavecomp.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "codyprime@gmail.com" <codyprime@gmail.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "mark.cave-ayland@ilande.co.uk" <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kraxel@redhat.com" <kraxel@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "quintela@redhat.com" <quintela@redhat.com>,
 "arikalo@wavecomp.com" <arikalo@wavecomp.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>,
 "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>,
 "joel@jms.id.au" <joel@jms.id.au>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>,
 "farman@linux.ibm.com" <farman@linux.ibm.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>, "sw@weilnetz.de" <sw@weilnetz.de>,
 "groug@kaod.org" <groug@kaod.org>,
 "yuval.shaia@oracle.com" <yuval.shaia@oracle.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "clg@kaod.org" <clg@kaod.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "david@redhat.com" <david@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 "integration@gluster.org" <integration@gluster.org>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "andrew@aj.id.au" <andrew@aj.id.au>, "cohuck@redhat.com" <cohuck@redhat.com>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>,
 "sundeep.lkml@gmail.com" <sundeep.lkml@gmail.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDguMTAuMjAxOSAxMDozMCwgTWFya3VzIEFybWJydXN0ZXIgd3JvdGU6DQo+IFZsYWRpbWlyIFNl
bWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4gd3JpdGVzOg0KPiAN
Cj4+IEhpIGFsbCENCj4+DQo+PiBIZXJlIGlzIGEgcHJvcG9zYWwgb2YgYXV0byBwcm9wYWdhdGlv
biBmb3IgbG9jYWxfZXJyLCB0byBub3QgY2FsbA0KPj4gZXJyb3JfcHJvcGFnYXRlIG9uIGV2ZXJ5
IGV4aXQgcG9pbnQsIHdoZW4gd2UgZGVhbCB3aXRoIGxvY2FsX2Vyci4NCj4+DQo+PiBUaGVyZSBh
cmUgYWxzbyB0d28gaXNzdWVzIHdpdGggZXJycDoNCj4+DQo+PiAxLiBlcnJvcl9mYXRhbCAmIGVy
cm9yX2FwcGVuZF9oaW50L2Vycm9yX3ByZXBlbmQ6IHVzZXIgY2FuJ3Qgc2VlIHRoaXMNCj4+IGFk
ZGl0aW9uYWwgaW5mbywgYmVjYXVzZSBleGl0KCkgaGFwcGVucyBpbiBlcnJvcl9zZXRnIGVhcmxp
ZXIgdGhhbiBpbmZvDQo+PiBpcyBhZGRlZC4gW1JlcG9ydGVkIGJ5IEdyZWcgS3Vyel0NCj4gDQo+
IEhvdyBpcyB0aGlzIHNlcmllcyByZWxhdGVkIHRvIEdyZWcncyAiW1BBVENIIDAwLzE3XSBGaXgg
dXNhZ2Ugb2YNCj4gZXJyb3JfYXBwZW5kX2hpbnQoKSI/ICBEbyB3ZSBuZWVkIGJvdGg/DQoNClRo
ZXNlIHNlcmllcyBpcyBhIHN1YnN0aXR1dGlvbiBmb3IgR3JlZydzLiBTdGlsbCwgdGhlcmUgYXJl
IHByb2JsZW1zIHdpdGgNCmF1dG9tYXRpb24sIHdoaWNoIEdyZWcgcG9pbnRlZCBpbiAyMS8zMSwg
YW5kIEkgZG9uJ3Qga25vdyB3aGF0IHRvIGRvIG5leHQuDQoNCk1heSBiZSwganVzdCBjb250aW51
ZSB0byByZXZpZXcgcGF0Y2hlcyBhbmQgZml4IHRoZW0gYnkgaGFuZC4gTWF5IGJlIHRyeSB0bw0K
aW1wcm92ZSBhdXRvbWF0aW9uLi4uDQoNCj4gDQo+PiAyLiBlcnJvcl9hYm9ydCAmIGVycm9yX3By
b3BhZ2F0ZTogd2hlbiB3ZSB3cmFwDQo+PiBlcnJvcl9hYm9ydCBieSBsb2NhbF9lcnIrZXJyb3Jf
cHJvcGFnYXRlLCByZXN1bHRpbmcgY29yZWR1bXAgd2lsbA0KPj4gcmVmZXIgdG8gZXJyb3JfcHJv
cGFnYXRlIGFuZCBub3QgdG8gdGhlIHBsYWNlIHdoZXJlIGVycm9yIGhhcHBlbmVkLg0KPj4gKHRo
ZSBtYWNybyBpdHNlbGYgZG9uJ3QgZml4IHRoZSBpc3N1ZSwgYnV0IGl0IGFsbG93cyB0byBbMy5d
IGRyb3AgYWxsDQo+PiBsb2NhbF9lcnIrZXJyb3JfcHJvcGFnYXRlIHBhdHRlcm4sIHdoaWNoIHdp
bGwgZGVmaW5pdGVseSBmaXggdGhlIGlzc3VlKQ0KPj4gW1JlcG9ydGVkIGJ5IEtldmluIFdvbGZd
DQo+Pg0KPj4gU3RpbGwsIGFwcGx5aW5nIG5ldyBtYWNybyB0byBhbGwgZXJycC1mdW5jdGlvbnMg
aXMgYSBodWdlIHRhc2ssIHdoaWNoIGlzDQo+PiBpbXBvc3NpYmxlIHRvIHNvbHZlIGluIG9uZSBz
ZXJpZXMuDQo+Pg0KPj4gU28sIGhlcmUgaXMgYSBtaW5pbXVtOiBzb2x2ZSBvbmx5IFsxLl0sIGJ5
IGFkZGluZyBuZXcgbWFjcm8gdG8gYWxsDQo+PiBlcnJwLWZ1bmN0aW9ucyB3aGljaCB3YW50cyB0
byBjYWxsIGVycm9yX2FwcGVuZF9oaW50Lg0KPj4NCj4+IHY0Ow0KPj4gMDI6IC0gY2hlY2sgZXJy
cCB0byBiZSBub3QgTlVMTA0KPj4gICAgICAtIGRyb3AgRXJpYydzIHItYg0KPj4gMDM6IGFkZCBF
cmljJ3Mgci1iDQo+PiAwNDogLSByZW5hbWUgbWFjcm8gdG8gRVJSUF9BVVRPX1BST1BBR0FURSBb
S2V2aW5dDQo+PiAgICAgIC0gaW1wcm92ZSBjb21tZW50IGFuZCBjb21taXQgbXNnLCBtZW50aW9u
DQo+PiAgICAgICAgZXJyb3JfcHJlcGVuZA0KPj4gMDU6IC0gaGFuZGxlIGVycm9yX3ByZXBlbmQg
dG9vDQo+PiAgICAgIC0gdXNlIG5ldyBtYWNybyBuYW1lDQo+PiAgICAgIC0gZHJvcCBlbXB0eSBs
aW5lIGF0IHRoZSBlbmQNCj4+DQo+PiBjb21taXQgbWVzc2FnZSBmb3IgYXV0by1nZW5lcmF0ZWQg
Y29tbWl0cyB1cGRhdGVkLA0KPj4gY29tbWl0cyByZWdlbmVyYXRlZC4NCj4+DQo+PiBJJ2xsIHVz
ZSBjYy1jbWQgdG8gY2MgYXBwcm9wcmlhdGUgcmVjaXBpZW50cyBwZXIgcGF0Y2gsIHN0aWxsDQo+
PiBjb3Zlci1sZXR0ZXIgdG9nZXRoZXIgd2l0aCAwNC0wNiBwYXRjaGVzIHNob3VsZCBiZSBpbnRl
cmVzdGluZyBmb3INCj4+IGFsbDoNCj4gWy4uLl0NCj4gDQo+IEJpZyBzZXJpZXM7IGxldCBtZSBn
dWVzcyBpdHMgc3RydWN0dXJlLg0KPiANCj4+IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkg
KDMxKToNCj4+ICAgIGVycnA6IHJlbmFtZSBlcnJwIHRvIGVycnBfaW4gd2hlcmUgaXQgaXMgSU4t
YXJndW1lbnQNCj4+ICAgIGh3L2NvcmUvbG9hZGVyLWZpdDogZml4IGZyZWVpbmcgZXJycCBpbiBm
aXRfbG9hZF9mZHQNCj4+ICAgIG5ldC9uZXQ6IGZpeCBsb2NhbCB2YXJpYWJsZSBzaGFkb3dpbmcg
aW4gbmV0X2NsaWVudF9pbml0DQo+IA0KPiBQcmVwYXJhdGlvbnMuDQo+IA0KPj4gICAgZXJyb3I6
IGF1dG8gcHJvcGFnYXRlZCBsb2NhbF9lcnINCj4gDQo+IFRoZSBuZXcgaWRlYS4NCj4gDQo+PiAg
ICBzY3JpcHRzOiBhZGQgc2NyaXB0IHRvIGZpeCBlcnJvcl9hcHBlbmRfaGludC9lcnJvcl9wcmVw
ZW5kIHVzYWdlDQo+PiAgICBweXRob246IGFkZCBjb21taXQtcGVyLXN1YnN5c3RlbS5weQ0KPiAN
Cj4gU2NyaXB0cyB0byBoZWxwIHlvdSBhcHBseSBpdC4NCj4gDQo+PiAgICBzMzkwOiBGaXggZXJy
b3JfYXBwZW5kX2hpbnQvZXJyb3JfcHJlcGVuZCB1c2FnZQ0KPj4gICAgQVJNIFRDRyBDUFVzOiBG
aXggZXJyb3JfYXBwZW5kX2hpbnQvZXJyb3JfcHJlcGVuZCB1c2FnZQ0KPj4gICAgUG93ZXJQQyBU
Q0cgQ1BVczogRml4IGVycm9yX2FwcGVuZF9oaW50L2Vycm9yX3ByZXBlbmQgdXNhZ2UNCj4+ICAg
IGFybTogRml4IGVycm9yX2FwcGVuZF9oaW50L2Vycm9yX3ByZXBlbmQgdXNhZ2UNCj4+ICAgIFNt
YXJ0RnVzaW9uMjogRml4IGVycm9yX2FwcGVuZF9oaW50L2Vycm9yX3ByZXBlbmQgdXNhZ2UNCj4+
ICAgIEFTUEVFRCBCTUNzOiBGaXggZXJyb3JfYXBwZW5kX2hpbnQvZXJyb3JfcHJlcGVuZCB1c2Fn
ZQ0KPj4gICAgQm9zdG9uOiBGaXggZXJyb3JfYXBwZW5kX2hpbnQvZXJyb3JfcHJlcGVuZCB1c2Fn
ZQ0KPj4gICAgUG93ZXJOViAoTm9uLVZpcnR1YWxpemVkKTogRml4IGVycm9yX2FwcGVuZF9oaW50
L2Vycm9yX3ByZXBlbmQgdXNhZ2UNCj4+ICAgIFBDSTogRml4IGVycm9yX2FwcGVuZF9oaW50L2Vy
cm9yX3ByZXBlbmQgdXNhZ2UNCj4+ICAgIFNDU0k6IEZpeCBlcnJvcl9hcHBlbmRfaGludC9lcnJv
cl9wcmVwZW5kIHVzYWdlDQo+PiAgICBVU0I6IEZpeCBlcnJvcl9hcHBlbmRfaGludC9lcnJvcl9w
cmVwZW5kIHVzYWdlDQo+PiAgICBWRklPOiBGaXggZXJyb3JfYXBwZW5kX2hpbnQvZXJyb3JfcHJl
cGVuZCB1c2FnZQ0KPj4gICAgdmhvc3Q6IEZpeCBlcnJvcl9hcHBlbmRfaGludC9lcnJvcl9wcmVw
ZW5kIHVzYWdlDQo+PiAgICB2aXJ0aW86IEZpeCBlcnJvcl9hcHBlbmRfaGludC9lcnJvcl9wcmVw
ZW5kIHVzYWdlDQo+PiAgICB2aXJ0aW8tOXA6IEZpeCBlcnJvcl9hcHBlbmRfaGludC9lcnJvcl9w
cmVwZW5kIHVzYWdlDQo+PiAgICBYSVZFOiBGaXggZXJyb3JfYXBwZW5kX2hpbnQvZXJyb3JfcHJl
cGVuZCB1c2FnZQ0KPj4gICAgYmxvY2s6IEZpeCBlcnJvcl9hcHBlbmRfaGludC9lcnJvcl9wcmVw
ZW5kIHVzYWdlDQo+PiAgICBjaGFyZGV2OiBGaXggZXJyb3JfYXBwZW5kX2hpbnQvZXJyb3JfcHJl
cGVuZCB1c2FnZQ0KPj4gICAgY21kbGluZTogRml4IGVycm9yX2FwcGVuZF9oaW50L2Vycm9yX3By
ZXBlbmQgdXNhZ2UNCj4+ICAgIFFPTTogRml4IGVycm9yX2FwcGVuZF9oaW50L2Vycm9yX3ByZXBl
bmQgdXNhZ2UNCj4+ICAgIE1pZ3JhdGlvbjogRml4IGVycm9yX2FwcGVuZF9oaW50L2Vycm9yX3By
ZXBlbmQgdXNhZ2UNCj4+ICAgIFNvY2tldHM6IEZpeCBlcnJvcl9hcHBlbmRfaGludC9lcnJvcl9w
cmVwZW5kIHVzYWdlDQo+PiAgICBuYmQ6IEZpeCBlcnJvcl9hcHBlbmRfaGludC9lcnJvcl9wcmVw
ZW5kIHVzYWdlDQo+PiAgICBQVlJETUE6IEZpeCBlcnJvcl9hcHBlbmRfaGludC9lcnJvcl9wcmVw
ZW5kIHVzYWdlDQo+PiAgICBpdnNobWVtOiBGaXggZXJyb3JfYXBwZW5kX2hpbnQvZXJyb3JfcHJl
cGVuZCB1c2FnZQ0KPiANCj4gQXBwbHlpbmcgaXQuDQo+IA0KPiBDb3JyZWN0Pw0KPiANCg0KWWVz
DQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

