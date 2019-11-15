Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F4EC432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 03:27:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD1EE206EF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 03:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="b0Mr/y3J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD1EE206EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVSGs-0002gh-Se
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 22:27:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43283)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iVSEj-00018y-OH
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 22:25:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iVSEi-0000SA-QQ
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 22:25:29 -0500
Received: from mail-eopbgr30096.outbound.protection.outlook.com
 ([40.107.3.96]:15086 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1iVSEf-0000Qc-9A; Thu, 14 Nov 2019 22:25:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XFX5l17XW6cWagd6wkBZGmZNMD6pJJ1D/bU9snhXg9dpezf2Z6tDLpEaMTc2P/yau7EMkwBydYCWtZjl40fVD7VMJU57SLPL7+Lanwe6UO0MxCnNuL/9iAfNQsXY9xh/9981ST/VTDauFFY4zBUzSbEhpy4RvZqR0nrSD7hNbxDmZO2ukDlgVe1CA2VOD2eP4xRc/hUhndre6YwxK9sDT2tzBlJZ1fir7wYQmSBLlTNYfR/ZxXZffR+7MmNYhNsiwrRO5ODXLj5iOASm+Xb+PfRVgY+KsEmMRsFlxlknHiWDect93Ia1GpQk13AB3Ii5Tj1dzC122Xsp0dT4Bbg4Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2laVKUnqcRfxQrpAa0e92UQcvM4942bOfVzwHFSXUn8=;
 b=nlz0tyhqCbIb9DEFRJo0zDMThkMRte2ceUsGjuO0EtVjnorls48z5xwvy7wEB6wArEHlOWKDFDrvXQR1rLajDd/Fkae20ngfoq4ejOKZeELGsp21pGZoCKNWHFJGqXWT5FEKgYSHY4ozjVsAeeHi1Z62YOY3Ae2Y6OsgoZWftfS7S4jqqcTpvHg+cfFqKghFAOGZJK/meFKISNvGouEI5ltJdAWBkya7C8pypZJByau8rm6o8N80FPRgUeQD4+t5TjxcsCu20vRV6OAvp0jviXTwAChOn6GQabRN8wJqxtugX0lbqOuJa3VA0OxTHI+GDCsKLx/PxbltxcEQQjMu6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2laVKUnqcRfxQrpAa0e92UQcvM4942bOfVzwHFSXUn8=;
 b=b0Mr/y3JvxKHb7EU7EI92ClQYYenNaKjFxmygvu3bMkcotazTePAn3nSNU7aL7VBRerZtXuJkmVWixF6rQwAq6YD5LKEmEW9WlFZ+F2k0vD5fzYLi2wyfPtTjgtnp6MBZrNUXza5lqvxWPp/YVyXVMhN0+7oSvf7BCY/lOJ2+r8=
Received: from DB6PR08MB2757.eurprd08.prod.outlook.com (10.170.220.33) by
 DB6PR08MB2854.eurprd08.prod.outlook.com (10.170.222.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Fri, 15 Nov 2019 03:25:22 +0000
Received: from DB6PR08MB2757.eurprd08.prod.outlook.com
 ([fe80::a1ee:668f:c3a5:87b]) by DB6PR08MB2757.eurprd08.prod.outlook.com
 ([fe80::a1ee:668f:c3a5:87b%4]) with mapi id 15.20.2451.027; Fri, 15 Nov 2019
 03:25:21 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [PATCH v5] iotests: Test NBD client reconnection
Thread-Topic: [PATCH v5] iotests: Test NBD client reconnection
Thread-Index: AQHVmQrV4Dkzt4+ca06YG9+T+/j6zqeKyNOAgADNsgA=
Date: Fri, 15 Nov 2019 03:25:21 +0000
Message-ID: <ffcafb3d-dce2-60a3-28a3-499ce430c066@virtuozzo.com>
References: <1573529976-815699-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <2c4ce0e6-92e8-fa6f-b151-970d6e5b516f@redhat.com>
In-Reply-To: <2c4ce0e6-92e8-fa6f-b151-970d6e5b516f@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0101CA0004.eurprd01.prod.exchangelabs.com
 (2603:10a6:3:77::14) To DB6PR08MB2757.eurprd08.prod.outlook.com
 (2603:10a6:6:18::33)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2b3c70e5-5c37-4bab-31c9-08d7697b723b
x-ms-traffictypediagnostic: DB6PR08MB2854:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR08MB2854A31613776A00F4F0B6C0F4700@DB6PR08MB2854.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 02229A4115
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(366004)(136003)(346002)(396003)(376002)(189003)(199004)(2616005)(4744005)(66066001)(6506007)(99286004)(6512007)(71200400001)(5660300002)(107886003)(31696002)(110136005)(44832011)(31686004)(8936002)(81166006)(4326008)(71190400001)(6116002)(316002)(86362001)(2906002)(81156014)(8676002)(54906003)(476003)(486006)(446003)(76176011)(2501003)(36756003)(2201001)(25786009)(6246003)(66446008)(14444005)(52116002)(256004)(66476007)(66556008)(14454004)(64756008)(66946007)(6436002)(102836004)(386003)(7736002)(6486002)(305945005)(26005)(478600001)(53546011)(3846002)(229853002)(186003)(11346002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB6PR08MB2854;
 H:DB6PR08MB2757.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7Nt5N5LtDDXdITbBM4P7qEm5ISNxt3w2aJIU+zSJul8SRLKkw3yqLKOnPNd44Pj6NjgJO7bIvPp2ymSDI3D/zdGyEkSo1poRzDzNaNLqK/mFZrbE576QEpwVoS9EIy1m7KXWQxalmIyY4/NXmis9bwoEGbi8Bz+b5tgHKDLlJ5XZllj3fnuMh4A7L79eaJYDAh99WQiwxqWywiAtD07zmoNbORIjTsfd+JK1aFKOCJWtn4ZNtHxPaEpABC1JuMKnf4narxfxYMCvveO+DNg8/Z8TJM0RBccXjrK4aHl18T23dyKW3Jz2oyuGOU6dHrc7v/FpF4HBp06EFK+fKmw/Fqk6dtVxZGJWcccX+Hq7xgZNseGhzmpJ7CAIeSyne25DE6srfFJDpHYYoFhNBsss2BJArpMjtcsl2EikMcvmbBrPKrmreLGpgJnHJK6mp8Yq
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <981F89454D44414AB3AA75986382697E@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b3c70e5-5c37-4bab-31c9-08d7697b723b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2019 03:25:21.6916 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DV52cOj8b32RoHHc5+W/lNCxrRL6RlnLMQjyYon1wfhlO75/NUJy5XHaQXu5glyfLQaNejB3L8XuH02H9QEbh0aF7xB3ksG4gfVD84PvqN8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR08MB2854
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.96
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Denis Lunev <den@virtuozzo.com>, "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 14/11/2019 18:09, Eric Blake wrote:
> On 11/11/19 9:39 PM, Andrey Shinkevich wrote:
>> The test for an NBD client. The NBD server is disconnected after the
>> client write request. The NBD client should reconnect and complete
>> the write operation.
>>
>> Suggested-by: Denis V. Lunev <den@openvz.org>
>> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> Tested-by: Eric Blake <eblake@redhat.com>
>> ---
>> v5:=A0 "" were replaced with '' in the test except the function comments=
.
>> =A0=A0=A0=A0 The 'quick' word was added to the 'qroup' file next to the =
test=20
>> #277.
>=20
> Queuing for 4.2-rc2 through my NBD tree.
>=20
>=20

Eric,
Thank you very much.
--=20
With the best regards,
Andrey Shinkevich


