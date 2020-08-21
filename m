Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB684C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 13:43:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2DD72075E
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 13:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="FhyNj7UH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2DD72075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k97KG-00065G-VK
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 09:43:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47956)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k97JU-0005Pv-IW; Fri, 21 Aug 2020 09:42:36 -0400
Received: from mail-eopbgr150104.outbound.protection.outlook.com
 ([40.107.15.104]:19711 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k97JR-00013i-UN; Fri, 21 Aug 2020 09:42:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ev3Jp+00hTNDoageE5eHDrRBF0R9PUXWjKvxvIVe9B/SSTMvDDHRBGXjSi+jLw32prHasEuMGq0FnSeP+0yJyPrkJaR15hocwpI2AeIYWGcwYH0UjBC2uz+Pg1LBFUK7wUF7ZKaKNPDzKBubb8Ooj21F8ws4JtqXwuG8adGG//Gp6BrL3ibhatVOYBBpRZIeTP2QS8+mIiZwXfiPqu2bNB4UNJM2s1UQDCnSuH6wJhtKelwycp4qfNkSgSbWgbSYLbIhVNEZIch1rkjr9L6pFm+bPaN1vuIPmXxq+FVsul4ukyIna2jcQm5YRsxgNXyo7qzqQ4OV54VoAoWfe2/h+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bjk5hAe1yaaSXk6PABOXU9I/ztZ4Jc//4U1i1oScrtg=;
 b=nhg5RHxVaRA8tB5PJ0n7OVLAv+ZB2FSAY8MLbxgHnUtLnVabDrcNS7ba/VoXNX3VXWi2sV+t7SdAOxOcb+aPv7L/loJ3XiQDJVf2eFYi8sS92O4DdICuo7HDbkU61aIWpKeVXF6m/UdSMq/p3SHGZIsRvalN/zJ0pKTRI5/v4ByZV4m1o+GD796XbVCbg8kXqV2IhwqiFWZf/SrrIPwVGn3CSjnGAui9zqpXtWNDCewBQeYWkvZIsPf0MyVQVil54znhF+bU1Qj94buuNhDq3uvqySqnS+HSXMvWxFmkfO3KAI4usUmJqBYBdG+h6Uqu6neFqwNOoZMvNUFn7+fQXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bjk5hAe1yaaSXk6PABOXU9I/ztZ4Jc//4U1i1oScrtg=;
 b=FhyNj7UHQmneeYxEVuM4zAu6oLhnnG3f+9hZ8b4658pplsRb3rs0PtsfoH054q48nMgHW5xHp9yhMgBttc6r79eypk7zIgz1gPZQJE9TehSAZqeM1sOu+c+ydgZbV6zjdF7psUqMl0l/nmTbPbJMfh/aCCBno/AhzzJGvIlJM2o=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4071.eurprd08.prod.outlook.com (2603:10a6:20b:a7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Fri, 21 Aug
 2020 13:42:30 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3283.027; Fri, 21 Aug 2020
 13:42:30 +0000
Subject: Re: qcow2 merge_cow() question
To: Alberto Garcia <berto@igalia.com>, qemu block <qemu-block@nongnu.org>
References: <b44aafbf-bd00-3bc0-68c4-5cc01a6b8b01@virtuozzo.com>
 <w51wo1si2jv.fsf@maestria.local.igalia.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <20684b8e-4f13-794a-f3d2-974ba380277b@virtuozzo.com>
Date: Fri, 21 Aug 2020 16:42:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <w51wo1si2jv.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0501CA0043.eurprd05.prod.outlook.com
 (2603:10a6:200:68::11) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.171) by
 AM4PR0501CA0043.eurprd05.prod.outlook.com (2603:10a6:200:68::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend
 Transport; Fri, 21 Aug 2020 13:42:30 +0000
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa97a090-0fd9-4479-0af5-08d845d80cec
X-MS-TrafficTypeDiagnostic: AM6PR08MB4071:
X-Microsoft-Antispam-PRVS: <AM6PR08MB407132B94DA5D6919908A10AC15B0@AM6PR08MB4071.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LqvRkHmDpJRPizOrmRPWhMFvKycOpH6SMg17dNGJKLF6F96gTNe6UakwEHV4NAPgrvP5x4RMNWc1iLrcNqe2u7zkrhObTKJDhUc+7tSw6UsJm9bcSi/dR00VYihAbaTvOZK1WugzAdho8ptbOSVnjyJJ+y+aLhWLZxGUiSpRluIW9HNg0CoRZ2PRBu4QGX5PIRrYcvwbhySOXbnxwsZw+V34uORjWmKPvOz7pghM9zXKoldqIjbDl79VyL0kmDsUmYmzBQ0CWtQ2hQaMy8gYyjxKq8K/fCoExY7GIdkYMcAlYN6IevcodZAndoY1F8yXLtpk7Q4aKuHzPiH3X1bueDKYyahIVDqUAL8urQVC51RepdA+ll4JpWtSNr7g2GCl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(366004)(376002)(39840400004)(346002)(8936002)(478600001)(36756003)(186003)(31686004)(66476007)(26005)(5660300002)(6486002)(66946007)(8676002)(66556008)(16526019)(86362001)(31696002)(110136005)(4326008)(83380400001)(54906003)(956004)(2906002)(316002)(2616005)(52116002)(16576012)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: mKGSewtMlAg/Z2a5VuvZlI5bL50AUVZNtYhTZkMWhHGARr6+noOItKekhy9A/r1udyu9l3Xo8C4yK/XLl3Rvo1AeoFCnaaQXuAFQbbIt+iesgYtmbZQxp1n+eQny9hjIz0M/knflgMsX8GlUBQaIPyyFjyJnkFYhnWdfiqW846dc8vO4fvHntEtst/VkMQrAPwQzuKg6mvVkN69eZfwYuTTrEj2zsa6y392QoLYky8Nm62+B1gmqCb/nbXdwTQb/2KES1mBc/ElyqC7Sge4X7FZVF/hZNUryaBkTtCqtVfF2Q4ktwdkmWPN0nyYyDLgkfNE75tahI8ZTln83trhxtlXm9z7uIkmBFo09utFdrNMrW0zC1ljE35/j+KcZAC8asFLHM5gfxMtQe5hkqjW1jVYkCY5tiC8tzwgZiS0uHBchAOS3Pwc+ECKosqZexd2V9MQt5kR7HBP4eqWwG3K5zAiqx/Oy6DY5ggUpOQvLeo3njnpzcuJGgYpWIgd5qQJC0xHt3N96e69f3TZLvMWWUNgE1QY3efgJSwrAV02GoRQn6QIbyLB+utZKAgBhHPdA5CfbUNnEv0fMqcpN7jiUdvkrl3RApuIP8XWOY9Wi58DPLi96ZLXJPOP93O0iCSqMZq0UqCf3jP2oQCFGjtGTdg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa97a090-0fd9-4479-0af5-08d845d80cec
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2020 13:42:30.6337 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m3q2bNgNa0Jjyclgx18ddNrmRobv4u+wSXU4gu/UJ/XqBdfHZSCYFx53RSHEAjflo3QC6OGq8Vz0mrBBM/628Ml9Ryc1Vaw4Ek3lZAo97mc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4071
Received-SPF: pass client-ip=40.107.15.104;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 09:42:31
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

21.08.2020 15:52, Alberto Garcia wrote:
> On Fri 21 Aug 2020 02:32:00 PM CEST, Vladimir Sementsov-Ogievskiy wrote:
>> Hi!
>>
>> I'm sorry, I feel I already asked about it, but can't now find the answer.
>>
>> What are these ifs for?
>>
>>             /* The data (middle) region must be immediately after the
>>              * start region */
>>             if (l2meta_cow_start(m) + m->cow_start.nb_bytes != offset) {
>>                 continue;
>>             }
>>                                                                                                             
>>             /* The end region must be immediately after the data (middle)
>>              * region */
>>             if (m->offset + m->cow_end.offset != offset + bytes) {
>>                 continue;
>>             }
>>
>> How is it possible that data doesn't immediately follow start cow region or
>> end cow region doesn't immediately follow data region?
> 
> They are sanity checks. They maybe cannot happen in practice and in that
> case I suppose they should be replaced with assertions but this should
> be checked carefully. If I remember correctly I was wary of overlooking
> a case where this could happen.
> 
> In particular, that function receives only one data region but a list of
> QCowL2Meta objects. I think you can get more than one QCowL2Meta if the
> same request involves a mix of copied and newly allocated clusters, but
> that shouldn't be a problem either.
> 
> Berto
> 

OK, thanks. So, intuitively it shouldn't happen, but there should be
some careful investigation to change them to assertions.

I think that the list actually may contain not more than 2 entries.
So the whole diversity is that we may have both cow regions in one
meta, or in two separate metas.

-- 
Best regards,
Vladimir

