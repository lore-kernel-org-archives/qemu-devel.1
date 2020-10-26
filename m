Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C10C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 19:32:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 002632085B
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 19:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="kOLY+5Yx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 002632085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX8Dx-0008RB-Gn
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 15:32:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kX8A9-0003x1-9B
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 15:28:13 -0400
Received: from mail-dm6nam08on2058.outbound.protection.outlook.com
 ([40.107.102.58]:55223 helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kX8A6-0001Ba-Jf
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 15:28:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b1DjBgAuIl8gotmVKl//rJk/7BZ22laV1PAzkg5qC1/wXjIaIsPd9EDNTYBW19pBcJ6x6D+TWEKM5txubdCe7IQbxLeWq8D+918BKFam3236bMwdojnQhTaeGBOJnZpvpF7TbKg5OJOFOQknsY4Y4B+T8oyFAVaLNjM3Z1JNflBO9deFtFrG8G5FrNFA1I3udY+CGy2AUcE8Ct1z/KVw6R8Jc9KX25rhPQUKrwSI8IDQtWa2thOL2mTNsDA49A1FQ00KLhuslxiZ7eAxglp10+RN3SHoMfvYUtoHJi1T6OxHdI3Ihf5IVtsUaSw2raTlvYDUnoIlGZJgMdUig2jhCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K9nI4aC0OFXuOggNnfRbqlwm5xZL76HpaQyUS39hymI=;
 b=abWGryighfWalAMp8AfV89b7GW7mzPvEHVvUQ0PBS4mAa8fSA7ujxRkYv4iGXI4qjMCjmrgxi4FswS4zKeYB/dR0pU99ML045DTU6HxRTk5a57BOOKVnGdXYyHJRi+gxlG7cS52YR0dsWlvc788IKRj16v5FPwPmynY669goRH7at0J82lmMJy6SNUOctkXaqxaqmTFYj5Vjm/lxETH/MchkT8IHqXq4L9j2c1BsqhqYaoacGfYXo3/pPrrOcqF73ucpB3kS2VLlNv6YvjjjBDGW+rTTa7N8EYTV/vHC+nMVf9AUa+MJ2pnuuzd1dc4GcpqOtjYxmD2Hb2egHhKKWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K9nI4aC0OFXuOggNnfRbqlwm5xZL76HpaQyUS39hymI=;
 b=kOLY+5Yx/sGQJE125tD7pUVPp8rjuI7SiHfhq7CzijYmKH7bt/B281CAmRn4A2OCeWb6qEEQljod42a/ZS04pkWBZYBJqmCE3TbqrZdH8tx8s3YfhQJJb74kPfrRWCnHZ6Y/5vNpJ1GZRO4iXVR/AHGaJ9zLWQqHuBJvc8PGaRg=
Received: from BY5PR02MB6772.namprd02.prod.outlook.com (2603:10b6:a03:206::11)
 by BY5PR02MB7043.namprd02.prod.outlook.com (2603:10b6:a03:23f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Mon, 26 Oct
 2020 19:28:07 +0000
Received: from BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::75ed:4271:263b:fd15]) by BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::75ed:4271:263b:fd15%3]) with mapi id 15.20.3499.018; Mon, 26 Oct 2020
 19:28:07 +0000
From: Sai Pavan Boddu <saipava@xilinx.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: RE: [PATCH v12 3/3] Versal: Connect DWC3 controller with virt-versal
Thread-Topic: [PATCH v12 3/3] Versal: Connect DWC3 controller with virt-versal
Thread-Index: AQHWqGyFQYR5fsaElU+ihmMCwEhRFKmqEsOAgAAr4OA=
Date: Mon, 26 Oct 2020 19:28:07 +0000
Message-ID: <BY5PR02MB6772DD08B035F035BE1E9A7BCA190@BY5PR02MB6772.namprd02.prod.outlook.com>
References: <1603369056-4168-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1603369056-4168-4-git-send-email-sai.pavan.boddu@xilinx.com>
 <CAFEAcA8QdJQqkLO47+Z=N6aTX70HNaDVXjw6UTS15_qnMAyxtA@mail.gmail.com>
