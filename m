Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C433BC32771
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 12:39:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D7702075D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 12:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="HoEsW9L5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D7702075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipX5f-0004jR-Nt
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 07:39:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34187)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rkagan@virtuozzo.com>) id 1ipX4u-0004J2-3k
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:38:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rkagan@virtuozzo.com>) id 1ipX4s-0007DC-Mq
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:38:19 -0500
Received: from mail-ve1eur04hn2042.outbound.protection.outlook.com
 ([52.101.139.42]:58434 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
 id 1ipX4s-00073d-1V
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:38:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RDzIsmbm6MjlPq/EJTM3JVIV1qhVvIUrVqn/0V+qw0sco7uN2xq0SpLoemrYfPn467HUnxOq2dLn6CKSizDEy/Vl1SpHJzQ4sa3FaL4wWE7N1abWRI5Tc35Q4UdZLJXPuvZieDZuloNx8d2+qtTbwuFJa8yx5HXNeOytfJZcwckcriMb4fKNabzm0nuY9+x8FUs1W2kObImDb6rPqmtJKypu3ba6lqAdZmY/KnZvXAmGaMSVwz2waDUkM2qcdZwZOiGnMZBm3GZrnsmjtFQtxkUxzwQA7GXsvGnH5GRMlAx27BkNXoqI1EqqdqqICFKRqskXypqQS2cAmV+yZhEHwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OY04DdZbqQkyfOaegVLSfuOBTpI6IiNINXC5ZPvJSKE=;
 b=gZ0/UbequC9pt2pK54AtuAns6Wm7SWL+dti/4SUTVr66RRUa0OY+ZTIOo0MnvK56vNamjk6VTrCL2mDj0Kbx4N5LSRYg44PhzSiI0GG1hUpSDKV1FDFb4VQcLhtqchM+Djyl9adRTdfNELOmY8qATj4Yy40BxYBe87XBW7py8P5S1gUWkEnmczBI6kXzkt0BqiTjDq+FutrItATKrVvlx5ObE26akqUd2USVe4ofaP1esFJ1M+qhq11dWl4eplFD2AT505RkAqSR4CM0Iqr5pZsMR95bbGNQsAkRKBwcShCSHsKueb+lQCXnp6c7LpMszqNJTJ+cKbGIir0eF/OctA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OY04DdZbqQkyfOaegVLSfuOBTpI6IiNINXC5ZPvJSKE=;
 b=HoEsW9L5SNnnZlOPAujoVCvXtnwDK2kLDCzVcutrjAin+7oR6aBH6ldksQJ4833D8L3bCDH3SGu1OZuN5WOJ454UWTHOgPkvYxpC8S74IgZxcbjo4JOdRpPItthbFh3+YQNqDHdJTkW8gs7dc1tIlhZUeHyySlUWyuco+jbDSPk=
Received: from VI1PR08MB4608.eurprd08.prod.outlook.com (20.178.80.22) by
 VI1PR08MB4285.eurprd08.prod.outlook.com (20.179.26.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Thu, 9 Jan 2020 12:38:07 +0000
Received: from VI1PR08MB4608.eurprd08.prod.outlook.com
 ([fe80::acb0:a61d:f08a:1c12]) by VI1PR08MB4608.eurprd08.prod.outlook.com
 ([fe80::acb0:a61d:f08a:1c12%7]) with mapi id 15.20.2602.018; Thu, 9 Jan 2020
 12:38:07 +0000
Received: from rkaganb.sw.ru (185.231.240.5) by
 HE1PR0202CA0012.eurprd02.prod.outlook.com (2603:10a6:3:8c::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9 via Frontend Transport; Thu, 9 Jan 2020 12:38:06 +0000
From: Roman Kagan <rkagan@virtuozzo.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: Re: [PATCH 1/2] vhost: Don't pass ram device sections
Thread-Topic: [PATCH 1/2] vhost: Don't pass ram device sections
Thread-Index: AQHVxis3tBYOS6DQvEWgJ8SABOU/mqfiRu8A
Date: Thu, 9 Jan 2020 12:38:07 +0000
Message-ID: <20200109123804.GB3147@rkaganb.sw.ru>
References: <20200108135353.75471-1-dgilbert@redhat.com>
 <20200108135353.75471-2-dgilbert@redhat.com>
In-Reply-To: <20200108135353.75471-2-dgilbert@redhat.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
mail-followup-to: Roman Kagan <rkagan@virtuozzo.com>, "Dr. David Alan Gilbert
 (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
 vkuznets@redhat.com, mst@redhat.com,	jasowang@redhat.com
x-originating-ip: [185.231.240.5]
x-clientproxiedby: HE1PR0202CA0012.eurprd02.prod.outlook.com
 (2603:10a6:3:8c::22) To VI1PR08MB4608.eurprd08.prod.outlook.com
 (2603:10a6:803:c0::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e1aa39b9-0634-4960-befc-08d79500c76f
x-ms-traffictypediagnostic: VI1PR08MB4285:|VI1PR08MB4285:|VI1PR08MB4285:
x-microsoft-antispam-prvs: <VI1PR08MB428531374291E2AD0CF668B6C9390@VI1PR08MB4285.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:246;
x-forefront-prvs: 02778BF158
x-forefront-antispam-report: SFV:SPM;
 SFS:(10019020)(396003)(39840400004)(366004)(136003)(346002)(376002)(199004)(189003)(33656002)(2906002)(86362001)(316002)(956004)(26005)(66476007)(66446008)(64756008)(81166006)(9686003)(186003)(66556008)(66946007)(5660300002)(54906003)(1076003)(8936002)(55016002)(16526019)(8676002)(4326008)(6916009)(7696005)(81156014)(52116002)(36756003)(6506007)(478600001)(71200400001)(30126003);
 DIR:OUT; SFP:1501; SCL:5; SRVR:VI1PR08MB4285;
 H:VI1PR08MB4608.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; CAT:OSPM; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KNlki1GkHrhpTg4hzw9Df2EMnzz8bdwTYogxg9CQfDX7odYgc4ZvPjVFxKN2gA6S6yyyfzfU5rCR1pNfGJxTjhnE1i9BKqnjYVNEQxbr7rH6mCCNYheElBG+2WcUdaheayCenYhQbFFlGnivD0Zq8LX9HHQS2sxGvmfNr0JsfdbEBDa02uV5mJehdz5aI9VsEAxR0znQ0VjUrY7fPFdYkJ8/eW7srL4/BeRPWoix6CwQ0a4nhOr35Q2HI5MZTZOfSQnnfCVUtHHiYjQupWXCc77G1+QD9FQM7I+GLCNncSJuXyaQhhD8ZPJkDcM4sQbv1G71CNm8+cNTVUi67M6n480+Kjy8DU20pdC4qZ/XhzrRJw7wtEFHEKvRlA2vC6Tc8nPPRVtetqdsTuaP++KeIS+5g12Fx1x9QOgKJ2yygu1QsMfqtAdkyiF1vzL4VEEVWq3kF5NSO0kKHfCpL2z8YojAYaL+FvwpdeFsQYgrjDkD9ZJjaFSwQMXpSqHD9o4x48ywkRTJIq8wiClPtkkmX2vfN5SW/K9x6dWmJknynxEkr2qKcfhe3ZpVph82rm1GbxUOBNjFR4ASsTu70tvyPj1t0Hqov/7adF0DY7Dd0fFtgKXr5faVFdNlXhQWO5XydzsqbLAx2ErnGehtO1Y7EE2B/rWbmieaoRLhQgQcV1nAXzvCUL/SR7l4073T0RVAtnsnOwRISUV+VtwsfpPbFJgz8EjYhZ55pr/UQqi4Qs4Oa+NG+m1fMDFybdlJTntxiGbjf4om+/MuaHA3w+OwhA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AD47C658D6C00F4483C95DCF3AEFD287@eurprd08.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1aa39b9-0634-4960-befc-08d79500c76f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2020 12:38:07.6391 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0PxqwcJI/mikDRedkZxj0K4zo34fBBqEPZNJDwz6BoLkSlk6/SoQWCG5wvhUsEoGTnMox2wPhkoKmuNzCaOwgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4285
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

On Wed, Jan 08, 2020 at 01:53:52PM +0000, Dr. David Alan Gilbert (git) wrote:
> Don't pass RAM blocks that are marked as ram devices to vhost.
> There's normally something special about them and they're not
> normally just shared memory.

Does this something special about them, whatever it is, make them
automatically ineligible for DMA?  Why should vhost ignore them?

/me goes reading what ram_device memory regions are...

Roman.

> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  hw/virtio/vhost.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 4da0d5a6c5..c81f0be71b 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -402,6 +402,7 @@ static bool vhost_section(struct vhost_dev *dev, MemoryRegionSection *section)
>      bool log_dirty = memory_region_get_dirty_log_mask(section->mr) &
>                       ~(1 << DIRTY_MEMORY_MIGRATION);
>      result = memory_region_is_ram(section->mr) &&
> +        !memory_region_is_ram_device(section->mr) &&
>          !memory_region_is_rom(section->mr);
>  
>      /* Vhost doesn't handle any block which is doing dirty-tracking other
> -- 
> 2.24.1
> 
> 

