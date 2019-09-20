Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44776C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 11:48:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CB47208C0
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 11:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="YbKFzz9V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CB47208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBHOy-00005i-4M
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 07:48:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39933)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iBHMw-0007dH-Rf
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 07:46:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iBHMv-0000IM-CN
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 07:46:34 -0400
Received: from mail-eopbgr60118.outbound.protection.outlook.com
 ([40.107.6.118]:63132 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iBHMb-0008Tn-R4; Fri, 20 Sep 2019 07:46:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gbXRuxsIe/Uy54NaH3rTGtgfU5RHtE4TcjvT5Y38HxO/Kh+vJXpm+Psp7vHHTe5ssIFIAqwOLqCMs+G0y9COYYMU3l8fRAF2anzK+13Z0SdFyjjIA+rnfCtcbV2fuejT0UatvnOsn1SgCzXCPgIkmsJfYFi1EdZyfcJhe/3P9jIZoKfueJ09RGSYTgnl7CyZUEMwIJVLgxcgA3qc8TqdA3emHZlniLKxpzf5DbrG5/97MNNsPOetCXhC6Clkn0HG9B9R0Pu4By9u7DMq9v4GiNPkhWKwuqaXRmu/lgXYBt9HMdryyuygDlEpgyivv//5ZHq7RQ3VTBR4R7CJSVLCIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BmBn99ft1uPHRCti70X8a0HNwK7lpBe+UxrZZPnfH+k=;
 b=fUXuoyZE2EJDT4HGR5MDt7XqyzQoW3iaSYBXKZgMAdmKTegLR83vHnkoUyoxIe0R2JOgjU4jkDVL5BH86Cuon/APkUvukXWz/KXRVppNRokkyO141KzPrmEqCKFYoMUJjvX1/sPO1Zq9xotcAqu4zdfJs37m7OvWUB6LvirlgQgRQ/0lgFyL/ZrMCiPfNV/3khOvPukSyk0ygDiIQOP0qa1V+mS+fPy+g/IU4kQh80lJmzaJu/cYn2TvwXmEGlghdDXPJNg9QI/07YsPkbxKnVTL1WosglZx6ENErbpVio7VYhqxnWAFyWuM4wsJ53RAdbx7DfbzPfL05t9orvEcmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BmBn99ft1uPHRCti70X8a0HNwK7lpBe+UxrZZPnfH+k=;
 b=YbKFzz9VaktnRJXIzwrI+3JkmB30CEh4kFIZfqRTxqo3zGLIW/Ne55VfWiji2rO2PzT8Y/kbl5u0tDWjrY+21jQJzlKYfi0HQemTHUzOFQsroV5D+sgFF5hrLZ4kha8UNkjfbTXvzxL1eFZozcVurm79GTwV4nPXSWr/rCcRhfY=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4970.eurprd08.prod.outlook.com (10.255.17.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.15; Fri, 20 Sep 2019 11:46:07 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2284.023; Fri, 20 Sep 2019
 11:46:07 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [RFC] error: auto propagated local_err
Thread-Topic: [RFC] error: auto propagated local_err
Thread-Index: AQHVbiFyZhBrSsOpYEOTsgc7Le+SIKc0dbKA
Date: Fri, 20 Sep 2019 11:46:07 +0000
Message-ID: <0ca8b02e-d885-2a54-c287-51f937653ef3@virtuozzo.com>
References: <20190918130244.24257-1-vsementsov@virtuozzo.com>
In-Reply-To: <20190918130244.24257-1-vsementsov@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0402CA0043.eurprd04.prod.outlook.com
 (2603:10a6:7:7c::32) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190920144603239
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 271e3d0f-0d21-4121-b540-08d73dc01fdb
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DB8PR08MB4970; 
x-ms-traffictypediagnostic: DB8PR08MB4970:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB8PR08MB49707D58FCED0F5560150158C1880@DB8PR08MB4970.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0166B75B74
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(376002)(39840400004)(346002)(366004)(136003)(189003)(199004)(53754006)(7736002)(14454004)(5640700003)(256004)(6436002)(66946007)(6916009)(66476007)(305945005)(71190400001)(64756008)(2501003)(66066001)(7406005)(25786009)(66446008)(2351001)(476003)(386003)(52116002)(11346002)(76176011)(54906003)(102836004)(6506007)(7416002)(6486002)(229853002)(316002)(3846002)(81166006)(99286004)(5660300002)(2906002)(2616005)(31686004)(26005)(486006)(66556008)(71200400001)(8936002)(478600001)(561944003)(36756003)(186003)(446003)(6116002)(8676002)(81156014)(6306002)(6512007)(6246003)(31696002)(4326008)(966005)(86362001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4970;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: drC9eYGpcwoIIhMtMI8jLvyjha1SVJKFebK9Smwu/tBcKDkVi1rrGer//nsx3+d9rvSjuDjoo3EiRZWbCZAVuABcVzcHiynM6Hch0UZYRdVD83bddHrLODUpLAZiWQ3Wl7C8E8FmEdZnJngCvBLgObEW5mQ9J1ZWddxajKSpMB4hq5ZLHcjKHTW1Bv/9fGEDTKWiMG67RYGvCUIngQeXkAonditU5EHZzWn1OerB+Uc5a3Xg3CBzsvP9NMf33Mz72PXSJzzvke201uUWnOe23RDZm4gJJDSqMDzg3ME6nsmT7NYbiQodUWudFxDyFMTXEqYhyowJfzMD9DpGkmJuM0R7ru+PSD6fMzCk0xiv4whbaQKRaY+sPmrcE1v5tOTyP8lX7EHYw2hBRH21eCDFSW37zrCaI+i3E1gihBds3fQ=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <32118CC3F201FA49A83C862688FE1D87@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 271e3d0f-0d21-4121-b540-08d73dc01fdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2019 11:46:07.4993 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wGZygbrAROm77Km6V5K9RYsYRSfJnenUhdT4PSZ8DDl+8Qsa+nxT2SnguASzo4znlVGrnbaxDl357Itx+xuLZn5dt1sByjXTp+9v7/YSF7Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4970
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.118
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
 "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>,
 "kraxel@redhat.com" <kraxel@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "quintela@redhat.com" <quintela@redhat.com>,
 "david@redhat.com" <david@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>,
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
 "kwolf@redhat.com" <kwolf@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>,
 "sundeep.lkml@gmail.com" <sundeep.lkml@gmail.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTguMDkuMjAxOSAxNjowMiwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4g
SGkgYWxsIQ0KPiANCj4gSGVyZSBpcyBhIHByb3Bvc2FsICh0aHJlZSBvZiB0aGVtLCBhY3R1YWxs
eSkgb2YgYXV0byBwcm9wYWdhdGlvbiBmb3INCj4gbG9jYWxfZXJyLCB0byBub3QgY2FsbCBlcnJv
cl9wcm9wYWdhdGUgb24gZXZlcnkgZXhpdCBwb2ludCwgd2hlbiB3ZQ0KPiBkZWFsIHdpdGggbG9j
YWxfZXJyLg0KPiANCj4gSXQgYWxzbyBtYXkgaGVscCBtYWtlIEdyZWcncyBzZXJpZXNbMV0gYWJv
dXQgZXJyb3JfYXBwZW5kX2hpbnQgc21hbGxlci4NCj4gDQo+IFNlZSBkZWZpbml0aW9ucyBhbmQg
ZXhhbXBsZXMgYmVsb3cuDQo+IA0KPiBJJ20gY2MtaW5nIHRvIHRoaXMgUkZDIGV2ZXJ5b25lIGZy
b20gc2VyaWVzWzFdIENDIGxpc3QsIGFzIGlmIHdlIGxpa2UNCj4gaXQsIHRoZSBpZGVhIHdpbGwg
dG91Y2ggc2FtZSBjb2RlIChhbmQgbWF5IGJlIG1vcmUpLg0KPiANCj4gWzFdOiBodHRwczovL2xp
c3RzLmdudS5vcmcvYXJjaGl2ZS9odG1sL3FlbXUtZGV2ZWwvMjAxOS0wOS9tc2cwMzQ0OS5odG1s
DQo+IA0KDQoNCk9LLCBzZWVtcyBhIGtpbmQgb2YgY29uc2Vuc3VzIGlzIGhlcmUsIGFuZCBsb29r
cyBsaWtlDQoNCiNkZWZpbmUgTUFLRV9FUlJQX1NBRkUoKSBcDQpnX2F1dG8oRXJyb3JQcm9wYWdh
dGlvblN0cnVjdCkgX19hdXRvX2VycnBfcHJvcCA9IHsuZXJycCA9IGVycnB9OyBcDQpFcnJvciAq
Kl9fbG9jYWxfZXJycF91bnVzZWQgX19hdHRyaWJ1dGVfXyAoKHVudXNlZCkpID0gXA0KICAgICAo
ZXJycCA9IChlcnJwID09IE5VTEwgfHwgKmVycnAgPT0gZXJyb3JfZmF0YWwgPyBcDQogICAgICAg
ICAgICAgICZfX2F1dG9fZXJycF9wcm9wLmxvY2FsX2Vycm9yIDogZXJycCkpDQoNCg0KW0kgYWxz
byBzdWdnZXN0IHRvIGNhbGwgaXQgRVJSUF9GVU5DVElPTl9CRUdJTiwgaW4gY2FzZSB3ZSdsbCBl
bmhhbmNlIGl0DQppbiBmdXR1cmUgKGZvciBleGFtcGxlIGJyaW5nIGNhbGwgc3RhY2sgaW50byBF
cnJvcildDQoNCg0KQW5kIE1BS0VfRVJSUF9TQUZFIGFzc3VtZWQgdG8gYmUgdXNlZCBpbiBhbGwg
ZXJycC1mdW5jdGlvbnMuDQoNCg0KTm93LCB0aGVyZSBhcmUgc3RpbGwgc2V2ZXJhbCB0aGluZ3Mg
dG8gZGlzY3VzczoNCg0KDQoxLiBTb21lIGZ1bmN0aW9ucyB3YW50IHRvIGRvIGVycm9yX2ZyZWUo
bG9jYWxfZXJyKSwgZXJyb3JfcmVwb3J0X2Vycihsb2NhbF9lcnIpLCBvcg0KbGlrZSB0aGlzLCB3
aGVuIHRoZXkgZGVjaWRlIHRoYXQgZXJyb3Igc2hvdWxkIG5vdCBiZSBwcm9wYWdhdGVkLg0KDQpX
aGF0IHRvIGRvIHdpdGggdGhlbT8gSSBzdWdnZXN0IHRvIG1ha2UgY29ycmVzcG9uZGluZyBmdW5j
dGlvbnMNCg0KZXJyb3JfZnJlZV9lcnJwLCBlcnJvcl9yZXBvcnRfZXJycCwgd2Fybl9yZXBvcnRf
ZmVycnAsIGV0Yywgd2l0aCBFcnJvciAqKmVycnAgcGFyYW1ldGVyLA0Kd2hpY2ggY2FsbHMgY29y
cmVzcG9uZGluZyAgRXJyb3IqIGZ1bmN0aW9uIGFuZCB0aGVuIHNldCBwb2ludGVyIHRvIDAuIFRo
ZW4gb3VyIHByb3BhZ2F0aW9uDQpjbGVhbnVwIHdpbGwgZG8gbm90aGluZywgYXMgZGVzaXJlZC4N
Cg0KDQoyLiBTb21lIGZ1bmN0aW9ucyB0ZW5kcyB0byBlcnJvcl9mcmVlKCplcnJwKSBvciBlcnJv
cl9yZXBvcnRfZXJyKCplcnJwKS4gU28sIHRoZXkgZG9uJ3QNCnVzZSBlcnJwIHRvIHJldHVybiBl
cnJvciwgYnV0IGluc3RlYWQgdGhleSB3YW50IHRvIGhhbmRsZSBlcnJwIHNvbWVob3c6DQp2bmNf
Y2xpZW50X2lvX2Vycm9yDQogICAtIGlzIHVzZWQgb25seSBpbiB0d28gcGxhY2VzIHRvIHRyYWNl
IGVycnAsIHNvIGl0IG1heSBiZSBpbmxpbmVkDQoNCmhtcF9oYW5kbGVfZXJyb3INCiAgIC0gaXMg
YSB3cmFwcGVyIHVzZWQgaW4gbW9yZSB0aGFuIDgwIHBsYWNlcywgdG8gZG8gZXJyb3JfcmVwb3J0
Zl9lcnIoKmVycnAsICJFcnJvcjogIik7DQooaG1tLCBiYWQgdGhhdCBpdCBkb2Vzbid0IHNldCAq
ZXJycCB0byBaRVJPIGFmdGVyIGl0KQ0KDQp3aGF0IGRvIGRvIHdpdGggaXQ/IGlubGluZSB0b28/
DQoNCm9yLCBtYXliZSByZW5hbWUgZXJycCBwYXJhbWV0ZXIgdG8gIkVycm9yICoqZmlsbGVkX2Vy
cnAiLCB0byBub3QgbWF0Y2ggb3VyIGNyaXRlcmlhPw0KDQooYXBpIGZ1bmN0aW9uIGVycm9yX2Zy
ZWVfb3JfYWJvcnQgaXMgd2l0aCBzYW1lIGJlaGF2aW9yKQ0KDQpKdXN0IGJ1Z3M6DQoNCjMuIFdv
dywgZml0X2xvYWRfZmR0KCkganVzdCBlcnJvcl9mcmVlKCplcnJwKSBpbiB3cm9uZyB3YXkhIEl0
IG11c3Qgc2V0IHRoZW4gKmVycnAgPSBOVUxMLA0KYnV0IGl0IGRvZXNuJ3QgZG8gaXQuIEFuZCBx
bXBfcXVlcnlfY3B1X2RlZigpIGlzIGNvcnJlY3QgZXhhbXBsZSBvZiB0aGlzIHRoaW5nIC0NCnRo
ZXNlIGZ1bmN0aW9ucyBkZWZpbml0ZWx5IHdhbnRzIGVycm9yX2ZyZWVfZXJycCBmdW5jdGlvbi4g
QnV0IHFtcF9xdWVyeV9jcHVfZGVmKCkNCmluY29ycmVjdGx5IGRlcmVmZXJlbmNlIGVycnAgKGl0
IG1heSBiZSBOVUxMISkNCg0KNC4gQSBsb3Qgb2YgZnVuY3Rpb25zIGluIHRhcmdldC9zMzkweC9j
cHVfbW9kZWxzLmMganVzdCBkZXJlZmVyZW5jZSBlcnJwIHRvIGNoZWNrIGVycm9yDQphbHNvOg0K
YnVpbGRfZ3Vlc3RfZnNpbmZvX2Zvcl92aXJ0dWFsX2RldmljZQ0KbGVnYWN5X2FjcGlfY3B1X3Bs
dWdfY2INCnNjbHBfZXZlbnRzX2J1c19yZWFsaXplDQptZW1vcnlfZGV2aWNlX2dldF9mcmVlX2Fk
ZHINCmlwbWlfaXNhX3JlYWxpemUNCmlzYV9pcG1pX2J0X3JlYWxpemUNCmxlZ2FjeV9hY3BpX2Nw
dV9wbHVnX2NiDQoNCjUuIGZpbGVfcmFtX2FsbG9jIGhhcyBmdW5ueSBwYXR0ZXIgdG8gY2hlY2sg
ZXJyb3I6DQogICAgIGlmIChtZW1fcHJlYWxsb2MpIHsNCiAgICAgICAgIG9zX21lbV9wcmVhbGxv
YyhmZCwgYXJlYSwgbWVtb3J5LCBtcy0+c21wLmNwdXMsIGVycnApOw0KICAgICAgICAgaWYgKGVy
cnAgJiYgKmVycnApIHsNCiAgICAgICAgICAgICBxZW11X3JhbV9tdW5tYXAoZmQsIGFyZWEsIG1l
bW9yeSk7DQogICAgICAgICAgICAgcmV0dXJuIE5VTEw7DQogICAgICAgICB9DQogICAgIH0NCg0K
DQpTZWVtcyBub3RoaW5nIGludGVyZXN0aW5nIG1vcmUuIEkgdXNlZCB0aGlzIGNvY2NpbmVsbGUg
c2NyaXB0DQpAQA0KaWRlbnRpZmllciBmbjsNCkBADQoNCiAgZm4oLi4uLCBFcnJvciAqKmVycnAp
DQogIHsNCiAgICAgIDwuLi4NCiogICAgKmVycnANCiAgICAgIC4uLj4NCiAgfQ0KDQp0byBzZWFy
Y2ggYnkgdGhpcyBjb21tZW5kOg0KDQpnaXQgZ3JlcCAtbCAnRXJyb3IgXCpcKmVycnAnIHwgeGFy
Z3MgZ3JlcCAtbCAnW14qXVwqZXJycCcgfCB4YXJncyBzcGF0Y2ggLS1zcC1maWxlIHNjcmlwdA0K
DQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

