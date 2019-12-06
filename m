Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D63C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 14:48:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3083221835
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 14:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="UnaDy/OF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3083221835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idEuB-0000ap-Sy
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 09:48:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35940)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1idEPE-0002NX-Gd
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:16:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1idEPA-0002pB-5h
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:16:28 -0500
Received: from mail-eopbgr00130.outbound.protection.outlook.com
 ([40.107.0.130]:22030 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1idEP9-0002go-La
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:16:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i5gNS/FdYMQOOdYKh+Ad1Yze11IMGXbev4emfsNNBH05hUUFkuDNFIZfzczf1tQ0dwQlJP3OmmRTvgGILB273hRR3L15mEx+a+KznN1InBfQknqYGFilrFjAwSEya7lg6ZZB90JxDxE2Gjf99YPo5/MarE2jzl+v2SxzcSXKH4UjKRcHJeGHz2YBcgkwJDZjNpr/BWMTP4gNUaeYslN0eHb+jWbi7qi/bt8IUUFpoD9Ba3n9VVErNOQh5d1CRPIAuIzdhMVOitn/kIxT0+6i0LOLUTgYQ0s9Xt8Z+jRsHIMz6ZGE2oZpDTmcO9vErRBdfSOZFnCdN6nOSucVh4tzZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=clXaqhcVHZQnBbwsgQLGXId9GTgDgZWn4WGeZWV6xtU=;
 b=Bpb6h7tuvWoqGY0RgLVXVppjEJOQNMsWwhKhHfckDpOtqn9NvEFJEB8EvuOx4e7fjVWus0oIUTlI5w5Zp/s3IbU2fiCxtJwTY9MvRng6uqcMOZOrI9IPdV3YWZ5EwUPnqglyUf7mOvu83gvbv4kBZJTykFc7XsXqCAB3ztg+OY7adwDt7aKULVDyNZAdhzBJv2WoKB0mjE+CXncc+Hb71Fd7DrU/m8rPKAa1UpophE9L0f5EthZjFcmkypOlDO2jkrQU1n551//WkiZmlavtc7VcjV4UIY1rkS2arB/ixm4HM3JW2lXaWwmT84FRjyMBGJl+KHTl0mDdmDTvD/sEPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=clXaqhcVHZQnBbwsgQLGXId9GTgDgZWn4WGeZWV6xtU=;
 b=UnaDy/OFMF3ZY1tqwXj6d9+WPOy1KTOQ8jQyuntXvXGlFEJwP4NKvmT8pNy1PQoKZar01iWknn/QHzu7nX6S0EhMhs7saPl1F7hQdwyoOG6YC26qJTmkNss2p9CJgfa9fQ0/xLwCwK6gwJJ8p0FRK1Z8y8o6g94VupWLSBqOoGE=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3062.eurprd08.prod.outlook.com (52.135.163.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Fri, 6 Dec 2019 10:19:56 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2516.014; Fri, 6 Dec 2019
 10:19:56 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: =?Windows-1252?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v8 17/21] hw/usb: rename Error ** parameter to more common
 errp
Thread-Topic: [PATCH v8 17/21] hw/usb: rename Error ** parameter to more
 common errp
Thread-Index: AQHVq5P3aqHGuP8oMkWDyhGK8l+ud6esuS4AgAAtEIA=
Date: Fri, 6 Dec 2019 10:19:55 +0000
Message-ID: <20fc2e09-85fe-daf1-9898-f0b76870fb2f@virtuozzo.com>
References: <20191205174635.18758-1-vsementsov@virtuozzo.com>
 <20191205174635.18758-18-vsementsov@virtuozzo.com>
 <1407847e-1e1d-9ecb-a522-103a09179f02@redhat.com>
In-Reply-To: <1407847e-1e1d-9ecb-a522-103a09179f02@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR08CA0056.eurprd08.prod.outlook.com
 (2603:10a6:7:2a::27) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191206131953684
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c442c447-15b9-4bef-c599-08d77a35d6ea
x-ms-traffictypediagnostic: AM6PR08MB3062:
x-microsoft-antispam-prvs: <AM6PR08MB30629DAA49061A957F7466D3C15F0@AM6PR08MB3062.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-forefront-prvs: 0243E5FD68
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(136003)(346002)(396003)(39850400004)(376002)(189003)(199004)(66946007)(66476007)(102836004)(26005)(11346002)(6506007)(66556008)(53546011)(66446008)(76176011)(52116002)(110136005)(54906003)(478600001)(31686004)(99286004)(2616005)(14444005)(316002)(5660300002)(4744005)(14454004)(186003)(64756008)(305945005)(36756003)(31696002)(2906002)(6486002)(229853002)(71190400001)(8676002)(4326008)(71200400001)(6512007)(81166006)(86362001)(81156014)(8936002)(25786009);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3062;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XB1tII+3BToEvgL9GiOCGM4m1rmkUSareKewRQH3/4fXZwyVTdAOR0YrRvZ/dU3S7e7ZxTPseSQe1rJDfwzo7K3MBJPX86fRncmQrQtWMdomkacSHWhiP/ARUOGcpeUpFbczJVd+Ohc+Gq/IjcIGqV4tUabDtdzRNBVs4zxyCEX4axhNRThzjdywgzgjgFCjYQ6cx0WP9MHBBcEWDF+zgMJHOp7dkPriDn3LrZGi3DYMCyjPL2r5aHWIIYMCjzV42AjmvE4AbluHY1dFQBtiMW2Gvkfgx0J1YHPn7ETsFQ7b7yVuGcqlhsgUuFtY7qWn7MDF+pjuJ0Ou+34QMNk7/S+OBo58EuEdAsohJf3CI4TcxqN6pcEtR+miaqMTqhShWcuY2IFfH4ucXWLyn8HKJe0sPe7P0JugcMGKa0ezw4FRaN0jPb4bIiLRndOIZ8s0
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <9BCED7AF04A6024CBD6DED31361840A0@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c442c447-15b9-4bef-c599-08d77a35d6ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2019 10:19:55.9746 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kj5VjqdDTfB2QtEBeTy0EYmFdVP/kUbpWsh7SKWnMs1A6H1sSqQIAS4u8xdG1nWWXXjAPdrjbiIfsitgxBpOckXYdHx6dwWkvrZ7DzyBJSE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3062
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.0.130
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
Cc: "armbru@redhat.com" <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

06.12.2019 10:38, Philippe Mathieu-Daud=E9 wrote:
> On 12/5/19 6:46 PM, Vladimir Sementsov-Ogievskiy wrote:
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>> =A0 hw/usb/dev-network.c | 2 +-
>> =A0 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/usb/dev-network.c b/hw/usb/dev-network.c
>> index 5de6213cc4..b81a8abe83 100644
>> --- a/hw/usb/dev-network.c
>> +++ b/hw/usb/dev-network.c
>> @@ -1342,7 +1342,7 @@ static NetClientInfo net_usbnet_info =3D {
>> =A0=A0=A0=A0=A0 .cleanup =3D usbnet_cleanup,
>> =A0 };
>> -static void usb_net_realize(USBDevice *dev, Error **errrp)
>=20
> Funny one.
>=20
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
>=20

Thanks a lot for reviewing!


--=20
Best regards,
Vladimir

