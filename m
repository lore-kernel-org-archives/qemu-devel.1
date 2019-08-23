Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ECF3C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 15:54:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E8402173E
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 15:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=here.com header.i=@here.com header.b="KEGfRHyW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E8402173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=here.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1BtM-0004AJ-Ek
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 11:54:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38972)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent.bonnans@here.com>) id 1i1BsE-0002yU-7r
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 11:53:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent.bonnans@here.com>) id 1i1BsA-0001LD-Ks
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 11:53:07 -0400
Received: from mail-eopbgr40111.outbound.protection.outlook.com
 ([40.107.4.111]:9345 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <laurent.bonnans@here.com>)
 id 1i1Bs8-0001GY-S3; Fri, 23 Aug 2019 11:53:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X+kn4SSLZTPFQOxVF39svyejxY40Pe9Z2zpxiuWJy5H9AmeLD51K9EKK4oH+h+/9HFQQE8bGmIWJC3/0Te5/vBuI5n2vgewf3WnpH4vh1ZoVDqTh0z66pF/XAhicVQnjPWF4FaPMoQflbKregXh+zlbqzrjrGNQfD0QLIHvcLE/zni9mzhhgYjHLjGmwlICqVtoB2FjhyLfrQZU7kU8NJaEzV4gK93041DQxpSNkxnSLkLyK3S7xL1HuTEUvcShuDsZPqdEz9fyz8wLPscTqHgmHulfuhgmD0IUt1sUVCTOaeDMC6yi7OM5enH23xcSY7lJEEOBMfCO9x4PyGDwbVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HeDRWNlaQ069Bm75VGg4Ol/sq9Gbf4nJXdzbQx48hCI=;
 b=CsyAvNgqOhPydtjY3PXHHCXTD3T0TsvFUT5BDXytMX5dXS4j+nInJ8Pk5IsRxEbOvXmX1MpbCCOo7JnD8GNquaWHWJPlgWh/MpJQu2i3Uhth3IrnyMEU2nOoETU4UeVkUSBumIwm5e6Rj4B0I7lFFIF4ZiBqcAXGg55GqRRgMhCyLlRyvIRvm8VdEq+7ren0ZEpSYAZIwiJz4GESzC4RWUu6XRwV3iD07jX3i/2JC6Q4i+p/wJC82jV7jxmX5Xk+0BjUNuiRRFv9tWHRM7zDDog0lXyriZ9jZq6NiAe/IV0Idokqp+712fQBuqAWmpCPECYmVoVHg4CD1Tjp4BGrHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=here.com; dmarc=pass action=none header.from=here.com;
 dkim=pass header.d=here.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=here.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HeDRWNlaQ069Bm75VGg4Ol/sq9Gbf4nJXdzbQx48hCI=;
 b=KEGfRHyW1hinzObQzblUFMEaRL2gixvFTKuo7owwZWTtg3Rvx6We4OaKO/02dPvProxA5douiYh6v0kNWRJjAvwIOp3GfCGKU2vYHGBXRy0dd/QaOyokLpEJDZ2ztr/0knPW6GDdpB/WU6lqfxwxzJ8RWvejsH8E/9zRjRh0QUM=
