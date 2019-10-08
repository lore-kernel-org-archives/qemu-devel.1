Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF04AC4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 10:11:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8327020673
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 10:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Jefwruo3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8327020673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHmSh-00066j-JU
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 06:11:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41481)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iHmRd-0005Qj-T7
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 06:10:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iHmRc-0000s9-9i
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 06:10:17 -0400
Received: from mail-eopbgr50117.outbound.protection.outlook.com
 ([40.107.5.117]:41828 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iHmRK-0000P5-CF; Tue, 08 Oct 2019 06:10:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U8YZWfrfsKBueAUqqcJb228kYc7tyH1taFeeYrQfbuQcTO/skUQWIs9rGXAOQPLanyBcogELnVx7ue0O1N6HoX+ok9QmsZ64QOGu0jiW+HbmRDQbPq5I6WZP8nm8rS+YUQnMumTNymZWdBZEKPvS3ZQA66atq5CgxzOLEP6Irw1oNQt4ZzH6EUZG6sgsw7fF1HzfiLTmVRxAl+Z1FyPjYMNXykwcIlEn5GEmQiYNDcs8CRK+vC5T6uf26fuvSY5BtgBGdTnRWgnAGbucklgX+4uMdldpUROFw+P/S8mPNiREWhD7yNddwCEq5683Z5B9NfLtonIhwwIgQKCrFzTipg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ee4RY8hM0HmW0//mvHV+u6+4qApWo1X5pa+RRVRxVrI=;
 b=FolocUt+JfBXB3kHpjY36ZuQG7yB55hQMEL0OM5eadnCutj6c796ctjhyySCG2fJ6j9HCoF0xLmq8GisGyo4+TlOY26ym0vxxdjUgZBKUf59t/cDJ+A+mXYneRRwVqjOGLMebXvSWSqQMQvPzUneEaiHBtGUeKZ4/jfdPoPu85qeHXJieRsOYC6C0F4cQ2egKQOv10RCiK2AIzX/63DQmfyBlzsExshqSod/voSseKlyBVZSdk5IlUbDA49J3zJiSpi8iUCIJqKP53Ej8C7SQolkb+J6HIJZjvSNpYbMUkDtEVWTKutTNUp/s2N9PWPGKXwb+5peUP2DoWvDrXI1hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ee4RY8hM0HmW0//mvHV+u6+4qApWo1X5pa+RRVRxVrI=;
 b=Jefwruo3k7/o/1i4HjhdU9jcXx4oCM5WF2LHyBTnvBYpEvHKI/r1R3nittSFnwa2/F8RZSYusd3B1LS65Aow2WLhzieUNqexCaJvC4nq1OYe8FNE1E9KG5FBES0N6gQx1KYedoMfUkIz+697I9eB+ucwrsc3oXeQkC16LFCsAc8=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5275.eurprd08.prod.outlook.com (10.255.19.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Tue, 8 Oct 2019 10:09:42 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f%2]) with mapi id 15.20.2327.023; Tue, 8 Oct 2019
 10:09:42 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v4 00/31] error: auto propagated local_err
Thread-Topic: [PATCH v4 00/31] error: auto propagated local_err
Thread-Index: AQHVeHBjrP5HIXy9eUuF1AJePQl1JqdQY7bDgABF8QD//94LAIAACGiA
Date: Tue, 8 Oct 2019 10:09:42 +0000
Message-ID: <7567d46b-f51c-d459-fd54-7841637d0666@virtuozzo.com>
References: <20191001155319.8066-1-vsementsov@virtuozzo.com>
 <87eeznn185.fsf@dusky.pond.sub.org>
 <a449a64d-ca3c-2442-27b3-70b565545a36@virtuozzo.com>
 <20191008113932.18eb4c1d@bahia.lan>
