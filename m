Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76346C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 07:58:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B6162133D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 07:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="JQkejJz5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B6162133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43479 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEUb2-0006Vc-HE
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 03:58:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hEUaH-00069h-57
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 03:57:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hEUaF-0004WY-Q4
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 03:57:21 -0400
Received: from mail-eopbgr60123.outbound.protection.outlook.com
	([40.107.6.123]:55553
	helo=EUR04-DB3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hEUaB-0004LX-4T; Thu, 11 Apr 2019 03:57:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=zpmmAZFuaOus0UJ73Liof9gkIit0tlaF/LbomLnvrlU=;
	b=JQkejJz520ISts1SBPMKBIkMuqfD4iC59njHwf56IGR/qIIMTv0h/ndgp7h+Ka6QnPE44Am8MekYah64lRKQ6cSSeQFk4M0KglQfn30mKGjGOEiknuVk8MfsDEmjI4g2qNC6b7GEBscYju1vQkN8znEG+5C4YwQUfjmQgNKDE0w=
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com (20.178.46.222) by
	DB7PR08MB3705.eurprd08.prod.outlook.com (20.178.46.32) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1771.16; Thu, 11 Apr 2019 07:57:09 +0000
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949]) by
	DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949%3]) with mapi id 15.20.1771.021;
	Thu, 11 Apr 2019 07:57:09 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>
Thread-Topic: [PATCH for-4.0?] iotest: Fix 241 to run in generic directory
Thread-Index: AQHU794br5Dm4Z3L90Owhq8BvbeODqY2mJSA
Date: Thu, 11 Apr 2019 07:57:09 +0000
Message-ID: <61e3b78b-4daf-eebc-7e8b-860c57658933@virtuozzo.com>
References: <20190410204215.5963-1-eblake@redhat.com>
In-Reply-To: <20190410204215.5963-1-eblake@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0172.eurprd05.prod.outlook.com
	(2603:10a6:3:f8::20) To DB7PR08MB3851.eurprd08.prod.outlook.com
	(2603:10a6:10:7b::30)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190411105706952
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d54af721-37de-47e8-5b90-08d6be534c41
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);
	SRVR:DB7PR08MB3705; 
