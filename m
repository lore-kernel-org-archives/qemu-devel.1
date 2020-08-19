Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5098BC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 12:05:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D9C2205CB
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 12:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="jA2LwpFd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D9C2205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8Mqm-0008Me-6R
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 08:05:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k8Mpt-0007PW-Pa; Wed, 19 Aug 2020 08:04:57 -0400
Received: from mail-vi1eur05on2135.outbound.protection.outlook.com
 ([40.107.21.135]:5844 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k8Mpq-0006Lb-R4; Wed, 19 Aug 2020 08:04:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iXuHXGMvbQEwb6/KBeFg5mmGZF06cO+wwnfFg2b5oM/Ko0axslhtSNEW+MMOayC/ORrXd4izQk4/gUmZPgFDWC+LRv9BGSIXlvI/xVdTZxRtvCpOyLYocM7NPKgFNQYUYY2WEc5uBuqFl4YcQLj5iB+WEyKazP2qLzXkAPFXsO2plE7DDIs2zlHNRfVArjfcsQIAmn0nBVSOyArGjStcffM6RQVZEHfA6JfZlnrv00pRw9cBQQpB0bknX51rxOguYS3+JF3WRawLnTQWvYgOh0PfWIz1w/v1bmc9cYj/g0d6HF87shE6+wDbRlVRBKaI0bZSsq+Fd83DeqbpEj02OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3nEaA7PrFeWRfZj83j+bd/3XrPt/ClsS53SDR44r8ls=;
 b=nonxCxqBCJ9FL/XcqqjEt+oxsyhSaQ9+C7jhCppEb0AN7yitlvVd7eabzDgVcuLs73Z6nsP1SRNL8oVYnTXe+CnVPK9QNA0HtbXQdpUJlCFdOsEAzC/+U5Pa74Z6izE6p5/f07/9oh3xuvpneE0sCL1xW3mrYmCRqPzpOAHkDiBbicuNQ7kigSvCmCvaELcYkEDYwhvmYXLELMENK5ikpMzKzqRRFqJa+HViBaXmgP1GsycJ/n33i/HGFoaYrMPc+VLticR5fJX57SEursHXRrctOBMCrroQQfuaqZyIpzL0TpPlS8no6RxohXHE5+EEPvVPOdbnwG39UUAW3qN+qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3nEaA7PrFeWRfZj83j+bd/3XrPt/ClsS53SDR44r8ls=;
 b=jA2LwpFdD7wgDuIPXUnlhNzu8qQzW/mrH3yT8PTlQTIYsscUo7lM8iizzvCMAw/b75vsSJzK2Lsyk4jOQ9tEgLQZ/+xGvdJ5rfQy1m9h0ZuyTO18VrGpToKNlgzNSqFFXwjhaVL170Me5PUBejOeeuMdqu7K97bc1oxUw05ZNDY=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4849.eurprd08.prod.outlook.com (2603:10a6:20b:c3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Wed, 19 Aug
 2020 12:04:50 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3283.027; Wed, 19 Aug 2020
 12:04:50 +0000
Subject: Re: [PATCH v5 1/5] block/io: fix bdrv_co_block_status_above
To: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
References: <20200610120426.12826-1-vsementsov@virtuozzo.com>
 <20200610120426.12826-2-vsementsov@virtuozzo.com>
 <w51lficjb0d.fsf@maestria.local.igalia.com>
 <57758b78-227a-c753-db9e-fe503b163927@virtuozzo.com>
 <w51v9heeuo1.fsf@maestria.local.igalia.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <1ed621e4-7931-a842-972b-858fb04213c7@virtuozzo.com>
Date: Wed, 19 Aug 2020 15:04:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <w51v9heeuo1.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR07CA0141.eurprd07.prod.outlook.com
 (2603:10a6:207:8::27) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.171) by
 AM3PR07CA0141.eurprd07.prod.outlook.com (2603:10a6:207:8::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.10 via Frontend Transport; Wed, 19 Aug 2020 12:04:50 +0000
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9945906-9ded-4731-88bf-08d84438134b
X-MS-TrafficTypeDiagnostic: AM6PR08MB4849:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4849F388471F8B908ABD3414C15D0@AM6PR08MB4849.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D56e3L6mYNWFDuSjRfTQjTP2k+J3cSkDr0shlF35TdQCpuFIu6fY4AmmoqrpmjT6U2u7V9n0jbG52YyKRd38a4JRb240ZFsuzQKzNeU9RIReW710l1SWqeU4BuUvl6E58za5IMbzwVfD5nqHNVeMnwZ/pRS9p7HekCGiWXUVsjgLVvhjOfYu1kfOJvqBFP/HQdC3DMz4CMtWhliGVxSQNne1j5XOGNhksM1y7UeqdihNhrudSVhP8vb7IhwCGJrYM5xxcRb5Z2v9JrevcOJ1E97jNyGinquJNL9mlqmnklh1IzH4xsocHdH9wZV3n124/8J6pL3NHwBPQHxt0jXwc20PqPLZ605dCRLvDzHkPhjEhm4NbtsYMkChQOO4oKjq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(346002)(396003)(376002)(136003)(366004)(66946007)(8936002)(66476007)(83380400001)(16526019)(36756003)(66556008)(2906002)(956004)(2616005)(6486002)(26005)(5660300002)(52116002)(8676002)(186003)(107886003)(478600001)(31686004)(31696002)(16576012)(316002)(4326008)(86362001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: yf7SV4ATsZ6QbWrNuPt/NGIFe9B2YiVm0Lzo/BaJifMDSF8XNgkrrdiDOdWD20jLp8JjYiT0rbfyC5Bcp5H2xeBVee/VjESe4focYac3K0yxn0FqTneqk/10BNJW5H4ujCd56gy2jCTJYIRBspmKu7Bb0GJMlm48JKnjh+KNx1iLC0plVtIVPTZMyflFAUZijdpJFUdHrdXYGOyRc3c8VXRAzGrbFJV9SHCZ0B04pF4i27t4y7OzXWHqm4ayEHTlLRGtXXEL/FGoKb60jIl/fK12rMUfzaavdwd9YmlCYItovSv24SqNgXSrzEb+ryyLqNLCXhC/QVDp+BlVSJYrzHtHRZOjgO4rpegzwEOvIHDQyEXAz6V5ggVBkTYnaOHGF8Ng9/yANWe/tsF+3FpzAz+gNc4SwKe404cEtMW4xuDYlYB21YyMcgNYGHMj9jyX3MMu2AIJX5SjvFsdK+RHfbbYqNtS3OH/NqTin9w+Kxvv0leyfYHkq3Hdhkn5QSbC0d60GCCgeO8LxHP4PDXggllVM08CrbkyMle5EpfwcpgVHNiP7dxh78X77hqH2s07Sf8qSEqsByF2+YzdCyPzGUyh8ZbP4gSFROYMNU+JOiTxA9vDS3U2za2/HE3wuP9iK6apxiBrXs951/RBMABLaQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9945906-9ded-4731-88bf-08d84438134b
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2020 12:04:50.7122 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cGr7e1P8pfRTuI3hzp0K62ly8NQV9IZ/a7lntpVrebBEf4cPSq9aT9T6yGHgHGEKD6W2vjdRebPDbyqiuYxucNv2GZMcSV8YNTXb6Vt+IWM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4849
Received-SPF: pass client-ip=40.107.21.135;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 08:04:52
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

19.08.2020 14:34, Alberto Garcia wrote:
> On Wed 19 Aug 2020 11:48:25 AM CEST, Vladimir Sementsov-Ogievskiy wrote:
>>>> +             * The top layer deferred to this layer, and because this layer is
>>>> +             * short, any zeroes that we synthesize beyond EOF behave as if they
>>>> +             * were allocated at this layer
>>>>                 */
>>>> +            assert(ret & BDRV_BLOCK_EOF);
>>>>                *pnum = bytes;
>>>> +            if (file) {
>>>> +                *file = p;
>>>> +            }
>>>> +            return BDRV_BLOCK_ZERO | BDRV_BLOCK_ALLOCATED;
>>>
>>> You don't add BDRV_BLOCK_EOF to the return code here ?
>>
>> No we shouldn't, as this is the end of backing file when the top layer
>> is larger.
> 
> Ok, but maybe the original request also reaches EOF on the top layer.
> 
> An example that does not actually involve short backing files: let's say
> that the size of the active image is 1MB and the backing file is 2MB.
> 
> We do 'write -z 960k 63k', that zeroes the last cluster minus a 1KB
> tail, so qcow2_co_pwrite_zeroes() calls is_zero() to check if that last
> 1KB already contains zeroes.
> 
> bdrv_co_block_status_above() on the top layer returns BDRV_BLOCK_EOF: no
> allocation, no zeros, we simply reached EOF. So we go to the backing
> image to see what's there. This is also unallocated, there's no backing
> file this time and want_zero is set, so this returns BDRV_BLOCK_ZERO.
> However the backing file is longer so bdrv_co_block_status() does not
> return BDRV_BLOCK_EOF this time.
> 
> If the backing file would have been the same size (1MB) we would have
> BDRV_BLOCK_ZERO | BDRV_BLOCK_EOF, but if it's longer or (with your
> patch) shorter then BDRV_BLOCK_EOF disappears.
> 
> Now, I don't see anyone else using BDRV_BLOCK_EOF for anything so this
> does not have any practical effect at the moment, but is this worth
> fixing?.

That's the point of course, I'll fix.

So, if we get EOF on top layer, we should add it to final ret anyway, regardless of backing chain statuses.

> 
>>>> +        res = bdrv_block_status_above(bs, NULL, offset, bytes, &nr, NULL, NULL);
>>>> +        offset += nr;
>>>> +        bytes -= nr;
>>>> +    } while (res >= 0 && (res & BDRV_BLOCK_ZERO) && nr && bytes);
>>>
>>> About this last "... && nr && bytes", I think 'nr' already implies
>>> 'bytes', maybe you want to use an assertion instead?
>>
>> No, on the last iteration, bytes would be 0 and nr is a last
>> chunk. So, if we check only nr, we'll do one extra call of
>> bdrv_block_status_above with bytes=0, I don't want do it.
> 
> You're right !
> 
> Berto
> 


-- 
Best regards,
Vladimir

