Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F169C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 15:49:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DC2320818
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 15:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="KkWb2jZN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DC2320818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51079 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEbx7-0000Q7-UR
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 11:49:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hEbvi-000889-7b
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 11:47:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hEbvg-00056u-T2
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 11:47:58 -0400
Received: from mail-eopbgr70127.outbound.protection.outlook.com
	([40.107.7.127]:19075
	helo=EUR04-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hEbvb-0004tN-7x; Thu, 11 Apr 2019 11:47:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=lT/wwWJ4JAcpUIoXHcBtPu/YYzel6Ynxcr40OTYUbQo=;
	b=KkWb2jZNdf/TsoKYfBsOZyzhtKaFHvnCT/xdbB41wYUfENcPO3x+CLNMXlaNZsH7iPggfeWxQBmqOs7Kce5IiD8k51wN+wHktaNTvnjgErgseimqTakTNPqpPFzk8y13AzbBZXKIBvrYx2r6u8C5eHdX27xx53MdAN7gd2y3C0U=
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com (20.178.46.222) by
	DB7PR08MB3658.eurprd08.prod.outlook.com (20.177.120.152) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1792.17; Thu, 11 Apr 2019 15:47:19 +0000
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949]) by
	DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949%3]) with mapi id 15.20.1771.021;
	Thu, 11 Apr 2019 15:47:19 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH v4 08/10] block/nbd: add cmdline and qapi parameter
	reconnect-delay
Thread-Index: AQHUKPQ1s3wRXrmZvEuWoIX/LEqyr6WgpuyAgJgC2AA=
Date: Thu, 11 Apr 2019 15:47:19 +0000
Message-ID: <c68db798-c0c8-f3f5-7f5b-cb672bfa66b6@virtuozzo.com>
References: <20180731173033.75467-1-vsementsov@virtuozzo.com>
	<20180731173033.75467-9-vsementsov@virtuozzo.com>
	<ac7e2dbf-0399-3b99-5cd5-42597b3027c1@redhat.com>
In-Reply-To: <ac7e2dbf-0399-3b99-5cd5-42597b3027c1@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR09CA0073.eurprd09.prod.outlook.com
	(2603:10a6:7:3d::17) To DB7PR08MB3851.eurprd08.prod.outlook.com
	(2603:10a6:10:7b::30)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190411184716486
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bb1b525d-0328-49c7-1c80-08d6be94fab0
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);
	SRVR:DB7PR08MB3658; 
x-ms-traffictypediagnostic: DB7PR08MB3658:
x-microsoft-antispam-prvs: <DB7PR08MB3658F08FCEFBC74640C32022C12F0@DB7PR08MB3658.eurprd08.prod.outlook.com>
x-forefront-prvs: 00046D390F
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(366004)(136003)(396003)(39850400004)(376002)(346002)(189003)(199004)(186003)(54906003)(7736002)(53936002)(110136005)(316002)(229853002)(31696002)(6116002)(3846002)(305945005)(11346002)(2616005)(446003)(26005)(14454004)(478600001)(6436002)(71190400001)(476003)(71200400001)(52116002)(5660300002)(86362001)(66066001)(97736004)(99286004)(31686004)(8676002)(6506007)(107886003)(486006)(386003)(2501003)(53546011)(2201001)(6246003)(68736007)(6486002)(4326008)(6512007)(105586002)(2906002)(102836004)(256004)(36756003)(106356001)(76176011)(25786009)(81166006)(8936002)(81156014)(14444005);
	DIR:OUT; SFP:1102; SCL:1; SRVR:DB7PR08MB3658;
	H:DB7PR08MB3851.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ejZV3pFLtq9jc25i5HNUA0lG7pkStrmIQ/GTlK6/ktXlTIxLopu02Q9s6hyRaGy+6ZWFLNk63BgXvUx6FNYiAxWFZu4VDPbZGtgpnMdtqalgWGLxCEc7JhAuagsGYQwwozIkNpY6BfAWTUINrn8UQu3KWltO0lzFi38KS6gGIbn9braoWBblrlbLRmtRFkj+E1CGOqqe9JRNtAm1tAgbEqlgnqEJAWZBASpNCXVcwIeC1IzytkX2FxnCTRpIh8+cnXP8oLK+J13Re9CVfREYrm/zfFH7uy9d/s8lwctHXB68iffOfXBjx+6ir3kFDyUawnE+0rtBQue/LZGBfsWbmgrH8osyrvBESm7Yhej1GjRu0GsOam+95SNoq4Qw/ioj2G36H533wibJxdDV4puPFajVKgPvODac6IORdQkH61I=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <0FCA2F016697C547BFD486736BA6A98D@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb1b525d-0328-49c7-1c80-08d6be94fab0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2019 15:47:19.2238 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3658
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.127
Subject: Re: [Qemu-devel] [PATCH v4 08/10] block/nbd: add cmdline and qapi
 parameter reconnect-delay
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	Denis Lunev <den@virtuozzo.com>, "armbru@redhat.com" <armbru@redhat.com>,
	"mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411154719.kOlk2RZSx__eZ_qOSTNzD52FBHdUVb54RqpFjvQwefA@z>

