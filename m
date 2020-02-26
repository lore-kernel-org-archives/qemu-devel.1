Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35BCC4BA18
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 18:16:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E00F24650
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 18:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=msn.com header.i=@msn.com header.b="Vhh89iiF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E00F24650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=msn.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j71E6-00076R-TL
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 13:16:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42553)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <skizzato73@msn.com>) id 1j71Co-0005vS-FC
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 13:14:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <skizzato73@msn.com>) id 1j71Cm-0003Ju-EC
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 13:14:45 -0500
Received: from mail-db5eur03olkn081e.outbound.protection.outlook.com
 ([2a01:111:f400:fe0a::81e]:14503
 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <skizzato73@msn.com>)
 id 1j71Cl-0003IM-VJ; Wed, 26 Feb 2020 13:14:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d6o0sxYWKEfcEX6jsulaeemeXK0Bsb7ERYC1+Qtc8CheTiOwCIiPZqQeNlDmo8R4FX6A4/Fu4u1nCItQQ/MSny3L5phQSBm/1FV0OrF2USfzLX9qpjlklDHfliLFFzpXjg5uskAepiYrk4rrUu7M86F4Ws+a4/NDIdSs30K6SBRXMHehvkudsIW1HojSzwaZ2c4rfMFIzh1OIv5MuKDlKDSVoKT/5RIlVKs1d4BK/nn3lWQ/3oSP4NTAPVt31pk8KyxC1pedZ1MR9+mgOzjf/aqcF0KvCRbe6Cwnlq9k5JP/EXMTcPel3/nyq1Gp0yxRtJeyYNjDEnZC9oix/UDl0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TD8FW+rhzH1+3oMnkX4/T0dgdFtmwAPE17iBHAGQ4Lk=;
 b=BdEt+NT6RGHXgltx8hoOY8p8fgzWAVkONQ5N29CfMFtLACFDKuCYtj0ltVrkaioIRKkcWwnb3O2ep0bUfYUgxwaoRDqjKaGZvpDYcm57L+gFx/bVU6YymA0VV561NO5oP1+JNO5EfdNmgXSG32WcGjKWOyDJ8T8e/gxBJ6je3VN/9FhHzGz0OzjAECSgoSQOPJY5UFxhqFYwT674JToZDWJIj4r0OIA/npmMSpKZUzkMmldVqXL5l2Mnug4uIjRdGIcBK91R+VSfpyoEuS6EG0Qhhl/l75udMqHEwjhoMYNE2LBskJ1x0zbnz4TQDATVrscShIaLrrUqEs3+GJDm2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=msn.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TD8FW+rhzH1+3oMnkX4/T0dgdFtmwAPE17iBHAGQ4Lk=;
 b=Vhh89iiFjMXnP+f1kyvYLfklGD+XLw+uCCWNpiIUsizgRQplr1ukjjrZwSbGSX+IE0SBvtos1wYfTAA9UE02HdeZQBW2kae8fxAGbTQkCiL6XEXr3UbNM3NvyWGcxN45yISFW7AlW1byL2GdW1+QUe6lA86duBjw/9FuhQDmK/f4baq692QCL6wN8FMmc8k79nJ5++YH3nSeV67M2Cw0aas0ZYvZ/uXhARYFlGYsSbpA72aDJSRNtiJjMgpvcBp1JaVHfvPqyAQW+ooGVOAv/r7h2W75kx1NteHCd/4aOnTqQkqGgnf7QEZKSPSYCHoMa07e9jKNTGzHZmW1F8MScQ==
Received: from VE1EUR03FT049.eop-EUR03.prod.protection.outlook.com
 (2a01:111:e400:7e09::36) by
 VE1EUR03HT070.eop-EUR03.prod.protection.outlook.com (2a01:111:e400:7e09::468)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.19; Wed, 26 Feb
 2020 18:14:41 +0000
