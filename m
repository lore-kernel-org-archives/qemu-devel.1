Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14686C388F9
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 13:46:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CAB8206E3
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 13:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="DBubxpFT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CAB8206E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbl1B-0000SN-TS
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 08:46:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43856)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kbkwn-0006Ey-4p
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 08:41:36 -0500
Received: from mail-mw2nam12on2078.outbound.protection.outlook.com
 ([40.107.244.78]:6176 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kbkwk-00063r-6s
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 08:41:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ciyi/cDcmvL7lOkk1ljEm2AX0McFJbpWhwcOzIlxyu8xzbr7dW8L5pVgVozwuqVnBr5qDOQZ3VEcAk4TEVteJn2t/BUvf43MGyydIiffYeslODR0pjbsS20FPNxqRd5eqMJ1hfrjONkwgKdivKHuO5IvI7ENRTSh6tUIPIJukFlocuybg4lUsX1rk4Jb5fY2aIKX/IVcIuMs5mjKynDdBYs8C1tlRHIvEh0+VvjR1un93jPwKHzQ6MQIN5b4z0AQQIMz1+Sgc3Uy5ibvBIvQpeWJ0tQi+bIOHSEKg9/NbEknAjlxhpVm/5GZKv2Q+UEaLyrayjrRV2ntO5oAXPFOZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWuMKZWudPV9MzJspgzNaJaaElc82V3cBkSwCbx3M70=;
 b=WcmNqr6T+IIE8+H+5gEXAPD5hkFTqbZzAanpMXBM5aQ3fmlUW1lTXMVCxDZ5MmtyBh+LRwBb622J8WsExPrVOOx7lqlJ1bn5cS+mN+7PpkuL/AKa50yrWCL9KGG89Vv9OmyFHxj7A2Yknb6mdNo3n9ELPswLunOz07x/0+i/CP6RySHzcnBiaK4yA8jQk7FGcyRUBZ2Kwh+ulmHboEMLOhMsFrA31ww/PHDS9ejqhNTSt4AwfYYSENzXRvoOuu1C/YCiNdwlhHeas9JtW1VYns4UCSRTwhkPi8cbEHM7Nv9EL5dieO65aaTrsINeuZtcb/ePNMyW/RUaEdExz9ZDJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWuMKZWudPV9MzJspgzNaJaaElc82V3cBkSwCbx3M70=;
 b=DBubxpFTKmC2PPPh2ly/PRQOPC1t2jjAk6V68Q6BLI6PL/EMEk99WUhHPzze/YOFaW8Gz84RdGQ7rHAByofR6ppWqnoPy8xb0ayga6973vFLas18P7yjcGOMI+qeyIqLzqCIhC6Aza2ME0IGRZ12Prqqc7OG9enZEKacnTueyyY=
Received: from BY5PR02MB6772.namprd02.prod.outlook.com (2603:10b6:a03:206::11)
 by BYAPR02MB5255.namprd02.prod.outlook.com (2603:10b6:a03:66::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Sun, 8 Nov
 2020 13:40:52 +0000
Received: from BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::75ed:4271:263b:fd15]) by BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::75ed:4271:263b:fd15%3]) with mapi id 15.20.3541.025; Sun, 8 Nov 2020
 13:40:52 +0000
From: Sai Pavan Boddu <saipava@xilinx.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH-for-5.2 2/5] hw/usb/Kconfig: Fix USB_XHCI_NEC (depends on
 USB_XHCI_PCI)
Thread-Topic: [PATCH-for-5.2 2/5] hw/usb/Kconfig: Fix USB_XHCI_NEC (depends on
 USB_XHCI_PCI)
Thread-Index: AQHWtPcCnyxeZ948bk+L4Gzt0NFJCKm+Pzsw
Date: Sun, 8 Nov 2020 13:40:52 +0000
Message-ID: <BY5PR02MB6772E37593614B04214ED690CAEB0@BY5PR02MB6772.namprd02.prod.outlook.com>
References: <20201107111307.262263-1-philmd@redhat.com>
 <20201107111307.262263-3-philmd@redhat.com>
