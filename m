Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF82DC388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 13:01:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0FFC2473A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 13:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="cgaLmqho"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0FFC2473A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXl4r-0006Rl-0r
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 09:01:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39020)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kXl2D-0004sP-3N
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 08:58:37 -0400
Received: from mail-eopbgr760084.outbound.protection.outlook.com
 ([40.107.76.84]:23873 helo=NAM02-CY1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kXl27-0001WA-4P
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 08:58:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nWWG+tv/0MNGxLNgPx7iA2p6Ez3uUUsA1bmX/bGR9zgPL/YEF1M3khtdtkxvPKsUYObvJDzWbFdP0WV7nZh8dCN75n2qNxNKEqUyybbAAXeugJFpF0KVndDiaq5JkFg3cMHsH4LKCaAo0E44AdAuTbAM9BHeKO3+QYeWLyZm1KEBbWUtOAG9ct6ro5xo4p3huWanYDMapx1vTGgJH6G9LUIrkTsSDhpKYigLcJg/b3C44janwX5Yer4yGIHmWFTdhaYMG04UM7uCtYhw8BeY7AGLkHVwgTN+6WziRXEw3T36VSaJyA42ZH46ZGRYxkOiiq2jA9NFDDQkVqX5dtMMXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+PBum84UOFG3lehluT/DH/XGJd4mBkTfBoACGUQx/U=;
 b=BFtF8V4jFnS7c8U64T+JAisRJ/vYm2eSLH/M6xECSRDg4E2/oAUz6Jl+iXq7uQsDmK19dnqZB7UIhx8A1dcZkXriuJdyaUoYaNIUjWHhu/ggbTrfWqht6PiM8DxmI3JJ7+bf0wxayVFZMVW01ZoHV3NgiVxVewerWL8EOc5hXG8xexbrqBYQcRkr8HYjMt9mmpksrQZVRh7RcmVji48S/2353zkr7IlZ+WZyYp/9XqHTQJkyxVQebwZ9JIGv+VU/emDLTMIgkJUNnyMPhF6w3C7BnTbpQTdkcdB8oJmrVJ0xTAdfsJNK0FsEzBtixPiIVShhOgYTPt/mTxMrqMC3YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+PBum84UOFG3lehluT/DH/XGJd4mBkTfBoACGUQx/U=;
 b=cgaLmqho5jBMK/n8EmhgVfWQc0WM0Gx3qYixkaRhiTbBuoUxy3EsI3+oRUDZnAFtudiIbjGWsMplIwPfw0pJQtA58BIp6Gq5ILvRuh1CxiIi2PFWpg8lrtk6cioBg//yZVRGLOqHhSre+Snkh/grp6Y2ZGpCSy6fOl+4NK9G8Ww=
Received: from BY5PR02MB6772.namprd02.prod.outlook.com (2603:10b6:a03:206::11)
 by BY5PR02MB6931.namprd02.prod.outlook.com (2603:10b6:a03:232::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.23; Wed, 28 Oct
 2020 12:58:27 +0000
Received: from BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::75ed:4271:263b:fd15]) by BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::75ed:4271:263b:fd15%3]) with mapi id 15.20.3499.018; Wed, 28 Oct 2020
 12:58:26 +0000
From: Sai Pavan Boddu <saipava@xilinx.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: RE: [PATCH v12 1/3] misc: Add versal-usb2-ctrl-regs module
Thread-Topic: [PATCH v12 1/3] misc: Add versal-usb2-ctrl-regs module
Thread-Index: AQHWqGyCOxCysZDUa0SsRgsa6fcPJqmqEhYAgAATCCCAAt09EA==
Date: Wed, 28 Oct 2020 12:58:26 +0000
Message-ID: <BY5PR02MB677213F5F6D3EE8D980B4B0ECA170@BY5PR02MB6772.namprd02.prod.outlook.com>
References: <1603369056-4168-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1603369056-4168-2-git-send-email-sai.pavan.boddu@xilinx.com>
 <CAFEAcA_UuL=ymba+v1O75EOZqXBopLq_HOEtgZ8vZSyJ3AcF3Q@mail.gmail.com>
 <BY5PR02MB67726DABBD88E12722E48F95CA190@BY5PR02MB6772.namprd02.prod.outlook.com>
