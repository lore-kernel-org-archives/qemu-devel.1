Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD19AC10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 14:59:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 646BA20879
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 14:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="HrcR8816"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 646BA20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54317 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDVji-0007km-Fy
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 10:59:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hDVi9-0006k7-47
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 10:57:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hDVi7-0006W1-Of
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 10:57:25 -0400
Received: from mail-eopbgr150092.outbound.protection.outlook.com
	([40.107.15.92]:5972
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hDVi7-0006Tl-0j; Mon, 08 Apr 2019 10:57:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=XEoREJ3hWqXAcL204UMoCVmtnlf4Ymzm1LnUl6O1cR0=;
	b=HrcR8816ekmnwAq7BxYBybSkcghSJI+tD0ERmf/AzoklGMZ0QiQ6q+6Wx3ZEnW1uDRfBXPuwvjxCoFc4xthqKdyNFKpABahPTb6T9N7b5QY98AmU7MgFRmBeRx+0Q7EwBuYaTdr6ZS7y+cfUz7MN+ZgT5ZVcVtR4tJgnbHXie14=
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com (20.178.46.222) by
	DB7PR08MB3803.eurprd08.prod.outlook.com (20.178.46.210) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1771.18; Mon, 8 Apr 2019 14:57:20 +0000
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949]) by
	DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949%3]) with mapi id 15.20.1771.021;
	Mon, 8 Apr 2019 14:57:20 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, Qemu-block <qemu-block@nongnu.org>
Thread-Topic: Aborts in iotest 169
Thread-Index: AQHUszMnxFyCYJwHb0WZSNOkLXojU6Yy0FGA
Date: Mon, 8 Apr 2019 14:57:20 +0000
Message-ID: <471e5ea1-cafb-c9b6-129e-07e9007122d6@virtuozzo.com>
References: <3da8da19-72dc-8f5e-f2e1-820999994cb2@redhat.com>
In-Reply-To: <3da8da19-72dc-8f5e-f2e1-820999994cb2@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0402CA0023.eurprd04.prod.outlook.com
	(2603:10a6:3:d0::33) To DB7PR08MB3851.eurprd08.prod.outlook.com
	(2603:10a6:10:7b::30)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190408175717356
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d321501d-54da-45f7-5efd-08d6bc327fdf
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);
	SRVR:DB7PR08MB3803; 
