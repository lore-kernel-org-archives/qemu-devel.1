Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBEBCA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 06:52:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0587C2086D
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 06:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="hlmmJz6Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0587C2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMRXw-0007gZ-Sh
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 02:52:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44257)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1iMRWY-0006OT-Uc
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 02:50:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1iMRWX-00041o-C9
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 02:50:38 -0400
Received: from mail-eopbgr50127.outbound.protection.outlook.com
 ([40.107.5.127]:39969 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1iMRWW-00040J-P9; Mon, 21 Oct 2019 02:50:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N9XC38sD1hiG1vMbzbLQXUV+ZZpP99BrAAI4i5Ni31k1xFZgvNRowlheCKZwOgb9Qzhe1vfnfY6yMjMlsxb21IOO602pGFVaBjL3AhYbMMyv7lZk0maViC4svSrQ200+VMOMteKfXGMAvoC5SaMI2HyiGOvcF4P/pKSiybJ3puDDKiQKiS7jU4bEYJ8BYVM/R0O6EJT+wcZS0u30xWb3TAPV5wigBXWDpdcmPqbiWPB5uj+HqO6Gi75Qid9V/k8GWJ+F7FSg4uzgJIG1x/BLol91IAZZN08whLTSEA/Dy/p+pioQ/rOK4vp+UNC33dkZdpQpgxDhq9xx4Nc5Iznbdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pXMNcbNqsUqoUix3XM6dh2viOBiIAgmMen713bLOvY0=;
 b=gJ3qfPBsHeDGtq+qE8z7yHOz+JdAARk17FnGUrdFK3Tl86UnFL3YBG+RLwJov8KYqD7R7STrdQhGNw9ZmPXxH1oIJ/OJio9tYcwpzVVzE0Szw+VtXL7SH+QMT9oujIpogjwhdwzTnHHn2xYPp6iA3QwL6LdpoiZjBN9yCRv0sTVU9umqLDGvlgwJp50+1mVJEAlguU4nJ/W6S8nLrV59weDsuJtNmd2hXJc57M1oa24uUpDYWjhlpKte6m5Fp87DQIsGyQ2sOPhQFaax2jGYJjt9MD56kk+C8HHduqP/s8LhkLGcnpfCCJtesHH1DfFGISJYyZ7iDjA34a65vyY6Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pXMNcbNqsUqoUix3XM6dh2viOBiIAgmMen713bLOvY0=;
 b=hlmmJz6Q3ftUgRbbBUY8fqt9fL1i2UaaK8PVq99WFqEDEobPhVgDfXmDGIqv9RUVgkbKstmfewjIe6KTYlGZ8iGw+BLLlcYrosLX6Tpp/FDcZPNaTZgamfu8S3SMy5Ju9YNNOWsTcngZY1Pa/hlhKGKQsHQUiX1I6gVzP0bjGhQ=
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB5297.eurprd08.prod.outlook.com (52.132.215.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.18; Mon, 21 Oct 2019 06:50:31 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::cb5:43e:b23f:9618]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::cb5:43e:b23f:9618%7]) with mapi id 15.20.2347.028; Mon, 21 Oct 2019
 06:50:31 +0000
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH] blockdev: modify blockdev-change-medium to change
 non-removable device
Thread-Topic: [PATCH] blockdev: modify blockdev-change-medium to change
 non-removable device
Thread-Index: AQHVhaz+7x8iUD8wDUy+y9mCSVwunqdgfsuAgAQtggA=
Date: Mon, 21 Oct 2019 06:50:31 +0000
Message-ID: <f5d689f6-4b23-8314-f92a-294ffcb6721b@virtuozzo.com>
References: <20191018120950.26849-1-dplotnikov@virtuozzo.com>
 <2b6cc2fe-5269-71ab-9f0b-1ab36d4dc050@redhat.com>
