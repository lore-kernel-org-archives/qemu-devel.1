Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC0E3C433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 12:33:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E413D206E6
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 12:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="iqASsxpE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E413D206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFGKb-0006WB-13
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 08:33:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kFGJq-0005ed-Rn; Mon, 07 Sep 2020 08:32:22 -0400
Received: from mail-eopbgr20116.outbound.protection.outlook.com
 ([40.107.2.116]:63633 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kFGJl-0001a7-0N; Mon, 07 Sep 2020 08:32:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b3D/cQb/pGVnns88uT3H9/19AKSnUVOv46Zn5bQd32JpcQ4je50FspqST1m5fZ5DzGGk6SBlvQ4LbyMeVZkQf2x6AyFTUjYDk8nJ6o2b0nN7tTfs0XXi5Nz79zf+ngfHHJK3C/OcGIArmV7OoSVaChQ2VOmbwgsxV0sV5xepZgroQqL1b+BHBjJsvGK/h/E2bCQn1PedSeuAU3MaoiENf3X1RsMiKj3GLkgdjFXqjwGdfMraMMW9Shpp+T5WXrOr5bbczRYQga+oROqyVmTmZVzo3ShdGJMXEe0egxgoaVfBUf+WK5mBSSpgC7K8yaEYc5zxk2cuieBC5apeRoSYug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3lCGA/+vt2Y7rjv2ek9vGtNAwCythjjK9yWtOvj8Ek=;
 b=nIrdMiOF+1rGkcpfKqxrJX0N4pMpiJmqgdL9ANMaAB/Dz2LWVJiYi8jdVHS2TtOExwFBSVGmWNdkgsoAsJlPOE9OxE1C+Ot4wF3rYhhpLqXxGzFU2akT2Tn4C7PsL3OEgdrRygMtNFBZYGdu7qYOZL/0qUCUirgeMYIag+TCpJjG0rA7vQZSHEBGAPvChmqF6svw4hqUY+EjszJcxjloN1/0qf+w2yT2kwIlpb2i1mbcO+ioUMMwTFMOHwJEvH49/12a3TrpQkJVZHTTh8YQN8IzGmDuqed9Ytm/VtU+Vv5hPl2P081SyJhPwwCBESmm+8VgPTsH46AvvuYFEaAtrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3lCGA/+vt2Y7rjv2ek9vGtNAwCythjjK9yWtOvj8Ek=;
 b=iqASsxpElLiLkWfhbDfhl7K8VHxnWA/dbg89A2dmnZckkVMNAWr1pKwOSD7b+Rb0dukJskEjU0W4DohwlZC61jPV5/1tgnme0HNDu/O8bp37LC9eta/d01jq5Jd2/AI1AFGlp/M1zBMr5wWhy23DCY4ldJW95/zLHsR35Y8dgZs=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4408.eurprd08.prod.outlook.com (2603:10a6:20b:be::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Mon, 7 Sep
 2020 12:17:10 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%7]) with mapi id 15.20.3348.019; Mon, 7 Sep 2020
 12:17:10 +0000
Subject: Re: [PATCH v8 6/7] block-stream: freeze link to base node during
 stream job
To: Max Reitz <mreitz@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, armbru@redhat.com,
 jsnow@redhat.com, eblake@redhat.com, den@openvz.org
References: <1598633579-221780-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1598633579-221780-7-git-send-email-andrey.shinkevich@virtuozzo.com>
 <9739719d-0681-d839-cf8d-398b78b6d323@redhat.com>
 <3a52e54e-22fe-6eee-439a-dc1db0a1bf63@virtuozzo.com>
 <a6bc0dc7-12d8-6a63-6885-2cbff7da580a@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <c691f24f-a223-f13e-2d48-9a7d1e558572@virtuozzo.com>
Date: Mon, 7 Sep 2020 15:17:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <a6bc0dc7-12d8-6a63-6885-2cbff7da580a@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0028.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::15) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.137) by
 FR2P281CA0028.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.9 via Frontend Transport; Mon, 7 Sep 2020 12:17:10 +0000
