Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B55C2D0CE
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 05:15:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6BF521734
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 05:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="hm/Gq2fX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6BF521734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inFIb-0000dO-V0
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 00:15:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59287)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <saipava@xilinx.com>) id 1inFHt-0008KS-6h
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 00:14:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <saipava@xilinx.com>) id 1inFHr-00072d-1D
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 00:14:16 -0500
Received: from mail-bn8nam11on2088.outbound.protection.outlook.com
 ([40.107.236.88]:6265 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <saipava@xilinx.com>) id 1inFHq-0006yk-OH
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 00:14:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X18tCGZJlMikrCin2lHf2I9CkjeFvT31or7CB8NneXz0Xcp3ifv2dybMHP4TcSzrtG2AiwoBsEAWoX2Y3clumqFa1VGvh9TPjfmEqlwz7RmQOzlZsmWwg0JrkNT2hZiaWj5M3Jt5mf6mjVFXTn11dOne5FbNOr/Tb/4UEC/x9oz+ZsOo+BMN+k1vAEIpXrHjxJTvjnKwtGWDaIPZWq5rhguf0GqXrfrZXv1dzT8ZVg+/7fBoYnTGEQkwg2xC9/Szo9gpKPpF0nd2rVjxWqUX19d0/U7yJDEtw408cVm7aaRgNuEMn/7BqeSZYbe1nhWYoLyG34jDMHuyaAu+J36Fmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JmuZ3orgKVKP23O25OklbXzzAjbhMMGkBVU/BNNzGrc=;
 b=UXoiDuvo9OKxNd2jJe7VToRhVfPk8YhTnh+V+5OTd9QkOAi4ptSGg9oJwJEO7oO74ARfqNVaO5DbqYkfTJf2RQB4PPZ8w6VGNGjwH+leIFWUEH34nPOzyMg4dmmZ9s2TKEM9i6Xpy+2yJDAwnLqT6ue283vcFyMrEKdLqdZHXPJNuC4GzGpwMHOXEq8Q/9ZFSmAbjB8+Ez+sKWe7Blnr+4AlKH9h54w6Tw5z9tC2IrucSVxXhSJakAQdQY3K2J4Rpankk1/tR8XnNLS7J93H60LRakDL2Iz3VwMYCSnYCbBGfMt3MfLRJY8ANYVromLO+vUa6F8IvaPNbTY8ODVbkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JmuZ3orgKVKP23O25OklbXzzAjbhMMGkBVU/BNNzGrc=;
 b=hm/Gq2fXRvLc+KRP3LsnoEMboD+E2vdwZ4fGkCw4j58qGcNMgf/PaNm8bNUOzsjOrsGTC52R82kNGs/G5mxHqvBtcy/iJDztwDPh340iwmoXWpsAOeExI9oMa2TNRtRypcSbF61eVOAqdZkjGQ850cgAin0fbvQLHgzO+77FsWE=
