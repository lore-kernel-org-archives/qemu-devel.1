Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F89C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 12:25:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D42920848
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 12:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="LOT3YG1P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D42920848
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSfqr-0000mb-Fd
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 08:25:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55674)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kSfgb-0000Jq-Gr; Wed, 14 Oct 2020 08:15:17 -0400
Received: from mail-eopbgr60127.outbound.protection.outlook.com
 ([40.107.6.127]:27249 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kSfgX-0003qk-L7; Wed, 14 Oct 2020 08:15:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FoXpRKOGEexqMFojyMvTQRj/H2DKH5B05KxC/GDd/GL42CTW66L5kYIfLEKgBW79ak4IM08clcueL2PzLb5L9n66yxqSdODqVepQ5HD/u347s6rjW8BYZYxyzzpzg3qVkceIJk25XbtiuT12GV7Gj6QdU2VQ3WiqKFLsDpRue1YzGGAF8nDjY7YpDmQ1Q0HTUhNL6cqnpo+5+gMKvGCIIla1MZb0eSuuey/zAR//iLvuUfHtGv9SIYKWREDY6lL/f+Hk2zTKJDG08d6BkqQ97GDsIx1yay0tlv0D+FDJlgyf3TlLTCHr4/UjhSzLtbl8XO3N1BWDrD5UiDVNEo7Ztw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGb9FXuhhPH+Lu+2wzDzAM3gbFPyO0LgkTfMx1VbtIw=;
 b=DsnF/h8Ry4KQrzG9N8TIBTkkTruIPVrk/TYLfvplUBs5Bl+p9Wk8gFi2RS5gF8FYb7Z3s1520Dyk6mBDPsGZ5PEgXw5vkbrEKR9X2KJVuOXThseCTjIqRKoJEwyriBD1SviN8h/BZR6aqZYxMDhO7ofBTMs1h3A7OtBCf/8q1Kb98uEdHq2q0mPz8PVtQ8RcMz+DJLZfoXJgax+3bsUm+eEgZaBAwjUh2C68O5VHHnAUYAYq+7XHOtiedW7V1nOqT7GyAWKVay3OpVrcZmYUUuTKJj2ZZB8rUSyQ9hyxJR01FVbiNEcc5yCZEnIuEEMKl3h4Xk8TgeRkZBu6aUhRaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGb9FXuhhPH+Lu+2wzDzAM3gbFPyO0LgkTfMx1VbtIw=;
 b=LOT3YG1PoLxWjS37wpChK3d/s0LrcMQxb6ZABLq05+gLftYMSZ9dn0p4QxrKoNTxO5UW5ydyLTuttn1PepYTjUMkPNE6vKobwbDNIaEMdq2o+8uxdff001BDK7VlbkyjkJsLItnlgh9iZir0kWN/oGY9s8Tw6NIonrobI+kMo10=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0802MB2609.eurprd08.prod.outlook.com (2603:10a6:203:98::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22; Wed, 14 Oct
 2020 12:15:10 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3455.031; Wed, 14 Oct 2020
 12:15:10 +0000
Subject: Re: [PATCH v4 4/7] nbd: Update qapi to support exporting multiple
 bitmaps
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, rjones@redhat.com,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20201009215533.1194742-1-eblake@redhat.com>
 <20201009215533.1194742-5-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <6ee3ac4f-65c3-fdfd-9adb-9bea5f5739e3@virtuozzo.com>
Date: Wed, 14 Oct 2020 15:15:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
In-Reply-To: <20201009215533.1194742-5-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.215.60.122]
X-ClientProxiedBy: FR2P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::10) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.122) by
 FR2P281CA0023.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.11 via Frontend Transport; Wed, 14 Oct 2020 12:15:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7f5b386-6af4-4f7f-d179-08d8703acbc7
