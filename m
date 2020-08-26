Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A4A5C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 11:21:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41A2E20786
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 11:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="XILd9QRG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41A2E20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAtUn-0004GJ-Fw
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 07:21:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kAtU0-00033N-4P; Wed, 26 Aug 2020 07:20:48 -0400
Received: from mail-eopbgr00103.outbound.protection.outlook.com
 ([40.107.0.103]:32109 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kAtTw-00058Y-BF; Wed, 26 Aug 2020 07:20:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NS6/wmy6BzybPMjB8ftQurm8AI+QIFtVMuIA0ZDLpS4ekl/RJRR/GiAvd3zCx8DCJzj2Wg0XlYZQ7h0iXpqZE0Av6kf+qDhoUVLm0b15n6NY4HtrQ4wZ3oezbPU01OPECV91NBerjPCHlAQQqLXmvl2l348DH5GjLheyTSOHmV/yW8xBjt5i86KgMS0xn7V35n2amIqZnzvP+b/6C1bcTzrpKI/MuGeNB7h792BSO8tV5xbjJxqBrgdGfFOqeJ6Idv0bpOuO3i83SDrUkx4NEW3tceKTJ/UmWIppER8bNMAnclEmA4f8WK6zO9A0xKacH19aLyRPzic23NEtO+gO+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9uqFn+69RRHzY9XfBlJuVjkApCGL5Fk99IFo6EpveBE=;
 b=iuJnRexxtg9NG/mz6Q5JGz7sB+l+2P0gCCqVl35hqlPddtfAI9F+Qm8ONY8ouBkxcztDeCwKAaKlvY4xvVe36eNolzwC/G89p0mzY4c5iDQGNEo9horM6jDf8lEmEd41M44JbV7lKNk8s01XA/kSF1lORLACF+Hlad8z2H3UqOnbqL1dOZKOdm0oZHZ5tx3P+H2JtF/UFqpxGA9Pc1Uf5zkJbKYZi1sGuCZPdAJHWlVhAPfnxhBhrNuDaXipjrpscMwgX+HEF3pVfMGoATBq5Pd7CJgTiR2wyFglWIdh31Yajij4M7xp7Ukw8qnM6IfYEV6SSInvZmIumRaOUTZW9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9uqFn+69RRHzY9XfBlJuVjkApCGL5Fk99IFo6EpveBE=;
 b=XILd9QRGm9phMnPVTIZQ6RuwWbC4UjwQYQMBDFVYgJrCVHi6oi3m+f6qw5OOMCOsu+UjCfNEV19jYjEMesQ2L009AB3/DoGrkgaLSAVORiz8qB4h6O2KFf4rAZkJgZJO6dZUQ2ec2gMc9sCakVU+G8KoG/JsTSv53sbYuyxRysk=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3093.eurprd08.prod.outlook.com (2603:10a6:209:41::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Wed, 26 Aug
 2020 11:20:35 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%9]) with mapi id 15.20.3305.032; Wed, 26 Aug 2020
 11:20:35 +0000
Subject: Re: [PATCH for-4.2 v2 3/3] block/file-posix: Let post-EOF fallocate
 serialize
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 "Denis V . Lunev" <den@openvz.org>, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Anton Nefedov <anton.nefedov@virtuozzo.com>
References: <20191101152510.11719-1-mreitz@redhat.com>
 <20191101152510.11719-4-mreitz@redhat.com>
 <d85c544c-70c0-6860-0b5c-a2d46d740d1c@virtuozzo.com>
 <de210b71-47e9-e119-3ab9-1dbf0812a4b6@virtuozzo.com>
 <ea6e644b-2e02-9317-8eac-14ae404df0e6@virtuozzo.com>
