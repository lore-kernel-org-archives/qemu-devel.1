Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37ACC2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 11:13:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D45D2072D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 11:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Rr7oCRsC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D45D2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOJVD-0000we-O8
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 07:13:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52487)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jOJT8-0007I0-HC
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 07:11:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jOJT5-0000eV-BA
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 07:11:06 -0400
Received: from mail-eopbgr50107.outbound.protection.outlook.com
 ([40.107.5.107]:18879 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jOJSz-0000bu-5r; Tue, 14 Apr 2020 07:10:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NNZjnUud9Leyyv+4xEd9ehZcGTO65jiT+Z4tdkyUbju6ZLTKVSOn5mb2fhjuPaw+LFjeDcxeSacQnphT+3pnfUjdSCwqwstX7qhe43gkApKgLJdEWmv7OruzOPqD+Zye/9+S9K3uhb9QY0Rmvt5B56gaXmDpnFQ6jQMMUgC11xnj1yNpxh7kiOsYBdwCBk24JGaOr1F/ZG1RaTMCcy5GMIJx3rnJC1CW8/OfXCESgnOcrsCrmkD08aOPUWqBY8PUEYjoCpUHzRIKpfcQaayHqbktj6yIzR22oBFV6vHjY08+NcaPOfLiA9FodIx8YyJaJ/ewYpeyIcCMwaZ59zjjIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bVJfeV7/QTLKzuCcaEkJdtooZx/TLtYi5idgX1dyGo4=;
 b=KB6U5KUeSd0N5a3IMBiaL9G6gsHrLDzS5rSrxrQt7Gf5QU6URYoRaYFxnIY8MGvrh2OTwbCn5tiA34qWtHhrYWAnKLez6Q/vn8vXwDQ3HAptHpAazd40QxXl93QquB0BxX9GmKjzMik0sQbpHZBfdN2yGdCGTD76V7xuJ5y5Q77QRftWGt6JQB1CW/z08Yi1WVqPlg0MHNGTpSydo7JoryExAaCayzUKVFmPxJMrbmRmjzxsLHiFYTJC1HLje4fmPrn0z/G3wCjJLjGuYqLicu2dN3c+vPz4JWtzVaqWCE6jPPSOZ1xm5sW0T6QjGtzebhdgdFm9E4tbBADo1py5gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bVJfeV7/QTLKzuCcaEkJdtooZx/TLtYi5idgX1dyGo4=;
 b=Rr7oCRsC6R7Ue1jRiok4ZOXOxPpqrnQq/ZGL0YEr8zYyRbBh1ikLnceaAmUebJ0CkE9F87NK1UKetLbRyrlyVkpkV7HdLdwPZ9zPuikjz8OB5zhcZA5KBSLigawslilOWxBgigiEvTLbmYwogOjQyKb4eFMcMl3lJrqTHWhTHO8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5496.eurprd08.prod.outlook.com (2603:10a6:20b:de::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.17; Tue, 14 Apr
 2020 11:10:54 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%4]) with mapi id 15.20.2900.028; Tue, 14 Apr 2020
 11:10:54 +0000
Subject: Re: [PATCH v4 13/30] qcow2: Add QCow2SubclusterType and
 qcow2_get_subcluster_type()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1584468723.git.berto@igalia.com>
 <fe21a93340427771899c47569c47063b849b54e6.1584468723.git.berto@igalia.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200414141047003
