Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E5A0C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 19:43:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23B822078D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 19:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="F0JUJeZn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23B822078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtyvU-0006CZ-DN
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 15:43:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60444)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jtyuZ-0005d0-1M; Fri, 10 Jul 2020 15:42:19 -0400
Received: from mail-eopbgr40093.outbound.protection.outlook.com
 ([40.107.4.93]:55523 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jtyuW-0006el-8t; Fri, 10 Jul 2020 15:42:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AMmF7QVOl34I0vVUOO/4d6qLTK28MhK4/k9g3Q4AaoF9DmWvdqSxVk1rsrutTtFR0sN1BpNFLnTXWIk/fcqAcsPR4NFrrRKD7dG34BErZ/ITbrJXbAdky/Mw7BFwKz0V9ChHIDzf9SSTbI9wFQvhU+AD4qZ7O1vHDzvJrcH2SEZo+wLO7uJAeOmF7qVOJCi31bxA2UA/QQooUKS4yUh7YAgceDRyS2Ql/W5A+PhnRc1Z3j7ripU+lyAc22XK2wEO/YUG4vQOYIzGxInP7aXILm6lhu+++BeK6rCKPVwv9TCsk+rDDbPym1QOaSoJjRXLBM/CBWWyOhR8ogmIdbGRhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iuR87FbHfmBdWls8shJmLHSW5DBD8d0iQpD3eZ35IhQ=;
 b=B5JooAAofURmajaL7/CxQZBQxPG1PlDTNok8cFJdchhEzVNOCggjfIf4sP3zJQ7pSGnJaa3Eewf1X3xaODp9ghr1MVR9LcVn1izJj7hrbzuok1ZlPGyICiouZ8mXaOyOXWOdii1BG1AwHbZficeM8O1wZ0qFy4R5yI1zPrqQZJhdgjIOma0Zyjd7ZZEpQjfZ4gmmpUDw7YCAt+9xApw/dh1rhSzuy3qOy+I48eNbnf6DUhCr4IHOVtqx9V0wSqCgUr/+GMQwRsQcKDvdNbjeSK9C04NH7RmRuvxvl3wPr3hH34qj18zflfMPCEmHxEZd8+qN+5W6jce6FDfXlh5c0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iuR87FbHfmBdWls8shJmLHSW5DBD8d0iQpD3eZ35IhQ=;
 b=F0JUJeZnwmNdaW0B1eH7yxR4Iwd8vhatNhBjyg7nDRaUDOoBYMcncnvNrhiMGyZK6i/uUrJT2ksw8OjG5EEsBQ6cW3mp2q/5rZMwjpSXWuASghQW2+fjHHRJ0vPRxtw4CehWzX9sRsNa/du9UDXQkDYnFRN0E0E8FmOslyHrwNk=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM6PR08MB4166.eurprd08.prod.outlook.com (2603:10a6:20b:a6::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Fri, 10 Jul
 2020 19:42:13 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0%5]) with mapi id 15.20.3174.021; Fri, 10 Jul 2020
 19:42:13 +0000
Subject: Re: [PATCH v7 17/47] block: Re-evaluate backing file handling in
 reopen
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-18-mreitz@redhat.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <cb80dda7-e3e1-afb1-10b5-18b09eb9669b@virtuozzo.com>
Date: Fri, 10 Jul 2020 22:42:09 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <20200625152215.941773-18-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: AM0PR10CA0028.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::38) To AM6PR08MB4070.eurprd08.prod.outlook.com
 (2603:10a6:20b:a3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.191) by
 AM0PR10CA0028.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22 via Frontend
 Transport; Fri, 10 Jul 2020 19:42:11 +0000
