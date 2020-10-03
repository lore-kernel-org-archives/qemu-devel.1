Return-Path: <SRS0=Kewn=DL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21536C4363C
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 19:42:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 691E12067C
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 19:42:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 691E12067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=outlook.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kP9tk-0004Xg-Tw
	for qemu-devel@archiver.kernel.org; Sun, 04 Oct 2020 15:42:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58164)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heecheol.yang@outlook.com>)
 id 1kP9sB-00042z-TM
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 15:40:43 -0400
Received: from mail-mw2nam10olkn2087.outbound.protection.outlook.com
 ([40.92.42.87]:49121 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heecheol.yang@outlook.com>)
 id 1kP9s8-0002Bd-Ni
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 15:40:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y4SBZUdGM3mhLz8rEcy/EJKAuuiHZEgB2oioXLOpRu4KPeLeWNOL4vh+38tDM759FkhmgXsMMYUoGoR5Ttd9/p/Mey7AgknZlfCs0fw6/PxKEiie2RyvIo6xqSFGegn6aFU/tW5G3KglajCzffGXbs93DH22w0pGKJwdtCwD3W5TtfNRGmsboF80y00mAPyFPJ1EOFc+1g5l8gLoGI1I/83se4Ao0sqP7t59cciOacQivrSzoKK20ie0hIfzmhRPwETfRQFt6dIrL3UyX3zE4a9bNclLDGG4My8FBWdcW0NSxfBAKYfpfDLtJkkg2Te5YjMpbWfWDU98fIveNG37eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6tSfAHg3N4BP2/y2VHKhB+VguW7zHCZvKUH4nQJIRSg=;
 b=AfrrSWn1OmWCtwxObXoLZ1ufgfCeBqLlSv6gpWdyxjmJ8Kho4hYdW0448ohzzSdg2rAjjAFUOIZoIQ+SnbY1aceRpFmy70/9GI9/AVHZyGgYfOHUN3i8VXSDoElVIAbUXlHE7wp6lb9hgBB5kIX0YE0J+8rKGh4Ythkiloip2Wu/k89mXpG2vVpewpeMjdFwrEjIzrKOtV8vu0L98T4zavvDF5IadTzpsdEbRFf1ecluyudaUR5krp/lSgIlQ1GdIBG56Vx9ANMFE4Ta48QNBG+5gsMuzia5dg00+eRK39xyDGRVgy0rWf85DwQ6LjzLuRdu2jH/x6vGqcQBXkamKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6tSfAHg3N4BP2/y2VHKhB+VguW7zHCZvKUH4nQJIRSg=;
 b=FRgNVnp8mjjD+xQjubArTOKZEWC7ITfoskug8YqKi4Vg9l9nU1ozcO4EZAWkyUC1gxyIseTFh3btfSOb0bwpq7G3b3EUmmm5XLZSmopEZf847SpAs62+9jKQrbuLrQlwh4tjmCNMqMEBIx9n7VqdnIgAfWsQjuBeSaCcZ1rHPUtQjT92pfH6WxfASR8kNPiki7pkp3h3SkbGpA9zXvNi8TpeQXIfRlqVECosoMw3UcKS76JxaNFpvP3hIb/4Uwi9p8GTLiNgt0d2OjMTka/wLdiLtmDeCwLSVlsj/h1QpXahbpRybn/HZiRIEWQhyw46GQYuaMBW4TIAw9Ag96/GSQ==
Received: from DM6NAM10FT015.eop-nam10.prod.protection.outlook.com
 (2a01:111:e400:7e86::50) by
 DM6NAM10HT028.eop-nam10.prod.protection.outlook.com (2a01:111:e400:7e86::108)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34; Sat, 3 Oct
 2020 22:02:02 +0000