Message-ID: <69095367-0d24-c08d-12d7-c1d1c8fc32ce@virtuozzo.com>
Date: Wed, 26 Aug 2020 14:20:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <ea6e644b-2e02-9317-8eac-14ae404df0e6@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0025.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::12) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.171) by
 FR2P281CA0025.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.10 via Frontend Transport; Wed, 26 Aug 2020 11:20:35 +0000
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3dd15b44-4e6b-4a52-c0b9-08d849b20dc8
X-MS-TrafficTypeDiagnostic: AM6PR08MB3093:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB309382E396EAE28277382E51C1540@AM6PR08MB3093.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:235;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q1L4Cv5rgE5qWpKZqfTl4jp1nNZK1vVlnrE8ghMHi0gL17MQLQrwCG6ZGGwF8qzW+ahShrGJh7WgfCZT03uGAOMZ/+St6+7ni1X8xtpvHjtn3ImKk/jEXJiMGItMaoAwdo5K+cYDqqoSu/VOGXw46N+uSbJXQW23e1wXbwgUgCARTWMKwvuEmLl+fvjm/oDqmqyTGmimELc/Z67i0gx3WAKiAba8hb6+iV9uvDyfG7WbRAxHGA3hHmpCPHfzJGJnnZ+jvgZCR9wIZnLsR4lB4LO1BiHw3+fazSgZ3E+zUXPsvRd1Gn310toy3LYcblEBs3cG24jp6fSYQJmQ8EQQrohTpvdogouC8o7Yasi2fG8GmLLqfVk+D/m0hg1t8sWx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(396003)(366004)(39840400004)(956004)(6486002)(5660300002)(4326008)(107886003)(31696002)(86362001)(16576012)(2616005)(83380400001)(8676002)(31686004)(316002)(16526019)(478600001)(26005)(66476007)(66946007)(66556008)(186003)(36756003)(52116002)(8936002)(2906002)(54906003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: dn0rKYhWt4QuOi0+4q/YUOegLYGQp/dI4vUxtj3nQxrrXqOjs+L5BO/XGGxzIJLXayWk3pd5AJdlBoEh0YW8p+dC9gaZXqDyhbfCVsPJ+yQVQRiS+TS1rdQrs4xaCOcV39TavkqfC6Y0NHZkj/lbl64OQUJd7Q4fRk4Ujgv1JOGSC4z3hGBn6xO/nKCQf3Hey9oLDZsRNDG/KCHz6zVBu8c89CpujkwNul/gbX43R4GvWa5HIBao6EMeNJ2UPiWS7eMs0DORaq6Vt44x4ngTQbGIKZr3PKZ7BUZtQ/ZU4pvMbHnN3sXwvczffb1ci1fk+MwtrPsq0cX8JG9FtjOHdQb0AdLB5dR7R+PS1Ta70bAD0VpTO/P4vCvcJZiz2oToUtviwMqdt1oFomnQTDULAhYH9hesp1ViuZbHQjdfuiKQ9SQFy5e4SHd9mzV7Ya+PBBhzfLMFolJAY90RFgP6GeCzQkBAkrhEKYkY8ycOgrkMfTOZ9bPhkohECEMyBkSq4svaF0Wqt53dUlK1zejimYLeTll9AW1QHYGcQvuOZ7f7osDB0Zq4qEgC3Op73fBJDDpjOw8LTXJRSTmrwFt7XiFHT7nrl1WT0BPJ28EbeOa/QfNmbhZ6kj7kHbQ9F4TbVZwneCZzolsj6xqJ//Ouag==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dd15b44-4e6b-4a52-c0b9-08d849b20dc8
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2020 11:20:35.8794 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: loAVsofvyXIp2w7xdgzqeVMkgKjuzYP5ug245FQNVLxbt+elTusF5eGxPDGq2WAh7zIR7q9HHl8heQTSbtNv5kpM01qrtQtFjXR8HbhEWfc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3093
Received-SPF: pass client-ip=40.107.0.103;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 07:20:40
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-2.239, RCVD_IN_DNSWL_NONE=-0.0001,
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

26.08.2020 11:23, Vladimir Sementsov-Ogievskiy wrote:
> 22.08.2020 20:04, Vladimir Sementsov-Ogievskiy wrote:
>> 22.08.2020 20:03, Vladimir Sementsov-Ogievskiy wrote:
>>> 01.11.2019 18:25, Max Reitz wrote:
>>>> The XFS kernel driver has a bug that may cause data corruption for qcow2
>>>> images as of qemu commit c8bb23cbdbe32f.  We can work around it by
>>>> treating post-EOF fallocates as serializing up until infinity (INT64_MAX
>>>> in practice).
>>>
>>> Hi! I'm doing some investigation, and here is an interesting result:
>>>
>>> Consider the following test:
>>>
>>> img=/ssd/x.qcow2; ./qemu-img create -f qcow2 $img 16G; ./qemu-img bench -c 50000 -d 64 -f qcow2 -o 1k -s 64k -t none -w $img
>>>
>>>
>>> Bisecting results changes between 2.12 and 5.1, I found the following:
>>>
>>> 2.12: ~20s
>>>
>>> ....
>>>
>>> c8bb23cbdbe32 "qcow2: skip writing zero buffers to empty COW areas"  -> becomes ~12s  [1]
>>>
>>> ....
>>>
>>>
>>> 292d06b925b27 "block/file-posix: Let post-EOF fallocate serialize"   -> becomes ~9s  [2]
>>>
>>> ....
>>>
>>> v5.1 ~9s
>>>
>>>
>>> And [1] is obvious, it is the main purpose of c8bb23cbdbe32. But [2] is a surprise for me.. Any ideas?
>>>
>>> ===
>>>
>>> just to check: staying at c8bb23cbdbe32 I revert c8bb23cbdbe32 and get again ~19.7s. So [2] doesn't substitute [1].
>>>
>>
>> Note, it's all ext4.
>>
> 
> 
> Let's go further:
> 
> If I add -n, to use aio native:
> ./qemu-img create -f qcow2 $img 16G; ./qemu-img bench -c 50000 -d 64 -f qcow2 -o 1k -s 64k -t none -n -w $img;
> 
> Then this patch doesn't have such effect..
> 
> But if consider the test without an offset on hdd, the effect is very significant:
> 
> ./qemu-img create -f qcow2 $img 16G; ./qemu-img bench -c 45000 -d 64 -f qcow2  -s 16k -t none -n -w $img;
> 
> v2.12 ~10.4s
> c8bb23cbdbe32^ ~10.6s
> c8bb23cbdbe32 qcow2: skip writing zero buffers to empty COW areas: ~16.7s : degradation!!!
> 292d06b925b27^ ~16.4s
> 292d06b925 block/file-posix: Let post-EOF fallocate serialize: ~7.6s: great improvement !
> 

Hmm, a bit more accurate results (use separate partition on non-root hard drive). I post just numbers I get from iterations, not calculating the average.

v2.12.0 9.227 8.999 9.059 8.793
c8bb23cbdbe32^ 9.264 8.996 8.969
c8bb23cbdbe32 20.694 16.050 15.898 15.918 16.136
292d06b925b27^ 15.509 15.343 16.549
292d06b925 8.368 8.529 8.342 7.503 8.361 8.353 8.416 13.043 12.594 7.898 7.907 11.914

292d06b925 + don't-handle-alloc 18.730 9.321 9.016 9.037 18.286 18.268

(don't handle alloc is don't call qcow2_handle_alloc function which is actual revert of c8bb23cbdbe32)

very interesting..

292d06b925^ + don't-handle-alloc 9.200 9.285 9.297 9.296 9.194 9.332 9.155

-- 
Best regards,
Vladimir

