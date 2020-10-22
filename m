Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C35C388F7
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 20:36:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60AA624640
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 20:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="EDeevUen"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60AA624640
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVhKM-0004uH-DE
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 16:36:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48994)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVhJ7-00048w-Hl; Thu, 22 Oct 2020 16:35:33 -0400
Received: from mail-vi1eur05on2100.outbound.protection.outlook.com
 ([40.107.21.100]:5089 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVhIx-0002TT-41; Thu, 22 Oct 2020 16:35:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PrzRBKEQtL/8GHzvol22zMCHkpLHeL40uFvbD+yb3GB5dmGX7GDbJ8wTm237VOp81/D+EbhyUqjkrFHZKcrwXycda2NaeNeT3aUoTd1syqNObal1RM1eSRDaC0Aql4aTOUR3wlp3tCJZFmQSn4KXcg3BOo7XbFo6nMhfyyoN3O7t2cA7in1K43N3f8j6xpFk+nxYT6V7Me6th+P3xrx0JkY3BvvNIG6CNQmQIinFjKo378kYxmi1Yy3Ef8UZjmypUJG4dWeDhmIM3Kf6h3GK7bPJkPl/QZNxyy6kJ/toq+1JQHaKgqPCND3U47erJOkHHF1SepEkAQgcz/Gpmfxf+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vrrvy0ntq4StyU3GGtaNcIaHIYQ1cLSYPqDuXFtRLSY=;
 b=B/nU5ebveypcYcOQI6vwb2T2PTNsTTrtEoSIXMmTz9qJXGp5rKIDbOOvDBSLyl4oIqSuwqIM+0usC+aadlKRsuy8PZXpTFs7lk+NsDRMnmrV3y2x0cDiy+XuQNVTowdZsZTEgxjiTP4O1YXq+ickGTNQ2Xg0i3/9rCbo1lxY4vQcadheWzapx/rV4O1PVeTtmBtNhvRVR213hJR3uG9poF1TqKrHGgsE+iFsjZaxQUwoQ0sykN3fFOb9txbtABNF251oLK3DNzn7v+9mC0Aqy1wl0VenyTMgBpI4efDmJJv5BwAlROKhq3qUgGN7dz7lSIDJMlgdNqnGOd0OxfIpRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vrrvy0ntq4StyU3GGtaNcIaHIYQ1cLSYPqDuXFtRLSY=;
 b=EDeevUentE6ZotQsBIuxN7D7Z7V4djopFdpYSAyHUcZSekPKeZZuohlwoOJ84Wgeak3rz/OHkE0tywU3OfzMQaJ0GIhWX0Bk6Adi9SBaumliY+MvrPPplrA1/d7hI+kIOtgMFn/L8m3Um3NnHIQ+hh2fWk91AcBVhP7Tnj7dTUQ=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0802MB2420.eurprd08.prod.outlook.com (2603:10a6:203:9e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.24; Thu, 22 Oct
 2020 20:35:18 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Thu, 22 Oct 2020
 20:35:18 +0000
Subject: Re: [PATCH v2 11/20] qapi: backup: add x-max-chunk and x-max-workers
 parameters
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, wencongyang2@huawei.com,
 xiechanglong.d@gmail.com, armbru@redhat.com, eblake@redhat.com,
 qemu-devel@nongnu.org, den@openvz.org
References: <20200601181118.579-1-vsementsov@virtuozzo.com>
 <20200601181118.579-12-vsementsov@virtuozzo.com>
 <2117c54a-c9b3-59c6-c0b2-9fd84cb965b6@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <b0334bde-2e84-9833-8228-a578dc064e32@virtuozzo.com>
Date: Thu, 22 Oct 2020 23:35:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
In-Reply-To: <2117c54a-c9b3-59c6-c0b2-9fd84cb965b6@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [185.215.60.82]
X-ClientProxiedBy: FR2P281CA0010.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::20) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.82) by
 FR2P281CA0010.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.10 via Frontend Transport; Thu, 22 Oct 2020 20:35:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e2ec4b5-a3f4-4971-92a5-08d876c9fd59
