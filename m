Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F29C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 13:41:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4414420773
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 13:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="UQjI8Rls"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4414420773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDT0y-0003yn-EK
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 09:41:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kDSzk-0002G3-LF; Wed, 02 Sep 2020 09:40:12 -0400
Received: from mail-dm6nam10on2059.outbound.protection.outlook.com
 ([40.107.93.59]:59981 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kDSze-00041e-AM; Wed, 02 Sep 2020 09:40:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=khIs61aizZqw0cSUy8TXLwtcG/y2cZZysgEnzthrOlqBJKrnac41x0AJkpQ2XJ3HWKrepdjPm+0uls4BxHPgJvkQDaynIxr5mj0IFg6i4EyQAUp9cQHQsDdt66CerVCree83KgfgJLfYxD/24/JPdOvK/7lYIbOCjb4e+TbmfALfbWf30eP+3UNi/iE0+x1Cm/EGN8NoYPEM6ZCeepqrMOzjSfWe3ODQDpmPcxjP/KWlAmn78Udkw36Hlln5trsHpJePnnpOqqnd0JcfPneTyBOwYNbWEd0fo8YBKppFNg9sMzy8Cey5PjocehhhqPO/SI6mBhhcSxtt/XKEL8RQVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7khyvsP3/gVXjtkW0D1l3MNoFEMMrHUet+L72/UaTpQ=;
 b=UNiU2ukxvryXn+U/CVXet2MjJ/ZQn+GnyHs+RISghFQFGXV01jgoQTbfjYie8ouK+2A7++toZ3cgD+6IZ06UL8pG2E7zTIZcv4vpuFBDvT0ANUagqNG69zbmmJQCavFSBLHEuwZg+qRAL1pQbGZ87+8YCNWpeP9nBY5a8ZEJ/VU/8V1LERz6Cb+xpvRLTM1okm86fqJfbhxXB7O5ZVpaAThNRcB3CAtSfyOR2UpdXGSOJeMglt2WgCkbT9ztJ3pKoJFgUhyG/dIGqF5OBFGi7atAR2BqfbzN6D6DHPzLxgpiEk/+3/utF30fLnG0p/QdB3AUxTAhWMUcWQUmd7PIbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7khyvsP3/gVXjtkW0D1l3MNoFEMMrHUet+L72/UaTpQ=;
 b=UQjI8RlsPilG+qmYdEQIjIxyPq8NYvwVQpNBSnpQ+wtJkRT3W/vpavI4J4lfqGjY3hTLlGu23CbU/D7b7ksD8qKlMsMzAgxLdFviUqX67UykECJD1Zi7mj1UJ0TVoQ5uTHX1yRnPEr38W+BptCojKXiM/35nct5+/t061dLAV/c=
Received: from BY5PR02MB6772.namprd02.prod.outlook.com (2603:10b6:a03:206::11)
 by BYAPR02MB4999.namprd02.prod.outlook.com (2603:10b6:a03:6f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Wed, 2 Sep
 2020 13:40:02 +0000
Received: from BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::1007:f094:45c9:bb47]) by BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::1007:f094:45c9:bb47%8]) with mapi id 15.20.3326.025; Wed, 2 Sep 2020
 13:40:02 +0000
