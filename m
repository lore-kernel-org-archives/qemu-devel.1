Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DC3C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 15:48:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C6AE2072E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 15:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="OnsPzKCh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C6AE2072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isTrB-0006mX-L7
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 10:48:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39186)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <saipava@xilinx.com>) id 1isTps-0005kz-ME
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 10:47:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <saipava@xilinx.com>) id 1isTpq-0007VY-Uj
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 10:47:00 -0500
Received: from mail-bn8nam11on20615.outbound.protection.outlook.com
 ([2a01:111:f400:7eae::615]:24174
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <saipava@xilinx.com>) id 1isTpq-0007Tl-LL
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 10:46:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fugf4IJJt6Pg5v7+NP7JBaZCHOM0Z/5XZB2NZsSKD/m5Z/MRSX0V9ClCfN5zLyuitDMTAl888i6SbEdUaU1BytcrRfpJUi9g2qnvG9f7zPU0zgRx2Ez99r3zWNlcIOr1iCtUwZD/+NkoQxSYoOmW5mYu+KD8eQdT2ci63aqbS7HE75qmQnUeLVJatlorxRyXLZvlZgL2ct9mJSOMgmDT41npiMw8MkvjhdHonz3JhBErNCNR5XRcwNS+oOKM5V4o82J/yO3vthqFd0iQA4hb6RKFOW6ZrLszzR8t9fUPx71q+wg42MSi1eKjGQVESmdyRSEjWmVuS2e76BrA6adc/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qArmHsPAm8d8aXUpeFueXUiddNe17Vxk3AzttlSRs/o=;
 b=POwX8zyhgrYwS5eznZxG+dkZ/lgj9N2wbH99BPwQ1c24J+NvvsGLx3qqpuOsvqVdgfaSvSE0vLh0L9D1sH5gQfZ+hhbMhsE8zFvUQ6NxJ3sZK3L596W3tq1ByThAGadR0QI+sYiNJIfEnuTEKegXcTp43DAWHn8vVVRe2gHJFR+YjurN/n1SjYiRrTFrDd5gH44S41QRhGBc5Vt36Fatcy+OqN/8cqXwk7QuF+FO01faONqOEl3n8nl1GnxaTbPfxM999ZngKtORxwFvyHVxYtANdMrFKkfCO0iYfjVBtaWMmK/Qevvl74GQmRp+kqlocyZVz6w4BgsVl78QHCe/ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qArmHsPAm8d8aXUpeFueXUiddNe17Vxk3AzttlSRs/o=;
 b=OnsPzKChZfZXpBpZGAuLpa1T1B/glwZy+CpGW7GNsMWShU4nGe+gbPpZpqJAj7BPXhxYobgypXVezesGIJe2AvHccexcRZn6IB+SU2wjdCCHYK/Nl6Pp+KSrwSgi0mPu8nkc9eE0AWN4Vvaf8+4sMuPROS43+i58wmkuEiNkF+s=
