Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C60FC5B578
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 07:19:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF8632187F
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 07:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ZnOQBja4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF8632187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiZYO-0004WL-8T
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 03:19:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59330)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <den@virtuozzo.com>) id 1hiZXS-0003au-Qf
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 03:18:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <den@virtuozzo.com>) id 1hiZXQ-0008IU-PR
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 03:18:46 -0400
Received: from mail-ve1eur03on0713.outbound.protection.outlook.com
 ([2a01:111:f400:fe09::713]:23262
 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <den@virtuozzo.com>) id 1hiZXQ-0008HO-5f
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 03:18:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lz87AbNKYpWJSwDkKEL1+jTbNTBv4JghPNjzmt/AX/M=;
 b=ZnOQBja4d6pYD3xFK4zZOre17yxTmU+9FrLKlsTgMqBv3ezQlDxqn7ajHhwtXSLsIFT8s1kqALUn3253mdzMpiuvHQy3hqKE0WfWcQgEcsqE3HGzYH2iMF7j3JfdmjR5J/Q1H3c+j7l4kZuwEEs5+KvPu0U67VqRWXJKFsBbQgI=
Received: from DBBPR08MB4250.eurprd08.prod.outlook.com (20.179.40.149) by
 DBBPR08MB4726.eurprd08.prod.outlook.com (10.255.79.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.16; Wed, 3 Jul 2019 07:18:39 +0000
Received: from DBBPR08MB4250.eurprd08.prod.outlook.com
 ([fe80::1d8b:7420:f966:e881]) by DBBPR08MB4250.eurprd08.prod.outlook.com
 ([fe80::1d8b:7420:f966:e881%3]) with mapi id 15.20.2032.019; Wed, 3 Jul 2019
 07:18:39 +0000
From: Denis Lunev <den@virtuozzo.com>
To: Markus Armbruster <armbru@redhat.com>, Denis Plotnikov
 <dplotnikov@virtuozzo.com>
Thread-Topic: [Qemu-devel] [PATCH] monitor: increase amount of data for
 monitor to read
Thread-Index: AQHVH3uTjLyZHmMxuEusn1LAsIaP+6a4lHlPgAALn4A=
Date: Wed, 3 Jul 2019 07:18:39 +0000
Message-ID: <e2e644d0-0cb3-3c11-2e43-9e9b1c3a17ef@virtuozzo.com>
References: <20190610105906.28524-1-dplotnikov@virtuozzo.com>
 <87lfxfy67u.fsf@dusky.pond.sub.org>
In-Reply-To: <87lfxfy67u.fsf@dusky.pond.sub.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0501CA0005.eurprd05.prod.outlook.com
 (2603:10a6:3:1a::15) To DBBPR08MB4250.eurprd08.prod.outlook.com
 (2603:10a6:10:c2::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=den@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1bbebff9-a22d-45f8-144a-08d6ff86ab93
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DBBPR08MB4726; 
x-ms-traffictypediagnostic: DBBPR08MB4726:
x-microsoft-antispam-prvs: <DBBPR08MB47260F05692384325E011A85B6FB0@DBBPR08MB4726.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 00872B689F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(396003)(136003)(39850400004)(346002)(366004)(199004)(189003)(3846002)(6116002)(6436002)(6246003)(99286004)(102836004)(26005)(6486002)(53546011)(6506007)(386003)(8676002)(305945005)(186003)(7736002)(229853002)(8936002)(54906003)(6512007)(52116002)(53936002)(81156014)(81166006)(316002)(76176011)(110136005)(36756003)(31686004)(14454004)(66066001)(6636002)(446003)(2906002)(256004)(478600001)(68736007)(476003)(4326008)(2616005)(4744005)(11346002)(86362001)(66946007)(486006)(25786009)(5660300002)(73956011)(31696002)(71190400001)(66446008)(71200400001)(66556008)(66476007)(64756008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DBBPR08MB4726;
 H:DBBPR08MB4250.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hlf609zgfZYBGUO4y4dlyBSpBMghqKykr87roT11nfgCJp/vPDUo9Fb4rDlUBH+nlfeRKGGEgAvAb5pnKfRo4LA9aema6AjhpSdKo5gNT1Ezeb9zCMbEOG9y936SxGsr6Ft/cjj3Of8hWM+sHAvFBirWkkiV36TWlqLpz6PW4bcdy1ZVA++OFOTSviQVKNo81yrKdbpbfYiH/b+aKxyF5/MMBtmHKNexTo6NfWARRp9d+255zByt57KExBGqt7hDUvx77ZwCDv7TruD4aS5lFH6QgEXtRxxIWLIW9HPhLSyTCxG9RxdrYW39Oyr6G9uhZ0wWqDV9USiznSD2WCwFg5wP9HrjdfSrYhFabpmLtHWre8jXL6t8bDwlHjUYI5WBaqm9+gaxFgAS9YB67kL1zwbGwqBoGI7WIqQzxeufq3s=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CAE471D38DC4854BB62048CBBE456C55@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bbebff9-a22d-45f8-144a-08d6ff86ab93
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2019 07:18:39.1535 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: den@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4726
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe09::713
Subject: Re: [Qemu-devel] [PATCH] monitor: increase amount of data for
 monitor to read
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
Cc: "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gNy8zLzE5IDk6MzYgQU0sIE1hcmt1cyBBcm1icnVzdGVyIHdyb3RlOg0KPiBEaWQgdGhpcyBm
YWxsIHRocm91Z2ggdGhlIGNyYWNrcz8NCj4NCj4gRGVuaXMgUGxvdG5pa292IDxkcGxvdG5pa292
QHZpcnR1b3p6by5jb20+IHdyaXRlczoNCj4NCj4+IFJpZ2h0IG5vdyBRTVAgYW5kIEhNUCBtb25p
dG9ycyByZWFkIDEgYnl0ZSBhdCBhIHRpbWUgZnJvbSB0aGUgc29ja2V0LCB3aGljaA0KPj4gaXMg
dmVyeSBpbmVmZmljaWVudC4gV2l0aCAxMDArIFZNcyBvbiB0aGUgaG9zdCB0aGlzIGVhc2lseSBy
ZWFzdWx0cyBpbg0KPj4gYSBsb3Qgb2YgdW5uZWNlc3Nhcnkgc3lzdGVtIGNhbGxzIGFuZCBDUFUg
dXNhZ2UgaW4gdGhlIHN5c3RlbS4NCj4gWWVzLCByZWFkaW5nIG9uZSBieXRlIGF0IGEgdGltZSBp
cyBhd2Z1bC4gIEJ1dCBRTVAgaXMgY29udHJvbCBwbGFuZTsgSQ0KPiBkaWRuJ3QgZXhwZWN0IGl0
IHRvIGltcGFjdCBzeXN0ZW0gcGVyZm9ybWFuY2UuICBIb3cgYXJlIHlvdSB1c2luZyBRTVA/DQo+
IEp1c3QgY3VyaW91cywgbm90IGFjdHVhbGx5IG9wcG9zZWQgdG8gaW1wcm92aW5nIFFNUCBlZmZp
Y2llbmN5Lg0KNTAwIFZNcyBvbiBhIGhvc3QsIGVhY2ggMzAgc2Vjb25kcyBsaWJ2aXJ0cyBleGVj
dXRlcyBBRkFJUiAzLTUgY29tbWFuZHMNCndpdGggZGVmYXVsdCBzZXR0aW5ncy4gVGhpcyByZXN1
bHRzIGluIGF0IGxlYXN0IHNvbWUgbG9hZC4gSXQgaXMgbm90IHZlcnkNCnNpZ25pZmljYW50LCBi
dXQgaXQgaXMgbm90aWNlYWJsZS4NCg0KVGhpcyByZWR1Y2VzIGlkbGUgQ1BVIGNvbnN1bXB0aW9u
IGFyb3VuZCAxLTIlIG9ic2VydmFibGUgdmlhIHRvcCwgd2hpY2ggaXMNCm5vdCB0aGF0IHNtYWxs
IGFtb3VudC4NCg0KRGVuDQo=