Received: from AM4PR07MB3506.eurprd07.prod.outlook.com (10.152.18.55) by
 VE1EUR03FT049.mail.protection.outlook.com (10.152.19.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15 via Frontend Transport; Wed, 26 Feb 2020 18:14:41 +0000
Received: from AM4PR07MB3506.eurprd07.prod.outlook.com
 ([fe80::1d5b:5d66:1368:39c4]) by AM4PR07MB3506.eurprd07.prod.outlook.com
 ([fe80::1d5b:5d66:1368:39c4%3]) with mapi id 15.20.2772.012; Wed, 26 Feb 2020
 18:14:40 +0000
From: Dino Papararo <skizzato73@msn.com>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>, G 3
 <programmingkidx@gmail.com>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, Mark Cave-Ayland
 <mark.cave-ayland@ilande.co.uk>, "cota@braap.org" <cota@braap.org>
Subject: R: R: [RFC PATCH v2] target/ppc: Enable hardfloat for PPC
Thread-Topic: R: [RFC PATCH v2] target/ppc: Enable hardfloat for PPC
Thread-Index: AQHV5n9iGhp7OH0uf0GD6Z/qd6KtDaghy0MAgADcEYCACJz9gIAAl6SAgAF7IoCAAAudgIAAGcEAgAAA5vCAABfAgIAAFvgAgAAUhwCAAAZhAIAABwoA
Date: Wed, 26 Feb 2020 18:14:40 +0000
Message-ID: <AM4PR07MB350693B43AE3987D317948ADCAEA0@AM4PR07MB3506.eurprd07.prod.outlook.com>
References: <20200218171702.979F074637D@zero.eik.bme.hu>
 <CD566CEF-6844-455C-B9C7-E5DFDE50E770@gmail.com>
 <alpine.BSF.2.22.395.2002191538190.33319@zero.eik.bme.hu>
 <1BC2E9E9-A694-4ED3-BD3D-D731F23B7245@gmail.com>
 <alpine.BSF.2.22.395.2002251241080.22173@zero.eik.bme.hu>
 <3539F747-145F-49CC-B494-C9794A8ABABA@gmail.com>
 <AM6PR03MB5525DE221E3E7E595893DF4DC8EA0@AM6PR03MB5525.eurprd03.prod.outlook.com>
 <AM4PR07MB350651FBB263FEEDB857CBFFCAEA0@AM4PR07MB3506.eurprd07.prod.outlook.com>
 <87eeuhxw0y.fsf@linaro.org>
 <CAL1e-=gGsEV4_a4gJr2x0L3r_UK7isnpjOWoJRCDhqpG_XT3Ww@mail.gmail.com>
 <CAKyx-3MCENJREWm0BxO3ES9sDB04KV3FzYoVFKK20Fh_iwh7wg@mail.gmail.com>
 <CAL1e-=hhhw4x4H24DWg6pTp9DmjyfwM6GFMOmWasKC66x5tR4Q@mail.gmail.com>
In-Reply-To: <CAL1e-=hhhw4x4H24DWg6pTp9DmjyfwM6GFMOmWasKC66x5tR4Q@mail.gmail.com>
Accept-Language: it-IT, en-US
Content-Language: it-IT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: OriginalChecksum:E816216ABB6A49D00192310E6C62607B4C9A50904CFDF13846A9D0B24B50244D;
 UpperCasedChecksum:3AB0D4F0E2FF3226045D301464B7DEB79301B7A274925D0E7D0BB0069FDBDCE1;
 SizeAsReceived:8155; Count:45
x-tmn: [oJcIktHTrKDlgnjgaT98t5ApgbN8FeLP]
x-ms-publictraffictype: Email
x-incomingheadercount: 45
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: d41e0263-3fa6-4d99-9af2-08d7bae7bf86
x-ms-exchange-slblob-mailprops: b0omxY8GwpYF0uojEr9BbXwzL3CXa5i7yvh4GwAt/2iBrx6NtqtpOk/sWbdNgvY4vzOj60wZf/nGB5zg3zNmgbJ6/0R+/uXEu2hDyjUUv8QGWXMk6od0cBmtXuu/0A7FF5B7vvevE3rP3OJc5bKD+xv28eKeAcDAhhVh61Zf6twESfGwH5sB5Eb1w8kfjDWG9PBS+kS4fzayHROMgceni7CkdU7yPYcQ5uXROn3wxz8BKLuii/3F1wW6+BAWUBJxMxjoUHH8oY3PAHEcwmQNuNiGp4uLDdGpFH2dD4+revjpOxngg0lkxrHlC8vL46wOCGrvKjwJczJW4RKxVMyREAdRBZAcN0o73YpRc4Ngfcqifk8unNEoPucLf6V3eUvhYup2jN4CHxPu5qHqVc/HzryeaXEyCvLAaMnEzHBlocMKjSMZgL58u/T0tLZC9Zn3VYsqmBckwomPNBDSSFa8vAErR0iIxORsq39rOjwBcZq4p8mmBYTVwYtEb0VU7/WZcbp9NYbXn1P8kibiLamRLzL37c0ehpwjoQVhXnXrqEvgEayy/bDR1kmzYoIDbiAaKs9FLpZDr7uUV3BcT20snQ7+7PZTMQD58R+BdX3laH9nmLdMfyfaPAxcTG9GaiPmTtzWEvaBC9jlyHQqdjy3XX5TqFgP601cOAXhUZDMENN0o/PJ4KTV35gXtpUxpviYuUwnft9SqhxLQ1Sq6sk3IDouWuyf03VFWBHMHjXmq/tgwW6siU6nyaMQEdxkSCbT
x-ms-traffictypediagnostic: VE1EUR03HT070:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Rb25AX3OHRpe3FkfZ06MJUnOfYKUsksYSe+K78+j7PIPmf9yO5X9k13K5/Ig6q52GDjOHalB5A7ffrIJWF99KHiQmz/IaRwXIRziC3q8XM0d+mWO6wN7ItlcjDmQ6vRkqJSFi210Ass1Tmy98C4zFK/Bt3QDWnC+PmHQ4kpmnZSpyjhLVqVvT1pIP16WyOz7
x-ms-exchange-antispam-messagedata: W6JJdKObb1tIBRnc8AUAxvBggn3fiCawbN7q8D6wsWZpNMqFI3+qEg6+v5kS/aID3YU+bdEeVdezOI47XijeZN8a6/ssXmLM2YEBiwF4FQuFktNUP0qpdIX2pIL+NEErg5RVvkQ/azUlG4iOkXBwsA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: d41e0263-3fa6-4d99-9af2-08d7bae7bf86
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2020 18:14:40.8736 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1EUR03HT070
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe0a::81e
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Programmingkid <programmingkidx@gmail.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Howard Spoelstra <hsp.cat7@gmail.com>, luigi burdo <intermediadc@hotmail.com>,
 =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SSB0aGluayB3ZSBhbGwgYWdyZWUgdGhlIGJlc3Qgc29sdXRpb24gaXMgdG8gcmVzb2x2ZSBwb3dl
cnBjIGlzc3VlcyBhYm91dCBoYXJkZmxvYXQgY3VycmVudCBpbXBsZW1lbnRhdGlvbi4NCkkgdGhp
bmsgYWxzbyBwb3dlcnBjIGlzIGFuIGltcG9ydGFudCBicmFuY2ggb2YgcWVtdSwgZm9yIGh5c3Rv
cmljYWwsIHByZXNlbnQgYW5kICh3aHkgbm90PykgZnV0dXJlIHJlYXNvbnMsIGFuZCBpdCBtdXN0
IE5PVCBiZSBsZWZ0IGJlaGluZC4NClNvIEkgd291bGQgaW52aXRlIGJlc3QgUWVtdSBjb21tdW5p
dHkncyBza2lsbGVkIHByb2dyYW1tZXJzIHRvIHdvcmsgb24gdGhpcyBhbmQgc29sdmUgdGhlIGlz
c3VlIG1heWJlIGluIGZldyBkYXlzLg0KVGhlIHNhbWUgZ3JvdXAgd2hvIHdvcmtlZCBvbiByZWNl
bnQgYWx0aXZlYyBvcHRpbWl6YXRpb25zIGlzIGFibGUgdG8gbWFrZSBhIGdvb2QgcGF0Y2ggZXZl
biBmb3IgdGhpcy4NCg0KSW4gYSBzdWJvcmRpbmF0ZSB3YXkgSSdkIGxpa2UgdG8gaW1wbGVtZW50
IGFueXdheSBoYXJkZmxvYXQgc3VwcG9ydCBmb3IgcG93ZXJwYywgYWR2aXNpbmcgdXNlcnMgYWJv
dXQgaW5hY2N1cmFuY3kgb2YgcmVzdWx0cy9mbGFncyBhbmQgbGV0dGluZyB0aGVtIGNob29zZS4N
Ck9mIGNvdXJzZSBJIHVuZGVyc3RhbmQsIGFuZCBpbiBwYXJ0IGFncmVlLCBvbiBhbGwgeW91ciBv
YmplY3Rpb25zLiANClNpbXBseSBJIHByZWZlciBoYXZlIGFsd2F5cyBhIGNob2ljZS4NCg0KQmVz
dCBSZWdhcmRzLA0KRGlubyBQYXBhcmFybw0KDQotLS0tLU1lc3NhZ2dpbyBvcmlnaW5hbGUtLS0t
LQ0KRGE6IEFsZWtzYW5kYXIgTWFya292aWMgPGFsZWtzYW5kYXIubS5tYWlsQGdtYWlsLmNvbT4g
DQpJbnZpYXRvOiBtZXJjb2xlZMOsIDI2IGZlYmJyYWlvIDIwMjAgMTg6MjcNCkE6IEcgMyA8cHJv
Z3JhbW1pbmdraWR4QGdtYWlsLmNvbT4NCkNjOiBBbGV4IEJlbm7DqWUgPGFsZXguYmVubmVlQGxp
bmFyby5vcmc+OyBEaW5vIFBhcGFyYXJvIDxza2l6emF0bzczQG1zbi5jb20+OyBRRU1VIERldmVs
b3BlcnMgPHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz47IHFlbXUtcHBjQG5vbmdudS5vcmc7IEhvd2Fy
ZCBTcG9lbHN0cmEgPGhzcC5jYXQ3QGdtYWlsLmNvbT47IGx1aWdpIGJ1cmRvIDxpbnRlcm1lZGlh
ZGNAaG90bWFpbC5jb20+OyBEYXZpZCBHaWJzb24gPGRhdmlkQGdpYnNvbi5kcm9wYmVhci5pZC5h
dT4NCk9nZ2V0dG86IFJlOiBSOiBbUkZDIFBBVENIIHYyXSB0YXJnZXQvcHBjOiBFbmFibGUgaGFy
ZGZsb2F0IGZvciBQUEMNCg0KT24gV2VkLCBGZWIgMjYsIDIwMjAgYXQgNjowNCBQTSBHIDMgPHBy
b2dyYW1taW5na2lkeEBnbWFpbC5jb20+IHdyb3RlOg0KPg0KPiBBY2N1cmFjeSBpcyBhbiBpbXBv
cnRhbnQgcGFydCBvZiB0aGUgSUVFRSA3NTQgZmxvYXRpbmcgcG9pbnQgc3RhbmRhcmQuIFRoZSB3
aG9sZSBwdXJwb3NlIG9mIHRoaXMgc3RhbmRhcmQgaXMgdG8gZW5zdXJlIGZsb2F0aW5nIHBvaW50
IGNhbGN1bGF0aW9ucyBhcmUgY29uc2lzdGVudCBhY3Jvc3MgbXVsdGlwbGUgQ1BVcy4gSSBiZWxp
ZXZlIHJlZmVycmluZyB0byB0aGlzIHBhdGNoIGFzIGluYWNjdXJhdGUgaXMgaXRzZWxmIGluYWNj
dXJhdGUuIFRoYXQgZ2l2ZXMgdGhlIGltcHJlc3Npb24gdGhhdCB0aGlzIHBhdGNoIHByb2R1Y2Vz
IGNhbGN1bGF0aW9ucyB0aGF0IGFyZSBub3QgaW5saW5lIHdpdGggZXN0YWJsaXNoZWQgc3RhbmRh
cmRzLiBUaGlzIGlzIG5vdCB0cnVlLiBUaGUgb25seSBwYXJ0IG9mIHRoaXMgcGF0Y2ggdGhhdCB3
aWxsIHByb2R1Y2UgaW5jb3JyZWN0IHZhbHVlcyBhcmUgdGhlIGZsYWdzLiBUaGVyZSAqbWF5KiBi
ZSBhIHByb2dyYW0gb3IgdHdvIG91dCB0aGVyZSB0aGF0IGRlcGVuZCBvbiB0aGVzZSBmbGFncywg
YnV0IGZvciB0aGUgbWFqb3JpdHkgb2YgcHJvZ3JhbXMgdGhhdCBvbmx5IGNhcmUgYWJvdXQgYmFz
aWMgZmxvYXRpbmcgcG9pbnQgYXJpdGhtZXRpYyB0aGlzIHBhdGNoIHdpbGwgcHJvZHVjZSBjb3Jy
ZWN0IHZhbHVlcy4gQ3VycmVudGx5IHRoZSBlbXVsYXRlZCBQb3dlclBDJ3MgRlBVIGFscmVhZHkg
cHJvZHVjZXMgd3JvbmcgdmFsdWVzIGZvciB0aGUgZmxhZ3MuIFRoaXMgcGF0Y2ggZG9lcyBzZXQg
dGhlIEluZXhhY3QgZmxhZyAod2hpY2ggSSBkb24ndCBsaWtlKSwgYnV0IHNpbmNlIEkgaGF2ZSBu
ZXZlciBlbmNvdW50ZXJlZCBhbnkgc291cmNlIGNvZGUgdGhhdCBjYXJlcyBmb3IgdGhpcyBmbGFn
LCBJIGNhbiBsZXQgaXQgZ28uIEkgdGhpbmsgZ2l2aW5nIHRoZSB1c2VyIHRoZSBhYmlsaXR5IHRv
IGRlY2lkZSB3aGljaCBvcHRpb24gdG8gdXNlIGlzIHRoZSBiZXN0IHRoaW5nIHRvIGRvLg0KPg0K
DQpGcm9tIHRoZSBleHBlcmltZW50cyBkZXNjcmliZWQgYWJvdmUsIHRoZSBwYXRjaCBpbiBxdWVz
dGlvbiBjaGFuZ2VzIHRoZSBiZWhhdmlvciBvZiBhcHBsaWNhdGlvbnMgKGZvciBleGFtcGxlLCBz
b3VuZCBpcyBkaWZmZXJlbnQgd2l0aCBhbmQgd2l0aG91dCB0aGUgcGF0Y2gpLCB3aGljaCBpcyBp
biBjb250cmFkaWN0aW9uIHdpdGggeW91ciBjbGFpbSB0aGF0IHlvdSAibmV2ZXIgZW5jb3VudGVy
ZWQgYW55IHNvdXJjZSBjb2RlIHRoYXQgY2FyZXMgZm9yIHRoaXMgZmxhZyIgYW5kIHRoYXQgInRo
ZSBvbmx5IHBhcnQgb2YgdGhpcyBwYXRjaCB0aGF0IHdpbGwgcHJvZHVjZSBpbmNvcnJlY3QgdmFs
dWVzIGFyZSB0aGUgZmxhZ3MiLg0KDQpJbiBvdGhlciB3b3JkcywgYW5kIHBsYXlpbmcgZnVydGhl
ciB3aXRoIHRoZW06DQoNClRoZSBjbGFpbSB0aGF0ICJyZWZlcnJpbmcgdG8gdGhpcyBwYXRjaCBh
cyBpbmFjY3VyYXRlIGlzIGl0c2VsZiBpbmFjY3VyYXRlIiBpcyBpdHNlbGYgaW5hY2N1cmF0ZS4N
Cg0KQmVzdCByZWdhcmRzLA0KQWxla3NhbmRhcg0KDQoNCj4gT24gV2VkLCBGZWIgMjYsIDIwMjAg
YXQgMTA6NTEgQU0gQWxla3NhbmRhciBNYXJrb3ZpYyA8YWxla3NhbmRhci5tLm1haWxAZ21haWwu
Y29tPiB3cm90ZToNCj4+DQo+Pg0KPj4NCj4+IE9uIFdlZCwgRmViIDI2LCAyMDIwIGF0IDM6Mjkg
UE0gQWxleCBCZW5uw6llIDxhbGV4LmJlbm5lZUBsaW5hcm8ub3JnPiB3cm90ZToNCj4+ID4NCj4+
ID4NCj4+ID4gRGlubyBQYXBhcmFybyA8c2tpenphdG83M0Btc24uY29tPiB3cml0ZXM6DQo+PiA+
DQo+PiA+ID4gUGxlYXNlIGxldCdzIGdvIHdpdGggaGFyZGZsb2F0IHBwcyBzdXBwb3J0LCBpdCdz
IHJlYWxseSBhIGdvb2QgZmVhdHVyZSB0byBpbXBsZW1lbnQuDQo+PiA+ID4gRXZlbiBpZiBpbiBh
IGZpcnN0IHN0ZXAgaXQgY291bGQgbGVhZCB0byBpbmFjY3VyYWN5IHJlc3VsdHMsIA0KPj4gPiA+
IGxhdGVyIGl0IGNvdWxkIHNvbHZlZCB3aXRoIG90aGVyIHBhdGNoZXMuDQo+PiA+DQo+PiA+IFRo
YXQncyB0aGUgd3Jvbmcgd2F5IGFyb3VuZC4gV2UgaGF2ZSByZWdyZXNzaW9uIHRlc3RzIGZvciBh
IHJlYXNvbi4NCj4+DQo+PiBJIHRlbmQgdG8gYWdyZWUgd2l0aCBBbGV4IGhlcmUsIGFuZCBhZGRp
dGlvbmFsbHkgd2FudCB0byBleHBhbmQgbW9yZSANCj4+IG9uIHRoaXMgdG9waWMuDQo+Pg0KPj4g
SW4gbXkgdmlldzogKHRoYXQgSSB0aGluayBpcyBhdCBsZWFzdCB2ZXJ5IGNsb3NlIHRvIHRoZSBj
b21tdW5pdHkgDQo+PiBjb25zZW5zdXMpDQo+Pg0KPj4gVGhpcyBpcyAqbm90KiBhIHBwYy1zcGVj
aWZpYyBpc3N1ZS4gVGhlcmUgZXhpc3QgYSBwcmluY2lwbGUgYWNyb3NzIA0KPj4gYWxsIHRhcmdl
dHMgdGhhdCBRRU1VIEZQVSBjYWxjdWxhdGlvbiBtdXN0IGJlIGFjY3VyYXRlIC0gZXhhY3RseSBh
cyANCj4+IHNwZWNpZmllZCBpbiBhbnkgYXBwbGljYWJsZSBwYXJ0aWN1bGFyIElTQSBkb2N1bWVu
dC4gQW55IGRpc2NyZXBhbmN5IGlzIGFuIG91dHJpZ2h0IGJ1Zy4NCj4+DQo+PiBXZSBldmVuIHJl
Y2VudGx5IGhhZCBzZXZlcmFsIHBhdGNoZXMgZm9yIEZQVSBpbiBwcGMgdGFyZ2V0IHRoYXQgDQo+
PiBoYW5kbGVkIHNvbWUgZmFpcmx5IG9ic2N1cmUgY2FzZXMgb2YgaW5hY2N1cmFjaWVzLCBJIGJl
bGlldmUgdGhleSANCj4+IHdlcmUgYXV0aG9yZWQgYnkgUGF1bCBDbGFya2UsIHNvIHRoZXJlIGFy
ZSBwZW9wbGUgaW4gcHBjIGNvbW11bml0eSANCj4+IHRoYXQgY2FyZSBhYm91dCBGUFUgYWNjdXJh
Y3kgKGFzIEkgZ3Vlc3MgaXMgdGhlIGNhc2UgZm9yIGFueSB0YXJnZXQpLg0KPj4NCj4+IFRoZXJl
IHNob3VsZG4ndCBiZSBhIHRhcmdldCB0aGF0IGRlY2lkZXMgYnkgaXRzZWxmIGFuZCB3aXRoaW4g
aXRzZWxmIA0KPj4gIm9rLCB3ZSBkb24ndCBuZWVkIGFjY3VyYWN5LCBsZXQncyB0cmFkZSBpdCBm
b3Igc3BlZWQiLiBUaGlzIHZpb2xhdGVzIA0KPj4gdGhlIGFyY2hpdGVjdHVyZSBvZiBRRU1VLiBQ
bGVhc2UgYWxsb3cgdGhhdCBmb3IgYW55IGdpdmVuIHNvZnR3YXJlIA0KPj4gcHJvamVjdCwgdGhl
cmUgaXMgYW4gYXJjaGl0ZWN0dXJlIHRoYXQgc2hvdWxkIGJlIHJlc3BlY3RlZC4NCj4+DQo+PiBU
aGlzIGRvZXNuJ3QgbWVhbiB0aGF0IGFueWJvZHkncyBleHBlcmltZW50YXRpb24gaXMgZGlzY291
cmFnZWQuIA0KPj4gTm8tb25lIGNhbiBzdG9wIGFueWJvZHkgZnJvbSBmb3JraW5nIGZyb20gUUVN
VSB1cHN0cmVhbSB0cmVlIGFuZCBkbyANCj4+IHdoYXRldmVyIGlzIHdhbnRlZC4NCj4+DQo+PiBC
dXQsIHRoaXMgZG9lc24ndCBtZWFuIHN1Y2ggZXhwZXJpbWVudGF0aW9uIHdpbGwgYmUgdXBzdHJl
YW1lZC4gUUVNVSANCj4+IHVwc3RyZWFtIHNob3VsZCBiZSBjb2xsZWN0aW5nIHBsYWNlIGZvciB0
aGUgYmVzdCBpZGVhcyBhbmQgDQo+PiBpbXBsZW1lbnRhdGlvbnMsIG5vdCBmb3IgYXJiaXRyYXJ5
IGV4cGVyaW1lbnRhdGlvbnMuDQo+Pg0KPj4gQmVzdCByZWdhcmRzLA0KPj4gQWxla3NhbmRhcg0K
Pj4NCj4+DQo+PiA+IEknbGwgaGFwcGlseSBhY2NlcHQgcGF0Y2hlcyB0byB0dXJuIG9uIGhhcmRm
bG9hdCBmb3IgUFBDIGlmOg0KPj4gPg0KPj4gPiAgYSkgdGhleSBkb24ndCBjYXVzZSByZWdyZXNz
aW9ucyBpbiBvdXIgZmFpcmx5IGV4dGVuc2l2ZSBmbG9hdGluZyANCj4+ID4gcG9pbnQgIHRlc3Rz
DQo+PiA+ICBiKSB0aGUgUFBDIG1haW50YWluZXJzIGFyZSBoYXBweSB3aXRoIHRoZSBuZXcgcGVy
Zm9ybWFuY2UgcHJvZmlsZQ0KPj4gPg0KPj4gPiBUaGUgd2F5IGZvcndhcmQgd291bGQgYmUgdG86
DQo+PiA+DQo+PiA+ICAxLiBwYXRjaCB0byBkcm9wICNpZiBkZWZpbmVkKFRBUkdFVF9QUEMpIHx8
IGRlZmluZWQoX19GQVNUX01BVEhfXykgIA0KPj4gPiAyLiBhdWRpdCB0YXJnZXQvcHBjL2ZwdV9o
ZWxwZXIuYyB3LnIudCBjaGlwIG1hbnVhbCBhbmQgZml4IGFueSANCj4+ID4gdW5uZWVkZWQgIHNw
bGF0dGluZyBvZiBmbGFncyAoaWYgYW55KSAgMy4gbWVhc3VyZSB0aGUgYmVmb3JlL2FmdGVyIA0K
Pj4gPiBwZXJmb3JtYW5jZSBlZmZlY3QgYW5kIGRlY2lkZSBpZiBvbiBiYWxhbmNlICBpdCdzIHdv
cnRoIGtlZXBpbmcNCj4+ID4NCj4+ID4gPiBJIHRoaW5rIGl0J3MgaW1wb3J0YW50IGZvciBxZW11
IHRvIGFzIGdsb2JhbCBhcyBwb3NzaWJsZSBhbmQgDQo+PiA+ID4gZG9uJ3QgdGFyZ2V0IG9ubHkg
cmVjZW50IGhhcmR3YXJlLg0KPj4gPg0KPj4gPiBBcmUgeW91IHJlZmVycmluZyB0byBndWVzdHMg
b3IgaG9zdHM/IEZvciBndWVzdHMgd2Ugd2lsbCBhbHdheXMgDQo+PiA+IGZhdm91ciBhY2N1cmFj
eSBvZiBzcGVlZCBvZiBlbXVsYXRpb24uIEZvciBob3N0cyB3ZSBuZWVkIHRvIGhhdmUgDQo+PiA+
IElFRUUgY29tcGxpYW50IEZQVSBIVyB0byBldmVuIHN0YW5kIGEgY2hhbmNlIG9mIHVzaW5nIGhh
cmRmbG9hdC4NCj4+ID4NCj4+ID4gLS0NCj4+ID4gQWxleCBCZW5uw6llDQo+PiA+DQo=

