Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DA6C47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:40:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D1B12070B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=msn.com header.i=@msn.com header.b="aTBHLSUi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D1B12070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=msn.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUCEV-0001ci-65
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 12:40:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50450)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <skizzato73@msn.com>) id 1jUCAy-0004kq-Sl
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:38:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <skizzato73@msn.com>) id 1jUC9M-00030a-PC
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:36:40 -0400
Received: from mail-vi1eur05olkn2043.outbound.protection.outlook.com
 ([40.92.90.43]:6497 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skizzato73@msn.com>)
 id 1jUC9M-0002zW-8J; Thu, 30 Apr 2020 12:35:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V0LKN0H6uUYEhFybWvR7o4Poa9vAumL1f+Hi4AH2zkVKOwbH5y55lgP2Ho644Fwr2gkl6k5WIiV1zWCmjY9qTFekt+W3GxiqBqUhnW7u1OxgTGJu20LI84vKeiv0/2t2vxIfGT0lW+14WdcepgR8H2nWxCAbxUAmfRlmFThio/RczNnmg64ZuzhW3Gju7v94mFUjYbkeNsXTMHY2XkM6TFLVZC9RUnK4gdfsCTZ4pu8/8I4vWAvNjOXPTz/gSKtD+ve8taC8qhGT154iYtfHp0xUyHp1vW7qExboTdhqVZxeEN9CaZRD1MVQ7w2+YXM0jnzSzNf060ioWWSXs6k7Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0aYuuHWmUeOw6JoSmV6Tm98QwqeAIp46q1HS6tOWdU=;
 b=IuODv2J98Ueuz81k0AQBhFpyyr2SKkV1PzqAbydYUUv2nx8eeQerp911vjP/dtMGwRYYjVVwvSTbL2omUDmuoajohXVODQA1g9GWi4UQAMzV648pmoIQkXy20RZbKdnfYwdj0MAxjRpqRtSkAKwpU/C5EPag31Jg7Myf3Av4+URFSAj2Ze0h+Q2+ic++Oi44Xm1oBzsvozRA86q6kxX1uMIpCkTSRKTtQBFhhHOaju8grc8T2EqS5oR76Ulqi7VYQRjPqeBQ+wfjmJsFszHU5BHLY1+H3QIBgsUt51T2uTUezpi9B+api6kgOdilUU8U84LooZtsJdtiA7nLzUk9zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=msn.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0aYuuHWmUeOw6JoSmV6Tm98QwqeAIp46q1HS6tOWdU=;
 b=aTBHLSUiMN8dg4Ah8E7Ig6oenw+2iLiuqRjRn1KEE+3ZyLO4HDGmcYC1w5024QD24Vtb9Q+xf0T8WEYKKiN9FPWip87kNAd5M1QaXNcgG+tJndOPF72nvrVKrtAZNm8dvM+xAUlpxj542eH3CEpOLf57iQIwoGxzi8j6luYTVj3R2QyeWRV0MFVGWFq5G0OezZbY2spyxwY7P6LMNYRA+KPc32gcvUync4+4N7TYTKZ1qTnOrQ4CktWZmnLSdqrWIDgaO5h7PFMDKjAHTBeuGaCa/CbTUqXCD0umIjmKm7bKw/aysQJaiarufGwMSSYtncKnfpy2XaDMgE32V+MWHA==
Received: from VI1EUR05FT029.eop-eur05.prod.protection.outlook.com
 (2a01:111:e400:fc12::47) by
 VI1EUR05HT066.eop-eur05.prod.protection.outlook.com (2a01:111:e400:fc12::206)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.15; Thu, 30 Apr
 2020 16:34:55 +0000
Received: from AM4PR07MB3506.eurprd07.prod.outlook.com
 (2a01:111:e400:fc12::51) by VI1EUR05FT029.mail.protection.outlook.com
 (2a01:111:e400:fc12::382) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.24 via Frontend
 Transport; Thu, 30 Apr 2020 16:34:55 +0000
