Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADC6ECE588
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 17:59:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C9C32086A
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 17:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="j+FC8hJZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C9C32086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKR6l-00040N-Ir
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 13:59:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55514)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iKR56-0002zF-GM
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 13:58:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iKR55-0006Gh-3X
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 13:58:00 -0400
Received: from mail-eopbgr10091.outbound.protection.outlook.com
 ([40.107.1.91]:22581 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1iKR50-0006Dm-3G; Tue, 15 Oct 2019 13:57:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UsvzFRB4CAzUJC8VoS42g2b5horDV4nZhpBz7ODTL+MQKgjqlBflu0fUjGDLiM0uOnCcu8ZMP+OYy1j8V+HRGstRm+Sjuy+UU+wkNOIQsed/jWMUoPPr23QKjM8lttT09GGAHcvT6I0aVr1GySBapGHqhOMX8MkdrbTsLIkOiN/N0YE4+xR4sk7wiSib3CMxpc3xtdYj1WF4koPIcisrBtUSFqFHDLJZ1+4f/8PYaRWAsg1EEKOHjnxvqcmkd5r2h2Jm+CZ6Kd0+eP+xVggyRo8M2mkyt9w2QUBJrq2rZicxwEOfy23VS9RctYYpO99NHnj24TaZmM3XxxZCuIRJnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRm0OJgX7Ab/85aGBUtr8dEeBn8qGtC12pyU4HUatZc=;
 b=n9hAWcNo+S8Z1EOG+Bto+KpbSDcbi6jv7j21teq1rjwQPwg/MEkq4WUaxfYOxy+Uzodqht5Y36JhL/Kvcs/65w2GIbpapCwm/agzcAuYsAGtZe5KcxMqEy621HwkIhS1dmQHv874MuNcIoIN4+cpbE9EtGclNqGz9xBKE9Wfj6QZs1knIJkTnLplAtaFjGJ/7CJeaAMeKjXMqEhxmHFSxQNJiKKjc1+l+bGE9hOM8Bwfskg3GceDPL8rVzJ0H9bqD4p1vtOAxpuKL/FC/RG8DAmah/U7HWOOmX4m4IU4zEnlp8EkoyC0mpQKNllZzUujukNGDcqJTQOz65CInDJD2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRm0OJgX7Ab/85aGBUtr8dEeBn8qGtC12pyU4HUatZc=;
 b=j+FC8hJZgneiG3C2pPZhxp/p3gg/4uHvq/LLkL8ioRMg8eV78UF/K34JnnnSnfiE9A+7f89D76polljBCDU2Egt9W2aa2LNz34rrz7st0UK6Sivy64ooitmG0D4ajC4vnEP8GInWtj/KZQi+/V3S7KiU93F+o3WWl+Rtu3ghixI=
Received: from DB6PR08MB2757.eurprd08.prod.outlook.com (10.170.220.33) by
 DB6PR08MB2822.eurprd08.prod.outlook.com (10.170.222.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Tue, 15 Oct 2019 17:57:51 +0000
Received: from DB6PR08MB2757.eurprd08.prod.outlook.com
 ([fe80::f8d8:53c7:ba52:ad42]) by DB6PR08MB2757.eurprd08.prod.outlook.com
 ([fe80::f8d8:53c7:ba52:ad42%5]) with mapi id 15.20.2347.023; Tue, 15 Oct 2019
 17:57:51 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH v2 6/6] tests/qemu-iotests: add case for block-stream
 compress
Thread-Topic: [PATCH v2 6/6] tests/qemu-iotests: add case for block-stream
 compress
Thread-Index: AQHVeSznztA3SDann0Kq3p3P1rLzjKdJA7eAgBMOCwA=
Date: Tue, 15 Oct 2019 17:57:51 +0000
Message-ID: <036fae88-0263-bb25-2c37-7b74ce7dbef9@virtuozzo.com>
References: <1570026166-748566-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1570026166-748566-7-git-send-email-andrey.shinkevich@virtuozzo.com>
 <ad9631b0-2145-c6c8-881c-b9f016ba82b1@virtuozzo.com>
In-Reply-To: <ad9631b0-2145-c6c8-881c-b9f016ba82b1@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR07CA0042.eurprd07.prod.outlook.com
 (2603:10a6:7:66::28) To DB6PR08MB2757.eurprd08.prod.outlook.com
 (2603:10a6:6:18::33)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 488cb806-2d0a-47b8-1984-08d75199323b
x-ms-traffictypediagnostic: DB6PR08MB2822:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR08MB2822EDA86BF6D24192908DE3F4930@DB6PR08MB2822.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:538;
x-forefront-prvs: 01917B1794
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39840400004)(376002)(346002)(396003)(366004)(136003)(199004)(189003)(316002)(44832011)(36756003)(6512007)(6246003)(2201001)(86362001)(25786009)(66446008)(66556008)(66476007)(81166006)(8936002)(64756008)(81156014)(107886003)(6486002)(31696002)(11346002)(54906003)(486006)(26005)(2616005)(53546011)(76176011)(476003)(4326008)(186003)(110136005)(52116002)(446003)(5660300002)(102836004)(386003)(66066001)(99286004)(6506007)(71200400001)(7416002)(478600001)(305945005)(14454004)(8676002)(3846002)(31686004)(6116002)(7736002)(2501003)(256004)(6436002)(66946007)(229853002)(2906002)(71190400001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB6PR08MB2822;
 H:DB6PR08MB2757.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ucJSCH+8mYiRm9picsF9CgtD24EY36KdDiBzLrWt94la6plqgLgmAPGLu7j/ZoMFi+UGmCkUUKMWtQ02ZI8B+BDC7ZMTihRl0IOmRIcio8qrTpxFc+yprNfI96YbogmY68rWq3AmGfGbpnzt9RP9teF6+xAi44BOBVGwSiaololXCZwJq04eEdDrPuHBz4JngRjoH4JdvovYijIDRlN3AfGnPIDmaH/AcYmCpl8dRsJR7UO42hQzYIRETQuZq1SPwixKO4/I+ZY4yduHPKduv4+/A0YoxIPTsU15lqoRHRVHqM1FMDEM6/i/SGPzwZEj+DQcIhXaUAT9nyjU7AzCxHDinOPDx2N+hUWuU9p951/4D6vWWfpz1YDryaPepxrfPVU3oEuZEGabSNjRHSOIcYE0DMxA03UYRoQQUuj8Yu4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6F945F492934774FB251335ABEA50133@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 488cb806-2d0a-47b8-1984-08d75199323b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2019 17:57:51.3243 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IsS779VkD2jexTrDNoNfnDkx57MGtCdYlhjcBEuKrHJHjnpWe39DxvYz9gfHp+pUy0NvUqOIhn2ipcp69Imt9nI1f2Umcel9x9yy/4vAvhs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR08MB2822
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.91
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
 Denis Lunev <den@virtuozzo.com>, "jsnow@redhat.com" <jsnow@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDAzLzEwLzIwMTkgMTc6NTgsIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3Jv
dGU6DQo+IDAyLjEwLjIwMTkgMTc6MjIsIEFuZHJleSBTaGlua2V2aWNoIHdyb3RlOg0KPj4gQWRk
IGEgdGVzdCBjYXNlIHRvIHRoZSBpb3Rlc3QgIzAzMCB0aGF0IGNoZWNrcyAnY29tcHJlc3MnIG9w
dGlvbiBmb3IgYQ0KPj4gYmxvY2stc3RyZWFtIGpvYi4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBB
bmRyZXkgU2hpbmtldmljaCA8YW5kcmV5LnNoaW5rZXZpY2hAdmlydHVvenpvLmNvbT4NCj4+IC0t
LQ0KPj4gICAgdGVzdHMvcWVtdS1pb3Rlc3RzLzAzMCAgICAgfCA0OSArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKystDQo+PiAgICB0ZXN0cy9xZW11LWlvdGVzdHMv
MDMwLm91dCB8ICA0ICsrLS0NCj4+ICAgIDIgZmlsZXMgY2hhbmdlZCwgNTAgaW5zZXJ0aW9ucygr
KSwgMyBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvdGVzdHMvcWVtdS1pb3Rlc3Rz
LzAzMCBiL3Rlc3RzL3FlbXUtaW90ZXN0cy8wMzANCj4+IGluZGV4IGYzNzY2ZjIuLjEzZmU1YTIg
MTAwNzU1DQo+PiAtLS0gYS90ZXN0cy9xZW11LWlvdGVzdHMvMDMwDQo+PiArKysgYi90ZXN0cy9x
ZW11LWlvdGVzdHMvMDMwDQo+PiBAQCAtMjEsNyArMjEsOCBAQA0KPj4gICAgaW1wb3J0IHRpbWUN
Cj4+ICAgIGltcG9ydCBvcw0KPj4gICAgaW1wb3J0IGlvdGVzdHMNCj4+IC1mcm9tIGlvdGVzdHMg
aW1wb3J0IHFlbXVfaW1nLCBxZW11X2lvDQo+PiArZnJvbSBpb3Rlc3RzIGltcG9ydCBxZW11X2lt
ZywgcWVtdV9pbywgcWVtdV9pbWdfcGlwZQ0KPj4gK2ltcG9ydCBqc29uDQo+PiAgICANCj4+ICAg
IGJhY2tpbmdfaW1nID0gb3MucGF0aC5qb2luKGlvdGVzdHMudGVzdF9kaXIsICdiYWNraW5nLmlt
ZycpDQo+PiAgICBtaWRfaW1nID0gb3MucGF0aC5qb2luKGlvdGVzdHMudGVzdF9kaXIsICdtaWQu
aW1nJykNCj4+IEBAIC05NTYsNiArOTU3LDUyIEBAIGNsYXNzIFRlc3RTZXRTcGVlZChpb3Rlc3Rz
LlFNUFRlc3RDYXNlKToNCj4+ICAgIA0KPj4gICAgICAgICAgICBzZWxmLmNhbmNlbF9hbmRfd2Fp
dChyZXN1bWU9VHJ1ZSkNCj4+ICAgIA0KPj4gK2NsYXNzIFRlc3RDb21wcmVzc2VkKGlvdGVzdHMu
UU1QVGVzdENhc2UpOg0KPj4gKw0KPj4gKyAgICBkZWYgc2V0VXAoc2VsZik6DQo+PiArICAgICAg
ICBxZW11X2ltZygnY3JlYXRlJywgJy1mJywgaW90ZXN0cy5pbWdmbXQsIGJhY2tpbmdfaW1nLCAn
MU0nKQ0KPj4gKyAgICAgICAgcWVtdV9pbWcoJ2NyZWF0ZScsICctZicsIGlvdGVzdHMuaW1nZm10
LCAnLW8nLA0KPj4gKyAgICAgICAgICAgICAgICAgJ2JhY2tpbmdfZmlsZT0lcycgJSBiYWNraW5n
X2ltZywgbWlkX2ltZykNCj4+ICsgICAgICAgIHFlbXVfaW1nKCdjcmVhdGUnLCAnLWYnLCBpb3Rl
c3RzLmltZ2ZtdCwgJy1vJywNCj4+ICsgICAgICAgICAgICAgICAgICdiYWNraW5nX2ZpbGU9JXMn
ICUgbWlkX2ltZywgdGVzdF9pbWcpDQo+PiArICAgICAgICBxZW11X2lvKCctYycsICd3cml0ZSAt
UCAweDEgMCA1MTJrJywgYmFja2luZ19pbWcpDQo+PiArICAgICAgICBzZWxmLnZtID0gaW90ZXN0
cy5WTSgpLmFkZF9kcml2ZSh0ZXN0X2ltZywgImJhY2tpbmcubm9kZS1uYW1lPW1pZCwiICsNCj4+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJiYWNraW5nLmJhY2tp
bmcubm9kZS1uYW1lPWJhc2UiKQ0KPj4gKyAgICAgICAgc2VsZi52bS5sYXVuY2goKQ0KPiANCj4g
V2h5IHlvdSBjYW4ndCBqdXN0IGFkZCBhIHRlc3QtY2FzZSB0byBUZXN0U2luZ2xlRHJpdmUgY2xh
c3M/DQoNClRoZWlyIHNldFVwKCkgZnVuY3Rpb25zIGRpZmZlci4NCg0KPiANCj4+ICsNCj4+ICsg
ICAgZGVmIHRlYXJEb3duKHNlbGYpOg0KPj4gKyAgICAgICAgc2VsZi52bS5zaHV0ZG93bigpDQo+
PiArICAgICAgICBvcy5yZW1vdmUodGVzdF9pbWcpDQo+PiArICAgICAgICBvcy5yZW1vdmUobWlk
X2ltZykNCj4+ICsgICAgICAgIG9zLnJlbW92ZShiYWNraW5nX2ltZykNCj4+ICsNCj4+ICsgICAg
ZGVmIHRlc3Rfc3RyZWFtX2NvbXByZXNzKHNlbGYpOg0KPj4gKyAgICAgICAgc2VsZi5hc3NlcnRf
bm9fYWN0aXZlX2Jsb2NrX2pvYnMoKQ0KPj4gKw0KPj4gKyAgICAgICAgcmVzdWx0ID0gc2VsZi52
bS5xbXAoJ2Jsb2NrLXN0cmVhbScsIGRldmljZT0nbWlkJywgam9iX2lkPSdzdHJlYW0tbWlkJykN
Cj4+ICsgICAgICAgIHNlbGYuYXNzZXJ0X3FtcChyZXN1bHQsICdyZXR1cm4nLCB7fSkNCj4+ICsN
Cj4+ICsgICAgICAgIHNlbGYud2FpdF91bnRpbF9jb21wbGV0ZWQoZHJpdmU9J3N0cmVhbS1taWQn
KQ0KPj4gKyAgICAgICAgZm9yIGV2ZW50IGluIHNlbGYudm0uZ2V0X3FtcF9ldmVudHMod2FpdD1U
cnVlKToNCj4+ICsgICAgICAgICAgICBpZiBldmVudFsnZXZlbnQnXSA9PSAnQkxPQ0tfSk9CX0NP
TVBMRVRFRCc6DQo+PiArICAgICAgICAgICAgICAgIHNlbGYuZGljdHBhdGgoZXZlbnQsICdkYXRh
L2RldmljZScpDQo+PiArICAgICAgICAgICAgICAgIHNlbGYuYXNzZXJ0X3FtcF9hYnNlbnQoZXZl
bnQsICdkYXRhL2Vycm9yJykNCj4gDQo+IENPTVBMRVRFRCBldmVudCBpcyBmb3Igc3VyZSBhbHJl
YWR5IHdhaXRlZCBieSB3YWl0X3VudGlsX2NvbXBsZXRlZA0KPiANCj4+ICsNCj4+ICsgICAgICAg
IHJlc3VsdCA9IHNlbGYudm0ucW1wKCdibG9jay1zdHJlYW0nLCBkZXZpY2U9J2RyaXZlMCcsIGJh
c2U9bWlkX2ltZywNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGpvYl9pZD0nc3Ry
ZWFtLXRvcCcsIGNvbXByZXNzPVRydWUpDQo+PiArICAgICAgICBzZWxmLmFzc2VydF9xbXAocmVz
dWx0LCAncmV0dXJuJywge30pDQo+PiArDQo+PiArICAgICAgICBzZWxmLndhaXRfdW50aWxfY29t
cGxldGVkKGRyaXZlPSdzdHJlYW0tdG9wJykNCj4+ICsgICAgICAgIHNlbGYuYXNzZXJ0X25vX2Fj
dGl2ZV9ibG9ja19qb2JzKCkNCj4gDQo+IHRoaXMgYXNzZXJ0aW9uIGlzIGRvbmUgaW4gd2FpdF91
bnRpbF9jb21wbGV0ZWQNCj4gDQo+PiArICAgICAgICBzZWxmLnZtLnNodXRkb3duKCkNCj4+ICsN
Cj4+ICsgICAgICAgIHRvcCA9IGpzb24ubG9hZHMocWVtdV9pbWdfcGlwZSgnaW5mbycsICctLW91
dHB1dD1qc29uJywgdGVzdF9pbWcpKQ0KPj4gKyAgICAgICAgbWlkID0ganNvbi5sb2FkcyhxZW11
X2ltZ19waXBlKCdpbmZvJywgJy0tb3V0cHV0PWpzb24nLCBtaWRfaW1nKSkNCj4+ICsgICAgICAg
IGJhc2UgPSBqc29uLmxvYWRzKHFlbXVfaW1nX3BpcGUoJ2luZm8nLCAnLS1vdXRwdXQ9anNvbics
IGJhY2tpbmdfaW1nKSkNCj4+ICsNCj4+ICsgICAgICAgIHNlbGYuYXNzZXJ0RXF1YWwobWlkWydh
Y3R1YWwtc2l6ZSddLCBiYXNlWydhY3R1YWwtc2l6ZSddKQ0KPj4gKyAgICAgICAgc2VsZi5hc3Nl
cnRMZXNzKHRvcFsnYWN0dWFsLXNpemUnXSwgbWlkWydhY3R1YWwtc2l6ZSddKQ0KPj4gKw0KPj4g
ICAgaWYgX19uYW1lX18gPT0gJ19fbWFpbl9fJzoNCj4+ICAgICAgICBpb3Rlc3RzLm1haW4oc3Vw
cG9ydGVkX2ZtdHM9WydxY293MicsICdxZWQnXSwNCj4+ICAgICAgICAgICAgICAgICAgICAgc3Vw
cG9ydGVkX3Byb3RvY29scz1bJ2ZpbGUnXSkNCj4+IGRpZmYgLS1naXQgYS90ZXN0cy9xZW11LWlv
dGVzdHMvMDMwLm91dCBiL3Rlc3RzL3FlbXUtaW90ZXN0cy8wMzAub3V0DQo+PiBpbmRleCA2ZDli
ZWUxLi5hZjhkYWMxIDEwMDY0NA0KPj4gLS0tIGEvdGVzdHMvcWVtdS1pb3Rlc3RzLzAzMC5vdXQN
Cj4+ICsrKyBiL3Rlc3RzL3FlbXUtaW90ZXN0cy8wMzAub3V0DQo+PiBAQCAtMSw1ICsxLDUgQEAN
Cj4+IC0uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4NCj4+ICsuLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uDQo+PiAgICAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+PiAtUmFuIDI3IHRlc3RzDQo+PiArUmFu
IDI4IHRlc3RzDQo+PiAgICANCj4+ICAgIE9LDQo+Pg0KPiANCj4gDQoNCi0tIA0KV2l0aCB0aGUg
YmVzdCByZWdhcmRzLA0KQW5kcmV5IFNoaW5rZXZpY2gNCg==

