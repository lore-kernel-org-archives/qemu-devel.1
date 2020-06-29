Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C41C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 07:55:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11BC6206A1
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 07:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="XG0Xt4S6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11BC6206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpodt-0001lq-9n
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 03:55:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43460)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jpodH-0001H5-Ud; Mon, 29 Jun 2020 03:55:15 -0400
Received: from mail-db8eur05on2093.outbound.protection.outlook.com
 ([40.107.20.93]:36688 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jpodE-00070Z-Km; Mon, 29 Jun 2020 03:55:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QkvyLKEsZX+Hx85uUvM3CdxHCf78yF5sbQLRT1KDFQ3dnIygIa5PfYQHXMFmTgnRZKg0+Nd7EDesA7yzsW5sf2U6epUeDMkW/QgkytYumMj7x3WMVlbu+ips/jQHFLNa2QVtD6bxO+Zvqa2nc4cz2jK0ffZKvBMwAI6lXedxndxmIHPIRx0ano0ox2Rk2jLOCSI2Irx++823ocX2Jv2JwpFl95WUjp08LPAbHVI0PdCekJ2labhIneAi+O/nLJ5tYnagjnFqJzMmYCIarAil9y6N/PUIQa8uTErtAeqmO9DW5+3ubHA9WjLzSIorfQZnglJ2Cu7xsrRj3YRolgx7Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qY0K+TQnstmVnxE9fL+9XBQOx5hMx11WVNCDiX0d6lU=;
 b=SKiNJNAFNpsjNIQamyAIDXzEw0dX9V1OgZd2ccJjQDZd63mxeEsJOGOSKlRm+wuCsAhDxvo2jh7eYUH4zyfuWy5+K0GDyEh7FndY0AO0ahKdV0yXfd0I1DmA+dj9gjP0s8RAKChcVZERa1VdovXX/zXKWvyM/n03xMrSju/zHDJpzcwXR9fiPBE8t56j43dZ45+NbO9GnP0it1vZpFrYPM65K0G5hROrNmOWijizQmOXpHL7a9tfmw999tw6E3YHWGVoi88pEqRnP0Q8R08o5OCZ1R+O87ZqdRX1eTv4xxq7d/oJOxCvdULkcdmIsCv0sGyq7pKN3px8oZFaH4mspA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qY0K+TQnstmVnxE9fL+9XBQOx5hMx11WVNCDiX0d6lU=;
 b=XG0Xt4S6DorlCFmG4lDg9Tv+b2MtGLThJfM+uU9v+LM44F5AQIqjbRHAanYOhNGQEo3jW2O0TsVGGc+M9Z+W9CrTowuou6jyAmxswjA42ztzufmF+ujQizr7Oy8DeJFSec5GiQyN4JdaP8xlxc5HauNpAbACYmiWb29wdMqZjWE=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4949.eurprd08.prod.outlook.com (2603:10a6:20b:ee::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Mon, 29 Jun
 2020 07:55:08 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3131.026; Mon, 29 Jun 2020
 07:55:08 +0000
Subject: Re: [PATCH 3/4] nbd: make client_close synchronous
To: qemu-block@nongnu.org
References: <20200625142540.24589-1-vsementsov@virtuozzo.com>
 <20200625142540.24589-4-vsementsov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <6f10f2d1-49f3-edff-eff6-0a2f97c07ebc@virtuozzo.com>
Date: Mon, 29 Jun 2020 10:55:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <20200625142540.24589-4-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR08CA0009.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::22) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.28) by
 AM0PR08CA0009.eurprd08.prod.outlook.com (2603:10a6:208:d2::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.23 via Frontend Transport; Mon, 29 Jun 2020 07:55:07 +0000
X-Originating-IP: [185.215.60.28]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7db0cad8-25cd-4afa-d463-08d81c01bdf0
X-MS-TrafficTypeDiagnostic: AM6PR08MB4949:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4949850BB34EA898DB4A6C22C16E0@AM6PR08MB4949.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 044968D9E1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ClAV6tZPenP/Zys0vOxdPWO1AZ3D5428GZ3OycQI/L6a3EgQS6P635VxOcowzxLkIoVwxeHlq+It5kPQjIh+gCpxIUo1n8541QgirhjnigHcykrRrhTAyR1yaGQzldLN1a8UmTzKammulKvBn+SS0hePVa3SRu9KbDBJ5K6+Gm1vJuegWAPEFzHaBTglv71uKNtkeloGNkcCPMwSOOPEw37i7Gr6kGzl0TX3BDuwkDQyO3pIphbxGnKDLs4cwkbzlp4kPpG+/iLaXKXdwqL4Kg90NqPwggP+iLxNLcpZHDAylQyRCnsci5bh3DlDvNImDGAf69YLXYCKb5D5Gg6cxfHSOd5CpCcpGM7KvkMYnW8YgRHNQZkH/TCTBy5y/RvM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39830400003)(366004)(346002)(396003)(376002)(136003)(8936002)(8676002)(316002)(16576012)(5660300002)(31686004)(478600001)(31696002)(6916009)(86362001)(66946007)(36756003)(4326008)(52116002)(66476007)(186003)(2616005)(956004)(16526019)(6486002)(26005)(83380400001)(2906002)(66556008)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: L63I4+YhE1GDawbnVYQrKtDBtRghEK2skW+g3sL/xvH/o2AZ2+NvMcoVnc4RaXPomzHIbl7yE3bRYM50aSBG5A7sPEUNLUszrj1Ww2Qs2tuT5bqq3Us7KchX3+3fFkcz8Zv0Ci1S2sZBo14rlOQTqvFXEa7Ocrwzfs2hUOOCtTF5X17ns2IvIleFBQnOBM3Wl/TMdXRHKfB9+WLPtDLJGXiC8bci5vpfmrA2e7v734qbve9S5ogWAfOK6OalGvwIhFGMQqNR4nRvs6cwpnTc4mldrumB04FwfoVezGNcpM9D9fmndM5NiY/Sf8VxFKY7eJdiPtl3qb4+jyWkYH661K1W+70QA4jUVRAd+8aICddt3H3ooLA7GmzwnjrJDarTZPBqlwLmlkohr4isVNmun7xMdStxJE1Nr4wud7qiOI7hnWoTQWDolStGC2jENmZjDCfYRQfkkcYJq6ACDLRAkNhKwpxiJuC3akbWuZ0vDqs=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7db0cad8-25cd-4afa-d463-08d81c01bdf0
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2020 07:55:08.2068 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /73DjVopSUFIfMaP1/y6prf0awPYoQ4/zDMVvaypK0HhALHIFgA51tAVctP7cWR9pH5GzIR0A8DaJzIh+81cHgUaxyeXhU0bPtOYz1n2hAU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4949
Received-SPF: pass client-ip=40.107.20.93;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 03:55:09
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