In-Reply-To: <CAFEAcA8QdJQqkLO47+Z=N6aTX70HNaDVXjw6UTS15_qnMAyxtA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [49.205.235.17]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d3228604-916b-4161-2db3-08d879e54433
x-ms-traffictypediagnostic: BY5PR02MB7043:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR02MB70437BEF0A8BA20F6979F0B2CA190@BY5PR02MB7043.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d2CcpMrPVqvyAn7ZThpnCdrVngJHbRx7kajohK7U9ALWSy39wcqmwz32zg2tiJYZ/rQBAukgW76akmevmM+0VqZp+bDmK4LDScrLT5X9crKlVskzGdvnnD136JhS1t4QlU2vksTfylnt3uvc4Hgu9ILiO9cxOwLvRTsxdftkMseYKPsccVL4Alo2KFNCVrPSIveX6ECdF2uXnoEH5/Wp8Px/iU+RTV0PeQVAudPj86vWndisy/2ZGA/m5XXLA7Nif/xV2mhEhKipfn+u4oUM2vtFlWUIbfjLNaWqmC97ULDp5WgPH23auc2ADHSgajvRYe7zT+U38DqCBvsK/O7dmQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6772.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(346002)(366004)(136003)(396003)(7416002)(6916009)(66476007)(7696005)(54906003)(55016002)(76116006)(64756008)(2906002)(26005)(8936002)(8676002)(53546011)(186003)(6506007)(86362001)(66946007)(66446008)(66556008)(316002)(9686003)(52536014)(478600001)(33656002)(5660300002)(71200400001)(4326008)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: aD3uOWcWSE1hcK2QlrwZsZ3v3lubaDD1kGAvJ3OwCNc92QR/mr34HUro3GnVbl1J6WY89Q4mNBME7p831f5zL3dRj0KbbS8TRL1MObuv9z+jvc8/cLRzh5J8R2tEAJ8ZsHGxWW1Ug5v7Eru2lmuYH3S+z/WNncXecHdK+ny65nXM2IIbS4/yZKkOzuPuJ3eSKBNDNpCU/SROsYRcpz/a3eN7L9v+lXD9v848Ax0TLBhCJffKRkCTQjfyI5eX1j2FxeVYK5rJx5RNWUjjHQq2PMWYwVC/AhwrffVj6xrGV2uf3o0UMT/TVF9BpLXLBV2wkaUx4eY0vCKfow8MxbRV6kv5/nmvO9Zd5AFK7LY2dMHdaOohCaYL9EmsPnEtvTKh3riGPhRcArj9afrS8ZmCvf4vGORcZZ1d76/86+JRFqH8Stti8yN32N8KLkWsMyJBTfk+XTpYdYRF2bYbzahSus/1xoX1vxzzZuWcA0MDym3WMDs+b/2AwfAgIaDm+vDjrUXWY2mb8710izXtWp22IQ7c5M1SsyToLeUTMEMpEyoBzHd2B8dU5ThhcSWdlLoRPDF2B/seq3elGMjkRHTL/s1awSZbCWs6yb4p64QvXCtWjewAR3VUXeDbX/Il0a01hfxI3HeIoQjmaZiXSFGjJQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6772.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3228604-916b-4161-2db3-08d879e54433
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2020 19:28:07.0416 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cx8EpW0srjn+RSdbvbTHm2K9/uPO+I6akSK8ou9XOZDWpqj2x4i/Pduk5cCTfAyuFw/w+XZHhVKFFsRXKeDQqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB7043
Received-SPF: pass client-ip=40.107.102.58; envelope-from=saipava@xilinx.com;
 helo=NAM04-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 15:28:08
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Eduardo Habkost <ehabkost@redhat.com>, Vikram Garhwal <fnuv@xilinx.com>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Edgar Iglesias <edgari@xilinx.com>,
 Alistair Francis <alistair.francis@wdc.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ying Fang <fangying1@huawei.com>,
 =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Paul Zimmerman <pauldzim@gmail.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkgUGV0ZXINCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQZXRlciBN
YXlkZWxsIDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+DQo+IFNlbnQ6IE1vbmRheSwgT2N0b2Jl
ciAyNiwgMjAyMCA5OjM1IFBNDQo+IFRvOiBTYWkgUGF2YW4gQm9kZHUgPHNhaXBhdmFAeGlsaW54
LmNvbT4NCj4gQ2M6IE1hcmt1cyBBcm1icnVzdGVyIDxhcm1icnVAcmVkaGF0LmNvbT47IE1hcmMt
QW5kcsOpIEx1cmVhdQ0KPiA8bWFyY2FuZHJlLmx1cmVhdUByZWRoYXQuY29tPjsgUGFvbG8gQm9u
emluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT47DQo+IEdlcmQgSG9mZm1hbm4gPGtyYXhlbEByZWRo
YXQuY29tPjsgRWRnYXIgSWdsZXNpYXMgPGVkZ2FyaUB4aWxpbnguY29tPjsNCj4gRnJhbmNpc2Nv
IEVkdWFyZG8gSWdsZXNpYXMgPGZpZ2xlc2lhQHhpbGlueC5jb20+OyBRRU1VIERldmVsb3BlcnMg
PHFlbXUtDQo+IGRldmVsQG5vbmdudS5vcmc+OyBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFpci5m
cmFuY2lzQHdkYy5jb20+OyBFZHVhcmRvDQo+IEhhYmtvc3QgPGVoYWJrb3N0QHJlZGhhdC5jb20+
OyBZaW5nIEZhbmcgPGZhbmd5aW5nMUBodWF3ZWkuY29tPjsNCj4gUGhpbGlwcGUgTWF0aGlldS1E
YXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPjsgVmlrcmFtIEdhcmh3YWwNCj4gPGZudXZAeGlsaW54
LmNvbT47IFBhdWwgWmltbWVybWFuIDxwYXVsZHppbUBnbWFpbC5jb20+OyBTYWkgUGF2YW4gQm9k
ZHUNCj4gPHNhaXBhdmFAeGlsaW54LmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MTIgMy8z
XSBWZXJzYWw6IENvbm5lY3QgRFdDMyBjb250cm9sbGVyIHdpdGggdmlydC12ZXJzYWwNCj4gDQo+
IE9uIFRodSwgMjIgT2N0IDIwMjAgYXQgMTM6MTEsIFNhaSBQYXZhbiBCb2RkdSA8c2FpLnBhdmFu
LmJvZGR1QHhpbGlueC5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4gRnJvbTogVmlrcmFtIEdhcmh3
YWwgPGZudS52aWtyYW1AeGlsaW54LmNvbT4NCj4gPg0KPiA+IENvbm5lY3QgZHdjMyBjb250cm9s
bGVyIGFuZCB1c2IyLXJlZyBtb2R1bGUgdG8geGxueC12ZXJzYWwgU09DLCBpdHMNCj4gPiBwbGFj
ZWQgaW4gaW91IG9mIGxwZCBkb21haW4gYW5kIGNvbmZpZ3VyZSBpdCBhcyBkdWFsIHBvcnQgaG9z
dA0KPiA+IGNvbnRyb2xsZXIuIEFkZCB0aGUgcmVzcGVjdGl2ZSBndWVzdCBkdHMgbm9kZXMgZm9y
ICJ4bG54LXZlcnNhbC12aXJ0IiBtYWNoaW5lLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogVmlr
cmFtIEdhcmh3YWwgPGZudS52aWtyYW1AeGlsaW54LmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBT
YWkgUGF2YW4gQm9kZHUgPHNhaS5wYXZhbi5ib2RkdUB4aWxpbnguY29tPg0KPiANCj4gDQo+ID4g
K3N0YXRpYyB2b2lkIHZlcnNhbF9jcmVhdGVfdXNicyhWZXJzYWwgKnMsIHFlbXVfaXJxICpwaWMp
IHsNCj4gPiArICAgIERldmljZVN0YXRlICpkZXYsICp4aGNpX2RldjsNCj4gPiArICAgIE1lbW9y
eVJlZ2lvbiAqbXI7DQo+ID4gKw0KPiA+ICsgICAgb2JqZWN0X2luaXRpYWxpemVfY2hpbGQoT0JK
RUNUKHMpLCAiZHdjMy0wIiwgJnMtPmxwZC5pb3UudXNiLmR3YzMsDQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBUWVBFX1VTQl9EV0MzKTsNCj4gPiArICAgIGRldiA9IERFVklDRSgm
cy0+bHBkLmlvdS51c2IuZHdjMyk7DQo+ID4gKyAgICB4aGNpX2RldiA9IERFVklDRSgmcy0+bHBk
LmlvdS51c2IuZHdjMy5zeXNidXNfeGhjaSk7DQo+IA0KPiBJZiB5b3UgZmluZCB5b3Vyc2VsZiBm
aXNoaW5nIGFyb3VuZCBpbiB0aGUgaW50ZXJuYWxzIG9mIGFub3RoZXIgZGV2aWNlLCBlc3BlY2lh
bGx5DQo+IHRvIHRoaXMgZGVwdGgsIHRoZW4gc29tZXRoaW5nJ3MgcHJvYmFibHkgbm90IHJpZ2h0
IGluIHRoZSBzdHJ1Y3R1cmUgb2YgdGhhdA0KPiBkZXZpY2UuDQpbU2FpIFBhdmFuIEJvZGR1XSBZ
ZWFoLCBpdCBsb29rIHByZXR0eSBsb25nLiBCdXQsICJzLT5scGQuaW91LnVzYiIgZGVmaW5lcyBz
b2MgZG9tYWlucyBmb3IgdXMuDQpFeC4gVXNiIGlzIHBhcnQgb2YgbG93LXBvd2VyIGRvbWFpbihp
LmUgbHBkKSBpbiBJT1UgbW9kdWxlLg0KQW5kICIgZHdjMy5zeXNidXNfeGhjaSAiLCBpcyBzcGVj
aWZpYyB0byB1c2IgYW5kIGlzIHJlc3VsdCBvZiBwYXJlbnRpbmcgZHdjMyB0byB4aGNpLg0KDQo+
IA0KPiA+ICsNCj4gPiArICAgIG9iamVjdF9wcm9wZXJ0eV9zZXRfbGluayhPQkpFQ1QoeGhjaV9k
ZXYpLCAiZG1hIiwgT0JKRUNUKCZzLT5tcl9wcyksDQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgJmVycm9yX2Fib3J0KTsNCj4gPiArICAgIHFkZXZfcHJvcF9zZXRfdWludDMyKHho
Y2lfZGV2LCAiaW50cnMiLCAxKTsNCj4gPiArICAgIHFkZXZfcHJvcF9zZXRfdWludDMyKHhoY2lf
ZGV2LCAic2xvdHMiLCAyKTsNCj4gPiArDQo+ID4gKyAgICBzeXNidXNfcmVhbGl6ZShTWVNfQlVT
X0RFVklDRShkZXYpLCAmZXJyb3JfZmF0YWwpOw0KPiA+ICsNCj4gPiArICAgIG1yID0gc3lzYnVz
X21taW9fZ2V0X3JlZ2lvbihTWVNfQlVTX0RFVklDRShkZXYpLCAwKTsNCj4gPiArICAgIG1lbW9y
eV9yZWdpb25fYWRkX3N1YnJlZ2lvbigmcy0+bXJfcHMsDQo+IE1NX1VTQl9YSENJXzBfRFdDM19H
TE9CQUwsIG1yKTsNCj4gPiArICAgIG1yID0gc3lzYnVzX21taW9fZ2V0X3JlZ2lvbihTWVNfQlVT
X0RFVklDRSh4aGNpX2RldiksIDApOw0KPiA+ICsgICAgbWVtb3J5X3JlZ2lvbl9hZGRfc3VicmVn
aW9uKCZzLT5tcl9wcywgTU1fVVNCX1hIQ0lfMCwgbXIpOw0KPiANCj4gRm9yIGluc3RhbmNlLCBy
YXRoZXIgdGhhbiBoYXZpbmcgdG8gZmluZCB0aGUgeGhjaSBkZXZpY2UgYW5kIG1hcCBpdHMgbWVt
b3J5DQo+IHJlZ2lvbnMgYW5kIGNvbm5lY3QgaXRzIElSUXMgZGlyZWN0bHksIHRoZQ0KPiB1c2It
ZHdjMyBkZXZpY2UgY291bGQgcHJvdmlkZSBhbmQgcGFzcyB0aHJvdWdoIHRob3NlIE1ScyBhbmQg
SVJRcywgc28gdGhhdA0KPiBib2FyZCBjb2RlIGlzIG9ubHkgd2lyaW5nIHVwIHdoYXQgdGhlIHVz
Yi1kd2MzIHByb3ZpZGVzIGFuZCBkb2Vzbid0IG5lZWQgdG8NCj4ga25vdyBhYm91dCBpdHMgaW50
ZXJuYWxzLg0KW1NhaSBQYXZhbiBCb2RkdV0gWWVzLCB4aGNpIHJlZ2lzdGVycyBjYW4gYmUgbWFw
cGVkIGludGVybmFsbHkuIFdlIGNhbiBtYWtlIHRob3NlIGNoYW5nZXMuDQoNClJlZ2FyZHMsDQpT
YWkgUGF2YW4NCj4gDQo+IA0KPiB0aGFua3MNCj4gLS0gUE1NDQo=

