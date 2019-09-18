Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0280CC4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 17:22:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3DC4208C0
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 17:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="StKgBhGD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3DC4208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAdf0-0000su-2f
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 13:22:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58464)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1iAcpb-0004DL-Pz
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 12:29:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1iAcpZ-0000bL-2X
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 12:29:27 -0400
Received: from mail-eopbgr10105.outbound.protection.outlook.com
 ([40.107.1.105]:7399 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1iAcpW-0000YR-7P; Wed, 18 Sep 2019 12:29:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ht90LirQTUeEMpxglPQfQoV/NotMKZ/oxwLL0Oyf1gCsLC21ptvO4NmxVyXpSY/SW+K8u9SFf6tkPWvu2wx1V/xtzyhZUgCs3xgVYgk0CP9lclcC/sfYvffKpTykOWUOTTfG9JkUKQ10q1Ct7aqzl+OMGBf+9Kdq5v9JfHIP801XiboRFrZfpnvbYK9GRd3l3RCF+DhVq/FPNK/uyYbcA/jPfMOG0PxUGJFrTUd5QziGzya5Wm5CVRpK5tL5MALK4gmktFgTcGvY1JiQcgMmfnmgqT3MIkvc51+8zK6nVgKiHFufX09zOwhqJS7bLXGzF3ly/NIpU22ycvsJye2hdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGZ5lZCgl7JQBJdrzynWNrO4yfWkHh9YNJ09ceZzi+k=;
 b=BWTWXnXeWN2hj1qLAp4017wG4uoPdO87zXkYRhQq0wgLdHZYR2x49jV2TiadvQQBdTxNegn7aOX7NcRzWSZiB29RHGZQYPt0JVZyjIQIOG7hLwu5EsskWupxlKVi90Lf3+sf55V99D+yGG3aoVlm9FvHD2ypE1WSelHV8g4/JpCS7q8nPXES2y8I4YFFNhppGMvTwJbi3gSPy4DIjWjQ25I34r6F35Vlv+syfgHZl9WSMAYNlRRLNd0Hy5MJawIMPJRNC1ZSIwBpc4UMj41u/UZQYfQuAq6a+elWzXFB0S4ogYt3js+59yGyQyEMuecaLpHG2eXYujJxorWLYHTSgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGZ5lZCgl7JQBJdrzynWNrO4yfWkHh9YNJ09ceZzi+k=;
 b=StKgBhGDmPLqPVXhjPoEMNWyLwTU/91fIE0xb/600+TJb/D4oaV9eGsF7Tcn44xocixhWXRVrqr0oMJ8+EUoihcNmsFXXnve8MGs2pcfVzCYbpfWFvBtlK5rRy81NzlHiOswqFbwdnDEGh6mj4NILuXib0q2eR5b+hOFZX9/osc=
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB4481.eurprd08.prod.outlook.com (20.179.36.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.14; Wed, 18 Sep 2019 16:29:18 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::302b:b479:1322:9d31]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::302b:b479:1322:9d31%5]) with mapi id 15.20.2284.009; Wed, 18 Sep 2019
 16:29:18 +0000
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [Ping] [PATCH v6 0/3] qcow2: add zstd cluster compression
Thread-Index: AQHVbj44c0thuovGjEe/EN8iLIPupg==
Date: Wed, 18 Sep 2019 16:29:18 +0000
Message-ID: <4cfcdf5d-efab-1d18-3bd6-240613ee84cc@virtuozzo.com>
References: <20190905093109.12261-1-dplotnikov@virtuozzo.com>
 <8c42f523-23ad-1bce-5315-c1f4511723de@virtuozzo.com>
