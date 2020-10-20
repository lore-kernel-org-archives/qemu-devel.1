Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1436FC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 10:41:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 464AC22283
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 10:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="qhUJqAL6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 464AC22283
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUp5J-000365-2O
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 06:41:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45068)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kUp3c-0001uv-8t; Tue, 20 Oct 2020 06:39:56 -0400
Received: from mail-eopbgr80090.outbound.protection.outlook.com
 ([40.107.8.90]:57152 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kUp3Y-0003bQ-W8; Tue, 20 Oct 2020 06:39:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IfjnYtg2wK1SL1a2qBq70IyZGm2RblRdBWH72NDXyT1wK5qsTdPC+cqsonNN7a5A7Sq7eOtvOEcHkuRxjZZZHJwC8KbJBAAA1LLvdXQbOX5QI2v/E/GGP//+KMzBi0iKk9Fm23FFIuXwNKJ80nPe+RP0sK376UPqT79j5Cnbct2cbutovJLD1exyZj7ATcmtUBr45GOB6JwcLagNASynTM8fXogoCxU29CcOU3+trTpskAA9DRMyZmWeprakKUnw8WJtQgVIRcB/9M++hQpzz9nIhUKjP0JgXMr5c2trUlRs9Eyim3Mma5GjNEdQWTtISa1jyJIOaQx7V9igQV9OSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=csgk6mHzrpq2jF67YCXTQabVovCmFmrUGkdmNyxgH9s=;
 b=AoFanqW5ZzUSkyc3TrRf0KjI9NPiav7qLbkr+E22/U1oT+ofD2SJpPzkJiacB7VWoYmNNTqjyxsbdB83xvQxLMKcBQu1PpyaJ7qnhvzuN/wNALzyNrQXdItE7jGB6kAUNWYqGwaqqt1XnmGSB7VNLzhWSqvK3uY+HGIDNYHzd0/4+zMWSfENn55khjvYGza66HVuPustu5jQmjiZbdAZWLi1rQqdz9zLixppFpsmIu6Y3HkEtxchp8WdmhS9dWgASgCgUT6ilIA3s5OI4srly/UFSn064GHvN/H4dAzs3C9unDiaPnvMxcp4EDAfp7in655ReZQuEytyHgCAia4aTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=csgk6mHzrpq2jF67YCXTQabVovCmFmrUGkdmNyxgH9s=;
 b=qhUJqAL6MSAcoolfumC1CSbS3F9SC52WGI0M1xBcp4VAMD/12Mi3eUvZ7y1/i15RrgB64fNVdJUxsPU3iRxI3gt4qGnQ/DuQdw3PYiXe7qv8gXZKg4oxcCXMRt0fFzCht3L2mYMABFnQcE4iODmEjirfaQoqlnql3FAzFGSzT5c=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB2981.eurprd08.prod.outlook.com (2603:10a6:209:44::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Tue, 20 Oct
 2020 10:39:47 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Tue, 20 Oct 2020
 10:39:47 +0000
Subject: Re: [PATCH v3] migration/block-dirty-bitmap: fix uninitialized
 variable warning
To: Laurent Vivier <laurent@vivier.eu>,
 "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>
Cc: "mreitz@redhat.com" <mreitz@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>, "fam@euphon.net"
 <fam@euphon.net>, "eblake@redhat.com" <eblake@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>,
 "quintela@redhat.com" <quintela@redhat.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 ganqixin <ganqixin@huawei.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>, Euler Robot <euler.robot@huawei.com>,
 Li Qiang <liq3ea@gmail.com>
References: <20201014114430.1898684-1-kuhn.chenqun@huawei.com>
 <c3a75c21-d9a6-a13b-7076-936867376ac6@virtuozzo.com>
 <7412CDE03601674DA8197E2EBD8937E83B9DA561@dggemm511-mbx.china.huawei.com>
 <4f87bb6e-96ab-897c-5361-78ae9b1db7ef@vivier.eu>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <bdfcf8f1-fa9c-55e9-38ed-820b4eb8b248@virtuozzo.com>
Date: Tue, 20 Oct 2020 13:39:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
In-Reply-To: <4f87bb6e-96ab-897c-5361-78ae9b1db7ef@vivier.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [185.215.60.66]
X-ClientProxiedBy: AM4PR0302CA0023.eurprd03.prod.outlook.com
 (2603:10a6:205:2::36) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.66) by
 AM4PR0302CA0023.eurprd03.prod.outlook.com (2603:10a6:205:2::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21 via Frontend
 Transport; Tue, 20 Oct 2020 10:39:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3182341c-a1ae-41ce-556c-08d874e47724
X-MS-TrafficTypeDiagnostic: AM6PR08MB2981:
X-Microsoft-Antispam-PRVS: <AM6PR08MB2981DBB63978892C7B46B739C11F0@AM6PR08MB2981.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1169;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 786kvwzPlsVMU1gE3GGBHHvkqyQP+PlVQeWEc+s9Bls4405DExUog0MHdKBeVdPuK5li7pKlzMSa0wVG5XgTxJtpjHt3fb9eEqs8SsEFicOLB2+WSWqKEE+q6pyjeYewVUYLARLfsK41/M/IQpbyvwWvUH4OIWUsjVoE8EwBeJUUcsAJm3o7MUAV+Qxo+dqfDQ76Ecp/yqvp8gUfvXLpXd09bVKCiAYMFb6IMfL3WahRWfWSpFdxJqXpWH7Xgb6tPzoj2TPCZfYJG1G4rQOR9/f3Arw6Tjb/RIsW9pinI/SQ+56RJhRR2+l8xMS69+5UK13JCYeuWexIWUZhRvreeicDf8Whf9cB/wQ+ar3ljesmgTh+TrigCo3HSzzYEhKRDWksFvCFGzyorzUEJ8/dSA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(366004)(39840400004)(136003)(6486002)(8676002)(26005)(186003)(110136005)(16576012)(16526019)(316002)(54906003)(478600001)(7416002)(52116002)(31686004)(31696002)(86362001)(53546011)(4326008)(8936002)(2906002)(36756003)(956004)(66556008)(66476007)(66946007)(5660300002)(66574015)(2616005)(83380400001)(14143004)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: jPfErmmOZiySCxSpScEDN8CjOZnpTgps7LAOs8HAb30J60GUPokzWC1ylSyrnN6UttGIXLUujVxAT6dsIjPnt5WS2/85JjPOKRAw+gLIxoxZ6OiQFL7S7LfVudLaMtZI2FH4WSXeeVXPYf9rRiz7gNaGLH+bPw4uLIh4+rcCRf5N4EW7Wsk6DVGnWeACn5qRtRU/JOpxWTpGgh9JnPqnP5NGZvy8tqDYEzodd9o+AMAb+knZlbDx4CX9Ssxeh8gjonsqqotwwcIDPszXgw37S7K6odXFVC54VuHhoP7Y2WYq081JR6aRUZnwXQIGi/jVlO0euZyXtc2guAVkqByGtl680xD6mmfYM5Sp1sNd6jP1rnDsKa0aboiCgQivE5dWgI6fHw7pZatVRCzQkWfUdRTorkDfcLlcMd/+Jaref67FdPVnQYOh9Cwyqk6J9rT0VngBMU/4A4LvrBmZmMfmQkugxKJUChU2llmr0pxT65tVF04Sz+KnMwYGZlUhMi2tHJtBi/NsJ6Bt1F41SXpBV9QLwUbhWufvTe9yYtNfo/ktGsj18K85BZ/ojSKh47HDpwMDtl0pL729+lvh9ry299LOG1Mdz7X5fVtztuwQUy0Ki0B5moTVpb8xxCYN4he9VNo334V/+t4esE17uWKS5g==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3182341c-a1ae-41ce-556c-08d874e47724
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2020 10:39:47.5320 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aQ+F1GEvEedA+LC8BUrtKcAFAofXKQ8NC3ja0PchUKe6hsYIbv6hbCC9U1KlTf52UEukpj1xCjyhCvA5KxtCYcIXIgCdUD72IupE3ClAziU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB2981
Received-SPF: pass client-ip=40.107.8.90;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 06:39:49
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001,
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

20.10.2020 11:16, Laurent Vivier wrote:
> Le 20/10/2020 à 09:36, Chenqun (kuhn) a écrit :
>> Ping!
>>
>> Hello,
>>
>>    Maybe this patch, some people have any other suggestions?   Or, maybe missed to queue?
> 
> Hi,
> 
> As we've seen by reviewing previous versions, this change is not really
> trivial, so I will not take it via the trivial queue.
> 
> Perhaps via block I/O queue (Stefan?), Dirty Bitmaps (John?) or
> Migration (Juan?).
> 

Correct would be Eric's bitmaps tree.

> 
>> Thanks,
>> Chen Qun
>>
>>> -----Original Message-----
>>> From: Vladimir Sementsov-Ogievskiy [mailto:vsementsov@virtuozzo.com]
>>> Sent: Wednesday, October 14, 2020 11:56 PM
>>> To: Chenqun (kuhn) <kuhn.chenqun@huawei.com>; qemu-devel@nongnu.org;
>>> qemu-trivial@nongnu.org
>>> Cc: mreitz@redhat.com; stefanha@redhat.com; fam@euphon.net;
>>> eblake@redhat.com; jsnow@redhat.com; quintela@redhat.com;
>>> dgilbert@redhat.com; Zhanghailiang <zhang.zhanghailiang@huawei.com>;
>>> ganqixin <ganqixin@huawei.com>; qemu-block@nongnu.org; Euler Robot
>>> <euler.robot@huawei.com>; Laurent Vivier <laurent@vivier.eu>; Li Qiang
>>> <liq3ea@gmail.com>
>>> Subject: Re: [PATCH v3] migration/block-dirty-bitmap: fix uninitialized variable
>>> warning
>>>
>>> 14.10.2020 14:44, Chen Qun wrote:
>>>> A default value is provided for the variable 'bitmap_name' to avoid compiler
>>> warning.
>>>>
>>>> The compiler show warning:
>>>> migration/block-dirty-bitmap.c:1090:13: warning: ‘bitmap_name’
>>>> may be used uninitialized in this function [-Wmaybe-uninitialized]
>>>>          g_strlcpy(s->bitmap_name, bitmap_name,
>>> sizeof(s->bitmap_name));
>>>>
>>> ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>
>>>> Reported-by: Euler Robot<euler.robot@huawei.com>
>>>> Signed-off-by: Chen Qun<kuhn.chenqun@huawei.com>
>>>
>>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>
>>> --
>>> Best regards,
>>> Vladimir
> 


-- 
Best regards,
Vladimir

