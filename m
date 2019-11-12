Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F4FC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 15:30:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 904B420679
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 15:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="IK9XKhEi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 904B420679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUY7Q-0005HN-K6
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 10:30:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44246)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iUY6e-0004fn-I7
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 10:29:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iUY6d-0006jK-Cw
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 10:29:24 -0500
Received: from mail-eopbgr50135.outbound.protection.outlook.com
 ([40.107.5.135]:65512 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iUY6Z-0006hm-F0; Tue, 12 Nov 2019 10:29:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A5zZvPcKKP0EISJJzxTaa8I+yZtdNNyVL35BMa4/opfPROSSezfNgeMDBPjBlEIVpjd5m+IsgVVTweZAk/41Nzf69brWpv5K/wEab/ulrLOw7DRN4YsvrcOln2uHN3kNnzO5aElgXAqCR87HloP4KS2cyKTpPTqOz4fdfdSf+8IQpYIgAvNxmpqm0slMl8lnIdmXNN+DyG8pWV8eeqI77CigKK8ZZ1saxTX99v+3c9eaKiOtaXGz5UREqQVz6J+fD0RQoRS9SP+KsyQsVHQocYyjzOJllen+o8hP033JhYVFONprEP35faAH5NnKzsNJkr4xsYWyTE+LNWUgU6OOlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nCjDcaxyCljAUFQAh+qMUKrrRVZxqhZ29/J7IeQqnEI=;
 b=QFR8+qBxn2S1qwVlQCHegGE5FapThyle6FHlpMETth623p7+7P/nsj5Ww41Iou7flbR3Hp/iHQevs41gtCxE7V6ovYqnW8UbOlkOYA0ubUQCF9New/bFoMr1rxYPsOyW2h9GwUbMEiGfwqumBCbPDVKEhSseVRR8iZOR0Syu8wbIlRkltiyRwgew8Mlf3JXaXutxeDLJRNDwUAE7DmFAgXQ5LYqsHyR+CXxHmnVpxWVxr+urTrJKqTQd7QjPeB/AR+QpzO8pyztvru/7gHufuadSzMgfSJND9sQQtBdolLIOoCMZCLvso3L2ix9hZuWfUwt8dD7c2uyNdIlUi/Fhyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nCjDcaxyCljAUFQAh+qMUKrrRVZxqhZ29/J7IeQqnEI=;
 b=IK9XKhEiaBfQoVXu0WHFrOp+2D3vylYnjem5ghqSGk5KYrgKS8W8UYIiVbSE76wdQ0MYlbY1ubWit/fiI6jobYU33MYMovuiQhrH05fOSBAlg3aM6FWPgk4tkdI0j+3uBVYYT6hODH4ND6cbm0WFE4at+Eg3n1o2iRO0jMQUtRk=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3160.eurprd08.prod.outlook.com (52.135.163.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Tue, 12 Nov 2019 15:29:16 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 15:29:16 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC v5 023/126] hw/vfio/ap: drop local_err from vfio_ap_realize
Thread-Topic: [RFC v5 023/126] hw/vfio/ap: drop local_err from vfio_ap_realize
Thread-Index: AQHVgE3MINO+9duWtUenEUAcgieu9KeHs1wAgAAn6QA=
Date: Tue, 12 Nov 2019 15:29:16 +0000
Message-ID: <0c562837-109f-72ea-11a3-434362f9abb7@virtuozzo.com>
References: <20191011160552.22907-1-vsementsov@virtuozzo.com>
 <20191011160552.22907-24-vsementsov@virtuozzo.com>
 <20191112140624.5a582db7.cohuck@redhat.com>
In-Reply-To: <20191112140624.5a582db7.cohuck@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0258.eurprd05.prod.outlook.com
 (2603:10a6:3:fb::34) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191112182914218
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f2240e3d-4294-4acb-8483-08d76785142f
x-ms-traffictypediagnostic: AM6PR08MB3160:
x-microsoft-antispam-prvs: <AM6PR08MB3160DAC871120782B9153DD2C1770@AM6PR08MB3160.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 021975AE46
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(376002)(396003)(136003)(39840400004)(346002)(199004)(189003)(3846002)(6506007)(71190400001)(386003)(99286004)(71200400001)(31696002)(76176011)(486006)(6916009)(7736002)(102836004)(446003)(31686004)(26005)(2616005)(36756003)(25786009)(66066001)(11346002)(2906002)(305945005)(4326008)(86362001)(6436002)(6116002)(66476007)(66556008)(64756008)(476003)(14454004)(478600001)(6512007)(8936002)(186003)(8676002)(66446008)(316002)(81156014)(81166006)(256004)(5660300002)(66946007)(6486002)(229853002)(6246003)(52116002)(54906003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3160;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gqEXpuJDFF51CMC7NYOukmpOJjBwvZm9NVBMfn3PqLhMOfndbrCV5NSLRxyT35Ix6nChc7ZJDdFO9J5s8zPnxlfx/70Z4jcjhERJJuIDjZjn5/cghSTy8I2sQqhw+ZfLiro9cqNVEooXOhV3jfM0MNAjBOO0HV2LKll+qY2VQWO3/v5W6vaJJQhH9cHPOi2NI6o+GbIxbh/D4dhPsKOexTUiiuoC96pEIZIxvw4GGAMLPQdLlQ+VahUVYzxuNVlSHpb2/ey7eyU9tAG+OuCG13ASe6JxR8DfvsDf2mO4etq1ssscVGDAEtN9BDIsgyWQEt5rxqz5G1YLqpLr8rrIdNRF086jbDEUejIQWIG28UGYSWIUGfEfAV7RlkvhXKrA15GY2KFJW0T7n+pIcjuW9NGgYoL68ktkphbCTB9LZJppybU2OpNa/WOVZ1+oA3uY
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <C5AC74BD6C1DAC4E9323108FF5655019@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2240e3d-4294-4acb-8483-08d76785142f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2019 15:29:16.4473 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LxgGw283kuvii2c6nJYMddxlPNKkbbEh0Fg92Q+kSGKYJIlPbeel+f3/EMd2CM6aARlw7ANq267J4sm0HAc0LbD8wWcZb4X5NpqiKr7G0+Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3160
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.135
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
Cc: Tony Krowiak <akrowiak@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

12.11.2019 16:06, Cornelia Huck wrote:
> On Fri, 11 Oct 2019 19:04:09 +0300
> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:
>=20
>> No reason for local_err here, use errp directly instead.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   hw/vfio/ap.c | 16 +++-------------
>>   1 file changed, 3 insertions(+), 13 deletions(-)
>>
>> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
>> index da6a20669d..db816e1860 100644
>> --- a/hw/vfio/ap.c
>> +++ b/hw/vfio/ap.c
>> @@ -87,16 +87,14 @@ static VFIOGroup *vfio_ap_get_group(VFIOAPDevice *va=
pdev, Error **errp)
>>  =20
>>   static void vfio_ap_realize(DeviceState *dev, Error **errp)
>>   {
>> -    int ret;
>>       char *mdevid;
>> -    Error *local_err =3D NULL;
>>       VFIOGroup *vfio_group;
>>       APDevice *apdev =3D AP_DEVICE(dev);
>>       VFIOAPDevice *vapdev =3D VFIO_AP_DEVICE(apdev);
>>  =20
>> -    vfio_group =3D vfio_ap_get_group(vapdev, &local_err);
>> +    vfio_group =3D vfio_ap_get_group(vapdev, errp);
>>       if (!vfio_group) {
>> -        goto out_err;
>> +        return;
>>       }
>>  =20
>>       vapdev->vdev.ops =3D &vfio_ap_ops;
>> @@ -113,18 +111,10 @@ static void vfio_ap_realize(DeviceState *dev, Erro=
r **errp)
>>        */
>>       vapdev->vdev.balloon_allowed =3D true;
>>  =20
>> -    ret =3D vfio_get_device(vfio_group, mdevid, &vapdev->vdev, &local_e=
rr);
>> -    if (ret) {
>> -        goto out_get_dev_err;
>> -    }
>> -
>> -    return;
>> +    vfio_get_device(vfio_group, mdevid, &vapdev->vdev, errp);
>=20
> This looks wrong; you still need to check for the outcome of
> vfio_get_device().

Oops, agree, will fix.


>=20
>>  =20
>> -out_get_dev_err:
>>       vfio_ap_put_device(vapdev);
>>       vfio_put_group(vfio_group);
>> -out_err:
>> -    error_propagate(errp, local_err);
>>   }
>>  =20
>>   static void vfio_ap_unrealize(DeviceState *dev, Error **errp)
>=20


--=20
Best regards,
Vladimir

