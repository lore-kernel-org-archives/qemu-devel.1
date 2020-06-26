Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB22C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 17:22:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE0CF2065F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 17:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="WIJbHr/8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE0CF2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jos3Q-0006za-4Y
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 13:22:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41392)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jos2f-00061B-IW; Fri, 26 Jun 2020 13:21:33 -0400
Received: from mail-eopbgr70128.outbound.protection.outlook.com
 ([40.107.7.128]:6058 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jos2c-0005U5-GZ; Fri, 26 Jun 2020 13:21:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gPDX0dzy4Kj3JpRmy7/WErl7rmOJPJ1Whr9/15rdNCXcMFPwIkHiZReWTj7BmK0YIBjtq8unwB/LVk8uZ4HAHzlmwPeeMTC+9NU0P14fB1Zn9J/DFCEUHXrOhZEPzEl4PJpmt9z2EaCAIzThe8uTBrr05zLdWfbMHfAvtpugKRy7H/N+TLs5ulwtxK1if1VIG6Jid1NJYeK+8+UlQ9f75v31H4oIaW8K/+b9HiHZxXdCQoB+L1CRgm2yOJUkkPWQAsgTaIPjLcBaqSO0EmgMzmC000W78TCOni7wGXscIEW3RRJr3ZwqyFBGFlr5FDySOBUgDNatVZa9CanI8+/3iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OX1t2PJmcbt03bo1SF4pOwpA9XIE7Hc+/vgptfyX86k=;
 b=f3EgazlFkn8WHHhxoNtQzV1iJCxrBFEg+5j9HkFacBRhp6V89WBVPpWOw/wOhpZ/ChibEvqKt2axnHtVoxgyxn1V9WxBJdDIQvJfoFGaMzJ+GV5lV0Btdu7IouA+l3HflraOr+cTjd4YQQBpu7RGptEk/2YzFqlLeyIdHcfpEgV+BrncsOFco+/1M+gjOj3g9RUiunrSW37DzJIptvz80FPJqRG9F0QZeht6ug2/78MNMtkVbGCusetBLPo4ToDqKnVPchCxwwgmnkJBtVkuGiws5PJQ/HPVt+FF+2MJ3HgFKANXNe/pV1TjID94wnctYrXJZf3s7nUb7R3ISiYoDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OX1t2PJmcbt03bo1SF4pOwpA9XIE7Hc+/vgptfyX86k=;
 b=WIJbHr/8kK0CZClHuk42XX9VuCYZ3+1mb3ZAKccMhBQIIfVi5hsmRz1fphgTcS5RoplB2fHDjnrA4VK58clvncMBXZib44t2NvlA1RoURHavtRaG2O9fUYFIfOUy7QRilthQtTnGFGBtKLONqBSqakgAaLiZjnW7LXmE2KMT1cM=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB1969.eurprd08.prod.outlook.com (2603:10a6:203:4c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.24; Fri, 26 Jun
 2020 17:21:26 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3131.025; Fri, 26 Jun 2020
 17:21:26 +0000
Subject: Re: [PATCH 07/46] error: Avoid more error_propagate() when error is
 not used here
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200624164344.3778251-1-armbru@redhat.com>
 <20200624164344.3778251-8-armbru@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <aa48ada1-2712-e658-6c36-440b402b046a@virtuozzo.com>
Date: Fri, 26 Jun 2020 20:21:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <20200624164344.3778251-8-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0125.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::42) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.7) by
 AM0PR10CA0125.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:e6::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.21 via Frontend Transport; Fri, 26 Jun 2020 17:21:25 +0000
