Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 183DEC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 12:51:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C57AB20869
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 12:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="KStg+96G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C57AB20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iafjw-00049n-UQ
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 07:51:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37625)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iafKA-0002kI-Ev
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 07:24:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iafK5-0006eC-UF
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 07:24:36 -0500
Received: from mail-ve1eur03on071e.outbound.protection.outlook.com
 ([2a01:111:f400:fe09::71e]:35138
 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iafK2-0006HS-VL; Fri, 29 Nov 2019 07:24:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ns9WB4AFdSIHaj8hQaVwsf3Lm8pqgxQ17DeedUzfrPQrz4mam8wI86zsWX5WCDW9YlpaR0ADCisfEB/2sjDefVpAlqoORUbVocYmRsZPvYvtrUdPQzkq/655ajF0cVnbwMpviTNrMY5rFEtn2Yv4YwNH4VxKjaHkuXZnUycFJx9hS9c13RkywQ7z/8JnIedWnzhXDKRf1nRAKkXN5oTu6RxtRwO5L8wGCvz9n06NBsuut3PGQC1bBDN12PzeOdekESlJrd3Zfd39MJT69Q8eSg0lPwQVp9vW0AnHVoO9brhZyR9aTA+w48ZRXrIgxvgrmBtd+d8WFJK2jVEwQoT38A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPc6ZjfM9fq0ZcsdIWf6F/5R4ZZfjzdFoHWOx+bBrXc=;
 b=XF8uZkBjm6E3nT61zPkvowLiyUH0hYhZOASLJSYDwiD41fwSMLyjrcT+673V3VU1Av3ulVjsWebxAWzUCId++dyYLoaEf3AZb883GdgqBsOB/K+UVLMkI82voDSqnTwlDGcypE22Pk+EeNRbZ1X+Am9QGxP47JJOmfMZROl+oIny+wD/LvnMM33WoWvTKP9md5jL9b/gjARBFIyJ4bx/WHDRuWVQcBS5gY6CWejDAshbnefvHtYGXzTL9XRk7B5LsLSgMz4ynRLBNVAuZBP1xAv8YpK8hbuqYgs0YGrBX+0BbJWONWnXOCsoxNoTb5Jp6oyuR/Jq7JpIOPzCGgYCGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPc6ZjfM9fq0ZcsdIWf6F/5R4ZZfjzdFoHWOx+bBrXc=;
 b=KStg+96G3A+L29SnH9QyCgpD4rRNuB/k13ZAeaRdEjPUpJ8zGSmCUOceQTicY3xQvwUHGEIcM1/O25tY0p68/+y3YyH+Kmyay8xOiDftQzdESH0X0SnzwP82KfcWszLjzoQ0/r4Yl12hBOJBYAwrNg5XgC79w3ql3gVB22zxdqg=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4708.eurprd08.prod.outlook.com (10.255.99.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.20; Fri, 29 Nov 2019 12:24:23 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2495.014; Fri, 29 Nov 2019
 12:24:23 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH for-5.0 v2 00/23] block: Fix check_to_replace_node()
Thread-Topic: [PATCH for-5.0 v2 00/23] block: Fix check_to_replace_node()
Thread-Index: AQHVmKlpfvOoU/F0/UCS/QjP1du9qqeiLoiA
Date: Fri, 29 Nov 2019 12:24:23 +0000
Message-ID: <a134c8a6-17c1-34bc-79f6-76062ff0c668@virtuozzo.com>
References: <20191111160216.197086-1-mreitz@redhat.com>
In-Reply-To: <20191111160216.197086-1-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR09CA0069.eurprd09.prod.outlook.com
 (2603:10a6:7:3d::13) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191129152421620
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a584ef3e-fda6-45fa-8d6e-08d774c7112b
x-ms-traffictypediagnostic: AM6PR08MB4708:
x-microsoft-antispam-prvs: <AM6PR08MB4708A87AE9AF827E95F5A0B2C1460@AM6PR08MB4708.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:348;
x-forefront-prvs: 0236114672
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(136003)(39840400004)(366004)(376002)(346002)(199004)(189003)(66066001)(7736002)(102836004)(36756003)(186003)(52116002)(31686004)(26005)(2906002)(99286004)(386003)(71200400001)(71190400001)(6506007)(110136005)(6116002)(305945005)(54906003)(316002)(3846002)(76176011)(6436002)(66446008)(64756008)(66556008)(66476007)(966005)(8676002)(66946007)(86362001)(256004)(6246003)(2501003)(81166006)(2616005)(81156014)(8936002)(11346002)(478600001)(229853002)(6512007)(4326008)(5660300002)(25786009)(6486002)(6306002)(14454004)(31696002)(446003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4708;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZFxiU9YNwUHKf+k1kTq5OH6V1q7aGvW69TXySopvo4FApWlsIzhCadpuTbILEb1498iZRdIaljx5L3YR+gvdsp7gzESotS9ds1a98TfDcUPKXMZ4JokCBRk9Ov3/W7fp/mJYXPKlA0ggSrazfGFgnyDiPqiCUQm+fzKPGSizzuf8ZafYkRQxzQAG8HnHvgEPD/TRMbWwFDOIKgKI1OCMlO1wF6c4NZ2A9jcCSUqmp9sLHcgSSc63O55T7adBcNYhC2T+gTiDHt4TG549dd21x944GS2q5189QpijgfQ79DWQ818KwK74U9Mu2KCZ2nBxiFK3g4jC7V47sIkyEMhBnW3SB++j2YfruCf3ZT19Y9sLpYi+Y6fxZsMG0zUi/ZcWp3LIUs3GpFEe7tzdXZPtHSvxake31K1D2x6d7P0nAvl8Rao47aOrt2xUvjinc46L3ydhZe09Of49fg7rk5vuFbp0Rvv34SEtps21/KY2B0U=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <96CCD4B116BCB94FA1841863339E9D2A@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a584ef3e-fda6-45fa-8d6e-08d774c7112b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2019 12:24:23.3474 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DS5ANRwRz/qDuQbc6szfQ5dQ9/GRNyNP8MxIinWTTYDeK5ZPka0G1AzttY5FfSxfkLuldai0lIbNTEF8bspHBUI90PWskhvTWsjB1i6H7tY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4708
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe09::71e
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MyBsYXN0IGlvdGVzdHMgcGF0Y2hlcyBkb24ndCBhcHBseSBub3cuLiBEbyB5b3UgaGF2ZSBhIGJy
YW5jaCBwdXNoZWQgc29tZXdoZXJlPw0KDQoxMS4xMS4yMDE5IDE5OjAxLCBNYXggUmVpdHogd3Jv
dGU6DQo+IEJhc2VkLW9uOiA8MjAxOTExMDgxMjM0NTUuMzk0NDUtMS1tcmVpdHpAcmVkaGF0LmNv
bT4NCj4gKOKAnGlvdGVzdHM6IFRlc3QgZmFpbGluZyBtaXJyb3IgY29tcGxldGXigJ0pDQo+IA0K
PiAoQmVjYXVzZSBib3RoIGFkZCBjYXNlcyB0byAwNDEuKQ0KPiANCj4gDQo+IEhpLA0KPiANCj4g
Rm9yIHdoYXQgdGhpcyBzZXJpZXMgZG9lcywgc2VlIHRoZSBjb3ZlciBsZXR0ZXIgb2YgdjE6DQo+
IA0KPiBodHRwczovL2xpc3RzLm5vbmdudS5vcmcvYXJjaGl2ZS9odG1sL3FlbXUtYmxvY2svMjAx
OS0wOS9tc2cwMTAyNy5odG1sDQo+IA0KPiANCj4gTm93LCBpbiB2MiBJ4oCZdmUgYWRkcmVzc2Vk
IFZsYWRpbWly4oCZcyBjb21tZW50czoNCj4gLSBQYXRjaCA1OiBFeHRlbmQgZXhwbGFuYXRpb24g
aW4gdGhlIGNvbW1pdCBtZXNzYWdlDQo+IC0gUGF0Y2ggNjogUHJlZmVyIGRyaXZlci1zcGVjaWZp
YyAuYmRydl9yZWN1cnNlX2Nhbl9yZXBsYWNlKCkNCj4gICAgICAgICAgICAgaW1wbGVtZW50YXRp
b24gYmVmb3JlIHRoZSBnZW5lcmljIG9uZSBmb3IgZmlsdGVycw0KPiAtIFBhdGNoIDg6IFNvbWUg
bW9yZSBzL0JkcnZDaGlsZCBcKi9RdW9ydW1DaGlsZC8NCj4gLSBQYXRjaCAxNTogRml4IHR5cG8g
aW4gdGhlIGNvbW1pdCBtZXNzYWdlDQo+IC0gUGF0Y2ggMTc6IEFkZGVkDQo+IC0gUGF0Y2ggMTg6
DQo+ICAgIC0gU3BsaXQgQHBhdGggaW50byBAcm9vdCArIEBwYXRoDQo+ICAgIC0gSW4gb25lIGlu
c3RhbmNlLCB1c2UgeCA9IG5leHQoeSwgeikgaW5zdGVhZCBvZg0KPiAgICAgIHRyeTogeCA9IG5l
eHQoeSk7IGV4Y2VwdCBTdG9wSXRlcmF0aW9uOiB4ID0gejsNCj4gICAgLSAlcy8nJycvIiIiLw0K
PiAtIFBhdGNoIDE5OiBGYWxsb3V0IGZyb20gdGhlIHBhdGNoIDE4IGNoYW5nZXMNCj4gLSBQYXRj
aCAyMDogRml4IGluIHRoZSBjb21taXQgbWVzc2FnZSAodW5jb21tZW50aW5nIC0+IGNvbW1lbnRp
bmcgb3V0KQ0KPiAtIFBhdGNoIDIxOg0KPiAgICAtIENoZWNrIGZ1bGwgc3RkZXJyIG1lc3NhZ2Ug
YnkgaW5zcGVjdGluZyB0aGUgVk0gbG9nDQo+ICAgIC0gRmFsbG91dCBmcm9tIHRoZSBwYXRjaCAx
OCBjaGFuZ2VzDQo+ICAgIC0gJXMvJycnLyIiIi8NCj4gLSBQYXRjaCAyMjoNCj4gICAgLSBTa2lw
IGNhc2UgaWYgQ09SIGlzIHVuc3VwcG9ydGVkDQo+ICAgIC0gRmFsbG91dCBmcm9tIHRoZSBwYXRj
aCAxOCBjaGFuZ2VzDQo+ICAgIC0gJXMvJycnLyIiIi8NCj4gLSBQYXRjaCAyMzoNCj4gICAgLSBB
ZGRlZCBtb3JlIGNvbW1lbnRzDQo+ICAgIC0gU2tpcCBjYXNlcyBpZiB0aHJvdHRsZS9DT1IvcXVv
cnVtIChhcyBhcHByb3ByaWF0ZSkgaXMgdW5zdXBwb3J0ZWQNCj4gICAgLSBVc2UgaW1nZm10IGlu
c3RlYWQgb2YgaGFyZC1jb2RpbmcgcWNvdzINCj4gICAgLSBGYWxsb3V0IGZyb20gdGhlIHBhdGNo
IDE4IGNoYW5nZXMNCj4gICAgLSAlcy8nJycvIiIiLw0KPiANCj4gDQo+IGdpdC1iYWNrcG9ydC1k
aWZmIGFnYWluc3QgdjE6DQo+IA0KPiBLZXk6DQo+IFstLS0tXSA6IHBhdGNoZXMgYXJlIGlkZW50
aWNhbA0KPiBbIyMjI10gOiBudW1iZXIgb2YgZnVuY3Rpb25hbCBkaWZmZXJlbmNlcyBiZXR3ZWVu
IHVwc3RyZWFtL2Rvd25zdHJlYW0gcGF0Y2gNCj4gW2Rvd25dIDogcGF0Y2ggaXMgZG93bnN0cmVh
bS1vbmx5DQo+IFRoZSBmbGFncyBbRkNdIGluZGljYXRlIChGKXVuY3Rpb25hbCBhbmQgKEMpb250
ZXh0dWFsIGRpZmZlcmVuY2VzLCByZXNwZWN0aXZlbHkNCj4gDQo+IDAwMS8yMzpbLS0tLV0gWy0t
XSAnYmxvY2tkZXY6IEFsbG93IGV4dGVybmFsIHNuYXBzaG90cyBldmVyeXdoZXJlJw0KPiAwMDIv
MjM6Wy0tLS1dIFstLV0gJ2Jsb2NrZGV2OiBBbGxvdyByZXNpemluZyBldmVyeXdoZXJlJw0KPiAw
MDMvMjM6Wy0tLS1dIFstLV0gJ2Jsb2NrOiBEcm9wIGJkcnZfaXNfZmlyc3Rfbm9uX2ZpbHRlcigp
Jw0KPiAwMDQvMjM6Wy0tLS1dIFstLV0gJ2lvdGVzdHM6IExldCAwNDEgdXNlIC1ibG9ja2RldiBm
b3IgcXVvcnVtIGNoaWxkcmVuJw0KPiAwMDUvMjM6Wy0tLS1dIFstLV0gJ3F1b3J1bTogRml4IGNo
aWxkIHBlcm1pc3Npb25zJw0KPiAwMDYvMjM6WzAwMTJdIFtGQ10gJ2Jsb2NrOiBBZGQgYmRydl9y
ZWN1cnNlX2Nhbl9yZXBsYWNlKCknDQo+IDAwNy8yMzpbLS0tLV0gWy0tXSAnYmxrdmVyaWZ5OiBJ
bXBsZW1lbnQgLmJkcnZfcmVjdXJzZV9jYW5fcmVwbGFjZSgpJw0KPiAwMDgvMjM6WzAwMDZdIFtG
Q10gJ3F1b3J1bTogU3RvcmUgY2hpbGRyZW4gaW4gb3duIHN0cnVjdHVyZScNCj4gMDA5LzIzOlst
LS0tXSBbLS1dICdxdW9ydW06IEFkZCBRdW9ydW1DaGlsZC50b19iZV9yZXBsYWNlZCcNCj4gMDEw
LzIzOlstLS0tXSBbLS1dICdxdW9ydW06IEltcGxlbWVudCAuYmRydl9yZWN1cnNlX2Nhbl9yZXBs
YWNlKCknDQo+IDAxMS8yMzpbLS0tLV0gWy0tXSAnYmxvY2s6IFVzZSBiZHJ2X3JlY3Vyc2VfY2Fu
X3JlcGxhY2UoKScNCj4gMDEyLzIzOlstLS0tXSBbLS1dICdibG9jazogUmVtb3ZlIGJkcnZfcmVj
dXJzZV9pc19maXJzdF9ub25fZmlsdGVyKCknDQo+IDAxMy8yMzpbLS0tLV0gWy0tXSAnbWlycm9y
OiBEb3VibGUtY2hlY2sgaW1tZWRpYXRlbHkgYmVmb3JlIHJlcGxhY2luZycNCj4gMDE0LzIzOlst
LS0tXSBbLS1dICdxdW9ydW06IFN0b3AgbWFya2luZyBpdCBhcyBhIGZpbHRlcicNCj4gMDE1LzIz
OlstLS0tXSBbLS1dICdtaXJyb3I6IFByZXZlbnQgbG9vcHMnDQo+IDAxNi8yMzpbLS0tLV0gWy0t
XSAnaW90ZXN0czogVXNlIGNvbXBsZXRlX2FuZF93YWl0KCkgaW4gMTU1Jw0KPiAwMTcvMjM6W2Rv
d25dICdpb3Rlc3RzOiBVc2Ugc2tpcF9pZl91bnN1cHBvcnRlZCBkZWNvcmF0b3IgaW4gMDQxJw0K
PiAwMTgvMjM6WzAwMzddIFtGQ10gJ2lvdGVzdHM6IEFkZCBWTS5hc3NlcnRfYmxvY2tfcGF0aCgp
Jw0KPiAwMTkvMjM6WzAwMDRdIFtGQ10gJ2lvdGVzdHM6IFJlc29sdmUgVE9ET3MgaW4gMDQxJw0K
PiAwMjAvMjM6Wy0tLS1dIFstLV0gJ2lvdGVzdHM6IFVzZSBzZWxmLmltYWdlX2xlbiBpbiBUZXN0
UmVwYWlyUXVvcnVtJw0KPiAwMjEvMjM6WzAwMjddIFtGQ10gJ2lvdGVzdHM6IEFkZCB0ZXN0cyBm
b3IgaW52YWxpZCBRdW9ydW0gQHJlcGxhY2VzJw0KPiAwMjIvMjM6WzAwMDddIFtGQ10gJ2lvdGVz
dHM6IENoZWNrIHRoYXQgQHJlcGxhY2VzIGNhbiByZXBsYWNlIGZpbHRlcnMnDQo+IDAyMy8yMzpb
MDE0MV0gW0ZDXSAnaW90ZXN0czogTWlycm9yIG11c3Qgbm90IGF0dGVtcHQgdG8gY3JlYXRlIGxv
b3BzJw0KPiANCj4gDQo+IE1heCBSZWl0eiAoMjMpOg0KPiAgICBibG9ja2RldjogQWxsb3cgZXh0
ZXJuYWwgc25hcHNob3RzIGV2ZXJ5d2hlcmUNCj4gICAgYmxvY2tkZXY6IEFsbG93IHJlc2l6aW5n
IGV2ZXJ5d2hlcmUNCj4gICAgYmxvY2s6IERyb3AgYmRydl9pc19maXJzdF9ub25fZmlsdGVyKCkN
Cj4gICAgaW90ZXN0czogTGV0IDA0MSB1c2UgLWJsb2NrZGV2IGZvciBxdW9ydW0gY2hpbGRyZW4N
Cj4gICAgcXVvcnVtOiBGaXggY2hpbGQgcGVybWlzc2lvbnMNCj4gICAgYmxvY2s6IEFkZCBiZHJ2
X3JlY3Vyc2VfY2FuX3JlcGxhY2UoKQ0KPiAgICBibGt2ZXJpZnk6IEltcGxlbWVudCAuYmRydl9y
ZWN1cnNlX2Nhbl9yZXBsYWNlKCkNCj4gICAgcXVvcnVtOiBTdG9yZSBjaGlsZHJlbiBpbiBvd24g
c3RydWN0dXJlDQo+ICAgIHF1b3J1bTogQWRkIFF1b3J1bUNoaWxkLnRvX2JlX3JlcGxhY2VkDQo+
ICAgIHF1b3J1bTogSW1wbGVtZW50IC5iZHJ2X3JlY3Vyc2VfY2FuX3JlcGxhY2UoKQ0KPiAgICBi
bG9jazogVXNlIGJkcnZfcmVjdXJzZV9jYW5fcmVwbGFjZSgpDQo+ICAgIGJsb2NrOiBSZW1vdmUg
YmRydl9yZWN1cnNlX2lzX2ZpcnN0X25vbl9maWx0ZXIoKQ0KPiAgICBtaXJyb3I6IERvdWJsZS1j
aGVjayBpbW1lZGlhdGVseSBiZWZvcmUgcmVwbGFjaW5nDQo+ICAgIHF1b3J1bTogU3RvcCBtYXJr
aW5nIGl0IGFzIGEgZmlsdGVyDQo+ICAgIG1pcnJvcjogUHJldmVudCBsb29wcw0KPiAgICBpb3Rl
c3RzOiBVc2UgY29tcGxldGVfYW5kX3dhaXQoKSBpbiAxNTUNCj4gICAgaW90ZXN0czogVXNlIHNr
aXBfaWZfdW5zdXBwb3J0ZWQgZGVjb3JhdG9yIGluIDA0MQ0KPiAgICBpb3Rlc3RzOiBBZGQgVk0u
YXNzZXJ0X2Jsb2NrX3BhdGgoKQ0KPiAgICBpb3Rlc3RzOiBSZXNvbHZlIFRPRE9zIGluIDA0MQ0K
PiAgICBpb3Rlc3RzOiBVc2Ugc2VsZi5pbWFnZV9sZW4gaW4gVGVzdFJlcGFpclF1b3J1bQ0KPiAg
ICBpb3Rlc3RzOiBBZGQgdGVzdHMgZm9yIGludmFsaWQgUXVvcnVtIEByZXBsYWNlcw0KPiAgICBp
b3Rlc3RzOiBDaGVjayB0aGF0IEByZXBsYWNlcyBjYW4gcmVwbGFjZSBmaWx0ZXJzDQo+ICAgIGlv
dGVzdHM6IE1pcnJvciBtdXN0IG5vdCBhdHRlbXB0IHRvIGNyZWF0ZSBsb29wcw0KPiANCj4gICBi
bG9jay5jICAgICAgICAgICAgICAgICAgICAgICB8IDExNSArKysrKystLS0tDQo+ICAgYmxvY2sv
YmxrdmVyaWZ5LmMgICAgICAgICAgICAgfCAgMjAgKy0NCj4gICBibG9jay9jb3B5LW9uLXJlYWQu
YyAgICAgICAgICB8ICAgOSAtDQo+ICAgYmxvY2svbWlycm9yLmMgICAgICAgICAgICAgICAgfCAg
MzEgKystDQo+ICAgYmxvY2svcXVvcnVtLmMgICAgICAgICAgICAgICAgfCAxNjEgKysrKysrKysr
KystLS0NCj4gICBibG9jay9yZXBsaWNhdGlvbi5jICAgICAgICAgICB8ICAgNyAtDQo+ICAgYmxv
Y2svdGhyb3R0bGUuYyAgICAgICAgICAgICAgfCAgIDggLQ0KPiAgIGJsb2NrZGV2LmMgICAgICAg
ICAgICAgICAgICAgIHwgIDU4ICsrKystDQo+ICAgaW5jbHVkZS9ibG9jay9ibG9jay5oICAgICAg
ICAgfCAgIDUgLQ0KPiAgIGluY2x1ZGUvYmxvY2svYmxvY2tfaW50LmggICAgIHwgIDE5ICstDQo+
ICAgdGVzdHMvcWVtdS1pb3Rlc3RzLzA0MSAgICAgICAgfCA0MDIgKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrLS0tLQ0KPiAgIHRlc3RzL3FlbXUtaW90ZXN0cy8wNDEub3V0ICAgIHwgICA0
ICstDQo+ICAgdGVzdHMvcWVtdS1pb3Rlc3RzLzE1NSAgICAgICAgfCAgIDcgKy0NCj4gICB0ZXN0
cy9xZW11LWlvdGVzdHMvaW90ZXN0cy5weSB8ICA1OSArKysrKw0KPiAgIDE0IGZpbGVzIGNoYW5n
ZWQsIDcxNSBpbnNlcnRpb25zKCspLCAxOTAgZGVsZXRpb25zKC0pDQo+IA0KDQoNCi0tIA0KQmVz
dCByZWdhcmRzLA0KVmxhZGltaXINCg==

