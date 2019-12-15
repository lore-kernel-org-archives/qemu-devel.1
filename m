Return-Path: <SRS0=VgCP=2F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91C2C43603
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2019 21:08:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73A0224676
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2019 21:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=infinera.com header.i=@infinera.com header.b="XshKWLJw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73A0224676
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=infinera.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igb83-0004oS-KE
	for qemu-devel@archiver.kernel.org; Sun, 15 Dec 2019 16:08:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53650)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Joakim.Tjernlund@infinera.com>) id 1igb7H-0004PY-HD
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 16:07:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Joakim.Tjernlund@infinera.com>) id 1igb7E-0006RS-Vz
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 16:07:50 -0500
Received: from mail-dm6nam12on2074.outbound.protection.outlook.com
 ([40.107.243.74]:23696 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Joakim.Tjernlund@infinera.com>)
 id 1igb7E-0006MW-HU
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 16:07:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ej5dmRySoHBgk57lN6JV0plE+k39nXaeSMTGCLYizQM5cFBWwFI6pSZoTpqrsnu4tCTF3bHQLDT5gQNRWTu/x103IrHdvbMnYnV9dMtTcevB01qkEF4bMI0itaLw8n8H68fNeT45ckOIwiGUbPXDgeUtuI51YS8THdpVeCehZHpgxnALjcbzu+hVwQrTw1GyLc4FlsTEXhHhSYcJbaKJq9LLG61REw+Wvbp5/n3gdNCi8cPuvIOnTAbPGZVm4WFFi2BzY/Vi8fZ42OFGGJx8HdIOpXk4qOYzyr3IrRuqQErWd6Rt8OCaVXjNho+bdDW86k4c4gZVjM/WhA6NJG10kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D3mJ0jiuZP1f8TzVAhkDhuo3AKW0mh9Hg2xE8sGjyEM=;
 b=K+Q5hx4gRZ9VIgbz0yX8JOBCAQL0Uqgizcmb6xaqFPC3Df+9edB52YEeTscoBuYujFJOJQHtv83NuE10EShWaAizIEWfZFK3txWJzcbS6LIQlvWoom0+dmQ4K7ULt+qVg4+WGBgeoG85e1Xnip18gj6XtHqIvIdCLByWNQsTHJwIVbGhyMX10hJ7LVawoUDUzTheCvkGgo3tykEfCept9BfGIBuom+MQB2A7jCTVkBiUq9UkHMXPquf15m1DUMotIYoF5PGPgjnBkTgjELnXXt8f24PkX25r+C3LqIJn8XQ6HqKbCmpOYQc6qyA2sMP1RbW3GoJtgPdi4TG7+bevRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=infinera.com; dmarc=pass action=none header.from=infinera.com;
 dkim=pass header.d=infinera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D3mJ0jiuZP1f8TzVAhkDhuo3AKW0mh9Hg2xE8sGjyEM=;
 b=XshKWLJwVcbe5eaxGMDGN6wj+csHEvsf5VmewiFcjClSFikt4LWpatW89om9y2mJfU2Sp70tiGaApZie8WQXn4lpd2h6rSU5to+2uBbhqlwhJq0pqpNBCfwcZCgcDsrMni0GwHrpdM+efTeLy0dMc+EebTB/WIayp4zF4dmnIBM=
Received: from BN8PR10MB3540.namprd10.prod.outlook.com (20.179.77.152) by
 BN8PR10MB3699.namprd10.prod.outlook.com (20.179.79.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.16; Sun, 15 Dec 2019 21:07:45 +0000
Received: from BN8PR10MB3540.namprd10.prod.outlook.com
 ([fe80::a97b:1c2e:601a:3e6e]) by BN8PR10MB3540.namprd10.prod.outlook.com
 ([fe80::a97b:1c2e:601a:3e6e%7]) with mapi id 15.20.2538.019; Sun, 15 Dec 2019
 21:07:44 +0000
From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To: "laurent@vivier.eu" <laurent@vivier.eu>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH] linux-user: make binfmt flag O require P
Thread-Topic: [PATCH] linux-user: make binfmt flag O require P
Thread-Index: AQHVsnji8FfNHEfOkU+djky8rYHZnqe7a7oAgABGtQA=
Date: Sun, 15 Dec 2019 21:07:43 +0000
Message-ID: <5a9bf498b5d80e6ca19a7d729b7cfeab785fa159.camel@infinera.com>
References: <20191214122022.17255-1-joakim.tjernlund@infinera.com>
 <b5e5743e-009f-397b-43d7-ae4a38443f9a@vivier.eu>