X-Originating-IP: [185.215.60.7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa45bd91-7c2d-4f3e-8482-08d819f55b56
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1969:
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1969F9479AF8C5A4E2C68587C1930@AM5PR0801MB1969.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:169;
X-Forefront-PRVS: 0446F0FCE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VGopLodnVdkoRKTVUkul+Lydzd7MJdGSgZC2Zv8VcgsHYRUxl9xBwhKkod3lq5gUgesgy898Q/ri39ry3KiOfvhHkFu2EMPgn1Vs710TCLBCJgj++kIKhwlIYeoJeopGeTHPR1xbN9djWeB2eHkMaARo/jHEpi/clr4G92Holqi1wEWOBrRv5slt2kfKhIaiBcZShJuQ1lUn29h6l2QWo24ejpnHwPSqiBCCW1uVoQWCDsIg4CJKq8e4wCgEVpQyQYkjad9PuVwM1r0ffqM8ZLwWouWbIxhxgnBjKQVY9skixhofILCgznfPV/HOIAvxaALCxKf4TxoNq99ILdyXP5S8apythPNMMuwFmf0qZln4qY6mHDs5N6yjZ7anvHq7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(366004)(396003)(376002)(346002)(136003)(6486002)(36756003)(52116002)(66556008)(66476007)(316002)(2906002)(86362001)(5660300002)(8676002)(16576012)(66946007)(83380400001)(8936002)(16526019)(31686004)(186003)(4326008)(2616005)(956004)(31696002)(478600001)(26005)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: FsY/k3gcKZmh04tACPiW3nabEHOTiXn1RW0vwAaTAZhG79jiMEz14XiutEr8xuIirI9QlcfAQvSHzhJDnuh49WkWpGAyBiL9HhFvhZkDrpb8V9saCW3xOvausb5BK+ge+eN0hhDEO7BtqwFSqpb1g5yZA8orYjF0anPsENlbSu+06hqg+fyw0VyoAk4kvkFdLBZL5upfjIuBXnYk5CUujvqTIQVIXEa87Ntt8aRmEByOQjXOod2OUlcNHZodsh4YMDWbo9dKEhNZUEZ8+ElJcIgw93HSnqmS8mJojy36F6cHVoNdNBCtL4vqSI8gXGgZ6R2Jo5NYhfUWMF0JGXwTm5NacSTZUuXcA0s+K5bfOMiS4nS87v3LzuI5AP0J3AdxlnYe/Y3SMExJae4hhNFxFCadvcyqs8L+yz32PDbAf9yhl0yX7Tw/2Ya1wRcka1mhur+I04qYi6mHVofB+fj/apiqLBo4ta8vvaQn6YgnRPQ=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa45bd91-7c2d-4f3e-8482-08d819f55b56
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2020 17:21:26.3740 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1BOo2FICWO7MGc0T3Ayr2RoRtrXUwUGKslt+52RpzoUMhGle/TZg2Yj0YJ1U/NQLH6I+5Gh60LCfL3NYy5jY8jgsJpg0hWg95ALE3iJnMTI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1969
Received-SPF: pass client-ip=40.107.7.128;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 13:21:27
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

24.06.2020 19:43, Markus Armbruster wrote:
> When all we do with an Error we receive into a local variable is
> propagating to somewhere else, we can just as well receive it there
> right away.  The previous commit did that for simple cases with
> Coccinelle.  Do it for a few more manually.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   blockdev.c     |  5 +----
>   hw/core/numa.c | 44 ++++++++++++++------------------------------
>   qdev-monitor.c | 11 ++++-------
>   3 files changed, 19 insertions(+), 41 deletions(-)
> 
> diff --git a/blockdev.c b/blockdev.c
> index b66863c42a..73736a4eaf 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -1009,13 +1009,10 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfaceType block_default_type,
>       }
>   
>       /* Actual block device init: Functionality shared with blockdev-add */
> -    blk = blockdev_init(filename, bs_opts, &local_err);
> +    blk = blockdev_init(filename, bs_opts, errp);
>       bs_opts = NULL;
>       if (!blk) {
> -        error_propagate(errp, local_err);
>           goto fail;
> -    } else {
> -        assert(!local_err);
>       }
>   
>       /* Create legacy DriveInfo */
> diff --git a/hw/core/numa.c b/hw/core/numa.c
> index 5f81900f88..aa8c6be210 100644
> --- a/hw/core/numa.c
> +++ b/hw/core/numa.c
> @@ -449,40 +449,33 @@ void parse_numa_hmat_cache(MachineState *ms, NumaHmatCacheOptions *node,
>   
>   void set_numa_options(MachineState *ms, NumaOptions *object, Error **errp)
>   {
> -    Error *err = NULL;
> -
>       if (!ms->numa_state) {
>           error_setg(errp, "NUMA is not supported by this machine-type");
> -        goto end;
> +        return;
>       }
>   
>       switch (object->type) {
>       case NUMA_OPTIONS_TYPE_NODE:
> -        parse_numa_node(ms, &object->u.node, &err);
> -        if (err) {
> -            goto end;
> -        }
> +        parse_numa_node(ms, &object->u.node, errp);
>           break;

Could we use return here and and for other "break" operators here, to stress, that we
are not going to do something more in case of failure (as well as in case of
success)? To prevent the future addition of some code after the switch without
handling the error carefully here.

>       case NUMA_OPTIONS_TYPE_DIST:
> -        parse_numa_distance(ms, &object->u.dist, &err);
> -        if (err) {
> -            goto end;
> -        }
> +        parse_numa_distance(ms, &object->u.dist, errp);
>           break;
>       case NUMA_OPTIONS_TYPE_CPU:
>           if (!object->u.cpu.has_node_id) {
> -            error_setg(&err, "Missing mandatory node-id property");
> -            goto end;
> +            error_setg(errp, "Missing mandatory node-id property");
> +            return;
>           }
>           if (!ms->numa_state->nodes[object->u.cpu.node_id].present) {
> -            error_setg(&err, "Invalid node-id=%" PRId64 ", NUMA node must be "
> -                "defined with -numa node,nodeid=ID before it's used with "
> -                "-numa cpu,node-id=ID", object->u.cpu.node_id);
> -            goto end;
> +            error_setg(errp, "Invalid node-id=%" PRId64 ", NUMA node must be "
> +                       "defined with -numa node,nodeid=ID before it's used with "
> +                       "-numa cpu,node-id=ID", object->u.cpu.node_id);
> +            return;
>           }
>   
> -        machine_set_cpu_numa_node(ms, qapi_NumaCpuOptions_base(&object->u.cpu),
> -                                  &err);
> +        machine_set_cpu_numa_node(ms,
> +                                  qapi_NumaCpuOptions_base(&object->u.cpu),
> +                                  errp);
>           break;
>       case NUMA_OPTIONS_TYPE_HMAT_LB:
>           if (!ms->numa_state->hmat_enabled) {
> @@ -492,10 +485,7 @@ void set_numa_options(MachineState *ms, NumaOptions *object, Error **errp)
>               return;
>           }
>   
> -        parse_numa_hmat_lb(ms->numa_state, &object->u.hmat_lb, &err);
> -        if (err) {
> -            goto end;
> -        }
> +        parse_numa_hmat_lb(ms->numa_state, &object->u.hmat_lb, errp);
>           break;
>       case NUMA_OPTIONS_TYPE_HMAT_CACHE:
>           if (!ms->numa_state->hmat_enabled) {
> @@ -505,17 +495,11 @@ void set_numa_options(MachineState *ms, NumaOptions *object, Error **errp)
>               return;
>           }
>   
> -        parse_numa_hmat_cache(ms, &object->u.hmat_cache, &err);
> -        if (err) {
> -            goto end;
> -        }
> +        parse_numa_hmat_cache(ms, &object->u.hmat_cache, errp);
>           break;
>       default:
>           abort();
>       }
> -
> -end:
> -    error_propagate(errp, err);
>   }
>   
>   static int parse_numa(void *opaque, QemuOpts *opts, Error **errp)
> diff --git a/qdev-monitor.c b/qdev-monitor.c
> index e38030429b..40c34bb9cf 100644
> --- a/qdev-monitor.c
> +++ b/qdev-monitor.c
> @@ -600,7 +600,6 @@ DeviceState *qdev_device_add(QemuOpts *opts, Error **errp)
>       const char *driver, *path;
>       DeviceState *dev = NULL;
>       BusState *bus = NULL;
> -    Error *err = NULL;
>       bool hide;
>   
>       driver = qemu_opt_get(opts, "driver");
> @@ -655,15 +654,14 @@ DeviceState *qdev_device_add(QemuOpts *opts, Error **errp)
>       dev = qdev_new(driver);
>   
>       /* Check whether the hotplug is allowed by the machine */
> -    if (qdev_hotplug && !qdev_hotplug_allowed(dev, &err)) {
> +    if (qdev_hotplug && !qdev_hotplug_allowed(dev, errp)) {
>           /* Error must be set in the machine hook */
> -        assert(err);
>           goto err_del_dev;
>       }
>   
>       if (!bus && qdev_hotplug && !qdev_get_machine_hotplug_handler(dev)) {
>           /* No bus, no machine hotplug handler --> device is not hotpluggable */
> -        error_setg(&err, "Device '%s' can not be hotplugged on this machine",
> +        error_setg(errp, "Device '%s' can not be hotplugged on this machine",
>                      driver);
>           goto err_del_dev;
>       }
> @@ -671,19 +669,18 @@ DeviceState *qdev_device_add(QemuOpts *opts, Error **errp)
>       qdev_set_id(dev, qemu_opts_id(opts));
>   
>       /* set properties */
> -    if (qemu_opt_foreach(opts, set_property, dev, &err)) {
> +    if (qemu_opt_foreach(opts, set_property, dev, errp)) {

Here is an example, what I was afraid, when we discussed introducing a lot more
bool functions (true is success).

Here are two functions with different semantics, and it looks a bit weird,
one if (func()) and one if (!func()). Still "goto err" makes it obvious
that it's all about error checking.

I don't remember, did we considered a convention to avoid if (func()) to check
errors, and use instead if (func() < 0) for such case? So here, update it to be

if (qemu_opt_foreach(opts, set_property, dev, errp) < 0)


(I don't insist to do it exactly in this patch, as its aim is another, I just
  want to remind about this problem)

>           goto err_del_dev;
>       }
>   
>       dev->opts = opts;
> -    if (!qdev_realize(DEVICE(dev), bus, &err)) {
> +    if (!qdev_realize(DEVICE(dev), bus, errp)) {
>           dev->opts = NULL;
>           goto err_del_dev;
>       }
>       return dev;
>   
>   err_del_dev:
> -    error_propagate(errp, err);
>       if (dev) {
>           object_unparent(OBJECT(dev));
>           object_unref(OBJECT(dev));
> 


Also, suggest a squash-in, I've noted during previous patch review:

diff --git a/backends/cryptodev-vhost-user.c b/backends/cryptodev-vhost-user.c
index dbe5a8aae6..3cdc406b0d 100644
--- a/backends/cryptodev-vhost-user.c
+++ b/backends/cryptodev-vhost-user.c
@@ -184,15 +184,13 @@ static void cryptodev_vhost_user_init(
  {
      int queues = backend->conf.peers.queues;
      size_t i;
-    Error *local_err = NULL;
      Chardev *chr;
      CryptoDevBackendClient *cc;
      CryptoDevBackendVhostUser *s =
                        CRYPTODEV_BACKEND_VHOST_USER(backend);
  
-    chr = cryptodev_vhost_claim_chardev(s, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    chr = cryptodev_vhost_claim_chardev(s, errp);
+    if (!chr) {
          return;
      }
  



-- 
Best regards,
Vladimir

