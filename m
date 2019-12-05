Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA23EC43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 16:07:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A71D5206DB
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 16:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="pXheX11q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A71D5206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ictfK-0002Pk-Vk
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 11:07:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50638)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ictc3-0008Ks-17
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 11:04:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ictc1-0005as-So
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 11:04:18 -0500
Received: from mail-vi1eur04on0709.outbound.protection.outlook.com
 ([2a01:111:f400:fe0e::709]:36582
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1ictbc-0003n3-Mk; Thu, 05 Dec 2019 11:03:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C9ABXgGxBOwOgsIPC8NfebRF6Y46ZZ+ct2n8/1NfYyFeVUyBRz2om3IiWLPf4ubTeqD7B4Op6sfS7cC9BIpFPk32+HDRDl4dgT5q5kGT66hOOHm4Xeev8AJDZRelAg1BnAXOkxmkLwsNiLLU3qe0mdQh/ZVG1w/cT8i3Jwo8z+btXyx2msU/ODW2c1a1cvuASuRtaTJ8lLTKUWGqwU4kmfHrGx2MWzC/MWm8uGbIHsVEul7OU9U2suiqehH7smeAYuyPmPTryAKNqRr9jNaP9OY1ZX+iXSG6Hilw1Wnp+WFPxkDai8/Fp2CK30/Tbql88JRkSARTxfFtHBzRaUcZ/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PTT7PxMm/NguqHg95cSTasuOdhk01vXlyocXabikdbQ=;
 b=Nukff+X1NJKgIu29sNgi4zwIclyWq9MeSruHMRhAVMU6xg/Kf0yk4vwQoRFB+utvIwl8u4v93FGfOmoQ3O/7Zv6FsqzKYQp0O2NCcF1iwy/ZA1SGhJKptOzZ8g/2sP6Fum2jK7MWexawnmyvnbWxGfeyEY1lYZ9bZCcYNCpkYCVSPlVtkZyc26lqXUbMqgxw99qs681nkQq0q8YFMnm23DsLSDD5+vv4TCw4/oNXLl5JFqmk/f/IuzklfEUOFt+TXxJNAQILaO8Hy6Kj56yUecJ1D+PWEzdHa4x8bKq47b45B+BPIFmYHJq0Yme3PDNPV67CO6vGCsHPe5XHK/8v4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PTT7PxMm/NguqHg95cSTasuOdhk01vXlyocXabikdbQ=;
 b=pXheX11qt2AKy03L1hR00RYf89vbmGHGoDAvOfte6Sx0Be2xKCm5b1F0pdl7sgEQapvGhxZ0tw1LnR2MQMp2plttT3Ealas56biP4Bs/5lQ3ZO3oXVe/YKzNBti72s+L2zV8D/bSaeImWnICmffoekj0vp1/az9looVlqEMmKvc=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4598.eurprd08.prod.outlook.com (20.178.88.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Thu, 5 Dec 2019 16:03:49 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2516.014; Thu, 5 Dec 2019
 16:03:49 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v7 00/21] error: prepare for auto propagated local_err
Thread-Topic: [PATCH v7 00/21] error: prepare for auto propagated local_err
Thread-Index: AQHVq3+Vo0pNx47wCkKZyJv5qiTU2qerqbmAgAAKbIA=
Date: Thu, 5 Dec 2019 16:03:49 +0000
Message-ID: <204304ad-3556-9964-0164-0477a97cd4d2@virtuozzo.com>
References: <20191205152019.8454-1-vsementsov@virtuozzo.com>
 <20191205162627.70ffe45c.cohuck@redhat.com>
In-Reply-To: <20191205162627.70ffe45c.cohuck@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0402CA0054.eurprd04.prod.outlook.com
 (2603:10a6:7:7c::43) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191205190345932
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 74db2669-5b03-490e-cf04-08d7799cb725
x-ms-traffictypediagnostic: AM6PR08MB4598:
x-microsoft-antispam-prvs: <AM6PR08MB4598DED1E42C2C27045B9745C15C0@AM6PR08MB4598.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 02426D11FE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(136003)(376002)(396003)(366004)(346002)(199004)(189003)(53754006)(11346002)(2616005)(86362001)(25786009)(305945005)(6512007)(6916009)(6506007)(186003)(66556008)(31696002)(66476007)(5660300002)(4744005)(66946007)(64756008)(66446008)(26005)(8936002)(478600001)(81166006)(81156014)(8676002)(6486002)(71190400001)(2906002)(36756003)(71200400001)(7416002)(4326008)(7406005)(102836004)(229853002)(14454004)(76176011)(316002)(31686004)(54906003)(52116002)(99286004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4598;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xbVVZ5gbxB3E1H/cmX+6Mwe5+qMlbXegSwbL8s7B8vW3I5kGVTA8UyjX1EKCJ0PYUqECvOBAveHbWNky9dHiHAjym0c+mopDeCOW525IfUqo39BhFBvULFjcPTD4oyVrk3b8LcApHvr4s0sQ/TKM2E6pmuf66vthJRdhCK2phLIxkNab+M4V5Z5U/ZTiy+eoY0JJsQKQ0WBFSpUUTcy1FY7FUN19wePWdKrd0oVyZjFlUmUChLxXBF6tE7AUuQybc1LTQ3ma8wEM/nw5E2F3oq8aSUY2sD19IO391LFq9FgA+BnVmoW6r3gKgdsUlpCEjGa/WYuz68GD10uelD6H2HgFzGVTJwVUTuXRTGefMcaIUrdOnS+dHZsQNp0EPz2YYw98PskoegAkVWrT8Zp4H0AloXLcXlIcvgt9+CAKIJhCdo6DpgHqE2zXtfMGOZzmGzRtyvZEVaMWjtU4qwQtWGpgtBYbKK6hI9/s6VNzeSuYgi1/U1WDQ7j1UkVbFm6x
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <39872A20775BAA4DBA5BD0E783BA3483@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74db2669-5b03-490e-cf04-08d7799cb725
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2019 16:03:49.1961 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BumUI2UX8hrie0yqslafibII41AsqfD9PQguGN2FrIga9pN2zslTKH06JdH+Aebpk8dvgE74rxuTh+QkXRex2wJo+8RWYdpk/lq4bIYmeTY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4598
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe0e::709
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
Cc: Paul Burton <pburton@wavecomp.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 David Hildenbrand <david@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Greg Kurz <groug@kaod.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>,
 =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>,
 Pierre Morel <pmorel@linux.ibm.com>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDUuMTIuMjAxOSAxODoyNiwgQ29ybmVsaWEgSHVjayB3cm90ZToNCj4gT24gVGh1LCAgNSBEZWMg
MjAxOSAxODoxOTo1OCArMDMwMA0KPiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2Vt
ZW50c292QHZpcnR1b3p6by5jb20+IHdyb3RlOg0KPiANCj4+IEhpIGFsbCENCj4+DQo+PiBUaGlz
IGlzIHRoZSBmaXJzdCBwYXJ0IG9mIHRoZSBiaXQgc2VyaWVzLCB3aGljaCBjb250YWlucyBtb3N0
bHkgc2ltcGxlDQo+PiBjbGVhbnVwcy4NCj4gDQo+IFdoYXQncyB0aGUgcGxhbj8gU2hvdWxkIHN1
YnN5c3RlbSBtYWludGFpbmVycyBwaWNrIHVwIGluZGl2aWR1YWwNCj4gcGF0Y2hlcywgb3Igd2ls
bCB0aGV5IGJlIG1lcmdlZCBpbiBvbmUgZ28/DQo+IA0KVGhlIGxhdHRlci4gTWFya3VzIHdpbGwg
dGFrZSB0aGVtIGFsbCB0b2dldGhlci4NCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

