Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842BAC10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 13:52:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E326213F2
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 13:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ZvbBAt42"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E326213F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53479 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDUhi-0006z3-Ev
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 09:52:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hDUgn-0006aP-6t
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 09:51:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hDUgl-0007kQ-US
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 09:51:57 -0400
Received: from mail-eopbgr80115.outbound.protection.outlook.com
	([40.107.8.115]:20715
	helo=EUR04-VI1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hDUgi-0007hv-ER; Mon, 08 Apr 2019 09:51:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=82EMThwMRLzRUhe9P7RYhT8GoZa9hcuGu9FvSjT1fMA=;
	b=ZvbBAt42G0T1TzCJ4b+sRHNKt/158+3GQy5WxqGhaepmkPqfZoo445+JFoxeq8y++xqQDcdcsfGampOU8M7E1dwjQ1JYgtNOWJsI5vKBeIkSZjMscUhMtpeu21L9Nd//SRxiwuIP+v4M0wjHY4CLfHBnBrkIqak8pmHflivmc5k=
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com (20.178.46.222) by
	DB7PR08MB3289.eurprd08.prod.outlook.com (52.134.111.27) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1771.19; Mon, 8 Apr 2019 13:51:47 +0000
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949]) by
	DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949%3]) with mapi id 15.20.1771.021;
	Mon, 8 Apr 2019 13:51:47 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>
Thread-Topic: [PATCH 4/7] iotests: Update 241 to expose backing layer
	fragmentation
Thread-Index: AQHU6codgi5M7m/JxEicxYLuupn+3qYyUNIA
Date: Mon, 8 Apr 2019 13:51:46 +0000
Message-ID: <7f20c0df-5ff3-cd2f-391f-3dae1a4cb51c@virtuozzo.com>
References: <20190403030526.12258-1-eblake@redhat.com>
	<20190403030526.12258-5-eblake@redhat.com>
In-Reply-To: <20190403030526.12258-5-eblake@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0210.eurprd05.prod.outlook.com
	(2603:10a6:3:f9::34) To DB7PR08MB3851.eurprd08.prod.outlook.com
	(2603:10a6:10:7b::30)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190408165144442
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 23b631bb-2b96-42ff-975c-08d6bc29575c
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);
	SRVR:DB7PR08MB3289; 
x-ms-traffictypediagnostic: DB7PR08MB3289:
x-microsoft-antispam-prvs: <DB7PR08MB32896D467625FBCC332D030FC12C0@DB7PR08MB3289.eurprd08.prod.outlook.com>
x-forefront-prvs: 0001227049
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(136003)(376002)(366004)(396003)(346002)(39840400004)(199004)(189003)(8676002)(14444005)(6506007)(386003)(68736007)(97736004)(4326008)(2501003)(256004)(26005)(99286004)(186003)(36756003)(6436002)(2616005)(31686004)(25786009)(305945005)(7736002)(11346002)(476003)(446003)(102836004)(5660300002)(52116002)(81156014)(81166006)(478600001)(8936002)(14454004)(76176011)(486006)(229853002)(6246003)(86362001)(316002)(31696002)(6512007)(71200400001)(3846002)(6116002)(110136005)(54906003)(2906002)(71190400001)(66066001)(53936002)(105586002)(6486002)(106356001);
	DIR:OUT; SFP:1102; SCL:1; SRVR:DB7PR08MB3289;
	H:DB7PR08MB3851.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sfxlWaQmitgO921PjWGjQNh3iNdkkEE+9fJ/ebPyoHREYfnV3iUsdXnhZ37Kv8izcRuF7o2ehJPIunUs3Ejg2DbFBIUBrWqQNw7bgylV8Yqi2Ho7iyyUBS4Zr7Ft0rMH4hGoipgEhgns4F+ASAQxrYrGAg12auzo4skOzbEAEECr2dIpdXt3zgAUyA357s66qtPEEAlCBTetP8wbZMGYLaL28nL1B4FVRA2ycow/1wej+KMhaSSsG1SM5rv/2cQ4+iLWSWLUwelRPSZ6sGeu9gv6lz5ZzvW32aeSTirTFxeJaEtACLS38J3sCUucE/QhYAgxAGNWMqf45S6xOPSj5WP1Ok4tBdWuAL7HpTJiSTaCtbFMvWrZvy/JTId1oBU8wk1MwWOzzAP6xUFqdrFKmvia7mopDFpLMIwjzJH5MMM=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <A1D0882FADB5A74194D6064C3DEEF36E@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23b631bb-2b96-42ff-975c-08d6bc29575c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2019 13:51:47.1415 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3289
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.115
Subject: Re: [Qemu-devel] [PATCH 4/7] iotests: Update 241 to expose backing
 layer fragmentation
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
Cc: Kevin Wolf <kwolf@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>,
	Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408135146.RnnrQJIa8rndNIBh_ikQd6VDHXv89Dc6jbFKNuw_O2k@z>

