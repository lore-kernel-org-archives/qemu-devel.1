Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2409C433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 15:55:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 537D92074D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 15:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="C1yQxQ0U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 537D92074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEE3H-0001mh-EO
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 11:54:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56254)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgari@xilinx.com>) id 1kEDum-0002eQ-33
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 11:46:13 -0400
Received: from mail-eopbgr770081.outbound.protection.outlook.com
 ([40.107.77.81]:54917 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgari@xilinx.com>) id 1kEDui-0007t7-6k
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 11:46:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MQpPqwPFp6Z+6j+lvrack1R0riLo7oZb1zsbDKrDsJJcLlrHXZuzbpM96hk6FTov4GLdzS2y2YAtXr/v3VusH+vptlcZ92LMCSxW9WWwr2EW160o49Fmt8OriVkBJtpStd5/hCtRx6K6yebzAxpq4IfGlJp96it+NkWNhBYnEw+uLS9IrUeZdT6gxqUtIqlHjkvcelIxDCK//wmGANHkug0fcTKMeICnNtiz/dhwdawXbHw/qRYQxZNqXcxWyuXiPRSZWOlH7EcP9eq59H+ItcGdAsvQYupBF9JIe7cWqo45nXRkLtHMrg3iO9RBsMU6UuwlV5MKoriqVi6hIhKO1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jfXgjNXz2EkMXWVFa9e1WYfIwRvSxNqr/EdtboFfikg=;
 b=E0cmeR2RFeouyp7fSHJcTnx/ibTVhstVLIJEeE/Z93eXDEyNypxG3RvyG1PFvj8sU3kCa4nMsb30s36GVPM5dAFhTH6+1Kuc1w5KVKrBJpGHxG7+qZPv2w6q1DaE67+MZKCr2tC5k3kXRQVG8v2JjVRzyXhzzkIHCE255bo79D4KW/5vx/LyCta9wjV9Ydn9vPNX4XSqG65doAQrsfXyOtyVXmKjgDTZ8fqMqdI6pwrM8UQuw78K3fhlXn5aTHYh8rIM14p8V78flEicn0nqG7uV/vSezMcdx0B2kua+SycmxdUYdTM2nu9DmfRdk2JKXj8iHxisHDtqiyLJ1weeTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jfXgjNXz2EkMXWVFa9e1WYfIwRvSxNqr/EdtboFfikg=;
 b=C1yQxQ0UU4eHv0gfc5AM7cOUjXcpno/3mx4vDbgP+IEFPDRlhVGg6MoErncnxNsz2veiuw6YiHPw8+3uYVg1oI+xqCQkP5ez4JAC+BoLElMAJN4TXJYxRjs0EWNmXdeZyY1oq04OfET7mBORCpGwnGbc7r/25XUNMyxM6MWVF+8=
Received: from BY5PR02MB6628.namprd02.prod.outlook.com (2603:10b6:a03:205::22)
 by BYAPR02MB5366.namprd02.prod.outlook.com (2603:10b6:a03:65::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.21; Fri, 4 Sep
 2020 15:31:01 +0000
Received: from BY5PR02MB6628.namprd02.prod.outlook.com
 ([fe80::a5a7:df24:7414:b761]) by BY5PR02MB6628.namprd02.prod.outlook.com
 ([fe80::a5a7:df24:7414:b761%9]) with mapi id 15.20.3348.017; Fri, 4 Sep 2020
 15:31:01 +0000
From: Edgar Iglesias <edgari@xilinx.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 05/12] target/microblaze: Fill in VMStateDescription
 for cpu
Thread-Topic: [PATCH v2 05/12] target/microblaze: Fill in VMStateDescription
 for cpu
Thread-Index: AQHWgcOeUEbYXINfnEiWW4UAgLEWg6lYm8SmgAABfpM=
Date: Fri, 4 Sep 2020 15:31:01 +0000
Message-ID: <4876c9af-65c7-4df8-a5a8-44c5b8ca7253@xilinx.com>
References: <20200903072650.1360454-1-richard.henderson@linaro.org>
 <20200903072650.1360454-6-richard.henderson@linaro.org>
 <20200904122003.GN14249@toto>,
 <07370a54-846f-9dd9-e6f2-1c9bdf216e3c@linaro.org>
