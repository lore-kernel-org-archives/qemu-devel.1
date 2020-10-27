Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E051C55179
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 15:08:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8261206E5
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 15:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="qL22cj/Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8261206E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXQai-00060c-QC
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 11:08:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kXQP0-0008TQ-6l; Tue, 27 Oct 2020 10:56:47 -0400
Received: from mail-eopbgr20136.outbound.protection.outlook.com
 ([40.107.2.136]:51438 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kXQOw-0004tG-8f; Tue, 27 Oct 2020 10:56:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V77bUrIJ92heFVmekW/mIJetlhEFJ1BBrPJDp0DoVbL6IWfIToAjGYveVWGcuzevAC+TUre10vSOA/EXmWd6NCvFkhMHCfmyhK9Mk0/GZkXfZJXVzFv8x1isDZ9Q9FyaLAih/kq1kZ1Yh5LqAf1JlWzFOxni8mXa9CGkzdC3Dl0XFZqG53rD6yNU9BdYHdwaNKaZBj75Kvjr2ckzFpeRUn3EsticCSos76JpocmJbXoCDgp0NKBDMLZgO8jqb5Jet8me8OTqTweisY0Bbwd+4MJLU1jgt9joFtbtikRiCEaoX/17yOshleZz+7Mnoplw/j9IoZdBL+utSoY88qIkcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sNeg2fUuDigwutzOAVh+Jti6BMNrVTTZ/1Ypn4FZydg=;
 b=P3/k7froUW8nhS7sO1vRIRyRZL2GG1QnBcdPtBmTLNtu3DJMNsFbRe3+cGfwPU4MFnj33KRUvOyWdC3ngEH8MFq66VRcbRK/UItvLIEHJOn3UTp9ZE6fr8SIw6+oiDsA7zdZMZE3WWq/kvkT7D7quxHrC/+3u/WvGWVZHEF9TtVzk8wIP/FM0t8yPYR12p7rK+SAHBfW+7fNqGCnw5wbTLOKkFwcaEJgiYfysIMBR1iD8tXhhZXZ4jV/JEnxQg5qfBMSpSFMT/SGyv9tngtTZqI9ew/ULNzTAV4a90l7CdIKn2N4v3euma542Fbj1MouaRK232X/JkZMwOeaIZkNzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sNeg2fUuDigwutzOAVh+Jti6BMNrVTTZ/1Ypn4FZydg=;
 b=qL22cj/QqLqZOnwOkqDnWTWEKpgUcyRmu1o901RsqPH2+lRVhYklF15FIsTq/nDzA0tAcgYvSmoFPX4EpgbzTbFrrz4t8jRQNi4kA3XL5+gHqVdrceY2c15r/7+AgYQktNy0r+W3sEJmiGgCDcVPjehnsARoUfj63CG51zfY8aI=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com (2603:10a6:803:137::19)
 by VI1PR0802MB2221.eurprd08.prod.outlook.com (2603:10a6:800:9a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.22; Tue, 27 Oct
 2020 14:56:36 +0000
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::c1ba:32cf:cd37:712c]) by VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::c1ba:32cf:cd37:712c%9]) with mapi id 15.20.3455.037; Tue, 27 Oct 2020
 14:56:36 +0000
Subject: Re: [PATCH v12 11/14] copy-on-read: add support for read flags to
 COR-filter
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, fam@euphon.net, stefanha@redhat.com,
 kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, jsnow@redhat.com,
 eblake@redhat.com, den@openvz.org
References: <1603390423-980205-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1603390423-980205-12-git-send-email-andrey.shinkevich@virtuozzo.com>
 <919b7722-f424-8213-f36a-1a64187e5004@virtuozzo.com>
Message-ID: <26c8f9a5-13e3-85d8-0ff5-34c6c6c6ce7e@virtuozzo.com>
Date: Tue, 27 Oct 2020 17:56:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <919b7722-f424-8213-f36a-1a64187e5004@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [185.215.60.93]
X-ClientProxiedBy: FR2P281CA0020.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::7) To VI1PR08MB5503.eurprd08.prod.outlook.com
 (2603:10a6:803:137::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.93) by
 FR2P281CA0020.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.9 via Frontend Transport; Tue, 27 Oct 2020 14:56:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc9aa4b0-1373-495e-fdee-08d87a888058
