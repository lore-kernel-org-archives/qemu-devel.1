Return-Path: <SRS0=VlUQ=WG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DECC32751
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 12:13:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA8212166E
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 12:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="CSj+1DHy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA8212166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwQF4-0002YH-4Z
	for qemu-devel@archiver.kernel.org; Sat, 10 Aug 2019 08:13:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52845)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hwQEY-0001vP-95
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 08:12:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hwQEW-0007Ix-QE
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 08:12:30 -0400
Received: from mail-eopbgr70112.outbound.protection.outlook.com
 ([40.107.7.112]:64482 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hwQEW-0007HJ-2e; Sat, 10 Aug 2019 08:12:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B7dgpeNLKwgjXH7H6xdNecwdbBNcrwn+mJgBiHjtqwedW9GN5GXqGp30iBobgCyuumpaD8vfPllS1GMpBpCi8rA47ypbhHW0R2Zno7pl13vLSVzxYobaE8FcXYuJU45Evw5DBgbDtctqxBe8veSz2QMXRfOUKItmZKJlHqInd5jdJu+Pkz338EoxrJALXtHJ5bo9XG1pXpzYRCmV4NIXhP3H9NCesIcXdROOckCmV6z6v7nXs17WYL/9KuPzSQ51mMbHPbU8HWooVKVPJdJj49kDqQa3PelyJsWBYtB3z8RWRWd1RyGgqYWOQllhd02WGflxu3TUvn2ualvkXCFl3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EuT4Yabgg2U5icbreAUgIDNH0aAEiY3+5FGLTcxOlrg=;
 b=FcDv3R+iozQlE8+fUC6PeAN9UVELlJy+ayYJ09e3FbFcp27TF8UyBi3KetXAMk4olZLpMHnbCwVL2iTLygCJnk36nB5wZ7+u3Qg+5JQRoWrtL7o4mn/vOCRYhYbnktikpMKu7ZBX25UxaZHuMc4/CAAJ9Trwloh7ZXK5jhxGkkxFSWeDz1hyO1p1W7Idi86+XAAg3szDr6Dzb9v4x74sJpTeie6NYK33bYnyoQRAa3U+Ja26vMfFS9YNh4Tc4/eXoeRlFCYh3OrGPo/TTJ66BeAKb1830BfYX/uamsLcgFycsQITi4XNDiH/E6418HbL3nVdTsly5+UeW26DCQsD2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EuT4Yabgg2U5icbreAUgIDNH0aAEiY3+5FGLTcxOlrg=;
 b=CSj+1DHyBizSGqclhRWZcn+vfhafNwvF+CGRUY/BPciqpEP4e4UyUn5XyUcoOEzaxmI5LunMPGEbHM7d298LWDBxQCw53JGlpWyEBC3EUj/fgNGLdW6+dZbhg1Wk8pIqK0Gg4EAJZ4oDgEgJBh5XuhGUIh0zmSofj0spMbQYhl0=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5401.eurprd08.prod.outlook.com (10.255.185.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.18; Sat, 10 Aug 2019 12:12:24 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2157.021; Sat, 10 Aug 2019
 12:12:24 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v2 6/7] block/backup: teach
 backup_cow_with_bounce_buffer to copy more at once
Thread-Index: AQHVTsegHdnYpu5qx0+85E1DXrVPQ6by+WeAgAFSwoA=
Date: Sat, 10 Aug 2019 12:12:24 +0000
Message-ID: <04e9f57a-4137-eed8-5005-f4fb26b71c47@virtuozzo.com>
References: <20190809153207.49288-1-vsementsov@virtuozzo.com>
 <20190809153207.49288-7-vsementsov@virtuozzo.com>
 <62bca2ef-d175-6926-e1e8-5edfc08d58ab@redhat.com>
In-Reply-To: <62bca2ef-d175-6926-e1e8-5edfc08d58ab@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0202CA0041.eurprd02.prod.outlook.com
 (2603:10a6:3:e4::27) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190810151221469
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c2d07327-b6b4-4ff5-9268-08d71d8c00c3
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5401; 
x-ms-traffictypediagnostic: DB8PR08MB5401:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB54019CC3FCD695003B30CB9AC1D10@DB8PR08MB5401.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 012570D5A0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(396003)(39840400004)(346002)(366004)(376002)(189003)(199004)(66066001)(186003)(52116002)(6486002)(81166006)(6436002)(316002)(81156014)(2501003)(229853002)(25786009)(31686004)(6506007)(26005)(478600001)(53546011)(966005)(76176011)(8676002)(102836004)(386003)(4326008)(7736002)(71200400001)(71190400001)(305945005)(53936002)(6512007)(6246003)(6306002)(476003)(486006)(6116002)(2616005)(3846002)(5660300002)(11346002)(86362001)(8936002)(14454004)(66476007)(66946007)(66446008)(99286004)(64756008)(110136005)(54906003)(256004)(14444005)(31696002)(2906002)(36756003)(446003)(66556008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5401;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TiGSHiBFWKE/ZNW3bxPQa2wyrSCN3JlDCjzV1e+T+OUsILVIhUL8nbzpmUH7eDZFgYXXU6rgt9LxQevS2T5Ws0MZT+1sO8i0EtBDLuu11XFjdYJZYHpF5CzPDUMNtNeibCEWReReSsq8kywqBFh+5XxwvOiVyVtO5ovNphD9mRCYrfD+3fw55xwS1G7FAdtyXryqq5GE17optkfbSetGrJeYgnW7w+LShJjYePBgB663GjIDI8IVrShcC5fF4F2Vv/P3Sph6dNkgvFv/CkrZyK11dGU84dXzcqdQSSWVcUe2kM1EgwcHBJOTW0pIobnWky5743lCRRfsZDWgTxyg3FlO/lJ841NMfH9mWT7QHRLDUpWQaRH3NLPxBePbgs3npSYCPWqM8Kn9/Z9iI80KFcCMslrScmzOr45r5ml5azU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9F30C438A7AB5C42AEC30DEA722D930B@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2d07327-b6b4-4ff5-9268-08d71d8c00c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2019 12:12:24.3299 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n9k0rIPpIyA29R+teHJr6Gu9CnAZWjrA/Q6JVyj8kz/dIceA9volInUiagPI66q9At7vi8onDz5nVUHRT0wmnVkjf5gDil/t14ydUfhuKA8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5401
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.112
Subject: Re: [Qemu-devel] [PATCH v2 6/7] block/backup: teach
 backup_cow_with_bounce_buffer to copy more at once
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
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDkuMDguMjAxOSAxODo1OSwgRXJpYyBCbGFrZSB3cm90ZToNCj4gT24gOC85LzE5IDEwOjMyIEFN
LCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3RlOg0KPj4gYmFja3VwX2Nvd193aXRo
X29mZmxvYWQgY2FuIHRyYW5zZmVyIG1vcmUgdGhhbiBvbiBjbHVzdGVyLiBMZXQNCj4gDQo+IHMv
b24vb25lLw0KPiANCj4+IGJhY2t1cF9jb3dfd2l0aF9ib3VuY2VfYnVmZmVyIGJlaGF2ZSBzaW1p
bGFybHkuIEl0IHJlZHVjZXMgbnVtYmVyDQo+PiBvZiBJTyBhbmQgdGhlcmUgYXJlIG5vIG5lZWRz
IHRvIGNvcHkgY2x1c3RlciBieSBjbHVzdGVyLg0KPiANCj4gSXQgcmVkdWNlcyB0aGUgbnVtYmVy
IG9mIElPIHJlcXVlc3RzLCBzaW5jZSB0aGVyZSBpcyBubyBuZWVkIHRvIGNvcHkNCj4gY2x1c3Rl
ciBieSBjbHVzdGVyLg0KPiANCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBWbGFkaW1pciBTZW1lbnRz
b3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQo+PiAtLS0NCj4+ICAgYmxv
Y2svYmFja3VwLmMgfCAyOSArKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLQ0KPj4gICAxIGZp
bGUgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgMTQgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlm
ZiAtLWdpdCBhL2Jsb2NrL2JhY2t1cC5jIGIvYmxvY2svYmFja3VwLmMNCj4+IGluZGV4IGQ0ODJk
OTM0NTguLjE1NWUyMWQwYTMgMTAwNjQ0DQo+PiAtLS0gYS9ibG9jay9iYWNrdXAuYw0KPj4gKysr
IGIvYmxvY2svYmFja3VwLmMNCj4+IEBAIC0xMDQsMjIgKzEwNCwyNSBAQCBzdGF0aWMgaW50IGNv
cm91dGluZV9mbiBiYWNrdXBfY293X3dpdGhfYm91bmNlX2J1ZmZlcihCYWNrdXBCbG9ja0pvYiAq
am9iLA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBpbnQ2NF90IHN0YXJ0LA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQ2NF90IGVuZCwNCj4+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYm9vbCBpc193cml0ZV9u
b3RpZmllciwNCj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBib29sICplcnJvcl9pc19yZWFkLA0KPj4gLSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZvaWQgKipib3VuY2VfYnVmZmVyKQ0K
Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGJvb2wgKmVycm9yX2lzX3JlYWQpDQo+IA0KPiBXaHkgaXMgdGhpcyBzaWduYXR1cmUgY2hhbmdp
bmc/DQo+IA0KPj4gICB7DQo+PiAgICAgICBpbnQgcmV0Ow0KPj4gICAgICAgQmxvY2tCYWNrZW5k
ICpibGsgPSBqb2ItPmNvbW1vbi5ibGs7DQo+PiAgICAgICBpbnQgbmJ5dGVzOw0KPj4gICAgICAg
aW50IHJlYWRfZmxhZ3MgPSBpc193cml0ZV9ub3RpZmllciA/IEJEUlZfUkVRX05PX1NFUklBTElT
SU5HIDogMDsNCj4+ICsgICAgdm9pZCAqYm91bmNlX2J1ZmZlcjsNCj4+ICAgDQo+PiAgICAgICBh
c3NlcnQoUUVNVV9JU19BTElHTkVEKHN0YXJ0LCBqb2ItPmNsdXN0ZXJfc2l6ZSkpOw0KPj4gLSAg
ICBiZHJ2X3Jlc2V0X2RpcnR5X2JpdG1hcChqb2ItPmNvcHlfYml0bWFwLCBzdGFydCwgam9iLT5j
bHVzdGVyX3NpemUpOw0KPj4gLSAgICBuYnl0ZXMgPSBNSU4oam9iLT5jbHVzdGVyX3NpemUsIGpv
Yi0+bGVuIC0gc3RhcnQpOw0KPj4gLSAgICBpZiAoISpib3VuY2VfYnVmZmVyKSB7DQo+PiAtICAg
ICAgICAqYm91bmNlX2J1ZmZlciA9IGJsa19ibG9ja2FsaWduKGJsaywgam9iLT5jbHVzdGVyX3Np
emUpOw0KPiANCj4gUHJlLXBhdGNoLCB5b3UgYWxsb2NhdGUgdGhlIGJvdW5jZV9idWZmZXIgYXQg
bW9zdCBvbmNlIChidXQgbGltaXRlZCB0byBhDQo+IGNsdXN0ZXIgc2l6ZSksIHBvc3QtcGF0Y2gs
IHlvdSBhcmUgbm93IGFsbG9jYXRpbmcgYW5kIGZyZWVpbmcgYSBib3VuY2UNCj4gYnVmZmVyIGV2
ZXJ5IGl0ZXJhdGlvbiB0aHJvdWdoLiAgVGhlcmUgbWF5IGJlIGZld2VyIGNhbGxzIGJlY2F1c2Ug
eW91DQo+IGFyZSBhbGxvY2F0aW5nIHNvbWV0aGluZyBiaWdnZXIsIGJ1dCBzdGlsbCwgaXNuJ3Qg
aXQgYSBnb29kIGdvYWwgdG8gdHJ5DQo+IGFuZCBhbGxvY2F0ZSB0aGUgYm91bmNlIGJ1ZmZlciBh
cyBmZXcgdGltZXMgYXMgcG9zc2libGUgYW5kIHJldXNlIGl0LA0KPiByYXRoZXIgdGhhbiBnZXR0
aW5nIGEgZnJlc2ggb25lIGVhY2ggaXRlcmF0aW9uPw0KDQpZZXMsIGl0J3MgYSAiZGVncmFkYXRp
b24iIG9mIHRoaXMgcGF0Y2gsIEkgd2FzIGFmcmFpZCBvZiB0aGlzIHF1ZXN0aW9uLg0KSG93ZXZl
ciwgSSBkb3VidCB0aGF0IGl0IHNob3VsZCBiZSBvcHRpbWl6ZWQ6DQoNCjEuIEknbSBnb2luZyB0
byBydW4gc2V2ZXJhbCBjb3B5IHJlcXVlc3RzIGluIGNvcm91dGluZXMgdG8gcGFyYWxsZWxpemUg
Y29weWluZyBsb29wLA0KdG8gaW1wcm92ZSBwZXJmb3JtYW5jZSAoc2VyaWVzIGZvciBxY293MiBh
cmUgaGVyZQ0KaHR0cHM6Ly9saXN0cy5nbnUub3JnL2FyY2hpdmUvaHRtbC9xZW11LWRldmVsLzIw
MTktMDcvbXNnMDY2NTQuaHRtbCksIHNvIHdlJ2xsIG5lZWQNCnNldmVyYWwgYnVmZmVycyBmb3Ig
cGFyYWxsZWwgY29weWluZyByZXF1ZXN0cyBhbmQgaXQncyBleHRyZW1lbHkgZWFzaWVyIHRvIGFs
bG9jYXRlDQpidWZmZXIgd2hlbiBpdCdzIG5lZWRlZCBhbmQgZnJlZSBhZnRlciBpdCwgdGhhbiBk
byBzb21lIGFsbG9jYXRlZCBtZW1vcnkgc2hhcmluZyBsaWtlDQppbiBtaXJyb3IuDQoNCjIuIEFj
dHVhbGx5IGl0IGlzIGEgcXVlc3Rpb24gYWJvdXQgbWVtb3J5IGFsbG9jYXRvcjogaXMgaXQgZmFz
dCBhbmQgb3B0aW1pemVkDQplbm91Z2ggdG8gbm90IGNhcmUsIG9yIGlzIGl0IGJhZCwgYW5kIHdl
IHNob3VsZCB3b3JrLWFyb3VuZCBpdCBsaWtlIGluDQptaXJyb3I/IEFuZCBpbiBteSBvcGluaW9u
IChwcm92ZWQgYnkgYSBiaXQgb2YgYmVuY2htYXJraW5nKSBtZW1hbGlnbg0KaXMgZmFzdCBlbm91
Z2ggdG8gZG9uJ3QgY2FyZS4gSSB3YXMgYW5zd2VyaW5nIHNpbWlsYXIgcXVlc3Rpb24gaW4gbW9y
ZSBkZXRhaWxzDQphbmQgd2l0aCBzb21lIG51bWJlcnMgaGVyZToNCmh0dHBzOi8vbGlzdHMuZ251
Lm9yZy9hcmNoaXZlL2h0bWwvcWVtdS1kZXZlbC8yMDE4LTExL21zZzAwMDg3Lmh0bWwNCg0KU28s
IEknZCBwcmVmZXJlIHRvIG5vdCBjYXJlIGFuZCBrZWVwIGNvZGUgc2ltcGxlci4gQnV0IGlmIHlv
dSBkb24ndCBhZ3JlZSwNCkkgY2FuIGxlYXZlIHNoYXJlZCBidWZmZXIgaGVyZSwgYXQgbGVhc3Qg
dW50aWwgaW50cm9kdWN0aW9uIG9mIHBhcmFsbGVsIHJlcXVlc3RzLg0KVGhlbiwgaXQgd2lsbCBi
ZSBzb21ldGhpbmcgbGlrZSBxZW11X3RyeV9ibG9ja2FsaWduKE1JTihieXRlcywgNjRNKSkuLg0K
DQo+IA0KPj4gKw0KPj4gKyAgICBuYnl0ZXMgPSBNSU4oZW5kIC0gc3RhcnQsIGpvYi0+bGVuIC0g
c3RhcnQpOw0KPiANCj4gV2hhdCBpcyB0aGUgbGFyZ2VzdCB0aGlzIHdpbGwgYmU/IFdpbGwgaXQg
ZXhoYXVzdCBtZW1vcnkgb24gYSAzMi1iaXQgb3INCj4gb3RoZXJ3aXNlIG1lbW9yeS1jb25zdHJh
aW5lZCBzeXN0ZW0sIHdoZXJlIHlvdSBzaG91bGQgaGF2ZSBzb21lIG1heGltdW0NCj4gY2FwIGZv
ciBob3cgbGFyZ2UgdGhlIGJvdW5jZSBidWZmZXIgd2lsbCBiZSB3aGlsZSBzdGlsbCBnZXR0aW5n
IGJldHRlcg0KPiBwZXJmb3JtYW5jZSB0aGFuIG9uZSBjbHVzdGVyIGF0IGEgdGltZSBhbmQgbm90
IHNsb3dpbmcgdGhpbmdzIGRvd24gYnkNCj4gb3Zlci1zaXppbmcgbWFsbG9jPyAgNjRNLCBtYXli
ZT8NCj4gDQoNCkhtbSwgZ29vZCBwb2ludC4gSSB0aG91Z2h0IHRoYXQgaXQncyBzYWZlIHRvIGFs
bG9jYXRlIGJ1ZmZlciBmb3IgYSBmdWxsIHJlcXVlc3QsDQphcyBpZiBzdWNoIGJ1ZmZlciBpcyBh
bHJlYWR5IGFsbG9jYXRlZCBmb3IgdGhlIGd1ZXN0IHJlcXVlc3QgaXRzZWxmLCBpdCBzaG91bGQN
Cm5vdCBiZSBiYWQgdG8gYWxsb2NhdGUgYW5vdGhlciBvbmUgd2l0aCBzYW1lIHNpemUuIEJ1dCBJ
IGZvcmdvdCBhYm91dCB3cml0ZS16ZXJvcw0KYW5kIGRpc2NhcmQgb3BlcmF0aW9ucyB3aGljaCBt
YXkgYmUgbGFyZ2Ugd2l0aG91dCBhbnkgYWxsb2NhdGlvbiBhbmQgaGVyZSB3ZSBuZWVkDQp0byBh
bGxvY2F0ZSBhbnl3YXkuDQoNCkhtbTIsIGJ1dCB3ZSBoYXZlIHBhcmFsbGVsIGd1ZXN0IHdyaXRl
cyhkaXNjYXJkcykgYW5kIHRoZXJlZm9yZSBwYXJhbGxlbA0KY29weS1iZWZvcmUtd3JpdGUgb3Bl
cmF0aW9ucy4gU28gdG90YWwgYWxsb2NhdGlvbiBpcyBub3QgbGltaXRlZCBhbnl3YXkgYW5kIGl0
DQpzaG91bGQgYmUgZml4ZWQgc29tZWhvdyB0b28uLg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZs
YWRpbWlyDQo=

