Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F55C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 13:58:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADB5B2083E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 13:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="qbwcNMKA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADB5B2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0mar-0001Vl-SH
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 09:58:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50212)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1k0ma2-0000Zv-61
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 09:57:14 -0400
Received: from mail-db8eur05on2091.outbound.protection.outlook.com
 ([40.107.20.91]:56288 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1k0mZz-0005BX-Dv
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 09:57:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=emsOn31Wi+HejVjE6Wsjybc3Y2hgCBaM9TLQIIIAk1/z8gmTUznPLEbwzmLMv9vXIWUaEtC2dlXtwVSPTcJ2WOg8V5LyUmqSJhS0URrgdoVLzISjag7kUgUIhocqqfIS6Bh+15qjFcfMzthBPuGkpoBKFOg0Au+BUREjtfXMEMReFQrw4s0ZhzBUdOueXxfDUx71fEmQ7SVmhrq7pmKs8DcdLcNK+RMAt4XbTqA+lxpstBuWm6GyAhvZ0U8BqBdmHU9cCs/ZGVpgB5lpVRAuG4DQcztXzfkUMu9qM1tiKZgZqsxfEoXbQImnUxkLfXVzk8g6qT4f0+52Gq41Hiwj7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FWi+2njOIaVk6tD8eXpDwwPExAsOLCPGCtNlAcTuDbM=;
 b=URMAy16r778o1zVJdbZl8wLcsQCEoqqgmYtrYsaoFwqjykZoOvX3YZyKJ6Yp4dyqxejJ0clkb0qtW/7bUxLprFjoCHigcapAmbMmUDXGv5hKiuX3q8VkEJUP+DJXJc5z+Wl7lprUf85i2dsA/IP2A6UCdZmJvTmEi0VAp7Rcx19+o3ub8epS6pmozRA7xK1TV8L9mUo7Hn4PLfr3t9SsIvr0/OM4csJs73ohD43bl+Jeo4GGYq8MO4Ov+EAhz7fv9hvf0GfnKQW6CxFvjP4J2gKsREFXpxg0E1TKsfRLmXmo9SL0xBXky1WZCXC6+SKtdtMqLeHvSFuNIPGk2BpINw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FWi+2njOIaVk6tD8eXpDwwPExAsOLCPGCtNlAcTuDbM=;
 b=qbwcNMKAG9O0edtv2Xi7p8qgZYu1vIfxpRqjVk8LFLrUet6AVyw6Wo7Tx7nMK5s761cXihg1haQUKMxzb/Ae6jCkqQi2KD5DcKFgiLHZqoH8pq8JUOOO/3O03se/+cXnFGr4oxaxigWnPp0MC3S+/YuIAkXY1Mcc3y3I+8vMbkM=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (2603:10a6:208:ff::27)
 by AM4PR0802MB2290.eurprd08.prod.outlook.com (2603:10a6:200:5c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Wed, 29 Jul
 2020 13:57:08 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::5d21:ce58:6f11:b5dd]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::5d21:ce58:6f11:b5dd%7]) with mapi id 15.20.3216.034; Wed, 29 Jul 2020
 13:57:08 +0000
