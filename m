Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E04C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 21:31:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E71B20739
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 21:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="XgMLiuM+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E71B20739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=openvz.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlJB7-0007AU-6c
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 17:31:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38038)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1jlJ9T-0006Y5-MV; Tue, 16 Jun 2020 17:29:52 -0400
Received: from mail-eopbgr40134.outbound.protection.outlook.com
 ([40.107.4.134]:34114 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1jlJ9O-00080h-VK; Tue, 16 Jun 2020 17:29:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kjtVQ2HA35U/EqXnD5n8Knzt0Ugj0WPmlqQ4apQOeVCKSQu9nBcVrc3bdXn1qNmmDrsB5hPxfE1LbTfu0sIfOIg4CYvoYEySFiMdQx85NDOsbXBFNb+o3++dMWFVdzF+eFUMixU0al6vnraQ0iJzyKUJofxNJ7Ohp8wR/Q5Eu8lHIryf0vpfZN811InzETdZxVpgUqJnY1wAmV2hZh0FynM7N5WaPVSqgYjLEEZWBxbm8GsPyd4LhfrAPnWUZ0g3Na02vLr/AKOhnuScLgQHCfZNRjVpRddw18yg2Osz5mi1MKrTXLL2T49n81H+9aQJRTBRZeV2d48t4mq4edskAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPjOvKpH7ZFqqUFZ3CsFPVlZBQlmKQmS7Z0XiNbeZKw=;
 b=oDI28n/CHLxx1NrCv/4+oFh4u9/GVubjBX1iVpBXKE5JzAtVHxBMwap8qWfJEkzPeEqPBuof/c4I+uqvKYVMRxHqO4QwwE8CEMpibYNuTudxN6BGXufegud/fePlI8V/IDkCaIdkBftjVs3AjDIiee7t80Nuky0HjaPylkrXae7OzdUAoIyd3dEmNR6qrKUHZv3ig4of1wkB/hNrsYBBkFHPTnamaNVQ93gUHb5QQRrrg5xMKqtuvudIKP44uKyT7euCJ/4gZGTbaiU1rsUIUJlAuIu7sTB3z6nzfXap+K8jrmSMxOSLrlyVG5Eji4P6xXN2joH7A73V/Jv0BZIOTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none header.from=openvz.org;
 dkim=pass header.d=openvz.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPjOvKpH7ZFqqUFZ3CsFPVlZBQlmKQmS7Z0XiNbeZKw=;
 b=XgMLiuM+y4BZrNrx5PB6nw77GM+6JibG8VIhgqpEcXgx8bRsiictQFFUnXV3Nb6dMBR9kAbt8MVZFs3pM/lAV5PMPg6nu/zRAZKH5eePM2SSmWDQg1Sy7jh0F1PbM5VdzX55tW9/QA5TvD/tkOUU5t7qyJDlGEJoN7LoAAKe2Ws=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=openvz.org;
Received: from AM6PR08MB4214.eurprd08.prod.outlook.com (2603:10a6:20b:8d::30)
 by AM6PR08MB4566.eurprd08.prod.outlook.com (2603:10a6:20b:a5::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Tue, 16 Jun
 2020 21:29:43 +0000
Received: from AM6PR08MB4214.eurprd08.prod.outlook.com
 ([fe80::821:7596:cf7f:68f8]) by AM6PR08MB4214.eurprd08.prod.outlook.com
 ([fe80::821:7596:cf7f:68f8%4]) with mapi id 15.20.3088.029; Tue, 16 Jun 2020
 21:29:43 +0000
Subject: Re: [PATCH 4/5] block, migration: add bdrv_flush_vmstate helper
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
References: <20200616162035.29857-1-den@openvz.org>
 <20200616162035.29857-5-den@openvz.org>
 <091af0f5-c8e9-8749-c329-287fb100f2b6@redhat.com>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <fc13f3c5-3f6b-047a-60a1-1d3a445f7db7@openvz.org>
Date: Wed, 17 Jun 2020 00:29:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <091af0f5-c8e9-8749-c329-287fb100f2b6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: HE1PR0401CA0118.eurprd04.prod.outlook.com
 (2603:10a6:7:54::47) To AM6PR08MB4214.eurprd08.prod.outlook.com
 (2603:10a6:20b:8d::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.27] (31.148.204.195) by
 HE1PR0401CA0118.eurprd04.prod.outlook.com (2603:10a6:7:54::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.21 via Frontend Transport; Tue, 16 Jun 2020 21:29:42 +0000
X-Originating-IP: [31.148.204.195]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa64ed62-e7b3-4108-c21e-08d8123c629c
X-MS-TrafficTypeDiagnostic: AM6PR08MB4566:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4566EE75A295E21682DF32B5B69D0@AM6PR08MB4566.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 04362AC73B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u6xppdSsQKZVZqx9q1vUSWNE3qT0u6zfdJVXtZca1tLM2OaDd7OGh7aLrCPJw09E+PGsl9AaQrUWi6uWHcEheeRcKuesBU06eK4OpNvDNHJuHGRLanZNcRlWjoi/cw4mjXnT30+ZcUpxzNbpiyD5SAjk7nGM0qnsBVPtCe4weuSpdXnPuvyBoyv1CrLDp4Ud6rKZJPbW6d8XYOykkHfLuY9OiO6lB1vFyTRvCzfXfgz+pChEa0W8FYVFIReTTE4Dv5N0BYPK6FQUhQ3tD+8nm7VGe5pgtNiWlS/Pt7p+WXO8qaLRXiG10ljIiYyb/RYI3bRoCprCrZhT4shKkUKDNfUgFMljZWbN7kPpGCsMtcKnItsPk6U5z6uw/Og/EC7g
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4214.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(376002)(136003)(39840400004)(366004)(346002)(2906002)(316002)(6486002)(54906003)(478600001)(83380400001)(16576012)(31686004)(8936002)(83170400001)(186003)(5660300002)(8676002)(16526019)(66946007)(42882007)(956004)(2616005)(66476007)(66556008)(31696002)(36756003)(4326008)(53546011)(26005)(52116002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: syeKn8w+XIEc6pKJdpBoB1U2QbnnSY8RGoMW32OUDJ4jXVVBXH3t8bN9PtUk79iVXa3c8OW33xVf97/AvQcE55JzyJlm7sQuVaS4uxbNWb2gEiL3JxEiI0FDsRw2ZNPhS6Al7zKpZf49ZzSvAuOn2DdUeDo9DG2T5X4ZNRmIS2p2wFO7U+TZzrlW2mfcaNR18iMqW0SymU1txhI6BeXC6fzLL0Aea3WfmwoEQfW7gn+oi+iXCg2H1Cdu7SSPr4Vd1AijtAXETiykdEpGyKKNZ2vp5D4OyraINOnhK/xvfdRsF3nHqjj9FOQt3R6r/m88oK0Kzl/BOP+FCQiXgK6zEVRc7CBm2YAknAPB+IYyIpZ6VBk/SIAdRlawAXN9bDy2MDBAXP/e9POEkQAtDu1tk4k1/aAUPP1Z5rtF4pNXbzu/X5R/F6EMeaoMFtGLB1Tj+3amKMDRThLhFxldVTjE3PsQ3+J/fjUi7F7AkGiq3y+63xyVz18NclY+DXWf6jBO
X-OriginatorOrg: openvz.org
X-MS-Exchange-CrossTenant-Network-Message-Id: aa64ed62-e7b3-4108-c21e-08d8123c629c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2020 21:29:43.6062 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0bnO7PZWdq1eZw+sLTDBW1nrX0Qwlka3wPrkZ+T98pgdPgjzT3NgO1d7D+aUtNKqeroyA9U1RJVIEOr/fgQeRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4566
Received-SPF: pass client-ip=40.107.4.134; envelope-from=den@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 17:29:44
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/17/20 12:11 AM, Eric Blake wrote:
> On 6/16/20 11:20 AM, Denis V. Lunev wrote:
>> Right now bdrv_fclose() is just calling bdrv_flush().
>>
>> The problem is that migration code is working inefficently from black
>
> inefficiently, block
>
>> layer terms and are frequently called for very small pieces of not
>> properly aligned data. Block layer is capable to work this way, but
>
> s/not properly aligned/unaligned/
>
>> this is very slow.
>>
>> This patch is a preparation for the introduction of the intermediate
>> buffer at block driver state. It would be beneficial to separate
>> conventional bdrv_flush() from closing QEMU file from migration code.
>>
>> The patch also forces bdrv_flush_vmstate() operation inside
>> synchronous blk_save_vmstate() operation. This helper is used from
>> qemu-io only.
>>
>
>> +++ b/block/block-backend.c
>> @@ -2177,16 +2177,20 @@ int blk_truncate(BlockBackend *blk, int64_t
>> offset, bool exact,
>>   int blk_save_vmstate(BlockBackend *blk, const uint8_t *buf,
>>                        int64_t pos, int size)
>>   {
>> -    int ret;
>> +    int ret, ret2;
>>         if (!blk_is_available(blk)) {
>>           return -ENOMEDIUM;
>>       }
>>         ret = bdrv_save_vmstate(blk_bs(blk), buf, pos, size);
>> +    ret2 = bdrv_flush_vmstate(blk_bs(blk));
>
> Do you really want to be attempting bdrv_flush_vmstate() even after
> bdrv_save_vmstate() failed?  Better might be...
>
>>       if (ret < 0) {
>>           return ret;
>>       }
>
> ...attempting it here, at which point it looks like the only reason
> you need ret2 is to preserve ret long enough...
no, I would like to be sure that intermediate state is always cleared at
the end.
In the next patch I am going to put intermediate buffer to
BlockDriverState and thus it has to be removed in any case.

May be flush would be a bad name... clean or finalize?

>
>> +    if (ret2 < 0) {
>> +        return ret2;
>> +    }
>>         if (ret == size && !blk->enable_write_cache) {
>
> ...for this check.  But a quick look at bdrv_save_vmstate() says this
> check is dead: the function can only return negative error or exactly
> size, and we already filtered out negative error above.
>
>
hmm. you are right. good point. this check is dead.
Worth to remove :) I'll add this as a separate patch.

Den

