Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B912FC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 10:31:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 739362076A
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 10:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="aG17coLM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 739362076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiF4A-0002lo-I2
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 06:31:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55284)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jiF3Q-0002FG-03; Mon, 08 Jun 2020 06:30:56 -0400
Received: from mail-am6eur05on2119.outbound.protection.outlook.com
 ([40.107.22.119]:51296 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jiF3M-0001Zl-Pp; Mon, 08 Jun 2020 06:30:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=etZASq2GHoe63pN+iVseqq2Q10t7ym59mJgtuD04TuupZwjq3XiQjKG3a1+SDap7MgEia8uB7LwBNmAZ34+SB1HpLXyKTE3zsFvqK/ks2SN7M4qs/nud3LN6l7gteon/oTSwHTF6AavqSnus36lstStKMyYvrRYbAAKOY3lADtxuN3eI4M8aG+UwylmRSLflw/joOaaf00bFzDBtIXT/UxsqOqySu2nGPiNTN94ZspJMQeUiNuggGLQ3roafB1PqekWMG/+Fsg82F3/nhNnVdJKc1pwDMp1hOvRzADN73z4VvRhlmDkzOzZ6tNtMQ3EXtJS9ZIwmXi4yC8PDfNJWfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KxMYadUxHbvp90he0x/D7XTexrSzdnfS2sYqTBqQHms=;
 b=LSOAlc33zMVotNfvQyYq+NaGZ7GDePuUsFVIwLyBPE1JGr6ftZLPo3gh2fDsP+BiQYyEnQsyUuIJ4u1p8TepZu4e2rZSQpWQR9q0WE0QQ6J72WGM4PqyfSyRGxo8w+wrkYLCz3nmh3yWR5QH9y/u7m2dWFMaM3I39uMj+YAbS3t9xYeOeIaphrlzfOUpBwWNTsKhcpJ7beIQTS54WZmRSvsckC07LFPbSuWstpXRN34rzpu7vlMuyds7IaVWddUpoEzvR5nUQc9lf+HW15EjhN0NRteY94Tfk1+9uL2A9WeIJw8nSuViFZ9wqHYZgXFHj4+wGWY1ZMXqTFSgp5GXqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KxMYadUxHbvp90he0x/D7XTexrSzdnfS2sYqTBqQHms=;
 b=aG17coLMB/bjgyiNLCgDYlw/F1TUV+TRQ+26fJLe8NGtJ70iqWJ6MSMrILfA7Ydlgb2++NMjg+x8zrXMxOh+M+zHdbIWjC47WCGIoj1rqVAtdnXNlzz4VH5l2U+Ng7DJ/wpMoDlGb2yshicyXoB5Ygneef9fsv2Bh6Je0VQvBPo=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5480.eurprd08.prod.outlook.com (2603:10a6:20b:de::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Mon, 8 Jun
 2020 10:30:50 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 10:30:50 +0000
Subject: Re: [PATCH RFC v2 1/5] block: add bitmap-populate job
To: Peter Krempa <pkrempa@redhat.com>
References: <20200604091651.GF2995787@angien.pipo.sk>
 <20200604113145.GE4512@linux.fritz.box>
 <20200604162237.GA22354@angien.pipo.sk>
 <20200605090123.GD5869@linux.fritz.box>
 <20200605092403.GB22354@angien.pipo.sk>
 <20200605094407.GG5869@linux.fritz.box>
 <20200605095810.GC22354@angien.pipo.sk>
 <20200605100747.GH5869@linux.fritz.box>
 <20200605105902.GD22354@angien.pipo.sk>
 <e0d889a2-2a52-1c3f-89fb-55a41dc6d226@virtuozzo.com>
 <20200608093812.GA400568@angien.pipo.sk>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <f6be06b3-fc18-0adf-51b9-c69138ce2906@virtuozzo.com>
Date: Mon, 8 Jun 2020 13:30:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <20200608093812.GA400568@angien.pipo.sk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0005.eurprd04.prod.outlook.com
 (2603:10a6:208:122::18) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.154) by
 AM0PR04CA0005.eurprd04.prod.outlook.com (2603:10a6:208:122::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend
 Transport; Mon, 8 Jun 2020 10:30:49 +0000
X-Originating-IP: [185.215.60.154]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2df83a9-759e-485f-89fb-08d80b97036b
X-MS-TrafficTypeDiagnostic: AM7PR08MB5480:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB54805DC4396E1A6CB2AB94F4C1850@AM7PR08MB5480.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 042857DBB5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EDoDqebmvhezT2iiPr4BKje8YH3nMvlTJ5DSeB3wlbE16FBdAMuT4G+GASEolti5km73qG0+UvxlW+0sg3ha+0mjSmrRs1w6Lo7AHRwpPKEUf1y+N40jwZu2RN2MvW/QmRvSlcdS8zleJ/au9a8UpipWLB6kooH1f+HQcEsxVMDTyUwMMBU4g796cjrlu25mFqT2du6QziUwdqHZSRubTHCJv3TGUgpAzLw0EU6ECsoSLFYbhjEQW+1VLxADUWKV+nA0g3h9IWcoYgJO3ZV/oY4kjGcVtBHRmawlZCIwNjGzTao+6Dd10ao5Uxn4e2GgAsIo+3w6cns/jpkYuh3FBDJtOu1S2QHxnoviDxpQeI3Zq4n0b9AT5G3wzCaYtDeG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(346002)(376002)(39840400004)(366004)(136003)(316002)(86362001)(2616005)(956004)(26005)(16576012)(7416002)(186003)(53546011)(54906003)(478600001)(16526019)(8936002)(5660300002)(8676002)(6916009)(52116002)(83380400001)(6486002)(66946007)(66556008)(31696002)(2906002)(30864003)(31686004)(36756003)(4326008)(66476007)(107886003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: OExa578OiG9gYH4lz9RJKDyS4eTg4euyBiuJHgjsDgMCj3/9xGnIH1LHeQDgjBNbHUy+WThYjUr0Pg5RNfmIwBQOqHdhAXGojTC14MM5ncpYgaYXlzh6m3ibpnvjl6AcNf9EuFGQ4WTJFMHm2qeXjnScvVcGf2dXg0o4TMjVaFaVOl8o6FxBa7otzEsOXeQ5pBzUFwf2MA8i26k6JdfB4YPYKIJDkwZ+TR8YWpG+F65vXLe197Ygz46Zl/m0yuiLVDgOnz9ESOkuafTNsy93akZ8rggcgymsW0bRLKM4yIydyzotX7/BP+EgQalBAefoJJ+N2esZ1bD7ROi/tPFoI+SC3/P6XS4KbZ1tj4smynXnqdwqfXj3SKwi1PuDqfkZao1ddB53RolVuF7+Bu2lDXjTxchgKQAXNarHXo+RN0+DF3QkmG6Px2oiFwmLP6AK9nbh65BL0qrcgeKTQj97MgnugzmfMgfsbUE+xKMEGuW/0m+nuxXPutIQDGsqcqvV
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2df83a9-759e-485f-89fb-08d80b97036b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2020 10:30:50.0063 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8gAvEfu3h0qbmJ2zJTfMyA6W5G5Z/uDtNkb8PkXJbw1PM3wOfak9n1wNQVWgg022SnagaGR7G1upmOgL2y8usUQLqU6DbZta3jIEOv+TyS0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5480
Received-SPF: pass client-ip=40.107.22.119;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 06:30:50
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Nikolay Shirokovskiy <nshirokovskiy@virtuozzo.com>,
 Cleber Rosa <crosa@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

08.06.2020 12:38, Peter Krempa wrote:
> On Sat, Jun 06, 2020 at 09:55:13 +0300, Vladimir Sementsov-Ogievskiy wrote:
>> 05.06.2020 13:59, Peter Krempa wrote:
>>> On Fri, Jun 05, 2020 at 12:07:47 +0200, Kevin Wolf wrote:
>>>> Am 05.06.2020 um 11:58 hat Peter Krempa geschrieben:
>>>>> On Fri, Jun 05, 2020 at 11:44:07 +0200, Kevin Wolf wrote:
>>>
>>> [...]
>>>
>>>>> The above was actually inspired by a very recent problem I have in my
>>>>> attempt to use the dirty bitmap populate job to refactor how libvirt
>>>>> handles bitmaps. I've just figured out that I need to shuffle around
>>>>> some stuff as I can't run the dirty-bitmap-populate job while an active
>>>>> layer commit is in synchronised phase and I wanted to do the merging at
>>>>> that point. That reminded me of a possible gotcha in having to sequence
>>>>> the blockjobs which certainly would be more painful.
>>>>
>>>> It would probably be good to have not only an iotests case that tests
>>>> the low-level functionality of the block job, but also one that
>>>> resembles the way libvirt would actually use it in combination with
>>>> other jobs.
>>>
>>
>> Hi! Sorry me missing the discussion for a long time.
>>
>> About new job semantics: if you create temporary bitmaps anyway, I do think that we should allow to populate into target bitmap directly, without creating any internal temporary bitmaps. I suggested it when reviewing v1, John argued for more transaction-like semantics to look like other jobs. Still, we can support both modes if we want.
>>
>> Allowing to use one target for several populating job is an interesting idea. Current series does "bdrv_dirty_bitmap_set_busy(target_bitmap, true);", which forbids it.. Hmm. If we just drop it, nothing prevents user just remove target bitmap during the job. So, we'll need something like collective-busy bitmap..
>>
>>> I certainly can document the way we'll use it but that in turn depends
>>> on how the job behaves.
>>>
>>> With the current state of the job I plan to use it in two scenarios:
>>>
>>> Preface: I'm currently changing libvirt to use one active bitmap per
>>> checkpoint (checkpoint is name for the point in time we want to take
>>> backup from). This means that a layer of the backing chain can have
>>> multiple active bitmaps depending on how many checkpoints were created
>>> in the current top layer. (previously we've tried to optimize things by
>>> having just one bitmap active, but the semantics were getting too crazy
>>> to be maintainable long-term)
>>
>> Hmm. I had a plan of creating "lazy" disabled bitmaps, to optimize scenario with one active bitmap, so that disabled bitmaps are not loaded into RAM on start, but only on demand. But how to do it with "many active bitmaps" scenario? I don't think that's a good idea.. Possibly, we can implement laziness by internally make only one active bitmap and merge it here and there when you request some active bitmap which we actually didn't load yet..
>>
>> Could you describe, what is the exact problem with "several disabled - one active" scheme, and how is it solved by "several active"?
> 
> The 'several disabled one active' semantics _heavily_ depend on metadata
> which must be tracked outside of qemu and is more prone to break. If any
> of the intermediate bitmaps is broken or missing everything breaks.
> 
> Then there's the complexity of the code which handles merging of the
> bitmaps during block jobs. Jobs such as blockdev-mirror in full mode and
> block-commit squash together the data and we need to do something about
> the bitmaps for the backups to work properly afterwards.
> 
> Without considering overlays which were created without propagating
> bitmaps, the code was already getting hairy especially in the case of
> backups where we needed to stitch together bitmaps for all the bitmaps
> corresponding to the given point in time where the backup is taken from.
> 
> When we add overlays without any bitmaps into the mix the code for
> resolving which bitmaps to merge the code is becoming very unpleasant,
> hard to understand and maintain and that is the main point for the
> switch.
> 
> I don't want to add unnecessary complexity to the libvirt code which
> will make it more fragile or hard to understand and fix in the future.
> 
> Both points which I heard for now (performance, and backup granularity
> in case of non-default qcow2 block size) don't seem compelling enough to
> me to make my life of implementing the feature in libvirt so much
> harder.
> 
> Also users really can just remove the point in time they wish to backup
> from after a successful backup which will also remove the corresponding
> active bitmap.

That's all is reasonable enough..

Than, we really need to refactor the code around bitmap support. Currently we
do keep all active bitmaps in RAM and update them in a loop on each write.
But it's obvious, the we can keep only one (with smallest granularity of existing
dirty bitmaps) to track guest writes.

> 
>>> Bitmaps are no longer propagated over to upper layers when creating
>>> snapshots as we can use block-dirty-bitmap-populate instead.
>>
>> Unexpected turn. When all this topic only started, it was reasoned more like "if user forget to create bitmap at start, let's help him".. But now it becomes the common scenario. Hmm.
> 
> It's not only a "user forgot" thing, but more that a systemic change
> would be required.
> 
> Additionally until _very_ recently it wasn't possible to create bitmaps
> using qemu-img, which made it impossible to create overlays for inactive

Didn't you consider to use qemu started in stopped mode to do block
operations in same manner as for running vm? What's wrong with it?
Also, there is qemu-storage-daemon, which is developed as separated
binary, where block-layer is compiled in together with QMP interface.

> VMs. Arguably this has changed so we could require it. It still adds a
> moving part which can break if the user doesn't add the bitmap or
> requires yet another special case handling if we want to compensate for
> that.
> 
> As of such, in libvirt's tech-preview implementation that is present
> currently upstream, if you create a qcow2 overlay without adding the
> appropriate bitmaps, the backups simply won't work.
> 
>> What do you think of granularity? We in Virtuozzo use 1M cluster as a default for qcow2 images. But we use 64k granularity (default) for bitmaps, to have smaller incremental backups. So, this is advantage of creating bitmap over relaying on block-status capturing by block-dirty-bitmap-populate: you don't control dirtiness granularity. So, I think that bitmap propagation, or just creating new dirty bitmap to track dirtiness from start of new snapshot is better.
> 
> This is a valid argument. Backups in this scenario will be bigger. I
> still don't feel like the code needs to be made much more complex
> because of it though.

May be, there is a simple solution? an option for blockdev-snapshot-sync to create a bitmap in a new image (or if you create image by qemu-img, just create bitmap by qemu-img as well, using new functionality).

Isn't it simpler than to just use existing block-status-bitmap, than run a job?

> 
>>> 1) backup
>>>
>>> Prior to doing the backup I'm figuring out the final backup bitmap, this
>>> involves creating a temporary bitmap populated by the job for every
>>> layer of the backing chain above of the one which contains the bitmap we
>>> want to take a backup from and then merge all of them together as a base
>>> for the backup.
>>
>> (just thinking out loud)
>>
>> So, assume the sequence top -> middle -> base
>>
>> If we have a backup, which was done when we were in base, than bitmap is stored in base. And  is loaded, and is active, but don't changes really, as base is opened read-only.]
>> We merge block-status information of top and middle together with this bitmap, and aggregate difference between last backup and current state.
>>
>>>
>>> 2) blockjobs
>>>
>>> Note: This is currently an outline how the things should be as I've hit
>>> the snag with attempting to run the population jobs during 'ready' state
>>> of a active-layer block-commit/blockdev-mirror job only an hour ago and
>>> I need to change a few things.
>>>
>>> 2.1) active layer block-commit/blockdev-mirror
>>>
>>> When the job reaches 'ready' state I'll create bitmaps in the
>>> destination/base image of the job for every bitmap in the images
>>> dropped/merged (we use blockdev-mirror in full-sync mode) by the
>>> blockjob. This will capture the writes that happen after 'job-complete'.
>>>
>>> The job will then be completed and the 2.2. will be executed as well.
>>
>> So, the aim is not to miss any new writes after switching to new bs, but do not capture into bitmaps writes which are copying the whole disk during mirror.
>>
>>>
>>> 2.2) non-active commit and also continuation of active layer block-commit/blockdev-mirror
>>>
>>> After the job is completed succesfully I'll create temporary
>>> non-persistent bitmaps for/in the images removed by the blockjob and
>>> merge them into the destination image's bitmaps depending on their
>>> original location in the backing chain so that the bitmap state still
>>> properly describes which blocks have changed.
>>
>> I don't follow. How do you populate these new temporary bitmaps? They are empty after creation..
> 
> With the 'block-dirty-bitmap-populate' block job.
> 
>>> After that the original images willbe blockdev-del-eted. The above is
>>> partialy in use today and since the job is already completed also
>>> requires blockdev-reopen to successfuly write to the bitmaps.
>>>
>>> ----
>>>
>>> While writing the above down I've actually realized that controling the
>>> destination of the bitmap might not be as useful as I've thought
>>> originally as in 2.2. step I might need the allocation bitmap merged
>>> into multiple bitmaps, so I'd either need a temporary bitmap anyways or
>>> would have to re-run the job multiple times which seems wasteful. I'm no
>>> longer fully persuaded that adding the 'merge' step to the dirty
>>> populate blockjob will be the best thing since sliced bread.
>>>
>>
>> What is 'merge' step?
> 
> In some previous replies to Kevin, we discussed that it might be worth
> optimizing 'block-dirty-bitmap-populate' to directly populate the bits
> in the target bitmap rather than after the job is complete, so
> efectively directly mering it. I probably described it wrong here.
> 
>> Do you mean that populating directly into target bitmap is not really needed?
> 
> I need the bitmap populated by 'block-dirty-bitmap-populate' to be
> merged into multiple bitmaps in the new semantics. If the job itself
> doesn't support that sematics, changing it to just to directly populate
> one bitmap doesn't seem to be worth it since I'll be using intermediate
> bitmaps anyways.
> 

Hmm, if the main use case of populating job is to merge changes since snapshot to several bitmaps (all active bitmaps?), than I think it's correct to implement exactly this semantics, allowing a list of targets as well as list of source bitmaps. We even can reuse same structure for target-list which we use for source-list. And it's simple to implement in Qemu.

-- 
Best regards,
Vladimir

