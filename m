Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE75EC282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 13:13:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 794E32072A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 13:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="dISMdcGX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 794E32072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60169 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipXcq-0002Rg-6q
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 08:13:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50943)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rkagan@virtuozzo.com>) id 1ipXTo-0007Dg-S0
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 08:04:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rkagan@virtuozzo.com>) id 1ipXTn-0005O0-BH
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 08:04:04 -0500
Received: from mail-ve1eur04hn2042.outbound.protection.outlook.com
 ([52.101.139.42]:45126 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
 id 1ipXTm-0005Gy-Mh
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 08:04:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WUEj2c7gcHbaX9OkSEec17KenCSJvAe7pOg079oN59NIgn7iK+zC1Y6/qbjXUcE6IAKQHw/WnQ8do24tv+DesAyBnN/5AdAxViRfPs3TExpDuSQIe0k0fQr8jpAzbUjKNtrQBTxbBi4Gzzs8SDf7GTQP4ZSfPmyDOxa5FMArNVF6X3xKgLTNljuifQESs7jK9EZhtPYXs3BIQNIwh/TRnP49bjiS3iXPgZ2XKdW1MOK28Ff7nxY5ya0xaB38TsCY+c/Y/DJE0dYJInOgXMlTbRikwIQpTKq/NPAlAX4DLhEaK2hivhYYCZ3KxITyBTqdFvudZUp8STKzN1MtcOEvaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+9IvMKyxqppI58OExwY+Nat7uxQmB1yvFSk3C9m4QkM=;
 b=ad7qm7Qid6n0W5HIN8D3I3GUq8b5jqC7Qf10QOOBxdTTXdKNWCTjL1veml2LA3/l3rRbTLfBfQEJJSFK3/aNT0CUkw03bCv5eUXTco1BVap/QJFyZwWe9o53iF8sBQb1BhlYWWvt+QJmpLlFVrAwwIFJocBtX4U8xi2izqSU/Rxjz+SdanMQ2Kzhiaki4YaG/kYAj1p/j0I+xeW9tFBz6r/bvJr0P4yuohj/oP1yPLQ4pXtjZROQgsGoEiMo5BURCijNI2etyDW9BjpFSRtTDmcetVaQYbO+NhfBVIcvQCu7hntrJBDMF6LrGxyLZR7/tRWUkaPiF1Nk3TuR3fysjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+9IvMKyxqppI58OExwY+Nat7uxQmB1yvFSk3C9m4QkM=;
 b=dISMdcGXtZDQP03wWr9Bml1MSrtLELl3Ape4Kky+nHMeYHCyjG0c/Cr92B+SJT36uIRy6b3yyc8yIrtH/3p8RQMv8Ny7DoYpHsJBLy/S+emdrAYipXOG8F3b5TPubpQetEZr5fYWurQcHxUn+DVHoQNODI9SPPvBTe/BTCXtv24=
Received: from VI1PR08MB4608.eurprd08.prod.outlook.com (20.178.80.22) by
 VI1PR08MB4000.eurprd08.prod.outlook.com (20.178.125.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Thu, 9 Jan 2020 13:03:52 +0000
Received: from VI1PR08MB4608.eurprd08.prod.outlook.com
 ([fe80::acb0:a61d:f08a:1c12]) by VI1PR08MB4608.eurprd08.prod.outlook.com
 ([fe80::acb0:a61d:f08a:1c12%7]) with mapi id 15.20.2602.018; Thu, 9 Jan 2020
 13:03:52 +0000
Received: from rkaganb.sw.ru (185.231.240.5) by
 HE1PR07CA0047.eurprd07.prod.outlook.com (2603:10a6:7:66::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.5 via Frontend Transport; Thu, 9 Jan 2020 13:03:51 +0000
From: Roman Kagan <rkagan@virtuozzo.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: Re: [PATCH 2/2] hyperv/synic: Allocate as ram_device
Thread-Topic: [PATCH 2/2] hyperv/synic: Allocate as ram_device
Thread-Index: AQHVxityEM59bZyv8EecProoJvSi/6fiTh8A
Date: Thu, 9 Jan 2020 13:03:52 +0000
Message-ID: <20200109130348.GC3147@rkaganb.sw.ru>
References: <20200108135353.75471-1-dgilbert@redhat.com>
 <20200108135353.75471-3-dgilbert@redhat.com>
In-Reply-To: <20200108135353.75471-3-dgilbert@redhat.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
mail-followup-to: Roman Kagan <rkagan@virtuozzo.com>, "Dr. David Alan Gilbert
 (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
 vkuznets@redhat.com, mst@redhat.com,	jasowang@redhat.com
x-originating-ip: [185.231.240.5]
x-clientproxiedby: HE1PR07CA0047.eurprd07.prod.outlook.com
 (2603:10a6:7:66::33) To VI1PR08MB4608.eurprd08.prod.outlook.com
 (2603:10a6:803:c0::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c6fda76b-418f-4872-8380-08d795046005
x-ms-traffictypediagnostic: VI1PR08MB4000:|VI1PR08MB4000:|VI1PR08MB4000:
x-microsoft-antispam-prvs: <VI1PR08MB4000F9D04DB4E8A7F3CE0E95C9390@VI1PR08MB4000.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 02778BF158
x-forefront-antispam-report: SFV:SPM;
 SFS:(10019020)(39840400004)(396003)(376002)(366004)(346002)(136003)(199004)(189003)(52116002)(7696005)(55016002)(54906003)(316002)(81166006)(81156014)(33656002)(2906002)(1076003)(5660300002)(4326008)(86362001)(71200400001)(36756003)(6506007)(186003)(16526019)(26005)(8676002)(66946007)(8936002)(64756008)(66476007)(66556008)(66446008)(6916009)(956004)(9686003)(478600001)(30126003);
 DIR:OUT; SFP:1501; SCL:5; SRVR:VI1PR08MB4000;
 H:VI1PR08MB4608.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; CAT:OSPM; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kW1UDNPl2er95LMmYrC0scmre4oPUHiaN7kc08wJXu6FZUop4m3blBGOjXmbo7zWfJjJZOtyn5mBYn9isjK+dx79seU6WlaAFUuNiRoBKOHTEBrbE7/j10nMypkhL9cW39BfF2Y55KytFosL5/OK2nlNpDKv0kQ+XpFiTZPoIAVP6dZg9M9Ay9iMDPeIkhaE/7d7KCr1Q4bVLv9aoRmNabgIsdXXACcLRty/fW7u2ioNVtL50R9jBBSjGso53u8F4o8h6BN7geXqX7Y0A/M27gwGahZPU13Vzrl++pNRJZmf+evdfZaKEFOe15UvyuJ8BZAfafg0RfBmg4frpHSpbBbzcAN2QmWhZZMgx2IvaF94c0OXyj1ckBmJI+ECrpUga3cQBa1XJbOoDf0hHDV9lmEuE6OYm112rdgcufw5nVT9N73WJohEsd97l5dDcgZJUroHHvqwpwQtKSpgCMwvYYh5ynARlrViQC0VXmE9HauHS2EIRXKf+5soiz+KIpeCL5BvsPYQ2RXntW5IFhXbtCHt304E0QF55YupQvzn6PWKQ7fm0xyYIKgp/LSGkR5nO2Ni5wOlBMdYr0cqvS/f3Vsnp2INdSJh+M/xX1dp9tkQFT5T5dmaefK92xJOwPdE0leKjyxo0+1mWNpbdQyeTWKpDfhXgZt5k53oeMkE0SiYFLMOK26jq/DXfpP6dIB0NDGhLpsB70jvBFUvQQzat6lQfGxDCD+WutCcbF7yZWxFSedPBK32ISkpbe6E5GTNMGE2AmpyxlLK0bdlYoDh7Q==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8D201965007F074E8AA1622DA8B7ADAB@eurprd08.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6fda76b-418f-4872-8380-08d795046005
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2020 13:03:52.1295 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eO9i8l/9R4e4WnhWvWhHo3qCejEMmmZQixq66q1y72orf3fcdsCPIKccKOpLmaUmuNJJf/EuTXw0nftcY4sLgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4000
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 52.101.139.42
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
Cc: "jasowang@redhat.com" <jasowang@redhat.com>,
 "vkuznets@redhat.com" <vkuznets@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jan 08, 2020 at 01:53:53PM +0000, Dr. David Alan Gilbert (git) wrote:
> Mark the synic pages as ram_device so that they won't be visible
> to vhost.

Unless I'm misreading the code this also makes them invisible to
migration.

I need some more reading on the ram_device region behavior to better
understand other potential consequences.

Thanks,
Roman.

> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  hw/hyperv/hyperv.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
> index da8ce82725..4de3ec411d 100644
> --- a/hw/hyperv/hyperv.c
> +++ b/hw/hyperv/hyperv.c
> @@ -95,12 +95,14 @@ static void synic_realize(DeviceState *dev, Error **errp)
>      msgp_name = g_strdup_printf("synic-%u-msg-page", vp_index);
>      eventp_name = g_strdup_printf("synic-%u-event-page", vp_index);
>  
> -    memory_region_init_ram(&synic->msg_page_mr, obj, msgp_name,
> -                           sizeof(*synic->msg_page), &error_abort);
> -    memory_region_init_ram(&synic->event_page_mr, obj, eventp_name,
> -                           sizeof(*synic->event_page), &error_abort);
> -    synic->msg_page = memory_region_get_ram_ptr(&synic->msg_page_mr);
> -    synic->event_page = memory_region_get_ram_ptr(&synic->event_page_mr);
> +    synic->msg_page = qemu_memalign(qemu_real_host_page_size,
> +                                    sizeof(*synic->msg_page));
> +    synic->event_page = qemu_memalign(qemu_real_host_page_size,
> +                                      sizeof(*synic->event_page));
> +    memory_region_init_ram_device_ptr(&synic->msg_page_mr, obj, msgp_name,
> +                           sizeof(*synic->msg_page), synic->msg_page);
> +    memory_region_init_ram_device_ptr(&synic->event_page_mr, obj, eventp_name,
> +                           sizeof(*synic->event_page), synic->event_page);
>  
>      g_free(msgp_name);
>      g_free(eventp_name);
> -- 
> 2.24.1
> 
> 

