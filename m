Return-Path: <SRS0=0TSG=SJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D7AC10F0E
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Apr 2019 13:48:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF7C2218D0
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Apr 2019 13:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="MXawOUNu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF7C2218D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39612 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hD89c-00061x-U8
	for qemu-devel@archiver.kernel.org; Sun, 07 Apr 2019 09:48:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elijahsh@mellanox.com>) id 1hD88j-0005h2-B0
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 09:47:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elijahsh@mellanox.com>) id 1hD88h-0006yc-SB
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 09:47:17 -0400
Received: from mail-eopbgr70059.outbound.protection.outlook.com
	([40.107.7.59]:15808
	helo=EUR04-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <elijahsh@mellanox.com>)
	id 1hD88h-0006x0-AU
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 09:47:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=CaZycrrHwS6MFs9MbrezJWPBxj7yRclDbFiN6Iws+3o=;
	b=MXawOUNu3qNil43rvXbcg8WDc86pXae4cKaKJemCbYjzLN2etfBArs7Wg2NsjJ+XVZojoqK0eCEqU//wS7A5eRlQ2sutGtH89lInr/7I5rXXjnp/mJOCrJX77vrf+4SxbVcki0tjp/zgFdalbJNj5S692dhSdz5GXdwXGnwyWD0=
Received: from AM6PR05MB6616.eurprd05.prod.outlook.com (20.179.3.215) by
	AM6PR05MB5109.eurprd05.prod.outlook.com (20.177.190.158) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1771.21; Sun, 7 Apr 2019 13:47:11 +0000
Received: from AM6PR05MB6616.eurprd05.prod.outlook.com
	([fe80::2c11:c606:8ec6:5ce0]) by
	AM6PR05MB6616.eurprd05.prod.outlook.com
	([fe80::2c11:c606:8ec6:5ce0%3]) with mapi id 15.20.1771.016;
	Sun, 7 Apr 2019 13:47:11 +0000
From: Elijah Shakkour <elijahsh@mellanox.com>
To: "Tian, Kevin" <kevin.tian@intel.com>, Peter Xu <peterx@redhat.com>
Thread-Topic: QEMU and vIOMMU support for emulated VF passthrough to nested
	(L2) VM
Thread-Index: AdTijGTn8alXJpwkTf2NVv9fkOV2RAAI/3gAAEKF2lAABhuFAAABAtxQACRMCoAAAqluAAABki+AAM18dcAAIYvoAAALCInAAAT3DIAAByS08AABNjaAADSn8bAAF1VgAAAn4bOwAADg+EAAEpgMAAACCPIAABmdUcA=
Date: Sun, 7 Apr 2019 13:47:11 +0000
Message-ID:
 <AM6PR05MB6616FF1FD229194F40882133BD530@AM6PR05MB6616.eurprd05.prod.outlook.com>
References: <AM6PR05MB6616E9FDE038EA2B0665DD9CBD540@AM6PR05MB6616.eurprd05.prod.outlook.com>
	<20190401024710.GB8853@xz-x1>
	<AM6PR05MB6616E9F5EE3B3B531266B73DBD550@AM6PR05MB6616.eurprd05.prod.outlook.com>
	<20190401102515.GD8853@xz-x1>
	<AM6PR05MB6616E41924ADEC1CFC6053BFBD550@AM6PR05MB6616.eurprd05.prod.outlook.com>
	<c89218b50e3b015edc4d7f9490138929a97b8268.camel@oracle.com>
	<AM6PR05MB6616081C90DBA9C552B847BEBD560@AM6PR05MB6616.eurprd05.prod.outlook.com>
	<20190403024018.GK11008@xz-x1>
	<AM6PR05MB6616802C8D185F294565E74CBD570@AM6PR05MB6616.eurprd05.prod.outlook.com>
	<AM6PR05MB66164C0598CFA23FFEEC6C4BBD570@AM6PR05MB6616.eurprd05.prod.outlook.com>
	<20190404065948.GB23212@xz-x1>
	<AADFC41AFE54684AB9EE6CBC0274A5D19C9CE809@SHSMSX104.ccr.corp.intel.com>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19C9CE809@SHSMSX104.ccr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=elijahsh@mellanox.com; 
