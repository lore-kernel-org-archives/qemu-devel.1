Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A35C388F9
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 13:54:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 494AF206E3
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 13:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="nBTD2MCt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 494AF206E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbl9a-0004eL-70
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 08:54:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45794)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kbl8A-0004Ak-Lo
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 08:53:18 -0500
Received: from mail-mw2nam10on2053.outbound.protection.outlook.com
 ([40.107.94.53]:21601 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kbl88-0001fx-EZ
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 08:53:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TkJm8hNJ/pLlR3TxCmi9OuAiXUOE3kB5eDmbJxAjzzKs06L7VCpxVHVbIDOTY3/Ejsq01ZTTE0W5vp78C1GG4IKvMALI4KI65bjEp2H3Gh0BJ9hN0jp7bxGvCLjTlnYHm4aCAt2vfLSP4V0YGc8UjuuW9CGiKt9WAJOPugF69sThIzwJaLhNRvG9GtY3zdNKw8vDbaotBf/wcRTj4CmGj5emkKeU2HDL6TV+J5hbs6RVL+muouu5W42QUy9up9mPN7dCCMfJJpOKMvAj7t1vknkZPjAGhEZqrkY/zjRMzeSMNVemt6R1fxY6Xbqe89OjbwMmhAGpoT5WYaApXz54ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DbQYtasdliO3ZpXyZaEHW3AvqplNFiKCruvuaYR8yno=;
 b=WLyta/TzRqUwrszvbeaxSMmFDsdRL0ZL/Ku73iBudV2SQSE8DBBKwsVH3bIfwtcAfKijwCMfg05Ha2eKKGZj7p+hREHeaMyjC9dTnCPNVYKMcD180tkNpyPfDBe0T6Sb7zHF4w69JLZ1p/C/f6cNg9pD5WYE3pne1WgB8CpGQZUrO21sY4PmsgtVaYL8A9XjMFTlwOljJehdArrI8cLEEX2cfZgD9UepROlkaByPrzt+jws2or1ZYGBIx8ANWaH7yg/p0W47EJohj8YRGoLxKGsZEsguzKkYdnww7UlQKZC2HZU1uTnGIPaC7iTMbPcrNgjenlKnz+B6J4aLFmaoeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DbQYtasdliO3ZpXyZaEHW3AvqplNFiKCruvuaYR8yno=;
 b=nBTD2MCtwasF5aX7r4D3Zeo7NTAze5GzZKg96YIOWAIoby8afwhzSNCfqA6GDB0pSBq3rHp8sZB4x+RcXZjC6I+aXNXIK8Sd843b9f9l2e1tQCKXzJlslpYoGTxjSIDp1WYSxIQ7s8Vdl2pRPeQMLXe3Sf/Q6s7mYgGszLUAvxQ=
Received: from BY5PR02MB6772.namprd02.prod.outlook.com (2603:10b6:a03:206::11)
 by BYAPR02MB5255.namprd02.prod.outlook.com (2603:10b6:a03:66::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Sun, 8 Nov
 2020 13:38:09 +0000
Received: from BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::75ed:4271:263b:fd15]) by BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::75ed:4271:263b:fd15%3]) with mapi id 15.20.3541.025; Sun, 8 Nov 2020
 13:38:08 +0000
From: Sai Pavan Boddu <saipava@xilinx.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH-for-5.2 1/5] hw/usb/hcd-xhci: Make xhci base model abstract
Thread-Topic: [PATCH-for-5.2 1/5] hw/usb/hcd-xhci: Make xhci base model
 abstract
Thread-Index: AQHWtPb/PuioC6DUAk6YMKXIFTrYram+PqwA
Date: Sun, 8 Nov 2020 13:38:08 +0000
Message-ID: <BY5PR02MB6772D97FA4C0DC0CEF7DB8D8CAEB0@BY5PR02MB6772.namprd02.prod.outlook.com>
References: <20201107111307.262263-1-philmd@redhat.com>
 <20201107111307.262263-2-philmd@redhat.com>
