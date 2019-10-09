Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B796FC47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 17:03:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 814D320B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 17:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="qID52BkG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 814D320B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIFNL-0005So-4M
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 13:03:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44984)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iI7AT-0005sI-59
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 04:17:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iI7AR-0001jZ-TM
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 04:17:57 -0400
Received: from mail-eopbgr10107.outbound.protection.outlook.com
 ([40.107.1.107]:18368 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iI7AL-0001hw-Cz; Wed, 09 Oct 2019 04:17:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lrC0sjYMOJS4amcj57+wVYH8i255pI75rBjSFqBMuJbfmI0+p1UWy+TtW4pbUpU295snl6XkthL8946IrkGvfxfMTvyYU/akI0DJFGCXDDEFxd37myLYxZnmcXxAFtit+L7tAp08ZteyI5jne4z8yPHwYZh01e7bWMFz7iMhmFCEN1vsGLqr4xBBum55eCa5XFvIxFuDX15ioc+NMBpES5s/4vbWyaRFMpz5SEqC3kDdGDuGuolTLoAZqhcCm/9Q9sb0i+qyuPSHlxiVS1iyIQMFoXFYwq712EbM2MsrRX8kGMGjsSkL4lbsQ0WVoSTdBqzNhBSKwPQwqTXz1O6w/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBWq+UoL7zI4QWco+24CD9k6d72HLnL2e84PUG7PDBY=;
 b=Oz7QH+y9QX0xV0m4dY9BYLBswVxpDHp1i0yTUw+nXRMl+Ph9YiEMqcAnuN49TXZARLSYbJzi12B1DJRui4saXZjGbiK8vqHAe3aNOsbazEwbZ4TiimfZnHkGNW1SYOL1iaP6flaWawtw6O66zbCt95Eiq+Bwda2HkEic5YxJjKvNuZ6b2pVz3hOtq1I0HXyg0WS+5NiAirT+ICV1lA3BnYTyJ1xbjxTaZFKkJfgpn9ktfGBcdi8fGbUvG8mHdQJlVbLQWbH3dZu8trd9iUeyQU3VUeNfAlpspxRl7QDouAxWpwXWb3mOyBNesbHfurT4OfLousqSWL7qmzZ8bfc01A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBWq+UoL7zI4QWco+24CD9k6d72HLnL2e84PUG7PDBY=;
 b=qID52BkGAn1+/yGuaI65loNPU+IVGKzVxgkE0CpN6XTgbNc1zHyLVZrKlnlAubgHgiVQX0McO/vRs0vsoXusE2MnLOQd+YsjA7kv1wKzok+C7bKia0H7FFvKDj7fPh4f9MhSauF3zJ2wkVYoQAHn/yNC2AGUbeHWvqztjPO0cig=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4059.eurprd08.prod.outlook.com (20.179.10.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Wed, 9 Oct 2019 08:17:45 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f%2]) with mapi id 15.20.2327.026; Wed, 9 Oct 2019
 08:17:45 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v4 04/31] error: auto propagated local_err
Thread-Topic: [PATCH v4 04/31] error: auto propagated local_err
Thread-Index: AQHVeHBkmvcT9nkNqUiG56jY6f3L6qdR/5BDgAADlwA=
Date: Wed, 9 Oct 2019 08:17:44 +0000
Message-ID: <b330f111-4e71-c3a6-4484-22dd25906b55@virtuozzo.com>
References: <20191001155319.8066-1-vsementsov@virtuozzo.com>
 <20191001155319.8066-5-vsementsov@virtuozzo.com>
 <87r23m8hvb.fsf@dusky.pond.sub.org>
