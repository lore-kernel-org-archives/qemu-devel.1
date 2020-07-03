Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BDAC433E1
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 15:36:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F54B21534
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 15:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="KpUnIoir"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F54B21534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrNjl-0000ge-Sj
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 11:36:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51512)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jrNdV-0001yA-2g; Fri, 03 Jul 2020 11:29:57 -0400
Received: from mail-vi1eur05on2121.outbound.protection.outlook.com
 ([40.107.21.121]:57953 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jrNdR-0006tm-KV; Fri, 03 Jul 2020 11:29:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JJhmNHSdFa6z0HLph4iVwIdhNcXT/vHR6QlRdqF0bOXpOIghLYAdldNwe3YtMg93qsu3cfMCrpn1ONqMuo2VjptXjc++Ks3pEmWQl++2eJ16O3ZZDTIe8c8B2RatO0AMxFZAPEjGkc3dMP09LLCan5rXzIUsSk96RGXRpzsNPEZrB1bNHsfYBGSc8oW9yhZ117kFcNc62e+FcH/xGZ3aHAouUhYr6GPPsbZJi4jFZnGYFZFyAT0vJ4gBatYOFb7KZowATCuBA9kJeIETsi0FbJZOWxt/gHN1IaAA4V2jrnoGzZm3XqIorU3Az/e9UBYdfcQCMftmOj09oW1NewAnPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbYRmg01qEGozz7l90mek6pIyRJQVP8Y38HiTUyPH1Y=;
 b=FC6MYbHYwW89ecE4me0CckXpazbIgm/qlHS/8Dl4UjB97D6N9P3y7IjNbUU1stoqiw2LD+y6lU+qxTbB/+vQuGiaLK459+bOGwrH7gJ7xrzCvm3rUS0xHHio6RCqHM6Pkm38069V3fvB2qaAMM6rBxsDx+5LYigtaN67eMMupoeFB0kDtXZYTMQtmpWySsw0aXLZDhiS/Bzoq9SxmJIwA3TWb9jjgrvQeLdov6zQji/j9Ifuv1vfk0uGiSDUBvRKE9kYFvZTkoot4cqtx259cXtmaiFWgWJBvomOHxP3uZ8eh+3UNspWhi6zkl0VaxTOYEKaMVkayH1IHqZRaXRKWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbYRmg01qEGozz7l90mek6pIyRJQVP8Y38HiTUyPH1Y=;
 b=KpUnIoir+q8O67zjku/aCWjw+kd+8ONTVcb/gRjtiDJNam1Qg2nc19pHU9GHfMh6dEJUXEQZL8Zj2RMEia6CUn43rnGMWYoXTq4CdYIWgKDI94a7cBoM+BgauigIq/ooISBG9jefDkn930bMiV4zT1pMb3BAED1MmrgFeAgpeNw=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4788.eurprd08.prod.outlook.com (2603:10a6:20b:c4::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Fri, 3 Jul
 2020 15:29:43 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3131.028; Fri, 3 Jul 2020
 15:29:43 +0000
Subject: Re: [PATCH v2 19/44] block/parallels: Simplify parallels_open() after
 previous commit
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200702155000.3455325-1-armbru@redhat.com>
 <20200702155000.3455325-20-armbru@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <c637cddf-cb3f-97d3-ce78-1a0dd46a1db9@virtuozzo.com>
Date: Fri, 3 Jul 2020 18:29:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200702155000.3455325-20-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR03CA0078.eurprd03.prod.outlook.com
 (2603:10a6:208:69::19) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.15) by
 AM0PR03CA0078.eurprd03.prod.outlook.com (2603:10a6:208:69::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.20 via Frontend Transport; Fri, 3 Jul 2020 15:29:42 +0000
X-Originating-IP: [185.215.60.15]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76ab8f9a-7c61-4f47-f762-08d81f65e8e6
X-MS-TrafficTypeDiagnostic: AM6PR08MB4788:
X-Microsoft-Antispam-PRVS: <AM6PR08MB4788EF14D60AD18A138169C6C16A0@AM6PR08MB4788.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:989;
X-Forefront-PRVS: 045315E1EE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g6J8Fza00AABA5RgmuY7jZh+2RYnv4LchNksp37rrkrzL7yVkRbl77cTNlwVMjSuTE5k0xBUVA7m993eGbxY8Hm8hB40VipaJf6QxuXH/dVTQXyeTza7+BmbzBO2tEDgsvjT7q+ANS5hzdDO0jeiXN/1gT6sw50tyJNwYM6SUDCNcT3ba1vVn9vN6ulhNkG9SvlvD++uGCBAQh0aiwX/QN7grRW+47t4s1Xnp5ahmIKtF/LpLPnjosc3bgH8EX0rNsuO2cA5w33AuA8dEkK/kr0+D/SQ+lMxxcrIL4ze4DH/im/u0EOehb+SakadHpNWLlFb0vmVPdZUUKPEq2Lfh/yH03TmbHws/K8h6B1++TyM9KDnElR6wgCGV83hGhF1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(346002)(396003)(39840400004)(376002)(366004)(8676002)(8936002)(86362001)(52116002)(31686004)(478600001)(2906002)(5660300002)(16526019)(316002)(16576012)(66556008)(4326008)(2616005)(83380400001)(26005)(186003)(66946007)(956004)(6486002)(31696002)(36756003)(66476007)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: ktZlZrJMZK2R9T6u5oVIkeSVXkNvJH6+cxyZ2hiqUaWkjdfp6fIBlRF54blBBH0DM3akBXPdfmPMrVclsfTIizBqJCZZ9KH/RQNIHYHvIa3pSJ0JS/SC6zxDyvusIZJqWZkLPVcksuymUSojBI5C47d9u3uVKO1/GSOgAqsw0GYXUQeV/ELENAsplqEOwZdmlxQ/CMwXJgqKEkNQcofBVZFERpSgeD9wrELoRWZy3uTLmH7HchPPt3sOTEWdobOu1xQoTrpGb6SwszTnTfz9qSP4+WygNvVqzp4Gk7BE3nz9M/z4wQxXwTEJF7YjXY7p6PlRqPQv7puW7YBdEv6XHIiCOJ6GN71HsgULFceJPser7TBV9Ci/NPLb4VjZlQ1/1oiPUPEFiRPzskQhGZa8eRZI8Cx0U5TTwFx+diLC6EYvWePZ/FypOHsh1bgE4GLPnQYK0cwSvzq0lFYkbIWPPJZQoQMyXrPLFI7JKuj+pk/8/pwXJC5ykCY6vSUOU451
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76ab8f9a-7c61-4f47-f762-08d81f65e8e6
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2020 15:29:43.3629 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BIt+AsI9bDD2YdrqTThioxw+0FUcS4imDew1iFpn7l5ZVEB85VmMksVufK5Be1+gg+prew6/INU0bDDb0IqQ4TlMou9sobELPpYSZHGzInQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4788
Received-SPF: pass client-ip=40.107.21.121;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 11:29:50
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

02.07.2020 18:49, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>   block/parallels.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/block/parallels.c b/block/parallels.c
> index 32d0ecd398..e0ec819550 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -843,6 +843,7 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
>                                          &local_err);
>       g_free(buf);
>       if (local_err != NULL) {
> +        error_propagate(errp, local_err);
>           goto fail_options;
>       }
>   
> @@ -873,15 +874,11 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
>   
>   fail_format:
>       error_setg(errp, "Image not in Parallels format");
> +fail_options:
>       ret = -EINVAL;
>   fail:
>       qemu_vfree(s->header);
>       return ret;
> -
> -fail_options:
> -    error_propagate(errp, local_err);
> -    ret = -EINVAL;
> -    goto fail;
>   }
>   
>   
> 

