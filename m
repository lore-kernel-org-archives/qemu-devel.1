Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70103C433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 15:46:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6884C205CA
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 15:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="vROJNum9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6884C205CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTRwW-0002Ua-AD
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 11:46:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kTRvA-0001sZ-8o; Fri, 16 Oct 2020 11:45:32 -0400
Received: from mail-am6eur05on2106.outbound.protection.outlook.com
 ([40.107.22.106]:34848 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kTRv7-0003ff-9v; Fri, 16 Oct 2020 11:45:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S5qSHIRqaw7PG0Rno4FVKkMG2b57/7l/a55gJmLPAhJg1LKs1HdsKpGO+HNAuS/7hrp6e1esC+reBdDeKHRo38b1BR4RHoUD/GoGKl8oCXtUBF4KcfaEeR1XB184ALGYpFOjgUhlH6RfJ3w/P5aYN80lZk75lvkPUYhaHpT1ygzLI6TwBHAC8KSqRjmI8rLoR4Xj5DWLDoMvVan0iHSsr0n1c1B+WvQ8GJvNsds0rK9/bDmViVGE/NiKFcyA0Kjkl6/0cpm9hrfTTVYM9uhkLXc3lLrqcCsIqZolqCbAPIzXVkVzhvyOsVFreLcqRfjkkkoaqoZEisyViyVmz2XItQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NKNqsPc1rKalv5052wRkREytCcnYwXZhJotvzp7lmL8=;
 b=D2+B+Xaikz3e1mlrN1legUjLUDmJdjuyzvS3zSQuRZ29FZRYk/yf6L9mU4HsAwmUbK1wCjM2n+aKsk5CDWBJYy5rIgns+6SkSF/w9CmbqLT7W9B7QF0Z1Ywwmw7iwabWP/Pr2W4ord4jFsM1aLAhne7FCzhhuLd+R5VMOWjjS291ZUwIhpWpW603hKK4PDy8gTCAkabyUNuejFiLIpzkhNXZmnHEKGDuHsIKUwIYlDwHikWvOpZ+JUhecROPEYfXYtF968RIZXVh3ybrE6dlOZ59lqe28iCHKNMeLlEkWbsh2ww/DlOZkaC1sK3A2TLNB8ZoEQZ5X3t0/unZY9m3YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NKNqsPc1rKalv5052wRkREytCcnYwXZhJotvzp7lmL8=;
 b=vROJNum9a+5YLTIIr85pcsPTv4T+22m2db5UMiOubogxUvhdtra9FL19gKQJ/q2ydiTQ1qzVmOslHUW1wd+lwoBtt5REirLx49Yv9YBjbSlb3pjwcAYWSSooPVP+CUj+PwYJdn7FqfjzfDbTR/Z9cU6VOjYUyqLdlo4EeetaG4M=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4343.eurprd08.prod.outlook.com (2603:10a6:20b:ba::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Fri, 16 Oct
 2020 15:45:24 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3455.031; Fri, 16 Oct 2020
 15:45:24 +0000
Subject: Re: [PATCH v11 13/13] block: apply COR-filter to block-stream jobs
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, fam@euphon.net,
 stefanha@redhat.com, armbru@redhat.com, jsnow@redhat.com,
 libvir-list@redhat.com, eblake@redhat.com, den@openvz.org
References: <1602524605-481160-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1602524605-481160-14-git-send-email-andrey.shinkevich@virtuozzo.com>
 <6074273c-088f-069b-2a6c-aee812c3bad6@redhat.com>
 <fd2d9c80-c238-e635-d12c-f2d41b5e3dbc@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <d5e8cf09-1e39-4c85-5e23-04642322a633@virtuozzo.com>
Date: Fri, 16 Oct 2020 18:45:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
In-Reply-To: <fd2d9c80-c238-e635-d12c-f2d41b5e3dbc@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [185.215.60.69]
X-ClientProxiedBy: AM3PR07CA0114.eurprd07.prod.outlook.com
 (2603:10a6:207:7::24) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.69) by
 AM3PR07CA0114.eurprd07.prod.outlook.com (2603:10a6:207:7::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.10 via Frontend Transport; Fri, 16 Oct 2020 15:45:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 305b0028-c838-4950-7e64-08d871ea7f07
X-MS-TrafficTypeDiagnostic: AM6PR08MB4343:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4343ED7286017A78010811F8C1030@AM6PR08MB4343.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fvOx29agVcB6KcPYN+f1ktX0S5IXVQWoxj5iB5JOjXOrzsAvYoNX/0yk0tMXwsAq2FrQqqJQIGsCup4T4iN4Rb2cHUv5yuLf/GT134EM0mtSwEF2tMc+r6jea7FHTBVEUc0dL8MOvDwKnEUmHjGe4hH2yQO+v2cyvz0nPUlt7Zja75E4yo+vTrEFBn0QAflhj+3PlNSkdyHbUzPKLHtYOXitMARruVQr6QGFMq9KIuIbBxoUHTSFIJ561Mg0CMfay5XCyZUZPM6sFHHPblBWTQpxVT9z6rJqRt6QXsM/D30AoyQsO7L/jMFStbSyggVThppTtL/5FSLUvvpdJp8+yoD3filFLd9i8YYVpk2fTjStYkBhgf9Gi9Y954L1F2Z2RtUXuC4Uuwt5v44XwAXL5GW2RdJoJiGJRSuwN5+4f3k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39830400003)(396003)(136003)(376002)(346002)(8676002)(66476007)(34490700002)(66556008)(316002)(6486002)(110136005)(5660300002)(31686004)(16576012)(7416002)(36756003)(8936002)(86362001)(26005)(2906002)(31696002)(4326008)(107886003)(53546011)(66946007)(52116002)(16526019)(478600001)(83380400001)(186003)(956004)(2616005)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Sw3bmD8OlRwKecOOYNTExTaL+Pjigj+G4NS1Xw//nT0i0moKZz7bds+sh2W4Xf7QME1FpyGfMvAuQdD+d+0SRT022+gBDmGyhE2iAZ+5IWpsmmdMOIlFVRkbfChto0878Vn3fbX+8ioJzfAFh+rvQEVsntdxFm0S5h5uwCGjchr3C9wPgoeYyMD1WdTW3kJaHpicxCp3uvj2DsAg5s/QoF+T+a7GjswOg5fl35E6nTQmunp/i96kXyREBlbIhX63ffnuL/vjMxAnH7NgqCnUmVMVV9etyf9SRHzJb/oqLh9UqAeXCr/fDcu4644RbyZFJ5wkiX54hlGFILKgZguF4Chgtw0zRceX5veqvuRLrRrcfJ8/q/UCqill3qxw6SO4kk3g7DyUOp0gfpnbhGeiR0wGhpTrQVWwsGNG6ojnUPbLJyS2xrRS39/5mybqxlBhXwisltqjJy3R4Ozqsq9S1hFk8T20OeCG4jWBow0MNtB+1pPVDvvgRMc175e3JYrVn3G6BWkTEr0f/k9i0Amyd1rH0zEnvO6h+a5y4gg9D1/2juRXFVIftW14/wSQb5q8dhG0+jE9DDCOUthVHNNqCBxthkwqot9av2KWQOH5rKViMVQgo8zVOorDXlxyvqoH0PkMQkadAPLYOHZ/JLKquw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 305b0028-c838-4950-7e64-08d871ea7f07
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 15:45:24.2210 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XGo2WRiY0cRxu+PNPBhT0QuMxmYmS/VbRKmzFMdZfAoFNoQaJ5vWs+44tmNhLkpBVxm6ZJQxQiERvg73Pz/fRGvUCZ7u6tDxK+g1sfa2AC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4343
Received-SPF: pass client-ip=40.107.22.106;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/16 11:45:26
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.253, RCVD_IN_DNSWL_LOW=-0.7,
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

15.10.2020 20:16, Andrey Shinkevich wrote:
> On 14.10.2020 19:24, Max Reitz wrote:
>> On 12.10.20 19:43, Andrey Shinkevich wrote:
> 
> [...]
> 
>>> ---
>>>   block/stream.c             | 93 +++++++++++++++++++++++++++++-----------------
>>>   tests/qemu-iotests/030     | 51 +++----------------------
>>>   tests/qemu-iotests/030.out |  4 +-
>>>   tests/qemu-iotests/141.out |  2 +-
>>>   tests/qemu-iotests/245     | 19 +++++++---
>>>   5 files changed, 81 insertions(+), 88 deletions(-)
>>
>> Looks like stream_run() could be a bit streamlined now (the allocation
>> checking should be unnecessary, unconditionally calling
>> stream_populate() should be sufficient), but not necessary now.
>>
> 
> That is what I had kept in my mind when I tackled this patch. But there is an underwater reef to streamline. Namely, how the block-stream job gets known about a long unallocated tail to exit the loop earlier in the stream_run(). Shall we return the '-EOF' or another error code from the cor_co_preadv_part() to be handled by the stream_run()? Any other suggestions, if any, will be appreciated.

Just calling read CHUNK by CHUNK may be less efficient than is_allocated()-driven loop: you may end up with splitting regions unaligned to CHUNK-granularity, which would not be splitted with is_allocated()-driven loop. Current loop allows chunks unaligned to CHUNK.

So, I think, it's better to keep is_allocated() logic as is for now.



-- 
Best regards,
Vladimir

