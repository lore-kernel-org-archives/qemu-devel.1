Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC464C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 12:18:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EF3120767
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 12:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="sJ7fqffw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EF3120767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDRis-00049x-M1
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 08:18:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54116)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kDRiF-0003ku-6c
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 08:18:03 -0400
Received: from mail-bn8nam11on2069.outbound.protection.outlook.com
 ([40.107.236.69]:9025 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kDRiB-0001sn-Nk
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 08:18:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iuce4r9mw7SDEFQHJ6xMFJQVN/FwXMfvoCQwbu2pVI8w2LlQ+tIvwBRALx7RWvJ1XFlT5hW1XlKriP5Ca11E0iuKf8hCmlZW2U+WNkdwEMCgam6OnZKJs+fqo4dZHEus5IaRujVPeNC/Q67yjep10yE1jfJie2rSRq2xPWKcEICTz/jrOpvxwA4zjfduLjSFaCU2sMBF1w2UVNwi8Nt1FL24SPT6oGE7vCeVh5FcrUd58mEOBjQbKnzcVS/5arpwcGjy1MtoplaI2lsvvtzs6j8Xhw5EeImw5IDMz0yWFLP8i0mKPHrAUsvmRL5cFih+TYlbwFdh1HFp2/rN3lg3Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D467MqOnaVZ2TmBw6L32sFWkjuOoXwOUPuK0iN3Uc+c=;
 b=UVtbY42aT2TsfMGeHB48m40Cnq66Vp8xB2MNl/aZJJ+irMS0A9MNCy8/9tLilAb9i6gShzuoBvuzwZSYr5kwI9biSdDXvExTyuy6PvY30gQd/jdQk+P0BW+3SxybXCoz9p5VaKX3ujCV6j1ZfTjktLPF2meiAaPmLqt/Gus2S54s8Ic/StXQv/F6tLnuxAS2Sd0fQM9nQbuT5Y9ugmPKkCVLdxGpZL8B8Ey7yocb01/RVShq1qy7X9N/j5kloF8PXqfkH+DO/5G3qPgErlXyNg/VZvunqMp4aZwELMg0Y1OBdLzzKZJsZWJiWY9iAvAheYE6+QeTRFkwRNGiRlWGqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D467MqOnaVZ2TmBw6L32sFWkjuOoXwOUPuK0iN3Uc+c=;
 b=sJ7fqffw0hcQM6vP44lUmd0HJSMMw0EW7W16J+KwxjGMn3aep/cuTqNBqJKGQFuskfp7A7n9h7kNNx43TeWr+76cKoVSu9HW8ZczkrOv3k6vPo3L5x1Xu8OE7f6qcz7xr0RXZm7H71RGQm4Gnudbz6EOAA5X3WhuLWDOEkM1kOM=
Received: from BY5PR02MB6772.namprd02.prod.outlook.com (2603:10b6:a03:206::11)
 by BYAPR02MB5269.namprd02.prod.outlook.com (2603:10b6:a03:6e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Wed, 2 Sep
 2020 12:17:55 +0000
Received: from BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::1007:f094:45c9:bb47]) by BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::1007:f094:45c9:bb47%8]) with mapi id 15.20.3326.025; Wed, 2 Sep 2020
 12:17:55 +0000
From: Sai Pavan Boddu <saipava@xilinx.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>, Peter
 Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>,
 =?utf-8?B?J01hcmMtQW5kcsOpIEx1cmVhdSc=?= <marcandre.lureau@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Edgar
 Iglesias <edgari@xilinx.com>, Francisco Eduardo Iglesias
 <figlesia@xilinx.com>
Subject: RE: [PATCH] usb/host-libusb: Check for USBDEVFS_GET_SPEED ioctl
 support
Thread-Topic: [PATCH] usb/host-libusb: Check for USBDEVFS_GET_SPEED ioctl
 support
