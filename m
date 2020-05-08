Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9929CC47247
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 02:56:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66305208CA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 02:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bt.com header.i=@bt.com header.b="lzIWs7De"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66305208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWtBr-0004kh-LR
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 22:56:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50128)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasper.lowell@bt.com>)
 id 1jWtBF-0004Gq-89
 for qemu-devel@nongnu.org; Thu, 07 May 2020 22:56:05 -0400
Received: from smtpe1.intersmtp.com ([213.121.35.78]:36946)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasper.lowell@bt.com>)
 id 1jWtBB-00061m-Fq
 for qemu-devel@nongnu.org; Thu, 07 May 2020 22:56:04 -0400
Received: from tpw09926dag12h.domain1.systemhost.net (10.9.212.36) by
 BWP09926083.bt.com (10.36.82.114) with Microsoft SMTP Server (version=TLS1_2, 
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.1713.5; Fri, 8 May
 2020 03:55:52 +0100
Received: from tpw09926dag06f.domain1.systemhost.net (10.9.202.25) by
 tpw09926dag12h.domain1.systemhost.net (10.9.212.36) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4; Fri, 8 May 2020 03:55:57 +0100
Received: from bwp09926083.bt.com (10.36.82.114) by
 tpw09926dag06f.domain1.systemhost.net (10.9.202.25) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4 via Frontend Transport; Fri, 8 May 2020 03:55:57
 +0100
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (104.47.21.53) by
 smtpe1.intersmtp.com (10.36.82.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.1.1713.5; Fri, 8 May 2020 03:55:50 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S6vARg9ZNXhTxreh/S9AQ9j06BBrbm0gWTREoNguOQwIQhf5BaFR1FF3StzvNB4aX69RqhOisGzEPloTS7W1lXYXvWqRe80JP+BL/aoCvxS3IDLg0YyaCBwJEpNq9o68hXPxSKotCcwDEe6AIgE9K4T1KYRAZxUk+gm7VD++Lp8HpVlqwszcKUOsWEhiLmtTXEigitVEbmf/gqVmOenK/40FfZEccgbCCF9QrM/R+U3hGYZllQYHvIwhLJSCeGmIyGf5tNF2iFreenizhZ2I9kRmASmCUx/m/x1Jt9aukDhxhlOxXHjNcYi6cZhBepJV6qmNE/lK+WmB8aUGFe83Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Huryq8cj0RXKU7/kCbXnm77L1sCLVlBkMXVEogbLSGE=;
 b=M65X651/kRnuXcFH8r35eRDia4sY83DMrWdszzliRke2/ejlSXhzJ5yQOCwwHzZ7+onUbkSOrdI6t8LraaMaj28xeQ2aDJb1ti41PuPar8F1jSGxq3D4+TU1CFg5AgbwfBDtbwI+N2UZHS56OBweavNOc5/1XrH1rEhp412FpQItBIH6lsBa7ifuIea0m710K3v97fuuw5hPU3X2KPw6KVkhreN/AYDiAJ/VSdYQTyDoV0oGT+HVtp6L1NP8RgVAbNUcjmKAaJmewUhPoBeCBZU7kxI/m6ON4Y2bwAeN1C/HhavLhhTg5eejOmcQ3F4ZlVFwbc0KoqoCc9N4mIik+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bt.com; dmarc=pass action=none header.from=bt.com; dkim=pass
 header.d=bt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bt.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Huryq8cj0RXKU7/kCbXnm77L1sCLVlBkMXVEogbLSGE=;
 b=lzIWs7DeUuJgXGWTRDOmcxOvWLm5JRU2LfwctfUMQPulFDQsyrwiUdprxCJgaZUxX4Xo0D5OdUbLQPVaQyVtWaevzJa9vjvIJAJ1X011eq2G44Aw5gAlCSO3iLEF5YZarzRP4zK60Il2lfaztwgOedRTPW2lpPjOn9msjvEHubE=
Received: from CWXP123MB1958.GBRP123.PROD.OUTLOOK.COM (20.179.109.18) by
 CWXP123MB2486.GBRP123.PROD.OUTLOOK.COM (20.179.109.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.20; Fri, 8 May 2020 02:55:46 +0000
Received: from CWXP123MB1958.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f132:e811:f232:2bdf]) by CWXP123MB1958.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f132:e811:f232:2bdf%7]) with mapi id 15.20.2958.035; Fri, 8 May 2020
 02:55:45 +0000
