Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 501A9C43463
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 10:31:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C57CB20773
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 10:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="iODP+NhS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C57CB20773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKJ6a-0005Qo-Iq
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 06:31:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55896)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kKJ4u-0004qf-Qa
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 06:29:48 -0400
Received: from mail-bn8nam12on2045.outbound.protection.outlook.com
 ([40.107.237.45]:65504 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kKJ4t-0001cU-3L
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 06:29:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PoN14WLxZNKHVb5ajKbi/fWR1txf0aIzq1L+JTGg3Uy5x4i7axOpI5tdiqU1+Qbxh6whgADI7ibQ5bDLP/gXtwJTyceYiaa3fHDMvnU0Zwabq0FWTkzp9jZn7w7NHBMxLAMFSO3EMTstPVwh7fxBUeUdYZvtGBGGJdxfhl3Gjs0MJFg1gBh7RSesAfA2x7TVEzzcKruokG1xPZfUBgRyXYm8vyFVpaCmPfRSZs3WNwu8QygUUl5CJ2SxlyGlKKikTZWOxBwzoLUCmPiHcOhd59Ay8v6HEvS3OzYzT5rKhg/Kzpm1G9YU69UeRuE5FpbCtCROJnEfRYXaelutiLGrCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UsLXZg6B7IDJIKL8yKb0WUuA9LkqUWPQe2W4UfLn+9o=;
 b=XdDP2cam9vZuJHfAq7158mGYd4iSD/KNGJTY+0ywLDzCHr0gSp00/mV1DvLJCw8H2bElOcASSSaIwr2L5ehC1nVi/9X2wJCRcpL3IuwTJf0uSoYuCgfXo/RkSVuM0AomIJxorC8ePD6wSGshgqobQEmXWIEB6yfxo4C5slde8PCRx2h8QWHt1IfZKdmsTKDly3TshGiq0eBuflWaECl9UlgBbb/18Ogtd3eBeNmho8OKYe9ExmB4wIIihHEtK+ywEb8ZC1RNuo9IXFJwFQXNiIwZLlv1TriqoTpPZYPeoGpT90t/StAvWKEk/ipMqbNZgfSiO+xKAv40JcYF8fksRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UsLXZg6B7IDJIKL8yKb0WUuA9LkqUWPQe2W4UfLn+9o=;
 b=iODP+NhSv8LUF7ladngkPZ0x6exgjSBLnhgxQSP3PGo6ty3LCQX+RepwwMS1H+fIg1KKG8Sw4vUf0LkijEjTWQCBWOONHBWSZMTVFpgNrpsk562yE44VHSABlMiPTBl1UKXsVmL8PaXftNiIbrGlynseM8Ltlg2cJRkxSwzQKQI=
Received: from BY5PR02MB6772.namprd02.prod.outlook.com (2603:10b6:a03:206::11)
 by BYAPR02MB4135.namprd02.prod.outlook.com (2603:10b6:a03::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.15; Mon, 21 Sep 2020 10:29:44 +0000
Received: from BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::68a7:8ea6:8731:d69f]) by BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::68a7:8ea6:8731:d69f%6]) with mapi id 15.20.3391.026; Mon, 21 Sep 2020
 10:29:44 +0000
From: Sai Pavan Boddu <saipava@xilinx.com>
To: Joel Stanley <joel@jms.id.au>, =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?=
 <clg@kaod.org>
Subject: RE: eMMC support
Thread-Topic: eMMC support
Thread-Index: AdaMV1egTP30pYAoRjSnbjGpoRC6iAANeBGAAN0oZ7A=
Date: Mon, 21 Sep 2020 10:29:43 +0000
Message-ID: <BY5PR02MB677292568BE17BEFC32E6065CA3A0@BY5PR02MB6772.namprd02.prod.outlook.com>
References: <BY5PR02MB6772761F83EDC56737969C18CA210@BY5PR02MB6772.namprd02.prod.outlook.com>
 <CACPK8XexXLYrwMenkyou0Xkc8Tx+p1SNi7jbFBj6aObAKHcBwQ@mail.gmail.com>
In-Reply-To: <CACPK8XexXLYrwMenkyou0Xkc8Tx+p1SNi7jbFBj6aObAKHcBwQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: jms.id.au; dkim=none (message not signed)
 header.d=none;jms.id.au; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6b08fbcd-49c9-4d5f-6ab9-08d85e1941a7
