Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1757CC282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 15:34:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D551520673
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 15:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Bbep7zeY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D551520673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipDLc-0006dO-JE
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 10:34:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37370)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <saipava@xilinx.com>) id 1ipDKI-0005NA-9A
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 10:32:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <saipava@xilinx.com>) id 1ipDKG-0004x2-Be
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 10:32:53 -0500
Received: from mail-mw2nam10on2061.outbound.protection.outlook.com
 ([40.107.94.61]:15218 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <saipava@xilinx.com>) id 1ipDKF-0004um-US
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 10:32:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fEWFEe80gMiOVYT14nM+FaZ3SOIJR6fxRueeFqgJEqmM9Szc5TN6n033zTUhnq4hpf4b6ydGz1SZXsjxzzZrQxVdRWe9I7Zqz1cUj8Rpi5J1CuOMhW5tKhHs6lFssC9tmfiHaCgRdXIHOO+9EbZN/6XulZixcBkQfNcalNwDMgVqUvpjGdq3ap9eQ8w5UleM6ujKFVJ71JblQB6fcDumTbInMowosElArPAWbuk6YktHbfkuVhgumL/HFxVPDkQuFurHBt28U2NM54VZW81vZ0UQiL5EJYkILF+B3jOV4K+YVwlImcIO2VhyMzIdRv6NHYjacnPhvxYnRBFiZZ9Btg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BKHAlf3mmPT3Ws7hRQrj+akPRijN2iYPIZl1+XPtmdc=;
 b=ZfsFPOQa4kvSW6vUPMimjU4GtZlvIky8wfBtgpBoeCdaTI2qRX57yKzy128Me/BknkLQbf07k9Psp0ruMgb1QDrhKVUMma6/4dwlq/gUbfR5zqr0eqKkTPMC53TCyZh8L3HQf2R1JLXTx6+SJqTgl4q8JjesWaFLBN2kcFvj9NRs2fU7PtVnoxFoEp5j5eYqeIdZ90CDabrregyvJ1kX/RGlC2P42j/CCqgKZzdtqGYPVJ+RDxRUp7nUKJ0wYkngDe1EaeouEwP+gB5fyFt/ei6v8RzwndyUOHJznIL9Dou6oTnuYbjeWoSkPM4hNdOMBRsa/HeDmiYvrIb9GcyDdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BKHAlf3mmPT3Ws7hRQrj+akPRijN2iYPIZl1+XPtmdc=;
 b=Bbep7zeYpn0CEM83v/+D1m9fk9tU+aUKNHRWo9CAQF6xdnLRizikRP/RtBZzPFazJQ+FXBHVbII9jUDGPl4e+lGeJF4Z0huewsE2r2sKdRYqmnC45CYogZlQ2vYybYP92y4ymEEWRMpa3P0Mt83hDCjavMB9Jtc8BR2411sBAkE=
