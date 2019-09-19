Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7516CC3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 13:51:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C1CA21D6C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 13:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="xaeyJtdV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C1CA21D6C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAwqO-0006nV-7N
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 09:51:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46057)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iAwPL-0008Uz-4S
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 09:23:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iAwPK-0005tS-3d
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 09:23:38 -0400
Received: from mail-co1nam04on0728.outbound.protection.outlook.com
 ([2a01:111:f400:fe4d::728]:6644
 helo=NAM04-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iAwPJ-0005rk-Ri
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 09:23:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jw/ty5ueiRB+NXARJ0OCpNy6OZJ1g6jQkT0bRwpxc4q3b29J+C2p+BFTIKE4hD1HDVM5Pv2FbyvkYCQQd5ly8A7OCR2DSJfpW+/wmE++UYusj5slTFVlG/HorxT8zzKY5lgjytX+h0oo4msKRQmbVh7f68y5zOUP974VgMtbnVVtnDACDng9zOB78uQXl0zuTocBGljGiN4a/LUFTHEMPd7C41rVO/rLldSiUgSL+gbqXjTrQfoaT0XiTB8zhL9DyR3YNjM9jMSxIPt3wgRODh84Q3X7we3zgpmdsnEn3UfTdq2OsL9GDx7Pk+LPh5vPSPcuRM+RP6gjXfLxggI7Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zbkZK62PlIQRdTgzZRTz/2bvSqTTikj6im4SJ1OVZ+I=;
 b=ScBv3nBFxTFifH/0Zzo0XjtHMQXTIYhoVnnl4xGEzExAKoesL0/G/TLmRzMs5PHWUTSnhCvW1PyKwWLZKTDi1lKOFiC1x/wNmGu0GyEiczSOvhcUk44Sqz13lmLvIuBmblALSJse/S7k/xR0ivp8lZkPolxb4s10TfTPI+OFWOMcAVoQ1h31Y0nVx/7Y+D9OESIbDl6fqUNajRhoPOQDXHr+sdx5hmAaefR1+s3m2Eua3Mhwg3bsHfIoMZ/JZJ5fozSzIKKK2iKEQojQVAuo5wqViW2Tn3qg+Pxoy7qfJbPrmQf18C03/dXRoDfibR/acCHpeMK0mABXmsdCfu7h3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zbkZK62PlIQRdTgzZRTz/2bvSqTTikj6im4SJ1OVZ+I=;
 b=xaeyJtdVdGJ+9fqVIPxTY3NI16fOi166ix/0sj2FAio4kjXcM5CX+Gf2FJ8KuYf2sowx/jjaWMvcorbyfOS+2CIRNFSB6FFFZxyp1x3DoOhGVLbDUsnMC+CDJ49WDUXPOYrRhyCYp/ONk58C+zaXD8jt60FJim7gItuEQzv064E=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Thu, 19 Sep 2019 13:23:34 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6d88:c5bd:41ad:b107]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6d88:c5bd:41ad:b107%3]) with mapi id 15.20.2284.009; Thu, 19 Sep 2019
 13:23:34 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v3 02/22] libqos: Rename i2c_send and i2c_recv
Thread-Index: AQHVbneFFU4BDIDh4Ea8xDc1OfLEzKcy2iKAgAAjyQA=
Date: Thu, 19 Sep 2019 13:23:34 +0000
Message-ID: <1b05e0618dad90ee83e1d27e41d7d88622ce6ce9.camel@bu.edu>
References: <20190918231846.22538-1-alxndr@bu.edu>
 <20190918231846.22538-3-alxndr@bu.edu>
 <9bd3100e-0e14-46c1-e086-29b3b26a41d4@redhat.com>