X-Originating-IP: [185.215.60.137]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 029e1971-800e-45e4-39e0-08d85327f234
X-MS-TrafficTypeDiagnostic: AM6PR08MB4408:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB44087F0551CB1BEA9BD7C6ADC1280@AM6PR08MB4408.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QMI1FmhPyUElMwy/a3SkWKXPU/QY560fq4h8DxfAo5UiIO1eMmznl7QlZlfm/pgnui6gi+wNor504aaLgI+BP//2HFculWjeIN8QT4yREsTYyCtrD5WMHESI6n5kyifZFX+oKE1AessWsefGRTTWOMjFhuuGWMpERYsd4Lvt+AOS3+GAQG3ZrGs5CkATpgykt7qGuc0QBmPPuf7pO49EZ1fzyTIOj+JgyxLQkwaiCADgAMOHCCXuluKoqgC6/mrXdS1c1p6u9KbNtMLhQ6vh38DDSwiXUzE93a/08ARmEyhcnI516C4U5PnPmkMvipPA2IbOGuAhcA3z0MOIBdBsZ7rZhvz+ABMiA5I9Cq5C2EnyFI/EM9y1NrIKKnWtZFSH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39840400004)(346002)(136003)(366004)(396003)(8676002)(16576012)(2616005)(956004)(110136005)(6486002)(186003)(53546011)(83380400001)(478600001)(26005)(16526019)(4326008)(52116002)(316002)(36756003)(107886003)(5660300002)(31696002)(66946007)(8936002)(2906002)(86362001)(31686004)(66476007)(66556008)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: NuVgigbRikpvhlCy12p917TxowGpNz4sbMMKxnVlxRZtirV1HrbQasY6YqSaJVERL1v7q2+lISpsvshpgcst3xuqEGUTX0HBa4Ys40KNVV1zIxt4thkGAws2JljV8S0IgJ/KKBM7zHLsVqPvIvXQrJxgRUYyxNzEPQjoHRdG8xa8Vum2PcUzrLv+OqAYrLuk/6NLotpf6+mUhCnqHCT2T286va4fTGKocKBdIkJXs43904Ms/sBTeSp9NHySoqm0eC8sVvbE/qky1l+eTEwD/xTW8b+ln6hpGUT+aWlJkwnXyKewIb/VehCP0KodpQagqr/WB0fv1EasXfSXfVTuMoYVWdkvqTQo0CiE5lyBIVDDY0Wi4N9nRvdU5hnjI6kR8PuH2YsdOwrT7I1jX54Z90vJBg4SEgTSec1DX2yzEhZjsISNiE+KqdWIJC8LJEyujGo1vsA3pdfRaTc+Zz/Xjf6FUF6scaWjZWXtpCNM+ou+fatQ+OBVzHh2+95EXDfGhehvtsWVJ8kSvsQTPliCAmarChzJpmMj1FL1OJUEXevViGkyy1caC83REpOlG5u0aaglTyOipqZ6zD+tEO/vzpgIznP81OoNllJbgcZ0SOrOXIEM2ItTzUNKF3WEF7d56JwWFqwXt8ayInb78LeTuA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 029e1971-800e-45e4-39e0-08d85327f234
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2020 12:17:10.6110 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mOjYyShMw2LycaPpFCOCyibPk4VAKqEAKURyf6G3yq05vQLy86yqCM1PKTNkxQaoULckMuLhjTjsqGnLoy8I4dUrUVEOGACx7KSRhEd57i0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4408
Received-SPF: pass client-ip=40.107.2.116;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 08:32:14
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-1.825, RCVD_IN_DNSWL_NONE=-0.0001,
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

