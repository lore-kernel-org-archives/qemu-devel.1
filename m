Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A22C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 18:39:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3360C20760
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 18:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="PATKxQDT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3360C20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXTsh-0000hj-2B
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 14:39:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58806)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kXTeB-0007E1-Il; Tue, 27 Oct 2020 14:24:40 -0400
Received: from mail-vi1eur05on2100.outbound.protection.outlook.com
 ([40.107.21.100]:56004 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kXTe6-0003WQ-8x; Tue, 27 Oct 2020 14:24:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZNVuEftUu1Q8gDGuJ44yzUGeGsnIarB4bPiV8a1/59XahfOXFIPQsluOuTVTwWfsYxRNLwYu8rhoYg6zReVZjzUiCV7qv77IBT2ouEWp2vyj/KgrepcXXIe0nUZdtExPx9UMk0KUxE+12vMH6I3TgWL9VBBXsYhmpvfppRdiyYAGR0o9AgKUaxGRkKa0SODSUZt699Y21jSrlZdtvFIatqyOLUL5x52mjBB7Y6p99AsgxLwWH1GS0VgB6TVZqbKCuVa9vgeuWcXOVxfv9qnXykieVP9e4+kXIacoWX82o7C1SiqEFXxI/H+w0z5wQ9pNk8vqytvovmQ3D7M1NmtSJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mY5Baws2GAhw0u4+pNA2x7ttvyvGEcl86clYaMSeqJ0=;
 b=Q3Gpv3QsDtcIz5E8tDTX0WhtDUfaLkg2FanqQRbFQA/jK0QhyVYXz6EIp3QXGqA3Nro4mDCfga8Oy9X2KKn63hOmXje1tfZ/KK4mh+zyKwr44BQK7bH7i2cFaZ0iT3uPsgvQlHL9nmE2hB9bDOE7wzT0osq7xmTSsIEbUGYjZEtzWpOOvHKIdhQoYTCd6cP5LK5MzgbIavUkeR34qAVYOqK3aCCUB8zxI533+ITTjKlCkIUNnyY05fnailmVz/Ef08O2TDhzkE3IWRnwQi8WJsniy06CRcVu9FsuwEQMis0YCtZ9iyXuBXbBmpeZY0iA/QdiBoyCgnOeuKyFIt+6iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mY5Baws2GAhw0u4+pNA2x7ttvyvGEcl86clYaMSeqJ0=;
 b=PATKxQDTewtsQOiht0wG2GTGmcFMAKzKDEQuEilh0FQqt+I78ksP9d7C3yQbq5REXUsTU5jiof1TTyeFRZLNm3akpsOidwDD/HZOzo/LklDbxAa24FSEfN8J8WVKj3iwlV8XygbzzWnseE8sFXXyAjxKv0QZYZyYRXXi/TxK/aA=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com (2603:10a6:3:89::22)
 by HE1PR08MB2652.eurprd08.prod.outlook.com (2603:10a6:7:30::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.28; Tue, 27 Oct
 2020 18:24:27 +0000
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::fd10:fc33:1bb0:1036]) by HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::fd10:fc33:1bb0:1036%6]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 18:24:27 +0000
Subject: Re: [PATCH v12 14/14] block: apply COR-filter to block-stream jobs
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, fam@euphon.net, stefanha@redhat.com,
 kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, jsnow@redhat.com,
 eblake@redhat.com, den@openvz.org
References: <1603390423-980205-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1603390423-980205-15-git-send-email-andrey.shinkevich@virtuozzo.com>
 <a8405ebc-8dc3-4520-1e35-2bae6a962f79@virtuozzo.com>
 <467434b5-abaa-fdac-bfcb-844626e1d5f4@virtuozzo.com>
 <f8a956c7-c2dc-29c7-14b4-8e0d1b2ca9f8@virtuozzo.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <e2547844-2820-11d8-749a-7c746536c6d1@virtuozzo.com>