X-MS-TrafficTypeDiagnostic: AM5PR0802MB2609:
X-Microsoft-Antispam-PRVS: <AM5PR0802MB2609A9B0C042F0524257C7F2C1050@AM5PR0802MB2609.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pQaRgZhV6r4rtn/rAPp92kqV+lzOPFszP6hsbk7TvvBnBupk3IM2TevaJhISArXuDuWTat+/+h72JcVR0DD2Yb51XTro0fGqS3FJkk9t/XM/0bMIC251pVZem2VuTRaz/t45jVsCTGHQzd+zV/Mwi+5bmlDGpuup7XwU8bxphN7g757aB7HJDK5whKnikLvG9paQm9UObF4XAPBxWMa/ba+/DHRZhCSzdj+0cVlbQWDMZF0ZLFJ/Dn+HUYbt0b65IoLeKm4Nn7531tZRPdNUpa6ZQAU8UrwuXoe8sJU9zeY+GQMbIQOpsPpJcHsGnCHxvfUVYm4BWKK5ysbypA6seuaImPHXWlOIZw2yrQkqx6uFNKQApiLDQWQ3sSbEKfA6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39840400004)(376002)(136003)(396003)(366004)(66556008)(66476007)(4326008)(16576012)(54906003)(66946007)(36756003)(2906002)(478600001)(6486002)(4744005)(8676002)(316002)(956004)(86362001)(83380400001)(2616005)(26005)(186003)(5660300002)(16526019)(31686004)(8936002)(52116002)(31696002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: z8is4uYc+8CJx/DrO0USbsWwgxTNbNnhEpK4AdlzFa1IQq2szD+cx7EO5FsUkMCyLsZGHqLV84myCH31kvyD7ePzX4RzbF1EqyAgmhthOtKK1/ZEKhv5MFDw8FMMAO32sovPF9z1//LmleJ5fHE7q0YfnjDGLBURucErdLYxAMwG3u9Q72TRUbksYH6BNzgDsWxjcUdEuKeoPF8nHefpdpZOZLxwQHuqBWOPyESzo5G58hTBHhHV+Aq1y1c7f/2jF4lbPN/dwLE9NHCRukJyAKvOoHhQ7oOYeLI0GAt/aR3I7oA7LwU4JslcuvM8unyiJfrq4SJ64S5NQzkAev3D7kMD05AHo9kq2z2+SYOsYipRCBlPU3APiwx5HIgQSzi3IbsnCUDfEain3np4oz7Nfc4SssbyCRceKHGEdsmWLrvyFg2+oR4GoMOVE1G15CVOIq5d6kSq75r0uYaVixH5XGnSpSBgihjIDnnU9KX2H5iGhHCrkzGjjPtelcsfmBX7hezyEZzArMUQN2o56Zc249KElF0CTziV9BleLUb5rJHwxC7cWwRiNCPVWpgey8sEF7ElY68WAT/zMWNLS7iQpWUO/0WJaImNJa4g7TtJavIg4WbQhDxabsEKZxSMs7V18/joV8WJ0dcvczwy7eDW7g==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7f5b386-6af4-4f7f-d179-08d8703acbc7
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 12:15:10.3314 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KLzo/nrFUKTiBsO3fWr1fEwwsBn2GL89irFXJKLfFruWRzcf7kbJArwZ/qdMwu+garouc63USJwTXb8gekaGbFS+SuXoFUmuXv9X2ZwRMHU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2609
Received-SPF: pass client-ip=40.107.6.127;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 08:15:11
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

10.10.2020 00:55, Eric Blake wrote:
> Since 'nbd-server-add' is deprecated, and 'block-export-add' is new to
> 5.2, we can still tweak the interface.  Allowing 'bitmaps':['str'] is
> nicer than 'bitmap':'str'.  This wires up the qapi and qemu-nbd
> changes to permit passing multiple bitmaps as distinct metadata
> contexts that the NBD client may request, but the actual support for
> more than one will require a further patch to the server.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---

[..]

>               break;
>           case 'B':
> -            bitmap = optarg;
> +            tmp = g_new(strList, 1);
> +            tmp->value = g_strdup(optarg);
> +            tmp->next = bitmaps;
> +            bitmaps = tmp;

If publish QAPI_LIST_ADD, defined in block.c, it would look like:

     QAPI_LIST_ADD(bitmaps, g_strdup(optarg));

anyway:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