In-Reply-To: <07370a54-846f-9dd9-e6f2-1c9bdf216e3c@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.62.254]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 33c704fe-0162-4d4c-1f9f-08d850e78782
x-ms-traffictypediagnostic: BYAPR02MB5366:
x-microsoft-antispam-prvs: <BYAPR02MB5366A743A95692CAA388E1EAAB2D0@BYAPR02MB5366.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F/FmUQaSBN+6u4u+clqBXx/WPkDa998mYCf+Olp39aqXzt0UUSnBueCKbjervRWD3G56/UVV8ptCub5uOQaLfErWANOz/oTS1N1IzBSrJkAUvCP9VqX99CIyKr5ZOwiYzy/vQh5QiE+3Ttpbp5eUKrOP8rNI1lkrb6Dulsyz1wdghqL8aQCO5F9xr27XuIFsQt80903CZpDImH+aVXivimBdT8bfEYbix1i2Z11D+3YtGNmNsC0CHmI5vNGCkXHAdHX8uWUWFcPuPSbPun5FTC1gmopxGuIGoVDrMcxVnN+r3yqmp2MhCIM/uiAX+HCUEVqjH0cPtCBqZ8hMeKCvXQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6628.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(376002)(346002)(39860400002)(366004)(136003)(396003)(31686004)(8936002)(31696002)(66446008)(64756008)(53546011)(66556008)(186003)(66946007)(83380400001)(6512007)(76116006)(26005)(6506007)(316002)(6486002)(2906002)(54906003)(5660300002)(66476007)(8676002)(478600001)(86362001)(6916009)(71200400001)(4326008)(2616005)(36756003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 4yrtumYQl6ZmOuB/R/f0WCoaO/HnfypRK6lwf886zpZY4En8g0Mg/CAewEhIq0I0F6kpfxOCjzMDkNnDex/FS+yG+gxjh2E8eHT2grQ432fcxKHAmQLkluP9UGoYIB2nlNsX7DBhhabgwPhCS7GMsgWkbILVmmGGLtWsktSpk98kMVLxbeWRnnupPvDAB03hmKVMCVJ+lEXpkQAbtMeeda1EGFbEeZrxHAGWfSMnwEd61zz9S/BjgpbcQAEyy2ZTEOhuJ8XQFt7yGyxQ8+zN75OnSXoC7ggrW6N7AYvNce7BdJBJuHFCVXt0jv6cDnlIaixdEclDDy9lZ6EScI2kaCaUo8SJ0QfC/DqO0bXvGKv4lnbThab4tu6Zrou3+7AVdXwQV7kqPCVUmrBGhzQS0lz4UKP4WUtuWK1KOPTDIu/V22KuAPNA6v2rGkWTYi9KceKs5a1N6utoWBXx42hc7SlIOmTfrYk+ozLZw6ncJflGuWxNNWBM2qZ8LCIjIylMYDk6zVybXYLpk+G3jcM/bgGENUhU20hJMwEfFh/kYh/5Xx95XUDxw9a1BMYDspLpYoF7AodxM8nu4Nsiyj6GTYkVTHSZvhoC7kzGescONzcNlWw+TVGP/qHycpqu6qQcJZuQP1qUgR4J4XorTshCow==
x-ms-exchange-transport-forked: True
Content-Type: multipart/alternative;
 boundary="_000_4876c9af65c74df8a5a844c5b8ca7253xilinxcom_"
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6628.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33c704fe-0162-4d4c-1f9f-08d850e78782
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2020 15:31:01.2600 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +bz3XkOwp0IrCrZv1y6AYBuw8oczXKnZRS9ibu4kFT9pxNUbMQyRGYAK7HgnmRzjVYFPilacJukKwi+jZxqvXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5366
Received-SPF: pass client-ip=40.107.77.81; envelope-from=edgari@xilinx.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 11:46:06
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "thuth@redhat.com" <thuth@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "f4bug@amsat.org" <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_4876c9af65c74df8a5a844c5b8ca7253xilinxcom_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

DQpPbiA0IFNlcCAyMDIwIDE3OjI1LCBSaWNoYXJkIEhlbmRlcnNvbiA8cmljaGFyZC5oZW5kZXJz
b25AbGluYXJvLm9yZz4gd3JvdGU6DQo+DQo+IE9uIDkvNC8yMCA1OjIwIEFNLCBFZGdhciBFLiBJ
Z2xlc2lhcyB3cm90ZToNCj4gPj4gK3N0YXRpYyBWTVN0YXRlRmllbGQgdm1zdGF0ZV9tbXVfZmll
bGRzW10gPSB7DQo+ID4+ICsgICAgVk1TVEFURV9VSU5UNjRfMkRBUlJBWShyYW1zLCBNaWNyb0Js
YXplTU1VLCAyLCBUTEJfRU5UUklFUyksDQo+ID4+ICsgICAgVk1TVEFURV9VSU5UOF9BUlJBWSh0
aWRzLCBNaWNyb0JsYXplTU1VLCBUTEJfRU5UUklFUyksDQo+ID4+ICsgICAgVk1TVEFURV9VSU5U
MzJfQVJSQVkocmVncywgTWljcm9CbGF6ZU1NVSwgMyksDQo+ID4+ICsgICAgVk1TVEFURV9JTlQz
MihjX21tdSwgTWljcm9CbGF6ZU1NVSksDQo+ID4+ICsgICAgVk1TVEFURV9JTlQzMihjX21tdV90
bGJfYWNjZXNzLCBNaWNyb0JsYXplTU1VKSwNCj4gPj4gKyAgICBWTVNUQVRFX0lOVDMyKGNfbW11
X3pvbmVzLCBNaWNyb0JsYXplTU1VKSwNCj4gPj4gKyAgICBWTVNUQVRFX1VJTlQ2NChjX2FkZHJf
bWFzaywgTWljcm9CbGF6ZU1NVSksDQo+ID4NCj4gPiBUaGVzZSBsYXN0IDQgZW50cmllcyBhcmUg
ZWxhYm9yYXRpb24tdGltZSBzZXR0aW5ncywgaS5lIHRoZXkgd2lsbCBub3QNCj4gPiBjaGFuZ2Ug
ZHVyaW5nIFZNIHJ1bnRpbWUuIEkgZG9uJ3QgdGhpbmsgd2UgbmVlZCB0byB0cmFuc2ZlciB0aGVz
ZSBzaW5jZQ0KPiA+IHdlIGV4cGVjdCB0aGUgcGVlciB0byBzZXR1cCB0aGUgc2FtZSBraW5kIG9m
IG1pY3JvYmxhemU/DQo+DQo+IEFoLCBJIHNlZS4gIFllcywgbWlncmF0aW9uIGlzIG9ubHkgc3Vw
cG9ydGVkIGJldHdlZW4gImxpa2UiIHN5c3RlbXMuDQo+DQo+IFRob3VnaCBpbiB0aGlzIGNhc2Ug
SSB3YXNuJ3QgdGhpbmtpbmcgc28gbXVjaCBvZiBtaWdyYXRpb24gYW5kIHRoZSBvdGhlciB1c2Vz
DQo+IHRvIHdoaWNoIFZNU3RhdGUgZ2V0cyBwdXQsIGxpa2UgcmVjb3JkL3JlcGxheSBhbmQgdGhl
IGZvbGxvdy1vbiBwYXRjaGVzIGZvciBnZGINCj4gcmV2ZXJzZSBkZWJ1Z2dpbmcuDQo+DQo+ID4+
ICsgICAgVk1TVEFURV9VSU5UMzJfQVJSQVkocHZyLnJlZ3MsIENQVU1CU3RhdGUsIDEzKSwNCj4g
Pg0KPiA+IHB2ci5yZWdzIGFyZSBhbHNvIGVsYWJvcmF0aW9uIHRpbWUgc2V0dXAgYW5kIHNob3Vs
ZCBiZSByZWFkLW9ubHkgZHVyaW5nDQo+ID4gdGhlIFZNJ3MgbGlmZXRpbWUuDQo+DQo+IFdoYXQg
ZG8geW91IHRoaW5rIGFib3V0IG1vdmluZyBhbGwgb2YgdGhlc2UgdG8gY3B1LT5jZmcsIHNvIHRo
YXQgYWxsIG9mIHRoZQ0KPiBjb25maWd1cmF0aW9uLXRpbWUgc3R1ZmYgaXMgdG9nZXRoZXI/DQoN
ClRoYXQgd291bGQgYmUgZ3JlYXQsIHRoYW5rcyENCg0KQnR3LCBJIHdhcyBydW5uaW5nIHRlc3Rz
IG9uIHRoaXMgc2VyaWVzIGFuZCBzYXcgc29tZSByZWdyZXNzaW9ucyBidXQgSSd2ZSBnb3Qgb3Ro
ZXIgc3R1ZmYgbW92aW5nIGluIG15IHRyZWUgc28gaXQgbWF5IHZlcnkgd2VsbCBub3QgYmUgcmVs
YXRlZCBidXQgSSdkIGxpa2UgdG8gbWFrZSBzdXJlLiBXaWxsIHByb2JhYmx5IHRha2UgbWUgYSBm
ZXcgZGF5cyB0byBmaWd1cmUgdGhpbmdzIG91dC4uLg0KDQpCZXN0IHJlZ2FyZHMsDQpFZGdhcg0K
DQoNCj4NCj4NCj4gcn4NCj4NCj4NCj4gPg0KPiA+IElmIHlvdSBmaXggdGhvc2UsIHRoaXMgbG9v
a3MgZ29vZCB0byBtZS46DQo+ID4gUmV2aWV3ZWQtYnk6IEVkZ2FyIEUuIElnbGVzaWFzIDxlZGdh
ci5pZ2xlc2lhc0B4aWxpbnguY29tPg0KPiA+DQo+DQoNCg==

--_000_4876c9af65c74df8a5a844c5b8ca7253xilinxcom_
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: base64

PGh0bWw+DQo8aGVhZD4NCjxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIgY29udGVudD0i
dGV4dC9odG1sOyBjaGFyc2V0PXV0Zi04Ij4NCjwvaGVhZD4NCjxib2R5Pg0KPGJyPg0KPGRpdiBk
aXI9Imx0ciI+T24gNCBTZXAgMjAyMCAxNzoyNSwgUmljaGFyZCBIZW5kZXJzb24gJmx0O3JpY2hh
cmQuaGVuZGVyc29uQGxpbmFyby5vcmcmZ3Q7IHdyb3RlOg0KPC9kaXY+DQo8ZGl2IGRpcj0ibHRy
Ij4mZ3Q7PC9kaXY+DQo8ZGl2IGRpcj0ibHRyIj4mZ3Q7IE9uIDkvNC8yMCA1OjIwIEFNLCBFZGdh
ciBFLiBJZ2xlc2lhcyB3cm90ZTogPC9kaXY+DQo8ZGl2IGRpcj0ibHRyIj4mZ3Q7ICZndDsmZ3Q7
ICtzdGF0aWMgVk1TdGF0ZUZpZWxkIHZtc3RhdGVfbW11X2ZpZWxkc1tdID0geyA8L2Rpdj4NCjxk
aXYgZGlyPSJsdHIiPiZndDsgJmd0OyZndDsgKyZuYnNwOyZuYnNwOyZuYnNwOyBWTVNUQVRFX1VJ
TlQ2NF8yREFSUkFZKHJhbXMsIE1pY3JvQmxhemVNTVUsIDIsIFRMQl9FTlRSSUVTKSwNCjwvZGl2
Pg0KPGRpdiBkaXI9Imx0ciI+Jmd0OyAmZ3Q7Jmd0OyArJm5ic3A7Jm5ic3A7Jm5ic3A7IFZNU1RB
VEVfVUlOVDhfQVJSQVkodGlkcywgTWljcm9CbGF6ZU1NVSwgVExCX0VOVFJJRVMpLCA8L2Rpdj4N
CjxkaXYgZGlyPSJsdHIiPiZndDsgJmd0OyZndDsgKyZuYnNwOyZuYnNwOyZuYnNwOyBWTVNUQVRF
X1VJTlQzMl9BUlJBWShyZWdzLCBNaWNyb0JsYXplTU1VLCAzKSwgPC9kaXY+DQo8ZGl2IGRpcj0i
bHRyIj4mZ3Q7ICZndDsmZ3Q7ICsmbmJzcDsmbmJzcDsmbmJzcDsgVk1TVEFURV9JTlQzMihjX21t
dSwgTWljcm9CbGF6ZU1NVSksIDwvZGl2Pg0KPGRpdiBkaXI9Imx0ciI+Jmd0OyAmZ3Q7Jmd0OyAr
Jm5ic3A7Jm5ic3A7Jm5ic3A7IFZNU1RBVEVfSU5UMzIoY19tbXVfdGxiX2FjY2VzcywgTWljcm9C
bGF6ZU1NVSksIDwvZGl2Pg0KPGRpdiBkaXI9Imx0ciI+Jmd0OyAmZ3Q7Jmd0OyArJm5ic3A7Jm5i
c3A7Jm5ic3A7IFZNU1RBVEVfSU5UMzIoY19tbXVfem9uZXMsIE1pY3JvQmxhemVNTVUpLCA8L2Rp
dj4NCjxkaXYgZGlyPSJsdHIiPiZndDsgJmd0OyZndDsgKyZuYnNwOyZuYnNwOyZuYnNwOyBWTVNU
QVRFX1VJTlQ2NChjX2FkZHJfbWFzaywgTWljcm9CbGF6ZU1NVSksIDwvZGl2Pg0KPGRpdiBkaXI9
Imx0ciI+Jmd0OyAmZ3Q7IDwvZGl2Pg0KPGRpdiBkaXI9Imx0ciI+Jmd0OyAmZ3Q7IFRoZXNlIGxh
c3QgNCBlbnRyaWVzIGFyZSBlbGFib3JhdGlvbi10aW1lIHNldHRpbmdzLCBpLmUgdGhleSB3aWxs
IG5vdA0KPC9kaXY+DQo8ZGl2IGRpcj0ibHRyIj4mZ3Q7ICZndDsgY2hhbmdlIGR1cmluZyBWTSBy
dW50aW1lLiBJIGRvbid0IHRoaW5rIHdlIG5lZWQgdG8gdHJhbnNmZXIgdGhlc2Ugc2luY2UNCjwv
ZGl2Pg0KPGRpdiBkaXI9Imx0ciI+Jmd0OyAmZ3Q7IHdlIGV4cGVjdCB0aGUgcGVlciB0byBzZXR1
cCB0aGUgc2FtZSBraW5kIG9mIG1pY3JvYmxhemU/IDwvZGl2Pg0KPGRpdiBkaXI9Imx0ciI+Jmd0
OzwvZGl2Pg0KPGRpdiBkaXI9Imx0ciI+Jmd0OyBBaCwgSSBzZWUuJm5ic3A7IFllcywgbWlncmF0
aW9uIGlzIG9ubHkgc3VwcG9ydGVkIGJldHdlZW4gJnF1b3Q7bGlrZSZxdW90OyBzeXN0ZW1zLg0K
PC9kaXY+DQo8ZGl2IGRpcj0ibHRyIj4mZ3Q7PC9kaXY+DQo8ZGl2IGRpcj0ibHRyIj4mZ3Q7IFRo
b3VnaCBpbiB0aGlzIGNhc2UgSSB3YXNuJ3QgdGhpbmtpbmcgc28gbXVjaCBvZiBtaWdyYXRpb24g
YW5kIHRoZSBvdGhlciB1c2VzDQo8L2Rpdj4NCjxkaXYgZGlyPSJsdHIiPiZndDsgdG8gd2hpY2gg
Vk1TdGF0ZSBnZXRzIHB1dCwgbGlrZSByZWNvcmQvcmVwbGF5IGFuZCB0aGUgZm9sbG93LW9uIHBh
dGNoZXMgZm9yIGdkYg0KPC9kaXY+DQo8ZGl2IGRpcj0ibHRyIj4mZ3Q7IHJldmVyc2UgZGVidWdn
aW5nLiA8L2Rpdj4NCjxkaXYgZGlyPSJsdHIiPiZndDs8L2Rpdj4NCjxkaXYgZGlyPSJsdHIiPiZn
dDsgJmd0OyZndDsgKyZuYnNwOyZuYnNwOyZuYnNwOyBWTVNUQVRFX1VJTlQzMl9BUlJBWShwdnIu
cmVncywgQ1BVTUJTdGF0ZSwgMTMpLCA8L2Rpdj4NCjxkaXYgZGlyPSJsdHIiPiZndDsgJmd0OyA8
L2Rpdj4NCjxkaXYgZGlyPSJsdHIiPiZndDsgJmd0OyBwdnIucmVncyBhcmUgYWxzbyBlbGFib3Jh
dGlvbiB0aW1lIHNldHVwIGFuZCBzaG91bGQgYmUgcmVhZC1vbmx5IGR1cmluZw0KPC9kaXY+DQo8
ZGl2IGRpcj0ibHRyIj4mZ3Q7ICZndDsgdGhlIFZNJ3MgbGlmZXRpbWUuIDwvZGl2Pg0KPGRpdiBk
aXI9Imx0ciI+Jmd0OzwvZGl2Pg0KPGRpdiBkaXI9Imx0ciI+Jmd0OyBXaGF0IGRvIHlvdSB0aGlu
ayBhYm91dCBtb3ZpbmcgYWxsIG9mIHRoZXNlIHRvIGNwdS0mZ3Q7Y2ZnLCBzbyB0aGF0IGFsbCBv
ZiB0aGUNCjwvZGl2Pg0KPGRpdiBkaXI9Imx0ciI+Jmd0OyBjb25maWd1cmF0aW9uLXRpbWUgc3R1
ZmYgaXMgdG9nZXRoZXI/PC9kaXY+DQo8YnI+DQo8ZGl2IGRpcj0ibHRyIj5UaGF0IHdvdWxkIGJl
IGdyZWF0LCB0aGFua3MhIDwvZGl2Pg0KPGJyPg0KPGRpdiBkaXI9Imx0ciI+QnR3LCBJIHdhcyBy
dW5uaW5nIHRlc3RzIG9uIHRoaXMgc2VyaWVzIGFuZCBzYXcgc29tZSByZWdyZXNzaW9ucyBidXQg
SSd2ZSBnb3Qgb3RoZXIgc3R1ZmYgbW92aW5nIGluIG15IHRyZWUgc28gaXQgbWF5IHZlcnkgd2Vs
bCBub3QgYmUgcmVsYXRlZCBidXQgSSdkIGxpa2UgdG8gbWFrZSBzdXJlLiBXaWxsIHByb2JhYmx5
IHRha2UgbWUgYSBmZXcgZGF5cyB0byBmaWd1cmUgdGhpbmdzIG91dC4uLjwvZGl2Pg0KPGJyPg0K
PGRpdiBkaXI9Imx0ciI+QmVzdCByZWdhcmRzLCA8L2Rpdj4NCjxkaXYgZGlyPSJsdHIiPkVkZ2Fy
PC9kaXY+DQo8YnI+DQo8YnI+DQo8ZGl2IGRpcj0ibHRyIj4mZ3Q7PC9kaXY+DQo8ZGl2IGRpcj0i
bHRyIj4mZ3Q7PC9kaXY+DQo8ZGl2IGRpcj0ibHRyIj4mZ3Q7IHJ+IDwvZGl2Pg0KPGRpdiBkaXI9
Imx0ciI+Jmd0OzwvZGl2Pg0KPGRpdiBkaXI9Imx0ciI+Jmd0OzwvZGl2Pg0KPGRpdiBkaXI9Imx0
ciI+Jmd0OyAmZ3Q7IDwvZGl2Pg0KPGRpdiBkaXI9Imx0ciI+Jmd0OyAmZ3Q7IElmIHlvdSBmaXgg
dGhvc2UsIHRoaXMgbG9va3MgZ29vZCB0byBtZS46IDwvZGl2Pg0KPGRpdiBkaXI9Imx0ciI+Jmd0
OyAmZ3Q7IFJldmlld2VkLWJ5OiBFZGdhciBFLiBJZ2xlc2lhcyAmbHQ7ZWRnYXIuaWdsZXNpYXNA
eGlsaW54LmNvbSZndDsgPC9kaXY+DQo8ZGl2IGRpcj0ibHRyIj4mZ3Q7ICZndDsgPC9kaXY+DQo8
ZGl2IGRpcj0ibHRyIj4mZ3Q7PC9kaXY+DQo8YnI+DQo8L2JvZHk+DQo8L2h0bWw+DQo=

--_000_4876c9af65c74df8a5a844c5b8ca7253xilinxcom_--