You leak local_err in one case. With at least:

diff --git a/block/parallels.c b/block/parallels.c
index e0ec819550..5c1940ee02 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -829,7 +829,7 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
          goto fail_options;
      }
  
-    if (!qemu_opts_absorb_qdict(opts, options, &local_err)) {
+    if (!qemu_opts_absorb_qdict(opts, options, errp)) {
          goto fail_options;
      }


squashed-in:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>


Still, if we have a special patch for the this function, we can get rid of one more propagation:

diff --git a/block/parallels.c b/block/parallels.c
index e0ec819550..d4ad83ac19 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -829,7 +829,7 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
          goto fail_options;
      }
  
-    if (!qemu_opts_absorb_qdict(opts, options, &local_err)) {
+    if (!qemu_opts_absorb_qdict(opts, options, errp)) {
          goto fail_options;
      }
  
@@ -863,9 +863,8 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
      error_setg(&s->migration_blocker, "The Parallels format used by node '%s' "
                 "does not support live migration",
                 bdrv_get_device_or_node_name(bs));
-    ret = migrate_add_blocker(s->migration_blocker, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    ret = migrate_add_blocker(s->migration_blocker, errp);
+    if (ret < 0) {
          error_free(s->migration_blocker);
          goto fail;
      }


with it, as well:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

