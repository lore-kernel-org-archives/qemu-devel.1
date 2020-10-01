Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AED9C47423
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 18:31:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74C1D20796
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 18:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="op9lF5ic"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74C1D20796
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO3ME-0007LW-FI
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 14:31:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43442)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>) id 1kO34V-0006Xa-US
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 14:12:52 -0400
Received: from mail-bn8nam12on2087.outbound.protection.outlook.com
 ([40.107.237.87]:39009 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>) id 1kO34T-0001gX-1v
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 14:12:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KmoYg20TTCQd6zB4L3p2mPTDcNRoTWSvyMrIk43BPoi7EKT4vCWG4ggfdxRRJg0VD/V8GUjyF4eLVLAxdiZrBdC55qSvovmStXFLsijQjZEAISPOEwWApSI9ZzULjvrMOQ3KcRTvWdv0I8qz7icYEwmlKJSQDG0gFV410XT3xbfz64EcWBImgolGErrHwLSYUckk+C1A/nwkikaoHfHKgkk8IoyoTS0j1QLX+i7ORszpaibZjogck2Ed098lOaophExiha1zKnbwiclOYlaxXGwaVODfc3e6g5NA4gmUkgAi3WZkicsYhtq+icOKNKMtrApMiGQ8keW4rmWN6zRagg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXCS4AmlO5BIQXB3c7kB8VO4iyZObGxNXDmaLKKnLW0=;
 b=STXCXcIoktZCjEEO1z1uM0ooXPiKYGQAGs4udNVW2PMTURCqRRh8Aa3cSnBzSPuZSPKXQ56EdSmbr+aEJVnK0b87Dmm9PKbwxr1ibwxCRboV8C0qTaDy3eIltW7cd/jRNOwifSWuuF1/3nDJX6KfIslG6cw8UARYrrzXx4vj+9hNg6Hcu6k3QeO+RbogZOTwj0XiW4fWXhRFJaHY7nOWbWG3dZVxRdF+1+Sc4GKfIyKxesl8pgpzB7b3KL+yk0B+YEH7OVXvQtDa6C9mDxiF7f7FTTuPAhsveo/+mDi/rnjfWcbqnQ1WPcXTOUQFGBxWuFFKC4ScnczXjUlsLpPCmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXCS4AmlO5BIQXB3c7kB8VO4iyZObGxNXDmaLKKnLW0=;
 b=op9lF5icOghNm7X3gnZinNMl6lBEjkn4RfM9OZ+DYzUFB91hRZns2IUEcmu02USVnBzx1jAPnl5LfThltG4o3ylLNyxJg7pNxe3sHxQN6Isu9pt4nUiAJZ5kKpO9oR+j/Ty3VYCvO0/DrO60h2X1KacojoiDYDsT0cu7nei7h44=
