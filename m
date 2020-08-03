Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B138C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 23:47:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75F8F206F6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 23:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="Ob9KYlXi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75F8F206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2kAd-0004IK-I0
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 19:47:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50538)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Josh.Pincus@windriver.com>)
 id 1k2kA1-0003sT-Gy
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 19:46:29 -0400
Received: from mail-bn8nam11on2045.outbound.protection.outlook.com
 ([40.107.236.45]:30433 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Josh.Pincus@windriver.com>)
 id 1k2k9y-0001gO-6y
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 19:46:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dUO174cFtv+0rcocJchKQed5oY1FZNNxrgriC3YItKDVGJrB8kHRujQl9zq8D9GcfOWY3wo+BxdYdOT5zBd6owTnger0av11kBVH+bHus909xngfwpeQYSh9TUuZ905v4BHv5zLB77R3SUcZomEYqJoQn8RrrKB9aGTW+reHrxRrJJcSxQCtckWoSoFhvtPLJAdozdwDKh6R2fp0muCnKgHPgkfxDgwfUXGDb/PceHLwgQgBPTAjqteCx302DSDCjEsa9zaJv3tKVXIaUNmKCur7HC/fgSFLG8Et+ChJvbE4p3yI1OR7UGJ6Q1wsv9q4vGUT9me4eC5SMi19eo8IYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L9Wg39eYutF9m9qnn+xrISr67zFYKjvOEEsQy6Mqnqg=;
 b=Xt9I+T0dZxLreEWoz0icpWS3t62xaxOVxLWvTRSI/n+SiJwsplCOXOeMKyk8fHsqJMqDMSc5sZ/XAYmitU+KzTSR88JaHVyqDFRm4iOLRo+CTRYyozuG8Qih+nyksfVfX2Xx0R+39qRBcZboy+dNreOYDH2grfUXBJM5nHpJhSJt66Rwh7jVBRvDOqelL+k1aAUQPf3YA7tYcGd3HIzFMRmP8qdWaKO2x9K6/LhqPn8ANMdZ30rw2kwz+QpJR+5rQ5X+0KCO4gd1PnbXIV3DFxqwKLKDqyRtuKFGEtYR/KSsIX6UmOz80Dt84KNWdig9K+OzJp1MlFGChK90NppANA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L9Wg39eYutF9m9qnn+xrISr67zFYKjvOEEsQy6Mqnqg=;
 b=Ob9KYlXinkhkQDNHO+vMDnHVkj3nZSd92U6SKTBh1oDNVUoCSwDcPuv36XSai3tL3CcBk2vZ0+h/SwhhsPczvpbMUhQuQbY0BDm61oCaZhOKrPdjijDg1VYeh65Ok0sGB1ecIuO3u+j0PSaDhZkj9AM1pTk5GC2HQ06xYWYJtlo=