Received: from MN2PR02MB5935.namprd02.prod.outlook.com (20.179.86.87) by
 MN2PR02MB6399.namprd02.prod.outlook.com (52.132.174.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.12; Fri, 3 Jan 2020 05:14:12 +0000
Received: from MN2PR02MB5935.namprd02.prod.outlook.com
 ([fe80::ccdf:be82:7597:e916]) by MN2PR02MB5935.namprd02.prod.outlook.com
 ([fe80::ccdf:be82:7597:e916%4]) with mapi id 15.20.2581.007; Fri, 3 Jan 2020
 05:14:12 +0000
From: Sai Pavan Boddu <saipava@xilinx.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 "kraxel@redhat.com" <kraxel@redhat.com>
Subject: RE: sysbus usb xhci
Thread-Topic: sysbus usb xhci
Thread-Index: AdXBOtUqrwwzin1wTyqynlaACcsu6gAFoByAAAOHm4AAJTzfAA==
Date: Fri, 3 Jan 2020 05:14:12 +0000
Message-ID: <MN2PR02MB59356EE03FCE2AFEF22F437ACA230@MN2PR02MB5935.namprd02.prod.outlook.com>
References: <MN2PR02MB5935CFE95528B85E06DA9583CA200@MN2PR02MB5935.namprd02.prod.outlook.com>
 <20200102094515.bbjaqlif7ucvzuou@sirius.home.kraxel.org>
 <b8ad0f98-a02d-bcb2-acd8-a6e9fb606167@redhat.com>
In-Reply-To: <b8ad0f98-a02d-bcb2-acd8-a6e9fb606167@redhat.com>
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
x-ms-office365-filtering-correlation-id: 77789c78-edc8-45a9-2200-08d7900bc573
x-ms-traffictypediagnostic: MN2PR02MB6399:
x-microsoft-antispam-prvs: <MN2PR02MB6399197329467E4D41126FADCA230@MN2PR02MB6399.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0271483E06
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(346002)(366004)(396003)(376002)(13464003)(189003)(199004)(5660300002)(8676002)(86362001)(81156014)(76116006)(7116003)(110136005)(54906003)(4326008)(3480700007)(33656002)(2906002)(7696005)(52536014)(9686003)(53546011)(6506007)(478600001)(66446008)(66556008)(26005)(64756008)(66946007)(55016002)(66476007)(71200400001)(316002)(186003)(8936002)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR02MB6399;
 H:MN2PR02MB5935.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xZC5jBq7KyLJfYTK3fIgOcac6j9x2YQ1+ratNaBKL48WJa8FVIp+o/fNAo2mQDUtAZZk7zg3a5zKty36chYO4/DeMOcn3b9euNsqFDhyoWM4oaoxsl4/4AP8mdbyZz1esbgMvCs8wjJ5DYVmr3U4yRurP+UWZPpIHERSRJBzoftD4dysL0CB3JZJ3n3wNUpCpne6+5QPXCh4YAxuS/Ba4YQnrkkL4G5ikZmEaiCWtOlGZoXJNIaDm2vbd1dCBot72TUqiKZRGyZh9BpVnWAJO2At76VSoXlt2U8nVuXDXFi1tuAXlpAIROEVu4SNVhgFBU4pv8+JmWcs812VLPgkHkA43TsBvYfzXx9kawTaO7l3WPxR2AP0mPvmKtdG44g1p0F4zIOmYA02pdwJscVNiXh+JPXrHNAfcdPqMBqu3wSAo6zydi84ZID8o6jou9U0hLlgi8nhaWHq9MIOrH6hVfYRo8IRf/Npgua4WZP/mKfFQ+DusEsB0c6FnAd5jE8C
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77789c78-edc8-45a9-2200-08d7900bc573
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2020 05:14:12.6212 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6PEg1UFpLRbqh+spGrfTGxxFuCAjMGCeuYdak/NfrKDAPcyEKYpsrm13gfdhTHUTs4VAsZKInOTp0NK1C9VloQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6399
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.236.88
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

VGhhbmtzIFBoaWxpcHBlICYgR3JlZC4gSSB3b3VsZCBzdGFydCB3aXRoIHRoZSBiZWxvdyBwb2lu
dGVycy4NCg0KUmVnYXJkcywNClNhaSBQYXZhbg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+IEZyb206IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAcmVkaGF0LmNvbT4N
Cj4gU2VudDogVGh1cnNkYXksIEphbnVhcnkgMiwgMjAyMCA0OjU2IFBNDQo+IFRvOiBrcmF4ZWxA
cmVkaGF0LmNvbTsgU2FpIFBhdmFuIEJvZGR1IDxzYWlwYXZhQHhpbGlueC5jb20+DQo+IENjOiBw
ZXRlci5tYXlkZWxsQGxpbmFyby5vcmc7IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBTdWJqZWN0
OiBSZTogc3lzYnVzIHVzYiB4aGNpDQo+IA0KPiBPbiAxLzIvMjAgMTA6NDUgQU0sIGtyYXhlbEBy
ZWRoYXQuY29tIHdyb3RlOg0KPiA+IE9uIFRodSwgSmFuIDAyLCAyMDIwIGF0IDA3OjEzOjI1QU0g
KzAwMDAsIFNhaSBQYXZhbiBCb2RkdSB3cm90ZToNCj4gPj4gSGkgR3JlZCwNCj4gPj4NCj4gPj4g
V2UgYXJlIHNlZWluZyBvZiBvcHRpb25zIHRvIHJldXNlIHRoZSBoY2QteGhjaSBtb2RlbCBhbmQg
dXNlIGl0IG92ZXINCj4gPj4gc3lzdGVtIGJ1cyBpbnRlcmZhY2UgcmF0aGVyIHRoYW4gcGNpLiAo
Zm9yIFhpbGlueCBaeW5xTVAgU09DLCB1c2INCj4gZW11bGF0aW9uKSBBcmUgdGhlcmUgYW55IHBs
YW5zIG9mIGltcGxlbWVudGluZyBhIHN5c2J1cyBkZXZpY2UgPyBpZiBub25lIGl0DQo+IHdvdWxk
IGJlIGdvb2QgaWYgcHJvdmlkZWQgZmV3IHBvaW50ZXJzIHRvIHN0YXJ0Lg0KPiA+DQo+ID4gVGhl
cmUgaGF2ZSBiZWVuIHNvbWUgZGlzY3Vzc2lvbnMgYWJvdXQgdGhpcyBmb3IgYSAoSUlSQykgc2Jz
YSBtYWNoaW5lLA0KPiA+IGJ1dCBJJ20gbm90IHN1cmUgd2hlbmV2ZXIgdGhhdCB3aGVyZSBqdXN0
IGlkZWFzIG9yIHNvbWUgY29kZSBleGlzdHMuDQo+ID4NCj4gPj4gSW0gbG9va2luZyBhdCBoY2Qt
ZWhjaS9vY2hpIGFzIGEgcmVmZXJlbmNlLCBsZXQgbWUga25vdyBpZiB0aGVyZSBhcmUgYW55DQo+
IGtub3cgbGltaXRhdGlvbnMgZm9yIHRoaXMgdXNlY2FzZS4NCj4gPg0KPiA+IFllcCwgdGhlIHBh
dGggZm9yIHhoY2kgd291bGQgYmUgcXVpdGUgc2ltbGlhcjogIENyZWF0ZSBhIG5ldw0KPiA+IFhI
Q0lQY2lTdGF0ZSBzdHJ1Y3QsIG1vdmUgb3ZlciBhbGwgcGNpLXNwZWNpZmljIGJpdHMgZnJvbSBY
SENJU3RhdGUsDQo+ID4gbGVhdmluZyB0aGUgZ2VuZXJpYyBzdHVmZiBpbiBYSENJU3RhdGUgZm9y
IHNoYXJpbmcgd2l0aCBzeXNidXMuDQo+ID4gUG9zc2libHkgbW92ZSBhbGwgcGNpLXNwZWNpZmlj
IGNvZGUgYml0cyBpbnRvIGEgbmV3IHNvdXJjZSBmaWxlIChmb3INCj4gPiBjbGVhbnVwLCB3aWxs
IGFsc28gYWxsb3cgdG8gYnVpbGQgcWVtdSB3aXRoIENPTkZJR19QQ0k9biBhbmQgc3RpbGwNCj4g
PiBoYXZlIFhIQ0kgZW5hYmxlZCkuDQo+ID4NCj4gPiBPbmNlIHRoaXMgc2VwYXJhdGlvbiBpcyBk
b25lIHlvdSBzaG91bGQgYmUgYWJsZSB0byBjcmVhdGUgYSBzeXNidXMNCj4gPiBkZXZpY2UsIHJl
dXNpbmcgdGhlIGdlbmVyaWMgeGhjaSBjb2RlIGFuZCBhZGRpbmcgc3lzYnVzIHBsdW1iaW5nDQo+
ID4gKG1taW8sIGlycSwgLi4uKQ0KPiANCj4gVGhlIFNESENJIGNvbW1pdHMgYjYzNWQ5OGNmMzIu
LjhiNzQ1NWM3NWUgc2VlbSBzaW1pbGFyIHRvIHdoYXQgeW91DQo+IHdhbnQgdG8gYWNoaWV2ZSAo
c2VlIGFsc28gY29tbWl0IGNlODY0NjAzNCkuDQoNCg==

