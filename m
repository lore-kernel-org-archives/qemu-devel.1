Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA20DC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 17:04:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 844C9222C2
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 17:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ooGJlhVu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 844C9222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX6v3-0008Mc-SR
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 12:04:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45389)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iX6qg-0005O1-W1
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 11:59:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iX6qf-0005gO-CX
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 11:59:30 -0500
Received: from mail-eopbgr140115.outbound.protection.outlook.com
 ([40.107.14.115]:20758 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iX6qe-0005eM-Ju
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 11:59:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bjRsre/8djj3b+DeNsdOzqrWR341Vp4oTAWseBw1NdJTf8I9AB9yJpYq2n9K8cj+8k2jio+/z++OvFUyJiaUVuYjFxrAwXUWQmHedOl0mAn5fhovlNyE8jiLSMOmsPT6bGqIdBMwg/MfbpbFu2mVRiWFQDae3jBjXt7Uv1MwZSNeJ6cy8JzHYEGsbpOs1iRpDWaSmHfO3htiTVX+OH58yRcUcjrdjR5+y4+MCDFdhIiIir1Pz96sjtSildWfJa/59iIeVqUVunhBP+Ba3OrM4x1IGOwS/Ye2RuOslXPk7DDYSFfIaDSVy3L0xb76JZ6gmNvWmPVhKOo+CYIB5wu7Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IqE78AMcYR1vZboejE79plSZ2lKlvemj1KitTd3UqKM=;
 b=dE+Qe6szIpXUpB+9djI0/6hn/+LgYxt/XxIL91Q1gEcSREcXqgWhTPj81A/JoEZ40QuJxWOQ/F3o3kIKHKr2fYIrA9xafe4rNcGEqJFy3YUcgoq2nV48SwApk3k3Dl3GSRDb7TZPQAyRDx9WIFrYOFXFELH2Qh8j/N4Tc6lfaolBxophA8fp0SUsk3ax1MOo/JlyiklhtaN4Gq7yWxHv3BDz756mTyQHVmIJd555Ak4GmQ6AXDCCVZYl1in/5Fj8ynQJg9kCQsCDPOdztnUDV/TIrwhzQ3Y9Bgaqtcm2Mv1SPH7Exoxc5JbZXWGnUGq1A+ADWfOPNtUWY7Cygnq4hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IqE78AMcYR1vZboejE79plSZ2lKlvemj1KitTd3UqKM=;
 b=ooGJlhVui39mecnS5EEiCNs8UxHMx2q3NNboBS43TxjuiVyZB5J1sCiGRV/a4+9K56vWUorppTUBNn+7M46I17RtFP5JNM/X63OreKBoZH7dnwRuZ2Qe6cRs7O6f+Lxpjlnk+bXzoyvLWf0rjpfnq8Dj17IFwlIazXIYC9Drs9o=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3750.eurprd08.prod.outlook.com (20.178.88.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.29; Tue, 19 Nov 2019 16:59:23 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2451.031; Tue, 19 Nov 2019
 16:59:23 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [RFC v5 054/126] virtio-9p: introduce ERRP_AUTO_PROPAGATE
Thread-Topic: [RFC v5 054/126] virtio-9p: introduce ERRP_AUTO_PROPAGATE
Thread-Index: AQHVgE3RgUutGEwxM0CZSXnWHj41fqeS9AkAgAAAu4A=
Date: Tue, 19 Nov 2019 16:59:23 +0000
Message-ID: <aef514db-f55a-bc5d-f9d2-b9a54d9e1ce7@virtuozzo.com>
References: <20191011160552.22907-1-vsementsov@virtuozzo.com>
 <20191011160552.22907-55-vsementsov@virtuozzo.com>
 <20191119175644.058cce0b@bahia.lan>
In-Reply-To: <20191119175644.058cce0b@bahia.lan>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0501CA0007.eurprd05.prod.outlook.com
 (2603:10a6:3:1a::17) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191119195921797
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 399797a1-fa40-4409-9ac9-08d76d11d419
x-ms-traffictypediagnostic: AM6PR08MB3750:
x-microsoft-antispam-prvs: <AM6PR08MB375012C71B3048270731A681C14C0@AM6PR08MB3750.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:419;
x-forefront-prvs: 022649CC2C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(39840400004)(376002)(346002)(136003)(366004)(189003)(199004)(25786009)(8676002)(6916009)(81166006)(6116002)(3846002)(81156014)(31696002)(26005)(229853002)(316002)(386003)(6506007)(6436002)(54906003)(6486002)(102836004)(66066001)(6246003)(186003)(99286004)(5660300002)(7736002)(66476007)(446003)(66946007)(478600001)(66446008)(64756008)(6512007)(486006)(11346002)(305945005)(476003)(66556008)(2616005)(36756003)(8936002)(14444005)(86362001)(256004)(31686004)(52116002)(71200400001)(71190400001)(76176011)(4326008)(2906002)(14454004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3750;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fwyuWELfbokQpCOESNP4lhCD8Yw+CIxRcCsHfdQxz5qHUsGzyzoOHYrLU83bOz/mckgKYAria8gHnkYp930VHMKeYqZXQBWF16RELcxiJsCTDIL6i55lV/rPefWINohH9oXiS7NaaFiMRknj+UMmLWltj3RK7sQkF7M6D2rAk+l4vOt4b8RhoOQ7CKUyk+Cof4E/yIaGk3GMRacPiTu5+ZtmRP2wVp+hOc3ngr3Gp1WgYx5ANOQdvKpRFQ5VLxi3s0yPFfaIP8J1j4HFS6fyKko6iT/V63MSQIqH2EzrYk1J7IClxFXKMYCeevpnEHNHm9jG32Eo3Rec5OC5NzTIsusgao6d9lYJOAmOExKLB+UYpLqrg1z25wTgPHSB8+BrPmRmfZwxs+DyyFB7M7NAM0LJt9FEsKX8UdHXdgD7SKe2DmhoRHzLZOIgEHS4HRmg
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F03A9A14F67DBE4EA0D79C65CF99672F@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 399797a1-fa40-4409-9ac9-08d76d11d419
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2019 16:59:23.8792 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WemmkRFIO4EV2Cx/CPpPnxJ1XppuAO7fjwC2uEdGiUpBB4/tf9hbA/UTC8UPTn6m51zP9T605wkA2EGphWdM+s9sjoZBusr0hx2ZR+kjdDU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3750
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.14.115
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTkuMTEuMjAxOSAxOTo1NiwgR3JlZyBLdXJ6IHdyb3RlOg0KPiBTb3JyeSBmb3IgdGhlIGxhdGUg
cmV2aWV3Li4uDQo+IA0KPiBPbiBGcmksIDExIE9jdCAyMDE5IDE5OjA0OjQwICswMzAwDQo+IFZs
YWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4gd3Jv
dGU6DQo+IA0KPj4gSWYgd2Ugd2FudCB0byBhZGQgc29tZSBpbmZvIHRvIGVycnAgKGJ5IGVycm9y
X3ByZXBlbmQoKSBvcg0KPj4gZXJyb3JfYXBwZW5kX2hpbnQoKSksIHdlIG11c3QgdXNlIHRoZSBF
UlJQX0FVVE9fUFJPUEFHQVRFIG1hY3JvLg0KPj4gT3RoZXJ3aXNlLCB0aGlzIGluZm8gd2lsbCBu
b3QgYmUgYWRkZWQgd2hlbiBlcnJwID09ICZmYXRhbF9lcnINCj4gDQo+IHMvZmF0YWxfZXJyL2Vy
cm9yX2ZhdGFsLw0KPiANCj4+ICh0aGUgcHJvZ3JhbSB3aWxsIGV4aXQgcHJpb3IgdG8gdGhlIGVy
cm9yX2FwcGVuZF9oaW50KCkgb3INCj4+IGVycm9yX3ByZXBlbmQoKSBjYWxsKS4gIEZpeCBzdWNo
IGNhc2VzLg0KPj4NCj4+IElmIHdlIHdhbnQgdG8gY2hlY2sgZXJyb3IgYWZ0ZXIgZXJycC1mdW5j
dGlvbiBjYWxsLCB3ZSBuZWVkIHRvDQo+PiBpbnRyb2R1Y2UgbG9jYWxfZXJyIGFuZCB0aGFuIHBy
b3BhZ2F0ZSBpdCB0byBlcnJwLiBJbnN0ZWFkLCB1c2UNCj4gDQo+IHMvdGhhbi90aGVuDQo+IA0K
Pj4gRVJSUF9BVVRPX1BST1BBR0FURSBtYWNybywgYmVuZWZpdHMgYXJlOg0KPj4gMS4gTm8gbmVl
ZCBvZiBleHBsaWNpdCBlcnJvcl9wcm9wYWdhdGUgY2FsbA0KPj4gMi4gTm8gbmVlZCBvZiBleHBs
aWNpdCBsb2NhbF9lcnIgdmFyaWFibGU6IHVzZSBlcnJwIGRpcmVjdGx5DQo+PiAzLiBFUlJQX0FV
VE9fUFJPUEFHQVRFIGxlYXZlcyBlcnJwIGFzIGlzIGlmIGl0J3Mgbm90IE5VTEwgb3INCj4+ICAg
ICAmZXJyb3JfZmF0ZWwsIHRoaXMgbWVhbnMgdGhhdCB3ZSBkb24ndCBicmVhayBlcnJvcl9hYm9y
dA0KPiANCj4gcy9lcnJvcl9mYXRlbC9lcnJvcl9mYXRhbA0KPiANCj4+ICAgICAod2UnbGwgYWJv
cnQgb24gZXJyb3Jfc2V0LCBub3Qgb24gZXJyb3JfcHJvcGFnYXRlKQ0KPj4NCj4+IFRoaXMgY29t
bWl0ICh0b2dldGhlciB3aXRoIGl0cyBuZWlnaGJvcnMpIHdhcyBnZW5lcmF0ZWQgYnkNCj4+DQo+
PiBmb3IgZiBpbiAkKGdpdCBncmVwIC1sIGVycnAgXCouW2NoXSk7IGRvIFwNCj4+ICAgICAgc3Bh
dGNoIC0tc3AtZmlsZSBzY3JpcHRzL2NvY2NpbmVsbGUvYXV0by1wcm9wYWdhdGVkLWVycnAuY29j
Y2kgXA0KPj4gICAgICAtLW1hY3JvLWZpbGUgc2NyaXB0cy9jb2NjaS1tYWNyby1maWxlLmggLS1p
bi1wbGFjZSAtLW5vLXNob3ctZGlmZiAkZjsgXA0KPj4gZG9uZTsNCj4+DQo+PiB0aGVuIGZpeCBh
IGJpdCBvZiBjb21waWxhdGlvbiBwcm9ibGVtczogY29jY2luZWxsZSBmb3Igc29tZSByZWFzb24N
Cj4+IGxlYXZlcyBzZXZlcmFsDQo+PiBmKCkgew0KPj4gICAgICAuLi4NCj4+ICAgICAgZ290byBv
dXQ7DQo+PiAgICAgIC4uLg0KPj4gICAgICBvdXQ6DQo+PiB9DQo+PiBwYXR0ZXJucywgd2l0aCAi
b3V0OiIgYXQgZnVuY3Rpb24gZW5kLg0KPj4NCj4+IHRoZW4NCj4+IC4vcHl0aG9uL2NvbW1pdC1w
ZXItc3Vic3lzdGVtLnB5IE1BSU5UQUlORVJTICIkKDwgYXV0by1tc2cpIg0KPj4NCj4+IChhdXRv
LW1zZyB3YXMgYSBmaWxlIHdpdGggdGhpcyBjb21taXQgbWVzc2FnZSkNCj4+DQo+PiBTdGlsbCwg
Zm9yIGJhY2twb3J0aW5nIGl0IG1heSBiZSBtb3JlIGNvbWZvcnRhYmxlIHRvIHVzZSBvbmx5IHRo
ZSBmaXJzdA0KPj4gY29tbWFuZCBhbmQgdGhlbiBkbyBvbmUgaHVnZSBjb21taXQuDQo+Pg0KPj4g
UmVwb3J0ZWQtYnk6IEtldmluIFdvbGYgPGt3b2xmQHJlZGhhdC5jb20+DQo+PiBSZXBvcnRlZC1i
eTogR3JlZyBLdXJ6IDxncm91Z0BrYW9kLm9yZz4NCj4+IFNpZ25lZC1vZmYtYnk6IFZsYWRpbWly
IFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCj4+IC0tLQ0K
Pj4gICBody85cGZzLzlwLWxvY2FsLmMgfCA4ICsrKystLS0tDQo+PiAgIGh3LzlwZnMvOXAuYyAg
ICAgICB8IDEgKw0KPj4gICAyIGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNCBkZWxl
dGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaHcvOXBmcy85cC1sb2NhbC5jIGIvaHcvOXBm
cy85cC1sb2NhbC5jDQo+PiBpbmRleCAzNTYzNWU3ZTdlLi5hYWM3OTg5ZjE2IDEwMDY0NA0KPj4g
LS0tIGEvaHcvOXBmcy85cC1sb2NhbC5jDQo+PiArKysgYi9ody85cGZzLzlwLWxvY2FsLmMNCj4+
IEBAIC0xNDc3LDkgKzE0NzcsOSBAQCBzdGF0aWMgdm9pZCBlcnJvcl9hcHBlbmRfc2VjdXJpdHlf
bW9kZWxfaGludChFcnJvciAqKmVycnBfaW4pDQo+PiAgIA0KPj4gICBzdGF0aWMgaW50IGxvY2Fs
X3BhcnNlX29wdHMoUWVtdU9wdHMgKm9wdHMsIEZzRHJpdmVyRW50cnkgKmZzZSwgRXJyb3IgKipl
cnJwKQ0KPj4gICB7DQo+PiArICAgIEVSUlBfQVVUT19QUk9QQUdBVEUoKTsNCj4+ICAgICAgIGNv
bnN0IGNoYXIgKnNlY19tb2RlbCA9IHFlbXVfb3B0X2dldChvcHRzLCAic2VjdXJpdHlfbW9kZWwi
KTsNCj4+ICAgICAgIGNvbnN0IGNoYXIgKnBhdGggPSBxZW11X29wdF9nZXQob3B0cywgInBhdGgi
KTsNCj4+IC0gICAgRXJyb3IgKmxvY2FsX2VyciA9IE5VTEw7DQo+PiAgIA0KPj4gICAgICAgaWYg
KCFzZWNfbW9kZWwpIHsNCj4+ICAgICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJzZWN1cml0eV9t
b2RlbCBwcm9wZXJ0eSBub3Qgc2V0Iik7DQo+PiBAQCAtMTUwNyw5ICsxNTA3LDkgQEAgc3RhdGlj
IGludCBsb2NhbF9wYXJzZV9vcHRzKFFlbXVPcHRzICpvcHRzLCBGc0RyaXZlckVudHJ5ICpmc2Us
IEVycm9yICoqZXJycCkNCj4+ICAgICAgICAgICByZXR1cm4gLTE7DQo+PiAgICAgICB9DQo+PiAg
IA0KPj4gLSAgICBmc2Rldl90aHJvdHRsZV9wYXJzZV9vcHRzKG9wdHMsICZmc2UtPmZzdCwgJmxv
Y2FsX2Vycik7DQo+PiAtICAgIGlmIChsb2NhbF9lcnIpIHsNCj4+IC0gICAgICAgIGVycm9yX3By
b3BhZ2F0ZV9wcmVwZW5kKGVycnAsIGxvY2FsX2VyciwNCj4+ICsgICAgZnNkZXZfdGhyb3R0bGVf
cGFyc2Vfb3B0cyhvcHRzLCAmZnNlLT5mc3QsIGVycnApOw0KPj4gKyAgICBpZiAoKmVycnApIHsN
Cj4+ICsgICAgICAgIGVycm9yX3ByZXBlbmQoZXJycCwNCj4+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAiaW52YWxpZCB0aHJvdHRsZSBjb25maWd1cmF0aW9uOiAiKTsNCj4gDQo+
IFRoZSBjaGFuZ2UgbG9va3MgZ29vZCwgYXBhcnQgZnJvbSB0aGUgZnVua3kgaW5kZW50YXRpb24u
DQo+IA0KPj4gICAgICAgICAgIHJldHVybiAtMTsNCj4+ICAgICAgIH0NCj4+IGRpZmYgLS1naXQg
YS9ody85cGZzLzlwLmMgYi9ody85cGZzLzlwLmMNCj4+IGluZGV4IGNjZTIzNjYyMTkuLjFkZjI3
NDllMDMgMTAwNjQ0DQo+PiAtLS0gYS9ody85cGZzLzlwLmMNCj4+ICsrKyBiL2h3LzlwZnMvOXAu
Yw0KPj4gQEAgLTM1NTIsNiArMzU1Miw3IEBAIHZvaWQgcGR1X3N1Ym1pdChWOWZzUERVICpwZHUs
IFA5TXNnSGVhZGVyICpoZHIpDQo+PiAgIGludCB2OWZzX2RldmljZV9yZWFsaXplX2NvbW1vbihW
OWZzU3RhdGUgKnMsIGNvbnN0IFY5ZnNUcmFuc3BvcnQgKnQsDQo+PiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBFcnJvciAqKmVycnApDQo+PiAgIHsNCj4+ICsgICAgRVJSUF9BVVRP
X1BST1BBR0FURSgpOw0KPiANCj4gSSBkb24ndCBrbm93IGNvY2NpbmVsbGUgc28gSSdtIG5vdCBz
dXJlIHdoeSBFUlJQX0FVVE9fUFJPUEFHQVRFKCkgd2FzDQo+IGFkZGVkIGhlcmUuLi4gYnV0IGl0
J3MgZGVmaW5pdGVseSBub3QgbmVlZGVkIGluIHRoaXMgZnVuY3Rpb24uDQoNCg0KQmVjYXVzZSB0
aGlzIGZ1bmN0aW9uIGNhbGxzIGVycm9yX3ByZXBlbmQoKQ0KDQo+IA0KPj4gICAgICAgaW50IGks
IGxlbjsNCj4+ICAgICAgIHN0cnVjdCBzdGF0IHN0YXQ7DQo+PiAgICAgICBGc0RyaXZlckVudHJ5
ICpmc2U7DQo+IA0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