In-Reply-To: <BY5PR02MB67726DABBD88E12722E48F95CA190@BY5PR02MB6772.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: abc1df55-bd15-40ef-22dd-08d87b412957
x-ms-traffictypediagnostic: BY5PR02MB6931:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR02MB6931C973DFA1177032B62D86CA170@BY5PR02MB6931.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X4w8ovqSvujJcU47Ot1YXn134NCrecuzxzBWU7ptRnvsIejkDJPUiVDD1oI47MX2mZWoeeZE0hhEAfNiScQJqY3iFGUw/+ZwckvbNK9pwwKLriXHTKGVXaPe2RizVrTvVJyCwOqY/SIcWF4tl2auKcBEXYjqp+IGtYXcHXcmvDbSbmrgBsRGCOmWUnLKE140YxbK49UnVFnYYD6/qWFieS1c6aAsvdW78jCy5qA2Eke8SE29AZe8FrnhcitaDh4zrnpjpTP98iB7wNOMLxb5AqlPj7PPKcb8dKr5+4sAo0tenZ1Z/ZYdiHZsC2zX1wPAHbetkAdLUC8H52jPorfQaA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6772.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(5660300002)(8936002)(76116006)(66946007)(71200400001)(86362001)(7696005)(83380400001)(8676002)(316002)(2906002)(64756008)(55016002)(52536014)(54906003)(26005)(186003)(7416002)(33656002)(66476007)(4326008)(66446008)(53546011)(6506007)(66556008)(478600001)(19627235002)(9686003)(6916009);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: mDjUyAl9J3/gb6qRmMoK2Xou/B0NhO1CF6gA+YVzFPNNbD1rEpNQzwaxi1NO0Ks3qdPyRSWEmAqD2n348u03ReeHATcXR5/zNRj38SHSpre20Syoytf8juytNgvjV4u+R2Z9yU4F88AxpOuPispMbuBj4MppKdHsePtNET1Bb0xMJW8n5M4sMXmG2ZU6g/jBVEQYMyoAqdEPJMRLgnv7+glYw0NY/JIWLU7IULAw/lxtWf3YusX1ngK6inwwYBO+sZF9qrOhmrHlagxWTMxveKReSz5hDyQ9d0QkUjxqx2YXxivVGSF4B2a6iBSm0ZeqIMlEK5iE4DgNIvyJkiCxbuySBAwYa5L5j0VyGkP79v2SYfnJKCQ9kcWvYZ+KU5pgB5BoghKXqoAX1Rvo8MxstrPXT8yrVhgEqmnuAEBcB/mm58QzB2UQfGrE9p6A3+6WK/VRuCHBi5MWnTOUfdGo6OYF3PWDF/uaNHcrIbcrI+JY9+5vc84L62duFPlqDQvXVyspkstcMQ8iMALLjbeny+XtGcVUxGwvWV90hq9ZjzloOeGvP64BJs9H3jbr6WSeJfAtR3QKFfBEU/QWe8f1GPs4j3UtTeeyLh75RvUEo9Wkzt2DOeUVLYOqhNNvv6PJF9aoYj5P+AmV1zy7h3+JYg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6772.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abc1df55-bd15-40ef-22dd-08d87b412957
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2020 12:58:26.7949 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V3ITazb9QBMog0G3lK2l/rjii6xepN+iwb6ByHO3zcS7ZspYlc+d64U7Rq1vfecM3+TiSH2UJvwkDlh2FODoQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6931
Received-SPF: pass client-ip=40.107.76.84; envelope-from=saipava@xilinx.com;
 helo=NAM02-CY1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 08:58:29
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

