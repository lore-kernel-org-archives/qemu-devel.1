Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FD9C4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 17:13:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FAB420665
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 17:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="aQXdLGxl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FAB420665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAdWA-0000ox-5C
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 13:13:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56159)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iAcW6-0005i6-8n
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 12:09:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iAcW5-00045r-3n
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 12:09:18 -0400
Received: from mail-eopbgr70128.outbound.protection.outlook.com
 ([40.107.7.128]:53666 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iAcW4-00044s-SI; Wed, 18 Sep 2019 12:09:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ltk0aIeHVgr/dDfci11ry1c9IHFu9ttVD1BOb4+Vn69wdvQeM4oxfY+MUC00sG0DTTeG1Rbd/wNhrX/M8Ve5EW0VKi5bonOytC6RgJdV8/Z4TQL71I8ErBHu/9h3QDBpQBwdXvkySLlEMLPEBBRidqxMvFIu5qLZFt2OG4PxuHmiA9AhikemamIQUw7kMyBUbObnoJTS11NKcABUOSj3FieEixDptEqPtb0UN5Q2rxx6CHMixbkXqH2VSFLDE0RUioERE6Dg+EkpG5HdcYNGRaKLM2Onh1yJW8zofdjshECf3iE3spKxm3egN6bG2pGdQhPvV2qKbCvv3G+mY14K+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CT6oNVkkcc2+VhZ7JDaAKiVUhbHLy59Ldqnw1yG9K4Y=;
 b=CxuxBac1CiJEBXBVc2KeL7dllXSmNcdr9bUEA2zCnrJvtYuF7mUyd94/obB3EAoRs2+0NBtZeJKIzTJdmH8wW6oVH1vn4J1IB1Pzfhxodr11qOUOnnrnAJgJgN456OsTwVUol3XSTRbODt5MLrwZclKqQHwVQO4n8NWlc5qEH16R2u6XVj6f9sG22HALEA11giSXgPaQtNqPTbxwv7ScmgYzWsR9r8/jtgWo03Tfyw/M2VWzJSA3SEwsov2UXOpnWSOXpcNK4EHEg8nPakV/gLeIrUeWTCh8bd2ysQofUndYxD45GgqwOvFcX4jHol5DlqPJ3mmTU+r5BuiAYf3S0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CT6oNVkkcc2+VhZ7JDaAKiVUhbHLy59Ldqnw1yG9K4Y=;
 b=aQXdLGxlQE9E6d+ZDcRuaHilV+0avEkC/JUZgOs9mqP5OAah8/aweREHLbxS6r+VN0OEE8LMAu10BYP9phS1M3//qwCbAaOoxlJkQ3ckIJKmYsoGyT5r2RBzUP9r3wBs1qpucefzrm0aDrGZ6cE6LI9qXqSLPqbHzU3xNRXhoUM=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4089.eurprd08.prod.outlook.com (20.179.9.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.18; Wed, 18 Sep 2019 16:09:14 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2263.023; Wed, 18 Sep 2019
 16:09:14 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH 3/4] iotests: Add @error to
 wait_until_completed
Thread-Index: AQHVaXWfSE9ruaJz3E+DkYnwggQ2V6cxo+YA
Date: Wed, 18 Sep 2019 16:09:14 +0000
Message-ID: <f2bd896e-72b0-360d-3878-72f4c2c4cb2a@virtuozzo.com>
References: <20190912135632.13925-1-mreitz@redhat.com>
 <20190912135632.13925-4-mreitz@redhat.com>
In-Reply-To: <20190912135632.13925-4-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P18901CA0010.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:3:8b::20) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190918190912416
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: afbead20-b091-4c5f-a9f1-08d73c528cd1
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DB8PR08MB4089; 
x-ms-traffictypediagnostic: DB8PR08MB4089:
x-microsoft-antispam-prvs: <DB8PR08MB408931DF87377D26E9722E26C18E0@DB8PR08MB4089.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1247;
x-forefront-prvs: 01644DCF4A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(396003)(346002)(366004)(136003)(376002)(199004)(189003)(7736002)(6116002)(305945005)(99286004)(76176011)(52116002)(2616005)(446003)(11346002)(14444005)(6436002)(186003)(478600001)(102836004)(6246003)(25786009)(26005)(6506007)(386003)(36756003)(4326008)(256004)(5660300002)(558084003)(2906002)(66556008)(64756008)(6512007)(66946007)(66476007)(66446008)(316002)(486006)(3846002)(8676002)(31686004)(476003)(86362001)(71190400001)(2501003)(66066001)(6486002)(229853002)(8936002)(110136005)(54906003)(81156014)(81166006)(14454004)(71200400001)(31696002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4089;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FtCa2ie9gUq4cU3OzOa5EFe4J9tt5TIN8zTyEEol1nf7FKddekqV8A2SZHB/dbjIKOIBvCRQwVEab8Bp3TSgjCk4GWBntURonP/8/ajOXCMwyL41UbcPCTx+f5cgpyLW7D+/jXTGcfYTiemzXpx7DeXi2lt2TkpBYPx1njMkv79hDvBF+vgxX9tcDzK1dAsz/QIpMDuyMq2TFH9Q0c/zaUxHo3ypv4RxcvaBDfsEUXlC9+v3Vasbboiit5kSCX7SYW/1QPgtaiB+UOXt2E02s4JzCjMJU6+Q8AMWASl1HWwWnUOwabn8+LW8oeCBBfyoyjk0888F1IFYdkfWexuCHYPClYSsLyfnnmSuHx1qayU0CTu8VnlaKArHXFDP+n3K8qDMcP+SPHnwXI4y1JLAnDJyiG+Cy4paEILxvH/I7uk=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <5CD94EE844F3D44DADCF3B58BE609168@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afbead20-b091-4c5f-a9f1-08d73c528cd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2019 16:09:14.5511 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XvZ11W1iwbexfvzX4MsqdlhYzPkFeUHxsXZNBPBSSoCGArvYYmkwyOVsROID8EzawSIAsz/+g9KyQnnJYvfh4Dtt6pmsWWH4HMoIYNVWaQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4089
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.128
Subject: Re: [Qemu-devel] [PATCH 3/4] iotests: Add @error to
 wait_until_completed
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTIuMDkuMjAxOSAxNjo1NiwgTWF4IFJlaXR6IHdyb3RlOg0KPiBDYWxsZXJzIGNhbiB1c2UgdGhp
cyBuZXcgcGFyYW1ldGVyIHRvIGV4cGVjdCBmYWlsdXJlIGR1cmluZyB0aGUNCj4gY29tcGxldGlv
biBwcm9jZXNzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWF4IFJlaXR6PG1yZWl0ekByZWRoYXQu
Y29tPg0KDQpSZXZpZXdlZC1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVu
dHNvdkB2aXJ0dW96em8uY29tPg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

