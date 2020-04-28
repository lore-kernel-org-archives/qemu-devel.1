Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4365DC83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 09:23:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0757D20663
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 09:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="HgJR0lRM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0757D20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTMSs-00062r-2W
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 05:23:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59982)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jTMQ2-0002C6-VM
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 05:22:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jTMNX-0000x1-Pw
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 05:20:46 -0400
Received: from mail-eopbgr30122.outbound.protection.outlook.com
 ([40.107.3.122]:41966 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jTMNX-0000wf-D8; Tue, 28 Apr 2020 05:18:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ddEa3RuUeRxEgP89onZILoJ6E1LIQopCzqY73XJl+ZqGN7nLVMXLlFjepkz+JhzTzQ6inF/kgKMlhiNA2F/lUBint81D0jC0+DIxOdK9lxzg8pkM0jTfSfLNEtZZ7/bqsZQzVKOjArUU8RiiB3n9QAOYeXaf/g8lbpkhE0+O0JpcPE5u/Tr1EF/JKe0sqOilwsayHD+vq2HQPlwqJzdigfcNPf0BgCU8QgbCT7SpLKS9JTs7GcP5QPKHOhgO15g6S7kDWb0RR028FS957vQKH7Ua+drjtSKiZb++aUZkpDbP9RhAe31yoO00EP5ThKO1KTwNe7Iweh93nYkk3XgQHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ks/+RSMBv4GNar4lRd1zaRMbsakoqnAvZTHOYCB+QIs=;
 b=i/9k1H1PEWM+7YZKHk9BhawsG7cG23mVlV/ows3ajKZTyjv8vz21SEPvRDakIO/B9eON/LrVQBRAqbAFt0PlrHBPLVjopU5dR8WUuvu84u02kP1L00pliDnd8h90jamWL6sEwtoSSesyHakG2Bjt+At3cms7l6FZThTuPP471CTN9ccKgKWOYDQyZtVZcKHfBenYr1FTdowDuoqxeDIutIPUx3EP41vbMRxW6ylI4JFAhDx+l8V3ZD1pVga0zJdgv7R7VV8SzWPqDQ1/POS/PGzudrmjT52qqcH/yfg5AHIV6FQsZ80pw/2NAM0RPCQSWHWGBeEX5XFTjTv/wtTC+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ks/+RSMBv4GNar4lRd1zaRMbsakoqnAvZTHOYCB+QIs=;
 b=HgJR0lRMrb85nkCIiVZuMSZKJlVWh/FZtylIML8rjL3/lpyJ9k3VINEOtr62tXu3C2racM42Nr/6mRAqX5bx92GkGFxA0WWA2OCXrTpsPtXeZAsFozhTUjyxwHpVcyrI6mz7awkSq9kkuQAz8qrwdUgyqMhB3SrsRJdWkM/3XSI=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5398.eurprd08.prod.outlook.com (2603:10a6:20b:103::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Tue, 28 Apr
 2020 09:18:08 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.023; Tue, 28 Apr 2020
 09:18:08 +0000
Subject: Re: [PATCH v2 1/6] block/block-copy: rename in-flight requests to
 tasks
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200325134639.16337-1-vsementsov@virtuozzo.com>
 <20200325134639.16337-2-vsementsov@virtuozzo.com>
 <da290ef0-c8dc-7cf0-fcf6-71e28aa323d5@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200428121806863
Message-ID: <a5bfaf7c-6516-aa07-c8b9-028b894aff15@virtuozzo.com>
Date: Tue, 28 Apr 2020 12:18:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <da290ef0-c8dc-7cf0-fcf6-71e28aa323d5@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR0P278CA0007.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::17) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.155) by
 ZR0P278CA0007.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:16::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Tue, 28 Apr 2020 09:18:08 +0000