In-Reply-To: <20191008113932.18eb4c1d@bahia.lan>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR08CA0057.eurprd08.prod.outlook.com
 (2603:10a6:7:2a::28) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191008130937344
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 18dd3972-0e91-4002-16a2-08d74bd7a2b0
x-ms-traffictypediagnostic: DB8PR08MB5275:
x-microsoft-antispam-prvs: <DB8PR08MB5275C787CBF9836922B0D861C19A0@DB8PR08MB5275.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 01842C458A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(366004)(396003)(136003)(376002)(39850400004)(189003)(199004)(53754006)(6246003)(446003)(8676002)(229853002)(71200400001)(36756003)(316002)(3846002)(31696002)(7416002)(7406005)(4326008)(256004)(71190400001)(5660300002)(6436002)(6512007)(6486002)(86362001)(2906002)(7736002)(8936002)(64756008)(26005)(66446008)(66476007)(66946007)(305945005)(99286004)(66556008)(25786009)(186003)(561944003)(66066001)(52116002)(2616005)(6116002)(76176011)(476003)(486006)(81166006)(478600001)(14454004)(31686004)(102836004)(386003)(81156014)(11346002)(54906003)(6506007)(6916009);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5275;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oZ59MKc4nx+Z8exg8z7sdh18ESvaAlYBgr9Qp/c7pB0UdZmfus7Q6eV5nPuGoDmNknmPEj5d/k65bDj4qQ55i0s661Lub1JEovDCiL8/IzirUiSf1FMXU62LJcZ9cpVVJebX+mnLRRP9pz1Rq6T/4phrE7CQJl0q04yPbzq92Tchneg89CirtARrr7nPLvnc7rY9kZJomxpIy27TTjaA4bK6NMfPDRE5x4OZz0fDfjOmwCYFetsJs68TFOULgfj/zY2t8SKPBKYRTNPBP9eupvRtcy3TqKCl5QD8lsBtsWlHqekLUWSYpiiEE4ySfe/0q/WLP8p+K89LTeE/2EDQE1zL2/1Zc091PmcygiVwMpWQTCwoKVXcj9ZvFgmGkG/asQuN11DyT4GwVtJNSj2/T686WpTfXM9eZhL/t2Vna5c=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <B3CCDDA9E6C44D4CB61112DBFC1947BF@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18dd3972-0e91-4002-16a2-08d74bd7a2b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2019 10:09:42.0569 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QMTk8OQ414bBaVH4EPeVmFSXpW+X6dozaFWxvqWsD873ZcQvE2GCF57Lm/AOjZH5pQYulnUyx2u35ivvqS3GGf1L37bh7Iae5w8CJLtPnWM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5275
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.117
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
 Markus Armbruster <armbru@redhat.com>, "kraxel@redhat.com" <kraxel@redhat.com>,
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
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "yuval.shaia@oracle.com" <yuval.shaia@oracle.com>,
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

