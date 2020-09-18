Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB039C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 20:13:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E99D82074B
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 20:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="bpb12Nmq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E99D82074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJMlB-0004h1-00
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 16:13:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40358)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kJMje-0002vS-If; Fri, 18 Sep 2020 16:11:59 -0400
Received: from mail-eopbgr60121.outbound.protection.outlook.com
 ([40.107.6.121]:57773 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kJMjb-0001ci-7j; Fri, 18 Sep 2020 16:11:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O1W2cbWZGRPwJMxhn3hYyt7pq0NdYkWxwTQHJwZNuNaOgvL3CQBFSSDr5LmTY1ikx2wDf6UCJ4njysNkN0PcY0N6mOmexBICAEYvu8kCAjSDHTqtedvcgePyiTfRNMa+dRNITs+NbbFK8lAbSEEM581OeF9r7zy1kX68h38sDF7QERyIWIPWuOd5nshLY0Rgxbvd69VWRaSMyJtnwHd1IZ2DYJE55awSWOX4lljqaQndnmX4Jri03aDzoAGE+ADm7jT5FtAIyPQlHnX8R/jGISTTlBvoMBLPVvaA46043rIP6bvN75ojGRzkmf9QwnxKp+rirsbvT4KlJ9h1BZT3Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KDS82kdkD5VdXxtM8ya5uj+r+9L2KCDDEo2HrQ+Odek=;
 b=aZqISzT8pct4mNpD8WUpet393nNmuLRLLH1oVkP3IrEQg3LwISHRcSD8LjNWv+JiNyoYqoCeOcZLGHQajHFPplsgDJN68FN0z6tfYNaBzqVjoXGuTK0wZbTdmSXRDeWzXgnlMFpycf54KPNyB/wTCH0F8HT5n+VHwf2WZmPxiTagRqlNyRn9bdoGdD/hXVtTOQaTm4uN0GTKq+2ul/P5LP5KpFWBLTOL0Bi4H0sOkQ9UDf5lexwi0hAPA5Q07wFLqY/U5ApwthJ74YKr5E+XR9zDGWPTmF4RrPfUFenLZk3ev45xOt0AsMtVx9wp9nt4q/UcifAlpOXASl1xWYXkjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KDS82kdkD5VdXxtM8ya5uj+r+9L2KCDDEo2HrQ+Odek=;
 b=bpb12Nmqx0XSsRjsnwcYaH+yODPFLQ6997AMjIzUDlcChr0F94HjUf3Bn1CsJ3+v3u9z5CVaoDuRSoIjZ7fkSYi33eCBfB1vMp52uIcXVigBaKNyluGoM4BSQmPxuyrxhnmjNhWqzjs6TVzLqMqM/xaxJCFyJcWNM865kXJ6jEg=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3861.eurprd08.prod.outlook.com (2603:10a6:20b:80::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Fri, 18 Sep
 2020 20:11:51 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.019; Fri, 18 Sep 2020
 20:11:51 +0000
Subject: Re: [PATCH v2 04/20] block/block-copy: More explicit call_state
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, wencongyang2@huawei.com,
 xiechanglong.d@gmail.com, armbru@redhat.com, eblake@redhat.com,
 qemu-devel@nongnu.org, den@openvz.org
References: <20200601181118.579-1-vsementsov@virtuozzo.com>
 <20200601181118.579-5-vsementsov@virtuozzo.com>
 <e0e8a810-814d-eb1c-21a7-4469451311e2@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <7f34130d-d627-59ce-b814-790fb560eb2f@virtuozzo.com>
Date: Fri, 18 Sep 2020 23:11:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
In-Reply-To: <e0e8a810-814d-eb1c-21a7-4469451311e2@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4PR0302CA0014.eurprd03.prod.outlook.com
 (2603:10a6:205:2::27) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.106) by
 AM4PR0302CA0014.eurprd03.prod.outlook.com (2603:10a6:205:2::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11 via Frontend
 Transport; Fri, 18 Sep 2020 20:11:51 +0000
X-Originating-IP: [185.215.60.106]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9dc12082-b0df-417b-7179-08d85c0f14d5
X-MS-TrafficTypeDiagnostic: AM6PR08MB3861:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB38618C5FABDD9E38F11B0C5AC13F0@AM6PR08MB3861.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UZxvu89bFTqEA3M2IUFni+1RbBDaGjJDnpEtWpr3KX9QkZASzB4zrHW7eKnU8L642Efyn7PT9t0p6mP2tiKc3lTP/E2fRpjGioVdhajzWNUEZQelIGf8pW1jXZ4px7A09z20vDNSWgA6dv6ldTIpTbIzGKT22gsr6FmJWrfCXz+hI7ES2RapXuq0VcAUg7mdjV1J6qVTjdHnSejWzIsT9WYnGFXf84cU7mUZg8aJ1qCNbSZOkimfMbWjZD+l9gcxTsGROeLZTJX8ituVFY2s+NJonQcPZhkV3vu69r7CypZgnm/LQtGwkZjHqb90kjKlH3w0xqJ4tpwWudvTwIBydE4PnfH6WA3eh2q1zysrqYt0rsnJBNFTJXUn0SpoiiIaoqhyT3DCQ61IKg9ncAwg68Y1HaPtLSGYIbtyCcTaRh7nkCeMvlx2d5mL48Dkr1hl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39840400004)(376002)(366004)(136003)(346002)(6486002)(36756003)(4326008)(2906002)(107886003)(52116002)(53546011)(5660300002)(66476007)(66556008)(66946007)(6666004)(2616005)(8936002)(31696002)(956004)(16576012)(316002)(478600001)(16526019)(186003)(86362001)(26005)(31686004)(8676002)(83380400001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: PLodIQRvpoqBST5SCB8MDhAt98PJ5GLXzJ5+m0qNLwNRtuOtR1n5H2B4JEaszGBIu/qh1UvVO2wb8KLLAFd1a/AdfbHA1aSO8UGWtm8g1NGj+n5KXEVQd/EPRFaC8k5i0ccKlJldzjcJFToYdbhKrDUfiwFx4UDVSqhJu4bTL2ATia7REnoYAJuXqP3cX1OlTq0g8F1XtiC+CxEKJ19OFpgb1bxtAXO/VXd46aCungoGL5P7dPsSG6fFrVDfYyPjFkiEA88KgEuxjXCeVZK0FxRwW809ZTPhjta7RakARTmghtbDYwLilTv6kccEzYMB2j6t9F2RgekzJOlrKz8MoaY+IO4R2YlYfYD4bLOuL1tMQUXb1uy1jPnaDg9MQ87vFwGhMOcf7ie2813fOyLpaO1+EYeIgkUiwgL3natV/OIQKUEfQFoP6rnaRbmrsLK6UQui9kvESM9SrmHrLh76oh5KSy8e6rxZNvItyQvXmmNaYmspUAKTdhSX8Vq3hPUbuIVaTahTCaOvF+L3+/sov2bPmNvdCpK3nYncmIFTu+N967eX+lK29Ymgtw6u8TDXehqABByHHBYeNj6BcS9Chea3yPZer06h9X8i5uAn7RhJkYZ07QWBt+7K2vV/Xq+J/tnvZ7FeRUR9Y0sWs2v03Q==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dc12082-b0df-417b-7179-08d85c0f14d5
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2020 20:11:51.8335 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5T+OWhouK4v3e6R4X4uZMrbx3cGW0/4AMe+L29zcjpFhELdxJh3Eo4eT/0lZcbAI/q5MEa6/h3akt8Cs9YZAgPnGKSKvKKqJa/UVReSOdQw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3861
Received-SPF: pass client-ip=40.107.6.121;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 16:11:53
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-1.869, RCVD_IN_DNSWL_NONE=-0.0001,
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

17.07.2020 16:45, Max Reitz wrote:
> On 01.06.20 20:11, Vladimir Sementsov-Ogievskiy wrote:
>> Refactor common path to use BlockCopyCallState pointer as parameter, to
>> prepare it for use in asynchronous block-copy (at least, we'll need to
>> run block-copy in a coroutine, passing the whole parameters as one
>> pointer).
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   block/block-copy.c | 51 ++++++++++++++++++++++++++++++++++------------
>>   1 file changed, 38 insertions(+), 13 deletions(-)
>>
>> diff --git a/block/block-copy.c b/block/block-copy.c
>> index 43a018d190..75882a094c 100644
>> --- a/block/block-copy.c
>> +++ b/block/block-copy.c
> 
> [...]
> 
>> @@ -646,16 +653,16 @@ out:
>>    * it means that some I/O operation failed in context of _this_ block_copy call,
>>    * not some parallel operation.
>>    */
>> -int coroutine_fn block_copy(BlockCopyState *s, int64_t offset, int64_t bytes,
>> -                            bool *error_is_read)
>> +static int coroutine_fn block_copy_common(BlockCopyCallState *call_state)
>>   {
>>       int ret;
>>   
>>       do {
>> -        ret = block_copy_dirty_clusters(s, offset, bytes, error_is_read);
>> +        ret = block_copy_dirty_clusters(call_state);
> 
> It’s possible that much of this code will change in a future patch of
> this series, but as it is, it might be nice to make
> block_copy_dirty_clusters’s argument a const pointer so it’s clear that
> the call to block_copy_wait_one() below will use the original @offset
> and @bytes values.

Hm. I'm trying this, and it doesn't work:

block_copy_task_entry() wants to change call_state:

    t->call_state->failed = true;

> 
> *shrug*
> 
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> 
>>   
>>           if (ret == 0) {
>> -            ret = block_copy_wait_one(s, offset, bytes);
>> +            ret = block_copy_wait_one(call_state->s, call_state->offset,
>> +                                      call_state->bytes);
>>           }
>>   
>>           /*
> 


-- 
Best regards,
Vladimir

