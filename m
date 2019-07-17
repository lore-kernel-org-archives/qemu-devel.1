Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60312C76186
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 08:45:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 270CA2173E
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 08:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ZQWPwft/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 270CA2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnfYh-0004g9-Ve
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 04:45:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50511)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hnfYT-0004B7-VZ
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 04:44:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hnfYT-00076B-1i
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 04:44:53 -0400
Received: from mail-ve1eur01on0717.outbound.protection.outlook.com
 ([2a01:111:f400:fe1f::717]:27022
 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1hnfYS-00074C-AB
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 04:44:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cyycg++Y3R/46bPSPFZujRT+EgTlHBf9k0EntBemAE5EJzZ6b8dXmdDBONor4Ki87zeLUApoiQmFKdTw9gqqVtBlI5Fz1dxxKdyIoesePbxplpY8i5YjgxSw0q09J74rxKaDwyraStqV9rLAaOPXOpE+lhdUrVpgX39U4uAyZXPPDSCsdJRUMM7RCHs8Wjrv6GPFy+edfBM3Ua/K/QTOZXBMAE7r4Qar+CKJdEltug6itylcqLhRc/IiFe236YageKX78/81rvbi0Un2y98Ts6OGe2U7pQXF1ipJq4tNDaOP4FY0oEQSoMKiYXiYfy+y3ZhniPXrrlQmgg3kbq/jhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Bq0MGNTwPd1rP9VVhLzMty/A1jqdVgHTtjbC+WJS1U=;
 b=Txg4wohWWWeHkz5QBVbpvOIztgEH6kqTkoZIOtPKU5EbdjBje6Usbe26wOl1iabwaVXnBTvlgc7FbVNO1k8+VGs8k7FWKH3WxxaObfxZWv6jhI76mACd/9U/5ENQ//vLD06yRMhefqQsXRSngPpxBjS4DgH4TN6aGqwc3Kh/KBI6lMRhVUywql24A09MQN682rHpHPm+ztqlmsRzuA+VWJD9nwKKo+zWfdIUhQ6icN8k4rKcpWcPTYosUs10LD/m8PrEyTn3bHQKtNAyP+MWxTztUdSlFEhYzs0Q+D2sqPrA8XfDwm/PxM+0DYAbnxr5JsM7wd1YV3YJGaiXORAdaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=virtuozzo.com;dmarc=pass action=none
 header.from=virtuozzo.com;dkim=pass header.d=virtuozzo.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Bq0MGNTwPd1rP9VVhLzMty/A1jqdVgHTtjbC+WJS1U=;
 b=ZQWPwft/a7YUHLkbuBcMxzUIPAe6H/fZdbUUNRgUFcvBAo54ObYtqooe2DICrC/HwIXz3nGysw3qkiezowWBQVjZ4mSJ61/Bls6obd8mEnryWcGlD83QORafGQcMLSNBJhO0CxE8J+MEsnl0p+/26yyEYtmDdJjCIQTJKK8E+Lk=
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com (20.179.28.141) by
 VI1PR08MB5487.eurprd08.prod.outlook.com (52.133.246.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.11; Wed, 17 Jul 2019 08:44:49 +0000
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::4c3d:79b3:a884:18c4]) by VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::4c3d:79b3:a884:18c4%3]) with mapi id 15.20.2073.012; Wed, 17 Jul 2019
 08:44:49 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH] chardev: race condition with
 tcp_chr_disconnect
Thread-Index: AQHVOOZ1DwB6Iz4ObkKXlmNSu3G56abL8iuAgAAR7QCAAWuEgP//4wsAgAEzUQA=
Date: Wed, 17 Jul 2019 08:44:48 +0000
Message-ID: <d257b84a-69cb-0eea-6c06-16716e6bd3db@virtuozzo.com>
References: <1562959033-223586-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <b270d0cc-2a28-8a60-ccac-45ac4de89f02@redhat.com>
 <a55d4518-734e-9dd1-296f-473600eacbf7@redhat.com>
 <5832b3c6-c014-eef2-50bb-f25d70d65678@virtuozzo.com>
 <ac5aefc4-b1e4-9465-c3f0-88f180f6fa14@redhat.com>