MDguMTAuMjAxOSAxMjozOSwgR3JlZyBLdXJ6IHdyb3RlOg0KPiBPbiBUdWUsIDggT2N0IDIwMTkg
MDg6NDE6MDggKzAwMDANCj4gVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNv
dkB2aXJ0dW96em8uY29tPiB3cm90ZToNCj4gDQo+PiAwOC4xMC4yMDE5IDEwOjMwLCBNYXJrdXMg
QXJtYnJ1c3RlciB3cm90ZToNCj4+PiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2Vt
ZW50c292QHZpcnR1b3p6by5jb20+IHdyaXRlczoNCj4+Pg0KPj4+PiBIaSBhbGwhDQo+Pj4+DQo+
Pj4+IEhlcmUgaXMgYSBwcm9wb3NhbCBvZiBhdXRvIHByb3BhZ2F0aW9uIGZvciBsb2NhbF9lcnIs
IHRvIG5vdCBjYWxsDQo+Pj4+IGVycm9yX3Byb3BhZ2F0ZSBvbiBldmVyeSBleGl0IHBvaW50LCB3
aGVuIHdlIGRlYWwgd2l0aCBsb2NhbF9lcnIuDQo+Pj4+DQo+Pj4+IFRoZXJlIGFyZSBhbHNvIHR3
byBpc3N1ZXMgd2l0aCBlcnJwOg0KPj4+Pg0KPj4+PiAxLiBlcnJvcl9mYXRhbCAmIGVycm9yX2Fw
cGVuZF9oaW50L2Vycm9yX3ByZXBlbmQ6IHVzZXIgY2FuJ3Qgc2VlIHRoaXMNCj4+Pj4gYWRkaXRp
b25hbCBpbmZvLCBiZWNhdXNlIGV4aXQoKSBoYXBwZW5zIGluIGVycm9yX3NldGcgZWFybGllciB0
aGFuIGluZm8NCj4+Pj4gaXMgYWRkZWQuIFtSZXBvcnRlZCBieSBHcmVnIEt1cnpdDQo+Pj4NCj4+
PiBIb3cgaXMgdGhpcyBzZXJpZXMgcmVsYXRlZCB0byBHcmVnJ3MgIltQQVRDSCAwMC8xN10gRml4
IHVzYWdlIG9mDQo+Pj4gZXJyb3JfYXBwZW5kX2hpbnQoKSI/ICBEbyB3ZSBuZWVkIGJvdGg/DQo+
Pg0KPj4gVGhlc2Ugc2VyaWVzIGlzIGEgc3Vic3RpdHV0aW9uIGZvciBHcmVnJ3MuIFN0aWxsLCB0
aGVyZSBhcmUgcHJvYmxlbXMgd2l0aA0KPj4gYXV0b21hdGlvbiwgd2hpY2ggR3JlZyBwb2ludGVk
IGluIDIxLzMxLCBhbmQgSSBkb24ndCBrbm93IHdoYXQgdG8gZG8gbmV4dC4NCj4+DQo+PiBNYXkg
YmUsIGp1c3QgY29udGludWUgdG8gcmV2aWV3IHBhdGNoZXMgYW5kIGZpeCB0aGVtIGJ5IGhhbmQu
IE1heSBiZSB0cnkgdG8NCj4+IGltcHJvdmUgYXV0b21hdGlvbi4uLg0KPj4NCj4gDQo+IFRoZSBm
ZWVsaW5nIEkgaGF2ZSBhZnRlciB3b3JraW5nIG9uIG15IHNlcmllcyBpcyB0aGF0IHRoZSBsaW5l
cyB0aGF0IGRlYWwNCj4gd2l0aCBlcnJvcnMgYXJlIG1peGVkIHVwIHdpdGggdGhlIGZ1bmN0aW9u
YWwgY29kZSBpbiBhIHZhcmlldHkgb2Ygd2F5cy4NCj4gVGhhdCBtYWtlcyBpdCB2ZXJ5IGRpZmZp
Y3VsdCBpZiBub3QgaW1wb3NzaWJsZSB0byBjb21lIHdpdGggY29kZSBwYXR0ZXJucw0KPiBzdWl0
YWJsZSBmb3IgYSAxMDAlIGF1dG9tYXRlZCBzb2x1dGlvbiBJTUhPLg0KPiANCj4gTXkgcXVlc3Rp
b25pbmcgaXMgbW9yZSBhcm91bmQgdGhlIHNlbWFudGljcyBvZiBlcnJvcl9mYXRhbCBhY3R1YWxs
eS4gV2hhdA0KPiBkb2VzIHBhc3NpbmcgJmVycm9yX2ZhdGFsIGdpdmVzIHVzIG92ZXIgcGFzc2lu
ZyAmbG9jYWxfZXJyIGFuZCBjYWxsaW5nDQo+IGVycm9yX3JlcG9ydF9lcnIoKStleGl0KCksIGFw
YXJ0IGZyb20gYnJlYWtpbmcgZXJyb3JfYXBwZW5kX2hpbnQoKSBhbmQNCj4gZXJyb3JfcHJlcGVu
ZCgpID8NCg0KQXMgSSB1bmRlcnN0YW5kLCB0aGUgb25seSBiZW5lZml0IGlzIG9uZSBsaW5lIGlu
c3RlYWQgb2YgZm91cjoNCg0KZnVuYyguLi4sICZlcnJvcl9mYXRhbCk7DQoNCmluc3RlYWQgb2YN
Cg0KZnVuYyguLi4sICZsb2NhbF9lcnIpOw0KaWYgKGxvY2FsX2Vycikgew0KICAgICBleGl0KDEp
Ow0KfQ0KDQpCdXQsIGtlZXBpbmcgaW4gbWluZCBhbGwgZGlmZmljdWx0aWVzIGFib3V0IHRoZXNl
IHNlcmllcy4uLiBXZSBjYW4gY29uc2lkZXINCmNvbnZlcnNpb24gZXJyb3JfZmF0YWwgLT4gbG9j
YWxfZXJyIHRvby4gSXQgc2VlbXMgc2ltcGxlIHRvIGRvIHdpdGggYSBjb2NjaW5lbGxlDQpzY3Jp
cHQsIEkgY2FuIHNlbmQgYW5vdGhlciBhdXRvbWF0aWMgc2VyaWVzIHRvIGxvb2sgYXQgaXQuDQoN
Cg0KSG1tLCBzb21lIGlkZWFzIGFyb3VuZCB0aGlzOg0KDQoxLiBXZSBjYW4gZ2VuZXJhdGUgX2Zh
dGFsIHZlcnNpb25zIG9mIGZ1bmN0aW9ucyBieSBweXRob24gc2NyaXB0ICh3ZSdsbCBjYWxsIGl0
IGZyb20gTWFrZWZpbGUsIHdlIGhhdmUgYSBsb3Qgb2YgZ2VuZXJhdGVkIGNvZGUgYW55d2F5KS4N
Cg0KYW5kIGNvbnZlcnQNCmZ1bmMoLi4uLCAmbG9jYWxfZXJyKTsgdG8NCg0KZnVuY19mYXRhbCgu
Li4pOw0KDQoyLiBVc2UgbWFjcm8gbGlrZQ0KDQojZGVmaW5lIEZBVEFMKGZ1bmMsIC4uLikgZG8g
eyBFcnJvciAqX19mYXRhbF9lcnIgPSBOVUxMOyBmdW5jKF9fVkFfQVJHU19fIF9fVkFfT1BUKCwp
LCAmX19mYXRhbF9lcnIpOyBpZiAoX19mYXRhbF9lcnIpIHsgZXJyb3JfcmVwb3J0KF9fZmF0YWxf
ZXJyKTsgZXhpdCgxKTsgfSB9IHdoaWxlICgwKQ0KDQphbmQgY29udmVydA0KZnVuYyguLi4sICZs
b2NhbF9lcnIpOyB0bw0KDQpGQVRBTChmdW5jLCAuLi4pOw0KDQo+IA0KPj4+DQo+Pj4+IDIuIGVy
cm9yX2Fib3J0ICYgZXJyb3JfcHJvcGFnYXRlOiB3aGVuIHdlIHdyYXANCj4+Pj4gZXJyb3JfYWJv
cnQgYnkgbG9jYWxfZXJyK2Vycm9yX3Byb3BhZ2F0ZSwgcmVzdWx0aW5nIGNvcmVkdW1wIHdpbGwN
Cj4+Pj4gcmVmZXIgdG8gZXJyb3JfcHJvcGFnYXRlIGFuZCBub3QgdG8gdGhlIHBsYWNlIHdoZXJl
IGVycm9yIGhhcHBlbmVkLg0KPj4+PiAodGhlIG1hY3JvIGl0c2VsZiBkb24ndCBmaXggdGhlIGlz
c3VlLCBidXQgaXQgYWxsb3dzIHRvIFszLl0gZHJvcCBhbGwNCj4+Pj4gbG9jYWxfZXJyK2Vycm9y
X3Byb3BhZ2F0ZSBwYXR0ZXJuLCB3aGljaCB3aWxsIGRlZmluaXRlbHkgZml4IHRoZSBpc3N1ZSkN
Cj4+Pj4gW1JlcG9ydGVkIGJ5IEtldmluIFdvbGZdDQo+Pj4+DQo+Pj4+IFN0aWxsLCBhcHBseWlu
ZyBuZXcgbWFjcm8gdG8gYWxsIGVycnAtZnVuY3Rpb25zIGlzIGEgaHVnZSB0YXNrLCB3aGljaCBp
cw0KPj4+PiBpbXBvc3NpYmxlIHRvIHNvbHZlIGluIG9uZSBzZXJpZXMuDQo+Pj4+DQo+Pj4+IFNv
LCBoZXJlIGlzIGEgbWluaW11bTogc29sdmUgb25seSBbMS5dLCBieSBhZGRpbmcgbmV3IG1hY3Jv
IHRvIGFsbA0KPj4+PiBlcnJwLWZ1bmN0aW9ucyB3aGljaCB3YW50cyB0byBjYWxsIGVycm9yX2Fw
cGVuZF9oaW50Lg0KPj4+Pg0KPj4+PiB2NDsNCj4+Pj4gMDI6IC0gY2hlY2sgZXJycCB0byBiZSBu
b3QgTlVMTA0KPj4+PiAgICAgICAtIGRyb3AgRXJpYydzIHItYg0KPj4+PiAwMzogYWRkIEVyaWMn
cyByLWINCj4+Pj4gMDQ6IC0gcmVuYW1lIG1hY3JvIHRvIEVSUlBfQVVUT19QUk9QQUdBVEUgW0tl
dmluXQ0KPj4+PiAgICAgICAtIGltcHJvdmUgY29tbWVudCBhbmQgY29tbWl0IG1zZywgbWVudGlv
bg0KPj4+PiAgICAgICAgIGVycm9yX3ByZXBlbmQNCj4+Pj4gMDU6IC0gaGFuZGxlIGVycm9yX3By
ZXBlbmQgdG9vDQo+Pj4+ICAgICAgIC0gdXNlIG5ldyBtYWNybyBuYW1lDQo+Pj4+ICAgICAgIC0g
ZHJvcCBlbXB0eSBsaW5lIGF0IHRoZSBlbmQNCj4+Pj4NCj4+Pj4gY29tbWl0IG1lc3NhZ2UgZm9y
IGF1dG8tZ2VuZXJhdGVkIGNvbW1pdHMgdXBkYXRlZCwNCj4+Pj4gY29tbWl0cyByZWdlbmVyYXRl
ZC4NCj4+Pj4NCj4+Pj4gSSdsbCB1c2UgY2MtY21kIHRvIGNjIGFwcHJvcHJpYXRlIHJlY2lwaWVu
dHMgcGVyIHBhdGNoLCBzdGlsbA0KPj4+PiBjb3Zlci1sZXR0ZXIgdG9nZXRoZXIgd2l0aCAwNC0w
NiBwYXRjaGVzIHNob3VsZCBiZSBpbnRlcmVzdGluZyBmb3INCj4+Pj4gYWxsOg0KPj4+IFsuLi5d
DQo+Pj4NCj4+PiBCaWcgc2VyaWVzOyBsZXQgbWUgZ3Vlc3MgaXRzIHN0cnVjdHVyZS4NCj4+Pg0K
Pj4+PiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5ICgzMSk6DQo+Pj4+ICAgICBlcnJwOiBy
ZW5hbWUgZXJycCB0byBlcnJwX2luIHdoZXJlIGl0IGlzIElOLWFyZ3VtZW50DQo+Pj4+ICAgICBo
dy9jb3JlL2xvYWRlci1maXQ6IGZpeCBmcmVlaW5nIGVycnAgaW4gZml0X2xvYWRfZmR0DQo+Pj4+
ICAgICBuZXQvbmV0OiBmaXggbG9jYWwgdmFyaWFibGUgc2hhZG93aW5nIGluIG5ldF9jbGllbnRf
aW5pdA0KPj4+DQo+Pj4gUHJlcGFyYXRpb25zLg0KPj4+DQo+Pj4+ICAgICBlcnJvcjogYXV0byBw
cm9wYWdhdGVkIGxvY2FsX2Vycg0KPj4+DQo+Pj4gVGhlIG5ldyBpZGVhLg0KPj4+DQo+Pj4+ICAg
ICBzY3JpcHRzOiBhZGQgc2NyaXB0IHRvIGZpeCBlcnJvcl9hcHBlbmRfaGludC9lcnJvcl9wcmVw
ZW5kIHVzYWdlDQo+Pj4+ICAgICBweXRob246IGFkZCBjb21taXQtcGVyLXN1YnN5c3RlbS5weQ0K
Pj4+DQo+Pj4gU2NyaXB0cyB0byBoZWxwIHlvdSBhcHBseSBpdC4NCj4+Pg0KPj4+PiAgICAgczM5
MDogRml4IGVycm9yX2FwcGVuZF9oaW50L2Vycm9yX3ByZXBlbmQgdXNhZ2UNCj4+Pj4gICAgIEFS
TSBUQ0cgQ1BVczogRml4IGVycm9yX2FwcGVuZF9oaW50L2Vycm9yX3ByZXBlbmQgdXNhZ2UNCj4+
Pj4gICAgIFBvd2VyUEMgVENHIENQVXM6IEZpeCBlcnJvcl9hcHBlbmRfaGludC9lcnJvcl9wcmVw
ZW5kIHVzYWdlDQo+Pj4+ICAgICBhcm06IEZpeCBlcnJvcl9hcHBlbmRfaGludC9lcnJvcl9wcmVw
ZW5kIHVzYWdlDQo+Pj4+ICAgICBTbWFydEZ1c2lvbjI6IEZpeCBlcnJvcl9hcHBlbmRfaGludC9l
cnJvcl9wcmVwZW5kIHVzYWdlDQo+Pj4+ICAgICBBU1BFRUQgQk1DczogRml4IGVycm9yX2FwcGVu
ZF9oaW50L2Vycm9yX3ByZXBlbmQgdXNhZ2UNCj4+Pj4gICAgIEJvc3RvbjogRml4IGVycm9yX2Fw
cGVuZF9oaW50L2Vycm9yX3ByZXBlbmQgdXNhZ2UNCj4+Pj4gICAgIFBvd2VyTlYgKE5vbi1WaXJ0
dWFsaXplZCk6IEZpeCBlcnJvcl9hcHBlbmRfaGludC9lcnJvcl9wcmVwZW5kIHVzYWdlDQo+Pj4+
ICAgICBQQ0k6IEZpeCBlcnJvcl9hcHBlbmRfaGludC9lcnJvcl9wcmVwZW5kIHVzYWdlDQo+Pj4+
ICAgICBTQ1NJOiBGaXggZXJyb3JfYXBwZW5kX2hpbnQvZXJyb3JfcHJlcGVuZCB1c2FnZQ0KPj4+
PiAgICAgVVNCOiBGaXggZXJyb3JfYXBwZW5kX2hpbnQvZXJyb3JfcHJlcGVuZCB1c2FnZQ0KPj4+
PiAgICAgVkZJTzogRml4IGVycm9yX2FwcGVuZF9oaW50L2Vycm9yX3ByZXBlbmQgdXNhZ2UNCj4+
Pj4gICAgIHZob3N0OiBGaXggZXJyb3JfYXBwZW5kX2hpbnQvZXJyb3JfcHJlcGVuZCB1c2FnZQ0K
Pj4+PiAgICAgdmlydGlvOiBGaXggZXJyb3JfYXBwZW5kX2hpbnQvZXJyb3JfcHJlcGVuZCB1c2Fn
ZQ0KPj4+PiAgICAgdmlydGlvLTlwOiBGaXggZXJyb3JfYXBwZW5kX2hpbnQvZXJyb3JfcHJlcGVu
ZCB1c2FnZQ0KPj4+PiAgICAgWElWRTogRml4IGVycm9yX2FwcGVuZF9oaW50L2Vycm9yX3ByZXBl
bmQgdXNhZ2UNCj4+Pj4gICAgIGJsb2NrOiBGaXggZXJyb3JfYXBwZW5kX2hpbnQvZXJyb3JfcHJl
cGVuZCB1c2FnZQ0KPj4+PiAgICAgY2hhcmRldjogRml4IGVycm9yX2FwcGVuZF9oaW50L2Vycm9y
X3ByZXBlbmQgdXNhZ2UNCj4+Pj4gICAgIGNtZGxpbmU6IEZpeCBlcnJvcl9hcHBlbmRfaGludC9l
cnJvcl9wcmVwZW5kIHVzYWdlDQo+Pj4+ICAgICBRT006IEZpeCBlcnJvcl9hcHBlbmRfaGludC9l
cnJvcl9wcmVwZW5kIHVzYWdlDQo+Pj4+ICAgICBNaWdyYXRpb246IEZpeCBlcnJvcl9hcHBlbmRf
aGludC9lcnJvcl9wcmVwZW5kIHVzYWdlDQo+Pj4+ICAgICBTb2NrZXRzOiBGaXggZXJyb3JfYXBw
ZW5kX2hpbnQvZXJyb3JfcHJlcGVuZCB1c2FnZQ0KPj4+PiAgICAgbmJkOiBGaXggZXJyb3JfYXBw
ZW5kX2hpbnQvZXJyb3JfcHJlcGVuZCB1c2FnZQ0KPj4+PiAgICAgUFZSRE1BOiBGaXggZXJyb3Jf
YXBwZW5kX2hpbnQvZXJyb3JfcHJlcGVuZCB1c2FnZQ0KPj4+PiAgICAgaXZzaG1lbTogRml4IGVy
cm9yX2FwcGVuZF9oaW50L2Vycm9yX3ByZXBlbmQgdXNhZ2UNCj4+Pg0KPj4+IEFwcGx5aW5nIGl0
Lg0KPj4+DQo+Pj4gQ29ycmVjdD8NCj4+Pg0KPj4NCj4+IFllcw0KPj4NCj4+DQo+IA0KDQoNCi0t
IA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

