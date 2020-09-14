Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5F2C2BC11
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 17:39:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4D16217BA
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 17:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="BFT0p8Tj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4D16217BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHsSG-000599-GT
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 13:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>) id 1kHsQa-0004FZ-UW
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 13:38:09 -0400
Received: from mail-eopbgr690047.outbound.protection.outlook.com
 ([40.107.69.47]:53476 helo=NAM04-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>) id 1kHsQW-000084-Rj
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 13:38:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MtKjBOQ+J3rknniricqxvEMCpwBSs8x+fGLC3NSNz+yy+jnudynAn8hFIVpywhX3r1UAnhaVFeWEAuFKGwRWgfaOhX8n7z7td6LDuFw6zoME8ZZ1rcRsB4Q/m3RDwyrrDHLTlkpDH3qczlc8lDxKZS7xU9hnJiVwHmqmiSidXEQgUdyY8j/htmYGR+2E0y+wYhLdh7XUCmCg8K9sxW3YnhUWM/1xnr/1EUv/rsjgnaRjExVA0qLEO3lulFHSyepqYFMlwpqHf4QH7KJODngF8FTNt433xORKTtyWI6gKZ+EeAxybsCQWNeOh8u8i0dz98KboNXB38+RH4UOL36Voiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B65XXp02TYHf3wB0slMdm+Rsq0WlGMeFscNq7x0fuRc=;
 b=m0dWCzXgR4dyZEe8X31OmZ0W3k+GVlsSB306NkNui1hN24HNJ+HqKf4cl/zP3FSmq9tJpnqvRd+FvG+PyxwmU9/WYwlkRxOaMAjEzlI3I0l4ypjooL2PLgwpNT9Y0ip/Mcr/9tZTJITPHttbL5i/KtqhAnDSwdh5QQKlq+GatcLLKHA5IxytmFVw0FaP4bwMM6YbZK4jTrJnC0z7/LaWSvXqn6Dn7KqFa/eTk6mOSvrwfLpSju5muys0IizVFopqc6he/Q4lD3s2nE7Pq6Z1RoOKKTNB3n4UPSpDR9eoBZU2yzPiuDbV50mJCzIZrP3xoQzEQrFKxEmknBSCqCVYJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B65XXp02TYHf3wB0slMdm+Rsq0WlGMeFscNq7x0fuRc=;
 b=BFT0p8Tj2sLnocprBKw/1N7jQUR8lQ0GJIgNC3u4c78OGVe+ECoWPWJNI+KyG+eh5AnAa0QBeYLJybnCTKIC2P5SVenAIQeOA4zxRPCwroDOjHmFcVoNDBFBFaXSy0+cu6TZ4pTVlNnocDUVzju3D1jsmveNAM8C/kODPw5sjyI=