07.09.2020 14:44, Max Reitz wrote:
> On 04.09.20 15:48, Vladimir Sementsov-Ogievskiy wrote:
>> 04.09.2020 16:21, Max Reitz wrote:
>>> On 28.08.20 18:52, Andrey Shinkevich wrote:
>>>> To keep the base node unchanged during the block-stream operation,
>>>> freeze it as the other part of the backing chain with the intermediate
>>>> nodes related to the job.
>>>> This patch revers the change made with the commit c624b015bf as the
>>>> correct base file name and its format have to be written down to the
>>>> QCOW2 header on the disk when the backing file is being changed after
>>>> the stream job completes.
>>>> This reversion incurs changes in the tests 030, 245 and discards the
>>>> test 258 where concurrent stream/commit jobs are tested. When the link
>>>> to a base node is frozen, the concurrent job cannot change the common
>>>> backing chain.
>>>>
>>>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>>>> ---
>>>>    block/stream.c             |  29 ++------
>>>>    tests/qemu-iotests/030     |  10 +--
>>>>    tests/qemu-iotests/245     |   2 +-
>>>>    tests/qemu-iotests/258     | 161
>>>> ---------------------------------------------
>>>>    tests/qemu-iotests/258.out |  33 ----------
>>>>    5 files changed, 14 insertions(+), 221 deletions(-)
>>>>    delete mode 100755 tests/qemu-iotests/258
>>>>    delete mode 100644 tests/qemu-iotests/258.out
>>>
>>> Does this need to be in this series?  (I’m not entirely sure, based on
>>> what I can see in patch 7.)
>>>
>>> When doing this, should we introduce a @bottom-node option alongside, so
>>> that we can make all the tests that are deleted here pass still, just
>>> with changes?
>>>
>>
>> That's a question to discuss, and I asked Andrey to make this patch in this
>> simple way to see, how much damage we have with this change.
>>
>> Honestly, I doubt that we need the new option. Previously, we decided that
>> we can make this change without a deprecation. If we still going to do it,
>> we shouldn't care about these use cases. So, if we freeze base again
>> wituhout
>> a depreaction and:
>>
>> 1. add bottom-node
>>
>>   - we keep the iotests
>>   - If (unlikely) someone will came and say: hey, you've broken my
>> working scenario, we will say "use bottom-node option, sorry"
>>   - Most likely we'll have unused option and corresponding unused logic,
>> making code more complex for nothing (and we'll have to say "sorry" anyway)
>>
>> 2. without option
>>
>>   - we loose the iotests. this looks scary, but it is honest: we drop
>> use-cases and corresponding iotests
>>   - If (unlikely) someone will came and say: hey, you've broken my
>> working scenario, he will have to wait for next release / package
>> version / or update the downstream himself
>>   - Most likely all will be OK.
> 
> Well, yes, we’ll disrupt either way, but it is a difference whether we
> can tell people immediately that there’s an alternative now, or whether
> we’ll have to make them wait for the next release.
> 
> Basically, the whole argument hinges on the question of whether anyone
> uses this right now or not, and we just don’t know.
> 
> The question remains whether this patch is necessary for this series.

Otherwise iotests fail :)

> We also have the option of introducing @bottom-node, leaving @base’s
> behavior as-is

You mean not make it freeze base again, but just don't care?

> and explaining it as a legacy option from which
> @bottom-node is inferred.  Then specifying @base just becomes weird and
> problem-prone when the graph is reconfigured while the job is active,
> but you can get around that by simply using the non-legacy option.

Hmm. Last time, I thought that bottom-node was a bad idea, as we have a lot of problems with it, but you think it should be kept as preferred behavior? But this sounds as working idea.

Then, we'll probably want to set skip_filters(bottom->backing) as backing of top in qcow2 metadata, and direct bottom->backing as new backing of top in block node graph.

Anyway, I like the idea to deprecate filename-based interfaces wherever we can.

PS: Sorry for my decreased attention to the list for last weeks, I have to finish necessary work for Virtuozzo release.

> 
> Max
> 
>> Hmm. OK, and the hard-way:
>>
>> 3. Enable all the new logic (filter insertion, freezing base, etc.) only
>> when filter-node-name option specified. And immediately deprecate
>> not-specifying the option.
>>   [Note, that in way [3] we don't need bottom-node option]
>>
>>
>>
> 
> 


-- 
Best regards,
Vladimir