x-ms-traffictypediagnostic: BYAPR02MB4135:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB4135EEE6CFC6BF0F2E407AF8CA3A0@BYAPR02MB4135.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zqvwftjDu9meoGQ9s0MdkGUAxVnphqnq+KFuLuZ8M7NvZSPWTT+B4OiIFLUbuXkgmO+/SLK2ClGSonwfihh3fgN6iN510n0e/hMJxa5LIFMAEWyXRFZ/ezQ4ZHaVwauJnoJ64+HiEswDh6XH/rcj3rgk04IeiqTzIpVbYRVBSutbbGlXec2olN0OBSLC5361FcikvxELyuvIbbfchNf+8qk84MpRAxTMCswt1/G9NWt/viME9M5C8NHoeo622eFX0FanYRf9V71sZiSKpy7Yj/IRdUDM3L5O65zDjGhyL/DBP68PHOqGhDOqD32lKZPseY0AeTme38hkc2A74oYB5GY2wM7+i/xQvuCnyBI6ZeCkFPLAVzmOrQeEqmntNWlrmLV7dp2lNePObeT+PSf8ug==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6772.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(136003)(39850400004)(366004)(396003)(346002)(376002)(3480700007)(33656002)(9686003)(66574015)(4326008)(55016002)(83380400001)(5660300002)(966005)(478600001)(52536014)(86362001)(76116006)(64756008)(66556008)(66476007)(66946007)(66446008)(71200400001)(316002)(26005)(53546011)(2906002)(54906003)(6506007)(7116003)(110136005)(8676002)(8936002)(186003)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: cZZZpTp0MeMuHzM9BDXVlcmVZSGoHigMlALUd/VM0ffBbuWLVENjfDWro4v8EMMDXC52sbJ5NycOueXLKYeFJvwnPl6/UriPmhib8cJhSRERRE2RjWEj4oyzqQVAwXSDxBgXR8gH2xn4JK3qijp2lq5MP1PNpx5SOjUPdx39FDv6x/BDcREqvNxcEne3xQC8K95rst92Z0JrdGPqosqgKGcYHz0Qe7r3a9VvwD7uAwy3rEVZjo1Iq5QvsF4gXx7icieLvXM+qiU6g8h/FZxCRmKG8RIVBDjd8c9ed41XjVvnyFEhUf2eb/GnpOoi4LFWUBzsiHQr5lCoGyZCjp5hGLGWQf+LsTVI72UDf3JwT4zjkWZOo+GSo/x1+SYeHnL73vZ+d9ZN2tBNfmc+16QWea2wL9qOZjrmP2J9NgT/zJJ1ihkmnUdtWDpg60shz/l1Lxcgymsxdy0EKYoaRMXOC0Ejza0uh4g3vtg183BKYikfrhdJ5JLTyUirB4sK6duL7IViyiBXAwYkakbHqwyFcVEp2EA/yMch3GBuJ9QJyHlKNBA6PjFZpgQcWZ5KFu/AcwD1xPE65vCI6wbcyqnrXmnBXS+3UxfKA7SZY2evpdXZmjOdZvVnv117GNtX44O2Ifegu1i7R3h2pKsTaGC5gw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6772.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b08fbcd-49c9-4d5f-6ab9-08d85e1941a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2020 10:29:44.0125 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RLWz2QTQG6rUUgPTX2Cm9U8o/vY5SJN0j0a3bKE05+LtmXud/j5n9P07Gmj01IFZ/1HqkAsaEkxdqxWnt23Gwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4135
Received-SPF: pass client-ip=40.107.237.45; envelope-from=saipava@xilinx.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 06:29:45
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
Cc: Edgar Iglesias <edgari@xilinx.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkgSm9lbCwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb2VsIFN0
YW5sZXkgPGpvZWxAam1zLmlkLmF1Pg0KPiBTZW50OiBUaHVyc2RheSwgU2VwdGVtYmVyIDE3LCAy
MDIwIDY6MjUgQU0NCj4gVG86IFNhaSBQYXZhbiBCb2RkdSA8c2FpcGF2YUB4aWxpbnguY29tPjsg
Q8OpZHJpYyBMZSBHb2F0ZXINCj4gPGNsZ0BrYW9kLm9yZz4NCj4gQ2M6IFBoaWxpcHBlIE1hdGhp
ZXUtRGF1ZMOpIDxmNGJ1Z0BhbXNhdC5vcmc+OyBFZGdhciBJZ2xlc2lhcw0KPiA8ZWRnYXJpQHhp
bGlueC5jb20+OyBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gU3ViamVjdDogUmU6IGVNTUMgc3Vw
cG9ydA0KPiANCj4gT24gV2VkLCAxNiBTZXAgMjAyMCBhdCAxODozNSwgU2FpIFBhdmFuIEJvZGR1
IDxzYWlwYXZhQHhpbGlueC5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4gSGkgUGhpbGlwcGUsDQo+
ID4NCj4gPg0KPiA+DQo+ID4gV2UgYXJlIGxvb2tpbmcgdG8gYWRkIGVNTUMgc3VwcG9ydCwgSSBz
ZWFyY2hlZCB0aGUgbWFpbGluZyBsaXN0IGFuZCBmb3VuZA0KPiBhIHNlcmllcyBwb3N0ZWQgb24g
ZU1NQyBieSDigJxWaW5jZW50IFBhbGF0aW7igJ0NCj4gPg0KPiA+IGh0dHBzOi8vbGlzdHMuZ251
Lm9yZy9hcmNoaXZlL2h0bWwvcWVtdS1kZXZlbC8yMDExLTA3L21zZzAyODMzLmh0bWwNCj4gDQo+
IEkgd291bGQgYmUgaW50ZXJlc3RlZCBpbiBlbW1jIHN1cHBvcnQgZm9yIHRoZSBhc3BlZWQgbWFj
aGluZXMuIFBsZWFzZSBjYw0KPiBtZSB3aGVuIHlvdSBwb3N0IHBhdGNoZXMuDQo+IA0KPiA+IEkg
d291bGQgbGlrZSB0byBjb25zaWRlciB0aGUgYWJvdmUgd29yayBhbmQgbWl4LXVwIHdpdGggbW9y
ZSBjaGFuZ2VzIHRvDQo+IHN0YXJ0IGFkZGluZyBzdXBwb3J0IGZvciBlTU1DLiBEbyB5b3UgaGF2
ZSBhbnkgc3VnZ2VzdGlvbnMgb24gdGhlDQo+IGFwcHJvYWNoIGZvbGxvd2VkIGluIGFib3ZlIHBh
dGNoZXMgPw0KPiANCj4gVGhlIHBhdGNoZXMgaGFkIG1pbm9yIHJldmlldyBjb21tZW50cywgYnV0
IEkgYXNzdW1lIHRoZSByZWFzb24gdGhleQ0KPiBkaWRuJ3QgZ28gYW55d2hlcmUgaXMgdGhlIGF1
dGhvciBuZXZlciBmb2xsb3dlZCB1cCB3aXRoIGZ1cnRoZXIgcmV2aXNpb25zLiBJDQo+IHdvdWxk
IHN1Z2dlc3QgYXBwbHlpbmcgdGhlbSB0byB0aGUgY3VycmVudCB0cmVlLCBjbGVhbmluZyB1cCBh
bnkgc3R5bGUNCj4gY2hhbmdlcyB0aGF0IGhhdmUgaGFwcGVuZWQgc2luY2UgdGhleSB3ZXJlIHBv
c3RlZCwgYW5kIHJlLXBvc3RpbmcgdGhlbQ0KPiBmb3IgcmV2aWV3Lg0KW1NhaSBQYXZhbiBCb2Rk
dV0gT2sgdGhhbmtzLiBJIHdpbGwgcmUtcG9zdCB0aGUgcGF0Y2hlcyBtaXhpbmcgdXAgd2l0aCBz
b21lIG9mIG91ciB3b3JrLg0KDQpSZWdhcmRzLA0KU2FpIFBhdmFuDQo+IA0KPiBDaGVlcnMsDQo+
IA0KPiBKb2VsDQo+IA0KPiA+DQo+ID4NCj4gPg0KPiA+IE5vdGU6IEhlcmUgaXMgdGhlIGV4aXN0
aW5nIHN1cHBvcnQgYXZhaWxhYmxlIGluIFhpbGlueCBmb3JrLCB3aGljaA0KPiA+IG1pZ2h0IHJl
cXVpcmUgc29tZSB3b3JrDQo+ID4gaHR0cHM6Ly9naXRodWIuY29tL1hpbGlueC9xZW11L2Jsb2Iv
bWFzdGVyL2h3L3NkL3NkLmMNCj4gPg0KPiA+DQo+ID4NCj4gPiBSZWdhcmRzLA0KPiA+IFNhaSBQ
YXZhbg0K