In-Reply-To: <20201107111307.262263-3-philmd@redhat.com>
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
x-ms-office365-filtering-correlation-id: 8adfbb1f-0be6-4e25-4d56-08d883ebe937
x-ms-traffictypediagnostic: BYAPR02MB5255:
x-microsoft-antispam-prvs: <BYAPR02MB52551FAC618DBE18054201B8CAEB0@BYAPR02MB5255.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:913;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JGKzRef4UhmnR5YZhm3DT6mDdOGLAUVFyoYqMJuqcwqj24xKtCK7Alvs8oFyqnsEtH0WUqbhl4BiYJYfu9SG4TGIcU4pk368CYrVWO2vOiZ57k0da8w1IblvGQrHF8+WPBWE5iVxzkc4hoQjkkG+sw9VsIY5qOToDO2vbHq7RNzKCI6n7CKMhysSDkWYQOY+J0kYOBategayIZIcvJwTfxAyePxCgt5pEa3HZPobzCYWLnB3gVgv20MKk8CHcT9wgxKpC4BLWoYLIehxVQYq2y5FtZH4Zwtvbr3zHYGee95uC3NZpr+b195eRM6dzI7C
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6772.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39850400004)(396003)(136003)(366004)(376002)(186003)(66446008)(66946007)(8676002)(316002)(2906002)(86362001)(8936002)(55016002)(6506007)(4326008)(9686003)(53546011)(7696005)(83380400001)(52536014)(33656002)(71200400001)(478600001)(26005)(64756008)(5660300002)(110136005)(66556008)(66476007)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: F5GS1UlLSSeArU81H9J11LvibvA6foZSnpTkpCx21rNq+rNC43/IOPzTTQgtAyQWUj8nFBU5QeppOkvM0bmsDKfZL1kV6O1k8nV7oci8OXMzrIhULXYESLY4y1HLkiwf6y71BJIh6WIsB04bWLTWp/qxACBsp5D3TqOpVaEUfOiPEagBZl/KBczE1X45hownYuj3shjLXqiLsWFVrFVVZs5Zecei26E5VmoNzbOn+r7dYvkYP9rz2PjCanfsE5WQKDNcrlfbBlHs+kLNhp/ewYZtEp+AXEIFdwsNuYSwSSzwYfYY4O/eIOiLkLJaB3/XZbQp+FUogw6ZugvIWGsqWcyDUAp8UjMDPXJ+Tvir9BX1MrYShIbK8EHhXJtcPXsXEDuo0ivXLtuXHxWo+AaDAF29YnDp8cttx3t4RfH2MWB2tF6rddGu2W6xEpNIb5lPbhp8/gt2YWvoOGTEczIwZKbHMgMt9rafDhH0jAYwdHW/a+Cofcuu8WSnqhVe3waWwpsBbKxKfUS5QaTbSqDKR5XPMxQKVPp/0DNYB+IUb/xbOtUbAKNntvU1nSF1qrBOnJgTDo/EaQNbT/cBilL6+KlQt+ecXQs7luXs3U7ugJ3CLrXpI4GXAL/Ofg1UxO6g1DrgwawhjwkKDZ1cYYxkiA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6772.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8adfbb1f-0be6-4e25-4d56-08d883ebe937
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2020 13:40:52.5367 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JZpE6RCO9VHzERSPl0ijS5yNwtzq0kNUeT7Nv8ueYVGdk4intRto/zFf0E4iuk1SbUXVJ2oyPLSiY46vQ98DQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5255
Received-SPF: pass client-ip=40.107.244.78; envelope-from=saipava@xilinx.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/08 08:41:28
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhhbmtzLCBnb29kIGZpeC4NCg0KUmV2aWV3ZWQtYnk6IFNhaSBQYXZhbiBCb2RkdSA8c2FpLnBh
dmFuLmJvZGR1QHhpbGlueC5jb20+DQoNClJlZ2FyZHMsDQpTYWkgUGF2YW4NCj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxt
ZEByZWRoYXQuY29tPg0KPiBTZW50OiBTYXR1cmRheSwgTm92ZW1iZXIgNywgMjAyMCA0OjQzIFBN
DQo+IFRvOiBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gQ2M6IEdlcmQgSG9mZm1hbm4gPGtyYXhl
bEByZWRoYXQuY29tPjsgU2FpIFBhdmFuIEJvZGR1DQo+IDxzYWlwYXZhQHhpbGlueC5jb20+OyBQ
aGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQHJlZGhhdC5jb20+DQo+IFN1YmplY3Q6IFtQ
QVRDSC1mb3ItNS4yIDIvNV0gaHcvdXNiL0tjb25maWc6IEZpeCBVU0JfWEhDSV9ORUMgKGRlcGVu
ZHMgb24NCj4gVVNCX1hIQ0lfUENJKQ0KPiANCj4gU2luY2UgY29tbWl0IDc1NWZiYTExZmJjIGFu
ZCA4ZGRhYjhkZDNkOCB3ZSBjYW4gbm90IGJ1aWxkIFVTQl9YSENJX05FQw0KPiB3aXRob3V0IFVT
Ql9YSENJX1BDSS4gQ29ycmVjdCB0aGUgS2NvbmZpZyBkZXBlbmRlbmN5Lg0KPiANCj4gRml4ZXM6
IDc1NWZiYTExZmJjICgidXNiL2hjZC14aGNpOiBNb3ZlIHFlbXUteGhjaSBkZXZpY2UgdG8gaGNk
LXhoY2ktcGNpLmMiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8
cGhpbG1kQHJlZGhhdC5jb20+DQo+IC0tLQ0KPiAgaHcvdXNiL0tjb25maWcgfCA0ICstLS0NCj4g
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9ody91c2IvS2NvbmZpZyBiL2h3L3VzYi9LY29uZmlnIGluZGV4DQo+IGE2NzRj
ZTRjNTQyLi42YTIxM2IwNDc1OCAxMDA2NDQNCj4gLS0tIGEvaHcvdXNiL0tjb25maWcNCj4gKysr
IGIvaHcvdXNiL0tjb25maWcNCj4gQEAgLTQyLDkgKzQyLDcgQEAgY29uZmlnIFVTQl9YSENJX1BD
SQ0KPiANCj4gIGNvbmZpZyBVU0JfWEhDSV9ORUMNCj4gICAgICBib29sDQo+IC0gICAgZGVmYXVs
dCB5IGlmIFBDSV9ERVZJQ0VTDQo+IC0gICAgZGVwZW5kcyBvbiBQQ0kNCj4gLSAgICBzZWxlY3Qg
VVNCX1hIQ0kNCj4gKyAgICBzZWxlY3QgVVNCX1hIQ0lfUENJDQo+IA0KPiAgY29uZmlnIFVTQl9Y
SENJX1NZU0JVUw0KPiAgICAgIGJvb2wNCj4gLS0NCj4gMi4yNi4yDQoNCg==