Received: from DM6PR11MB4331.namprd11.prod.outlook.com (2603:10b6:5:203::12)
 by DM6PR11MB3354.namprd11.prod.outlook.com (2603:10b6:5:9::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.16; Mon, 3 Aug 2020 23:31:18 +0000
Received: from DM6PR11MB4331.namprd11.prod.outlook.com
 ([fe80::c982:743f:799c:b82c]) by DM6PR11MB4331.namprd11.prod.outlook.com
 ([fe80::c982:743f:799c:b82c%6]) with mapi id 15.20.3239.022; Mon, 3 Aug 2020
 23:31:18 +0000
From: "Pincus, Josh" <Josh.Pincus@windriver.com>
To: =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Subject: RE: [PATCH v2 0/5] virtio mmio specification enhancement
Thread-Topic: [PATCH v2 0/5] virtio mmio specification enhancement
Thread-Index: AQHWZ1GLBOGI81rh00qmY9/kQnZAdakm+FSA
Date: Mon, 3 Aug 2020 23:31:17 +0000
Message-ID: <DM6PR11MB4331176F03293E22E9253E5EF94D0@DM6PR11MB4331.namprd11.prod.outlook.com>
References: <DM6PR11MB4331B490586462DE7353E0B8F9710@DM6PR11MB4331.namprd11.prod.outlook.com>
 <87ft973d0b.fsf@linaro.org>
In-Reply-To: <87ft973d0b.fsf@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=windriver.com;
x-originating-ip: [172.91.148.166]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6f309bec-9427-4d40-b60b-08d838055269
x-ms-traffictypediagnostic: DM6PR11MB3354:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB3354D347ACED0997D547E07BF94D0@DM6PR11MB3354.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KwMDJmNhX0Y9yBW1DniJvN8biGXr67ZtEFu1N8AIAUf+0fm3tkhf8cno1YphmnW5dbYLQdTUMamC/s+T9bqvajClOc1FP4T5c1wc0CMlOFLnMTVEEnaYen+40vrp0bYVcrXdiZMNy7JHOgkJ4h/75g2EjXCs+P83h8pI90CkHATwBdaAmTvHMPmobHDonOGs2V37vlNNpi2uP2gq30xhi8k1iLZwfT1YnQJEjTQz3ytX32MvJNRNh5gIBr33RYtAAXvIjvFo0CXYUjIZTY06zxSPBmviTXCTR7QvWVSCmue2fYP89QSJxhd8DF1iwuVP8QMpiB2wAjc1+lTM4RsCSw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR11MB4331.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(39850400004)(346002)(396003)(366004)(376002)(136003)(8676002)(186003)(76116006)(64756008)(66556008)(54906003)(8936002)(71200400001)(66446008)(66476007)(66946007)(52536014)(5660300002)(6506007)(53546011)(316002)(66574015)(33656002)(6916009)(26005)(478600001)(9686003)(83380400001)(86362001)(7696005)(2906002)(4326008)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: g/ueREr0UvJn6a4D/wCwQJkWXj9kpjOg8qfqsUXoHVLGaD8RZP6IiUWHpw5eKD5SMfzhvfISK48WLSgG9VDgbI7o2O3hI9g0zVhO8PafzhTRO2ViBYiFZKkXQGbztFXb9qmZ7/m1caaJQIVLfzKbxcOcaN7AEj3jZ/SE+RXibB7b8Ib3rz5riZeXExKkqYeRS0O4kZzF/iYgEzytAyTIsg1xbYmJ/R2UV9mHRtZNK4qqjk5z1NN7+b38MRu5kOcGoYUXahpLQz3um5n7YbSGjlhn5L866GoxvlPz0LlVthZDNXJYKVE7odrHC9JJmfNB4Hn0i5/4qzal9swgpc86q+sJm9YhhZ632PdSxBx7tF7ZaCPp9d/LMPOxERMOgvVEv1vi9Ku2lfbCZREE5J1tSncr7BCH2Wpae/UB3yH7UX53EBBOIZXt3svvMvGIF4ty3hvOQH9+puWE1t+Hu9TUyr4OuStxBqc0neci3EZ+fILotfu76XKkzXPOXviaQsVWoo/4ugAmUyddE2SOt11kqlfGAAWcH7M7HgV6+cXnIKZqDfQNAlnC/EOTy5WEHYBwtYilQcd+rFRN8d0pMjVN5hyhYLaUh0gH4FzR00felJlF4zp3NKU/SvmXOAFbcn8D6FpoYVPyz1YnWlPMaAxiKg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4331.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f309bec-9427-4d40-b60b-08d838055269
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2020 23:31:17.9657 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uBPr8OmpRgp/1JoQj8uDoYZwFaY8tHTOzwD5ndL7l68fgaqZPbrOb0oITnOzvRGa//XxIj32kiJE/ECe6aAbXiotPcfgd0odl6E9Ja2autA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3354
Received-SPF: pass client-ip=40.107.236.45;
 envelope-from=Josh.Pincus@windriver.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/03 19:46:22
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
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
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 "zhabin@linux.alibaba.com" <zhabin@linux.alibaba.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkgQWxleCwNCg0KVGhhbmsgeW91IGZvciB0aGUgcmVwbHkuDQoNClBsZWFzZSBzZWUgbXkgaW5s
aW5lIHJlc3BvbnNlIGJlbG93Lg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTog
QWxleCBCZW5uw6llIDxhbGV4LmJlbm5lZUBsaW5hcm8ub3JnPiANClNlbnQ6IEZyaWRheSwgSnVs
eSAzMSwgMjAyMCA4OjQ1IEFNDQpUbzogUGluY3VzLCBKb3NoIDxKb3NoLlBpbmN1c0B3aW5kcml2
ZXIuY29tPg0KQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IHpoYWJpbkBsaW51eC5h
bGliYWJhLmNvbTsgdmlydGlvLWRldkBsaXN0cy5vYXNpcy1vcGVuLm9yZzsgcWVtdS1kZXZlbEBu
b25nbnUub3JnDQpTdWJqZWN0OiBSZTogW1BBVENIIHYyIDAvNV0gdmlydGlvIG1taW8gc3BlY2lm
aWNhdGlvbiBlbmhhbmNlbWVudA0KDQoNClBpbmN1cywgSm9zaCA8Sm9zaC5QaW5jdXNAd2luZHJp
dmVyLmNvbT4gd3JpdGVzOg0KDQo+IEhpLA0KPg0KPiAgDQo+DQo+IFdlIHdlcmUgbG9va2luZyBp
bnRvIGEgc2ltaWxhciBlbmhhbmNlbWVudCBmb3IgdGhlIFZpcnQgSS9PIE1NSU8gdHJhbnNwb3J0
IGFuZCBjYW1lIGFjcm9zcyB0aGlzIHByb2plY3QuDQo+DQo+IFRoaXMgZW5oYW5jZW1lbnQgd291
bGQgYmUgcGVyZmVjdCBmb3IgdXMuDQoNClNvIHRoZXJlIGlzIGNlcnRhaW5seSBhbiBpbnRlcmVz
dCBpbiBvcHRpbWlzaW5nIE1NSU8gYmFzZWQgdmlydGlvIGFuZCB0aGUgY3VycmVudCByZWFkL2Fj
ayBjeWNsZSBhZGRzIGFkZGl0aW9uYWwgcm91bmQgdHJpcCB0aW1lIGZvciBhbnkgdHJhcCBhbmQg
ZW11bGF0ZSBoeXBlcnZpc29yLiBIb3dldmVyIEkgdGhpbmsgdGhlcmUgaXMgc29tZSByZXNpc3Rh
bmNlIHRvIG1ha2luZyBNTUlPIGEgcmUtaW1wbGVtZW50YXRpb24gb2Ygd2hhdCBQQ0kgYWxyZWFk
eSBnaXZlcyB1cyBmb3IgImZyZWUiLg0KDQpJIGJlbGlldmUgdGhlIGN1cnJlbnQgcXVlc3Rpb25z
IHRoYXQgbmVlZCB0byBiZSBhZGRyZXNzZWQgYXJlOg0KDQogIC0gQ2xlYXIgZGVmaW5pdGlvbnMg
aW4gdGhlIHNwZWMgb24gZG9vcmJlbGxzL25vdGlmaWNhdGlvbnMNCg0KICAgIFRoZSBjdXJyZW50
IHZpcnRpbyBzcGVjIHVzZXMgZGlmZmVyZW50IHRlcm1zIGluIHNvbWUgcGxhY2VzIHNvIGl0DQog
ICAgd291bGQgYmUgbmljZSB0byBjbGFyaWZ5IHRoZSBsYW5ndWFnZSBhbmQgZm9ybWFsaXNlIHdo
YXQgdGhlDQogICAgc3RhbmRhcmQgZXhwZWN0cyBmcm9tIHRyYW5zcG9ydHMgdy5yLnQgdGhlIGNh
cGFiaWxpdGllcyBvZg0KICAgIG5vdGlmaWNhdGlvbnMgYW5kIGRvb3JiZWxscy4NCg0KW0pQXSBU
aGUgcmVhZC9hY2sgY3ljbGUgbm90IG9ubHkgYWRkcyB0byB0aGUgcm91bmQtdHJpcCB0aW1lIGZv
ciBhbnkgdHJhcCBhbmQgZW11bGF0ZSBIWVAsIGJ1dCBpdCBhbHNvIHByZWNsdWRlcyBhbiBlbnZp
cm9ubWVudCB3aGVyZSBvbmUgbWlnaHQgd2FudCB0byBhdm9pZCBlbXVsYXRpb24gY29tcGxldGVs
eS4gIFdlJ3JlIGludGVyZXN0ZWQgaW4gdXNpbmcgdGhlIE1NSU8gdHJhbnNwb3J0IGNvbWJpbmVk
IHdpdGggYW4gYXVnbWVudGVkIGRldmljZSBub2RlIGluIHRoZSBEVEIgdG8gaGF2ZSBkZXZpY2Ug
ZmVhdHVyZXMsIHJlc2VydmVkIG1lbW9yeSBmb3IgcXVldWVzLCBhbmQgc3BlY2lmaWMgTVNJIGlu
dGVycnVwdHMgcGVyIHF1ZXVlIGNvbnZleWVkIHRvIHRoZSBndWVzdCBzdGF0aWNhbGx5LiAgSW4g
dGhpcyBraW5kIG9mIHJlc3RyaWN0ZWQgZW52aXJvbm1lbnQsIG5lZ290aWF0aW9uIGZvciBmZWF0
dXJlcyBtaWdodCBiZSBjb21wbGV0ZWx5IGRpc2FibGVkOyB5b3Ugc2VlIHdoYXQgdGhlIGRldmlj
ZSBub2RlIGRlc2NyaWJlcyBhbmQgeW91IGVpdGhlciBzdXBwb3J0IHRob3NlIGZlYXR1cmVzIG9y
IG5vdC4gIExpa2V3aXNlLCB0aGUgc3RhbmRhcmQgbGlzdCBvZiBzdGF0ZSBtYWNoaW5lIHRyYW5z
aXRpb25zIGZvciBjb21tdW5pY2F0aW5nIGRyaXZlciBhbmQgZGV2aWNlIHN0YXRlIHdvdWxkIGJl
IHNraXBwZWQuICBBIGRyaXZlciBpbiBhIGd1ZXN0IGNvbWVzIHVwLCByZWFkcyB0aGUgZGV2aWNl
IG5vZGUgaW5mbywgdXNlcyB0aGUgcXVldWVzIGFzIGRlc2NyaWJlZCwgYW5kIGFzc2lnbnMgdGhl
IE1TSSB2ZWN0b3JzIHBlciBxdWV1ZSBhbmQgY29uZmlnLWhhcy1jaGFuZ2VkIHNlcnZpY2UuICBX
aGVuIGFuIGludGVycnVwdCBjb21lcyBpbiwgdGhlcmUncyBubyBuZWVkIHRvIGFjayBpdCBiZXlv
bmQgdGhlIG5vcm1hbCB3YXkgaW4gd2hpY2ggb25lIGNvbnZleXMgYW4gRU9JIHRvIGhhcmR3YXJl
LiAgSXQgYWxzbyBtZWFucyB0aGF0IHdpdGggb25lIGRlZGljYXRlZCBpbnRlcnJ1cHQgcGVyIHF1
ZXVlIHdlIHdvbid0IGhhdmUgdG8gc2VsZWN0IHRoZSBxdWV1ZSBpbiBxdWVzdGlvbiBhbmQgdGVz
dCB3aGljaCBvbmUgZ290IHVwZGF0ZWQuICBJbiBzaG9ydCwgd2UgYXJlIGV4cGVyaW1lbnRpbmcg
d2l0aCBnZXR0aW5nIHJpZCBvZiB0aGUgZW11bGF0aW9uIGlmIHdlIGNhbi4NCg0KICAtIFF1YW50
aWZ5aW5nIHRoZSBtZW1vcnkgZm9vdC1wcmludCBkaWZmZXJlbmNlIGJldHdlZW4gUENJL01NSU8N
Cg0KICAgIFBDSSBnaXZlcyBhIGxvdCBmb3IgZnJlZSBpbmNsdWRpbmcgYSBkaXNjb3ZlcnkgYW5k
IElSUSBtb2RlbCBhbHJlYWR5DQogICAgZGVzaWduZWQgdG8gaGFuZGxlIE1TSS9NU0ktWC4gVGhl
cmUgaXMgYSBjbGFpbSB0aGF0IHRoaXMgYnJpbmdzIGluIGENCiAgICBsb3Qgb2YgYmxvYXQgYnV0
IEkgdGhpbmsgdGhlcmUgd2FzIHNvbWUgZGViYXRlIGFyb3VuZCB0aGUgbnVtYmVycy4NCiAgICBN
eSByb3VnaCBpbml0aWFsIGV4cGVyaW1lbnQgd2l0aCBhIFBDSSBhbmQgbm9uLVBDSSBidWlsZCB3
aXRoDQogICAgb3RoZXJ3aXNlIGlkZW50aWNhbCBWSVJUSU8gY29uZmlncyByZXN1bHRzIGluIHRo
ZSBmb2xsb3dpbmc6DQoNCiAgICAxNjo0MDoxNSBjLjI4MiUgW2FsZXhAemVuOn4vbC9sL2J1aWxk
c10gcmV2aWV3L3JwbWJ84oCmICsgbHMgLWwgYXJtNjQvdm1saW51eCBhcm02NC5ub3BjaS92bWxp
bnV4DQogICAgLXJ3eHIteHIteCAxIGFsZXggYWxleCA4MzkxNDcyOCBKdWwgMzEgMTY6MzkgYXJt
NjQubm9wY2kvdm1saW51eCoNCiAgICAtcnd4ci14ci14IDEgYWxleCBhbGV4IDg2MzY4MDgwIEp1
bCAzMSAxNjozMyBhcm02NC92bWxpbnV4Kg0KDQogICAgd2hpY2ggY2VydGFpbmx5IGltcGxpZXMg
dGhlcmUgY291bGQgYmUgYSBmYWlyIGFtb3VudCBvZiBoZWFkcm9vbSBmb3INCiAgICBhbiBNTUlP
IHZlcnNpb24gdG8gaW1wbGVtZW50IHNvbWUgZmVhdHVyZXMuIEhvd2V2ZXIgSSBkb24ndCBrbm93
IGlmDQogICAgaXQncyBmdWxseSBhcHBsZXMgdG8gYXBwbGVzIGFzIHRoZXJlIG1heWJlIHVubmVl
ZGVkIFBDSSBibG9hdCB0aGF0IGENCiAgICB2aXJ0aW8tb25seSBrZXJuZWwgZG9lc24ndCBuZWVk
Lg0KDQpbSlBdIEFwcm9wb3Mgb2YgeW91ciBzdWJzZXF1ZW50IGVtYWlsIG9uIHRoaXMgdG9waWMs
IHRoZSBQQ0kgYmxvYXQgaXNuJ3QgdGVycmlibGUuICBUaGUgbWFqb3Igc3R1bWJsaW5nIGJsb2Nr
IGluIG91ciBjYXNlIGlzIHRoYXQgd2Ugd291bGQgbGlrZSB0byBzZWUgaWYgdGhlcmUncyBhIHJl
c3RyaWN0ZWQgbW9kZWwgaW4gd2hpY2ggdGhlIGVtdWxhdGlvbiBjYW4gYmUgcmVtb3ZlZCBjb21w
bGV0ZWx5LiAgQ2FzZSBpbiBwb2ludDogVmlydCBJL08gUlBNc2dzIGluIE9wZW5BTVAgb25seSB1
c2UgdGhlIHF1ZXVlcyB0byB0cmFuc2ZlciBkYXRhIGJhY2sgYW5kIGZvcnRoLiAgKFVubGVzcyBJ
J20gbWlzdGFrZW4/KSAgIFdlJ2QgbGlrZSB0byBzZWUgaWYgdGhhdCBtb2RlbCBjYW4gYmUgYSBi
aXQgbW9yZSBnZW5lcmFsaXplZCBzbyB0aGF0IG90aGVyIGtpbmRzIG9mIGRyaXZlcnMgY2FuIGJl
IGNvbnN0cnVjdGVkIHRoYXQgc2ltaWxhcmx5IGRvbid0IHJlbHkgb24gZW11bGF0aW9uIGZvciBo
YW5kbGluZyBpbnRlcnJ1cHQgcmVhZC9hY2ssIGZlYXR1cmUgbmVnb3RpYXRpb24sIHF1ZXVlIHNl
bGVjdGlvbiwgZXRjLiAgTWVtb3J5IGlzIG1hcHBlZCBpbnRvIHRoZSBndWVzdCBmb3IgcXVldWVz
IGFuZCBSL08gZGV2aWNlIHJlZ2lzdGVycywgaW50ZXJydXB0cyBhcmUgYXNzaWduZWQgaW4gdGhl
IERUQiBmb3IgZWFjaCBxdWV1ZSwgYW5kIGZlYXR1cmVzIGFyZSwgZXNzZW50aWFsbHksIG5vbi1u
ZWdvdGlhYmxlLiAgDQoNCldoYXQgYXJlIHRoZSBmZWF0dXJlcyB5b3UgYXJlIG1vc3QgaW50ZXJl
c3RlZCBpbj8NCg0KW0pQXSBTZWUgYWJvdmUuIPCfmIkgVGhlIHJlc3RyaWN0ZWQgZW52aXJvbm1l
bnQgaW4gcXVlc3Rpb24gaXMgZm9yIHZlcnkgc2ltcGxlIGFwcGxpY2F0aW9ucyB0aGF0IGRvbid0
IGhhdmUgYW55IGtpbmQgb2YgUENJIGluZnJhc3RydWN0dXJlIGFuZCBmb3IgdmlydHVhbCBlbnZp
cm9ubWVudHMgd2l0aCBubyBIWVAgb3IgYSB2ZXJ5IHJlc3RyaWN0ZWQgSFlQLiAgDQoNCj4gSGFz
IHRoZXJlIGJlZW4gYW55IHByb2dyZXNzIHNpbmNlIEZlYiwgMjAyMD8gIEl0IGxvb2tzIGxpa2Ug
dGhlIGVmZm9ydCANCj4gbWlnaHQgaGF2ZSBzdGFsbGVkPw0KDQpJIGNhbid0IHNwZWFrIHRvIHRo
ZSBPUCdzIGJ1dCB0aGVyZSBpcyBjZXJ0YWlubHkgaW50ZXJlc3QgZnJvbSBvdGhlcnMgdGhhdCBh
cmUgbm90IHRoZSBvcmlnaW5hbCBwb3N0ZXJzLg0KDQpbSlBdIE1heWJlIHdlIGNhbiByZXN0YXJ0
IHRoZSB0aHJlYWQvZGlzY3Vzc2lvbiBhbmQgc2VlIHdoZXJlIGl0IGdvZXMgZnJvbSBoZXJlLg0K
DQotLQ0KQWxleCBCZW5uw6llDQo=

