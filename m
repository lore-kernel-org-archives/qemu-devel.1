Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45458C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 17:37:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51FBD23899
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 17:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="LTsNLAnU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51FBD23899
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLVBb-000659-El
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 13:37:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kLVAg-0005T0-Uj; Thu, 24 Sep 2020 13:36:43 -0400
Received: from mail-eopbgr130120.outbound.protection.outlook.com
 ([40.107.13.120]:53950 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kLVAb-0000Xk-U2; Thu, 24 Sep 2020 13:36:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fyST/M3etstkroAzdz5OX0B1Dnz29DHCkYT+5ZWVx56S0ERNRkEPDIo63pyW02zPa+n35bIKtpKdQ0Bh4PG5sYvnQxH4XVd022vzTl1NdJyebQHkkwoSOEURs6PuOt2MLFlEpKWWFCklp7ZI8JxAQDkQ0USoOLl19rR+ERkf9mXWb1t4IU1ArARTeXVZrr8YFKy7BEIfO/rGCFAg4v1PvBl9dyeXLqdgECAavy6PqcBgEeFsNrwVJT2TvGjpHDJpXIDzXvVVX1PsxwOqg10o8heeXN2sOT2Pa/SUZKPHoQbSS7pTTe8GkvqUYJbFFG31Wzc5p0xaP5lBBqgNR4u8gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BBKKqSRZlbZ+71DPBgAoI8YYQqmCsAs5BC+c3nXwLmc=;
 b=BoeR89n/6OtypnB0U7x8QATkpcynZxy8xDZy4puLeIcLQD0YcxAVj3+kVnBCnXhsq3rJej8BTrNzC1OZE9wMmVsyDuj/yNi61r4M5wniySIHKl2mmLHFAtUifgNpKrQHpfyfy3L0xU7H1jVT9t0oMZvz2syj4sFcUcb8vbvQ1VW7l4q7FMFpxJn9buCIbB8FBAFDpsWUmxOQKhR8jn3GUv4At8WeyktYdY5XxPdzWlqU+kHP+BkjGF6IzUHV3/ITHYt7uwhwcyStc3AYER6PyGCjUjz1U88gEMz0fxQM4GUuMK1EbisOF31UpBZQ+6qOPQPyp510OXUXm//22m5cAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BBKKqSRZlbZ+71DPBgAoI8YYQqmCsAs5BC+c3nXwLmc=;
 b=LTsNLAnUTDmokfqXjnejgutYh1NdTyiOMA8gs7VzXcYcxVPGAcPGhXkD7EvUacx+lBPimsxaHI69STH4aL0sgUpNASWMQhEQ7c5qRcJWKwwwq/cOMgTKvW9s+dSWFUHbPLBaAY6mf2ouf4Hg8499g04n5y31hnBxXJ2u5I1qlkw=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3094.eurprd08.prod.outlook.com (2603:10a6:209:48::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Thu, 24 Sep
 2020 17:36:34 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.033; Thu, 24 Sep 2020
 17:36:34 +0000
Subject: Re: [PATCH v6 08/15] block: introduce preallocate filter
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 fam@euphon.net, stefanha@redhat.com, kwolf@redhat.com, den@openvz.org
References: <20200918181951.21752-1-vsementsov@virtuozzo.com>
 <20200918181951.21752-9-vsementsov@virtuozzo.com>
 <73b1b0eb-5ca3-a436-5783-695d62fe337e@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <fd9c5668-5f4e-a56b-b14d-a169ff97411f@virtuozzo.com>
Date: Thu, 24 Sep 2020 20:36:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
In-Reply-To: <73b1b0eb-5ca3-a436-5783-695d62fe337e@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM3PR07CA0085.eurprd07.prod.outlook.com
 (2603:10a6:207:6::19) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.94) by
 AM3PR07CA0085.eurprd07.prod.outlook.com (2603:10a6:207:6::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.13 via Frontend Transport; Thu, 24 Sep 2020 17:36:33 +0000
X-Originating-IP: [185.215.60.94]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f6a0d19-a4cd-46d3-d118-08d860b06155
X-MS-TrafficTypeDiagnostic: AM6PR08MB3094:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB309412F8D9D724CBA9FEE149C1390@AM6PR08MB3094.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rAb9EulB8QFbctS7cBMqvpOG7munrDxvQ5RVrYH36WCoWWU/WTt7KY3Qk5hyb4AmVUouyjHcDLqSmALwrkFmUjgnWWgCEswUlFLuw8hsBMYwardGtqvep4NKnmINEw6oj30LYpBPr5c4VxZH3lv3Ic68kz3iFCjEV6i9pEn+ZD+UHw36I2iWpZJDmnTmEs3PTEDprq0ShK8DK3PLD2mMi1UBWgKGQRJ40uz8NViGDqyRXKk7klSyMuOrflWkwz31a3H0DwyIUbREBi2of1fX23EzxOmV3ISMtSqyP9JIy4EMyPQL+BSJ5LBE/Jtp4Msq+Gw2HYB+BcgEWM1OGtJssbUbs9vK8rIACRGuyvFYRCrlV4Ul93czhsYvnB57LNd6cmqGyB34icHPC1jMVhYp56jrTX3vLLm1GSc2LiB1BZfqDXXvoEy1csdL7RWcwCOg
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39840400004)(396003)(376002)(346002)(136003)(31686004)(956004)(2616005)(86362001)(66946007)(26005)(478600001)(53546011)(83380400001)(186003)(66476007)(16526019)(6486002)(8936002)(66556008)(107886003)(5660300002)(4326008)(36756003)(31696002)(8676002)(52116002)(316002)(2906002)(16576012)(30864003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: c9J43hcBOlUlKou7t+vx0oX0z2fzbJB5ci/PTD+AOaHyHKGpHW7yv7idORg21jGMnN5B7Td56swZaGEDZpz6EoAgXVbnVJ1oj3CjXkbqIiprgm8xwQJynHOLDuoC6Sm7roeRPRI0xZRPoeFNs2wDSHKnCA56RRaOvQnVuwYT6eVfZ//z3KvnKch6oHWsDOLg6U0OsG3AaxZ752LeGjNbP+RwXmISwwAoaudq5QJAplOIpb2T92deP6F2Y8uRdmO8dmfVcLmR/v8FAJbHYf/i1LVYCw2MzxUcib+szVOA3AB2zWrsphnR4H+MO6UJ4uoDhu/q5mUqvrhD2ZVzQdqdHghh0+ydunLKZx8R1XRiYdqfdLArmTK43JOaDgjmytUN10t+Y6wqXFDNAf0+9dsS212ksRaXQ47NF7sVxeFrugsKO9hFIPiix/uiv9z7owafGDvVUHXW+id4+WXpC/Frv5RkzmrMjH6xyq512zbxOaeRgWknqbdNmFUNlyqF7HMpJFhHAegTDSpjYTQdndYy0AAdgTDXgMrbPgYP+XhS6H0kc31CT1W3aCK418FXZAGh8eJsqfYzAx+TpHr8Ap4EuCBNAxRRenkvYarpZqg7jh/SXeQFf8XPG9Jk40FyTm5Uv1V8LWIleriQa1rXL5LDtw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f6a0d19-a4cd-46d3-d118-08d860b06155
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 17:36:33.9416 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c8qZ4o8lYHwkhpf5wcpW+CHCWWNsBG46jT04muYwa1PXe79xnWLvEdGHcjIpKY/iTw+imwsz7i9qVzzWPE1Hg5HOLOEefU8nMi3RPDINRKE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3094
Received-SPF: pass client-ip=40.107.13.120;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 13:36:34
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.214, RCVD_IN_DNSWL_NONE=-0.0001,
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

24.09.2020 19:50, Max Reitz wrote:
> On 18.09.20 20:19, Vladimir Sementsov-Ogievskiy wrote:
>> It's intended to be inserted between format and protocol nodes to
>> preallocate additional space (expanding protocol file) on writes
>> crossing EOF. It improves performance for file-systems with slow
>> allocation.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   docs/system/qemu-block-drivers.rst.inc |  26 ++
>>   qapi/block-core.json                   |  20 +-
>>   block/preallocate.c                    | 556 +++++++++++++++++++++++++
>>   block/meson.build                      |   1 +
>>   4 files changed, 602 insertions(+), 1 deletion(-)
>>   create mode 100644 block/preallocate.c
> 
> Looks good to me in general.
> 
> [...]
> 
>> diff --git a/block/preallocate.c b/block/preallocate.c
>> new file mode 100644
>> index 0000000000..6510ad0149
>> --- /dev/null
>> +++ b/block/preallocate.c
> 
> [...]
> 
>> +/*
>> + * Handle reopen.
>> + *
>> + * We must implement reopen handlers, otherwise reopen just don't work. Handle
>> + * new options and don't care about preallocation state, as it is handled in
>> + * set/check permission handlers.
>> + */
>> +
>> +static int preallocate_reopen_prepare(BDRVReopenState *reopen_state,
>> +                                      BlockReopenQueue *queue, Error **errp)
>> +{
>> +    PreallocateOpts *opts = g_new0(PreallocateOpts, 1);
>> +
>> +    if (!preallocate_absorb_opts(opts, reopen_state->options,
>> +                                 reopen_state->bs->file->bs, errp)) {
> 
> I tried to find out whether this refers to the old file child, or the
> post-reopen one.

Note, that it's needed only to check request_alignment. Probably it's better to pass request_alignment to preallocate_absorb_opts, not the whole child.

>  As far as I could find out, there is no generic
> implementation for changing the file child as part of x-blockdev-reopen:
> 
> {"error": {"class": "GenericError", "desc": "Cannot change the option
> 'file'"}}
> 
> Now that’s a shame.  That means you can’t reasonably integrate a
> preallocate filter into an existing node graph unless the format driver
> checks for the respective child option and issues a replace_node on
> commit or something, right?  I suppose any driver who’d want to
> implement child replacement would need to attach the new node in
> prepare() as some pseudo-child, and then drop the old one and rename the
> new one in commit().  I don’t think any driver does that yet, so I
> suppose no format driver allows replacement of children yet (except for
> quorum...).
> 
> Does anyone know what the status on that is?  Are there any plans for
> implementing child replacement in reopen, or did I just miss something?
> 
> (It looks like the backing child can be replaced, but that’s probably
> not a child where the preallocate filter would be placed on top...).

Hm. I didn't care about it, because main use case is to insert the filter at start, specifying it in -drive or in -blockdev options.

Probably, we need a separate API which will insert/remove filters like it is done in block jobs code, not reopening the block device.

> 
>> +        g_free(opts);
>> +        return -EINVAL;
>> +    }
>> +
>> +    reopen_state->opaque = opts;
>> +
>> +    return 0;
>> +}
> 
> [...]
> 
>> +/*
>> + * Call on each write. Returns true if @want_merge_zero is true and the region
>> + * [offset, offset + bytes) is zeroed (as a result of this call or earlier
>> + * preallocation).
>> + *
>> + * want_merge_zero is used to merge write-zero request with preallocation in
>> + * one bdrv_co_pwrite_zeroes() call.
>> + */
>> +static bool coroutine_fn handle_write(BlockDriverState *bs, int64_t offset,
>> +                                      int64_t bytes, bool want_merge_zero)
>> +{
>> +    BDRVPreallocateState *s = bs->opaque;
>> +    int64_t end = offset + bytes;
>> +    int64_t prealloc_start, prealloc_end;
>> +    int ret;
>> +
>> +    if (!has_prealloc_perms(bs)) {
> 
> Took me a bit to figure out, because it takes a trip to
> preallocate_child_perm() to figure out exactly when we’re going to have
> the necessary permissions for this to pass.
> 
> Then it turns out that this is going to be the case exactly when the
> parents collectively have the same permissions (WRITE+RESIZE) on the
> preallocate node.
> 
> Then I had to wonder whether it’s appropriate not to preallocate if
> WRITE is taken, but RESIZE isn’t.  But that seems entirely correct, yes.
>   If noone is going to grow the file, then there is no need for
> preallocation.  (Vice versa, if noone is going to write, but only
> resize, then there is no need for preallocation either.)
> 
> So this seems correct, yes.
> 
> (It could be argued that if one parent has WRITE, and another has RESIZE
> (but neither has both), then we probably don’t need preallocation
> either.  But in such an arcane case (which is impossible to figure out
> in .bdrv_child_perm() anyway), we might as well just do preallocation.
> Won’t hurt.)
> 
>> +        /* We don't have state neither should try to recover it */
>> +        return false;
>> +    }
>> +
>> +    if (s->data_end < 0) {
>> +        s->data_end = bdrv_getlength(bs->file->bs);
>> +        if (s->data_end < 0) {
>> +            return false;
>> +        }
>> +
>> +        if (s->file_end < 0) {
>> +            s->file_end = s->data_end;
>> +        }
>> +    }
>> +
>> +    if (end <= s->data_end) {
>> +        return false;
>> +    }
>> +
>> +    /* We have valid s->data_end, and request writes beyond it. */
>> +
>> +    s->data_end = end;
>> +    if (s->zero_start < 0 || !want_merge_zero) {
>> +        s->zero_start = end;
> 
> Skipping this on want_merge_zero == true means that zero writes can be
> cached; if you repeatedly perform zero writes into the preallocated
> area, then none of those will actually be executed.  I legitimately
> don’t know whether that’s OK.
> 
> I suppose until someone tells me it isn’t OK, I’ll believe it is.

Skipping zero-writes to preallocated area is significant for performance.
If I remember correctly, handle_alloc_space() in qcow2 will otherwise do extra write-zeroes, which reduces performance.

So, we assume that zero-write after EOF is a kind of preallocation. And avoid preallocating same region twice.

Using zero_start instead of data_end is probably less significant, I'm not sure.

> 
>> +    }
>> +
>> +    if (s->file_end < 0) {
>> +        s->file_end = bdrv_getlength(bs->file->bs);
>> +        if (s->file_end < 0) {
>> +            return false;
>> +        }
>> +    }
>> +
>> +    /* Now s->data_end, s->zero_start and s->file_end are valid. */
>> +
>> +    if (end <= s->file_end) {
>> +        /* No preallocation needed. */
>> +        return want_merge_zero && offset >= s->zero_start;
>> +    }
>> +
>> +    /* Now we want new preallocation, as request writes beyond s->data_end. */
> 
> s/data_end/file_end/> 
>> +
>> +    prealloc_start = want_merge_zero ? MIN(offset, s->file_end) : s->file_end;
> 
> I suppose you intentionally use s->file_end here instead of @end, even
> if offset <= s->file_end.  I just mention it because I wonder whether
> it’s really better to effectively write twice to the same area in such
> cases (once zeroes for preallocation, then immediately the data) instead
> of only writing the data and then preallocating past it.
> 
> (Though if it were the same code just with @end instead of s->file_end
> for offset <= s->file_end, then the order would be to preallocate past
> @end, and then to write the data.  Which might be suboptimal in terms of
> how the blocks are then ordered in the filesystem.)

Yes, I think it's better to preallocate from file_end, in this way we do our best for good file blocks location in filesystem. And writing twice shouldn't really matter with big enough preallocation size (a lot larger than usual guest write operation).

> 
>> +    prealloc_end = QEMU_ALIGN_UP(offset + bytes + s->opts.prealloc_size,
> 
> s/offset + bytes/end/?

yes

> 
>> +                                 s->opts.prealloc_align);
>> +    s->file_end = end;
> 
> Why is this set here, when it’s always overwritten after
> bdrv_co_pwrite_zeroes() anyway?
> 
> (It also seems a bit wrong, because at this point we don’t know yet
> whether the data write is going to succeed, so we don’t know for sure
> whether the file end is really going to be @end without the preallocation.)

Agree, that's strange and seems wrong. Will drop.

> 
>> +
>> +    ret = bdrv_co_pwrite_zeroes(
>> +            bs->file, prealloc_start, prealloc_end - prealloc_start,
>> +            BDRV_REQ_NO_FALLBACK | BDRV_REQ_SERIALISING | BDRV_REQ_NO_WAIT);
>> +    if (ret < 0) {
>> +        s->file_end = ret;
>> +        return false;
>> +    }
>> +
>> +    s->file_end = prealloc_end;
>> +    return want_merge_zero;
>> +}
>> +
>> +static int coroutine_fn preallocate_co_pwrite_zeroes(BlockDriverState *bs,
>> +        int64_t offset, int bytes, BdrvRequestFlags flags)
>> +{
>> +    bool want_merge_zero =
>> +        (flags & (BDRV_REQ_ZERO_WRITE | BDRV_REQ_NO_FALLBACK)) == flags;
> 
> Isn’t this the same as !(flags & ~(ZERO_WRITE | NO_FALLBACK))?  (Maybe
> only I would find that simpler to understand, though.)

Actually, I think yours is more usual notation and it uses "flags" once. Will change.

> 
>> +    if (handle_write(bs, offset, bytes, want_merge_zero)) {
>> +        return 0;
>> +    }
>> +
>> +    return bdrv_co_pwrite_zeroes(bs->file, offset, bytes, flags);
>> +}
> 
> [...]
> 
>> +static int coroutine_fn
>> +preallocate_co_truncate(BlockDriverState *bs, int64_t offset,
>> +                        bool exact, PreallocMode prealloc,
>> +                        BdrvRequestFlags flags, Error **errp)
>> +{
>> +    ERRP_GUARD();
>> +    BDRVPreallocateState *s = bs->opaque;
>> +    int ret;
>> +
>> +    if (s->data_end >= 0 && offset > s->data_end) {
>> +        if (s->file_end < 0) {
>> +            s->file_end = bdrv_getlength(bs->file->bs);
>> +            if (s->file_end < 0) {
>> +                error_setg(errp, "failed to get file length");
>> +                return s->file_end;
>> +            }
>> +        }
>> +
>> +        if (prealloc == PREALLOC_MODE_FALLOC) {
>> +            /*
>> +             * If offset <= s->file_end, the task is already done, just
>> +             * update s->file_end, to move part of "filter preallocation"
> 
> s/file_end/data_end/
> 
>> +             * to "preallocation requested by user".
>> +             * Otherwise just proceed to preallocate missing part.
>> +             */
>> +            if (offset <= s->file_end) {
>> +                s->data_end = offset;
>> +                return 0;
>> +            }
> 
> [...]
> 
>> +static int preallocate_check_perm(BlockDriverState *bs,
>> +                                  uint64_t perm, uint64_t shared, Error **errp)
>> +{
>> +    BDRVPreallocateState *s = bs->opaque;
>> +
>> +    if (s->data_end >= 0 && !can_write_resize(perm)) {
>> +        /*
>> +         * Loose permissions.
> 
> *Lose
> 
> (I assume)

Oops)

> 
>> +         * We should truncate in check_perm, as in set_perm bs->file->perm will
>> +         * be already changed, and we should not violate it.
>> +         */
>> +        if (s->file_end < 0) {
>> +            s->file_end = bdrv_getlength(bs->file->bs);
>> +            if (s->file_end < 0) {
>> +                error_setg(errp, "Failed to get file length");
>> +                return s->file_end;
>> +            }
>> +        }
>> +
>> +        if (s->data_end < s->file_end) {
>> +            int ret = bdrv_truncate(bs->file, s->data_end, true,
>> +                                    PREALLOC_MODE_OFF, 0, NULL);
>> +            if (ret < 0) {
>> +                error_setg(errp, "Failed to drop preallocation");
>> +                s->file_end = ret;
>> +                return ret;
>> +            }
>> +        }
>> +        /*
>> +         * We will drop our permissions, as well as allow shared
>> +         * permissions, anyone will be able to change the child, so mark
>> +         * all states invalid. We'll regain control if get good permissions
>> +         * back.
>> +         */
>> +        s->data_end = s->file_end = s->zero_start = -EINVAL;
> 
> Shouldn’t we clear these variables whenever !can_write_resize(perm), not
> just if also s->data_end >= 0?

Yes, will fix.

> 
>> +    }
>> +
>> +    return 0;
>> +}
> 
> Max
> 

Thanks!

-- 
Best regards,
Vladimir

