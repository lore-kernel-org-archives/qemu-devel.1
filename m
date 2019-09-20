Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A8AC49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 13:28:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39E1520644
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 13:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="W2lqO+El"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39E1520644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBIxc-0006Gd-6G
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 09:28:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54058)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iBIvo-0005H0-Bd
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 09:26:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iBIvk-0008P3-0l
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 09:26:39 -0400
Received: from mail-eopbgr80137.outbound.protection.outlook.com
 ([40.107.8.137]:57817 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iBIvg-0008Mg-Il; Fri, 20 Sep 2019 09:26:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mReJ3/J5PAHwp86Z+x3k9YUkLM3jHUazzTSZreFEN96NSGz9g9UPodUalEcU8wimf+A1IAyVx7cKoDmrWhrEMiDEcHJ5Jyz542PmYcbjh44LClkmFPBEGlV9+ao0Lhw/KcKXBqyhz352En4D3ywgM3bKGoMggHGAsNV2zuctRLS+LnwFKT7VOjzNmdqTwXLZhXYEcz+Tuq/KVWt6PIib0sgcBLJ+u22/5p9DuU1V3n8DwJV377vnB7KKtrZNpQZ3WFbO6XG4ZDTjX4w2I1a3aLUH+ghxXNlgzNk2o4huHe+/2gdwigniBNnj/9VebOJsj3YGeTfBQhspqWqBjertdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cqb/o/VDQo3PthjCrCLBC0jfNxQ24Fs5+sK3xJrt+Ks=;
 b=Dr6OQAIkSxz6p61PAEKfaxNr+zraR/zqCi0FaHdOk3JU2dVMXA7ptw5/xnKtXwiCFttyRAfgJKtDpkJwkYnFWgAlF1R3Ppa5HyVpT4w/vyRgmfmSo5CW9oUeWhr8DY5NK3XNS4nJvePM8xt1SPC0IA6myWZmaYO6B8YWPGuJacNAy1io37UaUs/SJ0A0io/eb9Zly9xSdE/rGiRWL16MmxQUfKi8Pg6OsqXEs0tbiiAPJUEnT37pL2nAYyDzMcLzchEdjF6V/3Ie60Jrd4bqnnlrR2SZ8WXCNwOPSKW5yldWpD70xdvoT9vbOYi5TUKMYEunAE9VIpRegwpchAHDhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cqb/o/VDQo3PthjCrCLBC0jfNxQ24Fs5+sK3xJrt+Ks=;
 b=W2lqO+ElG5xRXYv6KhL08i5lPt8Y1+h09G8tJo3iSuYc5Vvd380TYkEKLZ4+E6P+D20rlNYR147hKVrvBdRRckZEq5nTwU7J9iHHu6BCGPENnhwX/JcsML0AR3e7tkeV6rZTchTvU5XAJWVAndOCMFEQbp49uPkawmp5XgnYk98=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5323.eurprd08.prod.outlook.com (10.255.185.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Fri, 20 Sep 2019 13:26:29 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2284.023; Fri, 20 Sep 2019
 13:26:29 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH v5 0/5] qcow2: async handling of fragmented io
Thread-Topic: [PATCH v5 0/5] qcow2: async handling of fragmented io
Thread-Index: AQHVbLeo76n3Ba9lJkqJlS+3Y8+k26c0bngAgAAMPwCAAA0OgIAAA7gAgAAEioCAAASMgA==
Date: Fri, 20 Sep 2019 13:26:29 +0000
Message-ID: <0baa8d6e-cb3b-9e20-be0e-324a3e270b87@virtuozzo.com>
References: <20190916175324.18478-1-vsementsov@virtuozzo.com>
 <d4d62196-84c2-0a90-312d-391493eae158@redhat.com>
 <93e72727-c46c-d30a-1f38-634237186126@virtuozzo.com>
 <d392d630-23e5-cc21-c8f5-8c2ec3d4f70b@redhat.com>
 <ea14f4bc-9a0c-0147-e963-9019fc9f4f2b@virtuozzo.com>
 <9b56ef11-8c1e-fa48-d838-4fe3ee043474@redhat.com>
In-Reply-To: <9b56ef11-8c1e-fa48-d838-4fe3ee043474@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0278.eurprd05.prod.outlook.com
 (2603:10a6:3:fc::30) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190920162627092
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4509e6d9-b10d-49f2-80cb-08d73dce253f
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(49563074)(7193020);
 SRVR:DB8PR08MB5323; 
x-ms-traffictypediagnostic: DB8PR08MB5323:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB53236E58E0A44AB28C7342D4C1880@DB8PR08MB5323.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-forefront-prvs: 0166B75B74
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(346002)(376002)(136003)(396003)(39850400004)(199004)(53754006)(189003)(6506007)(6116002)(81166006)(478600001)(476003)(4326008)(31686004)(99286004)(110136005)(66066001)(31696002)(71190400001)(6436002)(107886003)(71200400001)(11346002)(2501003)(6306002)(25786009)(446003)(26005)(6246003)(6512007)(2616005)(7736002)(186003)(6486002)(86362001)(966005)(53546011)(66446008)(81156014)(305945005)(316002)(486006)(8936002)(102836004)(386003)(66476007)(66576008)(8676002)(64756008)(54906003)(3846002)(2906002)(14454004)(229853002)(52116002)(76176011)(5660300002)(66946007)(66556008)(36756003)(256004)(99936001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5323;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gbmJqz/JoGPfWL0VVcli9RDNUItDwTesoyks4GHLAQQ+zhvLhFBvJdncWY6GCOwf0x+EUH3/PPaB7FbSfRIr3z7Cgl+czX30yfPlWH+wt8BbVXwpqgFZZPemdla+CoywZL7Cj4WnlYzrxNcubAQk99OF8ppZEtRJz2WbOfUAjqWpYKiSZc2fG8dIzA6RWbY9VCBiu7CTZYwxz5zLMsLT8GBKxVYrEPpa2FJuFqn+ofgkzzITlZBh0hAMVog8kJXbe4ybV/RN2iDNIt6LxzLdEJsYFpn3Xz6RzsxhdmdnpmusoPXpSUMNqSwg2ZT5HfC1yl9duzg3q6cmznEjAAfR6Ppg2j0jWkK50VNKIV88e+LJFcbdpBG9eEdOgNAJJfxJwCMAoyMPV8YJKJOt0ZchcNgdRDeg8BUftiao408dmHk=
Content-Type: multipart/mixed;
 boundary="_004_0baa8d6ecb3b9e20be0e324a3e270b87virtuozzocom_"
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4509e6d9-b10d-49f2-80cb-08d73dce253f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2019 13:26:29.6172 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M+E25ibvraQ2hU8lwEMoTJi/616F2tbmd2uRUNNTY6LivDDBX/MesHxYXQjN0rpDHiQKoSGtYr8HNrhqfKrj53idovwBE6UQV3d6dq7zbeI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5323
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.137
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_004_0baa8d6ecb3b9e20be0e324a3e270b87virtuozzocom_
Content-Type: text/plain; charset="utf-8"
Content-ID: <CC66F1880CAC784C86872E836077A95B@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64

MjAuMDkuMjAxOSAxNjoxMCwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAyMC4wOS4xOSAxNDo1Mywg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IDIwLjA5LjIwMTkgMTU6NDAs
IE1heCBSZWl0eiB3cm90ZToNCj4+PiBPbiAyMC4wOS4xOSAxMzo1MywgVmxhZGltaXIgU2VtZW50
c292LU9naWV2c2tpeSB3cm90ZToNCj4+Pj4gMjAuMDkuMjAxOSAxNDoxMCwgTWF4IFJlaXR6IHdy
b3RlOg0KPj4+Pj4gT24gMTYuMDkuMTkgMTk6NTMsIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNr
aXkgd3JvdGU6DQo+Pj4+Pj4gSGkgYWxsIQ0KPj4+Pj4+DQo+Pj4+Pj4gSGVyZSBpcyBhbiBhc3lu
Y2hyb25vdXMgc2NoZW1lIGZvciBoYW5kbGluZyBmcmFnbWVudGVkIHFjb3cyDQo+Pj4+Pj4gcmVh
ZHMgYW5kIHdyaXRlcy4gQm90aCBxY293MiByZWFkIGFuZCB3cml0ZSBmdW5jdGlvbnMgbG9vcHMg
dGhyb3VnaA0KPj4+Pj4+IHNlcXVlbnRpYWwgcG9ydGlvbnMgb2YgZGF0YS4gVGhlIHNlcmllcyBh
aW0gaXQgdG8gcGFyYWxsZWxpemUgdGhlc2UNCj4+Pj4+PiBsb29wcyBpdGVyYXRpb25zLg0KPj4+
Pj4+IEl0IGltcHJvdmVzIHBlcmZvcm1hbmNlIGZvciBmcmFnbWVudGVkIHFjb3cyIGltYWdlcywg
SSd2ZSB0ZXN0ZWQgaXQNCj4+Pj4+PiBhcyBkZXNjcmliZWQgYmVsb3cuDQo+Pj4+Pg0KPj4+Pj4g
VGhhbmtzIGFnYWluLCBhcHBsaWVkIHRvIG15IGJsb2NrIGJyYW5jaDoNCj4+Pj4+DQo+Pj4+PiBo
dHRwczovL2dpdC54YW5jbGljLm1vZS9YYW5DbGljL3FlbXUvY29tbWl0cy9icmFuY2gvYmxvY2sN
Cj4+Pj4NCj4+Pj4gVGhhbmtzIGEgbG90IQ0KPj4+Pg0KPj4+Pj4NCj4+Pj4+PiB2NTogZml4IDAy
NiBhbmQgcmViYXNlIG9uIE1heCdzIGJsb2NrIGJyYW5jaCBbcGVyZiByZXN1bHRzIG5vdCB1cGRh
dGVkXToNCj4+Pj4+Pg0KPj4+Pj4+IDAxOiBuZXcsIHByZXBhcmUgMDI2IHRvIG5vdCBmYWlsDQo+
Pj4+Pj4gMDM6IC0gZHJvcCByZWFkX2VuY3J5cHRlZCBibGtkYmcgZXZlbnQgW0tldmluXQ0KPj4+
Pj4+ICAgICAgICAtIGFzc2VydCgoeCAmIChCRFJWX1NFQ1RPUl9TSVpFIC0gMSkpID09IDApIC0+
IGFzc2VydChRRU1VX0lTX0FMSUdORUQoeCwgQkRSVl9TRUNUT1JfU0laRSkpIFtyZWJhc2VdDQo+
Pj4+Pj4gICAgICAgIC0gZnVsbCBob3N0IG9mZnNldCBpbiBhcmd1bWVudCBvZiBxY293Ml9jb19k
ZWNyeXB0IFtyZWJhc2VdDQo+Pj4+Pj4gMDQ6IC0gc3Vic3RpdHV0ZSByZW1haW5pbmcgcWNvdzJf
Y29fZG9fcHdyaXRldiBieSBxY293Ml9jb19wd3JpdGV2X3Rhc2sgaW4gY29tbWVudCBbTWF4XQ0K
Pj4+Pj4+ICAgICAgICAtIGZ1bGwgaG9zdCBvZmZzZXQgaW4gYXJndW1lbnQgb2YgcWNvdzJfY29f
ZW5jcnlwdCBbcmViYXNlXQ0KPj4+Pj4+IDA1OiAtIE5vdyBwYXRjaCBkb24ndCBhZmZlY3QgMDI2
IGlvdGVzdCwgc28gaXRzIG91dHB1dCBpcyBub3QgY2hhbmdlZA0KPj4+Pj4+DQo+Pj4+Pj4gUmVi
YXNlIGNoYW5nZXMgc2VlbXMgdHJpdmlhbCwgc28sIEkndmUga2VwdCByLWIgbWFya3MuDQo+Pj4+
Pg0KPj4+Pj4gKEZvciB0aGUgcmVjb3JkLCBJIGRpZG7igJl0IGNvbnNpZGVyIHRoZW0gdHJpdmlh
bCwgb3IgSeKAmWTigJl2ZSBhcHBsaWVkDQo+Pj4+PiBNYXhpbeKAmXMgc2VyaWVzIG9uIHRvcCBv
ZiB5b3Vycy4gIEkgY29uc2lkZXIgYSBjb25mbGljdCB0byBiZSB0cml2aWFsbHkNCj4+Pj4+IHJl
c29sdmFibGUgb25seSBpZiB0aGVyZSBpcyBvbmx5IG9uZSB3YXkgb2YgZG9pbmcgaXQ7IGJ1dCB3
aGVuIEkNCj4+Pj4+IHJlc29sdmVkIHRoZSBjb25mbGljdHMgbXlzZWxmLCBJIHJlc29sdmVkIHRo
ZSBvbmUgaW4gcGF0Y2ggMyBkaWZmZXJlbnRseQ0KPj4+Pj4gZnJvbSB5b3Ug4oCTIEkgYWRkZWQg
YW4gb2Zmc2V0X2luX2NsdXN0ZXIgdmFyaWFibGUgdG8NCj4+Pj4+IHFjb3cyX2NvX3ByZWFkdl9l
bmNyeXB0ZWQoKS4gIFN1cmUsIGl04oCZcyBzdGlsbCBzaW1wbGUgYW5kIHRoZSBkaWZmZXJlbmNl
DQo+Pj4+PiBpcyBtaW5vciwgYnV0IHRoYXQgd2FzIGV4YWN0bHkgd2hlcmUgSSB0aG91Z2h0IHRo
YXQgSSBjYW7igJl0IGNvbnNpZGVyDQo+Pj4+PiB0aGlzIHRyaXZpYWwuKQ0KPj4+Pj4NCj4+Pj4N
Cj4+Pj4gSG1tLiBNYXkgYmUgaXQncyB0cml2aWFsIGVub3VnaCB0byBrZWVwIHItYiAoYXMgbXkg
Y2hhbmdlIGlzIHRyaXZpYWwgaXRzZWxmKSwgYnV0IG5vdA0KPj4+PiB0cml2aWFsIGVub3VnaCB0
byBjaGFuZ2UgYWxpZW4gcGF0Y2ggb24gcXVldWluZz8gSWYgeW91IGRpc2FncmVlLCBJJ2xsIGJl
IG1vcmUNCj4+Pj4gY2FyZWZ1bCBvbiBrZWVwaW5nIHItYiBpbiBjaGFuZ2VkIHBhdGNoZXMsIHNv
cnJ5Lg0KPj4+DQo+Pj4gSXQgZG9lc27igJl0IG1hdHRlciBtdWNoIHRvIG1lLCBJIGRpZmYgYWxs
IHBhdGNoZXMgYW55d2F5LiA6LSkNCj4+Pg0KPj4NCj4+IHRoZW4gYSBiaXQgb2ZmdG9waWM6DQo+
Pg0KPj4gV2hpY2ggdG9vbHMgYXJlIHlvdSB1c2U/DQo+Pg0KPj4gSSd2ZSBzb21lIHNjcmlwdHMg
dG8gY29tcGFyZSBkaWZmZXJlbnQgdmVyc2lvbnMgb2Ygb25lIHNlcmllIChvciB0byBjaGVjaywg
d2hhdA0KPj4gd2FzIGNoYW5nZWQgaW4gcGF0Y2hlcyBkdXJpbmcgc29tZSBwb3J0aW5nIHByb2Nl
c3MuLikuLiBUaGUgY29yZSB0aGluZyBpcyB0byBmaWx0ZXINCj4+IHNvbWUgbm90IGludGVyZXN0
aW5nIG51bWJlcnMgYW5kIGhhc2hlcywgd2hpY2ggbWFrZXMgZGlmZnMgZGlydHksIGFuZCB0aGVu
IGNhbGwgdmltZGlmZi4NCj4+IEJ1dCBtYXliZSBJJ3ZlIHJlaW52ZW50ZWQgdGhlIHdoZWVsLg0K
PiANCj4gSnVzdCBrb21wYXJlIGFzIGEgZ3JhcGhpY2FsIGRpZmYgdG9vbDsgSSBqdXN0IHNjcm9s
bCBwYXN0IHRoZSBoYXNoIGRpZmZzLg0KPiANCj4gQnV0IG5vdyB0aGF0IHlvdSBnYXZlIG1lIHRo
ZSBpZGVhLCBtYXliZSBJIHNob3VsZCB3cml0ZSBhIHNjcmlwdCB0bw0KPiBmaWx0ZXIgdGhlbS4u
LiAgKFNvLCBubywgSSBkb27igJl0IGtub3cgb2YgYSB0b29sIHRoYXQgd291bGQgZG8gdGhhdA0K
PiBhbHJlYWR5IDotLykNCj4gDQoNCg0KVGhlbiB5b3UgbWF5IGZpbmQgbXkgc2NyaXB0cyBzb21l
aG93IHVzZWZ1bCwgYXQgbGVhc3QgYXMgYSBoaW50IChJJ20gYWZyYWlkIGNvZGUgaXMgbm90IGJl
YXV0aWZ1bCBhdCBhbGwpDQoNCi0tLQ0KDQpVc2FnZToNCg0KZWF0LWRpZmYtbnVtYmVycyBpcyBq
dXN0IHNlZCBzY3JpcHQsIHVzZWQgYnkgYm90aCBmb2xsb3dpbmcgc2NyaXB0cywgdG8gZWF0IGdp
dCBudW1iZXJzIGFuZCBoYXNoZXMuDQoNCi0tLQ0KDQpjaGVjay1yZWJhc2UgLSBzZWFyY2hlcyBw
YXRjaGVzIGJ5IG5hbWUgaW4gb3JpZ2luYWwgYnJhbmNoIGFuZCBjb21wYXJlcw0KDQpnaXQgY2hl
Y2stcmViYXNlIDxvcmlnaW5hbCBicmFuY2g+IDxjb21taXRzIHRvIGNoZWNrPg0KDQpmb3IgZXhh
bXBsZSAoY2hlY2sgc2V2ZXJhbCBiYWNrcG9ydGVkIGNvbW1pdHMpOg0KDQpnaXQgY2hlY2stcmVi
YXNlIG1hc3RlciBIRUFEXl5eXi4uSEVBRA0KDQotLS0tLS0tLS0tLQ0KDQpjaGVjay1yZWJhc2Uy
IC0gZG9uJ3Qgc2VhcmNoIGJ5IG5hbWUsIGJ1dCBqdXN0IGNvbXBhcmUgdHdvIHNlcXVlbmNlcyBv
ZiBwYXRjaGVzIG9mIHNhbWUgbGVuZ3RoLg0KDQpnaXQgY2hlY2stcmViYXNlMiA8b3JpZ2luYWwg
dG9wIGNvbW1pdD4gIDxuZXcgdG9wIGNvbW1pdD4gIDxob3cgbWFueSBjb21taXRzPg0KDQpmb3Ig
ZXhhbXBsZSAoY2hlY2sgb25lIHNlcmllcyB2ZXJzaW9uIHZzIGFub3RoZXIpDQoNCmdpdCBjaGVj
ay1yZWJhc2UyIHNhbHZhZ2UtdjEgc2FsdmFnZS12MiA3DQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMs
DQpWbGFkaW1pcg0K

--_004_0baa8d6ecb3b9e20be0e324a3e270b87virtuozzocom_
Content-Type: text/plain; name="eat-diff-numbers"
Content-Description: eat-diff-numbers
Content-Disposition: attachment; filename="eat-diff-numbers"; size=170;
	creation-date="Fri, 20 Sep 2019 13:26:29 GMT";
	modification-date="Fri, 20 Sep 2019 13:26:29 GMT"
Content-ID: <83CF4654440FAA4FB72537A6AF6076D3@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64

IyEvdXNyL2Jpbi9zaAoKc2VkIC1lICdzL15pbmRleCAuKi9pbmRleCA8c29tZSBpbmRleD4vJyAt
ZSAncy9eQEAgLiogQEAvQEAgPHNvbWUgbGluZXM+IEBALycgLWUgJ3MvXmNvbW1pdCAuKi9jb21t
aXQgPHNvbWUgY29tbWl0Pi8nIC1lICdzL15EYXRlOi4qMDAvRGF0ZTogPHNvbWUgZGF0ZT4vJwo=

--_004_0baa8d6ecb3b9e20be0e324a3e270b87virtuozzocom_
Content-Type: text/plain; name="git-check-rebase2"
Content-Description: git-check-rebase2
Content-Disposition: attachment; filename="git-check-rebase2"; size=921;
	creation-date="Fri, 20 Sep 2019 13:26:29 GMT";
	modification-date="Fri, 20 Sep 2019 13:26:29 GMT"
Content-ID: <A2C5B08A55074840A4CAFDF42D73D456@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64

IyEvdXNyL2Jpbi9iYXNoCgpmdW5jdGlvbiBkc2hvdyB7CiAgICBnaXQgc2hvdyAkMSB8IGVhdC1k
aWZmLW51bWJlcnMKfQoKZnVuY3Rpb24gY29tcCB7CiAgICBhcD0iL3RtcC9bYSAkM10gJChnaXQg
bG9nIC0tZm9ybWF0PSVmIC1uIDEgJDEpLnBhdGNoIgogICAgYnA9Ii90bXAvW2IgJDNdICQoZ2l0
IGxvZyAtLWZvcm1hdD0lZiAtbiAxICQyKS5wYXRjaCIKICAgIGRzaG93ICQxID4gIiRhcCIKICAg
IGRzaG93ICQyID4gIiRicCIKICAgIGlmICEgZGlmZiAiJGFwIiAiJGJwIiA+IC9kZXYvbnVsbCA7
IHRoZW4KICAgICAgICBjbz0kKGdpdCBsb2cgLS1mb3JtYXQ9JXMgLW4gMSAkMikKICAgICAgICBl
Y2hvIC1uICRjbyAtIGRpZmZlcnMgfCB0ZWUgLWEgbG9nbG9nCiAgICAgICAgZWNobyAiJGFwIC0g
JDEiCiAgICAgICAgZWNobyAiJGJwIC0gJDIiCiAgICAgICAgZWNobyAidHlwZSBleGl0IHRvIGNv
bnRpbnVlIgogICAgICAgICNnaXQgZGlmZiAtLW5vLWluZGV4IC0tY29sb3Itd29yZHMgLS13b3Jk
LWRpZmYtcmVnZXg9LiAvdG1wL3thLGJ9LnBhdGNoCiAgICAgICAgaWYgdmltZGlmZiAgPCAvZGV2
L3R0eSAtYyAwICIkYXAiICIkYnAiIDsgdGhlbgogICAgICAgICAgICBlY2hvICIgLSBvayIgfCB0
ZWUgLWEgbG9nbG9nCiAgICAgICAgZWxzZQogICAgICAgICAgICBlY2hvICIgLSBiYWQiIHwgdGVl
IC1hIGxvZ2xvZwogICAgICAgIGZpCiAgICAgICAgcmV0dXJuIDEKICAgIGZpCn0KCmE9JDEKYj0k
MgpuPSQzCgpmb3IgKChpPTE7IGk8PW47IGkrKykpOyBkbwogICAgcnI9JCgobiAtIGkpKQogICAg
Y289JChnaXQgbG9nIC0tZm9ybWF0PSVzIC1uIDEgJGJ+JHJyKQogICAgaWYgY29tcCAkYX4kcnIg
JGJ+JHJyICRpOyB0aGVuCiAgICAgICAgZWNobyAkY28gLSBvayB8IHRlZSAtYSBsb2dsb2cKICAg
IGZpCmRvbmUK

--_004_0baa8d6ecb3b9e20be0e324a3e270b87virtuozzocom_
Content-Type: text/plain; name="git-check-rebase"
Content-Description: git-check-rebase
Content-Disposition: attachment; filename="git-check-rebase"; size=1002;
	creation-date="Fri, 20 Sep 2019 13:26:29 GMT";
	modification-date="Fri, 20 Sep 2019 13:26:29 GMT"
Content-ID: <BC8BF36C122AED449D8D939ACF4F5654@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64

IyEvdXNyL2Jpbi9iYXNoCgpmdW5jdGlvbiBkc2hvdyB7CiAgICBnaXQgc2hvdyAkMSB8IGVhdC1k
aWZmLW51bWJlcnMKfQoKZnVuY3Rpb24gY29tcCB7CiAgICBsb2NhbCBiPSIvdG1wL1tiLSQzXS0k
KGdpdCBsb2cgLS1mb3JtYXQ9JWYgLW4gMSAkMikucGF0Y2giCiAgICBkc2hvdyAkMiA+ICRiCiAg
ICBkc2hvdyAkKGdpdC1maW5kLXN1YmogJDEgJDIgfHwgZWNobyAiTk9UIEZPVU5EIikgPiAvdG1w
L2EucGF0Y2gKICAgIGlmICEgZGlmZiAvdG1wL2EucGF0Y2ggJGIgPiAvZGV2L251bGwgOyB0aGVu
CiAgICAgICAgY289JChnaXQgbG9nIC0tZm9ybWF0PSVzIC1uIDEgJGMpCiAgICAgICAgZWNobyAt
biAkY28gLSBkaWZmZXJzIHwgdGVlIC1hIGxvZ2xvZwogICAgICAgIGVjaG8gIi90bXAvYS5wYXRj
aCAtIGZvdW5kIGluICQxOiAiCiAgICAgICAgZWNobyAiJGIgLSAkYyBmcm9tIGN1cnJlbnQgYnJh
bmNoIgogICAgICAgIGVjaG8gInR5cGUgZXhpdCB0byBjb250aW51ZSIKICAgICAgICAjZ2l0IGRp
ZmYgLS1uby1pbmRleCAtLWNvbG9yLXdvcmRzIC0td29yZC1kaWZmLXJlZ2V4PS4gL3RtcC97YSxi
fS5wYXRjaAogICAgICAgIGlmIHZpbWRpZmYgIDwgL2Rldi90dHkgLWMgMCAvdG1wL2EucGF0Y2gg
JGIgOyB0aGVuCiAgICAgICAgICAgIGVjaG8gIiAtIG9rIiB8IHRlZSAtYSBsb2dsb2cKICAgICAg
ICBlbHNlCiAgICAgICAgICAgIGVjaG8gIiAtIGJhZCIgfCB0ZWUgLWEgbG9nbG9nCiAgICAgICAg
ZmkKICAgICAgICByZXR1cm4gMQogICAgZmkKfQoKcm0gbG9nbG9nIGxvZ2N1cgphPTAKZ2l0IGxv
ZyAkMiAtLWZvcm1hdD0iJWgiIC0tcmV2ZXJzZSB8IHdoaWxlIHJlYWQgYzsgZG8KICAgICgoYSsr
KSkKICAgIGNvPSQoZ2l0IGxvZyAtLWZvcm1hdD0lcyAtbiAxICRjKQogICAgZ2l0IGxvZyAtbiAx
ICRjID4gbG9nY3VyCiAgICBpZiBjb21wICQxICRjICRhOyB0aGVuCiAgICAgICAgZWNobyAkY28g
LSBvayB8IHRlZSAtYSBsb2dsb2cKICAgIGZpCmRvbmUK

--_004_0baa8d6ecb3b9e20be0e324a3e270b87virtuozzocom_--

