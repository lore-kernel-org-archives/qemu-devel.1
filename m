Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A5CAC4363D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 10:15:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 426EE20782
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 10:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="O9EdhuJz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 426EE20782
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ6UC-00020h-1G
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 06:15:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41452)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kQ6Sx-0001ah-OV; Wed, 07 Oct 2020 06:14:35 -0400
Received: from mail-db8eur05on2097.outbound.protection.outlook.com
 ([40.107.20.97]:1185 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kQ6St-0005Qv-RY; Wed, 07 Oct 2020 06:14:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oWsdhGj4QLLJ90QRIjR1nbMqamRuBN5XzbZsjUV8irbPcEC2WYVC/et6h2essDswA34NZmrV7bVk9600mM4Wxtwf45atX3XwpWsdm6bDGyRE6LBSKW0tllhRU7ij11bi//oifib7VZBrWhA46KmxRNmGHKpYdPKZuMorClytcQNFGyQIoTn8qclsT9nYEWhJNJKolbU0q1bX0JU8a/+FSNvshBl+vcI5x6TGOvBhFLxS8IDIQATr7VE5vQZ2+rgl4fnHwX3fOJfw/XxkeTijXwKGcPwrS9lnwUDNh1TOrepThNpScg7Dfo6nVtm/xRaFEz0Q45/dJQzJ25JBZ99DqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r4dZVikKbmJWoD8vMkQHFjVZhTlU05J1JbDil+dDdzc=;
 b=TzwhKkeqm7yMp+TebjJonfIxbypTsV1IQ87FLjumcE6nwFNV+e/b/7hYtb8860UWGcUc/bo7sVWxLCyHUu2xf/nmGlMSdsNgc4C8PtkT6TgpI6h1xWMp/XIWwFikqtzl+m0OU4QlFppMiB92VIwPqYZuPiA5jvYB9gBUC06OVMPZ8C9kl/ykKBGSMpLTgGD3/WkSkODht6ewyTD5z1DvWMxFZfzqeDtFUQPRidwy75ZCwipPLpYs7mdJ9JfRizs38+H9ays/jkZTMw5T9VbRR4zeOFidqTil3hw04pNVyu8RtvwbsrTH0lz2Oej+OyuNTBInswZRGUFJReuKEud/AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r4dZVikKbmJWoD8vMkQHFjVZhTlU05J1JbDil+dDdzc=;
 b=O9EdhuJzFYZEmb5ZNf1bo+mYqnAlDFdvNKxsoRAo0uB3+HatJvha+otbVSTLVAQqRKCLh5DUjVnYTc7QtUdtTm/6cvHKVQUJwCvxmWPWIiuop3TAK+HxQAY79aPWT/zfZ3cvJlGtIpT1eK8jwLniQuup5BevKxmZ6QKC9dYfSpU=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AS8PR08MB6309.eurprd08.prod.outlook.com (2603:10a6:20b:29f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22; Wed, 7 Oct
 2020 10:14:28 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3433.045; Wed, 7 Oct 2020
 10:14:28 +0000
Subject: Re: [PATCH v10 7/9] stream: skip filters when writing backing file
 name to QCOW2 header
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, mreitz@redhat.com,
 stefanha@redhat.com, fam@euphon.net, jsnow@redhat.com, armbru@redhat.com,
 eblake@redhat.com, den@openvz.org
References: <1601383109-110988-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1601383109-110988-8-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <c75c215d-ab8f-4147-5c5c-0b8b56868638@virtuozzo.com>
Date: Wed, 7 Oct 2020 13:14:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
In-Reply-To: <1601383109-110988-8-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.215.60.87]
X-ClientProxiedBy: AM0PR02CA0006.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::19) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.87) by
 AM0PR02CA0006.eurprd02.prod.outlook.com (2603:10a6:208:3e::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.21 via Frontend Transport; Wed, 7 Oct 2020 10:14:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4a91c4a-c9e5-4bea-78f0-08d86aa9c66c
X-MS-TrafficTypeDiagnostic: AS8PR08MB6309:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AS8PR08MB630933357CEC2F726195FAEEC10A0@AS8PR08MB6309.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ba2FSDz1Kv0YGzTt4qJuVZflA7ZciRrtjbj75m3o+F4133LNTj+wfNVGkJv5hh9P41PvzMGXchbZUC1stPFocZLiJtOjzJLKcNJvj4h6ADJN6uwRprkqV/UgpQ/tmlPaVCoqd/tv79AvELxFQzRpb7EkvKjIT7Q/Gy5d2VLjmiwUai5qqnOsK4+DnRRct7vj7jX2jGTJ+1AR/A+ypjbTj/aNtSy2h/M6WEeaM3o3H8U40IEJPLl/Eh1iSuCRdNGrUwtRNPEa6mMNdjWGPgDU7WLWNPfbEs+Eh1G0kWN7jc2j/B0/JH0pwi3fIX66RtL8kO2IiMFQ3Cz+RT/2LxcS5VG/J+kTQY18xHNxapBdRPJgqrb9e2kJs74jx4bQTX1i
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(346002)(39840400004)(376002)(396003)(16576012)(316002)(31686004)(107886003)(2616005)(956004)(26005)(186003)(16526019)(83380400001)(4326008)(6486002)(478600001)(36756003)(2906002)(86362001)(5660300002)(52116002)(8936002)(8676002)(66556008)(31696002)(66946007)(66476007)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: wzn6A/lLiM0DDadQWzmy8JdN49uSeSccV2igrU84KS59WNHbji1JzJR8EiQryWIicx7HQVe5Csdxm5jOJRi8QiW7EvqpKTkISYdLBIkS3iKbDtRL97v6RN5NbioAxx99Jdd5iPacwxTmpJ1gtHGYkthraQQK/Y8hJWca138/aOzpYmareRcVL29+yuBJ+h87RYgtHK5CyA2pWtLFFqtOYgv/+CUkvN/KCQCDkDHABbU0V5KQwRpji4KyLWyzu0znXVOUZZNe68FfC0wHb81sIvNCZL597AHo5jntz7A7F8VMEChJkzBwKHU7PPwgbgybuTtAmycpGYfF82+epVThfwI1ezemo0Yf4atkcy/Mx20SJuJW81iqxQeEHCr5nDai8EuqxrUTzls7aA4r3h8x+d8h6GJXvrMOfv1eXWFRP+aZ210y5Ceoo+7ocw/doHFKyyBeHh4ihNA5s0nsMPJ7umtnw3OqaGOSWW25c5ZRw1xVX1Aoe+4sfS+PHYTjTersbl3pKkagcOl0QswFrG7fLctOtcQTJ+E8e7p+YXzrhOKqtIYHoS4rZyO+BrJbjO0UZLyiqZvNBVkx7STiYI1lAZ49e36jnkVED2wP4hUohYyoCRwHK+5nXQkw0GScK7ojjjL8+Sc4MV3gFANka9Htcw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4a91c4a-c9e5-4bea-78f0-08d86aa9c66c
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2020 10:14:28.5005 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RUAuRZciJ1Wf5Ropd5KWBQhmynEnaJlGdZgiUKMDVikTW1CGB0S+8cQeK0bS1Lu41fQ7Fj1f+eXm28lVlvYMmEuLrvSVtTUVOWtC2mux/MI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6309
Received-SPF: pass client-ip=40.107.20.97;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 06:14:29
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_LOW=-0.7,
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

29.09.2020 15:38, Andrey Shinkevich wrote:
> Avoid writing a filter JSON-name to QCOW2 image when the backing file
> is changed after the block stream job.
> 
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>   block/stream.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/block/stream.c b/block/stream.c
> index e0540ee..b0719e9 100644
> --- a/block/stream.c
> +++ b/block/stream.c
> @@ -65,6 +65,7 @@ static int stream_prepare(Job *job)
>       BlockDriverState *bs = blk_bs(bjob->blk);
>       BlockDriverState *unfiltered_bs = bdrv_skip_filters(bs);
>       BlockDriverState *base = bdrv_filter_or_cow_bs(s->above_base);
> +    BlockDriverState *base_metadata = bdrv_skip_filters(base);

Could we call it base_unfiltered in according with all such things?

>       Error *local_err = NULL;
>       int ret = 0;
>   
> @@ -73,10 +74,10 @@ static int stream_prepare(Job *job)
>   
>       if (bdrv_cow_child(unfiltered_bs)) {
>           const char *base_id = NULL, *base_fmt = NULL;
> -        if (base) {
> -            base_id = s->backing_file_str;

Seems backing_file_str becomes unused and we should drop it. So, actually,
this patch fix two problems:

  - do not save backing_file_str at stream start (as base may change during the job)
  - avoid json filters in final qcow2 image metadata

> -            if (base->drv) {
> -                base_fmt = base->drv->format_name;
> +        if (base_metadata) {
> +            base_id = base_metadata->filename;
> +            if (base_metadata->drv) {
> +                base_fmt = base_metadata->drv->format_name;
>               }
>           }
>           bdrv_set_backing_hd(unfiltered_bs, base, &local_err);
> 


-- 
Best regards,
Vladimir