x-originating-ip: [79.180.234.22]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9e8db8bc-cb20-4b6f-aadc-08d6bb5f88ec
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:AM6PR05MB5109; 
x-ms-traffictypediagnostic: AM6PR05MB5109:
x-microsoft-antispam-prvs: <AM6PR05MB5109F89C7222AF56D5A61CF2BD530@AM6PR05MB5109.eurprd05.prod.outlook.com>
x-forefront-prvs: 00003DBFE7
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(346002)(396003)(366004)(136003)(39860400002)(376002)(13464003)(199004)(189003)(71190400001)(4326008)(76176011)(53936002)(53546011)(54906003)(6506007)(105586002)(102836004)(8676002)(8936002)(81166006)(9686003)(25786009)(106356001)(229853002)(55016002)(81156014)(68736007)(66066001)(86362001)(93886005)(71200400001)(7696005)(6246003)(7736002)(74316002)(305945005)(99286004)(11346002)(446003)(476003)(486006)(52536014)(5660300002)(97736004)(186003)(26005)(14444005)(256004)(110136005)(316002)(6436002)(33656002)(2906002)(14454004)(478600001)(6116002)(3846002);
	DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR05MB5109;
	H:AM6PR05MB6616.eurprd05.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: mellanox.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: h+x2RWUwJ8WDKf5nqMiWcr/xP3fIHbkyZjidWedLLfDao86PN36NwzUaiiRaUyYcKxOzDd3tHUmzSRFLwFnKCMvfkCGgNgBnc3ctmGI8bzMk5WoO3FN1iMj81FkFanV+UxTdD0BOdd1sDfs503ZEnhEYyPOpbUvNA9mVNdeFLCBlwlnWMzHZnJQhqI3cbguaaYEW9GW1EU8UiTB+EDIJtWS/a0dS3xrDtxvi8+pWA2fceakQNwuvF+0ETnMT9xwZ+jdvdVfZCoAJT6ZxB76uJinCvP4MkSD11MfttUm1NgUGc6o528mY0uOXRikHBN1MjRKOX/GjdZ4oYPSQo6IK0UsZRypLSJelzHRGpesIqwNj4QJHEMyxxauqdBTR/I2v9j7szlllvhvFIBpAXFY8+IvFtmfE9WYeBEwO0sAPzcM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e8db8bc-cb20-4b6f-aadc-08d6bb5f88ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2019 13:47:11.1261 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5109
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.59
Subject: Re: [Qemu-devel] QEMU and vIOMMU support for emulated VF
 passthrough to nested (L2) VM
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>,
	Knut Omang <knut.omang@oracle.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	Alex Williamson <alex.williamson@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190407134711.t8w3UjeoIpGKm93Qep-F0m2YC-DxBsws59CyfaeW2K0@z>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVGlhbiwgS2V2aW4gPGtl
