Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34019C2BA19
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 18:40:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF175206F7
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 18:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="IW3XV+Qj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF175206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMc6B-0002FU-5i
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 14:40:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49642)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jMc5J-0001aS-Ne
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 14:39:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jMc5I-0004PY-I5
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 14:39:29 -0400
Received: from mail-db8eur05on2072f.outbound.protection.outlook.com
 ([2a01:111:f400:7e1a::72f]:41440
 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jMc5E-0004NJ-7d; Thu, 09 Apr 2020 14:39:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RyZNYXNTJo7norSAxR4uKPRN4+JSoO9iKy27+/k8eMLvVf8Pq/Di/LJfESkEad/xPiDEDgjWn18wLLSXYuUakS0EO1gQs+gPlHWGwEPW2/kypz+6xlv9pGVUFb2P7bQt6GzXk+OvL2rG6TWj7nX2TIaFw38XoDbNvArKlZ9jYLFanWQ6IFFJqiYX4JdXp3cZRKvAS1MoDgkrL1K6WMAPshqneFfWRataiG2bFw4z0B0ihCzWW7EhvQ34XiGHiPg+XBX/BdV2q0sNbLaSn5q4vb4ixKLYLi/P1WhmzRX8SSfOicTK/fDySW/JeaSZdl8jJhQ2qOYeHaM78jQM4NOKtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dl9SepakIWcO8CZfW9EsQFOPnSn+hDeolT3KdiabAQQ=;
 b=VREgG9vjrIvon2OZ03YQEqIoDhoWJCTy5EABxhnz7Gg71LmktNLmMSqyPAWDq+ckReHMNAR7Y2D4N35JB4q9DVBFSkuPtI5n7Dc3MEt1DJKMryDVfzt7bkKxtkw2iYD3PjLIozs9evxxbXAQzDId3MbvQNQ4SElYTlWqjTBQGvOHDLvGNbtV9TyC8lOmvoTxIkOpAevp4yZdZFOQa6CY4/99qFNBcPqpQDuvpejvorV24Lh360KHJznCa1KT7oBT97V473p3TmT6AcSBDhFRLjyZIQD41/wd8wy4moNsTmWBtHA5ZFYiywtLgmjrJEoFdpVfebxAqDbUMvl6XBlbMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dl9SepakIWcO8CZfW9EsQFOPnSn+hDeolT3KdiabAQQ=;
 b=IW3XV+QjB84e3Y1cQEEQQFqp6j3Pk+Zj1xbkbNtHiRxY0Sl4u1KUYSOiZQIU8vRZ2G4gkn8iPkjtjjrzccHur9yUKRF4rsBmb5CC2A7OB/Ee5gTLushDM8++W+ZESzXf2L7D10RPD565RJfadOmofVDKLTqgM31ZfusDO91jhSA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5478.eurprd08.prod.outlook.com (2603:10a6:20b:107::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Thu, 9 Apr
 2020 18:39:22 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%4]) with mapi id 15.20.2900.015; Thu, 9 Apr 2020
 18:39:22 +0000
Subject: Re: [PATCH v12 2/3] qcow2: Allow writing compressed data of multiple
 clusters
To: Alberto Garcia <berto@igalia.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
References: <1575288906-551879-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1575288906-551879-3-git-send-email-andrey.shinkevich@virtuozzo.com>
 <w51y2r41u4d.fsf@maestria.local.igalia.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200409213912160
Message-ID: <5bbb126f-37c0-f107-c3b3-667ed43670fa@virtuozzo.com>
Date: Thu, 9 Apr 2020 21:39:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <w51y2r41u4d.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0081.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::22) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.186) by
 AM0PR01CA0081.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15 via Frontend
 Transport; Thu, 9 Apr 2020 18:39:21 +0000
