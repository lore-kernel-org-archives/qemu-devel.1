Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A8CC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 19:04:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AF9A2072E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 19:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="iad7Zu7M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AF9A2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=openvz.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj61m-0001Zn-6s
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 15:04:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56310)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1jj5yj-0006fn-2q; Wed, 10 Jun 2020 15:01:37 -0400
Received: from mail-am6eur05on2128.outbound.protection.outlook.com
 ([40.107.22.128]:27610 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1jj5yg-0005Xb-TW; Wed, 10 Jun 2020 15:01:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dcFIeAD7sM6jXhfWFLz5DWE4LKGLelZlCrG4rOhbP7BldnY+1jT9hfGbbto8DeDmmxZKdxzsIOFPkGPZCd5s4ksqhiRaaJPf2S2JkFP2J3dJ37BRfu50ccPgP51EB59b+Ipi26eWH3gidYsdacU+TsSe2qjuk9fxBSG5aCp9k1Yy28EbGrWjVhz9IfNcckO1ZIenxu7aupUl+13GH56paNz+FpVqKx2c67JrvUQBAk2Vs+ITu5HxMXvmy+6TNh1CafEjQmd3+lwKLCAHwghXmUQaq2knZo30e9M6iCuspJJrS4BX4s3VCv+KzjBAAAoN6AFufknJNBBhO7YDiS8zuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N76MesArbEg+IgWDkX0DmViPYI8TCOqWIXZl9hgkRbU=;
 b=MSayuLsl1woIBrUaIpC8VptdyyhOKnxSJ5OX01rF7/2wB5S+1RNjd5Ksspx0+V1gzvSaldCuCHQ5uqmj0zi86WXbiqEQNYN717J2fNX/Vdj4wgezbY8c4lwBuHD4bWv9iGIX69dbi6Wi2iwYxSmKB8DnsEmOhIv64IcSqtrlhxQFy3t8Q0yVJ4LPSp1crZHglG9Wh/vUe60S7/uoiR0iTrs0PHkL/yS74gY+QiMkBPBH/eP9SYutO+w/k2ruruNKyFmca65U+qSbn1hlpCAVU7AI12XL09uaula3wkmjY+e8kBtTi0tEWvALDEHutXmsBkUPY4ktyPQksWaMlSQTmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none header.from=openvz.org;
 dkim=pass header.d=openvz.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N76MesArbEg+IgWDkX0DmViPYI8TCOqWIXZl9hgkRbU=;
 b=iad7Zu7MjE6+kBwU3Qm9R6Sb96ZkTqKry77uFDRD5DuY7zp6neQs/iPJZleeaTmRN0QSeF9d1GPGUCoMKpVi5InSaijPfwvfQUSQvRVnodNvcVB44WC0m3wQIzE6WiuWsZw+h3WUO++Kj7V4WcOBFxNkmsUffOcX1mOLcm04Ox0=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none header.from=openvz.org;
Received: from AM6PR08MB4214.eurprd08.prod.outlook.com (2603:10a6:20b:8d::30)
 by AM6PR08MB4581.eurprd08.prod.outlook.com (2603:10a6:20b:83::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Wed, 10 Jun
 2020 19:01:30 +0000
Received: from AM6PR08MB4214.eurprd08.prod.outlook.com
 ([fe80::821:7596:cf7f:68f8]) by AM6PR08MB4214.eurprd08.prod.outlook.com
 ([fe80::821:7596:cf7f:68f8%4]) with mapi id 15.20.3088.018; Wed, 10 Jun 2020
 19:01:30 +0000
Subject: Re: [PATCH 1/2] aio: allow to wait for coroutine pool from different
 coroutine - please ignore
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20200610185833.10665-1-den@openvz.org>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <5d22087b-8c0c-1175-ee0c-79816d81d237@openvz.org>
Date: Wed, 10 Jun 2020 22:01:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200610185833.10665-1-den@openvz.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: HE1PR05CA0373.eurprd05.prod.outlook.com
 (2603:10a6:7:94::32) To AM6PR08MB4214.eurprd08.prod.outlook.com
 (2603:10a6:20b:8d::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.27] (31.148.204.195) by
 HE1PR05CA0373.eurprd05.prod.outlook.com (2603:10a6:7:94::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.18 via Frontend Transport; Wed, 10 Jun 2020 19:01:30 +0000
X-Originating-IP: [31.148.204.195]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a7428bb-b9f4-4dbb-9e19-08d80d70af9d
X-MS-TrafficTypeDiagnostic: AM6PR08MB4581:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB45814C715086856DB161FBF8B6830@AM6PR08MB4581.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 0430FA5CB7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hwxGop037o6Hy6FeDtvCLh+6aLqwBmKtY4XgJWBfUKfZm/qYC41+cxlwXOGMtgNLpMh8oJyIiA1twXWjj2fn1eiSNIHvmKQqkBYjgcUPD7VgeUy++UL8yhsAGSU+fJK9KlvlPVBCk9KoF/03WfyHabSy+34BSj7f2Gez2RzVaziZoOZzfrR6xzpOOdjyhvkqytZr35ioCHzxhP2XYxmLvdS0FkU1gI4MVoc8wIYFzwvF+c4iwCXrjsNimHvoOjp9y/ZPvZB4pK4A0c/qw8+IzubL+SzgNevDqdIVRe5neeuCd6CdXzeMKA58dOV3DHL7knHnBCLNkPanqDrOI4Xf8zxqB+gnVh6WtTPcGD4mbuf6pmMo6SwpUKSWTYO5sqkq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4214.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39850400004)(136003)(396003)(376002)(346002)(52116002)(66476007)(66946007)(42882007)(66556008)(53546011)(6486002)(2616005)(956004)(4326008)(2906002)(5660300002)(36756003)(478600001)(186003)(8676002)(107886003)(8936002)(83170400001)(316002)(54906003)(31686004)(16526019)(26005)(83380400001)(16576012)(31696002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 7CEYfsyzy9Yn9k81dA/djTpdQMHvV4CbESEy00rRITirqJmRCy4fTH/YUxTqb+45aJ9A1R9x63uVrwjGge0hm8jJzpI28rZlp/3G+td7IPm6NLzJ9Qr3xnNpVPaKWI1V2wgHRvg9ltWWuF4lMbCKwMNorABD5V0Ic0rIHYGqX9VyN8KQyU6serCsQ9dvKXJcDCHeoDl4A3YWCcbc3fPxCz4aZN38rw/QGgWefmvR3vlEQOL5XI4Qqw0VmahegyjjK+HPNrKvf3M4EqkbJ/Bo1NFL808cbw+SXlXZQ7eDX71H+A2v5lI+ST1EtBCXfJCP/1Lv9sHhnD4PwhET48smsl/P7kS0CiPwwFJELFSYlDmzYY1NxX6jaHJB77U1iK9DlVP/xeVbK2ZUSFUK18hsKTuNsOy2FJoO0XTzvYQMaojtdR+aTwHafCETbmR9zBny/NYiuVKOzDapAOor5eaquxlkb8XTyzTnbAdVJ28OQGhk0ILmokT8m/hRO3GzZBpa
X-OriginatorOrg: openvz.org
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a7428bb-b9f4-4dbb-9e19-08d80d70af9d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2020 19:01:30.8374 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9NbC4BzL8y1ruFJfovhM2at2r7alsibvqt5+9bZbVXrwKoCMgMSFqWGhN8v9kSMluqPHKXmsziM9aAYEkxf8yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4581
Received-SPF: pass client-ip=40.107.22.128; envelope-from=den@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 15:01:31
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/10/20 9:58 PM, Denis V. Lunev wrote:
> The patch preserves the constraint that the only waiter is allowed.
>
> The patch renames AioTaskPool->main_co to wake_co and removes
> AioTaskPool->waiting flag. wake_co keeps coroutine, which is
> waiting for wakeup on worker completion. Thus 'waiting' flag
> in this semantics is equivalent to 'wake_co != NULL'.
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Max Reitz <mreitz@redhat.com>
> CC: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> CC: Denis Plotnikov <dplotnikov@virtuozzo.com>
> ---
>  block/aio_task.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/block/aio_task.c b/block/aio_task.c
> index 88989fa248..5183b0729d 100644
> --- a/block/aio_task.c
> +++ b/block/aio_task.c
> @@ -27,11 +27,10 @@
>  #include "block/aio_task.h"
>  
>  struct AioTaskPool {
> -    Coroutine *main_co;
> +    Coroutine *wake_co;
>      int status;
>      int max_busy_tasks;
>      int busy_tasks;
> -    bool waiting;
>  };
>  
>  static void coroutine_fn aio_task_co(void *opaque)
> @@ -52,21 +51,21 @@ static void coroutine_fn aio_task_co(void *opaque)
>  
>      g_free(task);
>  
> -    if (pool->waiting) {
> -        pool->waiting = false;
> -        aio_co_wake(pool->main_co);
> +    if (pool->wake_co != NULL) {
> +        aio_co_wake(pool->wake_co);
> +        pool->wake_co = NULL;
>      }
>  }
>  
>  void coroutine_fn aio_task_pool_wait_one(AioTaskPool *pool)
>  {
>      assert(pool->busy_tasks > 0);
> -    assert(qemu_coroutine_self() == pool->main_co);
> +    assert(pool->wake_co == NULL);
>  
> -    pool->waiting = true;
> +    pool->wake_co = qemu_coroutine_self();
>      qemu_coroutine_yield();
>  
> -    assert(!pool->waiting);
> +    assert(pool->wake_co == NULL);
>      assert(pool->busy_tasks < pool->max_busy_tasks);
>  }
>  
> @@ -98,7 +97,7 @@ AioTaskPool *coroutine_fn aio_task_pool_new(int max_busy_tasks)
>  {
>      AioTaskPool *pool = g_new0(AioTaskPool, 1);
>  
> -    pool->main_co = qemu_coroutine_self();
> +    pool->wake_co = NULL;
>      pool->max_busy_tasks = max_busy_tasks;
>  
>      return pool;
please ignore

