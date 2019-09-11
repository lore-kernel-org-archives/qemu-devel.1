Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830C8C5ACAE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 14:12:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E2E520863
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 14:12:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="nmDQHwxF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E2E520863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i83Ly-0001fc-4J
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 10:12:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39061)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i83Jx-0000GY-8d
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 10:10:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i83Jw-0003sE-1L
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 10:10:09 -0400
Received: from mail-eopbgr130124.outbound.protection.outlook.com
 ([40.107.13.124]:62470 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i83Jn-0003ki-US; Wed, 11 Sep 2019 10:10:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bda8gxkm4Sw2kJuZTiWTOv6I10pimxOvC4zqZDlhrW6DBLth+/WzE2hymRqj1nJ5LDOGobypEN73Fbc42tQwGh1Dyby+v5djFVLaEtY/JEC1bIrv+pPopvFtuRyKndulmRhc8BPqojcKCUx31fw+TeyBJGyuXisIPKYToOxGkVGhgRTnZnYR1e9eApSSDJBKOodsBFF0IdsYDghQT/POGry/leT/lcOHIWOexEfYvJlazn9yEVpWtWzWHvJ8c2JAprwfSRBCTCGLksYEcce1dszlF0MfygsvZW5trs3hDQzjOwUXJxynRrwOWCCYGrY+kby0lyMQXSChNKv7U0XFtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w8C00f56fUW1sta4nrRTwCPmRnOCEsISsX7Rb+PWpr8=;
 b=nJ/ZPGQ9CgzEersDNgM9JRJIEHP2qJ6VExc2k831gSeJAVDg/sVVRDFd+OF6uS2KI0/eFZ1sNO42m+UNhQELmLSxpvlqGuP+VG3rcsL/rxFITLC5/QVJNIAsFikJyQGz5+x5YktnaKvUpotcwSPLhjjCwDllnmBS/UdJ8qs4xKBygvWtuxlcNRb9gs08APUCgFatASse61CdygVtsVcPuxHVAWyJMkCKyQAUTNIrum90i7LiawtgF8ppAcPm/PElzEt4jVmLrrzU6CWkMJerp8R7dDNTJmtGL3eYBWvOGOya37BObMBmiyxPcnriMHbarvyPrWxBtjxiw5j/cKn/PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w8C00f56fUW1sta4nrRTwCPmRnOCEsISsX7Rb+PWpr8=;
 b=nmDQHwxF9w3YYmFyTICdTbbZTXI3tE2tJnA2JRmlT4aTpMCx7XLMeW2jfZy8hCyvi8ssE1+SRZI1Tsf4GAjTEr2KxFafksZRLvXZsV7rZFUkqfYuQJj2evtOgzmmhw3qVSx71OGBFn5ZdaumeY8zHy+295ChKfBDnooqEMFQjQ8=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4139.eurprd08.prod.outlook.com (20.179.11.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.14; Wed, 11 Sep 2019 14:09:57 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2241.018; Wed, 11 Sep 2019
 14:09:57 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH 0/3] proper locking on bitmap add/remove
 paths
Thread-Index: AQHVZ/Sl8JlDvEflUE+vmp1j2//H2aclX1kAgAEl6YA=
Date: Wed, 11 Sep 2019 14:09:57 +0000
Message-ID: <cb8fd02c-4fe7-0594-3a89-1d91d02940fc@virtuozzo.com>
References: <156814787725.15929.11693446479791530766@5dec9699b7de>
In-Reply-To: <156814787725.15929.11693446479791530766@5dec9699b7de>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0502CA0024.eurprd05.prod.outlook.com
 (2603:10a6:3:e3::34) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190911170955019
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 52ccb6c8-af26-4ed7-c54c-08d736c1b9ec
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DB8PR08MB4139; 
x-ms-traffictypediagnostic: DB8PR08MB4139:
x-ms-exchange-purlcount: 3
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB41398958D68320316458C8B0C1B10@DB8PR08MB4139.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:499;
x-forefront-prvs: 0157DEB61B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(366004)(136003)(376002)(39850400004)(396003)(189003)(199004)(6116002)(386003)(3846002)(25786009)(86362001)(476003)(486006)(66946007)(6246003)(2616005)(186003)(52116002)(2501003)(99286004)(31696002)(76176011)(36756003)(6436002)(256004)(71190400001)(71200400001)(14444005)(66476007)(5660300002)(66446008)(64756008)(229853002)(26005)(2906002)(8936002)(6916009)(6512007)(478600001)(66066001)(6306002)(81156014)(81166006)(66556008)(102836004)(53936002)(6506007)(2351001)(53376002)(966005)(7736002)(8676002)(305945005)(11346002)(54906003)(446003)(6486002)(5640700003)(316002)(4326008)(31686004)(14454004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4139;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1tOSyFWxeMr581HIEJbLvIW6ELMa5skMPZV/ALTZQiRfUyMgtSAMzhOviKweGtos0LMyuaT5QVl8G3CjCyGI8wn6/iOoK3JQo7FGOwt/4tMiw1B1Wx6LVaff97uCQJQ6dBYLBIdEjlooxlRJM89zaepvDsqTscu63ZzzWGUEVVmNEICT7Nusq416XKFvKWbHUgYIkN391Y8+pZCgBeJB2RSxGepmNG7s3/Kdwz5v4DMtOFrv59+cQISxlVkFWchH+jhlVdvc+Hv4NuOk+PdsKbn5/BH9fcrqHfblPJDykXdOUQxvMq6rqdnKa1a27uFNrxoP9TcyCHQJ45yzn/Guv1dOpyzwEqTcrHWERVhBDRkOKqKmJbgEHEGel53I3atAz3ct+V/5L2ZqYZqrhZ66Ftq/TucB9vX8Ynv1mBUrJLc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4BFAD18C1FDC9B4687C0885CDDED7918@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52ccb6c8-af26-4ed7-c54c-08d736c1b9ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2019 14:09:57.3445 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NRR9DKs1CWwbml9cr5+BQ9PEe58CxUpNw16AX7lmJAO5PrRZIgYDi9n6X0wEf+vf7o+Klc8Jfxzv5DL5MsWQL30p555HfrzECatKw15qnjI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4139
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.124
Subject: Re: [Qemu-devel] [PATCH 0/3] proper locking on bitmap add/remove
 paths
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
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTAuMDkuMjAxOSAyMzozNywgbm8tcmVwbHlAcGF0Y2hldy5vcmcgd3JvdGU6DQo+IFBhdGNoZXcg
VVJMOiBodHRwczovL3BhdGNoZXcub3JnL1FFTVUvMjAxOTA5MTAxNjI3MjQuNzk1NzQtMS12c2Vt
ZW50c292QHZpcnR1b3p6by5jb20vDQo+IA0KPiANCj4gDQo+IEhpLA0KPiANCj4gVGhpcyBzZXJp
ZXMgZmFpbGVkIHRoZSBkb2NrZXItcXVpY2tAY2VudG9zNyBidWlsZCB0ZXN0LiBQbGVhc2UgZmlu
ZCB0aGUgdGVzdGluZyBjb21tYW5kcyBhbmQNCj4gdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3Ug
aGF2ZSBEb2NrZXIgaW5zdGFsbGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdA0KPiBs
b2NhbGx5Lg0KPiANCj4gPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQ0KPiAjIS9iaW4vYmFzaA0K
PiBtYWtlIGRvY2tlci1pbWFnZS1jZW50b3M3IFY9MSBORVRXT1JLPTENCj4gdGltZSBtYWtlIGRv
Y2tlci10ZXN0LXF1aWNrQGNlbnRvczcgU0hPV19FTlY9MSBKPTE0IE5FVFdPUks9MQ0KPiA9PT0g
VEVTVCBTQ1JJUFQgRU5EID09PQ0KPiANCj4gbGlidWRldiAgICAgICAgICAgbm8NCj4gZGVmYXVs
dCBkZXZpY2VzICAgeWVzDQo+IA0KPiB3YXJuaW5nOiBQeXRob24gMiBzdXBwb3J0IGlzIGRlcHJl
Y2F0ZWQNCj4gd2FybmluZzogUHl0aG9uIDMgd2lsbCBiZSByZXF1aXJlZCBmb3IgYnVpbGRpbmcg
ZnV0dXJlIHZlcnNpb25zIG9mIFFFTVUNCj4gDQo+IE5PVEU6IGNyb3NzLWNvbXBpbGVycyBlbmFi
bGVkOiAgJ2NjJw0KPiAgICBHRU4gICAgIHg4Nl82NC1zb2Z0bW11L2NvbmZpZy1kZXZpY2VzLm1h
ay50bXANCj4gLS0tDQo+ICAgIENDICAgICAgYmxvY2svcWVkLWNsdXN0ZXIubw0KPiAgICBDQyAg
ICAgIGJsb2NrL3FlZC1jaGVjay5vDQo+IC90bXAvcWVtdS10ZXN0L3NyYy9ibG9jay9xY293Mi1i
aXRtYXAuYzogSW4gZnVuY3Rpb24gJ3Fjb3cyX2NvX3JlbW92ZV9wZXJzaXN0ZW50X2RpcnR5X2Jp
dG1hcCc6DQo+IC90bXAvcWVtdS10ZXN0L3NyYy9ibG9jay9xY293Mi1iaXRtYXAuYzo1MDI6ODog
ZXJyb3I6ICdibScgbWF5IGJlIHVzZWQgdW5pbml0aWFsaXplZCBpbiB0aGlzIGZ1bmN0aW9uIFst
V2Vycm9yPW1heWJlLXVuaW5pdGlhbGl6ZWRdDQo+ICAgICAgIGlmIChibSA9PSBOVUxMKSB7DQo+
ICAgICAgICAgIF4NCj4gL3RtcC9xZW11LXRlc3Qvc3JjL2Jsb2NrL3Fjb3cyLWJpdG1hcC5jOjE0
MTM6MTg6IG5vdGU6ICdibScgd2FzIGRlY2xhcmVkIGhlcmUNCj4gDQo+IA0KPiBUaGUgZnVsbCBs
b2cgaXMgYXZhaWxhYmxlIGF0DQo+IGh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkwOTEwMTYy
NzI0Ljc5NTc0LTEtdnNlbWVudHNvdkB2aXJ0dW96em8uY29tL3Rlc3RpbmcuZG9ja2VyLXF1aWNr
QGNlbnRvczcvP3R5cGU9bWVzc2FnZS4NCj4gLS0tDQo+IEVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0
aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4NCj4gUGxlYXNlIHNlbmQg
eW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20NCj4gDQoNCldobyBrbm93
cywgaG93IHRvIGNsYW5nIFFlbXU/DQoNCkkgdHJ5IHdpdGgNCi4vY29uZmlndXJlIC0tdGFyZ2V0
LWxpc3Q9eDg2XzY0LXNvZnRtbXUgLS1lbmFibGUtZGVidWcgLS1kaXNhYmxlLXZpcnRmcyAtLWVu
YWJsZS13ZXJyb3IgLS1hdWRpby1kcnYtbGlzdD1vc3MgLS1leHRyYS1jZmxhZ3M9LVdhbGwgLS1l
bmFibGUtc2FuaXRpemVycyAtLWNjPWNsYW5nIC0tY3h4PWNsYW5nKysNCm1ha2UgLWo5DQoNCmJ1
dCBnZXQgdGhlIGZvbGxvd2luZyBlcnJvcjoNCg0KL3RtcC9saW51eGJvb3RfZG1hLTY3MTJjMC5z
OiBBc3NlbWJsZXIgbWVzc2FnZXM6DQovdG1wL2xpbnV4Ym9vdF9kbWEtNjcxMmMwLnM6NDczOiBF
cnJvcjogaW5jb25zaXN0ZW50IHVzZXMgb2YgLmNmaV9zZWN0aW9ucw0KY2xhbmc6IGVycm9yOiBh
c3NlbWJsZXIgY29tbWFuZCBmYWlsZWQgd2l0aCBleGl0IGNvZGUgMSAodXNlIC12IHRvIHNlZSBp
bnZvY2F0aW9uKQ0KbWFrZVsxXTogKioqIFtsaW51eGJvb3RfZG1hLm9dIEVycm9yIDENCm1ha2Vb
MV06ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uDQogICBTSUdOICAgIHBjLWJp
b3Mvb3B0aW9ucm9tL2xpbnV4Ym9vdC5iaW4NCiAgIExJTksgICAgaXZzaG1lbS1jbGllbnQNCi90
bXAvcHZoX21haW4tM2JiYzc1LnM6IEFzc2VtYmxlciBtZXNzYWdlczoNCi90bXAvcHZoX21haW4t
M2JiYzc1LnM6NjUxOiBFcnJvcjogaW5jb25zaXN0ZW50IHVzZXMgb2YgLmNmaV9zZWN0aW9ucw0K
Y2xhbmc6IGVycm9yOiBhc3NlbWJsZXIgY29tbWFuZCBmYWlsZWQgd2l0aCBleGl0IGNvZGUgMSAo
dXNlIC12IHRvIHNlZSBpbnZvY2F0aW9uKQ0KbWFrZVsxXTogKioqIFtwdmhfbWFpbi5vXSBFcnJv
ciAxDQptYWtlOiAqKiogW3BjLWJpb3Mvb3B0aW9ucm9tL2FsbF0gRXJyb3IgMg0KbWFrZTogKioq
IFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4NCm1ha2U6ICoqKiB3YWl0OiBObyBjaGls
ZCBwcm9jZXNzZXMuICBTdG9wLg0KDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

