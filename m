Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3497AC43463
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 10:28:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BC622073A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 10:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="pkIPX71M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BC622073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKJ3K-0004LJ-Af
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 06:28:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55708)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kKJ2a-0003px-07
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 06:27:24 -0400
Received: from mail-bn8nam12on2055.outbound.protection.outlook.com
 ([40.107.237.55]:54796 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kKJ2U-0001SM-DP
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 06:27:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nEwcXKC1RyMfbXipzNs56S6eH4O1Xs/+wwf0qgECe4FaAKArvN5krRPgpaBp2/dgRMYGOWF7Z5t12O1bhj2YpT7IqclSmujSylXeNCdLiFDijS3F6Py3XaynOpaNlDLZt2XbYHGINiLij5mx613uK4dmUDltgOnKeoGwAtn1S2NIss/loGKDbSVc6Q8my+tigB7lCODna9Qs02RLQduhte8DwOKMZ7RLWf1Ezo5WMxpE5+sk60p1zwqPHK1z4WfRQwV3a6tU+pQ3v3krq3MMuP//uvWhVBhU2v/leYv7IDD2kzvbnGizWX6eEt14Dkry1QqaX5Rmsa6niCs/N1l6xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1KOweoriBeGeLVGNGZfC3NHowpge1p5SUtSFYRODMY=;
 b=Gr4698BBh8QAazOjmhOVPqHLSWm0q4hw7824+O9TTMkWt5mMja3P9CDzfuGCgWzcuswVcaOdQba0OIx63L7YoWNYnjGKK/r59oLFEL2aNdJKIJgPME04U5XPbuOefqjspOGL3yCcu38Bxy+M7qGeI58NR71qUFvfRKMKfKmUpDRnUCMuHGGrGLn4bIc0Ihj++YvPqA/C+dY1Pzu+0lwVmE6l6CaP74rXKgjC663jTxuc/XdptSqqM/29E3nstAjzgAroqW6wRV5x3Q838NBJxTYUVlgJDRxMrCc4YlC+h9eGNZbtKrowXpawRBx9lXNeKnVmD4sDMu2CjO/sNvTz6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1KOweoriBeGeLVGNGZfC3NHowpge1p5SUtSFYRODMY=;
 b=pkIPX71M0pZ6/aO2fp3vWfBE/Q2EXJLR3eyavmA4yJavesFLMswwtfWIZnl5j43+SRoFUqY67jaD+/Ey3D2w3vWLnOdsgTmRm5z5xZAghdRDagom51tAf/DgrSjLL0SevERbhgXNGZrGYoR4x6NXOCgAK5XUT0s8SoUntsQkZek=
Received: from BY5PR02MB6772.namprd02.prod.outlook.com (2603:10b6:a03:206::11)
 by BYAPR02MB4135.namprd02.prod.outlook.com (2603:10b6:a03::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.15; Mon, 21 Sep 2020 10:27:14 +0000
Received: from BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::68a7:8ea6:8731:d69f]) by BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::68a7:8ea6:8731:d69f%6]) with mapi id 15.20.3391.026; Mon, 21 Sep 2020
 10:27:14 +0000
From: Sai Pavan Boddu <saipava@xilinx.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Joel Stanley
 <joel@jms.id.au>
Subject: RE: eMMC support
Thread-Topic: eMMC support
Thread-Index: AdaMV1egTP30pYAoRjSnbjGpoRC6iAANeBGAAAuHn4AA0X3XIA==
Date: Mon, 21 Sep 2020 10:27:14 +0000
Message-ID: <BY5PR02MB6772FA2C095B8A76304AA8C0CA3A0@BY5PR02MB6772.namprd02.prod.outlook.com>
References: <BY5PR02MB6772761F83EDC56737969C18CA210@BY5PR02MB6772.namprd02.prod.outlook.com>
 <CACPK8XexXLYrwMenkyou0Xkc8Tx+p1SNi7jbFBj6aObAKHcBwQ@mail.gmail.com>
 <6a30107a-abf1-635b-c96f-af3d63f93bc8@kaod.org>
In-Reply-To: <6a30107a-abf1-635b-c96f-af3d63f93bc8@kaod.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: kaod.org; dkim=none (message not signed)
 header.d=none;kaod.org; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8e15f164-50e4-4a0d-919e-08d85e18e875