Received: from DM6PR16MB2473.namprd16.prod.outlook.com
 (2a01:111:e400:7e86::53) by DM6NAM10FT015.mail.protection.outlook.com
 (2a01:111:e400:7e86::100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34 via Frontend
 Transport; Sat, 3 Oct 2020 22:02:02 +0000
Received: from DM6PR16MB2473.namprd16.prod.outlook.com
 ([fe80::ec2c:246a:b4d4:48b1]) by DM6PR16MB2473.namprd16.prod.outlook.com
 ([fe80::ec2c:246a:b4d4:48b1%3]) with mapi id 15.20.3433.039; Sat, 3 Oct 2020
 22:02:02 +0000
From: Hee-cheol Yang <heecheol.yang@outlook.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Hee-cheol Yang
 <heecheol.yang@outlook.com>
Subject: RE: [PATCH v2] hw/avr: Add limited support for avr gpio registers
Thread-Topic: [PATCH v2] hw/avr: Add limited support for avr gpio registers
Thread-Index: AQHWmYI5aN4/7/KuykiauBZvsOOin6mGK+gAgABCuAs=
Date: Sat, 3 Oct 2020 22:02:02 +0000
Message-ID: <DM6PR16MB24739B6BF93E480B6873A216E60E0@DM6PR16MB2473.namprd16.prod.outlook.com>
References: <DM6PR16MB2473C5A77E009CA2FEF3D8ECE60E0@DM6PR16MB2473.namprd16.prod.outlook.com>,
 <77f59e9a-861e-f580-57f4-72912ba2566a@amsat.org>
In-Reply-To: <77f59e9a-861e-f580-57f4-72912ba2566a@amsat.org>
Accept-Language: ko-KR, en-US
Content-Language: ko-KR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: OriginalChecksum:D321509D9F057D3F408ED59A4793ADE3C13C9C2FE79BEB8C1F29E63019248244;
 UpperCasedChecksum:4A5C3FD3F23913A8803E3CCD857286E0191B49B7DBCECA127B1C2F0517B48AAE;
 SizeAsReceived:7138; Count:45
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [URA/jH/0m3WV7Rbf63u3b1gQLNk3vNVx]
x-ms-publictraffictype: Email
x-incomingheadercount: 45
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 1890bc27-4e73-45bd-08ab-08d867e7f5a2
x-ms-exchange-slblob-mailprops: ZK1LJjhzK/D0dphKRG3Uc6K54Ygkcp4hzJXdQT/ClpVR2n0WlZYv7C2fJs8TZIBay0SdAlDtaQU0yHg3CIvUqGeq17dvqiswo0yDaiDJ0V6kVoM5UV3PXgtbyFj6J7af3hsSKke4mvFV07Pvc3lxM0x9yV1U9xABmHkVmYH+iBnsLE1CE3spI4ArmnYD9reBd2401v1Gc6hzkW5qu+ysfYsIv/jLtBuj6+QiIkYf399Iw8UybPVKF6dss6Fwfjes46QSYjKSZAydxPGONlI/FThaU7/SFT/by5SNJHtHN1Qnz3bB+wB0MAPfzVhCIlNWJhXG05RD90uGHhVN6FcuZlyfWhK17pAfH7g/Dczl4vJvRnH9Iaa8wb2A8YjHTDYV/xYOL/TIZsWjzpa24NRJoUJab++zMrfI6tbkysNkyJC5eGvevYpBhE0yiUeY2XtRqHEn6lKqobhDC+oMf7oWZrv0SaNLBu2Hhyz1VFYvegnZxPhCIS5i4uSlzrhqIs2UCdCQ23IkYKC10ml4O87C9AG+M8zNBWMvJ5oYhL5MAKPunj8n1qE8p0XknDxm6bK1jWVRR5PzI4tKVbcw9rmGsu+Bjem1fdRcEELeFl6atX32rO8vEdpd8CFkLXSLNgl+ED40I48xa8spV9Qpnx8kOXDcgpbZAA41mIHMZRyQzVqhUrnQMuMUF2RJsaM1LL0kldHz7BysxFIRnVPA+wV5XrbevyPx8qjb5w15jCnGM9H5BIU+w5ukl4pDDHKPcTJ7676ytGC63nGd5pwfD5MWK+Y60c1Fkep62ujj+peMqjbBz/zzG1NElkGzRQmXvZgVJBSKlUehV+nCtPh9inlQa1iyRT2ybJXJP4+gie8g2InR47A418sUk7EfKIlJ3Nw69vRVDULiE2PgX/9BTazqatY4J/a18R8bnMjj/T/lIngVCk3KTdTng4rDxN1O080h
x-ms-traffictypediagnostic: DM6NAM10HT028:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ANUsHtpp7zhK74s72D9w1xF5p7c+Om86SBul/qrpjKoGx4zuDa2i7BSr/InrY6c+IwKa16y4YqGvlJpEly66HxUB1ZsbYH4fB0ECYBBWIVZaiAcARYnZB3mCtWgQrobUTGrgjhWcHjRYAHi+ZQmmcuOqj1ZbOr09Jj+CBhKYFkHijn8uOH25wLK2rivCXhi3vE1rLKU11PDnx5X/fZR7sH78hsMZi4J/PMwzRYcZFn0YRRloAtE1q3eWQN0r0U16
x-ms-exchange-antispam-messagedata: zPB3VckpzXikYhxtUxpK4CE8giZe/o/gvQi5ohPkXTKlwCKxpNsOa/4596JFw04YlhFDHhAKHL1tJg/wq/arLF1HCnpcMBMSadPx+uHNfvsGyRwp6XsZ9J6XlY7poDfvTzJ3sSlm3JhmD2tU6JTm1g==
x-ms-exchange-transport-forked: True
Content-Type: multipart/alternative;
 boundary="_000_DM6PR16MB24739B6BF93E480B6873A216E60E0DM6PR16MB2473namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM10FT015.eop-nam10.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 1890bc27-4e73-45bd-08ab-08d867e7f5a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2020 22:02:02.8358 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6NAM10HT028
X-OriginatorOrg: outlook.com
Received-SPF: pass client-ip=40.92.42.87;
 envelope-from=heecheol.yang@outlook.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/04 15:40:38
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>, Michael Rolnik <mrolnik@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_DM6PR16MB24739B6BF93E480B6873A216E60E0DM6PR16MB2473namp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

VGhhbmtzIGZvciB5b3VyIHJldmlldy4NCkFjdHVhbGx5LCB0aGUgdmVyeSByZWNlbnQgdjIgb25l
IGlzIHY0LiBUaGVyZSB3YXMgYW4gdHlwbyB3aGlsZSBJIHdhcyB3cml0aW5nIG11bHRpcGxlIG1h
aWxzIGZvciBzdWNjZXNzZnVsIHBhdGNoZXcgYnVpbGRzKHYyIGFuZCB2MyBoYXMgdGhlIHNhbWUg
Y29udGVudHMpIC4uIFNvcnJ5Lg0KDQpJZiBuZWVkZWQsIGxldCBtZSBrbm93IHRvIHdyaXRlIHRo
ZSBuZXcgdGl0bGVkIHZlcnNpb24gb2YgbWFpbCB3aGljaCBjb250YWlucyB0aGUgc2FtZSBjb250
ZW50cy4NCg0KDQoNCi0tLS0tLS0tIOybkOuzuCDsnbTrqZTsnbwgLS0tLS0tLS0NCuuwnOyLoDog
UGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPGY0YnVnQGFtc2F0Lm9yZz4NCuuCoOynnDogMjAvMTAv
NCDsmKTsoIQgMzowMyAoR01UKzA5OjAwKQ0K67Cb7J2AIOyCrOuejDogSGVlY2hlb2wgWWFuZyA8
aGVlY2hlb2wueWFuZ0BvdXRsb29rLmNvbT4sIHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0K7LC47KGw
OiBTYXJhaCBIYXJyaXMgPFMuRS5IYXJyaXNAa2VudC5hYy51az4sIE1pY2hhZWwgUm9sbmlrIDxt
cm9sbmlrQGdtYWlsLmNvbT4NCuygnOuqqTogUmU6IFtQQVRDSCB2Ml0gaHcvYXZyOiBBZGQgbGlt
aXRlZCBzdXBwb3J0IGZvciBhdnIgZ3BpbyByZWdpc3RlcnMNCg0KT24gMTAvMy8yMCAyOjM4IFBN
LCBIZWVjaGVvbCBZYW5nIHdyb3RlOg0KPiBBZGQgc29tZSBvZiB0aGVzZSBmZWF0dXJlcyBmb3Ig
YXZyIGdwaW86DQo+DQo+ICAgLSBHUElPIEkvTyA6IFBPUlR4IHJlZ2lzdGVycw0KPiAgIC0gRGF0
YSBEaXJlY3Rpb24gOiBERFJ4IHJlZ2lzdGVycw0KPg0KPiBGb2xsb3dpbmcgdGhpbmdzIGFyZSBu
b3Qgc3VwcG9ydGVkIHlldDoNCj4gICAtIFBJTnggcmVnaXN0ZXJzDQo+ICAgLSBNQ1VSIHJlZ2lz
dGVycw0KPiAgIC0gRXZlbiB0aG91Z2ggcmVhZC93cml0ZSBmb3IgRERSeCByZWdpc3RlcnMgYXJl
DQo+ICAgICBpbXBsZW1lbnRlZCwgYWN0dWFsIGRpcmVjdGlvbiBjb250cm9scyBhcmUgbm90DQo+
ICAgICBzdXBwb3J0ZWQgeWV0Lg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBIZWVjaGVvbCBZYW5nIDxo
ZWVjaGVvbC55YW5nQG91dGxvb2suY29tPg0KPiAtLS0NCj4gIGh3L2F2ci9LY29uZmlnICAgICAg
ICAgICAgIHwgICAxICsNCj4gIGh3L2F2ci9hdG1lZ2EuYyAgICAgICAgICAgIHwgICA3ICsrLQ0K
PiAgaHcvYXZyL2F0bWVnYS5oICAgICAgICAgICAgfCAgIDIgKw0KPiAgaHcvZ3Bpby9LY29uZmln
ICAgICAgICAgICAgfCAgIDMgKw0KPiAgaHcvZ3Bpby9hdnJfZ3Bpby5jICAgICAgICAgfCAxMTIg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgaHcvZ3Bpby9tZXNvbi5i
dWlsZCAgICAgICAgfCAgIDIgKw0KPiAgaW5jbHVkZS9ody9ncGlvL2F2cl9ncGlvLmggfCAgNDYg
KysrKysrKysrKysrKysrDQo+ICA3IGZpbGVzIGNoYW5nZWQsIDE3MSBpbnNlcnRpb25zKCspLCAy
IGRlbGV0aW9ucygtKQ0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGh3L2dwaW8vYXZyX2dwaW8uYw0K
PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvaHcvZ3Bpby9hdnJfZ3Bpby5oDQoNCkZZSSB0
aGlzIG9uZSBpcyBwb3N0ZWQgY29ycmVjdGx5LCBJIGNhbiByZWFkIGl0IGFuZCBwYXRjaGV3DQpz
dWNjZXNzZnVsbHkgYXBwbGllZCBpdDoNCmh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS9ETTZQUjE2
TUIyNDczQzVBNzdFMDA5Q0EyRkVGM0Q4RUNFNjBFMEBETTZQUjE2TUIyNDczLm5hbXByZDE2LnBy
b2Qub3V0bG9vay5jb20vDQoNCkJ1dCB2MyBpcyBicm9rZW4gYWdhaW4uLi4NCg==

--_000_DM6PR16MB24739B6BF93E480B6873A216E60E0DM6PR16MB2473namp_
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: base64

PGh0bWw+DQo8aGVhZD4NCjxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIgY29udGVudD0i
dGV4dC9odG1sOyBjaGFyc2V0PXV0Zi04Ij4NCjxtZXRhIG5hbWU9IkdlbmVyYXRvciIgY29udGVu
dD0iTWljcm9zb2Z0IEV4Y2hhbmdlIFNlcnZlciI+DQo8IS0tIGNvbnZlcnRlZCBmcm9tIHRleHQg
LS0+PHN0eWxlPjwhLS0gLkVtYWlsUXVvdGUgeyBtYXJnaW4tbGVmdDogMXB0OyBwYWRkaW5nLWxl
ZnQ6IDRwdDsgYm9yZGVyLWxlZnQ6ICM4MDAwMDAgMnB4IHNvbGlkOyB9IC0tPjwvc3R5bGU+DQo8
L2hlYWQ+DQo8Ym9keT4NCjxkaXYgZGlyPSJhdXRvIj4NCjxkaXYgZGlyPSJhdXRvIj5UaGFua3Mg
Zm9yIHlvdXIgcmV2aWV3LiZuYnNwOzwvZGl2Pg0KPGRpdiBkaXI9ImF1dG8iPkFjdHVhbGx5LCB0
aGUgdmVyeSByZWNlbnQgdjIgb25lIGlzIHY0LiBUaGVyZSB3YXMgYW4gdHlwbyB3aGlsZSBJIHdh
cyB3cml0aW5nIG11bHRpcGxlIG1haWxzIGZvciBzdWNjZXNzZnVsIHBhdGNoZXcgYnVpbGRzKHYy
IGFuZCB2MyBoYXMgdGhlIHNhbWUgY29udGVudHMpIC4uIFNvcnJ5LiZuYnNwOzwvZGl2Pg0KPGRp
diBkaXI9ImF1dG8iPjxicj4NCjwvZGl2Pg0KPGRpdiBkaXI9ImF1dG8iPklmIG5lZWRlZCwgbGV0
IG1lIGtub3cgdG8gd3JpdGUgdGhlIG5ldyB0aXRsZWQgdmVyc2lvbiBvZiBtYWlsIHdoaWNoIGNv
bnRhaW5zIHRoZSBzYW1lIGNvbnRlbnRzLjwvZGl2Pg0KPGRpdiBkaXI9ImF1dG8iPjxicj4NCjwv
ZGl2Pg0KPGRpdj48YnI+DQo8L2Rpdj4NCjxkaXY+PGJyPg0KPC9kaXY+DQo8ZGl2Pi0tLS0tLS0t
IOybkOuzuCDsnbTrqZTsnbwgLS0tLS0tLS08L2Rpdj4NCjxkaXY+67Cc7IugOiBQaGlsaXBwZSBN
YXRoaWV1LURhdWTDqSAmbHQ7ZjRidWdAYW1zYXQub3JnJmd0OyA8L2Rpdj4NCjxkaXY+64Kg7Kec
OiAyMC8xMC80IOyYpOyghCAzOjAzIChHTVQrMDk6MDApIDwvZGl2Pg0KPGRpdj7rsJvsnYAg7IKs
656MOiBIZWVjaGVvbCBZYW5nICZsdDtoZWVjaGVvbC55YW5nQG91dGxvb2suY29tJmd0OywgcWVt
dS1kZXZlbEBub25nbnUub3JnIDwvZGl2Pg0KPGRpdj7ssLjsobA6IFNhcmFoIEhhcnJpcyAmbHQ7
Uy5FLkhhcnJpc0BrZW50LmFjLnVrJmd0OywgTWljaGFlbCBSb2xuaWsgJmx0O21yb2xuaWtAZ21h
aWwuY29tJmd0Ow0KPC9kaXY+DQo8ZGl2PuygnOuqqTogUmU6IFtQQVRDSCB2Ml0gaHcvYXZyOiBB
ZGQgbGltaXRlZCBzdXBwb3J0IGZvciBhdnIgZ3BpbyByZWdpc3RlcnMgPC9kaXY+DQo8ZGl2Pjxi
cj4NCjwvZGl2Pg0KPC9kaXY+DQo8Zm9udCBzaXplPSIyIj48c3BhbiBzdHlsZT0iZm9udC1zaXpl
OjExcHQ7Ij4NCjxkaXYgY2xhc3M9IlBsYWluVGV4dCI+T24gMTAvMy8yMCAyOjM4IFBNLCBIZWVj
aGVvbCBZYW5nIHdyb3RlOjxicj4NCiZndDsgQWRkIHNvbWUgb2YgdGhlc2UgZmVhdHVyZXMgZm9y
IGF2ciBncGlvOjxicj4NCiZndDsgPGJyPg0KJmd0OyZuYnNwOyZuYnNwOyAtIEdQSU8gSS9PIDog
UE9SVHggcmVnaXN0ZXJzPGJyPg0KJmd0OyZuYnNwOyZuYnNwOyAtIERhdGEgRGlyZWN0aW9uIDog
RERSeCByZWdpc3RlcnM8YnI+DQomZ3Q7IDxicj4NCiZndDsgRm9sbG93aW5nIHRoaW5ncyBhcmUg
bm90IHN1cHBvcnRlZCB5ZXQ6PGJyPg0KJmd0OyZuYnNwOyZuYnNwOyAtIFBJTnggcmVnaXN0ZXJz
PGJyPg0KJmd0OyZuYnNwOyZuYnNwOyAtIE1DVVIgcmVnaXN0ZXJzPGJyPg0KJmd0OyZuYnNwOyZu
YnNwOyAtIEV2ZW4gdGhvdWdoIHJlYWQvd3JpdGUgZm9yIEREUnggcmVnaXN0ZXJzIGFyZTxicj4N
CiZndDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgaW1wbGVtZW50ZWQsIGFjdHVhbCBkaXJlY3Rp
b24gY29udHJvbHMgYXJlIG5vdDxicj4NCiZndDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgc3Vw
cG9ydGVkIHlldC48YnI+DQomZ3Q7IDxicj4NCiZndDsgU2lnbmVkLW9mZi1ieTogSGVlY2hlb2wg
WWFuZyAmbHQ7aGVlY2hlb2wueWFuZ0BvdXRsb29rLmNvbSZndDs8YnI+DQomZ3Q7IC0tLTxicj4N
CiZndDsmbmJzcDsgaHcvYXZyL0tjb25maWcmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgfCZuYnNwOyZuYnNwOyAx
ICs8YnI+DQomZ3Q7Jm5ic3A7IGh3L2F2ci9hdG1lZ2EuYyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyB8Jm5ic3A7Jm5ic3A7
IDcgKystPGJyPg0KJmd0OyZuYnNwOyBody9hdnIvYXRtZWdhLmgmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgfCZuYnNwOyZu
YnNwOyAyICs8YnI+DQomZ3Q7Jm5ic3A7IGh3L2dwaW8vS2NvbmZpZyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyB8Jm5ic3A7
Jm5ic3A7IDMgKzxicj4NCiZndDsmbmJzcDsgaHcvZ3Bpby9hdnJfZ3Bpby5jJm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IHwgMTEyICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKys8YnI+DQomZ3Q7Jm5ic3A7IGh3L2dwaW8vbWVzb24uYnVp
bGQmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgfCZuYnNwOyZuYnNw
OyAyICs8YnI+DQomZ3Q7Jm5ic3A7IGluY2x1ZGUvaHcvZ3Bpby9hdnJfZ3Bpby5oIHwmbmJzcDsg
NDYgKysrKysrKysrKysrKysrPGJyPg0KJmd0OyZuYnNwOyA3IGZpbGVzIGNoYW5nZWQsIDE3MSBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKTxicj4NCiZndDsmbmJzcDsgY3JlYXRlIG1vZGUg
MTAwNjQ0IGh3L2dwaW8vYXZyX2dwaW8uYzxicj4NCiZndDsmbmJzcDsgY3JlYXRlIG1vZGUgMTAw
NjQ0IGluY2x1ZGUvaHcvZ3Bpby9hdnJfZ3Bpby5oPGJyPg0KPGJyPg0KRllJIHRoaXMgb25lIGlz
IHBvc3RlZCBjb3JyZWN0bHksIEkgY2FuIHJlYWQgaXQgYW5kIHBhdGNoZXc8YnI+DQpzdWNjZXNz
ZnVsbHkgYXBwbGllZCBpdDo8YnI+DQo8YSBocmVmPSJodHRwczovL3BhdGNoZXcub3JnL1FFTVUv
RE02UFIxNk1CMjQ3M0M1QTc3RTAwOUNBMkZFRjNEOEVDRTYwRTBARE02UFIxNk1CMjQ3My5uYW1w
cmQxNi5wcm9kLm91dGxvb2suY29tLyI+aHR0cHM6Ly9wYXRjaGV3Lm9yZy9RRU1VL0RNNlBSMTZN
QjI0NzNDNUE3N0UwMDlDQTJGRUYzRDhFQ0U2MEUwQERNNlBSMTZNQjI0NzMubmFtcHJkMTYucHJv
ZC5vdXRsb29rLmNvbS88L2E+PGJyPg0KPGJyPg0KQnV0IHYzIGlzIGJyb2tlbiBhZ2Fpbi4uLjxi
cj4NCjwvZGl2Pg0KPC9zcGFuPjwvZm9udD4NCjwvYm9keT4NCjwvaHRtbD4NCg==

--_000_DM6PR16MB24739B6BF93E480B6873A216E60E0DM6PR16MB2473namp_--

