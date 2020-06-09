Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB70FC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 15:30:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 849022072F
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 15:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="u7lbrFQ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 849022072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jigCe-0004eh-NU
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 11:30:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36718)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jigBv-0004Dg-HU; Tue, 09 Jun 2020 11:29:31 -0400
Received: from mail-eopbgr60133.outbound.protection.outlook.com
 ([40.107.6.133]:12615 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jigBs-0005LC-TZ; Tue, 09 Jun 2020 11:29:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UJQbM9OglLeIwKRBrEQe6jWAkEYWCpim9WukGKln6hnSvtkA5oLmmbm+I73m23qDIn7Wm6GCykHSgqkpM4Q9XmQDESme3Vl9vcye3YNyvi9c+y8SdGBV8+KZze/J4xCUMPeXa1OwCbBGY/GSTkzOPOTi/2/7n/HX+KD7EhBDQQ4PjSnuPgxuaC5oWBqgu2LHKjZtJV63wget9UyN2xSnwmc200W5qCsueI8pF6eggG0jGiT50ucH1h2lWiQsOQv8mo59IxiZBiiMPZ6cVGZok/76Pr9cc2eNIhYNe2lV8w1D/6PdSCysPEt0AXSPWQQRL7L+shqpxiCgHJUNf8KgyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGLMe7U8XHQRMYHrXE2rfKYM9mzhc9en/uZa/BL+Jyc=;
 b=MBJN2pb2I+yUihYS/Ljl48Lnyjcn/vVAw0QVQ5fUjm3Iejp7bhJfmbCaQo0BIJ7vrCa62qLjVIHwOYjc8S7nrYqObrt6/aLYqyWwIrqgjrwJYCJSZuXSWByRv1+HLxxugShYLdIh2C9Sz/r3JqWbbY0o1v5vjuQA08fXf/7/VFEdIG4a8BZl43Qro91lz5eOpRq3e18EpxhPbHTPUhBR2aoDdaYZYrVrPs499/9x1Zg88jMESTcA2BIzMLYhbABZMstg0ySrWkE6APLWOODO1RqNMMhKGaGICPFfcVIb5LOW1V8Mq1a/h2YXl0a2ynzzzQYRy1C1PdqIUk+aB9altQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGLMe7U8XHQRMYHrXE2rfKYM9mzhc9en/uZa/BL+Jyc=;
 b=u7lbrFQ+//4VV2ZCgwSZgStUg7l0LCSsDs/5xhHKPbeyeA+Kp2DqLpZrhacSr3HoaHd0vYz9mYh/crk7UeDGXGjwBpi2Rs76wlMfIDu+hRWqchm7znQN6LmAOVB+78i8oi9P9ZRI8X9R8h4IZaOP6RbHtlavklwciL10H08wCcI=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5384.eurprd08.prod.outlook.com (2603:10a6:20b:10c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Tue, 9 Jun
 2020 15:29:23 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.023; Tue, 9 Jun 2020
 15:29:23 +0000
Subject: Re: [PATCH] qcow2: Reduce write_zeroes size in handle_alloc_space()
To: Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>
References: <20200609140859.142230-1-kwolf@redhat.com>
 <02e24dca-99da-873d-8425-09a07571e675@virtuozzo.com>
 <042f0b8f-dd51-acc3-8498-ac9a5532df15@redhat.com>
 <20200609151810.GD11003@linux.fritz.box>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <177d9401-e040-13bd-2e77-26bfeda4a3d6@virtuozzo.com>
Date: Tue, 9 Jun 2020 18:29:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <20200609151810.GD11003@linux.fritz.box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR01CA0170.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::39) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.180) by
 AM0PR01CA0170.eurprd01.prod.exchangelabs.com (2603:10a6:208:aa::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend
 Transport; Tue, 9 Jun 2020 15:29:23 +0000
X-Originating-IP: [185.215.60.180]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 524f8913-3b9b-4d0d-2d12-08d80c89e333
X-MS-TrafficTypeDiagnostic: AM7PR08MB5384:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53841A0FC7DB4D972D8AC730C1820@AM7PR08MB5384.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 042957ACD7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7hINK3aEIM7ly26rO2qr9YPAv6pgXyqYLtZ9gO5WnwDLlMXDfy6Rj7MC8l+YjklcgXLkaeRpGZGV9ql0kzgt978IMbwXD7XEfXwQz3NNJV8T0iUQ2gOLbY7CA1FTDLfZY5T2pQZXztzlnLfQmRRgCOyR33j6VVykD2+m7jItrTwsG+rLKd+QsaN8rwqEWYn9MEJeBSEHjTeNqfCFVd4n7UL4Au6/WSAwbTIDRAEX2b3mpH77vz+ZYJa5vB3ZmciXfgSu4lNeGCfWEuXtzF8Unkv2CQ4tkVmxiLX8fJ5mY6re4c1zpL+tGCHetwVVi4qrz7hpvAFWTCv4kLLPSw0/7NBfWqmEl18KzMoPR2pfSrEpR0jE+jZxOKKG3BJ8X16CnSaeNe5TeWuXJ2pGImzblaFpB5YQ0iqCjFdbROFykDj2KyH6Q7TjQuE8LLxwH6aJlSw/x8oiUchy+xAkzbBbAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(31686004)(52116002)(26005)(5660300002)(86362001)(498600001)(53546011)(4326008)(83380400001)(2616005)(66946007)(31696002)(66556008)(66476007)(956004)(8936002)(36756003)(8676002)(6486002)(2906002)(16526019)(16576012)(966005)(186003)(110136005)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: qngnGDXUELmrOCWim7s4S0Ats+cZqAX6BFHicFgzs/pAReV31kqRLJc8SaKxdayz0EDKZ7qC7DZcrpRpJfrHzscIatEMaYwCxX1pExHY0wvMTv38nn/pvB6WaOisLfMAMVWoSA+Z/Repy3lX3yuxHy9JqlbwkqceId5ilD6T+NPYzfkYr7tK/o0Z+fC2tPbCZtuN2N2PV+XAIPhnfyIvLY0uPMp6j8mVFFP4BkRMVZHJv7RR4rFeNpbTP6KB725zURmwHLQbWU6GzgPq0RwreKR2c240rhqIBX5zk6xkIpk3gi/KChyUPs50I/aJJ+HlTsWICb1Rrs82O66wu3PM88B5y1bmD5XyC9VabvY9THSrG+xqNR+MkozPOjRthjqTBSeFPFLlphh3fSZ75zI/OxDSVOSW2CTOvzsQbIb8fTU20wFjBc43Sjc8/FRd78u9on/QRn960n8VLqN+Sv/GKrhgbl7QpADnv4z6BLIkLF38YT83ZVNppL8skk3QXc8w
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 524f8913-3b9b-4d0d-2d12-08d80c89e333
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2020 15:29:23.6263 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H7QXCTwdEu2yG1w/Oob3GictOXapDUQApu27GXybavp3Z+rPhe8p5VEEbKlwhaD3x8rL+xbtKg3BMMN3uhmZVRtoN78/lRE1RNnKEmVyUxw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5384
Received-SPF: pass client-ip=40.107.6.133;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 11:29:26
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
Cc: "Denis V. Lunev" <den@openvz.org>, anton.nefedov@virtuozzo.com,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

09.06.2020 18:18, Kevin Wolf wrote:
> Am 09.06.2020 um 16:46 hat Eric Blake geschrieben:
>> On 6/9/20 9:28 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> 09.06.2020 17:08, Kevin Wolf wrote:
>>>> Since commit c8bb23cbdbe, handle_alloc_space() is called for newly
>>>> allocated clusters to efficiently initialise the COW areas with zeros if
>>>> necessary. It skips the whole operation if both start_cow nor end_cow
>>>> are empty. However, it requests zeroing the whole request size (possibly
>>>> multiple megabytes) even if only one end of the request actually needs
>>>> this.
>>>>
>>>> This patch reduces the write_zeroes request size in this case so that we
>>>> don't unnecessarily zero-initialise a region that we're going to
>>>> overwrite immediately.
>>>>
>>
>>>
>>> Hmm, I'm afraid, that this may make things worse in some cases, as with
>>> one big write-zero request
>>> we preallocate data-region in the protocol file, so we have better
>>> locality for the clusters we
>>> are going to write. And, in the same time, with BDRV_REQ_NO_FALLBACK
>>> flag write-zero must be
>>> fast anyway (especially in comparison with the following write request).
>>>
>>>> Â Â Â Â Â Â Â Â Â  /*
>>>> Â Â Â Â Â Â Â Â Â Â  * instead of writing zero COW buffers,
>>>> Â Â Â Â Â Â Â Â Â Â  * efficiently zero out the whole clusters
>>>> Â Â Â Â Â Â Â Â Â Â  */
>>>> -Â Â Â Â Â Â Â  ret = qcow2_pre_write_overlap_check(bs, 0, m->alloc_offset,
>>>> -Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â  m->nb_clusters *
>>>> s->cluster_size,
>>>> -Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â  true);
>>>> +Â Â Â Â Â Â Â  ret = qcow2_pre_write_overlap_check(bs, 0, start, len, true);
>>>> Â Â Â Â Â Â Â Â Â  if (ret < 0) {
>>>> Â Â Â Â Â Â Â Â Â Â Â Â Â  return ret;
>>>> Â Â Â Â Â Â Â Â Â  }
>>>> Â Â Â Â Â Â Â Â Â  BLKDBG_EVENT(bs->file, BLKDBG_CLUSTER_ALLOC_SPACE);
>>>> -Â Â Â Â Â Â Â  ret = bdrv_co_pwrite_zeroes(s->data_file, m->alloc_offset,
>>>> -Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â  m->nb_clusters * s->cluster_size,
>>>> +Â Â Â Â Â Â Â  ret = bdrv_co_pwrite_zeroes(s->data_file, start, len,
>>>> Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â  BDRV_REQ_NO_FALLBACK);
>>
>> Good point.  If we weren't using BDRV_REQ_NO_FALLBACK, then avoiding a
>> pre-zero pass over the middle is essential.  But since we are insisting that
>> the pre-zero pass be fast or else immediately fail, the time spent in
>> pre-zeroing should not be a concern.  Do you have benchmark numbers stating
>> otherwise?
> 
> I stumbled across this behaviour (write_zeros for 2 MB, then overwrite
> almost everything) in the context of a different bug, and it just didn't
> make much sense to me. Is there really a file system where fragmentation
> is introduced by not zeroing the area first and then overwriting it?
> 
> I'm not insisting on making this change because the behaviour is
> harmless if odd, but if we think that writing twice to some blocks is an
> optimisation, maybe we should actually measure and document this.

Not to same blocks: first we do write-zeroes to the area aligned-up to cluster bound. So it's more probable that the resulting clusters would be contigous on file-system.. With your patch it may be split into two parts. (a bit too theoretical, I'd better prove it by example)

Also, we (Virtuozzo) have to support some custom distributed fs, where allocation itself is expensive, so the additional benefit of first (larger) write-zero request is that we have one allocation request instead of two (with your patch) or three (if we decide to make two write-zero opersions).

> 
> 
> Anyway, let's talk about the reported bug that made me look at the
> strace that showed this behaviour because I feel it supports my last
> point. It's a bit messy, but anyway:
> 
>      https://bugzilla.redhat.com/show_bug.cgi?id=1666864
> 
> So initially, bad performance on a fragmented image file was reported.
> Not much to do there, but then in comment 16, QA reported a performance
> regression in this case between 4.0 and 4.2. And this change caused by
> c8bb23cbdbe, i.e. the commit that introduced handle_alloc_space().
> 
> Turns out that BDRV_REQ_NO_FALLBACK doesn't always guarantee that it's
> _really_ fast. fallocate(FALLOC_FL_ZERO_RANGE) causes some kind of flush
> on XFS and buffered writes don't. So with the old code, qemu-img convert
> to a file on a very full filesystem that will cause fragmentation, was
> much faster with writing a zero buffer than with write_zeroes (because
> it didn't flush the result).
> 
> I don't fully understand why this is and hope that XFS can do something
> about it. I also don't really think we should revert the change in QEMU,
> though I'm not completely sure. But I just wanted to share this to show
> that "obvious" characteristics of certain types of requests aren't
> always true and doing obscure optimisations based on what we think
> filesystems may do can actually achieve the opposite in some cases.
> 
> Kevin
> 


-- 
Best regards,
Vladimir

