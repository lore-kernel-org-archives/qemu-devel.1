Return-Path: <SRS0=rO5d=BF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B391C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2020 04:08:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F0C720674
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2020 04:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=leostella.onmicrosoft.com header.i=@leostella.onmicrosoft.com header.b="bUDye/t5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F0C720674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=leostella.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jzXxH-00086K-EK
	for qemu-devel@archiver.kernel.org; Sun, 26 Jul 2020 00:08:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33086)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matthieu.bucchianeri@leostella.com>)
 id 1jzXwb-0007Ef-1S; Sun, 26 Jul 2020 00:07:25 -0400
Received: from mail-cy1usg02on0125.outbound.protection.office365.us
 ([23.103.209.125]:7968 helo=USG02-CY1-obe.outbound.protection.office365.us)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matthieu.bucchianeri@leostella.com>)
 id 1jzXwY-0003KD-LD; Sun, 26 Jul 2020 00:07:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=ZE6UEqqdCCSRvhMS5u+l7uXdS5ogjwaOgzTxZjHZ4/BZPjHHRgaKt+SDIsVZLO+zo6rYKaCD49QRMaxEGT0RRAZAOrA0Y6jDRee4IAEFBMl4BkYi7JG5NY1ZuKrgcna1OW+XKum1ybN+LhDiLpb8CadmuNue4KTwGrMJHyVZDGh+2PCM0aBpO/kd7+8BNyRqcyPNR55BLvilNU3t2eFNd6efvx7lbZBMvtcHaexw/aw2Rfab911zAJaPj86mVbiuQ3eJMwxRZQKiF/JG1eLKiX6wAXGJmXqAeaH2utAiXh/DfsrE6J2VVyDrQwadC0nOTdzzabFdbZf3WNlexrF9CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=waW4fAQEFrULDRToszuDG8PKK6locv7S73ragGWfh6k=;
 b=arC1mOVPB+YvxDiJbSNxocxFqIc1/wPWwFY6NtmP+/g3sfvNVV88bqt8Og/9Y2vVVk+ojrHK8Hh8BpVvd/mJ+Nq6Nz5iV5I3hA2t/kn81zO9fosOMmT6pnreDwOY2hYsiEIxKFdGSc758HXehIuuRL38Qi3Vx6U1yuHMOMsLlRzjmIxuORGqHsFGtjHC6jpgIP3vdXDE4LNT6en3JdAinUM+5dZItSMV1rhX9G0xCiPNOvcNPw/9Vv5JBbUfOuOUbNG/lJKZyr1bjKTQa+DlWHTkERMnHyd8RAW8rjitdxUJ6mQAmg7uAngTPdOs81WJ1+1ROq+0fr/6QwrB+zW2Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leostella.com; dmarc=pass action=none
 header.from=leostella.com; dkim=pass header.d=leostella.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leostella.onmicrosoft.com; s=selector1-leostella-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=waW4fAQEFrULDRToszuDG8PKK6locv7S73ragGWfh6k=;
 b=bUDye/t5QR2jJCQgY/6mhsNY2c77ZM3L77bFaH2b+k4j90/ZMO3umNrIf4k3Kz6Ru/WGL2LvYFvAZ9i0urE2dE9xMGNlCfjvLbVkugtV4XRWxituASFT7t49Qam04E6QUmPSZQ2lA5fwtWzPV2FEkkNJoWF+5vmNivSVBPrHE3c=
Received: from SN5P110MB0543.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:41c::10)
 by SN5P110MB0557.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:41c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.28; Sun, 26 Jul
 2020 04:07:15 +0000
Received: from SN5P110MB0543.NAMP110.PROD.OUTLOOK.COM
 ([fe80::d0e1:84ad:f42:f6f2]) by SN5P110MB0543.NAMP110.PROD.OUTLOOK.COM
 ([fe80::d0e1:84ad:f42:f6f2%5]) with mapi id 15.20.3195.029; Sun, 26 Jul 2020
 04:07:15 +0000
From: Matthieu Bucchianeri <matthieu.bucchianeri@leostella.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org"
 <qemu-ppc@nongnu.org>