In-Reply-To: <9bd3100e-0e14-46c1-e086-29b3b26a41d4@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-originating-ip: [128.197.127.33]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2af1441d-3762-48c5-dc75-08d73d0492dd
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:CY4PR03MB2872; 
x-ms-traffictypediagnostic: CY4PR03MB2872:
x-microsoft-antispam-prvs: <CY4PR03MB28727F2E0B191CF252E953D0BA890@CY4PR03MB2872.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(396003)(39860400002)(376002)(346002)(136003)(189003)(199004)(66066001)(81166006)(81156014)(8676002)(786003)(6512007)(446003)(14454004)(2616005)(99286004)(11346002)(118296001)(36756003)(2501003)(6116002)(6246003)(6486002)(2906002)(3846002)(88552002)(110136005)(6436002)(54906003)(229853002)(7736002)(305945005)(8936002)(316002)(66946007)(91956017)(75432002)(64756008)(256004)(66446008)(66556008)(86362001)(186003)(53546011)(76116006)(4326008)(66476007)(5660300002)(26005)(4744005)(76176011)(71200400001)(71190400001)(478600001)(476003)(102836004)(6506007)(25786009)(486006);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB2872;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: l/tzIrNt63KeCW7JV8Hw34jdKNeyWbvxxdzcN1hvy5h5p67W66FXhegW1wyEYMiHWZA9gXkTVIJ3LQmGo8/QZCWi7zk9r+nYGqmP43kAPzipXwYqRsbzup4Tu/p9O1xyGKeVpjg2JqNJVMsca+CdjkoVrq/GGqQV7bYJKtTU75bC9z1VkHvBxOgcuHsy2rIBSyHS098P6fQqaAE1NipHsmgkWSuwVnymLAcfO69FK0On0s6q2oogcQnFf0D6P4Rz0NlQEZPHaGjUiJeKv7rg/AQQA/zFqIN7VRqFMWA8SIoLp8Cu/ZYrrOJ1ok3B+qNkwp+txcFnuwH3dPtY30dE2Dp20p3onTd/3Usxk3g+reeSHeXo9xAIq5jzO6XGnkEg5PiBzOsj3rZuG4TZdSfhKIL+muR16GEsfW/Q1+JZ8pY=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <CC00532AD41CF946AB9A46EF93448D8E@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 2af1441d-3762-48c5-dc75-08d73d0492dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 13:23:34.8371 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0AbV8n/ZjdaRJjidQDbLdXs/1z/nHp0/zOq0NGCuYLdylZmTwdlgUXjroVzXYmKW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2872
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe4d::728
Subject: Re: [Qemu-devel] [PATCH v3 02/22] libqos: Rename i2c_send and
 i2c_recv
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
Cc: "lvivier@redhat.com" <lvivier@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>, "thuth@redhat.com" <thuth@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gVGh1LCAyMDE5LTA5LTE5IGF0IDEzOjE1ICswMjAwLCBQYW9sbyBCb256aW5pIHdyb3RlOg0K
PiBPbiAxOS8wOS8xOSAwMToxOSwgT2xlaW5paywgQWxleGFuZGVyIHdyb3RlOg0KPiA+IFRoZSBu
YW1lcyBpMmNfc2VuZCBhbmQgaTJjX3JlY3YgY29sbGlkZSB3aXRoIGZ1bmN0aW9ucyBkZWZpbmVk
IGluDQo+ID4gaHcvaTJjL2NvcmUuYy4gVGhpcyBjYXVzZXMgYW4gZXJyb3Igd2hlbiBsaW5raW5n
IGFnYWluc3QgbGlicW9zIGFuZA0KPiA+IHNvZnRtbXUgc2ltdWx0YW5lb3VzbHkgKGZvciBleGFt
cGxlIHdoZW4gdXNpbmcgcXRlc3QgaW5wcm9jKS4NCj4gPiBSZW5hbWUgdGhlDQo+ID4gbGlicW9z
IGZ1bmN0aW9ucyB0byBhdm9pZCB0aGlzLg0KPiANCj4gSSdkIHByZWZlciAicWkyY197c2VuZCxy
ZWN2fSIgc2luY2UgdGhhdCBpcyBjb25zaXN0ZW50IHdpdGgNCj4gInF2aXJ0aW9fIg0KPiBmdW5j
dGlvbnMgYW5kIHdpdGggdGhlIG5hbWUgb2YgdGhlICJRSTJDRGV2aWNlIiBzdHJ1Y3QuDQoNCk9r
IC0gaSdsbCBjaGFuZ2UgdGhpcy4NCg==

