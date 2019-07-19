Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918F0C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 15:47:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A9E621872
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 15:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="hmw8ch+N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A9E621872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoV6G-0000av-Fz
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 11:47:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35362)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hoV5y-0000AM-0M
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 11:46:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hoV5i-0005YP-74
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 11:46:42 -0400
Received: from mail-db5eur03on0703.outbound.protection.outlook.com
 ([2a01:111:f400:fe0a::703]:21679
 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1hoV59-0003z1-2q; Fri, 19 Jul 2019 11:46:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cvwwGR3MIrDQT4PKUSaIdRDCMhdsdE7wdfd5rhJuSVH3MYQEkv4aFsQnvqbiZpmZZZn31yZkT2aDrtY5ngmv+6Mr3+dx5+CezI/NTs1c6X3QrGC+biC61OYJtX/sX1iZsDv5o4SH4M6Jj5+yasYWK8lf7R9Vq9a23rAB8+xhrYFK1g2j+xjfkTJFNTcC/9Binivp9VvnGst+gpojPLHoqz7PhY8c5+aaOBlu0/rkIEi272dSTDZNyNdWh242kcQZh1/N8m+UprK1zJ6N+zlOzZWIB5fkMp04q3wTx1fdSdLzN1kxbwMX9Tc5KFmSmzz9/bCBqy4xCvg6u3k+Hiyn1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4jTGmedKGCyK9JrcXCP1EHsEJH9Ysa6WmTfnIVjAYI=;
 b=fOncJdMGAVb+9ZMu6mxIh2ERn0mSK/5P2c6OMUl0X+MSEVdK/mxjGPELJCmwdVtpigswe7f9HYTlUMEZdmo/P6dyuLiqJDPfJuTLgNOSsAanXOYcEBCB2rSI7LQDSJFGEEpsXM7wLXOeV+nIW/wLHHoVHd2TUcaCng8ITY7xOvBvQ48IdNRn2m2uB9p+UTkQ3TQkDAxOt2FXmuP/CrxeZ+jgxMjD+lwXB8zZiTwdJX4ohnvIzKwD1pgtTA5+YKL5EzkgmRm69T6rZ8yAMVO1dCPkZoVUtwxZPxpddT1K/DTEo3vqqu/xKkfSjEXAhEgG/utAoZQLoHSoCIti5Vy6Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=virtuozzo.com;dmarc=pass action=none
 header.from=virtuozzo.com;dkim=pass header.d=virtuozzo.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4jTGmedKGCyK9JrcXCP1EHsEJH9Ysa6WmTfnIVjAYI=;
 b=hmw8ch+N/3G6ejiGhwsXQ1ZG7xSl6U25hdrk9xVeQl1uMUD8a4mGVk8MofHofbVPSY1alpPYL+/PCDmLcPJSiwus/RMWy1+sNq3KBfYAg9l1q1eMCpnOupkOVHHur/uNCEy4yKuUJpqgm4gvXKYya0OYzjjYXI/Y+0u56vc1+aE=
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com (20.179.28.141) by
 VI1PR08MB2896.eurprd08.prod.outlook.com (10.170.239.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.12; Fri, 19 Jul 2019 15:43:10 +0000
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::4c3d:79b3:a884:18c4]) by VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::4c3d:79b3:a884:18c4%3]) with mapi id 15.20.2073.012; Fri, 19 Jul 2019
 15:43:10 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH v4 7/7] block/nbd: NBDReply is used being uninitialized
Thread-Index: AQHVPhX6yHnO2fi6H020bxQ0/FYE6abSAfoAgAAC0gCAADbSgP//0e6AgAAHmYA=
Date: Fri, 19 Jul 2019 15:43:10 +0000
Message-ID: <fdb6b2f9-f5e8-bc5f-7d04-26426218c888@virtuozzo.com>
References: <1563529204-3368-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1563529204-3368-8-git-send-email-andrey.shinkevich@virtuozzo.com>
 <a4214009-e9ba-2f67-138b-30ce31f7905f@redhat.com>
 <e12c0aa2-6757-856a-bbe0-717895453986@redhat.com>
 <d6093ee2-b0d6-8b85-dbca-9ee76d52688a@virtuozzo.com>
 <13facb85-33bf-f33e-be56-eed63f4f2d8c@redhat.com>