X-MS-TrafficTypeDiagnostic: VI1PR0802MB2221:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0802MB2221C0D40B73B5BB36DA41ADC1160@VI1PR0802MB2221.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MJxe8O9nYNH/KEk/mBdzaQOa//WdR02ou0djMa+RmJqfYeYxprismla/i/5wUwWpGWCNgrd1K34IESxSgVHwPYF6u9DFOcV7Ejt8xtHVvjUKeMdzZ3wV+S0SMueb5TPW8v6rdhIubtQ4wUKJBW/CQnWH/hi3Lhj2RnnQG/FEsrQ+rxjepjTx09Im3hgd4vWQJ9C3YpZc5fakIXQrrQSqHiB5qCnWpYPtr5il/MLuZ54pZMtb5ToWGHMoW3HTwW3fktXeJjLcCyV+oNZ/alDztTGph7ZsAKIQmZ6/tnqKXrzA0XpEKiVFcSQPmcV6nwxuLzYX5n38ro4CfCeYFXpOSpysJ3YNRW3w7Ig2+NHAoHXNUJQX+nCoPzTB7SiOUJy1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR08MB5503.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39840400004)(376002)(396003)(346002)(316002)(36756003)(4326008)(26005)(5660300002)(6486002)(2906002)(66556008)(86362001)(66946007)(16576012)(956004)(2616005)(8936002)(16526019)(52116002)(31696002)(107886003)(66476007)(31686004)(478600001)(83380400001)(186003)(8676002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Us/hdNj1ENKP2uUIHywY1FMA7EwLAzspiDi56bi8cys1rALSbEAq/qG5BZKTNYzBxcWNj2NwyV2Y853Mw/5gqfuvnQs7mNqI0/A088f/pZMfMZmVVJ6vCTGFzfg/N9UdF5EWvL9gmuwNU2UnLXW3fmDigUiTUWl8BxWpAXwiHRWiw5floFZLSjsA6QMtjbqU7ypoMWbdjpTD6PwAwSx4OiskD7mg/50XgLbzpqllSVIFvhCFLCsHcBEH5n/35ynPq3GMNUzZXslHHVsyagaEI3gAUGEGqOpkUp3y1qLsKW0ypIkdobibyZZvw9uh7A5Qj3ms0VzMAtgeIL7Fg6rQarhFS8GQHB3NQAlmJP7etqY+kkUB6MGJUb7xjMpBSpVrWezNRIIQZn2pM6zCHm2rnwjDOEvT9UlAo0z/EJxc9fAdX3UII6NUCMXieRN+JOrn2de1UBiiEQdWqCacvNhi7aKIRIfq5loUUQGaES0Dp/h2jBtXiz8GIs+5xaTnwe0V5VT6pRIzib67+ErrPAw7i+QzWbBubMXVWIRDDH0OghCnXMW+GgZ1JpmRrh1iECfwK/ulMy+rlaJT6G8ypoFRiY1PXm792I46l3nfRWKxRGAQr8f4DkHQCRMQXZLe8USpTY8XwpdVxCRlHC5x8pJPUw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc9aa4b0-1373-495e-fdee-08d87a888058
X-MS-Exchange-CrossTenant-AuthSource: VI1PR08MB5503.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 14:56:36.2104 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bYVOqVCBVrj/b1prSB5ikxmuMxLZ/PL+7F0HDLAHjIdWEzYcT3SB3L3CXfDlHJI+XOvhRXHOcqGk+vLHWIdnrPzs/4tGY5Q2hziAyDEsgII=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2221
Received-SPF: pass client-ip=40.107.2.136;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 10:56:37
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001,
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

27.10.2020 17:46, Vladimir Sementsov-Ogievskiy wrote:
> 22.10.2020 21:13, Andrey Shinkevich wrote:
>> Add the BDRV_REQ_COPY_ON_READ and BDRV_REQ_PREFETCH flags to the
>> supported_read_flags of the COR-filter.
>>
>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>> ---
>>   block/copy-on-read.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/block/copy-on-read.c b/block/copy-on-read.c
>> index 8178a91..a2b180a 100644
>> --- a/block/copy-on-read.c
>> +++ b/block/copy-on-read.c
>> @@ -50,6 +50,8 @@ static int cor_open(BlockDriverState *bs, QDict *options, int flags,
>>           return -EINVAL;
>>       }
>> +    bs->supported_read_flags = BDRV_REQ_COPY_ON_READ | BDRV_REQ_PREFETCH;
>> +
>>       bs->supported_write_flags = BDRV_REQ_WRITE_UNCHANGED |
>>           (BDRV_REQ_FUA & bs->file->bs->supported_write_flags);
>>
> 
> This should be merged with the following patch, otherwise it doesn't make sense. You mark filter as supporting PREFETCH, but actually it just ignores it (and may crash on trying to read into qiov=NULL).
> 

Ah, no, problem is not in qiov=NULL, but in that we will just pass PREFETCH to bs->file, which may not support it and crash in block.io in the new abort() from patch 10.


Also, any reason to add support for BDRV_REQ_COPY_ON_READ ? What it means for cor filter? I don't know. It make sense only for generic layer and handled in generic layer. It never passed to driver, so let's not declare support for it.

-- 
Best regards,
Vladimir

