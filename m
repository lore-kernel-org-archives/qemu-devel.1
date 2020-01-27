Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98EF0C32771
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 07:19:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BE80214AF
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 07:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="o3XPpO2w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BE80214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ivygX-0007fC-GR
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 02:19:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39017)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1ivyfw-0007Gi-Np
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 02:19:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1ivyfu-0007D3-Ti
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 02:19:12 -0500
Received: from mail-db8eur05on2120.outbound.protection.outlook.com
 ([40.107.20.120]:52640 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1ivyfu-0007Be-Ao
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 02:19:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KYJN5OX0LUvkfpRTL3G6iQZMpo0eoBYP4iGqsGaoG1dBwJ5AWi3hgxeEWQ6fLMiVif+h9THFrjjZ/gUCJo40jHSKaloz5JMEFmXQDy3NJS44cbGZPDWKoqYYXbqgXPI/CaBcyz2h8a8IlyRUqf0dCJtn/xN4GgI3tyrhww5wExC1WEZOsqzIYDPIOxDiAt6lukeXsNaiXXm+PWrU2Mucwy0PKb4pOkS1Jo5Oa7iu9HVvjuB/gta/glqAIeeEPdTTfc5y7aSuwEJ6m1XgXXGx+uupEmac9BDXp69CAtAdQyVngBxHnDtddpU87SWXtj4Y3XsW2rhP6e/TvNb/3jEcDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m2S9hEDn3zJB9rozQUv9tPMJah4paJ4PrrSz9eT8uEA=;
 b=jXRdKtBTAsrMcty+L2p2SS/y7ziQyxHtxP02Y2TvO4NCUi8UuKD5obbB9O4+QIWP9MbrFFrJDvpVP5c17wofi+vR4dN7A+7WmpuRUnURho1ehm4cfyhIRnP0CLGLJI3gqjbwfy1zTyuJHRa+Rg5Cumc2VUitn7X65pX8eVEBc/HFr/mKU2NqvJz/WDkq28GdFefK4S+MsocOpGsWOZwsQsYjHraHOYHWeB0Xf0VZZ/5tRxX7LwDcVzQb2fp3/459QArT1jHqzGaK6bgRkFOAYCCByt98RDtjZfXQyvfpWri+UhH6jNKfjMsy/V/autoU5WvFbFe0T5+xxd8D4Q8rEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m2S9hEDn3zJB9rozQUv9tPMJah4paJ4PrrSz9eT8uEA=;
 b=o3XPpO2wCGGQADsK585oRHqDXBIEpnGzDkC8nTtcFLykog2jgeeAaKgcyBqchchLNmjOlpjURQXXdc9uvzrcsTuc7oq83UQOKli7uIK8HN9zBP2Dyj7OSxVZuodV4TEnyxEha1hTtI7RsXlRaHsCCDzIxBTqZb86/bTGW8rV41k=
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB3283.eurprd08.prod.outlook.com (52.134.94.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.22; Mon, 27 Jan 2020 07:19:06 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::5558:d9d2:7f7d:e4]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::5558:d9d2:7f7d:e4%2]) with mapi id 15.20.2665.025; Mon, 27 Jan 2020
 07:19:06 +0000