Received: from BYAPR02MB4823.namprd02.prod.outlook.com (2603:10b6:a03:4e::18)
 by BY5PR02MB7043.namprd02.prod.outlook.com (2603:10b6:a03:23f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Mon, 14 Sep
 2020 17:22:57 +0000
Received: from BYAPR02MB4823.namprd02.prod.outlook.com
 ([fe80::55f8:f25:475a:4bf4]) by BYAPR02MB4823.namprd02.prod.outlook.com
 ([fe80::55f8:f25:475a:4bf4%7]) with mapi id 15.20.3326.030; Mon, 14 Sep 2020
 17:22:57 +0000
From: Vikram Garhwal <fnuv@xilinx.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: RE: [PATCH v9 0/4] Introduce Xilinx ZynqMP CAN controller
Thread-Topic: [PATCH v9 0/4] Introduce Xilinx ZynqMP CAN controller
Thread-Index: AQHWcQncmpoRUQzgOUGLpGmAPF6xzqloUHaAgAAetYCAABlBMA==
Date: Mon, 14 Sep 2020 17:22:57 +0000
Message-ID: <BYAPR02MB48233D8E6B36F394772C84ACBC230@BYAPR02MB4823.namprd02.prod.outlook.com>
References: <1597278668-339715-1-git-send-email-fnu.vikram@xilinx.com>
 <CAFEAcA8gYXDJKMS3nUSW96hhwmC37=QX1EhVfWj7j0smKGvXgA@mail.gmail.com>
 <CAFEAcA-Y8GQXSU6F3-AWcW=5VcWOtT0w_Fi4SAbfT2M2zjxB1Q@mail.gmail.com>
In-Reply-To: <CAFEAcA-Y8GQXSU6F3-AWcW=5VcWOtT0w_Fi4SAbfT2M2zjxB1Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.62.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c442fdaa-0009-4cd8-0c33-08d858d2d2d5
x-ms-traffictypediagnostic: BY5PR02MB7043:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR02MB7043CDE1A9052F8788B1C6EFBC230@BY5PR02MB7043.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dak07uoeWE89UxhnpD5uPKgZY5VbYiJYPGqN5ykp/c4HsxlFuD8/UaQhNpAhPGTAp1S62FrhAHR3+zlE4ehcXcYk/uC0i7vmLkZ2EKxpOjnkaFxn4nYZ8zSe01nJLMu19aYwo6AYkeLl/lNgjfhkwsLkb8fedq/S6ycf1pzX1qveSxh7pImJh3vT6TCU+MG1ruMDtzsx5yQIxs9+Bg1TfIpN4TBqwn0BtKdx5C3kOlRQHJQoHtLrgvrzH1VyCDrdJsdjo13TcZYVCcjE5nZDSKA4bdrVr8OpLn2F59hi6wQqEDBPkQJL42SSDjNskDhEP8wNZR+TGAGlzRaLdQjmCQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4823.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(136003)(39860400002)(366004)(376002)(396003)(346002)(6506007)(54906003)(2906002)(83380400001)(186003)(8676002)(33656002)(64756008)(66556008)(8936002)(7696005)(5660300002)(76116006)(66946007)(66446008)(107886003)(66476007)(86362001)(55016002)(478600001)(52536014)(6916009)(316002)(4326008)(26005)(71200400001)(53546011)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: HCkyRdyvpAT4ADGVlym947z4atb38Ecw1oQV3wn1uCO5++Z5yreMQX9E5sCUZQdQge4QJBYQ0W0BtlpefGy77K8KP5YdY2pUO8vejISLyDnXv1VCS066G6/0Ezj0KD5nUNon8FjIqVeDWtLxa0WGlZfK3ZLRMMXDOAuZ5CsNuIfGO2/WCgVnhskFsZpxl2ss3UeTO4lL0gJ+0qwUtny2+NVIbgqqlgqHJ8QD+UoThn/JwQSNbwfleZge+yuFBrp9SGElJ6i9mucf4AkafrxEyvKk6KgxZOUo6jLzSe+AFsFCjGpxP22CXiiwJKa2JKxdmEjCSwlWyQsCuaCfposINo0xUht7XqbKbcX/76vDE7mczK+NBUCVyyZPXiFrhfKbMBMTwcbFswmLiNtqX/B88ELEt7vtjWNXRZcd4ACFZxTnGxae4WFqgV84tgrODPY4NeoM0LPt+Pxk21jAreb38ZLgXaPM7vDtq6hCNXpgUFdCQWcUi6AVrKQRIa7Xtu8ZElbZ5Hqo6gtym+LWeDxuhlaf2PWZlwENujUq6Ewh2KpPs7xv1Q726AEwB7Ou6pBl3snDULn2XkuBH9mNY8nzUWHfsfEzEboCKCh+ljM8cp3Br43i0n78YwCJ2kgmXEuiF+N9we4x2jV/1G6u73kn7A==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4823.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c442fdaa-0009-4cd8-0c33-08d858d2d2d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2020 17:22:57.5459 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RFJeLZeZUCq+57VQVrAGr6s0m3ZtR4f1235lcWIyismNI5DKzNSYRw6Uobpnaeey
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB7043
Received-SPF: pass client-ip=40.107.69.47; envelope-from=fnuv@xilinx.com;
 helo=NAM04-CO1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 13:38:02
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Francisco Eduardo Iglesias <figlesia@xilinx.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkgUGV0ZXIsDQpUaGFua3MgZm9yIHRoZSBoZWxwIGhlcmUuDQoNCkkgaGFkIGEgbG9vayBhdCB0
aGUgdjEgcHVsbC4gSSB3aWxsIHJlYmFzZSB0aGUgcGF0Y2hlcyB3aXRoIGxhdGVzdCBjaGFuZ2Vz
IGFuZCBzZW5kIG5leHQgdmVyc2lvbiB3aXRoIGNoYW5nZXMuDQoNClJlZ2FyZHMsDQpWaWtyYW0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQZXRlciBNYXlkZWxsIDxw
ZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+DQo+IFNlbnQ6IE1vbmRheSwgU2VwdGVtYmVyIDE0LCAy
MDIwIDg6MDYgQU0NCj4gVG86IFZpa3JhbSBHYXJod2FsIDxmbnV2QHhpbGlueC5jb20+DQo+IENj
OiBRRU1VIERldmVsb3BlcnMgPHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz47IEZyYW5jaXNjbyBFZHVh
cmRvDQo+IElnbGVzaWFzIDxmaWdsZXNpYUB4aWxpbnguY29tPg0KPiBTdWJqZWN0OiBSZTogW1BB
VENIIHY5IDAvNF0gSW50cm9kdWNlIFhpbGlueCBaeW5xTVAgQ0FOIGNvbnRyb2xsZXINCj4gDQo+
IE9uIE1vbiwgMTQgU2VwIDIwMjAgYXQgMTQ6MTYsIFBldGVyIE1heWRlbGwgPHBldGVyLm1heWRl
bGxAbGluYXJvLm9yZz4NCj4gd3JvdGU6DQo+ID4NCj4gPiBPbiBUaHUsIDEzIEF1ZyAyMDIwIGF0
IDAxOjMzLCBWaWtyYW0gR2FyaHdhbCA8Zm51LnZpa3JhbUB4aWxpbnguY29tPg0KPiB3cm90ZToN
Cj4gPiA+IFZpa3JhbSBHYXJod2FsICg0KToNCj4gPiA+ICAgaHcvbmV0L2NhbjogSW50cm9kdWNl
IFhpbGlueCBaeW5xTVAgQ0FOIGNvbnRyb2xsZXINCj4gPiA+ICAgeGxueC16eW5xbXA6IENvbm5l
Y3QgWGlsaW54IFp5bnFNUCBDQU4gY29udHJvbGxlcnMNCj4gPiA+ICAgdGVzdHMvcXRlc3Q6IElu
dHJvZHVjZSB0ZXN0cyBmb3IgWGlsaW54IFp5bnFNUCBDQU4gY29udHJvbGxlcg0KPiA+ID4gICBN
QUlOVEFJTkVSUzogQWRkIG1haW50YWluZXIgZW50cnkgZm9yIFhpbGlueCBaeW5xTVAgQ0FOIGNv
bnRyb2xsZXINCj4gPg0KPiA+IEFwcGxpZWQgdG8gdGFyZ2V0LWFybS5uZXh0LCB0aGFua3MuIChJ
IGhhZCB0byBtYWtlIHNvbWUgbWlub3IgZml4dXBzDQo+ID4gdG8gY29udmVydCB0aGUgbWFrZWZp
bGUgY2hhbmdlcyB0byB0aGUgbmV3IG1lc29uIGJ1aWxkIHN5c3RlbS4pDQo+IA0KPiBJIGhhZCB0
byBkcm9wIHRoZXNlIHBhdGNoZXMgYmVjYXVzZSBpbiB0aGUgZnVsbCBtZXJnZSBidWlsZCB0ZXN0
IGNvbmZpZ3MgdGhleQ0KPiBmYWlsZWQgdG8gbGluayBiZWNhdXNlIG5vdGhpbmcgd2FzIHB1bGxp
bmcgaW4gdGhlIGdlbmVyaWMgQ09ORklHX0NBTl9CVVMNCj4gZmlsZXMuDQo+IA0KPiBDb3VsZCB5
b3UgcmViYXNlIHRoaXMsIG1ha2UgdGhlIG5lY2Vzc2FyeSBjaGFuZ2VzIHRvIGdldCBpdCB0byB3
b3JrIHdpdGgNCj4gbWVzb25bKl0sIGFuZCBhbHNvIG1ha2Ugd2hhdGV2ZXIgS2NvbmZpZyBjaGFu
Z2VzIGFyZSBuZWNlc3Nhcnkgc28gdGhhdA0KPiB0aGUgWnlucU1QIENBTiBjb250cm9sbGVyIGRl
dmljZSBkZWNsYXJlcyBpdHMgZGVwZW5kZW5jeSBvbiB0aGUgZ2VuZXJpYw0KPiBDT05GSUdfQ0FO
X0JVUyBjb2RlLCBwbGVhc2U/DQo+IA0KPiBbKl0geW91IG1pZ2h0IHdhbnQgdG8gbG9vayBhdCB0
aGUgdmVyc2lvbnMgb2YgdGhlIHBhdGNoZXMgSSBqdXN0IHNlbnQgb3V0IGluDQo+IG15IHYxIHB1
bGxyZXEgdG9kYXksIGJ1dCBiYXNpY2FsbHkgaW5zdGVhZCBvZiB0aGUgTWFrZWZpbGUuaW5jbHVk
ZSBjaGFuZ2VzDQo+IHlvdSB3YW50IHNvbWUgc2ltcGxlIG9uZS1saW5lciBjaGFuZ2VzIHRvIG1l
c29uLmJ1aWxkIGZpbGVzLCBhbmQgYWxzbw0KPiB0ZXN0cy9xdGVzdC94bG54LWNhbi10ZXN0LmMg
bmVlZHMgdG8gI2luY2x1ZGUgImxpYnFvcy9saWJxdGVzdC5oIg0KPiByYXRoZXIgdGhhbiBqdXN0
ICJsaWJxdGVzdC5oIi4NCj4gDQo+IHRoYW5rcw0KPiAtLSBQTU0NCg==