x-ms-traffictypediagnostic: DB7PR08MB3803:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB7PR08MB38033740B404D981F07148DCC12C0@DB7PR08MB3803.eurprd08.prod.outlook.com>
x-forefront-prvs: 0001227049
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(136003)(396003)(346002)(39840400004)(366004)(376002)(199004)(189003)(4326008)(7116003)(6246003)(97736004)(2906002)(8936002)(186003)(316002)(446003)(11346002)(476003)(2616005)(26005)(486006)(14444005)(110136005)(99286004)(54906003)(305945005)(5660300002)(7736002)(66066001)(53936002)(31686004)(5024004)(256004)(8676002)(81156014)(81166006)(106356001)(52116002)(6512007)(6306002)(68736007)(14454004)(3846002)(6436002)(76176011)(71190400001)(36756003)(6486002)(6506007)(6116002)(86362001)(386003)(25786009)(102836004)(31696002)(71200400001)(478600001)(966005)(105586002)(229853002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:DB7PR08MB3803;
	H:DB7PR08MB3851.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Hey+PQqSiiPvua9bAeVgHt0OuE6/c9fXfRKCrMUx6Jyjs7wu0aTWCEykndQ5thi/eJNudALNL294IbZKgUTG4w9P1kgrOYiCGDZYALNxVOvMM0+nX4fR/b60qjafHAQ8Spo5uNfEnTGMIRdwt+V7Glm7sqnAFYobnP16G0HRlJ1uZBXOZBmuziSAsKf25oNcfi7G5bt1FCzf1QhnHbD8IPxk3Dy8k1Rn4wFZLw0Y4OjA7A12qV399f1pJYw3/nRmD2KOt5GTSfCxbNGvWSZYG2waQYvz1Oxg4uffTqlRKkDzvsdNdnYlTfleH6x1mfCWSs9zSwjX3cKR1fDUSznO2i2rP9aJ1/BQLY43wS+MPmXnRrAsRk9YxjFVGVBd3H5IFvKQ1NxPZvUSipDYTyjnr+wxOXSYJTRSmtOpbDA+MnA=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <50DE7AE92B3F04419092AAC8169DB580@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d321501d-54da-45f7-5efd-08d6bc327fdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2019 14:57:20.2468 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3803
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.92
Subject: Re: [Qemu-devel] Aborts in iotest 169
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	Luiz Capitulino <lcapitulino@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408145720.wmwKqQeJlEgQ6aOn6K8Jr5EGOqqDcaW-G45zH8m5uOs@z>

MjMuMDEuMjAxOSAxODo0OCwgTWF4IFJlaXR6IHdyb3RlOg0KPiBIaSwNCj4gDQo+IFdoZW4gcnVu
bmluZyAxNjkgaW4gcGFyYWxsZWwgKGUuZy4gbGlrZSBzbzoNCj4gDQo+ICQgd2hpbGUgVEVTVF9E
SVI9L3RtcC90MCAuL2NoZWNrIC1UIC1xY293MiAxNjk7IGRvOyBkb25lDQo+ICQgd2hpbGUgVEVT
VF9ESVI9L3RtcC90MSAuL2NoZWNrIC1UIC1xY293MiAxNjk7IGRvOyBkb25lDQo+ICQgd2hpbGUg
VEVTVF9ESVI9L3RtcC90MiAuL2NoZWNrIC1UIC1xY293MiAxNjk7IGRvOyBkb25lDQo+ICQgd2hp
bGUgVEVTVF9ESVI9L3RtcC90MyAuL2NoZWNrIC1UIC1xY293MiAxNjk7IGRvOyBkb25lDQo+IA0K
PiBpbiBmb3VyIGRpZmZlcmVudCBzaGVsbHMpLCBJIGdldCBhYm9ydHM6DQo+IA0KPiAoT2Z0ZW4g
SSBnZXQgc2VnZmF1bHRzLCBidXQgdGhhdCdzIGJlY2F1c2Ugb2YNCj4gaHR0cDovL2xpc3RzLm5v
bmdudS5vcmcvYXJjaGl2ZS9odG1sL3FlbXUtZGV2ZWwvMjAxOC0xMi9tc2cwNTU3OS5odG1sIC0t
DQo+IGZlZWwgZnJlZSB0byBhcHBseSB0aGUgYXR0YWNoZWQgcGF0Y2ggdG8gbWFrZSB0aGVtIGdv
IGF3YXkpDQoNCkhpLA0KDQpEaWRuJ3QgeW91IHNlbmQgaXQgaW4gc2VwYXJhdGU/IGlvdGVzdHMg
c3RpbGwgZmFpbHMgc29tZXRpbWVzIHdpdGggc2VnZmF1bHQNCmluIGNoYXJkZXYgY29kZS4uLg0K
DQo+IA0KPiANCj4gV0FSTklORzpxZW11OnFlbXUgcmVjZWl2ZWQgc2lnbmFsIDY6DQo+IGJ1aWxk
L3Rlc3RzL3FlbXUtaW90ZXN0cy8uLi8uLi94ODZfNjQtc29mdG1tdS9xZW11LXN5c3RlbS14ODZf
NjQNCj4gLWNoYXJkZXYgc29ja2V0LGlkPW1vbixwYXRoPS90bXAvdDAvdG1wYlgzMFhVL3FlbXVh
LTI1NzQ1LW1vbml0b3Iuc29jaw0KPiAtbW9uIGNoYXJkZXY9bW9uLG1vZGU9Y29udHJvbCAtZGlz
cGxheSBub25lIC12Z2Egbm9uZSAtcXRlc3QNCj4gdW5peDpwYXRoPS90bXAvdDAvcWVtdWEtMjU3
NDUtcXRlc3Quc29jayAtbWFjaGluZSBhY2NlbD1xdGVzdA0KPiAtbm9kZWZhdWx0cyAtbWFjaGlu
ZSBhY2NlbD1xdGVzdCAtZHJpdmUNCj4gaWY9dmlydGlvLGlkPWRyaXZlMCxmaWxlPS90bXAvdDAv
ZGlza19hLGZvcm1hdD1xY293MixjYWNoZT13cml0ZWJhY2sNCj4gLi4uLi4uLi4uLi4uLi4uLi5F
Li4NCj4gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PQ0KPiBFUlJPUjoNCj4gdGVzdF9kb190ZXN0X21pZ3JhdGlvbl9y
ZXN1bWVfc291cmNlX25vdF9wZXJzaXN0ZW50X19ub3RfbWlnYml0bWFwDQo+IChfX21haW5fXy5U
ZXN0RGlydHlCaXRtYXBNaWdyYXRpb24pDQo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gVHJhY2ViYWNrICht
b3N0IHJlY2VudCBjYWxsIGxhc3QpOg0KPiAgICBGaWxlICIxNjkiLCBsaW5lIDIwNiwgaW4gPGxh
bWJkYT4NCj4gICAgICBzZXRhdHRyKGtsYXNzLCAndGVzdF8nICsgbWV0aG9kICsgbmFtZSwgbGFt
YmRhIHNlbGY6IG1jKHNlbGYpKQ0KPiAgICBGaWxlICIxNjkiLCBsaW5lIDExMywgaW4gZG9fdGVz
dF9taWdyYXRpb25fcmVzdW1lX3NvdXJjZQ0KPiAgICAgIHNlbGYuY2hlY2tfYml0bWFwKHNlbGYu
dm1fYSwgc2hhMjU2KQ0KPiAgICBGaWxlICIxNjkiLCBsaW5lIDcyLCBpbiBjaGVja19iaXRtYXAN
Cj4gICAgICBub2RlPSdkcml2ZTAnLCBuYW1lPSdiaXRtYXAwJykNCj4gICAgRmlsZSAidGVzdHMv
cWVtdS1pb3Rlc3RzLy4uLy4uL3NjcmlwdHMvcWVtdS5weSIsIGxpbmUgMzY5LCBpbiBxbXANCj4g
ICAgICByZXR1cm4gc2VsZi5fcW1wLmNtZChjbWQsIGFyZ3M9cW1wX2FyZ3MpDQo+ICAgIEZpbGUg
InRlc3RzL3FlbXUtaW90ZXN0cy8uLi8uLi9zY3JpcHRzL3FtcC9xbXAucHkiLCBsaW5lIDE5MSwg
aW4gY21kDQo+ICAgICAgcmV0dXJuIHNlbGYuY21kX29iaihxbXBfY21kKQ0KPiAgICBGaWxlICJ0
ZXN0cy9xZW11LWlvdGVzdHMvLi4vLi4vc2NyaXB0cy9xbXAvcW1wLnB5IiwgbGluZSAxNzQsIGlu
IGNtZF9vYmoNCj4gICAgICByZXNwID0gc2VsZi5fX2pzb25fcmVhZCgpDQo+ICAgIEZpbGUgInRl
c3RzL3FlbXUtaW90ZXN0cy8uLi8uLi9zY3JpcHRzL3FtcC9xbXAucHkiLCBsaW5lIDgyLCBpbg0K
PiBfX2pzb25fcmVhZA0KPiAgICAgIGRhdGEgPSBzZWxmLl9fc29ja2ZpbGUucmVhZGxpbmUoKQ0K
PiAgICBGaWxlICIvdXNyL2xpYjY0L3B5dGhvbjIuNy9zb2NrZXQucHkiLCBsaW5lIDQ1MSwgaW4g
cmVhZGxpbmUNCj4gICAgICBkYXRhID0gc2VsZi5fc29jay5yZWN2KHNlbGYuX3JidWZzaXplKQ0K
PiBlcnJvcjogW0Vycm5vIDEwNF0gQ29ubmVjdGlvbiByZXNldCBieSBwZWVyDQo+IA0KPiAtLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tDQo+IFJhbiAyMCB0ZXN0cw0KPiANCj4gRkFJTEVEIChlcnJvcnM9MSkNCj4gDQo+
IA0KPiBPcjoNCj4gDQo+IFdBUk5JTkc6cWVtdTpxZW11IHJlY2VpdmVkIHNpZ25hbCA2Og0KPiBi
dWlsZC90ZXN0cy9xZW11LWlvdGVzdHMvLi4vLi4veDg2XzY0LXNvZnRtbXUvcWVtdS1zeXN0ZW0t
eDg2XzY0DQo+IC1jaGFyZGV2IHNvY2tldCxpZD1tb24scGF0aD0vdG1wL3QzL3RtcDBwbGxXRC9x
ZW11YS0zNDQ1LW1vbml0b3Iuc29jaw0KPiAtbW9uIGNoYXJkZXY9bW9uLG1vZGU9Y29udHJvbCAt
ZGlzcGxheSBub25lIC12Z2Egbm9uZSAtcXRlc3QNCj4gdW5peDpwYXRoPS90bXAvdDMvcWVtdWEt
MzQ0NS1xdGVzdC5zb2NrIC1tYWNoaW5lIGFjY2VsPXF0ZXN0IC1ub2RlZmF1bHRzDQo+IC1tYWNo
aW5lIGFjY2VsPXF0ZXN0IC1kcml2ZQ0KPiBpZj12aXJ0aW8saWQ9ZHJpdmUwLGZpbGU9L3RtcC90
My9kaXNrX2EsZm9ybWF0PXFjb3cyLGNhY2hlPXdyaXRlYmFjaw0KPiBXQVJOSU5HOnFlbXU6cWVt
dSByZWNlaXZlZCBzaWduYWwgNjoNCj4gYnVpbGQvdGVzdHMvcWVtdS1pb3Rlc3RzLy4uLy4uL3g4
Nl82NC1zb2Z0bW11L3FlbXUtc3lzdGVtLXg4Nl82NA0KPiAtY2hhcmRldiBzb2NrZXQsaWQ9bW9u
LHBhdGg9L3RtcC90My90bXAwcGxsV0QvcWVtdWEtMzQ0NS1tb25pdG9yLnNvY2sNCj4gLW1vbiBj
aGFyZGV2PW1vbixtb2RlPWNvbnRyb2wgLWRpc3BsYXkgbm9uZSAtdmdhIG5vbmUgLXF0ZXN0DQo+
IHVuaXg6cGF0aD0vdG1wL3QzL3FlbXVhLTM0NDUtcXRlc3Quc29jayAtbWFjaGluZSBhY2NlbD1x
dGVzdCAtbm9kZWZhdWx0cw0KPiAtbWFjaGluZSBhY2NlbD1xdGVzdCAtZHJpdmUNCj4gaWY9dmly
dGlvLGlkPWRyaXZlMCxmaWxlPS90bXAvdDMvZGlza19hLGZvcm1hdD1xY293MixjYWNoZT13cml0
ZWJhY2sNCj4gDQo+IC4uLi4uLi4uLi4uLi4uLi4uLi5GDQo+ID09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCj4gRkFJ
TDogdGVzdF9kb190ZXN0X21pZ3JhdGlvbl9yZXN1bWVfc291cmNlX3BlcnNpc3RlbnRfX25vdF9t
aWdiaXRtYXANCj4gKF9fbWFpbl9fLlRlc3REaXJ0eUJpdG1hcE1pZ3JhdGlvbikNCj4gLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQ0KPiBUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6DQo+ICAgIEZpbGUg
IjE2OSIsIGxpbmUgMjA2LCBpbiA8bGFtYmRhPg0KPiAgICAgIHNldGF0dHIoa2xhc3MsICd0ZXN0
XycgKyBtZXRob2QgKyBuYW1lLCBsYW1iZGEgc2VsZjogbWMoc2VsZikpDQo+ICAgIEZpbGUgIjE2
OSIsIGxpbmUgMTI1LCBpbiBkb190ZXN0X21pZ3JhdGlvbl9yZXN1bWVfc291cmNlDQo+ICAgICAg
c2VsZi5hc3NlcnRFcXVhbChsb2csICcnKQ0KPiBBc3NlcnRpb25FcnJvcjogInFlbXUtc3lzdGVt
LXg4Nl82NDogaW52YWxpZCBydW5zdGF0ZSB0cmFuc2l0aW9uOg0KPiAncnVubmluZycgLT4gJ3Bv
c3RtaWdyYXRlJ1xuIiAhPSAnJw0KPiANCj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiBSYW4gMjAgdGVzdHMN
Cj4gDQo+IEZBSUxFRCAoZmFpbHVyZXM9MSkNCj4gDQo+IA0KPiBUaGUgYmFja3RyYWNlIGFsd2F5
cyBnb2VzIGxpa2UgdGhpczoNCj4gDQo+IChnZGIpIGJ0DQo+ICMwICAweDAwMDA3ZjBhY2Y1Y2M1
M2YgaW4gcmFpc2UgKCkgYXQgL2xpYjY0L2xpYmMuc28uNg0KPiAjMSAgMHgwMDAwN2YwYWNmNWI2
ODk1IGluIGFib3J0ICgpIGF0IC9saWI2NC9saWJjLnNvLjYNCj4gIzIgIDB4MDAwMDU1YTQ2ZWJi
YjFhNiBpbiBydW5zdGF0ZV9zZXQgKG5ld19zdGF0ZT1SVU5fU1RBVEVfUE9TVE1JR1JBVEUpDQo+
IGF0IHZsLmM6NzQyDQo+ICMzICAweDAwMDA1NWE0NmViYmIxYTYgaW4gcnVuc3RhdGVfc2V0DQo+
IChuZXdfc3RhdGU9bmV3X3N0YXRlQGVudHJ5PVJVTl9TVEFURV9QT1NUTUlHUkFURSkgYXQgdmwu
Yzo3MzANCj4gIzQgIDB4MDAwMDU1YTQ2ZWQzOTEyOSBpbiBtaWdyYXRpb25faXRlcmF0aW9uX2Zp
bmlzaCAocz0weDU1YTQ3MDhiZTAwMCkNCj4gYXQgbWlncmF0aW9uL21pZ3JhdGlvbi5jOjI5NzIN
Cj4gIzUgIDB4MDAwMDU1YTQ2ZWQzOTEyOSBpbiBtaWdyYXRpb25fdGhyZWFkDQo+IChvcGFxdWU9
b3BhcXVlQGVudHJ5PTB4NTVhNDcwOGJlMDAwKSBhdCBtaWdyYXRpb24vbWlncmF0aW9uLmM6MzEz
MA0KPiAjNiAgMHgwMDAwNTVhNDZlZWE2NjVhIGluIHFlbXVfdGhyZWFkX3N0YXJ0IChhcmdzPTxv
cHRpbWl6ZWQgb3V0PikgYXQNCj4gdXRpbC9xZW11LXRocmVhZC1wb3NpeC5jOjUwMg0KPiANCj4g
DQo+ICM3ICAweDAwMDA3ZjBhY2Y3NjI1OGUgaW4gc3RhcnRfdGhyZWFkICgpIGF0IC9saWI2NC9s
aWJwdGhyZWFkLnNvLjANCj4gIzggIDB4MDAwMDdmMGFjZjY5MTZhMyBpbiBjbG9uZSAoKSBhdCAv
bGliNjQvbGliYy5zby42DQo+IChnZGIpIGZyYW1lIDINCj4gIzIgIDB4MDAwMDU1YTQ2ZWJiYjFh
NiBpbiBydW5zdGF0ZV9zZXQgKG5ld19zdGF0ZT1SVU5fU1RBVEVfUE9TVE1JR1JBVEUpDQo+IGF0
IHZsLmM6NzQyDQo+IDc0MiAgICAgICAgICAgICBhYm9ydCgpOw0KPiAoZ2RiKSBwcmludCBjdXJy
ZW50X3J1bl9zdGF0ZQ0KPiAkMSA9IFJVTl9TVEFURV9SVU5OSU5HDQo+IA0KPiANCj4gTmVpdGhl
ciBvZiBtaWdyYXRpb24gb3IgcnVuc3RhdGVzIGFyZSBteSBzdHJvbmcgc3VpdGUsIHNvIEkgdGhv
dWdodCBJJ2QNCj4gcmVwb3J0IGl0IGJlZm9yZSBkaXZpbmcgaW50byBpdC4NCj4gDQo+IE1heA0K
PiANCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