X-Tagtoolbar-Keys: D20200409213912160
X-Originating-IP: [185.215.60.186]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ece1d461-bce2-4ce6-a0df-08d7dcb551d9
X-MS-TrafficTypeDiagnostic: AM7PR08MB5478:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB54785DEB30DAFB259DF3735CC1C10@AM7PR08MB5478.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-Forefront-PRVS: 0368E78B5B
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(366004)(346002)(376002)(39840400004)(396003)(136003)(4326008)(6486002)(36756003)(5660300002)(81166007)(107886003)(6666004)(81156014)(66946007)(2906002)(316002)(66476007)(66556008)(8936002)(8676002)(31696002)(2616005)(956004)(52116002)(478600001)(26005)(110136005)(16526019)(86362001)(186003)(16576012)(31686004);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nbP1Axewk1ukJA1m+oOfQtIE+ybAzlkWB0SDNsAPzg5xj4mF7QI3gh/J7g7R/IiJc3wDCqKmacbAQU/0FFUXnhNMDhZNsL6B+dK1MV9iNT9/APSwnmey8Xw0FLd8hUXwVJEwMkHphoBjQQc8EhRipHnDh4zn+GqkDb+1iKaVmahakhOy8rW4A5hF8CNpjqh7hi1BWEWyRVZibOdx8WiXXnISMi65kidIwFxciWXkstdDYbTAMPflMdBvnMWhhXLo45aHz+frTA70/dPjagNRH7Od30IBLt9VMSLZ7kcYCihTF3zjY/avf0gxaEJzpz6/5OWG7W/5qCW6DUDOp5rNRt0xEZiE/fTKrlJ5cGQEOaaANbszFCM1PxOfO7akyf+YsNBXhCHjm11UqNUkFBOy5eMdz1H3arx81v95eksCq9LPHrjvM5tPm/MP7b0eJ1CH
X-MS-Exchange-AntiSpam-MessageData: 69d39YLRPG+Iu5NfXNhTYtkOINf8qw5U0qrVPR4bSK7aldlLj2Zcmm7TisKdm3sy90oAgJsPZzN6dVNBIV8K6LnWgZarVk8YrG6RhiXjKtPO3agi4bXydjRnswwNaxGxhN0AtsK7Qrnhrga9TngBQQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ece1d461-bce2-4ce6-a0df-08d7dcb551d9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2020 18:39:21.8026 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rsinhfLOuiEbaCMcjUgQdP9QepJhTlbw8qR0SulDGq5vgPYLojt9avWbaPgdcoF1er1l9M3Mk1I5EfRoz+llpzOjk9uqw5zpn3odTSJAfv0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5478
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:111:f400:7e1a::72f
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
Cc: kwolf@redhat.com, den@openvz.org, armbru@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

09.04.2020 19:50, Alberto Garcia wrote:
> On Mon 02 Dec 2019 01:15:05 PM CET, Andrey Shinkevich wrote:
>> +static coroutine_fn int
>> +qcow2_co_pwritev_compressed_part(BlockDriverState *bs,
>> +                                 uint64_t offset, uint64_t bytes,
>> +                                 QEMUIOVector *qiov, size_t qiov_offset)
>> +{
>> +    BDRVQcow2State *s = bs->opaque;
>> +    AioTaskPool *aio = NULL;
>> +    int ret = 0;
>> +
>> +    if (has_data_file(bs)) {
>> +        return -ENOTSUP;
>> +    }
>> +
>> +    if (bytes == 0) {
>> +        /*
>> +         * align end of file to a sector boundary to ease reading with
>> +         * sector based I/Os
>> +         */
>> +        int64_t len = bdrv_getlength(bs->file->bs);
>> +        if (len < 0) {
>> +            return len;
>> +        }
>> +        return bdrv_co_truncate(bs->file, len, false, PREALLOC_MODE_OFF, NULL);
>> +    }
>> +
>> +    if (offset_into_cluster(s, offset)) {
>> +        return -EINVAL;
>> +    }
>> +
>> +    while (bytes && aio_task_pool_status(aio) == 0) {
>> +        uint64_t chunk_size = MIN(bytes, s->cluster_size);
>> +
>> +        if (!aio && chunk_size != bytes) {
>> +            aio = aio_task_pool_new(QCOW2_MAX_WORKERS);
>> +        }
>> +
>> +        ret = qcow2_add_task(bs, aio, qcow2_co_pwritev_compressed_task_entry,
>> +                             0, 0, offset, chunk_size, qiov, qiov_offset, NULL);
>> +        if (ret < 0) {
>> +            break;
>> +        }
>> +        qiov_offset += chunk_size;
>> +        offset += chunk_size;
>> +        bytes -= chunk_size;
>> +    }
> 
> This patch allows the user to write more than one cluster of compressed
> data at a time, and it does so by splitting the request into many
> cluster-sized requests and using qcow2_add_task() for each one of them.
> 
> What happens however is that there's no guarantee that the requests are
> processed in the same order that they were added.
> 
> One consequence is that running on an empty qcow2 file a command as
> simple as this one:
> 
>     qemu-io -c 'write -c 0 256k' image.qcow2
> 
> does not always produce the same results.
> 
> This does not have any user-visible consequences for the guest. In all
> cases the data is correctly written, it's just that the ordering of the
> compressed clusters (and therefore the contents of the L2 entries) will
> be different each time.
> 
> Because of this a test cannot expect that running the same commands on
> an empty image produces always the same results.
> 
> Is this something that we should be concerned about?
> 

Parallel writing compressed clusters is significant improvement, as it allow compressing in really parallel threads.

Generally, async parallel issuing of several requests gives more performance than handling peaces one-by-one, mirror works on this basis and it is fast. I've already moved qcow2 to this idea (aio tasks in qcow2 code), and in progress of moving backup job. So, I think that asynchrony and ambiguity would be native for block-layer anyway.

Hmm. Still, what about cluster sequence? For normal clusters there may be simple thing to do: preallocation (at least of metadata). So, we can pre-create cluster sequence.. But what to do with compressed clusters if we want specific order for them, I don't know. On the other hand, ordering of normal cluster may make sence: it should increase performnace of following IO. But for compressed clusters it's not the case.

So, I don't think we should make specific workaround for testing... What exactly is the case?

-- 
Best regards,
Vladimir

