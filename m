Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24ABC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 09:41:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CBC1204EC
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 09:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="WOg3ncK/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CBC1204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jixEC-0004mq-RH
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 05:41:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50684)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jixD4-0003hS-JM; Wed, 10 Jun 2020 05:39:50 -0400
Received: from mail-eopbgr40110.outbound.protection.outlook.com
 ([40.107.4.110]:53383 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jixD1-0001JE-OW; Wed, 10 Jun 2020 05:39:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nICwwC6K6oTSVdgp6A1TYnRbj4h87xcSm+bFUt85fyGtSRsbpkxYn2ZH7/8hAy0JGIJRLH/D2Rh27ccpvGkUKvOlzAKrGWgXshwLr5eNAC2VThnAc9bGTC6tG5JAG3b0DBHhU/BGDspKTNh+bCL13yDGglSu024AUZgyMQ6/GG2pRrARVCwGl1CTInNY5Yh01uIFTLe4abGfhJni4yQkeo4tHnueLTnCPBqg3xK/s8X9bcJ+JMvAX4l2WNdk+Xi0+Sr6EWM1yO6hi0TiHhHjoUgkRE7DVr5lF7n0bd2DA7eGByTYD24dYWxwMoyiIIirTgurHS/xJoVe16jPJDeFRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62chBF+UGv0Xbf0DkaYDaWnROOMelVuszbZBqlHk8Iw=;
 b=FTQvYfi5VmsL1mOYWtkAGCePAFei70X3xfyYlFnCfSqQo5wb+U0pDF5bR7YX1SNFdpTqyRXzWxqWA5elq9cOAhBYYDq9oVL69Q13QsV+tfu2jC6hTyTZGsWbWSeim8alrgpW6njFNBTG3J3fgYKmSN6/LLs9taZwzaxU4u7c1s5uc19yDdriwXBj9IipdHaNlbkYR9VTaWqZsI2m21Q+6n2azJmT8SS+cGmetaGEzJgc79slKunfh2Fvjl137YqemXVPKv99pt+XYnP7iSpJ7i4obAYbw790/q5BkcIMd/51Ni01BV3XOm6rupWU7T9Y/4aHdE9pDyv4OvyVzrV4PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62chBF+UGv0Xbf0DkaYDaWnROOMelVuszbZBqlHk8Iw=;
 b=WOg3ncK/lSqLWMUQFkTXFCuqM2rDmKCNfKnpc9VxuclSbAoml49b+HBYLTeteFdJIlxrwic/DAy5NtG3oY/rhnccBwtL8L/bWD+J7EYT6R7IyfDFwugTz0xKXgbMETbZkUFY5wVZGuo2mVaR7hW2jHCy6/NcyzDT7KCI8CAWRzk=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5464.eurprd08.prod.outlook.com (2603:10a6:20b:10a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.19; Wed, 10 Jun
 2020 09:24:40 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.023; Wed, 10 Jun 2020
 09:24:40 +0000
Subject: Re: [PATCH 2/2] block: Call attention to truncation of long NBD
 exports
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200608182638.3256473-1-eblake@redhat.com>
 <20200608182638.3256473-3-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <5430f8e5-8f28-d703-1b55-136e2296ec72@virtuozzo.com>
Date: Wed, 10 Jun 2020 12:24:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <20200608182638.3256473-3-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR07CA0104.eurprd07.prod.outlook.com
 (2603:10a6:207:7::14) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.166) by
 AM3PR07CA0104.eurprd07.prod.outlook.com (2603:10a6:207:7::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.7 via Frontend Transport; Wed, 10 Jun 2020 09:24:39 +0000
X-Originating-IP: [185.215.60.166]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28c0d7f1-ca6c-483c-36d6-08d80d2019fa
X-MS-TrafficTypeDiagnostic: AM7PR08MB5464:
X-Microsoft-Antispam-PRVS: <AM7PR08MB54646013E0A0A9C7ED7AC8C8C1830@AM7PR08MB5464.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 0430FA5CB7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QAvFGG94DObL9wPXXHK5PkIdS4gF6OHmsJ4MrptqS0eCy633Gl9QZsI4Uo/wXy1UIsp0IvkMhNFysfFYb0LO8RCYWPB7x4yB4Ae+G0AXHHD8YCs+1fsY/TnSXWvGaDkS3oa+kMWcWtLoieOw8FMb8CYLEnehmV2HHxeqRR68/6HgMPPK+7r2Vl3VIRh/UrwVZ/fuV8E14BE+ykTPb1rsYull0a39UmA3gKYOFRk4QQgq9yJjnFDKWRjVsBftnEKuffYQUvuqwr+X67xpE2pIjv6iWFL5XFWh7JjyQmEMn8NwlFMLVApneaVzAbBEVdJDGjzQF/sj3JRmy3VK5o0wMhnXMboY0E9v04nJ+wWgO82dXVrgJTOZkLXFPSLnu/282yVv06KfM2kqMn6M9Vb7iLhA2G2Txt8OnmJIV09xeYtAVBImtZrNVJwXOqaBTfE38KTOw5EQdId/TWlmmB+Ck7i6jsIOBmHEXiGg+yc1ArpimwoaIduJmdkugmgXK0hf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(396003)(39850400004)(136003)(366004)(316002)(8676002)(54906003)(26005)(8936002)(31696002)(83380400001)(31686004)(16576012)(16526019)(86362001)(4326008)(2906002)(52116002)(956004)(6486002)(966005)(36756003)(478600001)(66476007)(66556008)(186003)(2616005)(5660300002)(66946007)(43740500002)(33290500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: xeBqknp9eCYiFECZTtwyYpow/JOXhruktOLU2FjoFTrA6nHUVNK4pB+suN/bbieVJ5ybtonrfh8ZPkPYAm7FfFI87Rmhzx4Zmjkzwb57Dm+XLqJHy6f7WjmV8Jewm7QF26DCuWk/hERzfzLbBI+8QXlXESjazC7fs/MxVWotuc05ovjNM+frnk9wdgKPw96lhjuDcmG2A0zY+o4gZ0gbW2c6FHu1iCMH/v+JRIzslVdPq+qDbSOskt34OpP25kmhZOFXk9N1yDa0J/QyKiAPe0ZtzhEeGeQ4bKiBkkcx8YYVY0M2bC/vjUfr6hPk8YDZgxz2alhE9df932mZ3pwdt5KZk2LEoeE4mRfygznoYwmXTcsaD61EkW/hHGICvGBajEoDWweppixm3EF16WoVADy412ancFbBipOIdkPFQIx2j5CAHZnWOh5Oq7W0FpePNXjUJ9h1XMnFM+ql6hVjXGrSFqOxh9pHn3Ay6OnmMx0Alz1rIy/2m+YRvEUjUK+/
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28c0d7f1-ca6c-483c-36d6-08d80d2019fa
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2020 09:24:40.0172 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 817L0cWfmbiz6020Z0WVFGTJh9EBC5gD6Tidrx7iPjulvZKhhJ5B301UhgliKHOtqFZkwGuypLW/Hwh2QlTHh7zTBBCiSu/8opIlPRUuwiQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5464
Received-SPF: pass client-ip=40.107.4.110;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 05:39:44
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 qemu-stable@nongnu.org, Max Reitz <mreitz@redhat.com>, ppandit@redhat.com,
 xuwei@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

08.06.2020 21:26, Eric Blake wrote:
> Commit 93676c88 relaxed our NBD client code to request export names up
> to the NBD protocol maximum of 4096 bytes without NUL terminator, even
> though the block layer can't store anything longer than 4096 bytes
> including NUL terminator for display to the user.  Since this means
> there are some export names where we have to truncate things, we can
> at least try to make the truncation a bit more obvious for the user.
> Note that in spite of the truncated display name, we can still
> communicate with an NBD server using such a long export name; this was
> deemed nicer than refusing to even connect to such a server (since the
> server may not be under our control, and since determining our actual
> length limits gets tricky when nbd://host:port/export and
> nbd+unix:///export?socket=/path are themselves variable-length
> expansions beyond the export name but count towards the block layer
> name length).
> 
> Reported-by: Xueqiang Wei <xuwei@redhat.com>
> Fixes: https://bugzilla.redhat.com/1843684
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

> ---
>   block.c     |  7 +++++--
>   block/nbd.c | 21 +++++++++++++--------
>   2 files changed, 18 insertions(+), 10 deletions(-)
> 
> diff --git a/block.c b/block.c
> index 8416376c9b71..6dbcb7e083ea 100644
> --- a/block.c
> +++ b/block.c
> @@ -6809,8 +6809,11 @@ void bdrv_refresh_filename(BlockDriverState *bs)
>           pstrcpy(bs->filename, sizeof(bs->filename), bs->exact_filename);
>       } else {
>           QString *json = qobject_to_json(QOBJECT(bs->full_open_options));
> -        snprintf(bs->filename, sizeof(bs->filename), "json:%s",
> -                 qstring_get_str(json));
> +        if (snprintf(bs->filename, sizeof(bs->filename), "json:%s",
> +                     qstring_get_str(json)) >= sizeof(bs->filename)) {
> +            /* Give user a hint if we truncated things. */
> +            strcpy(bs->filename + sizeof(bs->filename) - 4, "...");
> +        }

Is  4096 really enough for json in normal cases?

>           qobject_unref(json);
>       }
>   }
> diff --git a/block/nbd.c b/block/nbd.c
> index 4ac23c8f6299..eed160c5cda1 100644
> --- a/block/nbd.c
> +++ b/block/nbd.c
> @@ -1984,6 +1984,7 @@ static void nbd_refresh_filename(BlockDriverState *bs)
>   {
>       BDRVNBDState *s = bs->opaque;
>       const char *host = NULL, *port = NULL, *path = NULL;
> +    size_t len = 0;
> 
>       if (s->saddr->type == SOCKET_ADDRESS_TYPE_INET) {
>           const InetSocketAddress *inet = &s->saddr->u.inet;
> @@ -1996,17 +1997,21 @@ static void nbd_refresh_filename(BlockDriverState *bs)
>       } /* else can't represent as pseudo-filename */
> 
>       if (path && s->export) {
> -        snprintf(bs->exact_filename, sizeof(bs->exact_filename),
> -                 "nbd+unix:///%s?socket=%s", s->export, path);
> +        len = snprintf(bs->exact_filename, sizeof(bs->exact_filename),
> +                       "nbd+unix:///%s?socket=%s", s->export, path);
>       } else if (path && !s->export) {
> -        snprintf(bs->exact_filename, sizeof(bs->exact_filename),
> -                 "nbd+unix://?socket=%s", path);
> +        len = snprintf(bs->exact_filename, sizeof(bs->exact_filename),
> +                       "nbd+unix://?socket=%s", path);
>       } else if (host && s->export) {
> -        snprintf(bs->exact_filename, sizeof(bs->exact_filename),
> -                 "nbd://%s:%s/%s", host, port, s->export);
> +        len = snprintf(bs->exact_filename, sizeof(bs->exact_filename),
> +                       "nbd://%s:%s/%s", host, port, s->export);
>       } else if (host && !s->export) {
> -        snprintf(bs->exact_filename, sizeof(bs->exact_filename),
> -                 "nbd://%s:%s", host, port);
> +        len = snprintf(bs->exact_filename, sizeof(bs->exact_filename),
> +                       "nbd://%s:%s", host, port);
> +    }
> +    if (len > sizeof(bs->exact_filename)) {
> +        /* Name is too long to represent exactly, so leave it empty. */
> +        bs->exact_filename[0] = '\0';
>       }
>   }
> 


-- 
Best regards,
Vladimir

