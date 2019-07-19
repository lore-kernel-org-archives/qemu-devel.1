Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9872DC76197
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 13:00:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63FC92173B
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 13:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="PhwF4qMd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63FC92173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=openvz.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoSV1-00015x-MD
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 09:00:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57269)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <den@virtuozzo.com>) id 1hoSUo-0000gd-6u
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 09:00:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <den@virtuozzo.com>) id 1hoSUn-0006jj-1h
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 09:00:22 -0400
Received: from mail-eopbgr130113.outbound.protection.outlook.com
 ([40.107.13.113]:53166 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <den@virtuozzo.com>) id 1hoSUm-0006i7-Ek
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 09:00:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kS8YSZa2BE2AyKXQhku3B0oxU58DJn4cMecY2lxSQci3tUyDXrl5LakLOwqvPcBywaIlz7THpRkFK5K07hTCCil/8GjpiPQ0rMxznozO8SFnUQGOSs7iDWVmSh/cKwHkUeyp2ro7l6k7nZYKs838hAv9KoOvj7sIM6TH4jph3jhdNOj5WavjJ+r0JzNkiqIiTDCJL5TGpSsPvfaDpGifEN0rp1tMwf5E+UKNC8nqBme9OMQX8IpUU6+r/k7D7g4bitxQSN7/+lf8P9PD41QecmRTQ7DEfdCuqHQwvSdY4zs3Yv7CN/X2Ih/jvnLcLP1RMt2CbjDGKtbavIgm8kutug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sRvMtFzhGA96FZgM072+mreZU5VBRflUNnwYIKydIPc=;
 b=caMBF3MYVZgR7KBhXkV+T1O3Lzf/YBXFeSKQFT/nkk03A7IiUKnFw99ZeHvJ2+bkDlR2ByOn9/eKDVkgJp/haEZkTxg1nIakF97ckDTHW7708f8ar58papX5rX11Eu8JKdK+eJYiFgp3jgOeTPnlAPlAmu14sLfZ+zpcjNykeZsALUvlneFN8TDyJZuwmXcGw1WpZvz2O3ggkqZ9y32fp+UUX/kE48cw1w7G85ol7EnQbzhHrjZ16EDKUMZ5nCHDS60F9jKJd9iLEsYUamnIRkhD5I4+WnHVVf0aYszzb0+D0CQqKEaCZFrXOGNNdgFcJsGbsDHm2GYOXfdceLj45g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=virtuozzo.com;dmarc=pass action=none
 header.from=openvz.org;dkim=pass header.d=openvz.org;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sRvMtFzhGA96FZgM072+mreZU5VBRflUNnwYIKydIPc=;
 b=PhwF4qMdTtWl22xpfKZKrBttt29BqqLrJjFUFb3Pfnnyd8L0jeeezjipYba6AXYzGdAuXciZ/aib3hqyRMSyHcX8AGW5NKZc9vMIQnDOvSo/ZNBPV25T4EtXNahbQlTsH7gxOgQ5HdUbGyFZLy/81vnoNtpQysjVw96wCbQzeN0=