From: <jasper.lowell@bt.com>
To: <balaton@eik.bme.hu>
Subject: Re: Emulating Solaris 10 on SPARC64 sun4u
Thread-Topic: Emulating Solaris 10 on SPARC64 sun4u
Thread-Index: AdXb7aKPCyPc5BgLRMag+zXZgy3FKQDThhmAEVAOwAAACTw4AAAQ0PIA
Date: Fri, 8 May 2020 02:55:45 +0000
Message-ID: <78d72c7f09a45357b151231cba9454d6d288680d.camel@bt.com>
References: <CWXP123MB2262B6F3159B7AA7AB010F4183020@CWXP123MB2262.GBRP123.PROD.OUTLOOK.COM>
 <f0f00ecd-1989-9bc1-02e0-8a9b4819f051@ilande.co.uk>
 <f833edcfed7dd58a6bb27269de66acfed0e550eb.camel@bt.com>
 <alpine.BSF.2.22.395.2005072048510.5891@zero.eik.bme.hu>
In-Reply-To: <alpine.BSF.2.22.395.2005072048510.5891@zero.eik.bme.hu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: eik.bme.hu; dkim=none (message not signed)
 header.d=none;eik.bme.hu; dmarc=none action=none header.from=bt.com;
x-originating-ip: [217.138.204.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 35c00117-26eb-4687-3896-08d7f2fb4e40
x-ms-traffictypediagnostic: CWXP123MB2486:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CWXP123MB24865CEDF8DD4FECEF2E0E5083A20@CWXP123MB2486.GBRP123.PROD.OUTLOOK.COM>
x-antispam-2: 1
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 039735BC4E
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CuAtvLu61ieGl73VAYbfhdtlqWQ3oJRD9kowsw9sQmiqGSl+uyn6i2KyGnlGJsnfoej7F0bEZIGZiQgapSdA7Cdk5jDVsEMH3VbNqIvALggVcEdsKNDvjEGkCeiTJPnR2g3Kj76guZ9z6ck22PdZ5L/HvsWAbuH+/VhR8z1NbEeIS0QiHF/rt3k71tk7Zl8djren21Dqxom+hKMQrhBi+XCPz5xy/khPxCRAyJEPufj9m8pk2NSW+mms7e75glM3qb92NuUiamYV3veWnP+kdX//aIlj+gVYUtzdclfkOISS/KYUzWNqxa6ynC3DUrSVDIBTmI32qHx745BsNL7MIyIWLFfLKIr+I77Dxvtdw4Nva49wMBftq42s8FOr5CGLcgaNGpqCQ30cWB+OSlhL0LTcDuibVdR+VicOH0+CYYEBbLxUvU45YIwd0p0g4iA459Ot+ZUgQbq3MyT/yfvfthLjdHDWucM0jSjmpbTN/a4zcDZJ+iCzuxNkFKb9CyCqpgXmRPScvSY0M/mLvF0Wzu29OjL0+LgjKiMeO0+nzo+tHTxiVUaVWH/LjoC4qn4W
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWXP123MB1958.GBRP123.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(346002)(136003)(396003)(39860400002)(33430700001)(26005)(316002)(2906002)(64756008)(6506007)(54906003)(8676002)(5660300002)(2616005)(478600001)(33440700001)(71200400001)(36756003)(91956017)(6916009)(66946007)(66446008)(66556008)(66476007)(76116006)(6486002)(83320400001)(83280400001)(83310400001)(86362001)(83290400001)(83300400001)(4326008)(8936002)(186003)(6512007)(32563001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: nJDR8xTrb7rsH6livslBryGxE+AWG7ll26RYJuQzFO2Hywl4m2H22BstpjL1K0wM6hj2850XxQGnNp/ovZzGLMXE4z967fh0xzN+9OxgnN7k10JkcX8LXfcvE/LLHETw3WzFpkW7utW1zYGdDh+lhGEehEQuus8C/xBbU4NDgRWJRCPn5IAiapOlvccVmos+3FvybxqkoTfVshxfK62qO28WzJPvONHZYSYY9zpigrj4cG2pqC9kJCX9XcWaDukHiBjMYzQozT00nCvqP10fWZWYv7yu3Y119Lmr4XKVrGxGokbCG6Gla+/c24PTFNpa4JxOehr9nByxcOM5Deile16Qlxv9KlBYKrL96q+w5mDmleDWwa5QABYJwq4Mo2CGwV3TLmMR3CIVQtFhdYPhH+S39r/kF1+zyvTqPcvoSs0qskAtvAM9IYDaL8JRD9JJGvS4dKqRNJfgrbqbZzkhNdVM3NgdANhYaQDsyT18+58M8EGAMzkzuU5jz8EvRpI+
Content-Type: text/plain; charset="utf-8"
Content-ID: <947045F56DEFF245B1712D98DFC666F7@GBRP123.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 35c00117-26eb-4687-3896-08d7f2fb4e40
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2020 02:55:45.8140 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7f35688-9c00-4d5e-ba41-29f146377ab0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NV2awfB3JRxrQwIzTKIdDDXxKOBbRFp8xVUUv4sXl4dB+pZVuzClhwCygeqAsEHVD63zLniuYvD0LGzQunaK6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB2486
X-OriginatorOrg: bt.com
Received-SPF: pass client-ip=213.121.35.78; envelope-from=jasper.lowell@bt.com;
 helo=smtpe1.intersmtp.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 22:55:59
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: tony.nguyen@bt.com, mark.cave-ayland@ilande.co.uk, dgilbert@redhat.com,
 atar4qemu@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiBJIGRvbid0IGtub3cgYW55dGhpbmcgYWJvdXQgdGhpcyBjaGlwIHNvIGRvbid0IGtub3cgaWYg
aXQgaGVscHMgYnV0DQo+IGlmIA0KPiBpdCdzIGFueSB3YXkgc2ltaWxhciB0byBFU0NDIChhbmQg
dGhlIEVTQ0MyIG5hbWUgaXMgbm90IGp1c3QNCj4gbWFya2V0aW5nKSANCj4gdGhlbiB0aGVyZSdz
IHNvbWUgZW11bGF0aW9uIG9mIHRoYXQgaW4gaHcvY2hhci9lc2NjLmMgdGhhdCB5b3UgbWF5DQo+
IHdhbnQgdG8gDQo+IGxvb2sgYXQuDQoNCkZyb20gd2hhdCBJIGNhbiB0ZWxsLCB0aGUgU0FCIDgy
NTMyIGlzIGEgYml0IG1vcmUgY29tcGxleCB0aGFuIHRoZSBFU0NDDQpvbmVzLiBJdCdzIG5vdCBk
aWZmaWN1bHQgdG8gaW1wbGVtZW50IGJ1dCBhIGNvbXBsZXRlIHNvbHV0aW9uIHdpbGwgYmUNCmxl
bmd0aHkgYmVjYXVzZSBvZiB0aGUgbGFyZ2UgY29tYmluYXRpb24gb2YgY29uZmlndXJhdGlvbiBv
cHRpb25zIHRoZQ0KY2hpcCBzdXBwb3J0cy4NCg0KPiBNYXliZSB5b3UgY2FuIGdldCBhd2F5IHdp
dGggc2V0dGluZyB0aGVzZSB0byB0aGUgdmFsdWVzIHRoZSBkcml2ZXINCj4gd291bGQgDQo+IHNl
dCBhbmQgaGFyZCBjb2RpbmcgaXQgZm9yIG5vdyBqdXN0IHRvIGdldCBzb21lIG91dHB1dC4gVGhl
biB5b3UgY2FuIA0KPiBpZ25vcmUgdGhlIGNvcnJlc3BvbmRpbmcgcmVnaXN0ZXJzIHdoaWNoIGNv
dWxkIHNpbXBsaWZ5IGluaXRpYWwNCj4gZGV2aWNlIA0KPiBtb2RlbC4NCg0KSSdsbCB0YWtlIHRo
aXMgYXBwcm9hY2guDQoNClRoYW5rcywNCkphc3BlciBMb3dlbGwuDQoNCk9uIFRodSwgMjAyMC0w
NS0wNyBhdCAyMDo1NCArMDIwMCwgQkFMQVRPTiBab2x0YW4gd3JvdGU6DQo+IE9uIFRodSwgNyBN
YXkgMjAyMCwgamFzcGVyLmxvd2VsbEBidC5jb20gd3JvdGU6DQo+ID4gSSd2ZSBzdGFydGVkIHdv
cmsgb24gZW11bGF0aW5nIHRoZSBTQUIgODI1MzIgRVNTQzIgYnV0IGl0J3MNCj4gPiB1bmZvcnR1
bmF0ZWx5IHdheSBtb3JlIGNvbXBsZXggdGhhbiB0aGFuIHRoZSAxNjU1MEEuIEZvciBpbnN0YW5j
ZSwNCj4gPiBpdCdzDQo+IA0KPiBJIGRvbid0IGtub3cgYW55dGhpbmcgYWJvdXQgdGhpcyBjaGlw
IHNvIGRvbid0IGtub3cgaWYgaXQgaGVscHMgYnV0DQo+IGlmIA0KPiBpdCdzIGFueSB3YXkgc2lt
aWxhciB0byBFU0NDIChhbmQgdGhlIEVTQ0MyIG5hbWUgaXMgbm90IGp1c3QNCj4gbWFya2V0aW5n
KSANCj4gdGhlbiB0aGVyZSdzIHNvbWUgZW11bGF0aW9uIG9mIHRoYXQgaW4gaHcvY2hhci9lc2Nj
LmMgdGhhdCB5b3UgbWF5DQo+IHdhbnQgdG8gDQo+IGxvb2sgYXQuDQo+IA0KPiA+IHBvc3NpYmxl
IHRvIGNvbmZpZ3VyZSBkaWZmZXJlbnQgYmF1ZHJhdGVzIGZvciByZWNlaXZpbmcgYW5kDQo+ID4g
dHJhbnNtaXR0aW5nLiBRRU1VJ3MgY2hhcmRldiBpbnRlcmZhY2UgZG9lc24ndCBhcHBlYXIgdG8g
aGFuZGxlDQo+ID4gdGhhdC4NCj4gPiBRRU1VU2VyaWFsU2V0UGFyYW1zIGhhcyBhIHNpbmdsZSBz
cGVlZCB2YWx1ZSB0aGF0IGlzIHBhc3NlZCB0bw0KPiA+IGNmc2V0aXNwZWVkIGFuZCBjZnNldG9z
cGVlZC4gVGhlIGNoaXAgYWxzbyBoYXMgc3VwcG9ydCBmb3Igc3RpY2sNCj4gPiBwYXJpdHkNCj4g
PiAsIHdoaWNoIGFyZW4ndCB2YWxpZCBvcHRpb25zIHJpZ2h0IG5vdyBlaXRoZXIuIElmIEknbSB3
cm9uZyBvbg0KPiA+IGVpdGhlcg0KPiA+IG9mIHRob3NlIHBvaW50cyBwbGVhc2UgY29ycmVjdCBt
ZS4gVW5sZXNzIHRoZXJlIGlzIGFuIGFsdGVybmF0aXZlLA0KPiA+IGNoYW5nZXMgdG8gdGhlIGlu
dGVyZmFjZSBtYXkgbmVlZCB0byBiZSBtYWRlIGlmIGFkZGluZyB0aGlzIGRldmljZQ0KPiA+IGlz
DQo+ID4gdG8gYmUgY29uc2lkZXJlZC4NCj4gDQo+IE1heWJlIHlvdSBjYW4gZ2V0IGF3YXkgd2l0
aCBzZXR0aW5nIHRoZXNlIHRvIHRoZSB2YWx1ZXMgdGhlIGRyaXZlcg0KPiB3b3VsZCANCj4gc2V0
IGFuZCBoYXJkIGNvZGluZyBpdCBmb3Igbm93IGp1c3QgdG8gZ2V0IHNvbWUgb3V0cHV0LiBUaGVu
IHlvdSBjYW4gDQo+IGlnbm9yZSB0aGUgY29ycmVzcG9uZGluZyByZWdpc3RlcnMgd2hpY2ggY291
bGQgc2ltcGxpZnkgaW5pdGlhbA0KPiBkZXZpY2UgDQo+IG1vZGVsLg0KPiANCj4gUmVnYXJkcywN
Cj4gQkFMQVRPTiBab2x0YW4NCg==