x-ms-traffictypediagnostic: BYAPR02MB4135:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB4135BBD71337A41B764FA30BCA3A0@BYAPR02MB4135.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nGh3GayOTd6kyNSBp1/KYojL84tIM5q1DrmhCdKKgPhq/fDX93NAZIyFM4cT2GSefJ1z8q1N8E+Zb+sxZhdM1f8ZD7BEcL9NOSBilkzjIIOlIMQstSiI7m3sG6zK7YmwD55aqC4QtY9PTqDXl/l+ui0oFc6AZyU1hjs3IYkeZuOmvURwgeBJRFsUmsaSnWGSMWWODLoeHIF0eRMOVaLjVb7br+XSpmk0WSwKVpUZl0QycLbf2wmkQtn4KalLvP9HRQNC4x88h7q+lId474YZstc8YZSat2EOcPjmI6SfhcxMV5sR8gGtz6inQAxq9VSlbZtEIqDeUu8Hau2EJ3fy6L1P+nDkkN4BvjGCVl9+uTg+2NO9D1NSifnd3B3lQvTy9PlDzI2Y3/nztlXbzOa0BA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6772.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(136003)(39850400004)(366004)(396003)(346002)(376002)(3480700007)(33656002)(9686003)(4326008)(55016002)(83380400001)(5660300002)(966005)(478600001)(52536014)(86362001)(76116006)(64756008)(66556008)(66476007)(66946007)(66446008)(71200400001)(316002)(26005)(53546011)(2906002)(54906003)(6506007)(7116003)(110136005)(8676002)(8936002)(186003)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: NCf5HiPSH3HRJu0oVRjD0s1SkTYSbQI1aikED5GYDtOafQf8q4tPIdiaLImdzjgxZMLohwpk3/0ggeBcOQDI6IkrQr4+ijvmLWsVzZOUZ8G0swmtUjac67Q4V34qt0iBPZ8kZGyXjzILgmrkfj+36upEgji0GJgT7l0faPWBXPYy/sg6IMI+w7l1KlUn59JeZDLPhr99iaEZyRyfNvKyyKBo5IL+Y8IFw6cdLSpeH9z8K4brHi0MdInv5K8PF53nAAu1GxA8OT4UeRkQ5/0w5qZOQTPJFFHCfLIaJiculaOPjulfj31dBsvHQjMkfhgtwMepHQbzxIagTNrbc7rv8Pn5jEonsc0AB2BcIQoJbfBvY9I3DTEXhtL5FV6BIc9W4LREBGLgFG7RHnLzh/9F9JPctKG0ZNQU4nlTTz02GnFCkOJNcn1tibXC8Y/D5RfI8UorWdlBFt33+UuBsAC01iYD92UX9v8noMwE+h5+y+e4coQav1HK0U0VllXAWATFX8dSQYwJgX4reg/+gHO5eUeKtRjuOxTtxbLl9iB8g+euwLl/jTftI2MMjaUt2HTKzcSG3W7pp0X7/jm69C1eeHC/Kt5rv0YOhqnf8w0MsgRGKsa6AFyQObw9E32ZOelYF7L0R08OcjCdgBZgTOHiVw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6772.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e15f164-50e4-4a0d-919e-08d85e18e875
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2020 10:27:14.3577 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MhU1argE1WLF0bbX7INx6JgXS0RUvjM9ldfHjS7rtaIfhgSUTbkh7dGyya8VDiA6WaxobClwJVE1yUTbhfmXmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4135
Received-SPF: pass client-ip=40.107.237.55; envelope-from=saipava@xilinx.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 06:27:16
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