25.06.2020 17:25, Vladimir Sementsov-Ogievskiy wrote:
> client_close doesn't guarantee that client is closed: nbd_trip() keeps
> reference to it. Let's wait for nbd_trip to finish.
> 
> Without this fix, the following crash is possible:
> 
> - export bitmap through unternal Qemu NBD server
> - connect a client
> - shutdown Qemu
> 
> On shutdown nbd_export_close_all is called, but it actually don't wait
> for nbd_trip() to finish and to release its references. So, export is
> not release, and exported bitmap remains busy, and on try to remove the
> bitmap (which is part of bdrv_close()) the assertion fairs:
> 
> bdrv_release_dirty_bitmap_locked: Assertion `!bdrv_dirty_bitmap_busy(bitmap)' failed
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   nbd/server.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/nbd/server.c b/nbd/server.c
> index 20754e9ebc..5e27a8d31a 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -1419,6 +1419,8 @@ static void client_close(NBDClient *client, bool negotiated)
>       qio_channel_shutdown(client->ioc, QIO_CHANNEL_SHUTDOWN_BOTH,
>                            NULL);
>   
> +    AIO_WAIT_WHILE(client->exp->ctx, client->recv_coroutine);
> +
>       /* Also tell the client, so that they release their reference.  */
>       if (client->close_fn) {
>           client->close_fn(client, negotiated);
> @@ -2450,6 +2452,7 @@ static coroutine_fn void nbd_trip(void *opaque)
>   
>       trace_nbd_trip();
>       if (client->closing) {
> +        client->recv_coroutine = NULL;
>           nbd_client_put(client);
>           return;
>       }
> 

I have a doubt, isn't it possible to hang in AIO_WAIT_WHILE() after this patch?

Do we need aio_wait_kick() in the nbd_trip()? Or may be, something like
aio_wait_kick(), but to wake exactly client->exp->ctx aio context?

Also, why in block/io.c we kick the main context, but not bs->aio_context?


-- 
Best regards,
Vladimir