Subject: Re: [PATCH v0 3/4] migration: add background snapshot
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20200722081133.29926-1-dplotnikov@virtuozzo.com>
 <20200722081133.29926-4-dplotnikov@virtuozzo.com>
 <20200727164848.GR3040@work-vm>
 <092ca853-d4ec-788d-6f26-7361714b8dea@virtuozzo.com>
 <20200729132721.GF2795@work-vm>
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <aff8e9b3-797d-073a-b4b6-5bff046ff6d1@virtuozzo.com>
Date: Wed, 29 Jul 2020 16:57:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200729132721.GF2795@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR05CA0093.eurprd05.prod.outlook.com
 (2603:10a6:208:136::33) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.102] (178.34.161.51) by
 AM0PR05CA0093.eurprd05.prod.outlook.com (2603:10a6:208:136::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23 via Frontend
 Transport; Wed, 29 Jul 2020 13:57:07 +0000
X-Originating-IP: [178.34.161.51]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 894ceaa2-8905-4404-2cfe-08d833c748b0
X-MS-TrafficTypeDiagnostic: AM4PR0802MB2290:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM4PR0802MB2290B94C8BB18C235005AE3BCF700@AM4PR0802MB2290.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BJx/UgMddGRYSABZDxlFxCealq6CLdQVuDqbtbg5tY4hL/nxwnftX1b6FQuG5hBZgLBJpAqSVWG9jxyrZwjol2aVrfntzuGTVWc7H+50zzAZeyucOQoCSgmdlZu/1S3hBU2hDxXS5Z1hWS7f3C681uuBDGO20cBR9IeO8NPcmPDwxfH3wqR7YJ3fntyTVSbmwGtBvl7FwERWTGu3ykUXH2ViGE+X9/4LtIpDW4opj1yx0OIpNcEZKUxaMAzc0/P/X0i5v3VnGucnhxxgjxnmXFs0oIZ4hoMB7U4uUsecNcg5uYUWkXKqBAjdtLLBTGVH9Jpv4iKA3uPtLssWsgVvn0+CI/7aCt4k58YoWGCiiZOdmsEHe1F3PDkFHnwtZRFE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR08MB3745.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(39830400003)(366004)(136003)(396003)(8936002)(186003)(2616005)(31696002)(66946007)(83380400001)(956004)(26005)(107886003)(478600001)(53546011)(36756003)(52116002)(16526019)(86362001)(5660300002)(16576012)(6486002)(316002)(31686004)(2906002)(6916009)(66476007)(8676002)(4326008)(66556008)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 0R40ZM/baFx5LonHg/YYK82UTkmt6GvMX6IAjjTYwRwsuTTdcYnjY4/fgddIXusAgwuvI6GSzsH9kKK8RWQTpe1pCYLZ5ZhB1O8v4Fnug8Z9+qgiQgnUN0GoMOSMzRUfrIbMsctKBSecGtz3Ua1b5jxeNyD4Zh7yVp4WoMhUAU4A+jzV9clyclqWSyGlLZG+0zWzUzNCzt2WdB0sLEuONgm4d/DXz21wVZxERlD2NOuBf8e5f7Oe2cqwc5256ytJAu9kOa+/6w2uY31deCOU/3WDy+YJj4yIYv+rESMWTDalaZDjkBN9vN9eilJiVOf9NDlu7A+XhYINyLi+ZwN5TbOxJvvgEPFc88BIJZJgJSmhIHa1cOMYAvGPO1Lcj59AE9fcvG/vIG0GzE/SsGGQg41atXEbgVqrEFieFDTbQlHaJTB4NKLI5NRJkTZkSJXx6AiBJgIpsi6wgj0mMHfNoYuhBjEFuAn6g4EnJ6EWmTE=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 894ceaa2-8905-4404-2cfe-08d833c748b0
X-MS-Exchange-CrossTenant-AuthSource: AM0PR08MB3745.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2020 13:57:08.5887 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HkWg8wy7jqz6wjdVU+UBh3nTI0VX/APjlHaqACYd0db1sNBOscPLlPxsePwv6qGbOK3vbGPrfpa+6pUo0I4SdDyhTNbl4rymJ3f+JoMLJcY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0802MB2290
Received-SPF: pass client-ip=40.107.20.91;
 envelope-from=dplotnikov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 09:57:09
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
Cc: quintela@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com,
 armbru@redhat.com, den@openvz.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 29.07.2020 16:27, Dr. David Alan Gilbert wrote:
>> ...
>>>>    /**
>>>>     * ram_find_and_save_block: finds a dirty page and sends it to f
>>>>     *
>>>> @@ -1782,6 +2274,7 @@ static int ram_find_and_save_block(RAMState *rs, bool last_stage)
>>>>        pss.block = rs->last_seen_block;
>>>>        pss.page = rs->last_page;
>>>>        pss.complete_round = false;
>>>> +    pss.page_copy = NULL;
>>>>        if (!pss.block) {
>>>>            pss.block = QLIST_FIRST_RCU(&ram_list.blocks);
>>>> @@ -1794,11 +2287,30 @@ static int ram_find_and_save_block(RAMState *rs, bool last_stage)
>>>>            if (!found) {
>>>>                /* priority queue empty, so just search for something dirty */
>>>>                found = find_dirty_block(rs, &pss, &again);
>>>> +
>>>> +            if (found && migrate_background_snapshot()) {
>>>> +                /*
>>>> +                 * make a copy of the page and
>>>> +                 * pass it to the page search status
>>>> +                 */
>>>> +                int ret;
>>>> +                ret = ram_copy_page(pss.block, pss.page, &pss.page_copy);
>>> I'm a bit confused about why we hit this; the way I'd thought about your
>>> code was we turn on the write faulting, do one big save and then fixup
>>> the faults as the save is happening (doing the copies) as the writes
>>> hit; so when does this case hit?
>> To make it more clear, let me draw the whole picture:
>>
>> When we do background snapshot, the vm is paused untill all vmstate EXCEPT
>> ram is saved.
>> RAM isn't written at all. That vmstate part is saved in the temporary
>> buffer.
>>
>> Then all the RAM is marked as read-only and the vm is un-paused. Note that
>> at this moment all vm's vCPUs are
>> running and can touch any part of memory.
>> After that, the migration thread starts writing the ram content. Once a
>> memory chunk is written, the write protection is removed for that chunk.
>> If a vCPU wants to write to a memory page which is write protected (hasn't
>> been written yet), this write is intercepted, the memory page is copied
>> and queued for writing, the memory page write access is restored. The
>> intention behind of that, is to allow vCPU to work with a memory page as
>> soon as possible.
> So I think I'm confusing this description with the code I'm seeing
> above.  The code above, being in ram_find_and_save_block makes me think
> it's calling ram_copy_page for every page at the point just before it
> writes it - I'm not seeing how that corresponds to what you're saying
> about it being queued when the CPU tries to write it.

You are right. The code should be different there.
It seems that I confused myself as well by sending a wrong version of 
the patch set.
I think this series should be re-send so my description above 
corresponds to the code.

Thanks,

Denis
>
>> Once all the RAM has been written, the rest of the vmstate is written from
>> the buffer. This needs to be so because some of the emulated devices, saved
>> in that
>> buffered vmstate part, expects the RAM content to be available first on its
>> loading.
> Right, same type of problem as postcopy.
>
> Dave
>
>> I hope this description will make things more clear.
>> If not, please let me know, so I could add more details.
>>
>> Denis
>>
>>> --
>>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>


