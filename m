Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC9FC28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 15:48:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D90F2083E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 15:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="NI1htU1i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D90F2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44815 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYY9i-0002UB-A4
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 11:48:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hYY8m-00028J-F7
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 11:47:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hYY8k-0003tq-O8
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 11:47:52 -0400
Received: from mail-eopbgr130135.outbound.protection.outlook.com
	([40.107.13.135]:16806
	helo=EUR01-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hYY8X-0001oQ-5i; Wed, 05 Jun 2019 11:47:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=SuZme9icPodpDK1O0ff0f555IiBIpr716jYwDuyoj1o=;
	b=NI1htU1i6LWiEsnTbVeOAm5B2z5y4yBRXd+rW348UKjTVWbD8edXbM53eJ2ZrI9Kd78m/Apd9vSkwwrbDQd6KtX4Anml0xbA5oXKDU5pNIXVNv/514s4xWK1ugsY0M3UoSxEpHU2LKcjR5m2cUCwgxeuHf/vY/uhH3tWBvugAPE=
Received: from AM0PR08MB2961.eurprd08.prod.outlook.com (52.134.126.11) by
	AM0PR08MB3892.eurprd08.prod.outlook.com (20.178.23.214) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1965.12; Wed, 5 Jun 2019 15:47:25 +0000
Received: from AM0PR08MB2961.eurprd08.prod.outlook.com
	([fe80::8d90:32ae:bdd6:48e8]) by
	AM0PR08MB2961.eurprd08.prod.outlook.com
	([fe80::8d90:32ae:bdd6:48e8%7]) with mapi id 15.20.1965.011;
	Wed, 5 Jun 2019 15:47:25 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH] iotests: fix 254 for qcow (1)
Thread-Index: AQHVG7QAPRWkRe4B1kCNKL8XX2zIDqaNNIUA
Date: Wed, 5 Jun 2019 15:47:24 +0000
Message-ID: <fa2f8510-70b0-2427-992d-de5ed70abaa2@virtuozzo.com>
References: <20190605152650.103483-1-vsementsov@virtuozzo.com>
	<2b93344d-d0c2-5c36-0693-6fc1e3cef607@redhat.com>
In-Reply-To: <2b93344d-d0c2-5c36-0693-6fc1e3cef607@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR02CA0093.eurprd02.prod.outlook.com
	(2603:10a6:7:29::22) To AM0PR08MB2961.eurprd08.prod.outlook.com
	(2603:10a6:208:66::11)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190605184722694
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4cc92b5e-bd69-4de6-a5be-08d6e9cd1abc
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
	SRVR:AM0PR08MB3892; 