Date: Tue, 27 Oct 2020 21:24:24 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <f8a956c7-c2dc-29c7-14b4-8e0d1b2ca9f8@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Originating-IP: [109.252.114.22]
X-ClientProxiedBy: AM4PR0202CA0014.eurprd02.prod.outlook.com
 (2603:10a6:200:89::24) To HE1PR0801MB2124.eurprd08.prod.outlook.com
 (2603:10a6:3:89::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.22) by
 AM4PR0202CA0014.eurprd02.prod.outlook.com (2603:10a6:200:89::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Tue, 27 Oct 2020 18:24:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82dc98b6-6319-411b-2b5c-08d87aa58982
X-MS-TrafficTypeDiagnostic: HE1PR08MB2652:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR08MB265256D09C5EF3E628B3B3CFF4160@HE1PR08MB2652.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:561;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aP4i1QOMnOm0nkwayi07l711Se0TM7/g+DCl418JsvPEHRURUolv/lKboHG0bS4b9HRKUxb+CxRg85227XO0GvIA6e9yDdh5zDZcrNwd2yLqegoEwNJ2H8Hpe25FrdBNZnc0rigeq+3V2RcKfCSTVRkN7fEphq2A0cWCkB+Xb+1VVWoYjC+i72y4t5PGfFuLIb0j5gEqobgfK0hkWDBpz8eI+bdsPBbkqXgWGED9MrAmOVcnnjKO5oMzTHdMyYZnRs4+ZbQqaeaiM+f065st+x/5OXVCQAPpXx0roOZadNQwZLnAsVRhbmrq6F+KFttE+RIiWNXunfKg6UGXy6LzDCufk07sxAsTYZVWEYQFe/9mM1mX4hHNFVM5xSlEc1FL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB2124.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(39830400003)(136003)(396003)(8676002)(66946007)(8936002)(2906002)(478600001)(6512007)(4326008)(107886003)(5660300002)(31696002)(316002)(31686004)(66556008)(66476007)(83380400001)(86362001)(956004)(52116002)(26005)(44832011)(6506007)(2616005)(53546011)(36756003)(186003)(16526019)(6486002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: +i6qEgvba/yXrZEutYoSV36NhK5P8ZkwmF0eBUbdrC/XMcKjnL4O07axP6swFvk7YcOt0obn4kbNLc3TvF/lRq8C5aCWSqsXIto6fuy7KC7Y+AjbMTR9vA9iDiha+6VD1YtYZzpVz/jJEUzPeCPBwp1zRQfTv/jjzWXz1a6zzd6AWAIy12ypPIsfMaaJNucFF+1SwgniCtYA5C4H4VPsC1UrK04md3mTvERMxKDNIMLfh5NBsnAH4ZUuY39YiCHTm9lHVMn6EX3wGU+y51jwccFV1PVI00Dn5kxMni5ZJyO5GGuhsrlhRUxBNrHgu+83Pun/Elty1a7XQYt+lvFXtKSN22ALmpT+28Si7hIRaHdIKiw+iOAX4bCVJSeopuQ+DMbN6mCrGZmMdRpw5lt9X5C7SdMJpiorZLB7rbxSzylXOZq1rsTYYboqEM1qyLsJcJnY2z7++Qljlghjr5mLf4neFv7tcNeWAd7uA25n+THLK+7LQtgG847HlHZSDh8ANmoH8lzgfNt+lynIRX3KCs/kzf9Ywr4gJTL/lCUkovCJRivDaRHnJm4pd+s2hawcujK1mPvFhKXSAOE2DWeO7Cj1TKmVBh5vA92xTfQGGI0H9g2VGWGtlamHfgIvMWyGojyQSW8jL1544f0fNRmCgA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82dc98b6-6319-411b-2b5c-08d87aa58982
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB2124.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 18:24:26.9566 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PM/R/acqbGVskKDwneLtS1euzp+DgHeebgHUHu/+F8QoM7oDPzsBprqUNYJscHsydSEWTiFGe+mG22T9PAAnLrWWShA3RHQGU4hhuAQS1aU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR08MB2652
Received-SPF: pass client-ip=40.107.21.100;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 14:24:29
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_LOW=-0.7,
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


On 27.10.2020 20:57, Vladimir Sementsov-Ogievskiy wrote:
> 27.10.2020 20:48, Andrey Shinkevich wrote:
>>
>> On 27.10.2020 19:13, Vladimir Sementsov-Ogievskiy wrote:
>>> 22.10.2020 21:13, Andrey Shinkevich wrote:
>>>> This patch completes the series with the COR-filter insertion for
>>>> block-stream operations. Adding the filter makes it possible for copied
>>>> regions to be discarded in backing files during the block-stream job,
>>>> what will reduce the disk overuse.
>>>> The COR-filter insertion incurs changes in the iotests case
>>>> 245:test_block_stream_4 that reopens the backing chain during a
>>>> block-stream job. There are changes in the iotests #030 as well.
>>>> The iotests case 030:test_stream_parallel was deleted due to multiple
>>>> conflicts between the concurrent job operations over the same backing
>>>> chain. The base backing node for one job is the top node for another
>>>> job. It may change due to the filter node inserted into the backing
>>>> chain while both jobs are running. Another issue is that the parts of
>>>> the backing chain are being frozen by the running job and may not be
>>>> changed by the concurrent job when needed. The concept of the parallel
>>>> jobs with common nodes is considered vital no more.
>>>>
>>>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>>>> ---
>>>>   block/stream.c             | 98 
>>>> ++++++++++++++++++++++++++++++----------------
>>>>   tests/qemu-iotests/030     | 51 +++---------------------
>>>>   tests/qemu-iotests/030.out |  4 +-
>>>>   tests/qemu-iotests/141.out |  2 +-
>>>>   tests/qemu-iotests/245     | 22 +++++++----
>>>>   5 files changed, 87 insertions(+), 90 deletions(-)
>>>>
>>>> diff --git a/block/stream.c b/block/stream.c
>>
>>
>> [...]
>>
>>>> +    s = block_job_create(job_id, &stream_job_driver, NULL, 
>>>> cor_filter_bs,
>>>> +                         BLK_PERM_CONSISTENT_READ,
>>>> +                         basic_flags | BLK_PERM_WRITE | 
>>>> BLK_PERM_GRAPH_MOD,
>>>
>>> I think that BLK_PERM_GRAPH_MOD is something outdated. We have 
>>> chain-feeze, what BLK_PERM_GRAPH_MOD adds to it? I don't know, and 
>>> doubt that somebody knows.
>>>
>>
>> That is true for the commit/mirror jobs also. If we agree to remove 
>> the flag BLK_PERM_GRAPH_MOD from all these jobs, it will be made in a 
>> separate series, won't it?
> 
> Hmm. At least, let's not implement new logic based on 
> BLK_PERM_GRAPH_MOD. In original code it's only block_job_create's perm, 
> not in shared_perm, not somewhere else.. So, if we keep it, let's keep 
> it as is: only in perm in block_job_create, not implementing additional 
> perm/shared_perm logic.
> 

With @perm=0 in the block_job_add_bdrv(&s->common, "active node"...), it 
won't.

>>
>>>>                            speed, creation_flags, NULL, NULL, errp);
>>>>       if (!s) {
>>>>           goto fail;
>>>>       }
>>>> +    /*
>>>> +     * Prevent concurrent jobs trying to modify the graph structure 
>>>> here, we
>>>> +     * already have our own plans. Also don't allow resize as the 
>>>> image size is
>>>> +     * queried only at the job start and then cached.
>>>> +     */
>>>> +    if (block_job_add_bdrv(&s->common, "active node", bs,
>>>> +                           basic_flags | BLK_PERM_GRAPH_MOD,
>>>
>>> why not 0, like for other nodes? We don't use this BdrvChild at all, 
>>> why to requre permissions?
>>>
>>
>> Yes, '0' s right.
>>
>>>> +                           basic_flags | BLK_PERM_WRITE, 
>>>> &error_abort)) {
>>>> +        goto fail;
>>>> +    }
>>>> +
>>>>       /* Block all intermediate nodes between bs and base, because 
>>
>>
>> [...]
>>
>>>> diff --git a/tests/qemu-iotests/030 b/tests/qemu-iotests/030
>>>> index dcb4b5d..0064590 100755
>>>> --- a/tests/qemu-iotests/030
>>>> +++ b/tests/qemu-iotests/030
>>>> @@ -227,61 +227,20 @@ class TestParallelOps(iotests.QMPTestCase):
>>>>           for img in self.imgs:
>>>>               os.remove(img)
>>>> -    # Test that it's possible to run several block-stream operations
>>>> -    # in parallel in the same snapshot chain
>>>> -    @unittest.skipIf(os.environ.get('QEMU_CHECK_BLOCK_AUTO'), 
>>>> 'disabled in CI')
>>>> -    def test_stream_parallel(self):
>>>
>>> Didn't we agree to add "bottom" paramter to qmp? Than this test-case 
>>> can be rewritten using
>>> node-names and new "bottom" stream argument.
>>>
>>
>> I guess it will not help for the whole test. Particularly, there is an 
>> issue with freezing the child link to COR-filter of the cuncurrent 
>> job, then it fails to finish first.
> 
> We should not have such frozen link, as our bottom node should be above 
> COR-filter of concurrent job.
> 
> 

The bdrv_freeze_backing_chain(bs, above_base, errp) does that job. Max 
insisted on keeping it.

Andrey