Received: from AM5PR04MB3299.eurprd04.prod.outlook.com (10.173.255.158) by
 AM5PR04MB2948.eurprd04.prod.outlook.com (10.175.229.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Fri, 23 Aug 2019 15:52:59 +0000
Received: from AM5PR04MB3299.eurprd04.prod.outlook.com
 ([fe80::1ce8:464b:3edf:4043]) by AM5PR04MB3299.eurprd04.prod.outlook.com
 ([fe80::1ce8:464b:3edf:4043%7]) with mapi id 15.20.2178.020; Fri, 23 Aug 2019
 15:52:59 +0000
From: "Bonnans, Laurent" <laurent.bonnans@here.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: Running u-boot on raspi2
Thread-Index: AQHVWcrWLGGpQJpj+0COBX96UyfaDA==
Date: Fri, 23 Aug 2019 15:52:59 +0000
Message-ID: <04703275-47e1-90c0-1b64-d2373ab48970@here.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=laurent.bonnans@here.com; 
x-originating-ip: [131.228.216.132]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 99a6d63f-e8e9-4aa6-c0c6-08d727e1f921
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:AM5PR04MB2948; 
x-ms-traffictypediagnostic: AM5PR04MB2948:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM5PR04MB29482129AF7BCC1BE6CBC9ED85A40@AM5PR04MB2948.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0138CD935C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(39860400002)(376002)(366004)(136003)(396003)(346002)(199004)(31014005)(189003)(31696002)(14444005)(6512007)(5660300002)(4326008)(5640700003)(99286004)(476003)(36756003)(2616005)(6486002)(86362001)(478600001)(107886003)(6436002)(6306002)(450100002)(305945005)(7736002)(3846002)(6116002)(25786009)(53936002)(66066001)(14454004)(2351001)(966005)(31686004)(6916009)(2501003)(186003)(6506007)(26005)(8676002)(102836004)(54906003)(81156014)(81166006)(8936002)(486006)(71190400001)(71200400001)(66556008)(2906002)(66446008)(64756008)(66946007)(91956017)(76116006)(66476007)(316002)(256004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM5PR04MB2948;
 H:AM5PR04MB3299.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: here.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5cVW/qKksOG40B6uHicSuQTEgzOAV5cAw38ujmHnhQTlm86CCMLaxW4IsVy/6+eYhKxosPqXcOVy657LrVyoe8XljMyZn1MrRrjw1bR1ZFoXjMVOxYB9SDB8o7n05LaxSBlqJKGdgk0hARSDUp7i5uYglSOTRoRKiZIpRZN7ESaKUTHcHVAVgu9tW3n65djzKoy3Rg3Lwj1TkNxuaXCM+tsVh4xrYCp3BKqTn6CDcg/Y2NSiRHP4li5Nse7QYB9RJRqkWsrf5RqZhHF/iWTFp9ptpo6gZvEDvg0wIf6tTO0v+sP6w5FQdLnJnJtzLt8l45rFJ+sE5pin5RMFYQTp91kQWZUfLT9mrHugz3jzr12StZX8vdNWElEAPEba2miSCzBivQkgSqm1MfkhvlXD+9PSTjZ7G11seO6Khi6Or7g=
Content-Type: text/plain; charset="utf-8"
Content-ID: <85DAAF1A7B46FF4393AF860871EBAD49@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: here.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99a6d63f-e8e9-4aa6-c0c6-08d727e1f921
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2019 15:52:59.5579 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6d4034cd-7225-4f72-b853-91feaea64919
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0VgeJ78oUma0p2UZm3Zy3SDvpFQEOvXbqMlLKyKw6wQnhLv820GvDWhTImBe34m8lJrFXPhtpTNmhVmu2gpP+thriyg2FmQ8P0zjtQIt1L4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB2948
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.111
Subject: [Qemu-devel] Running u-boot on raspi2
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
Cc: "Xiang, Cheng" <ext-cheng.xiang@here.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGksDQoNCldlIChtb3N0bHkgQ2hlbmcgWGlhbmcncyB3b3JrKSBoYXZlIGJlZW4gdHJ5aW5nIHRv
IHVzZSB0aGUgcmFzcGkyIA0KbWFjaGluZSB0byBib290IGFuIGltYWdlIHRocm91Z2ggdS1ib290
Lg0KSXQgc2VlbXMsIGhvd2V2ZXIsIHRoYXQgdGhlcmUgYXJlIHNvbWUgbWlzc2luZyBwaWVjZXM6
DQoNClRoZSBmaXJzdCBwcm9ibGVtIGlzIHRoYXQgaXQgdHJpcHMgdmVyeSBlYXJseSBpZiB3ZSBr
ZWVwIHRoZSBjcHVzIGNvdW50IA0KYXQgNCBidXQgd2lsbCBjb250aW51ZSBpZiB3ZSBoYXJkLXBh
dGNoIGl0IHRvIGJlIGEgc2luZ2xlIGNvcmUuDQpTeW1wdG9tIGlzIHRoYXQgaXQgc2VlbXMgYWxs
IGNvcmVzIGFyZSBydW5uaW5nIGFuZCB0cnlpbmcgdG8gZXhlY3V0ZSANCnNvbWV0aGluZywgd2hp
bGUgdS1ib290IHByb2JhYmx5IGhhcyBub3QgaW50ZW50aW9uIG9mIGRvaW5nIHNvbWV0aGluZyAN
CndpdGggU01QLg0KT3VyIGd1ZXNzIGlzIHRoYXQgaXQncyBzb21ldGhpbmcgcmVsYXRlZCB0byB0
aGUgYXNtIHNwaW4gcm91dGluZSBpbiANCnJhc3BpLmMsIHdoaWNoIGlzIG1heWJlIGF3b2tlbiB0
b28gc29vbiBieSBzb21lIGV2ZW50IGluIHRoZSBtYm94Pw0KDQpTZWNvbmQgcHJvYmxlbSBpcyB0
aGF0IHUtYm9vdCByZWxpZXMgb24gc29tZSBTb0MgdGltZXIgZm9yIHRoZSANCnJhc3BiZXJyeXBp
IDIsICJTeXN0ZW0gVGltZXIiIGluIA0KaHR0cHM6Ly93d3cucmFzcGJlcnJ5cGkub3JnL2FwcC91
cGxvYWRzLzIwMTIvMDIvQkNNMjgzNS1BUk0tUGVyaXBoZXJhbHMucGRmDQpJdCBoYXMgbm90IGJl
ZW4gYWRkZWQgdG8gcWVtdSwgdG8gb3VyIGtub3dsZWRnZSBidXQgaXQgbG9va3MgbGlrZSBpdCAN
CnNob3VsZCBiZSBwcmV0dHkgZWFzeSB0byBlbXVsYXRlLg0KDQpJZiB3ZSByZW1vdmUgdGhlIHRp
bWVyIGFjY2Vzc2VzIG9uIHUtYm9vdCArIHNldHMgdGhlIGNwdSBjb3VudCB0byAxLCB0aGUgDQpt
YWNoaW5lIGJvb3RzIGZpbmUgdXAgdG8gdGhlIGtlcm5lbCAobWludXMgdGhlIFBMTCByZWxhdGVk
IHdhcm5pbmcgDQptZW50aW9uZWQgZWFybGllciBpbiB0aGUgbGlzdCkuDQoNClRoZSBmaXJzdCBp
c3N1ZSBzZWVtcyBoYXJkZXIgdG8gcmVzb2x2ZS4gRG9lcyBhbnlib2R5IGhhdmUgYSBjbGVhcmVy
IA0KcGljdHVyZSBvbiB3aGF0IGNvdWxkIGJlIHRoZSBwcm9ibGVtPw0KDQpDaGVlcnMsDQoNCkxh
dXJlbnQNCg==