X-Tagtoolbar-Keys: D20200428121806863
X-Originating-IP: [185.215.60.155]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07643d21-0b5f-4558-ddcd-08d7eb551107
X-MS-TrafficTypeDiagnostic: AM7PR08MB5398:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53988F2B4D17BD0E511CC961C1AC0@AM7PR08MB5398.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:57;
X-Forefront-PRVS: 0387D64A71
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39840400004)(346002)(396003)(366004)(376002)(52116002)(66556008)(2906002)(66946007)(53546011)(31686004)(66476007)(478600001)(5660300002)(8676002)(26005)(81156014)(8936002)(186003)(36756003)(16576012)(107886003)(956004)(2616005)(16526019)(6486002)(31696002)(316002)(4326008)(86362001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rwxdgjpVi6eLobzyzvvn1dvoxvdkYArn/1gQYJJxD6vLF47H1SbmVB+E/PZAHYOKQ+ie22lNm/IZGljrxcDrZdO/2w7NFxVIAK88XoLmxh+HXwgKHOZJlxiA0ebOkRrROvc13kNCIXHAkEzJMqstjPc8Gjt6oItVZFImPitkO8EK+f6VzVPyj3t53OTx/H7DPfqxIfU3UouxOLZ0YjS9gXsE9ltTyRkWe/1BXFtLaM/qC0nRb3Uch0PAxkVzKQvCFEH/rQE2qQtE1bLQWIXeo9x8iKNd3uM1W/RBwJEw81WThpqUXg75syjs3EVNout6V7oReOFscF44DtogcaJD9uCFOW7vV9Kc1Mzg7OC997WvGrDKybnD6FpNjBAOD84STtlnUgvZTUc4ddzpdyUzZ3aZI20rTYrIlL5yugpt5weELEIGDPPQ/Io/+VTpo6C3
X-MS-Exchange-AntiSpam-MessageData: Zxty1RZqH9MOflFipZLe6+U79OJNmtBsdyLo5veCy4wDI+N99fls1Rwtd83TmQtxHwJKw/ALfAffoabP4sjyXI7TrPCwtds7vTkVx8TlmYDY0rxcUqUUefIhmI72raTDqlWfIQuv9emv6XX9l1tWw6PX+IeCavtNtJllWUWOIDNwTfkcOU2vCHTp/e9f5IjyO9OyLzDIpY3bZFVlgpo5ovQRYEDlhknLnO9B/NUHegYAp/7mw6T5OKEV0+9XnmMtQJ3INfhm8gG0DNwIEICJzY66qkdgJtqA5duwDJWF00yrML6sV3i0Hj82FDZcDskRRoNxHqkGtn2MB+TFCd60KTbqGPChs+7M0dGhozOIzIQ0NVKOsflJfSTULp3G3kbUjjSB/M95/0Ii/rIV3aQmfooBjC2il2Su4UvS4FI29sYHyUe+MbVNE8kCb601xPYHTL9xz+K1lgcW6D9/DteuEflHPuHaxSguMml67aDjp9cvxpI/qTB5tKPpS4th3D9a+NRbndP5j9ApniOVVaMF/STohSYpV7N/SZsastBKosk+Ycegk5aHfm/98GMzOy3piPqtgxtfL+ivvA6mnltJZrfDEhVqUUdptNQB/MPmse/PJzg+fjeLv8IA/tNvBXkwNCXJfLYRDvMGoyjVHGL+Xkq6pv6nbjmZoyMxkt2z+m1jziWbI9I0GZ0aqO3ObwuiaWPGEkutlVApYl/afvtJObyT1asXF/lg0RD33tiFz1bNrauzt1u3ipiZkIbfvJPkvH6j52W6SVaZV3JRaHC9EIzUfMGj/jE5t2BxSgm3LSU=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07643d21-0b5f-4558-ddcd-08d7eb551107
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2020 09:18:08.8333 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WiEoKuNNogJkJyf0mBUeTa6bTM0cMk0o684eTgwj6JYOM4aXEGyf/Ax37it6qS/G1xtXcx8id6GAVYaE2H7R+y5+Dfz06UJg7pg81BhYHQ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5398
Received-SPF: pass client-ip=40.107.3.122;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 05:18:09
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.3.122
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
Cc: kwolf@redhat.com, den@openvz.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

28.04.2020 10:30, Max Reitz wrote:
> On 25.03.20 14:46, Vladimir Sementsov-Ogievskiy wrote:
>> We are going to use aio-task-pool API and extend in-flight request
>> structure to be a successor of AioTask, so rename things appropriately.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   block/block-copy.c | 99 +++++++++++++++++++++++-----------------------
>>   1 file changed, 49 insertions(+), 50 deletions(-)
>>
>> diff --git a/block/block-copy.c b/block/block-copy.c
>> index 05227e18bf..61d1d26991 100644
>> --- a/block/block-copy.c
>> +++ b/block/block-copy.c
> 
> [...]
> 
>> -static void coroutine_fn block_copy_inflight_req_shrink(BlockCopyState *s,
>> -        BlockCopyInFlightReq *req, int64_t new_bytes)
>> +static void coroutine_fn block_copy_task_shrink(BlockCopyState *s,
>> +                                                BlockCopyTask *task,
>> +                                                int64_t new_bytes)
>>   {
>> -    if (new_bytes == req->bytes) {
>> +    if (new_bytes == task->bytes) {
>>           return;
>>       }
>>   
>> -    assert(new_bytes > 0 && new_bytes < req->bytes);
>> +    assert(new_bytes > 0 && new_bytes < task->bytes);
>>   
>> -    s->in_flight_bytes -= req->bytes - new_bytes;
>> +    s->in_flight_bytes -= task->bytes - new_bytes;
>>       bdrv_set_dirty_bitmap(s->copy_bitmap,
>> -                          req->offset + new_bytes, req->bytes - new_bytes);
>> +                          task->offset + new_bytes, task->bytes - new_bytes);
>> +    s->in_flight_bytes -= task->bytes - new_bytes;
> 
> This line doesn’t seem right.
> 

Hmm yes.. A kind of copy-paste or rebase artifact.


-- 
Best regards,
Vladimir