x-ms-traffictypediagnostic: DB7PR08MB3705:
x-microsoft-antispam-prvs: <DB7PR08MB37050FC3C0106A9AE584ADB5C12F0@DB7PR08MB3705.eurprd08.prod.outlook.com>
x-forefront-prvs: 00046D390F
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(376002)(39840400004)(346002)(396003)(366004)(136003)(199004)(189003)(6436002)(99286004)(3846002)(6116002)(6246003)(6486002)(76176011)(66066001)(97736004)(229853002)(6512007)(5660300002)(305945005)(52116002)(71190400001)(71200400001)(2501003)(14444005)(86362001)(105586002)(31686004)(7736002)(36756003)(53936002)(186003)(102836004)(386003)(256004)(26005)(6506007)(476003)(8936002)(316002)(8676002)(11346002)(446003)(2616005)(81166006)(81156014)(486006)(14454004)(478600001)(2906002)(4326008)(68736007)(110136005)(106356001)(31696002)(25786009)(54906003)(41533002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:DB7PR08MB3705;
	H:DB7PR08MB3851.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: blnPtd2V8MT0TeD+X4FkyMaQnaDqRwPI5hwNuTGl1rM1+soUhJp5SrhxpjjgzfV2ZvqrLSimSTV4D3oFe7V/p753n2axnWKyPMd8x4bp2asBQObMmshZ+O+lcF13NPwUhEGrC3PPJxKfcAST2nXuOigHJ2wRs0lpiOnm2EbPb4YEoBSI06RtfmFc6+9x+G7wtH+m/eJT3E5HZP0HbxWWXlAiN7TMwebTJovFH5Y4D+u5ixsetKbuHSP2AVMNd3xDUHYquOD59BH0i+zn1cl6G/y3aJwipHewzjyqb6kyLjJxCo9eTvxWRUHrVyaYnv+aQ4kfWdnUTYkdmrCZaIqi4j/8/e5hHKP5c+GKaLE6YJNrVsIlk8iZEOtn3R0gqHSeVQFTLI+NVxJQ07HULkxDwItReQqxkZXvoz9bFIZhoRI=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <DF693769F7DBCF459259172BF60F38D4@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d54af721-37de-47e8-5b90-08d6be534c41
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2019 07:57:09.3810 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3705
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.123
Subject: Re: [Qemu-devel] [PATCH for-4.0?] iotest: Fix 241 to run in generic
 directory
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>,
	"mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411075709.KL5vJ5dCopKbLzJ9h1FmJHvmOGxtNGIxoi_KvYflSdg@z>

MTAuMDQuMjAxOSAyMzo0MiwgRXJpYyBCbGFrZSB3cm90ZToNCj4gRmlsdGVyIHRoZSBxZW11LW5i
ZCBzZXJ2ZXIgb3V0cHV0IHRvIGdldCByaWQgb2YgYSBkaXJlY3QgcmVmZXJlbmNlDQo+IHRvIG15
IGJ1aWxkIGRpcmVjdG9yeS4NCj4gDQo+IEZpeGVzOiBlOWRjZTljYg0KPiBSZXBvcnRlZC1ieTog
TWF4IFJlaXR6IDxtcmVpdHpAcmVkaGF0LmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogRXJpYyBCbGFr
ZSA8ZWJsYWtlQHJlZGhhdC5jb20+DQo+IC0tLQ0KPiANCj4gTm90IHdvcnRoIC1yYzQgb24gaXRz
IG93biwgYnV0IGlmIHNvbWV0aGluZyBlbHNlIHBvcHMgdXAgdGhhdCByZXF1aXJlcw0KPiBhbm90
aGVyIHNwaW4sIEkgcGxhbiBvbiBhIHB1bGwgcmVxdWVzdCBmb3IgdGhpcyBvbmUuIE90aGVyd2lz
ZSBpdA0KPiBzbGlwcyB0byA0LjEsIGFuZCA0LjAganVzdCBoYXMgYSBicm9rZW4gaW90ZXN0Lg0K
PiANCj4gICB0ZXN0cy9xZW11LWlvdGVzdHMvMjQxICAgICB8IDQgKysrLQ0KPiAgIHRlc3RzL3Fl
bXUtaW90ZXN0cy8yNDEub3V0IHwgNiArKystLS0NCj4gICAyIGZpbGVzIGNoYW5nZWQsIDYgaW5z
ZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS90ZXN0cy9xZW11
LWlvdGVzdHMvMjQxIGIvdGVzdHMvcWVtdS1pb3Rlc3RzLzI0MQ0KPiBpbmRleCA0YjE5Njg1NzM4
Ny4uMDE3YTczNmFhYmEgMTAwNzU1DQo+IC0tLSBhL3Rlc3RzL3FlbXUtaW90ZXN0cy8yNDENCj4g
KysrIGIvdGVzdHMvcWVtdS1pb3Rlc3RzLzI0MQ0KPiBAQCAtMjgsNiArMjgsNyBAQCBuYmRfdW5p
eF9zb2NrZXQ9JFRFU1RfRElSL3Rlc3RfcWVtdV9uYmRfc29ja2V0DQo+ICAgX2NsZWFudXAoKQ0K
PiAgIHsNCj4gICAgICAgX2NsZWFudXBfdGVzdF9pbWcNCj4gKyAgICBybSAtZiAiJFRFU1RfRElS
L3NlcnZlci5sb2ciDQo+ICAgICAgIG5iZF9zZXJ2ZXJfc3RvcA0KPiAgIH0NCj4gICB0cmFwICJf
Y2xlYW51cDsgZXhpdCBcJHN0YXR1cyIgMCAxIDIgMyAxNQ0KPiBAQCAtNjksMTIgKzcwLDEzIEBA
IGVjaG8NCj4gDQo+ICAgIyBJbnRlbnRpb25hbGx5IG9taXQgJy1mJyB0byBmb3JjZSBpbWFnZSBw
cm9iaW5nLCB3aGljaCBpbiB0dXJuIGZvcmNlcw0KPiAgICMgc2VjdG9yIGFsaWdubWVudCwgaGVy
ZSBhdCB0aGUgc2VydmVyLg0KPiAtbmJkX3NlcnZlcl9zdGFydF91bml4X3NvY2tldCAiJFRFU1Rf
SU1HX0ZJTEUiDQo+ICtuYmRfc2VydmVyX3N0YXJ0X3VuaXhfc29ja2V0ICIkVEVTVF9JTUdfRklM
RSIgMj4gIiRURVNUX0RJUi9zZXJ2ZXIubG9nIg0KPiANCj4gICAkUUVNVV9OQkRfUFJPRyAtLWxp
c3QgLWsgJG5iZF91bml4X3NvY2tldCB8IGdyZXAgJ1woc2l6ZVx8bWluXCknDQo+ICAgJFFFTVVf
SU1HIG1hcCAtZiByYXcgLS1vdXRwdXQ9anNvbiAiJFRFU1RfSU1HIiB8IF9maWx0ZXJfcWVtdV9p
bWdfbWFwDQo+ICAgJFFFTVVfSU8gLWYgcmF3IC1jIG1hcCAiJFRFU1RfSU1HIg0KPiAgIG5iZF9z
ZXJ2ZXJfc3RvcA0KPiArY2F0ICIkVEVTVF9ESVIvc2VydmVyLmxvZyIgfCBfZmlsdGVyX3Rlc3Rk
aXINCj4gDQo+ICAgZWNobw0KPiAgIGVjaG8gIj09PSBFeHBvcnRpbmcgdW5hbGlnbmVkIHJhdyBp
bWFnZSwgZm9yY2VkIGNsaWVudCBzZWN0b3IgYWxpZ25tZW50ID09PSINCj4gZGlmZiAtLWdpdCBh
L3Rlc3RzL3FlbXUtaW90ZXN0cy8yNDEub3V0IGIvdGVzdHMvcWVtdS1pb3Rlc3RzLzI0MS5vdXQN
Cj4gaW5kZXggZjQ4MTA3NGEwMmUuLjc1ZjlmNDY1ZTUyIDEwMDY0NA0KPiAtLS0gYS90ZXN0cy9x
ZW11LWlvdGVzdHMvMjQxLm91dA0KPiArKysgYi90ZXN0cy9xZW11LWlvdGVzdHMvMjQxLm91dA0K
PiBAQCAtMTAsMTMgKzEwLDEzIEBAIFFBIG91dHB1dCBjcmVhdGVkIGJ5IDI0MQ0KPiANCj4gICA9
PT0gRXhwb3J0aW5nIHVuYWxpZ25lZCByYXcgaW1hZ2UsIGZvcmNlZCBzZXJ2ZXIgc2VjdG9yIGFs
aWdubWVudCA9PT0NCj4gDQo+IC1XQVJOSU5HOiBJbWFnZSBmb3JtYXQgd2FzIG5vdCBzcGVjaWZp
ZWQgZm9yICcvaG9tZS9lYmxha2UvcWVtdS90ZXN0cy9xZW11LWlvdGVzdHMvc2NyYXRjaC90LnJh
dycgYW5kIHByb2JpbmcgZ3Vlc3NlZCByYXcuDQo+IC0gICAgICAgICBBdXRvbWF0aWNhbGx5IGRl
dGVjdGluZyB0aGUgZm9ybWF0IGlzIGRhbmdlcm91cyBmb3IgcmF3IGltYWdlcywgd3JpdGUgb3Bl
cmF0aW9ucyBvbiBibG9jayAwIHdpbGwgYmUgcmVzdHJpY3RlZC4NCj4gLSAgICAgICAgIFNwZWNp
ZnkgdGhlICdyYXcnIGZvcm1hdCBleHBsaWNpdGx5IHRvIHJlbW92ZSB0aGUgcmVzdHJpY3Rpb25z
Lg0KPiAgICAgc2l6ZTogIDEwMjQNCj4gICAgIG1pbiBibG9jazogNTEyDQo+ICAgW3sgInN0YXJ0
IjogMCwgImxlbmd0aCI6IDEwMjQsICJkZXB0aCI6IDAsICJ6ZXJvIjogZmFsc2UsICJkYXRhIjog
dHJ1ZSwgIm9mZnNldCI6IE9GRlNFVH1dDQo+ICAgMSBLaUIgKDB4NDAwKSBieXRlcyAgICAgYWxs
b2NhdGVkIGF0IG9mZnNldCAwIGJ5dGVzICgweDApDQo+ICtXQVJOSU5HOiBJbWFnZSBmb3JtYXQg
d2FzIG5vdCBzcGVjaWZpZWQgZm9yICdURVNUX0RJUi90LnJhdycgYW5kIHByb2JpbmcgZ3Vlc3Nl
ZCByYXcuDQo+ICsgICAgICAgICBBdXRvbWF0aWNhbGx5IGRldGVjdGluZyB0aGUgZm9ybWF0IGlz
IGRhbmdlcm91cyBmb3IgcmF3IGltYWdlcywgd3JpdGUgb3BlcmF0aW9ucyBvbiBibG9jayAwIHdp
bGwgYmUgcmVzdHJpY3RlZC4NCj4gKyAgICAgICAgIFNwZWNpZnkgdGhlICdyYXcnIGZvcm1hdCBl
eHBsaWNpdGx5IHRvIHJlbW92ZSB0aGUgcmVzdHJpY3Rpb25zLg0KDQpNYXkgYmUsIGp1c3QgYWRk
IC1mIHJhdyB0byBuYmQgc2VydmVyLCB0byBtYWtlIHRoaXMgbWVzc2FnZSBkaXNhcHBlYXI/IEFu
ZCB0aGFuLCBkb24ndCBkbyBhbnkgcmVkaXJlY3Rpb25zLCBhcyBpZiB0aGVyZQ0Kd2lsbCBiZSBm
YWlsZWQgdW5maWx0ZXJlZCBvdXRwdXQgaXQgaXMgT0s/DQoNCj4gDQo+ICAgPT09IEV4cG9ydGlu
ZyB1bmFsaWduZWQgcmF3IGltYWdlLCBmb3JjZWQgY2xpZW50IHNlY3RvciBhbGlnbm1lbnQgPT09
DQo+IA0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