In-Reply-To: <2b6cc2fe-5269-71ab-9f0b-1ab36d4dc050@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: GVAP278CA0017.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:20::27) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [178.34.161.147]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 806765a9-23ae-4700-af39-08d755f2f71e
x-ms-traffictypediagnostic: AM0PR08MB5297:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB5297B6F41075249B627AFAADCF690@AM0PR08MB5297.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0197AFBD92
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(979002)(376002)(39830400003)(366004)(136003)(346002)(396003)(189003)(199004)(6512007)(102836004)(99286004)(31696002)(256004)(4326008)(36756003)(31686004)(478600001)(2906002)(6436002)(14444005)(52116002)(76176011)(6486002)(2501003)(229853002)(86362001)(66066001)(305945005)(25786009)(7736002)(66476007)(14454004)(486006)(6506007)(107886003)(476003)(6246003)(71200400001)(54906003)(386003)(3846002)(64756008)(66446008)(8676002)(316002)(66556008)(66946007)(26005)(8936002)(2616005)(5660300002)(71190400001)(81166006)(446003)(53546011)(81156014)(186003)(6116002)(110136005)(4744005)(11346002)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB5297;
 H:AM0PR08MB3745.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eEKvTl0S6alR4jvAzgZcZDHtBz0D/FkuCmmkYL8f4CYMb7Fdu7NoqVYkvDC+Au+WZE9Rxgjd/mSPgZi/akFhzknoZPy8JZr/xKnJ2PR0lTzAXm5ereFU+YSOusera6xzoM0x+naYeC7IQM4fBpm02KgaTnmBog8XreYH7xvS/7UMwOLPx7Ro21fOtJu/LrApVUT/ptyY9Fg5uw+E+GuWtjxpsDYa5/lJ3x7MOfzGsaStjW2GjG7eJjk9SEoHO6ZBPbXtSTrXtlLtY1AsgK4i4ix4WylU5IQo5KItszgaIGCs5pReGVTKgvIMJydt3fPMAjNtPAeOnxdMmTevdNj4/GgQIhh3bu9XS0JKWCih5qTCT+Y93zMjIRQm5wyJ8AReFtgfu+1VEM5sMnLI4DNyfkMwnNy++mwUdK2ufzve2CU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <77FA1A360279E249B7F60F86E61C0A2F@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 806765a9-23ae-4700-af39-08d755f2f71e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2019 06:50:31.5392 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YvAiTHT2Ezl6qp7iJBMvy8x4+4GYRgzz0DgtOc1rRsNTBZuFkcfs2NfYnnaniqdK8nv1Ic5eYJ3bNxRw9u2U/J7HlnWog95eCXu7dYPkL9U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5297
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.127
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQpPbiAxOC4xMC4yMDE5IDE4OjAyLCBNYXggUmVpdHogd3JvdGU6DQo+IE9uIDE4LjEwLjE5IDE0
OjA5LCBEZW5pcyBQbG90bmlrb3Ygd3JvdGU6DQo+PiBUaGUgbW9kaWZpY2F0aW9uIGlzIHVzZWZ1
bCB0byB3b3JrYXJvdW5kIGV4Y2x1c2l2ZSBmaWxlIGFjY2VzcyByZXN0cmljdGlvbnMsDQo+PiBl
LmcuIHRvIGltcGxlbWVudCBWTSBtaWdyYXRpb24gd2l0aCBzaGFyZWQgZGlzayBzdG9yZWQgb24g
YSBzdG9yYWdlIHdpdGgNCj4+IHRoZSBleGNsdXNpdmUgZmlsZSBvcGVuaW5nIG1vZGVsOiBhIGRl
c3RpbmF0aW9uIFZNIGlzIHN0YXJ0ZWQgd2FpdGluZyBmb3INCj4+IGluY29tbWluZyBtaWdyYXRp
b24gd2l0aCBhIGZha2UgaW1hZ2UgZHJpdmUsIGFuZCBsYXRlciwgb24gdGhlIGxhc3QgbWlncmF0
aW9uDQo+PiBwaGFzZSwgdGhlIGZha2UgaW1hZ2UgZmlsZSBpcyByZXBsYWNlZCB3aXRoIHRoZSBy
ZWFsIG9uZS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBEZW5pcyBQbG90bmlrb3YgPGRwbG90bmlr
b3ZAdmlydHVvenpvLmNvbT4NCj4gSXNu4oCZdCB0aGlzIHdoYXQgd2Ugd291bGQgd2FudCB0byB1
c2UgcmVvcGVuIGZvcj8NCj4NCj4gTWF4DQoNCkNvdWxkIHlvdSBwbGVhc2UgZXhwbGFpbiB3aGF0
IGlzICJ1c2UgcmVvcGVuIj8NCg0KRGVuaXMNCg0KPg0K