MDMuMDQuMjAxOSA2OjA1LCBFcmljIEJsYWtlIHdyb3RlOg0KPiBQcmV2aW91cyBjb21taXRzIGhh
dmUgbWVudGlvbmVkIHRoYXQgb3VyIE5CRCBzZXJ2ZXIgc3RpbGwgc2VuZHMNCj4gdW5hbGlnbmVk
IGZyYWdtZW50cyB3aGVuIGFuIGFjdGl2ZSBsYXllciB3aXRoIGxhcmdlIGFkdmVydGlzZWQgbWlu
aW11bQ0KPiBibG9jayBzaXplIGlzIGJhY2tlZCBieSBhbm90aGVyIGxheWVyIHdpdGggYSBzbWFs
bGVyIGJsb2NrDQo+IHNpemUuIEV4cGFuZCB0aGUgdGVzdCB0byBhY3R1YWxseSBjb3ZlciB0aGlz
IHNjZW5hcmlvLCBieSB1c2luZyBxY293Mg0KPiBlbmNyeXB0aW9uICh3aGljaCBmb3JjZXMgNTEy
LWJ5dGUgYWxpZ25tZW50KSB3aXRoIGFuIHVuYWxpZ25lZCByYXcNCj4gYmFja2luZyBmaWxlLg0K
PiANCj4gVGhlIHRlc3QgcGFzc2VzLCBidXQgb25seSBiZWNhdXNlIHRoZSBjbGllbnQgc2lkZSB3
b3JrcyBhcm91bmQgdGhlDQo+IHNlcnZlcidzIG5vbi1jb21wbGlhbmNlOyBpZiB5b3UgcmVwZWF0
IHRoZSB0ZXN0IG1hbnVhbGx5IHdpdGggdHJhY2luZw0KPiB0dXJuZWQgb24sIHlvdSB3aWxsIHNl
ZSB0aGUgc2VydmVyIHNlbmRpbmcgYSBzdGF0dXMgZm9yIDEwMDAgYnl0ZXMNCj4gZGF0YSB0aGVu
IDEwNDggYnl0ZXMgaG9sZSwgd2hpY2ggaXMgbm90IGFsaWduZWQuIEJ1dCByZXZlcnRpbmcgY29t
bWl0DQo+IDczN2QzZjUyNDQgc2hvd3MgdGhhdCBpdCBpcyBpbmRlZWQgdGhlIGNsaWVudCB3b3Jr
aW5nIGFyb3VuZCB0aGUgYnVnDQo+IGluIHRoZSBzZXJ2ZXIuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBFcmljIEJsYWtlIDxlYmxha2VAcmVkaGF0LmNvbT4NCg0KT29wcywgMjQxIGZhaWxzIGZvciBt
ZToNCg0KLVdBUk5JTkc6IEltYWdlIGZvcm1hdCB3YXMgbm90IHNwZWNpZmllZCBmb3IgJy9ob21l
L2VibGFrZS9xZW11L3Rlc3RzL3FlbXUtaW90ZXN0cy9zY3JhdGNoL3QucmF3JyBhbmQgcHJvYmlu
ZyBndWVzc2VkIHJhdy4NCitXQVJOSU5HOiBJbWFnZSBmb3JtYXQgd2FzIG5vdCBzcGVjaWZpZWQg
Zm9yICcvd29yay9zcmMvcWVtdS9lcmljL3Rlc3RzL3FlbXUtaW90ZXN0cy9zY3JhdGNoL3QucmF3
JyBhbmQgcHJvYmluZyBndWVzc2VkIHJhdy4NCg0KV2UgZm9yZ2V0IHRvIGZpbHRlciBvdXRwdXQg
OigNCg0KVGVzdGVkLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292
QHZpcnR1b3p6by5jb20+DQoNCj4gLS0tDQo+ICAgdGVzdHMvcWVtdS1pb3Rlc3RzLzI0MSAgICAg
fCAyMCArKysrKysrKysrKysrKysrKysrLQ0KPiAgIHRlc3RzL3FlbXUtaW90ZXN0cy8yNDEub3V0
IHwgIDkgKysrKysrKysrDQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCAyOCBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdGVzdHMvcWVtdS1pb3Rlc3RzLzI0MSBi
L3Rlc3RzL3FlbXUtaW90ZXN0cy8yNDENCj4gaW5kZXggNGIxOTY4NTczODcuLmMxZmE2OTgwZGM4
IDEwMDc1NQ0KPiAtLS0gYS90ZXN0cy9xZW11LWlvdGVzdHMvMjQxDQo+ICsrKyBiL3Rlc3RzL3Fl
bXUtaW90ZXN0cy8yNDENCj4gQEAgLTI4LDYgKzI4LDcgQEAgbmJkX3VuaXhfc29ja2V0PSRURVNU
X0RJUi90ZXN0X3FlbXVfbmJkX3NvY2tldA0KPiAgIF9jbGVhbnVwKCkNCj4gICB7DQo+ICAgICAg
IF9jbGVhbnVwX3Rlc3RfaW1nDQo+ICsgICAgcm0gLWYgIiRURVNUX0lNQUdFX0ZJTEUucWNvdzIi
DQoNCnlvdSBtZWFuIF9JTUdfLCBub3QgX0lNQUdFXy4NCg0KUmV2aWV3ZWQtYnk6IFZsYWRpbWly
IFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCg0KPiAgICAg
ICBuYmRfc2VydmVyX3N0b3ANCj4gICB9DQo+ICAgdHJhcCAiX2NsZWFudXA7IGV4aXQgXCRzdGF0
dXMiIDAgMSAyIDMgMTUNCj4gQEAgLTM3LDcgKzM4LDcgQEAgdHJhcCAiX2NsZWFudXA7IGV4aXQg
XCRzdGF0dXMiIDAgMSAyIDMgMTUNCj4gICAuIC4vY29tbW9uLmZpbHRlcg0KPiAgIC4gLi9jb21t
b24ubmJkDQo+IA0KPiAtX3N1cHBvcnRlZF9mbXQgcmF3DQo+ICtfc3VwcG9ydGVkX2ZtdCByYXcg
IyBhbHRob3VnaCB0aGUgdGVzdCBhbHNvIHJlcXVpcmVzIHVzZSBvZiBxY293Mg0KPiAgIF9zdXBw
b3J0ZWRfcHJvdG8gbmJkDQo+ICAgX3N1cHBvcnRlZF9vcyBMaW51eA0KPiAgIF9yZXF1aXJlX2Nv
bW1hbmQgUUVNVV9OQkQNCj4gQEAgLTg4LDYgKzg5LDIzIEBAICRRRU1VX0lNRyBtYXAgLS1vdXRw
dXQ9anNvbiAiJFRFU1RfSU1HIiB8IF9maWx0ZXJfcWVtdV9pbWdfbWFwDQo+ICAgJFFFTVVfSU8g
LWMgbWFwICIkVEVTVF9JTUciDQo+ICAgbmJkX3NlcnZlcl9zdG9wDQo+IA0KPiArZWNobw0KPiAr
ZWNobyAiPT09IEVuY3J5cHRlZCBxY293MiBmaWxlIGJhY2tlZCBieSB1bmFsaWduZWQgcmF3IGlt
YWdlICA9PT0iDQo+ICtlY2hvDQo+ICsNCj4gKyMgRW5hYmxpbmcgZW5jcnlwdGlvbiBpbiBxY293
MiBmb3JjZXMgNTEyLWFsaWdubWVudA0KPiArU0VDUkVUPXNlY3JldCxpZD1zZWMwLGRhdGE9MTIz
NDUNCj4gKyRRRU1VX0lNRyBjcmVhdGUgLWYgcWNvdzIgLWIgIiRURVNUX0lNR19GSUxFIiAtRiBy
YXcgLS1vYmplY3QgIiRTRUNSRVQiIFwNCj4gKyAgLW8gZW5jcnlwdC5mb3JtYXQ9bHVrcyxlbmNy
eXB0LmtleS1zZWNyZXQ9c2VjMCxlbmNyeXB0Lml0ZXItdGltZT0xMCBcDQo+ICsgICIkVEVTVF9J
TUdfRklMRS5xY293MiIgMmsgfCBfZmlsdGVyX2ltZ19jcmVhdGUNCj4gK25iZF9zZXJ2ZXJfc3Rh
cnRfdW5peF9zb2NrZXQgLS1vYmplY3QgIiRTRUNSRVQiIC0taW1hZ2Utb3B0cyBcDQo+ICsgIGRy
aXZlcj1xY293MixmaWxlLmZpbGVuYW1lPSIkVEVTVF9JTUdfRklMRS5xY293MiIsZW5jcnlwdC5r
ZXktc2VjcmV0PXNlYzANCj4gKw0KPiArJFFFTVVfTkJEX1BST0cgLS1saXN0IC1rICRuYmRfdW5p
eF9zb2NrZXQgfCBncmVwICdcKHNpemVcfG1pblwpJw0KPiArJFFFTVVfSU1HIG1hcCAtLW91dHB1
dD1qc29uICIkVEVTVF9JTUciIHwgX2ZpbHRlcl9xZW11X2ltZ19tYXANCj4gKyRRRU1VX0lPIC1j
IG1hcCAiJFRFU1RfSU1HIg0KPiArbmJkX3NlcnZlcl9zdG9wDQo+ICsNCj4gICAjIE5vdCB0ZXN0
ZWQgeWV0OiB3ZSBhbHNvIHdhbnQgdG8gZW5zdXJlIHRoYXQgcWVtdSBhcyBOQkQgY2xpZW50IGRv
ZXMNCj4gICAjIG5vdCBhY2Nlc3MgYmV5b25kIHRoZSBlbmQgb2YgYSBzZXJ2ZXIncyBhZHZlcnRp
c2VkIHVuYWxpZ25lZCBzaXplOg0KPiAgICMgIG5iZGtpdCAtVSAtIG1lbW9yeSBzaXplPTUxMyAt
LXJ1biAncWVtdS1pbyAtZiByYXcgLWMgInIgNTEyIDUxMiIgJG5iZCcNCj4gZGlmZiAtLWdpdCBh
L3Rlc3RzL3FlbXUtaW90ZXN0cy8yNDEub3V0IGIvdGVzdHMvcWVtdS1pb3Rlc3RzLzI0MS5vdXQN
Cj4gaW5kZXggZjQ4MTA3NGEwMmUuLmVmN2RlMTIwNWQyIDEwMDY0NA0KPiAtLS0gYS90ZXN0cy9x
ZW11LWlvdGVzdHMvMjQxLm91dA0KPiArKysgYi90ZXN0cy9xZW11LWlvdGVzdHMvMjQxLm91dA0K
PiBAQCAtMjUsNCArMjUsMTMgQEAgV0FSTklORzogSW1hZ2UgZm9ybWF0IHdhcyBub3Qgc3BlY2lm
aWVkIGZvciAnL2hvbWUvZWJsYWtlL3FlbXUvdGVzdHMvcWVtdS1pb3Rlc3QNCj4gICBbeyAic3Rh
cnQiOiAwLCAibGVuZ3RoIjogMTAwMCwgImRlcHRoIjogMCwgInplcm8iOiBmYWxzZSwgImRhdGEi
OiB0cnVlLCAib2Zmc2V0IjogT0ZGU0VUfSwNCj4gICB7ICJzdGFydCI6IDEwMDAsICJsZW5ndGgi
OiAyNCwgImRlcHRoIjogMCwgInplcm8iOiB0cnVlLCAiZGF0YSI6IHRydWUsICJvZmZzZXQiOiBP
RkZTRVR9XQ0KPiAgIDEgS2lCICgweDQwMCkgYnl0ZXMgICAgIGFsbG9jYXRlZCBhdCBvZmZzZXQg
MCBieXRlcyAoMHgwKQ0KPiArDQo+ICs9PT0gRW5jcnlwdGVkIHFjb3cyIGZpbGUgYmFja2VkIGJ5
IHVuYWxpZ25lZCByYXcgaW1hZ2UgID09PQ0KPiArDQo+ICtGb3JtYXR0aW5nICdURVNUX0RJUi90
LklNR0ZNVC5xY293MicsIGZtdD1xY293MiBzaXplPTIwNDggYmFja2luZ19maWxlPVRFU1RfRElS
L3QuSU1HRk1UIGJhY2tpbmdfZm10PUlNR0ZNVCBlbmNyeXB0LmZvcm1hdD1sdWtzIGVuY3J5cHQu
a2V5LXNlY3JldD1zZWMwIGVuY3J5cHQuaXRlci10aW1lPTEwDQo+ICsgIHNpemU6ICAyMDQ4DQo+
ICsgIG1pbiBibG9jazogNTEyDQo+ICtbeyAic3RhcnQiOiAwLCAibGVuZ3RoIjogMTAyNCwgImRl
cHRoIjogMCwgInplcm8iOiBmYWxzZSwgImRhdGEiOiB0cnVlLCAib2Zmc2V0IjogT0ZGU0VUfSwN
Cj4gK3sgInN0YXJ0IjogMTAyNCwgImxlbmd0aCI6IDEwMjQsICJkZXB0aCI6IDAsICJ6ZXJvIjog
dHJ1ZSwgImRhdGEiOiBmYWxzZSwgIm9mZnNldCI6IE9GRlNFVH1dDQo+ICsyIEtpQiAoMHg4MDAp
IGJ5dGVzICAgICBhbGxvY2F0ZWQgYXQgb2Zmc2V0IDAgYnl0ZXMgKDB4MCkNCj4gICAqKiogZG9u
ZQ0KPiANCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