In-Reply-To: <87r23m8hvb.fsf@dusky.pond.sub.org>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0342.eurprd05.prod.outlook.com
 (2603:10a6:7:92::37) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191009111739975
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 602fcbc2-1453-4783-bc18-08d74c91296d
x-ms-traffictypediagnostic: DB8PR08MB4059:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB8PR08MB4059EC8348CDFE711C320951C1950@DB8PR08MB4059.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 018577E36E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(366004)(376002)(136003)(396003)(39840400004)(199004)(189003)(6246003)(36756003)(446003)(7736002)(25786009)(486006)(4326008)(229853002)(81156014)(8676002)(8936002)(81166006)(11346002)(31696002)(86362001)(2616005)(476003)(6486002)(6306002)(6512007)(305945005)(6436002)(7416002)(7406005)(478600001)(64756008)(66556008)(66476007)(66446008)(66946007)(14454004)(5660300002)(66066001)(6916009)(2906002)(966005)(186003)(14444005)(256004)(316002)(26005)(99286004)(52116002)(76176011)(3846002)(6116002)(102836004)(386003)(6506007)(71190400001)(54906003)(71200400001)(31686004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4059;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DYPV/Os7Y7Qcj2xdZNXWXe8YHIm8UTkZgvAhrbrdFki3U8tasVI4VdLkVwAo1LZPDcKzAkB811ouveHjJoN/DqDUtuC26OJHroUXp1P2Ul/it4uP1wdQZZ+SybsYDmhd9saUs0Qm1/jgcXAn3xR3S2sKtO3f7EqBmh54xCEAMdsJSEKsz6RmXVYD8uwze8Nfvk+5HtxnbydWOVzNA3V9hoBKmpptTVDAVGvDQ4HhQFX8uRw5NpJp6bTVLo/dTw7rmjsar1Iw76v5gfJDJLhzH9iIRtgkzSPAHf/iuqmIfXE7HLw15rHSSOjA6CtZFQ/m1xX0OiRPlrP57eT4XcCwd/ME6GWTtNK88Js88KO8L3Qji+Lctnv94GNxtl+dXJcalBrQK0o2pC60bhJm8hyzx+HmjI0sdrEI6PTpbihlQACRKrkfzkX5CD8si/CaK8vEY5uJqLzw7fzJqw3h0+3diA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <1F04203EDEC94040874701CC5D5D5B8F@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 602fcbc2-1453-4783-bc18-08d74c91296d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2019 08:17:44.9414 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eYoGkYJf5xZ2e34FvjS0JF4dHE0tfE0IDV2mvO4BZ+WaEuDOeiV+V8Ztq0QKOQ7emHQzvOAOs2XEN0s3s04hofknEypDZMXELAanR2ghHkQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4059
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.107
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

MDkuMTAuMjAxOSAxMTowNCwgTWFya3VzIEFybWJydXN0ZXIgd3JvdGU6DQo+IFZsYWRpbWlyIFNl
bWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4gd3JpdGVzOg0KPiAN
Cj4+IEhlcmUgaXMgaW50cm9kdWNlZCBFUlJQX0FVVE9fUFJPUEFHQVRFIG1hY3JvLCB0byBiZSB1
c2VkIGF0IHN0YXJ0IG9mDQo+PiBmdW5jdGlvbnMgd2l0aCBlcnJwIE9VVCBwYXJhbWV0ZXIuDQo+
Pg0KPj4gSXQgaGFzIHRocmVlIGdvYWxzOg0KPj4NCj4+IDEuIEZpeCBpc3N1ZSB3aXRoIGVycm9y
X2ZhdGFsICYgZXJyb3JfcHJlcGVuZC9lcnJvcl9hcHBlbmRfaGludDogdXNlcg0KPj4gY2FuJ3Qg
c2VlIHRoaXMgYWRkaXRpb25hbCBpbmZvcm1hdGlvbiwgYmVjYXVzZSBleGl0KCkgaGFwcGVucyBp
bg0KPj4gZXJyb3Jfc2V0ZyBlYXJsaWVyIHRoYW4gaW5mb3JtYXRpb24gaXMgYWRkZWQuIFtSZXBv
cnRlZCBieSBHcmVnIEt1cnpdDQo+IA0KPiBEb25lIGluIFBBVENIIDA3LTMxLg0KPiANCj4+IDIu
IEZpeCBpc3N1ZSB3aXRoIGVycm9yX2Fib3J0ICYgZXJyb3JfcHJvcGFnYXRlOiB3aGVuIHdlIHdy
YXANCj4+IGVycm9yX2Fib3J0IGJ5IGxvY2FsX2VycitlcnJvcl9wcm9wYWdhdGUsIHJlc3VsdGlu
ZyBjb3JlZHVtcCB3aWxsDQo+PiByZWZlciB0byBlcnJvcl9wcm9wYWdhdGUgYW5kIG5vdCB0byB0
aGUgcGxhY2Ugd2hlcmUgZXJyb3IgaGFwcGVuZWQuDQo+PiAodGhlIG1hY3JvIGl0c2VsZiBkb2Vz
bid0IGZpeCB0aGUgaXNzdWUsIGJ1dCBpdCBhbGxvd3MgdG8gWzMuXSBkcm9wIGFsbA0KPj4gbG9j
YWxfZXJyK2Vycm9yX3Byb3BhZ2F0ZSBwYXR0ZXJuLCB3aGljaCB3aWxsIGRlZmluaXRlbHkgZml4
IHRoZSBpc3N1ZSkNCj4+IFtSZXBvcnRlZCBieSBLZXZpbiBXb2xmXQ0KPj4NCj4+IDMuIERyb3Ag
bG9jYWxfZXJyK2Vycm9yX3Byb3BhZ2F0ZSBwYXR0ZXJuLCB3aGljaCBpcyB1c2VkIHRvIHdvcmth
cm91bmQNCj4+IHZvaWQgZnVuY3Rpb25zIHdpdGggZXJycCBwYXJhbWV0ZXIsIHdoZW4gY2FsbGVy
IHdhbnRzIHRvIGtub3cgcmVzdWx0aW5nDQo+PiBzdGF0dXMuIChOb3RlOiBhY3R1YWxseSB0aGVz
ZSBmdW5jdGlvbnMgY291bGQgYmUgbWVyZWx5IHVwZGF0ZWQgdG8NCj4+IHJldHVybiBpbnQgZXJy
b3IgY29kZSkuDQo+IA0KPiBOb3QgZG9uZS4gIENhbiB5b3UgcHJvdG90eXBlIHRoaXMgcGFydD8g
IEEgZmV3IG1hbnVhbGx5IGRvbmUgZXhhbXBsZXMNCj4gd291bGQgZ2l2ZSB1cyBhbiBpZGVhIGhv
dyB0aGUgY29tcGxldGUgc29sdXRpb24gd291bGQgbG9vayBsaWtlLiAgQQ0KPiAoc2VtaS0pYXV0
b21hdGVkIGNvbXBsZXRlIGNvbnZlcnNpb24gb2YgYSBzdWJzeXN0ZW0gd291bGQgYWRkaXRpb25h
bGx5DQo+IGdpdmUgdXMgYW4gaWRlYSBob3cgdG8gYWN0dWFsbHkgZG8gdGhlIGNvbnZlcnNpb24u
DQo+IA0KPiBXZSBjYW4gZGlzY3VzcyBhcHBseWluZyBFUlJQX0FVVE9fUFJPUEFHQVRFKCkgYXMg
YSBidWcgZml4IGZvciAxLiwgYW5kDQo+IGxlYXZlIDIuIGFuZCAzLiBmb3IgbGF0ZXIuICBGZWVs
cyBsaWtlIGEgaGFsZi1kb25lIGpvYiB0byBtZS4gIFdlJ3ZlIGdvdA0KPiB0b28gbWFueSBvZiB0
aG9zZSBpbiB0aGUgdHJlZSBhbHJlYWR5LiAgRHVubm8uDQo+IA0KDQpJZiB1cGRhdGUgZXZlcnl0
aGluZyBpdCdzIGFib3V0IDkwLTE0MCBwYXRjaGVzLg0KDQpUaGUgd2hvbGUgdGhpbmcgd2FzIGRv
bmUgaW4gIltSRkMgdjIgMC85XSBlcnJvcjogYXV0byBwcm9wYWdhdGVkIGxvY2FsX2VyciINCjwy
MDE5MDkyMzE2MTIzMS4yMjAyOC0xLXZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCmh0dHBzOi8v
bGlzdHMuZ251Lm9yZy9hcmNoaXZlL2h0bWwvcWVtdS1kZXZlbC8yMDE5LTA5L21zZzA1MTU3Lmh0
bWwNCg0KLSBpdCB3YXMgc28gaHVnZSwgdGhhdCBJIGRlY2lkZWQgdG8gcG9zdHBvbmUgMiBhbmQg
My4uLg0KDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