SGkgQ2VkcmljLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEPDqWRy
aWMgTGUgR29hdGVyIDxjbGdAa2FvZC5vcmc+DQo+IFNlbnQ6IFRodXJzZGF5LCBTZXB0ZW1iZXIg
MTcsIDIwMjAgMTE6NTUgQU0NCj4gVG86IEpvZWwgU3RhbmxleSA8am9lbEBqbXMuaWQuYXU+OyBT
YWkgUGF2YW4gQm9kZHUgPHNhaXBhdmFAeGlsaW54LmNvbT4NCj4gQ2M6IFBoaWxpcHBlIE1hdGhp
ZXUtRGF1ZMOpIDxmNGJ1Z0BhbXNhdC5vcmc+OyBFZGdhciBJZ2xlc2lhcw0KPiA8ZWRnYXJpQHhp
bGlueC5jb20+OyBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gU3ViamVjdDogUmU6IGVNTUMgc3Vw
cG9ydA0KPiANCj4gT24gOS8xNy8yMCAyOjU1IEFNLCBKb2VsIFN0YW5sZXkgd3JvdGU6DQo+ID4g
T24gV2VkLCAxNiBTZXAgMjAyMCBhdCAxODozNSwgU2FpIFBhdmFuIEJvZGR1IDxzYWlwYXZhQHhp
bGlueC5jb20+DQo+IHdyb3RlOg0KPiA+Pg0KPiA+PiBIaSBQaGlsaXBwZSwNCj4gPj4NCj4gPj4N
Cj4gPj4NCj4gPj4gV2UgYXJlIGxvb2tpbmcgdG8gYWRkIGVNTUMgc3VwcG9ydCwgSSBzZWFyY2hl
ZCB0aGUgbWFpbGluZyBsaXN0IGFuZA0KPiBmb3VuZCBhIHNlcmllcyBwb3N0ZWQgb24gZU1NQyBi
eSDigJxWaW5jZW50IFBhbGF0aW7igJ0NCj4gPj4NCj4gPj4gaHR0cHM6Ly9saXN0cy5nbnUub3Jn
L2FyY2hpdmUvaHRtbC9xZW11LWRldmVsLzIwMTEtMDcvbXNnMDI4MzMuaHRtbA0KPiA+DQo+ID4g
SSB3b3VsZCBiZSBpbnRlcmVzdGVkIGluIGVtbWMgc3VwcG9ydCBmb3IgdGhlIGFzcGVlZCBtYWNo
aW5lcy4gUGxlYXNlDQo+ID4gY2MgbWUgd2hlbiB5b3UgcG9zdCBwYXRjaGVzLg0KPiA+DQo+ID4+
IEkgd291bGQgbGlrZSB0byBjb25zaWRlciB0aGUgYWJvdmUgd29yayBhbmQgbWl4LXVwIHdpdGgg
bW9yZSBjaGFuZ2VzIHRvDQo+IHN0YXJ0IGFkZGluZyBzdXBwb3J0IGZvciBlTU1DLiBEbyB5b3Ug
aGF2ZSBhbnkgc3VnZ2VzdGlvbnMgb24gdGhlDQo+IGFwcHJvYWNoIGZvbGxvd2VkIGluIGFib3Zl
IHBhdGNoZXMgPw0KPiA+DQo+ID4gVGhlIHBhdGNoZXMgaGFkIG1pbm9yIHJldmlldyBjb21tZW50
cywgYnV0IEkgYXNzdW1lIHRoZSByZWFzb24gdGhleQ0KPiA+IGRpZG4ndCBnbyBhbnl3aGVyZSBp
cyB0aGUgYXV0aG9yIG5ldmVyIGZvbGxvd2VkIHVwIHdpdGggZnVydGhlcg0KPiA+IHJldmlzaW9u
cy4gSSB3b3VsZCBzdWdnZXN0IGFwcGx5aW5nIHRoZW0gdG8gdGhlIGN1cnJlbnQgdHJlZSwgY2xl
YW5pbmcNCj4gPiB1cCBhbnkgc3R5bGUgY2hhbmdlcyB0aGF0IGhhdmUgaGFwcGVuZWQgc2luY2Ug
dGhleSB3ZXJlIHBvc3RlZCwgYW5kDQo+ID4gcmUtcG9zdGluZyB0aGVtIGZvciByZXZpZXcuDQo+
IA0KPiBJdCBzZWVtcyB3ZSBvbmx5IGNhcmUgYWJvdXQgdGhlc2UgdGhyZWUgcGF0Y2hlcyA6DQo+
IA0KPiAgIGh0dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcGF0Y2gvMTA2NzYyDQo+ICAgaHR0
cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wYXRjaC8xMDY3NjENCj4gICBodHRwczovL3BhdGNo
d29yay5vemxhYnMub3JnL3BhdGNoLzEwNjc2Mw0KW1NhaSBQYXZhbiBCb2RkdV0gWWVhaCwgdGhh
bmtzIGZvciBwb2ludGluZy4gDQo+IA0KPiBJdCBzaG91bGQgbm90IGJlIHRvbyBjb21wbGV4IHRv
IGdldCBzb21ldGhpbmcgZ29pbmcuDQo+ID4+IE5vdGU6IEhlcmUgaXMgdGhlIGV4aXN0aW5nIHN1
cHBvcnQgYXZhaWxhYmxlIGluIFhpbGlueCBmb3JrLCB3aGljaA0KPiA+PiBtaWdodCByZXF1aXJl
IHNvbWUgd29yaw0KPiA+PiBodHRwczovL2dpdGh1Yi5jb20vWGlsaW54L3FlbXUvYmxvYi9tYXN0
ZXIvaHcvc2Qvc2QuYw0KPiANCj4gV2hhdCBhcmUgdGhlIHJlbGV2YW50IHBhdGNoZXMgPw0KW1Nh
aSBQYXZhbiBCb2RkdV0gSSB3b3VsZCBzZW5kIG91dCBhIHNlcmllcyBtZXJnaW5nIGJvdGggdGhl
IHdvcmtzLCB0byBtYWtlIGl0IGVhc3kgZm9yIHJldmlldy4NCg0KVGhhbmtzLA0KU2FpIFBhdmFu
DQo+IA0KPiBUaGFua3MsDQo+IA0KPiBDLg0K