In-Reply-To: <8c42f523-23ad-1bce-5315-c1f4511723de@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
x-originating-ip: [94.233.240.226]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 11a50c08-5665-48cc-2ab7-08d73c555ab8
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:AM0PR08MB4481; 
x-ms-traffictypediagnostic: AM0PR08MB4481:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB44815570CFD8B96109C1ACA9CF8E0@AM0PR08MB4481.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01644DCF4A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(376002)(346002)(366004)(396003)(39850400004)(199004)(189003)(81156014)(6916009)(81166006)(76176011)(6486002)(446003)(25786009)(4326008)(66066001)(186003)(6436002)(102836004)(11346002)(486006)(476003)(305945005)(2616005)(31696002)(26005)(53546011)(7736002)(6506007)(2906002)(8676002)(5660300002)(14454004)(36756003)(71200400001)(256004)(6116002)(76116006)(71190400001)(5640700003)(2351001)(478600001)(99286004)(8936002)(19627235002)(86362001)(3846002)(2501003)(31686004)(54906003)(66946007)(64756008)(66476007)(66556008)(316002)(6512007)(66446008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4481;
 H:AM0PR08MB3745.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Rt5G+FdQ4WJOGuCfmAlI7hO8DYCVCwZcc3Y3MnwpY7e0YrtgdROcfrZTAMhHFSTTm7nYhKD5iFIbIDaq9IVwnbJPDmaYYFewSxd8F3a7PH+SHi184gUxSHKrZy47FCTraPCuNQwrD7gcPeNUY8CtpChgzQPreHTxlZ3Mfd5kF2Fjry056DWY3L2aqo/etl4u1oPmUgLlkPUJAMkYohg96fw8kqkTrgHMyAM9eUKheSyjguGRuX406oCPqTvGYyDvMs5KZFkamVUp5TRr2sJYhd4p7FdQkdqIFp5YL5o9ToKTpvzXkIv+RISqkHu3rBZQBIGDHxzoC8TlBFafcBzWdm0sFZKWOEaNhAjGVnDWZbwT/Kg6UIzoj/PawG9BJKltN0JOwsiv64JbR+UMoNWZulBfs4u40DpDUJmcBVV8u1M=
Content-Type: text/plain; charset="utf-8"
Content-ID: <04001CB8520F9848A496E2A70ADCD4DB@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11a50c08-5665-48cc-2ab7-08d73c555ab8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2019 16:29:18.7660 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2pamth3/hgUlXpg1GeJStraOvyLsUftdBEr5AGi8tbAhRbaar7C9tCRv8Kj97YMZQ+4/DyOf4hnW4K4kGt2BlV4QJgBuV8kUEMiQINidHVE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4481
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.105
Subject: [Qemu-devel] [Ping] [PATCH v6 0/3] qcow2: add zstd cluster
 compression
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
 "armbru@redhat.com" <armbru@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gMTIuMDkuMjAxOSAxMTo0NiwgRGVuaXMgUGxvdG5pa292IHdyb3RlOg0KPiBwaW5nIQ0KPg0K
PiBPbiAwNS4wOS4yMDE5IDEyOjMxLCBEZW5pcyBQbG90bmlrb3Ygd3JvdGU6DQo+PiB2NjoNCj4+
ICogZml4ZWQgenN0ZCBjb21wcmVzc2VkIGxlbmd0aCBzdG9yaW5nL2xvYWRpbmcgW0VyaWNdDQo+
PiAqIGZpeGVkIHdvcmRpbmcsIHNwZWMgc2VjdGlvbiBwbGFjZW1lbnQgW0VyaWNdDQo+Pg0KPj4g
djU6DQo+PiAqIHR5cGUgY2hhbmdlZCBmb3IgY29tcHJlc3Npb25fdHlwZSBhdCBCRFJWUWNvdzJT
dGF0ZSBbS2V2aW5dDQo+PiAqIGZpeGVkIHR5cG9zLCBncmFtbWFyIFtLZXZpbl0NCj4+ICogZml4
ZWQgZGVmYXVsdCBjb25maWcgenN0ZCBzZXR0aW5nIFtLZXZpbl0NCj4+DQo+PiB2NDoNCj4+ICog
cmVtb3ZlIG5vdCBmZWFzaWJsZSBzd2l0Y2ggY2FzZSBbVmxhZGltaXJdDQo+PiAqIGFkZCBzYW5p
dHkgY2hlY2tzIHRvIHpzdGQgZGVjb21wcmVzc3Npb24gW1ZsYWRpbWlyXQ0KPj4gKiBzdG9yZSB6
c3RkIGNvbXByZXNzZWQgbGVuZ3RoIGluIGJpZyBlbmRpYW4gW01heCwgS2V2aW5dDQo+Pg0KPj4g
djM6DQo+PiAqIHJlbGF4IHRoZSBjb21wcmVzc2lvbiB0eXBlIHNldHRpbmcgcmVxdWlyZW1lbnQg
d2hlbg0KPj4gICAgIHRoZSBjb21wcmVzc2lvbiB0eXBlIGlzIG5vdCB6bGliIFtFcmljLCBLZXZp
bl0NCj4+ICogYWRkIGNvbXByZXNzaW9uIHR5cGUgdmFsdWVzIHRvIHRoZSBzcGVjIFtFcmljXQ0K
Pj4gKiBmaXggd29yZGluZyBpbiB0aGUgc3BlYyBhbmQgZGVzY3JpcHRpb25zIFtFcmljXQ0KPj4g
KiBmaXggZnVuY3Rpb25zIGRlc2NyaXB0aW9ucyBbTWF4XQ0KPj4gKiBmaXggenN0ZCAoZGUpY29t
cHJlc3Npb24gZnVuY3Rpb25zIGZsYXdzIFtNYXhdDQo+PiAqIGZpeCB6c3RkIHJlbGF0ZWQgcGFy
dHMgb2YgY29uZmlndXJlIGZpbGUgW01heF0NCj4+ICogcmViYXNlZCB0byB2NC4xLjAtcmM1IGFu
ZCBjaGVuZ2VkIHRoZSBzZXJpZXMgdmVyc2lvbiBhaW1pbmcgdG8gNC4yDQo+Pg0KPj4gdjI6DQo+
PiAqIHJlbGF4IHRoZSBjb21wcmVzc2lvbiB0eXBlIHNldHRpbmcgcmVzdHJpY3Rpb24gaW4gdGhl
IHNwZWMNCj4+ICogZml4IHFjb3cyIGhlYWRlciBzaXplIGNoZWNraW5nDQo+PiAqIGZpeCBlcnJv
ciBwcm9jZXNzaW5nIGFuZCBtZXNzYWdpbmcNCj4+ICogZml4IHFjb3cyIGltYWdlIHNwZWNpZmlj
IGluZm8gcmVwb3J0aW5nDQo+PiAqIHNldCBRY293MkNvbXByZXNzaW9uVHlwZSB6c3RkIGNvbmZp
ZyBkZXBlbmRhbnQNCj4+ICogYWRkIHpzdGQgY29tcHJlc3NlZCBjbHVzdGVyIGZvcm1hdCBkZXNj
cmlwdGlvbiB0byB0aGUgc3BlYw0KPj4NCj4+IHYxOg0KPj4gKiBleHRlbmQgcWNvdzIgaGVhZGVy
IGluc3RlYWQgb2YgYWRkaW5nIGEgbmV3IGluY29tcGF0aWJsZSBleHRlbnNpb24gaGVhZGVyDQo+
PiBzcGVjaWZpY2F0aW9uIHJlLXdyaXR0ZW4gYWNjb3JkaW5nbHkNCj4+ICogZW5hYmxlIHpzdGQg
Y29tcHJlc3Npb24gdmlhIGNvbmZpZw0KPj4gKiBmaXggenN0ZCAoZGUpY29tcHJlc3Npb24gZnVu
Y3Rpb25zDQo+PiAqIGZpeCBjb21tZW50cy9kZXNjcmlwdGlvbg0KPj4gKiBmaXggZnVuY3Rpb24g
bmFtaW5nDQo+Pg0KPj4gLS0tDQo+PiBUaGUgZ29hbCBvZiB0aGUgcGF0Y2gtc2V0IGlzIHRvIGVu
YWJsZSBxY293MiB0byB1c2UgenN0ZCBjb21wcmVzc2lvbiBmb3INCj4+IGNsdXN0ZXJzLiBaU1RE
IHByb3ZpZGVzIGJldHRlciAoZGUpY29tcHJlc3Npb24gcGVyZm9ybWFuY2UgdGhhbiBjdXJyZW50
bHkNCj4+IHVzZWQgWkxJQi4gVXNpbmcgaXQgd2lsbCBpbXByb3ZlIHBlcmZvcmFtbmNlIChyZWR1
Y2UgY29tcHJlc3Npb24gdGltZSkNCj4+IHdoZW4gdGhlIGNvbXByZXNzZWQgY2x1c3RlcnMgaXMg
dXNlZCwgZS5nIGJhY2t1cCBzY2VuYXJpb3MuDQo+Pg0KPj4gQWxzbywgdGhlIHBhdGNoLXNldCBl
eHRlbmRzIHFjb3cyIHNwZWNpZmljYXRpb24gYnkgYWRkaW5nIGNvbXByZXNzaW9uX3R5cGUNCj4+
IGZlYXR1cmUuIFRoZSBmZWF0dXJlIGVuYWJsZXMgYWRkaW5nIFpTVEQgYW5kIGFub3RoZXIgY29t
cHJlc3Npb24gYWxnb3JpdGhtcw0KPj4gaW4gdGhlIGZ1dHVyZS4NCj4+DQo+PiBIZXJlIGlzIHNv
bWUgbWVhc3VyZW1lbnRzIFpTVEQgdnMgWkxJQjoNCj4+DQo+PiBUaGUgdGVzdDoNCj4+IFRlc3Qg
Y29tcHJlc3NlcyBhbmQgZGVjb21wcmVzc2VzIHFlbXUgcWNvdzIgaW1hZ2Ugd2l0aCBqdXN0DQo+
PiBpbnN0YWxsZWQgcmhlbC03LjYgZ3Vlc3QuDQo+PiBJbWFnZSBjbHVzdGVyIHNpemU6IDY0Sy4g
SW1hZ2Ugb24gZGlzayBzaXplOiAyLjJHDQo+Pg0KPj4gVGhlIHRlc3Qgd2FzIGNvbmR1Y3RlZCB3
aXRoIGJyZCBkaXNrIHRvIHJlZHVjZSB0aGUgaW5mbHVlbmNlDQo+PiBvZiBkaXNrIHN1YnN5c3Rl
bSB0byB0aGUgdGVzdCByZXN1bHRzLg0KPj4gVGhlIHJlc3VsdHMgaXMgZ2l2ZW4gaW4gc2Vjb25k
cy4NCj4+DQo+PiBjb21wcmVzcyBjbWQ6DQo+PiB0aW1lIC4vcWVtdS1pbWcgY29udmVydCAtTyBx
Y293MiAtYyAtbyBjb21wcmVzc2lvbl90eXBlPVt6bGlifHpzdGRdDQo+PiBzcmMuaW1nIFt6bGli
fHpzdGRdX2NvbXByZXNzZWQuaW1nDQo+PiBkZWNvbXByZXNzIGNtZA0KPj4gdGltZSAuL3FlbXUt
aW1nIGNvbnZlcnQgLU8gcWNvdzINCj4+IFt6bGlifHpzdGRdX2NvbXByZXNzZWQuaW1nIHVuY29t
cHJlc3NlZC5pbWcNCj4+DQo+Pg0KPj4gVGhlIHJlc3VsdHM6DQo+PiBjb21wcmVzc2lvbiBkZWNv
bXByZXNzaW9uDQo+PiB6bGliIHpzdGQgemxpYiB6c3RkDQo+PiAtLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4+IHJlYWwgNjUuNSAx
Ni4zICgtNzUgJSkgMS45IDEuNiAoLTE2ICUpDQo+PiB1c2VyIDY1LjAgMTUuOCA1LjMgMi41DQo+
PiBzeXMgMy4zIDAuMiAyLjAgMi4wDQo+Pg0KPj4gQm90aCBaTElCIGFuZCBaU1REIGdhdmUgdGhl
IHNhbWUgY29tcHJlc3Npb24gcmF0aW86IH4xLjUNCj4+IGNvbXByZXNzZWQgaW1hZ2Ugc2l6ZSBp
biBib3RoIGNhc2VzOiB+MS40Rw0KPj4NCj4+IERlbmlzIFBsb3RuaWtvdiAoMyk6DQo+PiAgICAg
cWNvdzI6IGludHJvZHVjZSBjb21wcmVzc2lvbiB0eXBlIGZlYXR1cmUNCj4+ICAgICBxY293Mjog
cmV3b3JrIHRoZSBjbHVzdGVyIGNvbXByZXNzaW9uIHJvdXRpbmUNCj4+ICAgICBxY293MjogYWRk
IHpzdGQgY2x1c3RlciBjb21wcmVzc2lvbg0KPj4NCj4+ICAgIGJsb2NrL3Fjb3cyLXRocmVhZHMu
YyAgICAgfCAxOTkgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0NCj4+ICAg
IGJsb2NrL3Fjb3cyLmMgICAgICAgICAgICAgfCAgOTggKysrKysrKysrKysrKysrKysrKw0KPj4g
ICAgYmxvY2svcWNvdzIuaCAgICAgICAgICAgICB8ICAyNiArKystLQ0KPj4gICAgY29uZmlndXJl
ICAgICAgICAgICAgICAgICB8ICAyOSArKysrKysNCj4+ICAgIGRvY3MvaW50ZXJvcC9xY293Mi50
eHQgICAgfCAgMzUgKysrKysrLQ0KPj4gICAgaW5jbHVkZS9ibG9jay9ibG9ja19pbnQuaCB8ICAg
MSArDQo+PiAgICBxYXBpL2Jsb2NrLWNvcmUuanNvbiAgICAgIHwgIDIzICsrKystDQo+PiAgICA3
IGZpbGVzIGNoYW5nZWQsIDM4NyBpbnNlcnRpb25zKCspLCAyNCBkZWxldGlvbnMoLSkNCj4+DQoN
Cg==

