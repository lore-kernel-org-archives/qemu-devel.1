Return-Path: <SRS0=aRDT=W3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7563C3A59F
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Aug 2019 08:20:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E4F423697
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Aug 2019 08:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="pb8VmFZB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E4F423697
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3ycy-0006dH-I2
	for qemu-devel@archiver.kernel.org; Sat, 31 Aug 2019 04:20:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42705)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i3ycC-00062t-3V
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 04:20:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i3ycA-0002XF-5a
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 04:20:08 -0400
Received: from mail-eopbgr70131.outbound.protection.outlook.com
 ([40.107.7.131]:36592 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i3yc7-0002UB-7v; Sat, 31 Aug 2019 04:20:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZa1tneLv3Rls4JlGdbubglBjbFV8Bob7PiJluQIEye/Iuo2Aolv9Ck2EzdSsMbiI7Pu1rGZ8pqc23Ml9dmr4lVV5NSE3dJMJm8+RUV36jHApUDUR43TLauCY7DvnXsjkkPuPBbOLS2U75n2p58GHth2vxvjj3CQp/ls6qs5Qy2vWdOpXzI8UA125daBPwTrnouVqf1+CXViAXn4pR6Cm1rAcgyQpbwAgfCFW0JI1+zy3H3oOvbAeT0YEzG7a4IjpBStLedOQleKkUeumLKJe3OurGmt5Sbaon15hsh3Wi/4z25jkitc8Fqq+8MgxaMn19GHehn/5ozvou2yzbm5jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37qFa2AQZEIJAYcZ3/Ij95UKA+3mYQG8mciAKTIikLU=;
 b=lg/EON60d/eBeykU6Tj2ZSN7g1oWhxo6z6/sMeVHaDGwAaPAPWAgt8r/dPYxQmHyxyFN6rQS3JyxMHRwdIrM+tg8p36yR2qWx4FOC2ZtjXqCA+FOhckbHGf3zzrd18dX5N4ruFgQRRABTbB3je/aTydl9ZtHSGHxaMfKFqfGD2QT0AbsbbS5JcvL+7ITuE7L57t5ULA0pVybjIerX7Lhjczj5vUa0V5lumH+DPk94e/SY4VEh22HOuZw0xMv1HF5X3UysG25ZJTf7SWIvihY23LynP0AOzqQHCHgKEUGnmFdHIOuVj6yVOw4ari6mytfT9IjgKS4aDEj7u6SYjDIRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37qFa2AQZEIJAYcZ3/Ij95UKA+3mYQG8mciAKTIikLU=;
 b=pb8VmFZB3jfXBXEHyheN4QGXdPdj5AtGn5lBEmL2IiPCCAvxPWG01MTj+zzFPbbDWjFqTYp2ulZl6M+0HjGv4IQ19+kE9vl3U5N19+HyQGBUq26+8FNjk1R1SCq7UXAqYWRotwZSx36NjyYJGmbMTGmvVm3K35a4nEc0kJQx4jA=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4092.eurprd08.prod.outlook.com (20.179.9.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.20; Sat, 31 Aug 2019 08:20:00 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2220.020; Sat, 31 Aug 2019
 08:20:00 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH 2/5] nbd: Prepare for NBD_CMD_FLAG_FAST_ZERO
Thread-Index: AQHVWcJnZgUz/ZiSEEiPmfDFNqlCh6cU9jqA
Date: Sat, 31 Aug 2019 08:20:00 +0000
Message-ID: <ca606ce7-90ec-591c-ffb4-6b4f5618bcd8@virtuozzo.com>
References: <25ead363-4f37-5450-b985-1876374e314d@redhat.com>
 <20190823143726.27062-1-eblake@redhat.com>
 <20190823143726.27062-3-eblake@redhat.com>
In-Reply-To: <20190823143726.27062-3-eblake@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0274.eurprd05.prod.outlook.com
 (2603:10a6:3:fc::26) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190831111957744
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5110bee5-4ea9-4edb-3689-08d72dec0409
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB4092; 
x-ms-traffictypediagnostic: DB8PR08MB4092:
x-microsoft-antispam-prvs: <DB8PR08MB4092C1C1668D58072C2E416EC1BC0@DB8PR08MB4092.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 014617085B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(39840400004)(366004)(396003)(136003)(376002)(189003)(199004)(31696002)(71190400001)(71200400001)(14454004)(66066001)(2501003)(316002)(54906003)(7736002)(110136005)(305945005)(99286004)(6436002)(256004)(53936002)(52116002)(14444005)(6512007)(31686004)(8936002)(81156014)(81166006)(8676002)(478600001)(476003)(76176011)(66476007)(386003)(6506007)(4744005)(6116002)(36756003)(5660300002)(66946007)(2616005)(486006)(6486002)(229853002)(4326008)(186003)(3846002)(86362001)(2906002)(6246003)(25786009)(102836004)(64756008)(11346002)(66446008)(66556008)(446003)(26005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4092;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: j3U1Ktz44dM45Onqd65wEinxWuF2jTy156C9T9+J0kcjsPQZ4Ggpq4aKUqtBlabCWHiJLlWxUeAUIzjXB4Je6K8bsiiG+B6oIOEcBL2ndAGwqw6b0u4SaCdj/Jo//My7oDQ5M84dyh9ykSW2UsnUEAg2woq4UMkI5RfrbINr+2mxcoeXOMy9k+UT4UwmZtrugp2gyRePGyLURa3nGTZt03CII9JD3Wr+1nykemhujxaz+byvof6ICYdQRcJZEwh5zHaQKjm31xx0wMf9WUz7zC+wysVZbY9ybOlyjBpprGlh9d0PsXWVFAPb6m61R9bcnLw6dYqK1O4W8d/KL18GBasKbJ/8KaiqF/yXk/BTPzLLNQJvrhnFxt59qLd9Mn0hKNnrv0cKcbSEhl9UALjfzIN6cAkL0HAUWLtgwKpS8Jk=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <BFADED8F31E99140A8E5D4879E64FD5A@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5110bee5-4ea9-4edb-3689-08d72dec0409
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2019 08:20:00.1160 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zb2uxGw4OmZQ1ANOGbX7XsLzOHCXRedY8vfwSdnvmtDkcIISSwq4XkjchjJ4AMpGJTJwuwKtx/rSPME6unQ/GJo5JwlOrZxLr1hdnEr0YII=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4092
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.131
Subject: Re: [Qemu-devel] [PATCH 2/5] nbd: Prepare for NBD_CMD_FLAG_FAST_ZERO
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "nbd@other.debian.org" <nbd@other.debian.org>,
 "libguestfs@redhat.com" <libguestfs@redhat.com>, "open
 list:Network Block Dev..." <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjMuMDguMjAxOSAxNzozNywgRXJpYyBCbGFrZSB3cm90ZToNCj4gQ29tbWl0IGZlMDQ4MGQ2IGFu
ZCBmcmllbmRzIGFkZGVkIEJEUlZfUkVRX05PX0ZBTExCQUNLIGFzIGEgd2F5IHRvDQo+IGF2b2lk
IHdhc3RpbmcgdGltZSBvbiBhIHByZWxpbWluYXJ5IHdyaXRlLXplcm8gcmVxdWVzdCB0aGF0IHdp
bGwgbGF0ZXINCj4gYmUgcmV3cml0dGVuIGJ5IGFjdHVhbCBkYXRhLCBpZiBpdCBpcyBrbm93biB0
aGF0IHRoZSB3cml0ZS16ZXJvDQo+IHJlcXVlc3Qgd2lsbCB1c2UgYSBzbG93IGZhbGxiYWNrOyBi
dXQgaW4gZG9pbmcgc28sIGNvdWxkIG5vdCBvcHRpbWl6ZQ0KPiBmb3IgTkJELiAgVGhlIE5CRCBz
cGVjaWZpY2F0aW9uIGlzIG5vdyBjb25zaWRlcmluZyBhbiBleHRlbnNpb24gdGhhdA0KPiB3aWxs
IGFsbG93IHBhc3Npbmcgb24gdGhvc2Ugc2VtYW50aWNzOyB0aGlzIHBhdGNoIHVwZGF0ZXMgdGhl
IG5ldw0KPiBwcm90b2NvbCBiaXRzIGFuZCAncWVtdS1uYmQgLS1saXN0JyBvdXRwdXQgdG8gcmVj
b2duaXplIHRoZSBiaXQsIGFzDQo+IHdlbGwgYXMgdGhlIG5ldyBlcnJubyB2YWx1ZSBwb3NzaWJs
ZSB3aGVuIHVzaW5nIHRoZSBuZXcgZmxhZzsgd2hpbGUNCj4gdXBjb21pbmcgcGF0Y2hlcyB3aWxs
IGltcHJvdmUgdGhlIGNsaWVudCB0byB1c2UgdGhlIGZlYXR1cmUgd2hlbg0KPiBwcmVzZW50LCBh
bmQgdGhlIHNlcnZlciB0byBhZHZlcnRpc2Ugc3VwcG9ydCBmb3IgaXQuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBFcmljIEJsYWtlPGVibGFrZUByZWRoYXQuY29tPg0KDQpSZXZpZXdlZC1ieTogVmxh
ZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KDQot
LSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