X-MS-TrafficTypeDiagnostic: AM5PR0802MB2420:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0802MB2420CCBA64AEFEA3ADE831D2C11D0@AM5PR0802MB2420.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NyxXvGfVVgVC91hgjdlEqiXxChZaeelVM6LchT7msQPjVDFumNv4C0VCF5WGc6la67v4Ikd3aOnWVnFxFeTWPVqSUGF69RLCdiArQj5ikx6SQ/BhLFk7kcTUdeK6gZgcN5iFuJbq1Mm8otmWwwlSIEUh4ioTfDcp9w/VshL0i+u0rWLZn9y/8se6CaFzI7jET3CY97DryPH/OhX+UfVbA5UWY4IjykbeiW6+2uooe5VVzetD+K/1SihxT2EWA5D1bDXPBc2RSNbn7wrb1WohqJHegBd07R1K5l8Kg4H3Gb+q3CTWY4WYQo3iwbIFJKxkxufiXfLi7omuBX27c4SetArmLb+oV004KIJ49HbApcfJETgf0ytCqpSczWddlp9H
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39840400004)(346002)(366004)(376002)(136003)(107886003)(6486002)(66476007)(66556008)(31686004)(83380400001)(2616005)(8936002)(86362001)(2906002)(16576012)(956004)(52116002)(8676002)(5660300002)(36756003)(478600001)(16526019)(186003)(31696002)(66946007)(26005)(4326008)(316002)(53546011)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 1VzpoUPj0UWT48KJdABRQbWQ/1+bp3AA0TWZENXWTmEovHKyetsoxUudu5cgsKMLHSz5geDrc3dVK9IYz4NLpL0p3QslRXUEC1mjdhGdnFOEahWn8HnoqFvpU2CqMXVTPIJhN8cA7vS8aUEQJ8f8LrZG8W8okMzFBa7SgqzKQeKumV+VfDOO7fgJmIjMiMQPXlbwYxBsJfXEva6lUE0XDymM0mERQbtE/jN/BkXVVm+O5bV5eTYZriIKz4Bwo7KwVXfpSqLx0rOE9a1CBZynoufn+y+vRJ0b3vd5QUTUbIysShr56F7UVRWjqVEkJ07qNLwE5G/d8xvTykgBdDY37GPIRuGK200+mgUUaEN2tC3S7OtpB/V3IIIuDZz5bJwx6USczo7IqN9Mm3BstRm/klxH5mCswSae87bJUHL4cGg+WsWql2/9F99CiIWoBdb+A30sY97Wy7AXJlkEBsBfp9fPtCPJ06t8p6VITTnRU1sfI+IGd4teMKfsT9R08Zn95kxHJXnln+ToLA5pXE588731pdyxQSPDgmyNa2tthH8TLFEMDIzdi+A6lDmYJgw7tcqvHBdWBTv1IiSJD43c0VnnNX8DEdc43FwyHy1u+B1cSUZYh/C/wC9DnXb4UAP2W3z1vcSS43KivYv3neA9xA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e2ec4b5-a3f4-4971-92a5-08d876c9fd59
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2020 20:35:18.4950 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NEWMJYCpt0mTjC0mOj914WVVXgprfsZgOAeKLY8eKp1Cxto2EyrXQIwm0SJaA/w0MD0x13BBDEvbTz734IK6XqXEoazTnUnghux07oSHlfM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2420
Received-SPF: pass client-ip=40.107.21.100;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 16:35:20
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.107, RCVD_IN_DNSWL_LOW=-0.7,
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

22.07.2020 15:22, Max Reitz wrote:
> On 01.06.20 20:11, Vladimir Sementsov-Ogievskiy wrote:
>> Add new parameters to configure future backup features. The patch
>> doesn't introduce aio backup requests (so we actually have only one
>> worker) neither requests larger than one cluster. Still, formally we
>> satisfy these maximums anyway, so add the parameters now, to facilitate
>> further patch which will really change backup job behavior.
>>
>> Options are added with x- prefixes, as the only use for them are some
>> very conservative iotests which will be updated soon.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   qapi/block-core.json      |  9 ++++++++-
>>   include/block/block_int.h |  7 +++++++
>>   block/backup.c            | 21 +++++++++++++++++++++
>>   block/replication.c       |  2 +-
>>   blockdev.c                |  5 +++++
>>   5 files changed, 42 insertions(+), 2 deletions(-)
>>

[..]

>> @@ -422,6 +436,11 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
>>       if (cluster_size < 0) {
>>           goto error;
>>       }
>> +    if (max_chunk && max_chunk < cluster_size) {
>> +        error_setg(errp, "Required max-chunk (%" PRIi64") is less than backup "
> 
> (missing a space after PRIi64)
> 
>> +                   "cluster size (%" PRIi64 ")", max_chunk, cluster_size);
> 
> Should this be noted in the QAPI documentation?

Hmm.. It makes sense, but I don't know what to write: should be >= job cluster_size? But then I'll have to describe the logic of backup_calculate_cluster_size()...

>  (And perhaps the fact
> that without copy offloading, we’ll never copy anything bigger than one
> cluster at a time anyway?)

This is a parameter for background copying. Look at block_copy_task_create(), if call_state has own max_chunk, it's used instead of common copy_size (derived from cluster_size). But at a moment of this patch background process through async block-copy is not  yet implemented, and the parameter doesn't work, which is described in commit message.

> 
>> +        return NULL;
>> +    }
>>   
>>       /*

[..]


-- 
Best regards,
Vladimir