In-Reply-To: <b5e5743e-009f-397b-43d7-ae4a38443f9a@vivier.eu>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Joakim.Tjernlund@infinera.com; 
x-originating-ip: [88.131.87.201]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 76afe1d7-ba4f-4919-035e-08d781a2d4a4
x-ms-traffictypediagnostic: BN8PR10MB3699:
x-microsoft-antispam-prvs: <BN8PR10MB3699906DA4811B20E2392761F4560@BN8PR10MB3699.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02524402D6
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(39860400002)(366004)(396003)(346002)(376002)(199004)(189003)(71200400001)(2906002)(6486002)(91956017)(76116006)(66476007)(66556008)(64756008)(66446008)(66946007)(186003)(86362001)(66574012)(45080400002)(6512007)(6506007)(2616005)(26005)(4001150100001)(966005)(8936002)(110136005)(5660300002)(36756003)(478600001)(81166006)(81156014)(8676002)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN8PR10MB3699;
 H:BN8PR10MB3540.namprd10.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: infinera.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xBFb40a83dFHwNgzx3RAx+ZIGsgpuddHDxd8TTp4hQeXvYC9uDLstuprG6TqNTt3denxRjdAXVl/B0Yah11u1Pc3GLlgKhYw4zq7lvcb3dM16zax5Z5JBwuDl5J0il0k0E8Kn/OixDHCCCFe8aJtP/WOKk0q18AAi/F0326j8kX+wrW7Z7XmjseYNNxv+Ffz3mf9o1rtAiYxgDoTYeF3xy17OjsfaK4y8xaDJVQzap/fSLjkfsShZwpkDMySW+nMQEFVsuKML+R++XTvTRY3TQeEIwV7dEsJd1o4aLNJiW8Aha5NRolLQHRJVALZuqq8yU+keXjdlMGe8Ln91iJHUTI+rYpAp+PqeP1dcOBkwadbKy+6hvcNrr4u0j2TC4XZlwnCVMay+FxgRvVRjrQNBznbjN2sO5CzSueDtzYYazXSifw/IeOHo0MmsGVq+ImD7tW1XGUZSWb18qONGWHQMCDdlRqHP4pwZcmCqIi9bqI=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <339A2A8138D531478D998ABA3C9A7782@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76afe1d7-ba4f-4919-035e-08d781a2d4a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2019 21:07:43.8373 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NmjDjt4paui2VVL2nNMHQZwYICSck7W+ORiEbh8exQ2vjjK0NbYIxL2fZK/d6MXi1yWhmMDVvjeEplm8FIZBVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3699
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.243.74
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gU3VuLCAyMDE5LTEyLTE1IGF0IDE3OjU0ICswMTAwLCBMYXVyZW50IFZpdmllciB3cm90ZToN
Cj4gDQo+IExlIDE0LzEyLzIwMTkgw6AgMTM6MjAsIEpvYWtpbSBUamVybmx1bmQgYSDDqWNyaXQg
Og0KPiA+IEZyb206IEpvYWtpbSBUamVybmx1bmQgPEpvYWtpbS5UamVybmx1bmRAaW5maW5lcmEu
Y29tPg0KPiA+IA0KPiA+IFFFTVUgY2FuIGF1dG9kZXRlY3QgaWYgaXQgaXMgc3RhcnRlZCBmcm9t
IExpbnV4IGJpbmZtdCBsb2FkZXINCj4gPiB3aGVuIGJpbmZtdCBmbGFnIE8gaXMgb24uDQo+ID4g
VXNlIHRoYXQgYW5kIHJlcXVpcmUgYmluZm10IGZsYWcgUCBhcyB3ZWxsIHdoaWNoIHdpbGwgZW5h
YmxlIFFFTVUNCj4gPiB0byBwYXNzIGluIGNvcnJlY3QgYXJndjAgdG8gdGhlIGFwcGxpY2F0aW9u
Lg0KPiANCj4gSSBhZ3JlZSBpdCdzIGEgZ29vZCBpZGVhIHRvIHRyeSB0byBkZXRlY3QgdGhlIFAg
ZmxhZyBpZiB3ZSB1c2UgdGhlIE8gYnV0DQo+IGl0IGNoYW5nZXMgdGhlIGN1cnJlbnQgYmVoYXZp
b3IgYW5kIGJyZWFrcyB0aGUgY29tcGF0aWJpbGl0eSB3aXRoDQo+IHByZXZpb3VzIHZlcnNpb24u
IFRoaXMgd2lsbCBwcmV2ZW50IHRvIHJ1biBvbGQgYW5kIG5ldyB2ZXJzaW9uIG9mIFFFTVUNCj4g
b24gdGhlIHNhbWUgc3lzdGVtLg0KDQpPbmx5IGlmIHlvdSBhbHJlYWR5IGFyZSB1c2luZyBPIGZs
YWcgb25seS4gRGlzdHJpYnV0aW9ucyBjYW4gYWRqdXN0IHNvIHRoYXQgTyBhbmQgUA0KYXJlIHVz
ZWQgaW4gdGFuZGVtLg0KDQo+IA0KPiBJIGFscmVhZHkgdHJ5IHRvIGZpbmQgYSBzb2x1dGlvbiB0
byB0aGlzIHByb2JsZW0uDQo+IA0KPiBUaGUgZmlyc3Qgb25lIGlzIGF0IFFFTVUgbGV2ZWw6DQo+
IA0KPiBodHRwczovL25hbTAzLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9
aHR0cHMlM0ElMkYlMkZwYXRjaGV3Lm9yZyUyRlFFTVUlMkYyMDE5MTAyNDE1Mzg0Ny4zMTgxNS0x
LWxhdXJlbnQlNDB2aXZpZXIuZXUlMkYmYW1wO2RhdGE9MDIlN0MwMSU3Q2pvYWtpbS50amVybmx1
bmQlNDBpbmZpbmVyYS5jb20lN0M1YzQ4NTk5NDdmNDk0OWQ4ODI0ZDA4ZDc4MTdmN2FlZiU3QzI4
NTY0M2RlNWY1YjRiMDNhMTUzMGFlMmRjOGFhZjc3JTdDMSU3QzElN0M2MzcxMjAyNTY4NTA3OTE3
NjEmYW1wO3NkYXRhPXc2WWdEbHJVUHhrN0JTUGRPVlJ5eVd6YjY0dXNVaUY5RU1TT01vbnNrUFkl
M0QmYW1wO3Jlc2VydmVkPTANCj4gDQo+IEFub3RoZXIgd291bGQgYmUgYXQgbGludXggbGV2ZWwg
dG8gcHJvdmlkZSBhIHdheSB0byBkZXRlY3QgYmluZm10IGZsYWdzDQo+IChsaWtlIHlvdSB0cnkg
dG8gZG8gd2l0aCBBVF9FWEVDRkQpOg0KDQpUaGUga2VybmVsIHdheSB0byByZXBvcnQgZmxhZ3Mg
YXJlIHJlYWxseSB0aGUgd2F5IGZvcndhcmQgaGVyZS4gVGhlcmUgc2VlbXMNCnRvIGJlIGxpdHRs
ZSBpbnRlcmVzdCBmcm9tIFFFTVUgY29tbXVuaXR5IHRvIGZpeCB0aGlzIHRob3VnaCwgd2h5IGlz
IHRoYXQ/DQoNCg0KIEpvY2tlDQo+IA0KPiBodHRwczovL25hbTAzLnNhZmVsaW5rcy5wcm90ZWN0
aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsb3JlLmtlcm5lbC5vcmclMkZwYXRj
aHdvcmslMkZwYXRjaCUyRjExNTgxNTElMkYmYW1wO2RhdGE9MDIlN0MwMSU3Q2pvYWtpbS50amVy
bmx1bmQlNDBpbmZpbmVyYS5jb20lN0M1YzQ4NTk5NDdmNDk0OWQ4ODI0ZDA4ZDc4MTdmN2FlZiU3
QzI4NTY0M2RlNWY1YjRiMDNhMTUzMGFlMmRjOGFhZjc3JTdDMSU3QzElN0M2MzcxMjAyNTY4NTA3
OTE3NjEmYW1wO3NkYXRhPWFiViUyQkVMa3RyalRPQ1M2Z0VwMzglMkJZdWoxN0hRZkNjbGowWWh5
TjBYN0JnJTNEJmFtcDtyZXNlcnZlZD0wDQo+IA0KPiBJIGFsc28gZm91bmQgYW5vdGhlciBvbmUg
ZnJvbSBhbm90aGVyIGF1dGhvcjoNCj4gDQo+IGh0dHBzOi8vbmFtMDMuc2FmZWxpbmtzLnByb3Rl
Y3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRnBhdGNod29yay5rZXJuZWwub3Jn
JTJGcGF0Y2glMkYxMDkwMjkzNSUyRiZhbXA7ZGF0YT0wMiU3QzAxJTdDam9ha2ltLnRqZXJubHVu
ZCU0MGluZmluZXJhLmNvbSU3QzVjNDg1OTk0N2Y0OTQ5ZDg4MjRkMDhkNzgxN2Y3YWVmJTdDMjg1
NjQzZGU1ZjViNGIwM2ExNTMwYWUyZGM4YWFmNzclN0MxJTdDMSU3QzYzNzEyMDI1Njg1MDc5MTc2
MSZhbXA7c2RhdGE9VGZ0TDU5JTJCYWoySUFBb1E2RmVtZmI4dyUyRjYlMkZHYyUyRmpyTTQ5aVF2
dzRiMU1NJTNEJmFtcDtyZXNlcnZlZD0wDQo+IA0KPiBUaGFua3MsDQo+IExhdXJlbnQNCj4gDQo+
IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEpvYWtpbSBUamVybmx1bmQgPEpvYWtpbS5UamVybmx1bmRA
aW5maW5lcmEuY29tPg0KPiA+IC0tLQ0KPiA+ICBsaW51eC11c2VyL21haW4uYyB8IDE4ICsrKysr
KysrKysrKysrLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgNCBk
ZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvbGludXgtdXNlci9tYWluLmMgYi9s
aW51eC11c2VyL21haW4uYw0KPiA+IGluZGV4IDZmZjc4NTFlODYuLjFiNjI2ZTU3NjIgMTAwNjQ0
DQo+ID4gLS0tIGEvbGludXgtdXNlci9tYWluLmMNCj4gPiArKysgYi9saW51eC11c2VyL21haW4u
Yw0KPiA+IEBAIC01NDQsNyArNTQ0LDcgQEAgc3RhdGljIHZvaWQgdXNhZ2UoaW50IGV4aXRjb2Rl
KQ0KPiA+ICAgICAgZXhpdChleGl0Y29kZSk7DQo+ID4gIH0NCj4gPiANCj4gPiAtc3RhdGljIGlu
dCBwYXJzZV9hcmdzKGludCBhcmdjLCBjaGFyICoqYXJndikNCj4gPiArc3RhdGljIGludCBwYXJz
ZV9hcmdzKGludCBhcmdjLCBjaGFyICoqYXJndiwgaW50IGFzc3VtZV9QX2ZsYWcpDQo+ID4gIHsN
Cj4gPiAgICAgIGNvbnN0IGNoYXIgKnI7DQo+ID4gICAgICBpbnQgb3B0aW5kOw0KPiA+IEBAIC01
NjAsNyArNTYwLDE3IEBAIHN0YXRpYyBpbnQgcGFyc2VfYXJncyhpbnQgYXJnYywgY2hhciAqKmFy
Z3YpDQo+ID4gICAgICAgICAgICAgIGFyZ2luZm8tPmhhbmRsZV9vcHQocik7DQo+ID4gICAgICAg
ICAgfQ0KPiA+ICAgICAgfQ0KPiA+IC0NCj4gPiArICAgIGlmIChhc3N1bWVfUF9mbGFnKSB7DQo+
ID4gKyAgICAgICAgLyogQXNzdW1lIHN0YXJ0ZWQgYnkgYmlubWlzYyBhbmQgYmluZm10IFAgZmxh
ZyBpcyBzZXQgKi8NCj4gPiArICAgICAgICBpZiAoYXJnYyA8IDMpIHsNCj4gPiArICAgICAgICAg
ICAgZnByaW50ZihzdGRlcnIsICIlczogUGxlYXNlIHVzZSBtZSB0aHJvdWdoIGJpbmZtdCB3aXRo
IFAgZmxhZ1xuIiwNCj4gPiArICAgICAgICAgICAgICAgICAgICBhcmd2WzBdKTsNCj4gPiArICAg
ICAgICAgICAgZXhpdCgxKTsNCj4gPiArICAgICAgICB9DQo+ID4gKyAgICAgICAgZXhlY19wYXRo
ID0gYXJndlsxXTsNCj4gPiArICAgICAgICAvKiBOZXh0IGFyZ3YgbXVzdCBiZSBhcmd2MCBmb3Ig
dGhlIGFwcCAqLw0KPiA+ICsgICAgICAgIHJldHVybiAyOw0KPiA+ICsgICAgfQ0KPiA+ICAgICAg
b3B0aW5kID0gMTsNCj4gPiAgICAgIGZvciAoOzspIHsNCj4gPiAgICAgICAgICBpZiAob3B0aW5k
ID49IGFyZ2MpIHsNCj4gPiBAQCAtNjU5LDcgKzY2OSw4IEBAIGludCBtYWluKGludCBhcmdjLCBj
aGFyICoqYXJndiwgY2hhciAqKmVudnApDQo+ID4gICAgICBxZW11X2FkZF9vcHRzKCZxZW11X3Ry
YWNlX29wdHMpOw0KPiA+ICAgICAgcWVtdV9wbHVnaW5fYWRkX29wdHMoKTsNCj4gPiANCj4gPiAt
ICAgIG9wdGluZCA9IHBhcnNlX2FyZ3MoYXJnYywgYXJndik7DQo+ID4gKyAgICBleGVjZmQgPSBx
ZW11X2dldGF1eHZhbChBVF9FWEVDRkQpOw0KPiA+ICsgICAgb3B0aW5kID0gcGFyc2VfYXJncyhh
cmdjLCBhcmd2LCAgZXhlY2ZkID4gMCk7DQo+ID4gDQo+ID4gICAgICBpZiAoIXRyYWNlX2luaXRf
YmFja2VuZHMoKSkgew0KPiA+ICAgICAgICAgIGV4aXQoMSk7DQo+ID4gQEAgLTY4Miw3ICs2OTMs
NiBAQCBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqKmFyZ3YsIGNoYXIgKiplbnZwKQ0KPiA+IA0K
PiA+ICAgICAgaW5pdF9xZW11X3VuYW1lX3JlbGVhc2UoKTsNCj4gPiANCj4gPiAtICAgIGV4ZWNm
ZCA9IHFlbXVfZ2V0YXV4dmFsKEFUX0VYRUNGRCk7DQo+ID4gICAgICBpZiAoZXhlY2ZkID09IDAp
IHsNCj4gPiAgICAgICAgICBleGVjZmQgPSBvcGVuKGV4ZWNfcGF0aCwgT19SRE9OTFkpOw0KPiA+
ICAgICAgICAgIGlmIChleGVjZmQgPCAwKSB7DQo+ID4gDQoNCg==

