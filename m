Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37883C49ED9
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 08:48:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03A162084F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 08:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="OCwMcpxX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03A162084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8KmG-0004iy-0G
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 04:48:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36427)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1i8Kkx-0003aU-1u
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 04:47:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1i8Kks-0007QL-QG
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 04:47:10 -0400
Received: from mail-db5eur03on0722.outbound.protection.outlook.com
 ([2a01:111:f400:fe0a::722]:6791
 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1i8KkT-00077J-3f; Thu, 12 Sep 2019 04:47:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R8yKVKwl8zREKBTn8nz0+L/5/osUUgeUSPtUJbAwVYAkM0bEXWHkSpGhkN/PvNL47fEJKS5TcVghzYt2p7fN0ZQhVKt8g41nm50S42zkPsedZ8ljcrGSIB9GqCRnO2lsEYHlPLY8h0mqOc8FGeR1JyFTwzvD7rV7qqngChfyvxNhBlfdAi0UEejnOV9Z/v4oG0M0WNlUGc7scVFK/Uw0L+EN6MxFnJLFYZiZ0z7/iVoUDwIPVMV925Yr4BmCOyun+oqusFOLu1wp8i5z9bQWbpOcBw0ULCjcl2CXAaCU1x10TutvoE0GjzQ90I8FyiNH8CYDNTonGIut5Dx58D/9yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H9rjoOD/PcqYXGyjRCPRuwHiuaycbiggcga119xcQHQ=;
 b=kIqvmjzEzimk3p1a3lws+2rOnuyvVclU6b+eD74RJoIG+2qjPtEtZXMir4Ec0TsOFNHdRU+qzYC0VwOh8iS1yyJU//Wly6BcYOwXxSUdxH/qygh6X547iiBCtnQ3h3Zemz+i/SgwR/jzQUasz9IT2ywg26goY4s4hHzaqqk4WOSxJ15phiCFEGK/cKoMOitI+noCEmpF0JXvKntBW/8vCfuEg8ZaC8eWWEUZ6Wt2ALxn56T6UjYKqxrP0LDMrNEwKzKLSlmC2Xhl2UHX+ClyH0/oqNcaCQMChTWzby65IjHdU6A86zce2fUz43+4NMRFcK+y7FKPBKy6ZG6hc3pDnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H9rjoOD/PcqYXGyjRCPRuwHiuaycbiggcga119xcQHQ=;
 b=OCwMcpxXkGmqe3Ku7LqA65KzR+5aNaKelshcPaBYkhbVH+9c5Aik11sc33B+3j8T6+XzNp6jgYi+eIDz0wi0zu4UPw5/u0w5jO3OBzdKYg8Y+5oe4eZzT2vejpT34Uvh9pV8lpy6c00tV1XjTsKoY+fhev3vbLypA5dSkIkennM=
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB5299.eurprd08.prod.outlook.com (10.255.225.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.15; Thu, 12 Sep 2019 08:46:37 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::302b:b479:1322:9d31]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::302b:b479:1322:9d31%5]) with mapi id 15.20.2263.016; Thu, 12 Sep 2019
 08:46:36 +0000
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: "armbru@redhat.com" <armbru@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v6 0/3] qcow2: add zstd cluster compression
Thread-Index: AQHVY8zB97xMzxdZGUGmblfZ326w56cnxZGA
Date: Thu, 12 Sep 2019 08:46:36 +0000
Message-ID: <8c42f523-23ad-1bce-5315-c1f4511723de@virtuozzo.com>
References: <20190905093109.12261-1-dplotnikov@virtuozzo.com>
In-Reply-To: <20190905093109.12261-1-dplotnikov@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
x-originating-ip: [5.138.126.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 96d3f5f0-90b4-4013-789d-08d7375db8df
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0PR08MB5299; 
x-ms-traffictypediagnostic: AM0PR08MB5299:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB5299935393754C4F140FD231CFB00@AM0PR08MB5299.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01583E185C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39840400004)(396003)(376002)(346002)(136003)(366004)(189003)(199004)(53546011)(8936002)(6246003)(102836004)(186003)(486006)(2616005)(25786009)(476003)(26005)(6512007)(66556008)(7736002)(305945005)(36756003)(76176011)(76116006)(64756008)(66446008)(99286004)(66476007)(19627235002)(5660300002)(2501003)(66946007)(256004)(6116002)(110136005)(3846002)(86362001)(316002)(31696002)(6486002)(71190400001)(229853002)(71200400001)(31686004)(66066001)(6436002)(14454004)(8676002)(81156014)(11346002)(446003)(53936002)(81166006)(4326008)(478600001)(54906003)(2906002)(6506007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB5299;
 H:AM0PR08MB3745.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: aqQ+pR6sDSw4WM14GXgOSS0G+enDCJnLI5KPL/5+AVhM3VnReH6rNKvasPCj0x5q9UKAeEA7oaWEStYai4O3ukaZA/D0ZzHx6shFJezWlMhk+ovaviq29EFE4vAbukS+k+YUx6v7FZcbXoYQU8wmj2Ikk7E5hNoY7Hm4wzmzceSEcPHrItC2tstzy9DEOwOh6WwcwbaTJ+1JMElefB0iz2zAxGH7fk4ZMw0U4xqMyIdCngQfZ/JUhJB35hkuDKTensaEUjdEGl08vde/nKZ7HwPK0W2VsKXAAvmkh7/Oy3L8IBEKr9zA9LBZYnYeowEpHG6h1TXhLDRKU2+n2wiNpaXgO6B8l679KXJcx1zALWFXT5O6eDWOTNPCwKOnYRkp2yFYnC+JJgTOkuePJiHovxEpVghyhfC1B9R61NXtWp4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <69B686F83D794147B58943DE89C2B2F5@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96d3f5f0-90b4-4013-789d-08d7375db8df
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2019 08:46:36.8034 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: StdK43LzHU43r0B8cCV0SQV42h1VCXAdqDGV1b0O7kwVD4G1uUqaO/tNBt02/T0Y+lpfoLl+B8tEo01k0vND9TlUmIgIDlkAaw8HU+lBRSA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5299
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe0a::722
Subject: Re: [Qemu-devel] [PATCH v6 0/3] qcow2: add zstd cluster compression
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

cGluZyENCg0KT24gMDUuMDkuMjAxOSAxMjozMSwgRGVuaXMgUGxvdG5pa292IHdyb3RlOg0KPiB2
NjoNCj4gKiBmaXhlZCB6c3RkIGNvbXByZXNzZWQgbGVuZ3RoIHN0b3JpbmcvbG9hZGluZyBbRXJp
Y10NCj4gKiBmaXhlZCB3b3JkaW5nLCBzcGVjIHNlY3Rpb24gcGxhY2VtZW50IFtFcmljXQ0KPg0K
PiB2NToNCj4gKiB0eXBlIGNoYW5nZWQgZm9yIGNvbXByZXNzaW9uX3R5cGUgYXQgQkRSVlFjb3cy
U3RhdGUgW0tldmluXQ0KPiAqIGZpeGVkIHR5cG9zLCBncmFtbWFyIFtLZXZpbl0NCj4gKiBmaXhl
ZCBkZWZhdWx0IGNvbmZpZyB6c3RkIHNldHRpbmcgW0tldmluXQ0KPg0KPiB2NDoNCj4gKiByZW1v
dmUgbm90IGZlYXNpYmxlIHN3aXRjaCBjYXNlIFtWbGFkaW1pcl0NCj4gKiBhZGQgc2FuaXR5IGNo
ZWNrcyB0byB6c3RkIGRlY29tcHJlc3NzaW9uIFtWbGFkaW1pcl0NCj4gKiBzdG9yZSB6c3RkIGNv
bXByZXNzZWQgbGVuZ3RoIGluIGJpZyBlbmRpYW4gW01heCwgS2V2aW5dDQo+DQo+IHYzOg0KPiAq
IHJlbGF4IHRoZSBjb21wcmVzc2lvbiB0eXBlIHNldHRpbmcgcmVxdWlyZW1lbnQgd2hlbg0KPiAg
ICB0aGUgY29tcHJlc3Npb24gdHlwZSBpcyBub3QgemxpYiBbRXJpYywgS2V2aW5dDQo+ICogYWRk
IGNvbXByZXNzaW9uIHR5cGUgdmFsdWVzIHRvIHRoZSBzcGVjIFtFcmljXQ0KPiAqIGZpeCB3b3Jk
aW5nIGluIHRoZSBzcGVjIGFuZCBkZXNjcmlwdGlvbnMgW0VyaWNdDQo+ICogZml4IGZ1bmN0aW9u
cyBkZXNjcmlwdGlvbnMgW01heF0NCj4gKiBmaXggenN0ZCAoZGUpY29tcHJlc3Npb24gZnVuY3Rp
b25zIGZsYXdzIFtNYXhdDQo+ICogZml4IHpzdGQgcmVsYXRlZCBwYXJ0cyBvZiBjb25maWd1cmUg
ZmlsZSBbTWF4XQ0KPiAqIHJlYmFzZWQgdG8gdjQuMS4wLXJjNSBhbmQgY2hlbmdlZCB0aGUgc2Vy
aWVzIHZlcnNpb24gYWltaW5nIHRvIDQuMg0KPg0KPiB2MjoNCj4gKiByZWxheCB0aGUgY29tcHJl
c3Npb24gdHlwZSBzZXR0aW5nIHJlc3RyaWN0aW9uIGluIHRoZSBzcGVjDQo+ICogZml4IHFjb3cy
IGhlYWRlciBzaXplIGNoZWNraW5nDQo+ICogZml4IGVycm9yIHByb2Nlc3NpbmcgYW5kIG1lc3Nh
Z2luZw0KPiAqIGZpeCBxY293MiBpbWFnZSBzcGVjaWZpYyBpbmZvIHJlcG9ydGluZw0KPiAqIHNl
dCBRY293MkNvbXByZXNzaW9uVHlwZSB6c3RkIGNvbmZpZyBkZXBlbmRhbnQNCj4gKiBhZGQgenN0
ZCBjb21wcmVzc2VkIGNsdXN0ZXIgZm9ybWF0IGRlc2NyaXB0aW9uIHRvIHRoZSBzcGVjDQo+DQo+
IHYxOg0KPiAqIGV4dGVuZCBxY293MiBoZWFkZXIgaW5zdGVhZCBvZiBhZGRpbmcgYSBuZXcgaW5j
b21wYXRpYmxlIGV4dGVuc2lvbiBoZWFkZXINCj4gc3BlY2lmaWNhdGlvbiByZS13cml0dGVuIGFj
Y29yZGluZ2x5DQo+ICogZW5hYmxlIHpzdGQgY29tcHJlc3Npb24gdmlhIGNvbmZpZw0KPiAqIGZp
eCB6c3RkIChkZSljb21wcmVzc2lvbiBmdW5jdGlvbnMNCj4gKiBmaXggY29tbWVudHMvZGVzY3Jp
cHRpb24NCj4gKiBmaXggZnVuY3Rpb24gbmFtaW5nDQo+DQo+IC0tLQ0KPiBUaGUgZ29hbCBvZiB0
aGUgcGF0Y2gtc2V0IGlzIHRvIGVuYWJsZSBxY293MiB0byB1c2UgenN0ZCBjb21wcmVzc2lvbiBm
b3INCj4gY2x1c3RlcnMuIFpTVEQgcHJvdmlkZXMgYmV0dGVyIChkZSljb21wcmVzc2lvbiBwZXJm
b3JtYW5jZSB0aGFuIGN1cnJlbnRseQ0KPiB1c2VkIFpMSUIuIFVzaW5nIGl0IHdpbGwgaW1wcm92
ZSBwZXJmb3JhbW5jZSAocmVkdWNlIGNvbXByZXNzaW9uIHRpbWUpDQo+IHdoZW4gdGhlIGNvbXBy
ZXNzZWQgY2x1c3RlcnMgaXMgdXNlZCwgZS5nIGJhY2t1cCBzY2VuYXJpb3MuDQo+DQo+IEFsc28s
IHRoZSBwYXRjaC1zZXQgZXh0ZW5kcyBxY293MiBzcGVjaWZpY2F0aW9uIGJ5IGFkZGluZyBjb21w
cmVzc2lvbl90eXBlDQo+IGZlYXR1cmUuIFRoZSBmZWF0dXJlIGVuYWJsZXMgYWRkaW5nIFpTVEQg
YW5kIGFub3RoZXIgY29tcHJlc3Npb24gYWxnb3JpdGhtcw0KPiBpbiB0aGUgZnV0dXJlLg0KPg0K
PiBIZXJlIGlzIHNvbWUgbWVhc3VyZW1lbnRzIFpTVEQgdnMgWkxJQjoNCj4NCj4gVGhlIHRlc3Q6
DQo+IFRlc3QgY29tcHJlc3NlcyBhbmQgZGVjb21wcmVzc2VzIHFlbXUgcWNvdzIgaW1hZ2Ugd2l0
aCBqdXN0DQo+IGluc3RhbGxlZCByaGVsLTcuNiBndWVzdC4NCj4gSW1hZ2UgY2x1c3RlciBzaXpl
OiA2NEsuIEltYWdlIG9uIGRpc2sgc2l6ZTogMi4yRw0KPg0KPiBUaGUgdGVzdCB3YXMgY29uZHVj
dGVkIHdpdGggYnJkIGRpc2sgdG8gcmVkdWNlIHRoZSBpbmZsdWVuY2UNCj4gb2YgZGlzayBzdWJz
eXN0ZW0gdG8gdGhlIHRlc3QgcmVzdWx0cy4NCj4gVGhlIHJlc3VsdHMgaXMgZ2l2ZW4gaW4gc2Vj
b25kcy4NCj4NCj4gY29tcHJlc3MgY21kOg0KPiB0aW1lIC4vcWVtdS1pbWcgY29udmVydCAtTyBx
Y293MiAtYyAtbyBjb21wcmVzc2lvbl90eXBlPVt6bGlifHpzdGRdDQo+IHNyYy5pbWcgW3psaWJ8
enN0ZF1fY29tcHJlc3NlZC5pbWcNCj4gZGVjb21wcmVzcyBjbWQNCj4gdGltZSAuL3FlbXUtaW1n
IGNvbnZlcnQgLU8gcWNvdzINCj4gW3psaWJ8enN0ZF1fY29tcHJlc3NlZC5pbWcgdW5jb21wcmVz
c2VkLmltZw0KPg0KPg0KPiBUaGUgcmVzdWx0czoNCj4gY29tcHJlc3Npb24gZGVjb21wcmVzc2lv
bg0KPiB6bGliIHpzdGQgemxpYiB6c3RkDQo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiByZWFsIDY1LjUgMTYuMyAoLTc1ICUp
IDEuOSAxLjYgKC0xNiAlKQ0KPiB1c2VyIDY1LjAgMTUuOCA1LjMgMi41DQo+IHN5cyAzLjMgMC4y
IDIuMCAyLjANCj4NCj4gQm90aCBaTElCIGFuZCBaU1REIGdhdmUgdGhlIHNhbWUgY29tcHJlc3Np
b24gcmF0aW86IH4xLjUNCj4gY29tcHJlc3NlZCBpbWFnZSBzaXplIGluIGJvdGggY2FzZXM6IH4x
LjRHDQo+DQo+IERlbmlzIFBsb3RuaWtvdiAoMyk6DQo+ICAgIHFjb3cyOiBpbnRyb2R1Y2UgY29t
cHJlc3Npb24gdHlwZSBmZWF0dXJlDQo+ICAgIHFjb3cyOiByZXdvcmsgdGhlIGNsdXN0ZXIgY29t
cHJlc3Npb24gcm91dGluZQ0KPiAgICBxY293MjogYWRkIHpzdGQgY2x1c3RlciBjb21wcmVzc2lv
bg0KPg0KPiAgIGJsb2NrL3Fjb3cyLXRocmVhZHMuYyAgICAgfCAxOTkgKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKystLS0NCj4gICBibG9jay9xY293Mi5jICAgICAgICAgICAgIHwg
IDk4ICsrKysrKysrKysrKysrKysrKysNCj4gICBibG9jay9xY293Mi5oICAgICAgICAgICAgIHwg
IDI2ICsrKy0tDQo+ICAgY29uZmlndXJlICAgICAgICAgICAgICAgICB8ICAyOSArKysrKysNCj4g
ICBkb2NzL2ludGVyb3AvcWNvdzIudHh0ICAgIHwgIDM1ICsrKysrKy0NCj4gICBpbmNsdWRlL2Js
b2NrL2Jsb2NrX2ludC5oIHwgICAxICsNCj4gICBxYXBpL2Jsb2NrLWNvcmUuanNvbiAgICAgIHwg
IDIzICsrKystDQo+ICAgNyBmaWxlcyBjaGFuZ2VkLCAzODcgaW5zZXJ0aW9ucygrKSwgMjQgZGVs
ZXRpb25zKC0pDQo+DQoNCg==