dmluLnRpYW5AaW50ZWwuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgQXByaWwgNCwgMjAxOSAxMDo1
OCBBTQ0KPiBUbzogUGV0ZXIgWHUgPHBldGVyeEByZWRoYXQuY29tPjsgRWxpamFoIFNoYWtrb3Vy
DQo+IDxlbGlqYWhzaEBtZWxsYW5veC5jb20+DQo+IENjOiBLbnV0IE9tYW5nIDxrbnV0Lm9tYW5n
QG9yYWNsZS5jb20+OyBNaWNoYWVsIFMuIFRzaXJraW4NCj4gPG1zdEByZWRoYXQuY29tPjsgQWxl
eCBXaWxsaWFtc29uIDxhbGV4LndpbGxpYW1zb25AcmVkaGF0LmNvbT47DQo+IE1hcmNlbCBBcGZl
bGJhdW0gPG1hcmNlbC5hcGZlbGJhdW1AZ21haWwuY29tPjsgU3RlZmFuIEhham5vY3ppDQo+IDxz
dGVmYW5oYUBnbWFpbC5jb20+OyBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gU3ViamVjdDogUkU6
IFFFTVUgYW5kIHZJT01NVSBzdXBwb3J0IGZvciBlbXVsYXRlZCBWRiBwYXNzdGhyb3VnaCB0bw0K
PiBuZXN0ZWQgKEwyKSBWTQ0KPiANCj4gPiBGcm9tOiBQZXRlciBYdSBbbWFpbHRvOnBldGVyeEBy
ZWRoYXQuY29tXQ0KPiA+IFNlbnQ6IFRodXJzZGF5LCBBcHJpbCA0LCAyMDE5IDM6MDAgUE0NCj4g
Pg0KPiA+IE9uIFdlZCwgQXByIDAzLCAyMDE5IGF0IDEwOjEwOjM1UE0gKzAwMDAsIEVsaWphaCBT
aGFra291ciB3cm90ZToNCj4gPg0KPiA+IFsuLi5dDQo+ID4NCj4gPiA+ID4gPiA+ID4gPiA+IFlv
dSBjYW4gYWxzbyB0cnkgdG8gZW5hYmxlIFZULWQgZGV2aWNlIGxvZyBieSBhcHBlbmRpbmc6DQo+
ID4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+ID4gICAtdHJhY2UgZW5hYmxlPSJ2dGRf
KiINCj4gPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4gPiBJbiBjYXNlIGl0IGR1bXBz
IGFueXRoaW5nIHVzZWZ1bCBmb3IgeW91Lg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IEhlcmUg
aXMgdGhlIHJlbGV2YW50IGR1bXAgKGRldiAwMTowMC4wMSBpcyBteSBWRik6DQo+ID4gPiA+ID4g
PiAiDQo+ID4gPiA+ID4gPiB2dGRfaW52X2Rlc2NfY2NfZGV2aWNlIGNvbnRleHQgaW52YWxpZGF0
ZSBkZXZpY2UgMDE6MDAuMDENCj4gPiA+ID4gPiA+IHZ0ZF9jZV9ub3RfcHJlc2VudCBDb250ZXh0
IGVudHJ5IGJ1cyAxIGRldmZuIDEgbm90IHByZXNlbnQNCj4gPiA+ID4gPiA+IHZ0ZF9zd2l0Y2hf
YWRkcmVzc19zcGFjZSBEZXZpY2UgMDE6MDAuMSBzd2l0Y2hpbmcgYWRkcmVzcw0KPiA+ID4gPiA+
ID4gc3BhY2UgKGlvbW11DQo+ID4gPiA+ID4gPiBlbmFibGVkPTEpIHZ0ZF9jZV9ub3RfcHJlc2Vu
dCBDb250ZXh0IGVudHJ5IGJ1cyAxIGRldmZuIDEgbm90DQo+ID4gPiA+ID4gPiBwcmVzZW50IHZ0
ZF9lcnIgRGV0ZWN0ZWQgaW52YWxpZCBjb250ZXh0IGVudHJ5IHdoZW4gdHJ5aW5nIHRvDQo+ID4g
PiA+ID4gPiBzeW5jIHNoYWRvdyBwYWdlIHRhYmxlDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBUaGVz
ZSBsaW5lcyBtZWFuIHRoYXQgdGhlIGd1ZXN0IHNlbnQgYSBkZXZpY2UgaW52YWxpZGF0aW9uIHRv
DQo+ID4gPiA+ID4geW91ciBWRiBidXQgdGhlIElPTU1VIGZvdW5kIHRoYXQgdGhlIGRldmljZSBj
b250ZXh0IGVudHJ5IGlzDQo+IG1pc3NpbmcuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IHZ0ZF9p
b3RsYl9jY191cGRhdGUgSU9UTEIgY29udGV4dCB1cGRhdGUgYnVzIDB4MSBkZXZmbiAweDENCj4g
PiA+ID4gPiA+IGhpZ2gNCj4gPiA+ID4gPiA+IDB4MTAyIGxvdyAweDJkMDA3MDAzIGdlbiAwIC0+
IGdlbiAyDQo+ID4gPiA+ID4gPiB2dGRfZXJyX2RtYXJfc2xwdGVfcmVzdl9lcnJvciBpb3ZhDQo+
ID4gPiA+ID4gPiAweGYwOGU3MDAwIGxldmVsIDIgc2xwdGUgMHgyYTU0MDA4ZjcNCj4gPiA+ID4g
Pg0KPiA+ID4gPiA+IFRoaXMgbGluZSBzaG91bGQgbm90IGV4aXN0IGluIGxhdGVzdCBRRU1VLiAg
QXJlIHlvdSBzdXJlIHlvdSdyZQ0KPiA+ID4gPiA+IHVzaW5nIHRoZSBsYXRlc3QgUUVNVT8NCj4g
PiA+ID4NCj4gPiA+ID4gSSBtb3ZlZCBub3cgdG8gUUVNVSA0LjAgUkMyLg0KPiA+ID4gPiBUaGlz
IGlzIHRoZSB3aGF0IEkgZ2V0IG5vdzoNCj4gPiA+ID4gdnRkX2lvdGxiX2NjX3VwZGF0ZSBJT1RM
QiBjb250ZXh0IHVwZGF0ZSBidXMgMHgxIGRldmZuIDB4MSBoaWdoDQo+ID4gPiA+IDB4MTAyDQo+
ID4gbG93DQo+ID4gPiA+IDB4MmYwMDcwMDMgZ2VuIDAgLT4gZ2VuIDENCj4gPiA+ID4gcWVtdS1z
eXN0ZW0teDg2XzY0OiB2dGRfaW92YV90b19zbHB0ZTogZGV0ZWN0ZWQgc3BsdGUgcmVzZXJ2ZQ0K
PiA+ID4gPiBub24temVybyBpb3ZhPTB4ZjBkMjkwMDAsIGxldmVsPTB4MnNscHRlPTB4MjlmNjAw
OGY3KQ0KPiA+ID4gPiB2dGRfZmF1bHRfZGlzYWJsZWQgRmF1bHQgcHJvY2Vzc2luZyBkaXNhYmxl
ZCBmb3IgY29udGV4dCBlbnRyeQ0KPiA+ID4gPiBxZW11LXN5c3RlbS14ODZfNjQ6IHZ0ZF9pb21t
dV90cmFuc2xhdGU6IGRldGVjdGVkIHRyYW5zbGF0aW9uDQo+ID4gPiA+IGZhaWx1cmUgKGRldj0w
MTowMDowMSwgaW92YT0weGYwZDI5MDAwKSBVbmFzc2lnbmVkIG1lbSByZWFkDQo+ID4gMDAwMDAw
MDBmMGQyOTAwMA0KPiA+ID4gPg0KPiA+ID4gPiBJJ20gbm90IGZhbWlsaWFyIHdpdGggdklPTU1V
IHJlZ2lzdGVycywgYnV0IEkgbm90aWNlZCB0aGF0IEkgbXVzdA0KPiA+ID4gPiByZXBvcnQgc25v
b3AgY29udHJvbCBzdXBwb3J0IHRvIEh5cGVyLVYgKGkuZS4gYml0IDcgaW4gZXh0ZW5kZWQNCj4g
PiA+ID4gY2FwYWJpbGl0eSByZWdpc3Rlcg0KPiA+IG9mDQo+ID4gPiA+IHZJT01NVSkgaW4tb3Jk
ZXIgdG8gc2F0aXNmeSBJT01NVSBzdXBwb3J0IGZvciBTUklPVi4NCj4gPiA+ID4gdklPTU1VLmVj
YXAgYmVmb3JlICAgIDB4ZjAwZjVlDQo+ID4gPiA+IHZJT01NVS5lY2FwIGFmdGVyICAgICAgIDB4
ZjAwZmRlDQo+ID4gPiA+IEJ1dCBJIHNlZSB0aGF0IHZJT01NVSBkb2Vzbid0IHJlYWxseSBzdXBw
b3J0IHNub29wIGNvbnRyb2wuDQo+ID4gPiA+IENvdWxkIHRoaXMgYmUgdGhlIHByb2JsZW0gdGhh
dCBmYWlscyBJT1ZBIHJhbmdlIGNoZWNrIGluIHRoaXMNCj4gPiA+ID4gZnVuY3Rpb24gdnRkX2lv
dmFfcmFuZ2VfY2hlY2soKT8NCj4gPiA+DQo+ID4gPiBTb3JyeSwgSSBtZWFudCB0aGUgU0xQVEUg
cmVzZXJ2ZWQgbm9uLXplcm8gY2hlY2sgZmFpbHVyZSBpbg0KPiA+IHZ0ZF9zbHB0ZV9ub256ZXJv
X3JzdmQoKQ0KPiA+ID4gQW5kIE5PVCBJT1ZBIHJhbmdlIGNoZWNrIGZhaWx1cmUgKHNpbmNlIHJh
bmdlIGNoZWNrIGRpZG4ndCBmYWlsKQ0KPiA+DQo+ID4gUHJvYmFibHkuICBDdXJyZW50bHkgVlQt
ZCBlbXVsYXRpb24gZG9lcyBub3Qgc3VwcG9ydCBzbm9vcGluZyBjb250cm9sLA0KPiA+IGFuZCBp
ZiB5b3UgbW9kaWZ5IHRoYXQgZWNhcCBvbmx5IHlvdSBwcm9iYWJseSB3aWxsIGVuY291bnRlciB0
aGlzDQo+ID4gcHJvYmxlbSBiZWNhdXNlIHRoZW4gdGhlIGd1ZXN0IGtlcm5lbCB3aWxsIHNldHVw
IHRoZSBTTlAgYml0IGluIHRoZQ0KPiA+IElPTU1VIHBhZ2UgdGFibGUgZW50cmllcyB3aGljaCB3
aWxsIHZpb2xhdGUgdGhlIHJlc2VydmVkIGJpdHMgaW4gdGhlDQo+ID4gZW11bGF0aW9uIGNvZGUg
dGhlbiB5b3UgY2FuIHNlZSB0aGVzZSBlcnJvcnMuDQo+ID4NCj4gPiBOb3cgdGFsa2luZyBhYm91
dCBpbXBsZW1lbnRpbmcgdGhlIFNub29wIENvbnRyb2wgZm9yIEludGVsIElPTU1VIGZvcg0KPiA+
IHJlYWwgKHdoaWNoIGNvcnJlc3BvbmRzIHRvIHZ0LWQgZWNhcCBiaXQgNykgLSBJJ2QgY29uZmVz
cyBJJ20gbm90IDEwMCUNCj4gPiBjbGVhciBvbiB3aGF0IGRvZXMgdGhlICJzbm9vcGluZyIgbWVh
biBhbmQgd2hhdCB3ZSBuZWVkIHRvIGRvIGFzIGFuDQo+ID4gZW11bGF0b3IuIEknbSBxdW90dGlu
ZyBmcm9tIHNwZWM6DQo+ID4NCj4gPiAgICJTbm9vcCBiZWhhdmlvciBmb3IgYSBtZW1vcnkgYWNj
ZXNzICh0byBhIHRyYW5zbGF0aW9uIHN0cnVjdHVyZQ0KPiA+ICAgZW50cnkgb3IgYWNjZXNzIHRv
IHRoZSBtYXBwZWQgcGFnZSkgc3BlY2lmaWVzIGlmIHRoZSBhY2Nlc3MgaXMNCj4gPiAgIGNvaGVy
ZW50IChzbm9vcHMgdGhlIHByb2Nlc3NvciBjYWNoZXMpIG9yIG5vdC4iDQo+ID4NCj4gPiBJZiBp
dCBpcyBvbmx5IGEgY2FwYWJpbGl0eSBzaG93aW5nIHRoYXQgd2hldGhlciB0aGUgaGFyZHdhcmUg
aXMNCj4gPiBjYXBhYmxlIG9mIHNub29waW5nIHByb2Nlc3NvciBjYWNoZXMsIHRoZW4gSSBkb24n
dCB0aGluayB3ZSBuZWVkIHRvIGRvDQo+ID4gbXVjaCBoZXJlIGFzIGFuIGVtdWxhdG9yIG9mIFZU
LWQgc2ltcGx5IGJlY2F1c2Ugd2hlbiB3ZSBhY2Nlc3MgdGhlDQo+ID4gZGF0YSB3ZSdyZSBzdGls
bCBmcm9tIHRoZSBwcm9jZXNzb3IncyBzaWRlIChiZWNhdXNlIHdlJ3JlIGVtdWxhdGluZw0KPiA+
IHRoZSBJT01NVSBiZWhhdmlvciBvbmx5KSBzbyB0aGUgY2FjaGUgc2hvdWxkIGFsd2F5cyBiZWVu
IGNvaGVyZW50IGZyb20NCj4gPiB0aGUgUE9WIG9mIGd1ZXN0IHZDUFVzLCBqdXN0IGxpa2UgaG93
IHRoZSBwcm9jZXNzb3JzIHByb3ZpZGUgY2FjaGUNCj4gPiBjb2hlcmVuY2UgYmV0d2VlbiB0d28g
Y29yZXMgKHNvIElNSE8gaGVyZSB0aGUgVlQtZCBlbXVsYXRpb24gY29kZSBjYW4NCj4gPiBiZSBy
dW4gb24gb25lIGNvcmUvdGhyZWFkLCBhbmQgdGhlIHZjcHUgd2hpY2ggcnVucyB0aGUgZ3Vlc3Qg
aW9tbXUNCj4gPiBkcml2ZXIgY2FuIGJlIHJ1biBvbiBhbm90aGVyIGNvcmUvdGhyZWFkKS4gIElm
IHNvLCBtYXliZSB3ZSBjYW4gc2ltcGx5DQo+ID4gZGVjbGFyZSBzdXBwb3J0IG9mIHRoYXQgYnV0
IHdlIGF0IGxlYXN0IGFsc28gbmVlZCB0byByZW1vdmUgdGhlIFNOUA0KPiA+IGJpdCBmcm9tIHZ0
ZF9wYWdpbmdfZW50cnlfcnN2ZF9maWVsZFtdIGFycmF5IHRvIHJlZmxlY3QgdGhhdCB3ZQ0KPiA+
IHVuZGVyc3RhbmQgdGhhdCBiaXQuDQo+ID4NCj4gPiBDQ2luZyBBbGV4IGFuZCBLZXZpbiB0byBz
ZWUgd2hldGhlciBJJ20gbWlzdW5kZXJzdGFuZGluZyBvciBpbiBjYXNlIG9mDQo+ID4gYW55IGZ1
cnRoZXIgaW5wdXQgb24gdGhlIHNub29waW5nIHN1cHBvcnQuDQo+ID4NCj4gDQo+IGZvciBzb2Z0
d2FyZSBETUEgeWVzIHNub29wIGlzIGd1YXJhbnRlZWQgc2luY2UgaXQncyBqdXN0IENQVSBhY2Nl
c3MuDQo+IA0KPiBIb3dldmVyIGZvciBWRklPIGRldmljZSBpLmUuIGhhcmR3YXJlIERNQSwgc25v
b3Agc2hvdWxkIGJlIHJlcG9ydGVkDQo+IGJhc2VkIG9uIHBoeXNpY2FsIElPTU1VIGNhcGFiaWxp
dHkuIEl0J3MgZmluZSB0byByZXBvcnQgbm8gc25vb3AgY29udHJvbCBvbg0KPiB2SU9NTVUgKGN1
cnJlbnQgc3RhdGUpIGV2ZW4gd2hlbiBpdCdzIHBoeXNpY2FsbHkgc3VwcG9ydGVkLiBJdCBqdXN0
IHJlc3VsdHMNCj4gdGhhdCBMMSBWTU0gbXVzdCBmYXZvciBndWVzdCBjYWNoZSBhdHRyaWJ1dGVz
IGluc3RlYWQgb2YgZm9yY2luZyBXQiBpbiBMMQ0KPiBFUFQgd2hlbiBkb2luZyBuZXN0ZWQgcGFz
c3Rocm91Z2guIEhvd2V2ZXIgaXQncyBpbmNvcnJlY3QgdG8gcmVwb3J0IHNub29wDQo+IGNvbnRy
b2wgb24gdklPTU1VIHdoZW4gcGh5c2ljYWxseSBpdCdzIG5vdCBzdXBwb3J0ZWQsIG90aGVyd2lz
ZSBMMSBWTU0NCj4gbWF5IGZvcmNlIFdCIGluIEwxIEVQVCBhbmQgZW5hYmxlIHNub29wIGZpZWxk
IGluIHZJT01NVSAybmQgbGV2ZWwgUFRFIHdpdGgNCj4gYXNzdW1wdGlvbiB0aGF0IGhhcmR3YXJl
IHNub29wIGlzIGd1YXJhbnRlZWQgKGhvd2V2ZXIgaXQgaXNuJ3QpLiBUaGVuIGl0DQo+IGJlY29t
ZXMgYSBjb3JyZWN0bmVzcyBpc3N1ZS4NCj4gDQoNCklmIG15IGRldmljZSBpcyBmdWxseSBlbXVs
YXRlZCwgY2FuIEkgaWdub3JlIHRoZSBTTlAgYml0IGluIHRoZSBTTFBURT8gV2hhdCBpcyB0aGUg
Y29zdCBvZiBpZ25vcmluZyBpdCBpbiBzdWNoIGEgY2FzZT8gV2hhdCBjb3VsZCBnbyB3cm9uZz8N
CihJIHRyaWVkIHRvIGlnbm9yZSBpdCBhbmQgaXQgc2VlbXMgdGhhdCB0cmFuc2xhdGlvbnMgd29y
ayBmb3IgbWUgbm93KS4NCg0KPiBUaGUgdGhpbmcgaXMgYSBiaXQgdHJpY2t5IHJlZ2FyZGluZyB0
byB0d28gVkZJTyBkZXZpY2VzIHdoaWNoIGFyZSB1bmRlciB0d28NCj4gcElPTU1VcyB3aXRoIG9u
ZSBzdXBwb3J0aW5nIHNub29wIGFuZCB0aGUgb3RoZXIgZG9lc24ndCwgd2hpY2ggbGVhdmVzIHVz
DQo+IHR3byBvcHRpb25zOg0KPiANCj4gMSkuIGNyZWF0ZSBvbmUgdklPTU1VIHdpdGhvdXQgc25v
b3AgY29udHJvbC4gQ3VycmVudCBzdGF0ZSBhbmQgc2FmZS4NCj4gMikuIGNyZWF0ZSB0d28gdklP
TU1VcyB3aXRoIG9uZSBzdXBwb3J0aW5nIHNub29wIGFuZCB0aGUgb3RoZXIgZG9lc24ndC4NCj4g
VGhlbiByZXBvcnQgVkZJTyBkZXZpY2UgdG8gdklPTU1VIGJhc2VkIG9uIG1hdGNoaW5nIHNub29w
IGNhcGFiaWxpdHkuDQo+IG1hdGNoIGhhcmR3YXJlIHRvcG9sb2d5IGJ1dCBhZGRzIGV4dHJhIGNv
bmZpZyBidXJkZW4gYW5kIGZvb3RwcmludC4NCj4gDQo+IFRoYW5rcywNCj4gS2V2aW4NCg==

