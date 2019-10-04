Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9870BC4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 15:07:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FDDE2133F
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 15:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Tk/aiWH/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FDDE2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGPAf-0004dq-IY
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 11:07:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33842)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iGP86-0002mc-Na
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 11:04:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iGP84-0002D6-1A
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 11:04:26 -0400
Received: from mail-eopbgr20131.outbound.protection.outlook.com
 ([40.107.2.131]:39329 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iGP81-00029o-FC; Fri, 04 Oct 2019 11:04:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OLbfZW7zTzM4fMMlycpwihPGvcYXEaQnuCxKXia6PCbSkriBML8N674aje/xyv9OdECHv36S2YcOxxiaYrd1cgNb5iN1HWnEWhZy+iwBtHtT/P7yOEAm8Up0j0LqTcbmuoDOX/lhJ2MZzV+sWCgrj7JiyHPBGwYvJy2WNH8RcxItEyXSUxpbkeY30TEQSOJLu7YT928FUqCONtw07rVim9dvFt1nvH51PD2r6ipdWo2hTTpt9FSopeGH1+vUkTuGiMu2tt/H8IwRRC7vQJ6gXIQwNC06mr3f4I3XiYDha323A9dKNiNbp1MbMVCkHLQB5xjYqAfvJ+JBzQMnyVfUGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smK78ryx0O3s7cRpd6BLQeEKqVhP+qunxZaXUFKzVGw=;
 b=g0OTTHtAhgmj5+ozZuBsCAh6eKmC4tTK46K1eMK1oGdvCT/TFIIaESa1v+GibgRzkBfBcYQEZ2SPPnVzeP/kDYX+b4PF1CrqvIFkBZy8uBuP46OdEJ7o9NHLRDt2PN/qBX+m0UtWLiTFBhSErrkT1Gjjdg0+94NXJziZPjzXVwZUOjn1lmQRlhAbHsHY03BfyNWQf9yMuPKTW0zBrxh4uPsvqXNvtCErb9mqwuTvmooS3l09N0MWuX/6iOPmdA5okMkGdWD2DM/y/9H5GcluHo4+99imKFWLhymUsYJYoCHELJ9AurPlXsA0qnC/DhISjngt2tJPDM7fEuuZXv1PHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smK78ryx0O3s7cRpd6BLQeEKqVhP+qunxZaXUFKzVGw=;
 b=Tk/aiWH/W9WaV2fWb+/gFWPmxUlOx0t0YCxp19uGR8pC7/FJblSRCD8h5AYYrKz9E/q3rBvVKDRKl2T3hO4y+auSYpq7LMAMdQEN2qWMScsd0jGyuIsAHPelGLm74/8rAvyku3xCoamcP82Gxk7c/BX3N3QgVtE5REm47LQ8QpY=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5050.eurprd08.prod.outlook.com (10.255.16.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Fri, 4 Oct 2019 15:04:15 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f%2]) with mapi id 15.20.2305.023; Fri, 4 Oct 2019
 15:04:15 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH 3/4] block/mirror: support unaligned write in active mirror
Thread-Topic: [PATCH 3/4] block/mirror: support unaligned write in active
 mirror
Thread-Index: AQHVaXyqGWMlukZLJkOXoRVirVbRLqdHkGAAgAA0KAD//857AIAADO6AgAFa8ICAAZlDgIAABlQAgAAYAACAAASFgA==
Date: Fri, 4 Oct 2019 15:04:15 +0000
Message-ID: <76736494-f3f6-6b42-e3cc-260250a8d862@virtuozzo.com>
References: <20190912151338.21225-1-vsementsov@virtuozzo.com>
 <20190912151338.21225-4-vsementsov@virtuozzo.com>
 <7dec596f-0175-951e-ba3f-2eb8b2a3d8ed@redhat.com>
 <9a857f23-73b0-44c1-dde2-ac68d45dcf93@virtuozzo.com>
 <62e03b60-b9cb-9e59-f876-df40bba96ca0@virtuozzo.com>
 <3dc81329-443a-288c-0ea1-4190dfc33f5e@redhat.com>
 <5b267415-519f-f4ca-29d0-1bc9753b29f3@virtuozzo.com>
 <292e7686-5440-fdf3-cda3-a0e1f1968089@redhat.com>
 <3193c71d-cd5e-fa94-4dc1-dc8ebbe9ce22@virtuozzo.com>
 <65b4fd06-4d66-ebc3-4e0e-1e8c2d983ef6@redhat.com>