Received: from [192.168.1.63] (178.34.161.7) by
 HE1PR02CA0094.eurprd02.prod.outlook.com (2603:10a6:7:29::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.20 via Frontend Transport; Mon, 27 Jan 2020 07:19:05 +0000
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: "quintela@redhat.com" <quintela@redhat.com>
Subject: Re: [PATCH 0/3] migration: add sztd compression
Thread-Topic: [PATCH 0/3] migration: add sztd compression
Thread-Index: AQHV0rPjbIT2jCdaJkOsmtBiLTdSD6f+HrEA
Date: Mon, 27 Jan 2020 07:19:06 +0000
Message-ID: <7cb3de14-6ba3-b978-4da1-1261e20950ae@virtuozzo.com>
References: <20190226131535.30361-1-dplotnikov@virtuozzo.com>
 <87o8ut3tzo.fsf@secure.laptop>
In-Reply-To: <87o8ut3tzo.fsf@secure.laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR02CA0094.eurprd02.prod.outlook.com
 (2603:10a6:7:29::23) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [178.34.161.7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2efe6222-888b-45d7-dc36-08d7a2f93190
x-ms-traffictypediagnostic: AM0PR08MB3283:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB3283D7F48596A18542B08391CF0B0@AM0PR08MB3283.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02951C14DC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(346002)(136003)(396003)(366004)(39840400004)(199004)(189003)(81166006)(16576012)(4326008)(81156014)(316002)(8676002)(54906003)(8936002)(6916009)(6486002)(5660300002)(2616005)(956004)(26005)(16526019)(186003)(52116002)(53546011)(31686004)(66476007)(64756008)(66556008)(2906002)(478600001)(71200400001)(31696002)(86362001)(36756003)(66446008)(66946007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3283;
 H:AM0PR08MB3745.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KIJbGPQjPZb6IjZZIE8XFyfBjnKZgPJUQEKL+eyJ/4IPprHgp58O+mCFPnkHITQ54MTew9Fy7A5BP7aoUNyPj8b+lvkXrFVZZk/O/+vR0Cyt8roMZu6fF2RyMlZDHtSRo9UX1jE3ClsRNlUmliYzpD2wmCLhrm3kFkFXcLXNL2SKrynN1TH7/HWQQigUbdCDwsUgR+D4hWMgVFA6wPjXnGvJZzdUwalmEgigZLSjEa66xNntEAEVAILnZQy5zWRi3mGzHubNmp+woBabIdVaiAyztHprcgxUMCAKM6qf2RQmDqeyj26d2e0QPKor7mXcYG+OLq85APDMoIdrIkvagjPr6uVY+TV0kFlfcnfHb6gbR1+qoalZcCNX51AMRBuvuDiAEA4BvfANhMf5rX0d/9vZRRGfQDaIZGfwSabTKmacLy7AujeCnTDmP2gFoLkq
x-ms-exchange-antispam-messagedata: 5CkVJytvLw3PRSgxhzpxzMKzOUjSZjTdSQcXcTvklW7Z6CL3eGG2ciC/7OAGwybKFGLA2a7bMydAs5V+87pwTU61e6Wc/czTfX4Db+5VjZ/KizGb8NG7WD3EJK23DKUupEeJtlK0Ctbjic/Tj7i/jA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <13B4252AF2364F47B1402D031EBD126A@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2efe6222-888b-45d7-dc36-08d7a2f93190
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2020 07:19:06.1006 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JAKTaGFomQu0Pop3p6nTAelbDe+SM0n/Gg6J5UYEkjzRT801fHcNjG6TowNg1xiuSNhV8p1B52K8lC4XdlR7Ee0X6b2mDoKQ74k1raYQfzs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3283
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.20.120
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
Cc: Denis Lunev <den@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGksIEp1YW4NCg0KSSdsbCByZWFkIHRoZSBzZXJpZXMgc29vbi4gVGhhbmtzIGZvciBzZW5kaW5n
IHRoYXQgdG8gbWUhDQoNCkRlbmlzDQoNCk9uIDI0LjAxLjIwMjAgMTU6NDMsIEp1YW4gUXVpbnRl
bGEgd3JvdGU6DQo+IERlbmlzIFBsb3RuaWtvdiA8ZHBsb3RuaWtvdkB2aXJ0dW96em8uY29tPiB3
cm90ZToNCj4+IHpzdGQgZGF0ZSBjb21wcmVzc2lvbiBhbGdvcml0aG0gc2hvd3MgYmV0dGVyIHBl
cmZvcm1hbmNlIG9uIGRhdGEgY29tcHJlc3Npb24uDQo+PiBJdCBtaWdodCBiZSB1c2VmdWwgdG8g
ZW1wbG95IHRoZSBhbGdvcml0aG0gaW4gVk0gbWlncmF0aW9uIHRvIHJlZHVjZSBDUFUgdXNhZ2Uu
DQo+PiBBIHVzZXIgd2lsbCBiZSBhYmxlIHRvIGNob29zZSBiZXR3ZWVuIHRob3NlIGFsZ29yaXRo
bXMsIHRoZXJlZm9yIGNvbXByZXNzLXR5cGUNCj4+IG1pZ3JhdGlvbiBwYXJhbWV0ZXIgaXMgYWRk
ZWQuDQo+Pg0KPj4gSGVyZSBhcmUgc29tZSByZXN1bHRzIG9mIHBlcmZvcm1hbmNlIGNvbXBhcmlz
b24genN0ZCB2cyBnemlwOg0KPiBQbGVhc2UsIGNvdWxkIHlvdSBjb21tZW50IG9uIHRoZSBzZXJp
ZXM6DQo+DQo+IFtQQVRDSCB2MyAwMC8yMV0gTXVsdGlmZCBNaWdyYXRpb24gQ29tcHJlc3Npb24N
Cj4NCj4gVGhhdCBzZXJpZXMgaW50ZWdyYXRlZCB6c3RkL3psaWIgY29tcHJlc3Npb24gb24gdG9w
IG9mIG11bHRpZmQsDQo+IGFkdmFudGFnZXMgb3ZlciAib2xkIiBjb21wcmVzc2lvbiBjb2RlIGFy
ZToNCj4gLSBXZSBkb24ndCBoYXZlIHRvIGNvcHkgZGF0YSBiYWNrIGFuZCBmb3J0aA0KPiAtIFRo
ZSB1bml0IG9mIGNvbXByZXNzaW9uIGlzIDUxMktCIGluc3RlYWQgb2YgNGtiDQo+IC0gV2UgImNv
bnNlcnZlIiB0aGUgY29tcHJlc3Npb24gc3RhdGUgYmV0d2VlbiBwYWNrZXRzICh0aGlzIGlzIHNw
ZWNpYWxseQ0KPiAgICBpbnRlcmVzdGluZyBmb3IgenN0ZCwgdGhhdCB1c2VzIGRpY3Rpb25hcmll
cykNCj4NCj4+IGhvc3Q6IGk3LTQ3OTAgOHhDUFUgQCAzLjYwR0h6LCAxNkcgUkFNDQo+PiBtaWdy
YXRpb24gdG8gdGhlIHNhbWUgaG9zdA0KPj4gVk06IDJ4VkNQVSwgOEcgUkFNIHRvdGFsDQo+PiA1
RyBSQU0gdXNlZCwgbWVtb3J5IHBvcHVsYXRlZCB3aXRoIHBvc3RncmVxc2wgZGF0YQ0KPj4gcHJv
ZHVjZWQgYnkgcGdiZW5jaCBwZXJmb3JtYW5jZSBiZW5jaG1hcmsNCj4+DQo+Pg0KPj4gVGhyZWFk
czogMSBjb21wcmVzcyDigJMgMSBkZWNvbXByZXNzDQo+Pg0KPj4genN0ZCBwcm92aWRlcyBzbGln
aHRseSBsZXNzIGNvbXByZXNzaW9uIHJhdGlvIHdpdGggYWxtb3N0IHRoZSBzYW1lDQo+PiBDUFUg
dXNhZ2UgYnV0IGNvcGVzIHdpdGggUkFNICBjb21wcmVzc2lvbiByb2dobHkgMiB0aW1lcyBmYXN0
ZXINCj4+DQo+PiBjb21wcmVzc2lvbiB0eXBlICAgICAgICAgICAgICB6bGliICAgICAgIHwgICAg
ICB6c3RkDQo+PiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0NCj4+IGNvbXByZXNzaW9uIGxldmVsICAgICAgICAgIDEgICAgICAgNSAgICAg
fCAgIDEgICAgICAgNQ0KPj4gY29tcHJlc3Npb24gcmF0aW8gICAgICAgICAgNi45MiAgICA3LjA1
ICB8ICAgNi42OSAgICA2Ljg5DQo+PiBjcHUgaWRsZSwgJSAgICAgICAgICAgICAgICA4MiAgICAg
IDgzICAgIHwgICA4NiAgICAgIDgwDQo+PiB0aW1lLCBzZWMgICAgICAgICAgICAgICAgICA0OSAg
ICAgIDcxICAgIHwgICAyNiAgICAgIDMxDQo+PiB0aW1lIGRpZmYgdG8gemxpYiwgc2VjICAgICAg
ICAgICAgICAgICAgICAgIC0yNSAgICAgLTQxDQo+Pg0KPj4NCj4+IFRocmVhZHM6IDggY29tcHJl
c3Mg4oCTIDIgZGVjb21wcmVzcw0KPj4NCj4+IHpzdGQgcHJvdmlkZXMgdGhlIHNhbWUgbWlncmF0
aW9uIHRpbWUgd2l0aCBsZXNzIGNwdSBjb25zdW1wdGlvbg0KPj4NCj4+IGNvbXByZXNzaW9uIHR5
cGUgICAgICAgICBub25lICB8ICAgICAgICBnemlwKHpsaWIpICAgIHwgICAgICAgICAgenN0ZA0K
Pj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+PiBjb21wcmVzc2lvbiBsZXZlbCAgICAgICAgLSAg
ICAgfCAgMSAgICAgIDUgICAgICAgOSAgICB8ICAgMSAgICAgICA1ICAgICAgIDE1DQo+PiBjb21w
cmVzc2lvbiByYXRpbyAgICAgICAgLSAgICAgfCAgNi45NCAgIDYuOTkgICAgNy4xNCB8ICAgNi42
NCAgICA2Ljg5ICAgIDYuOTMNCj4+IHRpbWUsIHNlYyAgICAgICAgICAgICAgICAxNTQgICB8ICAy
MiAgICAgMjMgICAgICAyNyAgIHwgICAyMyAgICAgIDIzICAgICAgMjUNCj4+IGNwdSBpZGxlLCAl
ICAgICAgICAgICAgICA5OSAgICB8ICA0NSAgICAgMzAgICAgICAxMiAgIHwgICA3MCAgICAgIDUy
ICAgICAgMjMNCj4+IGNwdSBpZGxlIGRpZmYgdG8gemxpYiAgICAgICAgICB8ICAgICAgICAgICAg
ICAgICAgICAgIHwgIC0yNSUgICAgLTIyJSAgICAtMTElDQo+IEkgZG9uJ3QgaGF2ZSBoYW5keSBy
ZXN1bHRzLCBidXQgaXQgbG9va2VkIGZvciBtZSBsaWtlIHlvdToNCj4gLSB6c3RkIGhhcyBhIHdh
eSBiZXR0ZXIgbGF0ZW5jeSB0aGFuIHpsaWIgKGkuZS4gdGhlIHBhY2tldCBjYW1lcyBzb29uZXIp
DQo+IC0gQW5kIGl0IGNvbXByZXNzIG11Y2ggYmV0dGVyDQo+DQo+IE9uIHRoZSBtaWdyYXRpb24g
dGVzdCAoYmVzdCBwb3NzaWJsZSBjYXNlIGZvciBhIGNvbXByZXNzb3IsIGFzIHdlIGFyZQ0KPiB3
cml0dGluZyBqdXN0IG9uZSBieXRlIG9mIGVhY2ggcGFnZSwgYW5kIHdlIHdyaXRlIHRoZSBzYW1l
IHZhbHVlIGluIGFsbA0KPiBwYWdlcyk6DQo+DQo+IC0gemxpYjogY29tcHJlc3MgNTEyS0IgLT4g
MjUwMCBieXRlcw0KPiAtIHpzdGQ6IGNvbXBlc3MgNTEyS0IgLT4gNTIgYnl0ZXMgKHllYXAsIEkg
dGVzdGVkIHNldmVyYWwgdGltZXMsIGl0DQo+ICAgIGxvb2tlZCB0b28gc21hbGwpDQo+DQo+IFNl
ZSB0aGF0IEkgcG9zdGVkIGFub3RoZXIgcGF0Y2ggdG8gImRlbGV0ZSIgdGhlIG9sZCBjb21wcmVz
c2lvbiBjb2RlLg0KPiBXaHk/DQo+IC0gSSBoYXZlIGJlZW4gdW5hYmxlIHRvIG1vZGlmeSBtaWdy
YXRpb24tdGVzdCB0byB0ZXN0IGl0IGFuZCB3b3JrDQo+ICAgIHJlbGlhYmxlbHkgKG9ubHkgd2F5
IHdhcyB0byBhbGxvdyBhIHJlYWxseSBodWdlIGRvd250aW1lKQ0KPiAtIEV2ZW4gd2l0aCBzbG93
IG5ldHdvcmtpbmcgKDFHaWdhYml0KSBJIGdvdCByZWFsbHkgbWl4ZWQgcmVzdWx0cywNCj4gICAg
YmVjYXVzZSBhcyBpdCBpcyBzbyBzbG93LCB0aGUgZ3Vlc3QgY29udGludWUgZGlydHlpbmcgbWVt
b3J5LCBhbmQgaW4NCj4gICAgbXkgdGVzdHMgaXQgd2FzIG5ldmVyIGEgd2lubmVyDQo+DQo+IFRo
YW5rcywgSnVhbi4NCj4NCg0K

