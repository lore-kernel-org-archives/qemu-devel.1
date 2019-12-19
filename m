Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4C1C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 15:26:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEC86206EC
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 15:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="N4hTpCSk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEC86206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihxgk-0006xL-UW
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 10:26:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57414)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ihxg0-0006NR-SI
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 10:25:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ihxfz-0005SH-9m
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 10:25:20 -0500
Received: from mail-eopbgr40113.outbound.protection.outlook.com
 ([40.107.4.113]:47105 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1ihxfv-0004ya-C5; Thu, 19 Dec 2019 10:25:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HQKPqp/yTbezBruKutNwugSDZhCksac1JHXqCrjyQ7jJlRu+HVrrdKXUVVTkzKeRGqBiomiyuWRXbd6aNuBjcWe5Egmvde/cvrQaEHhxdZQ1v7g1g8iH56c4PQMlpKga5zPCOAbsaLMuiJE47LNiB2VLi2rLE4EtghDQIyyLBMm0vWBFLp1KUhMD4826tt1kgX4Ya5prY7RbqjXYXEzuO31/AXomgmRFd38t31XLoTNFd3cC/SU1uZBplJVLYth5KVFZFQKZRTA8p218pgz4TqOqSIvtNd3e/Jza+OZqDObkJlS6Gizt0VTkPkwMEDxYcpGd/zk76Pf/7GQWWLMb9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4fPBUlysIhY47f2sOuYkwo+YaOSva3iD/1W0D3uv+qM=;
 b=IWgj2Ou98q08+/1J+7O9z8hbg/PqBAaQAxD9lh4TciX8Oi1OcPXt9a6NVjjx3zrk2sJdIA1B9I1MKqQ27MXXexVrbWzY0IT3kM0+oXrP3PyNyRTgN5lUSLjqrz0pciHzEsnLsmNBunERGcxzBsHfksuNjerAygomtXqU5/26laZez+UGH9nWxG5PrNzNcIh6n8Oq+3VCu19H1laQRfYEtQo/7c82vbtIQxCAEuyCq/KpQ/VUcMez+7VnH0laGHzGh3RvYUeBI+UL+whPA6DXF6au0YNe/rCK0TKam+yo48cUHOMhvfjm6AUPau0fddCwHosUSpF+g3L1ucB8EcEYow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4fPBUlysIhY47f2sOuYkwo+YaOSva3iD/1W0D3uv+qM=;
 b=N4hTpCSkTsxZKQPrccisUtd1AWNJ7UseqrPcdcfOfVROUfYXGJF+K91tcZfZixmqq3crAQjiLch3Hl5JYiFDJJMCFZFTapJR431VbIomCdfDYEQj3SE/L+mQQ0EQ27IMaQWkIzzcAS9rkzpQCX1zPYLF2EjYdARarUZo4XErZHQ=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3496.eurprd08.prod.outlook.com (20.177.115.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.15; Thu, 19 Dec 2019 15:25:12 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2559.012; Thu, 19 Dec 2019
 15:25:12 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Nir Soffer <nsoffer@redhat.com>
Subject: Re: [PATCH] qapi/block: fix nbd-server-add spec
Thread-Topic: [PATCH] qapi/block: fix nbd-server-add spec
Thread-Index: AQHVtnnxYNIeaG1fgkq9lkIsLWKUC6fBiECAgAAE4wCAAAIuAIAABLsA
Date: Thu, 19 Dec 2019 15:25:12 +0000
Message-ID: <0d6ea2fe-2f4f-00d4-2f13-20591b56310d@virtuozzo.com>
References: <20191219143415.28490-1-vsementsov@virtuozzo.com>
 <CAMRbyyt8Y8DFV5=72+GvHrAWbdUO5Mys5JGn7D8es+w2SVcRMA@mail.gmail.com>
 <c97f28de-c924-bc42-4725-09b633a28674@virtuozzo.com>
 <CAMRbyyv+h7UrR-vPJVMeGQpp-8Di-VuAZJit798L0Wda0BiE7A@mail.gmail.com>
In-Reply-To: <CAMRbyyv+h7UrR-vPJVMeGQpp-8Di-VuAZJit798L0Wda0BiE7A@mail.gmail.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR07CA0013.eurprd07.prod.outlook.com
 (2603:10a6:7:67::23) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191219182510429
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a910aa90-18bc-4de8-da47-08d78497a431
x-ms-traffictypediagnostic: AM6PR08MB3496:
x-microsoft-antispam-prvs: <AM6PR08MB3496D46E6CFE265E46C2FF83C1520@AM6PR08MB3496.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0256C18696
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(366004)(39840400004)(136003)(346002)(376002)(53754006)(189003)(199004)(66476007)(8676002)(81166006)(81156014)(53546011)(6506007)(8936002)(54906003)(86362001)(66556008)(66946007)(66446008)(64756008)(52116002)(31696002)(6512007)(316002)(71200400001)(2906002)(26005)(186003)(36756003)(4326008)(5660300002)(6916009)(478600001)(966005)(2616005)(31686004)(6486002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3496;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ombpTBTH1qSzGJUlS+GLQcuHNo+L2zzdbIvHEAMvtNzEr7pqzk+bQrLeLfHMqjpPfjmUfmt1UBdmAiFRpJr7pZIoGWFhjNAJz+DN+4Zj5fhKFAAoDVit0aY80JzsIA7Labqvcf8y/Y0liz6a4VRXPgZXh+flvPR5iWkmRnE0CGKOPlt7gZ3qM0iScSBQbbp9zK7cGZWb9Me4erDy6pmN+HTQIc+2HtJKLy/0gCDvn3ll2T1g4mbSRD3M3yQt9s6v/bCSI3GLghJ2+fbNLzxLGBOzem2UNtG244FfnHanVDKszg/FeY7CacFQ17ntpEMIzjGfyw362fItOGnHqf3gArP6G0Kt2Y/SE9OyzCZMOzR/m5ljMOZPU219TqXuRAdTUHVAztlPASHMH/psXpayFZewcUXputQGcs81Q57QJ/axd/9tDT1xMBMu+vSzHrDFuNHR1lrI8/ykX9BwkMne4CVC/mj+l5TCnk5tAsUrAYunIfWa8idWPm8zpoMs4XfgYGwEv1qZrzZoxdA4OUXk5wm8sQ5A8x5jVOlUkDEEt24=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D0CBFBB951F31C478F86D5B34FD93AFF@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a910aa90-18bc-4de8-da47-08d78497a431
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2019 15:25:12.7182 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DtQW+Azw4+2VgE652WeFRs07lsuE2nuwav2BoQ3vD9FUhOuwEMKGtZ8bAyRdpW93kxlKAowt4EkFK7cKb3zIqWfOdfSxFzs3IYUuEIo69Os=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3496
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.113
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

MTkuMTIuMjAxOSAxODowOCwgTmlyIFNvZmZlciB3cm90ZToNCj4gT24gVGh1LCBEZWMgMTksIDIw
MTkgYXQgNTowMCBQTSBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5DQo+IDx2c2VtZW50c292
QHZpcnR1b3p6by5jb20+IHdyb3RlOg0KPj4NCj4+IDE5LjEyLjIwMTkgMTc6NDIsIE5pciBTb2Zm
ZXIgd3JvdGU6DQo+Pj4gT24gVGh1LCBEZWMgMTksIDIwMTkgYXQgNDozNCBQTSBWbGFkaW1pciBT
ZW1lbnRzb3YtT2dpZXZza2l5DQo+Pj4gPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4gd3JvdGU6
DQo+Pj4+DQo+Pj4+ICJOQU1FIiBoZXJlIG1heSBiZSBpbnRlcnByZXRlZCBsaWtlIGl0IHNob3Vs
ZCBtYXRjaCBAbmFtZSwgd2hpY2ggaXMNCj4+Pj4gZXhwb3J0IG5hbWUuIEJ1dCBpdCB3YXMgbmV2
ZXIgbWVudGlvbmVkIGluIHN1Y2ggd2F5LiBNYWtlIGl0IG9idmlvdXMsDQo+Pj4+IHRoYXQgYWN0
dWFsICI8ZGlydHktYml0bWFwLWV4cG9ydC1uYW1lPiIgKHNlZSBkb2NzL2ludGVyb3AvbmJkLnR4
dCkNCj4+Pj4gd2lsbCBtYXRjaCBAYml0bWFwIHBhcmFtZXRlci4NCj4+Pg0KPj4+IEJ1dCB0aGlz
IGlzIHdyb25nLCBkaXJ0eS1iaXRtYXAtZXhwb3J0LW5hbWUgZG9lcyBub3QgbWVhbiB0aGUgYWN0
dWFsIGJpdG1hcA0KPj4+IG5hbWUgYnV0IHRoZSBuYW1lIGV4cG9zZWQgdG8gdGhlIE5CRCBjbGll
bnQsIHdoaWNoIGNhbiBiZSBhbnl0aGluZy4NCj4+DQo+PiBZZXMuIFdoYXQgaXMgd3Jvbmc/IEl0
IGNhbiBiZSBlbnl0aGluZy4gQ3VycmVudGx5IGJ5IGRlZmF1bHQgaXQgaXMgYml0bWFwIG5hbWUu
DQo+PiBJdCBwdXJlbHkgZG9jdW1lbnRlZCAob2theSwgZXZlbiBjb25mdXNpbmdseSBkb2N1bWVu
dGVkKSwgYnV0IGl0IHdhcyBzbyBzaW5jZQ0KPj4gNC4wLiBBbmQgZXhpc3RpbmcgdXNlcnMgb2J2
aW91c2x5IGtub3dzIGhvdyBpdCB3b3JrIChvdGhlcndpc2UsIHRoZXkgY2FuJ3QgdXNlDQo+PiB0
aGUgZmVhdHVyZSkNCj4+DQo+PiBTbywgSSB0aGluayBpdCdzIE9LIHRvIGZpeCBzcGVjIHRvIGRp
cmVjdGx5IHNob3cgaW1wbGVtZW50YXRpb24sIHRoYXQgd2FzIGhlcmUNCj4+IHNpbmNlIGZlYXR1
cmUgaW50cm9kdWNpbmcuDQo+Pg0KPj4+DQo+Pj4+IEZpeGVzOiA1ZmNiZWIwNjgxMjY4NWEyDQo+
Pj4+IFNpZ25lZC1vZmYtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRz
b3ZAdmlydHVvenpvLmNvbT4NCj4+Pj4gLS0tDQo+Pj4+DQo+Pj4+IEhpIGFsbC4NCj4+Pj4NCj4+
Pj4gVGhpcyBwYXRjaCBmb2xsb3dzIGRpc2N1c3Npb24gb24gTmlyJ3MgcGF0Y2gNCj4+Pj4gICAg
W1BBVENIXSBibG9jazogbmJkOiBGaXggZGlydHkgYml0bWFwIGNvbnRleHQgbmFtZQ0KPj4+PiAg
ICAoIGh0dHBzOi8vbGlzdHMuZ251Lm9yZy9hcmNoaXZlL2h0bWwvcWVtdS1kZXZlbC8yMDE5LTEy
L21zZzA0MzA5Lmh0bWwgKQ0KPj4+Pg0KPj4+PiBMZXQncyBqdXN0IGZpeCBxYXBpIHNwZWMgbm93
Lg0KPj4+DQo+Pj4gQnV0IHFhcGkgZG9jdW1lbnRzIGEgYmV0dGVyIGJlaGF2aW9yIGZvciB1c2Vy
cy4gV2Ugc2hvdWxkIGZpeCB0aGUgY29kZSBpbnN0ZWFkDQo+Pj4gdG8gbWFjaCB0aGUgZG9jcy4N
Cj4+DQo+PiAxLiBVc2luZyBkaXNrIG5hbWUgYXMgYSBiaXRtYXAgbmFtZSBpcyBhIGJhZCBiZWhh
dmlvciwgYXMgdGhleSBhcmUgY29tcGxldGVseQ0KPj4gZGlmZmVyZW50IGNvbmNlcHRzLiBFc3Bl
Y2lhbGx5IGtlZXBpbmcgaW4gbWluZCB0aGF0IHVzZXIgYWxyZWFkeSBrbm93cyBkaXNrIG5hbWUg
YW55d2F5DQo+PiBhbmQgbm8gcmVhc29uIHRvIHdyaXRlIHRoaXMgZXhwb3J0IG5hbWUgaW5zaWRl
IG1ldGFkYXRhIGNvbnRleHQgb2YgdGhpcyBleHBvcnQuDQo+IA0KPiBUaGUgZGlmZmVyZW50IGNv
bmNlcHQgaXMgZXhwcmVzc2VkIGJ5IHRoZSAicWVtdTpkaXJ0eS1iaXRtYXA6IiBwcmVmaXguDQo+
ICJxZW11OmRpcnR5LWJpdG1hcDpleHBvcnQtbmFtZSIgbWVhbnMgdGhlIGRpcnR5IGJpdG1hcCBm
b3IgdGhpcyBleHBvcnQuDQoNCldoeSBkbyB5b3UgdGhpbmsgc28/IERpZCB5b3UgcmVhZCBOQkQg
c3BlY2lmaWNhdGlvbj8NCg0KTWV0YWRhdGEgY29udGV4dCBpcyBhbHdheXMgb3duZWQgYnkgc29t
ZSBleHBvcnQuIERvIHlvdSBtZWFuIHRoYXQgdGhlcmUgd2lsbCBiZQ0KbWV0YWRhdGEgY29udGV4
dHMNCg0KcWVtdTpkaXJ0eS1iaXRtYXA6ZXhwb3J0LUENCnFlbXU6ZGlydHktYml0bWFwOmV4cG9y
dC1CDQoNCmJvdGggZGVmaW5lZCBmb3IgZXhwb3J0LUE/DQoNCj4gDQo+PiAyLiBJdCdzIG5vdCBk
aXJlY3RseSBkb2N1bWVudGVkLiBZb3UgYXNzdW1lIHRoYXQgTkFNRSA9PSBAbmFtZS4gSSB1bmRl
cnN0YW5kIHRoYXQNCj4+IGl0IG1heSBiZSBhc3N1bWVkLi4gQnV0IGl0J3Mgbm90IGRvY3VtZW50
ZWQuDQo+IA0KPiBCdXQgTkFNRSBpcyBsaWtlbHkgdG8gYmUgdW5kZXJzdG9vZCBhcyB0aGUgbmFt
ZSBhcmd1bWVudCwgYW5kIHVubGlrZWx5IHRvIGJlIHRoZQ0KPiBiaXRtYXAgbmFtZS4NCg0KWWVz
IGxpa2VseS4gQnV0IGl0J3Mgc3RpbGwgYmFkIHNwZWNpZmljYXRpb24sIHdoaWNoIHNob3VsZCBi
ZSBmaXhlZC4NCg0KPiANCj4+IDMuIEl0J3MgbmV2ZXIgd29ya2VkIGxpa2UgeW91IHdyaXRlLiBT
byBpZiB3ZSBjaGFuZ2UgdGhlIGJlaGF2aW9yLCB3ZSdsbCBicmVhaw0KPj4gZXhpc3RpbmcgdXNl
cnMuDQo+IA0KPiBEbyB3ZSBoYXZlIGV4aXN0aW5nIHVzZXJzPyBpc24ndCB0aGlzIG5ldyBmZWF0
dXJlIGluIDQuMj8NCg0KTm8sIGl0J3Mgc2luY2UgNC4wDQoNCj4gDQo+IEJlZm9yZSB3ZSBoYWQg
ZXhwZXJpbWVudGFsIHgtYmxvY2stZGlydHktYml0bWFwIEFQSXMsIHdoaWNoIGFyZSBzdGFibGUs
IHNvIHVzZXJzDQo+IGNvdWxkIG5vdCBkZXBlbmQgb24gdGhlbS4NCj4gDQo+Pj4gV2l0aCB0aGlz
IHdlIHN0aWxsIGhhdmUgdGhlIGlzc3VlIG9mIGxlYWtpbmcgaW50ZXJuYWwgYml0bWFwIG5hbWUg
dG8NCj4+PiB1c2VycyB3aG8gZG8gbm90DQo+Pj4gY29udHJvbCB0aGUgbmFtZSwgYW5kIGRvIG5v
dCBjYXJlIGFib3V0IGl0Lg0KPj4+DQo+Pj4+ICAgIHFhcGkvYmxvY2suanNvbiB8IDMgKystDQo+
Pj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+
Pj4NCj4+Pj4gZGlmZiAtLWdpdCBhL3FhcGkvYmxvY2suanNvbiBiL3FhcGkvYmxvY2suanNvbg0K
Pj4+PiBpbmRleCAxNDVjMjY4YmI2Li44MDQyZWY3OGYwIDEwMDY0NA0KPj4+PiAtLS0gYS9xYXBp
L2Jsb2NrLmpzb24NCj4+Pj4gKysrIGIvcWFwaS9ibG9jay5qc29uDQo+Pj4+IEBAIC0yNTUsNyAr
MjU1LDggQEANCj4+Pj4NCj4+Pj4gICAgIyBAYml0bWFwOiBBbHNvIGV4cG9ydCB0aGUgZGlydHkg
Yml0bWFwIHJlYWNoYWJsZSBmcm9tIEBkZXZpY2UsIHNvIHRoZQ0KPj4+PiAgICAjICAgICAgICAg
IE5CRCBjbGllbnQgY2FuIHVzZSBOQkRfT1BUX1NFVF9NRVRBX0NPTlRFWFQgd2l0aA0KPj4+PiAt
IyAgICAgICAgICAicWVtdTpkaXJ0eS1iaXRtYXA6TkFNRSIgdG8gaW5zcGVjdCB0aGUgYml0bWFw
LiAoc2luY2UgNC4wKQ0KPj4+PiArIyAgICAgICAgICAicWVtdTpkaXJ0eS1iaXRtYXA6QklUTUFQ
IiB0byBpbnNwZWN0IHRoZSBiaXRtYXAgKEJJVE1BUCBoZXJlDQo+Pj4+ICsjICAgICAgICAgIG1h
dGNoZXMgQGJpdG1hcCBwYXJhbWV0ZXIpLiAoc2luY2UgNC4wKQ0KPj4+PiAgICAjDQo+Pj4+ICAg
ICMgUmV0dXJuczogZXJyb3IgaWYgdGhlIHNlcnZlciBpcyBub3QgcnVubmluZywgb3IgZXhwb3J0
IHdpdGggdGhlIHNhbWUgbmFtZQ0KPj4+PiAgICAjICAgICAgICAgIGFscmVhZHkgZXhpc3RzLg0K
Pj4+PiAtLQ0KPj4+PiAyLjIxLjANCj4+Pj4NCj4+Pg0KPj4NCj4+DQo+PiAtLQ0KPj4gQmVzdCBy
ZWdhcmRzLA0KPj4gVmxhZGltaXINCj4gDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1p
cg0K

