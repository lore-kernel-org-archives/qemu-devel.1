Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA096C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 09:26:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4C532146E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 09:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="aU99gkgB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4C532146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiEYM-0005ad-Rc
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 04:26:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33415)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iiEXY-0004j4-Hz
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 04:25:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iiEXV-0000L8-CO
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 04:25:44 -0500
Received: from mail-eopbgr130102.outbound.protection.outlook.com
 ([40.107.13.102]:19073 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iiEXQ-0008LO-8a; Fri, 20 Dec 2019 04:25:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DmM+68e7aZkIJVr+g4JMBcnt+wURRng0ryxCesw0Ty1BxLPA2Q7VsHdJfyK9PH9bPVIUB5N7KvutD4Xy9dC5amPnDiYegOZSb+Y30BSLjI5TybfYuIonN3RmWs/7TZxhHxSlZzeP1wTq8MLWaJESWn6EdB56Hv+pq9rEFakiK2hp57hZk1P4zGp824gZLlXMn65dgmBnPiMnike7doYZSi4umMo5YKOdFVCX3j/hIA6So3X8XuIhMRctQlCSG5Z7mt2SpFWMgM9xk5OTj+CCPg18k9BfZZUBKDRcLMNovuPaRfby0mifhg1mfMdqLwB0bXVkffPF7ONTWCdqrHGIOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y245WSJbVEZW0OY2J4qR1+29ggHwDk+VLwEBBMeikbw=;
 b=VMS6ylEeHhzM26lbyq5M4FynCsjQkbkOug8SOk1RcW0Jmz42xd4IRPyz7ho4mhxkkd6xsrSDtODjNEIqdO8ZeBkRrOM8cayf2nB+VzReDQTbujLVidrkOuD7mt8xCMmA3Kykv37xc8yxL1VFJXOX6TOe2lFbzZpzbzg+6fTnYah4P92EJ+juBRGQa1dwuKGHYLBua7F0duTC3xJalxD4qfHJYyeccG8n6TDnN+hVwOUzxXN/hIJuLXhDuBRZaH3LHEzAf8XzkS0fk1HKYT55kveGeAvMxElhEHVNCDhPKgU3qGgM+ANoOw7keIIl7ntMGSoO4TIz7nqmPWO+JHrBOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y245WSJbVEZW0OY2J4qR1+29ggHwDk+VLwEBBMeikbw=;
 b=aU99gkgBpjuFHb2mmOpeQINSZpL4KjHnHXfPM8b0jtLwLxn/nsv6vRVD3n+SFPe9EYRoQljXWY9QdQV2IexFWU+UrqSVdViDa35sgL0Z5pJEpPwqFro4oJuwXOKzBEJTw1cflQbKeitNe2EpwmSLiRH/HIhB92Wlf/pbkwh8rOM=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3141.eurprd08.prod.outlook.com (52.135.166.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.15; Fri, 20 Dec 2019 09:25:32 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2559.016; Fri, 20 Dec 2019
 09:25:31 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Nir Soffer <nsoffer@redhat.com>
Subject: Re: [PATCH] qapi/block: fix nbd-server-add spec
Thread-Topic: [PATCH] qapi/block: fix nbd-server-add spec
Thread-Index: AQHVtnnxYNIeaG1fgkq9lkIsLWKUC6fBiECAgAAE4wCAAAIuAIAABLsAgAAN2ICAAR/+gA==
Date: Fri, 20 Dec 2019 09:25:31 +0000
Message-ID: <060ab549-5dde-bf66-fb0f-0c75731f7065@virtuozzo.com>
References: <20191219143415.28490-1-vsementsov@virtuozzo.com>
 <CAMRbyyt8Y8DFV5=72+GvHrAWbdUO5Mys5JGn7D8es+w2SVcRMA@mail.gmail.com>
 <c97f28de-c924-bc42-4725-09b633a28674@virtuozzo.com>
 <CAMRbyyv+h7UrR-vPJVMeGQpp-8Di-VuAZJit798L0Wda0BiE7A@mail.gmail.com>
 <0d6ea2fe-2f4f-00d4-2f13-20591b56310d@virtuozzo.com>
 <CAMRbyys6na7S4q00VR81LNhfNvtEXUAFQV=2R1O506+p_U+VKA@mail.gmail.com>
In-Reply-To: <CAMRbyys6na7S4q00VR81LNhfNvtEXUAFQV=2R1O506+p_U+VKA@mail.gmail.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P190CA0044.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::33)
 To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191220122529811
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e9ecfefa-a4a1-4b38-f0d9-08d7852e8f65
x-ms-traffictypediagnostic: AM6PR08MB3141:
x-microsoft-antispam-prvs: <AM6PR08MB3141C1366B6C52DD9654BCDDC12D0@AM6PR08MB3141.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 025796F161
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(366004)(39840400004)(396003)(376002)(346002)(53754006)(189003)(199004)(54906003)(6512007)(6916009)(2616005)(4326008)(6486002)(316002)(2906002)(71200400001)(186003)(86362001)(31696002)(8936002)(66476007)(66946007)(6506007)(66446008)(53546011)(31686004)(64756008)(26005)(66556008)(36756003)(8676002)(478600001)(52116002)(966005)(81166006)(81156014)(5660300002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3141;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +TiH4EXHO8Xd1KaE/0BSksPeeZNg10hQOzdN4haqWdYka9x/mfxtu/FBZOA8yoySHHtcx1GMhR4hwO1kov03cSZ98kwc0mpespE5fkSxb/wtcubd63ytNXbqugo8B6FqAiglZYUHClIdP3cq882nW6p0mLBH+Jd+4VEUZIrb+LG2tOPOUdV4YWws8xQDvMFqBMwQEfqug1B+LRrceZyx3tQxh379lx8qMMiOuVG6slA5l78fRBHGx2ZfGAiujlZlEz7JxdGoHf++jxhL/7LutI/HofQFXdCYhBygP1GP2mWIiPf06SoLl5gZh+IlWdB47hyR4k6t1YFnG/IItxcA85kr3aZOkUZYJZJdenCH+TFeuwRXYzGY4IIytFBBhedfi0XkeId5Plw+CUjL0aYP8DsqfreLnVOat2cL0fIcGg2Ob0D7Yf4ctTjuUJXDVZuyZ2NKzm6EmE6ArzVDiB5qwyFygRT6InbP17K4CDw9MWEhZZu65tSi1ZA6lt4iSaM1GhOb+XJfjBmzvVCVePYsnnoeiXTEmMSuPj3PKZTnBgI=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <8990BB0E6458674493B0A85A0EE38360@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9ecfefa-a4a1-4b38-f0d9-08d7852e8f65
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2019 09:25:31.8436 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q2TfDhSWni5qtiedsCseF62OcgkXwiyh7FMfcU+D7fh51f6RwmMVQe+DEf++vBGWVb5mP3X074O7xyYgThqswB7zWBUN1FwuEPu0Kof6Urc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3141
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.102
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

MTkuMTIuMjAxOSAxOToxNCwgTmlyIFNvZmZlciB3cm90ZToNCj4gT24gVGh1LCBEZWMgMTksIDIw
MTkgYXQgNToyNSBQTSBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5DQo+IDx2c2VtZW50c292
QHZpcnR1b3p6by5jb20+IHdyb3RlOg0KPj4NCj4+IDE5LjEyLjIwMTkgMTg6MDgsIE5pciBTb2Zm
ZXIgd3JvdGU6DQo+Pj4gT24gVGh1LCBEZWMgMTksIDIwMTkgYXQgNTowMCBQTSBWbGFkaW1pciBT
ZW1lbnRzb3YtT2dpZXZza2l5DQo+Pj4gPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4gd3JvdGU6
DQo+Pj4+DQo+Pj4+IDE5LjEyLjIwMTkgMTc6NDIsIE5pciBTb2ZmZXIgd3JvdGU6DQo+Pj4+PiBP
biBUaHUsIERlYyAxOSwgMjAxOSBhdCA0OjM0IFBNIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNr
aXkNCj4+Pj4+IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+IHdyb3RlOg0KPj4+Pj4+DQo+Pj4+
Pj4gIk5BTUUiIGhlcmUgbWF5IGJlIGludGVycHJldGVkIGxpa2UgaXQgc2hvdWxkIG1hdGNoIEBu
YW1lLCB3aGljaCBpcw0KPj4+Pj4+IGV4cG9ydCBuYW1lLiBCdXQgaXQgd2FzIG5ldmVyIG1lbnRp
b25lZCBpbiBzdWNoIHdheS4gTWFrZSBpdCBvYnZpb3VzLA0KPj4+Pj4+IHRoYXQgYWN0dWFsICI8
ZGlydHktYml0bWFwLWV4cG9ydC1uYW1lPiIgKHNlZSBkb2NzL2ludGVyb3AvbmJkLnR4dCkNCj4+
Pj4+PiB3aWxsIG1hdGNoIEBiaXRtYXAgcGFyYW1ldGVyLg0KPj4+Pj4NCj4+Pj4+IEJ1dCB0aGlz
IGlzIHdyb25nLCBkaXJ0eS1iaXRtYXAtZXhwb3J0LW5hbWUgZG9lcyBub3QgbWVhbiB0aGUgYWN0
dWFsIGJpdG1hcA0KPj4+Pj4gbmFtZSBidXQgdGhlIG5hbWUgZXhwb3NlZCB0byB0aGUgTkJEIGNs
aWVudCwgd2hpY2ggY2FuIGJlIGFueXRoaW5nLg0KPj4+Pg0KPj4+PiBZZXMuIFdoYXQgaXMgd3Jv
bmc/IEl0IGNhbiBiZSBlbnl0aGluZy4gQ3VycmVudGx5IGJ5IGRlZmF1bHQgaXQgaXMgYml0bWFw
IG5hbWUuDQo+Pj4+IEl0IHB1cmVseSBkb2N1bWVudGVkIChva2F5LCBldmVuIGNvbmZ1c2luZ2x5
IGRvY3VtZW50ZWQpLCBidXQgaXQgd2FzIHNvIHNpbmNlDQo+Pj4+IDQuMC4gQW5kIGV4aXN0aW5n
IHVzZXJzIG9idmlvdXNseSBrbm93cyBob3cgaXQgd29yayAob3RoZXJ3aXNlLCB0aGV5IGNhbid0
IHVzZQ0KPj4+PiB0aGUgZmVhdHVyZSkNCj4+Pj4NCj4+Pj4gU28sIEkgdGhpbmsgaXQncyBPSyB0
byBmaXggc3BlYyB0byBkaXJlY3RseSBzaG93IGltcGxlbWVudGF0aW9uLCB0aGF0IHdhcyBoZXJl
DQo+Pj4+IHNpbmNlIGZlYXR1cmUgaW50cm9kdWNpbmcuDQo+Pj4+DQo+Pj4+Pg0KPj4+Pj4+IEZp
eGVzOiA1ZmNiZWIwNjgxMjY4NWEyDQo+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogVmxhZGltaXIgU2Vt
ZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KPj4+Pj4+IC0tLQ0K
Pj4+Pj4+DQo+Pj4+Pj4gSGkgYWxsLg0KPj4+Pj4+DQo+Pj4+Pj4gVGhpcyBwYXRjaCBmb2xsb3dz
IGRpc2N1c3Npb24gb24gTmlyJ3MgcGF0Y2gNCj4+Pj4+PiAgICAgW1BBVENIXSBibG9jazogbmJk
OiBGaXggZGlydHkgYml0bWFwIGNvbnRleHQgbmFtZQ0KPj4+Pj4+ICAgICAoIGh0dHBzOi8vbGlz
dHMuZ251Lm9yZy9hcmNoaXZlL2h0bWwvcWVtdS1kZXZlbC8yMDE5LTEyL21zZzA0MzA5Lmh0bWwg
KQ0KPj4+Pj4+DQo+Pj4+Pj4gTGV0J3MganVzdCBmaXggcWFwaSBzcGVjIG5vdy4NCj4+Pj4+DQo+
Pj4+PiBCdXQgcWFwaSBkb2N1bWVudHMgYSBiZXR0ZXIgYmVoYXZpb3IgZm9yIHVzZXJzLiBXZSBz
aG91bGQgZml4IHRoZSBjb2RlIGluc3RlYWQNCj4+Pj4+IHRvIG1hY2ggdGhlIGRvY3MuDQo+Pj4+
DQo+Pj4+IDEuIFVzaW5nIGRpc2sgbmFtZSBhcyBhIGJpdG1hcCBuYW1lIGlzIGEgYmFkIGJlaGF2
aW9yLCBhcyB0aGV5IGFyZSBjb21wbGV0ZWx5DQo+Pj4+IGRpZmZlcmVudCBjb25jZXB0cy4gRXNw
ZWNpYWxseSBrZWVwaW5nIGluIG1pbmQgdGhhdCB1c2VyIGFscmVhZHkga25vd3MgZGlzayBuYW1l
IGFueXdheQ0KPj4+PiBhbmQgbm8gcmVhc29uIHRvIHdyaXRlIHRoaXMgZXhwb3J0IG5hbWUgaW5z
aWRlIG1ldGFkYXRhIGNvbnRleHQgb2YgdGhpcyBleHBvcnQuDQo+Pj4NCj4+PiBUaGUgZGlmZmVy
ZW50IGNvbmNlcHQgaXMgZXhwcmVzc2VkIGJ5IHRoZSAicWVtdTpkaXJ0eS1iaXRtYXA6IiBwcmVm
aXguDQo+Pj4gInFlbXU6ZGlydHktYml0bWFwOmV4cG9ydC1uYW1lIiBtZWFucyB0aGUgZGlydHkg
Yml0bWFwIGZvciB0aGlzIGV4cG9ydC4NCj4+DQo+PiBXaHkgZG8geW91IHRoaW5rIHNvPyBEaWQg
eW91IHJlYWQgTkJEIHNwZWNpZmljYXRpb24/DQo+IA0KPiBZZXMgLSB0aGUgbmFtZSBvZiB0aGUg
Yml0bWFwIGRvZXMgbm90IGhhdmUgYW55IG1lYW5pbmcuDQoNCml0IGRvZXMgbm90IGhhdmUgYW55
IG1lYW5pbmcgaW4geW91ciBzY2VuYXJpby4gQnV0IGluIHNvbWUgb3RoZXIsIHdoZW4gd2UgbmVl
ZA0KdG8gZXhwb3J0IHNldmVyYWwgYml0bWFwcywgdGhlIG5hbWUgd2lsbCBiZSB1c2VkLg0KDQo+
IEJ1dCBmb3IgbmJkX3NlcnZlcl9hZGQgd2UgYWxsb3cgb25seSBzaW5nbGUgYml0bWFwIGZvciBl
eHBvcnQuDQoNClllcywgUWVtdSBqdXN0IGRvbid0IHVzZSB0aGUgd2hvbGUgcG93ZXIgb2YgTkJE
IHNwZWMuIEJ1dCBpdCBtYXkgY2hhbmdlLg0KDQo+IA0KPj4gTWV0YWRhdGEgY29udGV4dCBpcyBh
bHdheXMgb3duZWQgYnkgc29tZSBleHBvcnQuDQo+IA0KPiBPZiBjb3Vyc2UuDQo+IA0KPj4gRG8g
eW91IG1lYW4gdGhhdCB0aGVyZSB3aWxsIGJlbWV0YWRhdGEgY29udGV4dHMNCj4+DQo+PiBxZW11
OmRpcnR5LWJpdG1hcDpleHBvcnQtQQ0KPj4gcWVtdTpkaXJ0eS1iaXRtYXA6ZXhwb3J0LUINCj4+
DQo+PiBib3RoIGRlZmluZWQgZm9yIGV4cG9ydC1BPw0KPiANCj4gSXQgZG9lcyBub3QgbWFrZSBz
ZW5zZSwgYnV0IGl0IGlzIHZhbGlkLg0KDQpJdCBjb25mbGljdHMgd2l0aCB0aGUgZmFjdCB0aGF0
IGJvdGggY29udGV4dHMgYXJlIG93bmVkIGJ5IGV4cG9ydC1BLiBUaGUgaWRlYQ0Kd2FzIHRoYXQg
bWV0YWRhdGEgaXMgYm91bmQgdG8gdGhlIGV4cG9ydC4gV2Ugc2hvdWxkIG5vdCBzZWUgbWV0YWRh
dGEgb2YgZXhwb3J0DQpCIGluIG1ldGFkYXRhIG9mIGV4cG9ydCBBLg0KDQpNb3Jlb3ZlciwgY29u
c2lkZXIgdGhhdCB0aGVzZSB0d28gZXhwb3J0cyBtYXkgaGF2ZSBkaWZmZXJlbnQgc2l6ZS4gVGhl
biBob3cgTkJEX0NNRF9CTE9DS19TVEFUVVMNCndpbGwgd29yaz8NCg0KV2UgZG9uJ3QgaGF2ZSBn
bG9iYWwgbmJkIHNlcnZlciBtZXRhZGF0YSwgbGlrZSB5b3UgY29uc2lkZXIgaXQuIFdlIG9ubHkg
aGF2ZSBwZXItZXhwb3J0IG1ldGFkYXRhLA0Kd2hpY2ggaXMgYm91bmQgKGF0IGxlYXN0IGJ5IHNp
emUpIHRvIHRoZSBleHBvcnQuIFNvIGl0J3MgdGhlb3JldGljYWxseSBwb3NzaWJsZSB0byBleHBv
cnQgYml0bWFwDQpvZiBhbm90aGVyIG5iZC1leHBvcnQgKGlmIGl0IGhhcyB0aGUgc2FtZSBzaXpl
KSwgYnV0IGl0IGJyZWFrcyB0aGUgY29uY2VwdC4NCg0KPiANCj4+Pj4gMi4gSXQncyBub3QgZGly
ZWN0bHkgZG9jdW1lbnRlZC4gWW91IGFzc3VtZSB0aGF0IE5BTUUgPT0gQG5hbWUuIEkgdW5kZXJz
dGFuZCB0aGF0DQo+Pj4+IGl0IG1heSBiZSBhc3N1bWVkLi4gQnV0IGl0J3Mgbm90IGRvY3VtZW50
ZWQuDQo+Pj4NCj4+PiBCdXQgTkFNRSBpcyBsaWtlbHkgdG8gYmUgdW5kZXJzdG9vZCBhcyB0aGUg
bmFtZSBhcmd1bWVudCwgYW5kIHVubGlrZWx5IHRvIGJlIHRoZQ0KPj4+IGJpdG1hcCBuYW1lLg0K
Pj4NCj4+IFllcyBsaWtlbHkuIEJ1dCBpdCdzIHN0aWxsIGJhZCBzcGVjaWZpY2F0aW9uLCB3aGlj
aCBzaG91bGQgYmUgZml4ZWQuDQo+IA0KPiBJZiB3ZSBjYW5ub3QgY2hhbmdlIHRoZSBjdXJyZW50
IGJlaGF2aW9yIHNpbmNlIGl0IHdpbGwgYnJlYWsgY3VycmVudCB1c2VycywNCj4gSSBhZ3JlZSBm
aXhpbmcgdGhlIHNwZWMgdG8gZGVzY3JpYmUgdGhlIGN1cnJlbnQgYmVoYXZpb3IgaXMgYSBnb29k
IGlkZWEuDQo+IA0KPiANCj4gDQo+IA0KPj4+DQo+Pj4+IDMuIEl0J3MgbmV2ZXIgd29ya2VkIGxp
a2UgeW91IHdyaXRlLiBTbyBpZiB3ZSBjaGFuZ2UgdGhlIGJlaGF2aW9yLCB3ZSdsbCBicmVhaw0K
Pj4+PiBleGlzdGluZyB1c2Vycy4NCj4+Pg0KPj4+IERvIHdlIGhhdmUgZXhpc3RpbmcgdXNlcnM/
IGlzbid0IHRoaXMgbmV3IGZlYXR1cmUgaW4gNC4yPw0KPj4NCj4+IE5vLCBpdCdzIHNpbmNlIDQu
MA0KPj4NCj4+Pg0KPj4+IEJlZm9yZSB3ZSBoYWQgZXhwZXJpbWVudGFsIHgtYmxvY2stZGlydHkt
Yml0bWFwIEFQSXMsIHdoaWNoIGFyZSBzdGFibGUsIHNvIHVzZXJzDQo+Pj4gY291bGQgbm90IGRl
cGVuZCBvbiB0aGVtLg0KPj4+DQo+Pj4+PiBXaXRoIHRoaXMgd2Ugc3RpbGwgaGF2ZSB0aGUgaXNz
dWUgb2YgbGVha2luZyBpbnRlcm5hbCBiaXRtYXAgbmFtZSB0bw0KPj4+Pj4gdXNlcnMgd2hvIGRv
IG5vdA0KPj4+Pj4gY29udHJvbCB0aGUgbmFtZSwgYW5kIGRvIG5vdCBjYXJlIGFib3V0IGl0Lg0K
Pj4+Pj4NCj4+Pj4+PiAgICAgcWFwaS9ibG9jay5qc29uIHwgMyArKy0NCj4+Pj4+PiAgICAgMSBm
aWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4+Pj4+DQo+Pj4+
Pj4gZGlmZiAtLWdpdCBhL3FhcGkvYmxvY2suanNvbiBiL3FhcGkvYmxvY2suanNvbg0KPj4+Pj4+
IGluZGV4IDE0NWMyNjhiYjYuLjgwNDJlZjc4ZjAgMTAwNjQ0DQo+Pj4+Pj4gLS0tIGEvcWFwaS9i
bG9jay5qc29uDQo+Pj4+Pj4gKysrIGIvcWFwaS9ibG9jay5qc29uDQo+Pj4+Pj4gQEAgLTI1NSw3
ICsyNTUsOCBAQA0KPj4+Pj4+DQo+Pj4+Pj4gICAgICMgQGJpdG1hcDogQWxzbyBleHBvcnQgdGhl
IGRpcnR5IGJpdG1hcCByZWFjaGFibGUgZnJvbSBAZGV2aWNlLCBzbyB0aGUNCj4+Pj4+PiAgICAg
IyAgICAgICAgICBOQkQgY2xpZW50IGNhbiB1c2UgTkJEX09QVF9TRVRfTUVUQV9DT05URVhUIHdp
dGgNCj4+Pj4+PiAtIyAgICAgICAgICAicWVtdTpkaXJ0eS1iaXRtYXA6TkFNRSIgdG8gaW5zcGVj
dCB0aGUgYml0bWFwLiAoc2luY2UgNC4wKQ0KPj4+Pj4+ICsjICAgICAgICAgICJxZW11OmRpcnR5
LWJpdG1hcDpCSVRNQVAiIHRvIGluc3BlY3QgdGhlIGJpdG1hcCAoQklUTUFQIGhlcmUNCj4+Pj4+
PiArIyAgICAgICAgICBtYXRjaGVzIEBiaXRtYXAgcGFyYW1ldGVyKS4gKHNpbmNlIDQuMCkNCj4+
Pj4+PiAgICAgIw0KPj4+Pj4+ICAgICAjIFJldHVybnM6IGVycm9yIGlmIHRoZSBzZXJ2ZXIgaXMg
bm90IHJ1bm5pbmcsIG9yIGV4cG9ydCB3aXRoIHRoZSBzYW1lIG5hbWUNCj4+Pj4+PiAgICAgIyAg
ICAgICAgICBhbHJlYWR5IGV4aXN0cy4NCj4+Pj4+PiAtLQ0KPj4+Pj4+IDIuMjEuMA0KPj4+Pj4+
DQo+Pj4+Pg0KPj4+Pg0KPj4+Pg0KPj4+PiAtLQ0KPj4+PiBCZXN0IHJlZ2FyZHMsDQo+Pj4+IFZs
YWRpbWlyDQo+Pj4NCj4+DQo+Pg0KPj4gLS0NCj4+IEJlc3QgcmVnYXJkcywNCj4+IFZsYWRpbWly
DQo+IA0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

