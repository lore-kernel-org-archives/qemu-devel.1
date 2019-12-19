Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A72C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 15:01:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D2F12146E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 15:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="g43mhvZM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D2F12146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihxJI-00041y-EH
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 10:01:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39711)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ihxIB-00036J-1P
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 10:00:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ihxI9-00077T-4V
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 10:00:42 -0500
Received: from mail-eopbgr60107.outbound.protection.outlook.com
 ([40.107.6.107]:28640 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1ihxI1-0006oV-4c; Thu, 19 Dec 2019 10:00:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=axdReCiymLhoqgCFpnQ9ouVUqjU9t7Q/TwAdQUVY+JpE7h937PWD2Hnb4am3W/VUzNE8gfYm/vm2AHH/JFxWSHV03HeEze+4c4maS7g0WZNRoBvzWSjzpEGy0rBORxJV/A4R8i1lx4TOUwk3kVdvaT498c3dKgbYg7a7xDR68+AmXhuNSyos1gZs5sIEJzXNSG0SR+33Rzq++HVOByDJm+mPPkJ2jPJdjWszWp5W+E+Yf5SGAvCMAxBmmcr1uY8MFbLA4FEXV7bqTIu/7kXfHGF8A5MkrPsufX7wAVsdMjmnGzmRhE9Pz0jxbyKF86XIxQ9Uq/Dm7A8+Ny2x7KMadA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QShgkqC20xTj+ty44Q/F9h5e6+EKcZJfTaLNp9vgN1I=;
 b=egfJQD+7fif/lTx6LBs0eQA+GX96bjfjwtmM7c9nhNlcLiFaCUNXUzgMdPZCNwQGF3N1rIevgfwSh+bqk/p4+yvQ6BOy6+E5Z6En8s5FfWHMn+RGrJ8jrGZ6y/xnts36QW/NPx/de0XXMOBcYZy2m/iZ2g/lpauCJuvR4/JQeUG1oTO51oOQRRZTCdat08dLvoawpjAPSe0zJZG2kt2x7OvoAETo5yODf3G10/m3S+uJFDsVvg9VBgELOiy0DU9TomWa6wVYmD3KL1r8dvySTSVZSGuasZgt8VRmlq+B+xy45NS384gVUt7c4BKu6LdyfXD0yx0QgiK/6O1ygs7zRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QShgkqC20xTj+ty44Q/F9h5e6+EKcZJfTaLNp9vgN1I=;
 b=g43mhvZMOiOYO9twe7ScF6vzfsd5b19ZwlkiMbqr+8RQk1q1ihCaB5YlVCgm0EeRwmMVAFA/0L2ajLElaJpbXGAfOSYcnDEohO6ipuE7zxKLhfYrzCO3HQIyR1YIHCfg0uN8/XojU7Buggemq0I/xzy/dfligG/S1x47TLcM+e4=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3718.eurprd08.prod.outlook.com (20.178.88.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Thu, 19 Dec 2019 15:00:30 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2559.012; Thu, 19 Dec 2019
 15:00:30 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Nir Soffer <nsoffer@redhat.com>
Subject: Re: [PATCH] qapi/block: fix nbd-server-add spec
Thread-Topic: [PATCH] qapi/block: fix nbd-server-add spec
Thread-Index: AQHVtnnxYNIeaG1fgkq9lkIsLWKUC6fBiECAgAAE4wA=
Date: Thu, 19 Dec 2019 15:00:29 +0000
Message-ID: <c97f28de-c924-bc42-4725-09b633a28674@virtuozzo.com>
References: <20191219143415.28490-1-vsementsov@virtuozzo.com>
 <CAMRbyyt8Y8DFV5=72+GvHrAWbdUO5Mys5JGn7D8es+w2SVcRMA@mail.gmail.com>
In-Reply-To: <CAMRbyyt8Y8DFV5=72+GvHrAWbdUO5Mys5JGn7D8es+w2SVcRMA@mail.gmail.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0401CA0082.eurprd04.prod.outlook.com
 (2603:10a6:3:19::50) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191219180026305
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2fcfa8e5-0d34-4b00-3697-08d784943061
x-ms-traffictypediagnostic: AM6PR08MB3718:
x-microsoft-antispam-prvs: <AM6PR08MB371802926A8BB01ABBF139FFC1520@AM6PR08MB3718.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0256C18696
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(346002)(366004)(396003)(376002)(136003)(53754006)(199004)(189003)(8936002)(86362001)(316002)(36756003)(2906002)(6512007)(5660300002)(26005)(53546011)(2616005)(54906003)(71200400001)(52116002)(8676002)(6506007)(966005)(81166006)(6916009)(31696002)(81156014)(4326008)(66476007)(64756008)(66556008)(66446008)(66946007)(6486002)(478600001)(186003)(31686004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3718;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fjUv8qVBR+Db57z15ypzHW7ctIoUUsET+W6exURFwuK4E9FEZv3nkXQ6+YQeFTqZMUVv1SYbU3+MYI1pixY7WKFy/CiZ3IrX8JXco6eCa9zjZgkqTThqVMF0+ub1gJfaAPt7FvuxzNVaxeBQMHMwPJJ/Xa7cYqQJ4LLheyJj6mWFhH5vkCxdDxq98NV+R/scW/6Wm3s6LtCyhGbo3a/ly6rr7NxqZQ5Ga6shrINpl+/gNwy15tySMSvf+i5AW4s7uQ8yynTZZ5SWr8BIy0WN5GHoGtDgXv2OuOIeXgxvgRdPiKAXJNhDnO2GQNH6EJfnO2hU25647th2yLNu+mpFXhfz5U/NHqqN3oKhosfvScNpS/olMmk3JK+3TUAraC8N//6xZenvHom0/VGGr9XewhucSvhYQwZ6SpBPD0sGJ/SMq431zzoMpalzFRhK611hWxhLMJ1yHkiFXDzJOmyDtQcYY85wHnbD6hq6LwkufuLDxi1LbAW1tJUoftdWOKagb4tB4JgjpmW23W8JGlNuCQIW5xUA8Nw2EcLAoJ/qJGo=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <1FF4E8F965DC63419571B4D38A750FE0@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fcfa8e5-0d34-4b00-3697-08d784943061
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2019 15:00:29.9667 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tX4OwylxfzFvPGoptyQ8NCguUBRMXVs9yotCulB0OHdQC/0oXBhlpdL6H/tZI2MLZ0jxioCS5OEO/pKRL7rngN/zfjk5lIZ843Z1HQYw6OA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3718
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.107
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block <qemu-block@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTkuMTIuMjAxOSAxNzo0MiwgTmlyIFNvZmZlciB3cm90ZToNCj4gT24gVGh1LCBEZWMgMTksIDIw
MTkgYXQgNDozNCBQTSBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5DQo+IDx2c2VtZW50c292
QHZpcnR1b3p6by5jb20+IHdyb3RlOg0KPj4NCj4+ICJOQU1FIiBoZXJlIG1heSBiZSBpbnRlcnBy
ZXRlZCBsaWtlIGl0IHNob3VsZCBtYXRjaCBAbmFtZSwgd2hpY2ggaXMNCj4+IGV4cG9ydCBuYW1l
LiBCdXQgaXQgd2FzIG5ldmVyIG1lbnRpb25lZCBpbiBzdWNoIHdheS4gTWFrZSBpdCBvYnZpb3Vz
LA0KPj4gdGhhdCBhY3R1YWwgIjxkaXJ0eS1iaXRtYXAtZXhwb3J0LW5hbWU+IiAoc2VlIGRvY3Mv
aW50ZXJvcC9uYmQudHh0KQ0KPj4gd2lsbCBtYXRjaCBAYml0bWFwIHBhcmFtZXRlci4NCj4gDQo+
IEJ1dCB0aGlzIGlzIHdyb25nLCBkaXJ0eS1iaXRtYXAtZXhwb3J0LW5hbWUgZG9lcyBub3QgbWVh
biB0aGUgYWN0dWFsIGJpdG1hcA0KPiBuYW1lIGJ1dCB0aGUgbmFtZSBleHBvc2VkIHRvIHRoZSBO
QkQgY2xpZW50LCB3aGljaCBjYW4gYmUgYW55dGhpbmcuDQoNClllcy4gV2hhdCBpcyB3cm9uZz8g
SXQgY2FuIGJlIGVueXRoaW5nLiBDdXJyZW50bHkgYnkgZGVmYXVsdCBpdCBpcyBiaXRtYXAgbmFt
ZS4NCkl0IHB1cmVseSBkb2N1bWVudGVkIChva2F5LCBldmVuIGNvbmZ1c2luZ2x5IGRvY3VtZW50
ZWQpLCBidXQgaXQgd2FzIHNvIHNpbmNlDQo0LjAuIEFuZCBleGlzdGluZyB1c2VycyBvYnZpb3Vz
bHkga25vd3MgaG93IGl0IHdvcmsgKG90aGVyd2lzZSwgdGhleSBjYW4ndCB1c2UNCnRoZSBmZWF0
dXJlKQ0KDQpTbywgSSB0aGluayBpdCdzIE9LIHRvIGZpeCBzcGVjIHRvIGRpcmVjdGx5IHNob3cg
aW1wbGVtZW50YXRpb24sIHRoYXQgd2FzIGhlcmUNCnNpbmNlIGZlYXR1cmUgaW50cm9kdWNpbmcu
DQoNCj4gDQo+PiBGaXhlczogNWZjYmViMDY4MTI2ODVhMg0KPj4gU2lnbmVkLW9mZi1ieTogVmxh
ZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KPj4g
LS0tDQo+Pg0KPj4gSGkgYWxsLg0KPj4NCj4+IFRoaXMgcGF0Y2ggZm9sbG93cyBkaXNjdXNzaW9u
IG9uIE5pcidzIHBhdGNoDQo+PiAgIFtQQVRDSF0gYmxvY2s6IG5iZDogRml4IGRpcnR5IGJpdG1h
cCBjb250ZXh0IG5hbWUNCj4+ICAgKCBodHRwczovL2xpc3RzLmdudS5vcmcvYXJjaGl2ZS9odG1s
L3FlbXUtZGV2ZWwvMjAxOS0xMi9tc2cwNDMwOS5odG1sICkNCj4+DQo+PiBMZXQncyBqdXN0IGZp
eCBxYXBpIHNwZWMgbm93Lg0KPiANCj4gQnV0IHFhcGkgZG9jdW1lbnRzIGEgYmV0dGVyIGJlaGF2
aW9yIGZvciB1c2Vycy4gV2Ugc2hvdWxkIGZpeCB0aGUgY29kZSBpbnN0ZWFkDQo+IHRvIG1hY2gg
dGhlIGRvY3MuDQoNCjEuIFVzaW5nIGRpc2sgbmFtZSBhcyBhIGJpdG1hcCBuYW1lIGlzIGEgYmFk
IGJlaGF2aW9yLCBhcyB0aGV5IGFyZSBjb21wbGV0ZWx5DQpkaWZmZXJlbnQgY29uY2VwdHMuIEVz
cGVjaWFsbHkga2VlcGluZyBpbiBtaW5kIHRoYXQgdXNlciBhbHJlYWR5IGtub3dzIGRpc2sgbmFt
ZSBhbnl3YXkNCmFuZCBubyByZWFzb24gdG8gd3JpdGUgdGhpcyBleHBvcnQgbmFtZSBpbnNpZGUg
bWV0YWRhdGEgY29udGV4dCBvZiB0aGlzIGV4cG9ydC4NCg0KMi4gSXQncyBub3QgZGlyZWN0bHkg
ZG9jdW1lbnRlZC4gWW91IGFzc3VtZSB0aGF0IE5BTUUgPT0gQG5hbWUuIEkgdW5kZXJzdGFuZCB0
aGF0DQppdCBtYXkgYmUgYXNzdW1lZC4uIEJ1dCBpdCdzIG5vdCBkb2N1bWVudGVkLg0KDQozLiBJ
dCdzIG5ldmVyIHdvcmtlZCBsaWtlIHlvdSB3cml0ZS4gU28gaWYgd2UgY2hhbmdlIHRoZSBiZWhh
dmlvciwgd2UnbGwgYnJlYWsNCmV4aXN0aW5nIHVzZXJzLg0KDQoNCj4gDQo+IFdpdGggdGhpcyB3
ZSBzdGlsbCBoYXZlIHRoZSBpc3N1ZSBvZiBsZWFraW5nIGludGVybmFsIGJpdG1hcCBuYW1lIHRv
DQo+IHVzZXJzIHdobyBkbyBub3QNCj4gY29udHJvbCB0aGUgbmFtZSwgYW5kIGRvIG5vdCBjYXJl
IGFib3V0IGl0Lg0KPiANCj4+ICAgcWFwaS9ibG9jay5qc29uIHwgMyArKy0NCj4+ICAgMSBmaWxl
IGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4NCj4+IGRpZmYgLS1n
aXQgYS9xYXBpL2Jsb2NrLmpzb24gYi9xYXBpL2Jsb2NrLmpzb24NCj4+IGluZGV4IDE0NWMyNjhi
YjYuLjgwNDJlZjc4ZjAgMTAwNjQ0DQo+PiAtLS0gYS9xYXBpL2Jsb2NrLmpzb24NCj4+ICsrKyBi
L3FhcGkvYmxvY2suanNvbg0KPj4gQEAgLTI1NSw3ICsyNTUsOCBAQA0KPj4NCj4+ICAgIyBAYml0
bWFwOiBBbHNvIGV4cG9ydCB0aGUgZGlydHkgYml0bWFwIHJlYWNoYWJsZSBmcm9tIEBkZXZpY2Us
IHNvIHRoZQ0KPj4gICAjICAgICAgICAgIE5CRCBjbGllbnQgY2FuIHVzZSBOQkRfT1BUX1NFVF9N
RVRBX0NPTlRFWFQgd2l0aA0KPj4gLSMgICAgICAgICAgInFlbXU6ZGlydHktYml0bWFwOk5BTUUi
IHRvIGluc3BlY3QgdGhlIGJpdG1hcC4gKHNpbmNlIDQuMCkNCj4+ICsjICAgICAgICAgICJxZW11
OmRpcnR5LWJpdG1hcDpCSVRNQVAiIHRvIGluc3BlY3QgdGhlIGJpdG1hcCAoQklUTUFQIGhlcmUN
Cj4+ICsjICAgICAgICAgIG1hdGNoZXMgQGJpdG1hcCBwYXJhbWV0ZXIpLiAoc2luY2UgNC4wKQ0K
Pj4gICAjDQo+PiAgICMgUmV0dXJuczogZXJyb3IgaWYgdGhlIHNlcnZlciBpcyBub3QgcnVubmlu
Zywgb3IgZXhwb3J0IHdpdGggdGhlIHNhbWUgbmFtZQ0KPj4gICAjICAgICAgICAgIGFscmVhZHkg
ZXhpc3RzLg0KPj4gLS0NCj4+IDIuMjEuMA0KPj4NCj4gDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMs
DQpWbGFkaW1pcg0K

