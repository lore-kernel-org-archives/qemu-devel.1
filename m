Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4132DCA9EBE
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 08:28:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D6BC214AF
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 08:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="uQclx8N0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D6BC214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP0OW-0004px-KH
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 04:28:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52980)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iP0Nd-0003vE-V3
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 04:28:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iP0Nc-00039F-VE
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 04:28:01 -0400
Received: from mail-eopbgr30090.outbound.protection.outlook.com
 ([40.107.3.90]:49984 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iP0NZ-00031J-5G; Mon, 28 Oct 2019 04:27:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lG1mW74YoV2XbUO932FA0gzMPak9C2BTE+1LsRp4mJt+DUg6PM5HkQv0x2ie7daQVRmMIShfSx/qiJVQNZVoCzck4nb3yhEBLdEFYqmZKi2g+aEF/UKbovM7q050y98M02agQuUmcHDABA25V+5tjqiSrSnFGHPIP42YIfnnvPOyQwiOoM7nuMZTY/hVrBD4DVSwYbz0a3/0Qn72RwZW9Q6vNWvBgV4wq0YORTeG93kjAQvHXMJ6/wxNzYvCTB7EWTa+IngbQVNUenex/g/t31vLIjkh1u9ifazhIQ5uIK45YmFKAmLEaPVDZCv2IsvyFSuLmQ6STMaJqIWWpI6Syw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=51vxmQYEp2TNlFLZs+nMWFNhZ+l5HwzPVH4Pg+qSJtg=;
 b=MR9zIKKvysPue8l7eTSe5UzfoGlk/VPHyKoX2lwNhR9Ku/+VswGWtwHIj5rF3ZyZiWqSRfMEDPFJTPn3gqOwHfavSXUI0hY4cxqro1HlPZa8jqxjcqBszFG6tsywttffeSGE/PHs5zMJ+KwhATB0FVCdNFM/eX1mHwRLGPFa22C9QE/wknZclzLlvn9XXOSmcQqXI6TT7LMESmM5+nIDh5U/UKbm2Vpi8CCArTFeYrV6XYnEyd/i9n9KroD8Wi3pWL0N3PzCzit1KgaScgvquc5cPWTXrLABWiV26CK6dBWp6rDPv9mYgYR+wT74PKgRNm0iXvesvj1fhtiw9D1aQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=51vxmQYEp2TNlFLZs+nMWFNhZ+l5HwzPVH4Pg+qSJtg=;
 b=uQclx8N0LdQJE4ClHY+IpCTVoWPxMtaEi6Htn55gJa9F2AMvQu8egN6W5gEr9Ql7/ostFLxYC6qSR61nh5TOXVIjmlNZ13douAwiTpVe8EDS5adDz/OdDlAEE3O1SAIswRtK7VZ28cCw8Ggi84FrTp/nlol/gU50LGtjkIk8Tx4=
Received: from AM0PR08MB4097.eurprd08.prod.outlook.com (20.178.202.217) by
 AM0PR08MB3108.eurprd08.prod.outlook.com (52.134.93.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Mon, 28 Oct 2019 08:27:54 +0000
Received: from AM0PR08MB4097.eurprd08.prod.outlook.com
 ([fe80::6844:bb8c:7d2c:b119]) by AM0PR08MB4097.eurprd08.prod.outlook.com
 ([fe80::6844:bb8c:7d2c:b119%6]) with mapi id 15.20.2387.025; Mon, 28 Oct 2019
 08:27:54 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Tuguoyi <tu.guoyi@h3c.com>, "kwolf@redhat.com" <kwolf@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH v2] qcow2-bitmap: Fix uint64_t left-shift overflow
Thread-Topic: [PATCH v2] qcow2-bitmap: Fix uint64_t left-shift overflow
Thread-Index: AdWNWOAJ7czUdZfnT3+PEnECPxQetwAELWoA
Date: Mon, 28 Oct 2019 08:27:53 +0000
Message-ID: <cb5c503b-c844-892f-9663-149db205619c@virtuozzo.com>
References: <494aedb644bf434f8eee0263aa17aa23@h3c.com>
In-Reply-To: <494aedb644bf434f8eee0263aa17aa23@h3c.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0701CA0072.eurprd07.prod.outlook.com
 (2603:10a6:3:64::16) To AM0PR08MB4097.eurprd08.prod.outlook.com
 (2603:10a6:208:132::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191028112750855
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ba0aebcf-77a9-42ee-181a-08d75b80ba52
x-ms-traffictypediagnostic: AM0PR08MB3108:
x-microsoft-antispam-prvs: <AM0PR08MB310867E728B1EB11EF17BA10C1660@AM0PR08MB3108.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1468;
x-forefront-prvs: 0204F0BDE2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(136003)(366004)(376002)(396003)(39840400004)(189003)(199004)(36756003)(25786009)(6246003)(7416002)(6436002)(31686004)(6116002)(6486002)(2906002)(5660300002)(229853002)(6512007)(54906003)(305945005)(7736002)(4326008)(3846002)(66556008)(64756008)(66446008)(66476007)(110136005)(71190400001)(66946007)(316002)(71200400001)(2201001)(81166006)(476003)(26005)(8676002)(81156014)(2501003)(8936002)(31696002)(99286004)(86362001)(52116002)(478600001)(256004)(11346002)(446003)(66066001)(6506007)(386003)(76176011)(14454004)(486006)(2616005)(186003)(102836004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3108;
 H:AM0PR08MB4097.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: amBKks0cIj2i7mdJKb9Hvz8kqbsAFzR9uBfMDobP+2fuS3RYln0RVFDDYETVREK3i94/NKBujaayXATKUZj6VPu2JNZaWyso44RZgh9vdhNkW33fzLGf2u1aUm1vZCKYzmifXZ2i4pcinnRp1KAZnE+AYBjX7PdaQryqGD4wLF6ycz4iWxdSDoKFBHPWlDTI9vg573n9nXOQjdLK6bd9XHuHZtU6JSRfpF0CVEjGrv+Sk1my6/KbtjQsAKRppvZNbn1iXwVnDExst4K1aaVzKrDNKP6jlhyDbHfP3s0QBn7yMi2rORdquYfQAZu9dSrEt8JoMhxjQecF6uNZ9OikyQP+Y+sET1zl15alsPhfpkCHTiC8Byx5Z8I5gPr6lgM8K5h4otfqvSvO1q5BY/fQ6RjDrMug8PokmA5BjdJ16ISatutNDoNwXscMXe2d06Z6
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <13451DA500187D4B8425BC380A7D4A37@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba0aebcf-77a9-42ee-181a-08d75b80ba52
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2019 08:27:53.9206 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NzQdeasMI7GUE5AQmqgCeg0FdqTXwJua8tFsuRLTaGUGJ4ccGvGltmRbgW75OI7MD/i4cqBuXYlBLQvWMgwyaFbke+f/K5+fXT9cML/nGAs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3108
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.90
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
Cc: Chengchiwen <chengchiwen@h3c.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 qemu-stable <qemu-stable@nongnu.org>, Wangyongqing <w_yongqing@h3c.com>,
 Changlimin <changlimin@h3c.com>, Gaoliang <liang_gao@h3c.com>,
 Wangyong <wang.yongD@h3c.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjguMTAuMjAxOSA5OjMzLCBUdWd1b3lpIHdyb3RlOg0KPiBJbiBjaGVja19jb25zdHJhaW50c19v
bl9iaXRtYXAoKSwgdGhlIHNhbml0eSBjaGVjayBvbiB0aGUNCj4gZ3JhbnVsYXJpdHkgd2lsbCBj
YXVzZSB1aW50NjRfdCBpbnRlZ2VyIGxlZnQtc2hpZnQgb3ZlcmZsb3cNCj4gd2hlbiBjbHVzdGVy
X3NpemUgaXMgMk0gYW5kIHRoZSBncmFudWxhcml0eSBpcyBCSUdHRVIgdGhhbg0KPiAzMksuIEFz
IGEgcmVzdWx0LCBmb3IgYSBxY293MiBkaXNrIHdpdGggY2x1c3Rlcl9zaXplIHNldCB0bw0KPiAy
TSwgd2UgY291bGQgbm90IGV2ZW4gY3JlYXRlIGEgZGlydHkgYml0bWFwIHdpdGggZGVmYXVsdA0K
PiBncmFudWxhcml0eS4gVGhpcyBwYXRjaCBmaXggdGhlIGlzc3VlIGJ5IGRpdmlkaW5nIEBsZW4g
YnkNCj4gZ3JhbnVsYXJpdHkgaW5zdGVhZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEd1b3lpIFR1
IDx0dS5ndW95aUBoM2MuY29tPg0KDQpUaGUgYnVnZ3kgY29kZSB3YXMgaW50cm9kdWNlZCBpbiA1
ZjcyODI2ZTdmYzYyMTYgKGJ5IG1lLCBzb3JyeSA6KCwNCnNvIGl0J3MgYW4gb2xkIGJ1ZywgYXBw
ZWFyZWQgaW4gMi4xMC4gU3RpbGwsIEkgYWRkIHN0YWJsZSB0byBDQywNCmFzIGZpeCBpcyB2ZXJ5
IHNpbXBsZS4NCg0KRml4ZXM6IDVmNzI4MjZlN2ZjNjIxNjdjZjNhDQpSZXZpZXdlZC1ieTogVmxh
ZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KDQo+
IC0tLQ0KPiAgIGJsb2NrL3Fjb3cyLWJpdG1hcC5jIHwgNCArKy0tDQo+ICAgMSBmaWxlIGNoYW5n
ZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9i
bG9jay9xY293Mi1iaXRtYXAuYyBiL2Jsb2NrL3Fjb3cyLWJpdG1hcC5jDQo+IGluZGV4IDk4Mjk0
YTcuLjcxYWM4MjIgMTAwNjQ0DQo+IC0tLSBhL2Jsb2NrL3Fjb3cyLWJpdG1hcC5jDQo+ICsrKyBi
L2Jsb2NrL3Fjb3cyLWJpdG1hcC5jDQo+IEBAIC0xNzIsOCArMTcyLDggQEAgc3RhdGljIGludCBj
aGVja19jb25zdHJhaW50c19vbl9iaXRtYXAoQmxvY2tEcml2ZXJTdGF0ZSAqYnMsDQo+ICAgICAg
IH0NCj4gICANCj4gICAgICAgaWYgKChsZW4gPiAodWludDY0X3QpQk1FX01BWF9QSFlTX1NJWkUg
PDwgZ3JhbnVsYXJpdHlfYml0cykgfHwNCj4gLSAgICAgICAgKGxlbiA+ICh1aW50NjRfdClCTUVf
TUFYX1RBQkxFX1NJWkUgKiBzLT5jbHVzdGVyX3NpemUgPDwNCj4gLSAgICAgICAgICAgICAgIGdy
YW51bGFyaXR5X2JpdHMpKQ0KPiArICAgICAgICAoRElWX1JPVU5EX1VQKGxlbiwgZ3JhbnVsYXJp
dHkpID4gKHVpbnQ2NF90KUJNRV9NQVhfVEFCTEVfU0laRSAqDQo+ICsgICAgICAgICAgICAgICAg
cy0+Y2x1c3Rlcl9zaXplKSkNCj4gICAgICAgew0KPiAgICAgICAgICAgZXJyb3Jfc2V0ZyhlcnJw
LCAiVG9vIG11Y2ggc3BhY2Ugd2lsbCBiZSBvY2N1cGllZCBieSB0aGUgYml0bWFwLiAiDQo+ICAg
ICAgICAgICAgICAgICAgICAgICJVc2UgbGFyZ2VyIGdyYW51bGFyaXR5Iik7DQo+IA0KDQoNCi0t
IA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