Thread-Index: AQHWgSJW03tSBdg1b0egylafmxHO7KlVQz8AgAAAWhA=
Date: Wed, 2 Sep 2020 12:17:55 +0000
Message-ID: <BY5PR02MB6772CEF19896968D6CE47051CA2F0@BY5PR02MB6772.namprd02.prod.outlook.com>
References: <1599049003-2937-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <8f9acb59-315d-938c-4db2-af9449e3f4ad@redhat.com>
In-Reply-To: <8f9acb59-315d-938c-4db2-af9449e3f4ad@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cd971092-4799-4c4a-afa1-08d84f3a3900
x-ms-traffictypediagnostic: BYAPR02MB5269:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB5269CF7E3F3BAE59078F73A1CA2F0@BYAPR02MB5269.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:411;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CVVL/zRjAtKGNDYjWW2GJM0Fuo3Yb+5deILY+i8UWXbuPjlbQk2wPXUjZixlqgEy75rw6QpXelvGekCGA94NiL7sZrYYb7XA37kXWDIyhTufoxxotzokGNbFO89QadpI1y1UUGYxnf3ZFeawOxo9rRkj91uz9yrFxCIoX0+guoFErg/mKB2Lz6RJpjagxL9jZeBGt43kpHnSxNLJFqWpHfBpjqS8qxlXPBr0S7H1EeqvlriRSm5nXfi6se8Ab55+/X54z0InsWspdHEt4lr8OjGl92EdtfJJIXPn+68qp3XIg4lz0IuiF4cONQXDY8nDrVZVMcbj8d71c1n0/K5ZqZ1kjCtV9Kg02NG4uyXwzV88ECJilFKpy/2kagSEVdIe+wE/2uf5Zeya1lCH0reEMQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6772.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(136003)(396003)(346002)(376002)(366004)(39860400002)(110136005)(71200400001)(83380400001)(7416002)(33656002)(316002)(54906003)(9686003)(52536014)(478600001)(7696005)(66556008)(66446008)(66476007)(186003)(64756008)(8676002)(55016002)(4326008)(8936002)(26005)(6636002)(6506007)(53546011)(2906002)(76116006)(66946007)(5660300002)(966005)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: IqX27Y1mJyZlmMkVAln2rgvROdHoA7JHnH0lBhaoF6xQjLtvUHfiYrw6SdLf0lUMt+DzSl3kMtyEQnb2bzBQDEddE5pwrFZ8MqV2KtSCEl7FqjNuUTjNfJiBDW/qMIM8dvzo1pl9kkDRmyalroEeayMCFnFJs5ycx7p3svufyKKXktdgLJ3A/MEAnEwo+c+bqEAgbz9UryG2loKUcxNM03bEkT5n/YV4CXQX5FESdR06eb4b2nCgMfPo6Uydzl4JpPw9GhHSLi87UsQ/zRjjg5ZD9EzQrYk3PDnyjnZuaSLmgTbKompwRC+y0oA16K6F3BhZoLDTEI8upPW2WdL2NjOskPDuzF4Hs6iCXwzS9P1mmn6zNcgBbZGGpU3NjWeqX8EmxalmoFTDs80A3htlT/CmnUG9VuSUHsP3QdryLYDmMWLB5LJcPEdxtrxCq3FTWRKDEsHTuZMnusb0gRxFF/8ZFpVZrYvhwC4CUktXZc+hsH/OH6rx967XmafBpLK6Vd7CLeILKVaEeGpH43V1rcUPFcGrcge1Uce8+LhiQTe5s5qRz8IdtA0NE8tetWscYuGV6J0ughNCKl/OIxc6o0sR9zgB+kYpc6sp+ghxklSEzXOsZOzNmRISr3rqDbSa05/2HPrxF5dR+feSiY6mqA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6772.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd971092-4799-4c4a-afa1-08d84f3a3900
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2020 12:17:55.4166 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Az6SLcUzYWEQ42ik5Gn3uI7txToXprdiX0tGLxCeIjWeq1oDRWiytGNBvsOJxv5rGv3nVOK2OTj6OEBxENtbnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5269
Received-SPF: pass client-ip=40.107.236.69; envelope-from=saipava@xilinx.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 08:17:58
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Vikram Garhwal <fnuv@xilinx.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Paul Zimmerman <pauldzim@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>, Ying Fang <fangying1@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SEkgUGhpbGlwcGUvR2VyZCwNCg0KVGhhbmtzLCANClRoaXMgcGF0Y2ggY2FuIGJlIGlnbm9yZWQg
dGhlbi4NCg0KUmVnYXJkcywNClNhaSBQYXZhbg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+IEZyb206IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAcmVkaGF0LmNvbT4N
Cj4gU2VudDogV2VkbmVzZGF5LCBTZXB0ZW1iZXIgMiwgMjAyMCA1OjQ2IFBNDQo+IFRvOiBTYWkg
UGF2YW4gQm9kZHUgPHNhaXBhdmFAeGlsaW54LmNvbT47IFBldGVyIE1heWRlbGwNCj4gPHBldGVy
Lm1heWRlbGxAbGluYXJvLm9yZz47IE1hcmt1cyBBcm1icnVzdGVyIDxhcm1icnVAcmVkaGF0LmNv
bT47DQo+ICdNYXJjLUFuZHLDqSBMdXJlYXUnIDxtYXJjYW5kcmUubHVyZWF1QHJlZGhhdC5jb20+
OyBQYW9sbyBCb256aW5pDQo+IDxwYm9uemluaUByZWRoYXQuY29tPjsgR2VyZCBIb2ZmbWFubiA8
a3JheGVsQHJlZGhhdC5jb20+OyBFZGdhcg0KPiBJZ2xlc2lhcyA8ZWRnYXJpQHhpbGlueC5jb20+
OyBGcmFuY2lzY28gRWR1YXJkbyBJZ2xlc2lhcw0KPiA8ZmlnbGVzaWFAeGlsaW54LmNvbT4NCj4g
Q2M6IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsgQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJh
bmNpc0B3ZGMuY29tPjsNCj4gRWR1YXJkbyBIYWJrb3N0IDxlaGFia29zdEByZWRoYXQuY29tPjsg
WWluZyBGYW5nDQo+IDxmYW5neWluZzFAaHVhd2VpLmNvbT47IFZpa3JhbSBHYXJod2FsIDxmbnV2
QHhpbGlueC5jb20+OyBQYXVsDQo+IFppbW1lcm1hbiA8cGF1bGR6aW1AZ21haWwuY29tPg0KPiBT
dWJqZWN0OiBSZTogW1BBVENIXSB1c2IvaG9zdC1saWJ1c2I6IENoZWNrIGZvciBVU0JERVZGU19H
RVRfU1BFRUQgaW9jdGwNCj4gc3VwcG9ydA0KPiANCj4gT24gOS8yLzIwIDI6MTYgUE0sIFNhaSBQ
YXZhbiBCb2RkdSB3cm90ZToNCj4gPiBGaXhlcyBjb21waWxhdGlvbiBpc3N1ZSB3aXRoIG9sZGVy
IGtlcm5lbHMsIGJlbG93IGlzIHRoZSBlcnJvciB3aGljaA0KPiA+IGlzIGZpeGVkLg0KPiA+DQo+
ID4gaHcvdXNiL2hvc3QtbGlidXNiLmM6OTU0OjMyOiBlcnJvcjog4oCYVVNCREVWRlNfR0VUX1NQ
RUVE4oCZIHVuZGVjbGFyZWQNCj4gPiAoZmlyc3QgdXNlIGluIHRoaXMgZnVuY3Rpb24pDQo+ID4g
ICAgICAgICAgaW50IHJjID0gaW9jdGwoaG9zdGZkLCBVU0JERVZGU19HRVRfU1BFRUQsIE5VTEwp
Ow0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogU2FpIFBhdmFuIEJvZGR1IDxzYWkucGF2YW4uYm9k
ZHVAeGlsaW54LmNvbT4NCj4gPiAtLS0NCj4gPiAgaHcvdXNiL2hvc3QtbGlidXNiLmMgfCAyICst
DQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+
DQo+ID4gZGlmZiAtLWdpdCBhL2h3L3VzYi9ob3N0LWxpYnVzYi5jIGIvaHcvdXNiL2hvc3QtbGli
dXNiLmMgaW5kZXgNCj4gPiAwODYwNGY3Li5jMzBkNDUwIDEwMDY0NA0KPiA+IC0tLSBhL2h3L3Vz
Yi9ob3N0LWxpYnVzYi5jDQo+ID4gKysrIGIvaHcvdXNiL2hvc3QtbGlidXNiLmMNCj4gPiBAQCAt
OTQyLDcgKzk0Miw3IEBAIHN0YXRpYyBpbnQgdXNiX2hvc3Rfb3BlbihVU0JIb3N0RGV2aWNlICpz
LA0KPiBsaWJ1c2JfZGV2aWNlICpkZXYsIGludCBob3N0ZmQpDQo+ID4gICAgICB1c2JfaG9zdF9l
cF91cGRhdGUocyk7DQo+ID4NCj4gPiAgICAgIGxpYnVzYl9zcGVlZCA9IGxpYnVzYl9nZXRfZGV2
aWNlX3NwZWVkKGRldik7IC0jaWZkZWYgQ09ORklHX0xJTlVYDQo+ID4gKyNpZiBkZWZpbmVkKENP
TkZJR19MSU5VWCkgJiYgZGVmaW5lZChVU0JERVZGU19HRVRfU1BFRUQpDQo+IA0KPiBHZXJkIHJl
Y2VudGx5IHNlbnQgYSBzbGlnaHRseSBkaWZmZXJlbnQgcGF0Y2g6DQo+IGh0dHBzOi8vbGlzdHMu
Z251Lm9yZy9hcmNoaXZlL2h0bWwvcWVtdS1kZXZlbC8yMDIwLTA5L21zZzAwNjQ5Lmh0bWwNCj4g
DQo+ID4gICAgICBpZiAoaG9zdGZkICYmIGxpYnVzYl9zcGVlZCA9PSAwKSB7DQo+ID4gICAgICAg
ICAgLyoNCj4gPiAgICAgICAgICAgKiBXb3JrYXJvdW5kIGxpYnVzYiBidWc6IGxpYnVzYl9nZXRf
ZGV2aWNlX3NwZWVkKCkgZG9lcyBub3QNCj4gPg0KDQo=

