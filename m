Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530F9C433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 14:30:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B3CE2084C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 14:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="DFtVeQfm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B3CE2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTQkc-0001eg-1S
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 10:30:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kTQja-00013Y-9H; Fri, 16 Oct 2020 10:29:30 -0400
Received: from mail-eopbgr150113.outbound.protection.outlook.com
 ([40.107.15.113]:35393 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kTQiv-0000CT-1n; Fri, 16 Oct 2020 10:29:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cfad2TfkIlXkDp1V+qI9khzEPnOF9VA+IDTGEzzp/Jy5KpAXWhpTpyMGWPbwh+JMmzYK1XnVckACMAn1LBWEk/0uHnPcpD7kWlUGKolDw2vhiqRnhAntygfBbEmjv6Jrp39RP0ht3Kz8ExBEvrriGcK2CM9k48JqpxLIs7xl1hBI0lxJ54nfcNYL2Z57hFHPPsNaZVgOuIu8029qqWGuANx3NYB+XnJWsWjVg0S5SlnSEzukouxr7O5eLDASZJ2BjVQu3i6OT8gJwWFrGpLMzd0Yh4usHdJKJdZQWyJkw87scnPnYR/FGLJjGVZDRRH+Y8+u6MR/HQPcLsJECJuCnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y6L6/aThh3YITEXJ4TefxQt4bAA+McVKbTkBHpBEtk8=;
 b=J7bwN6Rfuj+n5DzeuFwQ7tJ8EwnRuQqyAYHpgpkVQ6bDIuULivZ/c3kM+hwVA9oYdAnc4wjYB4NwvhcEzXyLRKiJFjbuRdSSsXG5Zm5zjLV8JyWbnSWFf8KBvSYySVQslZvHDwRzMSKT/7kfrekuERfv5s02Ik8OsNtItWJn63x9M2lr7TuokJc4bEe1mGYLIjBRtg3OdkfAMTYGmG1tIopIQOqA/wm62dXbG9uKbrxNuKTQLzezjvdL3ZkeLmG0FGv1DK217CL9ws666VDk1+Nr21mJK634BNTWRGfvbvgIFYyhmb7gl1Oy4wrD84+BamyWUqYPNb3Bgxkr461NFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y6L6/aThh3YITEXJ4TefxQt4bAA+McVKbTkBHpBEtk8=;
 b=DFtVeQfmGnRjeARaZaPO9VQ2FcZ246DuxrTPywSFFEsqszwn89d866U79TDe6lhaINy/657MANrzAiQ4etJsGFmpkBNaI0NrmCqbQHylelVR3LJGwIjeTPu2mptv9HZaQQf9kehtFf/d3IAh/0fcA83lE50i5eDFop8XFaURd9U=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3765.eurprd08.prod.outlook.com (2603:10a6:20b:8f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Fri, 16 Oct
 2020 14:28:44 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3455.031; Fri, 16 Oct 2020
 14:28:44 +0000
Subject: Re: [PATCH v11 05/13] copy-on-read: limit COR operations to base in
 COR driver
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, fam@euphon.net,
 stefanha@redhat.com, armbru@redhat.com, jsnow@redhat.com,
 libvir-list@redhat.com, eblake@redhat.com, den@openvz.org
References: <1602524605-481160-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1602524605-481160-6-git-send-email-andrey.shinkevich@virtuozzo.com>
 <6dc38263-ad9c-f238-7197-68e920b6080d@redhat.com>
 <7b649922-6c4d-7d5f-fb52-c97c1c34b7d8@virtuozzo.com>
 <80f81abd-c810-c3a1-48aa-b1d94bdfda32@redhat.com>
 <164ef641-a6e2-5482-551b-8667b6930645@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <961f9cb6-06d5-4fe3-662a-ab9e397ec76c@virtuozzo.com>
Date: Fri, 16 Oct 2020 17:28:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
In-Reply-To: <164ef641-a6e2-5482-551b-8667b6930645@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [185.215.60.69]
X-ClientProxiedBy: AM0PR05CA0075.eurprd05.prod.outlook.com
 (2603:10a6:208:136::15) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.69) by
 AM0PR05CA0075.eurprd05.prod.outlook.com (2603:10a6:208:136::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21 via Frontend
 Transport; Fri, 16 Oct 2020 14:28:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb8c6e93-ed65-4864-aa9b-08d871dfc96d
X-MS-TrafficTypeDiagnostic: AM6PR08MB3765:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB376504FFDDFDC5D164F16A19C1030@AM6PR08MB3765.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RFNRgDxTQgWnd9DjA3vvwA2Yp4viRh6Fitl9VHefLCwrK8iO1Sx5b3wNVG9V9x077zafgaSel5ZNZ4JS/S60xKT027pKLTgsV2CKSZe90kGgIu+jUa0pRMWEfo2ZbXggpEETdnojgJUkJY8Eqv705asaUIlFtm6utK9HRXrsYWfrR3toID84IzdYyLXVqJDDnCyrSUS+b/RHJVCh8TtPmPiUBe3VrjgfEN56564JI4zVnY7Zi1bXthnn2NDHd84aUYO+o2cwYuffGLqYIZNj2FKgVTIxi5ozK4K91HSAourA1Iu50Ox+V74/Y9wMonjPyWDXrLcS/YXQFU/sySR2T6ebeuhQDf1UCTa4shjYyMsYGebFBEIXaQslXjXhfcERqPOAiNUgeP1cqlQHEgZHuYuLTPeXI2WnIhNumFiP6Hc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(366004)(376002)(396003)(39840400004)(4326008)(956004)(16526019)(26005)(2616005)(31686004)(66476007)(16576012)(110136005)(107886003)(7416002)(478600001)(6486002)(186003)(34490700002)(66556008)(8676002)(31696002)(52116002)(36756003)(8936002)(83380400001)(66946007)(53546011)(5660300002)(86362001)(2906002)(316002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: pbod7ysW5aSLS+aSsZqM4AitGognTak6zORfsDFiTG5uWXE6pflU2j2B5REspnOJLP9I4ld9DJAgsqK8/NHqCSDOxKDPXS/S1dLc7E593/CzkrYbk6i8NYbQPMG/Sn7h7NjTMKTrUt8sk5wwvd0GnIqyuBCVD+oVD2W4ebkg9D8MvIGHL5w7MxX+3seKYml/HO1ddw+aZzCZyDjqi+jEkYmeQ4WJ2WF0xywCwZhicADEozsNS4/bAWynaMY+LXxIyvbBhtVxRtZMBW/xP+l4U0boPDhOZnj5xC8DsnLwN0ONS9BjMjz+ic4LUBWLphauJprGybTPDHgFIIpssOBYxyGqcS2DWeiuTq6Ctg6HlS0vAjuAVQ6xJhpE5OUJyrM/Le3h/kCpHuW7W5mGBe6o9d64MI3rHfrvYuw4CURQ8HOCqMfuZzZifE/BWZTB/SRYRQl3jjtmw3VrX9sJ2NxFC4DxJ2JU2Bmk/p2vLIGkorT6NSuRTyLa1gZfEvxoeWsmj4Vg5hINxHVcloBL+2SFoO2j+UBTP+xGx4edbKZZrDEj3rwlXojBZJhGRKrlPFnu17g2x9qjOdiJMxwZyi9htCCSk17lyQLP1PyJrbLARDxxhFEsbpXwDNlvrD90oqSJKFNcB4lVjBC4ZErUXodgJQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb8c6e93-ed65-4864-aa9b-08d871dfc96d
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 14:28:44.5830 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D37panCtxj8PuWQL5cfv+vv8MaTDQqS9+RczNvk9rn3NpqTHfoNMsmIDLRd2l/ee3HIO5giuA8g7nUih2YpwB/U8cQFSiigRpLrR1sOwj3U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3765
Received-SPF: pass client-ip=40.107.15.113;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/16 10:28:45
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

15.10.2020 20:37, Andrey Shinkevich wrote:
> On 15.10.2020 18:56, Max Reitz wrote:
>> On 14.10.20 20:57, Andrey Shinkevich wrote:
>>> On 14.10.2020 15:01, Max Reitz wrote:
>>>> On 12.10.20 19:43, Andrey Shinkevich wrote:
>>>>> Limit COR operations by the base node in the backing chain when the
>>>>> overlay base node name is given. It will be useful for a block stream
>>>>> job when the COR-filter is applied. The overlay base node is passed as
>>>>> the base itself may change due to concurrent commit jobs on the same
>>>>> backing chain.
>>>>>
>>>>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>>>>> ---
>>>>>    block/copy-on-read.c | 39 +++++++++++++++++++++++++++++++++++++--
>>>>>    1 file changed, 37 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/block/copy-on-read.c b/block/copy-on-read.c
>>>>> index c578b1b..dfbd6ad 100644
>>>>> --- a/block/copy-on-read.c
>>>>> +++ b/block/copy-on-read.c
>>>>> @@ -122,8 +122,43 @@ static int coroutine_fn
>>>>> cor_co_preadv_part(BlockDriverState *bs,
>>>>>                                               size_t qiov_offset,
>>>>>                                               int flags)
>>>>>    {
>>>
>>> [...]
>>>
>>>>> +            ret = bdrv_is_allocated_above(bdrv_cow_bs(bs->file->bs),
>>>>> +                                          state->base_overlay, true,
>>>>> offset,
>>>>> +                                          n, &n);
>>>>> +            if (ret) {
>>>>> +                local_flags |= BDRV_REQ_COPY_ON_READ;
>>>>> +            }
>>>>> +        }
>>>>
>>>> Furthermore, I just noticed – can the is_allocated functions not return
>>>> 0 in @n, when @offset is a the EOF?  Is that something to look out for?
>>>>    (I’m not sure.)
>>>>
>>>> Max
>>>>
>>>
>>> The check for EOF is managed earlier in the stream_run() for a
>>> block-stream job. For other cases of using the COR-filter, the check for
>>> EOF can be added to the cor_co_preadv_part().
>>> I would be more than happy if we can escape the duplicated checking for
>>> is_allocated in the block-stream. But how the stream_run() can stop
>>> calling the blk_co_preadv() when EOF is reached if is_allocated removed
>>> from it?
>>
>> True.  Is it that bad to lose that optimization, though?  (And I would
>> expect the case of a short backing file to be rather rare, too.)
>>
>>> May the cor_co_preadv_part() return EOF (or other error code)
>>> to be handled by a caller if (ret == 0 && n == 0 && (flags &
>>> BDRV_REQ_PREFETCH)?
>>
>> That sounds like a bad hack.  I’d rather keep the double is_allocated().
>>
>> But what would be the problem with losing the short backing file
>> optimization?  Just performance?  Or would we end up writing actual
>> zeroes into the overlay past the end of the backing file?  Hm, probably
>> not, if the COR filter would detect that case and handle it like stream
>> does.
>>
>> So it seems only a question of performance to me, and I don’t think it
>> would be that bad to in this rather rare case to have a bunch of useless
>> is_allocated and is_allocated_above calls past the backing file’s EOF.
>> (Maybe I’m wrong, though.)
>>
>> Max
>>
> 
> Thank you, Max, for sharing your thoughts on this subject.
> The double check for the is_allocated in the stream_run() is a performance degradation also.
> And we will make a check for the EOF in the cor_co_preadv_part() in either case, won't we?
> 
> Andrey


I'd keep is_allocated logic in block-stream as is for now. It's not good that we check block-status several times (in block-stream, than in cor filter, than in generic COR code), but it shouldn't be real problem, and we can postpone optimizations for the next step.

Also, the resulting architecture is not final. I believe that in bright future block-stream will work through block-copy like backup does. And COR filter will call block_copy() by itself, and generic COR code will be dropped together with BDRV_REQ_COR flag. And stream will do just one background call of block_copy for the whole device, like backup in finish on my in-flight backup series. And all extra levels of block_status checking will leave.

About EOF problem discussed here, let's look at more generic problem: we are going to skip _large_ area, but skipping chunk-by-chunk is inefficient. So, we just want to learn to skip large areas. The simplest way is just to call is_allocated/is_allocated_above
from current offset to device end, if we decided to skip current chunk. Then we'll know how much to skip totally. But that kind of optimization is not directly related to these series and may be done in separate if needed.

-- 
Best regards,
Vladimir

