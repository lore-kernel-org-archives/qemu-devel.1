Return-Path: <SRS0=aRDT=W3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C61BC3A5A6
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Aug 2019 12:36:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6277922D37
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Aug 2019 12:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="rRh0FKL4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6277922D37
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i42bx-00037A-HE
	for qemu-devel@archiver.kernel.org; Sat, 31 Aug 2019 08:36:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52866)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i42ax-0002Zy-QE
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 08:35:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i42aw-000741-7A
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 08:35:07 -0400
Received: from mail-eopbgr40091.outbound.protection.outlook.com
 ([40.107.4.91]:20846 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i42av-00073Q-MB; Sat, 31 Aug 2019 08:35:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X2psrwCRSanDywuyUdpTn1WgjEnzH/kFG7xG5FeUHJb/kKPuvYd/6pPAFzB1Xv1857f3UVH/yc9ztZdtv0QS8sbTK6BBW4wC3amIXShDn2zzBPjWQrzSltYtDfC4TJowUr2KIoL3i5q7FSGxTiqMw+WIHdBxCRVUxDj2hL9wLsSt06UPOfl7bCnhTf2v+bGYgFII93JXYbIqkOynfbqQXllifbySCIIKuW+WylxpIFhwp5el6ruOaWZ6rt9tO2J2CuEnm5bAtek8TvGqcHihpokakY+EDGZ8ws4Tmw/fJ5a+/QWPL6TebhHWqXu+blB75KY07YuyDI54G0x5RHIafw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vpFV5Xp06Xuudj3PbUU/Dozdk458YWzzJaf3ZNbJ3j4=;
 b=eHVZJ4pIt1O46WnREZkmA0dAxWqYT3EQHaxl+2EKTlXwW35Vs0jG6Nfl8DMMI9z9BEi2wxIq/0euCvYrPIQMD8HgyhHfKioszx4euZvwaK6uw+J4Mz43L2TYRrcK4AYDjcRoWmpjuOG/1qdG1Pmyk0KGJyjSOUmyoFXkNs1G13bq8Gg3M7KdM358ixqEEcbs6VigbKnsxNj0hjuuu3XmkKmPSKEKB8dv1p8DyN+GpIOccuPxMglb6yjyPGhs9IFH5gVJV8tCCXcU9WFdsV1eKrfd1OFOI9GdKaT8QE7HWsoSWrRieELbOkWV/W3aB1cTyDxIXiqTW1SD6AgWvgdprA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vpFV5Xp06Xuudj3PbUU/Dozdk458YWzzJaf3ZNbJ3j4=;
 b=rRh0FKL4YLdcjFEYcy4s/kkLTrAknbd48X9ljgdYOF7aYpbx+HZb77WFCMye9ChukdbiOrPpF5eLZ+7uNvsOtZ6JSXsPTS95rLUkKXSAxBqFlESMqwvK03RMKALyHZfq/lgOQZLoPcg2vIDUUAW7pvQvYaLJzF15jeNnc86TD2U=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5177.eurprd08.prod.outlook.com (10.255.16.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.19; Sat, 31 Aug 2019 12:35:02 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2220.020; Sat, 31 Aug 2019
 12:35:02 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v6 40/42] iotests: Add filter mirror test cases
Thread-Index: AQHVTs22i6yP/NlQIUS6mqZFHPpcxqcVU2WA
Date: Sat, 31 Aug 2019 12:35:02 +0000
Message-ID: <3656dcc5-41e4-6f6d-088d-11c912e4d1ee@virtuozzo.com>
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-41-mreitz@redhat.com>
In-Reply-To: <20190809161407.11920-41-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0102CA0027.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::40) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190831153459849
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 51f3f485-2645-4f09-ffb3-08d72e0fa4ba
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5177; 
x-ms-traffictypediagnostic: DB8PR08MB5177:
x-microsoft-antispam-prvs: <DB8PR08MB5177D1ACEA3829AEBF081C43C1BC0@DB8PR08MB5177.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:129;
x-forefront-prvs: 014617085B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(376002)(396003)(346002)(366004)(39840400004)(189003)(199004)(2501003)(4326008)(8676002)(110136005)(6486002)(7736002)(14454004)(5660300002)(31686004)(81156014)(66476007)(54906003)(6246003)(76176011)(305945005)(478600001)(31696002)(8936002)(66946007)(71200400001)(64756008)(66446008)(66556008)(99286004)(36756003)(2616005)(186003)(25786009)(486006)(52116002)(256004)(476003)(446003)(11346002)(102836004)(386003)(6506007)(2906002)(81166006)(53936002)(6512007)(86362001)(6436002)(66066001)(316002)(4744005)(6116002)(3846002)(71190400001)(229853002)(26005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5177;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LtQMzQId4uqOL0DuwBTKSiHK98KuovwEDYbBhwDeFITp6SCs4N7+xwBsqJwK8t5wdazLn9S5nCQC6IAWQ3a26em5gyG0cN7eV28kRFiIFqw5NK2xHc4U9s738LPkAr729jm6ibiN3wxCT0YSEOYNBSc2ZurkedVOapoGQW1kEbHpVbsa33tTlFUaosf3d5iQcOIBMD2igH1zRp9DdDKlXWlI8UcpDWFMOrWO2YJwQZCNnPLY1tesS17rzyT8Zn4dCsvriCnau7Umn7/tuAb78hGvf5vHt+2OlW7RvqxLAsdqVS+v8b8mIcGh9wd2c0IYWWHCqOo+/ohX04w4kG1LO3xw0b31RrErT4hu6O0fbF6Fk5kScXev1B1GVKrW5/h95RTm1c7O2ghNL7Qtekj0ZkN6frlwuSexYUuJcy6Lao8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <7FDC6CFECF4F284A89BC0F290181411C@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51f3f485-2645-4f09-ffb3-08d72e0fa4ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2019 12:35:02.1081 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gcCAabb94nEYkZQYdIV08oK2n7MsQVqkhWWPfhOsFrbJ7NsVu+XELo1uyqKfKCa1c5/MJ5jRvLXOhJK9zTPRwK0gvj2G+mw0k/IgP+ChYSM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5177
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.91
Subject: Re: [Qemu-devel] [PATCH v6 40/42] iotests: Add filter mirror test
 cases
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDkuMDguMjAxOSAxOToxNCwgTWF4IFJlaXR6IHdyb3RlOg0KPiBUaGlzIHBhdGNoIGFkZHMgc29t
ZSB0ZXN0IGNhc2VzIGhvdyBtaXJyb3JpbmcgcmVsYXRlcyB0byBmaWx0ZXJzLiAgT25lDQo+IG9m
IHRoZW0gdGVzdHMgd2hhdCBoYXBwZW5zIHdoZW4geW91IG1pcnJvciBvZmYgYSBmaWx0ZXJlZCBD
T1cgbm9kZSwgdHdvDQo+IG90aGVycyB1c2UgdGhlIG1pcnJvciBmaWx0ZXIgbm9kZSBhcyBiYXNp
Y2FsbHkgb3VyIG9ubHkgZXhhbXBsZSBvZiBhbg0KPiBpbXBsaWNpdGx5IGNyZWF0ZWQgZmlsdGVy
IG5vZGUgc28gZmFyIChiZXNpZGVzIHRoZSBjb21taXQgZmlsdGVyKS4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IE1heCBSZWl0ejxtcmVpdHpAcmVkaGF0LmNvbT4NCg0KUmV2aWV3ZWQtYnk6IFZsYWRp
bWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCg0KLS0g
DQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