Received: from DBBPR08MB4250.eurprd08.prod.outlook.com (20.179.40.149) by
 DBBPR08MB4250.eurprd08.prod.outlook.com (20.179.40.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.12; Fri, 19 Jul 2019 13:00:16 +0000
Received: from DBBPR08MB4250.eurprd08.prod.outlook.com
 ([fe80::c1aa:9c2d:d6b8:b0d]) by DBBPR08MB4250.eurprd08.prod.outlook.com
 ([fe80::c1aa:9c2d:d6b8:b0d%7]) with mapi id 15.20.2094.013; Fri, 19 Jul 2019
 13:00:16 +0000
From: "Denis V. Lunev" <den@openvz.org>
To: Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Thread-Topic: [PATCH 1/1] x86: add CPU flags supported inside libvirt
Thread-Index: AQHVPW8iLcODjwN9YUWDgQNVKGFnYabQZRSAgAGD2AA=
Date: Fri, 19 Jul 2019 13:00:16 +0000
Message-ID: <4ea5c1cd-f662-64df-d42d-52e38d7087a6@openvz.org>
References: <20190718134537.22356-1-den@openvz.org>
 <4620eddd-e500-25d2-a8b2-5c47eefc74ab@redhat.com>
In-Reply-To: <4620eddd-e500-25d2-a8b2-5c47eefc74ab@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0239.eurprd05.prod.outlook.com
 (2603:10a6:3:fb::15) To DBBPR08MB4250.eurprd08.prod.outlook.com
 (2603:10a6:10:c2::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=den@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 540855b8-7c74-4209-28cd-08d70c490b39
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DBBPR08MB4250; 
x-ms-traffictypediagnostic: DBBPR08MB4250:
x-microsoft-antispam-prvs: <DBBPR08MB4250A77ED147A7902B0412D7B6CB0@DBBPR08MB4250.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01039C93E4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(366004)(396003)(39850400004)(136003)(376002)(189003)(199004)(6246003)(52116002)(53546011)(6506007)(186003)(386003)(102836004)(26005)(68736007)(229853002)(76176011)(8936002)(31686004)(3846002)(6116002)(6512007)(2906002)(316002)(31696002)(42882007)(99286004)(476003)(2616005)(11346002)(53936002)(6436002)(6486002)(110136005)(446003)(54906003)(81166006)(25786009)(2501003)(478600001)(14454004)(8676002)(4326008)(36756003)(5660300002)(66446008)(64756008)(66476007)(66556008)(66946007)(256004)(486006)(7736002)(66066001)(71200400001)(71190400001)(81156014)(305945005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DBBPR08MB4250;
 H:DBBPR08MB4250.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xN+lJEunHQrpX7uGmc+tRUy4kFrqEHx6nJmLE4ypK9gjLWJdNtPkpawy/MFHbwy/OGyMIK8Bp5qzbdc1aEWoFZAERrHGtlp2G/l/V/OJmIIGApqPhVxod43TcLRo5xbhBuE1iZdFmOooteCPe9OFRGwrmAA+JIpKVamNGIwnwL5jWhUPsoeIQl0TLlz3IRndt9hUO3VSkLiBFssDaGWe036fbazLE+Rs8Z0P4c4KbSoVgsPs7mvZJGqa/sf5TBiE1jw2N7z8r9IotNPz780FE9xS7klGwr4EPDQPU2ZVYAqCBqtW6/nyyuyVx9k1K10DnkGKMZqMhLOcbEQndxnjHGCrfxb+3/38JYU5HU0QL50dvhbzgcMvZ/t9j1HHib7Bntlh5jLhgyFUah36C9/5Y3pxXk/zAgcy7+vSuouN9LM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <900CE6034BCF2947914B7832E998E000@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: openvz.org
X-MS-Exchange-CrossTenant-Network-Message-Id: 540855b8-7c74-4209-28cd-08d70c490b39
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2019 13:00:16.3861 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: den@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4250
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.113
Subject: Re: [Qemu-devel] [PATCH 1/1] x86: add CPU flags supported inside
 libvirt
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
Cc: Nikolay Shirokovskiy <nshirokovskiy@virtuozzo.com>,
 Peter Krempa <pkrempa@redhat.com>,
 =?utf-8?B?RGFuaWVsIFAgLiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gNy8xOC8xOSA0OjUyIFBNLCBQYW9sbyBCb256aW5pIHdyb3RlOg0KPiBPbiAxOC8wNy8xOSAx
NTo0NSwgRGVuaXMgVi4gTHVuZXYgd3JvdGU6DQo+PiBUaGVyZSBhcmUgdGhlIGZvbGxvd2luZyBm
bGFncyBhdmFpbGFibGUgaW4gbGlidmlydCBpbnNpZGUgY3B1X21hcC54bQ0KPj4gICAgIDxmZWF0
dXJlIG5hbWU9J2N2dDE2Jz4NCj4+ICAgICAgIDxjcHVpZCBmdW5jdGlvbj0nMHg4MDAwMDAwMScg
ZWN4PScweDAwMDQwMDAwJy8+DQo+PiAgICAgPC9mZWF0dXJlPg0KPj4gICAgIDxmZWF0dXJlIG5h
bWU9J2NtdCc+IDwhLS0gY3FtIC0tPg0KPj4gICAgICAgPGNwdWlkIGVheF9pbj0nMHgwNycgZWN4
X2luPScweDAwJyBlYng9JzB4MDAwMDEwMDAnLz4NCj4+ICAgICA8L2ZlYXR1cmU+DQo+PiBXZSBo
YXZlIGZhY2VkIHRoZSBwcm9ibGVtIHRoYXQgUUVNVSBkb2VzIG5vdCBzdGFydCBvbmNlIHRoZXNl
IGZsYWdzIGFyZQ0KPj4gcHJlc2VudCBpbiB0aGUgZG9tYWluLnhtbC4NCj4+DQo+PiBUaGlzIHBh
dGNoIGp1c3QgYWRkcyBwcm9wZXIgbmFtZXMgaW50byB0aGUgbWFwLg0KPj4NCj4+IFNpZ25lZC1v
ZmYtYnk6IERlbmlzIFYuIEx1bmV2IDxkZW5Ab3BlbnZ6Lm9yZz4NCj4+IENDOiBQYW9sbyBCb256
aW5pIDxwYm9uemluaUByZWRoYXQuY29tPg0KPj4gQ0M6IFJpY2hhcmQgSGVuZGVyc29uIDxydGhA
dHdpZGRsZS5uZXQ+DQo+PiBDQzogRWR1YXJkbyBIYWJrb3N0IDxlaGFia29zdEByZWRoYXQuY29t
Pg0KPj4gQ0M6IE5pa29sYXkgU2hpcm9rb3Zza2l5IDxuc2hpcm9rb3Zza2l5QHZpcnR1b3p6by5j
b20+DQo+PiBDQzogUGV0ZXIgS3JlbXBhIDxwa3JlbXBhQHJlZGhhdC5jb20+DQo+PiBDQzogRGFu
aWVsIFAuIEJlcnJhbmfDqSA8YmVycmFuZ2VAcmVkaGF0LmNvbT4NCj4+IC0tLQ0KPj4gIHRhcmdl
dC9pMzg2L2NwdS5jIHwgNCArKy0tDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygr
KSwgMiBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L2kzODYvY3B1LmMg
Yi90YXJnZXQvaTM4Ni9jcHUuYw0KPj4gaW5kZXggODA1Y2U5NTI0Ny4uODhiYTRkYWQ0NyAxMDA2
NDQNCj4+IC0tLSBhL3RhcmdldC9pMzg2L2NwdS5jDQo+PiArKysgYi90YXJnZXQvaTM4Ni9jcHUu
Yw0KPj4gQEAgLTg3MCw3ICs4NzAsNyBAQCBzdGF0aWMgRmVhdHVyZVdvcmRJbmZvIGZlYXR1cmVf
d29yZF9pbmZvW0ZFQVRVUkVfV09SRFNdID0gew0KPj4gICAgICAgICAgICAgICJsYWhmLWxtIiwg
ImNtcC1sZWdhY3kiLCAic3ZtIiwgImV4dGFwaWMiLA0KPj4gICAgICAgICAgICAgICJjcjhsZWdh
Y3kiLCAiYWJtIiwgInNzZTRhIiwgIm1pc2FsaWduc3NlIiwNCj4+ICAgICAgICAgICAgICAiM2Ru
b3dwcmVmZXRjaCIsICJvc3Z3IiwgImlicyIsICJ4b3AiLA0KPj4gLSAgICAgICAgICAgICJza2lu
aXQiLCAid2R0IiwgTlVMTCwgImx3cCIsDQo+PiArICAgICAgICAgICAgInNraW5pdCIsICJ3ZHQi
LCAiY3Z0MTYiLCAibHdwIiwNCj4+ICAgICAgICAgICAgICAiZm1hNCIsICJ0Y2UiLCBOVUxMLCAi
bm9kZWlkLW1zciIsDQo+PiAgICAgICAgICAgICAgTlVMTCwgInRibSIsICJ0b3BvZXh0IiwgInBl
cmZjdHItY29yZSIsDQo+PiAgICAgICAgICAgICAgInBlcmZjdHItbmIiLCBOVUxMLCBOVUxMLCBO
VUxMLA0KPj4gQEAgLTEwNDQsNyArMTA0NCw3IEBAIHN0YXRpYyBGZWF0dXJlV29yZEluZm8gZmVh
dHVyZV93b3JkX2luZm9bRkVBVFVSRV9XT1JEU10gPSB7DQo+PiAgICAgICAgICAgICAgImZzZ3Ni
YXNlIiwgInRzYy1hZGp1c3QiLCBOVUxMLCAiYm1pMSIsDQo+PiAgICAgICAgICAgICAgImhsZSIs
ICJhdngyIiwgTlVMTCwgInNtZXAiLA0KPj4gICAgICAgICAgICAgICJibWkyIiwgImVybXMiLCAi
aW52cGNpZCIsICJydG0iLA0KPj4gLSAgICAgICAgICAgIE5VTEwsIE5VTEwsICJtcHgiLCBOVUxM
LA0KPj4gKyAgICAgICAgICAgICJjbXQiLCBOVUxMLCAibXB4IiwgTlVMTCwNCj4+ICAgICAgICAg
ICAgICAiYXZ4NTEyZiIsICJhdng1MTJkcSIsICJyZHNlZWQiLCAiYWR4IiwNCj4+ICAgICAgICAg
ICAgICAic21hcCIsICJhdng1MTJpZm1hIiwgInBjb21taXQiLCAiY2xmbHVzaG9wdCIsDQo+PiAg
ICAgICAgICAgICAgImNsd2IiLCAiaW50ZWwtcHQiLCAiYXZ4NTEycGYiLCAiYXZ4NTEyZXIiLA0K
Pj4NCj4gT29wcywgbmljZSBjYXRjaCEgIEkndmUgcXVldWVkIHRoZSBwYXRjaCBmb3IgNC4xLg0K
Pg0KPiBQYW9sbw0KSSBoYXZlIHdyaXR0ZW4gc21hbGwgc2NyaXB0IHRvIGZpbmQgZGlmZmVyZW5j
ZXMgYmV0d2Vlbg0KQ1BVIGZlYXR1cmVzIGluIFFFTVUgYW5kIGxpYnZpcnQuDQoNCiMhL2Jpbi9i
YXNoDQpMSVNUPWBhd2sgIi9uYW1lL3tzcGxpdChcXFwkMiwgYXJyLCBcIidcIik7IHByaW50IGFy
clsyXX0iIHg4Nl9mZWF0dXJlcy54bWxgDQpmb3IgZmVhdCBpbiAkTElTVDsgZG8NCsKgwqDCoCB2
YXI9YGdyZXAgXCIkZmVhdFwiIHRhcmdldC9pMzg2L2NwdS5jYA0KwqDCoMKgIGlmIFsgLXogIiR2
YXIiIF07IHRoZW4NCsKgwqDCoMKgwqDCoMKgIGVjaG8gJGZlYXQNCsKgwqDCoCBmaQ0KZG9uZQ0K
DQpUaGVyZSBhcmUgdGhlIGZvbGxvd2luZyBsaXN0IG9mIGZlYXR1cmVzIHByZXNlbnQgaW4gbGli
dmlydA0KYW5kIG1pc3NlZCBpbiBRRU1VOg0KDQpvc3hzYXZlIC0gcmVtb3ZlZCBpbiBxZW11IGlu
IGYxYTIzNTIyYjAzDQpvc3BrZSAtIHJlbW92ZWQgaW4gcWVtdSBpbiA5Y2NiOTc4NGI1Nw0KcGNv
bmZpZyAtIHJlbW92ZWQgaW4gcWVtdSBpbiA3MTJmODA3ZTE5Ni4NCm1ibV90b3RhbA0KbWJtX2xv
Y2FsDQoNClR3byBsYXN0IGZlYXR1cmVzIGFyZSBkZXNjcmliZWQgYXMgZm9sbG93czoNCsKgIDwh
LS0gY3B1aWQgbGV2ZWwgMHgwMDAwMDAwZjoxIChlZHgpIC0tPg0KwqAgPGZlYXR1cmUgbmFtZT0n
bWJtX3RvdGFsJz4NCsKgwqDCoCA8Y3B1aWQgZWF4X2luPScweDBmJyBlY3hfaW49JzB4MDEnIGVk
eD0nMHgwMDAwMDAwMicvPg0KwqAgPC9mZWF0dXJlPg0KwqAgPGZlYXR1cmUgbmFtZT0nbWJtX2xv
Y2FsJz4NCsKgwqDCoCA8Y3B1aWQgZWF4X2luPScweDBmJyBlY3hfaW49JzB4MDEnIGVkeD0nMHgw
MDAwMDAwNCcvPg0KwqAgPC9mZWF0dXJlPg0KVGhpcyBsZWFmIGlzIG5vdCBzdXBwb3J0ZWQgaW4g
UUVNVSBhdCBhbGwuDQoNCkFjY29yZGluZyB0byBJbnRlbCA2NCBhbmQgSUEtMzIgQXJjaGl0ZWN0
dXJlIERldmVsb3BlciBtYW51YWwNCnZvbC4gMmEgdGhlc2UgYml0cyBhcmUgdXNlZCBmb3INCkVE
WCBCaXQgMDA6IFN1cHBvcnRzIEwzIG9jY3VwYW5jeSBtb25pdG9yaW5nIGlmIDEuDQpCaXQgMDE6
IFN1cHBvcnRzIEwzIFRvdGFsIEJhbmR3aWR0aCBtb25pdG9yaW5nIGlmIDEuDQpCaXQgMDI6IFN1
cHBvcnRzIEwzIExvY2FsIEJhbmR3aWR0aCBtb25pdG9yaW5nIGlmIDEuDQpCaXRzIDMxIC0gMDM6
IFJlc2VydmVkLg0KDQpUaHVzIHRlY2huaWNhbGx5IHRoZXNlIDUgYml0cyBhcmUgYWJsZSB0byBw
cm9kdWNlIHByb2JsZW1zDQpmb3IgUUVNVSBpZiB0aGV5IHdpbGwgYmUgZm91bmQgaW4gZG9tYWlu
LnhtbA0KDQpEZW4NCg==