x-ms-traffictypediagnostic: AM0PR08MB3892:
x-microsoft-antispam-prvs: <AM0PR08MB389257D28B097B25C8381C75C1160@AM0PR08MB3892.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 00594E8DBA
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(396003)(366004)(376002)(136003)(346002)(39850400004)(189003)(199004)(229853002)(99286004)(52116002)(3846002)(6116002)(31686004)(68736007)(186003)(53936002)(6486002)(8676002)(316002)(6512007)(6246003)(11346002)(446003)(486006)(476003)(81166006)(81156014)(36756003)(110136005)(14444005)(4326008)(64756008)(256004)(66556008)(8936002)(6506007)(305945005)(2616005)(102836004)(386003)(73956011)(76176011)(6436002)(66446008)(53546011)(66066001)(7736002)(26005)(2501003)(66946007)(31696002)(5660300002)(86362001)(14454004)(25786009)(66476007)(71190400001)(478600001)(71200400001)(2201001)(2906002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3892;
	H:AM0PR08MB2961.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pu/Z3NYLox2iAFe+CxiwsLMfY96VuGJTkCQMIkvYSK6P0pMvR3V9WgULu3rVflZssdoRwUY3EbzpEBasl69IvEyFOCcz9IIg4t04DS1xZe+3QW464T0ptnqtdSMfZK+VhpKhcm+zzG8E+irW2zlJNZimT+KvkmWPuvNE7O2caPFCrVBKIdOsMeUv7apYP54pcUaEW/9qF+nb4P3xXf8VoIBjjz1HM3PBqTTzmuV5BojbhxETqxAk95GwYtDjUoONmROx3Qt0FmfD+ATE6xZuxq98Z7aDQ5Nhtz/u/TQGjTmq+CXPejcVZRTxXGOu/furt205/J/5t4uo/3LRmMXmjzovkY4Sr4eLs+krjJQjws+rk6V7pxzp1LcXlfsFAFaZCVMD9OQ8jiqYYoi6Eydzip7UMe9/RIOn64NEVTOoBFM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AB710645E4D4E24886E5B9AF49B49B57@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cc92b5e-bd69-4de6-a5be-08d6e9cd1abc
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2019 15:47:24.8180 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3892
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.135
Subject: Re: [Qemu-devel] [PATCH] iotests: fix 254 for qcow (1)
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDUuMDYuMjAxOSAxODozMywgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAwNS4wNi4xOSAxNzoyNiwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IFFjb3cgZGVmYXVsdCBjbHVz
dGVyIHNpemUgaXMgNGssIGJ1dCBkZWZhdWx0IGZvcm1hdCBvZiBjcmVhdGVkIG92ZXJsYXkNCj4+
IGltYWdlIG9uIHNuYXBzaG90IG9wZXJhdGlvbiBpcyBxY293MiB3aXRoIGl0J3MgZGVmYXVsdCBj
bHVzdGVyIG9mIDY0ay4NCj4gDQo+IFRoZW4gSSB3b25kZXIgd2h5IHdlIHJ1biB0aGlzIHRlc3Qg
ZXZlbiBmb3IgYW55dGhpbmcgYnV0IHFjb3cyLg0KPiANCj4gSSBmb3Jnb3QgdG8gbWVudGlvbiB0
aGF0IHRoaXMgdGVzdCBhbHNvIGZhaWxzIGZvciBhbGwgaW1hZ2UgZm9ybWF0cyB0aGF0DQo+IGRv
IG5vdCBzdXBwb3J0IGltYWdlIGNyZWF0aW9uLiAgU28gd2UgbmVlZCBzb21lIGZvcm0gb2YNCj4g
aW90ZXN0cy52ZXJpZnlfaW1hZ2VfZm9ybWF0KCkgYW55d2F5LiAgSWYgaGFsZiBvZiB0aGlzIHRl
c3QgcmVxdWlyZXMNCj4gcWNvdzIsIGFuZCB0aGUgb3RoZXIgaGFsZiBkb2VzIG5vdCByZWFsbHkg
Y2FyZSBhYm91dCB0aGUgaW1hZ2UgZm9ybWF0LA0KPiB0aGVuIHdoeSBub3QganVzdCByZXN0cmlj
dCBpdCB0byBxY293MiBhbHRvZ2V0aGVyLg0KDQpIbW0sIHRoZW4gYmV0dGVyIHJlc3RyaWN0IHRv
IHFjb3cyIG9mY291cnNlLg0KDQo+IA0KPiAoT3IgcmVzdHJpY3QgaXQgdG8gYWxsIGZvcm1hdHMg
dGhhdCBzdXBwb3J0IGJhY2tpbmcgZmlsZXMsIGFuZCB0aGVuDQo+IGV4cGxpY2l0bHkgc3BlY2lm
eSB0aGUgZm9ybWF0IHdoZW4gY3JlYXRpbmcgdGhlIHNuYXBzaG90PykNCj4gDQo+IE1heA0KPiAN
Cj4+IFRoaXMgbGVhZHMgdG8gYmxvY2stZGlydHktYml0bWFwLW1lcmdlIGZhaWwgd2hlbiB0ZXN0
IHJ1biBmb3IgcWNvdw0KPj4gZm9ybWF0LCBhcyBpdCBjYW4ndCBtZXJnZSBiaXRtYXBzIHdpdGgg
ZGlmZmVyZW50IGdyYW51bGFyaXRpZXMuDQo+PiBMZXQncyBmaXggaXQgYnkgc3BlY2lmeWluZyBz
dHJpY3QgZ3JhbnVsYXJpdHkuDQo+Pg0KPj4gUmVwb3J0ZWQtYnk6IE1heCBSZWl0eiA8bXJlaXR6
QHJlZGhhdC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZz
a2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQo+PiAtLS0NCj4+ICAgdGVzdHMvcWVtdS1p
b3Rlc3RzLzI1NCAgICAgfCA1ICsrKy0tDQo+PiAgIHRlc3RzL3FlbXUtaW90ZXN0cy8yNTQub3V0
IHwgMyArKy0NCj4+ICAgMiBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDMgZGVsZXRp
b25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL3Rlc3RzL3FlbXUtaW90ZXN0cy8yNTQgYi90ZXN0
cy9xZW11LWlvdGVzdHMvMjU0DQo+PiBpbmRleCAzM2NiODBhNTEyLi5hOGVhNTgxOGZmIDEwMDc1
NQ0KPj4gLS0tIGEvdGVzdHMvcWVtdS1pb3Rlc3RzLzI1NA0KPj4gKysrIGIvdGVzdHMvcWVtdS1p
b3Rlc3RzLzI1NA0KPj4gQEAgLTI5LDcgKzI5LDggQEAgcWVtdV9pbWdfY3JlYXRlKCctZicsIGlv
dGVzdHMuaW1nZm10LCBkaXNrLCBzdHIoc2l6ZSkpDQo+PiAgIHZtID0gaW90ZXN0cy5WTSgpLmFk
ZF9kcml2ZShkaXNrLCBvcHRzPSdub2RlLW5hbWU9YmFzZScpDQo+PiAgIHZtLmxhdW5jaCgpDQo+
PiAgIA0KPj4gLXZtLnFtcF9sb2coJ2Jsb2NrLWRpcnR5LWJpdG1hcC1hZGQnLCBub2RlPSdkcml2
ZTAnLCBuYW1lPSdiaXRtYXAwJykNCj4+ICt2bS5xbXBfbG9nKCdibG9jay1kaXJ0eS1iaXRtYXAt
YWRkJywgbm9kZT0nZHJpdmUwJywgbmFtZT0nYml0bWFwMCcsDQo+PiArICAgICAgICAgICBncmFu
dWxhcml0eT02NTUzNikNCj4+ICAgDQo+PiAgIHZtLmhtcF9xZW11X2lvKCdkcml2ZTAnLCAnd3Jp
dGUgMCA1MTJLJykNCj4+ICAgDQo+PiBAQCAtMzgsNyArMzksNyBAQCB2bS5xbXBfbG9nKCd0cmFu
c2FjdGlvbicsIGluZGVudD0yLCBhY3Rpb25zPVsNCj4+ICAgICAgICAnZGF0YSc6IHsnZGV2aWNl
JzogJ2RyaXZlMCcsICdzbmFwc2hvdC1maWxlJzogdG9wLA0KPj4gICAgICAgICAgICAgICAgICdz
bmFwc2hvdC1ub2RlLW5hbWUnOiAnc25hcCd9fSwNCj4+ICAgICAgIHsndHlwZSc6ICdibG9jay1k
aXJ0eS1iaXRtYXAtYWRkJywNCj4+IC0gICAgICdkYXRhJzogeydub2RlJzogJ3NuYXAnLCAnbmFt
ZSc6ICdiaXRtYXAwJ319LA0KPj4gKyAgICAgJ2RhdGEnOiB7J25vZGUnOiAnc25hcCcsICduYW1l
JzogJ2JpdG1hcDAnLCAnZ3JhbnVsYXJpdHknOiA2NTUzNn19LA0KPj4gICAgICAgeyd0eXBlJzog
J2Jsb2NrLWRpcnR5LWJpdG1hcC1tZXJnZScsDQo+PiAgICAgICAgJ2RhdGEnOiB7J25vZGUnOiAn
c25hcCcsICd0YXJnZXQnOiAnYml0bWFwMCcsDQo+PiAgICAgICAgICAgICAgICAgJ2JpdG1hcHMn
OiBbeydub2RlJzogJ2Jhc2UnLCAnbmFtZSc6ICdiaXRtYXAwJ31dfX0NCj4+IGRpZmYgLS1naXQg
YS90ZXN0cy9xZW11LWlvdGVzdHMvMjU0Lm91dCBiL3Rlc3RzL3FlbXUtaW90ZXN0cy8yNTQub3V0
DQo+PiBpbmRleCBkNzM5NGNmMDAyLi5kYzg5OTAxNmRhIDEwMDY0NA0KPj4gLS0tIGEvdGVzdHMv
cWVtdS1pb3Rlc3RzLzI1NC5vdXQNCj4+ICsrKyBiL3Rlc3RzL3FlbXUtaW90ZXN0cy8yNTQub3V0
DQo+PiBAQCAtMSw0ICsxLDQgQEANCj4+IC17ImV4ZWN1dGUiOiAiYmxvY2stZGlydHktYml0bWFw
LWFkZCIsICJhcmd1bWVudHMiOiB7Im5hbWUiOiAiYml0bWFwMCIsICJub2RlIjogImRyaXZlMCJ9
fQ0KPj4gK3siZXhlY3V0ZSI6ICJibG9jay1kaXJ0eS1iaXRtYXAtYWRkIiwgImFyZ3VtZW50cyI6
IHsiZ3JhbnVsYXJpdHkiOiA2NTUzNiwgIm5hbWUiOiAiYml0bWFwMCIsICJub2RlIjogImRyaXZl
MCJ9fQ0KPj4gICB7InJldHVybiI6IHt9fQ0KPj4gICB7DQo+PiAgICAgImV4ZWN1dGUiOiAidHJh
bnNhY3Rpb24iLA0KPj4gQEAgLTE0LDYgKzE0LDcgQEANCj4+ICAgICAgICAgfSwNCj4+ICAgICAg
ICAgew0KPj4gICAgICAgICAgICJkYXRhIjogew0KPj4gKyAgICAgICAgICAiZ3JhbnVsYXJpdHki
OiA2NTUzNiwNCj4+ICAgICAgICAgICAgICJuYW1lIjogImJpdG1hcDAiLA0KPj4gICAgICAgICAg
ICAgIm5vZGUiOiAic25hcCINCj4+ICAgICAgICAgICB9LA0KPj4NCj4gDQo+IA0KDQoNCi0tIA0K
QmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