Message-ID: <1fb53079-7a3f-9b4f-7194-74090bf52210@virtuozzo.com>
Date: Tue, 14 Apr 2020 14:10:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <fe21a93340427771899c47569c47063b849b54e6.1584468723.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0112.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::17) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.131) by
 AM0PR01CA0112.eurprd01.prod.exchangelabs.com (2603:10a6:208:168::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15 via Frontend
 Transport; Tue, 14 Apr 2020 11:10:51 +0000
X-Tagtoolbar-Keys: D20200414141047003
X-Originating-IP: [185.215.60.131]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22e9a78d-95b5-4598-a7c8-08d7e0647f81
X-MS-TrafficTypeDiagnostic: AM7PR08MB5496:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5496158F9E7D7CEF8FC4FD86C1DA0@AM7PR08MB5496.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0373D94D15
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(396003)(346002)(39850400004)(366004)(376002)(136003)(52116002)(8676002)(86362001)(26005)(186003)(8936002)(31696002)(81156014)(16576012)(66476007)(66556008)(316002)(4326008)(16526019)(66946007)(36756003)(6666004)(54906003)(2906002)(956004)(6486002)(478600001)(107886003)(5660300002)(19627235002)(2616005)(31686004);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CJ8ZGdShfWNf8a7iqahqGzMqU51VvfJGfmCsZlnYfKwp98r768mookPYXbon4IoJIZ+yPJi/6r8a9JjfDj2t3e5f2w9k0s1Q78dgTTt/sM0Q9vs2W/hmwX4oh4BRSZB4BYP28V7mrwM5V8aSUG7+ygRAytBQXthAH12/Zo5S7ZO7RnYUNbzU0rCufHz4k/VNTvMFpNnj9oPmBxPI+yAiCFV/Q70enFDRiCjqxzolI5LPv/MeJOQoAFoXJgKSCkgF52jgZa+NdvoyRtnhk/FD0J0u+c6iRPSFHIuTCtf8NQhdPj8AU482mDP96XJ392XhYSNSE3RbsvaNv3n/U0VLtPRlIHihesIw90xqBoubu7mueetqAUG5Ne0PhNg5cXtnFUvXsZpmOglxn1gK+f6jUmpEvZ8S6uifMNQUIHY/1Ue4uS/fsZNmwZJ7WBPA4sID
X-MS-Exchange-AntiSpam-MessageData: xGh2AhdSUK8l6LCUkvphzUP7/D2Hd6piOF4KcMXRCrnTCt9KqXVfImM0CghUwgI/rQk2jiLulRlQ5gHDD5LEM7qSeVjKGbmki/gSMguSAajUcoHw9hpC4TE9VPcNZPpyl6HlNt/nDIJoKjjSE6St6g==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22e9a78d-95b5-4598-a7c8-08d7e0647f81
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2020 11:10:53.8700 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ydn0vUvsQEiwtoDINIcEkzC6Ep2Sa0uFiuVIWJvJhMJxRcdS2cg6nue/1cylBo5CuBzRomLajC3RccY5J+H7H4TKdLFpcUyqgCF3gmrQwp4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5496
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.107
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

17.03.2020 21:16, Alberto Garcia wrote:
> This patch adds QCow2SubclusterType, which is the subcluster-level
> version of QCow2ClusterType. All QCOW2_SUBCLUSTER_* values have the
> the same meaning as their QCOW2_CLUSTER_* equivalents (when they
> exist). See below for details and caveats.
> 
> In images without extended L2 entries clusters are treated as having
> exactly one subcluster so it is possible to replace one data type with
> the other while keeping the exact same semantics.
> 
> With extended L2 entries there are new possible values, and every
> subcluster in the same cluster can obviously have a different
> QCow2SubclusterType so functions need to be adapted to work on the
> subcluster level.
> 
> There are several things that have to be taken into account:
> 
>    a) QCOW2_SUBCLUSTER_COMPRESSED means that the whole cluster is
>       compressed. We do not support compression at the subcluster
>       level.
> 
>    b) There are two different values for unallocated subclusters:
>       QCOW2_SUBCLUSTER_UNALLOCATED_PLAIN which means that the whole
>       cluster is unallocated, and QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC
>       which means that the cluster is allocated but the subcluster is
>       not. The latter can only happen in images with extended L2
>       entries.
> 
>    c) QCOW2_SUBCLUSTER_INVALID is used to detect the cases where an L2
>       entry has a value that violates the specification. The caller is
>       responsible for handling these situations.
> 
>       To prevent compatibility problems with images that have invalid
>       values but are currently being read by QEMU without causing side
>       effects, QCOW2_SUBCLUSTER_INVALID is only returned for images
>       with extended L2 entries.
> 
> qcow2_cluster_to_subcluster_type() is added as a separate function
> from qcow2_get_subcluster_type(), but this is only temporary and both
> will be merged in a subsequent patch.
> 
> Signed-off-by: Alberto Garcia<berto@igalia.com>


Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

