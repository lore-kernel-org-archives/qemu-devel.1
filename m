Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1088DC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 09:40:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEAE52146E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 09:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="WMz0381E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEAE52146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiElT-0002Fn-TY
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 04:40:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41324)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iiEkp-0001l8-Tu
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 04:39:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iiEko-0004Gh-05
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 04:39:27 -0500
Received: from mail-eopbgr80131.outbound.protection.outlook.com
 ([40.107.8.131]:44342 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iiEkj-0003n5-4a; Fri, 20 Dec 2019 04:39:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k3DYC0yW8RUvD6zfiIzLuXI4Sms7mQrTtFwZlXVS7V3hYV+TRifkDtrQTy694biEYZcfFjqciglDzp8udXT80/kzVs/1fRpeaBHXeY0BiKvJat5BomIb1Qd9T9WaS7pPvu5PyHJgSNS8lPreye6QZkwokzOo81SwZTiJmFXsM4Fp5vHtfP2oU4wq505zdcw8x5dy/AVSBHzAXegsHI2vUfe9Xr1HA0QrQD+GcSds8vqdRtTga7q0pveqlEhKPliEW5lHuGM/bxqWkTVllRU2cun4JMTwwoT5frpaTao0RTP3Wy252Nc4g3ghtUXizpJ0jr1XyKWTH2UjNPildjnqiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O2jkRpId+Ts5CK1l6i71LjmM/O4PTBALi6cU/rFBTqg=;
 b=CLpgHIpWp7ozzLxod+N7YlEKT0Q3kHxBs4TYd7AZsWBqM45FnZ4yPtrneXYvVsuWf63Ucep1ya10Ncd4P39/tqO19vzh6c0kz2rzbxcO/s1rJQUh0ja4KsOtDFp/TTrYqx6LXN7W7Vutl/07cLHQaiGugmwdRWVE58oNBae4qKjFU0SjSl1WCk5E/lO0ZGO7CPRaT+Ot5H/4gymbFxcPqdMRYa1gzTZRD0SxwG1B2FAx/+B3ZPOURWF1howP5s32tqOfWXNFybYON4qPsI1PcVfsupHmlWh+5sNhSf5STsUme6C4uFrSvBZvT+LFVo3aQD3PUvDiWXBNsdadU7qoyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O2jkRpId+Ts5CK1l6i71LjmM/O4PTBALi6cU/rFBTqg=;
 b=WMz0381Em77eUXh05kfbA+8VwqEgqsQDfvSB3CEpinC0j9+llem7Jt5oSUjz3SgEnxb7ZaoH5PjKZgn4ZHQ0ottxSTtOwNSR9HmKCGpl28DdE0NbidlmLyfV1VM8Fjw96WVUCWAba0R49NR3BmUH0xlzYq8lL7xzR9HxKLmH6vY=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB5542.eurprd08.prod.outlook.com (20.179.18.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.13; Fri, 20 Dec 2019 09:39:17 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2559.016; Fri, 20 Dec 2019
 09:39:17 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Nir Soffer <nsoffer@redhat.com>
Subject: Re: [PATCH] block: nbd: Fix dirty bitmap context name
Thread-Topic: [PATCH] block: nbd: Fix dirty bitmap context name
Thread-Index: AQHVtmzMtpyWQS3Bp0OaQNZadGqOP6fBd04AgAAGUoCAAA9GgIAABQYAgAAKm4CAASlOgA==
Date: Fri, 20 Dec 2019 09:39:17 +0000
Message-ID: <42c73579-fdaa-5590-39f9-ca9cacfeaa5e@virtuozzo.com>
References: <20191219125151.21482-1-nsoffer@redhat.com>
 <443c32b3-0e0c-ef9e-4d5b-9404b16eaa02@virtuozzo.com>
 <20191219140433.GK5230@linux.fritz.box>
 <CAMRbyyvqa1_3U=2Q7HmCrRcEq+yJjxUP7MM-GM5hUdrZw=yBOw@mail.gmail.com>
 <ddf58827-72e8-f853-e6bc-05d19100c62d@virtuozzo.com>
 <CAMRbyysHGjsWaCWXW2+iNSwU03DhavRF6sJ9-POUx3Mky6LK7Q@mail.gmail.com>
In-Reply-To: <CAMRbyysHGjsWaCWXW2+iNSwU03DhavRF6sJ9-POUx3Mky6LK7Q@mail.gmail.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0102CA0011.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::24) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191220123915502
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c6f2cca9-0761-4d9c-4ca7-08d785307b77
x-ms-traffictypediagnostic: AM6PR08MB5542:
x-microsoft-antispam-prvs: <AM6PR08MB5542F7AA5C9ABF2CA3C94686C12D0@AM6PR08MB5542.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 025796F161
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(366004)(136003)(39840400004)(396003)(346002)(199004)(189003)(52116002)(66946007)(71200400001)(6916009)(478600001)(64756008)(66556008)(66446008)(26005)(66476007)(966005)(53546011)(36756003)(2906002)(6486002)(81156014)(81166006)(316002)(8936002)(4326008)(31686004)(31696002)(54906003)(186003)(5660300002)(6506007)(8676002)(86362001)(6512007)(2616005)(14143004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB5542;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7hjR9qgR1wf1cXOjVajZ/p1nJw03kUnFww3iPj9QKFLv8ZSOSbgxsvR94ttcS/oZcD5xZOzHjVL4I1Zr719Iv+a/pwQv8+Lmepo7jOsO9o4zPyHvunXvY4DRfvrez6BL9Bi09lcqMh4JO9MpJFLEL+izl6vHOYobHuuDpSzKIFmmFwIID8G0VGmC6wizz9Z7IfA9zytgYSX2CtcEUzPRLEBvrlBniW6LbHp1di0gA49biKbiCvfZ5hYqYYzvV2kQw7iNFjLBVNDgmEPMm4N3h3JW3jFA/RscMmnQLNpMFTWllb9s9t0UloVy2OrcYYMXARm1Aj9s9f7OqPG62TT0W1+4Zy08W5ClPfu49Nw14Zx3EOB+4+Nac3CE1dUv/ksISwqrLoPZBzYEHmjKIRvJfEBYgYiFvQcbHc9Lcls/ExeLqjFkuosrybYWy0nyjUfEW1q/ZGL/OUnfH1bgXKdZfhFOixadN6zoWEwURPlEvTma5PohzdaebpjaeR1yJz3DCDL9R0YFE1TRxlLlJLSa2Q==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <19BE8EF8B1D2A042B4EDFD240FBEB19C@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6f2cca9-0761-4d9c-4ca7-08d785307b77
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2019 09:39:17.3984 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1GKGjLUu5KkoxebcFjX2F+gftfB38Vol6841M/xxGgNVCHs/dlXyK+rrZdmUW8DlZJ7CZPzOQ6/GeCZG2uVV/4bPvrM0azpn9tcpGUbd/Fs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5542
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.131
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 Nir Soffer <nirsof@gmail.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTkuMTIuMjAxOSAxODo1NSwgTmlyIFNvZmZlciB3cm90ZToNCj4gT24gVGh1LCBEZWMgMTksIDIw
MTkgYXQgNToxNyBQTSBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5DQo+IDx2c2VtZW50c292
QHZpcnR1b3p6by5jb20+IHdyb3RlOg0KPj4NCj4+IDE5LjEyLjIwMTkgMTc6NTksIE5pciBTb2Zm
ZXIgd3JvdGU6DQo+Pj4gT24gVGh1LCBEZWMgMTksIDIwMTkgYXQgNDowNCBQTSBLZXZpbiBXb2xm
IDxrd29sZkByZWRoYXQuY29tPiB3cm90ZToNCj4+Pj4NCj4+Pj4gQW0gMTkuMTIuMjAxOSB1bSAx
NDo0MSBoYXQgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSBnZXNjaHJpZWJlbjoNCj4+Pj4+
IEFoaCwgSSBzZWUsIGl0J3MgZG9jdW1lbnRlZCBhcw0KPj4+Pj4NCj4+Pj4+ICsjIEBiaXRtYXA6
IEFsc28gZXhwb3J0IHRoZSBkaXJ0eSBiaXRtYXAgcmVhY2hhYmxlIGZyb20gQGRldmljZSwgc28g
dGhlDQo+Pj4+PiArIyAgICAgICAgICBOQkQgY2xpZW50IGNhbiB1c2UgTkJEX09QVF9TRVRfTUVU
QV9DT05URVhUIHdpdGgNCj4+Pj4+ICsjICAgICAgICAgICJxZW11OmRpcnR5LWJpdG1hcDpOQU1F
IiB0byBpbnNwZWN0IHRoZSBiaXRtYXAuIChzaW5jZSA0LjApDQo+Pj4+Pg0KPj4+Pj4gYW5kIGl0
IGlzIGxvZ2ljYWwgdG8gYXNzdW1lIHRoYXQgZXhwb3J0IG5hbWUgKHdoaWNoIGlzIEBuYW1lIGFy
Z3VtZW50KSBpcw0KPj4+Pj4gbWVudGlvbmVkLiBCdXQgd2UgbmV2ZXIgbWVudGlvbmVkIGl0LiBU
aGlzIGlzIGp1c3QgZG9jdW1lbnRlZCBhZnRlcg0KPj4+Pj4gcmVtb3ZlZCBleHBlcmltZW5hdGwg
Y29tbWFuZCB4LW5iZC1zZXJ2ZXItYWRkLWJpdG1hcCwNCj4+Pj4+DQo+Pj4+PiBsb29rIGF0DQo+
Pj4+Pg0KPj4+Pj4gY29tbWl0IDdkYzU3MGIzODA2ZTViMGE0YzkyMTkwNjE1NTZlZDVhNGEwZGU4
MGMNCj4+Pj4+IEF1dGhvcjogRXJpYyBCbGFrZSA8ZWJsYWtlQHJlZGhhdC5jb20+DQo+Pj4+PiBE
YXRlOiAgIEZyaSBKYW4gMTEgMTM6NDc6MTggMjAxOSAtMDYwMA0KPj4+Pj4NCj4+Pj4+ICAgICAg
ICBuYmQ6IFJlbW92ZSB4LW5iZC1zZXJ2ZXItYWRkLWJpdG1hcA0KPj4+Pj4NCj4+Pj4+IC4uLg0K
Pj4+Pj4NCj4+Pj4+IC0jIEBiaXRtYXAtZXhwb3J0LW5hbWU6IEhvdyB0aGUgYml0bWFwIHdpbGwg
YmUgc2VlbiBieSBuYmQgY2xpZW50cw0KPj4+Pj4gLSMgICAgICAgICAgICAgICAgICAgICAgKGRl
ZmF1bHQgQGJpdG1hcCkNCj4+Pj4+IC0jDQo+Pj4+PiAtIyBOb3RlOiB0aGUgY2xpZW50IG11c3Qg
dXNlIE5CRF9PUFRfU0VUX01FVEFfQ09OVEVYVCB3aXRoIGEgcXVlcnkgb2YNCj4+Pj4+IC0jICJx
ZW11OmRpcnR5LWJpdG1hcDpOQU1FIiAod2hlcmUgTkFNRSBtYXRjaGVzIEBiaXRtYXAtZXhwb3J0
LW5hbWUpIHRvIGFjY2Vzcw0KPj4+Pj4gLSMgdGhlIGV4cG9zZWQgYml0bWFwLg0KPj4+Pj4NCj4+
Pj4+DQo+Pj4+PiBTbywgdGhpcyAiTkFNRSIgaXMgc2F2ZWQgYW5kIG5vdyBsb29rcyBpbmNvcnJl
Y3QuIFdoYXQgc2hvdWxkIGJlIGZpeGVkLCBpcyBRYXBpDQo+Pj4+PiBkb2N1bWVudGF0aW9uLg0K
Pj4+Pg0KPj4+PiBIbSwgSSBkb24ndCBrbm93IHRoZXNlIGludGVyZmFjZXMgdmVyeSB3ZWxsLCBi
dXQgZnJvbSB5b3UgZXhwbGFuYXRpb24gaXQNCj4+Pj4gbG9va3MgdG8gbWUgYXMgaWYgaGF2aW5n
IGEgYml0bWFwIG5hbWUgbWFkZSBzZW5zZSB3aXRoDQo+Pj4+IHgtbmJkLXNlcnZlci1hZGQtYml0
bWFwIGJlY2F1c2UgaXQgY291bGQgYmUgY2FsbGVkIG1vcmUgdGhhbiBvbmNlIGZvcg0KPj4+PiBl
eHBvcnRpbmcgbXVsdGlwbGUgYml0bWFwcy4NCj4+Pj4NCj4+Pj4gQnV0IG5vdywgd2UgaGF2ZSBv
bmx5IG5iZC1zZXJ2ZXItYWRkLCB3aGljaCB0YWtlcyBhIHNpbmdsZSBiaXRtYXAgbmFtZS4NCj4+
Pj4gQXMgd2UgZG9uJ3QgaGF2ZSB0byBkaXN0aW5ndWlzaCBtdWx0aXBsZSBiaXRtYXBzIGFueSBt
b3JlLCB3b3VsZG4ndCBpdA0KPj4+PiBtYWtlIG1vcmUgc2Vuc2UgdG8gdXNlICJxZW11OmRpcnR5
LWJpdG1hcCIgd2l0aG91dCBhbnkgb3RoZXINCj4+Pj4gaW5mb3JtYXRpb24/IEJvdGggZXhwb3J0
IG5hbWUgYW5kIGJpdG1hcCBuYW1lIGFyZSBhbHJlYWR5IGlkZW50aWZpZWQgYnkNCj4+Pj4gdGhl
IGNvbm5lY3Rpb24uDQo+Pj4NCj4+PiBXZSBjYW4gdXNlIGVtcHR5IHN0cmluZyAobGlrZSB0aGUg
ZGVmYXVsdCBleHBvcnQgbmFtZSksIHNvIHRoZSBiaXRtYXANCj4+PiB3b3VsZCBiZSBleHBvc2Vk
IGFzOg0KPj4+DQo+Pj4gICAgICAgInFlbXU6ZGlydHktYml0bWFwOiINCj4+Pg0KPj4+IFRoaXMg
d291bGQgc29sdmUgdGhlIGlzc3VlIGZvciB1c2VycywgYW5kIGtlZXAgdGhlIEFQSSBleHRlbnNp
YmxlLg0KPj4NCj4+IEFzIEkgYWxyZWFkeSBzYWlkLCB3ZSBjYW4gbm90LiBJZiB3ZSByZWFsbHkg
d29udCBzdWNoIHRoaW5nLCB1c2UgYW5vdGhlciBuYW1lLA0KPj4gbGlrcSBxZW11OmRlZmF1bHQt
ZGlydHktYml0bWFwLi4NCj4+DQo+PiBPciBjYWxsIGJpdG1hcCBleHBvcnQgImRlZmF1bHQiLCB0
byBwcm9kdWNlDQo+PiAgICAicWVtdTpkaXJ0eS1iaXRtYXBzOmRlZmF1bHQiDQo+Pg0KPj4gQnV0
IGRvbid0IGNoYW5nZSBkZWZhdWx0IGJlaGF2aW9yIG9mIG5iZC1zZXJ2ZXItYWRkDQo+Pg0KPj4+
DQo+Pj4+IEJ1dCBpZiB3ZSBoYXZlIHRvIGhhdmUgc29tZXRoaW5nIHRoZXJlLCB1c2luZyB0aGUg
Yml0bWFwIG5hbWUgKHdoaWNoIG1heQ0KPj4+PiBvciBtYXkgbm90IGJlIHRoZSBzYW1lIGFzIHVz
ZWQgaW4gdGhlIGltYWdlIGZpbGUpIG1ha2VzIGEgbGl0dGxlIG1vcmUNCj4+Pj4gc2Vuc2UgYmVj
YXVzZSBpdCBtYWtlcyB0aGUgaW50ZXJmYWNlIGV4dGVuc2libGUgZm9yIHRoZSBjYXNlIHRoYXQg
d2UNCj4+Pj4gZXZlciB3YW50IHRvIHJlLWludHJvZHVjZSBhbiBuYmQtc2VydmVyLWFkZC1iaXRt
YXAuDQo+Pj4NCj4+PiBCdXQgdXNpbmcgdGhlIGJpdG1hcCBuYW1lIG1lYW5zIHVzZXIgb2YgdGhl
IE5CRCBzZXJ2ZXIgbmVlZCB0byBrbm93IHRoaXMgbmFtZS4NCj4+DQo+PiBXaHkgbm90PyBXaGF0
IGlzIHlvdXIgY2FzZSBleGFjdGx5PyBVc2VyIGtub3dzLCB3aGF0IGtpbmQgb2YgYml0bWFwIHlv
dSBhcmUNCj4+IGV4cG9ydGluZywgc28gdXNlciBpcyBpbiBzb21lIHJlbGF0aW9uIHdpdGggZXhw
b3J0aW5nIHByb2Nlc3MgYW55d2F5LiBXaHkNCj4+IHNob3VsZG4ndCBpdCBrbm93IHRoZSBuYW1l
Pw0KPiANCj4gQmVjYXVzZSB0aGUgdXNlciBjb25maWd1cmluZyBxZW11IChsaWJ2aXJ0KSBpcyBu
b3QgdGhlIHNhbWUgdXNlcg0KPiBhY2Nlc3NpbmcgcWVtdSBOQkQNCj4gc2VydmVyIChvdmlydCwg
b3Igc29tZSBiYWNrdXAgYXBwbGljYXRpb24pLg0KPiANCj4+IFRoaXMgbmFtZSBtYXkgYmUgZGVm
aW5lZCBpbiB5b3UgZXhwb3J0aW5nIHByb3RvY29sLi4gV2hhdCBhcmUgeW91IGV4cG9ydGluZz8N
Cj4gDQo+IFdlIGV4cG9ydCBIVFRQIEFQSSwgYWxsb3dpbmcgZ2V0dGluZyBkaXJ0eSBleHRlbnRz
IGFuZCByZWFkaW5nIGRhdGE6DQo+IGh0dHBzOi8vd3d3Lm92aXJ0Lm9yZy9kZXZlbG9wL3JlbGVh
c2UtbWFuYWdlbWVudC9mZWF0dXJlcy9zdG9yYWdlL2luY3JlbWVudGFsLWJhY2t1cC5odG1sI21h
cC1yZXF1ZXN0DQo+ICh0aGlzIGRvY3VtZW50IGlzIG91dGRhdGVkLCBidXQgaXQgZ2l2ZXMgdGhl
IGdlbmVyYWwgaWRlYSkNCj4gDQo+IE9yIHByb3ZpZGUgdGhlIE5CRCBVUkwgZGlyZWN0bHkgdG8g
dXNlciAoZnV0dXJlKS4NCj4gDQo+PiBOb3RlIGFsc28sIHRoYXQgY2xpZW50IG1heSB1c2UgTkJE
X09QVF9MSVNUX01FVEFfQ09OVEVYVCB3aXRoIHF1ZXJ5DQo+PiAicWVtdTpkaXJ0eS1iaXRtYXA6
IiwgdG8gZ2V0IGxpc3Qgb2YgYWxsIGV4cG9ydGVkIGJpdG1hcHMuDQo+IA0KPiBUaGlzIGlzIGFu
b3RoZXIgb3B0aW9uLCBJIGRpZCBub3QgdHJ5IHRvIHVzZSB0aGlzIHlldC4gV2UgY2FuIHVzZSB0
aGUgc2luZ2xlDQo+IGV4cG9ydGVkIGJpdG1hcCBhbmQgZmFpbCBpZiB3ZSBnZXQgbW9yZSB0aGFu
IG9uZS4gVGhpcyBpcyBwcm9iYWJseSBiZXR0ZXINCj4gdGhhbiBjaGFuZ2luZyB0aGUgZW50aXJl
IHN0YWNrIHRvIHN1cHBvcnQgYml0bWFwIG5hbWUuDQo+IA0KPj4+IE9uZSBvcHRpb24gaXMgdGhh
dCBsaWJ2aXJ0IHdvdWxkIHB1Ymxpc2ggdGhlIG5hbWUgb2YgdGhlIGJpdG1hcCBpbiB0aGUNCj4+
PiB4bWwgZGVzY3JpYmluZw0KPj4+IHRoZSBiYWNrdXAsIGFuZCBvVmlydCB3aWxsIGhhdmUgdG8g
cHJvcGFnYXRlIHRoaXMgbmFtZSB0byB0aGUgYWN0dWFsDQo+Pj4gcHJvZ3JhbSBhY2Nlc3NpbmcN
Cj4+PiB0aGUgTkJEIHNlcnZlciwgd2hpY2ggbWF5IGJlIGEgdXNlciBwcm9ncmFtIGluIHRoZSBj
YXNlIHdoZW4gd2UgZXhwb3NlIHRoZSBOQkQNCj4+PiBVUkwgdG8gdXNlcnMgKHBsYW5uZWQgZm9y
IGZ1dHVyZSB2ZXJzaW9uKS4NCj4+Pg0KPj4+IEFub3RoZXIgb3B0aW9uIGlzIHRoYXQgdGhlIHVz
ZXIgd2lsbCBjb250cm9sIHRoaXMgbmFtZSwgYW5kIGxpYnZpcnQNCj4+PiB3aWxsIHVzZSB0aGUg
bmFtZSBzcGVjaWZpZWQNCj4+PiBieSB0aGUgdXNlci4gVGhpcyBtZWFucyBvVmlydCB3aWxsIGhh
dmUgdG8gcHJvdmlkZSBBUEkgdG8gc2V0IHRoaXMNCj4+PiBuYW1lIGFuZCBwYXNzIGl0IHRvIGxp
YnZpcnQuDQo+Pj4NCj4+PiBCb3RoIGNhc2VzIHJlcXVpcmUgbG90IG9mIGVmZm9ydCB3aGljaCBk
b2VzIG5vdCBoZWxwIGFueW9uZSBpbiB0aGUNCj4+PiB0YXNrIG9mIGdldHRpbmcgZGlydHkNCj4+
PiBleHRlbnRzIGZyb20gYW4gaW1hZ2UgLSB3aGljaCBpcyBvdXIgY3VycmVudCBnb2FsLiBXZSBu
ZWVkIHRvIGhhdmUNCj4+PiBnb29kIGRlZmF1bHRzIHRoYXQNCj4+PiBzYXZlIHVubmVlZGVkIGVm
Zm9ydCBpbiB0aGUgZW50aXJlIHN0YWNrLg0KPj4NCj4+IFNvLCB5b3UgaW1wbGVtZW50aW5nIHNv
bWUgcHJvdG9jb2wsIGFuZCBuZWVkIHRvIGV4cG9ydCBvbmx5IG9uZSBiaXRtYXAgZm9yDQo+PiB5
b3VyIHNwZWNpZmllZCBzY2VuYXJpby4gV2h5IG5vdCBqdXN0IGdpdmUgYSBjb25zdGFudCBuYW1l
PyBMaWtlIG92aXJ0LWJpdG1hcCwNCj4+IG9yIHNvbWV0aGluZyBsaWtlIHRoaXM/DQo+IA0KPiBC
dXQgd2UgZG9uJ3QgdXNlIHFlbXUgZGlyZWN0bHkuIFdlIHVzZSBsaWJ2aXJ0LCBhbmQgbGlidmly
dCBkb2VzIG5vdCBleHBvc2UNCj4gdGhlIG5hbWUgb2YgdGhlIGJpdG1hcCwgb3IgbGV0IHVzZSBj
b250cm9sIHRoaXMgbmFtZS4NCj4gDQo+IFRoaXMgaXMgYSBzaW1wbGlmaWVkIGZsb3c6DQo+IDEu
IGxpYnZpcnQgc3RhcnRzIGEgYmFja3VwLCBjcmVhdGluZyB0aGUgImJhY2t1cC1leHBvcnRuYW1l
IiBiaXRtYXANCg0KQnV0IGRvIHlvdSBtYW5hZ2UgZXhwb3J0bmFtZSwgb3Igbm90Pw0KDQo+IDIu
IG9WaXJ0IGhvc3QgYWdlbnQgcmVwb3J0cyB0aGUgbmJkIHVybCBmb3IgdGhlIGRpc2sNCj4gMy4g
b1ZpcnQgbWFuYWdlciBjb25maWd1cmVzIG5iZC9odHRwIHByb3h5IHdpdGggbmJkIHVybA0KPiA0
LiBVc2VyIChlLmcuIGJhY2t1cCBhcHBsaWNhdGlvbikgYWNjZXNzIHRoZSBodHRwL25iZCBwcm94
eSB0byBnZXQgdGhlDQo+IGRpcnR5IGV4dGVudHMNCj4gDQo+IEFsdGVybmF0aXZlbHksIG9WaXJ0
IG1hbmdhZXIgd291bGQgcHJvdmlkZSB0aGUgTkJEIHVybCBkaXJlY3RseSB0byB0aGUgdXNlciwN
Cj4gYW5kIGl0IHdpbGwgYWNjZXNzIGl0IGRpcmVjdGx5IHdpdGggc29tZSBOQkQgY2xpZW50Lg0K
PiANCj4gVG8gbWFrZSB0aGlzIHdvcmsgd2UgbmVlZCB0byBwYXNzIG1vcmUgaW5mb3JtYXRpb24g
YmV0d2VlbiB0aGUNCj4gZGlmZmVyZW50IHByb2dyYW1zDQo+IGFuZCBjaGFuZ2UgQVBJcyB0byBw
dWJsaXNoIG9yIGFjY2VwdCBiaXRtYXAgbmFtZXMuIFRoaXMgaXMgYSBsb3Qgb2YNCj4gd29yayB0
aGF0IGRvZXMNCj4gbm90IGhlbHAgdGhlIGN1cnJlbnQgdXNlIGNhc2UsIGFjY2Vzc2luZyBhIHNp
bmdsZSBkaXJ0eSBiaXRtYXAuDQo+IA0KPiBXZSBjYW4gc29sdmUgaXQgaW4gbGlidmlydCBpZiB3
ZSBkb24ndCBoYXZlIGFub3RoZXIgY2hvaWNlLg0KDQpBaGEuIFNvLCB0aGUgYWN0dWFsIHByb2Js
ZW0gaXMgdGhhdCB5b3UgdXNlIGxpYnZpcnQgZmVhdHVyZSwgd2hpY2ggb24gdGhlIG91dHB1dA0K
Z2l2ZXMgeW91IGJpdG1hcCwgd2l0aCBzb21lIG5hbWUgY2hvc2VuIGJ5IGxpYnZpcnQsIGFuZCBp
dCBpcyBub3QgY29tZm9ydGFibGUuDQoNClRoZW4gbWF5IGJlIGNvcnJlY3Qgd2F5IGlzIHRvIG1h
a2UgaW4gbGlidmlydCBhbiBvcHRpb24gdG8gY2hvc2UgZXhwb3J0LWJpdG1hcC1uYW1lLA0KYmFj
a2VkIGluIFFlbXUgYnkgY29ycmVzcG9uZGluZyBvcHRpb24gaW4gbmJkLXNlcnZlci1hZGQgKG9y
IG5iZC1zZXJ2ZXItYWRkLWJpdG1hcCk/DQoNClRoZW4geW91IGp1c3QgY2hvc2Ugc29tZSBuYW1l
LCBsaWtlIF9fb3JnX292aXJ0X2JpdG1hcCwgd2hpY2ggd291bGQgYmUgYWRkaXRpb25hbA0KY2hl
Y2sgZm9yIG5iZCBjbGllbnQsIHRoYXQgdGhpcyBpcyB0aGUgY29ycmVjdCBiaXRtYXAgdG8gdXNl
LCBhbmQgZXZlcnl0aGluZyBpcyBnb29kPw0KDQo+IA0KPj4gKG9mIGNvdXJzZSwgd2UgbmVlZCBu
ZXcgb3B0aW9uYWwgcGFyYW10ZXIgZXhwb3J0LWJpdG1hcC1uYW1lIGZvciBuYmQtc2VydmVyLWFk
ZCwNCj4+IGFzIEkgcHJvcG9zZXMsIG9yIHJlaW1wbGVtZW50IG5iZC1zZXJ2ZXItYWRkLWJpdG1h
cCkNCj4+DQo+Pj4NCj4+Pj4gKEJ5IHRoZSB3YXksIGV2ZW4gaWYgdGhlIHBhdGNoIHdlcmUgY29y
cmVjdCwNCj4+Pg0KPj4+IEkgZG9uJ3QgdGhpbmsgdGhpcyBpcyBhYm91dCBjb3JyZWN0bmVzcywg
YnV0IGhhdmluZyBiZXR0ZXIgZGVmYXVsdCBmb3IgdXNlcnMuDQo+Pj4NCj4+DQo+PiBDaGFuZ2lu
ZyBkZWZhdWx0cyBhbHdheXMgYnJlYWtzIGV4aXN0aW5nIHVzZXJzLiBGb3IgZXhhbXBsZSBWaXJ0
dW96em8uIFdlIGxpdmUNCj4+IHdpdGggdGhlc2UgZGVmYXVsdHMsIHlvdSBjYW4ndCBqdXN0IGNo
YW5nZSBpdCB3aXRob3V0IGFueSBuZXcgb3B0aW9uLi4gSSBob3BlLg0KPiANCj4gVGhhdCdzIGEg
Z29vZCBwb2ludCwgd2Ugc2hvdWxkIG5vdCBicmVhayBleGlzdGluZyB1c2FnZS4NCj4gDQo+IE5p
cg0KPiANCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

