Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F02BC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 16:44:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C022020855
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 16:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="SPRKYRrc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C022020855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6GLP-00035W-11
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 12:44:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56938)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k6GBa-0002H7-1g; Thu, 13 Aug 2020 12:34:38 -0400
Received: from mail-vi1eur05on2124.outbound.protection.outlook.com
 ([40.107.21.124]:11105 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k6GBW-0001qP-DQ; Thu, 13 Aug 2020 12:34:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OObBKBZvyGA8ih67NsOivJ4NNwc1fokDpIUTib1nUIiEdk0hxO8vLRRc1H7ZEvJ+LuCPZrfwRbZYBtif66hA5UTSsMbdIhTPaGN4noT5Y6MPOtZbg6dpGcvQtvylFs8lxPmpjSNgxUAq/YB0WITr08y2zN4QWSUjtJTbwzCBsGr/J3YMkCIH+BFEGfOL0EmvfB4ojLwPi8TZlqqd77N3DTJXXDXz45AEyd7OgF2gE9Iig7T0sHkNrbuWblDpTyaHpXtzgAm2x8jOuVnAVkTdfNUqZVCjuILpeEAqf2XH6xKeSikd96poYjbmUrqEoBcdu6D5f8ZzQoqVF04m1SSszA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ogJXA3CPOlrHFsw6GmfTR8N6E/84NHPrSZAu11reiWg=;
 b=gGeGFWFVUb99jBMWvauxp/JAeP4GoXJg0YxXUaXnJ5CYS2uHfzztnV6J6dEOZOsg05psluyjCh6wp7o+cGjXIU3SMeHLkhHOWwakRXxahIvMhxq8lOxSapzzqZBr1SPebn7jkD+VbCYe5Nw9YHo8h2Y6YFIfZ8kMppwRnwjEo7EWgazVRPr+lehNTNOGs/jLAGoOsNnl/cKgZ2fngij8OgSaOZi7j/kzWY+0tRjLVvfAVZ6Mlj5BKXSQKr3PIkgsmXIsubWjQXT0FYDwDvpNWqDwe0e/6mxdNFW3+CPICH983Ly1V8BTgBMaB1mOvWALFLSR+pv/H4Snbs19G9QZSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ogJXA3CPOlrHFsw6GmfTR8N6E/84NHPrSZAu11reiWg=;
 b=SPRKYRrcvorGlLhIB+RvGO5mMAiiqASmp5czt2DsHc7g8pVrKS515JbaTQumNNnalA21p6V7LLGIStX0Y7vaYHf5TplFQZ9lbDY7e5fRuzLNYz4j89AirSFn0R5byLvEM7VkFMIE4UUIP0mqXBN9zj3SV7+hgVTyEbbhVMxqplE=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5493.eurprd08.prod.outlook.com (2603:10a6:20b:102::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.20; Thu, 13 Aug
 2020 16:34:30 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3283.015; Thu, 13 Aug 2020
 16:34:30 +0000
Subject: Re: What is bs->reqs_lock for?
To: Paolo Bonzini <pbonzini@redhat.com>, qemu block <qemu-block@nongnu.org>
References: <ebea1375-8bc0-2b0a-051f-28b2afa02a1c@virtuozzo.com>
 <2c237be3-7e28-f61a-d339-5765089fe65c@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <e6d75774-300d-c38d-3f07-0cbc39aff54e@virtuozzo.com>
Date: Thu, 13 Aug 2020 19:34:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <2c237be3-7e28-f61a-d339-5765089fe65c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR08CA0026.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::39) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.139) by
 AM0PR08CA0026.eurprd08.prod.outlook.com (2603:10a6:208:d2::39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.15 via Frontend Transport; Thu, 13 Aug 2020 16:34:29 +0000
X-Originating-IP: [185.215.60.139]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8271732-f532-4507-1272-08d83fa6c06a
X-MS-TrafficTypeDiagnostic: AM7PR08MB5493:
X-Microsoft-Antispam-PRVS: <AM7PR08MB54931B7095933F3B816BE187C1430@AM7PR08MB5493.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yThguTOUCudE303OM0E6Ggd2KChC7e5VfNR0i/ODi0xcRqb9bUnu7UpgJCNSo8aA7Y9N3ScEGtpQiXiuzB+IibAawvgswtmDm6rrbK50JXixg4KdViTyPH3SQUQM/bT9RSUxifSfPSIQvDusfMAo0lSttOfxJqKH/MA6ao46xdJffJC5naQFt1E3r5fmeJdbo04dck/P9Z0gq/D3Q6Ss3l1M9tb8D+b0NdOskrsDs4Cjgh+sMu70hBrKaEa5lVNTRV1VzmFesi6eraECA/DP+RtHlYlNVKALMjWaXRzgYmh7e32EuvhZOAAQfcsf0lM3kt8i3lo7VS4j43aRhTybIQZOAEWkt/0YScvip+qLqdlVKMIbLibMxbahctjtcjr3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(136003)(396003)(39840400004)(346002)(31686004)(86362001)(31696002)(16576012)(6486002)(4326008)(36756003)(8936002)(83380400001)(110136005)(54906003)(316002)(478600001)(26005)(52116002)(16526019)(186003)(2616005)(956004)(8676002)(66946007)(66476007)(66556008)(5660300002)(53546011)(2906002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: XA7titxRFrDZXmVw2j+xDlz8gPdjJjofO/sLxpCyUbguH9TQO3XJ8rXdmDcCrlWFZcHh900GEADbSyNTB+FYhKYFzT7ja0AXNauo7K3ZpB/WOb/tK759V9n/WF29O7GAMmA9eFFipKA9bADT4e5/jpW6TCw7WXHZ4ksyCtczR505Ybqz3SgPdQT2MhTM0NBT2DPsC/cAg07gSA53XAL8SYkl13jt/mO0BSv8d5pIHki/H0v7f0QkoL1tWA4BPifi/OfxG6dN00s8qDGNI86fXDRBZcZy2CETx39JrEc79xs6LE+6kJ0nLUhF0Hq8KBUINVaRv2/WKsEV330/oyj3DM5J2wkFqlz6WpCapLCqkxEua3gJ1XJPlkilhPd/1jl3y91T2/lUBZteiWQQmvQLAxgRLU9mH14x7nrFMPou7jak2q8/86URgNKU1YFn0jO/la9jrzj+pSImbHbI3HqjkuOWIcyaG8vUjDqef3/dO/jRwQzGjK3FpooBdFIOWmmSYVQbgV33/cEvOed0urjLBwKLlTZTMmAaNh7R4gjVHpw/JtcfN+mtESOz1UqMwQKNlxbo1+aHpD2yvSWaqKN/vi0Ci9HokxjZDSoPDQl3dPpl9gnctjWJeHeJ0xliGkeu55OFu8KKUAwEFXssRcKX3w==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8271732-f532-4507-1272-08d83fa6c06a
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2020 16:34:30.0065 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uSmPOE7cbOvfnBDMbKTnN5ZuAUcqXAX3dS0IW4k2mQBQb9t2N+edardRvz0Hr4sC4tJYp8e2dq/W0bd9pYTo+F6AW0UtVM8vKN3U2H4RIzM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5493
Received-SPF: pass client-ip=40.107.21.124;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 12:34:31
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
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

13.08.2020 18:54, Paolo Bonzini wrote:
> On 13/08/20 16:57, Vladimir Sementsov-Ogievskiy wrote:
>> Hi!
>>
>> Sorry my stupid question, but which kind of concurrent access
>> bs->reqs_lock prevents?
>>
>> In my understanding the whole logic of request tracking for the bs is
>> going in the coroutine, so, we don't have parallel access anyway? How
>> can parallel access to bs->tracked_requests happen?
> 
> Different iothreads can access the same BlockDriverState, and block/io.c
> is not protected by the AioContext lock (in fact almost nothing, or
> nothing, needs it in the I/O path).
> 

I thought bs is attached to one aio context and aio context attached to one iothread.
And all normal request processing of the bs is done in this one iothread.
And when we need to access bs externally, we do it in
aio_context_acquire / aio_context_release, which protects from parallel access to
BlockDriverState fields...

But you say, that block/io.c is not protected by AioContext lock..

Does it mean that everything must be thread-safe in block/io.c and all block drivers?

Are tracked_requests different from other fields? A lot of other BlockDriverState
fields are not protected by any mutex.. For example: total_sectors, file, backing..

Could you give an example of parallel access to tracked_requests?

-- 
Best regards,
Vladimir