Subject: RE: [PATCH] target/ppc: Fix SPE unavailable exception triggering
Thread-Topic: [PATCH] target/ppc: Fix SPE unavailable exception triggering
Thread-Index: AQHWYrfk1Mes9sSNm0m4bx3FUJe/kKkYyO+AgAB1XcA=
Date: Sun, 26 Jul 2020 04:07:15 +0000
Message-ID: <SN5P110MB0543740427336E63D9D1AC0384750@SN5P110MB0543.NAMP110.PROD.OUTLOOK.COM>
References: <20200725191436.31828-1-matthieu.bucchianeri@leostella.com>
 <159571106877.5803.9650819864553051317@66eaa9a8a123>
In-Reply-To: <159571106877.5803.9650819864553051317@66eaa9a8a123>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=leostella.com;
x-originating-ip: [2601:601:f01:e820:3805:9c62:2079:6ea0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c906d5e4-a7c6-4e77-0f83-08d83119618d
x-ms-traffictypediagnostic: SN5P110MB0557:
x-microsoft-antispam-prvs: <SN5P110MB05576F12069CCA5181C24E9184750@SN5P110MB0557.NAMP110.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN5P110MB0543.NAMP110.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(366004)(508600001)(45080400002)(55016002)(9686003)(2906002)(83380400001)(110136005)(966005)(52536014)(5660300002)(33656002)(8676002)(7696005)(186003)(86362001)(66476007)(66556008)(64756008)(66946007)(76116006)(4326008)(71200400001)(66446008)(53546011)(8936002)(44832011)(6506007)(131093003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: leostella.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN5P110MB0543.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c906d5e4-a7c6-4e77-0f83-08d83119618d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2020 04:07:15.1743 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dbc51146-ab26-404b-9c4b-cce4f3331cc5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN5P110MB0557
Received-SPF: pass client-ip=23.103.209.125;
 envelope-from=matthieu.bucchianeri@leostella.com;
 helo=USG02-CY1-obe.outbound.protection.office365.us
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/26 00:07:19
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhpcyBsb29rcyBsaWtlIGFuIGluZnJhc3RydWN0dXJlIGlzc3VlLiBOb3RoaW5nIGluIHRoZSBs
b2cgc2VlbXMgdG8gaW5kaWNhdGUgYW4gaXNzdWUuDQoNCmNoZWNrcGF0Y2ggd2FzIHJ1biBsb2Nh
bGx5LCBhbmQgcGFzc2VkLg0KDQojIC4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIDAwMDEtdGFyZ2V0
LXBwYy1GaXgtU1BFLXVuYXZhaWxhYmxlLWV4Y2VwdGlvbi10cmlnZ2VyaW5nLnBhdGNoDQp0b3Rh
bDogMCBlcnJvcnMsIDAgd2FybmluZ3MsIDE5MiBsaW5lcyBjaGVja2VkDQoNCjAwMDEtdGFyZ2V0
LXBwYy1GaXgtU1BFLXVuYXZhaWxhYmxlLWV4Y2VwdGlvbi10cmlnZ2VyaW5nLnBhdGNoIGhhcyBu
byBvYnZpb3VzIHN0eWxlIHByb2JsZW1zIGFuZCBpcyByZWFkeSBmb3Igc3VibWlzc2lvbi4NCg0K
UGxlYXNlIGxldCBtZSBrbm93IGlmIGFueSBvdGhlciBhY3Rpb24gaXMgcmVxdWlyZWQuDQoNCi0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBuby1yZXBseUBwYXRjaGV3Lm9yZyA8bm8t
cmVwbHlAcGF0Y2hldy5vcmc+DQpTZW50OiBTYXR1cmRheSwgSnVseSAyNSwgMjAyMCAyOjA0IFBN
DQpUbzogTWF0dGhpZXUgQnVjY2hpYW5lcmkgPG1hdHRoaWV1LmJ1Y2NoaWFuZXJpQGxlb3N0ZWxs
YS5jb20+DQpDYzogcWVtdS1kZXZlbEBub25nbnUub3JnOyBxZW11LXBwY0Bub25nbnUub3JnOyBN
YXR0aGlldSBCdWNjaGlhbmVyaSA8bWF0dGhpZXUuYnVjY2hpYW5lcmlAbGVvc3RlbGxhLmNvbT47
IGRhdmlkQGdpYnNvbi5kcm9wYmVhci5pZC5hdQ0KU3ViamVjdDogUmU6IFtQQVRDSF0gdGFyZ2V0
L3BwYzogRml4IFNQRSB1bmF2YWlsYWJsZSBleGNlcHRpb24gdHJpZ2dlcmluZw0KDQogRXh0ZXJu
YWwgTWVzc2FnZQ0KDQoNClBhdGNoZXcgVVJMOiBodHRwczovL3VzZzAyLnNhZmVsaW5rcy5wcm90
ZWN0aW9uLm9mZmljZTM2NS51cy8/dXJsPWh0dHBzJTNBJTJGJTJGcGF0Y2hldy5vcmclMkZRRU1V
JTJGMjAyMDA3MjUxOTE0MzYuMzE4MjgtMS1tYXR0aGlldS5idWNjaGlhbmVyaSU0MGxlb3N0ZWxs
YS5jb20lMkYmYW1wO2RhdGE9MDIlN0MwMSU3Q21hdHRoaWV1LmJ1Y2NoaWFuZXJpJTQwbGVvc3Rl
bGxhLmNvbSU3QzBlMGMzZmQ5ZmJmYjQzNDkzMzFjMDhkODMwZGU2MDBjJTdDZGJjNTExNDZhYjI2
NDA0YjljNGJjY2U0ZjMzMzFjYzUlN0MxJTdDMCU3QzYzNzMxMzA3ODk0Mjc0ODgyMSZhbXA7c2Rh
dGE9VnNzc3ZMNDAlMkJGNkFMQ04xaWZwZVRMelJRQnBGNHJxNE4lMkJZMXpDTXNDT2clM0QmYW1w
O3Jlc2VydmVkPTANCg0KDQoNCkhpLA0KDQpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUg
Y29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvciBtb3JlIGluZm9ybWF0
aW9uOg0KDQpUeXBlOiBzZXJpZXMNCk1lc3NhZ2UtaWQ6IDIwMjAwNzI1MTkxNDM2LjMxODI4LTEt
bWF0dGhpZXUuYnVjY2hpYW5lcmlAbGVvc3RlbGxhLmNvbQ0KU3ViamVjdDogW1BBVENIXSB0YXJn
ZXQvcHBjOiBGaXggU1BFIHVuYXZhaWxhYmxlIGV4Y2VwdGlvbiB0cmlnZ2VyaW5nDQoNCj09PSBU
RVNUIFNDUklQVCBCRUdJTiA9PT0NCiMhL2Jpbi9iYXNoDQpnaXQgcmV2LXBhcnNlIGJhc2UgPiAv
ZGV2L251bGwgfHwgZXhpdCAwIGdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAg
Z2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlIGdpdCBjb25maWcgLS1sb2NhbCBk
aWZmLmFsZ29yaXRobSBoaXN0b2dyYW0gLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFj
ayBiYXNlLi4NCj09PSBURVNUIFNDUklQVCBFTkQgPT09DQoNCkZyb20gaHR0cHM6Ly91c2cwMi5z
YWZlbGlua3MucHJvdGVjdGlvbi5vZmZpY2UzNjUudXMvP3VybD1odHRwcyUzQSUyRiUyRmdpdGh1
Yi5jb20lMkZwYXRjaGV3LXByb2plY3QlMkZxZW11JmFtcDtkYXRhPTAyJTdDMDElN0NtYXR0aGll
dS5idWNjaGlhbmVyaSU0MGxlb3N0ZWxsYS5jb20lN0MwZTBjM2ZkOWZiZmI0MzQ5MzMxYzA4ZDgz
MGRlNjAwYyU3Q2RiYzUxMTQ2YWIyNjQwNGI5YzRiY2NlNGYzMzMxY2M1JTdDMSU3QzAlN0M2Mzcz
MTMwNzg5NDI3NDg4MjEmYW1wO3NkYXRhPTNLNWxoemhMUkhxS2NWaGF6YUZBN0w3SWJOTGlKZ3JC
a2xpNjh2c1J2RTQlM0QmYW1wO3Jlc2VydmVkPTANCiAgIDdhZGZiZWEuLmIwY2UzZjAgIG1hc3Rl
ciAgICAgLT4gbWFzdGVyDQpGcm9tIGh0dHBzOi8vdXNnMDIuc2FmZWxpbmtzLnByb3RlY3Rpb24u
b2ZmaWNlMzY1LnVzLz91cmw9aHR0cHMlM0ElMkYlMkZnaXRodWIuY29tJTJGcGF0Y2hldy1wcm9q
ZWN0JTJGcWVtdSZhbXA7ZGF0YT0wMiU3QzAxJTdDbWF0dGhpZXUuYnVjY2hpYW5lcmklNDBsZW9z
dGVsbGEuY29tJTdDMGUwYzNmZDlmYmZiNDM0OTMzMWMwOGQ4MzBkZTYwMGMlN0NkYmM1MTE0NmFi
MjY0MDRiOWM0YmNjZTRmMzMzMWNjNSU3QzElN0MwJTdDNjM3MzEzMDc4OTQyNzQ4ODIxJmFtcDtz
ZGF0YT0zSzVsaHpoTFJIcUtjVmhhemFGQTdMN0liTkxpSmdyQmtsaTY4dnNSdkU0JTNEJmFtcDty
ZXNlcnZlZD0wDQogKiBbbmV3IHRhZ10gICAgICAgICBwYXRjaGV3LzIwMjAwNzI1MTkxNDM2LjMx
ODI4LTEtbWF0dGhpZXUuYnVjY2hpYW5lcmlAbGVvc3RlbGxhLmNvbSAtPiBwYXRjaGV3LzIwMjAw
NzI1MTkxNDM2LjMxODI4LTEtbWF0dGhpZXUuYnVjY2hpYW5lcmlAbGVvc3RlbGxhLmNvbQ0KZmF0
YWw6IGZhaWxlZCB0byB3cml0ZSByZWYtcGFjayBmaWxlDQpmYXRhbDogVGhlIHJlbW90ZSBlbmQg
aHVuZyB1cCB1bmV4cGVjdGVkbHkgVHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOg0K
ICBGaWxlICJwYXRjaGV3LXRlc3RlcjIvc3JjL3BhdGNoZXctY2xpIiwgbGluZSA1MzEsIGluIHRl
c3Rfb25lDQogICAgZ2l0X2Nsb25lX3JlcG8oY2xvbmUsIHJbInJlcG8iXSwgclsiaGVhZCJdLCBs
b2dmLCBUcnVlKQ0KICBGaWxlICJwYXRjaGV3LXRlc3RlcjIvc3JjL3BhdGNoZXctY2xpIiwgbGlu
ZSA2MiwgaW4gZ2l0X2Nsb25lX3JlcG8NCiAgICBzdWJwcm9jZXNzLmNoZWNrX2NhbGwoY2xvbmVf
Y21kLCBzdGRlcnI9bG9nZiwgc3Rkb3V0PWxvZ2YpDQogIEZpbGUgIi9vcHQvcmgvcmgtcHl0aG9u
MzYvcm9vdC91c3IvbGliNjQvcHl0aG9uMy42L3N1YnByb2Nlc3MucHkiLCBsaW5lIDI5MSwgaW4g
Y2hlY2tfY2FsbA0KICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQpDQpz
dWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAnWydnaXQnLCAnY2xvbmUnLCAn
LXEnLCAnL2hvbWUvcGF0Y2hldzIvLmNhY2hlL3BhdGNoZXctZ2l0LWNhY2hlL2h0dHBzZ2l0aHVi
Y29tcGF0Y2hld3Byb2plY3RxZW11LTNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3
MTMzODQnLCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLXhtdDdxMHM5L3NyYyddJyByZXR1
cm5lZCBub24temVybyBleGl0IHN0YXR1cyAxMjguDQoNCg0KDQpUaGUgZnVsbCBsb2cgaXMgYXZh
aWxhYmxlIGF0DQpodHRwczovL3VzZzAyLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm9mZmljZTM2NS51
cy8/dXJsPWh0dHAlM0ElMkYlMkZwYXRjaGV3Lm9yZyUyRmxvZ3MlMkYyMDIwMDcyNTE5MTQzNi4z
MTgyOC0xLW1hdHRoaWV1LmJ1Y2NoaWFuZXJpJTQwbGVvc3RlbGxhLmNvbSUyRnRlc3RpbmcuY2hl
Y2twYXRjaCUyRiUzRnR5cGUlM0RtZXNzYWdlJmFtcDtkYXRhPTAyJTdDMDElN0NtYXR0aGlldS5i
dWNjaGlhbmVyaSU0MGxlb3N0ZWxsYS5jb20lN0MwZTBjM2ZkOWZiZmI0MzQ5MzMxYzA4ZDgzMGRl
NjAwYyU3Q2RiYzUxMTQ2YWIyNjQwNGI5YzRiY2NlNGYzMzMxY2M1JTdDMSU3QzAlN0M2MzczMTMw
Nzg5NDI3NTg4MTgmYW1wO3NkYXRhPVlVcjd0TUt1ZG5XWWM3MXphM3BYRlAlMkZMQ3BVd3hOUzlv
WGIzeVZ2eUhaMCUzRCZhbXA7cmVzZXJ2ZWQ9MC4NCi0tLQ0KRW1haWwgZ2VuZXJhdGVkIGF1dG9t
YXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly91c2cwMi5zYWZlbGlua3MucHJvdGVjdGlvbi5v
ZmZpY2UzNjUudXMvP3VybD1odHRwcyUzQSUyRiUyRnBhdGNoZXcub3JnJTJGJmFtcDtkYXRhPTAy
JTdDMDElN0NtYXR0aGlldS5idWNjaGlhbmVyaSU0MGxlb3N0ZWxsYS5jb20lN0MwZTBjM2ZkOWZi
ZmI0MzQ5MzMxYzA4ZDgzMGRlNjAwYyU3Q2RiYzUxMTQ2YWIyNjQwNGI5YzRiY2NlNGYzMzMxY2M1
JTdDMSU3QzAlN0M2MzczMTMwNzg5NDI3NTg4MTgmYW1wO3NkYXRhPXdsRVdwa3lQdmdGc3klMkZU
QXM0OTdTV3lHMCUyQiUyRm9CUzNPdUNLT3Z2U3ZOZEElM0QmYW1wO3Jlc2VydmVkPTBdLg0KUGxl
YXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20NCkxlb1N0
ZWxsYSwgTExDDQpBIGpvaW50IHZlbnR1cmUgb2YgVGhhbGVzIEFsZW5pYSBTcGFjZSBhbmQgU3Bh
Y2VmbGlnaHQgSW5kdXN0cmllcw0KDQoxMjUwMSBFIE1hcmdpbmFsIFdheSBTIOKAoiBUdWt3aWxh
LCBXQSA5ODE2OA0KDQpQcm9wcmlldGFyeSBEb2N1bWVudDogVGhpcyBkb2N1bWVudCBtYXkgY29u
dGFpbiB0cmFkZSBzZWNyZXRzIG9yIG90aGVyd2lzZSBwcm9wcmlldGFyeSBhbmQgY29uZmlkZW50
aWFsIGluZm9ybWF0aW9uIG93bmVkIGJ5IExlb1N0ZWxsYSBMTEMuIEl0IGlzIGludGVuZGVkIG9u
bHkgZm9yIHRoZSBpbmRpdmlkdWFsIGFkZHJlc3NlZSBhbmQgbWF5IG5vdCBiZSBjb3BpZWQsIGRp
c3RyaWJ1dGVkLCBvciBvdGhlcndpc2UgZGlzY2xvc2VkIHdpdGhvdXQgTGVvU3RlbGxhIExMQyBl
eHByZXNzIHByaW9yIHdyaXR0ZW4gYXV0aG9yaXphdGlvbi4NCkV4cG9ydCBDb250cm9sbGVkOiBU
aGlzIGRvY3VtZW50IG1heSBjb250YWluIHRlY2huaWNhbCBkYXRhIHdob3NlIGV4cG9ydCBpcyBy
ZXN0cmljdGVkIGJ5IHRoZSBBcm1zIEV4cG9ydCBDb250cm9sIEFjdCAoVGl0bGUgMjIsIFUuUy5D
LiwgU2VjIDI3NTEgZXQgc2VxLikgb3IgdGhlIEV4cG9ydCBBZG1pbmlzdHJhdGlvbiBBY3Qgb2Yg
MTk3OSwgYXMgYW1lbmRlZCwgVGl0bGUgNTAsVS5TLkMuLCBhcHAgMjQwMSBldCBzZXEuIFZpb2xh
dGlvbiBvZiB0aGVzZSBleHBvcnQgbGF3cyBhcmUgc3ViamVjdCB0byBzZXZlcmUgY3JpbWluYWwg
cGVuYWx0aWVzLiBSZWNpcGllbnQgc2hhbGwgbm90IGV4cG9ydCwgcmUtZXhwb3J0LCBvciBvdGhl
cndpc2UgdHJhbnNmZXIgb3Igc2hhcmUgdGhpcyBkb2N1bWVudCB0byBhbnkgZm9yZWlnbiBwZXJz
b24gKGFzIGRlZmluZWQgYnkgVS5TLiBleHBvcnQgbGF3cykgd2l0aG91dCBhZHZhbmNlIHdyaXR0
ZW4gYXV0aG9yaXphdGlvbiBmcm9tIExlb1N0ZWxsYSBMTEMuDQo=

