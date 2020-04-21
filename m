Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92238C54FD0
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 12:30:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57AA52070B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 12:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="e7GCY6tz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57AA52070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQs2v-0001xi-Ea
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 08:30:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33034)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jQs0H-0006NN-9l
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 08:27:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jQs0F-0007Qv-BQ
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 08:27:53 -0400
Received: from mail-eopbgr60131.outbound.protection.outlook.com
 ([40.107.6.131]:13390 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jQs0D-0007Nb-Iu; Tue, 21 Apr 2020 08:27:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=obiyVoDOO2Am9dlt+9aVbL57imo5vFkyPYMOBaa2JoI6PQP3TZ1GZ8UgCtd1HCAsZFVHDotQZSg88lBBpQZ4y5HrpEr7EpdizLXGI390c1ZhLZetHi4kDlBaRI11rxXapEkTagQ4hzPP6Iuw3Z2D+PulbBG8WwpFK7Zr0J1OMKerZCAELRX+3+w2As+LiRv4ao/UQ/HNJVT97qVgI3XJS6rDR9hedvtqAinSXBKIIlw6DfGGGZNHZJ38+1Ag+yntwsERXI6t4INGLMJfXi1BUH86uZrSWcmEeOsVPK5vqYW6T3nih3Um82zykhpqVsyWajGA0Y5yshN3G1a+XpcbUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iq/r3WyuH2TlhgaktqC3y4Avb/t3W5k8qoO8vp5S9Ro=;
 b=IgdHQydVVY0d/JT8pOfM+fS6XbQ3yisQKfv7UXU5+9fz5TDmziL8/1qALZFkYtA5SxaDu8eFnnl/i35MqSLI/qJXhWdl4pvxDHgTK1wuRP9casv9Ax1fS38ttPpUyZsQPkFCfs2rc/sL5fR+oy32IQ/ZCfErfWkc226svFMrUTrZ6oK7EEzabNMewT9/C74h8f25qyeC/fU5QfS3AOJfYkjk5LAb+TZrx1Hma26W425sS2AhI+EvyHako9p3qIQ+06bR7V/AE8Ddhc1ksOqnvQWWgJB8EKtjuS6loBFc1ZF+HuQukD/+KT/hyYydLXpVosgBnQeMlATHg/eeNKpw2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iq/r3WyuH2TlhgaktqC3y4Avb/t3W5k8qoO8vp5S9Ro=;
 b=e7GCY6tzWW2PpjN9V5P2GGhrWBnWDdgjYjGdFNHl6DKJ20rCYbR+XebdNHXQwhWAj33qycJVMoCwOFNpaRnC5svXMZEJTCUvZMYZ3dDV+qSTRrAlZ2be/UpzuFCH1E1Uhlhts51HIlBBVbVb02suG50o5hDHEod1HEadda8trqE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5478.eurprd08.prod.outlook.com (2603:10a6:20b:107::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.26; Tue, 21 Apr
 2020 12:27:47 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2921.027; Tue, 21 Apr 2020
 12:27:47 +0000
Subject: Re: [PATCH 2/7] stream: exclude a link to filter from freezing
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1587407806-109784-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1587407806-109784-3-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200421152745547
Message-ID: <bbf82085-7777-5590-9fb1-93fccad9d275@virtuozzo.com>
Date: Tue, 21 Apr 2020 15:27:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <1587407806-109784-3-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0093.eurprd02.prod.outlook.com
 (2603:10a6:208:154::34) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.142) by
 AM0PR02CA0093.eurprd02.prod.outlook.com (2603:10a6:208:154::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend
 Transport; Tue, 21 Apr 2020 12:27:46 +0000
X-Tagtoolbar-Keys: D20200421152745547
X-Originating-IP: [185.215.60.142]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0955fe81-7f53-4406-9b50-08d7e5ef6645
X-MS-TrafficTypeDiagnostic: AM7PR08MB5478:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5478766D40AE45EA27E267F8C1D50@AM7PR08MB5478.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 038002787A
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(136003)(376002)(366004)(396003)(39840400004)(346002)(186003)(5660300002)(26005)(2616005)(16526019)(956004)(2906002)(4326008)(86362001)(36756003)(81156014)(478600001)(31696002)(66476007)(66556008)(66946007)(31686004)(316002)(16576012)(107886003)(8676002)(8936002)(52116002)(6486002);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kO7TbPXy6HqGI3SSivPGreAe/0oJhvRMFRp7y0NGu9o4N5KLBNkYdBVYU2o6N1PcRHBJlAspMiVXaL2JMFHns4si1COgChRMUi4Y+dVst+nkcL1B1lII0xhIx/0FxgizahGCOTDUTOAR9MXLs07BDIIFIy+FTUH7HepsUfSQsSmCsKmcMZZFSJGufv+RD9pqTqHUGzfozGB9bLlml9AgmQnZYB1eQ7Thkmt35DBc8ehRrh+OcnsTqAyZumdlWPD4M4x2PAJX3QASCKrxyqbi5ynb5gZPywQTLVxG2NwMQs8gcRRyrLLi7gob3osLZK9K15eGm2B5tia20MZmpFUIcdCACIWMH4H4aM1Qb1px2pzh1mmVbMpgFIJWo6ND6UTh05ohVYUyKHN5BF4B1WCMqjDSvQqMzZtE55SeEbO33CNzO6c4MaFUCjwvSCR3dd24
X-MS-Exchange-AntiSpam-MessageData: lFF3DUCWONaSBthkRxqzyJALgzNvRlG8n8gF7lcxYXr/tnwP3STlXx5ouipvZ1X1AaAPka9Ksbpq5cQXt7/2WYldj+L5ruX3Pdudt36aLoByAXzQ0rhhnIexOnfPhSYtdabqM4kKUHIY1/yR2qjNIw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0955fe81-7f53-4406-9b50-08d7e5ef6645
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2020 12:27:47.3171 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l6qybO4sshSBfSTr0JPcq+RlIeFhfiUdDfxxO38zvn4bgW31vWTdSWODNdE7STP5G8mF1JSpSqb6M6x40OiIu0J4YVQJmVTA8SPkpguQCew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5478
Received-SPF: pass client-ip=40.107.6.131;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 08:27:48
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.131
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
Cc: kwolf@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org, den@openvz.org,
 mreitz@redhat.com, jsnow@redhat.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

20.04.2020 21:36, Andrey Shinkevich wrote:
> A node above the base can be the filter of the concurrent job. In that
> case, the filter cannot be removed being a part of the frozen chain.
> Exclude the link to filter node from freezing and provide the safety
> check for a concurrent job.
> 
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>   block/stream.c | 16 +++++++++++++---
>   1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/block/stream.c b/block/stream.c
> index bd4a351..d8b4bbe 100644
> --- a/block/stream.c
> +++ b/block/stream.c
> @@ -244,7 +244,7 @@ void stream_start(const char *job_id, BlockDriverState *bs,
>            above_base = bdrv_filtered_bs(above_base))
>       {}
>   
> -    if (bdrv_freeze_chain(bs, above_base, errp) < 0) {
> +    if (bdrv_freeze_chain(bs, bottom_cow_node, errp) < 0) {
>           return;
>       }
>   
> @@ -257,6 +257,15 @@ void stream_start(const char *job_id, BlockDriverState *bs,
>           }
>       }
>   
> +    /*
> +     * Check for an overlapping block-commit job that is not allowed.
> +     */
> +    if (bdrv_freeze_chain(bottom_cow_node, above_base, errp) < 0) {
> +        goto fail;
> +    } else {
> +        bdrv_unfreeze_chain(bottom_cow_node, above_base);
> +    }
> +
>       /* Prevent concurrent jobs trying to modify the graph structure here, we
>        * already have our own plans. Also don't allow resize as the image size is
>        * queried only at the job start and then cached. */
> @@ -276,7 +285,8 @@ void stream_start(const char *job_id, BlockDriverState *bs,
>        * bdrv_reopen_set_read_only() due to parallel block jobs running.
>        */
>       base = bdrv_filtered_bs(above_base);
> -    for (iter = bdrv_filtered_bs(bs); iter && iter != base;
> +    for (iter = bdrv_filtered_bs(bs);
> +         iter && iter != base && iter->drv && !iter->drv->is_filter;
>            iter = bdrv_filtered_bs(iter))
>       {
>           block_job_add_bdrv(&s->common, "intermediate node", iter, 0,

So, we still "own" these nodes above base, but just exclude them from freezing?
It's wrong I think. We should exclude them at all (look my previous answer).

> @@ -298,5 +308,5 @@ fail:
>       if (bs_read_only) {
>           bdrv_reopen_set_read_only(bs, true, NULL);
>       }
> -    bdrv_unfreeze_chain(bs, above_base);
> +    bdrv_unfreeze_chain(bs, bottom_cow_node);
>   }
> 


-- 
Best regards,
Vladimir