Received: from BYAPR02MB4823.namprd02.prod.outlook.com (2603:10b6:a03:4e::18)
 by BYAPR02MB5543.namprd02.prod.outlook.com (2603:10b6:a03:9f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Thu, 1 Oct
 2020 17:57:44 +0000
Received: from BYAPR02MB4823.namprd02.prod.outlook.com
 ([fe80::a59a:bb96:8fb:69c4]) by BYAPR02MB4823.namprd02.prod.outlook.com
 ([fe80::a59a:bb96:8fb:69c4%3]) with mapi id 15.20.3412.029; Thu, 1 Oct 2020
 17:57:44 +0000
From: Vikram Garhwal <fnuv@xilinx.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: RE: [PATCH v9 0/4] Introduce Xilinx ZynqMP CAN controller
Thread-Topic: [PATCH v9 0/4] Introduce Xilinx ZynqMP CAN controller
Thread-Index: AQHWcQncmpoRUQzgOUGLpGmAPF6xzqloUHaAgAAetYCAAAYwAIAa4I2Q
Date: Thu, 1 Oct 2020 17:57:43 +0000
Message-ID: <BYAPR02MB4823111774CAC3DA1577EF17BC300@BYAPR02MB4823.namprd02.prod.outlook.com>
References: <1597278668-339715-1-git-send-email-fnu.vikram@xilinx.com>
 <CAFEAcA8gYXDJKMS3nUSW96hhwmC37=QX1EhVfWj7j0smKGvXgA@mail.gmail.com>
 <CAFEAcA-Y8GQXSU6F3-AWcW=5VcWOtT0w_Fi4SAbfT2M2zjxB1Q@mail.gmail.com>
 <20200914222838.GA75143@xilinx.com>
In-Reply-To: <20200914222838.GA75143@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [73.158.204.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8eb43aeb-0b73-472d-5ec4-08d866337f86
x-ms-traffictypediagnostic: BYAPR02MB5543:
x-microsoft-antispam-prvs: <BYAPR02MB554382E33FC2375A5FC1DB0ABC300@BYAPR02MB5543.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E8AQ3mUH1HVViskBrBdb8LYTNWnGPuJlZNF3mdKJ4GGgSQGXHbXUitZMhkLNZVweRrfX15jKFXHqu/361E/EDfDMRs7qB/YN+X3EweRntjQlCjQitRKOUteVEG7opUmA0ZlEMjTpkMDw2tYwDkWrKNLi2nh6HdlxZbiraQp916J1pMHW/da3aCmYZV+bzq8x5h8oS6747jtK11kALVw8oglTSWoL1UMErE6dZ3EHLA6k0r28jQdoys+KBGlRp0+ghKSPftYR7PdlhIZD2UrvgQ0r8+V7+usn6cSWBhHusyPHw7pu7cha/ljNmH0oRJpwcSM9ulsz5bajbUcEHJUJR6sAFkT0P7I2YRzYR+H54c0Wkp6MfvFt8ZxNz4pfaGZGufA1+qubQkt8/j7RSvZGFg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4823.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(346002)(39860400002)(366004)(376002)(396003)(136003)(5660300002)(6916009)(52536014)(64756008)(9686003)(186003)(83080400001)(2906002)(33656002)(8936002)(7696005)(316002)(478600001)(4326008)(8676002)(53546011)(66446008)(66946007)(83380400001)(66476007)(66556008)(26005)(71200400001)(76116006)(86362001)(55016002)(966005)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: eKHPA++/EOSyc4GDMgikXHtgBBaK9Ag9kyBQp5b9/ZYnATOEtAk4XdpyS7nHY8+0l3DvZcRN4dhzg4bnbdQm9A9c9DA1qySafnYkWJ5JzWVJQi4up6kMm9/xda+ab5Y/Fw1eDCKnvVJPzrG6YGqDj2HAd4LxnWNwaU1POYDRAYlsaCowYSufZf553zzmkYS1u9xXFdmoy0s8a6F09jyaXjXt6oQtS1wCj0JYFe78nAA2Fp7mU3tSzjdkzoK2kPNP5UUH68IEpzaqOey2nfrWsJL/3zoxlh5mWvJdlL4PyUTth/eR1ug8FDzz3VpGA5Q0qp0/k2oGib+tLsOcgdsSkmJ7j2yQB0A6GqqnDUL3AwwWecw7IrOYoLboBr1sovZXA/7gNbZ0PwCgXtMgyC0eDkk5M0QG1tmJszz67Y+70kguBIODCx0BoBSrKDu0IXtfMQIG7bHtRuwNMLwS6NG+5BryUiITMSimKzZ2rbSIQQNStRUlPRncmHPGc91ae9QjYFr6i/tRhg1PqwVeFckj7GdLZuF1RY9wARpiWasOtrFfA1TWpEeFicgd/t4UebuL0ABvtsLgFyUsdqjQDYYTeV5FaBhDh2f5Qi9L7le6xnieRviYaktkVdrDgUAJSML/cr+j6db+vRSes6U09t2Nqw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4823.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eb43aeb-0b73-472d-5ec4-08d866337f86
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2020 17:57:43.9924 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: scG69McVvzkXIngdJ0rxQfgHiRLTcpQMW1wvRAgegfIWX/dg4nH+RUsOo3Wz6d9Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5543
Received-SPF: pass client-ip=40.107.237.87; envelope-from=fnuv@xilinx.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 14:12:47
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkgUGV0ZXIsDQpJIHNlbnQgcmViYXNlZCBWMTAgc2VyaWVzIHRocmVlIHdlZWtzIGJhY2sgYXMg
dGhlcmUgd2VyZSBzb21lIGlzc3VlcyB3aXRoIG1lc29uIGJ1aWxkIG9uIHY5LiBXb3VsZCBpdCBw
b3NzaWJsZSBmb3IgeW91IHRvIGFwcGx5IHRoZSBwYXRjaCBzZXJpZXM/DQoNCkxpbmsgZm9yIHNl
cmllczogaHR0cHM6Ly9wYXRjaGV3Lm9yZy9RRU1VLzE2MDAxMjEzMjQtMzEzMzctMS1naXQtc2Vu
ZC1lbWFpbC1mbnUudmlrcmFtQHhpbGlueC5jb20vDQoNClJlZ2FyZHMsDQpWaWtyYW0NCg0KPiAt
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBWaWtyYW0gR2FyaHdhbCA8Zm51LnZp
a3JhbUB4aWxpbnguY29tPg0KPiBTZW50OiBNb25kYXksIFNlcHRlbWJlciAxNCwgMjAyMCAzOjI5
IFBNDQo+IFRvOiBQZXRlciBNYXlkZWxsIDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+DQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggdjkgMC80XSBJbnRyb2R1Y2UgWGlsaW54IFp5bnFNUCBDQU4gY29u
dHJvbGxlcg0KPiANCj4gSGkgUGV0ZXIsDQo+IEkganVzdCBzZW50IHRoZSB2MTAgc2VyaWVzIHdo
aWNoIGlzIHJlYmFzZWQgd2l0aCBsYXRlc3QgbWFzdGVyIGJyYW5jaA0KPiBjaGFuZ2VzLg0KPiAN
Cj4gVGhhbmtzIGFnYWluIGZvciB0aGUgaGVscC4NCj4gDQo+IFJlZ2FyZHMsDQo+IFZpa3JhbQ0K
PiANCj4gT24gTW9uLCBTZXAgMTQsIDIwMjAgYXQgMDQ6MDY6MjlQTSArMDEwMCwgUGV0ZXIgTWF5
ZGVsbCB3cm90ZToNCj4gPiBPbiBNb24sIDE0IFNlcCAyMDIwIGF0IDE0OjE2LCBQZXRlciBNYXlk
ZWxsDQo+IDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+IHdyb3RlOg0KPiA+ID4NCj4gPiA+IE9u
IFRodSwgMTMgQXVnIDIwMjAgYXQgMDE6MzMsIFZpa3JhbSBHYXJod2FsDQo+IDxmbnUudmlrcmFt
QHhpbGlueC5jb20+IHdyb3RlOg0KPiA+ID4gPiBWaWtyYW0gR2FyaHdhbCAoNCk6DQo+ID4gPiA+
ICAgaHcvbmV0L2NhbjogSW50cm9kdWNlIFhpbGlueCBaeW5xTVAgQ0FOIGNvbnRyb2xsZXINCj4g
PiA+ID4gICB4bG54LXp5bnFtcDogQ29ubmVjdCBYaWxpbnggWnlucU1QIENBTiBjb250cm9sbGVy
cw0KPiA+ID4gPiAgIHRlc3RzL3F0ZXN0OiBJbnRyb2R1Y2UgdGVzdHMgZm9yIFhpbGlueCBaeW5x
TVAgQ0FOIGNvbnRyb2xsZXINCj4gPiA+ID4gICBNQUlOVEFJTkVSUzogQWRkIG1haW50YWluZXIg
ZW50cnkgZm9yIFhpbGlueCBaeW5xTVAgQ0FODQo+ID4gPiA+IGNvbnRyb2xsZXINCj4gPiA+DQo+
ID4gPiBBcHBsaWVkIHRvIHRhcmdldC1hcm0ubmV4dCwgdGhhbmtzLiAoSSBoYWQgdG8gbWFrZSBz
b21lIG1pbm9yIGZpeHVwcw0KPiA+ID4gdG8gY29udmVydCB0aGUgbWFrZWZpbGUgY2hhbmdlcyB0
byB0aGUgbmV3IG1lc29uIGJ1aWxkIHN5c3RlbS4pDQo+ID4NCj4gPiBJIGhhZCB0byBkcm9wIHRo
ZXNlIHBhdGNoZXMgYmVjYXVzZSBpbiB0aGUgZnVsbCBtZXJnZSBidWlsZCB0ZXN0DQo+ID4gY29u
ZmlncyB0aGV5IGZhaWxlZCB0byBsaW5rIGJlY2F1c2Ugbm90aGluZyB3YXMgcHVsbGluZyBpbiB0
aGUgZ2VuZXJpYw0KPiA+IENPTkZJR19DQU5fQlVTIGZpbGVzLg0KPiA+DQo+ID4gQ291bGQgeW91
IHJlYmFzZSB0aGlzLCBtYWtlIHRoZSBuZWNlc3NhcnkgY2hhbmdlcyB0byBnZXQgaXQgdG8gd29y
aw0KPiA+IHdpdGggbWVzb25bKl0sIGFuZCBhbHNvIG1ha2Ugd2hhdGV2ZXIgS2NvbmZpZyBjaGFu
Z2VzIGFyZSBuZWNlc3Nhcnkgc28NCj4gPiB0aGF0IHRoZSBaeW5xTVAgQ0FOIGNvbnRyb2xsZXIg
ZGV2aWNlIGRlY2xhcmVzIGl0cyBkZXBlbmRlbmN5IG9uIHRoZQ0KPiA+IGdlbmVyaWMgQ09ORklH
X0NBTl9CVVMgY29kZSwgcGxlYXNlPw0KPiA+DQo+ID4gWypdIHlvdSBtaWdodCB3YW50IHRvIGxv
b2sgYXQgdGhlIHZlcnNpb25zIG9mIHRoZSBwYXRjaGVzIEkganVzdCBzZW50DQo+ID4gb3V0IGlu
IG15IHYxIHB1bGxyZXEgdG9kYXksIGJ1dCBiYXNpY2FsbHkgaW5zdGVhZCBvZiB0aGUNCj4gPiBN
YWtlZmlsZS5pbmNsdWRlIGNoYW5nZXMgeW91IHdhbnQgc29tZSBzaW1wbGUgb25lLWxpbmVyIGNo
YW5nZXMgdG8NCj4gPiBtZXNvbi5idWlsZCBmaWxlcywgYW5kIGFsc28gdGVzdHMvcXRlc3QveGxu
eC1jYW4tdGVzdC5jIG5lZWRzIHRvDQo+ID4gI2luY2x1ZGUgImxpYnFvcy9saWJxdGVzdC5oIg0K
PiA+IHJhdGhlciB0aGFuIGp1c3QgImxpYnF0ZXN0LmgiLg0KPiA+DQo+ID4gdGhhbmtzDQo+ID4g
LS0gUE1NDQo=