MDUuMDEuMjAxOSAxOjI1LCBFcmljIEJsYWtlIHdyb3RlOg0KPiBPbiA3LzMxLzE4IDEyOjMwIFBN
LCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3RlOg0KPj4gUmVjb25uZWN0IHdpbGwg
YmUgaW1wbGVtZW50ZWQgaW4gdGhlIGZvbGxvd2luZyBjb21taXQsIHNvIGZvciBub3csDQo+PiBp
biBzZW1hbnRpY3MgYmVsb3csIGRpc2Nvbm5lY3QgaXRzZWxmIGlzIGEgInNlcmlvdXMgZXJyb3Ii
Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZz
ZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCj4+IC0tLQ0KPj4gICBxYXBpL2Jsb2NrLWNvcmUuanNv
biB8IDEyICsrKysrKysrKysrLQ0KPj4gICBibG9jay9uYmQtY2xpZW50LmggICB8ICAxICsNCj4+
ICAgYmxvY2svbmJkLWNsaWVudC5jICAgfCAgMSArDQo+PiAgIGJsb2NrL25iZC5jICAgICAgICAg
IHwgMTYgKysrKysrKysrKysrKysrLQ0KPj4gICA0IGZpbGVzIGNoYW5nZWQsIDI4IGluc2VydGlv
bnMoKyksIDIgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL3FhcGkvYmxvY2stY29y
ZS5qc29uIGIvcWFwaS9ibG9jay1jb3JlLmpzb24NCj4+IGluZGV4IDViOTA4NGEzOTQuLmNmMDM0
MDJlYzUgMTAwNjQ0DQo+PiAtLS0gYS9xYXBpL2Jsb2NrLWNvcmUuanNvbg0KPj4gKysrIGIvcWFw
aS9ibG9jay1jb3JlLmpzb24NCj4+IEBAIC0zNTExLDEzICszNTExLDIzIEBADQo+PiAgICMgICAg
ICAgICAgICAgICAgICB0cmFkaXRpb25hbCAiYmFzZTphbGxvY2F0aW9uIiBibG9jayBzdGF0dXMg
KHNlZQ0KPj4gICAjICAgICAgICAgICAgICAgICAgTkJEX09QVF9MSVNUX01FVEFfQ09OVEVYVCBp
biB0aGUgTkJEIHByb3RvY29sKSAoc2luY2UgMy4wKQ0KPj4gICAjDQo+PiArIyBAcmVjb25uZWN0
LWRlbGF5OiBSZWNvbm5lY3QgZGVsYXkuIE9uIGRpc2Nvbm5lY3QsIG5iZCBjbGllbnQgdHJpZXMg
dG8gY29ubmVjdA0KPiANCj4gTWF5YmUgJ09uIHVuZXhwZWN0ZWQgZGlzY29ubmVjdCcsIHNpbmNl
IGludGVudGlvbmFsIGRpc2Nvbm5lY3QgaXMgbm90DQo+IHVuZXhwZWN0ZWQuDQo+IA0KPj4gKyMg
ICAgICAgICAgICAgICAgICAgYWdhaW4sIHVudGlsIHN1Y2Nlc3Mgb3Igc2VyaW91cyBlcnJvci4g
RHVyaW5nIGZpcnN0DQo+PiArIyAgICAgICAgICAgICAgICAgICBAcmVjb25uZWN0LWRlbGF5IHNl
Y29uZHMgb2YgcmVjb25uZWN0aW5nIGxvb3AgYWxsIHJlcXVlc3RzDQo+PiArIyAgICAgICAgICAg
ICAgICAgICBhcmUgcGF1c2VkIGFuZCBoYXZlIGEgY2hhbmNlIHRvIHJlcnVuLCBpZiBzdWNjZXNz
ZnVsDQo+PiArIyAgICAgICAgICAgICAgICAgICBjb25uZWN0IG9jY3VyZXMgZHVyaW5nIHRoaXMg
dGltZS4gQWZ0ZXIgQHJlY29ubmVjdC1kZWxheQ0KPiANCj4gb2NjdXJzDQo+IA0KPj4gKyMgICAg
ICAgICAgICAgICAgICAgc2Vjb25kcyBhbGwgZGVsYXllZCByZXF1ZXN0cyBhcmUgZmFpbGVkIGFu
ZCBhbGwgZm9sbG93aW5nDQo+PiArIyAgICAgICAgICAgICAgICAgICByZXF1ZXN0cyB3aWxsIGJl
IGZhaWxlZCB0byAodW50aWwgc3VjY2Vzc2Z1bGwgcmVjb25uZWN0KS4NCj4gDQo+IHN1Y2Nlc3Nm
dWwNCj4gDQo+PiArIyAgICAgICAgICAgICAgICAgICBEZWZhdWx0IDMwMCBzZWNvbmRzIChTaW5j
ZSAzLjEpDQo+IA0KPiBNeSBkZWxheSBpbiByZXZpZXdpbmcgbWVhbnMgdGhpcyBub3cgaGFzIHRv
IGJlIDQuMC4NCj4gDQo+IEknbSBndWVzc2luZyB0aGF0IGEgZGVsYXkgb2YgMCBtZWFucyBkaXNh
YmxlIGF1dG8tcmVjb25uZWN0Lg0KDQpJIGRvdWJ0LCBhcyByZWNvbm5lY3QtZGVsYXk9MCBpcyBh
IHZhbGlkIGNhc2UsIHdoZW4gYWxsIHJlcXVlc3QgYXJlIGZhaWxlZA0KKHByZS1wYXRjaCBiZWhh
dmlvciksIGJ1dCB3ZSBzdGlsbCB0cnkgdG8gcmVjb25uZWN0IGluIGJhY2tncm91bmQuIEFueSBy
ZWFzb24NCm5vdCB0byB0cnk/IElmIGFueSwgSSBzdWdnZXN0IG9uZSBvZiB0aGUgZm9sbG93aW5n
Og0KDQoxLiB0cmVhdCBhYnNlbmNlIG9mIHRoZSBvcHRpb24gYXMgbm8tcmVjb25uZWN0LWF0LWFs
bC4gU28gYWJzZW5jZSBhbmQgMCB3b3VsZCBiZQ0KICAgIG5vdCB0aGUgc2FtZQ0KDQoyLiB1c2Ug
LTEgdmFsdWUgYXMgbm8tcmVjb25uZWN0LWF0LWFsbA0KDQozLiBhZGRpdGlvbmFsIGJvb2wgb3B0
aW9uICJyZWNvbm5lY3QiDQoNCj4gIEZyb20gYQ0KPiBiYWNrd2FyZHMtY29tcGF0aWJpbGl0eSBz
dGFuZHBvaW50LCBubyBhdXRvLXJlY29ubmVjdCBpcyBtb3JlIGluIGxpbmUNCj4gd2l0aCB3aGF0
IHdlIHByZXZpb3VzbHkgaGFkIC0gYnV0IGZyb20gYSB1c2FiaWxpdHkgc3RhbmRwb2ludCwgdHJ5
aW5nIHRvDQo+IHJlY29ubmVjdCBjYW4gYXZvaWQgdHVybmluZyB0cmFuc2llbnQgbmV0d29yayBo
aWNjdXBzIGludG8gcGVybWFuZW50DQo+IGxvc3Mgb2YgYSBkZXZpY2UgdG8gRUlPIGVycm9ycywg
ZXNwZWNpYWxseSBpZiB0aGUgcmV0cnkgdGltZW91dCBpcyBsb25nDQo+IGVub3VnaCB0byBhbGxv
dyBhbiBhZG1pbmlzdHJhdG9yIHRvIHJlcm91dGUgdGhlIG5ldHdvcmsgdG8gYW4NCj4gYWx0ZXJu
YXRpdmUgc2VydmVyLiAgU28gSSdtIHByb2JhYmx5IG9rYXkgd2l0aCB0aGUgZGVmYXVsdCBiZWlu
Zw0KPiBub24temVybyAtIGJ1dCBpdCBET0VTIG1lYW4gdGhhdCB3aGVyZSB5b3UgdXNlZCB0byBn
ZXQgaW5zdGFudCBFSU8NCj4gZmFpbHVyZXMgd2hlbiBhIG5ldHdvcmsgY29ubmVjdGlvbiB3YXMg
c2V2ZXJlZCwgeW91IG5vdyBoYXZlIHRvIHdhaXQgZm9yDQo+IHRoZSByZWNvbm5lY3QgZGVsYXkg
dG8gZXhwaXJlLCBhbmQgNSBtaW51dGVzIGNhbiBiZSBhIGxvbmcgd2FpdC4gIFNpbmNlDQo+IHRo
ZSBsb25nIGRlbGF5IGlzIGd1ZXN0LW9ic2VydmFibGUsIGNhbiB3ZSBydW4gaW50byBpc3N1ZXMg
d2hlcmUgYSBndWVzdA0KPiB0aGF0IGlzIGN1cnJlbnRseSB1c2VkIHRvIGluc3RhbnQgRUlPIGFu
ZCB0b3RhbCBsb3NzIG9mIHRoZSBkZXZpY2UgY291bGQNCj4gaW5zdGVhZCBnZXQgY29uZnVzZWQg
Ynkgbm90IGdldHRpbmcgYW55IHJlc3BvbnNlIGZvciB1cCB0byA1IG1pbnV0ZXMsDQo+IHdoZXRo
ZXIgb3Igbm90IHRoYXQgcmVzcG9uc2UgZXZlbnR1YWxseSB0dXJucyBvdXQgdG8gYmUgRUlPIG9y
IGENCj4gc3VjY2Vzc2Z1bCByZWNvdmVyeT8NCj4gDQo+PiArKysgYi9ibG9jay9uYmQuYw0KPj4g
QEAgLTM2MCw2ICszNjAsMTggQEAgc3RhdGljIFFlbXVPcHRzTGlzdCBuYmRfcnVudGltZV9vcHRz
ID0gew0KPj4gICAgICAgICAgICAgICAuaGVscCA9ICJleHBlcmltZW50YWw6IGV4cG9zZSBuYW1l
ZCBkaXJ0eSBiaXRtYXAgaW4gcGxhY2Ugb2YgIg0KPj4gICAgICAgICAgICAgICAgICAgICAgICJi
bG9jayBzdGF0dXMiLA0KPj4gICAgICAgICAgIH0sDQo+PiArICAgICAgICB7DQo+PiArICAgICAg
ICAgICAgLm5hbWUgPSAicmVjb25uZWN0LWRlbGF5IiwNCj4+ICsgICAgICAgICAgICAudHlwZSA9
IFFFTVVfT1BUX05VTUJFUiwNCj4+ICsgICAgICAgICAgICAuaGVscCA9ICJSZWNvbm5lY3QgZGVs
YXkuIE9uIGRpc2Nvbm5lY3QsIG5iZCBjbGllbnQgdHJpZXMgdG8iDQo+PiArICAgICAgICAgICAg
ICAgICAgICAiY29ubmVjdCBhZ2FpbiwgdW50aWwgc3VjY2VzcyBvciBzZXJpb3VzIGVycm9yLiBE
dXJpbmciDQo+PiArICAgICAgICAgICAgICAgICAgICAiZmlyc3QgQHJlY29ubmVjdC1kZWxheSBz
ZWNvbmRzIG9mIHJlY29ubmVjdGluZyBsb29wIGFsbCINCj4+ICsgICAgICAgICAgICAgICAgICAg
ICJyZXF1ZXN0cyBhcmUgcGF1c2VkIGFuZCBoYXZlIGEgY2hhbmNlIHRvIHJlcnVuLCBpZiINCj4+
ICsgICAgICAgICAgICAgICAgICAgICJzdWNjZXNzZnVsIGNvbm5lY3Qgb2NjdXJlcyBkdXJpbmcg
dGhpcyB0aW1lLiBBZnRlciINCj4+ICsgICAgICAgICAgICAgICAgICAgICJAcmVjb25uZWN0LWRl
bGF5IHNlY29uZHMgYWxsIGRlbGF5ZWQgcmVxdWVzdHMgYXJlIGZhaWxlZCINCj4+ICsgICAgICAg
ICAgICAgICAgICAgICJhbmQgYWxsIGZvbGxvd2luZyByZXF1ZXN0cyB3aWxsIGJlIGZhaWxlZCB0
byAodW50aWwiDQo+PiArICAgICAgICAgICAgICAgICAgICAic3VjY2Vzc2Z1bGwgcmVjb25uZWN0
KS4gRGVmYXVsdCAzMDAgc2Vjb25kcyIsDQo+IA0KPiBTYW1lIHR5cG9zIGFzIGluIHFhcGkuDQo+
IA0KPiBUaGUgVUkgYXNwZWN0cyBsb29rIGZpbmUsIG5vdyBJIG5lZWQgdG8gcmV2aWV3IHRoZSBw
YXRjaCBzZXJpZXMgZm9yIGNvZGUNCj4gaXNzdWVzIDopDQo+IA0KPiANCg0KDQotLSANCkJlc3Qg
cmVnYXJkcywNClZsYWRpbWlyDQo=