SGkgUGV0ZXIsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2FpIFBh
dmFuIEJvZGR1DQo+IFNlbnQ6IE1vbmRheSwgT2N0b2JlciAyNiwgMjAyMCAxMDo1OSBQTQ0KPiBU
bzogUGV0ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPg0KPiBDYzogTWFya3Vz
IEFybWJydXN0ZXIgPGFybWJydUByZWRoYXQuY29tPjsgTWFyYy1BbmRyw6kgTHVyZWF1DQo+IDxt
YXJjYW5kcmUubHVyZWF1QHJlZGhhdC5jb20+OyBQYW9sbyBCb256aW5pIDxwYm9uemluaUByZWRo
YXQuY29tPjsNCj4gR2VyZCBIb2ZmbWFubiA8a3JheGVsQHJlZGhhdC5jb20+OyBFZGdhciBJZ2xl
c2lhcyA8ZWRnYXJpQHhpbGlueC5jb20+Ow0KPiBGcmFuY2lzY28gRWR1YXJkbyBJZ2xlc2lhcyA8
ZmlnbGVzaWFAeGlsaW54LmNvbT47IFFFTVUgRGV2ZWxvcGVycyA8cWVtdS0NCj4gZGV2ZWxAbm9u
Z251Lm9yZz47IEFsaXN0YWlyIEZyYW5jaXMgPGFsaXN0YWlyLmZyYW5jaXNAd2RjLmNvbT47IEVk
dWFyZG8NCj4gSGFia29zdCA8ZWhhYmtvc3RAcmVkaGF0LmNvbT47IFlpbmcgRmFuZyA8ZmFuZ3lp
bmcxQGh1YXdlaS5jb20+Ow0KPiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQHJlZGhh
dC5jb20+OyBWaWtyYW0gR2FyaHdhbA0KPiA8Zm51dkB4aWxpbnguY29tPjsgUGF1bCBaaW1tZXJt
YW4gPHBhdWxkemltQGdtYWlsLmNvbT4NCj4gU3ViamVjdDogUkU6IFtQQVRDSCB2MTIgMS8zXSBt
aXNjOiBBZGQgdmVyc2FsLXVzYjItY3RybC1yZWdzIG1vZHVsZQ0KPiANCj4gSGkgUGV0ZXIsDQo+
IA0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogUGV0ZXIgTWF5ZGVs
bCA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPg0KPiA+IFNlbnQ6IE1vbmRheSwgT2N0b2JlciAy
NiwgMjAyMCA5OjMzIFBNDQo+ID4gVG86IFNhaSBQYXZhbiBCb2RkdSA8c2FpcGF2YUB4aWxpbngu
Y29tPg0KPiA+IENjOiBNYXJrdXMgQXJtYnJ1c3RlciA8YXJtYnJ1QHJlZGhhdC5jb20+OyBNYXJj
LUFuZHLDqSBMdXJlYXUNCj4gPiA8bWFyY2FuZHJlLmx1cmVhdUByZWRoYXQuY29tPjsgUGFvbG8g
Qm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT47DQo+ID4gR2VyZCBIb2ZmbWFubiA8a3JheGVs
QHJlZGhhdC5jb20+OyBFZGdhciBJZ2xlc2lhcyA8ZWRnYXJpQHhpbGlueC5jb20+Ow0KPiA+IEZy
YW5jaXNjbyBFZHVhcmRvIElnbGVzaWFzIDxmaWdsZXNpYUB4aWxpbnguY29tPjsgUUVNVSBEZXZl
bG9wZXJzDQo+ID4gPHFlbXUtIGRldmVsQG5vbmdudS5vcmc+OyBBbGlzdGFpciBGcmFuY2lzIDxh
bGlzdGFpci5mcmFuY2lzQHdkYy5jb20+Ow0KPiA+IEVkdWFyZG8gSGFia29zdCA8ZWhhYmtvc3RA
cmVkaGF0LmNvbT47IFlpbmcgRmFuZw0KPiA+IDxmYW5neWluZzFAaHVhd2VpLmNvbT47IFBoaWxp
cHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAcmVkaGF0LmNvbT47DQo+ID4gVmlrcmFtIEdhcmh3
YWwgPGZudXZAeGlsaW54LmNvbT47IFBhdWwgWmltbWVybWFuDQo+IDxwYXVsZHppbUBnbWFpbC5j
b20+Ow0KPiA+IFNhaSBQYXZhbiBCb2RkdSA8c2FpcGF2YUB4aWxpbnguY29tPg0KPiA+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggdjEyIDEvM10gbWlzYzogQWRkIHZlcnNhbC11c2IyLWN0cmwtcmVncyBt
b2R1bGUNCj4gPg0KPiA+IE9uIFRodSwgMjIgT2N0IDIwMjAgYXQgMTM6MTEsIFNhaSBQYXZhbiBC
b2RkdQ0KPiA+IDxzYWkucGF2YW4uYm9kZHVAeGlsaW54LmNvbT4NCj4gPiB3cm90ZToNCj4gPiA+
DQo+ID4gPiBUaGlzIG1vZHVsZSBlbXVsYXRlcyBjb250cm9sIHJlZ2lzdGVycyBvZiB2ZXJzYWwg
dXNiMiBjb250cm9sbGVyLA0KPiA+ID4gdGhpcyBpcyBhZGRlZCBqdXN0IHRvIG1ha2UgZ3Vlc3Qg
aGFwcHkuIEluIGdlbmVyYWwgdGhpcyBtb2R1bGUgd291bGQNCj4gPiA+IGNvbnRyb2wgdGhlIHBo
eS1yZXNldCBzaWduYWwgZnJvbSB1c2IgY29udHJvbGxlciwgZGF0YSBjb2hlcmVuY3kgb2YNCj4g
PiA+IHRoZSB0cmFuc2FjdGlvbnMsIHNpZ25hbHMgdGhlIGhvc3Qgc3lzdGVtIGVycm9ycyByZWNl
aXZlZCBmcm9tIGNvbnRyb2xsZXIuDQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogU2FpIFBh
dmFuIEJvZGR1IDxzYWkucGF2YW4uYm9kZHVAeGlsaW54LmNvbT4NCj4gPiA+IFNpZ25lZC1vZmYt
Ynk6IFZpa3JhbSBHYXJod2FsIDxmbnUudmlrcmFtQHhpbGlueC5jb20+DQo+ID4gPiAtLS0NCj4g
PiA+ICBody9taXNjL21lc29uLmJ1aWxkICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMSAr
DQo+ID4gPiAgaHcvbWlzYy94bG54LXZlcnNhbC11c2IyLWN0cmwtcmVncy5jICAgICAgICAgfCAy
MjkNCj4gPiArKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiA+ICBpbmNsdWRlL2h3L21p
c2MveGxueC12ZXJzYWwtdXNiMi1jdHJsLXJlZ3MuaCB8ICA0NSArKysrKysNCj4gPg0KPiA+IFRo
aXMgc2VlbXMgYSBiaXQgb2RkLiBJZiBpdCdzIGEgVVNCIGRldmljZSAob3IgcGFydCBvZiBhIFVT
Qg0KPiA+IGRldmljZSkgdGhlbiBpdCBzaG91bGQgYmUgdW5kZXIgaHcvdXNiLCBzaG91bGRuJ3Qg
aXQ/DQo+IFtTYWkgUGF2YW4gQm9kZHVdIFRoaXMgaXMgYSB0b3AgbGV2ZWwgd3JhcHBlciBvdmVy
IGhjZC1kd2MzIGRldmljZSwgd2hpY2ggaXMNCj4gc3BlY2lmaWMgdG8gdmVyc2FsIHNvYy4gSXQn
cyBtb3N0bHkgZHVtbXkgd2hpY2ggY29udHJvbHMgdGhlIHBoeS1yZXNldCBhbmQgZG9lcw0KPiBm
cmFtZSBsZW5ndGggYWRqdXN0bWVudHMuIEl0IHdhcyBhZGRlZCBqdXN0IHRvIG1ha2UgZ3Vlc3Qg
aGFwcHksIHRoYXQgaXMgdGhlDQo+IHJlYXNvbiBpdCBoYXMgYmVlbiBhZGRlZCB0byBtaXNjIGRl
dmljZXMuDQo+ID4NCj4gPiA+ICtzdGF0aWMgdm9pZCBpcl9zdGF0dXNfcG9zdHcoUmVnaXN0ZXJJ
bmZvICpyZWcsIHVpbnQ2NF90IHZhbDY0KSB7DQo+ID4gPiArICAgIFZlcnNhbFVzYjJDdHJsUmVn
cyAqcyA9IFhJTElOWF9WRVJTQUxfVVNCMl9DVFJMX1JFR1MocmVnLQ0KPiA+b3BhcXVlKTsNCj4g
PiA+ICsgICAgLyoNCj4gPiA+ICsgICAgICogVE9ETzogVGhpcyBzaG91bGQgYWxzbyBjbGVhciBV
U0JTVFMuSFNFIGZpZWxkIGluIFVTQiBYSENJIHJlZ2lzdGVyLg0KPiA+ID4gKyAgICAgKiBNYXkg
YmUgY29tYmluZSBib3RoIHRoZSBtb2R1bGVzLg0KPiA+ID4gKyAgICAgKi8NCj4gPg0KPiA+IFdo
YXQgZG9lcyB0aGUgaGFyZHdhcmUgZm9yIHRoaXMgbG9vayBsaWtlPyBZb3UndmUgbW9kZWxsZWQg
aXQgYXMgdHdvDQo+ID4gY29tcGxldGVseSBzZXBhcmF0ZSBkZXZpY2VzICh0aGlzIG9uZSBhbmQg
dGhlDQo+ID4gVFlQRV9VU0JfRFdDMykgYnV0IHdvdWxkIGl0IGJlIGNsb3NlciB0byB0aGUgaGFy
ZHdhcmUgc3RydWN0dXJlIHRvDQo+ID4gaGF2ZSBhIHRvcC1sZXZlbCBkZXZpY2Ugd2hpY2ggaGFz
LWEgRFdDMyA/DQo+IFtTYWkgUGF2YW4gQm9kZHVdIFllcywgd2UgY2FuIGxvb2sgYXQgaXQgc3Vj
aCB3YXkuIEJ1dCBhcyBpdHMgc3BlY2lmaWMgdG8gdmVyc2FsDQo+IFNPQywgd2UgaGF2ZSBjcmFm
dGVkIGl0IG91dCBhbmQgc3RpdGNoZWQgdGhlbSBpbiBTT0MgZmlsZS4NCj4gDQo+IFJlZ2FyZHMs
DQo+IFNhaSBQYXZhbg0KW1NhaSBQYXZhbiBCb2RkdV0gSSB3b3VsZCBiZSBzZW5kaW5nIFYxMyB3
aXRob3V0IGRvaW5nIGFueSBjaGFuZ2VzIHdpdGggdGhpcyBwYXRjaCBhbmQgYWRkcmVzc2luZyBv
dGhlciBjb21tZW50cywgUGxlYXNlIHJldmlldyBvdmVyIFYxMy4NCg0KVGhhbmtzLA0KU2FpIFBh
dmFuDQo+ID4NCj4gPiB0aGFua3MNCj4gPiAtLSBQTU0NCg==

