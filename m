Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E5D1C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 09:47:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A5DF22BEA
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 09:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="rCi6wbSf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A5DF22BEA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8hA6-0004jA-O2
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 05:47:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37184)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k8h9G-0004AI-LS; Thu, 20 Aug 2020 05:46:19 -0400
Received: from mail-eopbgr140097.outbound.protection.outlook.com
 ([40.107.14.97]:22606 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k8h9A-0006AL-1y; Thu, 20 Aug 2020 05:46:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CEANAZOjEReEJHrVL9Ko2qEZOHPkBJN2dXC9WuJsoYMNhWE6Ed/B/ccVqcpSGy4SgAwQqhq0aXgQT1Tl8VSVQe9PpbY3kKQdT1JQuD9OS919wTbQ+h0b8cx9TvGoXm7+rpxDeYBGzw97weYc+c5YId0IJxEgfKVmhDPRslxkmqPfHAjwaDy5mtLavIJ/L0dM4LhocF0iM7q+0L60+4jGNuDqXijgSBsgxiLk4F+5byx+rMJPJki8jnpwWGxuKxO8aDgdccu1u5SkPJQAa45uA26UNe8ZM+lqXJRzcChE6adBvqczP9DP7oUgLa8oBTWfmw9Y+jopH/ZQSBWaEfGgsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9fBuTKnKVAqSL+SyVVNDJ1UUCPygivqiMvsKTdXLds=;
 b=OcsJZ4tF5e/DENZtOhBtfjtuLf95LfsUnq4DXJAboX9z/UO+YT7WDQfbKICnS3BGi1Mmp3x4siQMHikP1uHcmau46AouQNmjkdIaMIFa07R5gqaHOiqf2s805/m/YJM6a6mkNukL/be/MhbuknPNX5eRre9545LKF9AqCjLBDqErHRjxL0zNC4paCoIB6VlsrNwNcKt0JEAlKZzRN0Ev4e7SSzglT0XFO/tJ3bYBu+LJszN2Wftzk+rsegA9qR9HtqiBVgXdWWqDzZITHtvLnhgy9nq/0xUSadcMDzIXlNGCZHK4UGBzmzQepbBfFByE3HUPtir1y3AWE01uKv7+tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9fBuTKnKVAqSL+SyVVNDJ1UUCPygivqiMvsKTdXLds=;
 b=rCi6wbSfQ3LPPmf0JSQnrsEL/SX8AjQbPdxSoIcxTHgQN+FAbuuX/x5xloZg0/kA1UJfNzrD+7DsOpHs85uySZVfAifP2KW0RzoQFChhcO29exOh5B5gvpRa9NcmaBUXcAek36Mhr8oI/ENdXmTOW6jLQ+HCbn4eUNYoEFaLqmg=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4342.eurprd08.prod.outlook.com (2603:10a6:20b:b4::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.18; Thu, 20 Aug
 2020 09:46:06 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3283.027; Thu, 20 Aug 2020
 09:46:06 +0000
Subject: Re: [PATCH v3 12/12] block/qcow2: automatically insert preallocate
 filter when on FUSE
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <20200817091553.283155-1-vsementsov@virtuozzo.com>
 <20200817091553.283155-13-vsementsov@virtuozzo.com>
 <20200819151515.GO366841@stefanha-x1.localdomain>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <38f6c463-3121-d1d9-6bf2-74f6a9baa97d@virtuozzo.com>
Date: Thu, 20 Aug 2020 12:46:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <20200819151515.GO366841@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR03CA0027.eurprd03.prod.outlook.com
 (2603:10a6:208:14::40) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.171) by
 AM0PR03CA0027.eurprd03.prod.outlook.com (2603:10a6:208:14::40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24 via Frontend Transport; Thu, 20 Aug 2020 09:46:05 +0000
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b7a9296-8050-468f-fd40-08d844eddbe4
X-MS-TrafficTypeDiagnostic: AM6PR08MB4342:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4342FDC66C9A27C1C3355E91C15A0@AM6PR08MB4342.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PglUHEckUEFgR90lsQQ6c3T3mMBVJJ38IFB9OgmZWDGyfuggKS7N/ccQNLZDPV0BdHHXratwkyFh7K3SFx5HX0Rq4uFzjLnG5WbbCEGV8pypPucnwDvddYKSQ+SA6Yoxc+/QNQ55s0iw1lge54MSL6XGlDS5EaWGTrEnZzo6f1QrqeFdaw5S2Md+qT/LXbrDcudnRHcVpphTdJejX5g6FaPlfANcraKYZs5opVAninChwaVsC28ENF5+Cbh+7nDDC/DSqTBqhTvuPJkxvvdbW/bgl29yeU39d7/TvTDvPb7qd7F2VRkgA0rEdnNLwA2x9m9olVkYmCWuigx1N41NgEz2P4gOU80y7xsBdi1XwL78W/XepytmQ3rMs7rgAcTj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39840400004)(346002)(396003)(136003)(376002)(4326008)(66946007)(66556008)(36756003)(6916009)(66476007)(8676002)(6486002)(86362001)(316002)(107886003)(8936002)(26005)(16576012)(5660300002)(31696002)(478600001)(16526019)(186003)(52116002)(31686004)(83380400001)(2616005)(2906002)(956004)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 8+cIrohD2PKNRxaLo7s9af9V7r+7KTqndC82PepGPQT0vrMkwbOzqU0Dp8MEodSeohFVj0a8mFlavBYmb4xFSSB1VV2LYZirOA4+666XHphrq9Q36BxUM/BNBmFuDtZ+ehrL9HcXEz/vzucQC5AKvuIdyafbPEzz9s3wBra241gEeMGH7ko7Z7h53FbwKajRrotL37Q/XR+03vCySY/T28Rlppm/t3oyBhBsLGdxh/0wqURdGXBUZdqlIqJE1MWdGBQv1zzZI6ann3OWqfnkYuL66/in3kFo66GqNutd8ai4JUaTolrwQTAqGAUiqPL3vw1VDNiIyLfanIMPcd6iLu2b18VKgpuHg+jrhqXaoknI7dxDGc6BLOMZ0QOLc6F9dashaeXAdc+d2CkAPUZbRMdNeyqeEiRj8ADcPcd9cYHt5sCNjcWj75Lt1OIlFCwg6MAdeNbxclTKbug2HMDuH0ME58yjMKZ4vCvm8uJ3qt4vvf+SrgH8ZYOR0bYMEUYiIcMZjYqOgJPhxPCm9XxUAXj5u8K7rjPvl/Ezz6AdA7I8PJcD6kaqscXVA3i+yvfkG45916xQrB8Yd0Xinp2VhuWm9o0jFXYj6xSacZL6JmzHLGyOjjz/JrDNDjNjpICkfH2zDPYpx4pSp9rGJ/T2Tw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b7a9296-8050-468f-fd40-08d844eddbe4
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 09:46:06.2848 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N2VOVv07cl6WYPCeQO3wlR0XkpzIKyOsJ6u0TQv9MLwWPnLEiEBWON6yMi6H/3OEqwhv7BMUi17WTu0qekb8JZmjt+PpXNmVFvDQyrj2Cqo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4342
Received-SPF: pass client-ip=40.107.14.97;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 05:46:07
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-block@nongnu.org, armbru@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

19.08.2020 18:15, Stefan Hajnoczi wrote:
> On Mon, Aug 17, 2020 at 12:15:53PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> vstorage has slow allocation, so this patch detect vstorage
>> (I hope, we don't use other FUSE filesystems) and inserts preallocate
>> filter between qcow2 node and its file child.
>>
>> The following test executes more than 10 times faster
>> (43.2s -> 3.9s for me) with this patch. (/newssd3 is mount point of
>> vstorage, both cs and mds are on same ssd local ssd disk)
>>
>>      IMG=/newssd3/z
>>      FILE_OPTS=file.filename=$IMG
>>      COUNT=15000
>>      CHUNK=64K
>>      CLUSTER=1M
>>      rm -f $IMG
>>      ./qemu-img create -f qcow2 -o cluster_size=$CLUSTER $IMG 1G
>>      ./qemu-img bench -c $COUNT -d 1 -s $CHUNK -w -t none -f qcow2 $IMG
> 
> Kevin's input is needed here. I think the philosophy is that nodes are
> not automatically inserted. The user should define the graph explicitly.
> The management tool would be responsible for configuring a preallocate
> filter node.
> 

This patch originally is not intended to be merged upstream, only for downstream.
I post it just to possibly get some ideas, could it be somehow useful for others.
(I'm not sure, that all FUSE filesystems needs this filter. But vstorage needs)

Hmm, about automatically inserted nodes: why not? block jobs insert their filters
automatically.. Anyway, for our downstream process the simplest thing is to
insert it automatically in Qemu.



-- 
Best regards,
Vladimir