Received: from MN2PR02MB5935.namprd02.prod.outlook.com (20.179.86.87) by
 MN2PR02MB6798.namprd02.prod.outlook.com (52.135.49.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19; Fri, 17 Jan 2020 15:46:54 +0000
Received: from MN2PR02MB5935.namprd02.prod.outlook.com
 ([fe80::ed5d:5fb7:b235:d910]) by MN2PR02MB5935.namprd02.prod.outlook.com
 ([fe80::ed5d:5fb7:b235:d910%6]) with mapi id 15.20.2644.023; Fri, 17 Jan 2020
 15:46:54 +0000
From: Sai Pavan Boddu <saipava@xilinx.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 "kraxel@redhat.com" <kraxel@redhat.com>
Subject: RE: sysbus usb xhci
Thread-Topic: sysbus usb xhci
Thread-Index: AdXBOtUqrwwzin1wTyqynlaACcsu6gAFoByAAAOHm4AAJTzfAAEQyhwQAAD3/AABxAlVQA==
Date: Fri, 17 Jan 2020 15:46:53 +0000
Message-ID: <MN2PR02MB593571EC80ADC8D2C3DD9AEDCA310@MN2PR02MB5935.namprd02.prod.outlook.com>
References: <MN2PR02MB5935CFE95528B85E06DA9583CA200@MN2PR02MB5935.namprd02.prod.outlook.com>
 <20200102094515.bbjaqlif7ucvzuou@sirius.home.kraxel.org>
 <b8ad0f98-a02d-bcb2-acd8-a6e9fb606167@redhat.com>
 <MN2PR02MB59356EE03FCE2AFEF22F437ACA230@MN2PR02MB5935.namprd02.prod.outlook.com>
 <MN2PR02MB59355EEA0C2807EA5EE52D94CA3E0@MN2PR02MB5935.namprd02.prod.outlook.com>
 <1644b627-be90-dff8-9de6-dd92b879e593@redhat.com>
In-Reply-To: <1644b627-be90-dff8-9de6-dd92b879e593@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: philmd@redhat.com
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=saipava@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 306ab1da-e352-432d-e164-08d79b6479ef
x-ms-traffictypediagnostic: MN2PR02MB6798:
x-microsoft-antispam-prvs: <MN2PR02MB67986097FC5C00618C6B6330CA310@MN2PR02MB6798.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 0285201563
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(376002)(396003)(346002)(366004)(189003)(199004)(55016002)(71200400001)(9686003)(33656002)(186003)(7696005)(5660300002)(8936002)(81156014)(81166006)(8676002)(26005)(53546011)(52536014)(6506007)(4326008)(2906002)(3480700007)(316002)(66946007)(66556008)(66446008)(66476007)(64756008)(478600001)(110136005)(54906003)(86362001)(7116003)(76116006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR02MB6798;
 H:MN2PR02MB5935.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SLp/1XJgfeW9uxSE6OSes/An55daSsz12Y5iqy7veBbkR5srmTlhaZD6sF6I2XyG14P/gGTxv+pdLRyNgYgUdChDP4czhMV/dAuNAFMfzffsb4sVwnYfiizwC9AvfZW3EXzZR/6lRLJRe5EJexayp/77MJ4Cpti6cixevUhDbj2vaJDPZl9Ud54G5wzv09XXHwymelI4EZVQQS03ZzjX0UhfM3QCethZbLshBc3K8AtOG5xyNZ3Ue/zTvc1JrAFt1lpjdvm6Nvz4zbBkhfhqNC+dkSwr7PCALhl6vz8n5NFvXxqEkASLU2e3T5kEwhjQ+PO2X3VSGoFwIXBrMqEG1jTHg8fVEsZoVPjKWT6EJDN8G7Mre6el50n2bfFpHeCFOrRW9gwvNbOil+A//8ZeqcTt2vUiTCJQaSHkDddgS+RuehFXEWZ9HE1mTqKjiZiu
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 306ab1da-e352-432d-e164-08d79b6479ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2020 15:46:53.9134 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ofnNUIbBumE1pWl9EmuW/6mnueYfX12Sgh9K/Fc719L6LGLkRTi9JHpIrz72qG6F94/0wty3vq4SEv8aph7c0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6798
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:7eae::615
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

SGkgR3JlZC9QaGlsaXBwZSwNCg0KQFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpLCAgdGhhbmtzIEkg
Zm91bmQgdGhlIGFsdGVybmF0aXZlICJsZHFfbGVfZG1hIi4NCg0KTW92aW5nIGZvcndhcmQsIGZv
ciB0ZXN0aW5nIHRoZSBuZXcgbW9kZWwuIEkgcmFuIHRocm91Z2ggcXRlc3Q6dXNiLWhjZC14aGNp
LXRlc3QuYywgYXJlIHRoZXJlIGFueSBvdGhlciB0ZXN0IHdoaWNoIEkgbmVlZCB0byBjb25zaWRl
ciBhcyBmaXJzdCBsZXZlbCB2YWxpZGF0aW9uID8NCg0KUmVnYXJkcywNClNhaSBQYXZhbg0KDQo+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFBoaWxpcHBlIE1hdGhpZXUtRGF1
ZMOpIDxwaGlsbWRAcmVkaGF0LmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBKYW51YXJ5IDgsIDIw
MjAgOToyMSBQTQ0KPiBUbzogU2FpIFBhdmFuIEJvZGR1IDxzYWlwYXZhQHhpbGlueC5jb20+OyBr
cmF4ZWxAcmVkaGF0LmNvbQ0KPiBDYzogcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnOyBxZW11LWRl
dmVsQG5vbmdudS5vcmcNCj4gU3ViamVjdDogUmU6IHN5c2J1cyB1c2IgeGhjaQ0KPiANCj4gT24g
MS84LzIwIDQ6MzIgUE0sIFNhaSBQYXZhbiBCb2RkdSB3cm90ZToNCj4gPiBIaSBHcmVkL1BoaWxp
cHBlLA0KPiA+DQo+ID4gSW4gdGhlIHByb2Nlc3Mgb2YgbWFraW5nIGhjZC14aGNpLmMgZnJlZSBv
ZiBwY2kgd3JhcHBlciwgSSBjYW1lIGFjcm9zcyBhDQo+IGRtYSBjb21tYW5kICIgbGRxX2xlX3Bj
aV9kbWEiIGZvciB3aGljaCBJIGRvbuKAmXQgc2VlIGFueSBsb3cgbGV2ZWwNCj4gYWx0ZXJuYXRp
dmUgdG8gcmVwbGFjZS4NCj4gPiBFdmVuIEkgY2Fubm90IGZpbmQgdGhlIHNvdXJjZSBvZiBpdCwg
ZG8geW91IGhhdmUgYW55IHRob3VnaHRzIG9uIHRoaXMgPw0KPiANCj4gSXNuJ3QgaXQgbGRxX2xl
X3BoeXMoKT8NCj4gDQo+IEkgdGhpbmsgeW91IHdhbnQgdG8gZXh0cmFjdCB0aGUgYWRkcmVzcyBz
cGFjZSBmaXJzdCBpbiBhIGNvbW1vbiBtZXRob2QuDQo+IFNlZSBpbiBzZGhjaV9wY2lfcmVhbGl6
ZSgpOg0KPiANCj4gICAgICBzLT5kbWFfYXMgPSBwY2lfZ2V0X2FkZHJlc3Nfc3BhY2UoZGV2KTsN
Cj4gDQo+IEFuZCBpbiBzZGhjaV9zeXNidXNfcmVhbGl6ZSgpOg0KPiANCj4gICAgICBpZiAocy0+
ZG1hX21yKSB7DQo+ICAgICAgICAgIHMtPmRtYV9hcyA9ICZzLT5zeXNidXNfZG1hX2FzOw0KPiAg
ICAgICAgICBhZGRyZXNzX3NwYWNlX2luaXQocy0+ZG1hX2FzLCBzLT5kbWFfbXIsICJzZGhjaS1k
bWEiKTsNCj4gICAgICB9IGVsc2Ugew0KPiAgICAgICAgICAvKiB1c2Ugc3lzdGVtX21lbW9yeSgp
IGlmIHByb3BlcnR5ICJkbWEiIG5vdCBzZXQgKi8NCj4gICAgICAgICAgcy0+ZG1hX2FzID0gJmFk
ZHJlc3Nfc3BhY2VfbWVtb3J5Ow0KPiAgICAgIH0NCj4gDQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+ID4+IEZyb206IFNhaSBQYXZhbiBCb2RkdQ0KPiA+PiBTZW50OiBGcmlkYXks
IEphbnVhcnkgMywgMjAyMCAxMDo0NCBBTQ0KPiA+PiBUbzogUGhpbGlwcGUgTWF0aGlldS1EYXVk
w6kgPHBoaWxtZEByZWRoYXQuY29tPjsga3JheGVsQHJlZGhhdC5jb20NCj4gPj4gQ2M6IHBldGVy
Lm1heWRlbGxAbGluYXJvLm9yZzsgcWVtdS1kZXZlbEBub25nbnUub3JnDQo+ID4+IFN1YmplY3Q6
IFJFOiBzeXNidXMgdXNiIHhoY2kNCj4gPj4NCj4gPj4gVGhhbmtzIFBoaWxpcHBlICYgR3JlZC4g
SSB3b3VsZCBzdGFydCB3aXRoIHRoZSBiZWxvdyBwb2ludGVycy4NCj4gPj4NCj4gPj4gUmVnYXJk
cywNCj4gPj4gU2FpIFBhdmFuDQo+ID4+DQo+ID4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPiA+Pj4gRnJvbTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQuY29t
Pg0KPiA+Pj4gU2VudDogVGh1cnNkYXksIEphbnVhcnkgMiwgMjAyMCA0OjU2IFBNDQo+ID4+PiBU
bzoga3JheGVsQHJlZGhhdC5jb207IFNhaSBQYXZhbiBCb2RkdSA8c2FpcGF2YUB4aWxpbnguY29t
Pg0KPiA+Pj4gQ2M6IHBldGVyLm1heWRlbGxAbGluYXJvLm9yZzsgcWVtdS1kZXZlbEBub25nbnUu
b3JnDQo+ID4+PiBTdWJqZWN0OiBSZTogc3lzYnVzIHVzYiB4aGNpDQo+ID4+Pg0KPiA+Pj4gT24g
MS8yLzIwIDEwOjQ1IEFNLCBrcmF4ZWxAcmVkaGF0LmNvbSB3cm90ZToNCj4gPj4+PiBPbiBUaHUs
IEphbiAwMiwgMjAyMCBhdCAwNzoxMzoyNUFNICswMDAwLCBTYWkgUGF2YW4gQm9kZHUgd3JvdGU6
DQo+ID4+Pj4+IEhpIEdyZWQsDQo+ID4+Pj4+DQo+ID4+Pj4+IFdlIGFyZSBzZWVpbmcgb2Ygb3B0
aW9ucyB0byByZXVzZSB0aGUgaGNkLXhoY2kgbW9kZWwgYW5kIHVzZSBpdA0KPiA+Pj4+PiBvdmVy
IHN5c3RlbSBidXMgaW50ZXJmYWNlIHJhdGhlciB0aGFuIHBjaS4gKGZvciBYaWxpbnggWnlucU1Q
IFNPQywNCj4gPj4+Pj4gdXNiDQo+ID4+PiBlbXVsYXRpb24pIEFyZSB0aGVyZSBhbnkgcGxhbnMg
b2YgaW1wbGVtZW50aW5nIGEgc3lzYnVzIGRldmljZSA/IGlmDQo+ID4+PiBub25lIGl0IHdvdWxk
IGJlIGdvb2QgaWYgcHJvdmlkZWQgZmV3IHBvaW50ZXJzIHRvIHN0YXJ0Lg0KPiA+Pj4+DQo+ID4+
Pj4gVGhlcmUgaGF2ZSBiZWVuIHNvbWUgZGlzY3Vzc2lvbnMgYWJvdXQgdGhpcyBmb3IgYSAoSUlS
Qykgc2JzYQ0KPiA+Pj4+IG1hY2hpbmUsIGJ1dCBJJ20gbm90IHN1cmUgd2hlbmV2ZXIgdGhhdCB3
aGVyZSBqdXN0IGlkZWFzIG9yIHNvbWUNCj4gPj4+PiBjb2RlDQo+ID4+IGV4aXN0cy4NCj4gPj4+
Pg0KPiA+Pj4+PiBJbSBsb29raW5nIGF0IGhjZC1laGNpL29jaGkgYXMgYSByZWZlcmVuY2UsIGxl
dCBtZSBrbm93IGlmIHRoZXJlDQo+ID4+Pj4+IGFyZSBhbnkNCj4gPj4+IGtub3cgbGltaXRhdGlv
bnMgZm9yIHRoaXMgdXNlY2FzZS4NCj4gPj4+Pg0KPiA+Pj4+IFllcCwgdGhlIHBhdGggZm9yIHho
Y2kgd291bGQgYmUgcXVpdGUgc2ltbGlhcjogIENyZWF0ZSBhIG5ldw0KPiA+Pj4+IFhIQ0lQY2lT
dGF0ZSBzdHJ1Y3QsIG1vdmUgb3ZlciBhbGwgcGNpLXNwZWNpZmljIGJpdHMgZnJvbQ0KPiA+Pj4+
IFhIQ0lTdGF0ZSwgbGVhdmluZyB0aGUgZ2VuZXJpYyBzdHVmZiBpbiBYSENJU3RhdGUgZm9yIHNo
YXJpbmcgd2l0aA0KPiBzeXNidXMuDQo+ID4+Pj4gUG9zc2libHkgbW92ZSBhbGwgcGNpLXNwZWNp
ZmljIGNvZGUgYml0cyBpbnRvIGEgbmV3IHNvdXJjZSBmaWxlDQo+ID4+Pj4gKGZvciBjbGVhbnVw
LCB3aWxsIGFsc28gYWxsb3cgdG8gYnVpbGQgcWVtdSB3aXRoIENPTkZJR19QQ0k9biBhbmQNCj4g
Pj4+PiBzdGlsbCBoYXZlIFhIQ0kgZW5hYmxlZCkuDQo+ID4+Pj4NCj4gPj4+PiBPbmNlIHRoaXMg
c2VwYXJhdGlvbiBpcyBkb25lIHlvdSBzaG91bGQgYmUgYWJsZSB0byBjcmVhdGUgYSBzeXNidXMN
Cj4gPj4+PiBkZXZpY2UsIHJldXNpbmcgdGhlIGdlbmVyaWMgeGhjaSBjb2RlIGFuZCBhZGRpbmcg
c3lzYnVzIHBsdW1iaW5nDQo+ID4+Pj4gKG1taW8sIGlycSwgLi4uKQ0KPiA+Pj4NCj4gPj4+IFRo
ZSBTREhDSSBjb21taXRzIGI2MzVkOThjZjMyLi44Yjc0NTVjNzVlIHNlZW0gc2ltaWxhciB0byB3
aGF0IHlvdQ0KPiA+Pj4gd2FudCB0byBhY2hpZXZlIChzZWUgYWxzbyBjb21taXQgY2U4NjQ2MDM0
KS4NCj4gPg0KDQo=