In-Reply-To: <ac5aefc4-b1e4-9465-c3f0-88f180f6fa14@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0502CA0012.eurprd05.prod.outlook.com
 (2603:10a6:3:e3::22) To VI1PR08MB4399.eurprd08.prod.outlook.com
 (2603:10a6:803:102::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 624b8a5d-5ac8-40e0-40aa-08d70a9306dc
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:VI1PR08MB5487; 
x-ms-traffictypediagnostic: VI1PR08MB5487:
x-microsoft-antispam-prvs: <VI1PR08MB548784436581E87181A6C7BEF4C90@VI1PR08MB5487.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01018CB5B3
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(376002)(366004)(396003)(346002)(136003)(199004)(189003)(71190400001)(486006)(71200400001)(86362001)(26005)(6246003)(107886003)(53936002)(102836004)(4744005)(5660300002)(4326008)(6512007)(31696002)(478600001)(66066001)(68736007)(25786009)(2906002)(8676002)(81156014)(2616005)(7736002)(305945005)(36756003)(81166006)(99286004)(52116002)(53546011)(6506007)(31686004)(476003)(386003)(2501003)(229853002)(11346002)(446003)(76176011)(6486002)(6436002)(256004)(6116002)(186003)(64756008)(66556008)(3846002)(316002)(66476007)(66446008)(44832011)(14454004)(66946007)(54906003)(110136005)(8936002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB5487;
 H:VI1PR08MB4399.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KIbsC6CuzwiUC5L6CtBo42yYzos7uUdW6PKQN9r2qcwKanNyOl1bs9+tsp/mKgA8nThhOPpHYDKwmcifWeV230Br/BFERhMFMx7PwwOZtnnQr2G6i/nOSId/08tteJqgLaKfZ6nkRsfJk6XlGZv3bXXNyv7SIYUKcBz4Z5OuHmYe/iPet2MslW0e05B/Vx7NzyabhPilGw0tcuDf8/TkDpLAXXy979HAc+e2oNIX2uEKKdPMVVlyYwikXCpAagL4UsDhbrKKIJmxy7EbiwUKRr14ZiFC0NoTJIbzGKhhTVcsajQg7kenxz3I0luaZamJ5Q5Gf0+UwpFG8fBiq5iLYsKjyaYz8NP0hGHkTidlNWLvJiz+Ws5CJw2dvznRTHZ/MkILD6hhrsQPGzObNrFI7Vz/HJLflydDI+WFdm+jfao=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CE1CE824139E334E98042BA5CB16B950@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 624b8a5d-5ac8-40e0-40aa-08d70a9306dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2019 08:44:49.0141 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: andrey.shinkevich@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5487
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe1f::717
Subject: Re: [Qemu-devel] [PATCH] chardev: race condition with
 tcp_chr_disconnect
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
Cc: "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Roman Kagan <rkagan@virtuozzo.com>, Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDE2LzA3LzIwMTkgMTc6MjQsIFBhb2xvIEJvbnppbmkgd3JvdGU6DQo+IE9uIDE2LzA3
LzE5IDE1OjA4LCBBbmRyZXkgU2hpbmtldmljaCB3cm90ZToNCj4+IFRoZSB0ZXN0IGNoZWNrLXF0
ZXN0LXg4Nl82NDogdGVzdHMvcW9zLXRlc3QgaGFuZ3Mgd2l0aCB0aGUNCj4+IFFURVNUX1ZIT1NU
X1VTRVJfRklYTUUgc2V0IGV2ZW4gd2l0aG91dCBhcHBseWluZyB0aGUgc2VyaWVzOg0KPiANCj4g
SG1tIGl0IG11c3QgaGF2ZSBiaXRyb3QuIDooKCAgSSBob3BlIEkgY2FuIGxvb2sgYXQgaXQgb24g
VGh1cnNkYXkuDQo+IA0KPiBQYW9sbw0KPiANCg0KVGhhbmsgeW91IFBhb2xvLg0KSSdtIHNvcnJ5
IGFib3V0IHNlbmRpbmcgdGhlIHNhbWUgbWVzc2FnZSBhZ2Fpbi4gVGhlcmUgd2FzIGEgbWVzcyBp
biBteSANClRodW5kZXJiaXJkIHdpdGggZXh0cmFjdGluZyB0aGUgdGhyZWFkICJjaGFyLXNvY2tl
dDogRml4IHJhY2UgY29uZGl0aW9uIiANCmZyb20gdGhlIGFyY2hpdmUgeWVzdGVyZGF5LiBTb21l
IG1lc3NhZ2VzIHdlcmUgZmFpbGVkIHRvIGRvd25sb2FkIGFuZCB0byANCnNlbmQuDQoNCkFuZHJl
eQ0KLS0gDQpXaXRoIHRoZSBiZXN0IHJlZ2FyZHMsDQpBbmRyZXkgU2hpbmtldmljaA0K

