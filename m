Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F56EC49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 08:53:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD4A42086A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 08:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="cALgeEly"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD4A42086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBEfN-0008Sn-Sj
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 04:53:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48367)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iBEdV-0006U7-Kv
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 04:51:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iBEdU-0004QG-5N
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 04:51:29 -0400
Received: from mail-eopbgr70122.outbound.protection.outlook.com
 ([40.107.7.122]:21808 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iBEdT-0004Ow-Df; Fri, 20 Sep 2019 04:51:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CVCSzgGm6Kycd4ozDVxSNk/a2GC7F0zxdTChzfmkeIqPqSVcAN2jhZqcfCiMoN5HdawkEQYq8Ilg+xvL7PoUbUAF09pNkAUW+jCL3Rb99Y0BmdAypwgDc4bwBTzlgdFsRCmOPo1MnO9v3YnrUmRjTEeKp26/kN2ny6WB5NxAq7I/GOSMG8IEcJe9FLhGRYVQ9tuB3hW4qxVEGO0aRAZocTlPzV1NScwkrFOzDt+xdMeTtouAhqwTnpvXAp+Yo4hYVBEHIEPYnr/la+0wERCjNYyajHekTHVH36Et3wfkdG9aN6suTz55+tYKpcelFNfL3D6QQq12P0MqQM/laI6EDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jujjw1b0Q9z8HWpr3YbH9aqyp37qLaDb7nzMlnyJ6vk=;
 b=d2gJRGKqhvHYk2Tz6zW8yF31yMv3+21yBmi8j+xVrBgoqMIDWFwcapP6VktVf4dP64kjMhnmfK8hkMve+by+5gaR+ujtOx/8HckN2pkMlyizYK8eUUk6Dr5+12yb/pUogvtliyvx+CPgsELmHtNE2Gtwv4tkJdnSivpESBpwVTznK8WeYwYPhhpusnKtYDj0fD+HFyW1GmEmN7krwxyorg6YSrQAo81zkC8UkiAJmbbIbrPRd4abXAdTeqP/8RMWTqaqmFflidrmqF3Xw/YmlHcuwKSyjwkeq1ZMmNaCesALg7+VRQe32vXptAvFYxjhQAeuFd1Ypn+4pBoiwiZ7Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jujjw1b0Q9z8HWpr3YbH9aqyp37qLaDb7nzMlnyJ6vk=;
 b=cALgeElyerict3J7LQMzfdfHd85z1mvlQLAEIKxZElESkvnjAl8cKHNfpzH+pqWRWfArrjxbY+7ENjJ17tAppeTt7iQ8RgfWjvZNiYwUzEOJ0+5WaQ2XKhNeJbGsPCCcCouMFybduygPihWIUYgy4M1ufZOi8EybiFldNtU+53s=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5193.eurprd08.prod.outlook.com (10.255.17.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.23; Fri, 20 Sep 2019 08:51:24 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2284.023; Fri, 20 Sep 2019
 08:51:24 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH v2 2/2] iotests: Remove Python 2 compatibility code
Thread-Topic: [PATCH v2 2/2] iotests: Remove Python 2 compatibility code
Thread-Index: AQHVbwiZL5xBS0N6A02BkQfJQr8BIqc0QxSA
Date: Fri, 20 Sep 2019 08:51:23 +0000
Message-ID: <c11f5683-b879-c984-08ad-796f70760ba4@virtuozzo.com>
References: <20190919162905.21830-1-kwolf@redhat.com>
 <20190919162905.21830-3-kwolf@redhat.com>
In-Reply-To: <20190919162905.21830-3-kwolf@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0501CA0015.eurprd05.prod.outlook.com
 (2603:10a6:3:1a::25) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190920115121472
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65c00078-62f6-4a53-4eff-08d73da7b717
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5193; 
x-ms-traffictypediagnostic: DB8PR08MB5193:
x-microsoft-antispam-prvs: <DB8PR08MB5193FA159EF165889E00FD30C1880@DB8PR08MB5193.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0166B75B74
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(376002)(136003)(366004)(396003)(346002)(199004)(189003)(31696002)(6506007)(36756003)(4326008)(54906003)(99286004)(6436002)(110136005)(7736002)(14454004)(6246003)(478600001)(76176011)(8936002)(86362001)(52116002)(66066001)(316002)(2501003)(386003)(71190400001)(486006)(6116002)(66476007)(71200400001)(66946007)(102836004)(66446008)(446003)(11346002)(26005)(64756008)(229853002)(66556008)(2906002)(3846002)(81166006)(81156014)(8676002)(476003)(2616005)(6486002)(31686004)(186003)(256004)(305945005)(5660300002)(6512007)(4744005)(25786009);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5193;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ePy0bQDXmf3qBVa8AjsQT04/2LqA1vaUFqx1UoNopEtaSb0ObmDU+9mD0GLJ8u2pDLpq1+mnqt2QGvNaTtUn8etH2mi87solevlX6HaDb/iDc3T+jIYRgdJD+1bxRh7QwS3r1aQ7k2tnYlbw3+QiMadrT6ULgb1CBrJOF6PuAwQjv7XQ3wXYAYn/bnPjTkXfyPvHyR6+zGTeZzx4gmuRqd+7R8Jvnf4I2I3BDvtRWDVxVafS2Nen/X4aFODynYbaW9VohyjAutPUbQkZ44RpDlEjXcuGObgRF5AwqZlWp4O+ug0EC1s/IqWewgme0tLgM7vvW0WAwc85lKNJ5cyjf/DHZIhGuAEkWNbRtZsPqVsuuh7OvCs8WVj2XJLi3T5DAKBFxcLUgBEgOQTsZPZriri44KilDMFTzjp4Kr849qY=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <BFA52D77CFCD03428366EC228A7BA420@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65c00078-62f6-4a53-4eff-08d73da7b717
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2019 08:51:23.8776 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6q6fnu3bcZYnQlqLgiGI8sSn/szvgchRgY22Z5j0lL4u/gez5JB0pYoD3npY2t+5kYMVN6xAEEBci0pMflYVdStqkpQGhHqYkI+aBxZmFbA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5193
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.122
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
Cc: "thuth@redhat.com" <thuth@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "philmd@redhat.com" <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTkuMDkuMjAxOSAxOToyOSwgS2V2aW4gV29sZiB3cm90ZToNCj4gU29tZSBzY3JpcHRzIGNoZWNr
IHRoZSBQeXRob24gdmVyc2lvbiBudW1iZXIgYW5kIGhhdmUgdHdvIGNvZGUgcGF0aHMgdG8NCj4g
YWNjb21vZGF0ZSBib3RoIFB5dGhvbiAyIGFuZCAzLiBSZW1vdmUgdGhlIGNvZGUgc3BlY2lmaWMg
dG8gUHl0aG9uIDIgYW5kDQo+IGFzc2VydCB0aGUgbWluaW11bSB2ZXJzaW9uIG9mIDMuNiBpbnN0
ZWFkIChjaGVjayBza2lwcyBQeXRob24gdGVzdHMgaW4NCj4gdGhpcyBjYXNlLCBzbyB0aGUgYXNz
ZXJ0aW9uIHdvdWxkIG9ubHkgZXZlciB0cmlnZ2VyIGlmIGEgUHl0aG9uIHNjcmlwdA0KPiBpcyBl
eGVjdXRlZCBtYW51YWxseSkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBLZXZpbiBXb2xmIDxrd29s
ZkByZWRoYXQuY29tPg0KDQoNClJldmlld2VkLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZz
a2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpW
bGFkaW1pcg0K

