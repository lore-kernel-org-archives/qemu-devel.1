Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 790D0C33CA1
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 09:13:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43E7520684
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 09:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="kSx2tUiI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43E7520684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itT7z-0005RH-Ei
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 04:13:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54267)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1itT6X-0003fL-5Q
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 04:12:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1itT6V-0002yv-4o
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 04:12:17 -0500
Received: from mail-am6eur05on2112.outbound.protection.outlook.com
 ([40.107.22.112]:63713 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1itT6N-0002wt-Rj; Mon, 20 Jan 2020 04:12:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LKWD6ShtqqdsYWSgqX/6586+gbhYibVR7G/O6wmxaGsFUJLBo1YCa647lwc8TTBKu4OkuU3d7Nk7UBl4yojrNhPsYNlvfNzLMJd1sds6vMS/mSCvvQ3z+ZYeTIZU51loVN65inwAeLgyr2u/Lv+kIUlygqbHaRignAUINiAP4KW8RJ2L+oj7HhGbyJiPayaTeKs4JJMD2bYZfD58k2VhRXes1UN6LHwF5ls/SIWyKRXwdsJhYl/EDkLYuL1eIoLHGIJiu6+uz4xULomss2moaBEXm3NWiRxim5TyuWS/h/jPj4D/A8KMODDxnQl/SQUDkt5HgKh16TagGuqNbfNPvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+EJZv1x0WR4jYqhF6jPnuntss5aLN2ZtpRK6lEAdG4=;
 b=IYdNrNg61UqRnV7/YfNZyWllVr7lZp72933BiX71Z0e3vC9HgacN81J12UV2caGfbt2tP1wDec9luRgqc5Wmgpl+/T/2zyCnL5TGekHxSsC8RGMzu9ZPysgI9dNwghq8/mK3gsS8ro1I2+vi90M5VYI5A7FbIfwaobMdjkriO+GSBZA6OWnLcOdB4znTFBxwloyD3Sy9KdlO4a1Dx7OzilyXc6De0a9oK61Pog2fsmnopBLb+YmqzjqMuO8uztFI7Y8i2wM3M6ZjJY9g8BuKQYtS5Eu+a0Gguv4v7SOOOu6gTIXFQi+QzrqqxpHX08OUTLTi6H1LlMoNilpTlF3Pyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+EJZv1x0WR4jYqhF6jPnuntss5aLN2ZtpRK6lEAdG4=;
 b=kSx2tUiI6cDVLaFHGMDGp2JPkRlRRj0SoSfI0EDnCLNapJ0gscwLl3ki6ueMaXcOS4/osF+yzDbMkqs0AiiwNOpGXT2TcX9bv6bbw0CfGHJHgE7SWVRW0QdZikJ55siXyoZcq4kX43LRD7ZSDeBf7T6+vaOqBEcn9NoB9MY4Yus=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB5270.eurprd08.prod.outlook.com (10.255.121.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23; Mon, 20 Jan 2020 09:12:05 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2644.026; Mon, 20 Jan 2020
 09:12:05 +0000
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR05CA0189.eurprd05.prod.outlook.com (2603:10a6:3:f9::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18 via Frontend Transport; Mon, 20 Jan 2020 09:12:05 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v9 0/2] qcow2: add zstd cluster compression
Thread-Topic: [PATCH v9 0/2] qcow2: add zstd cluster compression
Thread-Index: AQHVtArTvV+OSQZsMUmr+E8pxKosJ6fze0WA
Date: Mon, 20 Jan 2020 09:12:05 +0000
Message-ID: <9fc0a0ed-49eb-d98a-9547-225e88530b64@virtuozzo.com>
References: <20191216121733.63562-1-vsementsov@virtuozzo.com>
In-Reply-To: <20191216121733.63562-1-vsementsov@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0189.eurprd05.prod.outlook.com
 (2603:10a6:3:f9::13) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20200120121203770
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aba2c204-d1da-444b-3ba2-08d79d88d1c2
x-ms-traffictypediagnostic: AM6PR08MB5270:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB5270CAA9BAD6E98922654D44C1320@AM6PR08MB5270.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-forefront-prvs: 0288CD37D9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(346002)(366004)(396003)(376002)(39840400004)(199004)(189003)(31696002)(81166006)(4744005)(6916009)(81156014)(54906003)(8676002)(5660300002)(16576012)(52116002)(316002)(71200400001)(86362001)(36756003)(478600001)(107886003)(2906002)(16526019)(186003)(66446008)(64756008)(66556008)(66476007)(4326008)(6486002)(8936002)(26005)(2616005)(956004)(31686004)(66946007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB5270;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KdWaf6ty/bkmau+6Ng23t6FGyZEvDROQADxsoNcY/Pq33cSDCtV49XMWt8OAac2eJOPYefhndLwq+xgOGE+nap9Cpcx2u+95ENxPiMeChqWeVx7QInYGRN4wBVGcY1vhYvq34HOJ+o5ETzsIwx0nPxfBKEHYZcLrXBx9yZNvRt+63qLo7m4WcSL+FVrXoPvk2ltej1rkfo6y69RzJ9DJmcFDWL+8WWt0zcT1ybUVwgQR+z0aa8HlK5LiacRqmu72TWj1cHkv6ZsP06sitfSJcmCqiuW3cMREg10vQdbzpAzrf1J5va7mtjiZfXkB/qIcglOzO2rKB77n2uTNLvcs4m++WCFsazyjfIG5gMactY+pDxtBaesfeiYIwUZBKiOZseVUHmbyiq11Vh9ZxPuSnEP2zdrgoHo8UoOB9EJSC40nZANW9V6Y0rE1niHaZSWp
Content-Type: text/plain; charset="utf-8"
Content-ID: <C393E28701CFCC49ABB2F9C1580B79DA@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aba2c204-d1da-444b-3ba2-08d79d88d1c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2020 09:12:05.7784 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XXnJG0LrYdwdNTAfh4rwvFDcUjbvVdgkCH6oyr2mfToK06B2EKk10GHkN7hY3u0zcR4OEM6USdwK+ydn79J6MrInGtvpAToEgTzNwy1UAJc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5270
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.22.112
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
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

cGluZw0KDQoxNi4xMi4yMDE5IDE1OjE3LCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdy
b3RlOg0KPiBIaSBhbGwhDQo+IA0KPiBIZXJlIGlzIG15IHByb3Bvc2FsLCBhYm91dCBob3cgdG8g
Y29ycmVjdGx5IHVwZGF0ZSBxY293MiBzcGVjaWZpY2F0aW9uDQo+IHRvIGludHJvZHVjZSBuZXcg
ZmllbGQsIGtlZXBpbmcgaW4gbWluZCBjdXJyZW50bHkgZXhpc3RpbmcgaW1hZ2VzIGFuZA0KPiBk
b3duc3RyZWFtIFFlbXUgaW5zdGFuY2VzLg0KPiANCj4gdjk6IE1lcmdlIDAxIGFuZCAwMg0KPiAg
ICAgIENoYW5nZSB3b3JkaW5ncw0KPiAgICAgIFJlcXVpcmUgaGVhZGVyIGFsaWdubWVudA0KPiAN
Cj4gVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSAoMik6DQo+ICAgIGRvY3M6IGltcHJvdmUg
cWNvdzIgc3BlYyBhYm91dCBleHRlbmRpbmcgaW1hZ2UgaGVhZGVyDQo+ICAgIGRvY3M6IHFjb3cy
OiBpbnRyb2R1Y2UgY29tcHJlc3Npb24gdHlwZSBmZWF0dXJlDQo+IA0KPiAgIGRvY3MvaW50ZXJv
cC9xY293Mi50eHQgfCA1MyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKyst
LS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgNTAgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkN
Cj4gDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