Received: from MN2PR02MB5935.namprd02.prod.outlook.com (20.179.86.87) by
 MN2PR02MB6317.namprd02.prod.outlook.com (10.255.7.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Wed, 8 Jan 2020 15:32:49 +0000
Received: from MN2PR02MB5935.namprd02.prod.outlook.com
 ([fe80::ed5d:5fb7:b235:d910]) by MN2PR02MB5935.namprd02.prod.outlook.com
 ([fe80::ed5d:5fb7:b235:d910%6]) with mapi id 15.20.2623.008; Wed, 8 Jan 2020
 15:32:48 +0000
From: Sai Pavan Boddu <saipava@xilinx.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 "kraxel@redhat.com" <kraxel@redhat.com>
Subject: RE: sysbus usb xhci
Thread-Topic: sysbus usb xhci
Thread-Index: AdXBOtUqrwwzin1wTyqynlaACcsu6gAFoByAAAOHm4AAJTzfAAEQyhwQ
Date: Wed, 8 Jan 2020 15:32:48 +0000
Message-ID: <MN2PR02MB59355EEA0C2807EA5EE52D94CA3E0@MN2PR02MB5935.namprd02.prod.outlook.com>
References: <MN2PR02MB5935CFE95528B85E06DA9583CA200@MN2PR02MB5935.namprd02.prod.outlook.com>
 <20200102094515.bbjaqlif7ucvzuou@sirius.home.kraxel.org>
 <b8ad0f98-a02d-bcb2-acd8-a6e9fb606167@redhat.com>
 <MN2PR02MB59356EE03FCE2AFEF22F437ACA230@MN2PR02MB5935.namprd02.prod.outlook.com>
In-Reply-To: <MN2PR02MB59356EE03FCE2AFEF22F437ACA230@MN2PR02MB5935.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=saipava@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5b3ecbec-6869-4e15-595d-08d79450046d
x-ms-traffictypediagnostic: MN2PR02MB6317:
x-microsoft-antispam-prvs: <MN2PR02MB6317238EF3BE26AA5E57677DCA3E0@MN2PR02MB6317.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02760F0D1C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(136003)(346002)(376002)(366004)(478694002)(199004)(189003)(13464003)(478600001)(86362001)(52536014)(5660300002)(3480700007)(55016002)(54906003)(9686003)(81166006)(8936002)(2906002)(81156014)(110136005)(316002)(8676002)(66446008)(66556008)(66476007)(64756008)(76116006)(66946007)(7696005)(26005)(71200400001)(7116003)(186003)(33656002)(6506007)(53546011)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR02MB6317;
 H:MN2PR02MB5935.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jT/BITQVU4LJSpHFBXCvaBcsiKxT5VlCHmuhmjsWO3C77F8/3NV6AoJNHcepqionS9lCTcinqGtymSasZ1fXOLrdrBvL1InzfPGckchIz5bbE8kgHZnkNm/W7PLqjiIlACq3TVKpjPSivQ0Wec4DtSfxspia86ORl/cyfs30hWiL1LDL0hhbL0ebdAm94BrX6W17PAOrpwEL120xwPDffQ6YCZxYYiBR7/gSVt9DL4FkYLXQHTSFJRXo/5CvlbNSLpbjt1DVOs9zRL9jLchaIsnx2NzcjIS2DLSRO1MxmUa1cCRKTUs0xYODsuaHjLRhviF6PTeNbE1MfYg2IXZlxkoYJ79HrAUZXlAQ/R8VMZaaB3EBktAtWsj0gsY1aAumujXsvVapjaPvn4ktiVM2hYlutIU2ZLPQdyekJekveNT3rt4lDFwgXhmH+CSEToq6zco/mjfNy9ttF4wx3oarDl90yWjJBwPPYxbykjIysspS4+EiYVk2Asyi4/kWmR1nwK6w6OF+OsniYkI2Rhuu7A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b3ecbec-6869-4e15-595d-08d79450046d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2020 15:32:48.6925 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vRpG5Nwpjx4bewfaQ07KuitxRvUDkwvCjYLTuFNJQ4dplf3C54nElwTrn5aU656j6ogQB9ywNqyt+5T+xkPIWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6317
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.94.61
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkgR3JlZC9QaGlsaXBwZSwNCg0KSW4gdGhlIHByb2Nlc3Mgb2YgbWFraW5nIGhjZC14aGNpLmMg
ZnJlZSBvZiBwY2kgd3JhcHBlciwgSSBjYW1lIGFjcm9zcyBhIGRtYSBjb21tYW5kICIgbGRxX2xl
X3BjaV9kbWEiIGZvciB3aGljaCBJIGRvbuKAmXQgc2VlIGFueSBsb3cgbGV2ZWwgYWx0ZXJuYXRp
dmUgdG8gcmVwbGFjZS4NCkV2ZW4gSSBjYW5ub3QgZmluZCB0aGUgc291cmNlIG9mIGl0LCBkbyB5
b3UgaGF2ZSBhbnkgdGhvdWdodHMgb24gdGhpcyA/DQoNClJlZ2FyZHMsDQpTYWkgUGF2YW4NCg0K
PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTYWkgUGF2YW4gQm9kZHUNCj4g
U2VudDogRnJpZGF5LCBKYW51YXJ5IDMsIDIwMjAgMTA6NDQgQU0NCj4gVG86IFBoaWxpcHBlIE1h
dGhpZXUtRGF1ZMOpIDxwaGlsbWRAcmVkaGF0LmNvbT47IGtyYXhlbEByZWRoYXQuY29tDQo+IENj
OiBwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc7IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBTdWJq
ZWN0OiBSRTogc3lzYnVzIHVzYiB4aGNpDQo+IA0KPiBUaGFua3MgUGhpbGlwcGUgJiBHcmVkLiBJ
IHdvdWxkIHN0YXJ0IHdpdGggdGhlIGJlbG93IHBvaW50ZXJzLg0KPiANCj4gUmVnYXJkcywNCj4g
U2FpIFBhdmFuDQo+IA0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTog
UGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPg0KPiA+IFNlbnQ6IFRo
dXJzZGF5LCBKYW51YXJ5IDIsIDIwMjAgNDo1NiBQTQ0KPiA+IFRvOiBrcmF4ZWxAcmVkaGF0LmNv
bTsgU2FpIFBhdmFuIEJvZGR1IDxzYWlwYXZhQHhpbGlueC5jb20+DQo+ID4gQ2M6IHBldGVyLm1h
eWRlbGxAbGluYXJvLm9yZzsgcWVtdS1kZXZlbEBub25nbnUub3JnDQo+ID4gU3ViamVjdDogUmU6
IHN5c2J1cyB1c2IgeGhjaQ0KPiA+DQo+ID4gT24gMS8yLzIwIDEwOjQ1IEFNLCBrcmF4ZWxAcmVk
aGF0LmNvbSB3cm90ZToNCj4gPiA+IE9uIFRodSwgSmFuIDAyLCAyMDIwIGF0IDA3OjEzOjI1QU0g
KzAwMDAsIFNhaSBQYXZhbiBCb2RkdSB3cm90ZToNCj4gPiA+PiBIaSBHcmVkLA0KPiA+ID4+DQo+
ID4gPj4gV2UgYXJlIHNlZWluZyBvZiBvcHRpb25zIHRvIHJldXNlIHRoZSBoY2QteGhjaSBtb2Rl
bCBhbmQgdXNlIGl0DQo+ID4gPj4gb3ZlciBzeXN0ZW0gYnVzIGludGVyZmFjZSByYXRoZXIgdGhh
biBwY2kuIChmb3IgWGlsaW54IFp5bnFNUCBTT0MsDQo+ID4gPj4gdXNiDQo+ID4gZW11bGF0aW9u
KSBBcmUgdGhlcmUgYW55IHBsYW5zIG9mIGltcGxlbWVudGluZyBhIHN5c2J1cyBkZXZpY2UgPyBp
Zg0KPiA+IG5vbmUgaXQgd291bGQgYmUgZ29vZCBpZiBwcm92aWRlZCBmZXcgcG9pbnRlcnMgdG8g
c3RhcnQuDQo+ID4gPg0KPiA+ID4gVGhlcmUgaGF2ZSBiZWVuIHNvbWUgZGlzY3Vzc2lvbnMgYWJv
dXQgdGhpcyBmb3IgYSAoSUlSQykgc2JzYQ0KPiA+ID4gbWFjaGluZSwgYnV0IEknbSBub3Qgc3Vy
ZSB3aGVuZXZlciB0aGF0IHdoZXJlIGp1c3QgaWRlYXMgb3Igc29tZSBjb2RlDQo+IGV4aXN0cy4N
Cj4gPiA+DQo+ID4gPj4gSW0gbG9va2luZyBhdCBoY2QtZWhjaS9vY2hpIGFzIGEgcmVmZXJlbmNl
LCBsZXQgbWUga25vdyBpZiB0aGVyZQ0KPiA+ID4+IGFyZSBhbnkNCj4gPiBrbm93IGxpbWl0YXRp
b25zIGZvciB0aGlzIHVzZWNhc2UuDQo+ID4gPg0KPiA+ID4gWWVwLCB0aGUgcGF0aCBmb3IgeGhj
aSB3b3VsZCBiZSBxdWl0ZSBzaW1saWFyOiAgQ3JlYXRlIGEgbmV3DQo+ID4gPiBYSENJUGNpU3Rh
dGUgc3RydWN0LCBtb3ZlIG92ZXIgYWxsIHBjaS1zcGVjaWZpYyBiaXRzIGZyb20gWEhDSVN0YXRl
LA0KPiA+ID4gbGVhdmluZyB0aGUgZ2VuZXJpYyBzdHVmZiBpbiBYSENJU3RhdGUgZm9yIHNoYXJp
bmcgd2l0aCBzeXNidXMuDQo+ID4gPiBQb3NzaWJseSBtb3ZlIGFsbCBwY2ktc3BlY2lmaWMgY29k
ZSBiaXRzIGludG8gYSBuZXcgc291cmNlIGZpbGUgKGZvcg0KPiA+ID4gY2xlYW51cCwgd2lsbCBh
bHNvIGFsbG93IHRvIGJ1aWxkIHFlbXUgd2l0aCBDT05GSUdfUENJPW4gYW5kIHN0aWxsDQo+ID4g
PiBoYXZlIFhIQ0kgZW5hYmxlZCkuDQo+ID4gPg0KPiA+ID4gT25jZSB0aGlzIHNlcGFyYXRpb24g
aXMgZG9uZSB5b3Ugc2hvdWxkIGJlIGFibGUgdG8gY3JlYXRlIGEgc3lzYnVzDQo+ID4gPiBkZXZp
Y2UsIHJldXNpbmcgdGhlIGdlbmVyaWMgeGhjaSBjb2RlIGFuZCBhZGRpbmcgc3lzYnVzIHBsdW1i
aW5nDQo+ID4gPiAobW1pbywgaXJxLCAuLi4pDQo+ID4NCj4gPiBUaGUgU0RIQ0kgY29tbWl0cyBi
NjM1ZDk4Y2YzMi4uOGI3NDU1Yzc1ZSBzZWVtIHNpbWlsYXIgdG8gd2hhdCB5b3UNCj4gPiB3YW50
IHRvIGFjaGlldmUgKHNlZSBhbHNvIGNvbW1pdCBjZTg2NDYwMzQpLg0KDQo=

