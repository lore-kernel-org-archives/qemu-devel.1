Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38937C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 19:15:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E33DD21882
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 19:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="f0BSzGRh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E33DD21882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSnFG-0005Kr-Tb
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 14:15:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43025)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iSnDm-0004e8-3g
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 14:13:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iSnDk-0007ll-5y
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 14:13:30 -0500
Received: from mail-am5eur02on0717.outbound.protection.outlook.com
 ([2a01:111:f400:fe07::717]:36270
 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iSnDf-0007kF-2P; Thu, 07 Nov 2019 14:13:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i2mbbG1zRw3BUfrWHFnFozjenysGLQRoUuw5XUqi4Kq05rN9b/DNIk5uISh6Soq3FKmSe+qN/ZcyHG648eoSp6NDhBlI0T2T95oPdnASjwgv3Pdt39H9odWzHYmYMrq8lI+u9cPpK71I9F7vS9yem7IyeSehOCh1qRUJLlmV9jRevVvnV8TGXrUtSdL9IlI5WLucQ/pv651tdNo3dhyf4S2P8MaKK0K2MH3XEC+eVOlyfCudtq/wIighLkVTm/OHgYkseiS2lvtHBBF9wUc/9h98ogo4dAzeIjQ6u/0JFOeDAKrjAxN2wbV3acj8xrV57sH0RB88YPOMzXB1QVZF6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s0lUuupsOvO0PCUP5Qf9ROUxm8d1sQamQRm7TArV0Qs=;
 b=ii/83+FtvSAR7cV4OS8fLrpDO8c0/poSLolOwvM+dzL/ngqsSnMmgCsxP3YPKZDmLho8HLRQ0b9QU9S+1F3nNRm29EoInrkgcSpS/+1TETH3wo5i4URMjoqgYVEAQAvfkrO19TbC1m+9ciOKlSS07J/E+ONkfJjiavlkRualYNKqJLoXQV/c9FYUMbKrfT/12QEGhs0NVcgSSnt2M8BwF5ZLZH3ajp/4pIyZnrFmzXFrPy5ASdGwncLvHmW+t77ChzIg6XNNYYFElCAG3FYlBi4Ih4MfU+rdIAIOxlLz2BI5F6pj4ncdTOVybpWLNa8pldFPeE9kyl58bERcnqDjtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s0lUuupsOvO0PCUP5Qf9ROUxm8d1sQamQRm7TArV0Qs=;
 b=f0BSzGRh5BenwsMzs4htrUZCJWUZYchCFcsHL93x2vG0ywepJLXD2oxdu+JTWJiisA185isAGugDNtR47aSZqeNiRTWxJYE4iuo49joCpNyEHmt1+SDAkJcQIxzRjwp+CPTOQAaQuXsArTAiRKnhCDPfg9i/Ow2Q2fS8sSDZsOQ=
Received: from AM0PR08MB4097.eurprd08.prod.outlook.com (20.178.202.217) by
 AM0PR08MB4497.eurprd08.prod.outlook.com (20.179.35.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Thu, 7 Nov 2019 19:13:18 +0000
Received: from AM0PR08MB4097.eurprd08.prod.outlook.com
 ([fe80::41f0:981:fd75:9946]) by AM0PR08MB4097.eurprd08.prod.outlook.com
 ([fe80::41f0:981:fd75:9946%3]) with mapi id 15.20.2408.028; Thu, 7 Nov 2019
 19:13:18 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>, Markus
 Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, Gerd Hoffmann
 <kraxel@redhat.com>
Subject: Re: [Qemu-devel] Exposing feature deprecation to machine clients
Thread-Topic: [Qemu-devel] Exposing feature deprecation to machine clients
Thread-Index: AQHVlZx46m/O93jXSkmw21C0ajlBgaeAE5aA
Date: Thu, 7 Nov 2019 19:13:18 +0000
Message-ID: <e0448126-3371-fcf7-20ed-0d682dd8ca97@virtuozzo.com>
References: <20190814100735.24234-1-vsementsov@virtuozzo.com>
 <20190814100735.24234-3-vsementsov@virtuozzo.com>
 <3eded188-0161-d494-194c-9d67da644eb1@redhat.com>
 <8736i2zf8e.fsf_-_@dusky.pond.sub.org>
 <423f2f82-9111-9c19-85b6-2645f66ab641@redhat.com>
 <ee0c3bf0-cb5b-835c-3981-d6f2b8af86e1@redhat.com>
In-Reply-To: <ee0c3bf0-cb5b-835c-3981-d6f2b8af86e1@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0338.eurprd05.prod.outlook.com
 (2603:10a6:7:92::33) To AM0PR08MB4097.eurprd08.prod.outlook.com
 (2603:10a6:208:132::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191107221315301
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a2706cbf-eddb-4e05-7a86-08d763b68bf1
x-ms-traffictypediagnostic: AM0PR08MB4497:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB4497A5F701F04E8346842B8CC1780@AM0PR08MB4497.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0214EB3F68
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(346002)(376002)(366004)(39840400004)(136003)(189003)(199004)(2501003)(31696002)(86362001)(386003)(102836004)(478600001)(7736002)(54906003)(26005)(110136005)(11346002)(966005)(2616005)(6506007)(66946007)(14454004)(53546011)(229853002)(66476007)(476003)(486006)(25786009)(6246003)(6436002)(6486002)(36756003)(6306002)(66556008)(76176011)(316002)(446003)(99286004)(6512007)(52116002)(4326008)(186003)(7416002)(305945005)(66066001)(256004)(3846002)(71200400001)(66446008)(6116002)(14444005)(2906002)(31686004)(81166006)(64756008)(5660300002)(81156014)(71190400001)(8676002)(8936002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4497;
 H:AM0PR08MB4097.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cpmTL3FQbswoneE9++vpfc9QeVhOmflvaI4kRqUllnw0Q4YtVTGCMaLfxVSAYh3OvLOus9FCUIsmx2kN/hkwcTwMZKqriD3df5u7pfZjYSPYXkawFyKvpiKwshijOT99nemEzugEG0xWEsGAViezJ0HbsOUj3iV8HFwgb5NK0Ag4VSt3iCZ1KM8rHfFMtSrlyJ0czGHzIWUpzX5ybW4VaJaffjZiz7YPP7wGNssOWbQNuAzJjDkaXN/6bdicAZPgE6o5frOFApzaVehmnCa0IgZ/ZHEZQBZQ5rXDO3ghCaO9HtjpoOOjEOrTmyVkXNvRQxM0eYwmDnbZMJKg31nDky1thXXSKc20reatdCRHlSmSnk0FcHLXHcJ47rurR8BPmaHumpzR1z1oMDINPeT38Qfoi4HNOAmmaDt1SHPkJe7Dm3aN2AyNIiWQ7yLd2roa9jZE7yQz9BdUO4AnNHpmyb5bpYZESO5a1c06RJqjuxw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C51A39C725B61F47BAF7D7D49FBCFD23@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2706cbf-eddb-4e05-7a86-08d763b68bf1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2019 19:13:18.4327 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o4B8Kp0N+lEo48NFMCY1rPThLFStmKbzCFOFQHCNpWoRwTov5D6ZaMKbm7sTm0Hfo8hIH0ojmXF9cthgiMXmHgfizeTKlU+Y664i01XrSx8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4497
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe07::717
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "libvir-list@redhat.com" <libvir-list@redhat.com>, "Dr.
 David Alan Gilbert" <dgilbert@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDcuMTEuMjAxOSAyMTo1MiwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IEhpIE1h
cmt1cywNCj4gDQo+IE9uIDgvMTUvMTkgNzo0MCBQTSwgSm9obiBTbm93IHdyb3RlOg0KPj4gT24g
OC8xNS8xOSAxMDoxNiBBTSwgTWFya3VzIEFybWJydXN0ZXIgd3JvdGU6DQo+Pj4gSm9obiBTbm93
IDxqc25vd0ByZWRoYXQuY29tPiB3cml0ZXM6DQo+IFsuLi5dDQo+Pj4+IEkgYXNrZWQgTWFya3Vz
IHRoaXMgbm90IHRvbyBsb25nIGFnbzsgZG8gd2Ugd2FudCB0byBhbWVuZCB0aGUgUUFQSQ0KPj4+
PiBzY2hlbWEgc3BlY2lmaWNhdGlvbiB0byBhbGxvdyBjb21tYW5kcyB0byByZXR1cm4gd2l0aCAi
V2FybmluZyIgc3RyaW5ncywNCj4+Pj4gb3IgIkRlcHJlY2F0ZWQiIHN0aW5ncyB0byBhbGxvdyBp
bi1iYW5kIGRlcHJlY2F0aW9uIG5vdGljZXMgZm9yIGNhc2VzDQo+Pj4+IGxpa2UgdGhlc2U/DQo+
Pj4+DQo+Pj4+IGV4YW1wbGU6DQo+Pj4+DQo+Pj4+IHsgInJldHVybiI6IHt9LA0KPj4+PiDCoMKg
ICJkZXByZWNhdGVkIjogVHJ1ZSwNCj4+Pj4gwqDCoCAid2FybmluZyI6ICJPbWl0dGluZyBmaWx0
ZXItbm9kZS1uYW1lIHBhcmFtZXRlciBpcyBkZXByZWNhdGVkLCBpdCB3aWxsDQo+Pj4+IGJlIHJl
cXVpcmVkIGluIHRoZSBmdXR1cmUiDQo+Pj4+IH0NCj4+Pj4NCj4+Pj4gVGhlcmUncyBubyAiZXJy
b3IiIGtleSwgc28gdGhpcyBzaG91bGQgYmUgcmVjb2duaXplZCBhcyBzdWNjZXNzIGJ5DQo+Pj4+
IGNvbXBhdGlibGUgY2xpZW50cywgYnV0IHRoZXknbGwgZGVmaW5pdGVseSBzZWUgdGhlIGV4dHJh
IGluZm9ybWF0aW9uLg0KPj4+DQo+Pj4gVGhpcyBpcyBhIGNvbXBhdGlibGUgZXZvbHV0aW9uIG9m
IHRoZSBRTVAgcHJvdG9jb2wuDQo+Pj4NCj4+Pj4gUGFydCBvZiBteSBtb3RpdmF0aW9uIGlzIHRv
IGZhY2lsaXRhdGUgYSBtb3JlIGFnZ3Jlc3NpdmUgZGVwcmVjYXRpb24gb2YNCj4+Pj4gbGVnYWN5
IGZlYXR1cmVzIGJ5IGVuc3VyaW5nIHRoYXQgd2UgYXJlIGFibGUgdG8gcmlnb3JvdXNseSBub3Rp
ZnkgdXNlcnMNCj4+Pj4gdGhyb3VnaCBhbnkgbWVhbnMgdGhhdCB0aGV5IG5lZWQgdG8gYWRqdXN0
IHRoZWlyIHNjcmlwdHMuDQo+Pj4NCj4+PiBZZXMsIHdlIHNob3VsZCBoZWxwIGxpYnZpcnQgZXRj
LiB3aXRoIGRldGVjdGluZyB1c2Ugb2YgZGVwcmVjYXRlZA0KPj4+IGZlYXR1cmVzLsKgIFdlIGRp
c2N1c3NlZCB0aGlzIGF0IHRoZSBLVk0gRm9ydW0gMjAxOCBCb0Ygb24gZGVwcmVjYXRpbmcNCj4+
PiBzdHVmZi7CoCBNaW51dGVzOg0KPj4+DQo+Pj4gwqDCoMKgwqAgTWVzc2FnZS1JRDogPDg3bXVy
MGxzOG8uZnNmQGR1c2t5LnBvbmQuc3ViLm9yZz4NCj4+PiDCoMKgwqDCoCBodHRwczovL2xpc3Rz
Lm5vbmdudS5vcmcvYXJjaGl2ZS9odG1sL3FlbXUtZGV2ZWwvMjAxOC0xMC9tc2cwNTgyOC5odG1s
DQo+Pj4NCj4+PiBMYXN0IGl0ZW0gaXMgcmVsZXZhbnQgaGVyZS4NCj4+Pg0KPj4+IEFkZGluZyBk
ZXByZWNhdGlvbiBpbmZvcm1hdGlvbiB0byBRTVAncyBzdWNjZXNzIHJlc3BvbnNlIGJlbG9uZ3Mg
dG8gIldlDQo+Pj4gY2FuIGFsc28gcGFzcyB0aGUgYnVjayB0byB0aGUgbmV4dCBsYXllciB1cCIs
IG5leHQgdG8gImVtaXQgYSBRTVANCj4+PiBldmVudCIuDQo+Pj4NCj4+PiBMZXQncyBjb21wYXJl
IHRoZSB0d28sIGkuZS4gImRlcHJlY2F0aW9uIGluZm8gaW4gc3VjY2VzcyByZXNwb25zZSINCj4+
PiB2cy4gImRlcHJlY2F0aW9uIGV2ZW50Ii4NCj4+Pg0KPj4+IDEuIFBvc3NpYmxlIHRyaWdnZXJz
DQo+Pj4NCj4+PiBBbnl0aGluZyB3ZSBwdXQgaW4gdGhlIHN1Y2Nlc3MgcmVzcG9uc2Ugc2hvdWxk
IG9ubHkgZXZlciBhcHBseSB0byB0aGUNCj4+PiAoc3VjY2Vzc2Z1bCkgY29tbWFuZC7CoCBTbyB0
aGlzIG9uZSdzIGxpbWl0ZWQgdG8gUU1QIGNvbW1hbmRzLg0KPj4+DQo+Pj4gQSBRTVAgZXZlbnQg
aXMgbm90IGxpbWl0ZWQgdG8gUU1QIGNvbW1hbmRzLsKgIEZvciBpbnN0YW5jZSwgaXQgY291bGQg
YmUNCj4+PiBlbWl0dGVkIGZvciBkZXByZWNhdGVkIENMSSBmZWF0dXJlcyAobG9uZyBhZnRlciB0
aGUgZmFjdCwgaW4gYWRkaXRpb24gdG8NCj4+PiBodW1hbi1yZWFkYWJsZSB3YXJuaW5ncyBvbiBz
dGRlcnIpLCBvciB3aGVuIHdlIGRldGVjdCB1c2Ugb2YgYQ0KPj4+IGRlcHJlY2F0ZWQgZmVhdHVy
ZSBvbmx5IGFmdGVyIHdlIHNlbnQgdGhlIHN1Y2Nlc3MgcmVzcG9uc2UsIHNheSBpbiBhDQo+Pj4g
am9iLsKgIE5laXRoZXIgdXNlIGNhc2UgaXMgcGFydGljdWxhcmx5IGNvbnZpbmNpbmcuwqAgUmVw
b3J0aW5nIHVzZSBvZg0KPj4+IGRlcHJlY2F0ZWQgQ0xJIGluIFFNUCBmZWVscyBsaWtlIGEgd29y
ay1hcm91bmQgZm9yIHRoZSBDTEkncw0KPj4+IG1hY2hpbmUtdW5mcmllbmRsaW5lc3MuwqAgSm9i
LWxpa2UgY29tbWFuZHMgc2hvdWxkIHJlYWxseSBjaGVjayB0aGVpcg0KPj4+IGFyZ3VtZW50cyB1
cGZyb250Lg0KPj4+DQo+Pj4gMi4gQ29ubmVjdGlvbiB0byB0cmlnZ2VyDQo+Pj4NCj4+PiBDb25u
ZWN0aW5nIHJlc3BvbnNlcyB0byBjb21tYW5kcyBpcyB0aGUgUU1QIHByb3RvY29sJ3MgcmVzcG9u
c2liaWxpdHkuDQo+Pj4gVHJhbnNtaXR0aW5nIGRlcHJlY2F0aW9uIGluZm9ybWF0aW9uIGluIHRo
ZSByZXNwb25zZSB0cml2aWFsbHkgdGllcyBpdA0KPj4+IHRvIHRoZSBvZmZlbmRpbmcgY29tbWFu
ZC4NCj4+Pg0KPj4+IFRoZSBRTVAgcHJvdG9jb2wgZG9lc24ndCB0aWUgZXZlbnRzIHRvIGFueXRo
aW5nLsKgIFRodXMsIGEgZGVwcmVjYXRpb24NCj4+PiBldmVudCBuZWVkcyBhbiBldmVudC1zcGVj
aWZpYyB0aWUgdG8gaXRzIHRyaWdnZXIuDQo+Pj4NCj4+PiBUaGUgb2J2aW91cyB3YXkgdG8gdGll
IGl0IHRvIGEgY29tbWFuZCBtaXJyb3JzIGhvdyB0aGUgUU1QIHByb3RvY29sIHRpZXMNCj4+PiBy
ZXNwb25zZXMgdG8gY29tbWFuZHM6IGJ5IGNvbW1hbmQgSUQuwqAgVGhlIGV2ZW50IGVpdGhlciBo
YXMgdG8gYmUgc2VudA0KPj4+IGp1c3QgdG8gdGhlIG9mZmVuZGluZyBtb25pdG9yIChjdXJyZW50
bHksIGFsbCBldmVudHMgYXJlIGJyb2FkY2FzdCB0bw0KPj4+IGFsbCBtb25pdG9ycyksIG9yIGlu
Y2x1ZGUgYSBzdWl0YWJsZSBtb25pdG9yIElELg0KPj4+DQo+Pj4gRm9yIG5vbi1jb21tYW5kIHRy
aWdnZXJzLCB3ZSdkIGhhdmUgdG8gaW52ZW50IHNvbWUgb3RoZXIgdGllLg0KPj4+DQo+Pj4gMy4g
SW50ZXJmYWNlIGNvbXBsZXhpdHkNCj4+Pg0KPj4+IFR5aW5nIHRoZSBldmVudCB0byBzb21lIGFy
Yml0cmFyeSB0cmlnZ2VyIGFkZHMgY29tcGxleGl0eS4NCj4+Pg0KPj4+IERvIHdlIG5lZWQgbm9u
LWNvbW1hbmQgdHJpZ2dlcnMsIGFuZCBiYWRseSBlbm91Z2ggdG8ganVzdGlmeSB0aGUNCj4+PiBh
ZGRpdGlvbmFsIGNvbXBsZXhpdHk/DQo+Pj4NCj4+PiA0LiBJbXBsZW1lbnRhdGlvbiBjb21wbGV4
aXR5DQo+Pj4NCj4+PiBFbWl0dGluZyBhbiBldmVudCBjb3VsZCBiZSBhcyBzaW1wbGUgYXMNCj4+
Pg0KPj4+IMKgwqDCoMKgIHFhcGlfZXZlbnRfc2VuZF9kZXByZWNhdGVkKHFtcF9jb21tYW5kX2lk
KCksDQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgIk9taXR0aW5nICdmaWx0ZXItbm9kZS1uYW1lJyIpOw0KPj4+DQo+Pj4g
d2hlcmUgcW1wX2NvbW1hbmRfaWQoKSByZXR1cm5zIHRoZSBJRCBvZiB0aGUgY3VycmVudGx5IGV4
ZWN1dGluZw0KPj4+IGNvbW1hbmQuwqAgTWFraW5nIHFtcF9jb21tYW5kX2lkKCkgd29yayBpcyB1
cCB0byB0aGUgUU1QIGNvcmUuwqAgU2ltcGxlDQo+Pj4gZW5vdWdoIGFzIGxvbmcgYXMgZWFjaCBR
TVAgY29tbWFuZCBydW5zIHRvIGNvbXBsZXRpb24gYmVmb3JlIGl0cyBtb25pdG9yDQo+Pj4gc3Rh
cnRzIHRoZSBuZXh0IG9uZS4NCj4+Pg0KPj4+IFRoZSBldmVudCBpcyAiZmlyZSBhbmQgZm9yZ2V0
Ii7CoCBUaGVyZSBpcyBubyB3YXJuaW5nIG9iamVjdCBwcm9wYWdhdGVkDQo+Pj4gdXAgdGhlIGNh
bGwgY2hhaW4gaW50byB0aGUgUU1QIGNvcmUgbGlrZSBlcnJvcnMgb2JqZWN0cyBhcmUuDQo+Pj4N
Cj4+PiAiRmlyZSBhbmQgZm9yZ2V0IiBpcyBpZGVhbCBmb3IgbGV0dGluZyBhcmJpdHJhcnkgY29k
ZSBkZWNpZGUgInRoaXMgaXMNCj4+PiBkZXByZWNhdGVkIi4NCj4+Pg0KPj4+IE5vdGUgdGhlIFFB
UEkgc2NoZW1hIHJlbWFpbnMgdW50b3VjaGVkLg0KPj4+DQo+Pj4gVW5saWtlIGFuIGV2ZW50LCB3
aGljaCBjYW4gYmUgZW1pdHRlZCBhbnl3aGVyZSwgdGhlIHN1Y2Nlc3MgcmVzcG9uc2UNCj4+PiBn
ZXRzIGJ1aWx0IGluIHRoZSBRTVAgY29yZS7CoCBUbyBoYXZlIHRoZSBjb3JlIGFkZCBkZXByZWNh
dGlvbiBpbmZvIHRvDQo+Pj4gaXQsIHdlIG5lZWQgdG8gZ2V0IHRoZSBpbmZvIHRvIHRoZSBjb3Jl
Lg0KPj4+DQo+Pj4gSWYgZGVwcmVjYXRpb24gaW5mbyBvcmlnaW5hdGVzIGluIGNvbW1hbmQgY29k
ZSwgbGlrZSBlcnJvcnMgZG8sIHdlIG5lZWQNCj4+PiB0byBwcm9wYWdhdGUgaXQgdXAgdGhlIGNh
bGwgY2hhaW4gaW50byB0aGUgUU1QIGNvcmUgbGlrZSBlcnJvcnMuDQo+Pj4NCj4+PiBQcm9wYWdh
dGluZyBlcnJvcnMgaXMgcGFpbmZ1bC7CoCBJdCBoYXMgY2F1c2VkIG1hc3NpdmUgY2h1cm4gYWxs
IG92ZXIgdGhlDQo+Pj4gcGxhY2UuDQo+Pj4NCj4+PiBJIGRvbid0IHRoaW5rIHdlIGNhbiBoaXRj
aCBkZXByZWNhdGlvbiBpbmZvIHRvIHRoZSBleGlzdGluZyBlcnJvcg0KPj4+IHByb3BhZ2F0aW9u
LCBzaW5jZSB3ZSBuZWVkIHRvIHRha2UgdGhlIHN1Y2Nlc3MgcGF0aCBiYWNrIHRvIHRoZSBRTVAN
Cj4+PiBjb3JlLCBub3QgYW4gZXJyb3IgcGF0aC4NCj4+Pg0KPj4+IFByb3BhZ2F0aW5nIGEgc2Vj
b25kIG9iamVjdCBmb3Igd2FybmluZ3MuLi4gdGhhbmtzLCBidXQgbm8gdGhhbmtzLg0KPj4+DQo+
Pg0KPj4gUHJvYmFibHkgdGhlIGJlc3QgYXJndW1lbnQgYWdhaW5zdCBpdC4gRmlyZS1hbmQtZm9y
Z2V0IGF2b2lkcyB0aGUNCj4+IHByb2JsZW0uIEV2ZW50cyBtaWdodCB3b3JrIGp1c3QgZmluZSwg
YnV0IHRoZSAidGllIiBiaXQgc2VlbXMgbGlrZSBhIHlhaw0KPj4gaW4gbmVlZCBvZiBhIHNoYXZl
Lg0KPj4NCj4+PiBUaGUgUU1QIGNvcmUgY291bGQgcHJvdmlkZSBhIGZ1bmN0aW9uIGZvciByZWNv
cmRpbmcgZGVwcmVjYXRpb24gaW5mbyBmb3INCj4+PiB0aGUgY3VycmVudGx5IGV4ZWN1dGluZyBR
TVAgY29tbWFuZC7CoCBUaGlzIGlzIGhvdyB3ZSB1c2VkIHRvIHJlY29yZA0KPj4+IGVycm9ycyBp
biBRTVAgY29tbWFuZHMsIHVudGlsIEFudGhvbnkgcmFtbWVkIHRocm91Z2ggd2hhdCB3ZSBoYXZl
IG5vdy4NCj4+PiBUaGUgY29tbWl0IG1lc3NhZ2VzIChlLmcuIGQ1ZWM0ZjI3YzM4KSBwcm92aWRl
IG5vIGp1c3RpZmljYXRpb24uwqAgSQ0KPj4+IGRpbWx5IHJlY2FsbCBhZGFtYW50IChvcmFsPykg
Y2xhaW1zIHRoYXQgcmVjb3JkaW5nIGVycm9ycyBpbiB0aGUgTW9uaXRvcg0KPj4+IG9iamVjdCBj
YW5ub3Qgd29yayBmb3IgdXMuDQo+Pj4NCj4+PiBJIHNtZWxsIGEgc3dhbXAuDQo+Pj4NCj4+PiBD
YW4gd2UgYXZvaWQgcGx1bWJpbmcgZGVwcmVjYXRpb24gaW5mbyBmcm9tIGNvbW1hbmQgY29kZSB0
byBRTVAgY29yZT8NCj4+PiBPbmx5IGlmIHRoZSBRTVAgY29yZSBpdHNlbGYgY2FuIHJlY29nbml6
ZSBkZXByZWNhdGVkIGludGVyZmFjZXMuwqAgSQ0KPj4+IGJlbGlldmUgaXQgY2FuIGZvciB0aGUg
Y2FzZXMgd2UgY2FuIGV4cG9zZSBpbiBpbnRyb3NwZWNpb24uwqAgTGV0IG1lDQo+Pj4gZXhwbGFp
bi4NCj4+Pg0KPj4+IEtldmluIHJlY2VudGx5IGFkZGVkICJmZWF0dXJlcyIgdG8gdGhlIFFBUEkg
c2NoZW1hIGxhbmd1YWdlLsKgIFRoZQ0KPj4+IGltcGxlbWVudGF0aW9uIGlzIGluY29tcGxldGUs
IGJ1dCB0aGF0J3MgZGV0YWlsLsKgIFRoZSBpZGVhIGlzIHRvIHRhY2sgYQ0KPj4+ICJkZXByZWNh
dGVkIiBmZWF0dXJlIHRvIGRlcHJlY2F0ZWQgc3R1ZmYgaW4gdGhlIFFBUEkgc2NoZW1hLg0KPj4+
DQo+Pg0KPj4gVGhhdCdzIGEgZ29vZCBpZGVhIHRvbzsgYnV0IHRoZSBzZW1hbnRpY3Mgb2YgZXhh
Y3RseSAqd2hhdCogd2FzDQo+PiBkZXByZWNhdGVkIG1heSBiZSBoYXJkIHRvIGNhcHR1cmUuDQo+
Pg0KPj4+IENvbW1hbmRzIGFuZCBhcmd1bWVudHMgbmVlZCB0byBzdXBwb3J0IGZlYXR1cmVzIGZv
ciB0aGF0Lg0KPj4+IEltcGxlbWVudGF0aW9uIHNob3VsZCBiZSByZWxhdGl2ZWx5IHN0cmFpZ2h0
Zm9yd2FyZC4NCj4+Pg0KPj4+IERlcHJlY2F0aW5nIGFuIGFyZ3VtZW50J3Mgb3B0aW9uYWxuZXNz
IG1heSByZXF1aXJlIGENCj4+PiAib3B0aW9uYWwtZGVwcmVjYXRlZCIgZmVhdHVyZS7CoCBJJ3Zl
IHNlZW4gbW9yZSBlbGVnYW50IGRlc2lnbnMsIGJ1dCBJJ3ZlDQo+Pj4gYWxzbyBzZWVuIHBsZW50
eSBvZiB1Z2xpZXIgb25lcy4NCj4+Pg0KPj4+IE5vdGUgdGhhdCBmZWF0dXJlcyBhcmUgdGllZCB0
byBzY2hlbWEgc3ludGF4LsKgIFRvIGV4cHJlc3Mgc2VtYW50aWNhbGx5DQo+Pj4gY29uZGl0aW9u
YWwgZGVwcmVjYXRpb24gbGlrZSAiaWYgeW91IHNwZWNpZnkgYXJndW1lbnQgRk9PLCB0aGVuIG5v
dA0KPj4+IHNwZWNpZnlpbmcgYXJndW1lbnQgQkFSIGlzIGRlcHJlY2F0ZWQiLCB3ZSdkIGhhdmUg
dG8gYWRkIGEgbGFuZ3VhZ2UgZm9yDQo+Pj4gdGhlc2UgY29uZGl0aW9ucy7CoCBVaCwgbm90IG5v
dywgbWF5YmUgbmV2ZXIuDQo+Pj4NCj4+PiBUaGUgcHJpbWFyeSB1c2Ugb2YgaGF2aW5nIGRlcHJl
Y2F0aW9uIGRlZmluZWQgaW4gdGhlIFFBUEkgc2NoZW1hIGlzDQo+Pj4gaW50cm9zcGVjdGlvbi7C
oCBUaGUgQm9GIG1pbnV0ZXMgbWVudGlvbiB0aGlzLCB0b28uDQo+Pj4NCj4+PiBBIHNlY29uZGFy
eSB1c2UgY291bGQgYmUgZGV0ZWN0aW5nIHVzZSBvZiBkZXByZWNhdGVkIGZlYXR1cmVzIHJpZ2h0
IGluDQo+Pj4gdGhlIFFNUCBjb3JlLsKgIE5vIG5lZWQgZm9yIGFkIGhvYyBjb2RlIGluIGNvbW1h
bmRzLCBubyBuZWVkIGZvciBwbHVtYmluZw0KPj4+IGluZm9ybWF0aW9uIGZyb20gdGhlcmUgdG8g
dGhlIFFNUCBjb3JlLg0KPj4+DQo+Pj4gSSdkIGxpa2UgdG8gcHVyc3VlIHRoaXMgaWRlYSwgdGhl
biBzZWUgaG93IHdlbGwgaXQgc3VpdHMgb3VyIGRlcHJlY2F0aW9uDQo+Pj4gbmVlZHMuDQo+Pj4N
Cj4+DQo+PiBJIHNob3VsZCBjbGVhcmx5IHJlbWVtYmVyIHRvIHRhbGsgdG8geW91IGJlZm9yZSB0
aGlua2luZyBhYm91dCBRTVAgaW4NCj4+IHB1YmxpYywgYmVjYXVzZSB5b3UndmUgdGhvdWdodCBh
Ym91dCBpdCBtdWNoIG1vcmUuDQo+IA0KPiBQcmUtcmVsZWFzZSBwZXJpb2QsIHRpbWUgdG8gZGVw
cmVjYXRlIHNvbWUgc3R1ZmZzIDopDQo+IA0KPiBIb3cgc2hvdWxkIHdlIHByb2NlZWQ/IERvIHlv
dSBoYXZlIHNvbWV0aGluZyBpbiBtaW5kPw0KPiANCj4gVGhlcmUgYXJlIG9sZGVyIHRocmVhZHMg
YWJvdXQgdGhpcy4gU2hvdWxkIHdlIHN0YXJ0IGEgbmV3IHRocmVhZD8gR2F0aGVyIHRoZSBkaWZm
ZXJlbnQgaWRlYXMgb24gdGhlIFdpa2k/DQo+IA0KPiAoT2J2aW91c2x5IHlvdSBhcmUgbm90IHRo
ZSBvbmUgcmVzcG9uc2libGUgb2YgdGhpcyB0b3BpYywgeW91IGp1c3QgaGFwcGVuIHRvIGJlIHRo
ZSBsYXN0IG9uZSB3b3JyaWVkIGFib3V0IGl0IG9uIHRoZSBsaXN0KS4NCj4gDQo+IFJlZ2FyZHMs
DQo+IA0KPiBQaGlsLg0KDQpIaSENCg0KSSB3YW50ZWQgdG8gcmVzZW5kLCBidXQgZmFjZWQgc29t
ZSBwcm9ibGVtcywgYW5kIHVuZGVyc3RhbmQgdGhhdCBJIGNhbid0IGRvIGl0IGluIHRpbWUgYmVm
b3JlIHNvZnQtZnJlZXplLi4NCkJ1dCB5b3Ugc2F5LCB0aGF0IHdlIGNhbiBkZXByZWNhdGUgc29t
ZXRoaW5nIGV2ZW4gYWZ0ZXIgaGFyZC1mcmVlemU/DQoNCk9rLCB0aGUgcHJvYmxlbSB0aGF0IEkg
ZmFjZWQsIGlzIHRoYXQgZGVwcmVjYXRpb24gd2FybmluZ3MgYnJlYWtzIHNvbWUgaW90ZXN0cy4u
IFdoYXQgY2FuIHdlIGRvPw0KDQoxLiBVcGRhdGUgaW90ZXN0cy4uLg0KICAgMS4xIEp1c3QgdXBk
YXRlIGlvdGVzdHMgb3V0cHV0cyB0byBzaG93IHdhcm5pbmdzLiBUaGVuLCBpbiBuZXh0IHJlbGVh
c2UgY3ljbGUsIHVwZGF0ZSBpb3Rlc3RzLCB0byBub3QgdXNlIGRlcHJlY2F0ZWQgdGhpbmdzDQog
ICBvcg0KICAgMS4yIFVwZGF0ZSBpb3Rlc3RzIHRvIG5vdCB1c2UgZGVwcmVjYXRlZCB0aGluZ3Mu
LiBOb3QgYXBwcm9wcmlhdGUgZm9yIGhhcmQgZnJlZXplLg0Kb3INCjIuIENvbW1pdCBkZXByZWNh
dGlvbnMgd2l0aG91dCB3YXJuaW5ncy4uIEJ1dCBob3cgZG8gcGVvcGxlIGZpbmQgb3V0IGFib3V0
IHRoaXM/DQoNCk5leHQsIHdoYXQgZXhhY3RseSB0byBkZXByZWNhdGU/IEFzIEkgdW5kZXJzdGFu
ZCwgd2UgY2FuJ3QgZGVwcmVjYXRlIGRyaXZlLW1pcnJvciBub3c/DQpTbyBJIHByb3Bvc2UgdG86
DQoNCjEuIGRlcHJlY2F0ZSBkcml2ZS1iYWNrdXANCjIuIGFkZCBvcHRpb25hbCBmaWx0ZXItbm9k
ZS1uYW1lIHBhcmFtZXRlciB0byBkcml2ZS1taXJyb3IsIHRvIGNvcnJlc3BvbmQgdG8gY29tbWl0
IGFuZCBtaXJyb3INCjMuIGRlcHJlY2F0ZSB0aGF0IGZpbHRlci1ub2RlLW5hbWUgaXMgb3B0aW9u
YWwgZm9yIGNvbW1pdCBhbmQgbWlycm9yLg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWly
DQo=