In-Reply-To: <65b4fd06-4d66-ebc3-4e0e-1e8c2d983ef6@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0148.eurprd05.prod.outlook.com
 (2603:10a6:7:28::35) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191004180413021
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d1273e50-32a9-45c1-10e5-08d748dc1f85
x-ms-traffictypediagnostic: DB8PR08MB5050:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB5050EB82B665B386DED704D8C19E0@DB8PR08MB5050.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 018093A9B5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(366004)(136003)(346002)(396003)(376002)(189003)(199004)(14444005)(6512007)(256004)(2906002)(476003)(2616005)(5660300002)(229853002)(71190400001)(71200400001)(11346002)(446003)(6436002)(25786009)(31696002)(54906003)(305945005)(7736002)(110136005)(6486002)(8676002)(81156014)(81166006)(316002)(486006)(4326008)(86362001)(8936002)(107886003)(6246003)(36756003)(14454004)(102836004)(53546011)(386003)(6506007)(66476007)(66556008)(66446008)(64756008)(478600001)(6116002)(66946007)(52116002)(2501003)(26005)(76176011)(31686004)(99286004)(3846002)(186003)(66066001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5050;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oV91jfN8bll1DFgu7OKCfcJeRFIOdus3p5R9MRIoG5fc1L8o33fGmUCwRNv+RKJtIhy0rlmutP8NNw+m/VYTnpEHyKtX9YdUdm1eIkJcmM6MVPXtioGBBEVu/GtcXvbJ9njeXdp7sR+PqwyGreU6fPDmHTgTUVVym1ok1B6R/S/Sva60hxKtovowOksVxxb5lLAxDFkiqdWXU8wbzfrGFluErtYMxhlGkrQ4k8bBvJghC+WI2DkHMI+X2E7rE9mOFjzMzM9l9kh7vgi/oYaA/cTWPQUxlezHtBWQdx6PEl6sm0EJd2nYjMtw4cdL+ztahC37ufUln9IUWTMVWgI+PyKoZtqpEqslAqq684Kky+D012mgziWdUx93uMfXaAZ+8JUIBHX4MxvTozGQpjZr9g1DA2heRgjqcKvSjGdmWos=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0F62F13D55228B4993D96D3CCA2F76FA@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1273e50-32a9-45c1-10e5-08d748dc1f85
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2019 15:04:15.6665 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QYclOF+vpoBf/P/kYm51ZeRAqiSgSoMVAeXi/ZyCqEyFAVKxCGZF6khp/WdcuS+usStLF5jR6HZu2TaSjJMhqHqd2PIXmk1xrM4wlNhxry0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5050
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.2.131
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
 "jsnow@redhat.com" <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDQuMTAuMjAxOSAxNzo0OCwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAwNC4xMC4xOSAxNToyMiwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IDA0LjEwLjIwMTkgMTU6NTks
IE1heCBSZWl0eiB3cm90ZToNCj4+PiBPbiAwMy4xMC4xOSAxMTozNCwgVmxhZGltaXIgU2VtZW50
c292LU9naWV2c2tpeSB3cm90ZToNCj4+Pj4gMDIuMTAuMjAxOSAxODo1MiwgTWF4IFJlaXR6IHdy
b3RlOg0KPj4+Pj4gT24gMDIuMTAuMTkgMTc6MDYsIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNr
aXkgd3JvdGU6DQo+Pj4+Pj4gMDIuMTAuMjAxOSAxODowMywgVmxhZGltaXIgU2VtZW50c292LU9n
aWV2c2tpeSB3cm90ZToNCj4+Pj4+Pj4gMDIuMTAuMjAxOSAxNzo1NywgTWF4IFJlaXR6IHdyb3Rl
Og0KPj4+Pj4+Pj4gT24gMTIuMDkuMTkgMTc6MTMsIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNr
aXkgd3JvdGU6DQo+Pj4+Pj4+Pj4gUHJpb3IgOWFkYzFjYjQ5YWY4ZCBkb19zeW5jX3RhcmdldF93
cml0ZSBoYWQgYSBidWc6IGl0IHJlc2V0IGFsaWduZWQtdXANCj4+Pj4+Pj4+PiByZWdpb24gaW4g
dGhlIGRpcnR5IGJpdG1hcCwgd2hpY2ggbWVhbnMgdGhhdCB3ZSBtYXkgbm90IGNvcHkgc29tZSBi
eXRlcw0KPj4+Pj4+Pj4+IGFuZCBhc3N1bWUgdGhlbSBjb3BpZWQsIHdoaWNoIGFjdHVhbGx5IGxl
YWRzIHRvIHByb2R1Y2luZyBjb3JydXB0ZWQNCj4+Pj4+Pj4+PiB0YXJnZXQuDQo+Pj4+Pj4+Pj4N
Cj4+Pj4+Pj4+PiBTbyA5YWRjMWNiNDlhZjhkIGZvcmNlZCBkaXJ0eSBiaXRtYXAgZ3JhbnVsYXJp
dHkgdG8gYmUNCj4+Pj4+Pj4+PiByZXF1ZXN0X2FsaWdubWVudCBmb3IgbWlycm9yLXRvcCBmaWx0
ZXIsIHNvIHdlIGFyZSBub3Qgd29ya2luZyB3aXRoDQo+Pj4+Pj4+Pj4gdW5hbGlnbmVkIHJlcXVl
c3RzLiBIb3dldmVyIGZvcmNpbmcgbGFyZ2UgYWxpZ25tZW50IG9idmlvdXNseSBkZWNyZWFzZXMN
Cj4+Pj4+Pj4+PiBwZXJmb3JtYW5jZSBvZiB1bmFsaWduZWQgcmVxdWVzdHMuDQo+Pj4+Pj4+Pj4N
Cj4+Pj4+Pj4+PiBUaGlzIGNvbW1pdCBwcm92aWRlcyBhbm90aGVyIHNvbHV0aW9uIGZvciB0aGUg
cHJvYmxlbTogaWYgdW5hbGlnbmVkDQo+Pj4+Pj4+Pj4gcGFkZGluZyBpcyBhbHJlYWR5IGRpcnR5
LCB3ZSBjYW4gc2FmZWx5IGlnbm9yZSBpdCwgYXMNCj4+Pj4+Pj4+PiAxLiBJdCdzIGRpcnR5LCBp
dCB3aWxsIGJlIGNvcGllZCBieSBtaXJyb3JfaXRlcmF0aW9uIGFueXdheQ0KPj4+Pj4+Pj4+IDIu
IEl0J3MgZGlydHksIHNvIHNraXBwaW5nIGl0IG5vdyB3ZSBkb24ndCBpbmNyZWFzZSBkaXJ0aW5l
c3Mgb2YgdGhlDQo+Pj4+Pj4+Pj4gICAgwqDCoMKgIGJpdG1hcCBhbmQgdGhlcmVmb3JlIGRvbid0
IGRhbWFnZSAic3luY2hyb25pY2l0eSIgb2YgdGhlDQo+Pj4+Pj4+Pj4gICAgwqDCoMKgIHdyaXRl
LWJsb2NraW5nIG1pcnJvci4NCj4+Pj4+Pj4+DQo+Pj4+Pj4+PiBCdXQgdGhhdOKAmXMgbm90IHdo
YXQgYWN0aXZlIG1pcnJvciBpcyBmb3IuwqAgVGhlIHBvaW50IG9mIGFjdGl2ZSBtaXJyb3IgaXMN
Cj4+Pj4+Pj4+IHRoYXQgaXQgbXVzdCBjb252ZXJnZSBiZWNhdXNlIGV2ZXJ5IGd1ZXN0IHdyaXRl
IHdpbGwgY29udHJpYnV0ZSB0b3dhcmRzDQo+Pj4+Pj4+PiB0aGF0IGdvYWwuDQo+Pj4+Pj4+Pg0K
Pj4+Pj4+Pj4gSWYgeW91IHNraXAgYWN0aXZlIG1pcnJvcmluZyBmb3IgdW5hbGlnbmVkIGd1ZXN0
IHdyaXRlcywgdGhleSB3aWxsIG5vdA0KPj4+Pj4+Pj4gY29udHJpYnV0ZSB0b3dhcmRzIGNvbnZl
cmdpbmcsIGJ1dCBpbiBmYWN0IGxlYWQgdG8gdGhlIG9wcG9zaXRlLg0KPj4+Pj4+Pj4NCj4+Pj4+
Pj4NCj4+Pj4+Pj4gVGhlIHdpbGwgbm90IGNvbnRyaWJ1dGUgb25seSBpZiByZWdpb24gaXMgYWxy
ZWFkeSBkaXJ0eS4gQWN0dWFsbHksIGFmdGVyDQo+Pj4+Pj4+IGZpcnN0IGl0ZXJhdGlvbiBvZiBt
aXJyb3JpbmcgKGNvcHlpbmcgdGhlIHdob2xlIGRpc2spLCBhbGwgZm9sbG93aW5nIHdyaXRlcw0K
Pj4+Pj4+PiB3aWxsIGNvbnRyaWJ1dGUsIHNvIHRoZSB3aG9sZSBwcm9jZXNzIG11c3QgY29udmVy
Z2UuIEl0IGlzIGEgYml0IHNpbWlsYXIgd2l0aA0KPj4+Pj4+PiBydW5uaW5nIG9uZSBtaXJyb3Ig
bG9vcCBpbiBub3JtYWwgbW9kZSwgYW5kIHRoZW4gZW5hYmxlIHdyaXRlLWJsb2NraW5nLg0KPj4+
Pj4+Pg0KPj4+Pj4+DQo+Pj4+Pj4NCj4+Pj4+PiBJbiBvdGhlciB3b3Jkcywgd2UgZG9uJ3QgbmVl
ZCAiYWxsIGd1ZXN0IHdyaXRlcyBjb250cmlidXRlIiB0byBjb252ZXJnZSwNCj4+Pj4+PiAiYWxs
IGd1ZXN0IHdyaXRlcyBkb24ndCBjcmVhdGUgbmV3IGRpcnR5IGJpdHMiIGlzIGVub3VnaCwgYXMg
d2UgaGF2ZSBwYXJhbGxlbA0KPj4+Pj4+IG1pcnJvciBpdGVyYXRpb24gd2hpY2ggY29udGlndW91
c2x5IGhhbmRsZXMgZGlydHkgYml0cy4NCj4+Pj4+DQo+Pj4+PiBIbSwgaW4gYSBzZW5zZS4gIEJ1
dCBpdCBkb2VzIG1lYW4gdGhhdCBndWVzdCB3cml0ZXMgd2lsbCBub3QgY29udHJpYnV0ZQ0KPj4+
Pj4gdG8gY29udmVyZ2VuY2UuDQo+Pj4+Pg0KPj4+Pj4gQW5kIHRoYXTigJlzIGFnYWluc3QgdGhl
IGN1cnJlbnQgZGVmaW5pdGlvbiBvZiB3cml0ZS1ibG9ja2luZywgd2hpY2ggZG9lcw0KPj4+Pj4g
c3RhdGUgdGhhdCDigJx3aGVuIGRhdGEgaXMgd3JpdHRlbiB0byB0aGUgc291cmNlLCB3cml0ZSBp
dCAoc3luY2hyb25vdXNseSkNCj4+Pj4+IHRvIHRoZSB0YXJnZXQgYXMgd2VsbOKAnS4NCj4+Pj4+
DQo+Pj4+DQo+Pj4+IEhtbSwgdW5kZXJzdGFuZC4gQnV0IElNSE8gb3VyIHByb3Bvc2VkIGJlaGF2
aW9yIGlzIGJldHRlciBpbiBnZW5lcmFsLg0KPj4+PiBEbyB5b3UgdGhpbmsgaXQncyBhIHByb2Js
ZW0gdG8gY2hhbmdlIHNwZWMgbm93Pw0KPj4+PiBJZiB5ZXMsIEknbGwgcmVzZW5kIHdpdGggYW4g
b3B0aW9uDQo+Pj4NCj4+PiBXZWxsLCB0aGUgdGhpbmcgaXMgdGhhdCBJ4oCZZCBmaW5kIGl0IHdl
aXJkIGlmIHdyaXRlLWJsb2NraW5nIHdhc27igJl0DQo+Pj4gYmxvY2tpbmcgaW4gYWxsIGNhc2Vz
LiAgQW5kIGluIG15IG9waW5pb24sIGl0IG1ha2VzIG1vcmUgc2Vuc2UgZm9yDQo+Pj4gYWN0aXZl
IG1pcnJvciBpZiBhbGwgd3JpdGVzIGFjdGl2ZWx5IGNvbnRyaWJ1dGVkIHRvIGNvbnZlcmdlbmNl
Lg0KPj4+DQo+Pg0KPj4gV2h5PyBXaGF0IGlzIHRoZSBiZW5lZml0IGluIGl0Pw0KPj4gV2hhdCBp
cyAiYWxsIHdyaXRlcyBhY3RpdmVseSBjb250cmlidXRlZCB0byBjb252ZXJnZW5jZSIgZm9yIHVz
ZXI/DQo+IA0KPiBPbmUgdGhpbmcgSSB3b25kZXIgYWJvdXQgaXMgd2hldGhlciBpdOKAmXMgcmVh
bGx5IGd1YXJhbnRlZWQgdGhhdCB0aGUNCj4gYmFja2dyb3VuZCBqb2Igd2lsbCBydW4gdW5kZXIg
ZnVsbCBJL08gbG9hZCwgYW5kIGhvdyBvZnRlbiBpdCBydW5zLg0KPiANCj4gSSBmZWFyIHRoYXQg
d2l0aCB5b3VyIG1vZGVsLCB0aGUgYmFja2dyb3VuZCBqb2IgbWlnaHQgc3RhcnZlIGFuZCB0aGUN
Cj4gbWlycm9yIG1heSB0YWtlIGEgdmVyeSBsb25nIHRpbWUuDQoNCkhtbW0uIEkgdGhpbmsgbWly
cm9yIGpvYiBpcyBpbiBzYW1lIGNvbnRleHQgYXMgZ3Vlc3Qgd3JpdGVzLCBhbmQgZ29lcw0KdGhy
b3VnaCBzYW1lIElPIGFwaS4uIFdoeSBpdCB3aWxsIHN0YXJ2ZT8gKEkgdW5kZXJzdGFuZCB0aGF0
IG15IHdvcmRzDQphcmUgbm90IGFuIGV2aWRlbmNlLi4uKS4NCg0KPiAgSXQgd29u4oCZdCBkaXZl
cmdlLCBidXQgaXQgYWxzbyB3b27igJl0DQo+IHJlYWxseSBjb252ZXJnZS4NCg0KQnV0IHNhbWUg
d2lsbCBiZSB3aXRoIGN1cnJlbnQgYmVoYXZpb3I6IGd1ZXN0IGlzIG5vdCBndWFyYW50ZWVkIHRv
IHdyaXRlDQp0byBhbGwgcGFydHMgb2YgZGlzay4gQW5kIGluIG1vc3Qgc2NlbmFyaW9zIGl0IGRv
ZXNuJ3QuIFNvLCBpZiBtaXJyb3Igam9iDQpzdGFydmUgYmVjYXVzZSBvZiBodWdlIGd1ZXN0IElP
IGxvYWQsIHdlIHdpbGwgbm90IGNvbnZlcmdlIGFueXdheS4NCg0KU28sIGJhY2tncm91bmQgcHJv
Y2VzcyBpcyBuZWNlc3NhcnkgdGhpbmcgZm9yIGNvbnZlcmdlIGFueXdheS4NCg0KPiANCj4gVGhl
IGFkdmFudGFnZSBvZiBsZXR0aW5nIGFsbCB3cml0ZXMgYmxvY2sgaXMgdGhhdCBldmVuIHVuZGVy
IGZ1bGwgSS9PDQo+IGxvYWQsIHRoZSBtaXJyb3Igam9iIHdpbGwgcHJvZ3Jlc3MgYXQgYSBzdGVh
ZHkgcGFjZS4NCj4gDQo+PiBJIHRoaW5rIGZvciB1c2VyIHRoZXJlIG1heSBiZSB0aGUgZm9sbG93
aW5nIGNyaXRlcmlhOg0KPj4NCj4+IDEuIGd1YXJhbnRlZWQgY29udmVyZ2UsIHdpdGggYW55IGd1
ZXN0IHdyaXRlIGxvYWQuDQo+PiBCb3RoIGN1cnJlbnQgYW5kIG15IHByb3Bvc2VkIHZhcmlhbnRz
IGFyZSBPSy4NCj4+DQo+PiAyLiBMZXNzIGltcGFjdCBvbiBndWVzdC4NCj4+IE9idmlvdXNseSBt
eSBwcm9wb3NlZCB2YXJpYW50IGlzIGJldHRlcg0KPj4NCj4+IDMuIFRvdGFsIHRpbWUgb2YgbWly
cm9yaW5nDQo+PiBTZWVtcywgY3VycmVudCBtYXkgYmUgYSBiaXQgYmV0dGVyLCBidXQgSSBkb24n
dCB0aGluayB0aGF0IHVuYWxpZ25lZA0KPj4gdGFpbHMgZ2l2ZXMgc2lnbmlmaWNhbnQgaW1wYWN0
Lg0KPj4NCj4+ID09PQ0KPj4NCj4+IFNvLCBhc3N1bWUgSSB3YW50IFsxXStbMl0uIEFuZCBwb3Nz
aWJseQ0KPj4gMi4yOiBFdmVuIGxlc3MgaW1wYWN0IG9uIGd1ZXN0OiBpZ25vcmUgbm90IG9ubHkg
dW5hbGlnbmVkIHRhaWxzIGlmIHRoZXkgYXJlDQo+PiBhbHJlYWR5IGRpcnR5LCBidXQgZnVsbCBz
eW5jaHJvbm91cyBtaXJyb3Igb3BlcmF0aW9uIGlmIGFyZWEgaXMgYWxyZWFkeSBkaXJ0eS4NCj4+
DQo+PiBIb3cgc2hvdWxkIEkgY2FsbCB0aGlzPyBTaG91bGQgaXQgYmUgc2VwYXJhdGUgbW9kZSwg
b3Igb3B0aW9uIGZvciB3cml0ZS1ibG9ja2luZz8NCj4gDQo+IEkgZG9u4oCZdCBrbm93IHdoZXRo
ZXIgaXQgbWFrZXMgc2Vuc2UgdG8gYWRkIGEgc2VwYXJhdGUgbW9kZSBvciBhIHNlcGFyYXRlDQo+
IG9wdGlvbiBqdXN0IGZvciB0aGlzIGRpZmZlcmVuY2UuICBJIGRvbuKAmXQgdGhpbmsgYW55b25l
IHdvdWxkIGNob29zZSB0aGUNCj4gbm9uLWRlZmF1bHQgb3B0aW9uLg0KDQpBdCBsZWFzdCBWaXJ0
dW96em8gd2lsbCBjaG9vc2UgOikNCg0KPiANCj4gQnV0IEkgZG8gdGhpbmsgdGhlcmXigJlzIHF1
aXRlIGEgYml0IG9mIGRpZmZlcmVuY2UgaW4gaG93IHRoZSBqb2IgYmVoYXZlcw0KPiBzdGlsbC4u
LiAgSSBkb27igJl0IGtub3cuIDotLw0KPiANCj4gTWF4DQo+IA0KDQoNCi0tIA0KQmVzdCByZWdh
cmRzLA0KVmxhZGltaXINCg==