In-Reply-To: <13facb85-33bf-f33e-be56-eed63f4f2d8c@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0290.eurprd05.prod.outlook.com
 (2603:10a6:7:93::21) To VI1PR08MB4399.eurprd08.prod.outlook.com
 (2603:10a6:803:102::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a910a44b-2234-4486-6156-08d70c5fcd43
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:VI1PR08MB2896; 
x-ms-traffictypediagnostic: VI1PR08MB2896:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR08MB289686D823F62D7070400462F4CB0@VI1PR08MB2896.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:324;
x-forefront-prvs: 01039C93E4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(39840400004)(396003)(346002)(366004)(376002)(199004)(189003)(31696002)(25786009)(478600001)(31686004)(6246003)(68736007)(305945005)(7736002)(966005)(14454004)(4326008)(53546011)(386003)(6506007)(26005)(186003)(102836004)(2501003)(256004)(14444005)(486006)(44832011)(476003)(446003)(11346002)(2616005)(2906002)(52116002)(76176011)(2201001)(6512007)(6306002)(66066001)(6436002)(3846002)(6116002)(6486002)(8936002)(54906003)(110136005)(99286004)(36756003)(66556008)(66476007)(66946007)(66446008)(8676002)(64756008)(86362001)(5660300002)(71190400001)(316002)(53936002)(71200400001)(229853002)(81156014)(81166006);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB2896;
 H:VI1PR08MB4399.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SnM1VHjbQtG7Ps3AxNgxH9chKYHq+L++fE31P/JzHY/PlK54DLvxGhIk5TtdQcLib3TbVRHHHcrPOboMW8m/e4BRix+ofLjPubfb/WHNNPzs7GTZZrJUtYbT6Ar4KzLdo4Smje/Bjj/AJsR/972eLBhH2DlA9hbLN79fN029RnewyrIBRIUQ4EkqaoldwRoCNPTKADczRqSGovNJMduHWHKNnQrY+xLQ1yhpdvRKNmTfB4aca6jVYfwTkWetIYuVRPK4cRUytzM7PG40stXGT8Oa6c0MGij9NkHp70Y4miXZv510ZpwhgNmU3GCAtZZEwvdTWRllk66EzS1vTzP+9AM4H2N2OPX5C4awoEmfpfpw0SBb1LzQstRg+aiqE0EX9DzI7FLTPQJsEgFGUW8eo9zWWV1sAuALQSh1+XlHu88=
Content-Type: text/plain; charset="utf-8"
Content-ID: <71E6BE5FDA97BD4496CA7F83B6A4F9B3@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a910a44b-2234-4486-6156-08d70c5fcd43
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2019 15:43:10.3484 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: andrey.shinkevich@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2896
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe0a::703
Subject: Re: [Qemu-devel] [PATCH v4 7/7] block/nbd: NBDReply is used being
 uninitialized
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Denis Lunev <den@virtuozzo.com>, "mreitz@redhat.com" <mreitz@redhat.com>,
 =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDE5LzA3LzIwMTkgMTg6MTUsIEVyaWMgQmxha2Ugd3JvdGU6DQo+IE9uIDcvMTkvMTkg
MTA6MDAgQU0sIEFuZHJleSBTaGlua2V2aWNoIHdyb3RlOg0KPj4NCj4+DQo+PiBPbiAxOS8wNy8y
MDE5IDE3OjQ0LCBFcmljIEJsYWtlIHdyb3RlOg0KPj4+IE9uIDcvMTkvMTkgOTozNCBBTSwgRXJp
YyBCbGFrZSB3cm90ZToNCj4+Pj4gT24gNy8xOS8xOSA0OjQwIEFNLCBBbmRyZXkgU2hpbmtldmlj
aCB3cm90ZToNCj4+Pj4+IEluIGNhc2UgbmJkX2NvX3JlY2VpdmVfb25lX2NodW5rKCkgZmFpbHMg
aW4NCj4+Pj4+IG5iZF9yZXBseV9jaHVua19pdGVyX3JlY2VpdmUoKSwgJ05CRFJlcGx5IHJlcGx5
JyBwYXJhbWV0ZXIgaXMgdXNlZCBpbg0KPj4+Pj4gdGhlIGNoZWNrIG5iZF9yZXBseV9pc19zaW1w
bGUoKSB3aXRob3V0IGJlaW5nIGluaXRpYWxpemVkLiBUaGUgaW90ZXN0DQo+Pj4+PiAwODMgZG9l
cyBub3QgcGFzcyB1bmRlciB0aGUgVmFsZ3JpbmQ6ICQuL2NoZWNrIC1uYmQgLXZhbGdyaW5kIDA4
My4NCj4+Pj4+IFRoZSBhbHRlcm5hdGl2ZSBzb2x1dGlvbiBpcyB0byBzd2FwIHRoZSBvcGVyYW5k
cyBpbiB0aGUgY29uZGl0aW9uOg0KPj4+Pj4gJ2lmIChzLT5xdWl0IHx8IG5iZF9yZXBseV9pc19z
aW1wbGUocmVwbHkpKScNCj4+Pj4+DQo+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXkgU2hpbmtl
dmljaCA8YW5kcmV5LnNoaW5rZXZpY2hAdmlydHVvenpvLmNvbT4NCj4+Pj4+IC0tLQ0KPj4+Pj4g
ICAgYmxvY2svbmJkLmMgfCAyICstDQo+Pj4+PiAgICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKyksIDEgZGVsZXRpb24oLSkNCj4+Pj4NCj4+Pj4gSHVoLiBWZXJ5IHNpbWlsYXIgdG8NCj4+
Pj4gaHR0cHM6Ly9saXN0cy5nbnUub3JnL2FyY2hpdmUvaHRtbC9xZW11LWRldmVsLzIwMTktMDcv
bXNnMDM3MTIuaHRtbCwgYnV0DQo+Pj4+IGFmZmVjdHMgYSBkaWZmZXJlbnQgZnVuY3Rpb24uIEkg
Y2FuIHF1ZXVlIHRoaXMgb25lIHRocm91Z2ggbXkgTkJEIHRyZWUNCj4+Pj4gdG8gZ2V0IGJvdGgg
aW4gbXkgcmMyIHB1bGwgcmVxdWVzdC4NCj4+Pj4NCj4+Pj4gUmV2aWV3ZWQtYnk6IEVyaWMgQmxh
a2UgPGVibGFrZUByZWRoYXQuY29tPg0KPj4+DQo+Pj4gQWN0dWFsbHksIHNpbmNlIHRoaXMgaXMg
dGhlIHNlY29uZCBwYXRjaCBvbiB0aGUgc2FtZSB0b3BpYywgSSdtDQo+Pj4gd29uZGVyaW5nIGlm
IGl0J3MgYmV0dGVyIHRvIHVzZSB0aGUgZm9sbG93aW5nIG9uZS1saW5lciB0byBmaXggQk9USA0K
Pj4+IGlzc3VlcyBhbmQgd2l0aG91dCByZWx5aW5nIG9uIGEgZ2NjIGV4dGVuc2lvbjoNCj4+Pg0K
Pj4+IGRpZmYgLS1naXQgaS9ibG9jay9uYmQuYyB3L2Jsb2NrL25iZC5jDQo+Pj4gaW5kZXggOGQ1
NjVjYzYyNGVjLi5mNzUxYThlNjMzZTUgMTAwNjQ0DQo+Pj4gLS0tIGkvYmxvY2svbmJkLmMNCj4+
PiArKysgdy9ibG9jay9uYmQuYw0KPj4+IEBAIC02NDAsNiArNjQwLDcgQEAgc3RhdGljIGNvcm91
dGluZV9mbiBpbnQgbmJkX2NvX3JlY2VpdmVfb25lX2NodW5rKA0KPj4+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJlcXVlc3RfcmV0LCBxaW92LCBwYXlsb2Fk
LA0KPj4+IGVycnApOw0KPj4+DQo+Pj4gICAgICAgIGlmIChyZXQgPCAwKSB7DQo+Pj4gKyAgICAg
ICAgbWVtc2V0KHJlcGx5LCAwLCBzaXplb2YgKnJlcGx5KTsNCj4+DQo+PiBUaGUgY2FsbCB0byBt
ZW1zZXQoKSBjb25zdW1lcyBtb3JlIENQVSB0aW1lLiBJIGRvbid0IGtub3cgaG93IGZyZXF1ZW50
DQo+PiB0aGUgInJldCA8IDAiIHBhdGggaXMuIFRoZSBpbml0aWFsaXphdGlvbiAnID0gezB9JyBp
cyBjaGVhcGVyLg0KPiANCj4gV3JvbmcuICBUaGUgJ3JldCA8IDAnIHBhdGggb25seSBoYXBwZW5z
IG9uIGVycm9yLCB3aGlsZSB0aGUgJz0gezB9JyBwYXRoDQo+IGhhcHBlbnMgb24gQUxMIGNhc2Vz
IGluY2x1ZGluZyBzdWNjZXNzIChpZiB5b3UnbGwgbG9vayBhdCB0aGUgZ2VuZXJhdGVkDQo+IGFz
c2VtYmx5IGNvZGUsIGdjYyBzaG91bGQgZW1pdCB0aGUgc2FtZSBhc3NlbWJseSBzZXF1ZW5jZSBm
b3INCj4gemVyby1pbml0aWFsaXphdGlvbiBvZiB0aGUgc3RydWN0LCB3aGV0aGVyIHRoYXQgaXMg
YSBjYWxsIHRvIG1lbXNldCgpIG9yDQo+IGp1c3QgaW5saW5lIGFzc2lnbm1lbnRzIG9mIHplcm9z
IGJhc2VkIG9uIHRoZSBzbWFsbCBzaXplIG9mIHRoZSBzdHJ1Y3QsDQo+IHdoZXRoZXIgb3Igbm90
IHlvdXIgY29kZSB1c2VzIG1lbXNldCBvciAnPXt9JykuICBZb3UgZG9uJ3QgbmVlZCB0bw0KPiBv
cHRpbWl6ZSB0aGUgZXJyb3IgY2FzZSwgYmVjYXVzZSBvbiBlcnJvciwgeW91ciBOQkQgY29ubmVj
dGlvbiBpcyBkZWFkLA0KPiBhbmQgeW91IGhhdmUgd29yc2UgcHJvYmxlbXMuICBQcmUtaW5pdGlh
bGl6YXRpb24gdGhhdCBpcyBnb2luZyB0byBiZQ0KPiBvdmVyd3JpdHRlbiBvbiBzdWNjZXNzIGlz
IHdvcnNlIChhbHRob3VnaCBwcm9iYWJseSBpbW1lYXN1cmFibHksIGJlY2F1c2UNCj4gaXQgaXMg
bGlrZWx5IGluIHRoZSBub2lzZSkgdGhhbiBleGFjdGx5IG9uZSBpbml0aWFsaXphdGlvbiBvbiBh
bnkNCj4gY29udHJvbCBmbG93IHBhdGguDQo+IA0KPj4gSXMgaXQgc2FmZSB0byBzd2FwIHRoZSBv
cGVyYW5kcyBpbiB0aGUgY29uZGl0aW9uIGluDQo+PiBuYmRfcmVwbHlfY2h1bmtfaXRlcl9yZWNl
aXZlKCk6DQo+PiAnaWYgKHMtPnF1aXQgfHwgbmJkX3JlcGx5X2lzX3NpbXBsZShyZXBseSkpJyA/
DQo+IA0KPiBZZXMsIHN3YXBwaW5nIHRoZSBjb25kaXRpb25hbCBhcHBlYXJzIHRvIGZpeCB0aGUg
b25seSB1c2Ugb2YgcmVwbHkgd2hlcmUNCj4gaXQgaXMgdXNlZCB1bmluaXRpYWxpemVkLCBhdCBs
ZWFzdCBpbiB0aGUgY3VycmVudCBzdGF0ZSBvZiB0aGUgY29kZSAoYnV0DQo+IGl0IHRvb2sgbWUg
bG9uZ2VyIHRvIGF1ZGl0IHRoYXQpLiAgU28gaWYgd2UncmUgZ29pbmcgZm9yIGEgb25lLWxpbmUg
Zml4DQo+IGZvciBib3RoIG9ic2VydmF0aW9ucyBvZiB0aGUgcHJvYmxlbSwgY2hhbmdpbmcgdGhl
IGNvbmRpdGlvbmFsIGluc3RlYWQNCj4gb2YgYSBtZW1zZXQgb24gZXJyb3IgaXMgYWxzbyBhY2Nl
cHRhYmxlIGZvciBub3cgKGFuZCBtYXliZSBtYWtlcyB0aGUNCj4gZXJyb3IgY2FzZSBzbGlnaHRs
eSBmYXN0ZXIsIGJ1dCB0aGF0J3Mgbm90IGEgYmlnIGRlYWwsIGJlY2F1c2UgdGhlIGVycm9yDQo+
IGNhc2UgYWxyZWFkeSBtZWFucyB0aGUgTkJEIGNvbm5lY3Rpb24gaGFzIGJpZ2dlciBwcm9ibGVt
cykgLSBidXQgd2hvDQo+IGtub3dzIHdoYXQgZnV0dXJlIHVzZXMgb2YgcmVwbHkgbWlnaHQgY3Jl
ZXAgaW4gdG8gYW4gdW5zdXNwZWN0aW5nIHBhdGNoDQo+IHdyaXRlciB0aGF0IGRvZXNuJ3Qgc2Vl
IHRoZSAoaW4pYWN0aW9uIGF0IGEgZGlzdGFuY2U/ICBXaGljaCB3YXkgaXMgbW9yZQ0KPiBtYWlu
dGFpbmFibGUsIHByb3ZpbmcgdGhhdCB0aGUgbG93LWxldmVsIGNvZGUgYWx3YXlzIGluaXRpYWxp
emVzIHRoZQ0KPiB2YXJpYWJsZSAoZWFzeSwgc2luY2UgdGhhdCBjYW4gYmUgY2hlY2tlZCBhdCBh
IHNpbmdsZSBmdW5jdGlvbiksIG9yDQo+IHByb3ZpbmcgdGhhdCBhbGwgaGlnaC1sZXZlbCB1c2Vz
IG1heSBwYXNzIGluIGFuIHVuaW5pdGlhbGl6ZWQgdmFyaWFibGUNCj4gdGhhdCBpcyBzdGlsbCBs
ZWZ0IHVuaW5pdCBvbiBlcnJvciBidXQgdGhhdCB0aGV5IG9ubHkgdXNlIHRoZSB2YXJpYWJsZQ0K
PiBvbiBzdWNjZXNzIChoYXJkZXIsIHNpbmNlIG5vdyB5b3UgaGF2ZSB0byBhdWRpdCBldmVyeSBz
aW5nbGUgY2FsbGVyIHRvDQo+IHNlZSBob3cgdGhleSB1c2UgcmVwbHkgb24gZmFpbHVyZSk/DQo+
IA0KDQpTb3VuZHMgcmVhc29uYWJsZS4gQ2xlYXIgbm93LiBTbywgSSB3aWxsIGRldGFjaCB0aGlz
IHBhdGNoIGZyb20gdGhlIA0Kc2VyaWVzIGluIHRoZSBuZXh0IHY1IHZlcnNpb24uDQoNCkFuZHJl
eQ0KLS0gDQpXaXRoIHRoZSBiZXN0IHJlZ2FyZHMsDQpBbmRyZXkgU2hpbmtldmljaA0K