X-Originating-IP: [109.252.114.191]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c714aef1-4c63-498e-e8db-08d8250957c4
X-MS-TrafficTypeDiagnostic: AM6PR08MB4166:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4166445CEBF629B490230DFDF4650@AM6PR08MB4166.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:612;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xCENqm/iD8gMt0k/AlIU6HYtNIwxJe8UKBcc4WknTEQie8qasJ7b9vYsg5vyf03TwjSTAiTq9Wb3b+TD9afJsldQNkustPSA9rUQItYV3AqfLUZIJGV4udK2WsJYbjihNSZu1nsqbtzzTTrT11KIOLUofbUni5oG1iclDCNZJ7w9j6ECkfH4UD0ZI1m0uIECoMoyyFHmkIQiifT6IXzCdh7wOCNnDpSMvmMp/rKcUOMm49L8Bpq88/HNjSrnDmE93Jg17EHo3TFL4zgZ229oPyARkvXPx/4BOELqUssOBXT+ymJhHUWNPdtDPq4XkxvvG6LyudqLmSaU+l1wsXkBL7E1/ZKk2fqu+wbGMjfTAD3MI3Hyv4YlHUbGCP7r2XAk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(136003)(346002)(396003)(376002)(366004)(2616005)(86362001)(956004)(6486002)(83380400001)(36756003)(478600001)(44832011)(52116002)(31686004)(6506007)(53546011)(8936002)(31696002)(8676002)(2906002)(54906003)(66556008)(186003)(26005)(16526019)(316002)(5660300002)(4326008)(6512007)(66946007)(66476007)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: p+NzV/uebxp/yVHRp6oNYgIJ/qdm6IL/LSRQEuILJwty+bh7Dfir22UlHwqS6efrS2IeG8y18UrFAV31DWYdH8IijEqN71MZaTNcZfZB00BCut2WKtiUGJ0B5V/8uV+n1tLkKrvQkBCNDN+2+kZHBfuE1sEoTtPjdUTgKxH5AzcNFFK0NXmcMY48W7j2+jdQbJtYaxvEWnt+1X0k/dtFgTdzXa/+XbRkXtr5WcAzQpKGvZ3WhuIAVcTUlZzPeis5PIqFzm7G8Wafw0z0tbULqSaUKGX207q3oGu6RmM8wElistM5K3NM8++s9Iwxr5BLNcsjIpWxm8DNyr2njJ6LQb0SBvqfOlq2nmQUEhiHV4qMf5itqgEpni8ztf8y74EyiCWaL5CvLBW/9HZGxpxxooStc4zaA61VORYTAlnLWZmIY4Llx1gmInPkeE8gQTNFE1MjGRslOHOai6PhN/wT+oFh08emOC4X8Tses9UnJCyLB3PKfwlR9K5NSTm9RFbx
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c714aef1-4c63-498e-e8db-08d8250957c4
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4070.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 19:42:13.2689 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CAPSOVmNNzD99IfW/BhLAHrS86Yghg7t0ATlmh9IJanlt10AfNcJ2Jg5duX8C4qy619KauJEX2dC+oXRq3GWMtQ14H30/UlhxYhkcjo6Du4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4166
Received-SPF: pass client-ip=40.107.4.93;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/10 15:42:14
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25.06.2020 18:21, Max Reitz wrote:
> Reopening a node's backing child needs a bit of special handling because
> the "backing" child has different defaults than all other children
> (among other things).  Adding filter support here is a bit more
> difficult than just using the child access functions.  In fact, we often
> have to directly use bs->backing because these functions are about the
> "backing" child (which may or may not be the COW backing file).
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   block.c | 46 ++++++++++++++++++++++++++++++++++++++--------
>   1 file changed, 38 insertions(+), 8 deletions(-)
>
> diff --git a/block.c b/block.c
> index 712230ef5c..8131d0b5eb 100644
> --- a/block.c
> +++ b/block.c
> @@ -4026,26 +4026,56 @@ static int bdrv_reopen_parse_backing(BDRVReopenState *reopen_state,
>           }
>       }
>   
> +    /*
> +     * Ensure that @bs can really handle backing files, because we are
> +     * about to give it one (or swap the existing one)
> +     */
> +    if (bs->drv->is_filter) {
> +        /* Filters always have a file or a backing child */
> +        if (!bs->backing) {
> +            error_setg(errp, "'%s' is a %s filter node that does not support a "
> +                       "backing child", bs->node_name, bs->drv->format_name);
> +            return -EINVAL;
> +        }
> +    } else if (!bs->drv->supports_backing) {
> +        error_setg(errp, "Driver '%s' of node '%s' does not support backing "
> +                   "files", bs->drv->format_name, bs->node_name);
> +        return -EINVAL;
> +    }
> +
>       /*
>        * Find the "actual" backing file by skipping all links that point
>        * to an implicit node, if any (e.g. a commit filter node).
> +     * We cannot use any of the bdrv_skip_*() functions here because
> +     * those return the first explicit node, while we are looking for
> +     * its overlay here.
>        */
>       overlay_bs = bs;
> -    while (backing_bs(overlay_bs) && backing_bs(overlay_bs)->implicit) {
> -        overlay_bs = backing_bs(overlay_bs);
> +    while (bdrv_filter_or_cow_bs(overlay_bs) &&
> +           bdrv_filter_or_cow_bs(overlay_bs)->implicit)
> +    {
> +        overlay_bs = bdrv_filter_or_cow_bs(overlay_bs);
>       }

I believe that little optimization would work properly:


for (BlockDriverState *below_bs = bdrv_filter_or_cow_bs(overlay_bs);
        below_bs && below_bs->implicit;
        below_bs = bdrv_filter_or_cow_bs(overlay_bs)) {
          overlay_bs = below_bs;
}
>   
>       /* If we want to replace the backing file we need some extra checks */
> -    if (new_backing_bs != backing_bs(overlay_bs)) {
> +    if (new_backing_bs != bdrv_filter_or_cow_bs(overlay_bs)) {
>           /* Check for implicit nodes between bs and its backing file */
>           if (bs != overlay_bs) {
>               error_setg(errp, "Cannot change backing link if '%s' has "
>                          "an implicit backing file", bs->node_name);
>               return -EPERM;
>           }
> -        /* Check if the backing link that we want to replace is frozen */
> -        if (bdrv_is_backing_chain_frozen(overlay_bs, backing_bs(overlay_bs),
> -                                         errp)) {
> +        /*
> +         * Check if the backing link that we want to replace is frozen.
> +         * Note that
> +         * bdrv_filter_or_cow_child(overlay_bs) == overlay_bs->backing,
> +         * because we know that overlay_bs == bs, and that @bs
> +         * either is a filter that uses ->backing or a COW format BDS
> +         * with bs->drv->supports_backing == true.
> +         */
> +        if (bdrv_is_backing_chain_frozen(overlay_bs,
> +                                         child_bs(overlay_bs->backing), errp))
What would be wrong with bdrv_filter_or_cow_bs(overlay_bs) here?
> +        {
>               return -EPERM;
>           }
>           reopen_state->replace_backing_bs = true;
> @@ -4196,7 +4226,7 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
>        * its metadata. Otherwise the 'backing' option can be omitted.
>        */
>       if (drv->supports_backing && reopen_state->backing_missing &&
> -        (backing_bs(reopen_state->bs) || reopen_state->bs->backing_file[0])) {
= BlockDriverState*
> +        (reopen_state->bs->backing || reopen_state->bs->backing_file[0])) {

= BdrvChild*

Are we OK with that?

>           error_setg(errp, "backing is missing for '%s'",
>                      reopen_state->bs->node_name);
>           ret = -EINVAL;
> @@ -4337,7 +4367,7 @@ void bdrv_reopen_commit(BDRVReopenState *reopen_state)
>        * from bdrv_set_backing_hd()) has the new values.
>        */
>       if (reopen_state->replace_backing_bs) {
> -        BlockDriverState *old_backing_bs = backing_bs(bs);
> +        BlockDriverState *old_backing_bs = child_bs(bs->backing);
>           assert(!old_backing_bs || !old_backing_bs->implicit);
>           /* Abort the permission update on the backing bs we're detaching */
>           if (old_backing_bs) {