Received: from AM4PR07MB3506.eurprd07.prod.outlook.com
 ([fe80::718e:de40:dfe9:9319]) by AM4PR07MB3506.eurprd07.prod.outlook.com
 ([fe80::718e:de40:dfe9:9319%5]) with mapi id 15.20.2937.028; Thu, 30 Apr 2020
 16:34:55 +0000
From: Dino Papararo <skizzato73@msn.com>
To: BALATON Zoltan <balaton@eik.bme.hu>,
 =?utf-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Subject: R: R: R: About hardfloat in ppc
Thread-Topic: R: R: About hardfloat in ppc
Thread-Index: AQHWHF7rwxop5oOlnUWWPH3hEGvks6iMt6WAgAAOeACAAAodAIAAqceAgAC9g4CAAau9MIAAHqMAgAApAWCAAEN9AIAAY0iAgAAg+QCAAGMZgIAAe5mAgAANuNA=
Date: Thu, 30 Apr 2020 16:34:55 +0000
Message-ID: <AM4PR07MB3506C091776962655FCE11E9CAAA0@AM4PR07MB3506.eurprd07.prod.outlook.com>
References: <CAE2XoE-ZSgtceSe5wYDm3cXf8+hTvJhD5PqZSrrFW5625LcSWg@mail.gmail.com>
 <87lfmhl0xa.fsf@linaro.org>
 <alpine.BSF.2.22.395.2004271212520.94232@zero.eik.bme.hu>
 <87imhlkwun.fsf@linaro.org>
 <CAE2XoE9hiw-ri66_xp3qNa5_Wx8ZfsQB9mqJdYR8VRm-KW830g@mail.gmail.com>
 <87ftcoknvu.fsf@linaro.org>
 <AM4PR07MB350653D5961DFCE441646131CAAD0@AM4PR07MB3506.eurprd07.prod.outlook.com>
 <871ro6ld2f.fsf@linaro.org>
 <AM4PR07MB350673696C7DE2CA16C9C685CAAD0@AM4PR07MB3506.eurprd07.prod.outlook.com>
 <87sggmjgit.fsf@linaro.org>
 <CAE2XoE8wFK1nOq3YXhB=iqTvqSDQk7Zzd35Tjzdd==v8ouMijA@mail.gmail.com>
 <43ac337c-752a-7151-1e88-de01949571de@linaro.org>
 <CAE2XoE-f_rkcnpQO1cHPUgdaWNAOvBRyUX1aj27UePd0Hkr=KQ@mail.gmail.com>
 <alpine.BSF.2.22.395.2004301721420.29315@zero.eik.bme.hu>
In-Reply-To: <alpine.BSF.2.22.395.2004301721420.29315@zero.eik.bme.hu>
Accept-Language: it-IT, en-US
Content-Language: it-IT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: OriginalChecksum:EF2543F715208A4956F99FAA337978BCB1757D24CE5803A27DE10F9C44424B51;
 UpperCasedChecksum:2D3619CCDD451D98D4F2856DF2239F9F40C5EB648D8509606AF58316CCA6CCF5;
 SizeAsReceived:7966; Count:45
x-tmn: [WcpTGwDqrRF9mOJwy9ObW5vXEChASOhY]
x-ms-publictraffictype: Email
x-incomingheadercount: 45
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: c20c4261-1c87-4981-c314-08d7ed246a4a
x-ms-traffictypediagnostic: VI1EUR05HT066:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c3oCcZfu+0ovYC8GwzCPOtHwRRZyBnHV8AloXUbykM+MQIoyh5gBak7eRIU5JtY6yqzwgEii0Vp+dptCs/ahzsc1VRiYH0ofm48UClRRE0H3MykVdpK07j8YOwcB1gHVH5w9dKDogbe5zouuG7hbxRtxnNXT+makngMoTNoDOYVO/fjFG6fonIEll5FfnDuCWJ/qDkG6T4nBp9UyQLYM/P+HDxieXwz9W8IDmps4coHATA/weJs/njwv7dWIh4ti
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:0; SRV:;
 IPV:NLI; SFV:NSPM; H:AM4PR07MB3506.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:; SFS:; DIR:OUT; SFP:1901; 
