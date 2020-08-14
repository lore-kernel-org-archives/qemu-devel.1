Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C80ECC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 18:08:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90B9C20771
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 18:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="uKI5/HrR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90B9C20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6e7i-0005Fg-TZ
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 14:08:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37120)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k6e6k-0004Pg-Ot; Fri, 14 Aug 2020 14:07:14 -0400
Received: from mail-eopbgr80097.outbound.protection.outlook.com
 ([40.107.8.97]:14242 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k6e6j-0004Kd-5J; Fri, 14 Aug 2020 14:07:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IwfPfHoTuabQioDhJ+eJdguGrvKxl9KOtxi3MK+4BwOpEvuIkbhawOvaQjCCV9vgvoyb3nZuula++LR8K7ZnOZblp51Na856ThaECzkiiyQLQG1p+xUK02UP2s2MoW7Jr3FpY0vr3EheE1Sv3Ww9t+S0JlHRJWWza7c+r2WYFm6erbYDU6KIXAS6ch1lJSn5HIXQhzySISLAIPXbZ27wX7JNVNNn/EbK4z4Ivz169otnMc6qjE+ymwxqIlm8RlxXTRvDEG13oYdopX8hrSqzNJpgOaELsB6Y6WWIlOk1yeXMTIs9S2AgsKz3Bq8Mhcok8MbzDrTP4aQ0PwA4+I+aWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDnOJvNRhkbKKXa6Cf4p6g6v1zIU/9ub4nUhldj9U7M=;
 b=NEicrqVuWIISEvKHQmgoC/wtsmgyoRiKEChRl94DzUFvQRZXTf2XrabIrmfhm893yJYUGomySi56QiJMU52lbrbi28Grnf7mCUWmzyWCEfa+bLP3bCTkXM/fuNnFdTBYGCnWTUqepqPDjhNyePgyzoRwmMVN+UDh32WRHXMwOWBy9G01PEH82WYYFZR0zFrzSQt6dVIpyGfTgdmAy676OwE/Kkv/UHM5kG45zZt5s58iz98QPtM+13iusm2RWW9KsvqEyBr7UOgTsHD182QKmkhyLAyUHgApzcfnnrSvsPhtiwyC2BS+PPxIV4zjtBloo/5y7w6pt5rJs8ob3esEtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDnOJvNRhkbKKXa6Cf4p6g6v1zIU/9ub4nUhldj9U7M=;
 b=uKI5/HrRvf/ZHu6zGsAxZxgRdTmMlhfsuXQBjEKyMFjkPJiSzSTLDjAxuXQBYbKRKQT7wZbHa2ICyhRAHM2q72rHXkt2hH0hsF/Wye+PBlWckLF4YtXPu0neacYWe1d+v69rKzdE8IOPq1ywoYPZTLZkvjiI9Bk5z4Avn9LcIpE=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB5077.eurprd08.prod.outlook.com (2603:10a6:20b:e6::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.22; Fri, 14 Aug
 2020 18:07:10 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3283.022; Fri, 14 Aug 2020
 18:07:10 +0000
Subject: Re: [PATCH 1/1] qcow2: Skip copy-on-write when allocating a zero
 cluster
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1597416317.git.berto@igalia.com>
 <8d0ca4de285ec56fa24ea43b8763f305816a0acc.1597416317.git.berto@igalia.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <09b6eb9d-d196-0196-78d3-c2eff4a4019b@virtuozzo.com>
Date: Fri, 14 Aug 2020 21:07:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <8d0ca4de285ec56fa24ea43b8763f305816a0acc.1597416317.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR05CA0108.eurprd05.prod.outlook.com
 (2603:10a6:207:1::34) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.177) by
 AM3PR05CA0108.eurprd05.prod.outlook.com (2603:10a6:207:1::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.15 via Frontend Transport; Fri, 14 Aug 2020 18:07:09 +0000
X-Originating-IP: [185.215.60.177]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f96c5674-017d-4af8-5787-08d8407cdcdf
X-MS-TrafficTypeDiagnostic: AM6PR08MB5077:
X-Microsoft-Antispam-PRVS: <AM6PR08MB50779BE136E0560681E012C8C1400@AM6PR08MB5077.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZJhs5xJXs99oSG2mWWGE2/YMCv/lUaO6v9xKSvUxrdNllgOh7oM8U8dBfUHneti8CUwVd42qgOF2AWdkWSbkuKVVlh3qRZ62jC/6lJW5W0MKLZlrmUoCzndqMpX6xr0WBmb1qmItRUm1UoA2llUL7TwA5PM9D4KKKWw7dATcs61+28ah8vLiQQOfzLEK2PN6UXydm0AYW6rdQjqEO1h/woamzJIAAfvNj6qGKW8yOWfgOv+B6tomtrt7iBFbBSS1GIhypD4LX8C+GreXON+PUmQotSfVj5CbO04uuFPBZIMqhS31z35zHg6Terk5xYWFSzHwRTGkBLVgRyjOIp6knBQ1DohpICsxgGt3Ywodw2ZuFDlrAaHLuHcqRkKJBu6J
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(346002)(376002)(136003)(39840400004)(31686004)(16576012)(316002)(52116002)(6486002)(54906003)(86362001)(31696002)(4326008)(83380400001)(2906002)(478600001)(66476007)(66556008)(66946007)(36756003)(16526019)(5660300002)(956004)(8676002)(2616005)(8936002)(26005)(186003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: X8u7jW5EQoeZz2qh5uF2L4my01gU40QLLFbTkznqZTVHkCR1cK/ET49sCpKD+i568RkSOR9hxqIuPKNK83wNuyONCLlvF84e0W4AMLV6ix3gd7IEnnvSWkvNMB1Mjbj+eMaN2H7EdXnFI5Ts/kv/tEPEQFDMCraPKlkZ/ApsthkjzF09K+aU4+FpD6tHqcbHXHGD4b4zgibZNaRdr9iKA87PMljZAcY1B7Mf9biNFHPhUm4A1jd+4rMe8EF+BE9JUBx/HpIid1V4zYl08vxbnt0Nelj65OhmbEejEQiRDV3iHM+VvSF0cAtD2IIgajD6xt2yb2n+jjIiO1Qspj0XjzJeDRs9KSVDfs98I9DS4dd6hEopEntQSWs1Pda0vsRvdsdNliS6ZzLba1pkx5qRJFuZGixFv5+dwbkcp5v+QqMCHME5uXijmRNNok60UTA/JcjWZlogabp56orZBaTLBZusIPFfqqsFG8sySKiybBVMfRBiHRiTUxc1/JrcvCcoaHCsjO08AOKAA1ZHB3bFxZ1WyMNGnEg+aC+YPX+to/TOJRWAimW2jwhasZgMR/x7da4r2fl/OuiU4keCB5T/L3PKMGa0RujPBMxTtrwgY1x9ql8ZhwUVHxWBybsgjIwyAeeknFnHFdpVpnfzvBH7ng==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f96c5674-017d-4af8-5787-08d8407cdcdf
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2020 18:07:09.9667 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ObmBMuAAN0GccIGtXoicd771Ih51/43gKgJw86wZ11NdAmlD921eH2fjRFM+ncKupJfHUCXfG/sdZ8EGVMVEX/NfC0Fdj2y8lD4DFGVzAI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5077
Received-SPF: pass client-ip=40.107.8.97;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/14 14:07:11
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

14.08.2020 17:57, Alberto Garcia wrote:
> Since commit c8bb23cbdbe32f5c326365e0a82e1b0e68cdcd8a when a write
> request results in a new allocation QEMU first tries to see if the
> rest of the cluster outside the written area contains only zeroes.
> 
> In that case, instead of doing a normal copy-on-write operation and
> writing explicit zero buffers to disk, the code zeroes the whole
> cluster efficiently using pwrite_zeroes() with BDRV_REQ_NO_FALLBACK.
> 
> This improves performance very significantly but it only happens when
> we are writing to an area that was completely unallocated before. Zero
> clusters (QCOW2_CLUSTER_ZERO_*) are treated like normal clusters and
> are therefore slower to allocate.
> 
> This happens because the code uses bdrv_is_allocated_above() rather
> bdrv_block_status_above(). The former is not as accurate for this
> purpose but it is faster. However in the case of qcow2 the underlying
> call does already report zero clusters just fine so there is no reason
> why we cannot use that information.
> 
> After testing 4KB writes on an image that only contains zero clusters
> this patch results in almost five times more IOPS.

Would be great to add this case to simplebench as well.

The idea is good, but I'm a bit confused with new interface.

As I understand the "The former is not as accurate for this
purpose but it is faster" is related to (and only to) want_zero
parameter of block_status. bdrv_is_allocated_above is about
allocation (in terms of backing chains), and is_unallocated() is
just wrong user (with wrong name:)): it actually want another kind
of information.
So, for me it looks like we need an interface to
bdrv_block_status_above with want_zero=false (add another
function, or add this parameter to public interface).

And even with your approach, I'd keep original
bdrv_is_allocated_above as is, and just add new function with *is_zero
argument, to not modify all users of bdrv_is_allocated_above to pass
additional NULL value, in this way patch will touch less files.

Also, note, I have a series about block_status & is_allocated:
"[PATCH v5 0/5] fix & merge block_status_above and is_allocated_above"
(me go and ping it), which a bit reduces all the mess around
block_status & is_allocated.



-- 
Best regards,
Vladimir