From: Sai Pavan Boddu <saipava@xilinx.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: RE: [PATCH] target/arm: Configure number of pmu counters
Thread-Topic: [PATCH] target/arm: Configure number of pmu counters
Thread-Index: AQHWf4xauq7t1XzrdE+wOSGRb8xnoqlTvTaAgAGgXXA=
Date: Wed, 2 Sep 2020 13:40:02 +0000
Message-ID: <BY5PR02MB6772451F40327463AFAEC51CCA2F0@BY5PR02MB6772.namprd02.prod.outlook.com>
References: <1598874522-5186-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <CAFEAcA_GvSnK0LSxyT0jsFz2yRufrg+Zjs=h7XJtJSp4dGzquw@mail.gmail.com>
In-Reply-To: <CAFEAcA_GvSnK0LSxyT0jsFz2yRufrg+Zjs=h7XJtJSp4dGzquw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 459ed466-e3a1-4416-6e00-08d84f45b17c
x-ms-traffictypediagnostic: BYAPR02MB4999:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB4999847978633554FA64F281CA2F0@BYAPR02MB4999.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xF5jpKc63VSbIWuCtOHSiIY3/d171JRrYwmvVJwhlNGEJjz+9Uuah9Si3KfWtB8XgjZdl+KqFKqH1pAHbHH5Pc8rE/ApzLj/nAl6WXy11ZxBjdXkFCBB1GfGWKS0rBnvf00qEUmGlt8Bx3NUn2D+o67f/lC4rsIjZrUypaozXzqm4QXA8kk+2sJXDKgvm7TGje+YkBQcozXblKyycKdKL5GfIlo2HHQsp+ua4E2EpoGtN5O8ijK2EfnuNRObOlEz4B8yB/BWxJIBJnmvnpB89ypM850J3Ldr3Lh/H2FKmVgGhAPJ9wHXxhjxakw/sGqchWp7Hro6KyulK33aQkRYPw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6772.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(39860400002)(396003)(366004)(346002)(376002)(136003)(54906003)(316002)(53546011)(186003)(26005)(66556008)(66476007)(33656002)(6506007)(9686003)(66574015)(4326008)(478600001)(66946007)(64756008)(66446008)(83380400001)(55016002)(7696005)(76116006)(5660300002)(2906002)(71200400001)(6916009)(52536014)(8676002)(8936002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: WPSAjo/6wjEA/O03zbD4aCmWFxCyj82KTQynRjJcg1B+qP3XQJvZQDqCgzLyFwYECgHcSnZ7pw6AIc33dml2XjiExEMRX4AR/D259T6zq9iChB5v1CLeHmwteNLjtialzpdbxY5iUBJbm7GnGzao3Ngzn8Fex3yygZvnjZXGi4raXhUTFH5VJ5OtQtYQGz5VrMlfA4N3mBc+FLS2Tel97THxwtcbhihdF6duEfR0UZgRECKeYR5wCxacDwgglCMWvdt73vDEDq0d3QL3sVJ18XTOKjVjoTInIRT2Pj4aBAuYrWqww1wJvadaoTldb1D5WWe6fzW+H3TXNoFwu0RPsVldrKTcBCNDiaNUA2PlUzATWYVTiEcIXqK/opPzgYcAdYAQtWwk+ZAWntOFbTmoU9FfE4pfEUqduDBS6oc8ZgYX+ykvSm+uJelSEPXXCQt3LEjgqqaDrBp+/vFJENdzqHKNBBV9RZQrs0WsQOz9S0GFJb99sYUcioPm+znpO5WocM+9PjiAoTEx7Mph33vmpsI+8r1z+okaGl3ENvZ4Qhs5PxpEqwW+SYStIhU40bx9G8aXCLY3EtEm2PehmFRI65oBR9byf3sYqmagjhmQI7q/EpSsoaCEyt/jOO21bHz239PhlvkqIOZJcNffLv0wRA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6772.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 459ed466-e3a1-4416-6e00-08d84f45b17c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2020 13:40:02.0451 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mUC9+bcFHROu6QEcrEZj7GGVlCiH0ZuCxlHpji+J9Nf15LklnJr8ZCMyRddx25sEn5oAysVIDJ1WqN7LyBLoIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4999
Received-SPF: pass client-ip=40.107.93.59; envelope-from=saipava@xilinx.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 09:40:03
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
Cc: Andrew Jones <drjones@redhat.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Eric Auger <eric.auger@redhat.com>,
 Edgar Iglesias <edgari@xilinx.com>, qemu-arm <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkgUGV0ZXIsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGV0ZXIg
TWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBTZXB0
ZW1iZXIgMSwgMjAyMCA2OjE4IFBNDQo+IFRvOiBTYWkgUGF2YW4gQm9kZHUgPHNhaXBhdmFAeGls
aW54LmNvbT4NCj4gQ2M6IFJpY2hhcmQgSGVuZGVyc29uIDxyaWNoYXJkLmhlbmRlcnNvbkBsaW5h
cm8ub3JnPjsgUGhpbGlwcGUgTWF0aGlldS0NCj4gRGF1ZMOpIDxwaGlsbWRAcmVkaGF0LmNvbT47
IEFuZHJldyBKb25lcyA8ZHJqb25lc0ByZWRoYXQuY29tPjsgUGFvbG8NCj4gQm9uemluaSA8cGJv
bnppbmlAcmVkaGF0LmNvbT47IEFsZXggQmVubsOpZSA8YWxleC5iZW5uZWVAbGluYXJvLm9yZz47
DQo+IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT47IEVkZ2FyIElnbGVzaWFzIDxl
ZGdhcmlAeGlsaW54LmNvbT47DQo+IHFlbXUtYXJtIDxxZW11LWFybUBub25nbnUub3JnPjsgUUVN
VSBEZXZlbG9wZXJzIDxxZW11LQ0KPiBkZXZlbEBub25nbnUub3JnPg0KPiBTdWJqZWN0OiBSZTog
W1BBVENIXSB0YXJnZXQvYXJtOiBDb25maWd1cmUgbnVtYmVyIG9mIHBtdSBjb3VudGVycw0KPiAN
Cj4gT24gTW9uLCAzMSBBdWcgMjAyMCBhdCAxMjo0NCwgU2FpIFBhdmFuIEJvZGR1DQo+IDxzYWku
cGF2YW4uYm9kZHVAeGlsaW54LmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBEZWZhdWx0IHRoZSBwbXUg
Y291bnRlcnMgdG8gNCBhbmQgY29uZmlndXJlIGl0IGEgNiBmb3IgYTUzIGNvcmVzLg0KPiA+DQo+
ID4gU2lnbmVkLW9mZi1ieTogU2FpIFBhdmFuIEJvZGR1IDxzYWkucGF2YW4uYm9kZHVAeGlsaW54
LmNvbT4NCj4gPiAtLS0NCj4gPiAgdGFyZ2V0L2FybS9jcHUuYyAgICB8IDMgKysrDQo+ID4gIHRh
cmdldC9hcm0vY3B1LmggICAgfCAzICsrKw0KPiA+ICB0YXJnZXQvYXJtL2NwdTY0LmMgIHwgMSAr
DQo+ID4gIHRhcmdldC9hcm0vaGVscGVyLmMgfCAyICstDQo+ID4gIDQgZmlsZXMgY2hhbmdlZCwg
OCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvdGFy
Z2V0L2FybS9jcHUuYyBiL3RhcmdldC9hcm0vY3B1LmMgaW5kZXgNCj4gPiA2YjM4MmZjLi44MDVh
NjkyIDEwMDY0NA0KPiA+IC0tLSBhL3RhcmdldC9hcm0vY3B1LmMNCj4gPiArKysgYi90YXJnZXQv
YXJtL2NwdS5jDQo+ID4gQEAgLTEwNTEsNiArMTA1MSw5IEBAIHN0YXRpYyB2b2lkIGFybV9jcHVf
aW5pdGZuKE9iamVjdCAqb2JqKQ0KPiA+ICAgICAgY3B1LT5wc2NpX3ZlcnNpb24gPSAxOyAvKiBC
eSBkZWZhdWx0IGFzc3VtZSBQU0NJIHYwLjEgKi8NCj4gPiAgICAgIGNwdS0+a3ZtX3RhcmdldCA9
IFFFTVVfS1ZNX0FSTV9UQVJHRVRfTk9ORTsNCj4gPg0KPiA+ICsgICAgLyogc2V0IG51bWJlciBv
ZiBwbXUgY291bnRlcnMgdG8gNCAqLw0KPiA+ICsgICAgY3B1LT5wbWNybiA9IDQ7DQo+ID4gKw0K
PiA+ICAgICAgaWYgKHRjZ19lbmFibGVkKCkpIHsNCj4gPiAgICAgICAgICBjcHUtPnBzY2lfdmVy
c2lvbiA9IDI7IC8qIFRDRyBpbXBsZW1lbnRzIFBTQ0kgMC4yICovDQo+ID4gICAgICB9DQo+ID4g
ZGlmZiAtLWdpdCBhL3RhcmdldC9hcm0vY3B1LmggYi90YXJnZXQvYXJtL2NwdS5oIGluZGV4DQo+
ID4gYWM4NTdiZC4uM2I0N2JhOCAxMDA2NDQNCj4gPiAtLS0gYS90YXJnZXQvYXJtL2NwdS5oDQo+
ID4gKysrIGIvdGFyZ2V0L2FybS9jcHUuaA0KPiA+IEBAIC04NzksNiArODc5LDkgQEAgc3RydWN0
IEFSTUNQVSB7DQo+ID4gICAgICAgKi8NCj4gPiAgICAgIGludDMyX3QgY29yZV9jb3VudDsNCj4g
Pg0KPiA+ICsgICAgLyogTnVtYmVyIG9mIHBtdSBjb3VudGVycyAqLw0KPiA+ICsgICAgdWludDhf
dCBwbWNybjsNCj4gPiArDQo+ID4gICAgICAvKiBUaGUgaW5zdGFuY2UgaW5pdCBmdW5jdGlvbnMg
Zm9yIGltcGxlbWVudGF0aW9uLXNwZWNpZmljIHN1YmNsYXNzZXMNCj4gPiAgICAgICAqIHNldCB0
aGVzZSBmaWVsZHMgdG8gc3BlY2lmeSB0aGUgaW1wbGVtZW50YXRpb24tZGVwZW5kZW50IHZhbHVl
cyBvZg0KPiA+ICAgICAgICogdmFyaW91cyBjb25zdGFudCByZWdpc3RlcnMgYW5kIHJlc2V0IHZh
bHVlcyBvZiBub24tY29uc3RhbnQNCj4gDQo+IFJhdGhlciB0aGFuIGRvaW5nIHRoaXMsIEkgdGhp
bmsgdGhlIGJldHRlciBhcHByb2FjaCB3b3VsZCBiZSB0byBzd2l0Y2ggdG8NCj4gdHJlYXRpbmcg
UE1DUl9FTDAgYXMgYW4gSUQgcmVnaXN0ZXIgaW4gdGhlIHNhbWUgd2F5IHdlIGRvIGZvciBvdGhl
ciB2YXJpZXMtDQo+IHBlci1DUFUgSUQgcmVnaXN0ZXJzOg0KPiANCj4gICogbmV3IGZpZWxkIHVp
bnQ2NF90IHBtY3JfZWwwIGluIHRoZSBBUk1JU0FSZWdpc3RlcnMgc3ViLXN0cnVjdCBvZiBBUk1D
UFUNCj4gICogZWFjaCBDUFUncyBpbml0Zm4gbmVlZHMgdG8gc2V0IHRoaXMgKHNvcnJ5LCB0aGlz
IGlzIGdvaW5nIHRvIG1lYW4NCj4gICAgYSBmYWlyIGFtb3VudCBvZiBkaWdnaW5nIHRocm91Z2gg
VFJNcyB0byBmaW5kIHRoZSByaWdodCB2YWx1ZXMpDQo+ICAqIGRlZmluZV9wbXVfcmVncygpIGp1
c3QgdXNlcyB0aGUgaXNhci5wbWNyX2VsMCBmaWVsZCBhcyB0aGUgcmVzZXR2YWx1ZQ0KPiAgICBm
b3IgUE1DUl9FTDANCj4gICogZGVmaW5lX3BtdV9yZWdzKCkgbmVlZHMgdG8gdXNlIHBtdV9udW1f
Y291bnRlcnMoKSB0byBnZXQgdGhlIG51bWJlcg0KPiAgICBvZiBjb3VudGVycyBmb3IgaXRzIGxv
b3BzDQo+IA0KPiBTaWRlIG5vdGU6IGxvb2tpbmcgYXQgdGhlIGNvZGUgSSBzZWUgd2UgZG9uJ3Qg
aW1wbGVtZW50IHRoZSBlZmZlY3QgdGhhdA0KPiBNRENSX0VMMi5IUE1OIGhhcyBvbiB0aGlzIHJl
Z2lzdGVyLi4uIChhbmQgcHJvYmFibHkgd2UgZG9uJ3QgaW4gZ2VuZXJhbA0KPiBnZXQgdGhlIEVM
MiBoYW5kbGluZyBvZiB0aGUgUE1VIHJpZ2h0IGluIG90aGVyIHBsYWNlcyB0b28pLg0KW1NhaSBQ
YXZhbiBCb2RkdV0gU3VyZSwgSSB3aWxsIGdldCBiYWNrIG9uIHRoaXMuIEkgbmVlZCB0byB1bmRl
cnN0YW5kIG1vcmUuDQoNClRoYW5rcywNClNhaSBQYXZhbg0KPiANCj4gdGhhbmtzDQo+IC0tIFBN
TQ0K

