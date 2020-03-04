Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0B0C3F2C6
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 00:59:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC06520728
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 00:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bt.com header.i=@bt.com header.b="YR1wbjeH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC06520728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9INw-0000pu-UI
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 19:59:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45946)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasper.lowell@bt.com>) id 1j9IMo-0000Hw-1O
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 19:58:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasper.lowell@bt.com>) id 1j9IMn-0002O4-5M
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 19:58:29 -0500
Received: from smtpe1.intersmtp.com ([213.121.35.75]:14840)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasper.lowell@bt.com>)
 id 1j9IMl-0002Jb-Q4
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 19:58:29 -0500
Received: from tpw09926dag03h.domain1.systemhost.net (10.9.202.30) by
 BWP09926080.bt.com (10.36.82.111) with Microsoft SMTP Server (version=TLS1_2, 
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.1713.5; Wed, 4 Mar
 2020 00:58:15 +0000
Received: from tpw09926dag06h.domain1.systemhost.net (10.9.202.33) by
 tpw09926dag03h.domain1.systemhost.net (10.9.202.30) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4; Wed, 4 Mar 2020 00:58:21 +0000
Received: from bwp09926084.bt.com (10.36.82.115) by
 tpw09926dag06h.domain1.systemhost.net (10.9.202.33) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4 via Frontend Transport; Wed, 4 Mar 2020 00:58:21
 +0000
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (104.47.21.57) by
 smtpe1.intersmtp.com (10.36.82.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.1.1713.5; Wed, 4 Mar 2020 00:58:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=njPrV/UTa25QafGjoYR/6y1ZkBkXtB1GTmlpfYRBz825FYTuamQL+0e6qJiMik/NkuUxwG3ytkCAEEzhY8RYnN/kII6FwwxPr5p/g18+5pLjglbCWAnY8XeNb78vKu8fOMdAB9bAvHYSL/r6rTfWuUWdSJdsmlnSQUMcIRhjy3/AqjDi6cFrmhGQL+ALetZ3ox8+G3nwvc0Az7sXCETwRvXI9yd4r3/utRDX1ySr5nkATiQyWu/Ocv3WPwUdfqZ8ow52ugqce7D6gt24cgQnK6MpISH4E5oghgGaTyLjzKpG7z0MBPOaKoe6OT4UlA0VbNsUE3qPhtr9OqYfWuyStw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iObwhuZ9+H77PArv7IckG21PiEAGLAHcDT4uck47sVI=;
 b=gS3tn2kyrAVNhoDQNjY4JADL7sntiAtDKZBSGE1BHLFLoAUbEec4BWvflnM19NnNwkk4V/0tFST8uyePtWv4n1nPOC30P7ro7zHALFVtDyoFctoS5CkABNGZKzGZyujGLL3K+t7YlX8Z35HBZ+pzWpJhUYcMSrNrV9pQJOELilu5poNzSPq+pvfDDnA9b/mz11B0o6zy74GW/wDLm9BNFVhVawdCqujtu9elaT9MmQ6sVXSLv7hL4tbkyJdwuhAuXLGQm/KI/Z3VI5hzWGe78wNWrBQWlL/qjKjS9Sk7bMQq7VuOduJ35cWDoGz+Kh3VLjKeBH5Mwf0DyzhLMmzAFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bt.com; dmarc=pass action=none header.from=bt.com; dkim=pass
 header.d=bt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bt.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iObwhuZ9+H77PArv7IckG21PiEAGLAHcDT4uck47sVI=;
 b=YR1wbjeHDw3m//dUnrd3s4RzBSpSybcUxUP1+C4ccfHR685u5R7YqtfG3RlxLWgUqkJ36vDb0SPQj3RGMo8UqjFctWJ/BSZI2WD2I/eYz3fmqjf7xcOEm/H0OVAnQ3Um4yi5wUPjqNuXjzGK12pWJqFIVoy9GYOEomL3AI2Or2k=
Received: from LO2P123MB2271.GBRP123.PROD.OUTLOOK.COM (20.176.154.209) by
 LO2P123MB2271.GBRP123.PROD.OUTLOOK.COM (20.176.154.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.18; Wed, 4 Mar 2020 00:58:20 +0000
Received: from LO2P123MB2271.GBRP123.PROD.OUTLOOK.COM
 ([fe80::312f:184d:74b1:28c5]) by LO2P123MB2271.GBRP123.PROD.OUTLOOK.COM
 ([fe80::312f:184d:74b1:28c5%4]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 00:58:20 +0000
From: <jasper.lowell@bt.com>
To: <balaton@eik.bme.hu>
Subject: Re: [PATCH] hw/ide: Remove status register read side effect
Thread-Topic: [PATCH] hw/ide: Remove status register read side effect
Thread-Index: AQHV6IMztk0nS91QXUSAhbuFxp1TiagnnJkAgAADjoCAAAXGgIAAvUiAgACESgCAAmZZAIAAvBaAgADuooCAAGA3gIABLrQAgABsPQCACLtLAA==
Date: Wed, 4 Mar 2020 00:58:20 +0000
Message-ID: <2eaad5b9fffb507a1dfabedcfb6c249d7c291353.camel@bt.com>
References: <20200221065015.337915-1-jasper.lowell@bt.com>
 <f432a118-f6be-d6ff-fe37-35b6244f3b97@ilande.co.uk>
 <alpine.LMD.2.03.2002222042370.1577@eik.bme.hu>
 <alpine.LMD.2.03.2002222101580.1577@eik.bme.hu>
 <5f336bc8838b5bfebfcc5829a3fae0a34a2ebac0.camel@bt.com>
 <alpine.BSF.2.22.395.2002231522530.69746@zero.eik.bme.hu>
 <5ca992b3a358610c897d923009fe9f7a8febc17f.camel@bt.com>
 <alpine.BSF.2.22.395.2002251515290.22173@zero.eik.bme.hu>
 <2e972e94627a39cf45504ed244828d065d743910.camel@bt.com>
 <alpine.BSF.2.22.395.2002261109290.39786@zero.eik.bme.hu>
 <e7758063db7312ab052e595a508f0baa70d454dc.camel@bt.com>
 <alpine.BSF.2.22.395.2002271235120.21840@zero.eik.bme.hu>
In-Reply-To: <alpine.BSF.2.22.395.2002271235120.21840@zero.eik.bme.hu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jasper.lowell@bt.com; 
x-originating-ip: [61.68.11.94]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 01919459-6182-4f95-00ce-08d7bfd721e9
x-ms-traffictypediagnostic: LO2P123MB2271:
x-microsoft-antispam-prvs: <LO2P123MB2271FC514F3064B4F39F2FA683E50@LO2P123MB2271.GBRP123.PROD.OUTLOOK.COM>
x-antispam-2: 1
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0332AACBC3
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(136003)(376002)(39860400002)(366004)(189003)(199004)(81166006)(8936002)(8676002)(4326008)(81156014)(6486002)(54906003)(5660300002)(186003)(6506007)(2616005)(6512007)(478600001)(76116006)(91956017)(36756003)(86362001)(66946007)(66556008)(4744005)(71200400001)(2906002)(64756008)(316002)(26005)(6916009)(66476007)(66446008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:LO2P123MB2271;
 H:LO2P123MB2271.GBRP123.PROD.OUTLOOK.COM; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bt.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: raIVQ0uYxg7H/iNIY1amDTNRPNtcAKawr7ucRyIz26S626xx9LFXakngAqh2NqDOCOVbIgwXd9/Bqks2fMmZj2AXuGx8qAdAsym6wGvUKpsS27J0G8wobf99/PczrT5x2P7u3hQzR9pS6G0ZFXV6wdfJzXX7FntQQ02eNp4Veo7oa6GZidPyMSC97bTGFP3yjU7bqDfBtXkjuvRQEUAO95jTVmmajv57RDSNsqFRc4Dz0ezxP8gAExdzc1clEwpFZlQ2yLXZxiVm157prk2OC4kOA3w+H34GzuhYe+aiAkal22jjXkgmN9wBUwAL9ZQLtsro0nlHLrA3IV243rzU1yQfOkng0AkcdzNgGKBmhgOg+wDz3eYbPzrQGvR2pP3YiBa+R4jc48qW6rni4kpX8OkfrVbFOXHI2K/6t3VyO8+l/QTsNyxIIwJ9gQat+XFK
x-ms-exchange-antispam-messagedata: NktjzSAPC4vEnTbMwfIKUmcJGsmZZmYEkX63Xeu5c1PdscGOaVeeOCcbTY2hAoWjdWWojFJ5Ms2u8mROJOhGjcSIczvxYW7GN9eqI5OjGxOFeRjKQZpOKvs7Ne1PfkmXK/Br2GfHM9PU5S/HqyE3XA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <A35DD182FC4B8542AD30E090AA231770@GBRP123.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 01919459-6182-4f95-00ce-08d7bfd721e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2020 00:58:20.2907 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7f35688-9c00-4d5e-ba41-29f146377ab0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dpiwFQ/z8Tvlr5+lcycAlPkVOuZYZRzsl7ObqfI5fPj3JN0uXUSTd1vWwypAcVLWVbXEoA3lfCw7rGP8en9A/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P123MB2271
X-OriginatorOrg: bt.com
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 213.121.35.75
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
Cc: jsnow@redhat.com, mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SSdtIGhhcHB5IHRvIGRvIHRoaXMuIEl0IHdpbGwgdGFrZSBhIHdoaWxlIGZvciBtZSB0byBjb2xs
ZWN0IHRoZQ0KcmVzdWx0cyB0aG91Z2guIEknbGwgY2hpbWUgaW4gb25jZSBJIGhhdmUgdGhlIHJl
c3VsdHMuDQoNCj4gVGhhdCBzaG91bGQgZ2l2ZSB0aGUgdWx0aW1hdGUgYW5zd2VyIHRvIG91ciBn
dWVzc2luZy4NCkFncmVlZC4NCg0KVGhhbmtzLA0KSmFzcGVyIExvd2VsbC4NCg0KT24gVGh1LCAy
MDIwLTAyLTI3IGF0IDEyOjM4ICswMTAwLCBCQUxBVE9OIFpvbHRhbiB3cm90ZToNCj4gT24gVGh1
LCAyNyBGZWIgMjAyMCwgamFzcGVyLmxvd2VsbEBidC5jb20gd3JvdGU6DQo+ID4gSSd2ZSBzaW5j
ZSBsb29rZWQgYXQgYSBVbHRyYSA1IGJvYXJkIGFuZCBjYW4gY29uZmlybSB0aGF0IGl0DQo+ID4g
c2hpcHBlZA0KPiA+IHdpdGggYSBDTUQ2NDZVIGNoaXAgbGlrZSB0aGUgVWx0cmEgMTAuDQo+IA0K
PiBJZiB5b3UgaGF2ZSBhY2Nlc3MgdG8gYW4gVWx0cmEgNSBtYXliZSB5b3UgY291bGQgdHJ5IHRl
c3Rpbmcgd2hhdCBpdA0KPiBkb2VzIA0KPiB3aXRoIGlycXMuIFRoYXQgc2hvdWxkIGdpdmUgdGhl
IHVsdGltYXRlIGFuc3dlciB0byBvdXIgZ3Vlc3NpbmcuIEl0DQo+IG1heSANCj4gbmVlZCBwYXRj
aGluZyBhIExpbnV4IGRyaXZlciB0byBsb2cgbW9yZSBpbmZvIGFuZCByZWNvbXBpbGUgdGhlDQo+
IGtlcm5lbCBzbyANCj4gbm90IHN1cmUgeW91IGhhdmUgdGltZSBmb3IgdGhhdCBidXQgbWF5YmUg
aXQgd291bGQgaGVscCBpZiB5b3UgY2FuIGRvDQo+IGl0Lg0KPiANCj4gUmVnYXJkcywNCj4gQkFM
QVRPTiBab2x0YW4NCg==