x-ms-exchange-antispam-messagedata: Qi14MO4oW4q388aQWZRHSvG4UYpMjdmcm4ZXHsHKBlBZIjuWq/SKhsekktAb53+r4Hq5JvbIxv6piSAQR6R7CTkNPIg6pEiBer4HGd/ow5vr+ewWP9ITh1VVtOW/m9ku7smFoiemt4XThPwiPLh1EQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: c20c4261-1c87-4981-c314-08d7ed246a4a
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2020 16:34:55.3365 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1EUR05HT066
Received-SPF: pass client-ip=40.92.90.43; envelope-from=skizzato73@msn.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 12:34:56
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.92.90.43
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Programmingkid <programmingkidx@gmail.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Howard Spoelstra <hsp.cat7@gmail.com>,
 =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

TWF5YmUgdGhlIGZhc3Rlc3Qgd2F5IHRvIGltcGxlbWVudCBoYXJkZmxvYXRzIGZvciBwcGMgY291
bGQgYmUgcnVuIHRoZW0gYnkgZGVmYXVsdCBhbmQgdW50aWwgc29tZSBmcHUgaW5zdHJ1Y3Rpb24g
cmVxdWVzdCBmb3IgRlBTQ1IgcmVnaXN0ZXIuDQpBdCB0aGlzIHRpbWUgcHJvYmFibHkgd2Ugd2Fu
dCB0byBjaGVjayBmb3Igc29tZSBleGNlcHRpb24uLiBzbyBRRU1VIGNvdWxkIGNvbWUgYmFjayB0
byBsYXN0IGZwdSBpbnN0cnVjdGlvbiBleGVjdXRlZCBhbmQgcmUtZXhlY3V0ZSBpdCBpbiBzb2Z0
ZmxvYXQgdGFraW5nIGNhcmUgdGhpcyB0aW1lIG9mIEZQU0NSIGZsYWdzLCB0aGVuIGNvbnRpbnVl
IGluIGhhcmRmbG9hdHMgdW5pdGwgYW5vdGhlciBpbnN0cnVjdGlvbiBsb29raW5nIGZvciBGUFND
UiByZWdpc3RlciBhbmQgc28gb24uLg0KDQpEaW5vDQoNCi0tLS0tTWVzc2FnZ2lvIG9yaWdpbmFs
ZS0tLS0tDQpEYTogQkFMQVRPTiBab2x0YW4gPGJhbGF0b25AZWlrLmJtZS5odT4gDQpJbnZpYXRv
OiBnaW92ZWTDrCAzMCBhcHJpbGUgMjAyMCAxNzozNg0KQTog572X5YuH5YiaKFlvbmdnYW5nIEx1
bykgPGx1b3lvbmdnYW5nQGdtYWlsLmNvbT4NCkNjOiBSaWNoYXJkIEhlbmRlcnNvbiA8cmljaGFy
ZC5oZW5kZXJzb25AbGluYXJvLm9yZz47IERpbm8gUGFwYXJhcm8gPHNraXp6YXRvNzNAbXNuLmNv
bT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsgUHJvZ3JhbW1pbmdraWQgPHByb2dyYW1taW5na2lk
eEBnbWFpbC5jb20+OyBxZW11LXBwY0Bub25nbnUub3JnOyBIb3dhcmQgU3BvZWxzdHJhIDxoc3Au
Y2F0N0BnbWFpbC5jb20+OyBBbGV4IEJlbm7DqWUgPGFsZXguYmVubmVlQGxpbmFyby5vcmc+DQpP
Z2dldHRvOiBSZTogUjogUjogQWJvdXQgaGFyZGZsb2F0IGluIHBwYw0KDQpPbiBUaHUsIDMwIEFw
ciAyMDIwLCDnvZfli4fliJooWW9uZ2dhbmcgTHVvKSB3cm90ZToNCj4gSSBwcm9wb3NlIGEgbmV3
IHdheSB0byBjb21wdXRpbmcgdGhlIGZsb2F0IGZsYWdzLCBXZSBwcmVzZXJ2ZSBhICBmbG9hdCAN
Cj4gY29tcHV0aW5nIGNhc2ggdHlwZWRlZiBzdHJ1Y3QgRnBSZWNvcmQgeyAgdWludDhfdCBvcDsN
Cj4gIGZsb2F0MzIgQTsNCj4gIGZsb2F0MzIgQjsNCj4gfSAgRnBSZWNvcmQ7DQo+IEZwUmVjb3Jk
IGZwX2NhY2hlWzEwMjRdOw0KPiBpbnQgZnBfY2FjaGVfbGVuZ3RoOw0KPiB1aW50MzJfdCBmcF9l
eGNlcHRpb25zOw0KPg0KPiAxLiBGb3IgZWFjaCBuZXcgZnAgb3BlcmF0aW9uIHdlIHB1c2ggaXQg
dG8gdGhlICBmcF9jYWNoZSwgMi4gT25jZSB3ZSANCj4gcmVhZCB0aGUgZnBfZXhjZXB0aW9ucyAs
IHRoZW4gd2UgcmUtY29tcHV0ZSB0aGUgZnBfZXhjZXB0aW9ucyBieSANCj4gcmUtcnVubmluZyB0
aGUgZnAgRnBSZWNvcmQgc2VxdWVuY2UuDQo+IGFuZCBjbGVhciAgZnBfY2FjaGVfbGVuZ3RoLg0K
PiAzLiBJZiB3ZSBjbGVhciB0aGUgZnBfZXhjZXB0aW9ucyAsIHRoZW4gd2Ugc2V0IGZwX2NhY2hl
X2xlbmd0aCB0byAwIA0KPiBhbmQgY2xlYXIgIGZwX2V4Y2VwdGlvbnMuDQo+IDQuIElmIHRoZSAg
ZnBfY2FjaGUgYXJlIGZ1bGwsIHRoZW4gd2UgcmUtY29tcHV0ZSB0aGUgZnBfZXhjZXB0aW9ucyBi
eSANCj4gcmUtcnVubmluZyB0aGUgZnAgRnBSZWNvcmQgc2VxdWVuY2UuDQo+DQo+IFdvdWxkIHRo
aXMgYmUgYSBnZW5lcmFsIG1ldGhvZCB0byB1c2UgaGFyZC1mbG9hdD8NCj4gVGhlIGNvbnN1ZWQg
dGltZSBzaG91bGQgYmUgIDIqaGFyZF9mbG9hdC4NCj4gQ29uc2lkZXJhdGluZyByZWFkIGZwX2V4
Y2VwdGlvbnMgYXJlIHJhcmUsIHRoZW4gdGhlIGFtb3J0aXplZCB0aW1lIA0KPiBjb21wbGV4aXR5
IHdvdWxkIGJlIDEgKiBoYXJkX2Zsb2F0Lg0KDQpJdCdzIGhhcmQgdG8gZ3Vlc3Mgd2hhdCB0aGUg
aGl0IHJhdGUgb2Ygc3VjaCBjYWNoZSB3b3VsZCBiZSBhbmQgaWYgaXQncyBsb3cgdGhlbiBtYW5h
Z2luZyB0aGUgY2FjaGUgaXMgcHJvYmFibHkgbW9yZSBleHBlbnNpdmUgdGhhbiBydW5uaW5nIHdp
dGggc29mdGZsb2F0LiBTbyB0byBldmFsdWF0ZSBhbnkgcHJvcG9zZWQgcGF0Y2ggd2UgYWxzbyBu
ZWVkIHNvbWUgYmVuY2htYXJrcyB3aGljaCB3ZSBjYW4gZXhwZXJpbWVudCB3aXRoIHRvIHRlbGwg
aWYgdGhlIHJlc3VsdHMgYXJlIGdvb2Qgb3Igbm90IG90aGVyd2lzZSB3ZSdyZSBqdXN0IGd1ZXNz
aW5nLiBBcmUgdGhlcmUgc29tZSBleGlzdGluZyB0ZXN0cyBhbmQgYmVuY2htYXJrcyB0aGF0IHdl
IGNhbiB1c2U/IEFsZXggbWVudGlvbmVkIGZwLWJlbmNoIEkgdGhpbmsgYW5kIHRvIGV2YWx1YXRl
IHRoZSBjb3JyZWN0bmVzcyBvZiB0aGUgRlAgaW1wbGVtZW50YXRpb24gSSd2ZSBzZWVuIHRoaXMg
b3RoZXINCmNvbnZlcnNhdGlvbjoNCg0KaHR0cHM6Ly9saXN0cy5ub25nbnUub3JnL2FyY2hpdmUv
aHRtbC9xZW11LWRldmVsLzIwMjAtMDQvbXNnMDUxMDcuaHRtbA0KaHR0cHM6Ly9saXN0cy5ub25n
bnUub3JnL2FyY2hpdmUvaHRtbC9xZW11LWRldmVsLzIwMjAtMDQvbXNnMDUxMjYuaHRtbA0KDQpJ
cyB0aGF0IHNvbWV0aGluZyB3ZSBjYW4gdXNlIGZvciBQUEMgYXMgd2VsbCB0byBjaGVjayB0aGUg
Y29ycmVjdG5lc3M/DQoNClNvIEkgdGhpbmsgYmVmb3JlIGltcGxlbWVudGluZyBhbnkgcG90ZW50
aWFsIHNvbHV0aW9uIHRoYXQgY2FtZSB1cCBpbiB0aGlzIGJyYWluc3Rvcm1pbmcgdGhlIGZpcnN0
IHN0ZXAgd291bGQgYmUgdG8gZ2V0IGFuZCBjb21waWxlIChvciB3cml0ZSBpZiBub3QNCmF2YWls
YWJsZSkgc29tZSB0ZXN0cyBhbmQgYmVuY2htYXJrczoNCg0KMS4gdGVzdGluZyBob3N0IGJlaGF2
aW91ciBmb3IgaW5leGFjdCBhbmQgY29tcGFyZSB0aGF0IGZvciBkaWZmZXJlbnQgYXJjaHMgMi4g
c29tZSBGUCB0ZXN0cyB0aGF0IGNhbiBiZSB1c2VkIHRvIGNvbXBhcmUgcmVzdWx0cyB3aXRoIFFF
TVUgYW5kIHJlYWwgQ1BVIHRvIGNoZWNrIGNvcnJlY3RuZXNzIG9mIGVtdWxhdGlvbiAoaWYgdGhl
c2UgY2hlY2sgZm9yIGluZXhhY3QgZGlmZmVyZW5jZXMgdGhlbiBjb3VsZCBiZSB1c2VkIGluc3Rl
YWQgb2YgMS4pIDMuIHNvbWUgYmVuY2htYXJrcyB0byBldmFsdWF0ZSBRRU1VIHBlcmZvcm1hbmNl
ICh0aGVzZSBjb3VsZCBiZSBzYW1lIGFzIEZQIHRlc3RzIG9yIHNvbWUgcmVhbCB3b3JsZCBGUCBo
ZWF2eSBhcHBsaWNhdGlvbnMpLg0KDQpUaGVuIHdlIGNhbiBzZWUgaWYgdGhlIHByb3Bvc2VkIHNv
bHV0aW9uIGlzIGZhc3RlciBhbmQgc3RpbGwgY29ycmVjdC4NCg0KUmVnYXJkcywNCkJBTEFUT04g
Wm9sdGFuDQo=

