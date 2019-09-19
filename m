Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A780C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 10:25:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FDA02196E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 10:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="XYzawFGb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FDA02196E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAtdE-0007b0-M0
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 06:25:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51818)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iAtZZ-00038O-96
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 06:22:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iAtZX-0007Tn-TV
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 06:22:01 -0400
Received: from mail-eopbgr30092.outbound.protection.outlook.com
 ([40.107.3.92]:56919 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iAtZL-0007JO-QL; Thu, 19 Sep 2019 06:21:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CM8sotmMkfvK55GU5U1LWAY1X3vE9Rr/9dnrUQD2/RzxWdcC+1xW82YZg2espHQB+lmB7I2n6RFN7DQNabrGA48JPn/lgALRG5E8UXN1QSPTipBZKAgHkLTzz0aBwXjO4x+gP8xENbfRcFTxnRCtoOvtkhDWrg6ETWEJnqtl6VpXoXh6K3WdcyuEDnxymMMLlHC/RwYawb6pGQMOn5WMkZJ4pf3fflrbvsOXAQ/Pqxb3SCi5IYPwc+xVYqSTsDxgrhswQTIjUoAZ5JNo+FnIelZSMtFbQQBeJrmC6GATqDrSOl21RzNe7QS87226bKEZvnBtbWntiqfJ+rOQrR8sKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FLBsrEiHWQIu4Sp2nDNmYaMU1I0+3kNbLtCFEQ59rBw=;
 b=cI9h9nLqmPgkqpirDtmcYjM9VYg5evsWwOpxy8gBA28d+4EaXfMimBnjsfWAV6HjcSakfsRZ2X6uByREJaDYqITWfWoHKoAA6dvVFiW6+fZWMH667wOKB9Wg35fXU/dEEAwa+WZdw2SoCNtWAyysleX7mEZSpJZhz3Du/CPE6cS2Ya00XQScGX1FkEg7sf5EE4RecJaP7yW1JeINOg63xM/QsD2Ndt2nIoFAGjrvG3pXlKksZTAcTeJzYe1d4u52KuT8srS7i+b2aGe1SX3W6kZPth20W5jf3SCne/RanFCD2o39LUb1RwWAGH2rAPtfRk0iZ+tuuofApWtIVwdr0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FLBsrEiHWQIu4Sp2nDNmYaMU1I0+3kNbLtCFEQ59rBw=;
 b=XYzawFGbr4somd/J4/dsojejIPVHgcSLc/DaEC/R7T49Fx+c1feRAyoqpVAMRxwfA0JYefMU/rUP3IRiPLe9YAln6XR1r3PtvnMaAb8ESTf458nqwBCd8qVJOE17o5e3/+UnYCmQ/0aKi4LUA3rREyx/wzEYTPh3FKHXGzyI87M=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5209.eurprd08.prod.outlook.com (10.255.17.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.14; Thu, 19 Sep 2019 10:21:44 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2284.009; Thu, 19 Sep 2019
 10:21:44 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>, Kevin Wolf
 <kwolf@redhat.com>
Thread-Topic: [RFC] error: auto propagated local_err
Thread-Index: AQHVbiFyZhBrSsOpYEOTsgc7Le+SIKcxq6KAgAEOLgCAAA5zgIAAA4cA
Date: Thu, 19 Sep 2019 10:21:44 +0000
Message-ID: <d6887113-f8e8-ca4e-1dd9-fa70d946e0fa@virtuozzo.com>
References: <20190918130244.24257-1-vsementsov@virtuozzo.com>
 <abb14088-6af2-5db2-da0d-0948fd4ac81c@redhat.com>
 <20190919091720.GB10163@localhost.localdomain>
 <20190919100903.GF20217@redhat.com>
In-Reply-To: <20190919100903.GF20217@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR07CA0016.eurprd07.prod.outlook.com
 (2603:10a6:7:67::26) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190919132140251
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7fdb0b5b-7bad-4915-74fb-08d73ceb2b8a
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DB8PR08MB5209; 
x-ms-traffictypediagnostic: DB8PR08MB5209:
x-microsoft-antispam-prvs: <DB8PR08MB52092798411FDBDA66379037C1890@DB8PR08MB5209.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(396003)(39850400004)(376002)(366004)(346002)(199004)(189003)(71200400001)(66556008)(11346002)(446003)(5660300002)(186003)(71190400001)(305945005)(7416002)(316002)(81156014)(478600001)(64756008)(66946007)(31696002)(66446008)(66066001)(3846002)(6116002)(6436002)(7406005)(4326008)(2616005)(52116002)(102836004)(81166006)(53546011)(8936002)(229853002)(2906002)(8676002)(76176011)(476003)(7736002)(6506007)(66476007)(486006)(26005)(86362001)(14454004)(99286004)(14444005)(110136005)(54906003)(6512007)(6486002)(386003)(36756003)(256004)(31686004)(25786009)(6246003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5209;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: om+ko+KwonOcJsM1/FricW5QM36hUjovUs8N2p+UVXDYIndTdSFrs1bQTmrFK7xko0woBF9ETtH5FY4kfMS7SxCRmlRAWvwZJDxnDTRaOaEDrgWkq5huOezI5n1LqS9vFsGykO6mWDWHzqzXXcGCA9YwSDC7hTL5p7MuE8njRdEzgEDXY0ld8+E9x8AaflrIdADr0B3COdJc8bWz9C/MDQaqxYZtVw4Ek/Qa49DZBpJF/9In1+L7piGTsD6HIVilTfUBxTFCvHamGRKHGqUx1n337aSXKBsii3sqmsaKJpkR4F+QnYKgth59PDSFL9nAbT0SDkL6meGVhDm1JYkEe+1hrVQmGOAmSGOiEv7FPLVfFBB6pltKadc9r5kwPE0vDH51bGewB7AAS6y/Kws6A1EZXjJPt6QNbmRLBUPB8Ls=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <A18A23A368AD7F409E8190BA8236AA42@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fdb0b5b-7bad-4915-74fb-08d73ceb2b8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 10:21:44.2920 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lDHhr6dU3u1hH9R9QSAAKiRW6ItRoPWtHXzdOTVbIDCeGMW6qY+ZNBmnbel5rmDVHY/iaYebMLz3QsFavfbZXuxGC1tF/FBDuXVTNbI4lrs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5209
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.92
Subject: Re: [Qemu-devel] [RFC] error: auto propagated local_err
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
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "mst@redhat.com" <mst@redhat.com>, "codyprime@gmail.com" <codyprime@gmail.com>,
 "mark.cave-ayland@ilande.co.uk" <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "kraxel@redhat.com" <kraxel@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "quintela@redhat.com" <quintela@redhat.com>,
 "david@redhat.com" <david@redhat.com>,
 "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>,
 "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>,
 "farman@linux.ibm.com" <farman@linux.ibm.com>,
 "groug@kaod.org" <groug@kaod.org>, "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>,
 "sundeep.lkml@gmail.com" <sundeep.lkml@gmail.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTkuMDkuMjAxOSAxMzowOSwgRGFuaWVsIFAuIEJlcnJhbmfDqSB3cm90ZToNCj4gT24gVGh1LCBT
ZXAgMTksIDIwMTkgYXQgMTE6MTc6MjBBTSArMDIwMCwgS2V2aW4gV29sZiB3cm90ZToNCj4+IEFt
IDE4LjA5LjIwMTkgdW0gMTk6MTAgaGF0IEVyaWMgQmxha2UgZ2VzY2hyaWViZW46DQo+Pj4gT24g
OS8xOC8xOSA4OjAyIEFNLCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3RlOg0KPj4+
PiArICovDQo+Pj4+ICsjZGVmaW5lIE1BS0VfRVJSUF9TQUZFKGVycnApIFwNCj4+Pj4gK2dfYXV0
byhFcnJvclByb3BhZ2F0aW9uU3RydWN0KSAoX19hdXRvX2VycnBfcHJvcCkgPSB7LmVycnAgPSAo
ZXJycCl9OyBcDQo+Pj4+ICtpZiAoKGVycnApID09IE5VTEwgfHwgKihlcnJwKSA9PSBlcnJvcl9h
Ym9ydCB8fCAqKGVycnApID09IGVycm9yX2ZhdGFsKSB7IFwNCj4+Pj4gKyAgICAoZXJycCkgPSAm
X19hdXRvX2VycnBfcHJvcC5sb2NhbF9lcnI7IFwNCj4+Pj4gK30NCj4+Pg0KPj4+IE5vdCB3cml0
dGVuIHRvIHRha2UgYSB0cmFpbGluZyBzZW1pY29sb24gaW4gdGhlIGNhbGxlci4NCj4+Pg0KPj4+
IFlvdSBjb3VsZCBldmVuIHNldCBfX2F1dG9fZXJycF9wcm9wIHVuY29uZGl0aW9uYWxseSByYXRo
ZXIgdGhhbiB0cnlpbmcNCj4+PiB0byByZXVzZSBpbmNvbWluZyBlcnJwICh0aGUgZGlmZmVyZW5j
ZSBiZWluZyB0aGF0IGVycm9yX3Byb3BhZ2F0ZSgpIGdldHMNCj4+PiBjYWxsZWQgbW9yZSBmcmVx
dWVudGx5KS4NCj4+DQo+PiBJIHRoaW5rIHRoaXMgZGlmZmVyZW5jZSBpcyBhY3R1YWxseSBhIHBy
b2JsZW0uDQo+Pg0KPj4gV2hlbiBkZWJ1Z2dpbmcgdGhpbmdzLCBJIGhhdGUgZXJyb3JfcHJvcGFn
YXRlKCkuIEl0IG1lYW5zIHRoYXQgdGhlIEVycm9yDQo+PiAoc3BlY2lmaWNhbGx5IGl0cyBmaWVs
ZHMgc3JjL2Z1bmMvbGluZSkgcG9pbnRzIHRvIHRoZSBvdXRlcm1vc3QNCj4+IGVycm9yX3Byb3Bh
Z2F0ZSgpIHJhdGhlciB0aGFuIHRoZSBwbGFjZSB3aGVyZSB0aGUgZXJyb3IgcmVhbGx5IGhhcHBl
bmVkLg0KPj4gSXQgYWxzbyBtYWtlcyBlcnJvcl9hYm9ydCBjb21wbGV0ZWx5IHVzZWxlc3MgYmVj
YXVzZSBhdCB0aGUgcG9pbnQgd2hlcmUNCj4+IHRoZSBwcm9jZXNzIGdldHMgYWJvcnRlZCwgdGhl
IGludGVyZXN0aW5nIGluZm9ybWF0aW9uIGlzIGFscmVhZHkgbG9zdC4NCj4gDQo+IFllYWgsIHRo
YXQgaXMgdmVyeSBmcnVzdHJhdGluZy4gRm9yIHBlcnNvbmFsIGRldmVsb3BtZW50IHlvdSBjYW4g
ZXZlbnR1YWxseQ0KPiBmaWd1cmUgaXQgb3V0LCBidXQgd2l0aCBjdXN0b21lciBzdXBwb3J0IHJl
cXVlc3RzLCBhbGwgeW91IGdldCBpcyB0aGUNCj4gc3RhY2sgdHJhY2UgYW5kIHlvdSd2ZSBubyBj
b3JlIGZpbGUgdG8gaW52ZXN0aWdhdGUsIHNvIHlvdSdyZSBzdHVjay4NCj4gSU9XLCBhcyBhIGdl
bmVyYWwgcHJpbmNpcGxlLCB3ZSBzaG91bGQgc3RyaXZlIHRvIG1pbmltaXplIHRoZSB1c2FnZQ0K
PiBvZiBlcnJvciBwcm9wYWdhdGUuDQo+IA0KPiBUaGUga2V5IHJlYXNvbiB3aHkgd2UgdHlwaWNh
bGx5IG5lZWQgdGhlIHByb3BhZ2F0ZSBjYWxscywgaXMgYmVjYXVzZQ0KPiB3ZSBhbGxvdyB0aGUg
cGFzc2VkIGluIEVycm9yICoqZXJycCBwYXJhbWV0ZXIgdG8gYmUgTlVMTCwgd2hpbGUgYXQgdGhl
DQo+IHNhbWUgdGltZSB3ZSB3YW50IHRvIGluc3BlY3QgaXQgdG8gc2VlIGlmIGl0cyBjb250ZW50
cyBhcmUgbm9uLU5VTEwNCj4gdG8gZGV0ZWN0IGZhaWx1cmUuIEkgdmVudHVyZSB0byBzdWdnZXN0
IHRoYXQgdGhpcyBpcyBmbGF3ZWQgQVBJDQo+IGRlc2lnbiBvbiBvdXIgcGFydC4gV2Ugc2hvdWxk
IG5vdCBuZWVkIHRvIGluc3BlY3QgdGhlIGVycm9yIG9iamVjdA0KPiB0byBzZWUgaWYgYSBtZXRo
b2QgY2FsbCBmYWlscyAtIHRoZSByZXR1cm4gdmFsdWUgY2FuIGJlIHVzZWQgZm9yDQo+IHRoaXMg
cHVycG9zZS4NCj4gDQo+IElPVywgaW5zdGVhZCBvZiB0aGlzIHBhdHRlcm4gd2l0aCB0eXBpY2Fs
bHkgJ3ZvaWQnIG1ldGhvZHMNCj4gDQo+ICAgICAgIGV4dGVybiB2b2lkIHNvbWVtZXRob2QoRXJy
b3IgKiplcnJwKTsNCj4gDQo+ICAgICAgIHZvaWQgdGhpc21ldGhvZChFcnJvciAqKmVycnApIHsN
Cj4gICAgICAgICAgRXJyb3IgKmxvY2FsX2VyciA9IE5VTEw7DQo+IAkuLi4NCj4gICAgICAgICAg
c29tZW1ldGhvZCgmbG9jYWxfZXJyKTsNCj4gICAgICAgICAgaWYgKGxvY2FsX2Vycikgew0KPiAJ
ICAgIGVycm9yX3Byb3BhZ2F0ZShlcnJwLCBsb2NhbF9lcnIpOw0KPiAJICAgIHJldHVybjsNCj4g
CX0NCj4gICAgICAgICAgLi4uDQo+ICAgICAgIH0NCj4gDQo+IFdlIHNob3VsZCBiZSBwcmVmZXJy
aW5nDQo+IA0KPiAgICAgICBleHRlcm4gaW50IHNvbWVtZXRob2QoRXJyb3IgKiplcnJwKTsNCj4g
DQo+ICAgICAgIGludCB0aGlzbWV0aG9kKEVycm9yICoqZXJycCkgew0KPiAJLi4uDQo+ICAgICAg
ICAgIGlmIChzb21lbWV0aG9kKGVycnApIDwgMCkgew0KPiAJICAgIHJldHVybiAtMTsNCj4gCX0N
Cj4gICAgICAgICAgLi4uDQo+ICAgICAgIH0NCj4gDQo+IGllIG9ubHkgdXNpbmcgdGhlIEVycm9y
IG9iamVjdCB0byBidWJibGUgdXAgdGhlICpkZXRhaWxzKiBvZg0KPiB0aGUgZXJyb3IsIG5vdCBh
cyB0aGUgbWVjaGFuaXNtIGZvciBmaW5kaW5nIGlmIGFuIGVycm9yIG9jY3VycmVkLg0KPiANCj4g
VGhlcmUgaXMgb2YgY291cnNlIGEgZG93bnNpZGUgd2l0aCB0aGlzIGFwcHJvYWNoLCBpbiB0aGF0
IGENCj4gbWV0aG9kIG1pZ2h0IHNldCAnZXJycCcgYnV0IHJldHVybiAwLCBvciBub3Qgc2V0ICdl
cnJwJyBidXQNCj4gcmV0dXJuIC0xLiBJIHRoaW5rIHRoaXMgaXMgb3V0d2VpZ2hlZCBieSB0aGUg
c2ltcGxlciBjb2RlDQo+IHBhdHRlcm4gb3ZlcmFsbCB0aG91Z2guDQo+IA0KPiANCg0KQWdyZWUu
IEJ1dCBzZWVtcyB0aGF0IHN1Y2ggY2hhbmdlIG1heSBiZSBvbmx5IGRvbmUgYnkgaGFuZC4uIEht
bSwgb24gdGhlIG90aGVyIGhhbmQsDQp3aHkgbm90LiBNYXkgYmUgSSdsbCB0cnkgZG8gaXQgZm9y
IHNvbWUgcGFydHMgb2YgYmxvY2sgbGF5ZXIuDQoNClN0aWxsLCBlcnJvcl9hcHBlbmRfaGludCBu
ZWVkcyBsb2NhbF9lcnIgaW4gY2FzZSBvZiBlcnJvcl9mYXRhbC4NCg0KDQotLSANCkJlc3QgcmVn
YXJkcywNClZsYWRpbWlyDQo=