In-Reply-To: <20201107111307.262263-2-philmd@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 54fd4388-027a-41ad-0d2e-08d883eb8795
x-ms-traffictypediagnostic: BYAPR02MB5255:
x-microsoft-antispam-prvs: <BYAPR02MB52554EC3BC7BF7DEE4DD8E3DCAEB0@BYAPR02MB5255.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a9SMAFGSL429ZcVED/rqJFdSVVKSrIfgEnwEoYlI9gCisoY29bSVU/blrMRxFQxHGIf3FJtmiS5bx4Kf8Skb7ES/yP8aeekDtWJiciM0U3JwTFoiK5kNI2/+I+GsRFBv4XiyPhjqz6SYBHG2mNDAyko54rk4a8uikgaoggnW0t7Ie9ypaAPsVSrZ7sg8NKXmMY0kmUpdasZkrx4yVJ0vwZMVfNpRYDVKBgA34+8PLerJJyHQk5an/H2CwxOlKtBmQX6xYPCxSgnby6GiMJB8drPl79GHC//VRjlYAdtJm0jvJC4NjVBmzhyAYtwSG/+u
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6772.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39850400004)(396003)(136003)(366004)(376002)(186003)(66446008)(66946007)(8676002)(316002)(2906002)(86362001)(8936002)(54906003)(55016002)(6506007)(4326008)(9686003)(53546011)(7696005)(83380400001)(52536014)(33656002)(71200400001)(478600001)(26005)(64756008)(5660300002)(110136005)(66556008)(66476007)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: fq4+wan60CjSz9jpMjlGEgRuhDnqU16LZP1WdEhn3YTmHk8rB7ZZTSy1WmiblClc1aO55/ioiebySbx8scRlx8xP39npsXZkDKPmNkjJ6BkLQRnh0dz6Ox8bxlE9IKPOJKVc3KZO/K+MZU0226fQZV6uwzueaNn3M87Zc+vBH8bBavazEt1BxgnPfmOQbe7xHCtkMhGmBQJJ5/hqhGXh1UtQ9oR/GpzyI86SG+6/m1kb0ATkMnAkEiK6gdyem4JuA0aYnFGKb0m0jaWM6BYx7w/6G/KQwSQ2FySxlst3F58Dca+nz8W/uRnDjuC+rcD6yTU/xKSR2ASUm+osavgM9oUqTncJJd9IefrgY2I+RWiaxazesf8/E9C8vcX78sUQJ91LUoy/LXjcKV9YUPHoyRHYeoxuKOn2zXRVdUeulMxvrr3QVIW4c4kldfguKxM/uMCfXGhUfFB1Xj5hW4wqUXGrZ9WdruBKGyQg3Q9ykt0C08pvYIis4UKkAK2BJ58GNxFUNPXJpcE9U+aEDOYB9oU1fpnESQr8jr65Zhisoeal4b53N0DqRwGW8iUKb6lOVwhurKK544exlYtKoy+wjcB3Nsy1c5NU+mdT9i/wQgoyyv6mNNEpHiIN3YFyhTYtn6CuiIxmx1vZdJzMByIFKw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6772.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54fd4388-027a-41ad-0d2e-08d883eb8795
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2020 13:38:08.7145 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kGzYS/qQSI7eMUx7ChE09UI6P8N9UHUUroeKcZZXY8x20bQt+o8RJZVQCXWRqXUHuPIP+ryVDFj7jzqMHLm7DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5255
Received-SPF: pass client-ip=40.107.94.53; envelope-from=saipava@xilinx.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/08 08:53:14
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
Cc: Miroslav Rezanina <mrezanin@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

TG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IFNhaSBQYXZhbiBCb2RkdSA8c2FpLnBhdmFuLmJv
ZGR1QHhpbGlueC5jb20+DQoNClRoYW5rcywNClNhaSBQYXZhbg0KPiAtLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KPiBGcm9tOiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQHJlZGhh
dC5jb20+DQo+IFNlbnQ6IFNhdHVyZGF5LCBOb3ZlbWJlciA3LCAyMDIwIDQ6NDMgUE0NCj4gVG86
IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogR2VyZCBIb2ZmbWFubiA8a3JheGVsQHJlZGhh
dC5jb20+OyBTYWkgUGF2YW4gQm9kZHUNCj4gPHNhaXBhdmFAeGlsaW54LmNvbT47IFBoaWxpcHBl
IE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAcmVkaGF0LmNvbT47DQo+IE1pcm9zbGF2IFJlemFuaW5h
IDxtcmV6YW5pbkByZWRoYXQuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0gtZm9yLTUuMiAxLzVdIGh3
L3VzYi9oY2QteGhjaTogTWFrZSB4aGNpIGJhc2UgbW9kZWwgYWJzdHJhY3QNCj4gDQo+IFRoZSBU
WVBFX1hIQ0kgbW9kZWwgaXMgYWJzdHJhY3QgYW5kIGNhbiBub3QgYmUgdXNlZCBhcyBpdC4NCj4g
SXQgaXMgbWVhbnQgdG8gYmUgb3ZlcmxvYWRlZCBieSBjaGlsZHJlbiBjbGFzc2VzLiBSZXN0b3Jl
IGl0IGFzIGFic3RyYWN0IHR5cGUuDQo+IA0KPiBGaXhlczogOGRkYWI4ZGQzZDggKCJ1c2IvaGNk
LXhoY2k6IFNwbGl0IHBjaSB3cmFwcGVyIGZvciB4aGNpIGJhc2UgbW9kZWwiKQ0KPiBSZXBvcnRl
ZC1ieTogTWlyb3NsYXYgUmV6YW5pbmEgPG1yZXphbmluQHJlZGhhdC5jb20+DQo+IFNpZ25lZC1v
ZmYtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAcmVkaGF0LmNvbT4NCj4gLS0t
DQo+ICBody91c2IvaGNkLXhoY2kuYyB8IDEgKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaHcvdXNiL2hjZC14aGNpLmMgYi9ody91c2IvaGNk
LXhoY2kuYyBpbmRleA0KPiA3OWNlNWM0YmU2Yy4uNTdiNjkyYWQ4NDkgMTAwNjQ0DQo+IC0tLSBh
L2h3L3VzYi9oY2QteGhjaS5jDQo+ICsrKyBiL2h3L3VzYi9oY2QteGhjaS5jDQo+IEBAIC0zNTk1
LDYgKzM1OTUsNyBAQCBzdGF0aWMgY29uc3QgVHlwZUluZm8geGhjaV9pbmZvID0gew0KPiAgICAg
IC5wYXJlbnQgICAgICAgID0gVFlQRV9ERVZJQ0UsDQo+ICAgICAgLmluc3RhbmNlX3NpemUgPSBz
aXplb2YoWEhDSVN0YXRlKSwNCj4gICAgICAuY2xhc3NfaW5pdCAgICA9IHhoY2lfY2xhc3NfaW5p
dCwNCj4gKyAgICAuYWJzdHJhY3QgICAgICA9IHRydWUsDQo+ICB9Ow0KPiANCj4gIHN0YXRpYyB2
b2lkIHhoY2lfcmVnaXN0ZXJfdHlwZXModm9pZCkNCj4gLS0NCj4gMi4yNi4yDQoNCg==

